<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>

<%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
   <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>文档一览</title>
</head>


<script language="javascript" src="../public_js/public.js"></script>
 <script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

	 
<script>
function check(aForm){
   if (aForm.title.value.length<1)
	  	{
	   	alert("请输入主题！");
	     aForm.title.focus();
	     return (false);
	   }	
  
 if (aForm.date.value.length<1)
	  	{
	   	alert("请选择日期！");
	     aForm.date.focus();
	     return (false);
	   }	 	     
 return (true);
}
</script>
<body> 
<p align=center><font size=3 class=FontColor><b>文件信息登记</b></font></p>
<form method="POST" name="cus" action="addknowledge_at1.jsp" onsubmit="return check(this);"  ENCTYPE="multipart/form-data">
<table width="100%" border="0" cellspacing="1"  cellpadding="1" >
 
  <tr>
    <td width="15%" class=roomleft >&nbsp;类 别</td>
    <td width="75%" class=roomright>
	<select name=type>
	<%String StrSql="select type from knowledge_type   where typestate=0 ";
	 ResultSet codeRS=ViewBean.executeQuery(StrSql);
     
     while (codeRS.next()){
	 String type=getbyte(codeRS.getString("type"));
       out.print("<option value='"+type+"'>"+type+"</option>");
	 
   }
   codeRS.close();
 %>
	</select>
	　</td>
  </tr>
 
  <tr>
    <td width="15%"class=roomleft>&nbsp;主    题</td>
    <td width="75%"class=roomright>
  
          <input type=text   name="title">         
       </td>
	   </tr>
	   <tr>
          <td width="15%"class=roomleft >&nbsp; 正   文</td>
          <td width="75%"class=roomright>
		  <INPUT type="hidden" name="content1" value="">
			 <IFRAME ID="eWebEditor1" src="../edit/ewebeditor.jsp?id=content1&style=coolblue" frameborder="0" scrolling="no" width="550" height="350"></IFRAME>
	      </td>   
        </tr>
      <tr>
          <td width="15%"class=roomleft >&nbsp; 日  期</td>
          <td width="75%"class=roomright>
		  <input type=text size="12" name="date"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(date);return false">       
       </td>   
       </tr>
		<tr>
          <td width="15%"class=roomleft >&nbsp; 附   件</td>
          <td width="75%"class=roomright>
		  <input type="file" name="Map"  >
		  </td>   
        </tr>
		
</table>
<p>
<div align="center"> 
            <input type="submit" value="提　交" name="submit" >
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="button" value="退  出" name="cancel" onclick="window.close();">
          </div>
</p>
  </form>       
</body>

</html>
