<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<html>
<head><LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

	<title>产权核对表</title>
</head>
<%

String Date1=request.getParameter("Date1");
String Date2=request.getParameter("Date2");
String SecNo=getbyte1(request.getParameter("SecNo"));
String SecNo1=SecNo.substring(0,SecNo.indexOf("-"));
SecNo=SecNo.substring(SecNo.indexOf("-")+1);
String Loft=China.getParameter(request,"Loft"); 
String room=China.getParameter(request,"room"); 
String SQL="select o.loft+o.building+o.room_no roomno,c.cus_name,o.visadate,o.cq_checkdate";
SQL+="  from order_contract o,customer c WHERE o.customer=c.serialno and  o.state=2 and o.cq_check=1 and o.section='"+SecNo1+"' and convert(char(10),o.cq_checkdate,120) >='"+Date1+"' and  convert(char(10),o.cq_checkdate,120) <='"+Date2+"'";
 if (!Loft.equals(""))
		  SQL+=" and o.Loft='"+Loft+"' " ;
 if (!room.equals(""))
		  SQL+=" and o.room_no='"+room+"' " ;
		  
ResultSet rs=null;

rs=ViewBean.executeQuery(SQL);

 %>
<body>
		 	<DIV align=center id="printdiv">
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" name="Button1" value="导出到EXCEL" onClick="bringToExcel();">

 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
    <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >

<p align="center">产权证核对表</p>

 <table   width="80%" align="center" ><tr ><td>项目：<%=SecNo %></td><td align="right"><%=Date1+"--"+Date2 %></td></tr></table>
<table width="80%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr align="center">
   <td width="10%">序号</td>
    <td width="20%">地点房号</td>
    <td width="20%">业主</td>
    <td width="20%">合同签订时间</td>
    <td width="20%">产权证核对时间</td>
	<td width="20%">备注</td>
  </tr>
  
  <%
  int i=1;
  while (rs.next()){
  
   %>
<tr align="center">
<td><%=i %></td>
    <td width="20%" height="16">&nbsp;<%=rs.getString("roomno") %></td>
	   <td width="20%" height="16">&nbsp;<%=rs.getString("cus_name") %></td>
    <td width="20%" height="16">&nbsp;<%=rs.getDate("visadate").toString() %></td>
  
    <td width="20%" height="16">&nbsp;<%=rs.getDate("cq_checkdate").toString() %> </td>
 <td width="20%" height="16">&nbsp; </td>
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
