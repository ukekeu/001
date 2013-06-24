<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<title>权限管理..</title>
</head>

<%@ page import="java.sql.*" %>
 <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />

<body oncontextmenu="return false" >
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="JavaScript" src='../public_js/public.js'></script>
<form name=frm method="post"  action="savecortrolman.jsp">

<%@ include file="../public_js/getByteOut.jsp"%>
<center>
<%
 String loginID=(String)session.getAttribute("loginid");
String SQL="select * from CortrolMan WHERE SerialNo='"+loginID+"'";
String control="";
ResultSet qx=null;
qx = aBean.executeQuery ( SQL );
if (qx.next()){
  control=qx.getString("job");
}
qx.close();
 %>
<LINK href="../class/news.css" rel=stylesheet>
 <p align=center class=FontColor><font size=3><b>权限设置</b></font></P>
</center>
</form>
<jsp:include page="cortrolmanlist.jsp" flush="true"/>
</body>

</html>
