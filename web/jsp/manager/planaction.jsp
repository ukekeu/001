<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.sql.*,common.*,java.util.*,java.util.Date" %> 
 <jsp:useBean id = "Bean" scope = "page" class = "ConnDatabase.SDatabase" />
 
  <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>WAGNER</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.bg {
	background-image: url(images/index3_03.jpg);
	background-repeat: repeat-y;
	background-position: left top;
}
-->
</style>
</head> 
<body>
<% String username=getbyte1(request.getParameter("name"));
String Date1=getbyte1(request.getParameter("sDate"));
String Date2=getbyte1(request.getParameter("eDate"));
String Description=getbyte1(request.getParameter("content1"));
String SQL="insert into dayplan(userid,sdate,edate,context) values('"+username+"','"+Date1+"','"+Date2+"','"+Description+"')";
Bean.executeUpdate(SQL); 
  %>
 <script>opener.document.forms[0].submit();window.close();</script>
</body>
</html>
