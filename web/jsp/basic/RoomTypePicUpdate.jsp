<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>

<html>
<head>
	<title>更新图片到房间资料中</title>
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
 <%@ include file="../public_js/getByteOut.jsp"%>
 
<script language="javascript" src="../public_js/public.js">
</script>
<body>
<%
   String SecNo=China.getParameter(request,"SecNo"); 
   String SQL="select *  from RoomTypePic where sectionno='"+SecNo+"'";
	  ResultSet rs=ViewBean.executeQuery(SQL);
	  while (rs.next()){
	   ViewBean1.executeUpdate("update room set Map='"+rs.getString("roomtypepic")+"' where seccode='"+SecNo+"' and roomtype='"+rs.getString("roomtype")+"'");
	  }rs.close();

 
%>  
<script>
alert("更使用成功！");window.close();
</script>
</body>
</html>
