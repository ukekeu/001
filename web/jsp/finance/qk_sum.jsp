<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<html>
<head><LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

	<title>各项目总体情况清</title>
</head>
<%

String Date1=request.getParameter("Date1");
String Date2=request.getParameter("Date2");
String SecNo=getbyte1(request.getParameter("SecNo"));
String SecNo1="";
if (!SecNo.equals("")){
  SecNo1=SecNo.substring(0,SecNo.indexOf("-"));
SecNo=SecNo.substring(SecNo.indexOf("-")+1);
}
String Loft =getbyte1(request.getParameter("Loft"));
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
<DIV align=center id="printdiv">
<input class="buttoninput" type="button" value="打印预览" onclick="window.printdiv.style.display='none';factory.printing.Preview();window.printdiv.style.display='block'"> 
  <input type="button" name="Button1" value="导出到EXCEL" onClick="bringToExcel();">

 </div>
<CENTER>
<object id="factory" style="display:none" viewastext classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814"
 codebase="ScriptX.cab#Version=5,60,0,360"></object>
   <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >

<p align="center">各项目欠款汇总表</p>
 
<table   width="99%" ><tr ><td>&nbsp;</td><td align="right">认购日期:<%=Date1+"--"+Date2 %></td></tr></table>
<table width="99%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

<table width="99%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr align="center">
    <td width="9%" rowspan="2">项目名称</td>

    <td width="27%" colspan="3">尚欠款项</td>
    <td width="10%" rowspan="2">备注</td>
  </tr>
  <tr align="center">
  
    <td width="9%">房款</td>
    <td width="9%">代收款</td>
    <td width="9%">合计</td>
  </tr>
  <%
  if (!SecNo.equals(""))SecNo=" and section='"+SecNo1+"'";
  String sql="select  sectionname,sum(rmbprice+lu_tai_area*lu_tai_area_price) fk,sum(ajmoney) ajmoney from order_contract where  state<>3 and  convert(char(10),date,120) >='"+Date1+"' and  convert(char(10),date,120) <='"+Date2+"' "+SecNo+" group by sectionname";

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
 double a1=0;
 double a2=0;
 int ajmoney=0;
  while (rs.next()){
    String name=rs.getString("sectionname"); 
	fk=rs.getDouble("fk"); 
	ajmoney=rs.getInt("ajmoney");
	 
   %>
  <tr  align="center">
    <td width="9%"><%=name%>　</td>
	   
	<%
	sql="select  sum(shouldMoney*rate) price  from GatheringRecord where ContactNo in (select code   from order_contract where  state<>3 and  convert(char(10),date,120) >='"+Date1+"' and  convert(char(10),date,120) <='"+Date2+"' and sectionname='"+name+"')";

	rs1=ViewBean1.executeQuery(sql);
	double ys_fk_price=ajmoney;
 
	if (rs1.next())ys_fk_price+=rs1.getDouble("price");
	

	 %>
   
	<%
	rs1.close();
	sql="select  sum(TaxMoney) price  from GatheringTaxRecord where   cancel=0  and  ContactNo in (select code from   order_contract where  state<>3 and  convert(char(10),date,120) >='"+Date1+"' and  convert(char(10),date,120) <='"+Date2+"' and sectionname='"+name+"')";
	rs1=ViewBean1.executeQuery(sql);
	 double ys_tax_price=0;
	if (rs1.next())ys_tax_price=rs1.getDouble("price");
	
	
	 %>
   
	<%
	rs1.close();
	
    double ss_fk_price=0;
	sql="select  sum(factmoney*CurrRate) price  from FactGatheringRecord where ContractNo in (select code from   order_contract where   state<>3 and  convert(char(10),date,120)  >='"+Date1+"' and   convert(char(10),date,120)  <='"+Date2+"' and sectionname='"+name+"')";
	rs1=ViewBean1.executeQuery(sql);
 
	if (rs1.next())ss_fk_price=rs1.getDouble("price");
	
	rs1.close();
	//放款
	sql="select  sum(FactMonye) price  from FactAjCharges where contractno in (select code from   order_contract where  state<>3 and    convert(char(10),date,120)  >='"+Date1+"' and   convert(char(10),date,120)  <='"+Date2+"' and sectionname='"+name+"')";
	rs1=ViewBean1.executeQuery(sql);
	  
	if (rs1.next())ss_fk_price+=rs1.getDouble("price");
	
	 %>
  
	<%
	rs1.close();
	  double ss_tax_price=0;
	sql="select  sum(money) price  from FactGatheringTaxRecord where  ContractNo in (select code from   order_contract where   state<>3 and  convert(char(10),date,120)  >='"+Date1+"' and   convert(char(10),date,120)  <='"+Date2+"' and sectionname='"+name+"')";
	rs1=ViewBean1.executeQuery(sql);
 
	if (rs1.next())ss_tax_price=rs1.getDouble("price");
	 
	 %>

    <td width="9%"><%=FormatD.getFloat2(ys_fk_price-ss_fk_price,2) %></td>
    <td width="9%"><%=FormatD.getFloat2(ys_tax_price-ss_tax_price,2) %></td>
        <td width="9%"><%=FormatD.getFloat2((ys_fk_price-ss_fk_price)+(ys_tax_price-ss_tax_price),2) %></td>
    <td width="10%">　</td>
  </tr>
  
 <%
  a1+=ys_fk_price-ss_fk_price;
  a2+=ys_tax_price-ss_tax_price;
 } %>
  <tr  align="center">
    <td width="9%">合计</td>

     <td width="9%"><%=FormatD.getFloat2(a1,2) %></td>
   <td width="9%"><%=FormatD.getFloat2(a2,2) %></td>
     <td width="9%"><%=FormatD.getFloat2((a1+a2),2) %></td>
    <td width="10%">　</td>
  </tr>
   <br>
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
 
  </script>


</body>
</html>
