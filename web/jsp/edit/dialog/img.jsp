<%@ page contentType="text/html;charset=GBK" %>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=javascript src="dialog.js"></script>
<link href='dialog.css' type='text/css' rel='stylesheet'>

<script language="javascript">

var sAction = "INSERT";
var sTitle = "插入";

var oControl;
var oSeletion;
var sRangeType;

var sFromUrl = "http://";
var sAlt = "";
var sBorder = "0";
var sBorderColor = "";
var sFilter = "";
var sAlign = "";
var sWidth = "";
var sHeight = "";
var sVSpace = "";
var sHSpace = "";

var sSLTUrl = "";
var sCheckFlag = "file";

var bAllowUpload = ((parseFloat(config.AllowImageSize)>0) ? true : false);

oSelection = dialogArguments.eWebEditor.document.selection.createRange();
sRangeType = dialogArguments.eWebEditor.document.selection.type;

if (sRangeType == "Control") {
	if (oSelection.item(0).tagName == "IMG"){
		sAction = "MODI";
		sTitle = "修改";
		sCheckFlag = "url";
		oControl = oSelection.item(0);
		sFromUrl = oControl.getAttribute("src", 2);
		sAlt = oControl.alt;
		sBorder = oControl.border;
		sBorderColor = oControl.style.borderColor;
		sFilter = oControl.style.filter;
		sAlign = oControl.align;
		sWidth = oControl.width;
		sHeight = oControl.height;
		sVSpace = oControl.vspace;
		sHSpace = oControl.hspace;
	}
}


document.write("<title>图片属性(" + sTitle + ")</title>");


function InitDocument(){
	SearchSelectValue(d_filter, sFilter);
	SearchSelectValue(d_align, sAlign.toLowerCase());

	d_fromurl.value = sFromUrl;
	d_alt.value = sAlt;
	d_border.value = sBorder;
	d_bordercolor.value = sBorderColor;
	s_bordercolor.style.backgroundColor = sBorderColor;
	d_width.value = sWidth;
	d_height.value = sHeight;
	d_vspace.value = sVSpace;
	d_hspace.value = sHSpace;

	if (!bAllowUpload){
		RadioClick("url");
	}

	adjustDialog();
}


function RadioClick(what){
	if (what=="url"){
		d_fromurl.disabled=false;
		if (config.AllowBrowse=="1"){
			d_browse.disabled=false;
		}
		d_checkfromurl.checked=true;
		if (bAllowUpload){
			d_checkfromfile.checked=false;
			d_file.myform.uploadfile.disabled=true;
		}
	}else{
		d_checkfromurl.checked=false;
		d_file.myform.uploadfile.disabled=false;
		d_checkfromfile.checked=true;
		d_fromurl.disabled=true;
		if (config.AllowBrowse=="1"){
			d_browse.disabled=true;
		}
	}
}


function UploadLoaded(){
	RadioClick(sCheckFlag);
}


function UploadError(sErrDesc){
	AbleItems();
	RadioClick('file');
	divProcessing.style.display="none";
	try {
		BaseAlert(d_file.myform.uploadfile,sErrDesc);
	}
	catch(e){}
}


function UploadSaved(sPathFileName, sPathFileName_s){
	d_fromurl.value = sPathFileName;
	sSLTUrl = sPathFileName_s;
	ReturnValue();
}


function ReturnValue(){
	sFromUrl = d_fromurl.value;
	sAlt = d_alt.value;
	sBorder = d_border.value;
	sBorderColor = d_bordercolor.value;
	sFilter = d_filter.options[d_filter.selectedIndex].value;
	sAlign = d_align.value;
	sWidth = d_width.value;
	sHeight = d_height.value;
	sVSpace = d_vspace.value;
	sHSpace = d_hspace.value;

	if (sAction == "MODI") {
		if (sSLTUrl){
			oControl.src = sSLTUrl;
		}else{
			oControl.src = sFromUrl;
		}
		oControl.alt = sAlt;
		oControl.border = sBorder;
		oControl.style.borderColor = sBorderColor;
		oControl.style.filter = sFilter;
		oControl.align = sAlign;
		oControl.width = sWidth;
		oControl.height = sHeight;
		oControl.style.width = sWidth;
		oControl.style.height = sHeight;
		oControl.vspace = sVSpace;
		oControl.hspace = sHSpace;
		if (sSLTUrl){
			oSelection.execCommand("CreateLink",false,sFromUrl);
			var oSel = oSelection(0).parentNode;
			oSel.target = "_blank";
		}
	}else{
		var sHTML = '';
		if (sFilter!=""){
			sHTML=sHTML+'filter:'+sFilter+';';
		}
		if (sBorderColor!=""){
			sHTML=sHTML+'border-color:'+sBorderColor+';';
		}
		if (sHTML!=""){
			sHTML=' style="'+sHTML+'"';
		}
		if (sSLTUrl){
			sHTML = '<img id=eWebEditor_TempElement_Img src="'+sSLTUrl+'"'+sHTML;
		}else{
			sHTML = '<img id=eWebEditor_TempElement_Img src="'+sFromUrl+'"'+sHTML;
		}
		if (sBorder!=""){
			sHTML=sHTML+' border="'+sBorder+'"';
		}
		if (sAlt!=""){
			sHTML=sHTML+' alt="'+sAlt+'"';
		}
		if (sAlign!=""){
			sHTML=sHTML+' align="'+sAlign+'"';
		}
		if (sWidth!=""){
			sHTML=sHTML+' width="'+sWidth+'"';
		}
		if (sHeight!=""){
			sHTML=sHTML+' height="'+sHeight+'"';
		}
		if (sVSpace!=""){
			sHTML=sHTML+' vspace="'+sVSpace+'"';
		}
		if (sHSpace!=""){
			sHTML=sHTML+' hspace="'+sHSpace+'"';
		}
		sHTML=sHTML+'>';
		if (sSLTUrl){
			sHTML = '<a id=eWebEditor_TempElement_Img_Href href="'+sFromUrl+'" target="_blank">'+sHTML+'</a>';
		}
		dialogArguments.insertHTML(sHTML);

		var oTempElement = dialogArguments.eWebEditor.document.getElementById("eWebEditor_TempElement_Img");
		if (sSLTUrl){
			oTempElement.src = sSLTUrl;
			var oTempElementHref = dialogArguments.eWebEditor.document.getElementById("eWebEditor_TempElement_Img_Href");
			oTempElementHref.setAttribute("href", sFromUrl);
			oTempElementHref.removeAttribute("id");
		}else{
			oTempElement.src = sFromUrl;
		}
		oTempElement.removeAttribute("id");

	}

	window.returnValue = null;
	window.close();
}


function ok(){
	d_border.value = ToInt(d_border.value);
	d_width.value = ToInt(d_width.value);
	d_height.value = ToInt(d_height.value);
	d_vspace.value = ToInt(d_vspace.value);
	d_hspace.value = ToInt(d_hspace.value);

	if (!IsColor(d_bordercolor.value)){
		BaseAlert(d_bordercolor,"提示：\n\n无效的边框颜色值！");
		return false;
	}
	
	if (d_checkfromurl.checked){
		ReturnValue();
	}else{
		if (!d_file.CheckUploadForm()) return false;
		DisableItems();
		divProcessing.style.display="";
		d_file.myform.submit();
	}
}


function DisableItems(){
	d_checkfromfile.disabled=true;
	d_checkfromurl.disabled=true;
	d_fromurl.disabled=true;
	if (config.AllowBrowse=="1"){
		d_browse.disabled=true;
	}
	d_alt.disabled=true;
	d_border.disabled=true;
	d_bordercolor.disabled=true;
	d_filter.disabled=true;
	d_align.disabled=true;
	d_width.disabled=true;
	d_height.disabled=true;
	d_vspace.disabled=true;
	d_hspace.disabled=true;
	Ok.disabled=true;
}


function AbleItems(){
	d_checkfromfile.disabled=false;
	d_checkfromurl.disabled=false;
	d_fromurl.disabled=false;
	if (config.AllowBrowse=="1"){
		d_browse.disabled=false;
	}
	d_alt.disabled=false;
	d_border.disabled=false;
	d_bordercolor.disabled=false;
	d_filter.disabled=false;
	d_align.disabled=false;
	d_width.disabled=false;
	d_height.disabled=false;
	d_vspace.disabled=false;
	d_hspace.disabled=false;
	Ok.disabled=false;
}

function doPreview(){
	var url;
	if (d_checkfromurl.checked){
		url = d_fromurl.value;
		if(config.BaseHref!=""){
			url = config.BaseHref + url;
		}
	}else{
		url = d_file.document.myform.uploadfile.value;
	}
	
	if (url.lastIndexOf(".")<=0){
		setPreviewError();
		return;
	}


	var b_IE7Local = false;
	if ((bAllowUpload)&&(config.IsIE7)){
		if (d_checkfromfile.checked){
			b_IE7Local = true;
		}
	}

	if (url){
		if (b_IE7Local){
			setPreviewIE7(url);
		}else{
			imgPreview.src = url;
		}
	}else{
		tdPreview.innerHTML = "";
	}

}

function setPreview(){
	var width = imgPreview.width;
	var height = imgPreview.height;
	if (imgPreview.src){
		var boxWidth = tdPreview.offsetWidth;
		var boxHeight = tdPreview.offsetHeight;
		if ((width>boxWidth)||(height>boxHeight)){
			var nw = boxWidth/width;
			var nh = boxHeight/height;
			if (nw>nh){
				height = boxHeight;
				width = width*nh;
			}else{
				width = boxWidth;
				height = height*nw;
			}
		}
		tdPreview.innerHTML = "<img border=0 src='"+imgPreview.src+"' width='"+width+"' height='"+height+"'>";
		tdPreviewSize.innerHTML = imgPreview.width+" * "+imgPreview.height;
	}
}

function setPreviewError(){
	tdPreview.innerHTML = "";
	tdPreviewSize.innerHTML = "";
}

function setPreviewIE7(url){
	var bw = tdPreview.offsetWidth;
	var bh = tdPreview.offsetHeight;

	tdPreview.innerHTML = "<div id=imgPreviewDiv style=\"filter : progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);WIDTH:10px; HEIGHT:10px;\"></div>";
	imgPreviewDiv.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = url;
	var w = imgPreviewDiv.offsetWidth;
	var h = imgPreviewDiv.offsetHeight;
	var sw,sh;

	if ((w>bw)||(h>bh)){
		var nw = bw/w;
		var nh = bh/h;
		if (nw>nh){
			sh = bh;
			sw = w*nh;
		}else{
			sw = bw;
			sh = h*nw;
		}
	}else{
		sw = w;
		sh = h;
	}

	imgPreviewDiv.style.width = sw;
	imgPreviewDiv.style.height = sh;
	imgPreviewDiv.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").sizingMethod = 'scale';	

	tdPreviewSize.innerHTML = w+" * "+h;
}


</script>

<BODY onload="InitDocument()">
<table border=0 cellpadding=0 cellspacing=5 id=tabDialogSize><tr><td>


<table border=0 cellpadding=0 cellspacing=5 align=center>
<tr valign=top><td width="60%">

	<table border=0 cellpadding=0 cellspacing=0 align=center width="100%">
	<tr>
		<td>
		<fieldset>
		<legend>图片来源</legend>
		<table border=0 cellpadding=5 cellspacing=0 width="100%">
		<tr><td>

			<table border=0 cellpadding=0 cellspacing=0 width="300px"><tr><td></td></tr></table>
			<table border=0 cellpadding=0 cellspacing=2 width="100%">
			<script language=javascript>
			if (bAllowUpload){
				document.write("<tr>");
				document.write("<td noWrap width=\"20%\"><input type=radio id=\"d_checkfromfile\" value=\"1\" onclick=\"RadioClick('file')\"><label for=d_checkfromfile>上传</label>:</td>");
				document.write("<td noWrap width=\"80%\">");
				document.write("<iframe id=d_file frameborder=0 src='../" + config.ServerExt + "/upload." + config.ServerExt + "?type=image&style=" + config.StyleName + "&cusdir=" + config.CusDir + "' width='100%' height='22' scrolling=no></iframe>");
				document.write("</td>");
				document.write("</tr>");
			}
			</script>
			<tr>
				<td noWrap width="20%"><input type=radio id="d_checkfromurl" value="1" onclick="RadioClick('url')"><label for=d_checkfromurl>网络</label>:</td>
				<td noWrap width="80%">
				<script language="javascript">
				if (config.AllowBrowse=="1"){
					document.write("<table border=0 cellpadding=0 cellspacing=0 width='100%'><tr><td width='100%'><input type=text id='d_fromurl' style='width:100%' size=20 value='' onpropertychange=\"if (event.propertyName=='value'){doPreview()}\"></td><td><input style='width:63px;height:18px;margin-left:2px;padding-top:0px;' type=button id='d_browse' onclick=\"SelectBrowse('image','fromurl')\" value='浏览...' align=absmiddle></td></tr></table>");
				} else {
					document.write("<input type=text id='d_fromurl' style='width:100%' size=30 value='' onpropertychange=\"if (event.propertyName=='value'){doPreview()}\">");
				}
				</script>
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
		<legend>显示效果</legend>
		<table border=0 cellpadding=5 cellspacing=0 width="100%">
		<tr><td>

			<table border=0 cellpadding=0 cellspacing=2 width="100%">
			<tr>
				<td noWrap width="20%">说明文字:</td>
				<td noWrap width="80%" colspan=4><input type=text id=d_alt size=10 value="" style="width:100%"></td>
			</tr>
			<tr>
				<td noWrap width="20%">边框粗细:</td>
				<td noWrap width="29%"><input style="width:80px" type=text id=d_border size=10 value="" ONKEYPRESS="event.returnValue=IsDigit();"></td>
				<td width="2%">&nbsp;</td>
				<td noWrap width="20%">边框颜色:</td>
				<td noWrap width="29%"><input style="width:62px" type=text id=d_bordercolor size=7 value=""><img border=0 src="../sysimage/rect.gif" width=18 style="cursor:hand" id=s_bordercolor onclick="SelectColor('bordercolor')" align=absmiddle></td>
			</tr>
			<tr>
				<td noWrap width="20%">特殊效果:</td>
				<td noWrap width="29%">
					<select id=d_filter size=1 style="width:80px">
					<option value='' selected>无</option>
					<option value='Alpha(Opacity=50)'>半透明</option>
					<option value='Alpha(Opacity=0, FinishOpacity=100, Style=1, StartX=0, StartY=0, FinishX=100, FinishY=140)'>线型透明</option>
					<option value='Alpha(Opacity=10, FinishOpacity=100, Style=2, StartX=30, StartY=30, FinishX=200, FinishY=200)'>放射透明</option>
					<option value='blur(add=1,direction=14,strength=15)'>模糊效果</option>
					<option value='blur(add=true,direction=45,strength=30)'>风动模糊</option>
					<option value='Wave(Add=0, Freq=60, LightStrength=1, Phase=0, Strength=3)'>正弦波纹</option>
					<option value='gray'>黑白照片</option>
					<option value='Chroma(Color=#FFFFFF)'>白色透明</option>
					<option value='DropShadow(Color=#999999, OffX=7, OffY=4, Positive=1)'>投射阴影</option>
					<option value='Shadow(Color=#999999, Direction=45)'>阴影</option>
					<option value='Glow(Color=#ff9900, Strength=5)'>发光</option>
					<option value='flipv'>垂直翻转</option>
					<option value='fliph'>左右翻转</option>
					<option value='grays'>降低彩色</option>
					<option value='xray'>X光照片</option>
					<option value='invert'>底片</option>
					</select>		
				</td>
				<td width="2%">&nbsp;</td>
				<td noWrap width="20%">对齐方式:</td>
				<td noWrap width="29%">
					<select id=d_align size=1 style="width:80px">
					<option value='' selected>默认</option>
					<option value='left'>左对齐</option>
					<option value='right'>右对齐</option>
					<option value='top'>顶部</option>
					<option value='middle'>中部</option>
					<option value='bottom'>底部</option>
					<option value='absmiddle'>绝对居中</option>
					<option value='absbottom'>绝对底部</option>
					<option value='baseline'>基线</option>
					<option value='texttop'>文本顶部</option>
					</select>
				</td>
			</tr>
			<tr>
				<td noWrap width="20%">图片宽度:</td>
				<td noWrap width="29%"><input style="width:80px" type=text id=d_width size=10 value="" ONKEYPRESS="event.returnValue=IsDigit();" maxlength=4></td>
				<td width="2%">&nbsp;</td>
				<td noWrap width="20%">图片高度:</td>
				<td noWrap width="29%"><input style="width:80px" type=text id=d_height size=10 value="" ONKEYPRESS="event.returnValue=IsDigit();" maxlength=4></td>
			</tr>
			<tr>
				<td noWrap width="20%">上下间距:</td>
				<td noWrap width="29%"><input style="width:80px" type=text id=d_vspace size=10 value="" ONKEYPRESS="event.returnValue=IsDigit();" maxlength=2></td>
				<td width="2%">&nbsp;</td>
				<td noWrap width="20%">左右间距:</td>
				<td noWrap width="29%"><input style="width:80px" type=text id=d_hspace size=10 value="" ONKEYPRESS="event.returnValue=IsDigit();" maxlength=2></td>
			</tr>
			</table>

		</td></tr>
		</table>
		</fieldset>
		</td>
	</tr>
	</table>


</td><td width="40%" height="100%">
	
		<fieldset style="height:100%">
		<legend>预览</legend>
		<table border=0 cellpadding=0 cellspacing=5 width="200" height="200" valign=top>
		<tr><td colspan=2 bgcolor=#FFFFFF align=center valign=middle id=tdPreview height="100%">

		</td></tr>
		<tr><td id=tdPreviewSize></td><td align=right><input type=button id=btnPreivew onclick="doPreview()" value="预览"></td></tr>
		</table>
		</fieldset>

</td></tr>
<tr><td noWrap align=right colspan=2><input type=submit value='确定' id=Ok onclick="ok()">&nbsp;&nbsp;<input type=button value='取消' onclick="window.close();"></td></tr>
</table>


</td></tr></table>


<div id=divProcessing style="width:200px;height:30px;position:absolute;left:70px;top:100px;display:none">
<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%"><tr><td bgcolor=#3A6EA5><marquee align="middle" behavior="alternate" scrollamount="5"><font color=#FFFFFF>...上传中...请等待...</font></marquee></td></tr></table>
</div>
<img id=imgPreview src='' border=0 style="visibility:hidden" onload="setPreview()" onerror="setPreviewError()">

</body>
</html>