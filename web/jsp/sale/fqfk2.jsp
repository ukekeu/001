 
<%@ page contentType="text/html;charset=GBK" %>

<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<HTML>
<%@ include file="../public_js/checktime.jsp"%>

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>分期付款销售方式月度明细报表</title>
</head>

<body>
<%
  String SQL="";
  String stdate = China.getParameter(request,"Date1") ;
  String endate = China.getParameter(request,"Date2") ;
  String SecNo=China.getParameter(request,"SecNo") ;
  SQL="SELECT YONG_TU FROM order_contract WHERE state=2 and convert(char(10),date,120)>='"+stdate+"' and convert(char(10),date,120)<='"+endate+"' and section='"+SecNo+"' group by YONG_TU";
  ResultSet rs=null;
  ResultSet rs1=null;
   ResultSet rs2=null;
   String sectionname="";
   double sumjzarea=0;
   double qqsumprice=0;
   double bqsumprice=0;
   double ljsumprice=0;
    double hxljsumprice=0;
   double ljqk=0;
   double price1=0,price2=0,price3=0,price4=0,price5=0,price6=0;
   double sumprice=0;
   double sumdj=0;
    
  rs=ViewBean.executeQuery(SQL);
  
	 
	 
 %>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
  <DIV align=center id="printdiv">
<input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
  <input type="button" onclick="bringToExcel()" value="导出到Excel">

 </div>
  <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >
<table border="0" width="99%"  cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
  <tr align="center"><td>分期付款销售方式月度明细报表</td></tr>
  <tr><td>&nbsp;</td></tr>
  <tr align="center"> <td>报表日期:从<%=stdate %>到<%=endate %></td></tr>
   <tr><td>&nbsp;</td></tr>
  <tr><td><div id=sectionname></div></td></tr>
  </table>
<table border="1"   width="99%" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1"  >
  <tr align="center">
    <td width="4%" rowspan="2" height="65">房屋<br>性质</td>
    <td width="4%" rowspan="2" height="65">房号</td>
    <td width="4%" rowspan="2" height="65">业主姓名</td>
    <td width="4%" rowspan="2" height="65">面积</td>
    <td width="4%" rowspan="2" height="65">合同日期</td>
    <td width="10%" colspan="2" height="16">第一次收款</td>
    <td width="10%" colspan="2" height="16">第二次收款</td>
    <td width="10%" colspan="2" height="16">第三次收款</td>
    <td width="5%" rowspan="2" height="65">合同金额</td>
    <td width="10%" height="33" colspan="2">第一次收款</td>
    <td width="10%" height="33" colspan="2">第二次收款</td>
    <td width="10%" height="33" colspan="2">第三次收款</td>
	<td width="10%" height="33" colspan="2">后续收款</td>
	
    <td width="5%" rowspan="2" height="65">累计收款</td>
    <td width="5%" rowspan="2" height="65">欠款额</td>
    <td width="5%" rowspan="2" height="65">备注</td>
  </tr>
  <tr align="center">
    <td width="5%" height="48">约定收<br>款日期</td>
    <td width="5%" height="48">金额</td>
    <td width="5%" height="48">约定收<br>款日期</td>
    <td width="5%" height="48">金额</td>
    <td width="5%" height="48">约定收<br>款日期</td>
    <td width="5%" height="48">金额</td>
    <td width="5%" height="32">实际收<br>款日期</td>
    <td width="5%" height="32">金额</td>
    <td width="5%" height="32">实际收<br>款日期</td>
    <td width="5%" height="32">金额</td>
    <td width="5%" height="32">实际收<br>款日期</td>
    <td width="5%" height="32">金额</td>
	 <td width="10%" height="32" colspan="2">
	   <table border="0"   width="100%" cellpadding="0" cellspacing="0"   height="100%">
	<tr align="center"> <td width="50%">实际收<br>款日期</td><td width="50%">金额</td></tr>
	 </table>
	 </td>
  
  </tr>
  <%
  while (rs.next()){
  
   SQL="SELECT a.sectionname,a.yong_tu,a.loft+a.room_no roomno,b.cus_name,a.jzarea,CONVERT(char(10),a.visadate,120) visadate ,a.subscription dj,CONVERT(char(10), DATEADD(dd,";
   SQL+="a.ajtxdate,a.VisaDate), 120) ajdate,a.rmbprice-a.subscription kk,a.rmbprice ,a.code FROM order_contract a ,customer b WHERE a.customer=b.serialno and  a.state=2 and convert(char(10),a.date,120)>='"+stdate+"' and convert(char(10),a.date,120)<='"+endate+"' and a.section='"+SecNo+"' and a.payment1 like '%分期%' and  a.YONG_TU='"+rs.getString("YONG_TU")+"' order by a.loft+a.room_no";
       rs1=ViewBean1.executeQuery(SQL);
	   double ysk=0;
	   int ii=0;
	    while (rs1.next()){
		sectionname=rs1.getString("sectionname");
		sumjzarea+=rs1.getDouble("jzarea");
		sumdj+=rs1.getDouble("dj");
   %>
  <tr align="center">
    <td width="7%"  align="center"><%if (ii==0) {out.print(rs1.getString("yong_tu"));} %></td>
    <td width="7%"  align="center"><%=rs1.getString("roomno") %></td>
    <td width="7%"  align="center"><%=rs1.getString("cus_name") %></td>
    <td width="7%"><%=rs1.getString("jzarea") %></td>
    <td width="8%"  align="center"><%=rs1.getString("visadate") %></td>
	<%
	//   convert(char(10),shouldDate,120)>='"+stdate+"' and convert(char(10),shouldDate,120)<='"+endate+"' and
	SQL="SELECT shouldDate,shouldMoney FROM GatheringRecord where   contactno = " +rs1.getString("code");
	 rs2=ViewBean2.executeQuery(SQL);
	 double yjsk=0;
	 int num=0;
	    while (rs2.next()){
		num++;
		yjsk+=rs2.getDouble("shouldMoney");
		if (num==1 )price1+=rs2.getDouble("shouldMoney");
		else if (num==2 )price2+=rs2.getDouble("shouldMoney");
		else if (num==3 )price3+=rs2.getDouble("shouldMoney");
		%>
		 <td width="4%" height="16"><%=rs2.getDate("shouldDate").toString() %></td>
    <td width="5%" height="16"><%=FormtD.getFloat2(rs2.getDouble("shouldMoney"),2)  %></td>
		<%
		}
		rs2.close();
	for (int aaa=num;aaa<3;aaa++){
	// if (num<3){	 %>   
    <td width="5%" height="16"></td>
    <td width="5%" height="16"></td>
	<%} %>
   <!-- <td width="5%" height="16"></td>
    <td width="5%" height="16"></td>
	-->
    <td width="5%" height="16"><%=FormtD.getFloat2(rs1.getDouble("rmbprice"),2)  %></td>
     <%
	//   convert(char(10),shouldDate,120)>='"+stdate+"' and convert(char(10),shouldDate,120)<='"+endate+"' and
	SQL="SELECT top 3 gather_date,factmoney FROM factGatheringRecord where    contractno = " +rs1.getString("code")  +" order by gather_date";
	 rs2=ViewBean2.executeQuery(SQL);
	  double ljsk=0;
	  String gather_date="";
	   num=0;
	    while (rs2.next()){
		num++;
		gather_date=rs2.getDate("gather_date").toString();
		 ljsk+=rs2.getDouble("factmoney");
		if (num==1 )price4+=rs2.getDouble("factmoney");
		else if (num==2 )price5+=rs2.getDouble("factmoney");
		else if (num==3 )price6+=rs2.getDouble("factmoney");
		%>
		 <td width="4%" height="16"><%=gather_date %></td>
    <td width="5%" height="16"><%=FormtD.getFloat2(rs2.getDouble("factmoney"),2)  %></td>
		<%	 
		}
		rs2.close();		
	 for (int aa=num;aa<3;aa++){
	 %>   
    <td width="5%" height="16"></td>
    <td width="5%" height="16"></td>
	<%} %>
	   <td width="5%" height="16" colspan="2">
	   <%if (num==3){ 
	   SQL="SELECT  gather_date,factmoney FROM factGatheringRecord where    contractno = " +rs1.getString("code")  +"  and convert(char(10),gather_date,120)>'"+gather_date+"'  order by gather_date";
	 rs2=ViewBean2.executeQuery(SQL);
	   
	   %>
	   
		 <% 
	    int aaa=0;
	    while (rs2.next()){
	    gather_date=rs2.getDate("gather_date").toString();
	    hxljsumprice+=rs2.getDouble("factmoney");
		 
		 ljsk+=rs2.getDouble("factmoney");
		 if (aaa==0){
		%>
		   <table border="1"   width="100%" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111"  height="100%">
        <%} %>
	   <tr>	 <td width="50%" height="16"><%=gather_date %></td>
    <td width="50%" height="16"><%=FormtD.getFloat2(rs2.getDouble("factmoney"),2)  %></td>
	</tr>
	   <%aaa++;}rs2.close(); %>
	   <% if (aaa>0){ %>
	   </table>
	   <%}}
	    ljqk+=yjsk-ljsk;
		ljsumprice+=ljsk;
	    %>
	   </td>
    <td width="5%" height="16"><%=FormtD.getFloat2(ljsk,2) %></td>
    <td width="5%" height="16"><%=FormtD.getFloat2(yjsk-ljsk,2) %></td>
    <td width="5%" height="16"></td>
    
  </tr> 
  
  <%ii++;}
  rs1.close(); 
  
  }
  rs.close();
  %>
  

  <tr>
    <td width="4%" height="13">小计</td>
    <td width="4%" height="13"></td>
    <td width="4%" height="13"></td>
    <td width="4%" height="13"></td>
    <td width="4%" height="13"></td>
    <td width="5%" height="13"></td>
    <td width="5%" height="13"><%=FormtD.getFloat2(price1,2) %></td>
    <td width="5%" height="13"></td>
    <td width="5%" height="13"><%=FormtD.getFloat2(price2,2) %></td>
    <td width="5%" height="13"></td>
    <td width="5%" height="13"><%=FormtD.getFloat2(price3,2) %></td>
    <td width="5%" height="13"></td>
    <td width="5%" height="13"></td>
    <td width="5%" height="13"><%=FormtD.getFloat2(price4,2) %></td>
    <td width="5%" height="13"></td>
    <td width="5%" height="13"><%=FormtD.getFloat2(price5,2) %></td>
    <td width="5%" height="13"></td>
    <td width="5%" height="13"><%=FormtD.getFloat2(price6,2) %></td>
	<td width="5%" height="13"></td>
    <td width="5%" height="13"><%=hxljsumprice %></td>
	
    <td width="5%" height="13"><%=FormtD.getFloat2(ljsumprice,2) %></td>
    <td width="5%" height="13"><%=FormtD.getFloat2(ljqk,2) %></td>
    <td width="5%" height="13"></td>
  </tr>
</table>
<p></p>
<table border="0"   width="99%" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1"  >



  <tr>
    <td   height="13" colspan="4">销售经理：</td>
    
   
    <td   height="13"></td>
    <td  height="13" colspan="3">销售主管：</td>
    <td width="5%" height="13"></td>
    <td width="5%" height="13"></td>
    
    <td width="5%" height="13" colspan="3">制表人：</td>
  
    <td width="5%" height="13"></td>
    <td width="5%" height="13"></td>
    <td width="5%" height="13"></td>
    <td width="5%" height="13"></td>
    <td width="5%" height="13"></td>
    <td width="5%" height="13"></td>
    <td width="5%" height="13"></td>
    <td width="5%" height="13"></td>
    <td width="5%" height="13"></td>
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
        var selectArea=document.body.createTextRange(); //创建文本区域 
        selectArea.moveToElementText(report1);//将文本区域聚焦到printData 
        selectArea.select();//选中printData 
        selectArea.execCommand("Copy");//将printData复制到剪切板中 
         oSheet.Paste();//将剪切板中的数据复制到Excel中    
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
</script>
 <script>sectionname.innerHTML="楼盘：<%=sectionname%>";</script>
	
</body>

</html>
