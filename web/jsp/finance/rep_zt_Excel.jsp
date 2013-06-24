<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<html><LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<head>
	<title>各项目总体情况清</title>
</head>
<%

String Date1=request.getParameter("Date1");
String Date2=request.getParameter("Date2");
String SecNo=request.getParameter("SecNo");
String Loft=request.getParameter("Loft");

String roomno=request.getParameter("room");
String SecNo1="";
if (!SecNo.equals("")){
  SecNo1=SecNo.substring(0,SecNo.indexOf("-"));
SecNo=SecNo.substring(SecNo.indexOf("-")+1);
}
/*
StringTokenizer st22 = new StringTokenizer(Date1,"-") ;
StringTokenizer st23 = new StringTokenizer(Date2,"-") ;
int count2 = st22.countTokens() ;
int count3 = st23.countTokens() ;

 
 String same = "";
try{
 while (st22.hasMoreElements()) {
    
	
	 if (same.equals("")){Date1=(String)st22.nextElement();   same = Date1;}
	 else {Date1+="/"+(String)st22.nextElement();} 
 
}
 }catch(Exception s){}
 same="";
 while (st23.hasMoreElements()) {
       
	 if (same.equals("")){Date2=(String)st23.nextElement(); same = Date2;}
	 else {Date2+="/"+(String)st23.nextElement();}
}
 */
 %>
<body>
 <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >

<p align="center">各项目总体情况清</p>
 
<table   width="100%" align="center" ><tr ><td>&nbsp;</td><td align="right"><%=Date1+"--"+Date2 %></td></tr></table>
<table width="100%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

<table width="150%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr align="center">
    <td width="9%" rowspan="2">项目名称</td>
    <td width="27%" colspan="3">应收款项</td>
    <td width="27%" colspan="3">已收款项</td>
    <td width="27%" colspan="3">尚欠款项</td>
    <td width="10%" rowspan="2">备注</td>
  </tr>
  <tr align="center">
    <td width="9%">房款</td>
    <td width="9%">代收款</td>
    <td width="9%">合计</td>
     <td width="9%">房款</td>
    <td width="9%">代收款</td>
    <td width="9%">合计</td>
    <td width="9%">房款</td>
    <td width="9%">代收款</td>
    <td width="9%">合计</td>
  </tr>
  <%
    String groupstr="";
	String wherestr="";
    if (!SecNo.equals(""))SecNo=" and o.section='"+SecNo1+"'";
	if (!Loft.equals(""))SecNo+=" and o.Loft='"+Loft+"'";
	if (!roomno.equals(""))SecNo+=" and o.room_No='"+roomno+"'";
	if (!SecNo.equals("")&&!Loft.equals(""))
	{ groupstr="o.sectionname+o.loft";
	  wherestr=" sectionname+loft";
	}else{   groupstr="o.sectionname";
	  wherestr=" sectionname";
	
	}
  String sql="select "+groupstr+" room,sum(o.rmbprice+o.lu_tai_area*o.lu_tai_area_price) fk,sum(ajmoney) ajmoney from order_contract o ,customer c where  o.customer=c.serialno and  o.date >='"+Date1+"' and o.state<>3 and  o.date <='"+Date2+"' "+SecNo+" group by "+groupstr;
  ResultSet rs=null;
   ResultSet rs1=null;

  rs=ViewBean.executeQuery(sql); 
 double y_price=0;
 double s_price=0;
 double y_price1=0;
 double s_price1=0;
 double fk=0;
 double dsk=0;
  double ffk=0;
 double fdsk=0;
  int ajmoney=0;
  while (rs.next()){
    String name=rs.getString("room"); 
 
	fk+=rs.getDouble("fk"); 
	ajmoney=rs.getInt("ajmoney");
   %>
  <tr>
    <td width="3%"><%=name%></td>
 
	<%
	sql="select  sum(shouldMoney*rate) price  from GatheringRecord where ContactNo in (select code   from order_contract where state<>3 and      convert(char(10),date,120) >='"+Date1+"' and   convert(char(10),date,120) <='"+Date2+"' and "+wherestr+"='"+name+"')";

	rs1=ViewBean1.executeQuery(sql);
	double f_price=ajmoney; 
	double t_price=0; 
	double f_sumprice=0;//应收
	double f_sum=0;//应收合计(房款+代收)
	
	double f_sumprice1=0;//实收房款
	
	double t_sumprice=0;//应收
	double t_sum1=0;//实收合计(房款+代收)
	
	double t_sumprice1=0;//实收代收
	
    double sumprice=0;
	double price=0;
	if (rs1.next())f_price+=rs1.getDouble("price");
	f_sumprice=f_price;
	
	 %>
    <td width="9%"><%=FormatD.getFloat2(f_price,2) %></td>
	<%
	rs1.close();
	sql="select  sum(TaxMoney) price  from GatheringTaxRecord where  cancel=0  and  ContactNo in (select code from   order_contract where state<>3 and      convert(char(10),date,120) >='"+Date1+"' and   convert(char(10),date,120) <='"+Date2+"' and "+wherestr+"='"+name+"')";
	rs1=ViewBean1.executeQuery(sql);
	 price=0;
	if (rs1.next())t_price=rs1.getDouble("price");
	t_sumprice=t_price;
	 %>
    <td width="9%"><%=FormatD.getFloat2(t_price,2) %></td>
    <td width="9%"><%=FormatD.getFloat2(t_price+f_price,2) %></td>
	<%
	rs1.close();
	
	sumprice=0;
	sql="select  sum(factmoney*CurrRate) price  from FactGatheringRecord where ContractNo in (select code from   order_contract where state<>3 and      convert(char(10),date,120) >='"+Date1+"' and   convert(char(10),date,120) <='"+Date2+"' and "+wherestr+"='"+name+"')";
	rs1=ViewBean1.executeQuery(sql);
	 price=0;
	if (rs1.next())f_sumprice1=rs1.getDouble("price");
	
	rs1.close();
	//放款
	sql="select  sum(FactMonye) price  from FactAjCharges where contractno in (select code from   order_contract where state<>3 and      convert(char(10),date,120) >='"+Date1+"' and   convert(char(10),date,120) <='"+Date2+"' and "+wherestr+"='"+name+"')";
	rs1=ViewBean1.executeQuery(sql);
	  
	if (rs1.next())f_sumprice1+=rs1.getDouble("price");
	 %>
    <td width="9%"><%=FormatD.getFloat2(f_sumprice1,2) %></td>
	<%
	rs1.close();
	 
	sql="select  sum(money) price  from FactGatheringTaxRecord where ContractNo in (select code from   order_contract where state<>3 and      convert(char(10),date,120) >='"+Date1+"' and   convert(char(10),date,120) <='"+Date2+"' and "+wherestr+"='"+name+"')";
	rs1=ViewBean1.executeQuery(sql);
	 price=0;
	if (rs1.next())t_sumprice1=rs1.getDouble("price");
	fdsk+=price;
	sumprice+=price;
	s_price1+=price;
	t_sum1=t_sumprice1+f_sumprice1;
	 %>
    <td width="9%"><%=FormatD.getFloat2(t_sumprice1,2) %></td>
    <td width="9%"><%=FormatD.getFloat2(t_sumprice1+f_sumprice1,2) %></td>
    <td width="9%"><%=FormatD.getFloat2(f_sumprice-f_sumprice1,2) %></td>
    <td width="9%"><%=FormatD.getFloat2(t_sumprice-t_sumprice1,2) %></td>
        <td width="9%"><%=FormatD.getFloat2((f_sumprice-f_sumprice1)+(t_sumprice-t_sumprice1),2) %></td>
    <td width="10%">　</td>
  </tr>
  
 <%} %>
 <%
 sql="select  sum(shouldMoney*rate) price  from GatheringRecord where ContactNo in (select code   from order_contract where state<>3 and      convert(char(10),date,120) >='"+Date1+"' and   convert(char(10),date,120) <='"+Date2+"' ";
  if (!SecNo.equals(""))sql+=" and section='"+SecNo1+"'";
  if (!Loft.equals(""))sql+=" and Loft='"+Loft+"'";
  if (!roomno.equals(""))sql+=" and  room_no='"+roomno+"'";
  sql+=")";
	 
	rs1=ViewBean1.executeQuery(sql);
	double a1=0,a2=0,a3=0,a4=0;
   if (rs1.next())a1=rs1.getDouble("price");
   rs1.close();
    sql="select  sum(ajmoney) ajmoney   from order_contract where state<>3 and      convert(char(10),date,120) >='"+Date1+"' and   convert(char(10),date,120) <='"+Date2+"' ";
  if (!SecNo.equals(""))sql+=" and section='"+SecNo1+"'";
  if (!Loft.equals(""))sql+=" and  Loft='"+Loft+"'";
  if (!roomno.equals(""))sql+=" and  room_no='"+roomno+"'";
 rs1=ViewBean1.executeQuery(sql);
     if (rs1.next())a1+=rs1.getDouble("ajmoney");
	 
	 
   sql="select  sum(TaxMoney) price  from GatheringTaxRecord where  cancel=0  and  ContactNo in (select code from   order_contract where state<>3 and      convert(char(10),date,120) >='"+Date1+"' and   convert(char(10),date,120) <='"+Date2+"' ";
   if (!SecNo.equals(""))sql+=" and section='"+SecNo1+"'";
   if (!Loft.equals(""))sql+=" and  Loft='"+Loft+"'";
   if (!roomno.equals(""))sql+=" and  room_no='"+roomno+"'";
   sql+=")";
	rs1=ViewBean1.executeQuery(sql);
	 
	if (rs1.next())a2=rs1.getDouble("price");
	rs1.close();
	//实收
	sql="select  sum(factmoney*CurrRate) price  from FactGatheringRecord where ContractNo in (select code from   order_contract where state<>3 and      convert(char(10),date,120) >='"+Date1+"' and   convert(char(10),date,120) <='"+Date2+"' ";
	 if (!SecNo.equals(""))sql+=" and section='"+SecNo1+"'";
   if (!Loft.equals(""))sql+=" and  Loft='"+Loft+"'";
       if (!roomno.equals(""))sql+=" and  room_no='"+roomno+"'";
   sql+=")";

	rs1=ViewBean1.executeQuery(sql);
 
	if (rs1.next())a3=rs1.getDouble("price");
	rs1.close();
	//放款
	sql="select  sum(FactMonye) price  from FactAjCharges where contractno in (select code from   order_contract where state<>3 and      convert(char(10),date,120) >='"+Date1+"' and   convert(char(10),date,120) <='"+Date2+"' ";
	 if (!SecNo.equals(""))sql+=" and section='"+SecNo1+"'";
   if (!Loft.equals(""))sql+=" and  Loft='"+Loft+"'";
       if (!roomno.equals(""))sql+=" and  room_no='"+roomno+"'";
   sql+=")";
   
	rs1=ViewBean1.executeQuery(sql);
	  
	if (rs1.next())a3+=rs1.getDouble("price");
	rs1.close();
	 
	sql="select  sum(money) price  from FactGatheringTaxRecord where  ContractNo in (select code from   order_contract where state<>3 and      convert(char(10),date,120) >='"+Date1+"' and   convert(char(10),date,120) <='"+Date2+"' ";
	 if (!SecNo.equals(""))sql+=" and section='"+SecNo1+"'";
   if (!Loft.equals(""))sql+=" and  Loft='"+Loft+"'";
      if (!roomno.equals(""))sql+=" and  room_no='"+roomno+"'";
   sql+=")";
	rs1=ViewBean1.executeQuery(sql);
 
	if (rs1.next())a4=rs1.getDouble("price");
  %>
  <tr>
    <td width="9%">合计</td>
 
    <td width="9%"><%=FormatD.getFloat2(a1,2) %></td>
    <td width="9%"><%=FormatD.getFloat2(a2,2) %></td>
    <td width="9%"><%=FormatD.getFloat2(a1+a2,2) %></td>
	
    <td width="9%"><%=FormatD.getFloat2(a3,2) %></td>
      <td width="9%"><%=FormatD.getFloat2(a4,2) %></td>
     <td width="9%"><%=FormatD.getFloat2(a3+a4,2) %></td>
     <td width="9%"><%=FormatD.getFloat2(a1-a3,2) %></td>
   <td width="9%"><%=FormatD.getFloat2(a2-a4,2) %></td>
     <td width="9%"><%=FormatD.getFloat2((a1-a3)+(a2-a4),2) %></td>
    <td width="10%">　</td>
  </tr>
  
</table>

</div>

<script>
  function bringToExcel(){

   // get all the text
   var pasteText = document.all.report1.innerHTML;

   // copy all the text to clipboard
   window.clipboardData.setData ("Text", pasteText);

     // Start Excel and get Application object.     
     var oXL = new ActiveXObject("Excel.Application");     
     oXL.Visible = true;   
     // Get a new workbook.     
     var oWB = oXL.Workbooks.Add();     
     var oSheet = oWB.ActiveSheet;     
     oSheet.Paste();     
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
  bringToExcel();
  window.close();
  </script>
</body>
</html>
