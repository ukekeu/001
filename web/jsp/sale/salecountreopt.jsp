<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<title>���ۼ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel=stylesheet href="../class/news.css" >
</head>
  <%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="FormatD" scope="session" class="FormatData.FormatData"/>
  <%
    double sumnum=0;
	double sumarea=0;
    double    orderNum=0;
	double countsumprice=0;
	double ssumnum1=0;
	double ssumarea1=0;
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
	String SecNo=China.getParameter(request,"SecNo");
	String Loft=China.getParameter(request,"Loft");
	String WhereSQL="";
	if(!SecNo.equals(""))
	  WhereSQL +=" and section='"+SecNo+"'";
	if(!Loft.equals(""))
	  WhereSQL +=" and Loft='"+Loft+"'";
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
	//���ҽ��
	countSQL="select sum(FactMonye) as FactMonye from FactAjCharges ";

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

	 countSQL="select count(*) num,sum(area) area from room where salestate <> 4";
  	 aRS = aBean.executeQuery(countSQL);
	if (aRS.next()){
	   sumnum=aRS.getDouble("num");
	   sumarea=aRS.getDouble("area");
	}
	aRS.close();
	
	 countSQL="select count(*) num,sum(ajmoney) as ajmoneys from order_contract where state<>3 and year(ajdate)>1900 ";
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
	
	
	 countSQL="select sum(salerprice*rate) as sumprice from order_contract where state<>3";
  	 aRS = aBean.executeQuery(countSQL);
	
	if (aRS.next()){
	   sumsaleprice=aRS.getDouble("sumprice");
	}
	aRS.close();
}catch(Exception s)	{out.print(countSQL);out.close();}
	 
	
   %>
<body  ondblclick="printd();">
<p align="center"><font size=5><b>�� �� �� ��</b></font></p>

<p align="center" ><font size=3><b><%=dates.substring(0,dates.indexOf("-"))+"��"+dates.substring(dates.indexOf("-")+1,dates.lastIndexOf("-"))+"��"+dates.substring(dates.lastIndexOf("-")+1,dates.length())+"��"+"��"+dates1.substring(0,dates1.indexOf("-"))+"��"+dates1.substring(dates1.indexOf("-")+1,dates.lastIndexOf("-"))+"��"+dates1.substring(dates1.lastIndexOf("-")+1,dates1.length())+"��"%></font></b></p>
<p align="left" ><font face="����"><b>��������</b></font></p>
<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center">
     <td width="5%"  rowspan="2" ><font face="����"><b>���</b></font></td> 
	 <td width="11%"  rowspan="2" ><font face="����"><b>¥������</b></font></td> 
	 <td width="11%"  rowspan="2" ><font face="����"><b>����</b></font></td> 
	 <td width="8%"  rowspan="2" ><font face="����"><b>��������</b></font></td>   
     <td width="25%"  colspan="2"><p align="center"><font face="����"><b>�����������</b></font></td>  
	 <td width="11%"  rowspan="2" ><font face="����"><b>���������ܼ�</b></font></td>
	 <td width="11%"  rowspan="2" ><font face="����"><b>�������۾���</b></font></td> 
   </tr>  
  <tr align="center"> 
    <td width="13%"><font face="����"><b>����</b></font></td>
    <td width="12%"><font face="����"><b>����</b></font></td>
    
  </tr>
  
  <% countSQL="select section,sectionname,loft,count(*) num,sum(salerprice*rate) as sumprice,sum(salerprice*rate)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state<>3 "+WhereSQL+" group by section,sectionname,loft";
     String sectionname1="";
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
	   sectionname1=getbyte(aRS.getString("sectionname"));
	   loft1=getbyte(aRS.getString("loft"));
	   countSQL="select section,sectionname,count(*) num,sum(salerprice*rate) as sumprice,sum(salerprice*rate)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state<>3  "+WhereSQL1+" and sectionname='"+sectionname1+"' and loft='"+loft1+"'  group by section,sectionname,loft";
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
    <td>&nbsp;<%=loft1 %></td>	
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%>��</td>
    
    <td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas,4) %>m<sup>2</sup></td>
    <td>&nbsp;<%=FormatD.getFloat2(acountsumareas,4) %>m<sup>2</sup></td>
	<td>&nbsp;��<%=FormatD.getFloat2(acountsumprices,2) %></td>
    <td>&nbsp;��<%=FormatD.getFloat2(acountavgprices,2) %></td>
    </tr>
	   <%
	}
	aRS.close();
	 %>
	 <% countSQL="select count(*) num,sum(salerprice*rate) as sumprice,sum(salerprice*rate)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state<>3 "+WhereSQL1;
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
	 <td>&nbsp;<font face="����"><b>�ϼ�</b></font></td>
	<td>&nbsp;</td>
    <td>&nbsp;</td>	
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%>��</td>
    
    <td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas,4) %>m<sup>2</sup></td>
    <td>&nbsp;<%=FormatD.getFloat2(acountsumareas,4) %>m<sup>2</sup></td>
	<td>&nbsp;��<%=FormatD.getFloat2(acountsumprices,2) %></td>
    <td>&nbsp;��<%=FormatD.getFloat2(acountavgprices,2) %></td>
  </tr> 
  </table>
  <p align="left" ><font face="����"><b>�ۼ�����</b></font></p>
  <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center">
     <td width="5%"  rowspan="2" ><font face="����"><b>���</b></font></td> 
	 <td width="11%"  rowspan="2" ><font face="����"><b>¥������</b></font></td> 
	 <td width="11%"  rowspan="2" ><font face="����"><b>����</b></font></td> 
	 <td width="8%"  rowspan="2" ><font face="����"><b>�ۼ�����</b></font></td>   
     <td width="25%"  colspan="2"><p align="center"><font face="����"><b>�ۼ��������</b></font></td>  
	 <td width="11%"  rowspan="2" ><font face="����"><b>�ۼ������ܼ�</b></font></td>
	 <td width="11%"  rowspan="2" ><font face="����"><b>�ۼ����۾���</b></font></td> 
   </tr>  
  <tr align="center"> 
    <td width="13%"><font face="����"><b>����</b></font></td>
    <td width="12%"><font face="����"><b>����</b></font></td>
    
  </tr>
  
  <% countSQL="select section,sectionname,loft,count(*) num,sum(salerprice*rate) as sumprice,sum(salerprice*rate)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state<>3 "+WhereSQL+" group by section,sectionname,loft";
      i=0;
      aRS = aBean.executeQuery(countSQL);
	 while (aRS.next()){
	   i=i+1;
	   sectionname1=getbyte(aRS.getString("sectionname"));
	   loft1=getbyte(aRS.getString("loft"));
	   aorderNums=aRS.getDouble("num");
	   acountsumprices=aRS.getDouble("sumprice");
	   acountavgprices=aRS.getDouble("avgprice");
	   acountsumjzareas=aRS.getDouble("sumjzarea");  
	   acountsumareas=aRS.getDouble("sumarea");  
	   %>
	   <tr align="center">
	    <td>&nbsp;<%=i %></td>
	<td>&nbsp;<%=sectionname1 %></td>
    <td>&nbsp;<%=loft1 %></td>	
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%>��</td>
    
    <td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas,4) %>m<sup>2</sup></td>
    <td>&nbsp;<%=FormatD.getFloat2(acountsumareas,4) %>m<sup>2</sup></td>
	<td>&nbsp;��<%=FormatD.getFloat2(acountsumprices,2) %></td>
    <td>&nbsp;��<%=FormatD.getFloat2(acountavgprices,2) %></td>
    </tr>
	   <%
	}
	aRS.close();
	 %>
	 <% countSQL="select count(*) num,sum(salerprice*rate) as sumprice,sum(salerprice*rate)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state<>3 "+WhereSQL;
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
	 <td>&nbsp;<font face="����"><b>�ϼ�</b></font></td>
	<td>&nbsp;</td>
    <td>&nbsp;</td>	
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%>��</td>
    
    <td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas,4) %>m<sup>2</sup></td>
    <td>&nbsp;<%=FormatD.getFloat2(acountsumareas,4) %>m<sup>2</sup></td>
	<td>&nbsp;��<%=FormatD.getFloat2(acountsumprices,2) %></td>
    <td>&nbsp;��<%=FormatD.getFloat2(acountavgprices,2) %></td>
  </tr> 
</table>
<p align="left" ><font face="����"><b>�ۼ�������</b></font></p>
  <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center">
     <td width="6%"   ><font face="����"><b>���</b></font></td> 
	 <td width="9%"  ><font face="����"><b>¥������</b></font></td> 
	 <td width="9%"  ><font face="����"><b>����</b></font></td> 
	 <td width="10%"   ><font face="����"><b>�ۼ�����</b></font></td>   
    <td width="9%"   ><font face="����"><b>����������</b></font></td> 
     <td width="9%"  ><font face="����"><b>����������</b></font></td>  
	 <td width="10%"  ><font face="����"><b>���������</b></font></td>
	 <td width="10%"  ><font face="����"><b>���������</b></font></td>
	 <td width="13%" colspan="2" ><font face="����"><b>�������������</b></font></td> 
   </tr>  
  
  
  <% double sumnum1=0;
     double sumarea1=0;
     countSQL="select section,sectionname,loft,count(*) num,sum(salerprice*rate) as sumprice,sum(salerprice*rate)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state<>3 "+WhereSQL+" group by section,sectionname,loft";
      i=0;
      aRS = aBean.executeQuery(countSQL);
	  String section="";
	 while (aRS.next()){
	   i=i+1;
	   section=aRS.getString("section");
	   sectionname1=getbyte(aRS.getString("sectionname"));
	   loft1=getbyte(aRS.getString("loft"));
	    countSQL="select count(*) num,sum(area) area from room where seccode='"+section+"' and loft='"+loft1+"' and salestate <> 4";
  	   ResultSet bRS = bBean.executeQuery(countSQL);
	    if (bRS.next()){
	       sumnum1=bRS.getDouble("num");
		  ssumnum1=ssumnum1+sumnum1;
	      sumarea1=bRS.getDouble("area");
		  ssumarea1=ssumarea1+sumarea1;
	    }
	    bRS.close();
	   aorderNums=aRS.getDouble("num");
	   acountsumprices=aRS.getDouble("sumprice");
	   acountavgprices=aRS.getDouble("avgprice");
	   acountsumjzareas=aRS.getDouble("sumjzarea");  
	   acountsumareas=aRS.getDouble("sumarea");  
	   %>
	   <tr align="center">
	    <td>&nbsp;<%=i %></td>
	<td>&nbsp;<%=sectionname1 %></td>
    <td>&nbsp;<%=loft1 %></td>	
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%>��</td>
     <td>&nbsp;<%=FormatD.getFloat2(sumnum1 ,0)%>��</td>	
	<td>&nbsp;<%=FormatD.getFloat2(aorderNums/sumnum1*100,2)%>%</td>
    <td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas,4) %>m<sup>2</sup></td>
	 <td>&nbsp;<%=FormatD.getFloat2(sumarea1,4) %>m<sup>2</sup></td>	
    <td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas/sumarea1*100 ,2)%>%</td>

    </tr>
	   <%
	}
	aRS.close();
	 %>
	 <% countSQL="select count(*) num,sum(salerprice*rate) as sumprice,sum(salerprice*rate)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state<>3  ajmoney>=0 "+WhereSQL;
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
	 <td>&nbsp;<font face="����"><b>�ϼ�</b></font></td>
	<td>&nbsp;</td>
    <td>&nbsp;</td>	
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%>��</td>
	 <td>&nbsp;<%=FormatD.getFloat2(ssumnum1 ,0)%>��</td>	
   <td>&nbsp;<%=FormatD.getFloat2(aorderNums/ssumnum1*100,2)%>%</td>
    <td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas,4) %>m<sup>2</sup></td>
	 <td>&nbsp;<%=FormatD.getFloat2(ssumarea1,4) %>m<sup>2</sup></td>	
    <td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas/ssumarea1*100 ,2)%>%</td>

  </tr> 
</table>
<p align="left" ><font face="����"><b>ǩ&nbsp;Լ</b></font></p>
  <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center">
     <td width="6%"   ><font face="����"><b>���</b></font></td> 
	 <td width="11%"  ><font face="����"><b>¥������</b></font></td> 
	 <td width="11%"  ><font face="����"><b>����</b></font></td> 
	 <td width="8%"   ><font face="����"><b>����ǩԼ</b></font></td>   
     <td width="11%"  ><font face="����"><b>����ǩԼ���</b></font></td>  
	 <td width="11%"><font face="����"><b>����ǩԼ���</b></font></td> 
	 <td width="8%"   ><font face="����"><b>�ۼ�ǩԼ</b></font></td>   
     <td width="11%"  ><font face="����"><b>�ۼ�ǩԼ���</b></font></td>  
	 <td width="11%"><font face="����"><b>�ۼ�ǩԼ���</b></font></td> 
   </tr>  
  
  
  <% countSQL="select section,sectionname,loft,count(*) num,sum(salerprice*rate) as sumprice,sum(salerprice*rate)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state=2 "+WhereSQL+" group by section,sectionname,loft";

      i=0;
      aRS = aBean.executeQuery(countSQL);
	 while (aRS.next()){
	   i=i+1;
	   sectionname1=getbyte(aRS.getString("sectionname"));
	   loft1=getbyte(aRS.getString("loft"));
	   aorderNums1=aRS.getDouble("num");
	   acountsumprices1=aRS.getDouble("sumprice");
	   acountavgprices1=aRS.getDouble("avgprice");
	   acountsumjzareas1=aRS.getDouble("sumjzarea");  
	   acountsumareas1=aRS.getDouble("sumarea");  
	   %>
	   <tr align="center">
	    <td>&nbsp;<%=i %></td>
	<td>&nbsp;<%=sectionname1 %></td>
    <td>&nbsp;<%=loft1 %></td>	
    

  <% countSQL="select section,sectionname,loft,count(*) num,sum(salerprice*rate) as sumprice,sum(salerprice*rate)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state=2  and substring(convert(char(24),visadate,120),1,10) >='"+dates+"' and substring(convert(char(24),visadate,120),1,10) <='"+dates1+"' and sectionname='"+sectionname1+"' and loft='"+loft1+"'   group by section,sectionname,loft";

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
	   <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%>��</td>
    
	<td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas,4)%>m<sup>2</sup></td>
    <td>&nbsp;��<%=FormatD.getFloat2(acountsumprices,2) %></td>   
	
	 <td>&nbsp;<%=FormatD.getFloat2(aorderNums1 ,0)%>��</td>
    
	<td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas1,4)%>m<sup>2</sup></td>
    <td>&nbsp;��<%=FormatD.getFloat2(acountsumprices1,2) %></td>  
    </tr>
	   <%
	}
	aRS.close();
	 %>
	 <% countSQL="select count(*) num,sum(salerprice*rate) as sumprice,sum(salerprice*rate)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where state=2   and substring(convert(char(24),visadate,120),1,10) >='"+dates+"' and substring(convert(char(24),visadate,120),1,10) <='"+dates1+"'"+WhereSQL;
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
	 <td>&nbsp;<font face="����"><b>�ϼ�</b></font></td>
	<td>&nbsp;</td>
    <td>&nbsp;</td>	
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%>��</td>
   <td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas,4)%>m<sup>2</sup></td>
    <td>&nbsp;��<%=FormatD.getFloat2(acountsumprices,2) %></td>
	 <% countSQL="select count(*) num,sum(salerprice*rate) as sumprice,sum(salerprice*rate)/sum(jzarea) as avgprice,sum(jzarea) as sumjzarea,sum(area) as sumarea from order_contract where  state=2  "+WhereSQL;
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
	
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%>��</td>
   <td>&nbsp;<%=FormatD.getFloat2(acountsumjzareas,4)%>m<sup>2</sup></td>
    <td>&nbsp;��<%=FormatD.getFloat2(acountsumprices,2) %></td>
	
   
  </tr> 
</table>
<p align="left" ><font face="����"><b>��&nbsp;��</b></font></p>
  <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center">
     <td width="6%"   ><font face="����"><b>���</b></font></td> 
	 <td width="11%"  ><font face="����"><b>¥������</b></font></td> 
	 <td width="10%"  ><font face="����"><b>����</b></font></td> 
	 <td width="8%"   ><font face="����"><b>���ڰ���</b></font></td>   
     <td width="8%"  ><font face="����"><b>���ڰ��Ҷ�</b></font></td>  
	 <td width="11%"  ><font face="����"><b>�������зſ�</b></font></td> 
	 <td width="13%"   ><font face="����"><b>�ۼư�������</b></font></td>   
     <td width="11%"  ><font face="����"><b>�ۼư��Ҷ�</b></font></td>  
	 <td width="13%" ><font face="����"><b>�ۼ����зſ�</b></font></td> 
   </tr>  
  
  
  <%  double aorderNums2=0;
      double ajmoney2=0;
	  double sumajmoney2=0;
      countSQL="select section,sectionname,loft,count(*) num,sum(ajmoney) as ajmoney1 from order_contract  where state<>3 and  year(ajdate)>1900   "+WhereSQL+" group by section,sectionname,loft";
      int code=0;
      i=0;
      aRS = aBean.executeQuery(countSQL);
	 
	 while (aRS.next()){
	   i=i+1;
	   sectionname1=getbyte(aRS.getString("sectionname"));
	   loft1=getbyte(aRS.getString("loft"));
	   aorderNums2=aRS.getDouble("num");
	   ajmoney2=aRS.getDouble("ajmoney1");
	   %>
	    <tr align="center">
	    <td>&nbsp;<%=i %></td>
	<td>&nbsp;<%=sectionname1 %></td>
    <td>&nbsp;<%=loft1 %></td>	
	   <%
	   String countSQL2="select section,sectionname,loft,count(*) num,sum(ajmoney) as ajmoney1 from order_contract  where  state=2 and year(ajdate)>1900   and sectionname='"+sectionname1+"' and loft='"+loft1+"'  and substring(convert(char(24),ajdate,120),1,10) >='"+dates+"' and substring(convert(char(24),ajdate,120),1,10) <='"+dates1+"' group by section,sectionname,loft";
	   ajmoney=0;
	   ResultSet bRS = bBean.executeQuery(countSQL2);
	   aorderNums=0;
	   if (bRS.next()){
	   	   aorderNums=bRS.getDouble("num");
	       ajmoney=bRS.getDouble("ajmoney1");
		}
	   String SQL="select sum(FactMonye) as FactMonye from FactAjCharges where   factdate>='"+dates+"' and  factdate<='"+dates1+"' and contractno in (select code from order_contract  where state<>3 and  sectionname='"+sectionname1+"' and loft='"+loft1+"')";
	 
        bRS = bBean.executeQuery(SQL);
	   if (bRS.next()){
	   sumajmoney=bRS.getDouble("FactMonye");
    	}bRS.close();	  
		 SQL="select sum(FactMonye) as FactMonye from FactAjCharges where  contractno in (select code from order_contract  where state<>3 and sectionname='"+sectionname1+"' and loft='"+loft1+"')";
	 
        bRS = bBean.executeQuery(SQL);
	   if (bRS.next()){
	   sumajmoney2=bRS.getDouble("FactMonye");
    	}bRS.close();	 
	   %>
	
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%>��</td>
    
	<td>&nbsp;��<%=FormatD.getFloat2(ajmoney,2)%></td>
	<td>&nbsp;��<%=FormatD.getFloat2(sumajmoney,2)%></td>
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums2 ,0)%>��</td>    
	<td>&nbsp;��<%=FormatD.getFloat2(ajmoney2,2)%></td>
	<td>&nbsp;��<%=FormatD.getFloat2(sumajmoney2,2)%></td>

    </tr>
	   <%
	}
	aRS.close();
	 %>
	 <% double ajmoneys2=0;
	    
	  countSQL="select count(*) num,sum(ajmoney) as ajmoneys1 from order_contract where state=2 and  year(ajdate)>1900    and substring(convert(char(24),ajdate,120),1,10) >='"+dates+"' and substring(convert(char(24),ajdate,120),1,10) <='"+dates1+"'"+WhereSQL;
      aRS = aBean.executeQuery(countSQL);
	  
	  if (aRS.next()){
	   aorderNums=aRS.getDouble("num");
	   ajmoneys1=aRS.getDouble("ajmoneys1");  
	   
	}
	aRS.close();
	countSQL="select count(*) num,sum(ajmoney) as ajmoneys1 from order_contract where state<>3 and  year(ajdate)>1900    "+WhereSQL;
      aRS = aBean.executeQuery(countSQL);
	  
	  if (aRS.next()){
	   aorderNums2=aRS.getDouble("num");
	   ajmoneys2=aRS.getDouble("ajmoneys1");  
	   
	}
	aRS.close();
	 String SQL="select sum(FactMonye) as FactMonye from FactAjCharges where contractno in (select code from order_contract  where  state<>3 and year(ajdate)>1900  and factdate>='"+dates+"' and  factdate<='"+dates1+"'"+ WhereSQL +")";
	 
	 ResultSet bRS = bBean.executeQuery(SQL);
	   if (bRS.next()){
	   sumajmoney=bRS.getDouble("FactMonye");
    	}bRS.close();	
	 SQL="select sum(FactMonye) as FactMonye from FactAjCharges where contractno in (select code from order_contract  where state<>3 and  year(ajdate)>1900  "+ WhereSQL +")";
	 
	  bRS = bBean.executeQuery(SQL);
	   if (bRS.next()){
	   sumajmoney2=bRS.getDouble("FactMonye");
    	}bRS.close();	  
	 %>
	 <tr align="center">
	 <td>&nbsp;<font face="����"><b>�ϼ�</b></font></td>
	<td>&nbsp;</td>
    <td>&nbsp;</td>	
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums ,0)%>��</td>
   <td>&nbsp;��<%=FormatD.getFloat2(ajmoneys1,2)%></td>
    <td>&nbsp;��<%=FormatD.getFloat2(sumajmoney,2)%></td>
    <td>&nbsp;<%=FormatD.getFloat2(aorderNums2 ,0)%>��</td>
   <td>&nbsp;��<%=FormatD.getFloat2(ajmoneys2,2)%></td>
   <td>&nbsp;��<%=FormatD.getFloat2(sumajmoney2,2)%></td>
  
	
   
  </tr> 
</table>
<p align="left" ><font face="����"><b>��&nbsp;��</b></font></p>
  <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center">
     <td width="5%"   ><font face="����"><b>���</b></font></td> 
	 <td width="11%"  ><font face="����"><b>¥������</b></font></td> 
	 <td width="11%"  ><font face="����"><b>����</b></font></td> 
	 <td width="6%"   ><font face="����"><b>�����տ�</b></font></td>   
     <td width="11%"  ><font face="����"><b>�ۼƵ��ʿ�</b></font></td> 
	 <td width="11%"  ><font face="����"><b>�ۼƳɽ��ܼ�</b></font></td> 	
	 <td width="11%" colspan="3" ><font face="����"><b>�ؿ���</b></font></td> 
   </tr>  
  
   <% countSQL="select section,sectionname,loft,count(*) num,sum(salerprice*rate) as sumprice  from order_contract where state<>3  "+WhereSQL+" group by section,sectionname,loft";
     //out.print(countSQL);
      i=0;
      aRS = aBean.executeQuery(countSQL);
	  double money1=0;//�����տ�
	  double money2=0;//���ڷſ�
	  double money3=0;//�ۼ��տ�
	  double money4=0;//�ۼƷſ�
	  double money5=0;//�ۼƳɽ�
      String sectionno="";
	 while (aRS.next()){
	   i=i+1;
	   sectionno=aRS.getString("section");
	  sectionname1=getbyte(aRS.getString("sectionname"));
	    loft1=getbyte(aRS.getString("loft"));
	   aorderNums=aRS.getDouble("num");
	     countSQL="select sum(salerprice*rate) as factmoney from order_contract where  state<>3 and section ='"+sectionno+"' and loft='"+loft1+"'";

	   bRS = bBean.executeQuery(countSQL);
	    if (bRS.next()){
	      money5=bRS.getDouble("factmoney");
	    }
	    bRS.close();	
	   
	   countSQL="select sum(factmoney*currrate) as factmoney from FactGatheringRecord where  Gather_Date >='"+dates+"' and  Gather_Date<='"+dates1+"' and  contractno in (select code from  order_contract where state<>3 and "+"date>='"+dates+"' and  date<='"+dates1+"' and section ='"+sectionno+"' and loft='"+loft1+"')";
  	   bRS = bBean.executeQuery(countSQL);
	    if (bRS.next()){
	      money1=bRS.getDouble("factmoney");
	    }
	    bRS.close();	
		 countSQL="select sum(factmoney*currrate) as factmoney from FactGatheringRecord where    contractno in (select code from  order_contract where state<>3 and  section ='"+sectionno+"' and loft='"+loft1+"')";

	   bRS = bBean.executeQuery(countSQL);
	    if (bRS.next()){
	      money3=bRS.getDouble("factmoney");
	    }
	    bRS.close();	
		
		 countSQL="select sum(FactMonye) as FactMonye from FactAjCharges where FactDate >='"+dates+"' and  FactDate<='"+dates1+"' and  contractno in (select code from  order_contract where state<>3 and "+"date>='"+dates+"' and  date<='"+dates1+"' and section ='"+sectionno+"' and loft='"+loft1+"')";
  	 
	   bRS = bBean.executeQuery(countSQL);
	    if (bRS.next()){
	      money2=bRS.getDouble("FactMonye");
	    }
	    bRS.close();  
		
		 countSQL="select sum(FactMonye) as FactMonye from FactAjCharges where  contractno in (select code from  order_contract where section ='"+sectionno+"' and loft='"+loft1+"')";
  	   bRS = bBean.executeQuery(countSQL);
	    if (bRS.next()){
	      money4=bRS.getDouble("FactMonye");
	    }
	    bRS.close();
	  
	   %>
	   <tr align="center">
	    <td>&nbsp;<%=i %></td>
	<td>&nbsp;<%=sectionname1 %></td>
    <td>&nbsp;<%=loft1 %></td>	
    <td>&nbsp;��<%=FormatD.getFloat2(money1,2)%></td>    
	<td>&nbsp;��<%=FormatD.getFloat2(money3+money4,2)%></td>
    <td>&nbsp;��<%=FormatD.getFloat2(money5,2)%></td>
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
	//�ۼƳɽ���
	 countSQL="select sum(salerprice*rate) as sumprice from order_contract";// where "+"date>='"+dates+"' and  date<='"+dates1+"'"+WhereSQL;
    
	  aRS = aBean.executeQuery(countSQL);
	  if (aRS.next()){
	     sumprice=aRS.getDouble("sumprice");
	   
	  
	}
	aRS.close();
	//�����տ�
	if (!SecNo.equals(""))	
	 countSQL="select sum(factmoney*currrate) as factmoney from FactGatheringRecord where  Gather_Date >='"+dates+"' and  Gather_Date<='"+dates1+"' and  contractno in (select code from  order_contract   where state<>3 and section ='"+SecNo+"')";
  	else
	 countSQL="select sum(factmoney*currrate) as factmoney from FactGatheringRecord where  Gather_Date >='"+dates+"' and  Gather_Date<='"+dates1+"' and  contractno in (select code from  order_contract where state<>3)";//   where  section ='"+SecNo+"')";
	bRS = bBean.executeQuery(countSQL);
	  if (bRS.next()){
	      sumajmoney=bRS.getDouble("factmoney");
	    }
	    bRS.close();	
	
	//�ۼ��տ�
	if (!SecNo.equals(""))
	  countSQL="select sum(factmoney*currrate) as factmoney from FactGatheringRecord where contractno in (select code from  order_contract where state<>3 and  section ='"+SecNo+"')";//where  Gather_Date >='"+dates+"' and  Gather_Date<='"+dates1+"' and  contractno in (select code from  order_contract where "+"date>='"+dates+"' and  date<='"+dates1+"'"+WhereSQL+")";
	else
      countSQL="select sum(factmoney*currrate) as factmoney from FactGatheringRecord where contractno in (select code from order_contract where state<>3) ";//where contractno in (select code from  order_contract where section ='"+SecNo+"')";//where  Gather_Date >='"+dates+"' and  Gather_Date<='"+dates1+"' and  contractno in (select code from  order_contract where "+"date>='"+dates+"' and  date<='"+dates1+"'"+WhereSQL+")";
	 bRS = bBean.executeQuery(countSQL);
	  if (bRS.next()){
	      sumajmoney1=bRS.getDouble("factmoney");
	    }
	    bRS.close();		
		//���ڷſ�
	if (!SecNo.equals(""))	
	 countSQL="select sum(FactMonye) as FactMonye from FactAjCharges where FactDate >='"+dates+"' and  FactDate<='"+dates1+"' and  contractno in (select code from  order_contract where state<>3 and section='"+SecNo+"')";// where "+"date>='"+dates+"' and  date<='"+dates1+"'"+WhereSQL+")";
    else
	  countSQL="select sum(FactMonye) as FactMonye from FactAjCharges where FactDate >='"+dates+"' and  FactDate<='"+dates1+"' and  contractno in (select code from  order_contract where state<>3)";// where "+"date>='"+dates+"' and  date<='"+dates1+"'"+WhereSQL+")";
  	 bRS = bBean.executeQuery(countSQL);
	  if (bRS.next()){
	      sumajmoney3=bRS.getDouble("FactMonye");
	    }
	    bRS.close();	
		//�ۼƷſ�
		double sumajmoney5=0;
		if (!SecNo.equals(""))
		 countSQL="select sum(FactMonye) as FactMonye from FactAjCharges  where contractno in (select code from  order_contract where  state<>3 and section ='"+SecNo+"')";//where FactDate >='"+dates+"' and  FactDate<='"+dates1+"' and  contractno in (select code from  order_contract where "+"date>='"+dates+"' and  date<='"+dates1+"'"+WhereSQL+")";
  	   else
	     countSQL="select sum(FactMonye) as FactMonye from FactAjCharges where contractno in (select code from order_contract where state<>3) ";// where contractno in (select code from  order_contract where section ='"+SecNo+"')";//where FactDate >='"+dates+"' and  FactDate<='"+dates1+"' and  contractno in (select code from  order_contract where "+"date>='"+dates+"' and  date<='"+dates1+"'"+WhereSQL+")";
	   bRS = bBean.executeQuery(countSQL);
	 	
	  if (bRS.next()){
	      sumajmoney5=bRS.getDouble("FactMonye");
	    }
	    bRS.close();		
	 %>
	 <tr align="center">
	 <td>&nbsp;<font face="����"><b>�ϼ�</b></font></td>
    <td>&nbsp;<%=sectionname1 %></td>
	<td>&nbsp;</td>
    <td>&nbsp;��<%=FormatD.getFloat2(sumajmoney3+sumajmoney,2)%></td>
  <td>&nbsp;��<%=FormatD.getFloat2(sumajmoney1+sumajmoney5,2)%></td>
    <td>&nbsp;��<%=FormatD.getFloat2(sumprice,2)%></td>
    <td>&nbsp;<%=FormatD.getFloat2((sumajmoney1+sumajmoney5)/sumprice*100 ,2)%>%</td>

  </tr> 
</table>

<p>&nbsp;</p>

  <table width="100%">
 <tr>
 <td width="65%"></td>
 <td width="20%" align="center"><font size=4>�������۲�</font></td>
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
 <td width="20%" align="center"><font size=4><%=CurYear %>��<%=CurMonth %>��<%=CurDay %>��</font></td>
 <td width="15%"></td>
 </tr>
 </table>
<script>
function dda(){
var today=new Date();
var dd1=String(today.getMonth()+1);
dd.innerText=today.getYear()+"��"+dd1+"��"+today.getDay()+"��";
}


function printd(){
if (confirm("��ӡ��"))
  print();

}
</script>

</body>
</html>
