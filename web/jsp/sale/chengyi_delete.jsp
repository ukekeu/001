<%@ page contentType="text/html;charset=GBK" import="java.sql.*,java.util.*"%>
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase" />
 <%@ include file="../public_js/checktime.jsp"%>
<%
 String ref_id = request.getParameter( "ref_id" ) ;
 String SQL="delete tb_chengyi where code in ("+ref_id+")";
  fBean.executeUpdate( SQL ) ;
 
  %>
 <html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>删除诚意</title>
</head>
<body>
 <script lang=javascript>
   opener.document.forms[0].submit();
      window.close();
</script>
</body>
</html>

