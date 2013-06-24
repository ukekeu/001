<%@ page contentType="text/html;charset=GBK" %>

 
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 
<title>佣金明细表</title>
 
</head>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/checktime.jsp"%>
 
<% 
 
 
 
  String stdate = China.getParameter(request,"Date1") ;
  String endate = China.getParameter(request,"Date2") ;
  String SectionName=China.getParameter(request,"SecNo") ; 
   SectionName=SectionName.substring(0,SectionName.indexOf("-"));
  String Region = China.getParameter(request,"Region") ; 
   String room=getbyte1(request.getParameter("room"));
  String Loft=getbyte1(request.getParameter("Loft"));
  String yong_tu=getbyte1(request.getParameter("yong_tu"));
String saletype=getbyte1(request.getParameter("saletype"));
if (saletype.equals("1"))saletype=" and a.state=1";
else if (saletype.equals("2"))saletype=" and a.state=2";
else if (saletype.equals("0"))saletype=" ";
   String sql=""; 
   ResultSet rs1=null;
	ResultSet rs=null;
	double yjRate=0;
   rs1 = ViewBean1.executeQuery("select *  from commision_scale where  section_no='"+SectionName+"'") ; 
if (rs1.next()){
  yjRate=rs1.getDouble("scale")/1000;
  
}
rs1.close(); 
 
   sql="select    a.*,b.cus_name from order_contract a,customer b  where a.customer=b.serialno and   a.seller <>'' and convert(char(10),a.date,120)<='"+endate+"'  and a.state<>3  and a.section='"+SectionName+"' "+saletype;
    if (!Loft.equals(""))
	  sql+=" and a.loft='"+Loft+"' ";
	   if (!room.equals(""))
	  sql+=" and a.Room_no='"+room+"'";
	    if (!yong_tu.equals(""))
	  sql+=" and a.yong_tu='"+yong_tu+"'";
	 // sql+=" and a.seller in ('彭启香、黄','吴娟')";
  sql+=" order by a.seller,a.loft,a.floors,a.room_no";
  
   int nn=0;
   double sump=0;
   double suma=0;
   double suml=0;
  double sum2=0;
   double sum3=0;
   double sum4=0;
   double sum5=0;
 %>


  
<body>
<form action="rgsview.jsp" method="post" name="frm">
  	<DIV align=center id="printdiv">
 <input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" name="Button1" value="导出到EXCEL" onClick="bringToExcel();">
<br>
<table><tr><td>导入前必须进行相应设置：</td></tr>
<tr><td>　1.在IE工具栏中选择"internet选项"</td></tr>
<tr><td>　2.选择"安全"->选择"本地intranet"后再点击"自定义级别"</td></tr>
<tr><td>　3.把所有ActiveX启用都选中后点击确认退后。</td></tr>
</table>
 
 
 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<div align=left id=report1 style="background-color:#F7F7F7;height:100%px;overflow:auto;width:100%;z-index:2" contentEditable >
<div id=tit align="center"> 佣金计算明细表  </div>
    
 <table width="99%"><tr><td colspan="3">时间段:<%=China.getParameter(request,"Date1")%>到<%=China.getParameter(request,"Date2") %></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></table>
 
 <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

 <tr  > 
<td  align="right">序号</td>
 <td  align="center">销售员</td> 
<td  align="center">房间代码</td>
 
 
<td  align="center">成交总价</td>
 
<td  align="center">提成比例</td> 
<td  align="center" >累计收款金额</td> 
<td  align="center" >本期收款金额</td> 
<td  align="center" >本期佣金</td> 
	<%
	String sell="";
	 
	try{
		 
	rs=ViewBean.executeQuery(sql);
	 
	 
	int i=0;
    double  sumarea=0;
    int sumsalek=0;
	double ljsk=0;
	double bqsk=0;
	
   while (rs.next()){
	 i++;
	 String seller=getbyte(rs.getString("seller"));
	 String code  =getbyte(rs.getString("code"));
     String sectionname =getbyte(rs.getString("sectionname"));
      room=getbyte(rs.getString("loft"))+getbyte(rs.getString("room_no"));
	 
     String jzarea=FormtD.getFloat(rs.getFloat("jzarea"),3);
	 String payment =getbyte(rs.getString("payment1"));
	 String unitprice=FormtD.getFloat2(rs.getDouble("unitprice"),2);
	 String sumprice=FormtD.getFloat2(rs.getDouble("rmbprice"),2);
	 
	 String rg_date=rs.getDate("date").toString(); 
	 
   
  
  if (sell.equals(""))sell=seller;
	else if  (!sell.equals(seller)){
	
	%>  
	<tr align="right">
	<td ><b>小计：</b></td>
	 
		<td  >&nbsp;</td>
			<td  >&nbsp;</td>
				<td  ><b><%=sumsalek %></b></td>
	<td  ><b><%=FormtD.getFloat2(yjRate,4) %></b></td>
	<td  ><b><%=FormtD.getFloat2(ljsk,2)%></b></td>
	<td  ><b><%=FormtD.getFloat2(bqsk,2) %></b></td>
    <td  ><b><%=FormtD.getFloat2(bqsk*yjRate,0) %></b></td>
	</tr>
	<% 
	  sumarea=0;
      sumsalek=0;
	  ljsk=0;
      bqsk=0;
	  sell=seller;
	}
	   sumsalek+=rs.getInt("rmbprice");
	   sumarea+=rs.getDouble("jzarea");
   %>
 <tr   align="center">
<td   align="center"><%=i %></td>
<td  align="left">&nbsp;<%=seller %></td>
 <td  align="left">&nbsp;<%=sectionname+room %></td>
 
 
<td  align="right">&nbsp;<%=sumprice %></td>
 
<td  align="right">&nbsp;<%=request.getParameter("yjbl"+String.valueOf(i)) %></td> 
<td>
<%sql="select sum(factmoney*currrate) as factmoney from factgatheringrecord where     convert(char(10),Gather_Date,120)<='"+endate+"' and contractno="+code;
 rs1=ViewBean1.executeQuery(sql);
 double money1=0;
while (rs1.next()){
  money1+=rs1.getDouble("factmoney");
}
rs1.close();
sql="select sum(factmonye) as factmoney from FactAjCharges where    convert(char(10),factdate,120)<='"+endate+"' and contractno="+code;
 rs1=ViewBean1.executeQuery(sql);
 while (rs1.next()){
    money1+=rs1.getDouble("factmoney");
}
rs1.close(); 
out.print(FormtD.getFloat2(money1,2));
ljsk+=money1;
%>
</td>
<td  align="right"  valign="bottom">
<%
sql="select sum(factmoney*currrate) as factmoney from factgatheringrecord where   convert(char(10),Gather_Date,120)>='"+stdate+"' and convert(char(10),Gather_Date,120)<='"+endate+"' and contractno="+code;
 rs1=ViewBean1.executeQuery(sql);
   money1=0;
while (rs1.next()){
  money1+=rs1.getDouble("factmoney");
}
rs1.close();
sql="select sum(factmonye) as factmoney from FactAjCharges where  convert(char(10),factdate,120)>='"+stdate+"' and convert(char(10),factdate,120)<='"+endate+"' and contractno="+code;
 rs1=ViewBean1.executeQuery(sql);
 while (rs1.next()){
    money1+=rs1.getDouble("factmoney");
}
rs1.close();
 out.print(FormtD.getFloat2(money1,2));
bqsk+=money1;
 %>
 
 </td> 
 <td> <%=request.getParameter("yj"+String.valueOf(i)) %></td>
</tr> 
 <%
 }
rs.close();  
%>
<tr align="right">
	<td ><b>小计：</b></td>
	 
		<td  >&nbsp;</td>
			<td  >&nbsp;</td>
				<td  ><b><%=sumsalek %></b></td>
	<td  ><b><%=FormtD.getFloat2(yjRate,4) %></b></td>
	<td  ><b><%=FormtD.getFloat2(ljsk,2)%></b></td>
	<td  ><b><%=FormtD.getFloat2(bqsk,2) %></b></td>
    <td  ><b><%=FormtD.getFloat2(bqsk*yjRate,0) %></b></td>
	</tr>
 </table> 
  </div>
 
 
  <%
}catch(Exception s){out.print(s.getMessage()+sql);out.close();}
  %>
 
 
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
