<html>
<head>
 
<%@ page import = "java.sql.*,java.util.*" contentType="text/html;charset=GBK" %>
   <%@ include file="public_js/checktime.jsp"%>
<jsp:useBean id="loginBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="checkreg" scope="page" class="regcheck.regcheck"/> 
 <jsp:useBean id='md5' scope='request' class='crypt.MD5'/>
 <%@ include file="../jsp/public_js/getByteOut.jsp"%>
 <% 
   out.print(checkreg.checkIn((String) session.getAttribute("loginfg")));  
   session.removeAttribute("loginfg");
   %>
 <title><%=(String)session.getAttribute("loginname")+",U客软件欢迎您！"%></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

 <script language="JavaScript">
<!--

if (window.Event) 
document.captureEvents(Event.MOUSEUP); 

function nocontextmenu() 
{
event.cancelBubble = true
event.returnValue = false;

return false;
}

function norightclick(e) 
{
if (window.Event) 
{
if (e.which == 2 || e.which == 3)
return false;
}
else
if (event.button == 2 || event.button == 3)
{
event.cancelBubble = true
event.returnValue = false;
return false;
}

}

document.oncontextmenu = nocontextmenu; // for IE5+
document.onmousedown = norightclick; // for all others
//-->
</script>


<script language="JavaScript">
this.resizeTo(screen.availWidth,screen.availHeight)
this.moveTo(0,0)
this.focus()
var risload=0;
  
</script>

</head> 
 
<frameset cols="0,*" frameborder="no" border="0" framespacing="0"  >
    <frame name="leftp" scrolling="NO" noresize src="online/list.jsp?ID=<%=getbyte2(request.getParameter("cc"))%>">
    <frame name="rightp" src="confirm.jsp?userid=<%=request.getParameter("IDID") %>&password=<%=request.getParameter("PASSPASS")%>&ID=<%=(String) session.getAttribute("cc")%>&PASS=<%=(String) session.getAttribute("dd")%>">
</frameset>
<noframes>
<body>
您的浏览器不支持框架式显示
</body> 
</html>
