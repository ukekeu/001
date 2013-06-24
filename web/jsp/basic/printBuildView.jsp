<%@ page contentType="text/html;charset=GBK" %><!--页显示中文编码-->
<%@ include file="../public_js/checktime.jsp"%><!--系统使用时间check-->
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<STYLE type=text/css>
BODY {
	FONT-SIZE: 15pt; LINE-HEIGHT: 10pt; FONT-FAMILY: 宋体
}
tr {
	FONT-SIZE: 10pt; HEIGHT: 20pt; FONT-FAMILY: 宋体
}
</STYLE>
<title>楼栋查询</title>
</head>
<%@ page language="java" import="java.sql.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/> <!--数据库操作class-->
<jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/><!--模块权限check-->
<%@ include file="../public_js/getByteOut.jsp"%><!--编码转换function-->

 

<body >

<%
  java.text.DecimalFormat df1 = new java.text.DecimalFormat("###,###,###.##"); 
	
  String SecNo=request.getParameter("SecNo");
  String SecNa=request.getParameter("SecNa");
 %>
<script language="javascript" src="../public_js/public.js">
</script>
<form method="POST" name="cus" action="">
 <DIV align=center id="printdiv">
注意:在打印之前必须设置纸张及距，在菜单"文件"中选择"页面设置",<br><br>选择纸张类型"a4",方向选择"纵向",边距"左为10"，上为"15"，
  <!--<input class="buttoninput" type="button" value="打印预览" onclick="window.printdiv.style.display='none';factory.printing.Preview();"> -->
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
  <center>
    <p align="center"><b><font size="3" class=FontColor><%=request.getParameter("SecNa") %></font></b></p>
	
  <table width="98%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
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
  <tr  align="center" > 
  
	   <td  width="8%" ><%=Loft %></td>
	 
	<%
	String count="select salestate,count(*) as num,sum(area) as area from room where  seccode='"+SecNo+"' and  Loft='"+Loft+"' group by salestate ";
	int coun=0;
	float sumarea=0;
	int i=0;
	ResultSet rs2=ViewBean1.executeQuery(count);
	while  (rs2.next()){
	     i++;
		 coun+=rs2.getInt("num");
		 sumarea+=rs2.getFloat("area");
	}	 
	rs2.close();
	float ArryArea[]=new float[i];
	int ArryCount[]=new int[i];
	float ArryMoney[]=new float[i];
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
	 ArryArea[i]=rs1.getFloat("area");
	 ArryMoney[i]=rs1.getFloat("sumprice");
	 i++;
	}
	rs1.close();
	int SaleNum=0;
	float money=0;
	int NoSaleNum=0;
	float SaleArea=0;
	float NoSale=0;
	//累计已销售及未售面积
	for (int j=0;j<i;j++){
	  if (ArryState[j].equals("1")||ArryState[j].equals("5")){NoSale+=ArryArea[j];NoSaleNum+=ArryCount[j];money+=ArryMoney[j];}
      if (ArryState[j].equals("3")||ArryState[j].equals("2")){SaleArea+=ArryArea[j];SaleNum+=ArryCount[j];}
	}
	 %>
	<td width="10%" align=left>&nbsp;<%=df1.format(sumarea) %> </td><td width="8%" align=left>&nbsp;<%=coun %></td><td width="10%" align=left>&nbsp;<%=df1.format(SaleArea) %></td><td width="8%" align=left>&nbsp;<%=SaleNum %></td><td width="10%" align=left>&nbsp;<%=df1.format(NoSale) %></td><td width="8%" align=left>&nbsp;<%=NoSaleNum %></td><td width="12%" align=left>&nbsp;<%=df1.format(money) %></td>
    
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

if (rs3.next()){sumnum=rs3.getString("num");sumarea=df1.format(rs3.getFloat("area"));sumprice=df1.format(rs3.getFloat("sumprice"));avg=df1.format(rs3.getFloat("avg"));}
rs3.close();
%>
</table>
<br>
 <table width="98%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

    <tr  align="center" > 

 <td>可售合计：</td>
<td>总套数：<%=sumnum %></td><td>可售面积：<%=sumarea %></td><td>可售金额：<%=sumprice %></td><td>可售均价：<%=avg %></td>
</tr>

 
<%  CountSql="select count(*) as num,sum(area) as area,sum(sumprice) as sumprice,sum(sumprice)/sum(area) avg from room  where seccode='"+SecNo+"' and salestate=1";
   sumnum="";
     sumarea="";
   sumprice="";
   avg="";
  rs3=ViewBean2.executeQuery(CountSql);

if (rs3.next()){sumnum=rs3.getString("num");sumarea=df1.format(rs3.getFloat("area"));sumprice=df1.format(rs3.getFloat("sumprice"));avg=df1.format(rs3.getFloat("avg"));}
rs3.close();
%>
 
    <tr align="center" > 

 <td>未售合计：</td>
<td>未售套数：<%=sumnum %></td><td>未售面积：<%=sumarea %></td><td>未售金额：<%=sumprice %></td><td>未售均价：<%=avg %></td>
</tr>  

<%  CountSql="select count(*) as num,sum(jzarea) as area,sum(rmbprice) as sumprice,sum(rmbprice)/sum(jzarea) avg from order_contract  where section='"+SecNo+"' and state<>3";
   sumnum="";
     sumarea="";
   sumprice="";
   avg="";
  rs3=ViewBean2.executeQuery(CountSql);

if (rs3.next()){sumnum=rs3.getString("num");sumarea=df1.format(rs3.getFloat("area"));sumprice=df1.format(rs3.getFloat("sumprice"));avg=df1.format(rs3.getFloat("avg"));}
rs3.close();
%>
  <tr align="center" > 

 <td>已售合计：</td>
<td>已售套数：<%=sumnum %></td><td>已售面积：<%=sumarea %></td><td>已售金额：<%=sumprice %></td><td>销售均价：<%=avg %></td>
</tr>
</table>
　
</body>
</form>
</html>