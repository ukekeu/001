<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>

<html>
<head>
	<title>搜索结果</title>
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<%@ page language="java" import="java.sql.*,common.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
 <%@ include file="../public_js/getByteOut.jsp"%>
<script language="javascript" src="../public_js/public.js">
</script>
<body>
<%
   String cusname=China.getParameter(request,"cusname");
     String secname=China.getParameter(request,"SecNo");
   cusname=cusname.trim();
   String searchSQL="select o.code,o.sectionname,o.section,o.loft,o.room_no,c.signatory,o.customer,r.code roomID from  order_contract o,customer c,room r where  o.state<>3 and  r.seccode=o.section and r.loft=o.loft and r.room_code=o.room_no and c.serialno = o.customer and c.cus_name like '%"+cusname+"%' and o.section='"+secname+"'";
   String sectionno="";
 
   String loft="";
   String room_no="";
   String code="";
   String roomID="";
   String cusno="";
   String sectionname="";

 %>
<form method="POST" name="frm" action="FindList.jsp">
<input type=hidden name=cusname value="">
<input type=hidden name=secname value="">
 <input type=hidden name=SecNo value="">
</form>
  <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 bordercolor="#dfdfdf" ALIGN=center class="tablefill" >
    <tr class=listtitle align="center" >   <td >
<font color=white>楼盘名称</font>
  </td>
    <td>
 <font color=white>栋号</font>
  </td>
    <td>
 <font color=white>房号</font>
  </td>
   <td>
<font color=white>客户姓名</font>
  </td>
  </tr>
<% 
 ResultSet SecRS=ViewBean.executeQuery(searchSQL);
   while (SecRS.next()){
        code=getbyte(SecRS.getString("code"));
        sectionname=getbyte(SecRS.getString("sectionname"));
        sectionno=getbyte(SecRS.getString("section"));
        loft=getbyte(SecRS.getString("loft"));
        room_no=getbyte(SecRS.getString("room_no"));
		cusname=getbyte(SecRS.getString("signatory"));
        cusno=getbyte(SecRS.getString("customer"));
		roomID=getbyte(SecRS.getString("roomID"));
%>
 <tr  align="center" class=listcontent  title=" 双击可看到收款情况" ondblclick="openwin1('yingshi.jsp?contractno=<%=code %>&cusno=<%=cusno %>&loft=<%=sectionname+loft %>&ldroomcode=<%=roomID %>',650,570,50,50);"> 

  <td>
  <%=sectionname %>
  </td>
    <td>
  <%=loft %>
  </td>
    <td>
  <%=room_no %>
  </td>
   <td>
  <%=cusname %>
  </td>

  </tr>
<%}
SecRS.close();
 %>
</table>
</body>
</html>
