 
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
��

<HTML>
<HEAD>
	<title>���Ͷ���</title> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chrset=gb2312"> 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 

</head>

<body>
<form name=frm method="post">
<table>
<tr><td>�������������</td></tr>
</table>
<table>
<tr><td><textarea cols="50" rows="8" title="�������ݲ�Ҫ����70������"></textarea></td></tr>
<tr><td align="center"><input type="button" name=send value="�� ��">&nbsp;<input type="button" name=close value="�� ��" onclick="window.close();"></td></tr>
</table>

</form>
</body>
</html>
