<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<html>

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>银行按揭贷款月度明细表</title>
</head>

<body>
<%
  String SQL="";
  String stdate = China.getParameter(request,"Date1") ;
  String endate = China.getParameter(request,"Date2") ;
  String SecNo=China.getParameter(request,"SecNo") ;
  SQL="SELECT YONG_TU,count(*) num FROM order_contract WHERE state=2 and convert(char(10),fkdate,120)>='"+stdate+"' and convert(char(10),fkdate,120)<='"+endate+"' and section='"+SecNo+"' group by YONG_TU";
  ResultSet rs=null;
  ResultSet rs1=null;
   ResultSet rs2=null;
   String sectionname="";
   double sumjzarea=0;
   double qqsumprice=0;
   double bqsumprice=0;
   double ljsumprice=0;
   double ljqk=0;
   
   double sumprice=0;
   double sumdj=0;
   
  
	 
 %>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
  <DIV align=center id="printdiv">
<input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
  <input type="button" onclick="bringToExcel()" value="导出到Excel">

 </div>
  <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >
<table border="0" width="99%"  cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
  <tr align="center"><td>银行按揭贷款月度明细表</td></tr>
  <tr><td>&nbsp;</td></tr>
  <tr align="center"> <td>报表日期:从<%=stdate %>到<%=endate %></td></tr>
   <tr><td>&nbsp;</td></tr>
  <tr><td><div id=sectionname></div></td></tr>
  </table>
<table border="1" width="99%"  cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
  <tr align="center">
  
   <td width="7%" rowspan="2">序号</td>
    <td width="7%" rowspan="2">房号</td>
    <td width="7%" rowspan="2">业主姓名</td>
    <td width="7%" rowspan="2">面积</td>
    <td width="32%" colspan="4">合同情况</td>
    <td width="24%" colspan="3">收款情况</td>
    <td width="8%" rowspan="2">欠款额</td>
    <td width="8%" rowspan="2">备注</td>
  </tr>
  <tr  align="center">
    <td width="8%">合同日期</td>
    <td width="8%">首期款</td>
    <td width="8%">合同收<br>款日期</td>
    <td width="8%">贷款额</td>
    <td width="8%">前期收款额</td>
    <td width="8%">本月收款额</td>
    <td width="8%">累计收款额</td>
  </tr>
  <%
 
  
   SQL="SELECT a.sectionname,a.yong_tu,a.loft+a.room_no roomno,b.cus_name,a.jzarea,CONVERT(char(10),a.visadate,120) visadate ,a.subscription dj,CONVERT(char(10), DATEADD(dd,";
   SQL+="a.ajtxdate,a.VisaDate), 120) ajdate,a.rmbprice-a.ajmoney kk,a.ajmoney,a.code FROM order_contract a ,customer b WHERE a.customer=b.serialno and  a.state=2 and a.code in (SELECT contractno  FROM FactAjCharges where   convert(char(10),FactDate,120)>='"+stdate+"' and  convert(char(10),FactDate,120)<='"+endate+"') and a.section='"+SecNo+"' and a.payment1 like '%按揭%'   order by a.loft+a.room_no";
       rs1=ViewBean1.executeQuery(SQL);
	   double ysk=0;
	   int ii=0;
	   double aa1=0;
	    while (rs1.next()){
		sectionname=rs1.getString("sectionname");
		sumjzarea+=rs1.getDouble("jzarea");
		sumdj+=rs1.getDouble("kk");
		aa1=rs1.getDouble("kk");
ii++;
   %>
  <tr align="center">
 
   <td width="7%"  align="center"><%=ii%></td>
    <td width="7%"  align="center"><%=rs1.getString("roomno") %></td>
    <td width="7%"  align="center"><%=rs1.getString("cus_name") %></td>
    <td width="7%"><%=rs1.getString("jzarea") %></td>
    <td width="8%"  align="center"><%=rs1.getString("visadate") %></td>
    <td width="8%"><%=FormtD.getFloat2(rs1.getDouble("kk"),2) %></td>
    <td width="8%"  align="center"><%=rs1.getString("ajdate") %></td>
	<%ysk=rs1.getDouble("ajmoney") ; sumprice+=ysk;aa1+=ysk;%>
    <td width="8%"><%=FormtD.getFloat2(ysk,2)%></td>
	<%
	SQL="SELECT sum(CurrRate*factmoney) ff FROM factGatheringRecord where    convert(char(10),gather_date,120)<'"+stdate+"'  and  contractno = " +rs1.getString("code");
	 rs2=ViewBean2.executeQuery(SQL);
	 double qqsk=0;
	    if (rs2.next()){
		qqsk=rs2.getDouble("ff");
		}
		rs2.close();
		
		SQL="SELECT sum(FactMonye) ff FROM FactAjCharges where    convert(char(10),FactDate,120)<'"+stdate+"'  and  contractno = " +rs1.getString("code");
	 rs2=ViewBean2.executeQuery(SQL);
	 
	    if (rs2.next()){
		qqsk+=rs2.getDouble("ff");
		}
		rs2.close();
		
	   qqsumprice+=qqsk;
	 %>
    <td width="8%"><%=qqsk %></td>
	<%
	SQL="SELECT sum(CurrRate*factmoney) ff FROM factGatheringRecord where    convert(char(10),gather_date,120)>='"+stdate+"' and convert(char(10),gather_date,120)<='"+endate+"' and   contractno = " +rs1.getString("code");
	 rs2=ViewBean2.executeQuery(SQL);
	 double bqsk=0;
	    if (rs2.next()){
		bqsk=rs2.getDouble("ff");
		}
		rs2.close();
		
		SQL="SELECT sum(FactMonye) ff FROM FactAjCharges where    convert(char(10),FactDate,120)>='"+stdate+"'  and convert(char(10),FactDate,120)<='"+endate+"'  and  contractno = " +rs1.getString("code");
	 rs2=ViewBean2.executeQuery(SQL);
	 
	    if (rs2.next()){
		bqsk+=rs2.getDouble("ff");
		}
		rs2.close();
	bqsumprice+=bqsk;
	 %>
    <td width="8%"><%=FormtD.getFloat2(bqsk,2) %></td>
	<%
	SQL="SELECT sum(CurrRate*factmoney) ff FROM factGatheringRecord where       contractno = " +rs1.getString("code");
	 rs2=ViewBean2.executeQuery(SQL);
	 double ljsk=0;
	    if (rs2.next()){
		ljsk=rs2.getDouble("ff");
		}
		rs2.close();
		
		SQL="SELECT sum(FactMonye) ff FROM FactAjCharges where       contractno = " +rs1.getString("code");
	 rs2=ViewBean2.executeQuery(SQL);
	 
	    if (rs2.next()){
		ljsk+=rs2.getDouble("ff");
		}
		rs2.close();
	ljsumprice+=ljsk;
	ljqk+=aa1-ljsk;
	 %>
    <td width="8%"><%=FormtD.getFloat2(ljsk,2) %></td>
    <td width="8%"><%=FormtD.getFloat2(aa1-ljsk,2) %></td>
    <td width="8%">　</td>
  </tr> 
  <%;}
  rs1.close(); 
  
  
  %>
   <tr align="center">
    <td width="7%" rowspan="2">小计</td>
    <td width="7%" rowspan="2"></td>
    <td width="7%" rowspan="2"></td>
    <td width="7%" rowspan="2"><%=FormtD.getFloat2(sumjzarea,2) %></td>
    <td  ></td>
    <td  ><%=FormtD.getFloat2(sumdj,2) %></td>
    <td   ></td>
	 <td   ><%=FormtD.getFloat2(sumprice,2) %></td> 
	  <td    ><%=FormtD.getFloat2(qqsumprice,2) %></td>
	   <td   ><%=FormtD.getFloat2(bqsumprice,2) %></td>
	  <td   ><%=FormtD.getFloat2(ljsumprice,2) %></td>
    <td   ><%=FormtD.getFloat2(ljqk,2) %></td>
  </tr> 
</table>
 
<table border="0"  width="99%" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">

<tr align="center">
    <td width="7%" rowspan="2">&nbsp;</td>
    <td width="7%" rowspan="2"></td>
    <td width="7%" rowspan="2"></td>
    <td width="7%" rowspan="2"></td>
    <td  ></td>
    <td  ></td>
    <td   ></td>
	 <td   ></td> 
	  <td    ></td>
	   <td   ></td>
	  <td   ></td>
    <td   ></td>
  </tr>
  
<tr align="center">
    <td width="7%" rowspan="2">&nbsp;</td>
    <td width="7%" rowspan="2"></td>
    <td width="7%" rowspan="2"></td>
    <td width="7%" rowspan="2"></td>
    <td  ></td>
    <td  ></td>
    <td   ></td>
	 <td   ></td> 
	  <td    ></td>
	   <td   ></td>
	  <td   ></td>
    <td   ></td>
  </tr>
<tr align="left">
    <td width="7%" rowspan="2">销售经理：</td>
    <td width="7%" rowspan="2"></td>
    <td width="7%" rowspan="2"></td>
    <td width="7%" rowspan="2">销售主管：</td>
    <td  ></td>
    <td  ></td>
    <td   ></td>
	 <td   ></td> 
	  <td    ></td>
	   <td   ></td>
	  <td   ></td>
    <td   ></td>
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
