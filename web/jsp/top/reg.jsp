<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 <html>
<title>Զ�̶�ϵͳ������ʽע��</title>
<head>
<base target="_self">
<meta http-equiv="Content-Language" content="zh-cn">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

</head>
<%@ page language="java" import="java.sql.*,java.util.*" %>

 
<jsp:useBean id="userBean" scope="page"  class="ConnDatabase.SDatabase"/>
   <jsp:useBean id='md5' scope='request' class='crypt.MD5'/>
   <%@ include file="../public_js/getByteOut.jsp"%>
<%
String endd=getbyte1(request.getParameter("endd"));
String reno=getbyte1(request.getParameter("regno"));
ResultSet rs=null;
 String msgsql="select * from user_reg where state=1";
 ResultSet msgrs = null;
	  msgrs=userBean.executeQuery(msgsql);
	  if (msgrs.next()){
       out.print("<br><br><br>&nbsp;&nbsp;ϵͳ��ע�������������ע�ᣡ<br>");
	   out.print("&nbsp;&nbsp;��ʽע��ʱ�䣺"+msgrs.getString("column_b"));
	   out.print("<br>&nbsp;&nbsp;��ʽע��ţ�"+msgrs.getString("userregno")); 
	  msgrs.close();
	 out.close();
	  
 }msgrs.close();
 
if (!reno.equals("")){
  String userCompayname="";
  
  msgrs=userBean.executeQuery("select  top 1 CompanyName from company");
 if (msgrs.next()){userCompayname=md5.getMD5ofStr(msgrs.getString("CompanyName"));
  }msgrs.close();
  if (userCompayname.equals(reno)){
  
int r=userBean.executeUpdate("update  user_reg set column_b=convert(char(10),getdate(),120),end_date=DATEADD(mm, 12, '"+endd+"'),state=1,userregno='"+md5.getMD5ofStr(reno)+"'");
	 rs = userBean.executeQuery("select * from user_reg");
	 if (rs.next())out.print("��ʽע��ʱ�䣺"+rs.getString("column_b"));
	 rs.close();
	 out.print("<br>���ע��ţ�"+md5.getMD5ofStr(reno));
	 out.close();
	 }else{
	 %>
	 <script>
	 alert("ע���벻��ȷ����ȷ���û���ݺϷ���!")
	  
	 </script>
	 <%}
	 
}//else{
//int r1=userBean.executeUpdate("alter table user_reg add userregno varchar(50)");

//int r=userBean.executeUpdate("alter table user_reg add userregno varchar(50)");

//}	
java.text.SimpleDateFormat date =null;
date=new java.text.SimpleDateFormat("yyyy-MM-dd");
String TodayDate=new java.util.Date().toString();
	 %>
	

<body>
<form name="regfrm">
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" height="48">
  <tr>
    <td width="25%" height="16">ϵͳ������</td>
    <td width="38%" height="16"><%=md5.getMD5ofStr(TodayDate) %></td>
    
  </tr>
  <tr>
    <td width="25%" height="14">ϵͳע������</td>
    <td width="38%" height="14"><input type=text name=endd size="42" value="<%=date.format(new java.util.Date()).toString()%>"></td>
  
  </tr>
  <tr>
    <td width="25%" height="16">����дע���</td>
    <td width="38%" height="16"><input type=text name=regno size="42" value="<%=md5.getMD5ofStr("U��") %>"></td>
     
  </tr>
  
 </table>
 <p align="center"> <input type=button name=reg value="ȷ��ע��" ONCLICK="if (confirm('ȷ��ע����?'))regfrm.submit();">
</p>
</form>
</body>

</html>