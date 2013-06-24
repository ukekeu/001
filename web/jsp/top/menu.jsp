  <%@ page contentType="text/html;charset=GBK" %>
  <%@ page import="java.sql.*,java.util.*" %>
  <%@ include file="../public_js/checktime.jsp"%>
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
String no=request.getParameter("MModuleNo");
String SqlStr="select Url,MModuleNo,MModuleName,CModuleNo,CModuleName,picpath,nexus,title  from ModuleCortrol where   nexus='C'and  MModuleNo ='"+no+"' and CModuleNo in(select ModuleNo from  PopedomConrtrol where SellerId='"+userid+"') ORDER BY nexus DESC, CModuleNo";//and nexus='C' ManModuleCortrol
	  ResultSet rs=null;
 
%>
<script>
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
</script>
 
<body  topmargin="0" leftmargin="0"   marginheight="100%" >
<form name=ok>
<table width="110%"   height="97%" border="0"  align="center"background="../images/leftmenu_title_middle.gif" >

 <input type=hidden name=userhelp value="<%=request.getParameter("help") %>">
 <%  //try{
     int i=0;
	 rs = ViewBean.executeQuery(SqlStr);
	while (rs.next()){ 
	 if (i==0){
 %>
   <tr valign="top" align="center"><td   width="16" height="13" ></td>
    <td   height=30 title="<%=getbyte(rs.getString("title"))  %>"   >
   <IMG height=20 src="../images/circle.gif" 
    width=20><%=rs.getString("MModuleName") %>
   </td> 
    </tr>
	 
	
   <%}i++; %>
    <tr valign="top"><!--onMouseOver='OverArrow(this)'  onMouseOut='OutArrow(this)'-->
    <td   width="16" height="13" ></td>
    <TD onclick="window.parent.main.location='../<%=getbyte(rs.getString("url"))  %>';" bgColor=#fef2f0  style="cursor:hand;" title="<%=getbyte(rs.getString("title"))  %>"><IMG    height=5 hspace=5 src="../images/trigon.gif"   width=3> 
<SPAN class=style4><SPAN 
      class=style8><%=rs.getString("CModuleName") %> </SPAN></SPAN></a></TD></TR>
	 
	 
<%}
rs.close();
 


 %>	 
 </table> 
<table   background="../images/bottom_left.gif"   width="18" height="13"  align="left" >
<tr><td></td></tr>
 
 </table> 
  </form>
</body>
</html>
