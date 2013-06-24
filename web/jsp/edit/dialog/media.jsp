<%@ page contentType="text/html;charset=GBK" %>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=javascript src="dialog.js"></script>
<link href='dialog.css' type='text/css' rel='stylesheet'>
<TITLE>媒体文件属性</TITLE>

<script language="javascript">

var bAllowUpload = ((parseFloat(config.AllowMediaSize)>0) ? true : false);

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
	RadioClick('file');
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

function UploadSaved(sPathFileName){
	d_fromurl.value = sPathFileName;
	ReturnValue();
}

function ReturnValue(){
	var sFromUrl = d_fromurl.value;
	var sWidth = d_width.value;
	var sHeight = d_height.value;

	var sHTML = '<EMBED src="' + sFromUrl + '" width="' + sWidth + '" height="' + sHeight + '" type="audio/x-pn-realaudio-plugin" autostart="true" controls="IMAGEWINDOW,ControlPanel,StatusBar" console="Clip1"></EMBED>';
	dialogArguments.insertHTML(sHTML);

	window.returnValue = null;
	window.close();
}

function ok(){
	d_width.value=ToInt(d_width.value);
	d_height.value=ToInt(d_height.value);

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
	d_width.disabled=true;
	d_height.disabled=true;
	Ok.disabled=true;
}

function AbleItems(){
	d_checkfromfile.disabled=false;
	d_checkfromurl.disabled=false;
	d_fromurl.disabled=false;
	if (config.AllowBrowse=="1"){
		d_browse.disabled=false;
	}
	d_width.disabled=false;
	d_height.disabled=false;
	Ok.disabled=false;
}

function InitDocument(){
	if (!bAllowUpload){
		RadioClick("url");
	}
	
	adjustDialog();
}
</script>
</HEAD>

<BODY onload="InitDocument()">
<table border=0 cellpadding=0 cellspacing=5 id=tabDialogSize><tr><td>


<table border=0 cellpadding=0 cellspacing=0 align=center>
<tr>
	<td>
	<fieldset>
	<legend>媒体文件来源</legend>
	<table border=0 cellpadding=5 cellspacing=0 width="100%">
	<tr><td>

		<table border=0 cellpadding=0 cellspacing=0 width="300px"><tr><td></td></tr></table>
		<table border=0 cellpadding=0 cellspacing=2 width="100%">
			<script language=javascript>
			if (bAllowUpload){
				document.write("<tr>");
				document.write("<td noWrap width=\"20%\"><input type=radio id=\"d_checkfromfile\" value=\"1\" onclick=\"RadioClick('file')\"><label for=d_checkfromfile>上传</label>:</td>");
				document.write("<td noWrap width=\"80%\">");
				document.write("<iframe id=d_file frameborder=0 src='../" + config.ServerExt + "/upload." + config.ServerExt + "?type=media&style=" + config.StyleName + "&cusdir=" + config.CusDir + "' width='100%' height='22' scrolling=no></iframe>");
				document.write("</td>");
				document.write("</tr>");
			}
			</script>
		<tr>
			<td noWrap width="20%"><input type=radio id="d_checkfromurl" value="1" onclick="RadioClick('url')"><label for=d_checkfromurl>网络</label>:</td>
			<td noWrap width="80%">
				<script language="javascript">
				if (config.AllowBrowse=="1"){
					document.write("<table border=0 cellpadding=0 cellspacing=0 width='100%'><tr><td width='100%'><input type=text id='d_fromurl' style='width:100%' size=10 value='http://'></td><td><input style='width:63px;height:18px;margin-left:2px;padding-top:0px;' type=button id='d_browse' onclick=\"SelectBrowse('media','fromurl')\" value='浏览...' align=absmiddle></td></tr></table>");
				} else {
					document.write("<input type=text id='d_fromurl' style='width:100%' size=10 value='http://'>");
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
	<legend>播放效果</legend>
	<table border=0 cellpadding=5 cellspacing=0 width="100%">
	<tr><td>

		<table border=0 cellpadding=0 cellspacing=2 width="100%">
		<tr>
			<td noWrap width="20%">播放宽度:</td>
			<td noWrap width="29%"><input style="width:80px" type=text id=d_width size=10 value="200" ONKEYPRESS="event.returnValue=IsDigit();" maxlength=4></td>
			<td width="2%">&nbsp;</td>
			<td noWrap width="20%">播放高度:</td>
			<td noWrap width="29%"><input style="width:80px" type=text id=d_height size=10 value="200" ONKEYPRESS="event.returnValue=IsDigit();" maxlength=4></td>
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

<div id=divProcessing style="width:200px;height:30px;position:absolute;left:70px;top:50px;display:none">
<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%"><tr><td bgcolor=#3A6EA5><marquee align="middle" behavior="alternate" scrollamount="5"><font color=#FFFFFF>...上传中...请等待...</font></marquee></td></tr></table>
</div>

</body>
</html>
