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
	out.print("ϵͳ��ɾ�������ϵ�����&nbsp;&nbsp;<a href='ContractView.jsp'>����</a>");
}
catch(Exception se){
	out.print("ϵͳ�����������£�");
	out.print(se.getMessage());
	out.close(); 
}
 %>
</body>
</html>