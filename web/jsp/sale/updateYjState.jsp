<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "��ͬ����" , 
                  "�ƽ�����"
                ) ;
%>

<html>
<head>
	<title>�ƽ�����</title>
</head>

<body>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>

<%String codes=request.getParameter("codes");

 String SQL="UPDATE ORDER_CONTRACT SET yj=1 WHERE CODE IN("+codes+")";
	ViewBean.executeUpdate(SQL);
 %>
<script>
 if (confirm("�Ƿ��ӡ�ƽ���"))
 
opener.window.location.reload();
window.close();
</script>
</body>
</html>
