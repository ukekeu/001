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
    
	   findStr = findStr + "" ;
       if( ! fanghou.equals( "" ) ) {
            findStr = findStr + " and a.room like '%'" + fanghou.trim() + "%' " ;
       }
       if( ! kehuxingming.equals( "" ) ) {
            findStr = findStr + " and a.person like '%" + kehuxingming + "%' " ;
       }
       if( ! time1.equals( "" ) ) {
            findStr = findStr + " and a.tf_date >= '" + time1 + " 00:00:00" + "' " ;
       }
       if( ! time2.equals( "" ) ) {
            findStr = findStr + " and a.tf_date <= '" + time2 + " 23:59:59" + "' " ;
       }
       if( ! xiaoshouren.equals( "" ) ) {
            findStr = findStr + " and a.checker like '%" + xiaoshouren + "%' " ;
       }
  
 
%>
   
<body  oncontextmenu="return false"   topmargin="1" >
<form name="frm" method="post" action="CancelList.jsp"> 
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
<table width="620" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('../sale/crm_rg_list.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>认购明细</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;findSub('../sale/crm_rg_list.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>签约明细</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('../basic/crm_ld_list.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>临订明细</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('../basic/crm_yl_list.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>预留明细</font></a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;document.frm.submit('../sale/CancelList.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>退房明细</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('../sale/ChangeList.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>换房明细</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('../basic/crm_ws_list.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>未售明细</font></a>
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
 
	  <p align="center" class=FontColor><font size=3><b> <%if (!SecName.equals(Loft)){out.print(SecName);} %><%=Loft+Build %>退定房明细</font></b></p>
<table  width="100%">
 <tr >
   <td>
    <input type=hidden name="doWhat" value="find" >
    房号:<input type=text name=fanghou size=5 value="<%//= fanghou %>" >
    经办人:<input type=text name=kehuxingming size=10 value="<%//= kehuxingming%>" >
   退定日期: 从<input type=input name=time1 size=10 readonly value="<%//= time1%>" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(time1);return false;">到<input type=input name=time2 size=10 readonly value="<%//= time2%>" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(time2);return false;"> 
    审批人:<input type=text name=xiaoshouren size=10 value="<%//= xiaoshouren %>" >
    <input type=button value="查询" onclick="doSearch()" >
  </td>
 </tr>
</table>

<input type=hidden name=choose>
<input type=hidden name=SecName value="<%=SecName %>">
<input type=hidden name=SecNo value="<%=SecNo %>">
<input type=hidden name="Build">
<input type=hidden name="Loft" value="<%=Loft %>">
<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  bgcolor="efefef" >
  <td >序号</td>
  <td> 认购日期</td>
 <td> 退定房间代码</td>
 <td> 客户姓名 </td>
 <td> 建筑面积 </td>
  <td> 退房金额 </td>
 <td> 退定日期 </td>
 <td> 退定原因 </td>
  <td> 经办人 </td>
 <td> 审批人 </td></tr> 
<%
	String changeStr = "select  a.* ,c.cus_name,b.date from TFRecord a ,order_contract b,customer c"
	                  +" where a.secno+a.loft+a.room =b.section+b.loft+b.room_no and a.customer=c.SerialNo and b.state=3 and  "
					  +"a.secno='"+SecNo+"'";
					 if (!Loft.equals("")) 
					 changeStr+="  and rtrim(a.loft)='"+Loft+"'";
					  if (!Build.equals("")) 
					 changeStr+=" and  a.building='"+Build+"'";
                       changeStr+= findStr 
                      + " order by a.loft+a.room asc,a.tf_date desc";
		 
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
		 secno=changeRS1.getString("secno");
		 
		    cusname=getbyte(changeRS1.getString("cus_name"));
		 
		 section = getbyte(changeRS1.getString("section"));
		 Loft =getbyte(changeRS1.getString("Loft"));
		 building = getbyte(changeRS1.getString("Building"));
		 Room_code = changeRS1.getString("room"); 
		 jzarea = changeRS1.getFloat("jzarea");
		 sumprice = changeRS1.getString("sumprice");
	     CancelDate = changeRS1.getString("tf_date");
		 Note = getbyte(changeRS1.getString("context"));
		 person=getbyte(changeRS1.getString("person"));
		 checker=getbyte(changeRS1.getString("checker"));
		 String date=changeRS1.getDate("date").toString();

 %> <b>
 <tr id=TR<%=i %>  align="center"  onclick="changeclass1(this,'clickbg','');"  onmouseover="mout(this) "  title="挞订原因：<%=Note %>" >
   <td    ><%=i %></td>
    <td    ><%=date%></td>
<td ><a href="#" onclick="openwin('td_hf_list.jsp?secno=<%=secno %>&roomno=<%=Room_code%>&loft=<%=Loft %>&build=<%=building%>&show=true&ftyy=<%=Note %>&checker=<%=checker %>&customer=<%=customer %>&order_code=<%=order_code %>',500,600,10,30)"><%=Loft+building+Room_code%></td>
<td> <%=cusname %></td>
<td ><%=jzarea%></td>
<td><%= sumprice%></td>
<td><%= CancelDate.substring(0,10) %></td>
<td><%= Note %>&nbsp;</td>
<td><%= person %></td>
<td><%= checker %></td>
</tr>
</b> 
<%
  	}
	changeRS1.close();
	}catch(Exception e){}
  %>
</div>
</form>

<script lang=javascript>
    function doSearch()
    { 
		document.frm.submit();
    }
</script>

</body>
</html>
