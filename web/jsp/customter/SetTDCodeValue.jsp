<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel="stylesheet" type="text/css" href="UltraGrid.css">	
<title>设置挞定原因选项</title>
</head>

  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/checktime.jsp"%>
 
<%
String codes=getbyte1(request.getParameter("codes"));
String deletecode=getbyte1(request.getParameter("deletecode"));
String SQL="";
if (!deletecode.equals("")){
   SQL="delete  TdCode where code="+deletecode;
   ViewBean.executeUpdate(SQL);
}
if (!codes.equals("")){
   SQL="insert into TdCode(codevalue) values('"+codes+"')";
   ViewBean.executeUpdate(SQL);
}
SQL="select * from TdCode";
ResultSet rs=ViewBean.executeQuery(SQL);	
 %>
<body>
<form name=frm>
<P align="center">流失原因:<input type=text size=12 name=codes>&nbsp;<input type=button name=ok value="提交" onclick="savedata();"></P>

<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
  <tr align="center"  class=listtitle>
    <td width="10%">序号</td>
    <td width="75%">原因</td>
	 <td width="10%"> </td>
  </tr>
  <%
  int i=0;
   while (rs.next()){
     i++;
   %>
 <tr align="center">
    <td width="10%" ><%=i %></td>
    <td width="75%"><%=rs.getString("codevalue") %></td>
	 <td width="10%"><a href="#" onclick="if (confirm('确认删除吗？'))window.location='SetTDCodeValue.jsp?deletecode=<%=rs.getString("code") %>';" title="删除"><img src="../images/button_sc.gif" border="0" ></a></td>
  </tr>
  <%}
  rs.close(); %>
  
</table>


</form>
<script>
function savedata(){
  if (document.frm.codes.value=="")
   {alert("请填写挞定原因！");
    return false;
   }
   document.frm.submit();
}

</script>

</body>
</html>
