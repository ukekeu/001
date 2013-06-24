<%@ page contentType="text/html;charset=GBK" %>
 <%@ page import="java.sql.*,java.util.*" %>
  <jsp:useBean id="onlineuser" class="online.ListUser" scope="application"/>
 <jsp:useBean id="userBean" scope="page" class="ConnDatabase.SDatabase" />
 <jsp:useBean id="smenu" scope="page" class="ConnDatabase.menu" />
 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
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
  var newwin=window.open(url,"topnewwin","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
  
}
function openwin1(url,wh,hg,lf,tp) {
  var newwin=window.open(url,"topnewwin","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,width="+wh+",height="+hg+",left="+lf+",top="+tp);
  
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
//
</script>
  <%@ include file="../public_js/CheckSection.jsp"%>
<body  topmargin="0" leftmargin="0"   marginheight="100%"   oncontextmenu="return false"    >
<form name=ok>
<%   
  setpopedom.setSectionlist(SectionS);
    String no=request.getParameter("MModuleNo");  
     String url="";
     if (no.equals("B"))url="../help/jcsj.jsp";
	 else   if (no.equals("C"))url="../help/kf.doc";
     else   if (no.equals("QT"))url="../help/qt.doc";
	 else   if (no.equals("S"))url="../help/ht.doc";
	 else   if (no.equals("F"))url="../help/cw.doc"; 
	 else   if (no.equals("JC"))url="../help/fx.doc"; 
	 else   if (no.equals("M"))url="../help/xt.doc"; 
	 else   if (no.equals("K"))url="../help/file.doc"; 
	 else   if (no.equals("P"))url="../help/file.doc"; 
	 else   if (no.equals("DESKTOP"))url="../help/desktop.doc";  
	 String aa=(String)session.getAttribute("loginname");
	  if (!onlineuser.existUser(aa+"["+request.getRemoteAddr()+"]"))     
      { 
      session.setAttribute(aa+"["+request.getRemoteAddr()+"]",onlineuser);  //绑定监听器到session,激发监听器valueBound时间
      }
 %>
<table width="100%"  height="5"    bgColor=#fef2f0    >
 
<tr><td align="right"  ><img src="../images/color.gif" height="1" width="100%"></td></tr>
</table>
<table width="100%"    bgColor=#fef2f0    >
 <tr valign="top"><td align="center"  >
 <table width="100%"  border="0"  >
 <input type=hidden name=userhelp value="<%=request.getParameter("help") %>">

<%
 
 String userid=(String)session.getAttribute("loginid"); 

   String modelid="";
   String   SqlStr="select Url,MModuleNo,MModuleName,CModuleNo,CModuleName,picpath,nexus,title  from ModuleCortrol where   nexus='C'and  MModuleNo ='"+no+"' and CModuleNo in(select ModuleNo from  PopedomConrtrol where SellerId='"+userid+"') ORDER BY nexus DESC, CModuleNo";//and nexus='C' ManModuleCortrol
		if (no.equals("DESKTOP"))
	    SqlStr="select Url,MModuleNo,MModuleName,CModuleNo,CModuleName,picpath,nexus,title  from ModuleCortrol where   nexus='C' and CModuleNo in(select ModuleNo from  PopedomConrtrol where SellerId='"+userid+"' and choose=1) ORDER BY nexus DESC, CModuleNo";//and nexus='C' ManModuleCortrol
 
	
	  ResultSet rs=null;
	  int i=0;
	  
	  rs = userBean.executeQuery(SqlStr);
  	if (rs.next()){ 
	 
	i++;
	 
 %>
   <tr valign="top" align="left"><td ></td>
    <td   height=30 >
   <IMG height=20 src="../images/circle.gif" 
    width=20><%if (!no.equals("DESKTOP")){ out.print(rs.getString("MModuleName").substring(0,4));}else{out.print("我的桌面");} %> 
   </td> 
    </tr>
	 <tr><td   align="right"  colspan="3"></td></tr>
	
   <%} rs.close();
 %>
 </table> <table   border="0"  align="left" >
 <%	  int num=0; 
   if (no.equals("DESKTOP")){
      SqlStr="select Url,MModuleNo,MModuleName,CModuleNo,CModuleName,picpath,nexus,title  from ModuleCortrol where   nexus='C' and CModuleNo in(select ModuleNo from  PopedomConrtrol where SellerId='"+userid+"' and choose=1) ORDER BY nexus DESC, orderby ,CModuleNo";//and nexus='C' ManModuleCortrol
 	  rs = userBean.executeQuery(SqlStr);
  	while (rs.next()){ 
	if (num==0){
	 %>
    <tr align="center"><!--onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)'-->
	<td   width="50" height="13" >&nbsp;</td><%} num++;	%>
    <td   width="16" height="13" ></td>
    <TD align="center" width="60"  background="" onclick="openwin('../<%=getbyte(rs.getString("Url"))  %>?para=<%=rs.getString("CModuleName")  %>',900,600,10,10);changeclass(this,'L3','L2');"    style="cursor:hand;"><IMG     src="<%=getbyte(rs.getString("picpath")) %>"    > <br>
    <%=rs.getString("CModuleName") %></a></TD>
	<%if (num==10){ out.print("</tr>");num=0;}%>
	 
 
	<%}
	rs.close();
	}else{
	
	  no=request.getParameter("MModuleNo");
	
       
        SqlStr="select Url,MModuleNo,MModuleName,CModuleNo,CModuleName,picpath,nexus,title  from ModuleCortrol where   nexus='C'and  MModuleNo ='"+no+"' and CModuleNo in(select ModuleNo from  PopedomConrtrol where SellerId='"+userid+"') ORDER BY nexus DESC, orderby ,CModuleNo";//and nexus='C' ManModuleCortrol
		if (no.equals("DESKTOP"))
	    SqlStr="select Url,MModuleNo,MModuleName,CModuleNo,CModuleName,picpath,nexus,title  from ModuleCortrol where   nexus='C' and CModuleNo in(select ModuleNo from  PopedomConrtrol where SellerId='"+userid+"' and choose=1) ORDER BY nexus DESC, orderby ,CModuleNo";//and nexus='C' ManModuleCortrol
	
	    num=0;   
		
		
	  rs = userBean.executeQuery(SqlStr);
  	while (rs.next()){if (num==0){
	 %>
    <tr valign="top" align="center"><!--onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)'-->
	<td   width="50" height="13" >&nbsp;</td><%} num++;	%>
    <td   width="16" height="53" ></td>
    <TD  align="center"  width="60" onclick="openwin('../<%=getbyte(rs.getString("Url"))  %>?para=<%=rs.getString("CModuleNo")  %>',900,600,10,10);changeclass(this,'L3','L2');"  style="cursor:hand;" title="<%= rs.getString("title")%>"><IMG     src="<%=getbyte(rs.getString("picpath")) %>"    ><br> 
 <%=rs.getString("CModuleName") %></a></TD> 
 <%if (num==10){ out.print("</tr>");num=0;}%>
	 
	 
	 
	 
<%}
rs.close();
 
 }
 String userDept=(String)session.getAttribute("logindept");
 
 %>	
   <tr valign="top" align="center"> 
    <td      colspan="3"> </td> 
    </tr>
	 
	 
    <tr valign="top" align="center"> 
    <td     colspan="3" >
   <IMG height=20 src="../images/circle.gif" 
    width=20>待办提醒</td> 
    </tr>
	
	
	
	 
 </table> 
 
 </td>
 
 </tr>
   <tr><td align="right"  ><img src="../images/color.gif" height="1" width="100%"></td></tr>
 </table>
 <table valign="top" border="0"  width="100%" height="60%" align="left">
 <%if (userDept.indexOf("财务")>=0){ %>
	  <tr valign="top" align="center"><td ></td>
    <td   height=30 >
	  <IFRAME ID="eWebEditor1" src="../finance/new_alert.jsp" frameborder="0" scrolling="auto" width="95%" height="100%" ></IFRAME>
	                   
	 </td> 
    </tr>
	<%}else if (userDept.indexOf("销售")>=0){ %>
	
	  <tr valign="top" align="center"><td ></td>
    <td   height=30 >
	  <IFRAME ID="eWebEditor1" src="../sale/visitcusview_alert.jsp" frameborder="0" scrolling="auto" width="100%" height="99%" ></IFRAME>
	                   
	 </td> 
    </tr>
	
	<%} %>
 </table>
  </form>
</body>
</html>
