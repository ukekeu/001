<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ page import="java.sql.*,java.util.*" %>
  <jsp:useBeanid="onlineuser" class="online.ListUser" scope="application"/>
 <jsp:useBean id="userBean" scope="page" class="ConnDatabase.SDatabase" />
 <jsp:useBean id="smenu" scope="page" class="ConnDatabase.menu" />
 
  <%@ include file="../public_js/getByteOut.jsp"%>
   
<html>
 <LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 <head>
	<title>对话窗口</title>
</head>
<STYLE type=text/css>BODY {
	MARGIN: 0px
}
.style4 {
	COLOR: #43994f
}
.style6 {
	FONT-SIZE: 15px
}
.style8 {
	COLOR: #e1411d
}
</STYLE>

 
<body  topmargin="0" leftmargin="0"   marginheight="100%"   oncontextmenu="return false"    >
 <form name=frm method="post" action="onlineAlert.jsp?acc=<%=getbyte1(request.getParameter("send_person")) %>"> 
 
 <table width="100%"   border="0"     bgColor=#fef2f0    >
 <tr><td><font size="3"><b><%=getbyte1(request.getParameter("send_person")) %>在<%=getbyte1(request.getParameter("send_date")) %>发来消息</b></font><input  name=acc type=hidden  readonly value="<%=getbyte1(request.getParameter("send_person")) %>"></td></tr>
</table> 
<table width="100%"   border="0"     bgColor=#fef2f0    >
<tr><td align="right"  ><img src="../images/color.gif" height="1" width="100%"></td></tr>
</table>
 <table width="100%"   border="0"     bgColor=#fef2f0    >
 <tr><td><textarea cols="65" rows="7" name="alt"><%=getbyte1(request.getParameter("info")) %></textarea></td></tr>
</table> 
<table width="100%"   border="0"     bgColor=#fef2f0    >
<tr><td align="right"  ><img src="../images/color.gif" height="1" width="100%"></td></tr>
</table>
 <table width="100%"   border="0"     bgColor=#fef2f0    >
 <tr><td align="right"><input type=button name="sendinfo" value="回 复" onclick="alertCheck();">&nbsp;<input type=button name="closeWIN" value="退  出" onclick="window.close();" title="确认退出吗"></td></tr>
</table> 
</form>
<script>
function alertCheck(){
 
  document.frm.submit();

}

</script>
</body>
</html>
