 <%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<html>
<head>
	<title>���Ų�Ȩʱ�Խ���ĺ�ʵ</title>
</head>

<body>
<%
   String codes=request.getParameter("codes");
   String sql="update order_contract set cq_check=1,cq_checkdate=getdate(),cq_checkperson='";
   sql+=(String)session.getAttribute("loginname")+"' where code in ("+codes+")";
   ViewBean.executeUpdate(sql);

 %>
 <script>alert("�Ѻ�ʵͨ��");opener.document.forms[0].submit();window.close();</script>
	

</body>
</html>
