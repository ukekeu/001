<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%> 
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/> 
<%@ include file="../public_js/getByteOut.jsp"%>

<html>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<head>
	<title>�����ѷ�����</title>
</head>
<script language="javascript" src="../public_js/public.js">
</script>
<body>
<%
 
String SQL="SELECT * from  SendMessage where messageType=0 ";
ResultSet rs=aBean.executeQuery(SQL);

 %>
    <p align="center"><font size=3>�ѷ��Ͷ�����ϸ��</font></p>
	  
<table BORDER=0 width="102%" CELLSPACING=0 CELLPADDING=0 bordercolor="#FFFFFF" ALIGN=center class="tablefill" >
    <tr class=listtitle align="center" > 
      <td  ><font color=white>���</font></td>
	  <td  ><font color=white>�ͻ�����</font></td>
      <TD  ><font color=white>��������</font></td>
	  <td ><font color=white>��������</font></td>

	  <td  ><font color=white>�������</font></td>
	 	  <td  ><font color=white>������</font></td>
   </tr>  
 <%
 int i=0;
 while (rs.next()){ 
 i++;
 %>
    <tr ondblclick="openwin('InputDj.jsp?code='+room_code,550,480,100,10);" id=TR<%=i %>  class=listcontent  align="center"  onmouseover="mout(this);"  onclick="changeclass1(this,'clickbg','listcontent');" title="˫������ȡ�Ǽ�">
      <td  > <%=i %></td>
	  <td  align="left" > <%=getbyte(rs.getString("customer")) %> </td>
      <TD align="left" > <%=getbyte(rs.getString("message")) %> </td>
	  <td > <%=getbyte(rs.getDate("messageDate").toString()) %> </td>
	  <td  ><%
	  String messagetype =getbyte(rs.getString("messagetype")) ;
	  if (messagetype.equals("1"))out.print("ǩԼ����");
	 
	  
	  %> </td>
	  <td  > <%
	   String SendmessagePerosn=getbyte(rs.getString("SendmessagePerosn"));
	 
	   out.print(SendmessagePerosn);
	  %> </td>
	  
   </tr>  
 
 <%}rs.close(); %>  
 
</body>
</html>
