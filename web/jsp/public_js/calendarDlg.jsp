<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<title>
����ѡ��&nbsp;
</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<body onload="fload()" bgcolor='#FFFFEF'>
<script src=calendar.script>
</script>

<script>
function fload()
{
	fPopCalendar(document.all.txt1, document.all.txt1);
}

function fkeydown()
{
	if(event.keyCode==27){
		event.returnValue = null;
		window.returnValue = null;
		window.close();
	}
}

document.onkeydown=fkeydown;
</script>

<input type=text id="txt1" style="display:none">
</body>
</html>