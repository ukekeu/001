<%@ page contentType="text/html;charset=GBK" %>
<HTML>
<HEAD>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<style type="text/css">
body {	margin: 0px; border: 0px; background-color: buttonface; }
</style>

<script language=javascript>

var config;
try{config = opener.config;}catch(e){}

var lang;
try{lang = opener.lang;}catch(e){}

</script>

<TITLE>eWebEditor - ȫ���༭</TITLE>
</HEAD>
<BODY scroll="no" onunload="Minimize()">
<input type="hidden" id="ContentFullScreen" name="ContentFullScreen" value="">

<script language=javascript>

ContentFullScreen.value = opener.getHTML();
document.write('<iframe ID="EditorFullScreen" src="../ewebeditor.htm?id=ContentFullScreen&fullscreen=1&style='+config.StyleName+'" frameborder="0" scrolling=no width="100%" HEIGHT="100%"></iframe>');

function Minimize() {
	opener.setHTML(EditorFullScreen.getHTML());
	self.close();
}

</script>

</BODY>
</HTML>
