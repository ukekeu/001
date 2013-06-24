<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,java.util.*,common.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<html>
<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

	<title>欠款明细表</title>
</head>
<%

String Date1=request.getParameter("Date1");
String Date2=request.getParameter("Date2");
String SecNo=getbyte1(request.getParameter("SecNo"));
String Loft=getbyte1(request.getParameter("Loft"));

String roomno=getbyte1(request.getParameter("room"));
String SecNo1="";
if (!SecNo.equals("")){
  SecNo1=SecNo.substring(0,SecNo.indexOf("-"));
SecNo=SecNo.substring(SecNo.indexOf("-")+1);
}
 
 %>
<body>
		 	<DIV align=center id="printdiv">
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" name="Button1" value="导出到EXCEL" onClick="bringToExcel();">

 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>  <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >

<p align="center">各项目欠款明细表</p>
 
<table   width="100%"  align="center" ><tr ><td>&nbsp;</td><td align="right"><%=Date1+"--"+Date2 %></td></tr></table>
<table width="100%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

<table width="110%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr align="center">
    <td width="3%" rowspan="2">状态</td>
    <td width="3%" rowspan="2">地点</td>
    <td width="3%" rowspan="2">业主</td>
    <td width="3%" rowspan="2">联系电话</td>
    <td width="3%" rowspan="2">成交总价</td>
     <td width="3%" rowspan="2">认购日期</td>
<td width="3%" rowspan="2">付款方式</td>
<td width="3%" rowspan="2">实测补差</td>
    <td width="27%" colspan="4">应收款项</td>
    <td width="27%" colspan="4">已收款项</td>
    <td width="27%" colspan="4">尚欠款项</td>
    <td width="10%" rowspan="2">备注</td>
  </tr>
  <tr align="center">
    <td width="9%">首期款</td>
	 <td width="9%">按揭款</td>
    <td width="9%">代收款</td>
    <td width="9%">合计</td>
      <td width="9%">首期款</td>
	 <td width="9%">按揭款</td>
    <td width="9%">代收款</td>
    <td width="9%">合计</td>
     <td width="9%">首期款</td>
	 <td width="9%">按揭款</td>
    <td width="9%">代收款</td>
    <td width="9%">合计</td>
  </tr>
  <%
    if (!SecNo.equals(""))SecNo=" and o.section='"+SecNo1+"'";
	if (!Loft.equals(""))SecNo+=" and o.Loft='"+Loft+"'";
	if (!roomno.equals(""))SecNo+=" and o.room_No='"+roomno+"'";
  String sql="select   case when o.state=1 then '认购' else '签约' end statevalue,o.loft+o.building+o.room_no room,  o.code,o.section,o.sectionname,c.Cus_Name,c.phone,c.sj ,o.rmbprice+o.lu_tai_area*o.lu_tai_area_price fk,ajmoney,convert(char(10),o.date,120) date,o.rmbprice,o.payment1,o.cj_f,o.customer   from order_contract o ,customer c  where   o.state<>3 and    o.customer=c.serialno and  o.date >='"+Date1+"' and o.state<>3 and  o.date <='"+Date2+"' "+SecNo+"        order by  o.section,o.sectionname,o.loft +o.building+o.Room_no";// group by o.code,o.section,o.sectionname, o.loft +o.building+o.Room_no, c.Cus_Name, c.Phone , c.sj";
  ResultSet rs=null;
   ResultSet rs1=null;
 // out.println(sql);
  rs=ViewBean.executeQuery(sql); 
 double y_price=0;
 double s_price=0;
 double y_price1=0;
 double s_price1=0;
 double fk=0;
 double dsk=0;
  double ffk=0;
 double fdsk=0;
  double  ajmoney=0;
double a001=0,a002=0,a003=0,a004=0,a005=0,a006=0,a007=0,a111=0;
double a222=0,a333=0,a444=0,a555=0;
  while (rs.next()){
    String statevalue=getbyte(rs.getString("statevalue")); 
    String section=getbyte(rs.getString("section")); 
    String name=rs.getString("room"); 
	String cusname=getbyte(rs.getString("cus_name")); 
	String phone=getbyte(rs.getString("phone")); 
	if (!phone.equals(""))
	phone+="/"+getbyte(rs.getString("sj")); 
	else 
	phone+=getbyte(rs.getString("sj")); 
	fk+=rs.getDouble("fk"); 
	ajmoney=rs.getDouble("ajmoney");
   %>
  
	<%
	sql="select  sum(shouldMoney*rate) price  from GatheringRecord where  cusno='"+rs.getString("customer")+"' and   ContactNo ="+rs.getString("code");
   //out.println(sql);
	rs1=ViewBean1.executeQuery(sql);
	double f_price=0; 
	double t_price=0; 
	double f_sumprice=0;//应收
	double f_sum=0;//应收合计(房款+代收)
	
	double f_sumprice1=0;//实收房款
	
	double t_sumprice=0;//应收
	double t_sum1=0;//实收合计(房款+代收)
	
	double t_sumprice1=0;//实收代收
	
    double sumprice=0;
	double price=0;
	if (rs1.next())f_price=rs1.getDouble("price");
	f_sumprice=f_price;
	
	 %>
  	<%
	rs1.close();
	sql="select  sum(TaxMoney) price  from GatheringTaxRecord where  cancel=0  and ContactNo   ="+rs.getString("code");
	rs1=ViewBean1.executeQuery(sql);
	 price=0;
	 
	if (rs1.next())t_price=rs1.getDouble("price");
	t_sumprice=t_price;
	 %>
    	<%
	rs1.close();
	
	sumprice=0;
	sql="select  sum(factmoney*CurrRate) price  from FactGatheringRecord where ContractNo    ="+rs.getString("code");
	rs1=ViewBean1.executeQuery(sql);
	 price=0;
f_sumprice1=0;
	if (rs1.next())f_sumprice1=rs1.getDouble("price");
	
	rs1.close();
	//放款
	double ajfk=0;
	sql="select  sum(FactMonye) price  from FactAjCharges where contractno   ="+rs.getString("code");
	rs1=ViewBean1.executeQuery(sql);
	  
	if (rs1.next())ajfk=rs1.getDouble("price");
	 %>

	<%
	rs1.close();
	 
	sql="select  sum(money) price  from FactGatheringTaxRecord where ContractNo    ="+rs.getString("code");
	rs1=ViewBean1.executeQuery(sql);
	 price=0;
	if (rs1.next())t_sumprice1=rs1.getDouble("price");
	fdsk+=price;
	sumprice+=price;
	s_price1+=price;
	t_sum1=t_sumprice1+f_sumprice1;
        double a009=0;
        double a008=0;
 if (t_sumprice>t_sumprice1){a009=(f_sumprice-f_sumprice1)+(t_sumprice-t_sumprice1) ;}
else{a009= (f_sumprice-f_sumprice1) ;}
a001+=a009;
if (t_sumprice>t_sumprice1)a008= t_sumprice-t_sumprice1 ;else{a008=0;}
a002+=a008;

 
	 if (a009>0){ 
a003+=ajmoney-ajfk;
a004+=f_sumprice-f_sumprice1;
a005+=t_sumprice1+f_sumprice1+ajfk;
a006+=t_sumprice1;
a007+=ajfk;
a111+=f_sumprice1;
a222+=t_price+f_price+ajmoney;
a333+=t_price;
a444+=ajmoney;
a555+=f_price;
%>
<tr  align="center">
    <td width="3%"><%=statevalue%></td>
    <td width="3%"><%=name%></td>
	
    <td width="3%"><%=cusname%></td>
    <td width="9%"><%=phone%>　</td>

    <td width="9%"><%=getbyte(rs.getString("rmbprice"))%>　</td>
<td width="3%"><%=getbyte(rs.getString("date"))%></td>
<td width="9%"><%=getbyte(rs.getString("payment1"))%>　</td>
<td width="9%"><%=getbyte(rs.getString("cj_f"))%>　</td>
  <td width="9%"><%=FormatD.getFloat2(f_price,2) %></td>
	  <td width="9%"><%=FormatD.getFloat2(ajmoney,2) %></td>

<td width="9%"><%=FormatD.getFloat2(t_price,2) %></td>
    <td width="9%"><%=FormatD.getFloat2(t_price+f_price+ajmoney,2) %></td>

    <td width="9%"><%=FormatD.getFloat2(f_sumprice1,2) %></td>
	 <td width="9%"><%=FormatD.getFloat2(ajfk,2) %></td>

    <td width="9%"><%=FormatD.getFloat2(t_sumprice1,2) %></td>
    <td width="9%"><%=FormatD.getFloat2(t_sumprice1+f_sumprice1+ajfk,2) %></td>
    <td width="9%"><%=FormatD.getFloat2(f_sumprice-f_sumprice1,2) %></td>
  <td width="9%"><%=FormatD.getFloat2(ajmoney-ajfk,2) %></td>
    <td width="9%"><%=FormatD.getFloat2(a008,2)%></td>
      <td width="9%"><%=FormatD.getFloat2(a009,2)%></td>
    <td width="10%">　</td>
  </tr>
  
 <%}} %>
 <%
 sql="select  sum(shouldMoney*rate) price  from GatheringRecord where ContactNo in (select code   from order_contract where state<>3 and      convert(char(10),date,120) >='"+Date1+"' and   convert(char(10),date,120) <='"+Date2+"' ";
  if (!SecNo.equals(""))sql+=" and section='"+SecNo1+"'";
  if (!Loft.equals(""))sql+=" and Loft='"+Loft+"'";
  if (!roomno.equals(""))sql+=" and  room_no='"+roomno+"'";
  sql+=")";
	 
	rs1=ViewBean1.executeQuery(sql);
	double a1=0,a2=0,a3=0,a4=0,a5=0,a6=0;
   if (rs1.next())a1=rs1.getDouble("price");
   rs1.close();
    sql="select  sum(ajmoney) ajmoney   from order_contract where state<>3 and      convert(char(10),date,120) >='"+Date1+"' and   convert(char(10),date,120) <='"+Date2+"' ";
  if (!SecNo.equals(""))sql+=" and section='"+SecNo1+"'";
  if (!Loft.equals(""))sql+=" and  Loft='"+Loft+"'";
  if (!roomno.equals(""))sql+=" and  room_no='"+roomno+"'";
 rs1=ViewBean1.executeQuery(sql);
     if (rs1.next())a5=rs1.getDouble("ajmoney");
	 
	 
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
	  
	if (rs1.next())a6=rs1.getDouble("price");
	rs1.close();
	 
	sql="select  sum(money) price  from FactGatheringTaxRecord where  ContractNo in (select code from   order_contract where state<>3 and      convert(char(10),date,120) >='"+Date1+"' and   convert(char(10),date,120) <='"+Date2+"' ";
	 if (!SecNo.equals(""))sql+=" and section='"+SecNo1+"'";
   if (!Loft.equals(""))sql+=" and  Loft='"+Loft+"'";
      if (!roomno.equals(""))sql+=" and  room_no='"+roomno+"'";
   sql+=")";
	rs1=ViewBean1.executeQuery(sql);
 
	if (rs1.next())a4=rs1.getDouble("price");
  %>
  <tr  align="center">
    <td width="9%">合计</td>
	<td width="9%"> &nbsp;</td>
	<td width="9%"> &nbsp;</td>
<td width="9%"> &nbsp;</td>
	<td width="9%"> &nbsp;</td>
<td width="9%"> &nbsp;</td>
	<td width="9%"> &nbsp;</td>
<td width="9%"> &nbsp;</td>
    <td width="9%"><%=FormatD.getFloat2(a555,2) %></td>
	    <td width="9%"><%=FormatD.getFloat2(a444,2) %></td>
    <td width="9%"><%=FormatD.getFloat2(a333,2) %></td>
    <td width="9%"><%=FormatD.getFloat2(a222,2) %></td>
	
    <td width="9%"><%=FormatD.getFloat2(a111,2) %></td>
	   <td width="9%"><%=FormatD.getFloat2(a007,2) %></td>
      <td width="9%"><%=FormatD.getFloat2(a006,2) %></td>
     <td width="9%"><%=FormatD.getFloat2(a005,2) %></td>
     <td width="9%"><%=FormatD.getFloat2(a004,2) %></td>
	  <td width="9%"><%=FormatD.getFloat2(a003,2) %></td>
   <td width="9%"><%=FormatD.getFloat2(a002,2) %></td>
     <td width="9%"><%=FormatD.getFloat2(a001,2)%></td>
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

 
 