<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>���¥��</title>
</head>
<frameset framespacing="0" border="0" cols="150,*" frameborder="0">
  <frame name="TreeList" target="ADDmain1" src="Tree.jsp?SecNo=<%=request.getParameter("SecNo") %>" scrolling="auto" style="border-style: solid; border-width: 0">
  <frame name="Operation" src="AddLoft.jsp?SecNo=<%=request.getParameter("SecNo") %>">
  <noframes>
  <body >

  <p>����ҳʹ���˿�ܣ��������������֧�ֿ�ܡ�</p>

  </body>
  </noframes>
</frameset>

</html>
