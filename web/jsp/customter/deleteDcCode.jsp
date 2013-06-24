<%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>删除调查选项</title>
</head>

<body>
 <%@ page language="java" import="com.jspsmart.upload.*,java.sql.*"%>
 
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%
 try{
   String code=request.getParameter("code");
 
 InsertBean.executeUpdate("delete CustomerDcValue where code="+code);
 
} catch (Exception e) { 
		out.println(e.toString());
		out.close();
}
	
%>
<SCRIPT>      opener.window.document.forms[0].submit();window.close();</SCRIPT>
</body>
</html>
 