<%@ page language="java" contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%
session.setAttribute( "m_menu" , "F" );
%>
<html>
<head>
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>财务管理</title>
</head>
<frameset rows="70,*" framespacing="0" border="0" frameborder="0">
  <frame name="banner" scrolling="no" noresize target="contents" src="../top/top.jsp?para=fina">
  <frameset cols="100,*">
    <frame name="contents" target="main" src="menu.jsp" marginwidth="11" marginheight="16" scrolling="auto" style="border-style: solid; border-width: 0">
    <frame name="main" src="todaySk.jsp" scrolling="auto">
  </frameset>
  <noframes>
  <body>

  <p>此网页使用了框架，但您的浏览器不支持框架。</p>

  </body>
  </noframes>
</frameset>

</html>
