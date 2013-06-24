  <%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
  <%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
  <jsp:useBean id="checkreg" scope="page" class="regcheck.regcheck"/> 

<html>
<head>
	<title>х╥хо</title>
</head>

<body>
<%String reginfomess=checkreg.checkREG();
out.print(reginfomess);
 %>
</body>
</html>
