<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>

<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>

<body><%@ page language="java" import="com.jspsmart.upload.*,java.sql.*,java.util.*"%>
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>

 
<body>
<%
String code=request.getParameter("id");
InsertBean.executeUpdate("delete my_knowledge where id="+code);

 %>
<script>
alert("ÒÑÉ¾³ý");
opener.window.location="myknowledge_view.jsp";
close();

</script>

</body>
</html>
