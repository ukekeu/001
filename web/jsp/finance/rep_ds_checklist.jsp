<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<html>
<head>
	<title>代收核对表</title>
</head>
<%

String Date1=request.getParameter("Date1");
String Date2=request.getParameter("Date2");
String SecNo=getbyte1(request.getParameter("SecNo"));
String SecNo1=SecNo.substring(0,SecNo.indexOf("-"));
SecNo=SecNo.substring(SecNo.indexOf("-")+1);
 String Loft=China.getParameter(request,"Loft"); 
String room=China.getParameter(request,"room"); 
String TaxName=China.getParameter(request,"TaxName"); 

String SQL="select o.loft+o.room_no roomno,c.cus_name,f.date,f.checkdate,f.taxname,f.money,f.out_date,f.out_money";//  f.checkstate=1 and 
SQL+=" from order_contract o,customer c,FactGatheringTaxRecord f  WHERE o.state<>3 and o.code=f.contractno and o.customer=c.serialno and o.section='"+SecNo1+"' and convert(char(10),f.date,120) >='"+Date1+"' and  convert(char(10),f.date,120) <='"+Date2+"'";
 if (!Loft.equals(""))
		  SQL+=" and o.Loft='"+Loft+"' " ;
 if (!room.equals(""))
		  SQL+=" and o.room_no='"+room+"' " ;
if (!TaxName.equals(""))		  
   		  SQL+=" and f.TaxName='"+TaxName+"' " ;
ResultSet rs=null;

rs=ViewBean.executeQuery(SQL+" order by o.loft,o.floors,o.room_no");
  
 %>
<body>
<DIV align=center id="printdiv">
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">

   <input type="button" name="Button1" value="导出到EXCEL" onClick="bringToExcel();">

 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
   <div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >

<p align="center">代收核对表</p>
 
<table   width="110%" border="0" align="center"><tr ><td>项目：<%=SecNo %></td><td align="right"><%=Date1+"--"+Date2 %></td></tr></table>
<table width="110%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr align="center">
  <td  >序号</td>
    <td >地点房号</td>
    <td  >业主</td>
    <td  >收款时间</td>
<td  >核对项目</td>
<td  >收款金额</td>
    <td  >核对时间</td>
	    <td  >代付时间</td>
		    <td  >代付金额</td>
	<td  >备注</td>
  </tr>
  
  <%
  int i=1;
  while (rs.next()){
  
   %>
<tr align="center">
<td><%=i %></td>
    <td height="16">&nbsp;<%=rs.getString("roomno") %></td>
	   <td  height="16">&nbsp;<%=rs.getString("cus_name") %></td>
    <td height="16">&nbsp;<%=rs.getDate("date").toString() %></td>
  <td height="16">&nbsp;<%=rs.getString("taxname").toString() %></td>
<td  height="16"><%=rs.getString("money") %></td>
<% String checkdate=getbyte(rs.getString("checkdate"));
	  if (!checkdate.equals(""))checkdate=checkdate.substring(0,10);
	 %>
    <td height="16">&nbsp;<%=checkdate%> </td>
	 <td height="16">&nbsp;<%
	 String out_date=getbyte(rs.getString("out_date"));
	  if (!out_date.equals(""))out_date=out_date.substring(0,10);
	  out.print(out_date);
	 %> </td>
	  <td height="16"><%=getbyte(rs.getString("out_money")) %> </td>
	 <td height="16">&nbsp; </td>
	 
  </tr>
  <%i++;}
  rs.close(); 
  %>
  <%
  
 SQL="select  sum(f.money) money,sum(f.out_money) money1 ";
SQL+=" from order_contract o,customer c,FactGatheringTaxRecord f  WHERE o.state<>3 and o.code=f.contractno and o.customer=c.serialno and  o.section='"+SecNo1+"' and convert(char(10),f.date,120) >='"+Date1+"' and  convert(char(10),f.date,120) <='"+Date2+"'";
 if (!Loft.equals(""))
		  SQL+=" and o.Loft='"+Loft+"' " ;
 if (!room.equals(""))
		  SQL+=" and o.room_no='"+room+"' " ;
if (!TaxName.equals(""))		  
   		  SQL+=" and f.TaxName='"+TaxName+"' " ;
 

rs=ViewBean.executeQuery(SQL);
if (rs.next()){
   %>
 <tr align="center">
<td>合计：</td>
    <td height="16">&nbsp;</td>
	   <td  height="16">&nbsp;</td>
    <td height="16">&nbsp;</td>
  <td height="16">&nbsp;</td>
<td  height="16">&nbsp;<%=getbyte(rs.getString("money")) %></td>
    <td height="16">&nbsp; </td>
	 <td height="16">&nbsp; </td>
	  <td height="16">&nbsp; </td>
	  <td  height="16">&nbsp;<%=getbyte(rs.getString("money1"))  %></td>
  </tr>
  <%i++;}
  rs.close(); 
  %>
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
