<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %> 

<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="aBean2" scope="page" class="ConnDatabase.SDatabase" />
 <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
	<title>»Ø¸´Ìù×Ó</title>
</head>

<body>
 
 
   <%String StrSql="";
   String id=request.getParameter("ids");
   String sContent1=getbyte1(request.getParameter("content1"));
   String subject=getbyte1(request.getParameter("subject"));
   String face=getbyte1(request.getParameter("face"));
   String loginuserid=(String)session.getAttribute("loginname");
	 String  sql="update  community_forum  set amount=amount+1 ,redate=getdate(),redu='"+loginuserid+"' where id="+request.getParameter("ids");
	 
		 
		  aBean.executeUpdate(sql);
		StrSql="insert into  community_forum (subject,body,parent,face,amount,writerid) VALUES('"+subject;
		StrSql+="','"+sContent1+"',"+id+","+face+",1,'"+loginuserid+"')";
		
		 aBean.executeUpdate(StrSql); 
	 
		%>
 <script language="JavaScript">
opener.window.location="see1.jsp";
window.close();
</script>

</body>
</html>
