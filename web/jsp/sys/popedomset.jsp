<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<title>常用代码设置</title>
</head>

<%@ page import="java.sql.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />

<body  oncontextmenu="return false">
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="JavaScript" src='../public_js/public.js'></script>
<form name=frm method="post"  action="savecode.jsp">
<script>
function selecode(){
  document.frm.codetype.value=document.frm.TYPE1.options[document.frm.TYPE1.selectedIndex].value; 
  document.frm.codetypename.value=document.frm.TYPE1.options[document.frm.TYPE1.selectedIndex].text;
  MM_showHideLayers('CODE','','hide');
  sh3="false";
  document.frm.codename.focus();
}
</script>
<div id="CODE" style="position:absolute; left:350px; top:60px; width:150px; height:52px; z-index:1; visibility: hidden"> 

<%@ include file="../public_js/getByteOut.jsp"%>

 <select  name="TYPE1"  onchange="selecode();" multiple size=10>
 <%String sql="select type,TYPENAME from code   group by type,TYPENAME"; 
   ResultSet rs=null;
  try{
   rs=aBean.executeQuery(sql);
   while (rs.next()){
   String type=rs.getString("type");
   String name= rs.getString("typename") ;
     name =getbyte(name);// new String(name.getBytes("iso-8859-1"));
    out.println("<option value="+type+">"+name+"</option>");
   }
  }catch(Exception s){out.println(s.getMessage());}
  
  rs.close(); %>
  </select>
</div>

<center>

<table BORDER=0 width="70%" >
<tr><td  width="50%">

<table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#000000" class="tablefill">
  <tr>
    <td width="100%" colspan="4">
	<br>
      <p align="center"><font size=3><b>常用代码设置</b></font></td>
  </tr>
  <tr>
    <td width="50%"  >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;代码类型</td>  
    <td width="50%"  >&nbsp;<input type=text name=codetype  size=10 onblur="toUpper(document.frm.codetype);"><input type=button name=sele value=".." title="选择存在的类型" onclick="shList('CODE');"></td>
  </tr>
  <tr>
    <td width="50%"  >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;类型名称</td>  
    <td width="50%"  >&nbsp;<input type=text name=codetypename  size=10></td>
  </tr>
<!--
  <tr>
    <td width="50%"  >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;代码编号</td>
    <td width="50%"  >&nbsp;<input type=text name=codeno  size=10></td>
  </tr>
-->  
  <tr>
    <td width="50%"  >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;代码名称</td>  
    <td width="50%"  >&nbsp;<input type=text name=codename  size=20></td>
  </tr>
  
  </table>
  </td>
  
  <td  width="20%"><table>
  <tr>
    <td width="25%">　</td>
    <td width="25%"><input type=submit name=save value="确定"></td>
    <td width="25%"><input type=reset name=cancel value="重写">　</td>
    <td width="25%"><input type=reset name=del value="删除" onclick="delSeller(RSID);"></td>
  </tr>
  </table>
</td></tr>
</table>

</center>
</form>
<jsp:include page="codelist.jsp" flush="true"/>
</body>

</html>
