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
<title>��������</title>
</head>


<script language="javascript" src="../public_js/public.js"></script>
 <script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

	 
<script>
function check(aForm){
   if (aForm.title.value.length<1)
	  	{
	   	alert("���������⣡");
	     aForm.title.focus();
	     return (false);
	   }	
  
 if (aForm.date.value.length<1)
	  	{
	   	alert("��ѡ�����ڣ�");
	     aForm.date.focus();
	     return (false);
	   }	 	     
 return (true);
}
</script>
<body> 
<p align=center><font size=3 class=FontColor><b>��������</b></font></p>
<form method="POST" name="cus" action="addkgongao_at.jsp" onsubmit="return check(this);"  ENCTYPE="multipart/form-data">
<table width="100%" border="0" cellspacing="1"  cellpadding="1" >
 
  <tr>
    <td width="15%" class=roomleft >&nbsp;����</td>
    <td width="75%" class=roomright>
	 <input type=text  size=50  name="dept"><input type=button name=set value="����" onclick="openwin1('dept_list.jsp',300,400);">&nbsp;      
	 
	��</td>
  </tr>
 
  <tr>
    <td width="15%"class=roomleft>&nbsp;��    ��</td>
    <td width="75%"class=roomright>
  
          <input type=text  size=50  name="title">         
       </td>
	   </tr>
	   <tr>
          <td width="15%"class=roomleft >&nbsp; ��   ��</td>
          <td width="75%"class=roomright>
		  	<INPUT type="hidden" name="content1" value="">
		      <IFRAME ID="eWebEditor1" src="../edit/ewebeditor.jsp?id=content1&style=coolblue" frameborder="0" scrolling="no" width="550" height="350"></IFRAME>
	                  
		  </td>   
        </tr>
      <tr>
          <td width="15%"class=roomleft  colspan="2">&nbsp; ��ʼ����    
		  <input type=text size="12" name="date"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(date);return false">       
       &nbsp; �������� 
        
		  <input type=text size="12" name="date1"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(date1);return false">       
       </td>    
       </tr>
		<tr>
          <td width="15%"class=roomleft >&nbsp; ��   ��</td>
          <td width="75%"class=roomright>
		  <input type="file" name="Map1"  >
		  </td>   
        </tr>
		<tr>
          <td width="15%"class=roomleft >&nbsp; ��   ��</td>
          <td width="75%"class=roomright>
		  <input type="file" name="Map2"  >
		  </td>   
        </tr>
		<tr>
          <td width="15%"class=roomleft >&nbsp; ��   ��</td>
          <td width="75%"class=roomright>
		  <input type="file" name="Map3"  >
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
