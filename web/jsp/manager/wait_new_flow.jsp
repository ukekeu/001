 
   
    
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
<form name=frm action="">
<table width="98%" align="center">
<tr class=listtitle align="center"><td>序号</td><td>事件主题</td><td>发起日期</td><td>当前状态</td> 
</tr>

	 <%  String alertSQL="";
	 try{
	 String waitSQL="select * from workflow_check_state where checker="+(String) session.getAttribute("login_id");
	 ResultSet rs1=Bean1.executeQuery(waitSQL);
	 while (rs1.next()){
	  alertSQL="select a.checker,c.code,a.checker_no,a.wait_day,b.name,c.flowtitle,c.send_date,c.send_person from ";
	    alertSQL+="workflow_check_state a ,CortrolMan b,workflow_txt c where  (a.check_state=0 or a.back_state=2) and c.code=a.flow_no and";
		alertSQL+=" a.checker=b.id  and  a.flow_no="+rs1.getString("flow_no")+" and a.back_state<>3 order by a.flow_no"; 
		ResultSet rs=Bean.executeQuery(alertSQL);
		int i=1;
	 
	  while (rs.next()){   
	   if (rs.getString("checker").equals((String) session.getAttribute("login_id"))&&i==1){
	  %>
	<tr class=listbody align="center"> 
	<td><%= i%></td>
	<td><%= rs.getString("flowtitle")%></td>
	<td><%= rs.getString("send_date")%></td>
	
	<td    >
	<a href="#" onClick="window.open('check_flow_view.jsp?code=<%= rs.getString("code")%>','','menubar=no,resizable=yes,scrollbars=yes,width=765,height=550,left=200,top=100');">审批</a> 
		
	</td>
</tr>
<%}
  i++; }rs.close();
  }
  rs1.close();
 }catch(Exception s){out.print(alertSQL);} %>
</table>
</form>
</body>
</html>
