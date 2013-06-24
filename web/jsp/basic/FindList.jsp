<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>

<html>
<head>
	<title>搜索结果</title>
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
 <%@ include file="../public_js/getByteOut.jsp"%>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/CheckSection.jsp"%>
<script language="javascript" src="../public_js/public.js">
</script>
<body>
<%
   String cusname=China.getParameter(request,"cusname");
   cusname=cusname.trim();
   
if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
 
   String searchSQL="select o.code,o.sectionname,o.section,o.loft,o.room_no,c.signatory,o.floors from  order_contract o,customer c where c.serialno = o.customer and c.signatory like '%"+cusname+"%' and o.state<>3 and o.section in ("+SectionS+")";
 
   String sectionno="";
   String loft="";
   String room_no="";
   String code="";
   String sectionname="";

 %>
<form method="POST" name="frm" action="FindList.jsp">
<input type=hidden name=cusname value="">
<input type=hidden name=secname value="">
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
 String floors="";
   while (SecRS.next()){
        code=getbyte(SecRS.getString("code"));
        sectionname=getbyte(SecRS.getString("sectionname"));
        sectionno=getbyte(SecRS.getString("section"));
        loft=getbyte(SecRS.getString("loft"));
        room_no=getbyte(SecRS.getString("room_no"));
		cusname=getbyte(SecRS.getString("signatory"));
		floors=getbyte(SecRS.getString("floors"));
   
%>
 <tr  align="center" class=listcontent  title=" 双击可看到合同资料"  ondblclick="openwin1('../sale/ContractInput.jsp?secname=<%=sectionname %>&secno=<%=sectionno %>&roomno=<%=room_no%>&build=&loft=<%=loft %>&Floor=<%=floors %>&show=true',680,530,50,2);"> 

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
