<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>删除确认</title>
</head>

<body oncontextmenu="return false" >
<script>

if (confirm("系统所有数据将被清空且不能恢复，确认吗？"))
window.location="DeleteAllData.jsp";
</script>


</body>
</html>
