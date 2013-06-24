
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*,java.sql.*"%>
 <%@ include file="../public_js/checktime.jsp"%>
<jsp:useBeanid="onlineuser" class="online.ListUser" scope="application"/>
<html>
<head></head>
<title>在线人数</title>
</head> 
<body topmargin="0">
  <table width="105%" border=0  >
 
 <%String online="";
int nn=0;
Vector vt=onlineuser.getOnLineUser(); 
  Enumeration e = vt.elements(); 
    while(e.hasMoreElements())
  { 
  if (nn==0) out.print("<tr>");
  
  %>
  <td align="center" ><%=(String)e.nextElement() %></td>
  <%nn++;
  if (nn==2){nn=0; out.print("</tr>");}
   
    
  }  %>
 </table>
 
  
</body>
</html>
