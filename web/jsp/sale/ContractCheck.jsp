<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>审核销售合同</title>

</head>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/checktime.jsp"%>
<body>
<%String code=request.getParameter("code");
  String username=(String) session.getAttribute("loginname");
  String SQL="UPDATE ORDER_CONTRACT SET checkstate=1,checkdate=GETDATE(),checkperson='"+username+"' where code in ("+code+")";
  ViewBean.executeUpdate(SQL);

 %>
<script>
alert("已通过你的审核，此合同资料不能再修改！");
opener.document.frm.submit();
window.close();

</script>

</body>
</html>
