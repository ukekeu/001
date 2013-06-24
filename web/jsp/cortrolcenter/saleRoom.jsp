<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page import="java.sql.*,common.*" %>

 

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>保存客户认购单位</title>
  <%@ include file="../public_js/getByteOut.jsp"%>
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="cBean" scope="page" class="ConnDatabase.SDatabase" />

</head>

<%
String Mess="系统已接受取消";
String vipno=China.getParameter(request,"vipno");
String secno=China.getParameter(request,"secno");
String loft=getbyte1(request.getParameter("loft"));
String room=getbyte1(request.getParameter("room"));
String code=getbyte1(request.getParameter("code"));

 
 String sql="";
String sql1="";
 sql="UPDATE room set ssstate=1 ";
sql+="WHERE code="+code;
 
InsertBean.executeUpdate(sql);
sql="insert into VIP_S_Room(projectno,loft,VIPno,room) values(";
sql+="'"+secno+"','"+loft+"','"+vipno+"','"+room+"')";
InsertBean.executeUpdate(sql);
String sqtest = "" ;
 
%>

<body>
<script>
	 
	opener.window.frm.submit();;
	 window.close();
</script>
</body>
</html>
