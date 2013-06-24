<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>ok</title>



</head>
<body>
<%
  String reSql="delete from  ReportSet where  reportname='"+getbyte2(request.getParameter("reportname"))+"'";
  ViewBean.executeUpdate(reSql);
 %>
<script>alert("系统已删除你定义的报表");opener.window.location.reload();close();</script> 
</body>       
</html>       
