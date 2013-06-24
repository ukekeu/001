 
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
<title>报表</title>
</head>
<body>
<% 
String secName="";
String Date1=request.getParameter("Date1");
String Date2=request.getParameter("Date2");
if (!Date1.equals(""))Date1=" and  date between '"+Date1+"' and '"+Date2+"'";
String sectionNo=getbyte1(request.getParameter("SecNo"));
 secName=sectionNo.substring(sectionNo.indexOf("|")+1);
sectionNo=sectionNo.substring(0,sectionNo.indexOf("|"));
	 
 %>
 
<table width="125%" cellspacing="0" cellpadding="0">
 <tr align="center" ><td  ><b><font size=4><%=secName  %>销售汇总表</font></b> </td></tr>
</table>
<br>
 
 <table width="125%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF">
  
  <tr bgcolor='#EAECEC' align="center">  
    <td> </td>
    <td>已售套数</td>
    <td>已售面积M<sup>2</sup></td>
    <td>销售金额(认购书)</td>
  
    <td>销售均价</td>
    <td>实际销售均价<br>(除首期优惠部分)</td>
    <td>实际均价(元/M<sup>2</sup>)</td>
    <td>销售率</td>
    <td>每月销售<br>费用支出</td>
    <td>销售费点实际<br>销售的比率</td>
    
  </tr>
  <%
  
  
   int s_sale_num=0;
   double s_sale_area=0;
   int s_sale_price=0;
   double s_sale_av_price=0;
   double s_fact_sale_av_price=0;
   int s_fact_sale_price=0;
   double s_sale_rate=0;
  //按付款方式
   
   SQL="select payment1 ,count(*)  num,sum(jzarea) jzarea,sum(rmbprice) price,sum(rmbprice)/sum(jzarea) avgprice,sum(rmbprice)-sum(zs_first_money) factprice,(sum(rmbprice)-sum(zs_first_money))/sum(jzarea) from order_contract where state<>3 and  and section ='"+sectionNo+"'"+Date1+" group by payment1"; 
 
	  ResultSet rs=ViewBean2.executeQuery(SQL);
	  if (rs.next()){
	     year_month=rs.getString("yearmonth");
	     sale_num=rs.getInt("num");
		 sale_area=rs.getDouble("jzarea");
	     sale_price=rs.getInt("price");
		 sale_av_price=rs.getDouble("avgprice");
    	 fact_sale_price=rs.getInt("factprice");
		 fact_sale_av_price=rs.getDouble("factavgprice");
		 sale_rate=rs.getDouble("salerate");
		 
	  }
	    rs.close();
	  }catch(Exception s){}
	
 %>
 <tr>
 <td>上周合计<br>(<%=Date1.substring(Date1.indexOf("-")+1) %>到<%=Date2.substring(Date2.indexOf("-")+1) %>)</td>
  <td><%= sale_num%></td> <td><%=sale_area%></td>
  <td><%=  Format.getFloat(sale_price,0)%></td> <td><%=Format.getFloat2(sale_av_price,2)%></td>
  <td><%= Format.getFloat(fact_sale_price,0)%></td> <td><%=Format.getFloat2(fact_sale_av_price,2)%></td>
  <td><%=sale_rate%></td>
   <td>
   <%
   float charge=0;
   if (yearmonth.contains(year_month)){
	  int index=yearmonth.indexOf(year_month);
	  out.print((String)charges.get(index));
	  charge=Float.parseFloat((String)charges.get(index));
	}  
   
   
   %>&nbsp;</td>
   <td>&nbsp;<%if (fact_sale_price>0)out.println(Format.getFloat2(charge/fact_sale_price*100,2));else out.println("0"); %>%</td>
</tr>
 
 </table>
 
</body>

</html>
