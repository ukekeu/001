
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<html>
<head>
	<title>数据纠</title>
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<%
  String codes[]=request.getParameterValues("aa");
  
  if (codes!=null){
    for (int ii=0;ii<codes.length;ii++){ 
    String sql="update room set salestate=1 where  seccode+loft+room_code = '"+getbyte1(codes[ii])+"'";
 
	 ViewBean.executeUpdate(sql);
	  
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "恢复程序执行异常错误" , 
                  "恢复"+getbyte1(codes[ii])
                ) ;
	    	
   }
 
  }
  

 %>
<body  oncontextmenu="return false" topmargin="0">

<%
String sel=(String)request.getParameter("sel");
    if(sel==null) sel="0";	  
 %>
 <form name=frm method="post" action="SaleState.jsp">
<table width="270" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("0")){out.print("paneselect3");}else{out.print("panemenu3");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=0;findSub('sysCheckData.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>异常状态</font></a>
	</td>
	  <td class="<%if(sel.equals("1")){out.print("paneselect3");}else{out.print("panemenu3");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('cancelTF.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>恢复退房</font></a>
	</td>
	 <td class="<%if(sel.equals("2")){out.print("paneselect3");}else{out.print("panemenu3");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=2;findSub('sysCheckDataLoke.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>异常锁定</font></a>
	</td>
   </tr>
<input type=hidden name=sel value="<%=sel%>">
 </table>
<script>
function findSub(para){
   document.frm.action=para;
   document.frm.submit();


}
</script>
<p align="center"><font size=3><b>数据纠错管理</b></font>
<br><br>
<form name="frm" method="post">
<input type=button name=ff value="恢 复" onclick="checkyh();"> 
<table width="90%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr class=listtitle align="center">
  <td>项目名称</td>
    <td>栋号</td>
	<td>房号</td>
	<td><input type=checkbox name=sh onclick="chooseCheckbox(this.checked);" ></td>
  </tr>	
<%
 
 String SQL="SELECT n.name,a.loft,a.room_code room_no,seccode+a.loft+room_code  a FROM ROOM a, CRM_Project n,LoftBuildCode b  WHERE    b.secno=a.seccode  and a.loft=b.loft and  a.seccode=n.SerialNo and  ( a.salestate=3  or a.salestate=2 )and not a.seccode+a.loft+a.room_code in  (select  section+loft+room_no   from order_contract where state<>3   )";
   ResultSet rs=ViewBean.executeQuery(SQL);
   while (rs.next()){

 %>
  <tr align="center" class='listcontent' >
  <td><%=rs.getString("name") %></td>
    <td><%=rs.getString("loft") %></td>
	<td><%=rs.getString("room_no") %></td>
	<td><input name="aa" value="<%=rs.getString("a") %>" type="checkbox"></td>
  </tr>	
  <%}
  rs.close();
   %>
   <%
 
   SQL="SELECT sectionname ,loft ,room_no,section+loft+room_no a    FROM  order_contract a  WHERE      not a.customer in  (select  serialno   from customer   )";
      rs=ViewBean.executeQuery(SQL);
   while (rs.next()){

 %>
  <tr align="center" class='listcontent' >
  <td><%=rs.getString("sectionname") %></td>
    <td><%=rs.getString("loft") %></td>
	<td><%=rs.getString("room_no") %></td>
	<td><input name="aa" value="<%=rs.getString("a") %>" type="checkbox"></td>
  </tr>	
  <%}
  rs.close();
   %>
   </table>
   </form>
<script>
 function chooseCheckbox(para) {//indexstring
     var x=0;
	// var seldocs = new Array();
	var aa="";
	if (frm.elements.length){
	 var temp=frm.elements.length;
     for (i=0;i<frm.elements.length;i++) {
       if ((frm.elements[i].type=="checkbox")&&(frm.elements[i].name=="aa"))
		 {
       		frm.elements[i].checked=para;
			
   		 }
	  }	
	  }
 
}
	function checkyh(){
	 
	 
	 if (getseldocs2()==""){alert("请选择需要恢复的数据");return false;}
	 
	 
 
	   if (confirm("确认通过吗？"))
	   document.frm.action="sysCheckData.jsp";
	    document.frm.submit();
	 }
   	 function getseldocs2() {
     var x=0;
	 var seldocs = new Array();
	 var temp=frm.elements.length;
     for (i=0;i<frm.elements.length;i++) {
       if ((frm.elements[i].type=="checkbox")&&(frm.elements[i].checked&&(frm.elements[i].name=="aa")))
		 {  
		    seldocs[x]="'"+frm.elements[i].value+"'";
			 
			x++;
   		 }
	  }	

   return seldocs ;
}
   
</script> 
</body>
</html>
