<%@ page contentType="text/html;charset=GBK" %>  
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.util.*,java.sql.*" %>

  <jsp:useBeanid="onlineuser" class="online.ListUser" scope="application"/>

<html>
<head>

<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>菜单</title>
<style>
<!--      
.p1{font-size: 12px;line-height:14pt;}
.p2{font-size: 12px;line-height:12px;}
.L1{font-size: 14.8px; font-family: 宋体;line-height:14pt;}
.L2{font-size: 12px; font-family: 宋体;line-height:14pt;}
.L3{font-size: 12px; font-family: 宋体;line-height:18pt;}
a.pblue:link{color: #000080; text-decoration: none}
.pblue{ color: #000080;}
.mfei {font-size: 11px;}
a { color: #666666;text-decoration: none;}
body {
	background-color: #2982EF;
}
-->
</style>

<base target="contents">

</head>
<%String online="";
Vector vt=onlineuser.getOnLineUser(); 
  Enumeration e = vt.elements(); 
    while(e.hasMoreElements())
  { 
   if (!online.equals(""))online+="/";
   online+=(String)e.nextElement(); 
    
  }  %>
<script>
function out(){
     if (confirm("确认退出系统吗？"))
	 window.parent.location='../outSys.jsp'
   }
   
 function openwin(url,wh,hg,lf,tp) {
  var newwin=window.open(url,"newwin","toolbar=no,location=no,directories=yes,status=yes,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
  
}
function userhelp(){
openwin("../help/"+window.parent.main.document.ok.userhelp.value,600,500,100,50);
 
}
   </script>
<body topmargin="0" leftmargin="0" title="当前在线名单：<%=online %>"  >
 
<table width="100%" height="66"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td  valign="top" width="25%" height="64" valign="bottom" bgcolor="#2982EF"><img src="top_img.gif" width="418" height="64"></td>
     <td valign="top">

	<td width=55%" align="right"  bgcolor="#2982EF">
<table width="185"  border="0" cellspacing="0" cellpadding="0" border="0">
      <tr align="center">
        <td><a title="U客软件" href="#" onclick="window.open('http://www.uk.com.cn/');return false;"     target=rightp>
		<img  src="top_home.gif" width="37" height="35" hspace=10 vspace="3" border=0 title="进入U客软件公司网站"　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　></a></td>
      
	    <td><a title="U客软件" href="javascript:window.parent.rightp.location.reload();"     target=rightp>
		<img  src="top_home.gif" width="37" height="35" hspace=10 vspace="3" border=0 title="我的任务提醒"　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　></a></td>
        <td><a href="#"  onClick="userhelp();return false;"><img src="top_help.gif" alt="弹出帮助窗口" name="Image2" width="37" height="35"   border="0"></a></td>
        <td><a href="#"  onClick="out();return false;"><img src="top_logout.gif" name="Image4" width="37" height="35" hspace="5"   border="0"></a></td>
      
      </tr>
    </table></td>
  </tr>
  <tr bgcolor="#1C69C5">
    <td height="2" colspan="2"></td>
  </tr>
</table>
</body>
</html>
