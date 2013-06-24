<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*,java.util.*,java.util.Calendar" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>销售资金回笼明细表</title>
</head>
<body>
<%      String dates=China.getParameter(request,"Date1");
		String dates1=China.getParameter(request,"Date2");
		String SecNo1=China.getParameter(request,"SecNo");
		String Loft=China.getParameter(request,"Loft");
		 String SQL= "";
		 int day=0;
		 SQL="select datediff(dd,'"+dates+"','"+dates1+"') day";
		  ResultSet rs=ViewBean.executeQuery(SQL);
		  if (rs.next())day=rs.getInt("day");
		  rs.close();
		 %>
		<DIV align=center id="printdiv">
  <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" name="Button1" value="导出到EXCEL" onClick="bringToExcel();">
 </div>
 
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
   <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >

<p align="center"><font size=4>销售资金回笼明细表</font></p><br>
 
 <%   List list1=new LinkedList();//存放显示区号
	  int arr=0;
	   SQL="SELECT   name from CRM_Project a ";
         if (!SecNo1.equals(""))
		  SQL+=" where  a.SerialNo='"+SecNo1+"'";
		 
		  rs=ViewBean.executeQuery(SQL);
 
		  while (rs.next()){
		   String   name=rs.getString("name"); 
	  	   list1.add(name);
	       arr++;
	     }rs.close(); %>
 <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="99%" id="AutoNumber1" height="47">
  <tr align="center">
    <td width="10%" rowspan="2">日期</td>
    <td width="40%" colspan="<%=arr+1 %>">首期</td>
   
    <td width="28%" colspan="<%=arr+1 %>">按揭</td>
  <td width="12%" rowspan="2">合计</td>
  </tr>
  <tr align="center">
   <%for (int aa=0;aa<arr;aa++){ 
       String region=(String)list1.get(aa); %>
    <td width="10%"><%=region %></td>
   <%} %>
  <td width="10%"  >小计</td>
    
     <%for (int aaa=0;aaa<arr;aaa++){ 
       String region=(String)list1.get(aaa); %>
    <td width="10%"><%=region %></td>
   <%} %>
    <td width="12%" >小计</td>
	
  </tr>
  <%
  double skhj=0;
  double dayhj=0;
  for (int jj=0;jj<=day;jj++){
          String skdate="";
          SQL="select convert(char(10),dateadd(dd,"+String.valueOf(jj)+",'"+dates+"'),120) skdate";
		  rs=ViewBean.executeQuery(SQL);
		  if (rs.next())skdate=rs.getString("skdate");
		  rs.close();
		  skhj=0;
		  dayhj=0;
  
   %>
 <tr align="center">
  <td width="12%"><%=skdate %></td>
   <%for (int aa=0;aa<arr;aa++){ 
         String region=(String)list1.get(aa); 
	     String sql="select sum(f.factmoney*f.currrate) money from factGatheringRecord f";
		 sql+=" where f.Period in(0,1,2,3,4,8,12,13) ";
		 sql+=" and contractno in (select code from order_contract where  state<>3 and sectionname='"+region+"')";
		 sql+=" and  convert(char(10),f.Gather_Date,120)='"+skdate+"'";
		 double sk=0;
		 
		  rs=ViewBean1.executeQuery(sql);//读取实际收到首期款
	      while (rs.next())sk+=rs.getDouble("money");
		  rs.close();
		  skhj+=sk;
	   dayhj+=sk;
	   %>
    <td width="10%"><%=FormatD.getFloat2(sk,2) %></td>
   <%} %>
 
    <td width="10%"><%=FormatD.getFloat2(skhj,2) %></td>
     <%
	 skhj=0;
	 for (int aaa=0;aaa<arr;aaa++){ 
       String region=(String)list1.get(aaa); 
	   
	     String sql="select sum(f.FactMonye) money from FactAjCharges f";
	 
		 sql+=" where contractno in (select code from order_contract where state=2  and  sectionname='"+region+"')";
		 sql+=" and  convert(char(10),f.FactDate,120)='"+skdate+"'";
		 double ajk=0;
		  rs=ViewBean1.executeQuery(sql);//读取实际收到首期款
	      while (rs.next())ajk+=rs.getDouble("money");
		  rs.close();
	    skhj+=ajk;
		  dayhj+=ajk;
	   %>
    <td width="10%"><%=FormatD.getFloat2(ajk,2) %></td>
   <%} %>
      <td width="10%"><%=FormatD.getFloat2(skhj,2) %></td>
	   <td width="10%"><%=FormatD.getFloat2(dayhj,2) %></td>
  </tr>
  <%} %>
  
  
 <tr align="center">
  <td width="12%">合计</td>
   <%
   skhj=0;
   double zj=0;
   for (int aa=0;aa<arr;aa++){ 
   
         String region=(String)list1.get(aa); 
	     String sql="select sum(f.factmoney*f.currrate) money from factGatheringRecord f";
		 sql+=" where f.Period in(0,1,2,3,4,8,12,13) ";
		 sql+=" and contractno in (select code from order_contract where state<>3 and  sectionname='"+region+"')";
		  sql+=" and convert(char(10),Gather_Date,120)>='"+dates+"' and convert(char(10),Gather_Date,120)<='"+dates1+"'";
		 
		 double sk=0;
		  rs=ViewBean1.executeQuery(sql);//读取实际收到首期款
	      if (rs.next())sk+=rs.getDouble("money");
		  rs.close();
		  skhj+=sk;
	   
	   %>
    <td width="10%"><%=FormatD.getFloat2(sk,2) %></td>
   <%} %>
 
    <td width="10%"><%=FormatD.getFloat2(skhj,2) %></td>
     <%
	 zj+=skhj;
	 skhj=0;
	 for (int aaa=0;aaa<arr;aaa++){ 
       String region=(String)list1.get(aaa); 
	   
	     String sql="select sum(f.FactMonye) money from FactAjCharges f";
	 
		 sql+=" where contractno in (select code from order_contract where state=2 and sectionname='"+region+"')";
		  sql+=" and convert(char(10),FactDate,120)>='"+dates+"' and convert(char(10),FactDate,120)<='"+dates1+"'";
		
		 double ajk=0;
		  rs=ViewBean1.executeQuery(sql);//读取实际收到首期款
	      while (rs.next())ajk+=rs.getDouble("money");
		  rs.close();
	    skhj+=ajk;
	   %>
    <td width="10%"><%=FormatD.getFloat2(ajk,2) %></td>
   <%}  zj+=skhj;%>
      <td width="10%"><%=FormatD.getFloat2(skhj,2) %></td>
	   <td width="10%"><%=FormatD.getFloat2(zj,2) %></td>
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
</body>
</html>
