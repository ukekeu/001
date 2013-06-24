 
 

 <%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<jsp:useBean id="ViewBean1" scope="page"  class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean2" scope="page"  class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean3" scope="page"  class="ConnDatabase.SDatabase"/>
<jsp:useBean id="df1" scope="page" class="FormatData.FormatData" />
<jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/><!--模块权限check-->
 
<%@ include file="../public_js/getByteOut.jsp"%>
 

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script src="js/mad.js"> </script>
<script language="JavaScript" src='../public_js/menu.js'></script>
</head><script language="javascript" src="../public_js/public.js">
</script>

<script>

  function submitForm(){
    
  
  }
  

</script>
<body>
<form name=frm>
<input type=hidden name=SecNo>
<input type=hidden name=Loft>
<input type=hidden name=SecName>
<input type=hidden name=Build>
<input type=hidden name=choose> 
   <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
  <DIV align=center id="printdiv">
<input type="button" name="Button" title="打印之前请关闭左边楼栋树" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
  <input type="button" name="Button1" value="导出到EXCEL" onClick="bringToExcel();">

 </div><div  id=report1 >
<%@ include file="../public_js/CheckSection.jsp"%>

<%  
 
	String LoftSql="";
 
	ResultSet rsuptown=null;
	 
	LoftSql="select SerialNo,Name FROM CRM_Project "+FindWhere+" group by  Name,SerialNo order by name";
	 rsuptown=ViewBean3.executeQuery(LoftSql);
	 while (rsuptown.next()){
	   SecNo=rsuptown.getString("SerialNo");
	   out.print("<p  align='center'> <font size=3>"+rsuptown.getString("Name")+"</font></p>");
  %> 
  
  

<table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
    <tr  align="center" > 
     
	  <td width="4%"  >栋号</td>
      <TD width="10%">可售面积M2</td>
	  <td width="8%">可售套数</td>
	  <td width="10%">已售面积M2</td>
	  <td width="8%">已售套数</td>
	  <td width="10%">未售面积M2</td>
	  <td width="8%">未售套数</td>
	  <td width="12%">预计回笼(元)</td>

    </tr>
    <%
String SectionNo="";
String SecName="";
String Building="";
String maxFloor="";
String minFloor="";
String maxRoom="";
String minRoom="";
String Loft=""; 

String sql="select Loft from sectiontree where SerialNo='"+SecNo+"' group by Loft";
ResultSet rs3=ViewBean2.executeQuery(sql);
int ii=0;
while (rs3.next()){
   Loft=getbyte(rs3.getString("Loft"));  
   sql="select * from sectiontree where SerialNo='"+SecNo+"' and Loft='"+Loft+"'";
   ii++;
 %> 
  <tr  align="center"   > 
  
	   <td  width="8%" ><a href="#" onclick="openwin1('../sale/show_sale_list.jsp?SecNo=<%=SecNo %>&Loft=<%=Loft %>',700,450,100,100);"><%=Loft %></a></td>
	 
     
	<%
	String count="select salestate,count(*) as num,sum(area) as area from room where  seccode='"+SecNo+"' and  Loft='"+Loft+"' group by salestate ";
	int coun=0;
	double sumarea=0;
	int i=0;
	ResultSet rs2=ViewBean1.executeQuery(count);
	while  (rs2.next()){
	     i++;
		 coun+=rs2.getInt("num");
		 sumarea+=rs2.getDouble("area");
	}	 
	rs2.close();
	double ArryArea[]=new double[i];
	int ArryCount[]=new int[i];
	double ArryMoney[]=new double[i];
	String ArryState[]=new String[i];
	String CountSql="select salestate,count(*) as num,sum(area) as area,sum(sumprice) as sumprice from room  where seccode='"+SecNo+"'   and Loft='"+Loft+"'  group by salestate  ";
	ResultSet rs1=null;
	 try{
	   rs1=ViewBean1.executeQuery(CountSql);
	 }catch(Exception s){out.print("执行出错！原因如下：");out.println(s.getMessage());out.close();}
	 i=0;
	 //把数据临时写入arry，
    while (rs1.next()){
	 ArryState[i]=rs1.getString("salestate");
	 ArryCount[i]=rs1.getInt("num");
	 ArryArea[i]=rs1.getDouble("area");
	 ArryMoney[i]=rs1.getDouble("sumprice");
	 i++;
	}
	rs1.close();
	int SaleNum=0;
	double money=0;
	int NoSaleNum=0;
	double SaleArea=0;
	double NoSale=0;
	//累计已销售及未售面积
	for (int j=0;j<i;j++){
	  if (ArryState[j].equals("1")||ArryState[j].equals("5")){NoSale+=ArryArea[j];NoSaleNum+=ArryCount[j];money+=ArryMoney[j];}
      if (ArryState[j].equals("3")||ArryState[j].equals("2")){SaleArea+=ArryArea[j];SaleNum+=ArryCount[j];}
	}
	 %>
	<td width="10%" align=left>&nbsp;<%=df1.getFloat2(sumarea,2) %> </td><td width="8%" align=left>&nbsp;<%=coun %></td><td width="10%" align=left>&nbsp;<%=df1.getFloat2(SaleArea,2) %></td><td width="8%" align=left>&nbsp;<%=SaleNum %></td><td width="10%" align=left>&nbsp;<%=df1.getFloat2(NoSale,2) %></td><td width="8%" align=left>&nbsp;<%=NoSaleNum %></td><td width="12%" align=left>&nbsp;<%=df1.getFloat2(money,2) %></td>
    
	</tr>
    <%

}rs3.close();
%> 
<%String CountSql="select count(*) as num,sum(area) as area,sum(sumprice) as sumprice,sum(sumprice)/sum(area) avg  from room  where seccode='"+SecNo+"' ";
 String sumnum="";
 String sumarea="";
 String sumprice="";
 String avg="";
  rs3=ViewBean2.executeQuery(CountSql);

if (rs3.next()){sumnum=rs3.getString("num");sumarea=df1.getFloat1(rs3.getFloat("area"),2);sumprice=df1.getFloat2(rs3.getDouble("sumprice"),2);avg=df1.getFloat1(rs3.getFloat("avg"),2);}
rs3.close();
%>
</table>
<br>
<table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
    <tr   align="center" > 

 <td>可售合计：</td>
<td>总套数：<%=sumnum %></td><td>可售面积：<%=sumarea %></td><td>可售金额：<%=sumprice %></td><td>可售均价：<%=avg %></td>
</tr>

 
<%  CountSql="select count(*) as num,sum(area) as area,sum(sumprice) as sumprice,sum(sumprice)/sum(area) avg from room  where seccode='"+SecNo+"' and salestate=1";
   sumnum="";
     sumarea="";
   sumprice="";
   avg="";
  rs3=ViewBean2.executeQuery(CountSql);

if (rs3.next()){sumnum=rs3.getString("num");sumarea=df1.getFloat1(rs3.getFloat("area"),2);sumprice=df1.getFloat2(rs3.getDouble("sumprice"),2);avg=df1.getFloat1(rs3.getFloat("avg"),2);}
rs3.close();
%> 
    <tr   align="center" > 

 <td>未售合计：</td>
<td>未售套数：<%=sumnum %></td><td>未售面积：<%=sumarea %></td><td>未售金额：<%=sumprice %></td><td>未售均价：<%=avg %></td>
</tr>  

<%  CountSql="select count(*) as num,sum(jzarea) as area,sum(rmbprice) as sumprice,sum(rmbprice)/sum(jzarea) avg from order_contract  where section='"+SecNo+"' and state<>3";
   sumnum="";
     sumarea="";
   sumprice="";
   avg="";
  rs3=ViewBean2.executeQuery(CountSql);

if (rs3.next()){sumnum=rs3.getString("num");sumarea=df1.getFloat1(rs3.getFloat("area"),2);sumprice=df1.getFloat2(rs3.getDouble("sumprice"),2);avg=df1.getFloat1(rs3.getFloat("avg"),2);}
rs3.close();
%>
  <tr  align="center" > 

 <td>已售合计：</td>
<td>已售套数：<%=sumnum %></td><td>已售面积：<%=sumarea %></td><td>已售金额：<%=sumprice %></td><td>销售均价：<%=avg %></td>
</tr>
</table>
　<%}rsuptown.close(); %>
 </form>
 
</center>
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
