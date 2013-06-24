<%@ page contentType="text/html;charset=GBK" %>

<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<jsp:useBean id="FormtD3" scope="page" class="test.PieChart"/>  
<%	
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "意向单位" , 
                  "分析"
                ) ;
			
%>

<html>
<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
	<title>意向单位分析</title>
</head>

<body>
<script language="JavaScript">
<!--
 function ok(x){
	 document.all.photo.value=x;
	 form1.action="list_charges_plan.jsp?type=5&ch_type=3";
	 form1.submit();
 }
//-->
</script>
 
<%
String SecNo=getbyte1(request.getParameter("section")); 
 
try{
  String sql="";
	 
  sql="select a.room+a.yxdw1 as nam,count(*) num from View_Chenyi a  where a.Section='"+SecNo+"' group by a.room+a.yxdw1  ";
    Calendar calendar = Calendar.getInstance();
  String filename = String.valueOf(calendar.getTimeInMillis());	
 
  String pic= FormtD3.drawToFile("D:/"+ request.getContextPath()+"/crmv9/jsp/picture/yxdw"+filename+".jpg",sql,"意向单位");  
  if (!pic.equals(""))
    out.print("<img src='../picture/yxdw"+filename+".jpg'>");
  
 }catch(Exception s){out.print(s);}

 %>
</body>
</html>