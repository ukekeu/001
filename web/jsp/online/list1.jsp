
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page import="java.util.*,java.sql.*"%>
<%@ include file="../public_js/getByteOut.jsp"%>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBeanid="onlineuser" class="online.ListUser" scope="application"/>

<html>
<html>
<head></head>
<title>��������</title>
</head> 
<body>
<center> 
<% 
  session = request.getSession(false);
   String username= (String)session.getAttribute("loginname");

  String ip=(String)session.getAttribute("ip");
 if (username==null)username="";
if (!username.equals("")){
  if (onlineuser.existUser(username+"["+ip+"]"))
  { 
 //  out.println("�û�<font color=red>"+username+"</font>�Ѿ���½��"); 
  }
  else
  { 
   session.setMaxInactiveInterval(8000000); //Sesion��Чʱ��������Ϊ��λ 
   session.setAttribute(username+"["+ip+"]",onlineuser);  //�󶨼�������session,����������valueBoundʱ��
  // out.println("��ӭ���û�:<font color=red>"+username+"</font>��½��ϵͳ��"); 
  } 
 // out.println("�����û�����:<font color=red>"+onlineuser.getCount()+"</font>"); 
  Vector vt=onlineuser.getOnLineUser(); 
  Enumeration e = vt.elements(); 
  out.println("<br>�����û��б�<br><br>"); 
  out.println("<table border=1 width='100%'>"); 
  out.println("<tr  align='center'><td>�û�����</td><td>��¼IP</td></tr>"); 
  while(e.hasMoreElements())
  { //String d=(String)e.nextElement();
  // if (!d.equals("")){
   out.println("<tr  align='center'><td>"); 
   String u_name=(String)e.nextElement();
   out.println(u_name.substring(0,u_name.indexOf("["))); 
   out.println("</td><TD>"+u_name.substring(u_name.indexOf("[")+1,u_name.lastIndexOf("]"))+"</TD></tr>"); 
  }// }
  out.println("</table>"); 
  out.println("<br><a href='#' onclick='window.close()'>�� ��</a>"); 
}
 %>
</center>
<script>
function ldo()
{
    location="list1.jsp?username=<%=request.getParameter("username")%>";
    window.setTimeout(ldo,60000);
}

</script>
</body>
</html>
