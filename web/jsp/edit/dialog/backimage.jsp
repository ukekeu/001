<%@ page contentType="text/html;charset=GBK" %>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=javascript src="dialog.js"></script>
<link href='dialog.css' type='text/css' rel='stylesheet'>

<script language="javascript">

var sAction = "";
var sTitle = "";

var oControl;
var oSeletion;
var sRangeType;

var sImage = "";
var sRepeat = "";
var sAttachment = "";

var sCheckFlag = "sys";

var bAllowUpload = ((parseFloat(config.AllowImageSize)>0) ? true : false);

if (URLParams['action'] == "other"){
	sAction = "OTHER"
	sTitle = "����"
	sImage = dialogArguments.d_image.value;
	sRepeat = dialogArguments.d_repeat.value;
	sAttachment = dialogArguments.d_attachment.value;
	sCheckFlag = "url";
}else{
	
	sAction = "INSERT";
	sTitle = "��ҳ";

	oSelection = dialogArguments.eWebEditor.document.selection.createRange();
	sRangeType = dialogArguments.eWebEditor.document.selection.type;

	if (sRangeType == "Control") {
		oControl = GetControl(oSelection, "TABLE");
	}else{
		oControl = GetImageParent(oSelection.parentElement());
	}
	if (oControl) {
		switch(oControl.tagName){
		case "TD":
			sTitle = "��Ԫ��";
			break;
		case "TR":
		case "TH":
			sTitle = "������";
			break;
		default:
			sTitle = "����";
			break;
		}
		sAction = "MODI";
		sImage = oControl.style.backgroundImage;
		sRepeat = oControl.style.backgroundRepeat;
		sAttachment = oControl.style.backgroundAttachment;
		sCheckFlag = "url";
		sImage = sImage.substr(4, sImage.length-5)
	}

}
document.write("<title>����ͼ����(" + sTitle + ")</title>");

function InitDocument(){
	SearchSelectValue(d_repeat, sRepeat.toLowerCase());
	SearchSelectValue(d_attachment, sAttachment.toLowerCase());
	d_fromurl.value = sImage;

	if (!bAllowUpload){
		RadioClick(sCheckFlag);
	}

	adjustDialog();
}

function GetImageParent(obj){
	while(obj!=null && obj.tagName!="TD" && obj.tagName!="TR" && obj.tagName!="TH" && obj.tagName!="TABLE")
		obj=obj.parentElement;
	return obj;
}

function GetControl(obj, sTag){
	obj=obj.item(0);
	if (obj.tagName==sTag){
		return obj;
	}
	return null;
}

function RadioClick(what){
	switch(what){
	case "url":
		d_checkfromurl.checked=true;
		d_checkfromsys.checked=false;
		d_checkcancel.checked=false;
		d_fromurl.disabled=false;
		if (config.AllowBrowse=="1"){
			d_browse.disabled=false;
		}
		d_fromsys.disabled=true;
		if (bAllowUpload){
			d_checkfromfile.checked=false;
			d_file.myform.uploadfile.disabled=true;
		}
		break;
	case "file":
		d_checkfromurl.checked=false;
		d_checkfromsys.checked=false;
		d_checkcancel.checked=false;
		d_fromurl.disabled=true;
		if (config.AllowBrowse=="1"){
			d_browse.disabled=true;
		}
		d_fromsys.disabled=true;
		if (bAllowUpload){
			d_checkfromfile.checked=true;
			d_file.myform.uploadfile.disabled=false;
		}
		break;
	case "sys":
		d_checkfromurl.checked=false;
		d_checkfromsys.checked=true;
		d_checkcancel.checked=false;
		d_fromurl.disabled=true;
		if (config.AllowBrowse=="1"){
			d_browse.disabled=true;
		}
		d_fromsys.disabled=false;
		if (bAllowUpload){
			d_checkfromfile.checked=false;
			d_file.myform.uploadfile.disabled=true;
		}
		break;
	case "cancel":
		d_checkfromurl.checked=false;
		d_checkfromsys.checked=false;
		d_checkcancel.checked=true;
		d_fromurl.disabled=true;
		if (config.AllowBrowse=="1"){
			d_browse.disabled=true;
		}
		d_fromsys.disabled=true;
		if (bAllowUpload){
			d_checkfromfile.checked=false;
			d_file.myform.uploadfile.disabled=true;
		}
		break;
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
		BaseAlert(d_file.myform.uploadfile,eval(sErrDesc));
	}
	catch(e){}
}

function UploadSaved(sPathFileName){
	d_fromurl.value = sPathFileName;
	ReturnValue();
}

function ReturnValue(){
	if (d_fromurl.value==""){
		sImage = "";
		sRepeat = "";
		sAttachment = "";
	}else{
		if (sAction == "OTHER"){
			sImage = d_fromurl.value;
		}else{
			sImage = "url(" + d_fromurl.value + ")";
		}
		sRepeat = d_repeat.options[d_repeat.selectedIndex].value;
		sAttachment = d_attachment.options[d_attachment.selectedIndex].value;
	}

	switch(sAction){
	case "MODI":
		oControl.style.backgroundImage = sImage;
		oControl.style.backgroundRepeat = sRepeat;
		oControl.style.backgroundAttachment = sAttachment;
		break;
	case "OTHER":
		dialogArguments.d_image.value = sImage;
		dialogArguments.d_repeat.value = sRepeat;
		dialogArguments.d_attachment.value = sAttachment;
		break;
	default:
		dialogArguments.setHTML("<table border=0 cellpadding=0 cellspacing=0 width='100%' height='100%'><tr><td valign=top id='eWebEditor_TempElement_Background'>"+dialogArguments.getHTML()+"</td></tr></table>", true);
		var oTempElement = dialogArguments.eWebEditor.document.getElementById("eWebEditor_TempElement_Background");
		oTempElement.style.backgroundImage = sImage;
		oTempElement.style.backgroundRepeat = sRepeat;
		oTempElement.style.backgroundAttachment = sAttachment;
		oTempElement.removeAttribute("id");
		break;
	}

	window.returnValue = null;
	window.close();
}

function ok(){
	if (d_checkfromurl.checked){
		ReturnValue();
	}
	if (bAllowUpload){
		if (d_checkfromfile.checked){
			if (!d_file.CheckUploadForm()) return false;
			DisableItems();
			divProcessing.style.display="";
			d_file.myform.submit();
		}
	}
	if (d_checkfromsys.checked){
		d_fromurl.value = relativePath2setPath("sysimage/bg/" + d_fromsys.options[d_fromsys.selectedIndex].value);
		ReturnValue();
	}
	if (d_checkcancel.checked){
		d_fromurl.value="";
		ReturnValue();
	}
}

function DisableItems(){
	d_checkfromfile.disabled=true;
	d_checkfromurl.disabled=true;
	if (config.AllowBrowse=="1"){
		d_browse.disabled=true;
	}
	d_checkfromsys.disabled=true;
	d_checkcancel.disabled=true;
	d_fromurl.disabled=true;
	d_fromsys.disabled=true;
	d_repeat.disabled=true;
	d_attachment.disabled=true;
	Ok.disabled=true;
}

function AbleItems(){
	d_checkfromfile.disabled=false;
	d_checkfromurl.disabled=false;
	if (config.AllowBrowse=="1"){
		d_browse.disabled=false;
	}
	d_checkfromsys.disabled=false;
	d_checkcancel.disabled=false;
	d_fromurl.disabled=false;
	d_fromsys.disabled=false;
	d_repeat.disabled=false;
	d_attachment.disabled=false;
	Ok.disabled=false;
}

</script>
</HEAD>

<BODY onload="InitDocument()">
<table border=0 cellpadding=0 cellspacing=5 id=tabDialogSize><tr><td>

<table border=0 cellpadding=0 cellspacing=0 align=center>
<tr>
	<td>
	<fieldset>
	<legend>ͼƬ��Դ</legend>
	<table border=0 cellpadding=5 cellspacing=0 width="100%">
	<tr><td>

		<table border=0 cellpadding=0 cellspacing=0 width="300px"><tr><td></td></tr></table>
		<table border=0 cellpadding=0 cellspacing=2 width="100%">
			<script language=javascript>
			if (bAllowUpload){
				document.write("<tr>");
				document.write("<td noWrap width=\"20%\"><input type=radio id=\"d_checkfromfile\" value=\"1\" onclick=\"RadioClick('file')\"><label for=d_checkfromfile>�ϴ�</label>:</td>");
				document.write("<td noWrap width=\"80%\" colspan=2>");
				document.write("<iframe id=d_file frameborder=0 src='../" + config.ServerExt + "/upload." + config.ServerExt + "?type=image&style=" + config.StyleName + "&cusdir=" + config.CusDir + "' width='100%' height='22' scrolling=no></iframe>");
				document.write("</td>");
				document.write("</tr>");
			}
			</script>
		<tr>
			<td width="20%" noWrap><input type=radio id="d_checkfromurl" onclick="RadioClick('url')"><label for=d_checkfromurl>����</label>:</td>
			<td width="80%" noWrap colspan=2>
				<script language="javascript">
				if (config.AllowBrowse=="1"){
					document.write("<table border=0 cellpadding=0 cellspacing=0 width='100%'><tr><td width='100%'><input type=text id='d_fromurl' style='width:100%' size=30 value=''></td><td><input style='width:63px;height:18px;margin-left:2px;padding-top:0px;' type=button id='d_browse' onclick=\"SelectBrowse('image','fromurl')\" value='���...' align=absmiddle></td></tr></table>");
				} else {
					document.write("<input type=text id='d_fromurl' style='width:100%' size=30 value=''>");
				}
				</script>			
			
			</td>
		</tr>
		<tr>
			<td width="20%" noWrap><input type=radio id="d_checkfromsys" onclick="RadioClick('sys')"><label for=d_checkfromsys>ϵͳ</label>:</td>
			<td noWrap>
				<select id="d_fromsys" size=1 style="width:80px">
				<option value="snow.gif" selected>ѩ��</option>
				<option value="nature.jpg">��Ȼ</option>
				<option value="clear.jpg">����</option>
				<option value="glacier.jpg">����</option>
				<option value="fiesta.jpg">����</option>
				<option value="birthday.gif">����</option>
				<option value="citrus.gif">��Ҷ</option>
				<option value="hearts.gif">����</option>
				<option value="flower.gif">�ʻ�</option>
				<option value="gathering.jpg">����</option>
				<option value="christmas.gif">ʥ����</option>
				<option value="ivy.gif">������</option>
				<option value="tech.gif">������</option>
				<option value="maize.jpg">��ɫ����</option>
				<option value="grid.gif">��ɫ����</option>
				</select>
			</td>
			<td noWrap><input type=radio id="d_checkcancel" onclick="RadioClick('cancel')"><label for=d_checkcancel>ȡ������ͼ</label> </td>
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
	<legend>��ʾЧ��</legend>
	<table border=0 cellpadding=5 cellspacing=0 width="100%">
	<tr><td>

		<table border=0 cellpadding=0 cellspacing=2 width="100%">
		<tr>
			<td width="20%" noWrap>ƽ�̷�ʽ:</td>
			<td width="29%" noWrap>
				<select id=d_repeat size=1 style="width:80px">
				<option value=''selected>Ĭ��</option>
				<option value='repeat'>�������</option>
				<option value='no-repeat'>��ƽ��</option>
				<option value='repeat-x'>����</option>
				<option value='repeat-y'>����</option>
				</select>
			</td>
			<td width="2%">&nbsp;</td>
			<td width="20%" noWrap>�����̶�:</td>
			<td width="29%" noWrap>
				<select id=d_attachment size=1 style="width:80px">
				<option value='' selected>Ĭ��</option>
				<option value='scroll'>����</option>
				<option value='fixed'>�̶�</option>
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
<tr><td noWrap align=right><input type=submit value='ȷ��' id=Ok onclick="ok()">&nbsp;&nbsp;<input type=button value='ȡ��' onclick="window.close();"></td></tr>
</table>


</td></tr></table>

<div id=divProcessing style="width:200px;height:30px;position:absolute;left:70px;top:45px;display:none">
<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%"><tr><td bgcolor=#3A6EA5><marquee align="middle" behavior="alternate" scrollamount="5"><font color=#FFFFFF>...�ϴ���...��ȴ�...</font></marquee></td></tr></table>
</div>

</body>
</html>