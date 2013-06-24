<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>确认结算佣金</title>

</head>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/checktime.jsp"%>
<body>
<%String code=request.getParameter("code");
String state=request.getParameter("state");
  String username=(String) session.getAttribute("loginname");
  String SQL="UPDATE ModuleCortrol SET active="+state+"  where id in ("+code+")";
 
  ViewBean.executeUpdate(SQL);

 %>
<script>
 
opener.document.form1.submit();
window.close();

</script>

</body>
</html>
