<%@ page contentType="text/html;charset=GBK" %>
<HTML>
<HEAD>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<script language="javascript" src="dialog.js"></script>
<link href='dialog.css' type='text/css' rel='stylesheet'>
<TITLE>�������ͼ��</TITLE>

<script language=javascript>

function emotclick(){
	if ("IMG"==event.srcElement.tagName.toUpperCase()) {
		var url = relativePath2setPath(event.srcElement.getAttribute("src", 2).substr(3));
		dialogArguments.insertHTML("<IMG id=eWebEditor_TempElement_Img SRC=" + url + ">");

		var oTempElement = dialogArguments.eWebEditor.document.getElementById("eWebEditor_TempElement_Img");
		oTempElement.src = url;
		oTempElement.removeAttribute("id");

		window.returnValue = null;
		window.close();
	}
}
document.onclick=emotclick;

function InitDocument(){
	adjustDialog();
}
</script>
</HEAD>

<BODY onload="InitDocument()">
<table border=0 cellpadding=0 cellspacing=5 id=tabDialogSize><tr><td>


<TABLE cellSpacing=5 border=0 align=center bgcolor=#FFFFFF>
  <TBODY>
  <TR>
    <TD><IMG src="../sysimage/emot/01.gif"></TD>
	<TD><IMG src="../sysimage/emot/02.gif"></TD>
	<TD><IMG src="../sysimage/emot/03.gif"></TD>
	<TD><IMG src="../sysimage/emot/04.gif"></TD>
	<TD><IMG src="../sysimage/emot/05.gif"></TD>
	<TD><IMG src="../sysimage/emot/06.gif"></TD>
	<TD><IMG src="../sysimage/emot/07.gif"></TD>
	<TD><IMG src="../sysimage/emot/08.gif"></TD>
	<TD><IMG src="../sysimage/emot/09.gif"></TD>
	<TD><IMG src="../sysimage/emot/10.gif"></TD></TR>
  <TR>
    <TD><IMG src="../sysimage/emot/11.gif"></TD>
	<TD><IMG src="../sysimage/emot/12.gif"></TD>
	<TD><IMG src="../sysimage/emot/13.gif"></TD>
	<TD><IMG src="../sysimage/emot/14.gif"></TD>
	<TD><IMG src="../sysimage/emot/15.gif"></TD>
	<TD><IMG src="../sysimage/emot/16.gif"></TD>
	<TD><IMG src="../sysimage/emot/17.gif"></TD>
	<TD><IMG src="../sysimage/emot/18.gif"></TD>
	<TD><IMG src="../sysimage/emot/19.gif"></TD>
	<TD><IMG src="../sysimage/emot/20.gif"></TD></TR>
  <TR>
    <TD><IMG src="../sysimage/emot/21.gif"></TD>
	<TD><IMG src="../sysimage/emot/22.gif"></TD>
	<TD><IMG src="../sysimage/emot/23.gif"></TD>
	<TD><IMG src="../sysimage/emot/24.gif"></TD>
	<TD><IMG src="../sysimage/emot/25.gif"></TD>
	<TD><IMG src="../sysimage/emot/26.gif"></TD>
	<TD><IMG src="../sysimage/emot/27.gif"></TD>
	<TD><IMG src="../sysimage/emot/28.gif"></TD>
	<TD><IMG src="../sysimage/emot/29.gif"></TD>
	<TD><IMG src="../sysimage/emot/30.gif"></TD></TR>
  <TR>
    <TD><IMG src="../sysimage/emot/31.gif"></TD>
	<TD><IMG src="../sysimage/emot/32.gif"></TD>
	<TD><IMG src="../sysimage/emot/33.gif"></TD>
	<TD><IMG src="../sysimage/emot/34.gif"></TD>
	<TD><IMG src="../sysimage/emot/35.gif"></TD>
	<TD><IMG src="../sysimage/emot/36.gif"></TD>
	<TD><IMG src="../sysimage/emot/37.gif"></TD>
	<TD><IMG src="../sysimage/emot/38.gif"></TD>
	<TD><IMG src="../sysimage/emot/39.gif"></TD>
	<TD><IMG src="../sysimage/emot/40.gif"></TD></TR>
  <TR>
    <TD><IMG src="../sysimage/emot/41.gif"></TD>
	<TD><IMG src="../sysimage/emot/42.gif"></TD>
	<TD><IMG src="../sysimage/emot/43.gif"></TD>
	<TD><IMG src="../sysimage/emot/44.gif"></TD>
	<TD><IMG src="../sysimage/emot/45.gif"></TD>
	<TD><IMG src="../sysimage/emot/46.gif"></TD>
	<TD><IMG src="../sysimage/emot/47.gif"></TD>
	<TD><IMG src="../sysimage/emot/48.gif"></TD>
	<TD><IMG src="../sysimage/emot/49.gif"></TD>
	<TD><IMG src="../sysimage/emot/50.gif"></TD></TR>
</TBODY></TABLE>


</td></tr></table>
</BODY></HTML>
