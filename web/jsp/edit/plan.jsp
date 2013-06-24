<%@ page contentType="text/html;charset=GBK" %>
 <%@ page language="java" import="java.sql.*,common.*,java.util.*,java.util.Date" %> 
 <jsp:useBean id = "Bean" scope = "page" class = "ConnDB.ConnODBC" />
 
  <%@ include file="../inc/getByteOut.jsp"%>

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
<script Language="JavaScript" src="../js/calendar.script"></script>
<script Language="JavaScript" src="../js/Popup.js"></script>
<% String username=getbyte(request.getParameter("username"));
String Date1=getbyte(request.getParameter("sDate"));
String Date2=getbyte(request.getParameter("eDate"));
String tuser=getbyte(request.getParameter("tuser"));
String Description=getbyte(request.getParameter("content1"));
String EMPNAME=(String)session.getAttribute("EMPNAME");
if (!Description.equals("")){
String SQL="insert into dayplan(userid,sdate,edate,context,jsperson,name) values('"+username+"','"+Date1+"','"+Date2+"','"+Description+"','"+tuser+"','"+EMPNAME+"')";
 
Bean.executeUpdate(SQL);
 
 %>
 <script>opener.window.location="../page/myplan.jsp";window.close();</script>
 <%} %>
<body>
<form name=myform method="post" action=""> 
      
            <table width="100%"  border="0" cellpadding="3" cellspacing="1" bgcolor="A9A9A9">
             <input type=hidden name="username" size=50 value="<%=(String)session.getAttribute("USERNAME") %>"></td>
           
            <tr><td align="center">工作内容</td></tr>
            <tr bgcolor="DEDEDE">
          
              <td  >&nbsp; 
			  			<textarea cols="95" rows="14" name="content1"></textarea>
		 
			  </td>
            </tr>
           
           
            <tr bgcolor="DEDEDE">
               <td><b>开始日期:</b> 
               &nbsp;<input type=text name="sDate" onkeyUp='formatDate(this);' onblur='checkDate(this);'><input type=button name=dd value="..." onclick="fPopUpCalendarDlg(sDate,'../');" > 
             <b>结束日期:</b> 
              &nbsp;<input type=text name="eDate" onkeyUp='formatDate(this);' onblur='checkDate(this);'><input type=button name=dd2 value="..." onclick="fPopUpCalendarDlg(eDate,'../');" ></td>
            </tr>
          
           
          <tr bgcolor="DEDEDE">
               <td><b>开放给:</b> 
            <input type="text" name="tuser1" size="70" class="input4">
				  <input type="hidden" name="tuser" size="70" class="input4">			  
							  <input type="button" name="sendman1" value="选择" onClick="window.open('../sys/user_tree3.jsp?selectman=form1.tuser1','f','menubar=no,scrollbars=yes,width=600,height=460,left=150,top=50')">
                            </tr>
            <tr bgcolor="DEDEDE">
              
              <td>&nbsp;<input type=button name=ok value="保存我的计划" onclick="checkdata();">&nbsp;&nbsp;<input type=button name=can value="退出操作" onclick="check()">  &nbsp;&nbsp;&nbsp;&nbsp;说明:系统不允许计划跨月的工作计划</td>
            </tr>
          </table> 
</form>
<script>
function check(){
if (document.frm.projectname.value!=""){
 if (confirm("The confirmation returns?"))window.location="Visitors.asp";
}
window.location="Visitors.asp";
}
function checkdata(){
 
 if (document.myform.sDate.value==""){alert("Please fill in Start Date");document.myform.sDate();return false;}
if (document.myform.eDate.value==""){alert("Please fill in End Date");document.myform.eDate.focus();return false;}
document.myform.submit();
return true;

}
</script>
</body>
</html>
