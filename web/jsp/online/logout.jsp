<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.util.*" %>
<jsp:useBeanid="onlineuser" class="online.ListUser" scope="application"/>

<html>
<head>
	<title>�㶨JSP��������</title>
</head>

<body>
<CENTER>
<%
  String username=request.getParameter("username"); 
  if (username==null)username="";
  if(onlineuser.deleteUser(username)) 
     out.println(username+"�Ѿ��˳�ϵͳ!"); 
 
%>
<script language=javascript>
    alert("��¼���ɹ���ע��������ʺż�����"); 
	 window.open("../../index.htm");
  parent.window.close();
</script>
</CENTER>
</body>
</html>
