<%@ page contentType="text/html;charset=GBK" %>
 <%@ page language="java" import="java.sql.*,common.*,java.util.*,java.util.Date" %> 
 <jsp:useBean id = "Bean" scope = "page" class = "ConnDB.ConnODBC" />
 <jsp:useBean id = "Bean1" scope = "page" class = "ConnDB.ConnODBC" />
  <jsp:useBean id = "Bean2" scope = "page" class = "ConnDB.ConnODBC" />
   <jsp:useBeanid="onlineuser" class="online.ListUser" scope="application"/>

<jsp:useBean id="relatime" scope="page" class="relaDateInfo.relaDateInfo"/>
  <%@ include file="../inc/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>新建事件</title>
<LINK href="yellow.css" rel=stylesheet type=text/css>
 
</head>

<body>


	 <% String alertSQL="select c.code,a.checker_no,a.wait_day,b.name,c.flowtitle,c.send_date,c.send_person from ";
	    alertSQL+="workflow_check_state a ,CortrolMan b,workflow_txt c where a.check_state=0 and  c.code=a.flow_no and";
		alertSQL+=" a.checker=b.id  AND a.checker="+(String) session.getAttribute("USER_ID"); 
		ResultSet rs=Bean.executeQuery(alertSQL);
	   
 
	 try{
	  while (rs.next()){ 
	 	 	 
	  %>
	<tr> 
	<td bgcolor="#ECF2F2" align="left"  width="11%">
	
		&nbsp;&nbsp;<a href="#" onClick="window.open('flow_view.jsp?code=<%= rs.getString("code")%>','','menubar=no,resizable=yes,scrollbars=yes,width=665,height=550,left=200,top=100');"><%=rs.getString("flowtitle") %></a>[<%=rs.getString("send_person") %>于<%=rs.getString("send_date").substring(0,10) %>发送]
		
	</td>
</tr>
<%
   }rs.close();
 }catch(Exception s){out.print(s);} %>

</body>
</html>
