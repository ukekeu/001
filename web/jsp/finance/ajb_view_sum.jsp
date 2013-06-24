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

	<title>按揭银行汇总表</title>
</head>
<%

String Date1=request.getParameter("Date1");
String Date2=request.getParameter("Date2");
String datetype=request.getParameter("datetype");
String SecNo=getbyte1(request.getParameter("SecNo"));
SecNo=SecNo.substring(SecNo.indexOf("-")+1);
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
String SQL="select o.sectionname,o.ajbk,sum(case when not o.fkdate is null then o.ajmoney end) fk,sum(o.ajmoney) ajmoney ";
SQL+="from order_contract o WHERE o.ajmoney>0 ";
if (!SecNo.equals(""))
SQL+=" and   o.sectionname='"+SecNo+"'  ";
if (datetype.equals("0"))
SQL+=" and convert(char(10),o.VisaDate,120) >='"+Date1+"' and  convert(char(10),o.VisaDate,120) <='"+Date2+"'";
else if (datetype.equals("1"))
SQL+=" and convert(char(10),o.date,120) >='"+Date1+"' and  convert(char(10),o.date,120) <='"+Date2+"' ";
else if (datetype.equals("2"))
SQL+=" and convert(char(10),o.fkdate,120) >='"+Date1+"' and  convert(char(10),o.fkdate,120) <='"+Date2+"' ";

SQL+=" group by o.sectionname,o.ajbk";

ResultSet rs=ViewBean.executeQuery(SQL);

 %>
<body>
	<DIV align=center id="printdiv">
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">

 <input type="button" name="Button1" value="导出到EXCEL" onClick="bringToExcel();">

 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
    <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >

<p align="center">各行办理按揭汇总表</p>
 
<table   width="80%"  align="center" ><tr align="right"><td><%=Date1+"--"+Date2 %></td></tr></table>
<table width="80%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr align="center">
    <td width="20%">项目</td>
    <td width="20%">办理银行</td>
    <td width="20%">按揭额</td>
    <td width="20%">备注</td>
  </tr>
    <%

  int sumaj=0,sumfk=0,ck=0;
  while (rs.next()){
    String sectionname= rs.getString("sectionname");
	 String ajbk= rs.getString("ajbk");
	int ajmoney=rs.getInt("ajmoney") ;
	sumaj+=ajmoney;
	int fk=rs.getInt("fk") ;
	sumfk+=fk;
	ck+=ajmoney-fk;
   %>
 <tr align="center">
    <td width="20%" height="16" align="left">&nbsp;<%=sectionname %></td>
	    <td width="20%" height="16">&nbsp;<%=ajbk %></td>
    <td width="20%" height="16"><%=ajmoney%></td>
   
    <td width="20%" height="16">&nbsp; </td>
  </tr>
  <%}
  rs.close(); 
  %>
 <tr><td>合计:</td><td>&nbsp;</td><td>&nbsp;<%=sumaj %></td><td>&nbsp;</td></td>
 
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
