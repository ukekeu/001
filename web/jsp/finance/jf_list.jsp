 
 <%@ page contentType="text/html;charset=GBK" %>
 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/CheckSection.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>交房清单</title>
</head>
<body>
<% 
String secName="";
String strDate1="",strDate2="";
String Date1=request.getParameter("Date1");
String Date2=request.getParameter("Date2");
if (!Date1.equals("")&&!Date2.equals("")){
  strDate1=" and o.jf_date between '"+Date1+"' and '"+Date2+"'";
   
}
 String Loft=getbyte1(request.getParameter("Loft"));
String sectionNo=getbyte1(request.getParameter("SecNo"));
 secName=sectionNo.substring(sectionNo.indexOf("|")+1);
sectionNo=sectionNo.substring(0,sectionNo.indexOf("|"));
	 
 %>
 <DIV align=center id="printdiv">
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
  <input type="button" onclick="bringToExcel()" value="导出到Excel"> 

 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
 <div valign=top id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >

<table width="98%" cellspacing="0" cellpadding="0">
 <tr align="center" ><td  ><b><font size=4><%=secName  %>交房明细表</font></b> </td></tr>
</table>
<br>
 时间段：<%=Date1 %>--<%=Date2 %>
 <table width="98%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF">
  
  <tr bgcolor='#EAECEC' align="center">  
    <td  >序号</td>
    <td>应交房日期</td>
	 <td>实交房日期</td>
	  <td>业主姓名</td>
    <td> 物业单元 </td>
	  </tr>
  <%
    
   String SQL="";//select sum(jzarea) jzarea,sum(rmbprice) rmbprice,count(*) num from  order_contract where state<>3  "+Date1+" and section ='"+sectionNo+"' and code in (select contractno from FactGatheringRecord where Period='0' group by  contractno) "; 

	  ResultSet rs=null;
	   ResultSet rs1=null;
	  double jzarea=0;
	  double rmbprice=0;
	  int num=0;
    
  
    SQL="select o.JLdate ,o.jf_date,o.loft+room_no room,c.cus_name from  order_contract o,customer c where o.customer=c.serialno and o.state<>3 "+strDate1+" and o.section ='"+sectionNo+"'";
	if (!Loft.equals(""))
	SQL+=" and o.loft='"+Loft+"' ";
	SQL+=" order by o.loft,o.floors,room_no  "; 
 
	   rs=ViewBean2.executeQuery(SQL);
	   int i=1;
	   while (rs.next()){
	     out.print("<tr align='center'><td>"+i+"</td>");
		 
   	     out.print("<td>"+rs.getDate("JLdate").toString()+"</td>");
		 
		 out.print("<td>"+rs.getDate("jf_date").toString()+"</td>");
		  out.print("<td>"+rs.getString("cus_name")+"</td>");
		  out.print("<td>"+rs.getString("room")+"</td></tr>");
   	    i++;
	}
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
