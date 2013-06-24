<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%> 
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase"/> 
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
  <%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>

<html>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<head>
	<title>临定定金管理</title>
</head>
<script language="javascript" src="../public_js/public.js">
</script>
<body>
<%
 String date1=getbyte1(request.getParameter("Date1"));
String date2=getbyte1(request.getParameter("Date2"));
String SecNo=getbyte1(request.getParameter("SecNo"));


 %>
 <form name=frm method=post >
 <input type="button" name="Button1" value="导出到EXCEL" onClick="bringToExcel();">
   <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >

    <p align="center">临定定金明细表 </p>
 
	   <table width="90%"  align="center" cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
                      <tr > <td> 
                 
				  项目名称：<%=SecNo.substring(SecNo.indexOf("-")+1) %>
				 </td><td align="right">时间段:<%=date1 %>到<%=date2 %></td></tr></table>
				<br>
  <table width="90%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
                
    <tr  align="center" > 
      <td  > 序号 </td>
	  <td  > 客户名称 </td>
      <TD  > 临定单位 </td>
	    <TD  > 单位面积 </td>
		<TD  > 临定单价 </td>
		<TD  > 临定总价 </td>
	  <td > 临定日期 </td>
	  <td  > 定金 </td>
	  <td  > 退款 </td>
 
	  <td > 是否结转 </td>
   </tr>  
 <%
 String datestr="";
String ztstr="";
String datetype=getbyte1( request.getParameter( "datetype" ) ) ;

 String zt= getbyte1( request.getParameter( "zt" ) ) ;
 if (zt.equals("0")||zt.equals("1"))ztstr=" tk=0 and zto="+zt;
 else ztstr="tk>0";
String sectionwhere="";
 if (!SecNo.equals(""))sectionwhere=" and l.serialno ='"+SecNo.substring(0,SecNo.indexOf("-"))+"'";
if (!datetype.equals("3")){
if (!date1.equals("")&&!date2.equals(""))datestr="  and convert(varchar(10),StartDate,120)>='"+date1+"' and convert(varchar(10),StartDate,120)<='"+date2+"'";
 }else{
if (!date1.equals("")&&!date2.equals(""))datestr="  and convert(varchar(10),StartDate,120)>='"+date1+"' and convert(varchar(10),StartDate,120)<='"+date2+"'";

}
 String SQL="SELECT  s.roomcode,c.cus_name,l.name+r.loft+r.building+r.Room_code Room_code,r.area,s.StartDate,s.Subscription,s.saleprice ,convert(numeric(9,2),s.saleprice/r.area) unitprice ,s.billtype,s.bill_num,s.paytype,s.zto,s.tk+s.tk1 tk  from  SL_TemporarilyBuy s,room r,customer c,CRM_PROJECT l where s.state=0 and  s.Cusname=c.serialno and s.RoomCode=r.code and r.seccode=l.serialno  ";

 SQL+=sectionwhere+datestr;

ResultSet rs=aBean.executeQuery(SQL);
 int i=0;
 while (rs.next()){ 
 i++;
 %>
    <tr >
      <td  > <%=i %></td>
	  <td  align="left" > <%=getbyte(rs.getString("cus_name")) %> </td>
      <TD align="left" > <%=getbyte(rs.getString("room_code")) %> </td>
	   <TD align="left" > <%=getbyte(rs.getString("area")) %> </td>
	    <TD align="left" > <%=getbyte(rs.getString("unitprice")) %> </td>
	    <TD align="left" > <%=getbyte(rs.getString("saleprice")) %> </td>
	  <td > <%=getbyte(rs.getDate("StartDate").toString()) %> </td>
	  <td  ><%=getbyte(rs.getString("Subscription")) %> </td>
	  <% float tk=rs.getFloat("tk"); %>
	   <td  ><%=tk%> </td>
	  <td >&nbsp; <%
	  String sate=getbyte(rs.getString("zto")) ;
	 
	  if (tk==0){
	   if (sate.equals("0"))sate="未结转";
	   if (sate.equals("1"))sate="已结转";
	     
	}else{out.print("退定");} %> </td>
   </tr>  
 
 <%}rs.close(); %>  
 </form>
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
