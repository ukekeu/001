<%@ page contentType="text/html;charset=GBK" %>

<%@ page language="java" import="java.sql.*,java.util.*" %>
 <%@ include file="../public_js/getByteOut.jsp"%>
 
<jsp:useBean id="userBean" scope="page"  class="ConnDatabase.SDatabase"/>
   <jsp:useBean id='md5' scope='request' class='crypt.MD5'/>
     <jsp:useBean id="checkreg" scope="page" class="regcheck.regcheck"/> 
<%String endd=getbyte1(request.getParameter("endd"));
String reno=getbyte1(request.getParameter("regno"));
ResultSet rs=null;
String mess=checkreg.checkREGMess();
    
 int aaa=0;
 if (!mess.equals("")){aaa=1;} %>
 <html>
<title><%if (aaa==0){out.print("Զ�̶�ϵͳ������ʽע��");}else{out.print("����ϵͳ");} %></title>
<head>
<base target="_self">
<meta http-equiv="Content-Language" content="zh-cn">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

</head>
<%

 if (aaa>0){out.print(mess);out.close();}
if (!reno.equals("")){
  String messinfo=checkreg.checkREGInfo(reno,endd,"");

  if (!messinfo.equals("")){out.print(messinfo);out.close();}
	 
} 
String userCompayname="";
java.text.SimpleDateFormat date =null;
date=new java.text.SimpleDateFormat("yyyy-MM-dd");
String TodayDate=new java.util.Date().toString();
	 ResultSet msgrs = null;
  msgrs=userBean.executeQuery("select  top 1 CompanyName from company");
 if (msgrs.next()){userCompayname=msgrs.getString("CompanyName");
 }msgrs.close();
	 %>
	

<body>
<form name="regfrm">
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" height="48">
 <tr>
    <td width="25%" height="16">ʹ����ҵ����</td>
    <td width="38%" height="16"><%=userCompayname %></td>
    
  </tr>
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
    <td width="38%" height="16"><input type=text name=regno size="42" value=""></td>
     
  </tr>
  
 </table>
 <p align="center"> <input type=button name=reg value="ȷ��ע��" ONCLICK="if (confirm('ȷ��ע����?'))regfrm.submit();">
</p>
</form>
</body>

</html>