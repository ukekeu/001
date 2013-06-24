<html>

 
<head>
<title>备案</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script src="../sale/js/mad.js"> </script>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
  <%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
  <%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <%
   String SQL="DELETE appraisal WHERE ContractNo="+request.getParameter("contract");
   aBean.executeUpdate(SQL);
   SQL="update  order_contract  set jzDate=null WHERE code="+request.getParameter("contract");
   aBean.executeUpdate(SQL);
   %> 
 
<body>
<script>
alert("系统已撤回备案");
opener.window.location.reload();
window.close();
</script>


</body>
</html>
