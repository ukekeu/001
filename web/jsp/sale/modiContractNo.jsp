<html>

 
<head>
<title>作废合同号</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script src="../sale/js/mad.js"> </script>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/line.css" >
</head>
<script language="javascript" src="../public_js/public.js"></script>
<script language=javascript src="../public_js/basal.js"> </script>
  <%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
  <%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />

<body>
<%  
String mess="";
String yy=request.getParameter("yy");
if (yy.equals("3"))mess="已作废编号";
else mess="已恢复编号";
if (yy.equals("3")){
   String sql="select code from order_contract where ContractNo=(select ContractNo from ContractNo  where code="+request.getParameter("code")+" )";
   ResultSet rs=aBean.executeQuery(sql);
   if (!rs.next()){
      aBean.executeUpdate("update ContractNo set state="+request.getParameter("yy")+" where code="+request.getParameter("code"));
	rs.close();
	  %>

  <script>alert("<%=mess %>");opener.window.location.reload();window.close();</script>
   <%}else{ %>
   
  <script>alert("此号被合同占用，不能作废处理");</script>

   
   <%}
   }else{ 
        aBean.executeUpdate("update ContractNo set state="+request.getParameter("yy")+" where code="+request.getParameter("code"));
	%> <script>alert("<%=mess %>");opener.window.location.reload();window.close();</script>

   
   
   <%} %>
</body>
</html>
