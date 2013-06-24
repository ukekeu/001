<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>送案登记</title>
</head>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
  <%@ page import="java.sql.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
<%@ include file="../public_js/getByteOut.jsp"%>
<%String ContractNo =request.getParameter("contract"); %>
 
<body  >
 <form method="POST" name=frm action="">
 <input type=hidden name=contractno value="<%= ContractNo %>">
   <center>
 <p><font class=FontColor size=3><b>送案登记</b></font></p>
  <table width="100%" border="0" cellpadding="3" cellspacing="1">
  <tr>
    <td width="40%" class=roomleft >送案日期</td>
    <td width="60%" class=roomright >
    <input type="text" name="INDATE" size="20"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(INDATE);return false;" title="请选择日期">
    
    </td>
  </tr>
  <tr>
    <td width="40%" class=roomleft>经&nbsp;办&nbsp;人</td>
    <td width="60%" class=roomright><input type=text size=15 name=HANDLE value="<%=(String)session.getAttribute("loginname") %>" onkeydown="key(document.frm.checker)"></td>
  </tr>
  <tr>
    <td width="40%">出案提醒设置：</td>
    <td width="60%">　</td>
  </tr>
  <tr>
    <td width="40%" class=roomleft><input type="radio" checked  name="R1" onclick="chec()">在送案后</td>
    <td width="60%" class=roomright><input type="text" name="day" size="5" value=5>天后开始提醒</td>
  </tr>
  <tr>
    <td width="40%" class=roomleft><input type="radio"  name="R1" onclick="chec()">固定日期</td>
    <td width="60%" class=roomright><input type="text" name="DATE" size="20"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(DATE);document.frm.R1[1].checked=true;return false;" title="请选择日期"></td>
  </tr>
  <tr>
    <td width="40%" class=roomleft>备 注</td>
    <td width="60%" colspan="3" class=roomright><textarea cols="25" rows="2" name="context"></textarea></td>
  </tr>
 
</table>
<input type=hidden name=check value=1>
 <p align="center"> 
 <input type=button name=aa value="提 交" onclick="loca();">
  <input type=button name=aa1 value="关 闭" onclick="window.close()">
        
          </P>

 </center>
  </form>
  <script>
  function chec(){
   if (document.frm.R1[0].checked)
   document.frm.check.value="1";
   else
   document.frm.check.value="2";
 
  }
  function Validate(aForm)
{ 

      if (document.frm.INDATE.value==""){
           alert("请输入送案日期");
           document.frm.INDATE.focus();
           return (false);
        }
		
    if (document.frm.HANDLE.value==""){
           alert("请输入经办人");
           document.frm.HANDLE.focus();
		   return (false);
	}	   
	if (document.frm.R1[0].checked)
     {
        if (document.frm.day.value==""){
           alert("请输入提醒时间");
           document.frm.day.focus();
           return (false);
        }
     }else{
	   if (document.frm.DATE.value==""){
           alert("请输入提醒日期");
           document.frm.DATE.focus();
           return (false);
        }
	 
	 }
	  if (document.frm.DATE.value!=""&&document.frm.DATE.value<document.frm.INDATE.value){
           alert("送案日期不能大于出案日期");
           document.frm.DATE.focus();
           return (false);
        }
	 return (true);
  }	 
  function loca(){
	  if (Validate(document.frm)){
	 	 document.frm.action="SaveJz.jsp";
		 document.frm.submit();
      }		
}
</script>
</body>

</html>
