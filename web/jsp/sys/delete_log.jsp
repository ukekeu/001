<%@ page contentType="text/html;charset=GBK" %>

<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>��־</title>
	<link rel=stylesheet href="../class/mad.css" >
</head>
<%@ page import="java.sql.*" %>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/getByteOut.jsp"%>
<body oncontextmenu="return false" >

<%
 String logid=getbyte1(request.getParameter("logid"));
 
 if (!logid.equals(""))
 {
   String DeleteLog="delete logrecord where id in ("+logid+")";// between '"+date1+"' and '"+date2+"'";
 aBean.executeUpdate(DeleteLog);
 
 }
 
  %>
<script>
alert("��ɾ����־");
opener.window.location="log.jsp";
window.close();
</script>
</body>
</html>
