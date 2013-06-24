 
 

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
</head>
<script language="javascript" src="../public_js/public.js">
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
	String SecNa ="";
	LoftSql="select SerialNo,Name FROM CRM_Project "+FindWhere+" group by  Name,SerialNo order by name";
	 rsuptown=ViewBean3.executeQuery(LoftSql);
	 while (rsuptown.next()){
	   SecNo=rsuptown.getString("SerialNo");
	   SecNa =rsuptown.getString("Name");
	   out.print("<p  align='center'> <font size=3>"+SecNa+"</font></p>");
  %> 
  
  
<table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
    <tr align="center" > 
     
	  <td width="4%"  >栋号</font></td>
      <TD width="10%">可售面积M2</font></td>
	  <td width="6%">可售套数</font></td>
	  <td width="10%">认购面积M2</font></td>
	  <td width="6%">认购套数</font></td>
	    <td width="10%">签约面积M2</font></td>
	  <td width="6%">签约套数</font></td>
	    <td width="10%">临定面积M2</font></td>
	  <td width="6%">临定套数</font></td>
	  
	  <td width="10%">未售面积M2</font></td>
	  <td width="6%">未售套数</font></td>
	  <td width="12%">预计回笼(元)</font></td>

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
  <tr  align="center"  > 
  
	   <td  width="8%" ><%=Loft %></td>
	   <td colspan=18> 
	    
	  
	<table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center >
	<tr  id=TR<%=ii %>   align="center" onclick="savepara('<%=SecNa %>','<%=SecNo%>','<%=Loft%>','<%=Building%>');changeclass1(this,'clickbg','listcontent');">
 
     
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
	int rgnum=0;
	double rgarea=0;
	int ldnum=0;
	double ldarea=0;
	//累计已销售及未售面积
	for (int j=0;j<i;j++){
	  if (ArryState[j].equals("1")||ArryState[j].equals("4")){NoSale+=ArryArea[j];NoSaleNum+=ArryCount[j];money+=ArryMoney[j];}
      if (ArryState[j].equals("3")){SaleArea+=ArryArea[j];SaleNum+=ArryCount[j];}
	   if (ArryState[j].equals("2")){rgarea+=ArryArea[j];rgnum+=ArryCount[j];}
	    if (ArryState[j].equals("5")){ldarea+=ArryArea[j];ldnum+=ArryCount[j];}
	}
	 %>
	<td width="10%" align=left>&nbsp;<%=df1.getFloat2(sumarea,2) %> </td><td width="6%" align=left>&nbsp;<%=coun %></td><td width="10%" align=left>&nbsp;<%=df1.getFloat2(rgarea,2) %></td><td width="6%" align=left>&nbsp;<%=rgnum %></td><td width="10%" align=left>&nbsp;<%=df1.getFloat2(SaleArea,2) %></td><td width="6%" align=left>&nbsp;<%=SaleNum %></td><td width="10%" align=left>&nbsp;<%=df1.getFloat2(ldarea,2) %></td><td width="6%" align=left>&nbsp;<%=ldnum %></td><td width="10%" align=left>&nbsp;<%=df1.getFloat2(NoSale,2) %></td><td width="6%" align=left>&nbsp;<%=NoSaleNum %></td><td width="12%" align=left>&nbsp;<%=df1.getFloat2(money,2) %></td>
   </tr> 
   </table>
	 
	</td>
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
    <tr align="center" > 

 <td>可售合计：</td>
<td>总套数：<%=sumnum %></td><td>可售面积：<%=sumarea %></td><td>可售金额：<%=sumprice %></td><td>可售均价：<%=avg %></td>
</tr>

 
<%  CountSql="select count(*) as num,sum(area) as area,sum(sumprice) as sumprice,sum(sumprice)/sum(area) avg from room  where seccode='"+SecNo+"' and (salestate=1 or salestate=4) ";
   sumnum="";
     sumarea="";
   sumprice="";
   avg="";
  rs3=ViewBean2.executeQuery(CountSql);

if (rs3.next()){sumnum=rs3.getString("num");sumarea=df1.getFloat1(rs3.getFloat("area"),2);sumprice=df1.getFloat2(rs3.getDouble("sumprice"),2);avg=df1.getFloat1(rs3.getFloat("avg"),2);}
rs3.close();
%>
 
    <tr  align="center" > 

 <td>未售合计：</td>
<td>未售套数：<%=sumnum %></td><td>未售面积：<%=sumarea %></td><td>未售金额：<%=sumprice %></td><td>未售均价：<%=avg %></td>
</tr>  

<%  CountSql="select count(*) as num,sum(area) as area,sum(sumprice) as sumprice,sum(sumprice)/sum(area) avg from room  where seccode='"+SecNo+"' and (salestate=5) ";
   sumnum="";
     sumarea="";
   sumprice="";
   avg="";
  rs3=ViewBean2.executeQuery(CountSql);

if (rs3.next()){sumnum=rs3.getString("num");sumarea=df1.getFloat1(rs3.getFloat("area"),2);sumprice=df1.getFloat2(rs3.getDouble("sumprice"),2);avg=df1.getFloat1(rs3.getFloat("avg"),2);}
rs3.close();
%>
 
    <tr align="center" > 

 <td>临定合计：</td>
<td>临定套数：<%=sumnum %></td><td>临定面积：<%=sumarea %></td><td>临定金额：<%=sumprice %></td><td>临定均价：<%=avg %></td>
</tr>  
<%  CountSql="select count(*) as num,sum(jzarea) as area,sum(rmbprice) as sumprice,sum(rmbprice)/sum(jzarea) avg from order_contract  where section='"+SecNo+"' and state=1";
   sumnum="";
     sumarea="";
   sumprice="";
   avg="";
  rs3=ViewBean2.executeQuery(CountSql);

if (rs3.next()){sumnum=rs3.getString("num");sumarea=df1.getFloat1(rs3.getFloat("area"),2);sumprice=df1.getFloat2(rs3.getDouble("sumprice"),2);avg=df1.getFloat1(rs3.getFloat("avg"),2);}
rs3.close();
%>
  <tr  align="center" > 

 <td>认购合计：</td>
<td>认购套数：<%=sumnum %></td><td>认购面积：<%=sumarea %></td><td>认购金额：<%=sumprice %></td><td>认购均价：<%=avg %></td>
</tr>
<%  CountSql="select count(*) as num,sum(jzarea) as area,sum(rmbprice) as sumprice,sum(rmbprice)/sum(jzarea) avg from order_contract  where section='"+SecNo+"' and state=2";
   sumnum="";
     sumarea="";
   sumprice="";
   avg="";
  rs3=ViewBean2.executeQuery(CountSql);

if (rs3.next()){sumnum=rs3.getString("num");sumarea=df1.getFloat1(rs3.getFloat("area"),2);sumprice=df1.getFloat2(rs3.getDouble("sumprice"),2);avg=df1.getFloat1(rs3.getFloat("avg"),2);}
rs3.close();
%>
  <tr align="center" > 

 <td>签约合计：</td>
<td>签约套数：<%=sumnum %></td><td>签约面积：<%=sumarea %></td><td>签约金额：<%=sumprice %></td><td>签约均价：<%=avg %></td>
</tr>
</table>
　<%}rsuptown.close(); %>
 </form>
  <%ViewBean1.closeConn(); 
  ViewBean3.closeConn(); 
  ViewBean2.closeConn(); 
        %>
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
