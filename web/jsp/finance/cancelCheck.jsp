<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>ȡ������Ӷ��</title>

</head>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/checktime.jsp"%>
<body>
<%String code=request.getParameter("code");
  String username=(String) session.getAttribute("loginname");
  String SQL="UPDATE ORDER_CONTRACT SET yjffstate=0  where code in ("+code+")";
  ViewBean.executeUpdate(SQL);

 %>
<script>
alert("��ȡ������");
opener.document.cus.submit();
window.close();

</script>

</body>
</html>
