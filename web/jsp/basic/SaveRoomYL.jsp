<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page import="java.sql.*,common.*" %>

<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "选房登记" , 
                  "新增"
                ) ;
%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>选房</title>

<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="cBean" scope="page" class="ConnDatabase.SDatabase" />

</head>

<%
String Mess="系统已接受选房";
String secno=China.getParameter(request,"secno");
String loft=request.getParameter("loft");
String build=request.getParameter("build");
String rooms=request.getParameter("rooms");
String rooms1=rooms.substring(rooms.indexOf("/")+1);
rooms=rooms.substring(0,rooms.indexOf("/"));


String sql="";
String sql1="";
java.util.StringTokenizer to = new java.util.StringTokenizer( rooms1 , ",") ;



sql="UPDATE room set type=0";
sql+="WHERE seccode='"+secno+"' and loft='"+loft+"' and building='";
sql+=build+"'";
InsertBean.executeUpdate(sql);
String sqtest = "" ;
try{
while( to.hasMoreTokens() ) {
	String temp = to.nextToken() ;
	sql1="UPDATE room set type=1";
    sql1+="WHERE seccode='"+secno+"' and loft='"+loft+"' and building='";
    sql1+=build+"' and room_code in ("+rooms+")";
	InsertBean.executeUpdate(sql1);
	}
}catch(Exception s){    
	out.print(sql1);
	out.close();
}

%>

<body>
<script>
	alert("<%=Mess %>");
	opener.window.location.reload();
	window.close();
</script>
</body>
</html>
