<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 
<title>常用代码设置</title>
</head>

<%@ page import="java.sql.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />

<body onload="document.frm.codename.focus();" oncontextmenu="return false" >
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="JavaScript" src='../public_js/public.js'></script>
<form name=frm method="post"  action="savecode.jsp"> 
<%@ include file="../public_js/getByteOut.jsp"%>
 
<center>

 <p align="center"><font size=3 class=FontColor><b>常用代码设置</b></font></p>
<input type=hidden name=codetype1 value="<%=request.getParameter("codetype") %>">
<input type=hidden name=codetypename value="<%=getbyte1(request.getParameter("CodeName")) %>">
<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >
   
  <tr  ALIGN=center>
    <td width="20%" class=listtitle ><font color=white>代码名称</font></td>  
    <td width="50%" ALIGN=left class=roomright  >&nbsp;<input type=text name=codename  size=20　></td>
  </tr>
  <tr  ALIGN=center>
    <td width="20%" class=listtitle ><font color=white>备注</font></td>  
    <td width="50%" ALIGN=left class=roomright  >&nbsp;<textarea cols="20" rows="3" name="bak"></textarea></td>
  </tr>
  </table>

  <p align="center"> 
 
            &nbsp;&nbsp;
			<input type=button name=submit1 value="提 交" onclick="save1();">
		
           &nbsp;
		   <input type=button name=cancel value="关 闭" onclick="window.close();">
	   &nbsp;
    
          </P>
    <input type=hidden name=save value="确定">



</center>
</form>
<script>
var RSID="";
function delSeller() {
    if (RSID!=""){
		if ( confirm("确实想删除该条记录?"))
			window.location = "savecode.jsp?id=" + RSID;
    }else{
	
	alert("请选择你要删除的代码");
	}
	}

 function cancel(){
   document.frm.codename.value="";
   document.frm.codetypename.value="";
   document.frm.codetype1.value="";
 
 }	
 
 
  function Validate()
   {
	 if (document.frm.codetype1.value.length<1){ 
		{
	       alert("请输入你的类型代码(请参考系统帮助说明)");
	       return (false);}
		}
     if (document.frm.codetypename.value==""){
        alert("请输入你的代码类型名称");
	     return (false);}
    if (document.frm.codename.value==""){
        alert("请输入你的代码名称");
        return (false);}
   return (true);
   }
   
 function save1(){
 if (Validate()){
   document.frm.action="savecode.jsp";
   document.frm.submit();
 
 }
 } 
</script>
</body>

</html>
