<%@ page contentType="text/html;charset=GBK" %>
 <%@ page import="java.sql.*,java.util.*" %>
 <jsp:useBean id="userBean" scope="page" class="ConnDatabase.SDatabase" />
 <jsp:useBean id="smenu" scope="page" class="ConnDatabase.menu" />
  <%@ include file="../public_js/getByteOut.jsp"%>
  
<html>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet> 
<head>
	<title>U客售楼管理信息系统</title>
</head>
<STYLE type=text/css>BODY {
	MARGIN: 0px
}
.style4 {
	COLOR: #43994f
}
.style6 {
	FONT-SIZE: 15px
}
.style8 {
	COLOR: #e1411d
}
</STYLE>
<script>
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
function openwin(url,wh,hg,lf,tp) {
  var newwin=window.open(url,"newwin","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
  
}

 function operwin(strurl){
  showx = screen.availWidth-100;  // + deltaX;
  showy = screen.availHeight-100; // + deltaY;
 	openwin(strurl,showx,showy,50,10);
 }
 
function OverItems(item)
{ 
	if(this.sliding)
		return;		
	item.style.border="1 outset #ffffff";
	item.bgcolor="#c0c0c0";

}

function OutItems(item)
{
	if(this.sliding)
		return;		
	item.style.border="0 none black";
	item.style.bgcolor="#ffffff";
		
}

function OverArrow(arrow)
{
	if(this.sliding)
		return;		
	arrow.style.border="1 outset #ffffff";
}

function OutArrow(arrow)
{
	if(this.sliding)
		return;		
	arrow.style.border="0 none black";
}

var TRID="";
function  changeclass(src,clrOver,clrIn){ 

 if (TRID==""){TRID=src.id;src.style.bgcolor="#ffffff"; }
 else{
    var aa=eval(""+TRID+"");
	//aa.className=clrIn;
	TRID=src.id;
  }
 
     var td = document.all.tags("TD") ;
	 var tmp=src.id.substring(0,2);
	  for ( i = 0 ; i < td.length ; i ++ ) {
		 td[i].style.border="0 none black";
		 td[i].background="";
		 }
		
		 src.background="../images/zjp/an01.png";
		// src.style.border="1 outset #ffffff";
		 
}
function windowstate(values){

window.status="当前操作模块："+values;
}	

function  menupic(src){ 
   var td = document.all.tags("img") ;
	 var tmp=src.id.substring(0,2);
	 	  for ( i = 0 ; i < td.length ; i ++ ) {
		 td[i].style.border="0 none black";
		 
		 }
	
		  src.style.border="1 outset white";
		 
}// 
</script>
 
<body  topmargin="0" leftmargin="0"  oncontextmenu="return false"   >
<form name=ok>
<table  width="100%"align="center" height="97.5%"  background="../images/leftmenu_title_middle.gif">
<tr valign="top"><td  align="center">
  <%
String userid=(String)session.getAttribute("loginid"); 
String ip=(String)session.getAttribute("ip");
out.print(smenu.doleftmenuStart(userid,ip));
 
 %>  </td></tr>
  </td>
 </tr>
 </table> 
 
<table border="0" cellspacing="0" width="100%" background="../images/bottom_bg.gif" id="AutoNumber2" cellpadding="0" style="border-collapse: collapse" bordercolor="#111111" height="10">
  <tr>
    <td width="19%" height="1">
    <img border="0" src="../images/bottom_left.gif" width="18" height="13"></td>
    <td width="181%" height="1" ></td>
  </tr>
</table>

  </form>
</body>
</html>