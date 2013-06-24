<%@ page contentType="text/html;charset=gb2312" %>

<%@ include file="../public_js/logrecord.jsp" %>
<%@ include file="../public_js/getByteOut.jsp"%>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "会员管理" , 
                  "删除"
                ) ;
%>

<html>
<head>
	<title>删除客户</title>
</head>

<body>
 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
<%
  String sql="";
  String cusno=request.getParameter("cusno");
 String con=request.getParameter("del");

 
         sql="delete VIPCUSTOMER where code='"+cusno+"'";  
        
		 InsertBean.executeUpdate(sql);
	 

		 InsertBean.executeUpdate(sql);
		 %>
		 <script>
		 alert("已删除");
	       opener.window.location.reload();
		   window.close();
		    </script>
		 
		   
</body>
</html>