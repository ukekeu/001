<%@ page contentType="text/html;charset=GBK" %>

<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "��Ȩ����" , 
                  "����ע��"
                ) ;
%>

<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
	<title>����ע��</title>
</head>

<body>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>

<%String codes=request.getParameter("codes");

 String SQL="UPDATE ORDER_CONTRACT SET yhzj=1,yhzj_date=getdate()  WHERE CODE IN("+codes+")";
	 ViewBean.executeUpdate(SQL);
 
 %>
<script>
alert("��ע��");
opener.window.location.reload();
 window.close();
</script>
</body>
</html>
