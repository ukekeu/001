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
   <%@ include file="../public_js/qx_checke.jsp"%>
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
	double aorderNums2=0;
	double aorderNums3=0;
	double aorderNums4=0;
	double aorderNums5=0;
	double dzcountsumprices=0;
	double sumsaleprice=0;

	String dates=China.getParameter(request,"Date1");
	String dates1=China.getParameter(request,"Date2");
	String SecNo=China.getParameter(request,"SecNo");
	String cusnote="";
	String agentcom="";
	String agentnote="";
	String projectman="";
	String projectnote="";
	String id=China.getParameter(request,"id");
	if(!id.equals("")){
	String sql="select * from saleweekly where id="+id;
	ResultSet rs = aBean.executeQuery(sql);
	if (rs.next()){
	  SecNo=rs.getString("section");
	  dates=rs.getString("date1").substring(0,10);
	  dates1=rs.getString("date2").substring(0,10);
	  cusnote=getbyte(rs.getString("cusnote"));
	  agentcom=getbyte(rs.getString("agentcom"));
	  agentnote=getbyte(rs.getString("agentnote"));
	  projectman=getbyte(rs.getString("projectman"));
	  projectnote=getbyte(rs.getString("projectnote"));
	}
	}
	
	
	String secname="";
	String sqlsecno=" select name FROM crm_project where serialno='"+SecNo+"'";
	ResultSet secrs = aBean.executeQuery(sqlsecno);
	if (secrs.next()){
	  secname=getbyte(secrs.getString("name"));
	}
	String Loft=China.getParameter(request,"Loft");
	String WhereSQL="";
	if(!SecNo.equals(""))
	  WhereSQL +=" and section='"+SecNo+"'";
	String WhereSQL1=WhereSQL+" and date>='"+dates+"' and  date<='"+dates1+"'";
	String sdate="";
	String edate="";
	String whereDate="";
	
   
	String countSQL="select count(*) num,sum(salerprice*rate) as sumprice,sum(salerprice*rate)/sum(jzarea) as avgprice,sum(jzarea) as sumarea from order_contract where state=1"+WhereSQL;
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
	countSQL="select sum(FactMonye) as FactMonye from FactAjCharges where contractno in (select code from  order_contract where section='" +SecNo+"')";

	aRS = aBean.executeQuery(countSQL);
	if (aRS.next()){
	   sumajmoney=aRS.getDouble("FactMonye");

	}
	aRS.close();
	
	 countSQL="select count(*) num,sum(salerprice*rate) as sumprice,sum(salerprice*rate)/sum(jzarea) as avgprice,sum(jzarea) as sumarea from order_contract where state=1";
  	 aRS = aBean.executeQuery(countSQL);
	if (aRS.next()){
	   orderNum1=aRS.getDouble("num");
	   countsumprice1=aRS.getDouble("sumprice");
	   countavgprice1=aRS.getDouble("avgprice");
	   countsumarea1=aRS.getDouble("sumarea");
	}
	aRS.close();
	 countSQL="select count(*) num,sum(salerprice*rate) as sumprice,sum(salerprice*rate)/sum(jzarea) as avgprice,sum(jzarea) as sumarea from order_contract where state=2"+WhereSQL1;
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
	
	
	 countSQL="select sum(salerprice*rate) as sumprice from order_contract ";
  	 aRS = aBean.executeQuery(countSQL);
	
	if (aRS.next()){
	   sumsaleprice=aRS.getDouble("sumprice");
	}
	aRS.close();
}catch(Exception s)	{out.print(countSQL);out.close();}
	
	
   %>
<body  ondblclick="printd();">
<form name="hsm" method="post">
<input type="hidden" name="date1" value="<%=dates %>">
<input type="hidden" name="date2" value="<%=dates1 %>">
<input type="hidden" name="section" value="<%=SecNo %>">
<input type="hidden" name="id" value="<%=id %>">
<p align="center"><font size=5><b><%=secname %>销售总结</b></font></p>

<p align="center" ><font size=3>日期:<%=dates%>----<%=dates1 %></font></p>

<p align="left" ><font face="黑体"><b>一、成交情况统计</b></font></p>
<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center"> 
    <td width="6%"   ><font face="黑体"><b>&nbsp;</b></font></td>
    <!--td width="11%"  ><font face="黑体"><b>楼盘名称</b></font></td-->
    <td width="8%"   ><font face="黑体"><b>套数</b></font></td>
    <td width="11%"  ><font face="黑体"><b>成交面积</b></font></td>
    <td width="11%"><font face="黑体"><b>成交金额(元)</b></font></td>
    <td width="8%"   ><font face="黑体"><b>成交均价(元)</b></font></td>
    <td width="11%"  ><font face="黑体"><b>占可售比例(套数)</b></font></td>
    <!--td width="11%"><font face="黑体"><b>累计签约金额</b></font></td-->
  </tr>
  <% countSQL="select section,sectionname,count(*) num,sum(salerprice*rate) as sumprice,sum(salerprice*rate)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state!=3  "+WhereSQL+" group by section,sectionname";
      int i=0; 
	  String sectionname1="";
      ResultSet aRS = aBean.executeQuery(countSQL);
	 if (aRS.next()){
	   i=i+1;
	   sectionname1=getbyte(aRS.getString("sectionname"));
	   aorderNums1=aRS.getDouble("num");
	   acountsumprices1=aRS.getDouble("sumprice");
	   acountavgprices1=aRS.getDouble("avgprice");
	   acountsumjzareas1=aRS.getDouble("sumjzarea");  
	   acountsumareas1=aRS.getDouble("sumarea");  
	   %>
  <tr align="center"> 
    <td><font face="黑体"><b>本期合计</b></font></td>
    <% countSQL="select section,sectionname,count(*) num,sum(salerprice*rate) as sumprice,sum(salerprice*rate)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state!=3  and sectionname='"+sectionname1+"' and substring(convert(char(24),date,120),1,10) >='"+dates+"' and substring(convert(char(24),date,120),1,10) <='"+dates1+"' group by section,sectionname";
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
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%></td>
    <td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas,4)%>m<sup>2</sup></td>
    <td>&nbsp;￥<%=FormatD.getFloat2(acountsumprices,2) %></td>
    <td>&nbsp;<%if(acountsumjzareas==0){out.print(acountsumjzareas);}else{out.print(FormatD.getFloat2(acountsumprices/acountsumjzareas,2));}%></td>
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums/sumnum*100,2)%>%</td>
    <!--td>&nbsp;￥<%=FormatD.getFloat2(acountsumprices1,2) %></td-->
  </tr>
  <%
	}
	aRS.close();
	 %>
  <% countSQL="select count(*) num,sum(salerprice*rate) as sumprice,sum(salerprice*rate)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state!=3   and substring(convert(char(24),date,120),1,10) >='"+dates+"' and substring(convert(char(24),date,120),1,10) <='"+dates1+"' "+WhereSQL;
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
	 <% countSQL="select section,sectionname,count(*) num,sum(salerprice*rate) as sumprice,sum(salerprice*rate)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state!=3  "+WhereSQL+" group by section,sectionname";
       i=0; 
	   sectionname1="";
       aRS = aBean.executeQuery(countSQL);
	 if (aRS.next()){
	   i=i+1;
	   sectionname1=getbyte(aRS.getString("sectionname"));
	   aorderNums1=aRS.getDouble("num");
	   acountsumprices1=aRS.getDouble("sumprice");
	   acountavgprices1=aRS.getDouble("avgprice");
	   acountsumjzareas1=aRS.getDouble("sumjzarea");  
	   acountsumareas1=aRS.getDouble("sumarea");  
	   %>
	 <tr align="center"> 
    <td><font face="黑体"><b>本月合计</b></font></td>
    <% countSQL="select section,sectionname,count(*) num,sum(salerprice*rate) as sumprice,sum(salerprice*rate)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state!=3 and sectionname='"+sectionname1+"' and DATEPART(year,date) = DATEPART(year,'"+dates+"') and DATEPART(month,date) = DATEPART(month,'"+dates+"') group by section,sectionname";
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
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%></td>
    <td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas,4)%>m<sup>2</sup></td>
    <td>&nbsp;￥<%=FormatD.getFloat2(acountsumprices,2) %></td>
    <td>&nbsp;<%if(acountsumjzareas==0){out.print(acountsumjzareas);}else{out.print(FormatD.getFloat2(acountsumprices/acountsumjzareas,2));}%></td>
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums/sumnum*100,2)%>%</td>
    <!--td>&nbsp;￥<%=FormatD.getFloat2(acountsumprices1,2) %></td-->
  </tr>
  <%
	}
	aRS.close();
	 %>
  <% countSQL="select count(*) num,sum(salerprice*rate) as sumprice,sum(salerprice*rate)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state!=3   and substring(convert(char(24),date,120),1,10) >='"+dates+"' and substring(convert(char(24),date,120),1,10) <='"+dates1+"' "+WhereSQL;
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
    <!--td>&nbsp;</td-->
    <% countSQL="select count(*) num,sum(salerprice*rate) as sumprice,sum(salerprice*rate)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state!=3  and substring(convert(char(24),date,120),1,10) <='"+dates1+"' "+WhereSQL;
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
    <td>&nbsp;<%if(acountsumjzareas==0){out.print(acountsumjzareas);}else{out.print(FormatD.getFloat2(acountsumprices/acountsumjzareas,2));}%></td>
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums/sumnum*100,2)%>%</td>
    <!--td>&nbsp;￥<%=FormatD.getFloat2(acountsumprices,2) %></td-->
  </tr>
</table>
<p align="left" ><font face="黑体"><b>二、退定统计</b></font></p>
<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center"> 
    <td width="6%"   ><font face="黑体"><b>总套数</b></font></td>
    <!--td width="11%"  ><font face="黑体"><b>楼盘名称</b></font></td-->
    <td width="8%"   ><font face="黑体"><b>已成交套数</b></font></td>
    <td width="11%"  ><font face="黑体"><b>已退套数</b></font></td>
    <td width="11%"><font face="黑体"><b>临定套数</b></font></td>
    <!--td width="8%"   ><font face="黑体"><b>成交均价(元)</b></font></td>
    <td width="11%"  ><font face="黑体"><b>占可售比例(套数)</b></font></td>
    <td width="11%"><font face="黑体"><b>累计签约金额</b></font></td-->
  </tr>
  <% countSQL="select section,sectionname,count(*) num,sum(salerprice*rate) as sumprice,sum(salerprice*rate)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state!=3   and substring(convert(char(24),date,120),1,10) <='"+dates1+"' "+WhereSQL+" group by section,sectionname";
       i=0; 
	   sectionname1="";
       aRS = aBean.executeQuery(countSQL);
	 if (aRS.next()){
	   sectionname1=getbyte(aRS.getString("sectionname"));
	   aorderNums1=aRS.getDouble("num");
	   %>
  <tr align="center"> 
  
    <% countSQL="select section,sectionname,count(*) num,sum(salerprice*rate) as sumprice,sum(salerprice*rate)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state!=3 and sectionname='"+sectionname1+"' and substring(convert(char(24),date,120),1,10) >='"+dates+"' and substring(convert(char(24),date,120),1,10) <='"+dates1+"' group by section,sectionname";
	  aorderNums=0;
      ResultSet bRS = bBean.executeQuery(countSQL);
	  if (bRS.next()){
	   aorderNums=bRS.getDouble("num");
	   }%>
	   <% countSQL="select section,sectionname,count(*) num,sum(salerprice*rate) as sumprice,sum(salerprice*rate)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state=3 and sectionname='"+sectionname1+"' and substring(convert(char(24),date,120),1,10) >='"+dates+"' and substring(convert(char(24),date,120),1,10) <='"+dates1+"' group by section,sectionname";
	  aorderNums2=0;
      bRS = bBean.executeQuery(countSQL);
	  if (bRS.next()){
	   aorderNums2=bRS.getDouble("num");
	   }%>
	   <% countSQL="select count(*) num from SL_TemporarilyBuy where roomcode in (select code from room where  seccode='"+SecNo+"')  and startdate>='"+dates+"' and  startdate<='"+dates1+"' ";
	  aorderNums3=0;
      bRS = bBean.executeQuery(countSQL);
	  if (bRS.next()){
	   aorderNums3=bRS.getDouble("num");
	   }%>
	<td>&nbsp;<%=FormatD.getFloat2(aorderNums1 ,0)%></td>
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%></td>
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums2 ,0)%></td>
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums3 ,0)%></td>   
  </tr>
  <%
	}
	aRS.close();
	 %>
  
  
</table>
<p align="left" ><font face="黑体"><b>三、成交客户分析</b></font><font size="2">----户型及楼层统计</font></p>
<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center"> 
    <td width="10%"   ><font face="黑体"><b>户型楼层</b></font></td>
    <td width="8%"   ><font face="黑体"><b>5--10层</b></font></td>
    <td width="8%"  ><font face="黑体"><b>11--15层</b></font></td>
    <td width="8%"><font face="黑体"><b>16--20层</b></font></td>
    <td width="8%"   ><font face="黑体"><b>21--25层</b></font></td>
    <td width="8%"  ><font face="黑体"><b>26--31层</b></font></td>
	<td width="5%"  ><font face="黑体"><b>比例</b></font></td>
  </tr>
  <tr align="center"> 
    <% countSQL="SELECT  roomtype,count(roomtype) num FROM room WHERE seccode='"+SecNo+"' group by roomtype";
      i=0;
	  String codename="";
	  aorderNums=0;
	  acountsumprices=0;
	  acountavgprices=0;
	  acountsumjzareas=0;  
	  acountsumareas=0; 
	  
      ResultSet bRS = bBean.executeQuery(countSQL);
	  while (bRS.next()){
	   codename=getbyte(bRS.getString("roomtype"));
	   aorderNums=bRS.getDouble("num");
	   aorderNums1=0;
	   countSQL="select count(*) num from order_contract where state!=3  "+WhereSQL1+" and roomtype='"+codename+"' and floors<=10 and floors >=5" ;
       aRS = aBean.executeQuery(countSQL);
	   if (aRS.next()){
	  	   aorderNums1=aRS.getDouble("num");
	   }
	   countSQL="select count(*) num from order_contract where state!=3  "+WhereSQL1+" and roomtype='"+codename+"' and floors<=15 and floors >=11" ;
       aRS = aBean.executeQuery(countSQL);
	   if (aRS.next()){
	  	   aorderNums2=aRS.getDouble("num");
	   }
	   countSQL="select count(*) num from order_contract where state!=3  "+WhereSQL1+" and roomtype='"+codename+"' and floors<=20 and floors >=16" ;
       aRS = aBean.executeQuery(countSQL);
	   if (aRS.next()){
	  	   aorderNums3=aRS.getDouble("num");
	   }
	   countSQL="select count(*) num from order_contract where state!=3  "+WhereSQL1+" and roomtype='"+codename+"' and floors<=25 and floors >=21" ;
       aRS = aBean.executeQuery(countSQL);
	   if (aRS.next()){
	  	   aorderNums4=aRS.getDouble("num");
	   }
	   countSQL="select count(*) num from order_contract where state!=3  "+WhereSQL1+" and roomtype='"+codename+"' and floors<=31 and floors >=26" ;
       aRS = aBean.executeQuery(countSQL);
	   if (aRS.next()){
	  	   aorderNums5=aRS.getDouble("num");
	   }
	   %>
    <td align="center"><font face="黑体"><b>&nbsp;<%=codename%>(<%=FormatD.getFloat2(aorderNums ,0) %>套)</b></font></td>
    <td align="center">&nbsp;<%=FormatD.getFloat2(aorderNums1 ,0)  %></td>
	<td align="center">&nbsp;<%=FormatD.getFloat2(aorderNums2 ,0)  %></td>
	<td align="center">&nbsp;<%=FormatD.getFloat2(aorderNums3 ,0)  %></td>
	<td align="center">&nbsp;<%=FormatD.getFloat2(aorderNums4 ,0)  %></td>
	<td align="center">&nbsp;<%=FormatD.getFloat2(aorderNums5 ,0)  %></td>
	<td align="center">&nbsp;<%=FormatD.getFloat2((aorderNums1+aorderNums2+aorderNums3+aorderNums4+aorderNums5)/aorderNums*100,2)%>%</td>

  </tr>
  <%}aRS.close();
	 %>
 
</table>
<p align="left" ><font face="黑体"><b>四、客户来源统计</b></font></p>
<p align="left" ><font size="2">1、来源区域统计</font></p>
<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center"> 
    <td width="10%"   ><font face="黑体"><b>区域</b></font></td>
    <td width="8%"   ><font face="黑体"><b>人数</b></font></td>
	<td width="5%"  ><font face="黑体"><b>比例</b></font></td>
  </tr>
  <tr align="center"> 
    <% countSQL="SELECT  region,count(region) num FROM customer WHERE section='"+SecNo+"' group by region ";
      i=0;
	   codename="";
	  aorderNums=0;
	  acountsumprices=0;
	  acountavgprices=0;
	  acountsumjzareas=0;  
	  acountsumareas=0; 
	   aorderNums2=0;
	   aorderNums3=0;
	   aorderNums4=0;
	   aorderNums5=0;
       bRS = bBean.executeQuery(countSQL);
	  while (bRS.next()){
	   codename=getbyte(bRS.getString("region"));
	   aorderNums=0;
	   aorderNums1=0;
	   countSQL="select count(*) num from customer where   visit_date>='"+dates+"' and  visit_date<='"+dates1+"' "+WhereSQL+"  " ;
       aRS = aBean.executeQuery(countSQL);
	   if (aRS.next()){
	  	   aorderNums=aRS.getDouble("num");
	   }
	   countSQL="select count(*) num from customer where region='"+codename+"' "+WhereSQL+"   and visit_date>='"+dates+"' and  visit_date<='"+dates1+"'" ;
       aRS = aBean.executeQuery(countSQL);
	   if (aRS.next()){
	  	   aorderNums1=aRS.getDouble("num");
	   }
	  
	   %>
    <td align="center"><font face="黑体"><b>&nbsp;<%=codename%></b></font></td>
    <td align="center">&nbsp;<%=FormatD.getFloat2(aorderNums1 ,0)  %></td>
	<td align="center">&nbsp;<%if(aorderNums!=0){out.print(FormatD.getFloat2(aorderNums1/aorderNums*100,2));}else{out.print("0");}%>%</td>

  </tr>
  <%}aRS.close();
	 %>
  <tr align="center"> 
   <td align="center"><font face="黑体"><b>&nbsp;合计</b></font></td>
    <td align="center">&nbsp;<%=FormatD.getFloat2(aorderNums ,0)  %></td>
	<td align="center">&nbsp;<%if(aorderNums==0){out.print("0");}else{out.print("100");} %>%</td>

  </tr>
  
</table>
<p align="left" ><font size="2">2、信息媒体统计</font></p>
<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center"> 
    <td width="10%"   ><font face="黑体"><b>&nbsp;</b></font></td>
    <td width="8%" colspan="2"><font face="黑体"><b>来电统计</b></font></td>
    <td width="8%" colspan="2"><font face="黑体"><b>来访统计</b></font></td>
  </tr>
  <tr  align="center"> 
    <td width="10%"   ><font face="黑体"><b>方式</b></font></td>
    <td width="8%"   ><font face="黑体"><b>人数</b></font></td>
    <td width="8%"  ><font face="黑体"><b>比例</b></font></td>
	<td width="8%"   ><font face="黑体"><b>人数</b></font></td>
    <td width="8%"  ><font face="黑体"><b>比例</b></font></td>
  </tr>
  <tr align="center"> 
    <% countSQL="SELECT  Knowledge_From,count(Knowledge_From) num FROM customer WHERE section='"+SecNo+"' group by Knowledge_From ";
      i=0;
	   codename="";
	  aorderNums=0;
	  aorderNums3=0;
	  aorderNums4=0;
       bRS = bBean.executeQuery(countSQL);
	  while (bRS.next()){
	   codename=getbyte(bRS.getString("Knowledge_From"));
	   aorderNums=0;
	   aorderNums1=0;
	   aorderNums2=0;
	   countSQL="select count(*) num from customer where Knowledge_From='"+codename+"' "+WhereSQL+"   and visit_date>='"+dates+"' and  visit_date<='"+dates1+"'" ;
       aRS = aBean.executeQuery(countSQL);
	   if (aRS.next()){
	  	   aorderNums=aRS.getDouble("num");
	   }
	   countSQL="select count(*) num from customer where Knowledge_From='"+codename+"' "+WhereSQL+"   and visit_date>='"+dates+"' and  visit_date<='"+dates1+"' and visitstate='1' " ;
       aRS = aBean.executeQuery(countSQL);
	   if (aRS.next()){
	  	   aorderNums1=aRS.getDouble("num");
		   aorderNums3=aorderNums3+aorderNums1;
	   }
	   countSQL="select count(*) num from customer where Knowledge_From='"+codename+"' "+WhereSQL+"   and visit_date>='"+dates+"' and  visit_date<='"+dates1+"' and visitstate='0' " ;
       aRS = aBean.executeQuery(countSQL);
	   if (aRS.next()){
	  	   aorderNums2=aRS.getDouble("num");
		   aorderNums4=aorderNums4+aorderNums2;
	   }
	   %>
    <td align="center"><font face="黑体"><b>&nbsp;<%=codename%></b></font></td>
    <td align="center">&nbsp;<%=FormatD.getFloat2(aorderNums1 ,0)  %></td>
	<td align="center">&nbsp;<%if(aorderNums!=0){out.print(FormatD.getFloat2(aorderNums1/aorderNums*100,2));}else{out.print("0");}%>%</td>
	 <td align="center">&nbsp;<%=FormatD.getFloat2(aorderNums2 ,0)  %></td>
	<td align="center">&nbsp;<%if(aorderNums!=0){out.print(FormatD.getFloat2(aorderNums2/aorderNums*100,2));}else{out.print("0");}%>%</td>

  </tr>
  <%}aRS.close();
	 %>
 <tr align="center"> 
   <td align="center"><font face="黑体"><b>&nbsp;合计</b></font></td>
   <td align="center">&nbsp;<%=FormatD.getFloat2(aorderNums3 ,0)  %></td>
	<td align="center">&nbsp;<%if(aorderNums3==0){out.print("0");}else{out.print("100");} %>%</td>
	 <td align="center">&nbsp;<%=FormatD.getFloat2(aorderNums4 ,0)  %></td>
	<td align="center">&nbsp;<%if(aorderNums4==0){out.print("0");}else{out.print("100");} %>%</td>


  </tr>
 
</table>
<p align="left" ><font face="黑体"><b>五、现场来电及来访客户统计</b></font></p>
<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center"> 
    <td width="10%"   ><font face="黑体"><b>日期</b></font></td>
    <td width="8%"   ><font face="黑体"><b>来电客户量</b></font></td>
    <td width="8%"  ><font face="黑体"><b>来访客户量</b></font></td>
  </tr>
  <tr align="center"> 
    <% countSQL="SELECT distinct DATEDIFF(day, '"+dates+"', '"+dates1+"') AS num FROM order_contract";
	   String appdate="";
	   int x=0;
	   int y=0;
	   aorderNums3=0;
	   aorderNums4=0;
       bRS = bBean.executeQuery(countSQL);
	   if (bRS.next()){
	      y=bRS.getInt("num");
       }
	   for(x=0;x<=y;x++)
	   {countSQL="select distinct dateadd(dy, +"+x+",'"+dates+"')  AS Exp1 FROM order_contract ";
	    bRS = bBean.executeQuery(countSQL);
		if (bRS.next()){
	      appdate=bRS.getString("Exp1").substring(0,10);
        }
		aorderNums1=0;
		aorderNums2=0;
		countSQL="select count(*) num from customer where visit_date='"+appdate+"' "+WhereSQL+"  and visitstate='1' " ;
        aRS = aBean.executeQuery(countSQL);
	    if (aRS.next()){
	  	   aorderNums1=aRS.getDouble("num");
		   aorderNums3=aorderNums3+aorderNums1;
	    }
		countSQL="select count(*) num from customer where visit_date='"+appdate+"' "+WhereSQL+"  and visitstate='0' " ;
        aRS = aBean.executeQuery(countSQL);
	    if (aRS.next()){
	  	   aorderNums2=aRS.getDouble("num");
		   aorderNums4=aorderNums4+aorderNums2;
	    }
	   %>
    <td align="center"><font face="黑体"><b>&nbsp;<%=appdate %></b></font></td>
    <td align="center">&nbsp;<%=FormatD.getFloat2(aorderNums1 ,0)  %></td>
    <td align="center">&nbsp;<%=FormatD.getFloat2(aorderNums2 ,0)  %></td>
  </tr>
 
 <%} %>
   <tr align="center"> 
   <td align="center"><font face="黑体"><b>&nbsp;合计</b></font></td>
   <td align="center">&nbsp;<%=FormatD.getFloat2(aorderNums3 ,0)  %></td>
   <td align="center">&nbsp;<%=FormatD.getFloat2(aorderNums4 ,0)  %></td>
  </tr>
</table>

<p align="left" ><font face="黑体"><b>六、客户反馈信息</b></font></p>
<%=cusnote %>
<p align="left" ><font face="黑体"><b>七、代理公司建议</b></font></p>
代理公司名称:<%=agentcom %>
<%=agentnote %>
<%if(!agentcom.equals("")){ %>
<p align="left" ><font face="黑体"><b>八、项目经理建议</b></font></p>
项目经理签名:<%=projectman %>
<%=projectnote %>
<%}else{ %>
<input type="hidden" name="projectman">
<input type="hidden" name="projectnote">
<%} %>

<script>
function dda(){
var today=new Date();
var dd1=String(today.getMonth()+1);
dd.innerText=today.getYear()+"年"+dd1+"月"+today.getDay()+"日";
}
function SaveContract(){
if (hsm.section.value == "") {
			alert("请选择楼栋");
			return false;
		}
if (hsm.date1.value == "") {
			alert("请选择开始日期");
			return false;
		}
if (hsm.date2.value == "") {
			alert("请选择结束日期");
			return false;
		}
 hsm.action="saleweeklyUpdate.jsp?Operation=Insert";
 hsm.submit();
}
function SaveContract1(){
hsm.action="saleweeklyUpdate.jsp?Operation=Modify";
hsm.submit();
}
function printd(){
if (confirm("打印吗？"))
  print();

}
</script>
</form>
</body>
</html>
