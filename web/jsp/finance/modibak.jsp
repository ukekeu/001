<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="vemBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<STYLE type=text/css>BODY {
	FONT-SIZE: 15pt; LINE-HEIGHT: 10pt; FONT-FAMILY: ����
}
tr {
	FONT-SIZE: 10pt; HEIGHT: 30pt; FONT-FAMILY: ����
} 
</STYLE>
<title>�ͻ��������嵥</title>
</head>

<body>
   
  <%
 //���½��㱸ע
  String SQL="";
         SQL="UPDATE order_contract SET Jq_BAK='"+getbyte1(request.getParameter("bak"))+"',jq_date='"+request.getParameter("jq_date")+"'";
		 SQL+=" WHERE code="+request.getParameter("code");

         ViewBean.executeUpdate(SQL);
		
   %>      
</body>
<script>window.close();</script>
</html>
