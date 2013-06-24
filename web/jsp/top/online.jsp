<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ page import="java.sql.*,java.util.*" %>
  <jsp:useBeanid="onlineuser" class="online.ListUser" scope="application"/>
 <jsp:useBean id="userBean" scope="page" class="ConnDatabase.SDatabase" />
 <jsp:useBean id="smenu" scope="page" class="ConnDatabase.menu" /> 
  <%@ include file="../public_js/getByteOut.jsp"%>   
<html>
 <LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 <head>
	<title>当前在线用户</title>
</head>
<STYLE type=text/css>BODY {
	MARGIN: 0px
}
.style4 {
	COLOR: #43994f
}
.style6 {
	FONT-SIZE: 15px
}
.style8 {
	COLOR: #e1411d
}
</STYLE>
  
<body  topmargin="0" leftmargin="0"   marginheight="100%"   oncontextmenu="return false"    >
 <table width="100%"   border="0"     bgColor=#fef2f0    >
<tr><td align="right"  ><img src="../images/color.gif" height="1" width="100%"></td></tr>
</table>
 <table width="100%"   border="1"     bgColor=#fef2f0    >
 <% 
try{
 String name1=getbyte1(request.getParameter("onlineperson")); 
 if (!name1.equals("")){
out.print(onlineuser.deleteUser(name1));
session.removeAttribute("loginid");
}
 Vector vt=onlineuser.getOnLineUser(); 
  String send_person=(String)session.getAttribute("loginname");
  Enumeration e = vt.elements(); 
   String useronline="";
  int onlinenum=0;
  int i=0;
    while(e.hasMoreElements())
  { onlinenum++;
      String online_name=(String)e.nextElement();
	       if (i==0)out.print("<tr>");
	 out.println("<td align='center'>"+online_name+"<a href='onlineAlert.jsp?acc="+online_name.substring(0,online_name.indexOf("["))+"'><img  border=0 src='../images/online.gif' title='点击此可以与他对话'></a>");
	 if (send_person.equals("系统管理员")){
	   out.println("&nbsp;<a href='online.jsp?onlineperson="+online_name+"'><img  border=0 src='../images/button_sc.gif' title='点击此可以把他跌出'></a>");
	 }
	 out.println(" </td>");
	i++;
	if (i==2){out.print("</tr>"); i=0;}
  }   
   }catch(Exception m){out.close();}
 %>
</table> 
<table width="100%"   border="0"     bgColor=#fef2f0    >
<tr><td align="right"  ><img src="../images/color.gif" height="1" width="100%"></td></tr>
</table>
</body>
</html>
