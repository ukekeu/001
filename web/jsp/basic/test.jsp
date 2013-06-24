<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>

<html>
<head>
	<title>Untitled</title>
</head>
  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<body>
<% 
 try{	 
 String sql="update user_reg set end_date='2007-01-01'";
 ViewBean.executeUpdate(sql);
 out.println("ok");
 }catch(Exception s){out.print("系统出现异常错误，错误原因："+s);}
 %>


</body>
</html>
