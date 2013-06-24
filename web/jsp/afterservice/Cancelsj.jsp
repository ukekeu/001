<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
<title>取消送件</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>

 <%@ page contentType="text/html;charset=GBK" %>
 
  <%@ page import="java.sql.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
 
<%
	String code = request.getParameter("code");
	  String deleStr = "update Order_Contract set song_jian_date= null    where code=" + code;
 
	try {
		 
		aBean.executeUpdate(deleStr);
		 
	}catch(Exception ee) {}
		 
	 
%>
<body bgcolor="#FFFFFF" text="#000000">
 <script>window.close();</script>
</body>
</html>
