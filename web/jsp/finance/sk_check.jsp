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
 
  
   String sql="update FactGatheringRecord set checkstate=1,checkDATE=getdate(),checkstateperson='";
   sql+=(String)session.getAttribute("loginname")+"' where id in ("+codes+")";
  ViewBean.executeUpdate(sql);
  
 
 %> 
 <script>alert("�Ѻ�ʵͨ��"); opener.findSub2();window.close();</script>
	

</body>
</html>
