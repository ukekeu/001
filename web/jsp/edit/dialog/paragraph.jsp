<%@ page contentType="text/html;charset=GBK" %>
<HTML>
<HEAD>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<script language="javascript" src="dialog.js"></script>
<link href='dialog.css' type='text/css' rel='stylesheet'>
<TITLE>段落属性</TITLE>

<script language=javascript>

var sMarginTop = "";
var sMarginBottom = "";
var sMarginLeft = "";
var sMarginRight = "";
var sTextAlign = "";
var sLineHeight = "";
var sTextIndent = "";
var sLetterSpacing = "";

var sel = dialogArguments.eWebEditor.document.selection.createRange();
sel.type = dialogArguments.eWebEditor.document.selection.type;


var oBody = dialogArguments.eWebEditor.document.body;
var aAllEl = oBody.getElementsByTagName("P");
var aSelEl = new Array();
var oRngTemp = oBody.createTextRange();

for(var i=0;i<aAllEl.length;i++){
	oRngTemp.moveToElementText(aAllEl(i));
	if (sel.inRange(oRngTemp)){
		aSelEl[aSelEl.length] = aAllEl[i];
	}else{
		if ( ((sel.compareEndPoints("StartToEnd",oRngTemp)<0)&&(sel.compareEndPoints("StartToStart",oRngTemp)>0)) || ((sel.compareEndPoints("EndToStart",oRngTemp)>0)&&(sel.compareEndPoints("EndToEnd",oRngTemp)<0)) ){
			aSelEl[aSelEl.length] = aAllEl[i];
		}
	}
}

for(var i=0;i<aSelEl.length;i++){
	if (i==0){
		sMarginTop = aSelEl[i].style.marginTop;
		sMarginBottom = aSelEl[i].style.marginBottom;
		sMarginLeft = aSelEl[i].style.marginLeft;
		sMarginRight = aSelEl[i].style.marginRight;
		sTextAlign = aSelEl[i].style.textAlign;
		sLineHeight = aSelEl[i].style.lineHeight;
		sTextIndent = aSelEl[i].style.textIndent;
		sLetterSpacing = aSelEl[i].style.letterSpacing;
	}else{
		if (aSelEl[i].style.marginTop!=sMarginTop) sMarginTop = "";
		if (aSelEl[i].style.marginBottom!=sMarginBottom) sMarginBottom = "";
		if (aSelEl[i].style.marginLeft!=sMarginLeft) sMarginLeft = "";
		if (aSelEl[i].style.marginRight!=sMarginRight) sMarginRight = "";
		if (aSelEl[i].style.textAlign!=sTextAlign) sTextAlign = "";
		if (aSelEl[i].style.lineHeight!=sLineHeight) sLineHeight = "";
		if (aSelEl[i].style.textIndent!=sTextIndent) sTextIndent = "";
		if (aSelEl[i].style.letterSpacing!=sLetterSpacing) sLetterSpacing = "";
	}
}


function doChangeLineHeightDrop(){
	var s_DropValue = d_lineheightdrop.options[d_lineheightdrop.selectedIndex].value;
	if (s_DropValue=="other"){
		return;
	}else{
		d_lineheight.value = s_DropValue;
	}
}

function doChangeLineHeightInput(){
	var s_Value = BaseTrim(d_lineheight.value);

	switch(s_Value){
	case "":
		d_lineheightdrop.selectedIndex = 1;
		break;
	case "1":
		d_lineheightdrop.selectedIndex = 2;
		break;
	case "1.5":
		d_lineheightdrop.selectedIndex = 3;
		break;
	case "2":
		d_lineheightdrop.selectedIndex = 4;
		break;
	default:
		d_lineheightdrop.selectedIndex = 0;
		break;
	}
}


function InitDocument() {
	SearchSelectValue(d_align, sTextAlign.toLowerCase());
	SearchSelectValue(d_lineheightdrop, sLineHeight);
	d_margintop.value = sMarginTop;
	d_marginbottom.value = sMarginBottom;
	d_marginleft.value = sMarginLeft;
	d_marginright.value = sMarginRight;
	d_lineheight.value = sLineHeight;
	d_textindent.value = sTextIndent;
	d_letterspacing.value = sLetterSpacing;

	adjustDialog();
}

function ok(){
	sMarginTop = d_margintop.value;
	sMarginBottom = d_marginbottom.value;
	sMarginLeft = d_marginleft.value;
	sMarginRight = d_marginright.value;
	sTextAlign = d_align.options[d_align.selectedIndex].value;
	sLineHeight = d_lineheight.value;
	sTextIndent = d_textindent.value;
	sLetterSpacing = d_letterspacing.value;
	
	for(var i=0;i<aSelEl.length;i++){
		try{aSelEl[i].style.marginTop = sMarginTop}catch(e){};
		try{aSelEl[i].style.marginBottom = sMarginBottom}catch(e){};
		try{aSelEl[i].style.marginLeft = sMarginLeft}catch(e){};
		try{aSelEl[i].style.marginRight = sMarginRight}catch(e){};
		try{aSelEl[i].style.textAlign = sTextAlign}catch(e){};
		try{aSelEl[i].style.lineHeight = sLineHeight}catch(e){};
		try{aSelEl[i].style.textIndent = sTextIndent}catch(e){};
		try{aSelEl[i].style.letterSpacing = sLetterSpacing}catch(e){};
	}

	window.returnValue = null;
	window.close();

}
</script>
</HEAD>

<BODY onload="InitDocument()">
<table border=0 cellpadding=0 cellspacing=5 id=tabDialogSize><tr><td>


<table border=0 cellpadding=0 cellspacing=0 align=center>
<tr>
	<td>
	<fieldset>
	<legend>空白</legend>
	<table border=0 cellpadding=5 cellspacing=0 width="100%">
	<tr><td>

		<table border=0 cellpadding=0 cellspacing=2 width="100%">
		<tr>
			<td noWrap width="20%">段前:</td>
			<td noWrap width="29%"><input style="width:80px" id=d_margintop size=10 value=""></td>
			<td width="2%">&nbsp;</td>
			<td noWrap width="20%">段后:</td>
			<td noWrap width="29%"><input style="width:80px" id=d_marginbottom size=10 value=""></td>
		</tr>
		<tr>
			<td noWrap width="20%">文本之前:</td>
			<td noWrap width="29%"><input style="width:80px" id=d_marginleft size=10 value=""></td>
			<td width="2%"></td>
			<td noWrap width="20%">文本之后:</td>
			<td noWrap width="29%"><input style="width:80px" id=d_marginright size=10 value=""></td>
		</tr>
		</table>

	</td></tr>
	</table>
	</fieldset>
	</td>
</tr>
<tr>
	<td>
	<fieldset>
	<legend>其它</legend>
	<table border=0 cellpadding=5 cellspacing=0 width="100%">
	<tr><td>

		<table border=0 cellpadding=0 cellspacing=2 width="100%">
		<tr>
			<td noWrap width="20%">对齐方式:</td>
			<td noWrap width="29%">
				<select id=d_align size=1 style="width:80px">
				<option value='' selected>默认</option>
				<option value='left'>左对齐</option>
				<option value='right'>右对齐</option>
				<option value='center'>居中对齐</option>
				<option value='justify'>两端对齐</option>
				</select>			
			</td>
			<td width="2%">&nbsp;</td>
			<td noWrap width="20%">行距大小:</td>
			<td noWrap width="29%">
				<div style="position:relative;">
				<span style="margin-left:62px;width:18px;overflow:hidden;">
				<select id=d_lineheightdrop style="width:80px;margin-left:-62px" onchange="doChangeLineHeightDrop()">
				<option value="other">多倍行距</option>
				<option value="">默认</option>
				<option value="1">单倍行距</option>
				<option value="1.5">1.5 倍行距</option>
				<option value="2">2 倍行距</option>
				</select>
				</span>
				<input style="width:62px;position:absolute;left:0px;" id=d_lineheight size=10 value="" onchange="doChangeLineHeightInput()">
				</div>
			</td>
		</tr>
		<tr>
			<td noWrap width="20%">首行缩进:</td>
			<td noWrap width="29%"><input style="width:80px" id=d_textindent size=10 value=""></td>
			<td width="2%">&nbsp;</td>
			<td noWrap width="20%">单字间距:</td>
			<td noWrap width="29%"><input style="width:80px" id=d_letterspacing size=10 value=""></td>
		</tr>
		</table>

	</td></tr>
	</table>
	</fieldset>
	</td>
</tr>

<tr><td height=5></td></tr>
<tr><td align=right><input type=submit value='确定' id=Ok onclick="ok()">&nbsp;&nbsp;<input type=button value='取消' onclick="window.close();"></td></tr>
</table>


</td></tr></table>
</BODY></HTML>
