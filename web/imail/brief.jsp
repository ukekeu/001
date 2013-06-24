 <%@ page contentType="text/html;charset=GBK" %>
<%@ page import = "java.sql.*" %>
 <jsp:useBean id = "Bean" scope = "page" class = "ConnDatabase.SDatabase" />
 <jsp:useBean id = "Bean1" scope = "page" class = "ConnDatabase.SDatabase" />
   <%@ include file="../jsp/public_js/getByteOut.jsp"%>
   <%@ include file="../jsp/public_js/checktime.jsp"%>
<%
	 String body="";
	 ResultSet rs=Bean.executeQuery("Select * from imail_message where id="+request.getParameter("id"));
	 if (rs.next()){   
	 
    body=rs.getString("body");
	}
	rs.close();
%><html>
<head>
<title>我的办公</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.unnamed1 {  font-size: 12px; line-height: 150%}
-->
</style>
</head>
<body leftmargin="0" topmargin="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="unnamed1">
  <tr>
    <td><%=body%> </td>
  </tr>
</table>
</body>
</html>
