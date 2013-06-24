<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "合同审核管理" , 
                  "审核可以办理产权"
                ) ;
%>

<html>
<head>
	<title>产权办理审核</title>
</head>

<body>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>

<%String codes=request.getParameter("codes");

 String SQL="UPDATE ORDER_CONTRACT SET CQ=1  WHERE  cq_check=1 and CODE IN("+codes+")";
	ViewBean.executeUpdate(SQL);
 %>
<script>
alert("已审核");
opener.document.forms[0].submit();
window.close();
</script>
</body>
</html>
