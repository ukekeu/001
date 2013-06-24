<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %> 

<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="aBean2" scope="page" class="ConnDatabase.SDatabase" />
 <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
	<title>»Ø¸´Ìù×Ó</title>
</head>

<body>
 
 
   <%String StrSql=""; 
	    String id=request.getParameter("id");
		StrSql="delete  community_forum  where id="+id;
		
		 aBean.executeUpdate(StrSql); 
	 
		%>
 
<script language="JavaScript">
opener.window.location="myplan.jsp";
window.close();
</script>
</body>
</html>
