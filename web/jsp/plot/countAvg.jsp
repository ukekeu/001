<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<html>
<head>
	<title>新增房间资料</title>
</head>

<body>
 <%@ page language="java" import="com.jspsmart.upload.*,java.sql.*"%>
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>

<html>
<head>
	<title>计算均价</title>
</head>

<body>
<%
 String SecNo=request.getParameter("SecNo");
 String Loft=request.getParameter("Loft");
 String SQL="SELECT sum(area) area from room where seccode='"+SecNo+"' and loft='"+Loft+"'";
 ResultSet rs=InsertBean.executeQuery(SQL);
Stirng area="";
 if (rs.next()){
   area=rs.getString("area");
 
 }
 rs.close()
 %>


</body>
</html>
