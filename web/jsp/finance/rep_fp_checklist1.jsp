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
	<title>开具发票情况表(按签约日期来统计)</title>
</head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<%

String Date1=request.getParameter("Date1");
String Date2=request.getParameter("Date2");
String SecNo=getbyte1(request.getParameter("SecNo"));
String datetype=request.getParameter("datetype");
String SecNo1="";
if (!SecNo.equals(""))
  SecNo1=SecNo.substring(0,SecNo.indexOf("-"));
  
SecNo=SecNo.substring(SecNo.indexOf("-")+1);
String Loft=China.getParameter(request,"Loft"); 
 String room=China.getParameter(request,"room");
  String fpno=China.getParameter(request,"fpno");
String SQL="select o.code,convert(char(10),o.JLdate,120) JLdate,o.payment1,o.ContractNo,o.loft+o.room_no roomno,o.rmbprice+o.cj_f rmbprice, c.cus_name,case when o.y_jzarea>0 then o.y_jzarea else o.jzarea end jzarea,case when o.y_area>0 then o.y_area else o.area end area,o.tnunitprice,convert(char(10),o.visadate,120) visadate,convert(char(10),o.jf_date,120) jf_date,o.yong_tu ";
SQL+="  from order_contract o,customer c WHERE o.state<>3   and o.customer=c.serialno ";

if (!SecNo1.equals(""))
  SQL+=" and  o.section='"+SecNo1+"' ";
if (!Date1.equals("")&&!Date2.equals("")&datetype.equals("3"))
  SQL+="  and convert(char(10),o.visadate,120) >='"+Date1+"' and  convert(char(10),o.visadate,120) <='"+Date2+"'";
else if (!Date1.equals("")&&!Date2.equals("")&datetype.equals("2"))
  SQL+="  and convert(char(10),o.jf_date,120) >='"+Date1+"' and  convert(char(10),o.jf_date,120) <='"+Date2+"'";
 if (!Loft.equals(""))
		  SQL+=" and o.Loft='"+Loft+"' " ;
 if (!room.equals(""))
		  SQL+=" and o.room_no='"+room+"' " ;		
  		    
ResultSet rs=null;
ResultSet rs1=null;
double zjk=0;
double qsk=0;
  double ysk=0;
rs=ViewBean.executeQuery(SQL);
  double a1=0,a2=0,a3=0,a4=0,a5=0,a6=0,a7=0;
 %>
<body>
		 	<DIV align=center id="printdiv">
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
  <input type="button" name="Button1" value="导出到EXCEL" onClick="bringToExcel();">

 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
    <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >

<p align="center">开具发票情况表</p>
 
<table   width="99%" align="center" ><tr ><td>项目：<%=SecNo %></td><td align="right"><%=Date1+"--"+Date2 %></td></tr></table>
<table width="99%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr align="center">
   <td >序号</td>
    <td >地点房号</td>
    <td >业主</td>
	
    <td >应交房<br>日期</td>
	<td >实际交<br>房日期</td>
    <td >合同签<br>订时间</td>
	    <td >合同号</td>
		<td >付款方式</td>
		
	    <td >核实建<br>筑面积</td>
		    <td >核实套内<br>建筑面积</td>
			    <td >合同单价</td>
				  <td >应收款</td>
				    <td >已收款</td>
					 <td >未收款</td>
    <td >开票时间</td>
	 <td >开票金额</td>
	  <td >发票编号</td>
	<td >用途</td>
  </tr>
  
  <%
  int i=1;
  double sumk=0;
  while (rs.next()){
  double rmbprice=rs.getDouble("rmbprice");
  String code=rs.getString("code");
  double sjk=0; 

  zjk+=rmbprice;
  SQL="SELECT factmoney*CurrRate factmoney from factGatheringRecord where not period in ('6','9','5','10','11') and contractno = '" + code + "' and  convert(char(10),gather_date,120) <='"+Date2+"'";
  rs1=ViewBean1.executeQuery(SQL);
  while (rs1.next())sjk+=rs1.getDouble("factmoney");
    rs1.close();
   SQL="SELECT  factmonye from FactAjCharges where contractno = '" + code + "' and  convert(char(10),factdate,120) <='"+Date2+"'";
  rs1=ViewBean1.executeQuery(SQL);
  while (rs1.next())sjk+=rs1.getDouble("factmonye");
   qsk+=rmbprice-sjk;
  rs1.close();
  ysk+=sjk;
  double qk=rmbprice-sjk;
   double jzarea=0,area=0;
   jzarea=rs.getDouble("jzarea");
  area=rs.getDouble("area");
  a1+=jzarea;
  a2+=area;
  String invoice_date="";
  String invoice_no="";
  double invoice_money=0;
  SQL="SELECT * FROM F_invoice  WHERE state=0 and order_contract="+code;
   rs1=ViewBean1.executeQuery(SQL);
   while  (rs1.next()){
      invoice_date=rs1.getDate("invoice_date").toString();
	  invoice_money+=rs1.getDouble("invoice_money");
	  invoice_no+=" "+getbyte(rs1.getString("invoice_no")) ;
   }
   %>
<tr align="center">
<td  ><%=i %></td>
    <td  height="16">&nbsp;<%=rs.getString("roomno") %></td>
	   <td  height="16">&nbsp;<%=rs.getString("cus_name") %></td>
	    <td  height="16">&nbsp;<%=getbyte(rs.getString("jldate")) %></td>
	    <td  height="16">&nbsp;<%=getbyte(rs.getString("jf_date")) %></td>
    <td  height="16">&nbsp;<%=getbyte(rs.getString("visadate")) %></td>
	 <td  height="16">&nbsp;<%=rs.getString("ContractNo") %></td>
	  <td  height="16">&nbsp;<%=rs.getString("payment1") %></td>
    <td  height="16"><%=jzarea%></td>
	  <td  height="16"><%=area%></td>
	    <td  height="16">&nbsp;<%=rs.getString("tnunitprice")%></td>
		   <td  height="16"><%=FormatD.getFloat3(rmbprice,2)%></td>
		      <td  height="16"><%=FormatD.getFloat3(sjk,2)%></td>
			   <td  height="16"><%=FormatD.getFloat3(qk,2)%></td>
    <td  height="16">&nbsp;<%=invoice_date %> </td>
	 <%double aa=invoice_money;
	 
	 sumk=sumk+aa;
	 	  %>
	 <td  height="16"><%=aa %> </td>
	  <td  height="16">&nbsp;<%=invoice_no  %> </td>
	 <td  height="16">&nbsp; <%=getbyte(rs.getString("yong_tu"))  %></td>
  </tr>
  <%i++;}
  rs.close(); 
  %>
  <tr align="center"><td>合计</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td><%=FormatD.getFloat3(a1,2) %></td><td><%=FormatD.getFloat3(a2,2) %></td><td>&nbsp;</td><td><%=FormatD.getFloat3(zjk,2) %></td><td><%=FormatD.getFloat3(ysk,2) %></td><td><%=FormatD.getFloat3(qsk,2) %></td><td>&nbsp;</td><td><%=FormatD.getFloat3(sumk,2) %></td><td>&nbsp;</td><td>&nbsp;</td></tr>
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
     var selectArea=document.body.createTextRange(); //创建文本区域 
        selectArea.moveToElementText(report1);//将文本区域聚焦到printData 
        selectArea.select();//选中printData 
        selectArea.execCommand("Copy");//将printData复制到剪切板中 
         oSheet.Paste();//将剪切板中的数据复制到Excel中      
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
 
  </script>

</body>
</html>
