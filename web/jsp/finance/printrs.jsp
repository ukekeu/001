<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*"%> 
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/> 

<html>
<head>
	<title>Untitled</title>
</head>
<script>
self.resizeTo(screen.availWidth,screen.availHeight)
self.moveTo(0,0)
self.focus()
</script>
<body>
<%
String strPara=request.getParameter("code");
String strSQL="update order_contract set out=0";
fBean.executeUpdate( strSQL ) ;
strSQL="update order_contract set out=1 where code="+strPara;
fBean.executeUpdate( strSQL ) ;
String strRaddr=(String) session.getAttribute("reportAddr");
 response.sendRedirect(strRaddr+"printRGS.rpt");

 %>
 

</body>
</html>
