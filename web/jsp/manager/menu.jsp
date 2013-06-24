  <%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
  <%@ page import="java.sql.*,java.util.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase" />
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
<%
 
String userid=(String)session.getAttribute("loginid"); 
String no=getbyte2(request.getParameter("MModuleNo"));
String SqlStr="";
if (no.equals("DESKTOP"))
   SqlStr="select Url,MModuleNo,MModuleName,CModuleNo,CModuleName,picpath,nexus,title  from ModuleCortrol where   nexus='C' and CModuleNo in(select ModuleNo from  PopedomConrtrol where SellerId='"+userid+"' and choose=1) ORDER BY nexus DESC, CModuleNo";//and nexus='C' ManModuleCortrol
else 
   SqlStr="select Url,MModuleNo,MModuleName,CModuleNo,CModuleName,picpath,nexus,title  from ModuleCortrol where   nexus='C'and  MModuleNo ='"+no+"' and CModuleNo in(select ModuleNo from  PopedomConrtrol where SellerId='"+userid+"') ORDER BY nexus DESC, CModuleNo";//and nexus='C' ManModuleCortrol
	  ResultSet rs=null;
 
%>
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
  //retval = window.showModalDialog(strurl,"","dialogWidth:"+showx+"px; dialogHeight:"+showy+"; dialogLeft:50px; dialogTop:10px; status:yes; directories:yes;scrollbars:yes;Resizable=yes; "  );
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
function windowstate(values){

window.status="当前操作模块："+values;
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
		
		 src.background="../images/yellowcolor.gif";
		 src.style.border="1 outset #ffffff";
		 
}
</script>
 
<body  topmargin="0" leftmargin="0"   marginheight="100%" oncontextmenu="return false">
<form name=ok>
<table width="110%"    height="97.5%" border="0"  align="center" background="../images/leftmenu_title_middle.gif" >
 <tr valign="top"><td>
 <table width="99%"   >
 <input type=hidden name=userhelp value="<%=request.getParameter("help") %>">
 <%  //try{
 
     String mm="";
	  mm="../";
     int i=0;
	  int num=0;
	 rs = ViewBean.executeQuery(SqlStr);
	while (rs.next()){ 
	String url=getbyte(rs.getString("url"));
	 num++;
	 if (i==0){
 %>
   <tr valign="top" align="left"><td ></td>
    <td   height=30 title="<%=getbyte(rs.getString("title"))  %>"   >
   <IMG height=20 src="../images/circle.gif" 
    width=20><%if (!no.equals("DESKTOP")){ out.print(rs.getString("MModuleName").substring(0,4));}else{out.print("我的桌面");} %>
   </td> 
    </tr>
	 <tr><td  colspan="2"></td></tr>
	
   <%}i++; %>
    <tr valign="top"><!--'-->
    <td   width="16" height="13" ></td>
    <TD background=""  onclick="window.parent.main.location='<%=mm+url  %>';windowstate('<%=rs.getString("CModuleName") %>');changeclass(this,'L3','L2');" bgColor=#fef2f0  style="cursor:hand;" title="<%=getbyte(rs.getString("title"))  %>"><IMG    height=5 hspace=5 src="../images/trigon.gif"   width=3> 
 <%=rs.getString("CModuleName") %></a></TD></TR>
	  <tr><td><td>&nbsp;</td></td></tr>
	 
	 
<%}
rs.close();
 
String url="";
 if (no.equals("B"))url="csh.doc";
 
 if (no.equals("C"))url="kf.doc";
 if (no.equals("S"))url="ht.doc";
  if (no.equals("QT"))url="qt.doc";
   if (no.equals("F"))url="cw.doc";
 if (no.equals("F"))url="cw.doc";
 if (no.equals("DESKTOP"))url="desktop.doc";
  if (no.equals("R"))url="desktop.doc";
    if (no.equals("K"))url="file.doc";
	 if (no.equals("JC"))url="fx.doc";
if (!url.equals("")){
 %>	
    <tr valign="top">
    <td   width="16" height="13" ></td>
    <TD onclick="window.parent.main.location='../help/<%=url %>';" bgColor=#fef2f0  style="cursor:hand;" ><IMG    height=5 hspace=5 src="../images/trigon.gif"   width=3> 
<SPAN class=style4><SPAN 
      class=style8>在线帮助</SPAN></SPAN></a></TD></TR>
	  <%} %>
 </table> 

 </td></tr>
 <tr><td colspan="2" align="center"><%if (i==0&&!no.equals("DESKTOP")){ out.print("如<br>果<br>你<br>有<br>权<br>限<br>，<br>请<br>点<br>击<br>主<br>菜<br>单<br>名<br>称<br>，<br>否<br>则<br>是<br>你<br>无<br>权<br>使<br>用<br>该<br>功<br>能</b><br><img src='../images/em14.gif'");}if (i==0&&no.equals("DESKTOP")){out.print("请在<br>[桌面设置]<br>中设置你的<br>快捷模块");}%></td></tr>
 
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
