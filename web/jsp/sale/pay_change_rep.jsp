 <%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
  <%@ page import = "java.sql.*,common.*" %>
  <jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id = "changeListBean" scope = "page" class = "ConnDatabase.SDatabase" />
   <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
  <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>付款方式变更报表</title>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<%String  SecNo=China.getParameter(request,"SecNo");
    String  Date1=China.getParameter(request,"Date1");
	String  Loft=China.getParameter(request,"Loft");	
	String  Date2=China.getParameter(request,"Date2");
 %>
<body>

<div align=left id=report1 style="background-color:#F7F7F7;height:100%px;overflow:auto;width:100%;z-index:2" contentEditable >
<form name="frm">
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<p align="center"><font size=4><b>付款方式变更明细</b></font> </p>
<table border="0" cellpadding="0" cellspacing="0"  width="99%"  >
  <tr >
  <td align="left" width="49%"><div id=w1></div></td>  <td align="right" width="49%"><div id=w2></div></td>
  </tr>
  </table>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="99%" id="AutoNumber1">
  <tr align="center">
    <td width="4%">序号</td>
    <td width="4%">变更日期</td>
    <td width="4%">认购日期</td>
    <td width="4%">认购人</td>
    <td width="4%">认购单位</td>
    <td width="4%">建筑面积</td>
    <td width="4%">原成交金额</td>
    <td width="4%">原付款方式</td>
    <td width="4%">现付款方式</td>
    <td width="4%">现成交金额</td>
    <td width="4%">成交金额差</td>
    <td width="4%">置业顾问</td>
    <td width="4%">审批人</td>
  </tr>
  <%
	String sql="select b.sectionname,convert(char(10),a.change_date,120) change_date, convert(char(10),b.date,120) date,";
	sql+="c.cus_name,b.loft+b.room_no room,b.jzarea,a.yrmbprice,a.oldpayment,a.nowpayment,b.rmbprice,";
	sql+="b.rmbprice-a.yrmbprice ce,b.seller,a.paychecker ";
	sql+=" from order_contract_log a,order_contract b,customer c where  b.customer=c.serialno and a.order_contract=b.code and b.section='"+SecNo+"' and a.change_date >='"+Date1+"'";
	sql+=" and a.change_date <='"+Date2+"' and nowpayment<>oldpayment ";
	if (!Loft.equals(""))
	     sql+=" and a.loft='"+Loft+"'";
	  ResultSet changeRS1 = null;
	  String sectionname="";
	  int i=0;
	 try{
	 
	   changeRS1 = changeListBean.executeQuery(sql);	
       while (changeRS1.next()){
	   i++;
	   sectionname=changeRS1.getString("sectionname") ;
	 %>
  <tr  align="center">
    <td width="4%"><%=i %></td>
    <td width="4%"><%=changeRS1.getString("change_date") %></td>
    <td width="4%"><%=changeRS1.getString("date") %></td>
    <td width="4%"><%=changeRS1.getString("cus_name") %></td>
    <td width="4%"><%=changeRS1.getString("room") %></td>
    <td width="4%"><%=changeRS1.getString("jzarea") %></td>
    <td width="4%"><%=changeRS1.getString("yrmbprice") %></td>
    <td width="4%"><%=changeRS1.getString("oldpayment") %></td>
    <td width="4%"><%=changeRS1.getString("nowpayment") %></td>
    <td width="4%"><%=changeRS1.getString("rmbprice") %></td>
    <td width="4%"><%=changeRS1.getString("ce") %></td>
    <td width="4%"><%=changeRS1.getString("seller") %></td>
    <td width="4%"><%=getbyte(changeRS1.getString("paychecker")) %></td>
  </tr>
   <% }
	 changeRS1.close();
	}catch(Exception e){out.print(e);} %>
</table>
</form>
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

w2.innerHTML="变更日期范围：<%=Date1 %>--<%=Date2 %>      ";

</script>
	
</body>

</html>
 