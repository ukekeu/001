<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="vemBean" scope="page" class="ConnDatabase.SDatabase"/>
  <%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<STYLE type=text/css>BODY {
	FONT-SIZE: 15pt; LINE-HEIGHT: 10pt; FONT-FAMILY: 宋体
}
tr {
	FONT-SIZE: 10pt; HEIGHT: 30pt; FONT-FAMILY: 宋体
} 
</STYLE>
<title>交房日期</title>
</head>

<body>
   
  <%
 //更新结算备注
  String SQL="";
         SQL="UPDATE order_contract SET  jf_date='"+request.getParameter("jf_date")+"'";
		 SQL+=" WHERE code="+request.getParameter("code");

         ViewBean.executeUpdate(SQL);
		
   %>      
</body>
<script>window.close();</script>
</html>
