<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title></title>
</head>

<body>
 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>

<%
String sql="";
String Code=request.getParameter("Code");
       sql="delete Contract_Sample where code="+Code;

try{
	InsertBean.executeUpdate(sql);
	out.print("系统已删除此资料的数据&nbsp;&nbsp;<a href='ContractView.jsp'>返回</a>");
}
catch(Exception se){
	out.print("系统出错，出错如下：");
	out.print(se.getMessage());
	out.close(); 
}
 %>
</body>
</html>