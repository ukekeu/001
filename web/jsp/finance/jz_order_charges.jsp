<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<title>���ۼ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel=stylesheet href="../class/news.css" >
</head>
  <%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <%
    String  code=request.getParameter("code");
	String  jzdate=request.getParameter("jzdate");
	String WhereSQL="";

	
	if(!code.equals(""))
	  WhereSQL +=" code in ("+code+")";
	
	  
	  aBean.executeUpdate("update Order_Contract set jz=1 where "+WhereSQL);
    
	   aBean.executeUpdate("update Order_Contract set out=0 ");
	   aBean.executeUpdate("update Order_Contract set out=1 where "+WhereSQL);
		String reportAddrs=(String)session.getAttribute("reportAddr");
   %>
<body  ><!-ondblclick="printd();"->
<p align="center"><font size=5><b>�����ת����</b></font></p>


<script>
 function aa(){
   if (confirm("��ӡ��ת������������"))
    window.location="<%=reportAddrs%>"+"JzSaleDataRpt.rpt";
   
   }
   aa();
</script>

</body>
</html>
