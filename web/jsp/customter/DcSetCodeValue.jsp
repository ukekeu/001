<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel="stylesheet" type="text/css" href="UltraGrid.css">	
<title>添加调查选项内容</title>
</head>
<script language="javascript" src="../public_js/public.js"></script>
  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/checktime.jsp"%>
 
<%
String code=getbyte1(request.getParameter("code"));
String codes=getbyte1(request.getParameter("codes"));
String SecNo=getbyte1(request.getParameter("SecNo"));

String SQL="";
 
if (!codes.equals("")){
   SQL="insert into CustomerDcValue(dcCode,CodeValue) values("+code+",'"+codes+"')";
   ViewBean.executeUpdate(SQL);
   %>
   <script>
    opener.window.document.forms[0].submit();
	if (!confirm("是否继续？"))window.close();
    document.frm.codes.focus();
   </script>
   <%
}
 
 %>
<body onload="document.frm.codes.focus();">
<form name=frm>
<input type=hidden name=code value="<%=code %>">
<input type=hidden name=SecNo value="<%=SecNo %>">
<P align="center">调查选项:<input type=text size=12 name=codes>&nbsp;</P>
<P align="center">
<input type=button name=ok value="提交" onclick="savedata();">&nbsp;&nbsp;<input type=button name=winclose value="退出" onclick="window.close();">&nbsp;&nbsp;</P> 
</form>
<script>
function savedata(){
  if (document.frm.codes.value=="")
   {alert("请填写内容！");
    return false;
   }
   document.frm.submit();
}

</script>

</body>
</html>
