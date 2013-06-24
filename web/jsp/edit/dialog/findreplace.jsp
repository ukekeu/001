<%@ page contentType="text/html;charset=GBK" %>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=javascript src="dialog.js"></script>
<link href='dialog.css' type='text/css' rel='stylesheet'>
<TITLE>查找 / 替换</TITLE>

<script language="JavaScript">

var oSelection;
oSelection = dialogArguments.document.selection.createRange();

function searchtype(){
    var retval = 0;
    var matchcase = 0;
    var matchword = 0;
    if (document.frmSearch.blnMatchCase.checked) matchcase = 4;
    if (document.frmSearch.blnMatchWord.checked) matchword = 2;
    retval = matchcase + matchword;
    return(retval);
}

function checkInput(){
    if (document.frmSearch.strSearch.value.length < 1) {
        alert("请输入查找内容");
        return false;
    } else {
        return true;
    }
}

function findtext(){
    if (checkInput()) {
        var searchval = document.frmSearch.strSearch.value;
        oSelection.collapse(false);
        if (oSelection.findText(searchval, 1000000000, searchtype())) {
            oSelection.select();
        } else {
            var startfromtop = confirm("搜索完成，是否要从顶部开始重新搜索？");
            if (startfromtop) {
                oSelection.expand("textedit");
                oSelection.collapse();
                oSelection.select();
                findtext();
            }
        }
    }
}

function replacetext(){
    if (checkInput()) {
        if (document.frmSearch.blnMatchCase.checked){
            if (oSelection.text == document.frmSearch.strSearch.value) oSelection.text = document.frmSearch.strReplace.value
        } else {
            if (oSelection.text.toLowerCase() == document.frmSearch.strSearch.value.toLowerCase()) oSelection.text = document.frmSearch.strReplace.value
        }
        findtext();
    }
}

function replacealltext(){
    if (checkInput()) {
        var searchval = document.frmSearch.strSearch.value;
        var wordcount = 0;
        var msg = "";
        oSelection.expand("textedit");
        oSelection.collapse();
        oSelection.select();
        while (oSelection.findText(searchval, 1000000000, searchtype())){
            oSelection.select();
            oSelection.text = document.frmSearch.strReplace.value;
            wordcount++;
        }
        if (wordcount == 0) msg = "要查找的内容没有找到"
        else msg = wordcount + " " + "处文本被替换成功";
        alert(msg);
    }
}

function InitDocument(){
	adjustDialog();
}

</script>

</HEAD>
<BODY onload="InitDocument()">
<table border=0 cellpadding=0 cellspacing=5 id=tabDialogSize><tr><td>


<TABLE CELLSPACING="0" cellpadding="0" border="0" align=center>
<FORM NAME="frmSearch" method="post" action="">
<TR>
	<TD VALIGN="top" align="left" nowrap width="60%">
		<label for="strSearch">查询内容</label><br>
		<INPUT TYPE=TEXT SIZE=25 NAME=strSearch id="strSearch"><br>
		<label for="strReplace">替换内容</label><br>
		<INPUT TYPE=TEXT SIZE=25 NAME=strReplace id="strReplace"><br>
		<INPUT TYPE=Checkbox NAME=blnMatchCase ID="blnMatchCase"><label for="blnMatchCase">区分大小写</label><br>
		<INPUT TYPE=Checkbox NAME=blnMatchWord ID="blnMatchWord"><label for="blnMatchWord">全部匹配</label>
	</td>
	<td width="5%">
	<td rowspan="2" valign="bottom" width="35%">
		<table border=0 cellpadding=0 cellspacing=5 width="100%" align=center>
		<tr><td><input type=button style="width:100%" name="btnFind" onClick="findtext();" value="查找下一个"></td></tr>
		<tr><td><input type=button style="width:100%" name="btnCancel" onClick="window.close();" value="关闭"></td></tr>
		<tr><td><input type=button style="width:100%" name="btnReplace" onClick="replacetext();" value="替换"></td></tr>
		<tr><td><input type=button style="width:100%" name="btnReplaceall" onClick="replacealltext();" value="全部替换"></td></tr>
		</table>
	</td>
</tr>
</FORM>
</table>


</td></tr></table>
</BODY>
</HTML>
