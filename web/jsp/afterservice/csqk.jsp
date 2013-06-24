<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>

<html>
<head>
	<title>打印出售情况</title>
</head>

<body>
<%
    String secno=getbyte1(request.getParameter("SecNo"));
    String Loft=getbyte1(request.getParameter("Loft"));
	String type=getbyte1(request.getParameter("type"));
	String sql="UPDATE room set out=0";
	ViewBean.executeUpdate(sql);
	 sql="UPDATE room set out=1 where seccode='"+secno+"' and loft='"+Loft+"'";
	ViewBean.executeUpdate(sql);
	String reportAddrs=(String)session.getAttribute("reportAddr");
	if (type.equals("8")){
 %>
  <script>window.location="<%=reportAddrs%>rep_zqq_csqk.rpt";</script>
  <%}else if (type.equals("9")){ %>
    <script>window.location="<%=reportAddrs%>rep_zqq_csqk1.rpt";</script>
   <%} %>

</body>
</html>
