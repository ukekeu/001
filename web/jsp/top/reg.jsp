<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 <html>
<title>远程对系统进行正式注册</title>
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
       out.print("<br><br><br>&nbsp;&nbsp;系统已注册过，不能重新注册！<br>");
	   out.print("&nbsp;&nbsp;正式注册时间："+msgrs.getString("column_b"));
	   out.print("<br>&nbsp;&nbsp;正式注册号："+msgrs.getString("userregno")); 
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
	 if (rs.next())out.print("正式注册时间："+rs.getString("column_b"));
	 rs.close();
	 out.print("<br>你的注册号："+md5.getMD5ofStr(reno));
	 out.close();
	 }else{
	 %>
	 <script>
	 alert("注册码不正确，请确认用户身份合法性!")
	  
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
    <td width="25%" height="16">系统随机序号</td>
    <td width="38%" height="16"><%=md5.getMD5ofStr(TodayDate) %></td>
    
  </tr>
  <tr>
    <td width="25%" height="14">系统注册日期</td>
    <td width="38%" height="14"><input type=text name=endd size="42" value="<%=date.format(new java.util.Date()).toString()%>"></td>
  
  </tr>
  <tr>
    <td width="25%" height="16">请填写注册号</td>
    <td width="38%" height="16"><input type=text name=regno size="42" value="<%=md5.getMD5ofStr("U客") %>"></td>
     
  </tr>
  
 </table>
 <p align="center"> <input type=button name=reg value="确认注册" ONCLICK="if (confirm('确认注册吗?'))regfrm.submit();">
</p>
</form>
</body>

</html>