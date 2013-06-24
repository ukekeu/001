<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%> 
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/> 
 <%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<html>
<head>
	<title></title>
</head>

<body>
<%
 String SQL="UPDATE GatheringTaxRecord SET cancel=0 ,cancelbak='' WHERE ID="+request.getParameter("id");
fBean.executeUpdate( SQL ) ;

 %>

<script>
alert("ÒÑ»Ö¸´");
opener.window.location.reload();
window.close();
</script>
</body>
</html>
