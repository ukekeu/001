<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %> 

<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="aBean2" scope="page" class="ConnDatabase.SDatabase" />
 <%@ include file="../public_js/getByteOut.jsp"%>

<html>
<head>
	<title>·¢ËÍÓÊ¼þ</title>
</head>

<body>
<%
String id=getbyte1(request.getParameter("id"));
 
String StrSql="update oa_mail_state set leave=2 where main_id="+id;
 out.print(StrSql);
 try{ 
  aBean1.executeUpdate(StrSql);
 
  }catch(Exception s){} %>

<script>
opener.window.location="myplan.jsp";
 window.close();
</script>
</body>
</html>
