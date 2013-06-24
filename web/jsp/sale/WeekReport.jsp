 
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
<title>报表</title>
</head>
<body  oncontextmenu="return false"  >
<%
String type=request.getParameter("type");
if (type==null)type="";
if (type.equals("1"))type="周报";
else type="月报";
String secName=getbyte1(request.getParameter("secName"));
String Date1=request.getParameter("Date1");
String Date2=request.getParameter("Date2");
String sectionNo=getbyte1(request.getParameter("SecNo"));
 

	
	 String up="";
	 if (Integer.parseInt(Date1.substring(Date1.indexOf("-")+1,Date1.lastIndexOf("-")))==1)up="一";
	 if (Integer.parseInt(Date1.substring(Date1.indexOf("-")+1,Date1.lastIndexOf("-")))==2)up="二";
	 if (Integer.parseInt(Date1.substring(Date1.indexOf("-")+1,Date1.lastIndexOf("-")))==3)up="三";
	 if (Integer.parseInt(Date1.substring(Date1.indexOf("-")+1,Date1.lastIndexOf("-")))==4)up="四";
	 if (Integer.parseInt(Date1.substring(Date1.indexOf("-")+1,Date1.lastIndexOf("-")))==5)up="五";
	 if (Integer.parseInt(Date1.substring(Date1.indexOf("-")+1,Date1.lastIndexOf("-")))==6)up="六";
	 if (Integer.parseInt(Date1.substring(Date1.indexOf("-")+1,Date1.lastIndexOf("-")))==7)up="七";
	 if (Integer.parseInt(Date1.substring(Date1.indexOf("-")+1,Date1.lastIndexOf("-")))==8)up="八";
	 if (Integer.parseInt(Date1.substring(Date1.indexOf("-")+1,Date1.lastIndexOf("-")))==9)up="九";
	 if (Integer.parseInt(Date1.substring(Date1.indexOf("-")+1,Date1.lastIndexOf("-")))==10)up="十";
	 if (Integer.parseInt(Date1.substring(Date1.indexOf("-")+1,Date1.lastIndexOf("-")))==11)up="十一";
	 if (Integer.parseInt(Date1.substring(Date1.indexOf("-")+1,Date1.lastIndexOf("-")))==12)up="十二"; 
 %>
 
<DIV align=center id="printdiv">
<input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'"><input type="button" onclick="bringToExcel()" value="导出到Excel"><br>

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

<table><tr><td>
第一次导入前必须进行相应设置：<br>
  1.在IE版本必须是IE5.5以上<br>
　2.在IE工具栏中选择"internet选项"<br>
　3.选择"安全"->选择"intranet"后再点击"自定义级别"<br>
  4.把所有ActiveX禁用的都选为启用。<br>
  </td></tr></table>
 </div>
  <div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable>
<object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<table width="99%" cellspacing="0" cellpadding="0">
 <tr align="center" ><td  ><b><font size=4><%=secName+up %>月销售<%=type %>表</font></b> </td></tr>
</table>

时间段:<%=Date1 %> 至<%=Date2 %> (金额：元)
 <table width="99%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF">
  
  <tr bgcolor='#EAECEC' align="center">  
    <td>楼盘名称</td>
    <td>楼号</td>
    <td>可售面积M<sup>2</sup></td>
    <td>可售套数</td>
    <td>认购面积M<sup>2</sup></td>
    <td>认购套数</td>
    <td>认购总金额</td>
    <td>累计认购<br>面积M<sup>2</sup></td>
    <td>累计认购<br>套数</td>
    <td>累计认购<br>金额</td>
    <td>已售均价</td>
    <td>销售率</td>
    <td>本周收款额</td>
    <td>累计收款额</td>
  </tr>
  <%
 try{
 if (!sectionNo.equals(""))sectionNo= " and serialno='"+sectionNo+"'";
 String  Sql="select SerialNo,Name FROM crm_project "+FindWhere+sectionNo+" group by  Name,SerialNo order by name";;
  ResultSet rs2=ViewBean1.executeQuery(Sql);
  while (rs2.next()){
   String SectionNo=rs2.getString("SerialNo");
   String SectionName=getbyte(rs2.getString("Name"));
   int  nn=0;
   double SumJzArea=0;
   String SQL="";
   SQL="SELECT loft,count(*) aa FROM Room r,crm_project s where r.seccode=s.serialno  and r.seccode='"+SectionNo+"'  group by loft order by loft ";//and s.name like '%住宅%'
	  ResultSet rs=ViewBean2.executeQuery(SQL);

   int num=0;
   double sumarea_ks=0;
   int sumnum_ks=0;
   double sumarea_rg=0;
   int sumnum_rg=0;
   int summoney_rg=0;
   int sumnum_ljrg=0;
   double sumarea_ljrg=0;
   int summoney_ljrg=0;
   int avg=0;
   double rate=0;
   double w_sk=0;
   double lj_sk=0;
   while (rs.next()){
    num++;
   }
rs.close();
	SQL="SELECT loft,sum(area) area,count(*) aa FROM Room r,crm_project s where r.seccode=s.serialno  and r.seccode='"+SectionNo+"' group by loft order by loft ";//and s.name like '%住宅%'
	    rs=ViewBean2.executeQuery(SQL);
  String roomtype="";
  double SumArea=0;
  int SumPrice=0;
  int y=0;
   while (rs.next()){
   String loft=getbyte(rs.getString("loft"));
   SumJzArea=rs.getDouble("area");
   sumarea_ks+=SumJzArea;
   int ts=rs.getInt("aa");
   sumnum_ks+=ts;
  
  
   %>
  <tr align="right"> 
  <%if (y==0){ %> <td rowspan="<%=num %>" align="center"><%=SectionName %></td><%} %>
    <td align="center"><%=loft %></td>
    <td><%=Format.getFloat2(SumJzArea ,3)%>&nbsp;</td>
    <td><%=ts%>&nbsp;</td>

 <% y=1; 
    int ddd=0;
	double areaNum=0;
	double price=0;
	try{
	SQL="SELECT COUNT(*) num ,sum(jzarea) area,sum(rmbprice) price from order_contract where state<>3 and loft='"+loft+"' and  substring(CONVERT(char(24), date, 120),1,10)>='"+Date1+"' and   substring(CONVERT(char(24), date, 120),1,10)<='"+Date2+"' and section='"+SectionNo+"'";
 
	 ResultSet rs1=ViewBean.executeQuery(SQL);
	
	 if (rs1.next()){
	   ddd=rs1.getInt("num");
	   if (ddd!=0){
	    areaNum=rs1.getDouble("area");
	    price=rs1.getDouble("price");
	    sumarea_rg+=areaNum;
	    sumnum_rg+=ddd;
	    summoney_rg+=price;
	   }
	   
    }
	rs1.close();
	//
	 
	}catch(Exception s){out.print(SQL+s.getMessage());}
	 %>
    <td><%=Format.getFloat2(areaNum,3) %>&nbsp;</td>
    <td><%=ddd %>&nbsp;</td>
	<td><%=Format.getFloat2(price,2) %>&nbsp;</td>
	<%
	ddd=0;
	areaNum=0;
	price=0;
	 SumArea=0;
	 SumPrice=0;
	try{
	SQL="SELECT COUNT(*) num ,sum(jzarea) area,sum(rmbprice) price from order_contract where  state<>3 and  loft='"+loft+"' and section='"+SectionNo+"'";
	 ResultSet rs1=ViewBean.executeQuery(SQL);
	 if (rs1.next()){
	   ddd=rs1.getInt("num");
	   if (ddd!=0){
	   areaNum=rs1.getDouble("area");
	   price=rs1.getDouble("price");
	    sumarea_ljrg+=areaNum;
	    sumnum_ljrg+=ddd;
	    summoney_ljrg+=price;
	   }
     }
	 rs1.close();
 
	SumArea+=areaNum;
	SumPrice+=price;

	 %>
    <td><%=Format.getFloat2(areaNum,3) %>&nbsp;</td>
    <td><%=ddd %>&nbsp;</td>
  	<td><%=Format.getFloat2(price,2) %>&nbsp;</td>
    <td><%if (SumPrice>0){out.print(Format.getFloat2(SumPrice/SumArea,0));}else{out.print("&nbsp;");}%>&nbsp;</td>
    <td><%=Format.getFloat2((SumArea/SumJzArea)*100,3) %>%&nbsp;</td>
	<%
	
	SQL="SELECT sum(f.factmoney*f.CurrRate) price  from FactGatheringRecord f,order_contract o  where o.state<>3 and  o.code = f.contractno and o.loft='"+loft+"' and  substring(CONVERT(char(24), f.Gather_Date, 120),1,10)>='"+Date1+"' and   substring(CONVERT(char(24), f.Gather_Date, 120),1,10)<='"+Date2+"' and o.section='"+SectionNo+"'";
    double factMoney=0;
	 rs1=ViewBean.executeQuery(SQL);
	 if (rs1.next()){
	   String aa=rs1.getString("price");
	   if (aa!=null){factMoney=Double.parseDouble(aa);w_sk+=factMoney;}
	  }
	   rs1.close();
	  //本周放款
	    SQL="select sum(f.FactMonye) fact from FactAjCharges f ,order_contract o";
		SQL+=" where o.state<>3 and  o.code = f.contractno and o.loft='"+loft+"' ";
		SQL+=" and  convert(char(10),f.FactDate,120)>='"+Date1+"' and  convert(char(10),f.FactDate,120)<='"+Date2+"' and o.section='"+SectionNo+"'";
	    rs1=ViewBean.executeQuery(SQL);//读取按按揭款
		double ajk=0;
		while (rs1.next())
		  ajk+=rs1.getDouble("fact");
	   rs1.close();
	   w_sk+=ajk;
	  
	  %>
    <td><%=Format.getFloat2(factMoney+ajk,2) %>&nbsp;</td>
	<%
	
	 
	SQL="SELECT sum(f.factmoney*f.CurrRate) price  from FactGatheringRecord f,order_contract o  where o.state<>3 and  o.code = f.contractno and o.loft='"+loft+"' and o.section='"+SectionNo+"'";
      factMoney=0;
	 rs1=ViewBean.executeQuery(SQL);
	 if (rs1.next()){
	  String aa=rs1.getString("price");
	  if (aa!=null){factMoney=Double.parseDouble(aa);lj_sk+=factMoney;}
	  }  rs1.close();
	  
	  //累计放款
	    SQL="select sum(f.FactMonye) fact from FactAjCharges f ,order_contract o";
		SQL+=" where o.state<>3 and  o.code = f.contractno and o.loft='"+loft+"' ";
		SQL+=" and    o.section='"+SectionNo+"'";
	    rs1=ViewBean.executeQuery(SQL);//读取按按揭款
		  ajk=0;
		while (rs1.next())
		  ajk+=rs1.getDouble("fact");
		  lj_sk+=ajk;
	   rs1.close();
	  %>
  <td><%=factMoney+ajk %>&nbsp;</td>
  <%}catch(Exception s){out.print(SQL+s.getMessage());} %>
  </tr>
  <%
    } rs.close();
   %>
   <tr bgcolor='#EAECEC' align="right"><td align="center">小计：</td><td>&nbsp;</td><td><%=Format.getFloat2(sumarea_ks,3) %>&nbsp;</td><td><%=sumnum_ks %></td><td><%=Format.getFloat2(sumarea_rg,3) %>&nbsp;</td><td><%=sumnum_rg %></td><td><%=Format.getFloat2(summoney_rg,2) %>&nbsp;</td><td><%=Format.getFloat2(sumarea_ljrg,3) %></td><td><%=sumnum_ljrg %>&nbsp;</td><td><%=Format.getFloat2(summoney_ljrg,2) %>&nbsp;</td><td><%=Format.getFloat2(summoney_ljrg/sumarea_ljrg,0) %>&nbsp;</td>
<td><%=Format.getFloat2(sumarea_ljrg/sumarea_ks*100,2) %>%&nbsp;</td>
<td><%=Format.getFloat2(w_sk,2) %>&nbsp;</td><td><%=Format.getFloat2(lj_sk,2) %>&nbsp;</td>
</tr>
   <% 
	}rs2.close();
 }catch(Exception s){out.print(s.getMessage());} %>
 
 
  
  
  
</table>

<p>说明:(1)销售率=累计认购面积/可售面积*100%   (2)均价=累计认购金额/累计认购面积</p>
 </div>
</body>

</html>
