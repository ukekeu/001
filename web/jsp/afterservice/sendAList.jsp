<html>
<head>
<LINK href="../class/mad.css" rel=stylesheet>
<title>�Ͱ���ϸ </title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script src="../class/mad.js"> </script>
</head>
  <%@ page contentType="text/html;charset=GBK" %>
  <%@ page import="java.sql.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  
<%@ include file="../public_js/getByteOut.jsp"%>
<body bgcolor="#FFFFFF" text="#000000">
<%
   String code=request.getParameter("code");
   String SQL="SELECT * FROM appraisal WHERE  ContractNo="+code;
   String send_date="";
   String send_person="";
   String out_date="";
   String out_person="";
   String context="";
   ResultSet rs=aBean.executeQuery(SQL);
   if (rs.next()){
      send_date=rs.getDate("SendDate").toString();
      send_person=getbyte(rs.getString("Handle"));
	  out_date=rs.getDate("OutDate").toString();
	  out_person=getbyte(rs.getString("Handle1"));
	  context=rs.getString("context");

   }
   rs.close();
%>
<table width="100%" border="0" CELLSPACING=0 CELLPADDING=0 bordercolor="#000000" class="tablefill"> 

<tr><td>�Ͱ�����</td><td>�Ͱ���</td><td>��������</td><td>������</td><td>��  ע</td>
</tr>

<tr><td><%=send_date%></td><td><%=send_person%></td><td><%=out_date%></td><td><%=out_person%></td><td><%=context%>&nbsp;</td>
</tr>
</table>

</body>
</html>
