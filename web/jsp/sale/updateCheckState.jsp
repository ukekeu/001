<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "��ͬ��˹���" , 
                  "��˿��԰����Ȩ"
                ) ;
%>

<html>
<head>
	<title>��Ȩ�������</title>
</head>

<body>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>

<%String codes=request.getParameter("codes");

 String SQL="UPDATE ORDER_CONTRACT SET CQ=1  WHERE  cq_check=1 and CODE IN("+codes+")";
	ViewBean.executeUpdate(SQL);
 %>
<script>
alert("�����");
opener.document.forms[0].submit();
window.close();
</script>
</body>
</html>
