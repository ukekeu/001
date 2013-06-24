<%@ page contentType="text/html;charset=GBK" %>

 
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 
<title>销售员销售明细表</title>
 
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
  String Region = China.getParameter(request,"Region") ; 
   String room=getbyte1(request.getParameter("room"));
  String Loft=getbyte1(request.getParameter("Loft"));
  String yong_tu=getbyte1(request.getParameter("yong_tu"));
String saletype=getbyte1(request.getParameter("saletype"));
String job=(String)session.getAttribute("job");	
	 if (job.indexOf("销售员")>=0){
	    job=" and a.seller like '%"+(String)session.getAttribute("loginname")+"%'";
  }else{job="";}
if (saletype.equals("1"))saletype=" and  convert(char(10),date,120)>='"+stdate+"' and convert(char(10),date,120)<='"+endate+"' and state=1 ";
else if (saletype.equals("2"))saletype=" and convert(char(10),visadate,120)>='"+stdate+"' and convert(char(10),visadate,120)<='"+endate+"' and state=2";
else if (saletype.equals("0"))saletype=" and  convert(char(10),date,120)>='"+stdate+"' and convert(char(10),date,120)<='"+endate+"'";

   String sql=""; 
   sql="select    a.rmbprice-a.ajmoney firstmoney,a.*,b.cus_name,b.phone + b.sj phone from order_contract a,customer b where a.customer=b.serialno and a.state<>3   and a.section='"+SectionName+"' "+saletype;
    if (!Loft.equals(""))
	  sql+=" and loft='"+Loft+"' ";
	   if (!room.equals(""))
	  sql+=" and Room_no='"+room+"'";
	    if (!yong_tu.equals(""))
	  sql+=" and yong_tu='"+yong_tu+"'";
	  sql+=job;
  sql+=" order by loft,floors,room_no";
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
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>

  
<div align=left id=report1 >
 <font size=3><div id=tit align="center"><%if (getbyte1(request.getParameter("saletype")).equals("1")){out.print("认购明细统计表");}else if (getbyte1(request.getParameter("saletype")).equals("2")){out.print("签约明细统计表");}else{out.print("认购/签约明细统计表");} %>  </div></font>
 
 <table width="99%"><tr><td colspan="3">时间段:<%=China.getParameter(request,"Date1")%>到<%=China.getParameter(request,"Date2") %></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></table>
 
 <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

 <tr  > 
<td  align="right">序号</td>
 <td  align="center">状态</td>
<td  align="center">房间代码</td>
<td  align="center">客户姓名</td>
<td  align="center">联系方式</td>
<td align="center">面积</td>
<td w align="center">付款方式</td>

<td  align="center">成交单价</td>
<td  align="center">成交总价</td>

<td  align="center">按揭金额</td>
<td  align="center">首期款</td>
 <td  align="center">认购日期</td>
 

<td  align="center">签约日期</td>
<td  align="center">放款日期</td>
<td  align="center">欠首期</td>
<!--<td  align="center">花园面积</td>
  <td  align="center">花园款</td>
<td  align="center">露台面积</td>
<td  align="center">露台款</td>
<td  align="center">屋面面积</td>--> 

 
 <td  align="center">销售员</td>
<td  align="center">备  注</td>
	<%
	ResultSet rs=null;
	ResultSet rs1=null;
	try{
 
	rs=ViewBean.executeQuery(sql);
	 
	 
	int i=0;
 
   while (rs.next()){
	 i++;
	  
     String sectionname =getbyte(rs.getString("sectionname"));
      room=getbyte(rs.getString("loft"))+getbyte(rs.getString("room_no"));
     String jzarea=rs.getString("jzarea");
	 String payment =getbyte(rs.getString("payment1"));
	 String unitprice=FormtD.getFloat2(rs.getDouble("unitprice"),2);
	 String sumprice=FormtD.getFloat2(rs.getDouble("rmbprice"),2);
	  float lta=rs.getFloat("lu_tai_area");
	 float ltp=rs.getFloat("lu_tai_area_price");
	 String lu_tai_area=FormtD.getFloat(lta,3);
	 String lt_price=FormtD.getFloat(ltp*lta,3);
	 float tya=rs.getFloat("ty_area");
	 float typ=rs.getFloat("ty_area_price");
	 String ty_area=FormtD.getFloat(tya,3);
	
	 String ty_price=FormtD.getFloat(tya*typ,3);
	 
	 String wd_area=FormtD.getFloat(rs.getFloat("wd_area"),3);
	 String phone=getbyte(rs.getString("phone"));
	 String rg_date="",ContractNo="",ht_date="",firstmoney="";
	    rg_date=rs.getDate("date").toString(); 
	   
	  ht_date=getbyte(rs.getString("visadate"));
	   firstmoney=getbyte(rs.getString("firstmoney"));
	  if (!ht_date.equals(""))ht_date=ht_date.substring(0,10);
	 String context =getbyte(rs.getString("note"));
	  String seller =getbyte(rs.getString("seller"));
	   String cus_name =getbyte(rs.getString("cus_name"));
	    String ajk =getbyte(rs.getString("ajmoney"));
		String fk_date=getbyte(rs.getString("fkdate"));
	 double yk=0;
	  if (!fk_date.equals(""))fk_date=fk_date.substring(0,10);
     sql="select   sum(factmoney*CurrRate) money from factGatheringRecord where contractno = " +rs.getString("code");
	 rs1=ViewBean1.executeQuery(sql);
	 
	 if (rs1.next())
	   yk=rs1.getDouble("money");
	 rs1.close();
	yk=rs.getDouble("rmbprice")-Double.parseDouble(ajk)-yk; 
  %>
 <tr   align="center">
<td   align="center"><%=i %></td>
 <td   align="left"><%if (ht_date.equals("")){out.print("认购");}else{out.print("签约");} %>　</td>
<td   align="left">&nbsp;<%=room%>　</td>
<td   align="left">&nbsp;<%=cus_name%>　</td>
<td   align="left">&nbsp;<%=phone%>　</td>

<td   align="center"><%=jzarea%>　</td>
 
<td    align="right">&nbsp;<%=payment %>　</td>
<td  align="left">&nbsp; <%=unitprice %></td>
<td  align="right"><%=sumprice %></td>
<td  align="right"><%=ajk %></td>
<td  align="right">&nbsp;<%=firstmoney %></td>
 <td  align="right">&nbsp;<%=rg_date %></td>


 

<td  align="right">&nbsp;<%=ht_date %></td>
<td  align="right">&nbsp;<%=fk_date %></td>
<td  align="right">&nbsp;<%if (yk<0){ %><font color=red><%} %><%=FormtD.getFloat2(yk,2) %><%if (yk<0){ %></font><%} %></td>
<!--<td  align="right">&nbsp;<%=ty_area %></td>
<td  align="right">&nbsp;<%=ty_price %></td>
<td  align="right">&nbsp;<%=lu_tai_area %></td>

<td  align="right">&nbsp;<%=lt_price %></td>
<td  align="right">&nbsp;<%=wd_area %></td>-->
 <td  align="right">&nbsp;<%=seller %></td>
 <td  align="right">&nbsp;<%=context %></td>
</tr> 
 <%
 }
rs.close(); 
 room=getbyte1(request.getParameter("room"));
   sql="select  payment1,count(*) num,sum(rmbprice) price,sum(jzarea) jzarea,sum(ajmoney) ajmoney,sum(lu_tai_area) lu_tai_area,sum(lu_tai_area*lu_tai_area_price) ltprice,sum(ty_area) ty_area ,sum(ty_area*ty_area_price) typrice,sum(wd_area) wd_area from order_contract where state<>3 and     section='"+SectionName+"' "+saletype;
    if (!Loft.equals(""))
	  sql+=" and loft='"+Loft+"' ";
	   if (!room.equals(""))
	  sql+=" and Room_no='"+room+"'";
	    if (!yong_tu.equals(""))
	  sql+=" and yong_tu='"+yong_tu+"'";
   sql+=" group by payment1";
   rs=ViewBean.executeQuery(sql);
  int ajmoneys=0;
  int sumnum=0;
   while (rs.next()){
   
     String payment=getbyte(rs.getString("payment1")) ;
	 int num=rs.getInt("num");
	 nn+=num;
	 double price=rs.getDouble("price");
	 double jzarea=rs.getDouble("jzarea");
	 double lu_tai_area=rs.getDouble("lu_tai_area");
	   double ltprice=rs.getDouble("ltprice");
	 double ty_area=rs.getDouble("ty_area");
	  double typrice=rs.getDouble("typrice");
	  int ajmoney	=rs.getInt("ajmoney");
	  ajmoneys+=ajmoney;
	  double wd_area=rs.getDouble("wd_area");
	 sump+=price;
	 suma+=jzarea;
	 suml+=lu_tai_area;
	 sum2+=ty_area;
	 sum3+=wd_area;
	 sum4+=ltprice;
	 sum5+=typrice;
	 sumnum+=num;
   %>
   <tr>
   <td>小计</td><td>&nbsp;</td><td>&nbsp;</td><td><%=payment%></td>
   <td><b><%=num %></b>套</td><td>&nbsp;<%=FormtD.getFloat2(jzarea,2) %></td><td>&nbsp;</td>
    <td align="right"><b><%=FormtD.getFloat2(price,2) %></b></td><td align="right">&nbsp;<b><%=ajmoney %></b></td><td>&nbsp;</td><td>&nbsp;</td> <td>&nbsp;</td> <td>&nbsp;</td>   <td>&nbsp;</td>  <td>&nbsp;</td><!-- <td align="right">&nbsp;<%=FormtD.getFloat2(ty_area,2) %></td><td align="right">&nbsp;<%=FormtD.getFloat2(typrice,2) %></td><td align="right">&nbsp;<%=FormtD.getFloat2(lu_tai_area,2) %></td><td align="right">&nbsp;<%=FormtD.getFloat2(ltprice,2) %></td>-->
   <td>&nbsp;</td>  <td>&nbsp;</td> 
   </tr>
 
  <%}%>
    <tr>
   <td>总计</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td><b><%=sumnum %></b></td>
   <td><b><%=FormtD.getFloat2(suma,2) %></b></td><td>&nbsp;</td>
    <td align="right"><b><%=FormtD.getFloat2(sump,2) %></b></td><td align="right">&nbsp;<B><%=ajmoneys %></B></td> <td>&nbsp;</td> <td>&nbsp;</td> <td>&nbsp;</td> <td>&nbsp;</td>  <td>&nbsp;</td>
		  <td>&nbsp;</td><td>&nbsp;</td>  <td>&nbsp;</td>
     
   </tr>
   
   </table>
<table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

<tr  > 
<td  align="center">序号</td>
 
<td  align="center">用途</td>
 <td  align="center">套数</td>
<td align="center">面积</td>
 
<td  align="center">成交总价</td>
 
  <%
rs.close(); 
 room=getbyte1(request.getParameter("room"));
   sql="select  yong_tu,count(*) num,sum(rmbprice) price,sum(jzarea) jzarea,sum(lu_tai_area) lu_tai_area,sum(lu_tai_area*lu_tai_area_price) ltprice,sum(ty_area) ty_area ,sum(ty_area*ty_area_price) typrice,sum(wd_area) wd_area from order_contract where state<>3   and section='"+SectionName+"' "+saletype;
    if (!Loft.equals(""))
	  sql+=" and loft='"+Loft+"' ";
	   if (!room.equals(""))
	  sql+=" and Room_no='"+room+"'";
	    if (!yong_tu.equals(""))
	  sql+=" and yong_tu='"+yong_tu+"'";
   sql+=" group by yong_tu";
   rs=ViewBean.executeQuery(sql);
 int nnn=0;
   while (rs.next()){
   
     String payment=getbyte(rs.getString("yong_tu")) ;
	 int num=rs.getInt("num");
	 nn+=num;
	 nnn++;
	 double price=rs.getDouble("price");
	 double jzarea=rs.getDouble("jzarea");
	 double lu_tai_area=rs.getDouble("lu_tai_area");
	  double ltprice=rs.getDouble("ltprice");
 double ty_area=rs.getDouble("ty_area");
	  double typrice=rs.getDouble("typrice");
	  double wd_area=rs.getDouble("wd_area");
	    
	
	 sump+=price;
	 suma+=jzarea;
	 suml+=lu_tai_area;
	 sum2+=ty_area;
	 sum3+=wd_area;
   %>
   <tr >
   <td align="center"><%=nnn %></td> <td align="center"><%=payment%></td>
   <td><b><%=num %></b>套</td>
<td align="right"><b><%=FormtD.getFloat2(jzarea,2) %></b></td> 
    <td align="right"><b><%=FormtD.getFloat2(price,2) %></b></td>
	     
   </tr>
  <%}rs.close();%>
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
<DIV align=center id="printdiv">
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
  <input type="button" onclick="bringToExcel()" value="导出到Excel"> 
<br>导入前必须进行相应设置：<br>
　1.在IE工具栏中选择"internet选项"<br>
　2.选择"安全"->选择"本地intranet"后再点击"自定义级别"<br>
  3.把所有ActiveX启用都选中后点击确认退后。<br>
 </div>
 

 
  <%
}catch(Exception s){out.print(s.getMessage()+sql);out.close();}
  %>
 
 
 
</body>
 
</html>
