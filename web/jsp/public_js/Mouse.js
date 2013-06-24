<script>                                  
var msg="";                                              
var def=msg;                                              
var interval = 100;                                              
var spacelen = 120;                                              
var space10=" ";                                              
var seq=0;                                              
                 
function Scroll() {                                              
                 
	len = msg.length;                                              
                 
	window.status = msg.substring(0, seq+1);                                              
                 
	seq++;                                              
                 
	if ( seq >= len ) {                                               
                 
		seq = spacelen;                                               
                 
		window.setTimeout("Scroll2();", interval );                                              
                 
	}                                              
                 
	else                                              
                 
		window.setTimeout("Scroll();", interval );                                              
                 
}                                               
                 
                                              
                 
function Scroll2() {                                              
                 
	var out="";                                              
                 
                                              
                 
	for (i=1; i<=spacelen/space10.length; i++) out += space10;                                              
                 
	out = out + msg;                                              
                 
	len=out.length;                                              
                 
	window.status=out.substring(seq, len);                                              
                 
	seq++;                                              
                 
	if ( seq >= len ) { seq = 0; };                                              
                 
	window.setTimeout("Scroll2();", interval );                                              
                 
}                                               
window.onLoad=Scroll();                                              
</SCRIPT>
<!--改变STATUS结束--><!--鼠标--><LAYER CLIP="0,0,1,1" BGCOLOR="#ffffff" 
VISIBILITY="SHOW" TOP="10" LEFT="10" NAME="a0"></LAYER><LAYER CLIP="0,0,1,1" 
BGCOLOR="#fff000" VISIBILITY="SHOW" TOP="10" LEFT="10" NAME="a1"></LAYER><LAYER 
CLIP="0,0,1,1" BGCOLOR="#ffa000" VISIBILITY="SHOW" TOP="10" LEFT="10" 
NAME="a2"></LAYER><LAYER CLIP="0,0,1,1" BGCOLOR="#ff00ff" VISIBILITY="SHOW" 
TOP="10" LEFT="10" NAME="a3"></LAYER><LAYER CLIP="0,0,1,1" BGCOLOR="#00ff00" 
VISIBILITY="SHOW" TOP="10" LEFT="10" NAME="a4"></LAYER><LAYER CLIP="0,0,1,1" 
BGCOLOR="#FF00FF" VISIBILITY="SHOW" TOP="10" LEFT="10" NAME="a5"></LAYER><LAYER 
CLIP="0,0,1,1" BGCOLOR="#FF0000" VISIBILITY="SHOW" TOP="10" LEFT="10" 
NAME="a6"></LAYER><LAYER CLIP="0,0,2,2" BGCOLOR="#ffffff" VISIBILITY="SHOW" 
TOP="10" LEFT="10" NAME="a7"></LAYER><LAYER CLIP="0,0,2,2" BGCOLOR="#fff000" 
VISIBILITY="SHOW" TOP="10" LEFT="10" NAME="a8"></LAYER><LAYER CLIP="0,0,2,2" 
BGCOLOR="#ffa000" VISIBILITY="SHOW" TOP="10" LEFT="10" NAME="a9"></LAYER><LAYER 
CLIP="0,0,2,2" BGCOLOR="#ff00ff" VISIBILITY="SHOW" TOP="10" LEFT="10" 
NAME="a10"></LAYER><LAYER CLIP="0,0,2,2" BGCOLOR="#00ff00" VISIBILITY="SHOW" 
TOP="10" LEFT="10" NAME="a11"></LAYER><LAYER CLIP="0,0,2,2" BGCOLOR="#0000ff" 
VISIBILITY="SHOW" TOP="10" LEFT="10" NAME="a12"></LAYER><LAYER CLIP="0,0,2,2" 
BGCOLOR="#FF0000" VISIBILITY="SHOW" TOP="10" LEFT="10" NAME="a13"></LAYER>
<SCRIPT>                                           
                  
if (document.all){                                           
                 
	document.write('<div id="starsDiv" style="position:absolute;top:0px;left:0px">')                                           
                 
	document.write('<div style="position:relative;width:1px;height:1px;background:#ffffff;font-size:1px;visibility:visible"></div>')                                           
                 
	document.write('<div style="position:relative;width:1px;height:1px;background:#fff000;font-size:1px;visibility:visible"></div>')                                           
                 
	document.write('<div style="position:relative;width:1px;height:1px;background:#ffa000;font-size:1px;visibility:visible"></div>')                                           
                 
	document.write('<div style="position:relative;width:1px;height:1px;background:#ff00ff;font-size:1px;visibility:visible"></div>')                                           
                 
	document.write('<div style="position:relative;width:1px;height:1px;background:#00ff00;font-size:1px;visibility:visible"></div>')                                           
                 
	document.write('<div style="position:relative;width:1px;height:1px;background:#0000ff;font-size:1px;visibility:visible"></div>')                                           
                 
	document.write('<div style="position:relative;width:1px;height:1px;background:#FF0000;font-size:1px;visibility:visible"></div>')                                           
                 
	document.write('<div style="position:relative;width:2px;height:2px;background:#ffffff;font-size:2px;visibility:visible"></div>')                                           
                 
	document.write('<div style="position:relative;width:2px;height:2px;background:#fff000;font-size:2px;visibility:visible"></div>')                                           
                 
	document.write('<div style="position:relative;width:2px;height:2px;background:#ffa000;font-size:2px;visibility:visible"></div>')                                           
                 
	document.write('<div style="position:relative;width:2px;height:2px;background:#ff00ff;font-size:2px;visibility:visible"></div>')                                           
                 
	document.write('<div style="position:relative;width:2px;height:2px;background:#00ff00;font-size:2px;visibility:visible"></div>')                                           
                 
	document.write('<div style="position:relative;width:2px;height:2px;background:#0000ff;font-size:2px;visibility:visible"></div>')                                           
                 
	document.write('<div style="position:relative;width:3px;height:3px;background:#FF0000;font-size:3px;visibility:visible"></div>')                                           
                 
	document.write('</div>')                                           
                 
}                                           
                 
                                           
                 
if (document.layers) {window.captureEvents(Event.MOUSEMOVE);}                                           
                 
                                           
                 
var yBase = 200;                                           
                 
var xBase = 200;                                           
                 
var step = 1;                                           
                 
var currStep = 0;                                           
                 
var Xpos = 1;                                           
                 
var Ypos = 1;                                           
                 
                                           
                 
if (document.all) {                                           
                 
	function MoveHandler(){                                           
                 
		Xpos = document.body.scrollLeft+event.x;                                           
                 
		Ypos = document.body.scrollTop+event.y;                                           
                 
	}                                           
                 
	document.onmousemove = MoveHandler;                                           
                 
}                                           
                 
                                           
                 
else if (document.layers) {                                           
                 
	function xMoveHandler(evnt){                                           
                 
		Xpos = evnt.pageX;                                           
                 
		Ypos = evnt.pageY;                                           
                 
	}                                           
                 
	window.onMouseMove = xMoveHandler;                                           
                 
}                                           
                 
                                           
                 
function animateLogo() {                                           
                 
	if (document.all) {                                           
                 
		yBase = window.document.body.offsetHeight/6;                                           
                 
		xBase = window.document.body.offsetWidth/6;                                           
                 
	}                                           
                 
	else if (document.layers) {                                           
                 
		yBase = window.innerHeight/8;                                           
                 
		xBase = window.innerWidth/8;                                           
                 
	}                                           
                 
                                           
                 
	if (document.all) {                                           
                 
		for ( i = 0 ; i < starsDiv.all.length ; i++ ) {                                           
                 
			starsDiv.all[i].style.top = Ypos + yBase*Math.sin((currStep + i*4)/12)*Math.cos(400+currStep/200);                                           
                 
			starsDiv.all[i].style.left = Xpos + xBase*Math.sin((currStep + i*3)/10)*Math.sin(currStep/200);                                           
                 
		}                                           
                 
	}                                           
                 
                                           
                 
	else if (document.layers) {                                           
                 
		for ( j = 0 ; j < 14 ; j++ ) {                                           
                 
			var templayer="a"+j                                           
                 
			document.layers[templayer].top = Ypos + yBase*Math.sin((currStep + j*4)/12)*Math.cos(400+currStep/200);                                           
                 
			document.layers[templayer].left = Xpos + xBase*Math.sin((currStep + j*3)/10)*Math.sin(currStep/200);                                           
                 
		}                                           
                 
	}                                           
                 
	currStep+= step;                                           
                 
	setTimeout("animateLogo()", 10);                                           
                 
}                                           
                 
//animateLogo();                                           
                 
</SCRIPT>

