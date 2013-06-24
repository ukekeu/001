<%@ page contentType="text/html;charset=GBK" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>房间编码</title>
</head>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/asiic.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>

 <%
 
String   sqlU="";
	String ok=getbyte1(request.getParameter("ok"));
	if (!ok.equals("")){
	   sqlU="update  LockRoom  set lockroom='"+getbyte1(request.getParameter("lokeroom"))+"' where Section=";
				sqlU=sqlU+"'"+getbyte2(request.getParameter("SecNo"))+"'  and Loft='"+getbyte2(request.getParameter("Loft"))+"' and Build='"+getbyte2(request.getParameter("Build"))+"'"; 
              ViewBean.executeUpdate(sqlU);
	%>
	     <script>alert("已恢复,请重新定义恢复过的号");window.close();</script>
<%} %>
<body>
<form name="frm" method="post">
    <table border="0" width="60%"  align="center" cellspacing="0" bgcolor="#ffffff"  cellpadding="0" bordercolor="#ffffff" class="tablefill">
 <tr><td>禁用房号</td></tr>
<%
sqlU="select * from LockRoom where Section=";
				sqlU=sqlU+"'"+request.getParameter("SecNo")+"'  and Loft='"+getbyte2(request.getParameter("Loft"))+"' and Build='"+getbyte2(request.getParameter("Build"))+"'";
	
ResultSet rr=ViewBean.executeQuery(sqlU);
  if (rr.next()){
 %>
 <tr><td><input type=text value="<%=rr.getString("lockroom") %>" name="lokeroom"></td></tr>
<%}
rr.close(); %>
</table><br>
       &nbsp;&nbsp; <input type=button value="提 交" onclick="cancelLoke();" >&nbsp;&nbsp; <input type=button value="退 出" onclick="window.close();" >
</form>
 <script>
 function cancelLoke(){
  if (confirm("确认吗？")){
   document.forms[0].action="listLoke.jsp?ok=a&SecNo=<%=request.getParameter("SecNo") %>&Loft=<%=getbyte2(request.getParameter("Loft")) %>&Build=<%=getbyte2(request.getParameter("Build")) %>";
   document.forms[0].submit();
  }
 }
 </script>
</body>
</html>
