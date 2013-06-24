<%@ page contentType="text/html;charset=GBK" %>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=javascript src="dialog.js"></script>
<link href='dialog.css' type='text/css' rel='stylesheet'>
<TITLE>图形热点链接</TITLE>

<script language="javascript">

var oControl;
var oSeletion;
var sRangeType;
var oMap = null;

var sSrc = "";
var sUseMap = "";
var sWidth = "";
var sHeight = "";

var aHref = new Array();
var aTarget = new Array();
var aCoords = new Array();

var aLeft = new Array();
var aTop = new Array();
var aWidth = new Array();
var aHeight = new Array();

var aMapName = new Array();
var sBody = "";

oSelection = opener.eWebEditor.document.selection.createRange();
oControl = oSelection.item(0);

sSrc = oControl.src;
sUseMap = oControl.useMap;
sWidth = oControl.offsetWidth;
sHeight = oControl.offsetHeight;
if (sUseMap!=""){
	sUseMap = sUseMap.toUpperCase();
	var oAllMap = opener.eWebEditor.document.body.getElementsByTagName("MAP");
	for (var i=0; i<oAllMap.length; i++){
		aMapName[i] = oAllMap[i].name.toUpperCase();
		if (("#"+aMapName[i])==sUseMap){
			oMap = oAllMap[i];
		}
	}
}


sBody = "<img id='SOURCEIMAGE' border=0 src='"+sSrc+"' width='"+sWidth+"' height='"+sHeight+"'>";
if (oMap){
	for (var i=0; i<oMap.areas.length; i++){
		aHref[i] = oMap.areas(i).href;
		aTarget[i] = oMap.areas(i).target;
		aCoords[i] = oMap.areas(i).coords;
		var a = aCoords[i].split(",");
		aLeft[i] = parseInt(a[0]);
		aTop[i] = parseInt(a[1]);
		aWidth[i] = parseInt(a[2])-aLeft[i];
		aHeight[i] = parseInt(a[3])-aTop[i];
		sBody += "<img id='myIMAGE"+i+"' border=1 src='../sysimage/space.gif' style='position:absolute;left:"+aLeft[i]+"px;top:"+aTop[i]+"px;width:"+aWidth[i]+"px;height:"+aHeight[i]+"px;zIndex:"+(i+1)+"'>";
	}
}


function doInit(){

	mapIframe.document.designMode="On";
	mapIframe.document.open();
	mapIframe.document.write("<head><style>body,a,table,td {font-size:9pt;font-family:Verdana, Arial, Helvetica, sans-serif;Color:#000000;}</style></head><body MONOSPACE>");
	mapIframe.document.body.innerHTML = sBody;
	mapIframe.document.body.contentEditable = "true";
	mapIframe.document.ondblclick=new Function("return dblClick(mapIframe.event);");
	
	mapIframe.document.execCommand("2D-Position",true,true);
	//mapIframe.document.execCommand("MultipleSelection", true, true);
	mapIframe.document.execCommand("LiveResize", true, true);
	mapIframe.document.close();

}

var objLink = new Object() ;
function dblClick(event){
	var e=event.srcElement;
	if (e){
		if ((e.tagName=="IMG")&&(e.id!="SOURCEIMAGE")){
			var sID = e.id;
			var nID = parseInt(sID.substr(7));
			objLink.Href = aHref[nID];
			objLink.Target = aTarget[nID];
			var arr = showModalDialog("hyperlink.htm?action=other", window, "dialogWidth:0px;dialogHeight:0px;help:no;scroll:no;status:no");
			if (arr){
				aHref[nID] = arr[0];
				aTarget[nID] = arr[1];
			}
		}
	}
	return false;
}

function newMap(){
	var n = aHref.length;
	aHref[n]="";
	aTarget[n]="";
	mapIframe.document.body.innerHTML += "<img id='myIMAGE"+n+"' border=1 src='../sysimage/space.gif' style='position:absolute;zIndex:"+(n+1)+";width:20;height:20;left:0;top:0'>";
	mapIframe.scrollBy(0,0);
	mapIframe.focus();
}


function getAutoMapName(){
	var b=true;
	var n=0;
	var s=""
	while (b){
		n++;
		s = "AutoMap" + n;
		if (isValidMapName(s)){
			b=false;
		}
	}
	return s;

}


function isValidMapName(str){
	str=str.toUpperCase();
	for (var i=0; i<aMapName.length; i++){
		if (aMapName[i]==str){
			return false;
		}
	}
	return true;
}

function ok(){
	var b=false;
	for (var i=0; i<aHref.length; i++){
		var obj = mapIframe.document.getElementById("myIMAGE"+i);
		if (obj){
			b=true;
		}
	}

	
	if (b){
		var html = "";
		for (var i=0; i<aHref.length; i++){
			var obj = mapIframe.document.getElementById("myIMAGE"+i);
			if (obj){
				var nLeft = parseInt(obj.style.left);
				var nTop = parseInt(obj.style.top);
				var nWidth = parseInt(obj.style.width);
				var nHeight = parseInt(obj.style.height);
				var nRight = nLeft+nWidth;
				var nBottom = nTop+nHeight;
				html += "<area shape='rect' href='"+aHref[i]+"' target='"+aTarget[i]+"' coords='"+nLeft+","+nTop+","+nRight+","+nBottom+"'>";
			}
		}

		if (oMap){
			oMap.innerHTML = html;
		}else{
			sUseMap = getAutoMapName();
			oControl.useMap = "#" + sUseMap;
			opener.appendHTML("<map name='"+sUseMap+"'>"+html+"</map>");
		}
	}else{
		if (oMap){
			oMap.outerHTML = "";
		}
		oControl.useMap = "";
	}
	oControl.width=mapIframe.SOURCEIMAGE.width;
	oControl.height=mapIframe.SOURCEIMAGE.height;

	window.returnValue = null;
	window.close();
}

function InitDocument(){

}

</script>

</HEAD>

<BODY onload="InitDocument()">
<table border=0 cellpadding=0 cellspacing=3 align=center width="100%" height="100%">
<tr><td colspan=2 height="100%"><iframe ID="mapIframe" MARGINHEIGHT="1" MARGINWIDTH="1" width="100%" scrolling="yes" height="100%"></iframe></td></tr>
<tr><td colspan=2 height=5></td></tr>
<tr><td><input type=button value='新建' id=btnNew onclick="newMap()">&nbsp;(双击可编辑链接)</td><td align=right><input type=button value='确定' id=Ok onclick="ok()">&nbsp;&nbsp;<input type=button value='取消' onclick="window.close();"></td></tr>
</table>

<Script Language=JavaScript>
doInit();
</Script>

</body>
</html>
