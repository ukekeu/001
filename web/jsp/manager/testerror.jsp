<%@ page contentType="text/html;charset=GBK" %>
 <%@ page language="java" import="java.sql.*,java.util.*" %>
 <%@ include file="../public_js/getByteOut.jsp"%> 
 <jsp:useBean id="smenu" scope="page" class="ConnDatabase.menu" />
   <jsp:useBean id='md5' scope='request' class='crypt.MD5'/>
     <jsp:useBean id="checkreg" scope="page" class="regcheck.regcheck"/> 
<%String endd=getbyte1(request.getParameter("endd"));
String reno=getbyte1(request.getParameter("regno"));
String custype=getbyte1(request.getParameter("custype"));
ResultSet rs=null;
String mess=checkreg.checkREGMess();
 int aaa=0;
 if (!mess.equals("")){mess="关于系统";} 
 else mess="远程对系统进行正式注册";
 %>
 <html>
<title><%=mess %></title>
<head>
<base target="_self">
<meta http-equiv="Content-Language" content="zh-cn">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head> 
	

<body>
<form name="regfrm"> 
<%out.print(smenu.doStartReg(endd,reno,custype)); %>  
</form>
</body>

</html>