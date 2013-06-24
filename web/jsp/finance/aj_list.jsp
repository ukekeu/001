<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,java.util.*,common.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/> 

<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

	<title>银行按揭额明细表</title>
</head>
<%

String Date1=request.getParameter("Date1");
String Date2=request.getParameter("Date2");
String SecNo=getbyte1(request.getParameter("SecNo"));
String SecNo1=SecNo.substring(0,SecNo.indexOf("-"));
SecNo=SecNo.substring(SecNo.indexOf("-")+1);
String Loft=China.getParameter(request,"Loft"); 
 String datetype=request.getParameter("datetype");
String SQL="";

ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;

 %>
<body topmargin="0">
	<DIV align=center id="printdiv">
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
  <input type="button" onclick="bringToExcel()" value="导出到Excel"> 

 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
 <div valign=top id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >
<p align="center">银行按揭额明细表	</p>
 <table   width="98%"  align="center" ><tr ><td>项目：<%=SecNo %></td><td align="right"><%=Date1+"--"+Date2 %></td></tr></table>
<table width="98%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center">
   <!-- <td >按揭银行(按揭款)</td>-->
    <td >序号</td>
    <td >房号</td>
	 <td >面积</td>
    <td >业主</td>
	 <td >联系电话</td>
	 <td >合同款额</td>
	  <td >首期款</td>
    <td >签订合同日期</td>
    <td >按揭金额</td>
	 <td >放款日期</td>
	  <td >放款金额</td>
	 <td >付抵押费日期   </td>
	  <td >备注   </td>
  </tr>
  
  <%
  int i=1;
  double ajmoney=0;
  double sumajmoney=0;
  double fk=0;
 SQL="SELECT ajbk from order_contract where section='"+SecNo1+"' group by ajbk";
 rs1=ViewBean1.executeQuery(SQL );
  while (rs1.next()){
  %><tr  align="left">
  
    <td colspan="13"  bgcolor="#c0c0c0" >按揭银行：<%=getbyte(rs1.getString("ajbk")) %></td>
 
  </tr>
  <%
	SQL="select o.code,o.loft+room_no room,o.ajbk,c.cus_name,c.phone,c.sj,o.VisaDate,o.dy_date";
	SQL+=",o.ajmoney,o.rmbprice,o.rmbprice-o.ajmoney first,o.jzarea from order_contract o,customer c WHERE  o.state=2 and  o.ajmoney>0 and  o.customer=c.serialno and o.section='"+SecNo1+"'  ";
	if (datetype.equals("0"))
	SQL+=" and convert(char(10),o.VisaDate,120) >='"+Date1+"' and  convert(char(10),o.VisaDate,120) <='"+Date2+"'";
	else if (datetype.equals("1"))
	SQL+=" and convert(char(10),o.date,120) >='"+Date1+"' and  convert(char(10),o.date,120) <='"+Date2+"' ";
	     SQL+=" and o.ajbk='"+ getbyte(rs1.getString("ajbk"))+"'";
 if (!Loft.equals(""))
	SQL+=" and o.Loft='"+Loft+"' " ;
	rs=ViewBean.executeQuery(SQL+" order by o.loft,o.floors,o.room_no");
double fkmoney=0;
ajmoney=0;
sumajmoney=0;
fk=0;
// out.println("<br>"+SQL);
 int aaa=0;
  while (rs.next()){
  
 String VisaDate= getbyte(rs.getString("VisaDate"));
 if (!VisaDate.equals(""))VisaDate=VisaDate.substring(0,10);
 
 String fk_date= "";
 int aj_type=0;
 String dy_date= getbyte(rs.getString("dy_date"));
 if (!dy_date.equals(""))dy_date=dy_date.substring(0,10);
 ajmoney=rs.getDouble("AJMONEY") ;
 fkmoney=0;
 sumajmoney+=ajmoney;
 SQL="select f.FactDate fkdate,f.FactMonye,f.aj_type  from   FactAjCharges f where  f.contractno ="+rs.getString("code");
 rs2=ViewBean2.executeQuery(SQL);
 if (rs2.next()){
   fkmoney=rs2.getDouble("FactMonye") ;
   fk_date= getbyte(rs2.getString("fkdate"));
   if (!fk_date.equals(""))fk_date=fk_date.substring(0,10);
   aj_type=rs2.getInt("aj_type");
 }
 rs2.close();
 if (!fk_date.equals("")) fk+=fkmoney;
   %>
 <tr align="center">
 
  <td  >&nbsp;<%=i%></td>
  <td  >&nbsp;<%=rs.getString("room") %></td>
    <td  >&nbsp;<%=rs.getString("jzarea") %></td>
  <td  >&nbsp;<%=rs.getString("cus_name") %></td>
    <td  >&nbsp;<%=rs.getString("phone") %>&nbsp;<%=rs.getString("sj") %></td>
	  <td  ><%=rs.getString("rmbprice") %></td>
	    <td  ><%=rs.getString("first") %></td>
  <td  >&nbsp;<%=VisaDate %></td>
  <td  ><%=FormatD.getFloat2(ajmoney,2)%></td>
  <td  >&nbsp;<%=fk_date %></td>
    <td  >&nbsp;<%if (!fk_date.equals("")) out.print(FormatD.getFloat2(fkmoney,2));%></td>
   <td  >&nbsp;<%=dy_date %></td>
 
    <td  >&nbsp;<%if (aj_type==0){out.print("商货");}else{out.print("公积金");} %> </td>
  </tr>
  <%i++;}
  rs.close(); 
 

  %>
  <tr align="center">
  <td  >&nbsp;小计</td>
  <td  >&nbsp;</td>
   <td  >&nbsp;</td>
    <td  >&nbsp;</td>
  <td  >&nbsp;</td>  
  <td  >&nbsp;</td>
  <td  >&nbsp;</td>  
  <td  >&nbsp;<%=FormatD.getFloat2(sumajmoney,2) %></td>
  <td  >&nbsp;</td>
  <td  >&nbsp;<%=FormatD.getFloat2(fk,2) %>  </td>  
    <td  >&nbsp;</td>
   <td  >&nbsp;</td>
 <td  >&nbsp;</td>
  </tr>
  
  <%}rs1.close(); %>
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
