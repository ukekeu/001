<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>������</title>
</head>


<script language="javascript" src="../public_js/public.js"></script>
 <script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
 
<script>
function check(aForm){
   if (aForm.name.value.length<1)
	  	{
	   	alert("���������");
	     aForm.name.focus();
	     return (false);
	   }	
 
 if (aForm.handler.value.length<1)
	  	{
	   	alert("��ѡ�������");
	     aForm.handler.focus();
	     return (false);
	   }		
  
 return (true);
}
</script>
<body> 
<p align=center><font size=3 class=FontColor><b>֪ʶ�����</b></font></p>
<form method="POST" name="form1" action="knowlege_type_ac.jsp" onsubmit="return check(this);">
<input type=hidden name="typestate" value="<%=request.getParameter("state") %>">
<input type=hidden name="sel" value="<%=request.getParameter("sel") %>">
<table width="100%" border="0" cellspacing="1"  cellpadding="1" >
 
  <tr>
    <td width="15%" class=roomleft >&nbsp;�������</td>
    <td width="75%" class=roomright> <input type=text   name="name"></td>
  </tr>
 
  <tr>
    <td width="15%"class=roomleft>&nbsp;�����û�</td>
    <td width="75%"class=roomright>
     <textarea name="handler" cols="30" rows="5"></textarea><input type=button name=choose value="ѡ���û�" onclick="openwin1('user_list.jsp',300,400);">         
       </td>
	   </tr>
	      
</table>
<p>
<div align="center"> 
            <input type="submit" value="�ᡡ��" name="submit" >
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="button" value="��  ��" name="cancel" onclick="window.close();">
          </div>
</p>
  </form>       
</body>

</html>
