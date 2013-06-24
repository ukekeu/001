<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean3" scope="page" class="ConnDatabase.SDatabase"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
	<title>test</title>
</head>
<%
 response.sendRedirect(session.getAttribute("reportAddr")+"printsksj13.rpt");
 %>
<body>



</body>
</html>
