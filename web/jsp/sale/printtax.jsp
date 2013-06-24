<%@ page contentType="text/html;charset=GBK" %>
　
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>打印契税</title>
</head>

  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 
   <%@ include file="../public_js/getByteOut.jsp"%>
<body>
<%
String code=request.getParameter("code");
String section=getbyte2(request.getParameter("section"));
String loft=getbyte2(request.getParameter("loft"));
ViewBean.executeUpdate("update order_contract set out=0");
String sql="";
String fzs="";
sql="SELECT fzs FROM LoftBuildCode WHERE SECNO='"+section+"' AND LOFT='"+loft+"'";  
	ResultSet rs=ViewBean.executeQuery(sql);
	if (rs.next())fzs=getbyte(rs.getString("fzs"));
	rs.close();
	sql="update order_contract set out=1,fzs='"+fzs+"' where code="+code;

ViewBean.executeUpdate(sql);
	   String reportAddrs=(String)session.getAttribute("reportAddr");
 %>
 <script>
 window.location="<%=reportAddrs %>rep_q_tax_taoda.rpt" ;
 </script>
 


</body>
</html>
