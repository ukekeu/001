<%@ page contentType="text/html;charset=GBK" %>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=javascript src="dialog.js"></script>

<STYLE type=text/css>
table.content {background-color:#000000;width:100%;}
table.content td {background-color:#ffffff;width:18px;height:18px;text-align:center;vertical-align:middle;cursor:hand;}
.card {cursor:hand;background-color:#3A6EA5;text-align:center;white-space:nowrap}
</STYLE>
<link href='dialog.css' type='text/css' rel='stylesheet'>
<TITLE>插入特殊符号</TITLE>

<SCRIPT language=JavaScript>

function cardClick(cardID){
	var obj;
	for (var i=1;i<7;i++){
		obj=document.all("card"+i);
		obj.style.backgroundColor="#3A6EA5";
		obj.style.color="#FFFFFF";
	}
	obj=document.all("card"+cardID);
	obj.style.backgroundColor="#FFFFFF";
	obj.style.color="#3A6EA5";

	for (var i=1;i<7;i++){
		obj=document.all("content"+i);
		obj.style.display="none";
	}
	obj=document.all("content"+cardID);
	obj.style.display="";
}

function SymbolOver(){
	var el=event.srcElement;
	preview.innerHTML=el.innerHTML;
}

function SymbolClick(){
	var el=event.srcElement;
	if (el.innerHTML=="&nbsp;") return;
	dialogArguments.insertHTML(el.innerHTML);
	window.returnValue = null;
	window.close();
}

function InitDocument(){
	adjustDialog();
}

</script>
</HEAD>

<BODY onload="InitDocument()">
<table border=0 cellpadding=0 cellspacing=5 id=tabDialogSize><tr><td>


<table border=0 cellpadding=0 cellspacing=0 align=center><tr valign=top><td>


<table border=0 cellpadding=3 cellspacing=0>
<tr align=center>
	<td class="card" onclick="cardClick(1)" id="card1">特殊</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(2)" id="card2">标点</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(3)" id="card3">数学</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(4)" id="card4">单位</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(5)" id="card5">数字</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(6)" id="card6">拼音</td>
</tr>
<tr>
	<td bgcolor=#ffffff align=center valign=middle colspan=11>
	<table border=0 cellpadding=3 cellspacing=1 class="content" id="content1">
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65283;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65312;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65286;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65290;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8251;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#167;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12291;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8470;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12307;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9675;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9679;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9651;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9650;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9678;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9734;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9733;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9671;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9670;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9633;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9632;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9661;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9660;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12963;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8453;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#713;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65507;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65343;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65097;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65098;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65101;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65102;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65099;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65100;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65119;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65120;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65121;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9792;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9794;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8853;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8857;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8593;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8595;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8592;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8594;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8598;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8599;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8601;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8600;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8741;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8739;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65295;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65340;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8725;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65128;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8364;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&yen;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&pound;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8482;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&reg;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&copy;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
	</tr>
	</table>
	<table border=0 cellpadding=3 cellspacing=1 class="content" id="content2">
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65292;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12289;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12290;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65294;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65307;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65306;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65311;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65281;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65072;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8230;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8229;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8242;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8245;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12293;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65374;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8214;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#711;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#713;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65104;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65105;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65106;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#183;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65108;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65109;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65110;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65111;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65372;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#45;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65073;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#45;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65075;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65076;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65103;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65288;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65289;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65077;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65078;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65371;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65373;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65079;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65080;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12308;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12309;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65081;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65082;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12304;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12305;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65083;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65084;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12298;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12299;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65085;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65086;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12296;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12297;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65087;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65088;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12300;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12301;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65089;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65090;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12302;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12303;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65091;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65092;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65113;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65114;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65115;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65116;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65117;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65118;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#39;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#39;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&quot;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&quot;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12317;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12318;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#715;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#714;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
	</tr>
	</table>
	<table border=0 cellpadding=3 cellspacing=1 class="content" id="content3">
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8776;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8801;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8800;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65309;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8804;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8805;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65308;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65310;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8814;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8815;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8759;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#177;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65291;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65293;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#215;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#247;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65295;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8747;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8750;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8733;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8734;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8743;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8744;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8721;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8719;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8746;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8745;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8712;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8757;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8756;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8869;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8741;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8736;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8978;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8857;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8780;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8765;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8730;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8806;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8807;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8786;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8801;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65122;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65123;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65124;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65125;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65126;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65374;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8735;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8895;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#13266;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#13265;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
	</tr>
	</table>
	<table border=0 cellpadding=3 cellspacing=1 class="content" id="content4">
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#176;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8242;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8243;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65284;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65509;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12306;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65504;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65505;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65285;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65312;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8451;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8457;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65129;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65130;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8240;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#65131;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#13269;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#13212;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#13213;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#13214;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#13262;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#13217;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#13198;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#13199;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#13252;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#176;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9675;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#164;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
	</tr>
	</table>
	<table border=0 cellpadding=3 cellspacing=1 class="content" id="content5">
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8560;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8561;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8562;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8563;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8564;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8565;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8566;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8567;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8568;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8569;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8544;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8545;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8546;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8547;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8548;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8549;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8550;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8551;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8552;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8553;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8554;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#8555;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9352;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9353;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9354;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9355;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9356;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9357;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9358;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9359;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9360;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9361;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9362;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9363;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9364;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9365;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9366;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9367;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9368;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9369;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9370;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9371;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9332;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9333;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9334;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9335;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9336;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9337;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9338;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9339;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9340;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9341;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9342;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9343;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9344;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9345;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9346;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9347;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9348;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9349;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9350;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9351;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9312;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9313;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9314;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9315;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9316;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9317;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9318;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9319;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9320;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#9321;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12832;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12833;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12834;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12835;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12836;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12837;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12838;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12839;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12840;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#12841;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
	</tr>
	</table>
	<table border=0 cellpadding=3 cellspacing=1 class="content" id="content6">
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#257;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#225;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#462;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#224;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#333;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#243;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#466;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#242;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#275;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#233;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#283;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#232;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#299;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#237;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#464;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#236;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#363;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#250;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#468;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#249;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#470;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#472;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#474;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#476;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#252;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#234;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#593;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#59335;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#324;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#328;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#59336;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&#609;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
	</tr>
	<tr>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
		<td onmouseover="SymbolOver()" onclick="SymbolClick()">&nbsp;</td>
	</tr>
	</table>

	</td>
</tr>
</table>


</td><td width=10>&nbsp;</td><td>

<table border=0 cellpadding=0 cellspacing=0>
<tr><td height=25></td></tr>
<tr><td align=center>预览</td></tr>
<tr><td height=10></td></tr>
<tr><td align=center valign=middle><table border=0 cellpadding=0 cellspacing=1 bgcolor=#000000 width=50 height=50><tr><td bgcolor=#ffffff style="font-size:32px;color:#0000ff" id=preview align=center valign=middle width=50 height=50></td></tr></table></td></tr>
<tr><td height=52></td></tr>
<tr><td align=center><input type=button value='取消' onclick="window.close();"></td></tr>
</table>

</td></tr></table>





</td></tr></table>

<script language=javascript>
cardClick(1);
</script>

</BODY>
</HTML>
