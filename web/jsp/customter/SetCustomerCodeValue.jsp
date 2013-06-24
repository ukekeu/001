<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel="stylesheet" type="text/css" href="UltraGrid.css">	
<title>添加客户流失原因</title>
</head>

  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/checktime.jsp"%>
 
<%
String customer=getbyte1(request.getParameter("customer"));
 
String codes[]	= request.getParameterValues("codes");
 
String deletecode=getbyte1(request.getParameter("deletecode"));
String SQL="";
   String code="";
   if (codes!=null){
   ViewBean.executeUpdate("delete CustomerLsCode where  customer='"+customer+"'");
   for (int i=0;i<codes.length;i++){
      SQL="insert into CustomerLsCode(codevalue,customer) values("+codes[i]+",'"+customer+"')";
      ViewBean.executeUpdate(SQL);
   }
   %><script>
   window.close();
   </script>
   <%
   }
if (!deletecode.equals("")){
   SQL="delete  LsCode where code="+deletecode;
   ViewBean.executeUpdate(SQL);
} 
int arrInt=0;
ResultSet rs=null;
SQL="SELECT COUNT(*) NUM FROM CustomerLsCode where customer='"+customer+"'";
 rs=ViewBean.executeQuery(SQL);	
 if (rs.next()){
   arrInt=rs.getInt("NUM");
 }
 rs.close();
 String CodeName[]=new String[arrInt];
 SQL="SELECT codevalue FROM CustomerLsCode where customer='"+customer+"'";
 rs=ViewBean.executeQuery(SQL);	
 int j=0;
 while (rs.next()){
   CodeName[j]=rs.getString("codevalue");
   j++;
 }
 rs.close();
SQL="select * from LsCode  where type=0";
  rs=ViewBean.executeQuery(SQL);	
 %>
<body>
<form name=frm>
 <input type="hidden" name=customer value="<%=customer %>">

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
	 String sele="";
	 code=rs.getString("code");
	  for (int ii=0;ii<arrInt;ii++){
		  if (CodeName[ii]!=null){
		   if (CodeName[ii].equals(code))
	        sele="checked";
		  }
       }
	    %>
 <tr align="center">
    <td width="10%" ><%=i %></td>
    <td width="75%"><%=rs.getString("codevalue") %></td>
	 <td width="10%"><input name="codes" type="checkbox" <%=sele %> value="<%=code%>"></td>
  </tr>
  <%}
  rs.close(); %>
  
</table>

<p align="center"><input type=button name=choosevalue value="提交" onclick="document.frm.submit();">&nbsp;&nbsp;<input type=button name=cancel value="退出" onclick="window.close();"></p>
</form>
<script>
function savedata(){
  if (document.frm.codes.value=="")
   {alert("请填写流失原因！");
    return false;
   }
   document.frm.submit();
}

</script>

</body>
</html>
