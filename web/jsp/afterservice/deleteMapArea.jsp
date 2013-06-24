
<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
<title>实测面积录入</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script src="js/mad.js"> </script>
</head>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>

<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
 
<jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
 

 

<body>

<%
String sql="delete MapArea where id="+request.getParameter("id");
ViewBean.executeUpdate(sql);
 %>
<script>
alert("已删除");
opener.window.location.reload();
window.close();
</script>
</body>
</html>
