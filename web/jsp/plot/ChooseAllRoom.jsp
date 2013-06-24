<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.sql.*,common.*" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "选择" , 
                  "推荐所有可售"
                ) ;
%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>选房</title>
  <%@ include file="../public_js/getByteOut.jsp"%>
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="cBean" scope="page" class="ConnDatabase.SDatabase" />

</head>

<%
String Mess="系统已接受所有推荐";
String secno=China.getParameter(request,"secno");
String loft=getbyte1(request.getParameter("loft"));
String build=getbyte1(request.getParameter("build"));
 
 String sql="";
String sql1="";
 sql="UPDATE room set type=1,fp=1  ";
sql+=" WHERE salestate =1 and seccode='"+secno+"' and loft='"+loft+"' and building='";
sql+=build+"'";
 
InsertBean.executeUpdate(sql);
String sqtest = "" ;
 
%>

<body>
<script>
	alert("<%=Mess %>");
	opener.window.location.reload();
	 window.close();
</script>
</body>
</html>
