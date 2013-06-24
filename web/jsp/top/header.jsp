 <%@ page contentType="text/html;charset=GBK" %>
 <%@ page import="java.sql.*,java.util.*" %>
 <%@ include file="../public_js/checktime.jsp"%>
  <jsp:useBean id="onlineuser" class="online.ListUser" scope="application"/>
 <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="checkCount" scope="page" class="crmzl.autoCount" />
 <jsp:useBean id="smenu" scope="page" class="ConnDatabase.menu" />
 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <jsp:useBean id="checkreg" scope="page" class="regcheck.regcheck"/> 
 <%@ include file="../public_js/qx_checke.jsp"%>
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<STYLE type=text/css>
@import url( /jsp/css/common.css );
@import url( /jsp/css/header.css );
td {
	font-size: 12px;
}
.style2 {color: #A9CDCD}
.style3 {color: #BAD6D6}
.style4 {color: #B1D1CF}
</STYLE>

<SCRIPT language=JavaScript src="images/warning.js"></SCRIPT>

<SCRIPT language=JavaScript src="images/moduleBar.js"></SCRIPT>

<SCRIPT type=text/JavaScript>
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
function mout(src)  { 
	if (!src.contains(event.fromElement)) { 
		src.style.cursor = 'hand'; 
	}
}
//-->
</SCRIPT>
<SCRIPT>
var currentModuleId = 0;
function changeTab(moduleId){
      if(moduleId != currentModuleId){
      var handle = document.getElementById("tabMiddle"+currentModuleId);
      handle.style.background = "url('/images/themes/sky/header/gray_middle.gif')";
      handle = document.getElementById("tabMix"+(parseInt(currentModuleId)-1));
      if(handle == undefined){
         handle = document.getElementById("tabFirst"+currentModuleId);
         handle.style.background =  "url('/images/themes/sky/header/gray_left.gif')";
      }else{
          handle.style.background =  "url('/images/themes/sky/header/gray_cover.gif')";
      }
      handle = document.getElementById("tabMix"+currentModuleId);
       if(handle == undefined){
           handle = document.getElementById("tabLast"+currentModuleId);
         handle.style.background =  "url('/images/themes/sky/header/gray_right.gif')";
      }else{
          handle.style.background =  "url('/images/themes/sky/header/gray_cover.gif')";
      }
      
      
      var handle = document.getElementById("tabMiddle"+moduleId);
      handle.style.background = "url('/images/themes/sky/header/light_middle.gif')";
      handle = document.getElementById("tabMix"+(parseInt(moduleId)-1));
      if(handle == undefined){
         handle = document.getElementById("tabFirst"+moduleId);
         handle.style.background =  "url('/images/themes/sky/header/light_left.gif')";
      }else{
          handle.style.background =  "url('/images/themes/sky/header/light_right_cover.gif')";
      }
      handle = document.getElementById("tabMix"+moduleId);
       if(handle == undefined){
           handle = document.getElementById("tabLast"+moduleId);
         handle.style.background =  "url('/images/themes/sky/header/light_right.gif')";
      }else{
          handle.style.background =  "url('/images/themes/sky/header/light_left_cover.gif')";
      }

           currentModuleId =   moduleId ;
         
   }
}
function  menupic(src){ 
   var td = document.all.tags("img") ;
	 var tmp=src.id.substring(0,2);
	 	  for ( i = 0 ; i < td.length ; i ++ ) {
		 td[i].style.border="0 none black";
		 
		 }
	
		  src.style.border="1 outset white";
		 
}
function openwin1(url,wh,hg,lf,tp) {
  var newwin=window.open(url,"newwin1","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
  newwin.focus();
  return false;
}
function OverArrow(arrow)
{
	if(this.sliding)
		return;		
	//arrow.style.border="1 outset #ffffff";
}

function OutArrow(arrow)
{
	if(this.sliding)
		return;		
	//arrow.style.border="0 none black";
}
    
function out(){
     if (confirm("确认退出系统吗？"))
	 window.parent.location='../outSys.jsp'
   }
function reg(){
showx = screen.availWidth;  // + deltaX;
	showy = screen.availHeight; // + deltaY;
     	 retval = window.showModalDialog("../manager/testerror.jsp","","dialogWidth:500px; dialogHeight:200px; dialogLeft:150px; dialogTop:100px; status:no; directories:yes;scrollbars:no;Resizable=no; "  );
	}
	function ver(){
showx = screen.availWidth;  // + deltaX;
	showy = screen.availHeight; // + deltaY;
     	 retval = window.showModalDialog("../manager/showver.jsp","","dialogWidth:600px; dialogHeight:220px; dialogLeft:150px; dialogTop:100px; status:no; directories:yes;scrollbars:no;Resizable=no; "  );
	}
 <%out.print(smenu.showregCompay()); %>
</SCRIPT>
<META content="MSHTML 6.00.2800.1106" name=GENERATOR><title></title></HEAD>
<%Vector vt=onlineuser.getOnLineUser(); 
  Enumeration e = vt.elements(); 
  int onlinenum=0;
    while(e.hasMoreElements())
  { onlinenum++;
  String aa=(String)e.nextElement();
  }  //
  %>
<BODY leftMargin=0  topMargin=0 rightMargin=0  oncontextmenu="return false"   onbeforeunload="return '建议在线用户点击[退出]按钮离开，请确认离开方式！'"  onload="windowstate();">
<%
String userid=(String)session.getAttribute("loginid"); 
String ip=(String)session.getAttribute("ip");
String menu1= (String)  session.getAttribute("menu");
if (menu1==null)menu1="1";
 
 if (menu1.equals("1")||menu1.equals("3"))
  out.print(smenu.DoTopMenu(userid,ip));
 else if (menu1.equals("2"))
  out.print(smenu.doStartTag(userid));
 else if (menu1.equals("4"))  
 
   out.print(smenu.newTopMenu(userid,ip));//
//  checkCount.checkCount();
 %> 
</BODY></HTML>
