<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title></title>
</head>

<body>
 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
<%
  String sql="";

  String Code=request.getParameter("code");

         sql="delete Room where code="+Code;  
        try{
		 InsertBean.executeUpdate(sql);
		}catch(Exception s){out.println(s.getMessage());out.close();}

  %>
<script>alert("系统已删除");opener.window.location.reload();close();</script>
</body>
</html>

<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "房间资料" , 
                  "删除"
                ) ;
%>