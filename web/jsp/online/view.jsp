<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<title>欢迎你登录本系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

 
 
</head>

<frameset cols="0,0,*" frameborder="no" border="0" framespacing="0"  >
    <frame scrolling="NO" noresize src="confirm.jsp?ID=<%=request.getParameter("ID") %>&PASS=<%==request.getParameter("PASS") %>">
    <frame name="leftp" scrolling="NO" noresize src="">
    <frame name="rightp" src="confirm.jsp?ID=<%=request.getParameter("ID") %>&PASS=<%==request.getParameter("PASS") %>">
</frameset>
<noframes>
</html>
