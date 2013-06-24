<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=javascript src="dialog.js"></script>
<link href='dialog.css' type='text/css' rel='stylesheet'>

<script language="javascript">

var sAction = URLParams['action'] ;
var sTitle = "";

var oControl;
var oSeletion;
var sRangeType;

var sAlign = "";
var sVAlign = "";
var sWidth = "";
var sHeight = "";
var sBorderColor = "#000000";
var sBgColor = "#FFFFFF";

var sImage = "";
var sRepeat = "";
var sAttachment = "";
var sBorderStyle = "";

var sWidthUnit = "%";
var bWidthCheck = true;
var bWidthDisable = false;
var sWidthValue = "100";

var sHeightUnit = "%";
var bHeightCheck = false;
var bHeightDisable = true;
var sHeightValue = "";

oSelection = dialogArguments.eWebEditor.document.selection.createRange();
sRangeType = dialogArguments.eWebEditor.document.selection.type;

if (sAction == "row"){
	oControl = getParentObject(oSelection.parentElement(), "TR");
	sAction = "ROW";
	sTitle = "表格行";
}else{
	oControl = getParentObject(oSelection.parentElement(), "TD");
	sAction = "CELL";
	sTitle = "单元格";
}
if (oControl){
	sAlign = oControl.align;
	sVAlign = oControl.vAlign;
	sWidth = oControl.width;
	sHeight = oControl.height;
	sBorderColor = oControl.borderColor;
	sBgColor = oControl.bgColor;
	sImage = oControl.style.backgroundImage;
	sRepeat = oControl.style.backgroundRepeat;
	sAttachment = oControl.style.backgroundAttachment;
	sBorderStyle = oControl.style.borderStyle;
	sImage = sImage.substr(4, sImage.length-5);
}

function getParentObject(obj, tag){
	if (tag == "TD"){
		while(obj!=null && obj.tagName!=tag && obj.tagName!="TH"){
			obj=obj.parentElement;
		}
	}else{
		while(obj!=null && obj.tagName!=tag){
			obj=obj.parentElement;
		}
	}
	return obj;
}

document.write("<title>" + sTitle + "</title>");

function InitDocument(){
	SearchSelectValue(d_align, sAlign.toLowerCase());
	SearchSelectValue(d_valign, sVAlign.toLowerCase());
	SearchSelectValue(d_borderstyle, sBorderStyle.toLowerCase());

	if ((sWidth == "")||(sWidth==undefined)){
		bWidthCheck = false;
		bWidthDisable = true;
		sWidthValue = "100";
		sWidthUnit = "%";
	}else{
		bWidthCheck = true;
		bWidthDisable = false;
		if (sWidth.substr(sWidth.length-1) == "%"){
			sWidthValue = sWidth.substring(0, sWidth.length-1);
			sWidthUnit = "%";
		}else{
			sWidthUnit = "";
			sWidthValue = parseInt(sWidth);
			if (isNaN(sWidthValue)) sWidthValue = "";
		}
	}
	if (sHeight == ""){
		bHeightCheck = false;
		bHeightDisable = true;
		sHeightValue = "100";
		sHeightUnit = "%";
	}else{
		bHeightCheck = true;
		bHeightDisable = false;
		if (sHeight.substr(sHeight.length-1) == "%"){
			sHeightValue = sHeight.substring(0, sHeight.length-1);
			sHeightUnit = "%";
		}else{
			sHeightUnit = "";
			sHeightValue = parseInt(sHeight);
			if (isNaN(sHeightValue)) sHeightValue = "";
		}
	}

	switch(sWidthUnit){
	case "%":
		d_widthunit.selectedIndex = 1;
		break;
	default:
		sWidthUnit = "";
		d_widthunit.selectedIndex = 0;
		break;
	}
	switch(sHeightUnit){
	case "%":
		d_heightunit.selectedIndex = 1;
		break;
	default:
		sHeightUnit = "";
		d_heightunit.selectedIndex = 0;
		break;
	}

	d_widthvalue.value = sWidthValue;
	d_widthvalue.disabled = bWidthDisable;
	d_widthunit.disabled = bWidthDisable;
	d_heightvalue.value = sHeightValue;
	d_heightvalue.disabled = bHeightDisable;
	d_heightunit.disabled = bHeightDisable;
	d_bordercolor.value = sBorderColor;
	s_bordercolor.style.backgroundColor = sBorderColor;
	d_bgcolor.value = sBgColor;
	s_bgcolor.style.backgroundColor = sBgColor;
	d_widthcheck.checked = bWidthCheck;
	d_heightcheck.checked = bHeightCheck;
	d_image.value = sImage;
	d_repeat.value = sRepeat;
	d_attachment.value = sAttachment;

	adjustDialog();
}

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

function ok(){
	sBorderColor = d_bordercolor.value;
	if (!IsColor(sBorderColor)){
		BaseAlert(d_bordercolor,"无效的边框颜色值！");
		return;
	}
	sBgColor = d_bgcolor.value;
	if (!IsColor(sBgColor)){
		BaseAlert(d_bgcolor,"无效的背景颜色值！");
		return;
	}

	var sWidth = "";
	if (d_widthcheck.checked){
		if (!MoreThanOne(d_widthvalue,"无效的宽度！")) return;
		sWidth = d_widthvalue.value + d_widthunit.value;
	}
	var sHeight = "";
	if (d_heightcheck.checked){
		if (!MoreThanOne(d_heightvalue,"无效的高度！")) return;
		sHeight = d_heightvalue.value + d_heightunit.value;
	}

	sAlign = d_align.options[d_align.selectedIndex].value;
	sVAlign = d_valign.options[d_valign.selectedIndex].value;
	sImage = d_image.value;
	sRepeat = d_repeat.value;
	sAttachment = d_attachment.value;
	sBorderStyle = d_borderstyle.options[d_borderstyle.selectedIndex].value;
	if (sImage!="") {
		sImage = "url(" + sImage + ")";
	}

	if (oControl) {
		try {
			oControl.width = sWidth;
		}
		catch(e) {
			//alert("Invalid Width!\n(Example:90% 200 300px 10cm)");
		}
		try {
			oControl.height = sHeight;
		}
		catch(e) {
			//alert("Invalid Height!\n(Example:90% 200 300px 10cm)");
		}

		oControl.align			= sAlign;
		oControl.vAlign			= sVAlign;
  		oControl.borderColor	= sBorderColor;
  		oControl.bgColor		= sBgColor;
		oControl.style.backgroundImage = sImage;
		oControl.style.backgroundRepeat = sRepeat;
		oControl.style.backgroundAttachment = sAttachment;
		oControl.style.borderStyle = sBorderStyle;
	}

	window.returnValue = null;
	window.close();
}

</script>

</head>
<body onload="InitDocument()">
<table border=0 cellpadding=0 cellspacing=5 id=tabDialogSize><tr><td>


<table border=0 cellpadding=0 cellspacing=0 align=center>
<tr>
	<td>
	<fieldset>
	<legend>布局</legend>
	<table border=0 cellpadding=5 cellspacing=0 width="100%">
	<tr><td>

		<table border=0 cellpadding=0 cellspacing=2 width="100%">
		<tr>
			<td noWrap width="20%">水平对齐:</td>
			<td noWrap width="29%">
				<select id="d_align" style="width:80px">
				<option value=''>默认</option>
				<option value='left'>左对齐</option>
				<option value='right'>右对齐</option>
				<option value='center'>居中对齐</option>
				</select>
			</td>
			<td width="2%">&nbsp;</td>
			<td noWrap width="20%">垂直对齐:</td>
			<td noWrap width="29%">
				<select id="d_valign" style="width:80px">
				<option value=''>默认</option>
				<option value='top'>顶部</option>
				<option value='middle'>中部</option>
				<option value='baseline'>基线</option>
				<option value='bottom'>底部</option>
				</select>
			</td>
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
	<legend>尺寸</legend>
	<table border=0 cellpadding=5 cellspacing=0 width="100%">
	<tr><td>

		<table border=0 cellpadding=0 cellspacing=2 width="100%">
		<tr>
			<td noWrap><input id="d_widthcheck" type="checkbox" onclick="d_widthvalue.disabled=(!this.checked);d_widthunit.disabled=(!this.checked);" value="1"> <label for=d_widthcheck>指定宽度</label></td>
			<td noWrap align=right>
				<input name="d_widthvalue" type="text" value="" size="5" ONKEYPRESS="event.returnValue=IsDigit();" maxlength="4">
				<select name="d_widthunit" size=1 style="width:65px">
				<option value='px'>像素</option><option value='%'>百分比</option>
				</select>
			</td>
		</tr>
		<tr>
			<td noWrap><input id="d_heightcheck" type="checkbox" onclick="d_heightvalue.disabled=(!this.checked);d_heightunit.disabled=(!this.checked);" value="1"> <label for=d_heightcheck>指定高度</label></td>
			<td noWrap align=right>
				<input name="d_heightvalue" type="text" value="" size="5" ONKEYPRESS="event.returnValue=IsDigit();" maxlength="4">
				<select name="d_heightunit" size=1 style="width:65px">
				<option value='px'>像素</option><option value='%'>百分比</option>
				</select>
			</td>
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
	<legend>样式</legend>
	<table border=0 cellpadding=5 cellspacing=0 width="100%">
	<tr><td>

		<table border=0 cellpadding=0 cellspacing=2 width="100%">
		<tr>
			<td noWrap width="20%">边框颜色:</td>
			<td noWrap width="29%"><input style="width:62px" type=text id=d_bordercolor size=7 value=""><img border=0 src="../sysimage/rect.gif" width=18 style="cursor:hand" id=s_bordercolor onclick="SelectColor('bordercolor')" align=absmiddle></td>
			<td width="2%">&nbsp;</td>
			<td noWrap width="20%">边框样式:</td>
			<td noWrap width="29%">
				<select id=d_borderstyle size=1 style="width:80px">
				<option value="">默认</option>
				<option value="solid">实线</option>
				<option value="dotted">虚线</option>
				<option value="dashed">破折号</option>
				<option value="double">双线</option>
				<option value="groove">凹线</option>
				<option value="ridge">凸线</option>
				<option value="inset">嵌入</option>
				<option value="outset">开端</option>
				</select>
			</td>
		</tr>
		<tr>
			<td noWrap width="20%">背景颜色:</td>
			<td noWrap width="29%"><input style="width:62px" type=text id=d_bgcolor size=7 value=""><img border=0 src="../sysimage/rect.gif" width=18 style="cursor:hand" id=s_bgcolor onclick="SelectColor('bgcolor')" align=absmiddle></td>
			<td width="2%">&nbsp;</td>
			<td noWrap width="20%">背景图片:</td>
			<td noWrap width="29%"><input style="width:62px" type=text id=d_image size=7 value=""><input type=hidden id=d_repeat><input type=hidden id=d_attachment><img border=0 src="../sysimage/rectimg.gif" width=18 style="cursor:hand" id=s_bgimage onclick="SelectImage()" align=absmiddle></td>
		</tr>
		</table>

	</td></tr>
	</table>
	</fieldset>
	</td>
</tr>
<tr><td height=5></td></tr>
<tr><td noWrap align=right><input type=submit value='确定' id=Ok onclick="ok()">&nbsp;&nbsp;<input type=button value='取消' onclick="window.close();"></td></tr>
</table>


</td></tr></table>
</body>
</html>