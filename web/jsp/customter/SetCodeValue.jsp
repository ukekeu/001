<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel="stylesheet" type="text/css" href="UltraGrid.css">	
<title>������ʧԭ��ѡ��</title>
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
   SQL="delete  LsCode where code="+deletecode;
   ViewBean.executeUpdate(SQL);
}
if (!codes.equals("")){
   SQL="insert into LsCode(codevalue) values('"+codes+"')";
   ViewBean.executeUpdate(SQL);
}
SQL="select * from LsCode where type=0";
ResultSet rs=ViewBean.executeQuery(SQL);	
 %>
<body>
<form name=frm>

<P align="center">��ʧԭ��:<input type=text size=12 name=codes>&nbsp;<input type=button name=ok value="�ύ" onclick="savedata();"></P>

<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
  <tr align="center"  class=listtitle>
    <td width="10%">���</td>
    <td width="75%">ԭ��</td>
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
	 <td width="10%"><a href="#" onclick="if (confirm('ȷ��ɾ����'))window.location='SetCodeValue.jsp?deletecode=<%=rs.getString("code") %>';" title="ɾ��"><img src="../images/button_sc.gif" border="0" ></a></td>
  </tr>
  <%}
  rs.close(); %>
  
</table>


</form>
<script>
function savedata(){
  if (document.frm.codes.value=="")
   {alert("����д��ʧԭ��");
    return false;
   }
   document.frm.submit();
}

</script>

</body>
</html>
