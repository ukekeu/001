<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
   <%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <%@ include file="../public_js/getByteOut.jsp"%>    
<html>
<head>
<title>优惠审核记录</title>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
</head>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<%
String codes=request.getParameter("codes");
String code=getbyte1(request.getParameter("code"));
if (!code.equals("")){
   String checkdate=getbyte1(request.getParameter("checkdate"));
   String checkperson=getbyte1(request.getParameter("checkperson"));
   String checknote=getbyte1(request.getParameter("checknote"));
   String sql="update order_contract set yh_check1=1,yh_checkbak=yh_checkbak+',于'+convert(varchar(10),getdate(),120) "+"+'核对,"+checkperson+"' where  code in("+code+")";
   try{
		 aBean.executeUpdate(sql);
  }catch(Exception s){out.print(s+sql);}
    %>
	   <script>alert("已记录<%=code %>");opener.window.location.reload();window.close();</script>
	   <%  

}

 %>
 <script>
  function checkdata(){
    if (document.frm.checkdate.value==""){alert("请选择日期");return false;}
    if (document.frm.checkperson.value==""){alert("请填写核对人");return false;}
  document.frm.submit();
  }
 
 </script>
<body>
<form name=frm method="post">
<input type=hidden name=code value="<%=codes %>">
<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1  ALIGN=center  >
<tr  class=TXTColor> 
 
<td  align="center">核对日期</td>
<td  align="center">核对人</td>
<td  align="center">核对意见</td>
 </tr>
 <tr  class=listcontent > 
 
<td  align="center"><input type=text name=checkdate size=12><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(checkdate);return false;"></td>
<td  align="center"><input type=text name=checkperson size=12></td>
<td  align="center"><input type=text name=checknote ></td>
 </tr>
</table>
<p align="center"><input type=button name=tj value="提 交" onclick="checkdata();">	&nbsp;<input type=button name=cl value="退 出" onclick="if (confirm('确认吗?'))window.close();">	
    </p>
	</form>
</body>
</html>
