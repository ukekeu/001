<%@ page contentType="text/html;charset=GBK" %>
 <%@ page language="java" import="java.sql.*,common.*,java.util.*,java.util.Date" %> 
 <jsp:useBean id = "Bean" scope = "page" class = "ConnDB.ConnODBC" />
 
  <%@ include file="../inc/getByteOut.jsp"%>
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
<% String username=getbyte(request.getParameter("name"));
String Date1=getbyte(request.getParameter("sDate"));
String Date2=getbyte(request.getParameter("eDate"));
String Description=getbyte(request.getParameter("content1"));
String SQL="insert into dayplan(userid,sdate,edate,context) values('"+username+"','"+Date1+"','"+Date2+"','"+Description+"')";
Bean.executeUpdate(SQL);
Bean.executeUpdate("DELETE dayplan WHERE context='' ");
 %>
 <script>opener.window.location="myplan.jsp";window.close();</script>
</body>
</html>
