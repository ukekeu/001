<%@ page contentType="text/html;charset=GBK" %>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=javascript src="dialog.js"></script>
<link href='dialog.css' type='text/css' rel='stylesheet'>

<script language=javascript>

var sAction = "INSERT";
var sTitle = "插入";
var sel = dialogArguments.eWebEditor.document.selection.createRange();
sel.type = dialogArguments.eWebEditor.document.selection.type;

var el;
var sText = "";
var sBehavior = "";

if (sel.type=="Control") {
	if (sel.item(0).tagName=="MARQUEE"){
		sAction = "MODI";
		sTitle = "修改";
		el = sel.item(0);
		sBehavior = el.behavior;
		sText = el.innerHTML;
	}
}

document.write("<title>字幕属性(" + sTitle + ")</title>");

function check(){
	sBehavior = event.srcElement.value;
}

function InitDocument() {
	d_text.value = sText;
	switch (sBehavior) {
	case "scroll":
		document.all("d_behavior")[0].checked = true;
		break;
	case "slide":
		document.all("d_behavior")[1].checked = true;
		break;
	default:
		sBehavior = "alternate";
		document.all("d_behavior")[2].checked = true;
		break;
	}

	adjustDialog();
}

function ok(){
	sText = d_text.value;
	if (sAction == "MODI") {
		el.behavior = sBehavior;
		el.innerHTML = sText;
	}else{
		dialogArguments.insertHTML("<marquee behavior='"+sBehavior+"'>"+sText+"</marquee>");
	}
	window.returnValue = null;
	window.close();
}
</script>
</HEAD>

<body onload="InitDocument()">
<table border=0 cellpadding=0 cellspacing=5 id=tabDialogSize><tr><td>


<table border=0 cellpadding=0 cellspacing=0 align=center>
<tr><td>
	<FIELDSET>
	<LEGEND></LEGEND>
	<table border=0 cellspacing=0 cellpadding=5 width="100%">
	<tr><td>

		<table border=0 cellspacing=2 cellpadding=0 width="100%">
		<tr>
			<td noWrap width="20%">文本:</td>
			<td noWrap width="80%"><input type=text id="d_text" size=40 value=""></td>
		</tr>
		<tr>
			<td noWrap width="20%">表现:</td>
			<td noWrap width="80%"><input onclick="check()" type="radio" name="d_behavior" value="scroll"> 滚动条 <input onclick="check()" type="radio" name="d_behavior" value="slide"> 幻灯片 <input onclick="check()" type="radio" name="d_behavior" value="alternate"> 交替</td>
		</tr>

		</table>

	</td></tr>
	</table>
	</FIELDSET>

</td></tr>
<tr><td height=10></td></tr>
<tr><td noWrap align=right><input type=submit value='确定' id=Ok onclick="ok()">&nbsp;&nbsp;<input type=button value='取消' onclick="window.close();"></td></tr>
</table>


</td></tr></table>
</body>
</html>
