<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
	<title>´òÓ¡Ìõ¼þ</title>
</head>

<body>
<%
String Date1=China.getParameter(request,"Date1");
String Date2=China.getParameter(request,"Date2");
if (Date2.equals(""))Date2="";
String SecNo=China.getParameter(request,"SecNo");
String Loft=China.getParameter(request,"Loft");
int i=0;
int t=0;
  
String SQLFindStr="";
String SQLFindStr1="";
String sectionname="";

if (!SecNo.equals(""))
  SQLFindStr+=" where section='"+SecNo+"'";
if (!Loft.equals(""))
  SQLFindStr+=" and Loft='"+Loft+"'";
 
 
if (!SecNo.equals(""))
  SQLFindStr1+=" where section='"+SecNo+"'";
if (!Loft.equals(""))
  SQLFindStr1+=" and Loft='"+Loft+"'";
  ViewBean.executeUpdate("update TaxViewList set out=0 ");

ViewBean.executeUpdate("update TaxViewList set out=1  "+SQLFindStr1);
 
String reportAddrs=(String)session.getAttribute("reportAddr");
response.sendRedirect(reportAddrs+"taxlist.rpt");
 %>


</body>
</html>
