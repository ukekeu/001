<html>
<head>
<title>退房一览表</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<script language="javascript" src="../public_js/public.js"></script>
<script language=javascript src="js/mad.js"> </script>

<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

  <%@ page contentType="text/html;charset=GBK" %>
   <%@ include file="../public_js/checktime.jsp"%>
  <%@ page import = "java.sql.*,common.*" %>
  <jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id = "changeListBean" scope = "page" class = "ConnDatabase.SDatabase" />

  <%@ include file="../public_js/getByteOut.jsp"%>

 

<%
    String doWhat = getbyte1( request.getParameter( "doWhat" ) ) ;
    String fanghou = getbyte1( request.getParameter( "fanghou" ) ) ;
    String kehuxingming = getbyte1( request.getParameter( "kehuxingming" ) ) ;
    String time1 = getbyte1( request.getParameter( "time1" ) ) ;
    String time2 = getbyte1( request.getParameter( "time2" ) ) ;
    String xiaoshouren = getbyte1( request.getParameter( "xiaoshouren" ) ) ;
    String findStr = "" ;
    if( doWhat.equals( "find" ) ) {
      // findStr = findStr + " and TFRecord.section like '%' " ;
	   findStr = findStr + "" ;
       if( ! fanghou.equals( "" ) ) {
            findStr = findStr + " and TFRecord.room = '" + fanghou.trim() + "' " ;
       }
       if( ! kehuxingming.equals( "" ) ) {
            findStr = findStr + " and TFRecord.person like '%" + kehuxingming + "%' " ;
       }
       if( ! time1.equals( "" ) ) {
            findStr = findStr + " and TFRecord.tf_date >= '" + time1 + " 00:00:00" + "' " ;
       }
       if( ! time2.equals( "" ) ) {
            findStr = findStr + " and TFRecord.tf_date <= '" + time2 + " 23:59:59" + "' " ;
       }
       if( ! xiaoshouren.equals( "" ) ) {
            findStr = findStr + " and TFRecord.checker like '%" + xiaoshouren + "%' " ;
       }
    }

%>
   
<body  topmargin="1" >
<form name="frm" method="post" action="tf_list.jsp"> 
 
 <%
	
	int hasRecord = 0;
	int id;
	String  SecNo=China.getParameter(request,"SecNo");
    String  SecName=China.getParameter(request,"SecName");
	 
	String  Loft=China.getParameter(request,"Loft");	

 
	String  Build=China.getParameter(request,"Build");
	String section;
	String building;
	String Room_code;
	String CancelDate;
    String Note="";
	String person="";
	String checker="";
	String seller="";
	String subscription="";
	

%>  
   


<%String sel=(String)request.getParameter("sel");
    if(sel==null) sel="1";	 
 
	  %> 
  <table width="370" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('RoomCodeShowC.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>收款审核</font></a>
	</td>
	  <td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=2;findSub('factSkhd.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>批量核对</font></a>
	</td>
 	 
	  <td class="<%if(sel.equals("4")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=4;findSub('RoomCodeShowTC.jsp');"><font color='<%if(sel.equals("4")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>一次退房款</font></a>
	</td> 
	  <td class="<%if(sel.equals("5")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=5;findSub('tf_list.jsp');"><font color='<%if(sel.equals("5")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>多次退房款</font></a>
	</td> 
   </tr>
<input type=hidden name=sel value="<%=sel%>">
  <input type=hidden name=SecNo value="<%=SecNo %>">
   <input type=hidden name=Loft value="<%=Loft %>">
 </table>
<script>
function findSub(para){
	   document.frm.action=para;	 
	   document.frm.submit();
	}
</script>
	  <p align="center" class=FontColor><font size=3><b> <%if (!SecName.equals(Loft)){out.print(SecName);} %><%=Loft+Build %>退定房明细</font></b></p>
<table  width="100%">
 <tr >
   <td>
     
    <input type=hidden name="doWhat" value="find" >
    房号:<input type=text name=fanghou size=5 value="<%//= fanghou %>" >
    经办人:<input type=text name=kehuxingming size=10 value="<%//= kehuxingming%>" >
   退定日期: 从<input type=input name=time1 size=10 readonly value="<%//= time1%>" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(time1);return false;">到<input type=input name=time2 size=10 readonly value="<%//= time2%>" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(time2);return false;"><br>
    审批人:<input type=text name=xiaoshouren size=10 value="<%//= xiaoshouren %>" >
    <input type=button value="查询" onclick="doSearch()" >
  </td>
 </tr>
</table>


<table width="100%" border="0" CELLPADDING="1" CELLSPACING="1"> 
<tr class=listtitle align="center">
  <td >序号</td>
 <td> 房间代码</td>
 <td> 客户姓名 </td>
 <td> 建筑面积 </td>
  <td> 总金额 </td>
   <td> 认购日期 </td>
    <td>销售员</td>
 <td> 退定日期 </td>

 </tr> 
<%
	String changeStr = " select a.code,a.customer,a.sectionname+a.loft room,a.loft,a.room_no,a.jzarea,a.yong_tu,a.jzarea,a.rmbprice,a.date,a.td_date,b.cus_name,a.seller from order_contract a ,customer b where a.state=3 and a.customer=b.serialno and a.section+a.loft+a.room_no in (select section+loft+room_no from order_contract where section+loft='"+SecNo+Loft+"' and state=3 group by section+loft+room_no HAVING count(*)>1) and a.section+a.loft='"+SecNo+Loft+"'"
	                
                      + " order by a.section,a.loft,a.room_no";
			//out.print(changeStr); 
    float jzarea=0;
	String secno="";
	String customer="";
	String cusname="";
	String order_code="";
   String sumprice="";

       ResultSet changeRS1 = null;
	try{
	changeRS1 = changeListBean.executeQuery(changeStr);	
	hasRecord = 0;
	int i=0;
	while (changeRS1.next()) {
		hasRecord = 1;
		 i++;
		 
		  

 %> <b>
 <tr id=TR<%=i %>  align="center"  class='listcontent' onclick="changeclass1(this,'clickbg','listcontent');"  onmouseout="mOut(this,'#e6f9ff');" onmouseover="mOvr(this,'#EAECEC');" title="双击弹出窗口退款登记"   ondblclick="openwin1('F_checkFactmoney.jsp?contractno=<%=changeRS1.getString("code") %>&cusno=<%=changeRS1.getString("customer") %>&loft=<%=changeRS1.getString("room")  %>&ldroomcode=0&checkQX=',650,570,50,50);" >
   <td    ><%=i %></td>
 <td ><%=changeRS1.getString("room_no")%></td>
<td><%= changeRS1.getString("cus_name")%></td>
<td><%= changeRS1.getString("jzarea") %></td>
<td><%= changeRS1.getString("rmbprice") %></td>
<td><%= changeRS1.getString("date").substring(0,10) %></td> 

<td><%= changeRS1.getString("seller") %></td>
<td><%= changeRS1.getString("td_date").substring(0,10)%></td>
</tr>
</b> 
<%
  	}
	changeRS1.close();
	}catch(Exception e){out.print(e);}
  %>

</form>

<script lang=javascript>
    function doSearch()
    { 
		document.frm.submit();
    }
</script>

</body>
</html>
