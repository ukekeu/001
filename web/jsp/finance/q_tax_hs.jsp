<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%> 
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>

<html>
<head>
	<title></title>
</head>

<body>
<%String ContactNo=request.getParameter("code");

 String modiTaxstate="update GatheringTaxRecord set TaxMoney=(select (cj_f+rmbprice)*q_tax_rate from   Order_Contract    where state<>3 and code="+ContactNo+") where taxname like '%契税%' and  ContactNo="+ContactNo; ;

fBean.executeUpdate(modiTaxstate);

 %>

<script>
alert("系统已按实结算了契税");
opener.window.location.reload();
window.close();
</script>
</body>
</html>
