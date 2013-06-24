<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=javascript src="dialog.js"></script>
<link href='dialog.css' type='text/css' rel='stylesheet'>

<script language="javascript">

var sAction = URLParams['action'] ;
var sTitle = "插入";

var oControl;
var oSeletion;
var sRangeType;

var sRow = "2";
var sCol = "2";
var sAlign = "";
var sBorder = "1";
var sAlignText = "";
var sBorderCollapse = "collapse";
var sCellPadding = "3";
var sCellSpacing = "2";
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

if (sAction == "modify"){
	if (sRangeType == "Control"){
		if (oSelection.item(0).tagName == "TABLE"){
			oControl = oSelection.item(0);
		}
	}else{
		oControl = getParentObject(oSelection.parentElement(), "TABLE");
	}
	if (oControl){
		sAction = "MODI";
		sTitle = "修改";
		sRow = oControl.rows.length;
		sCol = getColCount(oControl);
		sAlign = oControl.align;
		sBorder = oControl.border;
		sAlignText = oControl.style.textAlign;
		sBorderCollapse = oControl.style.borderCollapse;
		sCellPadding = oControl.cellPadding;
		sCellSpacing = oControl.cellSpacing;
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
}

function getParentObject(obj, tag){
	while(obj!=null && obj.tagName!=tag)
		obj=obj.parentElement;
	return obj;
}

document.write("<title>表格属性(" + sTitle + ")</title>");

function InitDocument(){
	SearchSelectValue(d_align, sAlign.toLowerCase());
	SearchSelectValue(d_aligntext, sAlignText.toLowerCase());
	SearchSelectValue(d_bordercollapse, sBorderCollapse.toLowerCase());
	SearchSelectValue(d_borderstyle, sBorderStyle.toLowerCase());

	if (sAction == "MODI"){
		if (sWidth == ""){
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

	d_row.value = sRow;
	d_col.value = sCol;
	d_border.value = sBorder;
	d_cellspacing.value = sCellSpacing;
	d_cellpadding.value = sCellPadding;
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

function getColCount(oTable) {
	var intCount = 0;
	if (oTable != null) {
		for(var i = 0; i < oTable.rows.length; i++){
			if (oTable.rows[i].cells.length > intCount) intCount = oTable.rows[i].cells.length;
		}
	}
	return intCount;
}

function InsertRows( oTable ) {
	if ( oTable ) {
		var elRow=oTable.insertRow();
		for(var i=0; i<oTable.rows[0].cells.length; i++){
			var elCell = elRow.insertCell();
			elCell.innerHTML = "&nbsp;";
		}
	}
}

function InsertCols( oTable ) {
	if ( oTable ) {
		for(var i=0; i<oTable.rows.length; i++){
			var elCell = oTable.rows[i].insertCell();
			elCell.innerHTML = "&nbsp;"
		}
	}
}

function DeleteRows( oTable ) {
	if ( oTable ) {
		oTable.deleteRow();
	}
}

function DeleteCols( oTable ) {
	if ( oTable ) {
		for(var i=0;i<oTable.rows.length;i++){
			oTable.rows[i].deleteCell();
		}
	}
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
	if (!MoreThanOne(d_row,"无效的行数，至少要1行！")) return;
	if (!MoreThanOne(d_col,"无效的列数，至少要1列！")) return;
	if (d_border.value == "") d_border.value = "0";
	if (d_cellpadding.value == "") d_cellpadding.value = "0";
	if (d_cellspacing.value == "") d_cellspacing.value = "0";
	d_border.value = parseFloat(d_border.value);
	d_cellpadding.value = parseFloat(d_cellpadding.value);
	d_cellspacing.value = parseFloat(d_cellspacing.value);
	// check table width
	var sWidth = "";
	if (d_widthcheck.checked){
		if (!MoreThanOne(d_widthvalue,"无效的表格宽度！")) return;
		sWidth = d_widthvalue.value + d_widthunit.value;
	}
	// check table height
	var sHeight = "";
	if (d_heightcheck.checked){
		if (!MoreThanOne(d_heightvalue,"无效的表格高度！")) return;
		sHeight = d_heightvalue.value + d_heightunit.value;
	}

	sRow = d_row.value;
	sCol = d_col.value;
	sAlign = d_align.options[d_align.selectedIndex].value;
	sBorder = d_border.value;
	sAlignText = d_aligntext.options[d_aligntext.selectedIndex].value;
	sBorderCollapse = d_bordercollapse.options[d_bordercollapse.selectedIndex].value;
	sCellPadding = d_cellpadding.value;
	sCellSpacing = d_cellspacing.value;
	sImage = d_image.value;
	sRepeat = d_repeat.value;
	sAttachment = d_attachment.value;
	sBorderStyle = d_borderstyle.options[d_borderstyle.selectedIndex].value;
	if (sImage!="") {
		sImage = "url(" + sImage + ")";
	}

	if (sAction == "MODI") {
		// modify rows
		var xCount = sRow - oControl.rows.length;
  		if (xCount > 0)
	  		for (var i = 0; i < xCount; i++) InsertRows(oControl);
  		else
	  		for (var i = 0; i > xCount; i--) DeleteRows(oControl);
		// modify cols
  		var xCount = sCol - getColCount(oControl);
  		if (xCount > 0)
  			for (var i = 0; i < xCount; i++) InsertCols(oControl);
  		else
  			for (var i = 0; i > xCount; i--) DeleteCols(oControl);

		try {
			oControl.width = sWidth;
			oControl.style.width = sWidth;
		}
		catch(e) {
			//alert("Invalid Width!\n(Example:90% 200 300px 10cm)");
		}
		try {
			oControl.height = sHeight;
			oControl.style.height = sHeight;
		}
		catch(e) {
			//alert("Invalid Height!\n(Example:90% 200 300px 10cm)");
		}

		oControl.align			= sAlign;
  		oControl.border			= sBorder;
		oControl.style.textAlign = sAlignText;
		oControl.style.borderCollapse = sBorderCollapse;
  		oControl.cellSpacing	= sCellSpacing;
  		oControl.cellPadding	= sCellPadding;
  		oControl.borderColor	= sBorderColor;
  		oControl.bgColor		= sBgColor;
		oControl.style.backgroundImage = sImage;
		oControl.style.backgroundRepeat = sRepeat;
		oControl.style.backgroundAttachment = sAttachment;
		oControl.style.borderStyle = sBorderStyle;

	}else{
		var sTable = "<table align='"+sAlign+"' border='"+sBorder+"' cellpadding='"+sCellPadding+"' cellspacing='"+sCellSpacing+"' width='"+sWidth+"' height='"+sHeight+"' bordercolor='"+sBorderColor+"' bgcolor='"+sBgColor+"' style='background-image:"+sImage+";background-repeat:"+sRepeat+";background-attachment:"+sAttachment+";border-style:"+sBorderStyle+";text-align:"+sAlignText+";border-collapse:"+sBorderCollapse+";'>";
		for (var i=1;i<=sRow;i++){
			sTable = sTable + "<tr>";
			for (var j=1;j<=sCol;j++){
				sTable = sTable + "<td>&nbsp;</td>";
			}
			sTable = sTable + "</tr>";
		}
		sTable = sTable + "</table>";
		dialogArguments.insertHTML(sTable);
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
	<legend>表格大小</legend>
	<table border=0 cellpadding=5 cellspacing=0 width="100%">
	<tr><td>

		<table border=0 cellpadding=0 cellspacing=2 width="100%">
		<tr>
			<td noWrap width="20%">表格行数:</td>
			<td noWrap width="29%"><input style="width:80px" type=text id=d_row size=10 value="" ONKEYPRESS="event.returnValue=IsDigit();" maxlength=3></td>
			<td width="2%">&nbsp;</td>
			<td noWrap width="20%">表格列数:</td>
			<td noWrap width="29%"><input style="width:80px" type=text id=d_col size=10 value="" ONKEYPRESS="event.returnValue=IsDigit();" maxlength=3></td>
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
	<legend>表格布局</legend>
	<table border=0 cellpadding=5 cellspacing=0 width="100%">
	<tr><td>

		<table border=0 cellpadding=0 cellspacing=2 width="100%">
		<tr>
			<td noWrap width="20%">对齐方式:</td>
			<td noWrap width="29%">
				<select id="d_align" style="width:80px">
				<option value=''>默认</option>
				<option value='left'>左对齐</option>
				<option value='center'>居中对齐</option>
				<option value='right'>右对齐</option>
				</select>
			</td>
			<td width="2%">&nbsp;</td>
			<td noWrap width="20%">边框粗细:</td>
			<td noWrap width="29%"><input style="width:80px" type=text id=d_border size=10 value="" ONKEYPRESS="event.returnValue=IsDigit();"></td>
		</tr>
		<tr>
			<td noWrap width="20%">文字对齐:</td>
			<td noWrap width="29%">
				<select id="d_aligntext" style="width:80px">
				<option value=''>默认</option>
				<option value='left'>左对齐</option>
				<option value='center'>居中对齐</option>
				<option value='right'>右对齐</option>
				<option value='justify'>两端对齐</option>
				</select>
			</td>
			<td width="2%">&nbsp;</td>
			<td noWrap width="20%">边框效果:</td>
			<td noWrap width="29%">
				<select id="d_bordercollapse" style="width:80px">
				<option value=''>默认</option>
				<option value='separate'>分开</option>
				<option value='collapse'>合并</option>
				</select>
			</td>
		</tr>
		<tr>
			<td noWrap width="20%">单元间距:</td>
			<td noWrap width="29%"><input style="width:80px" type=text id=d_cellspacing size=10 value="" ONKEYPRESS="event.returnValue=IsDigit();" maxlength=3></td>
			<td width="2%">&nbsp;</td>
			<td noWrap width="20%">单元边距:</td>
			<td noWrap width="29%"><input style="width:80px" type=text id=d_cellpadding size=10 value="" ONKEYPRESS="event.returnValue=IsDigit();" maxlength=3></td>
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
	<legend>表格尺寸</legend>
	<table border=0 cellpadding=5 cellspacing=0 width="100%">
	<tr><td>

		<table border=0 cellpadding=0 cellspacing=2 width="100%">
		<tr>
			<td noWrap><input id="d_widthcheck" type="checkbox" onclick="d_widthvalue.disabled=(!this.checked);d_widthunit.disabled=(!this.checked);" value="1"> <label for=d_widthcheck>指定表格的宽度</label></td>
			<td noWrap align=right>
				<input name="d_widthvalue" type="text" value="" size="5" ONKEYPRESS="event.returnValue=IsDigit();" maxlength="4">
				<select name="d_widthunit" size=1 style="width:65px">
				<option value='px'>像素</option><option value='%'>百分比</option>
				</select>
			</td>
		</tr>
		<tr>
			<td noWrap><input id="d_heightcheck" type="checkbox" onclick="d_heightvalue.disabled=(!this.checked);d_heightunit.disabled=(!this.checked);" value="1"> <label for=d_heightcheck>指定表格的高度</label></td>
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
	<legend>表格样式</legend>
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