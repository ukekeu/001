 
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
<title>按付款方式统计</title>
</head>
<body>
<% 
String secName="",strDate4="";
String strDate1="",strDate2="",strDate3="";
String Date1=request.getParameter("Date1");
String Date2=request.getParameter("Date2");
String con=getbyte1(request.getParameter("con"));
 
if (!Date1.equals("")&&!Date2.equals("")){
  strDate1=" and convert(char(10),Date,120) >= '"+Date1+"' and  convert(char(10),Date,120)<= '"+Date2+"'";
  if (con.equals("1")){
    strDate4="    ";
  strDate2="    convert(char(10),Gather_Date,120) <= '"+Date2+"'";//convert(char(10),Gather_Date,120) >='"+Date1+"' and
  strDate3="   convert(char(10),factDate,120) <= '"+Date2+"'";//convert(char(10),factDate,120) >='"+Date1+"' and 
 }else{
 
 strDate4=" and convert(char(10),Date,120) >= '"+Date1+"' and  convert(char(10),Date,120)<= '"+Date2+"'";
 
  strDate2="  convert(char(10),Gather_Date,120) >='"+Date1+"' and   convert(char(10),Gather_Date,120) <= '"+Date2+"'";//
  strDate3="  convert(char(10),factDate,120) >='"+Date1+"' and  convert(char(10),factDate,120) <= '"+Date2+"'";//
 }
 
}
 
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
 <tr align="center" ><td  ><b><font size=4><%=secName  %>付款方式情况分析</font></b> </td></tr>
</table>
<br>
 时间段：<%=Date1 %>--<%=Date2 %>
 <table width="98%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF">
  
  <tr bgcolor='#EAECEC' align="center">  
    <td colspan="2">付款方式</td>
    <td>已售面积M<sup>2</sup></td>
	 <td>已售总套数</td>
	  <td>已售总金额</td>
   
	  <td>  已收款金额 
 </td>
  </tr>
  <%
    
   String SQL="";//select sum(jzarea) jzarea,sum(rmbprice) rmbprice,count(*) num from  order_contract where state<>3  "+Date1+" and section ='"+sectionNo+"' and code in (select contractno from FactGatheringRecord where Period='0' group by  contractno) "; 

	  ResultSet rs=null;
	   ResultSet rs1=null;
	  double jzarea=0;
	  double rmbprice=0;
	  int num=0;
	  double a1=0;
	  double a2=0;
	  double a3=0;
	  int a4=0; 
	  int a5=0;
	
   SQL="select payment1,count(*) num,sum(jzarea) jzarea   from  order_contract where state<>3  and section ='"+sectionNo+"' "+strDate1+"  group by payment1"; 
  int i=0;
 
	   rs=ViewBean2.executeQuery(SQL);
	   while (rs.next()){
	   i++;
	     String pay=getbyte(rs.getString("payment1"));
    SQL="select sum(case when fkdate is null then 0 else ajmoney end) fk,count(*)  num,sum(jzarea) jzarea,sum(rmbprice) price,sum(rmbprice)/sum(jzarea) avgprice,sum(rmbprice)-sum(zs_first_money) factprice,(sum(rmbprice)-sum(zs_first_money))/sum(jzarea) factavgprice from  order_contract where state<>3 "+strDate1+" and section ='"+sectionNo+"' and code in (select contractno from FactGatheringRecord  group by  contractno) and payment1='"+pay+"'"; 
    int ii=rs.getInt("num");
		 a4+=ii;
		  double jzarea1=rs.getDouble("jzarea");
		 a1+=jzarea1;
	   rs1=ViewBean1.executeQuery(SQL);
	  
	    double ajk=0;
	   if (rs1.next()){
	     out.print("<tr><td>"+i+"</td>");
		
		 
   	     out.print("<td>"+pay+"</td>");
		
		
		 out.print("<td>"+Format.getFloat2(jzarea1,2)+"</td>");
		  out.print("<td>"+ii+"</td>");
		  double price=rs1.getDouble("price");
		  a2+=price;
		  out.print("<td>"+Format.getFloat2(price,2)+"</td>");
		}else{
		
		  out.print("<tr><td>"+i+"</td>");
		 
   	     out.print("<td>&nbsp;</td>");
		 
		 out.print("<td>0</td>");
		  out.print("<td>0</td>");
		  out.print("<td>0</td>");
		
		
		}  
		rs1.close();
		  SQL="  select contractno ,count(*) num ,sum(factmoney*CurrRate) rmbprice from FactGatheringRecord where   "+strDate2+" and   contractno in (select  code from  order_contract where state<3 "+strDate4+"  and section ='"+sectionNo+"'  and payment1='"+pay+"') group by  contractno   "; // 
 		num=0;
		//rmbprice=ajk;
	   rs1=ViewBean1.executeQuery(SQL);
	      while (rs1.next()) {  num+=1;}
		  rs1.close();
		  a5+=num;
		 
		 	// out.print(SQL);
   	     SQL="  select count(*) num ,sum(factmoney*CurrRate) rmbprice from FactGatheringRecord where   "+strDate2+" and  contractno in (select  code from  order_contract where state<>3 and section ='"+sectionNo+"'  and payment1='"+pay+"')    "; // "+strDate1+" 
 //state<>3   and
  //out.print(SQL+"<br>");
		num=0;
		 rmbprice=0;
	   rs1=ViewBean1.executeQuery(SQL);
	      if (rs1.next()) {  rmbprice=rs1.getDouble("rmbprice");}
		  rs1.close();
		 
		 ajk=0;
		 SQL ="select sum(factmonye) as factmonye from FactAjCharges where "+strDate3+" and contractno  in (select  code from  order_contract where state<>3   and section ='"+sectionNo+"'  and payment1='"+pay+"')"; // "+strDate1+"
	// out.print(SQL);
	 	rs1 = ViewBean1.executeQuery( SQL) ;
		if (rs1.next())   ajk=rs1.getDouble("factmonye");
		rs1.close();
		a3+=rmbprice+ajk;
		  out.print("<td>"+Format.getFloat2(rmbprice+ajk,2)+"</td></tr>");		 
	}
	rs.close();

	 %>
	 <tr><td>&nbsp;合计：</td><td>&nbsp;</td><td><%=Format.getFloat2(a1,2) %></td><td><%=a4 %></td><td><%=Format.getFloat2(a2,2) %></td> <td><%=Format.getFloat2(a3,2) %></td>
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
