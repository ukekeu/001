<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/>
 
 
<html>
<head>
	<title>取消附属房产</title>
</head>

<body>
<%String fsfccode=request.getParameter("fsfccode");
  String br=request.getParameter("br");
 String code=request.getParameter("code");
 String sql="delete fsfc where roomcode in ("+fsfccode+")";
 ViewBean.executeUpdate(sql);
 ViewBean.executeUpdate("update room set salestate=1 where code in("+fsfccode+")");
sql="delete GatheringRecord where shouldQS=15 and contactno="+code;
 ViewBean.executeUpdate(sql);

 %>
<script>
opener.charges();
opener.SaveContract();
window.close();


</script>

</body>
</html>
