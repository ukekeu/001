<%@ page contentType="text/html;charset=GBK" %>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=javascript src="dialog.js"></script>
<link href='dialog.css' type='text/css' rel='stylesheet'>
<TITLE>文件属性</TITLE>

<script language="javascript">

var bAllowUpload = ((parseFloat(config.AllowFileSize)>0) ? true : false);


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
	var url = d_fromurl.value;
	var sFilePic = getFilePic(url);
	var sPicSrc = relativePath2setPath("sysimage/icon16/"+sFilePic);
	dialogArguments.insertHTML("<img id=eWebEditor_TempElement_Img border=0 src='"+sPicSrc+"'><a id=eWebEditor_TempElement_Href href='"+url+"' target=_blank>"+d_filename.value+"</a>");

	var oTempElement = dialogArguments.eWebEditor.document.getElementById("eWebEditor_TempElement_Img");
	oTempElement.src = sPicSrc;
	oTempElement.removeAttribute("id");
	
	oTempElement = dialogArguments.eWebEditor.document.getElementById("eWebEditor_TempElement_Href");
	oTempElement.href = url;
	oTempElement.removeAttribute("id");
	
	window.returnValue = null;
	window.close();
}

function ok(){
	if (d_checkfromurl.checked){
		GetFileName(d_fromurl.value, "/");
		ReturnValue();
	}else{
		if (!d_file.CheckUploadForm()) return false;
		GetFileName(d_file.myform.uploadfile.value, "\\");
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
	Ok.disabled=true;
}

function AbleItems(){
	d_checkfromfile.disabled=false;
	d_checkfromurl.disabled=false;
	d_fromurl.disabled=false;
	if (config.AllowBrowse=="1"){
		d_browse.disabled=false;
	}
	Ok.disabled=false;
}

function getFilePic(url){
	var sExt;
	sExt=url.substr(url.lastIndexOf(".")+1);
	sExt=sExt.toUpperCase();
	var sPicName;
	switch(sExt){
	case "TXT":
		sPicName = "txt.gif";
		break;
	case "CHM":
	case "HLP":
		sPicName = "hlp.gif";
		break;
	case "DOC":
		sPicName = "doc.gif";
		break;
	case "PDF":
		sPicName = "pdf.gif";
		break;
	case "MDB":
		sPicName = "mdb.gif";
		break;
	case "GIF":
		sPicName = "gif.gif";
		break;
	case "JPG":
		sPicName = "jpg.gif";
		break;
	case "BMP":
		sPicName = "bmp.gif";
		break;
	case "PNG":
		sPicName = "pic.gif";
		break;
	case "ASP":
	case "JSP":
	case "JS":
	case "PHP":
	case "PHP3":
	case "ASPX":
		sPicName = "code.gif";
		break;
	case "HTM":
	case "HTML":
	case "SHTML":
		sPicName = "htm.gif";
		break;
	case "ZIP":
		sPicName = "zip.gif";
		break;
	case "RAR":
		sPicName = "rar.gif";
		break;
	case "EXE":
		sPicName = "exe.gif";
		break;
	case "AVI":
		sPicName = "avi.gif";
		break;
	case "MPG":
	case "MPEG":
	case "ASF":
		sPicName = "mp.gif";
		break;
	case "RA":
	case "RM":
		sPicName = "rm.gif";
		break;
	case "MP3":
		sPicName = "mp3.gif";
		break;
	case "MID":
	case "MIDI":
		sPicName = "mid.gif";
		break;
	case "WAV":
		sPicName = "audio.gif";
		break;
	case "XLS":
		sPicName = "xls.gif";
		break;
	case "PPT":
	case "PPS":
		sPicName = "ppt.gif";
		break;
	case "SWF":
		sPicName = "swf.gif";
		break;
	default:
		sPicName = "unknow.gif";
		break;
	}
	return sPicName;

}

function GetFileName(url, opt){
	d_filename.value=url.substr(url.lastIndexOf(opt)+1);
}


function InitDocument(){

	if (!bAllowUpload){
		RadioClick("url");
	}

	adjustDialog();
}

</script>


<BODY onload="InitDocument()">
<table border=0 cellpadding=0 cellspacing=5 id=tabDialogSize><tr><td>


<table border=0 cellpadding=0 cellspacing=0 align=center>
<tr>
	<td>
	<fieldset>
	<legend>文件来源</legend>
	<table border=0 cellpadding=5 cellspacing=0 width="100%">
	<tr><td>

		<table border=0 cellpadding=0 cellspacing=0 width="300px"><tr><td></td></tr></table>
		<table border=0 cellpadding=0 cellspacing=2 width="100%">
			<script language=javascript>
			if (bAllowUpload){
				document.write("<tr>");
				document.write("<td noWrap width=\"20%\"><input type=radio id=\"d_checkfromfile\" value=\"1\" onclick=\"RadioClick('file')\"><label for=d_checkfromfile>上传</label>:</td>");
				document.write("<td noWrap width=\"80%\">");
				document.write("<iframe id=d_file frameborder=0 src='../" + config.ServerExt + "/upload." + config.ServerExt + "?type=file&style=" + config.StyleName + "&cusdir=" + config.CusDir + "' width='100%' height='22' scrolling=no></iframe>");
				document.write("</td>");
				document.write("</tr>");
			}
			</script>
		<tr>
			<td noWrap width="20%"><input type=radio id="d_checkfromurl" value="1" onclick="RadioClick('url')"><label for=d_checkfromurl>网络</label>:</td>
			<td noWrap width="80%">
				<script language="javascript">
				if (config.AllowBrowse=="1"){
					document.write("<table border=0 cellpadding=0 cellspacing=0 width='100%'><tr><td width='100%'><input type=text id='d_fromurl' style='width:100%' size=20 value='http://'></td><td><input style='width:63px;height:18px;margin-left:2px;padding-top:0px;' type=button id='d_browse' onclick=\"SelectBrowse('file','fromurl')\"  value='浏览...' align=absmiddle></td></tr></table>");
				} else {
					document.write("<input type=text id='d_fromurl' style='width:100%' size=40 value='http://'>");
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
<tr><td noWrap align=right><input type=submit value='确定' id=Ok onclick="ok()">&nbsp;&nbsp;<input type=button value='取消' onclick="window.close();"></td></tr>
</table>


</td></tr></table>

<div id=divProcessing style="width:200px;height:30px;position:absolute;left:70px;top:30px;display:none">
<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%"><tr><td bgcolor=#3A6EA5><marquee align="middle" behavior="alternate" scrollamount="5"><font color=#FFFFFF>...上传中...请等待...</font></marquee></td></tr></table>
</div>
<input type=hidden id=d_filename value="">
</body>
</html>
