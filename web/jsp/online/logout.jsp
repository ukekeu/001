<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.util.*" %>
<jsp:useBeanid="onlineuser" class="online.ListUser" scope="application"/>

<html>
<head>
	<title>搞定JSP在线人数</title>
</head>

<body>
<CENTER>
<%
  String username=request.getParameter("username"); 
  if (username==null)username="";
  if(onlineuser.deleteUser(username)) 
     out.println(username+"已经退出系统!"); 
 
%>
<script language=javascript>
    alert("登录不成功，注意输入的帐号及密码"); 
	 window.open("../../index.htm");
  parent.window.close();
</script>
</CENTER>
</body>
</html>
