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
 
String StrSql="delete  oa_mail_state  where main_id="+id;
 
 try{ 
   aBean1.executeUpdate(StrSql);
   aBean1.executeUpdate("delete imail_message  where id="+id);
  }catch(Exception s){} %>
<script>
opener.window.location="myplan.jsp";
 window.close();
</script>
</body>
</html>
