 
   
    
 <%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="Bean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="Bean1" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
   
<jsp:useBean id="relatime" scope="page" class="relaDateInfo.relaDateInfo"/>
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>新建事件</title>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 </head>
<script language="javascript" src="../public_js/public.js"></script>
<body>
<body>
<table width="98%" align="center">
<tr class=listtitle align="center"><td>序号</td><td>事件主题</td><td>发起人</td><td>发起日期</td><td>审批日期</td><td>当前状态</td> 
</tr>

	 <%  String alertSQL="";
	 try{
	 
	 
	  alertSQL="select a.checker,c.code,a.checker_no,a.wait_day,b.name,c.flowtitle,c.send_date,c.send_person,a.check_date from ";
	    alertSQL+="workflow_check_state a ,CortrolMan b,workflow_txt c where a.check_state=1 and  c.code=a.flow_no and";
		alertSQL+=" a.checker=b.id  and  a.checker="+(String) session.getAttribute("login_id")+" order by a.flow_no"; 
		ResultSet rs=Bean.executeQuery(alertSQL);
		 
		int i=1;
	 
	  while (rs.next()){ 
	 
	  %>
	<tr class=listbody align="center"> 
	<td><%= i%></td>
	<td><%= rs.getString("flowtitle")%></td>
	<td><%= rs.getString("send_person")%></td>
	<td><%= rs.getString("send_date")%></td>
	<td><%= rs.getString("check_date")%></td>
	<td   >
	<a href="#" onClick="window.open('flow_view_other.jsp?code=<%= rs.getString("code")%>','','menubar=no,resizable=yes,scrollbars=yes,width=665,height=550,left=200,top=100');">查阅</a> 
		
	</td>
</tr>
<% 
  i++; }rs.close();
   
  
 }catch(Exception s){out.print(alertSQL);} %>
</table>
</body>
</html>
