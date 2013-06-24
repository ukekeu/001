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
String Mess="系统已接受操作";
String id=China.getParameter(request,"id");
String sql="";
String sql1="";

sql="UPDATE PayMent set type=0";
InsertBean.executeUpdate(sql);
try{
	sql1="UPDATE PayMent set type=1";
    sql1+="WHERE id in("+id+")";
	InsertBean.executeUpdate(sql1);
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
