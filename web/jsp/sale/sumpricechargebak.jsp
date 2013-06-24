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
	<title>总价变化明细表</title>
</head>
<%

String Date1=request.getParameter("Date1");
String Date2=request.getParameter("Date2");
String SecNo=getbyte1(request.getParameter("SecNo"));
String SecNo1=SecNo.substring(0,SecNo.indexOf("-"));
SecNo=SecNo.substring(SecNo.indexOf("-")+1);
String Loft=getbyte1(request.getParameter("Loft"));
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
String SQL="select o.loft+o.building+o.room_no roomno,o.date,b.log_date,b.change_date,o.rmbprice,b.yrmbprice yrmbprice,b.rmbprice-b.yrmbprice cj,o.payment1,o.Note ";
SQL+=" from order_contract o,order_contract_log b WHERE b.state=1 and b.yrmbprice-b.rmbprice>10 and  ";
if (!Loft.equals(""))
SQL+=" o.loft='"+Loft+"' and";

SQL+=" b.order_contract=o.code and o.section='"+SecNo1+"' and convert(char(7),o.date,120)<>convert(char(7),b.change_date,120) and convert(char(10),b.change_date,120) >='"+Date1+"' and  convert(char(10),b.change_date,120) <='"+Date2+"'";
ResultSet rs=null;

rs=ViewBean.executeQuery(SQL);

 %>
<body>
<DIV align=center id="printdiv">
<input class="buttoninput" type="button" value="打印预览" onclick="window.printdiv.style.display='none';factory.printing.Preview();window.printdiv.style.display='block'"> 
 </div>
<CENTER>
<object id="factory" style="display:none" viewastext classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814"
 codebase="ScriptX.cab#Version=5,60,0,360"></object>
<p align="center">总价变化情况表</p>
 
<table   width="95%" ><tr ><td>项目：<%=SecNo %></td><td align="right"><%=Date1+"--"+Date2 %></td></tr></table>
<table width="95%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr align="center">
   <td  >序号</td>
    <td  >单位</td>
	<td  >认购日期</td>
	<td  >认购总款</td>
    <td  >变化日期</td>
    <td  >变化后总款</td>
	<td  >变化差额</td>
	<td  >付款方式</td>
	
    <td  >备注</td>
  </tr>
  <%
  int iii=0;
  while (rs.next()){iii++;
  
   %>
  <tr>
  <td height="16">&nbsp;<%=iii%></td>
    <td height="16">&nbsp;<%=rs.getString("roomno") %></td>
	<td height="16">&nbsp;<%=rs.getDate("date").toString() %></td>
	<td height="16">&nbsp;<%=rs.getString("yrmbprice") %></td>
    <td height="16">&nbsp;<%=rs.getDate("change_date").toString() %></td>
    <td height="16">&nbsp;<%=rs.getString("rmbprice") %></td>
	<td height="16">&nbsp;<%=rs.getString("cj") %></td>
    <td height="16">&nbsp;<%=rs.getString("payment1") %></td>
    <td height="16">&nbsp; <%=rs.getString("Note") %></td>
  </tr>
  <%}
  rs.close(); 
  %>
 
</table>


</body>
</html>
