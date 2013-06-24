<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>

<html>
<head>
	<title>保存比例设置</title>
</head>

<body>
<%
    String section=getbyte1(request.getParameter("section"));
	String yong_tu=getbyte1(request.getParameter("yong_tu"));
    String bl1=getbyte1(request.getParameter("bl1"));
	String bl2=getbyte1(request.getParameter("bl2"));
	String bl3=getbyte1(request.getParameter("bl3"));
	String bl4=getbyte1(request.getParameter("bl4"));
	String sql="";
	 	
	sql="INSERT INTO commision_scale(section_no,scale,yong_tu) VALUES('";
sql+=section+"',"+bl1+",'"+yong_tu+"')";
ViewBean.executeUpdate(sql);
 %>
<script>
 alert("已保存");
 opener.window.location.reload();
 window.close();
</script>
 
</body>
</html>
