
<%@ page contentType="text/html;charset=GBK" %>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=javascript src="dialog.js"></script>
<link href='dialog.css' type='text/css' rel='stylesheet'>
<TITLE>导入Excel电子表格</TITLE>

<script language="javascript">

var bInstalled = true;

function ok(){
	if (!bInstalled){
		alert("您还未安装eWebEditor客户端插件, 请先安装再使用此功能！");
		return;
	}

	if (d_sheet.length<=0){
		alert("无效的Excel文件，请选择！");
		return;
	}
	
	var n_Index = d_sheet.options[d_sheet.selectedIndex].value;
	var s_File = d_file.value;
	var s_PostUrl = getSitePath() + getWebEditorRootPath() + "/" + config.ServerExt + "/upload." + config.ServerExt + "?action=local&type=local&style=" + config.StyleName + "&cusdir=" + config.CusDir;
	var b_VML = d_vmlyes.checked;
	var b_OverFlow = d_overflowyes.checked;
	var b_AddBorder = d_addborderyes.checked;

	divProcessing.style.display="";
	eWebEditorClient.ImportExcelSheet(s_File, n_Index, s_PostUrl, b_VML, b_OverFlow, b_AddBorder);
	divProcessing.style.display="none";

	var s_Error = eWebEditorClient.Error;
	if (s_Error!=""){
		var s_ErrorCode = s_Error.substring(0,s_Error.indexOf(":"));
		switch(s_ErrorCode){
		case "InvalidFile":
			alert("无效的Excel文件，请选择！");
			break;
		default:
			alert(s_Error);
		}
		return;
	}

	var s_StyleVML = "\n"
			+"<STYLE id=eWebEditor_Style_VML>\n"
			+"v\\:* {behavior: url(#default#VML);}\n"
			+"o\\:* {behavior: url(#default#VML);}\n"
			+"w\\:* {behavior: url(#default#VML);}\n"
			+"x\\:* {behavior: url(#default#VML);}\n"
			+".shape{behavior: url(#default#VML);}\n"
			+"</STYLE>\n";

	var s_Style = eWebEditorClient.Style;
	if (b_VML){
		s_Style = s_StyleVML + s_Style;
	}
	var s_Body = eWebEditorClient.Body;

	var s_OriginalFiles = eWebEditorClient.OriginalFiles;
	var s_SavedFiles = eWebEditorClient.SavedFiles;
	if (s_OriginalFiles){
		var a_Original = s_OriginalFiles.split("|");
		var a_Saved = s_SavedFiles.split("|");
		for (var i=0; i<a_Original.length; i++){
			if (a_Saved[i]){
				var s_OriginalFileName = a_Original[i];
				var s_SaveFileName = a_Saved[i].substr(a_Saved[i].lastIndexOf("/")+1);
				var s_SavePathFileName = a_Saved[i];
				dialogArguments.addUploadFile(s_OriginalFileName, s_SaveFileName, s_SavePathFileName);
			}
		}
	}
	
	dialogArguments.setHTML(s_Style + s_Body, true);
	

	window.returnValue = null;
	window.close();
}

var s_LastFile = "";
function DoGetExcelSheet(){
	if (!bInstalled){return;}

	var s_File = BaseTrim(d_file.value);
	if ((s_LastFile!=s_File)){
		d_sheet.options.length = 0;
		s_LastFile="";
	}
	if (s_File=="") {return;}
	if (s_File.indexOf(":")<0){return;}
	if ((s_LastFile!="")&&(s_LastFile==s_File)) {return;}
	
	var n=s_File.lastIndexOf(".");
	if (n<0){return;}

	var s_Ext = s_File.substr(n+1);
	if (s_Ext.toLowerCase()!="xls"){return;}

	var s_Sheets = eWebEditorClient.GetExcelWorkSheetName(s_File);
	var s_Error = eWebEditorClient.Error;
	if (s_Error!=""){
		var s_ErrorCode = s_Error.substring(0, s_Error.indexOf(":"));
		if (s_ErrorCode!="InvalidFile"){
			alert(s_Error);
			return;
		}
	}
	
	var a_Sheets = s_Sheets.split("\n");
	for (var i=0; i<a_Sheets.length; i++){
		d_sheet.options[d_sheet.options.length] = new Option(a_Sheets[i], i+1);
	}
	s_LastFile = s_File;
	
}

function RadioClickVML(s_Flag){
	if (s_Flag=="1"){
		d_vmlyes.checked=true;
		d_vmlno.checked=false;
	}else{
		d_vmlyes.checked=false;
		d_vmlno.checked=true;
	}
}

function RadioClickOverFlow(s_Flag){
	if (s_Flag=="1"){
		d_overflowyes.checked=true;
		d_overflowno.checked=false;
	}else{
		d_overflowyes.checked=false;
		d_overflowno.checked=true;
	}
}

function RadioClickAddBorder(s_Flag){
	if (s_Flag=="1"){
		d_addborderyes.checked=true;
		d_addborderno.checked=false;
	}else{
		d_addborderyes.checked=false;
		d_addborderno.checked=true;
	}
}

function InitDocument(){
	try{
		if(eWebEditorClient.Test()!="eWebEditor"){
			bInstalled = false;
		}
	}catch(e){
		bInstalled = false;
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
	<legend>Excel选项:</legend>
	<table border=0 cellpadding=5 cellspacing=0 width="100%">
	<tr><td>

		<table border=0 cellpadding=0 cellspacing=2 width="100%">
		<tr>
			<td noWrap>文　件:</td>
			<td noWrap><input type=file id="d_file" size=30 onchange="DoGetExcelSheet()" onkeyup="DoGetExcelSheet()"></td>
		</tr>
		<tr>
			<td noWrap>工作表:</td>
			<td noWrap><select id="d_sheet" size=1 style="width:100%"></select></td>
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
	<legend>导入选项:</legend>
	<table border=0 cellpadding=5 cellspacing=0 width="100%">
	<tr><td>

		<table border=0 cellpadding=0 cellspacing=2 width="100%">
		<tr>
			<td noWrap width="20%">保留VML:</td>
			<td noWrap width="29%"><input type=radio id=d_vmlyes onclick="RadioClickVML('1')"><label for=d_vmlyes>是</label> <input type=radio id=d_vmlno onclick="RadioClickVML('0')" checked><label for=d_vmlno>否</label></td>
			<td noWrap width="20%">自动滚动:</td>
			<td noWrap width="29%"><input type=radio id=d_overflowyes onclick="RadioClickOverFlow('1')"><label for=d_overflowyes>是</label> <input type=radio id=d_overflowno onclick="RadioClickOverFlow('0')" checked><label for=d_overflowno>否</label></td>
		</tr>
		<tr>
			<td noWrap width="20%">表格边框:</td>
			<td noWrap width="29%"><input type=radio id=d_addborderyes onclick="RadioClickAddBorder('1')"><label for=d_addborderyes>是</label> <input type=radio id=d_addborderno onclick="RadioClickAddBorder('0')" checked><label for=d_addborderno>否</label></td>
			<td noWrap width="20%">&nbsp;</td>
			<td noWrap width="29%">&nbsp;</td>
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

<div id=divProcessing style="width:200px;height:30px;position:absolute;left:60px;top:85px;display:none">
<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%"><tr><td bgcolor=#3A6EA5 align=center><marquee align="middle" behavior="alternate" scrollamount="5"><font color=#FFFFFF>...Excel导入中...请等待...</font></marquee></td></tr></table>
</div>

<OBJECT ID="eWebEditorClient" CLASSID="CLSID:D39A5EBE-F907-4EC2-BCDF-A72F58DA01F4" width=0 height=0 CODEBASE="eWebEditorClient.CAB#version=1,2,0,3"></OBJECT>

</body>
</html>
