 
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
　

<HTML>
<HEAD>
	<title>发送短信</title> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chrset=gb2312"> 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 

</head>

<body>
<form name=frm method="post">
<table>
<tr><td>请输入短信内容</td></tr>
</table>
<table>
<tr><td><textarea cols="50" rows="8" title="短信内容不要超过70个汉字"></textarea></td></tr>
<tr><td align="center"><input type="button" name=send value="发 送">&nbsp;<input type="button" name=close value="退 出" onclick="window.close();"></td></tr>
</table>

</form>
</body>
</html>
