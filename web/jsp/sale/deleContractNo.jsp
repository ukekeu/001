<html>

 
<head>
<title>���Ϻ�ͬ��</title>
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

   String sql="select code from order_contract where ContractNo=(select ContractNo from ContractNo  where code="+request.getParameter("code")+" )";
   ResultSet rs=aBean.executeQuery(sql);
   if (!rs.next()){
      aBean.executeUpdate("delete  ContractNo where code="+request.getParameter("code"));
	rs.close();
	  %>

  <script>alert("ɾ������");opener.window.location.reload();window.close();</script>
   <%}else{ %>
   
  <script>alert("�˺ű���ͬռ�ã�����ɾ������");window.close();</script>

   
   <%}%>
 
</body>
</html>
