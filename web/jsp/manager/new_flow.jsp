 
   
    
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
<title>�½��¼�</title>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 </head>
<script language="javascript" src="../public_js/public.js"></script>
<body>
<a href="#"  onclick="openwin2('add_emp.jsp?customer=0','800','400',100,100);return false;">����</a>
<table width="98%" align="center">
<tr class=listtitle align="center"><td>���</td><td>�¼�����</td><td>��������</td><td>��ǰ״̬</td> 
</tr>

	 <% 
	    String flowid=getbyte(request.getParameter("flowid")) ;
		if (!flowid.equals(""))Bean.executeUpdate("delete workflow_txt where code="+flowid);
	    String alertSQL="select c.code,c.flowtitle,c.send_date,c.send_person,c.state from ";
	    alertSQL+="workflow_txt c where ";
		alertSQL+="   c.send_person='"+(String) session.getAttribute("loginname")+"'"; 
		ResultSet rs=Bean.executeQuery(alertSQL);
		 
		int i=1;
	 try{
	  while (rs.next()){ 
	   int stateN=rs.getInt("state");
	  
	   String stateMess="";
	   if (stateN==0)stateMess="������";
	   else if (stateN==1) stateMess="����";
	   else if (stateN==2) stateMess="��ֹ";
	 
	  
	  %>
	<tr   class=listcontent align="center"> 
	<td><%= i%></td>
	<td><%= rs.getString("flowtitle")%></td>
	<td><%= rs.getString("send_date")%></td>
	
	<td  >
	<a href="#" onClick="window.open('flow_view_other.jsp?code=<%= rs.getString("code")%>','','menubar=no,resizable=yes,scrollbars=yes,width=665,height=550,left=200,top=100');"><%=stateMess %></a> 
		
	</td>
	<td  >
	<a href="new_flow.jsp?flowid=<%=  rs.getString("code")%>">ɾ��</a> 
		
	</td>
</tr>
<%
  i++; }rs.close();
 }catch(Exception s){out.print(alertSQL);} %>
</table>
</body>
</html>
