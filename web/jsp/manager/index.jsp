<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<title><%=(String)session.getAttribute("loginname")+",U客软件欢迎您！"%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">
var risload=0;
var pdv=new Array();
var pdv1=new Array();
 
function ldo()
{  
    leftp.location="rsh.jsp";
    window.setTimeout(ldo,30000);
}
 
function setr(e)
{
    risload=e;
    leftp.location="rsh.jsp";
}

function setr1(e)
{
    risload=e;
    leftp.location="rsh.jsp";
}
 
</script>
 
</head>
 
<frameset cols="0,0,*" frameborder="no" border="0" framespacing="0" onload="ldo();">
    <frame scrolling="NO" noresize  >
   <frame name="leftp" scrolling="NO" noresize src="rsh.jsp">
   
    <frame name="rightp" src="sysindex.jsp">
<noframes> 
</noframes>
</body>
</html>
