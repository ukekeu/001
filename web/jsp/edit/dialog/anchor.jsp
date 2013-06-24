<%@ page contentType="text/html;charset=GBK" %>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=javascript src="dialog.js"></script>
<link href='dialog.css' type='text/css' rel='stylesheet'>
<TITLE>标签管理</TITLE>

<script language="javascript">

var oRange;
var sType;
var oSel;

var sName="";

oRange = dialogArguments.eWebEditor.document.selection.createRange();
sType = dialogArguments.eWebEditor.document.selection.type;
if (sType == "Control") {
	oSel = oRange(0).parentNode;
}else{
	oSel = oRange.parentElement();
}

if (oSel.tagName.toUpperCase() == "A"){
	if (oSel.href.toUpperCase() == ""){
		sName = oSel.name;
		moveRange(oSel);
	}
}

function InitDocument(){
	d_anchor.value = sName;
	getAnchors();
	adjustDialog();
}

function getAnchors() {
	d_allanchor.options.length = 0;
	var allLinks = dialogArguments.eWebEditor.document.body.getElementsByTagName("A");
	for (i=0; i < allLinks.length; i++) {
		if (allLinks[i].href.toUpperCase() == "") {
			d_allanchor.options[d_allanchor.options.length] = new Option(allLinks[i].name, allLinks[i].name);
		}
	}
}

function getAnchorObj(str) {
	var allLinks = dialogArguments.eWebEditor.document.body.getElementsByTagName("A");
	for (i=0; i < allLinks.length; i++) {
		if (allLinks[i].href.toUpperCase() == "") {
			if (allLinks[i].name==str){
				return allLinks[i];
			}
		}
	}
	return null;
}

function OK(){
	var sName = BaseTrim(d_anchor.value);
	if (sName == ""){
		BaseAlert(d_anchor, "请输入书签名称！");
		return;
	}

	oRange = dialogArguments.eWebEditor.document.selection.createRange();
	sType = dialogArguments.eWebEditor.document.selection.type;
	if (sType == "Control") {
		oSel = oRange(0).parentNode;
	}else{
		oSel = oRange.parentElement();
	}

	var bModify = false;
	if (oSel.tagName.toUpperCase() == "A"){
		if (oSel.href.toUpperCase() == ""){
			oSel.name = sName;
			bModify = true;
		}
	}
	if (!bModify){
		var html="";
		if (sType == "Control") {
			oRange(0).outerHTML = "<a id=eWebEditor_TempElement_Anchor name=" + sName + ">" + oRange(0).outerHTML + "</a>";
		}else{
			oRange.pasteHTML("<a id=eWebEditor_TempElement_Anchor name=" + sName + ">" + oRange.htmlText + "</a>");
		}

		var oTempElement = dialogArguments.eWebEditor.document.getElementById("eWebEditor_TempElement_Anchor");

		if (dialogArguments.borderShown != "0") {
			oTempElement.runtimeStyle.borderBottom = "1px dashed #000000";
		}

		oTempElement.removeAttribute("id");
	}
	
	window.returnValue = null;
	window.close();
}

function doMove(){
	var nIndex = d_allanchor.selectedIndex;
	if (nIndex<0) {
		alert("请先选择一个书签！");
		return;
	}
	var sel = getAnchorObj(d_allanchor.options[nIndex].value);
	if (sel){
		moveRange(sel);
	}
}

function doDel(){
	var nIndex = d_allanchor.selectedIndex;
	if (nIndex<0) {
		alert("请先选择一个书签！");
		return;
	}
	var sel = getAnchorObj(d_allanchor.options[nIndex].value);
	if (sel){
		sel.outerHTML = sel.innerHTML;
		d_allanchor.options[nIndex] = null;
	}
}

function moveRange(sel){
	var rng = dialogArguments.eWebEditor.document.body.createTextRange();
	rng.moveToElementText(sel);
	rng.select();
}
</script>

</HEAD>
<BODY onload="InitDocument()">
<table border=0 cellpadding=0 cellspacing=5 id=tabDialogSize><tr><td>


<TABLE CELLSPACING="0" cellpadding="5" border="0" align=center>
<TR valign="top">
	<TD noWrap align="left">
		书签名称:<br>
		<INPUT TYPE=TEXT SIZE=20 id="d_anchor" style="width:150px;"><br>
		本页其它书签:<br>
		<select id="d_allanchor" size=8 style="width:150px;" onchange="d_anchor.value=this.options[this.selectedIndex].value;"></select>
	</td>
	<td noWrap height="100%">
		<table border=0 cellpadding=0 cellspacing=0 height="100%">
		<tr>
			<td height="50%" valign=top>
			<input type=button style="width:80px;margin-top:15px" name="btnOK" onClick="OK()" value="确定"><br>
			<input type=button style="width:80px;margin-top:5px" name="btnCancel" onClick="window.close()" value="取消"><br>
			</td>
		</tr>
		<tr>
			<td height="50%" valign=bottom>
			<input type=button style="width:80px;" name="btnMove" onClick="doMove()" value="转到"><br>
			<input type=button style="width:80px;margin-top:5px" name="btnDel" onClick="doDel()" value="删除"><br>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>


</td></tr></table>
</BODY>
</HTML>
