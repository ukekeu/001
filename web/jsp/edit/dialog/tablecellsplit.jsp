<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=javascript src="dialog.js"></script>
<link href='dialog.css' type='text/css' rel='stylesheet'>
<title>��Ԫ����</title>

<script language="javascript">

function MoreThanOne(obj, sErr){
	var b=false;
	if (obj.value!=""){
		obj.value=parseFloat(obj.value);
		if (obj.value!="0"){
			b=true;
		}
	}
	if (b==false){
		BaseAlert(obj,sErr);
		return false;
	}
	return true;
}

function doView(opt){
	if (opt=="col"){
		d_col.checked=true;
		d_row.checked=false;
	}else{
		d_col.checked=false;
		d_row.checked=true;
	}
	if (d_col.checked){
		d_view.innerHTML = "<table border=1 cellpadding=0><tr><td width=25>&nbsp;</td><td width=25>&nbsp;</td></tr></table>";
		d_label.innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;����:";
	}
	if (d_row.checked){
		d_view.innerHTML = "<table border=1 cellpadding=0 width=50><tr><td>&nbsp;</td></tr><tr><td>&nbsp;</td></tr></table>";
		d_label.innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;����:";
	}
}

function ok(){
	if (!MoreThanOne(d_num,"��Ч�����������������1��")) return;

	if (d_row.checked){
		dialogArguments.TableRowSplit(parseInt(d_num.value));
	}
	if (d_col.checked){
		dialogArguments.TableColSplit(parseInt(d_num.value));
	}

	window.returnValue = null;
	window.close();
}

function InitDocument(){
	adjustDialog();
}

</script>

</head>
<body onload="InitDocument()">
<table border=0 cellpadding=0 cellspacing=5 id=tabDialogSize><tr><td>


<table border=0 cellpadding=0 cellspacing=0 align=center width=180 height=150>
<tr>
	<td>
	<table border=0 cellpadding=0 cellspacing=0>
	<tr><td colspan=3 height=5></td></tr>
	<tr><td noWrap><input type=radio id=d_col checked onclick="doView('col')"><label for="d_col">���Ϊ��</label></td><td rowspan=3 width=30>&nbsp;</td><td width=60 rowspan=3 id=d_view valign=middle align=center></td></tr>
	<tr><td height=5></td></tr>
	<tr><td noWrap><input type=radio id=d_row onclick="doView('row')"><label for="d_row">���Ϊ��</label></td></tr>
	<tr><td height=5 colspan=3></td></tr>
	<tr>
		<td noWrap id=d_label></td>
		<td></td>
		<td><input type=text id=d_num size=8 value="1" ONKEYPRESS="event.returnValue=IsDigit();" maxlength=3></td>
	</tr>
	</table>
</tr>
<tr><td height=5></td></tr>
<tr><td noWrap align=right><input type=submit value='ȷ��' id=Ok onclick="ok()">&nbsp;&nbsp;<input type=button value='ȡ��' onclick="window.close();"></td></tr>
</table>


</td></tr></table>

<Script Language=JavaScript>
doView('col');
</Script>

</body>
</html>