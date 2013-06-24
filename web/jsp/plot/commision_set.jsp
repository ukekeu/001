<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,java.util.*,common.*,java.lang.String.*,javax.servlet.ServletRequest.*"%>
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/checktime.jsp"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/CheckSection.jsp"%>
   <%@ include file="../public_js/getByteOut.jsp"%>
 
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
	<title>佣金设置</title>
</head>
<script language="javascript" src="../public_js/public.js">
</script>

 
<% 
String section=getbyte1(request.getParameter("Section")); 
 
 
try{
    defaultNo=(String)session.getAttribute("defaultNo");
}catch(Exception s){
}
if ( defaultNo == null ) {
    defaultNo="";//如何用户未设置默认楼盘，则显示用户选中或所有楼盘的楼栋
}
if (!defaultNo.equals(""))
{
    SectionS=defaultNo;
    SecNo=defaultNo;
}
 
if ( !SecNo.equals("") ) { 
    FindWhere=" where SerialNo='"+SecNo+"'";
}else{
    FindWhere=" where SerialNo in("+SectionS+")";
}

%> 
<body onload="setSelectMad(document.forms[0].Section, '<%= section %>');">
<form name=frm method=post>
<p align="center" class=FontColor>
<font size=3>佣金提成比例一览表</font></p>
<table width=90% ALIGN=center><tr height="16" bgcolor="#EAEAEA"><td>所属搂盘<select name="Section" onchange="document.forms[0].submit() ;">
<option></option>
   
 		<%
			String firstNo = "" ;
			String getStr = "select serialNo, name from CRM_Project where SerialNo in("+SectionS+")" ;
			ResultSet getRs = ViewBean.executeQuery(getStr) ;
			int i = 0 ;
			while (getRs.next()) {
				i++ ;
				String no = getRs.getString("serialNo") ;
				String name = getRs.getString("name") ;
				name = getbyte(name) ;
				if (i == 1)
					firstNo = no ;
				if (section.equals("")) {
					section = firstNo ;
					session.setAttribute("Advertise-Section", section) ;
				}		
		%>
			<option value="<%= no %>"><%= name %>
		<%
			}
			getRs.close() ;
		%>	
		<option value="All">
      </select></td><td align="right">
   
 <input type=button value="增加佣金" title="增加佣金提成比例"  onclick="openwin('add_commision.jsp?Section='+document.frm.Section.value,330,300,100,100);"><!--<img  src="../picture/button_xg.gif" title="修改佣金提成比例" onclick="openwin('modi_comm.jsp?code='+comm_code,330,300,100,100);" >--><input type=button value=" 批量删除" title="删除佣金提成比例"  onclick="DeleC();">
	<input type=hidden name=SetNo>	
	<input type=hidden name=CancelNo>	
	   </td></tr></table>
<table border="0" width=90%" CELLSPACING=1 CELLPADDING=3 ALIGN=center>
<tr class=TITLE align="center"><td>&nbsp;</td><td>楼盘名称</td><td>提成比例</td><td>用途</td><td></td>
 </tr>
<%
String sellerid[]=request.getParameterValues("choose");
String sellers="";
if (sellerid!=null){
for (int a=0;a<sellerid.length;a++){
 if (sellers.equals(""))sellers=sellerid[a];
 else sellers+=","+sellerid[a];
}
if (!sellers.equals("")){
  sellers="("+sellers+")";
   ViewBean.executeUpdate("delete commision_scale where code in "+sellers);
  }
}


if (getbyte1(request.getParameter("Section")).equals(""))
   FindWhere=" and  c.section_no "+FindWhere.substring(FindWhere.indexOf("in"));
else 
  FindWhere=" and  c.section_no='"+  getbyte1(request.getParameter("Section"))+"'";
 String SQL="SELECT c.code,s.name,c.scale,c.yong_tu FROM commision_scale c,CRM_Project s where c.section_no=s.serialno "+FindWhere;

 ResultSet reRs=ViewBean.executeQuery(SQL); 
 int ii=0;
  while (reRs.next()){
  %>
  <tr  align="center" id=TR<%=ii %> class=listcontent onmouseover="mout(this);"  onclick="savepara('<%=getbyte(reRs.getString("code"))%>');changeclass1(this,'clickbg','listcontent');">
  <td><input type="checkbox" name="choose" value="<%=getbyte(reRs.getString("code")) %>"></td>
  <td><%=getbyte(reRs.getString("name")) %></td>
  <td><%=FormatD.getFloat(reRs.getFloat("scale"),2) %>‰</td>
  <td><%= reRs.getString("yong_tu")%></td>
  <td><a href="#" onclick="savepara('<%=getbyte(reRs.getString("code"))%>');DeleC();">删除</a></td>
  </tr>
 <%ii++;} %>

</table>
</form>
<script>
var comm_code="";
function savepara(aa){
  comm_code=aa;
}
function DeleC(){
if (confirm("确认删除吗？")){

  var i=0;
  var id="";
  if (document.frm.choose.length)
	  for(var aa=0;aa<document.frm.choose.length;aa++){
	      if (document.frm.choose[aa].checked)i++;
 }else{
    if (document.frm.choose.checked){i++;id=document.frm.choose.value;}
  
  }  
     if (i==0){alert("请选择需要删除的销售员资料");return false;}
	if (confirm("确认删除吗？"))
 

 document.frm.action="commision_set.jsp?code="+comm_code;
 document.frm.submit();
}
}



 
</script>
</body>
</html>
