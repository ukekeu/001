<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<title>销售简报</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel=stylesheet href="../class/news.css" >
</head>
  <%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="FormatD" scope="session" class="FormatData.FormatData"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/CheckSection.jsp"%>
  <%
    double sumnum=0;
	double sumarea=0;
    double    orderNum=0;
	double countsumprice=0;
	
	double countsumarea=0;
	double countavgprice=0;
	double    orderNum1=0;
	double countsumprice1=0;
	double countsumarea1=0;
	double countavgprice1=0;
    double    sorderNum=0;
	double scountsumprice=0;
	double scountsumarea=0;
	double scountavgprice=0;
	double ssumnum1=0;
	double ssumarea1=0;
	double    aorderNum=0;
	double acountsumprice=0;
	double acountsumarea=0;
	double acountavgprice=0;
	
	double    aorderNums=0;
	double acountsumprices=0;
	double acountsumareas=0;
	double acountsumjzareas=0;
	double acountavgprices=0;
	double aorderNums1=0;
	double   acountsumprices1=0;
	double   acountavgprices1=0;
	double   acountsumjzareas1=0;  
	double   acountsumareas1=0;  
	double ajmoneys=0;
	double ajmoneys1=0;
	double ajmoney=0;
	double sumajmoney=0;
	double dzcountsumprices=0;
	double sumsaleprice=0;
	
	String dates=China.getParameter(request,"Date1");
	String dates1=China.getParameter(request,"Date2");
	String SecNo1=China.getParameter(request,"SecNo");
	String Loft=China.getParameter(request,"Loft");
	String WhereSQL="";
	 
	if(!SecNo1.equals(""))
	  WhereSQL +=" and section='"+SecNo1+"'";
	else{
	   WhereSQL+=" and  section in "+FindWhere.substring(FindWhere.indexOf("("));
	   }
	   
	String WhereSQL1=WhereSQL+" and date>='"+dates+"' and  date<='"+dates1+"'";


	String sdate="";
	String edate="";
	String whereDate="";
	
   
	String countSQL="select count(*) num,sum(rmbprice) as sumprice,sum(rmbprice)/sum(jzarea) as avgprice,sum(jzarea) as sumarea from order_contract where state=1"+WhereSQL;
try{
  	ResultSet aRS = aBean.executeQuery(countSQL);
	if (aRS.next()){
	   orderNum=aRS.getDouble("num");
	   countsumprice=aRS.getDouble("sumprice");
	   countavgprice=aRS.getDouble("avgprice");
	   countsumarea=aRS.getDouble("sumarea");
	}
	aRS.close();
	countSQL="select sum(FactMonye) as FactMonye from FactAjCharges where FactDate>='"+dates+"' and  FactDate<='"+dates1+"'";
	
	aRS = aBean.executeQuery(countSQL);
	if (aRS.next()){
	   ajmoney=aRS.getDouble("FactMonye");
	}
	aRS.close();
	//按揭金额
	countSQL="select sum(FactMonye) as FactMonye from FactAjCharges where contractno in (select code from  order_contract where section='" +SecNo1+"')";

	aRS = aBean.executeQuery(countSQL);
	if (aRS.next()){
	   sumajmoney=aRS.getDouble("FactMonye");

	}
	aRS.close();
	
	 countSQL="select count(*) num,sum(rmbprice) as sumprice,sum(rmbprice)/sum(jzarea) as avgprice,sum(jzarea) as sumarea from order_contract where state=1";
  	 aRS = aBean.executeQuery(countSQL);
	if (aRS.next()){
	   orderNum1=aRS.getDouble("num");
	   countsumprice1=aRS.getDouble("sumprice");
	   countavgprice1=aRS.getDouble("avgprice");
	   countsumarea1=aRS.getDouble("sumarea");
	}
	aRS.close();
	 countSQL="select count(*) num,sum(rmbprice) as sumprice,sum(rmbprice)/sum(jzarea) as avgprice,sum(jzarea) as sumarea from order_contract where state=2"+WhereSQL1;
  	 aRS = aBean.executeQuery(countSQL);
	if (aRS.next()){
	   sorderNum=aRS.getDouble("num");
	   scountsumprice=aRS.getDouble("sumprice");
	   scountavgprice=aRS.getDouble("avgprice");
	   scountsumarea=aRS.getDouble("sumarea");
	}
	aRS.close();
	
	 countSQL="select count(*) num,sum(area) area from room where  salestate <> 4";
  	 aRS = aBean.executeQuery(countSQL);
	if (aRS.next()){
	   sumnum=aRS.getDouble("num");
	   sumarea=aRS.getDouble("area");
	}
	aRS.close();
	
	 countSQL="select count(*) num,sum(ajmoney) as ajmoneys from order_contract where year(ajdate)>1900 ";
  	 aRS = aBean.executeQuery(countSQL);
	if (aRS.next()){
	   aorderNum=aRS.getDouble("num");
	   ajmoneys=aRS.getDouble("ajmoneys");
	}
	aRS.close();
	
	
	 countSQL="select sum(factmoney) as sumprice from viewSaleList ";
  	 aRS = aBean.executeQuery(countSQL);
	if (aRS.next()){
		   dzcountsumprices=aRS.getDouble("sumprice");
		}
	aRS.close();
	
	
	 countSQL="select sum(rmbprice) as sumprice from order_contract ";
  	 aRS = aBean.executeQuery(countSQL);
	
	if (aRS.next()){
	   sumsaleprice=aRS.getDouble("sumprice");
	}
	aRS.close();
}catch(Exception s)	{out.print(countSQL);out.close();}
	
	
   %>
<body  ondblclick="printd();">
<p align="center"><font size=5><b>销 售 简 报</b></font></p>
<p align="center" ><font size=3><b><%=dates.substring(0,dates.indexOf("-"))+"年"+dates.substring(dates.indexOf("-")+1,dates.lastIndexOf("-"))+"月"+dates.substring(dates.lastIndexOf("-")+1,dates.length())+"日"+"－"+dates1.substring(0,dates1.indexOf("-"))+"年"+dates1.substring(dates1.indexOf("-")+1,dates.lastIndexOf("-"))+"月"+dates1.substring(dates1.lastIndexOf("-")+1,dates1.length())+"日"%></font></b></p>
<p align="left" ><font face="黑体"><b>本期销售</b></font></p>
<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center"> 
    <td width="5%"  rowspan="2" ><font face="黑体"><b>序号</b></font></td>
    <td width="11%"  rowspan="2" ><font face="黑体"><b>楼盘名称</b></font></td>
    <td width="8%"  rowspan="2" ><font face="黑体"><b>本期销售</b></font></td>
    <td width="25%"  colspan="2"><p align="center"><font face="黑体"><b>本期销售面积</b></font></td>
    <td width="11%"  rowspan="2" ><font face="黑体"><b>本期销售总价</b></font></td>
    <td width="11%"  rowspan="2" ><font face="黑体"><b>本期销售均价</b></font></td>
  </tr>
  <tr align="center"> 
    <td width="13%"><font face="黑体"><b>建筑</b></font></td>
    <td width="12%"><font face="黑体"><b>套内</b></font></td>
  </tr>
  <% 
  aBean.executeUpdate("update order_contract set sectionname=(select name from crm_project where serialno='"+SecNo1+"') where section='" +SecNo1+"'");
       countSQL="select section,sectionname from order_contract where state<>3  "+WhereSQL+" group by section,sectionname";
     String sectionname1="";
	 String section1="";
	 String loft1="";
	 int i=0;
     ResultSet aRS = aBean.executeQuery(countSQL);
	 while (aRS.next()){
	   i=i+1;
	   aorderNums=0;
	   acountsumprices=0;
	   acountavgprices=0;
	   acountsumjzareas=0;
	   acountsumareas=0;
	   section1=getbyte(aRS.getString("section"));
	   sectionname1=getbyte(aRS.getString("sectionname"));
	   countSQL="select section,sectionname,count(*) num,sum(rmbprice) as sumprice,sum(rmbprice)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state<>3  "+WhereSQL1+" and section='"+section1+"'  group by section,sectionname";
	   ResultSet bRS = bBean.executeQuery(countSQL);
	   if(bRS.next()){
	   aorderNums=bRS.getDouble("num");
	   acountsumprices=bRS.getDouble("sumprice");
	   acountavgprices=bRS.getDouble("avgprice");
	   acountsumjzareas=bRS.getDouble("sumjzarea");  
	   acountsumareas=bRS.getDouble("sumarea");  
	   }
	   %>
  <tr align="center"> 
    <td>&nbsp;<%=i %></td>
    <td>&nbsp;<%=sectionname1 %></td>
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%>套</td>
    <td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas,4) %>m<sup>2</sup></td>
    <td>&nbsp;<%=FormatD.getFloat2(acountsumareas,4) %>m<sup>2</sup></td>
    <td>&nbsp;￥<%=FormatD.getFloat2(acountsumprices,2) %></td>
    <td>&nbsp;￥<%=FormatD.getFloat2(acountavgprices,2) %></td>
  </tr>
  <%
	}
	aRS.close();
	 %>
  <% countSQL="select count(*) num,sum(rmbprice) as sumprice,sum(rmbprice)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state<>3  "+WhereSQL1;
      aRS = aBean.executeQuery(countSQL);
	  if (aRS.next()){
	   aorderNums=aRS.getDouble("num");
	   acountsumprices=aRS.getDouble("sumprice");
	   acountavgprices=aRS.getDouble("avgprice");
	   acountsumjzareas=aRS.getDouble("sumjzarea");  
	   acountsumareas=aRS.getDouble("sumarea");  
	}
	aRS.close();
	 %>
  <tr align="center"> 
    <td>&nbsp;<font face="黑体"><b>合计</b></font></td>
    <td>&nbsp;</td>
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%>套</td>
    <td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas,4) %>m<sup>2</sup></td>
    <td>&nbsp;<%=FormatD.getFloat2(acountsumareas,4) %>m<sup>2</sup></td>
    <td>&nbsp;￥<%=FormatD.getFloat2(acountsumprices,2) %></td>
    <td>&nbsp;￥<%=FormatD.getFloat2(acountavgprices,2) %></td>
  </tr>
</table>
  <p align="left" ><font face="黑体"><b>累计销售</b></font></p>
  
<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center"> 
    <td width="5%"  rowspan="2" ><font face="黑体"><b>序号</b></font></td>
    <td width="11%"  rowspan="2" ><font face="黑体"><b>楼盘名称</b></font></td>
    <td width="8%"  rowspan="2" ><font face="黑体"><b>累计销售</b></font></td>
    <td width="25%"  colspan="2"><p align="center"><font face="黑体"><b>累计销售面积</b></font></td>
    <td width="11%"  rowspan="2" ><font face="黑体"><b>累计销售总价</b></font></td>
    <td width="11%"  rowspan="2" ><font face="黑体"><b>累计销售均价</b></font></td>
  </tr>
  <tr align="center"> 
    <td width="13%"><font face="黑体"><b>建筑</b></font></td>
    <td width="12%"><font face="黑体"><b>套内</b></font></td>
  </tr>
  <% countSQL="select section,sectionname,count(*) num,sum(rmbprice) as sumprice,sum(rmbprice)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state<>3  "+WhereSQL+" group by section,sectionname";
 
      i=0;
      aRS = aBean.executeQuery(countSQL);
	 while (aRS.next()){
	   i=i+1;
	   sectionname1=getbyte(aRS.getString("sectionname"));
	   aorderNums=aRS.getDouble("num");
	   acountsumprices=aRS.getDouble("sumprice");
	   acountavgprices=aRS.getDouble("avgprice");
	   acountsumjzareas=aRS.getDouble("sumjzarea");  
	   acountsumareas=aRS.getDouble("sumarea");  
	   %>
  <tr align="center"> 
    <td>&nbsp;<%=i %></td>
    <td>&nbsp;<%=sectionname1 %></td>
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%>套</td>
    <td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas,4) %>m<sup>2</sup></td>
    <td>&nbsp;<%=FormatD.getFloat2(acountsumareas,4) %>m<sup>2</sup></td>
    <td>&nbsp;￥<%=FormatD.getFloat2(acountsumprices,2) %></td>
    <td>&nbsp;￥<%=FormatD.getFloat2(acountavgprices,2) %></td>
  </tr>
  <%
	}
	aRS.close();
	 %>
  <% countSQL="select count(*) num,sum(rmbprice) as sumprice,sum(rmbprice)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state<>3  "+WhereSQL;

      aRS = aBean.executeQuery(countSQL);
	  if (aRS.next()){
	   aorderNums=aRS.getDouble("num");
	   acountsumprices=aRS.getDouble("sumprice");
	   acountavgprices=aRS.getDouble("avgprice");
	   acountsumjzareas=aRS.getDouble("sumjzarea");  
	   acountsumareas=aRS.getDouble("sumarea");  
	}
	aRS.close();
	 %>
  <tr align="center"> 
    <td>&nbsp;<font face="黑体"><b>合计</b></font></td>
    <td>&nbsp;</td>
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%>套</td>
    <td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas,4) %>m<sup>2</sup></td>
    <td>&nbsp;<%=FormatD.getFloat2(acountsumareas,4) %>m<sup>2</sup></td>
    <td>&nbsp;￥<%=FormatD.getFloat2(acountsumprices,2) %></td>
    <td>&nbsp;￥<%=FormatD.getFloat2(acountavgprices,2) %></td>
  </tr>
</table>
<p align="left" ><font face="黑体"><b>累计销售率</b></font></p>
  <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center">
     <td width="6%"   ><font face="黑体"><b>序号</b></font></td> 
	 <td width="9%"  ><font face="黑体"><b>楼盘名称</b></font></td> 
	 <td width="8%"   ><font face="黑体"><b>累计套数</b></font></td>  
	 <td width="10%"   ><font face="黑体"><b>可销售套数</b></font></td> 
     <td width="11%"  ><font face="黑体"><b>套数销售率</b></font></td>  
	 <td width="10%"  ><font face="黑体"><b>已销售面积</b></font></td>
	 <td width="10%"  ><font face="黑体"><b>可销售面积</b></font></td>
	 <td width="13%" colspan="2" ><font face="黑体"><b>建筑面积销售率</b></font></td> 
   </tr>  
  
  
  <% double sumnum1=0;
     double sumarea1=0;
     countSQL="select section,sectionname,count(*) num,sum(rmbprice) as sumprice,sum(rmbprice)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state<>3  "+WhereSQL+" group by section,sectionname";
      i=0;
      aRS = aBean.executeQuery(countSQL);
	 while (aRS.next()){
	   i=i+1;
	   countSQL="select count(*) num,sum(area) area from room where seccode='"+aRS.getString("section")+"'";// and salestate <> 4
	   
  	   ResultSet bRS = bBean.executeQuery(countSQL);
	    if (bRS.next()){
	      sumnum1=bRS.getDouble("num");
		  ssumnum1=ssumnum1+sumnum1;
	      sumarea1=bRS.getDouble("area");
		  ssumarea1=ssumarea1+sumarea1;
	    }
	    bRS.close();
	   sectionname1=getbyte(aRS.getString("sectionname"));	    
	   aorderNums=aRS.getDouble("num");
	   acountsumprices=aRS.getDouble("sumprice");
	   acountavgprices=aRS.getDouble("avgprice");
	   acountsumjzareas=aRS.getDouble("sumjzarea");  
	   acountsumareas=aRS.getDouble("sumarea");  
	   %>
	   <tr align="center">
	    <td>&nbsp;<%=i %></td>
	<td>&nbsp;<%=sectionname1 %></td>
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%>套</td>
     <td>&nbsp;<%=FormatD.getFloat2(sumnum1 ,0)%>套</td>	
	<td>&nbsp;<%=FormatD.getFloat2(aorderNums/sumnum1*100,2)%>%</td>
    <td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas,4) %>m<sup>2</sup></td>
	 <td>&nbsp;<%=FormatD.getFloat2(sumarea1,4) %>m<sup>2</sup></td>	
    <td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas/sumarea1*100 ,2)%>%</td>

    </tr>
	   <%
	}
	aRS.close();
	 %>
	 <% countSQL="select count(*) num,sum(rmbprice) as sumprice,sum(rmbprice)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state<>3  "+WhereSQL;
	  
      aRS = aBean.executeQuery(countSQL);
	  if (aRS.next()){
	   aorderNums=aRS.getDouble("num");
	   acountsumprices=aRS.getDouble("sumprice");
	   acountavgprices=aRS.getDouble("avgprice");
	   acountsumjzareas=aRS.getDouble("sumjzarea");  
	   acountsumareas=aRS.getDouble("sumarea");  
	}
	aRS.close();
	 %>
	 <tr align="center">
	 <td>&nbsp;<font face="黑体"><b>合计</b></font></td>
    <td>&nbsp;</td>	
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%>套</td>
	 <td>&nbsp;<%=FormatD.getFloat2(ssumnum1 ,0)%>套</td>	
   <td>&nbsp;<%=FormatD.getFloat2(aorderNums/ssumnum1*100,2)%>%</td>
    <td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas,4) %>m<sup>2</sup></td>
	 <td>&nbsp;<%=FormatD.getFloat2(ssumarea1,4) %>m<sup>2</sup></td>	
    <td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas/ssumarea1*100 ,2)%>%</td>

  </tr> 
</table>
<p align="left" ><font face="黑体"><b>签&nbsp;约</b></font></p>
<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center"> 
    <td width="6%"   ><font face="黑体"><b>序号</b></font></td>
    <td width="11%"  ><font face="黑体"><b>楼盘名称</b></font></td>
    <td width="8%"   ><font face="黑体"><b>本期签约</b></font></td>
    <td width="11%"  ><font face="黑体"><b>本期签约面积</b></font></td>
    <td width="11%"><font face="黑体"><b>本期签约金额</b></font></td>
    <td width="8%"   ><font face="黑体"><b>累计签约</b></font></td>
    <td width="11%"  ><font face="黑体"><b>累计签约面积</b></font></td>
    <td width="11%"><font face="黑体"><b>累计签约金额</b></font></td>
  </tr>
  <% countSQL="select section,sectionname,count(*) num,sum(rmbprice) as sumprice,sum(rmbprice)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state=2  "+WhereSQL+" group by section,sectionname";
      i=0; 
      aRS = aBean.executeQuery(countSQL);
	 while (aRS.next()){
	   i=i+1;
	   sectionname1=getbyte(aRS.getString("sectionname"));
	   aorderNums1=aRS.getDouble("num");
	   acountsumprices1=aRS.getDouble("sumprice");
	   acountavgprices1=aRS.getDouble("avgprice");
	   acountsumjzareas1=aRS.getDouble("sumjzarea");  
	   acountsumareas1=aRS.getDouble("sumarea");  
	   %>
  <tr align="center"> 
    <td>&nbsp;<%=i %></td>
    <td>&nbsp;<%=sectionname1 %></td>
    <% countSQL="select section,sectionname,count(*) num,sum(rmbprice) as sumprice,sum(rmbprice)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state=2  and sectionname='"+sectionname1+"' and substring(convert(char(24),visadate,120),1,10) >='"+dates+"' and substring(convert(char(24),visadate,120),1,10) <='"+dates1+"' group by section,sectionname";
      i=0;
	  aorderNums=0;
	  acountsumprices=0;
	  acountavgprices=0;
	  acountsumjzareas=0;  
	  acountsumareas=0;  
      ResultSet bRS = bBean.executeQuery(countSQL);
	  if (bRS.next()){
	   aorderNums=bRS.getDouble("num");
	   acountsumprices=bRS.getDouble("sumprice");
	   acountavgprices=bRS.getDouble("avgprice");
	   acountsumjzareas=bRS.getDouble("sumjzarea");  
	   acountsumareas=bRS.getDouble("sumarea");  
	   }%>
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%>套</td>
    <td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas,4)%>m<sup>2</sup></td>
    <td>&nbsp;￥<%=FormatD.getFloat2(acountsumprices,2) %></td>
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums1 ,0)%>套</td>
    <td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas1,4)%>m<sup>2</sup></td>
    <td>&nbsp;￥<%=FormatD.getFloat2(acountsumprices1,2) %></td>
  </tr>
  <%
	}
	aRS.close();
	 %>
  <% countSQL="select count(*) num,sum(rmbprice) as sumprice,sum(rmbprice)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state=2   and substring(convert(char(24),visadate,120),1,10) >='"+dates+"' and substring(convert(char(24),visadate,120),1,10) <='"+dates1+"' "+WhereSQL;
      aRS = aBean.executeQuery(countSQL);
	  if (aRS.next()){
	   aorderNums=aRS.getDouble("num");
	   acountsumprices=aRS.getDouble("sumprice");
	   acountavgprices=aRS.getDouble("avgprice");
	   acountsumjzareas=aRS.getDouble("sumjzarea");  
	   acountsumareas=aRS.getDouble("sumarea");  
	}
	aRS.close();
	 %>
  <tr align="center"> 
    <td>&nbsp;<font face="黑体"><b>合计</b></font></td>
    <td>&nbsp;</td>
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%>套</td>
    <td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas,4)%>m<sup>2</sup></td>
    <td>&nbsp;￥<%=FormatD.getFloat2(acountsumprices,2) %></td>
    <% countSQL="select count(*) num,sum(rmbprice) as sumprice,sum(rmbprice)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state=2  "+WhereSQL;
      aRS = aBean.executeQuery(countSQL);
	  if (aRS.next()){
	   aorderNums=aRS.getDouble("num");
	   acountsumprices=aRS.getDouble("sumprice");
	   acountavgprices=aRS.getDouble("avgprice");
	   acountsumjzareas=aRS.getDouble("sumjzarea");  
	   acountsumareas=aRS.getDouble("sumarea");  
	}
	aRS.close();
	 %>
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%>套</td>
    <td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas,4)%>m<sup>2</sup></td>
    <td>&nbsp;￥<%=FormatD.getFloat2(acountsumprices,2) %></td>
  </tr>
</table>
<p align="left" ><font face="黑体"><b>按&nbsp;揭</b></font></p>
  <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center"> 
    <td width="6%"   ><font face="黑体"><b>序号</b></font></td>
    <td width="11%"  ><font face="黑体"><b>楼盘名称</b></font></td>
    <td width="8%"   ><font face="黑体"><b>本期按揭</b></font></td>
    <td width="8%"  ><font face="黑体"><b>本期按揭额</b></font></td>
    <td width="11%"  ><font face="黑体"><b>本期银行放款</b></font></td>
    <td width="13%"   ><font face="黑体"><b>累计按揭套数</b></font></td>
    <td width="11%"  ><font face="黑体"><b>累计按揭额</b></font></td>
    <td width="13%" ><font face="黑体"><b>累计银行放款</b></font></td>
  </tr>
  <%  double aorderNums2=0;
      double ajmoney2=0;
	  double sumajmoney2=0;
      countSQL="select section,sectionname,count(*) num,sum(ajmoney) as ajmoney1 from order_contract  where  state<>3 and  payment1 like '%按揭%'   "+WhereSQL+" group by section,sectionname ";
      int code=0;
    
      i=0;
      aRS = aBean.executeQuery(countSQL);
	  
	 while (aRS.next()){
	   i=i+1;
	   sectionname1=getbyte(aRS.getString("sectionname"));
	   aorderNums2=aRS.getDouble("num");
	   ajmoney2=aRS.getDouble("ajmoney1");
	   %>
  <tr align="center"> 
    <td>&nbsp;<%=i %></td>
    <td>&nbsp;<%=sectionname1 %></td>
    <%
	   String countSQL2="select section,sectionname,count(*) num,sum(ajmoney) as ajmoney1 from order_contract  where state<>3 and  ajmoney>0   and substring(convert(char(24),date,120),1,10) >='"+dates+"' and substring(convert(char(24),date,120),1,10) <='"+dates1+"'  and sectionname='"+sectionname1+"'   group by section,sectionname";
	 
	   ajmoney=0;
	   ResultSet bRS = bBean.executeQuery(countSQL2);
	   aorderNums=0;
	   if (bRS.next()){
	   	   aorderNums=bRS.getDouble("num");
	       ajmoney=bRS.getDouble("ajmoney1");
		}
	   String SQL="select sum(FactMonye) as FactMonye from FactAjCharges where   factdate>='"+dates+"' and  factdate<='"+dates1+"' and contractno in (select code from order_contract  where state<>3 and  sectionname='"+sectionname1+"'  )";
//out.print(SQL);
        bRS = bBean.executeQuery(SQL);
	   if (bRS.next()){
	   sumajmoney=bRS.getDouble("FactMonye");
    	}bRS.close();	  
		 SQL="select sum(FactMonye) as FactMonye from FactAjCharges where  contractno in (select code from order_contract  where state<>3 and sectionname='"+sectionname1+"'  )";
	 
        bRS = bBean.executeQuery(SQL);
	   if (bRS.next()){
	   sumajmoney2=bRS.getDouble("FactMonye");
    	}bRS.close();	 
	   %>
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%>套</td>
    <td>&nbsp;￥<%=FormatD.getFloat2(ajmoney,2)%></td>
    <td>&nbsp;￥<%=FormatD.getFloat2(sumajmoney,2)%></td>
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums2 ,0)%>套</td>
    <td>&nbsp;￥<%=FormatD.getFloat2(ajmoney2,2)%></td>
    <td>&nbsp;￥<%=FormatD.getFloat2(sumajmoney2,2)%></td>
  </tr>
  <%
	}
	aRS.close();
	 %>
  <% double ajmoneys2=0;
	    
	  countSQL="select count(*) num,sum(ajmoney) as ajmoneys1 from order_contract where state<>3 and  ajmoney>0     and substring(convert(char(24),date,120),1,10) >='"+dates+"' and substring(convert(char(24),date,120),1,10) <='"+dates1+"'"+WhereSQL;
      aRS = aBean.executeQuery(countSQL);
	  
	  if (aRS.next()){
	   aorderNums=aRS.getDouble("num");
	   ajmoneys1=aRS.getDouble("ajmoneys1");  
	   
	}
	aRS.close();
	countSQL="select count(*) num,sum(ajmoney) as ajmoneys1 from order_contract where state<>3 and   ajmoney>0    "+WhereSQL;
      aRS = aBean.executeQuery(countSQL);
	  
	  if (aRS.next()){
	   aorderNums2=aRS.getDouble("num");
	   ajmoneys2=aRS.getDouble("ajmoneys1");  
	   
	}
	aRS.close();
	
	 String SQL="";
     if (!SecNo1.equals(""))
	    SQL="select sum(FactMonye) as FactMonye from FactAjCharges where contractno in (select code from order_contract  where state<>3 and  ajmoney>0 "+ WhereSQL +") and     factdate>='"+dates+"' and  factdate<='"+dates1+"'";
	 else 
	   	SQL="select sum(FactMonye) as FactMonye from FactAjCharges where contractno in (select code from order_contract where state<>3  and ajmoney>0 "+ WhereSQL +") and factdate>='"+dates+"' and  factdate<='"+dates1+"'";
	 //out.println(SQL);
	 ResultSet bRS = bBean.executeQuery(SQL);
	   if (bRS.next()){
	   sumajmoney=bRS.getDouble("FactMonye");
    	}bRS.close();	
	 
	 SQL="select sum(FactMonye) as FactMonye from FactAjCharges where contractno in (select code from order_contract  where state<>3 and  ajmoney>0  "+ WhereSQL +")";
	 
            // out.println(SQL);
	  bRS = bBean.executeQuery(SQL);
	   if (bRS.next()){
	   sumajmoney2=bRS.getDouble("FactMonye");
    	}bRS.close();	  
	 %>
  <tr align="center"> 
    <td>&nbsp;<font face="黑体"><b>合计</b></font></td>
    <td>&nbsp;</td>
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%>套</td>
    <td>&nbsp;￥<%=FormatD.getFloat2(ajmoneys1,2)%></td>
    <td>&nbsp;￥<%=FormatD.getFloat2(sumajmoney,2)%></td>
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums2 ,0)%>套</td>
    <td>&nbsp;￥<%=FormatD.getFloat2(ajmoneys2,2)%></td>
    <td>&nbsp;￥<%=FormatD.getFloat2(sumajmoney2,2)%></td>
  </tr>
</table>
<p align="left" ><font face="黑体"><b>收&nbsp;款</b></font></p>
  <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center">
     <td width="5%"   ><font face="黑体"><b>序号</b></font></td> 
	 <td width="11%"  ><font face="黑体"><b>楼盘名称</b></font></td> 
	 <td width="8%"   ><font face="黑体"><b>本期收款</b></font></td>   
     <td width="9%"  ><font face="黑体"><b>累计到帐款</b></font></td>  
	 <td width="11%"  ><font face="黑体"><b>累计成交总价</b></font></td>	
	 <td width="11%" colspan="3" ><font face="黑体"><b>回款率</b></font></td> 
   </tr>  
  
  
  <% countSQL="select section,sectionname,count(*) num,sum(rmbprice) as sumprice  from order_contract where state<>3  "+WhereSQL+" group by section,sectionname";
     //out.print(countSQL);
      i=0;
      aRS = aBean.executeQuery(countSQL);
	  double money1=0;//本期收款
	  double money2=0;//本期放款
	  double money3=0;//累计收款
	  double money4=0;//累计放款
	  double money5=0;//累计成交
      String sectionno="";
	 while (aRS.next()){
	   i=i+1;
	   sectionno=aRS.getString("section");
	 
	     countSQL="select sum(rmbprice) as factmoney from order_contract where state<>3 and  section ='"+sectionno+"'";

	   bRS = bBean.executeQuery(countSQL);
	    if (bRS.next()){
	      money5=bRS.getDouble("factmoney");
	    }
	    bRS.close();	
	   
	   countSQL="select sum(factmoney*currrate) as factmoney from FactGatheringRecord where  Gather_Date >='"+dates+"' and  Gather_Date<='"+dates1+"' and  contractno in (select code from  order_contract where state<>3 and   section ='"+sectionno+"')";
  	   bRS = bBean.executeQuery(countSQL);
	    if (bRS.next()){
	      money1=bRS.getDouble("factmoney");
	    }
	    bRS.close();	
		 countSQL="select sum(factmoney*currrate) as factmoney from FactGatheringRecord where    contractno in (select code from  order_contract where state<>3 and section ='"+sectionno+"')";

	   bRS = bBean.executeQuery(countSQL);
	    if (bRS.next()){
	      money3=bRS.getDouble("factmoney");
	    }
	    bRS.close();	
		
		 countSQL="select sum(FactMonye) as FactMonye from FactAjCharges where FactDate >='"+dates+"' and  FactDate<='"+dates1+"' and  contractno in (select code from  order_contract where  state<>3 and section ='"+sectionno+"')";
	   bRS = bBean.executeQuery(countSQL);
	    if (bRS.next()){
	      money2=bRS.getDouble("FactMonye");
	    }
	    bRS.close();  
			
		 countSQL="select sum(FactMonye) as FactMonye from FactAjCharges where  contractno in (select code from  order_contract where state<>3 and section ='"+sectionno+"')";
  	   
	   bRS = bBean.executeQuery(countSQL);
	    if (bRS.next()){
	      money4=bRS.getDouble("FactMonye");
	    }
	    bRS.close();
	   sectionname1=getbyte(aRS.getString("sectionname"));
	   aorderNums=aRS.getDouble("num");
	   %>
	   <tr align="center">
	    <td>&nbsp;<%=i %></td>
	<td>&nbsp;<%=sectionname1 %></td>
    <td>&nbsp;￥<%=FormatD.getFloat2(money1+money2,2)%></td>    
	<td>&nbsp;￥<%=FormatD.getFloat2(money3+money4,2)%></td>
    <td>&nbsp;￥<%=FormatD.getFloat2(money5,2)%></td>
    <td>&nbsp;<%=FormatD.getFloat2((money3+money4)/money5*100 ,2)%>%</td>

    </tr>
	   <%
	}
	aRS.close();
	 %>
	 <%    
	double sumajmoney1=0;
	double sumajmoney3=0;
	double  sumprice=0;
	
	sumprice=0;
	//累计成交款
	if (!SecNo1.equals(""))	
	 countSQL="select sum(rmbprice) as sumprice from order_contract where state<>3 and section ='"+SecNo1+"'";// where "+"date>='"+dates+"' and  date<='"+dates1+"'"+WhereSQL;
    else
	   countSQL="select sum(rmbprice) as sumprice from order_contract where state<>3 "+WhereSQL;// where "+"date>='"+dates+"' and  date<='"+dates1+"'"+WhereSQL;
  
	  aRS = aBean.executeQuery(countSQL);
	  if (aRS.next()){
	     sumprice=aRS.getDouble("sumprice");
	   
	  
	}
	aRS.close();
	//本期收款
	if (!SecNo1.equals(""))	
	 countSQL="select sum(factmoney*currrate) as factmoney from FactGatheringRecord where  Gather_Date >='"+dates+"' and  Gather_Date<='"+dates1+"' and  contractno in (select code from  order_contract   where state<>3 and  section ='"+SecNo1+"')";
  	else
	 countSQL="select sum(factmoney*currrate) as factmoney from FactGatheringRecord where  Gather_Date >='"+dates+"' and  Gather_Date<='"+dates1+"' and  contractno in (select code from  order_contract where state<>3 "+ WhereSQL +")";//   where  section ='"+SecNo+"')";
	 bRS = bBean.executeQuery(countSQL);
//out.println(countSQL);
sumajmoney=0;
	  if (bRS.next()){
	      sumajmoney=bRS.getDouble("factmoney");
	    }
	    bRS.close();	
	//累计收款
	if (!SecNo1.equals(""))
	  countSQL="select sum(factmoney*currrate) as factmoney from FactGatheringRecord where contractno in (select code from  order_contract where state<>3 and section ='"+SecNo1+"')";//where  Gather_Date >='"+dates+"' and  Gather_Date<='"+dates1+"' and  contractno in (select code from  order_contract where "+"date>='"+dates+"' and  date<='"+dates1+"'"+WhereSQL+")";
	else
      countSQL="select sum(factmoney*currrate) as factmoney from FactGatheringRecord where contractno in (select code from order_contract where state<>3 "+ WhereSQL +") ";//where contractno in (select code from  order_contract where section ='"+SecNo+"')";//where  Gather_Date >='"+dates+"' and  Gather_Date<='"+dates1+"' and  contractno in (select code from  order_contract where "+"date>='"+dates+"' and  date<='"+dates1+"'"+WhereSQL+")";
	 

	 bRS = bBean.executeQuery(countSQL);

	  if (bRS.next()){
	      sumajmoney1=bRS.getDouble("factmoney");
	    }
	    bRS.close();		
		//本期放款
	if (!SecNo1.equals(""))	
	 countSQL="select sum(FactMonye) as FactMonye from FactAjCharges where FactDate >='"+dates+"' and  FactDate<='"+dates1+"' and  contractno in (select code from  order_contract where state<>3 and section='"+SecNo1+"')";// where "+"date>='"+dates+"' and  date<='"+dates1+"'"+WhereSQL+")";
    else
	  countSQL="select sum(FactMonye) as FactMonye from FactAjCharges where FactDate >='"+dates+"' and  FactDate<='"+dates1+"' and  contractno in (select code from  order_contract where state<>3 "+ WhereSQL +")";// where "+"date>='"+dates+"' and  date<='"+dates1+"'"+WhereSQL+")";
  	 bRS = bBean.executeQuery(countSQL);

	  if (bRS.next()){
	      sumajmoney3=bRS.getDouble("FactMonye");
	    }
	    bRS.close();	
		//累计放款
		double sumajmoney5=0;
		if (!SecNo1.equals(""))
		 countSQL="select sum(FactMonye) as FactMonye from FactAjCharges  where contractno in (select code from  order_contract where state<>3 and section ='"+SecNo1+"')";//where FactDate >='"+dates+"' and  FactDate<='"+dates1+"' and  contractno in (select code from  order_contract where "+"date>='"+dates+"' and  date<='"+dates1+"'"+WhereSQL+")";
  	   else
	     countSQL="select sum(FactMonye) as FactMonye from FactAjCharges where contractno in (select code from order_contract where state<>3 "+ WhereSQL +") ";// where contractno in (select code from  order_contract where section ='"+SecNo+"')";//where FactDate >='"+dates+"' and  FactDate<='"+dates1+"' and  contractno in (select code from  order_contract where "+"date>='"+dates+"' and  date<='"+dates1+"'"+WhereSQL+")";
	   bRS = bBean.executeQuery(countSQL);
	 	  
	  if (bRS.next()){
	      sumajmoney5=bRS.getDouble("FactMonye");
	    }
	    bRS.close();	
		 
	 %>
	 <tr align="center">
	 <td>&nbsp;<font face="黑体"><b>合计</b></font></td>
    <td>&nbsp;</td>
    <td>&nbsp;￥<%=FormatD.getFloat2(sumajmoney+sumajmoney3,2)%></td>
  <td>&nbsp;￥<%=FormatD.getFloat2(sumajmoney1+sumajmoney5,2)%></td>
    <td>&nbsp;￥<%=FormatD.getFloat2(sumprice,2)%></td>
    <td>&nbsp;<%=FormatD.getFloat2((sumajmoney1+sumajmoney5)/sumprice*100 ,2)%>%</td>

  </tr> 
</table>

<p>&nbsp;</p>

 <table width="100%">
 <tr>
 <td width="65%"></td>
 <td width="20%" align="center"><font size=4>房产销售部</font></td>
 <td width="15%"></td>
 </tr>
 </table>
 <table width="100%">
 <%java.util.Date curDate=new java.util.Date();
  int CurYear=curDate.getYear()+1900;
      int CurMonth=curDate.getMonth()+1;
      int CurDay=curDate.getDate(); %>
 <tr>
 <td width="65%"></td>
 <td width="20%" align="center"><font size=4><%=CurYear %>年<%=CurMonth %>月<%=CurDay %>日</font></td>
 <td width="15%"></td>
 </tr>
 </table>
<script>
function dda(){
var today=new Date();
var dd1=String(today.getMonth()+1);
dd.innerText=today.getYear()+"年"+dd1+"月"+today.getDay()+"日";
}


function printd(){
if (confirm("打印吗？"))
  print();

}
</script>

</body>
</html>
