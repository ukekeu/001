  <%@ page contentType="text/html;charset=GBK" %>
   <%@ include file="public_js/checktime.jsp"%>
  <%@ page import="java.sql.*,java.util.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase" />
    <jsp:useBean id="aa" scope="page" class="regcheck.GetMACAddress" />
    <%@ include file="public_js/getByteOut.jsp"%>
<html>
<LINK href="class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
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
</script>
 
<body  topmargin="0"  >
<form name=ok>

<TABLE id=Table1 cellSpacing=0 cellPadding=0 width="90%" align=center 
  border=0><TBODY>
  <TR>
    <TD background=images/mk_dd.gif height=23>&nbsp;</TD>
    <TD vAlign=bottom align=right width=60><SPAN 
  class=style8>功能介绍</SPAN></TD></TR></TBODY></TABLE>
  <TABLE id=Table2 cellSpacing=0 cellPadding=0 width="90%" align=center 
bgColor=#efcec6 border=0>
  <TBODY>
  <TR>
    <TD height=5></TD></TR></TBODY></TABLE>
<table width="93%"  border="0"  align="center">

 <input type=hidden name=userhelp value="<%=request.getParameter("help") %>">
 <%  //try{
     int i=0;
	 rs = ViewBean.executeQuery(SqlStr);
	while (rs.next()){ 
	 if (i==0){
 %>
   <tr align="center">
    <td  width=40 height=30 title="<%=getbyte(rs.getString("title"))  %>"   >
   <IMG height=20 src="images/circle.gif" 
    width=20></td><td  align="left"><%=rs.getString("MModuleName") %>
   </td> 
    </tr>
	<tr align="center">
    <td  width=40 height=15  colspan="2">&nbsp;</td>
   
    </tr>
	
   <%}i++; %>
    <tr>
   <TD align=right width=40><IMG height=5 hspace=5 src="images/trigon.gif" 
      width=3></TD>
    <TD bgColor=#fef2f0 title="<%=getbyte(rs.getString("title"))  %>"><a href="#" onclick="operwin('<%=getbyte(rs.getString("url"))  %>');return false;">
<SPAN class=style4>&nbsp;<SPAN 
      class=style8><%=rs.getString("CModuleName") %> </SPAN></SPAN></a></TD></TR>
	   <tr> 
  <TD align=right width=40>&nbsp;</TD>
    <TD ><font size=2><%=getbyte(rs.getString("title"))  %></font></TD></TR>
	 <tr align="center">
    <td  width=40 height=15  colspan="2">&nbsp;</td>
   
    </tr>
   
	 
<%}
rs.close();
 


 %>	 
 </table>
<table width="95%"   border="0"  align="center">
	  
 <tr align="center"><td>&nbsp;<img src="images/cl.jpg" width="443" height="172"></td></tr>
 
 <tr align="center"><td> &nbsp;</td></tr>
  <tr align="center"><td>  &nbsp; </td></tr>
 
   <tr align="center"><td>  &nbsp; 请刷新重新登录！</td></tr>
    <tr align="center"><td> &nbsp;</td></tr>
	 
 </table>
  </form>
</body>
</html>
