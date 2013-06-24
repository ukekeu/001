
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
     <b><font size="3"><%=sectionname%>资金回笼及每月应收分布图</font></b> 
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
	 sqlstr1="select sum(shouldmoney*rate)/10000 num,sum(yijiao)/10000 jzarea,substring(convert(char(24),shoulddate,120),1,7)  yearmonth from gatheringrecord where contactno in (select code from order_contract where section='"+section+"') and shouldqs<>0 " +dateWhere+" group by substring(convert(char(24),shoulddate,120),1,7) ";
	 
String choose=request.getParameter("choose");
String pic="",pic1="";
 
   sqlstr1="select  substring(convert(char(24),shoulddate,120),1,7)  yearmonth,sum(shouldmoney*rate)/10000  num  from gatheringrecord where contactno in (select code from order_contract where section='"+section+"') and shouldqs<>0 " +dateWhere+" group by substring(convert(char(24),shoulddate,120),1,7) ";
  
  pic=FormtD3.drawToFile("D:/zlcrm/crmv9/jsp/picture/cwpic2"+section+".jpg",sqlstr1,"应收款分析");  
 
 
  //获取应收数
	 sqlstr1="select sum(shouldmoney*rate-yijiao)  dd from gatheringrecord a  where state<>2 and     contactno in (select code from order_contract where section='"+section+"')  " +dateWhere+"  ";
	ResultSet change2RS   = userBean1.executeQuery(sqlstr1);
        userBean2.executeUpdate("delete   skprocess where sectionno='"+section+"'");
		 
		while (change2RS.next()) {
		  userBean2.executeUpdate("insert into skprocess(sectionno,type,money) values('"+section+"','未收首期款',"+change2RS.getString("dd")+")");
        }
		change2RS.close();
		 sqlstr1="select sum(ajmoney)  dd from    order_contract where not code in (select contractno  dd from FactAjCharges )  and section='"+section+"'  " +dateWhere1+"  ";
	  change2RS   = userBean1.executeQuery(sqlstr1);
      ;
		 
		while (change2RS.next()) {
		  userBean2.executeUpdate("insert into skprocess(sectionno,type,money) values('"+section+"','未放款',"+change2RS.getString("dd")+")");
        }
		change2RS.close();
		
		 sqlstr1="select sum(factmoney*currrate)  dd from factgatheringrecord a  where    contractno in (select code from order_contract where section='"+section+"')   " +dateWhere3+"  ";
	    change2RS   = userBean1.executeQuery(sqlstr1);
		while (change2RS.next()) {
		   userBean2.executeUpdate("insert into skprocess(sectionno,type,money) values('"+section+"','已收首期款',"+change2RS.getString("dd")+")");
         }
		change2RS.close();
		 sqlstr1="select sum(FactMonye)  dd from FactAjCharges    where    contractno in (select code from order_contract where section='"+section+"')   " +dateWhere2+"  ";
	    change2RS   = userBean1.executeQuery(sqlstr1);
		while (change2RS.next()) {
		   userBean2.executeUpdate("insert into skprocess(sectionno,type,money) values('"+section+"','已放款',"+change2RS.getString("dd")+")");
         }
		change2RS.close();
		Calendar calendar = Calendar.getInstance();
	String filename = String.valueOf(calendar.getTimeInMillis());
  sqlstr1="select type,sum(money)/10000 ys from skprocess where sectionno='"+filename+"' group by type";
 pic1=FormtD3.drawToFile("D:/"+ request.getContextPath()+"/crmv9/jsp/picture/cwpic3"+filename+".jpg",sqlstr1,"回笼资金分析");  
 
  %>
	
	 <table width="100%" border="0"><tr><td align="center">
    <%if (!pic.equals("")){%>
	<img src="../picture/<%=pic%>">
	<%}%>
 
  </td><td align="center">
    <%if (!pic1.equals("")){%>
	<img src="../picture/<%=pic1%>">
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