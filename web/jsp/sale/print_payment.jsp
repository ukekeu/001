 
 <%@ page contentType="text/html;charset=GBK" %>
 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/CheckSection.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>按付款方式统计</title>
</head>
<body>
<% 
String secName="";
String Date1=request.getParameter("Date1");
String Date2=request.getParameter("Date2");
if (!Date1.equals("")&&!Date2.equals("")){
 Date1=" and date between '"+Date1+"' and '"+Date2+"'";
}
 
String sectionNo=getbyte1(request.getParameter("SecNo"));
 secName=sectionNo.substring(sectionNo.indexOf("|")+1);
sectionNo=sectionNo.substring(0,sectionNo.indexOf("|"));
	 
 %>
 
<table width="98%" cellspacing="0" cellpadding="0">
 <tr align="center" ><td  ><b><font size=4><%=secName  %>付款方式情况分析</font></b> </td></tr>
</table>
<br>
 
 <table width="98%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF">
  
  <tr bgcolor='#EAECEC' align="center">  
    <td colspan="2">付款方式</td>
    <td>已售面积M<sup>2</sup></td>
	 <td>已售总套数</td>
	  <td>已售总金额</td>
    <td>占已售比率</td>
  </tr>
  <%    
   String SQL="select sum(jzarea) jzarea,sum(rmbprice) rmbprice,count(*) num from  order_contract where state<>3  "+Date1+" and section ='"+sectionNo+"'"; 

	  ResultSet rs=ViewBean2.executeQuery(SQL);
	  double jzarea=0;
	  double rmbprice=0;
	  int num=0;
     if (rs.next()){
	   jzarea=rs.getDouble("jzarea");
	   rmbprice=rs.getDouble("rmbprice");
	   num=rs.getInt("num");
	 }
	 rs.close();
  
    SQL="select payment1 ,count(*)  num,sum(jzarea) jzarea,sum(rmbprice) price,sum(rmbprice)/sum(jzarea) avgprice,sum(rmbprice)-sum(zs_first_money) factprice,(sum(rmbprice)-sum(zs_first_money))/sum(jzarea) factavgprice from  order_contract where state<>3 "+Date1+" and section ='"+sectionNo+"' group by payment1"; 
 
	   rs=ViewBean2.executeQuery(SQL);
	   int i=1;
	   while (rs.next()){
	     out.print("<tr><td>"+i+"</td>");
   	     out.print("<td>"+getbyte(rs.getString("payment1"))+"</td>");
		 double jzarea1=rs.getDouble("jzarea");
		 out.print("<td>"+Format.getFloat2(jzarea1,2)+"</td>");
		  out.print("<td>"+Format.getFloat2(rs.getDouble("num"),2)+"</td>");
		  out.print("<td>"+Format.getFloat2(rs.getDouble("price"),2)+"</td>");
   	     out.print("<td>"+Format.getFloat2(jzarea1/jzarea*100,2)+"%</td></tr>");		 
		 i++;
	}
	rs.close();
	 %>
</table>
</body>

</html>
