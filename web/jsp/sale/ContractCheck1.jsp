<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>������ۺ�ͬ</title>

</head>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/checktime.jsp"%>
<body>
<%String code=request.getParameter("code");
  String username=(String) session.getAttribute("loginname");
  String SQL="UPDATE ORDER_CONTRACT SET yh_check=1,youhuibeizhu=youhuibeizhu+' ������ڣ�'+CONVERT(CHAR(10),GETDATE())+' ����ˣ�"+username+"' where code="+code;
  ViewBean.executeUpdate(SQL);

 %>
<script>
alert("��ͨ�������ˣ�");
opener.window.location.reload();
window.close();

</script>

</body>
</html>
