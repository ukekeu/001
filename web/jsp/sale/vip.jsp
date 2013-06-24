<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
  
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>诚意认购书</title>
<STYLE type=text/css>BODY {
	FONT-SIZE: 15pt; LINE-HEIGHT: 30pt; FONT-FAMILY: 宋体
}
 
A:link {
	COLOR: #0000cc; TEXT-DECORATION: none
}
A:visited {
	COLOR: #0000cc; TEXT-DECORATION: none
}
A:active {
	COLOR: #ff0000; TEXT-DECORATION: none
}
A:hover {
	TEXT-DECORATION: underline
}
.unnamed1 {
	FONT-SIZE: 9pt; FONT-FAMILY: "宋体"
}
.unnamed2 {
	FONT-SIZE: 15pt
}
</STYLE>
</head>
<%
 String SQL=" update tb_chengyi  set out=1  where code="+request.getParameter("code");
   
   
   
    ViewBean.executeUpdate("update tb_chengyi  set out=0 ");
    ViewBean.executeUpdate(SQL);
	
   String reportAddrs=(String)session.getAttribute("reportAddr");
   
 %>
 <script>
 window.location="<%=reportAddrs %>vip.rpt" ;
 </script>
 
</body>

</html>
