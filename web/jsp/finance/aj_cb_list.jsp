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

	<title>按揭催办进度统计表</title>
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
<p align="center">催办按揭统计表	</p>
 <table   width="98%"  align="center" ><tr ><td>项目：<%=SecNo %></td><td align="right"><%=Date1+"--"+Date2 %></td></tr></table>
<table width="98%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center">
   <!-- <td >按揭银行(按揭款)</td>-->
    <td >序号</td>
    <td >地点</td>
    <td >业主</td>
	 <td >联系电话</td>
    <td >签订合同日期</td>
	<td >合同款</td>
	 <td >应交首期款</td>
	 <td >收到首期款</td>
    <td >按揭金额</td>
	 <td >应办日期</td>
	 
	  <td >备注   </td>
  </tr>
  
  <%
  int i=1;
  double ajmoney=0;
  double sumajmoney=0;
  double fk=0;
  
	SQL="select CONVERT(char(10), DATEADD(dd, o.ajtxdate, o.VisaDate), 120) AS ajtxdate,o.code,o.loft+room_no room,o.ajbk,c.cus_name,c.phone,c.sj,o.VisaDate,o.dy_date";
	SQL+=",o.rmbprice+convert(numeric(9,2),o.dxs_area*o.dxs_unitprice) rmbprice, o.rmbprice+convert(numeric(9,2),o.dxs_area*o.dxs_unitprice)-o.ajmoney firstmoney, o.ajmoney,o.aj_send_date,o.ajDate from order_contract o,customer c  WHERE    o.state=2 and  o.ajmoney>0 and  o.customer=c.serialno and o.section='"+SecNo1+"' and ";
	if (datetype.equals("0"))
	SQL+=" convert(char(10),o.VisaDate,120) >='"+Date1+"' and  convert(char(10),o.VisaDate,120) <='"+Date2+"'";
 
	 
 if (!Loft.equals(""))
	SQL+=" and o.Loft='"+Loft+"'" ;
	SQL+=" and   o.aj_send_date is null ";
	 
	rs=ViewBean.executeQuery(SQL+" order by o.loft,o.room_no");
double firstmoney=0;
ajmoney=0;
sumajmoney=0;
String code="";
fk=0;
// out.println("<br>"+SQL);
 int aaa=0;
  while (rs.next()){
  code= getbyte(rs.getString("code"));
 String VisaDate= getbyte(rs.getString("VisaDate"));
 if (!VisaDate.equals(""))VisaDate=VisaDate.substring(0,10);
 
 String ajtxdate= getbyte(rs.getString("ajtxdate"));
 
  String ajbk= getbyte(rs.getString("ajbk"));
 String dy_date= getbyte(rs.getString("dy_date"));
 if (!dy_date.equals(""))dy_date=dy_date.substring(0,10);
 ajmoney=rs.getDouble("AJMONEY") ;
 String rmbprice=getbyte(rs.getString("rmbprice"));
 firstmoney=rs.getDouble("firstmoney") ;
 sumajmoney+=ajmoney;
   SQL="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
   SQL+=" where   f.ContractNo ="+code;
    rs2=ViewBean2.executeQuery(SQL );
	double ss_money=0;
	if (rs2.next()){
	  ss_money=rs2.getDouble("fact");
	 
	}
	rs2.close();
   %>
 <tr align="center">
 
  <td  >&nbsp;<%=i%></td>
  <td  >&nbsp;<%=rs.getString("room") %></td>
  <td  >&nbsp;<%=rs.getString("cus_name") %></td>
    <td  >&nbsp;<%=rs.getString("phone") %>&nbsp;<%=rs.getString("sj") %></td>
  <td  >&nbsp;<%=VisaDate %></td>
    <td  ><%=rmbprice %></td>
    <td  ><%=firstmoney %></td>
	 <td  ><%=ss_money %></td>
  <td  ><%=FormatD.getFloat2(ajmoney,2)%></td>
  <td  >&nbsp;<%=ajtxdate %></td>
 
 
  
 <%
 SQL="SELECT * from aj_bak where contractno="+code;
 rs2=ViewBean2.executeQuery(SQL );
 int state=0;
 int state1=0;
 int state2=0;
 int state3=0;
 while (rs2.next()){
   state=rs2.getInt("state");
   state1=rs2.getInt("state1");
   state2=rs2.getInt("state2");
   state3=rs2.getInt("state3");
  }
 rs2.close();
  %>
    <td  >&nbsp;<%if (state1==0){out.print("资料未提交完");} %>&nbsp;<%if (state==1){out.print("银行已批");} %>&nbsp;<%if (state2==1){out.print("终审通过");}  %>&nbsp;<%if (state3==1){out.print(ajbk+"退件");}  %></td>
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
  <td  >&nbsp;</td>
  <td  ><%=FormatD.getFloat2(sumajmoney,2) %></td>
 
    <td  >&nbsp;</td>
   <td  >&nbsp;</td>
   
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
</script>

</body>
</html>
