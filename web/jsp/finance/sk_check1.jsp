 <%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<html>
<head>
	<title>发放产权时对交款的核实</title>
</head>

<body>
<%
   String codes=request.getParameter("codes");
 
  
   String sql=" ";
 
    sql="update FactGatheringTaxRecord set checkstate=1,checkdate=getdate(),checkperson='";
   sql+=(String)session.getAttribute("loginname")+"' where code in ("+codes+")";
 if (!codes.equals(""))ViewBean.executeUpdate(sql);
 
 
 %> 
 <script>alert("已核实通过"); opener.findSub2();window.close();</script>

</body>
</html>
