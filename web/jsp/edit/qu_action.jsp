<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %> 

<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="aBean2" scope="page" class="ConnDatabase.SDatabase" />
 <%@ include file="../public_js/getByteOut.jsp"%>
  <%String StrSql="";
   String sContent1=getbyte1(request.getParameter("content1"));
   String subject=getbyte1(request.getParameter("subject"));
   String face=getbyte1(request.getParameter("face"));
   String loginuserid=(String)session.getAttribute("loginname");
	if (!subject.equals("")){
		StrSql="insert into  community_forum (subject,body,parent,face,amount,writerid) VALUES('"+subject;
		StrSql+="','"+sContent1+"',0,"+face+",0,'"+loginuserid+"')";
		
		 aBean.executeUpdate(StrSql); 
		 
		 
		%>
<script language="JavaScript">
opener.window.location="../manager/myplan.jsp";
window.close();
</script>
<% 
	}
%> 