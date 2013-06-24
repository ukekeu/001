<%@ page contentType="text/html;charset=GBK" %>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=javascript src="dialog.js"></script>
<link href='dialog.css' type='text/css' rel='stylesheet'>

<Script language=JavaScript>

var sAction = "INSERT";
var sTitle = "插入";

var oControl;
var oChild;
var oSeletion;
var sRangeType;

var sAlignFieldset = "";
var sAlignLegend = "";
var sBorderColor = "";
var sBgColor = "";

oSelection = dialogArguments.eWebEditor.document.selection.createRange();
sRangeType = dialogArguments.eWebEditor.document.selection.type;

if (sRangeType == "Control") {
	if (oSelection.item(0).tagName == "FIELDSET"){
		sAction = "MODI";
		sTitle = "修改";
		oControl = oSelection.item(0);
		sAlignFieldset = oControl.align;
		oChild = GetChildElement(oControl,"LEGEND");
		if (oChild) sAlignLegend = oChild.align;
		sBorderColor = oControl.style.borderColor;
		sBgColor = oControl.style.backgroundColor;
	}
}


document.write("<title>栏目框属性(" + sTitle + ")</title>");


function InitDocument(){
	SearchSelectValue(d_alignfieldset, sAlignFieldset.toLowerCase());
	SearchSelectValue(d_alignlegend, sAlignLegend.toLowerCase());

	d_bordercolor.value = sBorderColor;
	s_bordercolor.style.backgroundColor = sBorderColor;
	d_bgcolor.value = sBgColor;
	s_bgcolor.style.backgroundColor = sBgColor;

	adjustDialog();
}

// get first child element from same tag object
function GetChildElement(obj, sTag){
	var el;
	for (var i=0;i<obj.children.length;i++){
		if (obj.children[i].tagName==sTag){
			return obj.children[i];
		}else{
			el=GetChildElement(obj.children[i], sTag);
			if (el){
				return el;
			}
		}
	}
	return null;
}

</script>

<SCRIPT event=onclick for=Ok language=JavaScript>
	// is valid bordercolor
	sBorderColor = d_bordercolor.value;
	if (!IsColor(sBorderColor)){
		BaseAlert(d_bordercolor,"无效的边框颜色值！");
		return;
	}
	// is valid bgcolor
	sBgColor = d_bgcolor.value;
	if (!IsColor(sBgColor)){
		BaseAlert(d_bgcolor,"无效的背景颜色值！");
		return;
	}

	sAlignFieldset = d_alignfieldset.options[d_alignfieldset.selectedIndex].value;
	sAlignLegend = d_alignlegend.options[d_alignlegend.selectedIndex].value;

	if (sAction == "MODI") {
		oControl.align = sAlignFieldset;
		if (oChild) oChild.align = sAlignLegend;
		oControl.style.borderColor = sBorderColor;
		oControl.style.backgroundColor = sBgColor;
	}else{
		dialogArguments.insertHTML("<fieldset align='"+sAlignFieldset+"' style='border-color:"+sBorderColor+";background-color:"+sBgColor+"'><legend align="+sAlignLegend+">标题</legend>内容</fieldset>");
	}

	window.returnValue = null;
	window.close();
</SCRIPT>
</HEAD>

<body onload="InitDocument()">
<table border=0 cellpadding=0 cellspacing=5 id=tabDialogSize><tr><td>


<table border=0 cellpadding=0 cellspacing=0 align=center>
<tr>
	<td>
	<fieldset>
	<legend>对齐方式</legend>
	<table border=0 cellpadding=5 cellspacing=0 width="100%">
	<tr><td>

		<table border=0 cellpadding=0 cellspacing=2 width="100%">
		<tr>
			<td noWrap width="20%">栏目对齐:</td>
			<td noWrap width="29%"><select id=d_alignfieldset size=1 style="width:80px"><option value=''>默认</option><option value='left'>左对齐</option><option value='center'>居中对齐</option><option value='right'>右对齐</option></select></td>
			<td width="2%">&nbsp;</td>
			<td noWrap width="20%">标题对齐:</td>
			<td noWrap width="29%"><select id=d_alignlegend size=1 style="width:80px"><option value=''>默认</option><option value='left'>左对齐</option><option value='center'>居中对齐</option><option value='right'>右对齐</option></select></td>
		</tr>
		</table>

	</td></tr>
	</table>
	</fieldset>
	</td>
</tr>
<tr><td height=5></td></tr>
<tr>
	<td>
	<fieldset>
	<legend>颜色属性</legend>
	<table border=0 cellpadding=5 cellspacing=0 width="100%">
	<tr><td>

		<table border=0 cellpadding=0 cellspacing=2 width="100%">
		<tr>
			<td noWrap width="20%">边框颜色:</td>
			<td noWrap width="29%"><input style="width:62px" type=text id=d_bordercolor size=7 value=""><img border=0 src="../sysimage/rect.gif" width=18 style="cursor:hand" id=s_bordercolor onclick="SelectColor('bordercolor')" align=absmiddle></td>
			<td width="2%">&nbsp;</td>
			<td noWrap width="20%">背景颜色:</td>
			<td noWrap width="29%"><input style="width:62px" type=text id=d_bgcolor size=7 value=""><img border=0 src="../sysimage/rect.gif" width=18 style="cursor:hand" id=s_bgcolor onclick="SelectColor('bgcolor')" align=absmiddle></td>
		</tr>
		</table>

	</td></tr>
	</table>
	</fieldset>
	</td>
</tr>
<tr><td height=5></td></tr>
<tr><td noWrap align=right><input type=submit value='确定' id=Ok>&nbsp;&nbsp;<input type=button value='取消' onclick="window.close();"></td></tr>
</table>


</td></tr></table>
</body>
</html>