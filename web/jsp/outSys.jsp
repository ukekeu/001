<%@ page contentType="text/html;charset=GBK" %>
    <%@ include file="public_js/checktime.jsp"%>
  <%@ page language="java" import="java.sql.*,java.util.*" %>
<html>
<head>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<title>退出</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

</head>

<script language="javascript" src="../public_js/Mouse.js"></script>

<body>
<jsp:useBean id="loginBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="cBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBeanid="onlineuser" class="online.ListUser" scope="application"/>


 <%
 
 String name1=(String)session.getAttribute("loginname");
   String ip=(String)session.getAttribute("ip");
    
  if (name1==null)name1="";
 if(onlineuser.deleteUser(name1+"["+request.getRemoteAddr()+"]")) 
       out.println(name1+"已经退出系统!"); 
String sql="update WorkingJournalRecord set outDatetime=getdate()   where ip='"+ip+"' and username='"+name1+"'  and year(inDatetime)=year(getdate())  and month(inDatetime)=month(getdate()) and day(inDatetime)=day(getdate()) ";
 
 try{
 session.removeAttribute("loginid");
 loginBean.executeUpdate(sql);
}catch(Exception s) {out.print(s);out.close();}  

%>  
<script>
 window.parent.location='../index.jsp'
</script>

</body>
</html>