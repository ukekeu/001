 <%@ page contentType="text/html;charset=GBK" %>
  <%@ page import = "java.sql.*,common.*" %>
  <%@ include file="../public_js/checktime.jsp"%>
  <jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id = "changeListBean" scope = "page" class = "ConnDatabase.SDatabase" />
   <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
  <%@ include file="../public_js/getByteOut.jsp"%>

<html>
<head>
	<title>销售台帐</title>
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>

<body>
<form name="frm">
<div align=left id=report1 style="background-color:#F7F7F7;height:100%px;overflow:auto;width:100%;z-index:2" contentEditable >

  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<p align="center"><font size=4><b>销售台帐明细表</b></font> </p>
<table border="0" cellpadding="0" cellspacing="0"  width="99%"  >
  <tr >
  <td align="left" width="49%"><div id=w1></div></td>  <td align="right" width="49%"><div id=w2></div></td>
  </tr>
  </table>
<table  border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="152%" id="AutoNumber1">
  <tr align="center">
    <td width="2%" rowspan="2">序号</td>
    <td width="2%" rowspan="2">客户名</td>
    <td width="10%" colspan="6">房间资料</td>
    
    <td width="14%" colspan="6">认购</td>
    <td width="21%" colspan="8">签约</td>
       <td width="27%" colspan="4">办证情况</td>
    <td width="27%" colspan="3">回款</td>
    <td width="27%" colspan="4">信息</td>
  </tr>
  <tr align="center">
    <td width="2%">楼栋</td>
    <td width="2%">单元</td>
    <td width="2%">房号</td>
    <td width="2%">户型</td>
    <td width="2%">面积</td>  
	<td width="2%">总价</td>  
    <td width="2%">单号</td>
    <td width="2%">日期</td>
    <td width="2%">认购金</td>
    <td width="2%">折扣</td>
    <td width="2%">单价</td>
    <td width="2%">总款</td>
    <td width="2%">合同号</td>
    <td width="3%">日期</td>
    <td width="3%">单价</td>
    <td width="3%">总价</td>
    <td width="3%">首付</td>
 
    <td width="3%">优惠合计</td>
    <td width="3%">付款方式</td>
    <td width="3%">按揭款</td>
    <td width="3%">按揭银行</td>
    <td width="3%">资料提<br>交情况</td>
    <td width="3%">银行审<br>批情况</td>
    <td width="3%">终审<br>通过</td>
    <td width="3%">到款额</td>
    <td width="3%">累计回款</td>
    <td width="3%">剩余款</td>
    <td width="3%">联系地址</td>
    <td width="2%">联系电话</td>
    <td width="4%">邮编</td>
    <td width="3%">置业顾问</td>
    
    
  </tr>
  <%  String  SecNo=China.getParameter(request,"SecNo");
    String  Date1=China.getParameter(request,"Date1");
	String  Loft=China.getParameter(request,"Loft");	
	String  Date2=China.getParameter(request,"Date2");
	String sql="",code="",sectionname="";
	       sql="select b.sectionname,b.code,a.cus_name,b.loft,b.room_no,b.roomtype,b.jzarea,b.SerialNo,d.cell"; 
		    sql+="  ,a.phone+a.sj phone,a.Zip_Code,b.seller,a.Address,d.sumprice as ysprice "; 
		   sql+=",convert(char(10),b.date,120) date,b.subscription,b.disc,convert(numeric(9,2),b.rg_sumprice/b.jzarea) rg_unitprice,b.rg_sumprice rgprice,b.ContractNo";
		   sql+=",convert(char(10),b.VisaDate,120)  VisaDate,b.rmbprice-b.ajmoney sq,b.ysumprice-b.rmbprice cj ,b.rmbprice,b.unitprice,b.payment1,b.ajmoney,b.AjBk  from customer a,order_contract b ,room d ";
		   sql+=" where  b.section+b.loft+b.room_no=d.seccode+d.loft+d.room_code and a.serialno=b.customer and   b.section='"+SecNo+"'";
		    sql+=" and b.state<>3 and  convert(char(10),b.date,120)>='"+Date1+"' and convert(char(10),b.date,120)<='"+Date2+"'";
			if (!Loft.equals(""))
			 sql+=" and b.loft='"+Loft+"'";
			 sql+=" order by b.loft,b.floors,b.room_no";
			ResultSet changeRS = null;
			ResultSet changeRS1 = null;
 %>
  <%try{
	changeRS1 = changeListBean.executeQuery(sql);	
	 
	int i=0;
	
	while (changeRS1.next()) {
	i++;
	sectionname=getbyte(changeRS1.getString("sectionname"));
	code=getbyte(changeRS1.getString("code"));
	 %>
  <tr align="center">
    <td width="2%"><%=i %></td>
    <td width="2%"><%=getbyte(changeRS1.getString("cus_name")) %></td>
    <td width="2%"><%=getbyte(changeRS1.getString("loft")) %></td>
    <td width="2%"><%=getbyte(changeRS1.getString("cell")) %></td>
    <td width="2%"><%=getbyte(changeRS1.getString("room_no")) %></td>
    <td width="2%"><%=getbyte(changeRS1.getString("roomtype")) %></td>
    <td width="2%"><%=getbyte(changeRS1.getString("jzarea")) %></td>
      <td width="2%"><%=getbyte(changeRS1.getString("ysprice")) %></td>
    <td width="2%"><%=getbyte(changeRS1.getString("SerialNo")) %></td>
    <td width="2%"><%=getbyte(changeRS1.getString("date")) %></td>
    <td width="2%"><%=getbyte(changeRS1.getString("subscription")) %></td>
    <td width="2%"><%=getbyte(changeRS1.getString("disc")) %></td>
    <td width="2%"><%=getbyte(changeRS1.getString("rg_unitprice")) %></td>
    <td width="2%"><%=getbyte(changeRS1.getString("rgprice")) %></td>
  
    <td width="2%"><%=getbyte(changeRS1.getString("ContractNo")) %></td>
    <td width="3%"><%=getbyte(changeRS1.getString("visadate")) %></td>
    <td width="3%"><%=getbyte(changeRS1.getString("unitprice")) %></td>
    <td width="3%"><%=getbyte(changeRS1.getString("rmbprice")) %></td>
    <td width="3%"><%=getbyte(changeRS1.getString("sq")) %></td>
 
    <td width="3%"><%=getbyte(changeRS1.getString("cj")) %></td>
    <td width="3%"><%=getbyte(changeRS1.getString("payment1")) %></td>
    <td width="3%"><%=getbyte(changeRS1.getString("ajmoney")) %></td>
    <td width="3%"><%=getbyte(changeRS1.getString("AjBk")) %></td>
	<%sql="select * from aj_bak where contractno="+code;
	  changeRS = ViewBean.executeQuery(sql);	
	  String state1="",state2="",state3="";
	  
	if (changeRS.next()) {
	 
	state1=getbyte(changeRS.getString("state"));
	if (state1.equals("0"))state1="未提交完";
	else state1="提交完";
	state2=getbyte(changeRS.getString("state1"));
	if (state2.equals("0"))state2="未审";
	else state2="已审";
	state3=getbyte(changeRS.getString("state2"));
	if (state3.equals("0"))state3="未审";
	else state3="已审";
	}
	changeRS.close();
	 %>
    <td width="3%"><%=state1 %></td>
    <td width="3%"><%=state2 %></td>
    <td width="3%"><%=state3 %></td>
	<td width="2%">　</td>
	<td width="4%">　</td>
	<td width="3%">　</td>

    <td width="3%"><%=getbyte(changeRS1.getString("Address")) %></td>
    <td width="3%"><%=getbyte(changeRS1.getString("Phone")) %></td>
	<td width="3%"><%=getbyte(changeRS1.getString("Zip_Code")) %></td>
	<td width="3%"><%=getbyte(changeRS1.getString("seller")) %></td>
	 
  </tr> 
   <%}
  
  changeRS1.close(); 
  }catch(Exception e){out.print(e);}
  %>
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
<p align="center"> <div   id="divprint" align="center"><input type="button" name="Button" value="打印预览"  title="打印前请先收起左边楼栋树" onClick="window.divprint.style.display='none';javascript:document.frm.WebBrowser.ExecWB(7,1);window.divprint.style.display='block'"> <input type="button" onclick="bringToExcel()" value="导出到Excel"><br>
导入前必须进行相应设置：<br>
　1.在IE工具栏中选择"internet选项"<br>
　2.选择"安全"->选择"本地intranet"后再点击"自定义级别"<br>
  3.把所有ActiveX启用都选中后点击确认退后。<br>
 
<script>

w1.innerHTML="楼盘名称：<%=sectionname %>      ";

w2.innerHTML="日期范围：<%=Date1 %>--<%=Date2 %>      ";

</script>
	

</body>
</html>
