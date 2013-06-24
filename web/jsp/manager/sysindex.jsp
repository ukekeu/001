 
<%@ page language="java" contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title><%=(String)session.getAttribute("loginname")+",U客软件欢迎您！"%></title>
</head>
 
<%
String menu= (String)session.getAttribute("menu");
 
if (menu==null)menu="1";
 
 %>
<frameset rows="<%if (menu.equals("4")){ %>100<%}else{ %>125<%} %>,*" framespacing="0" border="0" frameborder="0">
  <frame name="banner" scrolling="no" noresize target="contents" src="../top/header.jsp?para=basic">
  <frameset cols="<%if (menu.equals("1")){ %>150,*<%}else if (menu.equals("2")){ %>130,*<%} else if (menu.equals("3")){%>100,*<%}else if (menu.equals("4")){%>120,*<%} %>"><!--menu.jsp?MModuleNo=223"-->
    <frame name="contents" scrolling="no" target="main" src="<%if (menu.equals("1")){ %>leftmenu.jsp<%}else if (menu.equals("2")){ %>menu.jsp?MModuleNo=DESKTOP<%}else if (menu.equals("3")){ %>manmenu.jsp<%}else if (menu.equals("4")){ %>newmenu.jsp<%} %>" marginwidth="11" marginheight="16" scrolling="auto" style="border-style: solid; border-width: 0">
    <frame name="main" src="rigthmenu.jsp?MModuleNo=DESKTOP" scrolling="auto"><!--welcome.jsp-->
  </frameset>
  <noframes>
  <body>
  </body>
  </noframes>
</frameset>
</html>
<script language='JavaScript' charset='gb2312' src='../public_js/book.js'></script>