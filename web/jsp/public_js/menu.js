function aad2(h,nn){ 
    var i ;
	var ww;	
	var t;
	var mm

  for(n=1;n<=nn;n++){
    mm = "../images/h"+".gif";

    var imageVar = eval("document.s"+n); 
	 if (imageVar)
     	imageVar.src = mm;
  }
	ww = "../images/s"+".gif";
	h.src = ww;

}
function aad(h,nn){ 
    var i ;
	var ww;	
	var t;
	var mm
 
  for(n=1;n<=nn;n++){
    mm = "../picture/file"+".gif";
    var imageVar = eval("document.filebox" + n); 
     //document.images[n].src = mm;  

	 if (imageVar)
     	imageVar.src = mm;
  }

	ww = "../picture/filebox1"+"0.gif";
	h.src = ww;
}

function aad1(h,nn){ 
    var i ;
	var ww;	
	var t;
	var mm
 
  for(n=1;n<=nn;n++){
    mm = "../picture/dot_01.gif";
    var imageVar = eval("document.filebox" + n); 
     //document.images[n].src = mm;  

	 if (imageVar)
     	imageVar.src = mm;
  }

	ww = "../picture/dleaf.gif";
	h.src = ww;
}


function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);


function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_showHideLayers() { //v3.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v='hide')?'hidden':v; }
    obj.visibility=v; }
}

nereidFadeObjects = new Object();
nereidFadeTimers = new Object();
function nereidFade(object, destOp, rate, delta){
if (!document.all)
return
    if (object != "[object]"){
        setTimeout("nereidFade("+object+","+destOp+","+rate+","+delta+")",0);
        return;
    }
    clearTimeout(nereidFadeTimers[object.sourceIndex]);
    diff = destOp-object.filters.alpha.opacity;
    direction = -1;
    if (object.filters.alpha.opacity > destOp){
        direction = -1;
    }
    delta=Math.min(direction*diff,delta);
    object.filters.alpha.opacity+=direction*delta;
    if (object.filters.alpha.opacity != destOp){
        nereidFadeObjects[object.sourceIndex]=object;
        nereidFadeTimers[object.sourceIndex]=setTimeout("nereidFade(nereidFadeObjects["+object.sourceIndex+"],"+destOp+","+rate+","+delta+")",rate);
    }
}

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}



function switchSysBar(){
	if (switchPoint.innerText==3){
		switchPoint.innerText=4
		document.all("frmTitle").style.display="none"
	}
	else{
		switchPoint.innerText=3
		document.all("frmTitle").style.display=""
	}
}
function switchSysBar1(src){
	//if (switchPoint.innerText==3){
		//switchPoint.innerText=4
		//document.all("frmTitle").style.display="none"
	//}
	//else{
		switchPoint.innerText=3
		src.style.display=""
	//}
}
<!-- ////////// Setup Color Library -->
function changeColor(j){
  var c = new Array(5);	//Color
  c[0] = new Array('#fffff5','#aaaaa','#CCFFCC');
  c[1] = new Array('#fde9e9','#ea9290','#fdc0bf');
  c[2] = new Array('#fff2cc','#fea827','#fecb35');
  c[3] = new Array('#fbfbd5','#b5bc4f','#d9df74');
  c[4] = new Array('#eeeeff','#99afFF','#ffcc66');
  c[5] = new Array('#dcedfc','#6b91bb','#9ec3e3');
	if(j < 0) return;
    frmright.document.bgColor=c[j][0];
    frmright.bar.bgColor=c[j][1];
    BoardTitle.document.bgColor=c[j][0];
    document.cookie="colorstyle="+j ;
}

