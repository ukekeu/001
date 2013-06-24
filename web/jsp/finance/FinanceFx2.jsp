<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<jsp:useBean id="userBean1" scope="page"  class="ConnDatabase.SDatabase"/>
<jsp:useBean id="userBean2" scope="page"  class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData" />
  <jsp:useBean id="FormtD1" scope="page" class="test.BarChartDemo"/>  
    <jsp:useBean id="FormtD3" scope="page" class="test.PieChart"/>  
<%@ include file="../public_js/getByteOut.jsp"%>
 
<html>
 <head><title>费用收取情况直方图</title>
 <LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 </head>
<script language="javascript" src="../public_js/public.js"></script> 
<body  >
<CENTER>
<form name=pm method=post>
 <%
      String sqlstr1="",sqlstr2="",sqlstr3="";
	 String wherestr="";
	 String item="";
	 String ydatestr1="";
	 String ydatestr2="";
	 String xdatestr="";
	 int  chargemonth=0;
	 String ysum,ssum="",chargeyear;
	 ResultSet RS=null,RS1=null;
	 String uptownname="";
 
	 String chargename="";
 String Date1=getbyte1(request.getParameter("Date1"));
 String Date2=getbyte1(request.getParameter("Date2"));
  String section=getbyte1(request.getParameter("section"));
  String sectionname=section.substring(section.indexOf("-")+1);
  section=section.substring(0,section.indexOf("-"));
  String dateWhere="",dateWhere1="",dateWhere2="",dateWhere3="";
if (!Date1.equals("")&&Date2.equals("")){dateWhere=" and shouldDate >='"+Date1+"'"; dateWhere1=" and visadate  >='"+Date1+"'";dateWhere2=" and FactDate  >='"+Date1+"'";dateWhere3=" and Gather_Date  >='"+Date1+"'";}
 else  if (!Date2.equals("")&&!Date1.equals("")){dateWhere=" and shouldDate between '"+Date1+"' and '"+Date2+"'"; dateWhere1=" and visadate between '"+Date1+"' and '"+Date2+"'"; dateWhere2=" and FactDate between '"+Date1+"' and '"+Date2+"'";dateWhere3=" and Gather_Date between '"+Date1+"' and '"+Date2+"'";}
 else    if (!Date2.equals("")&&Date1.equals("")){dateWhere=" and shouldDate<='"+Date2+"'"; dateWhere1=" and visadate<='"+Date2+"'"; dateWhere2=" and FactDate<='"+Date2+"'"; dateWhere3=" and Gather_Date<='"+Date2+"'";}
 %>
 
<br>
<table width="95%" border="0">
  <tr>
    <td align="center" width="25%"> 
     <b><%=sectionname%>收款进度分析统计图 </b> 
    </td>
	 
  </tr>
</table>
<table width="95%" border="0">
  <tr>
    <td align="center" width="25%"> 
    
    </td>
	 <td align="right" width="25%">金额单位:<span id="unitspan">人民币万元</span></td>
  </tr>
</table>

 
<% //获取应收数
	 sqlstr1="select substring(convert(char(24),shoulddate,120),1,7) yearmonth,sum(shouldmoney*rate)  dd from gatheringrecord a  where    contactno in (select code from order_contract where section='"+section+"')  " +dateWhere+" group by substring(convert(char(24),shoulddate,120),1,7) ";
	
	ResultSet change2RS   = userBean1.executeQuery(sqlstr1);
        userBean2.executeUpdate("delete   skfx where sectionno='"+section+"'");
		
		while (change2RS.next()) {
		  userBean2.executeUpdate("insert into skfx(sectionno,yearmonth,ys,ss) values('"+section+"','"+change2RS.getString("yearmonth")+"',"+change2RS.getString("dd")+",0)");
        }
		change2RS.close();   
		 sqlstr1="select substring(convert(char(24),gather_date,120),1,7) yearmonth,sum(factmoney*currrate)  dd from factgatheringrecord a  where    contractno in (select code from order_contract where section='"+section+"')   " +dateWhere3+" group by substring(convert(char(24),gather_date,120),1,7) ";
	
	    change2RS   = userBean1.executeQuery(sqlstr1);
		while (change2RS.next()) {
		  userBean2.executeUpdate("update  skfx set ss="+change2RS.getString("dd")  +" where sectionno='"+section+"' and yearmonth='"+ change2RS.getString("yearmonth")+"'");
        }
		change2RS.close();
		
String pic="";
Calendar calendar = Calendar.getInstance();
	String filename = String.valueOf(calendar.getTimeInMillis());
 sqlstr1="select yearmonth,ys/10000,ss/10000 from skfx where sectionno='"+section+"'";
  pic=FormtD1.main1("D:/"+ request.getContextPath()+"/crmv9/jsp/picture/cwpic1"+filename+".jpg","每月收款进度统计分析","应收金额","收款分析",sqlstr1,2,"应收款","实收款","","");
  
 
  %>
	 <table width="100%" border="0"><tr><td align="center">
    <%if (!pic.equals("")){%>
	<img src="../picture/<%=pic%>">
	<%}%>
 
  </td></tr></table>
	 
<center> 
<br>
<table width="95%" border="0">
  <tr>
    <td align="left" width="25%"> 
      制表日期:<%//=nowdate%>
    </td>
	 <td align="right" width="25%">金额单位:<span id="unitspan">人民币万元</span></td>
  </tr>
</table>
 
</center>
</form>
</CENTER>
</body>
</html>