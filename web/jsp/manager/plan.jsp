 <%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>我的日程计划</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.bg {
	background-image: url(images/index3_03.jpg);
	background-repeat: repeat-y;
	background-position: left top;
}
-->
</style>
</head>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

<body>
<form name=frm method="post" action="planaction.jsp"> 
             <table width="100%"  border="0" cellpadding="3" cellspacing="1" bgcolor="A9A9A9">
             <input type=hidden name="name" size=50 value="<%=(String)session.getAttribute("loginid") %>"></td>
           
		       <tr bgcolor="DEDEDE">
               <td><b>开始日期:</b> 
               &nbsp;<input type=text name="sDate" size=10 onkeyUp='formatDate(this);' onblur='checkDate(this);'><input type=button name=dd value="..." onclick="fPopUpCalendarDlg(sDate);" > 
             <b>结束日期:</b> 
              &nbsp;<input type=text name="eDate" size=10 onkeyUp='formatDate(this);' onblur='checkDate(this);'><input type=button name=dd2 value="..." onclick="fPopUpCalendarDlg(eDate);" ></td>
            </tr>
		   
            
            <tr bgcolor="DEDEDE">
          
              <td  > 
			<!-- <INPUT type="hidden" name="content1" value="">
			<IFRAME ID="eWebEditor1" src="../edit/ewebeditor.jsp?id=content1&style=coolblue" frameborder="0" scrolling="no" width="550" height="350"></IFRAME>-->
	       <textarea cols="76" rows="10" name="content1"></textarea>
			  </td>
            </tr>
           
          
          </table> 
		       <p align="center"> <input type=button name=ok value="保存我的计划" onclick="checkdata();">&nbsp;&nbsp;<input type=button name=can value="退出操作" onclick="window.close();"> 
               </p>
		  </form>

<script>
function check(){
if (document.frm.projectname.value!=""){
 if (confirm("The confirmation returns?"))window.location="Visitors.asp";
}
window.location="Visitors.asp";
}
function checkdata(){
 if (document.frm.name.value==""){alert("Please fill in  Name");document.frm.name.focus();return false;}
 if (document.frm.sDate.value==""){alert("Please fill in Start Date");document.frm.sDate();return false;}
if (document.frm.eDate.value==""){alert("Please fill in End Date");document.frm.eDate.focus();return false;}
document.frm.submit();
return true;

}
</script>
</body>
</html>
