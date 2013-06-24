<%@ page contentType="text/html;charset=GBK" %>

<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "产权管理" , 
                  "银行注记"
                ) ;
%>

<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
	<title>银行注记</title>
</head>

<body>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>

<%String codes=request.getParameter("codes");

 String SQL="UPDATE ORDER_CONTRACT SET yhzj=1,yhzj_date=getdate()  WHERE CODE IN("+codes+")";
	 ViewBean.executeUpdate(SQL);
 
 %>
<script>
alert("已注记");
opener.window.location.reload();
 window.close();
</script>
</body>
</html>
