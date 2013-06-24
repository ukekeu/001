 
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
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
<title>销售月度汇总表</title>
</head>
<html>
 
<body>
<%
  String SQL="";
  String stdate = China.getParameter(request,"Date1") ;
  String endate = China.getParameter(request,"Date2") ;
  String SecNo=China.getParameter(request,"SecNo") ;
   SQL="SELECT top 1 sectionname  FROM order_contract a  WHERE  a.state<>3 and  a.section='"+SecNo+"'    ";
  ResultSet rs=null;
  ResultSet rs1=null;
  double qm1=0;
  double hj1=0,hj2=0,hj3=0;
   double n1=0,n2=0,n3=0;
  int qm2=0;
   rs=ViewBean.executeQuery(SQL);
//a.state=2 
String sectionname="";
if (rs.next()){
sectionname=rs.getString("sectionname");
}
rs.close();

 SQL="SELECT a.payment1  FROM order_contract a  WHERE  a.state<>3 and  a.section='"+SecNo+"' group by  a.payment1   ";
 rs=ViewBean.executeQuery(SQL);
 %>
 
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
  <DIV align=center id="printdiv">
<input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
  <input type="button" onclick="bringToExcel()" value="导出到Excel">

 </div>
  <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >
<table border="0" width="99%"  cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
  <tr align="center"><td>销售月度汇总表</td></tr>
  <tr><td>&nbsp;</td></tr>
  <tr align="center"> <td>报表日期:从<%=stdate %>到<%=endate %></td></tr>
   <tr><td>&nbsp;</td></tr>
  <tr><td><div id=sectionname></div></td></tr>
  </table>
<table border="1"  width="99%" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" height="82">
  <tr align="center">
    <td width="14%" rowspan="2" height="31">项目</td>
    <td width="28%" colspan="2" height="15">期初数</td>
    <td width="28%" colspan="2" height="15">本期数</td>
    <td width="30%" colspan="2" height="15">期末数</td>
  </tr>
  <tr align="center">
    <td width="14%" height="15">数量（套）</td>
    <td width="14%" height="15">金额</td>
    <td width="14%">数量（套）</td>
    <td width="14%">金额</td>
    <td width="14%">数量（套）</td>
    <td width="14%">金额</td>
  </tr>
  <% while (rs.next()){ %>
  <tr align="center">
  
  <%   SQL="SELECT  sum(rmbprice) rmbpirce,count(*) num FROM order_contract a  WHERE   a.payment1='"+rs.getString("payment1")+"' and   convert(char(10),a.date,120)<'"+stdate+"'  and a.state<>3 and  a.section='"+SecNo+"'   ";
     rs1=ViewBean1.executeQuery(SQL);
	 double qc1=0;
	  int qc2=0;
	  double bq1=0;
	  int bq2=0;
	 if (rs1.next()){
	    qc1=rs1.getDouble("rmbpirce");
		qc2=rs1.getInt("num");
	 }
	 rs1.close();
	 hj1+=qc1;
	  n1+=qc2;
  %>
   <td width="15%" height="16"><%=rs.getString("payment1") %></td>
    
    <td width="14%" height="16"><%=qc2 %></td>
<td width="14%" height="16"><%=FormtD.getFloat2(qc1,2) %></td>
	<%   SQL="SELECT sum(rmbprice) rmbpirce,count(*) num  FROM order_contract a  WHERE     a.payment1='"+rs.getString("payment1")+"'  and convert(char(10),a.date,120)>='"+stdate+"' and convert(char(10),a.date,120)<='"+endate+"' and a.state<>3 and  a.section='"+SecNo+"'    ";
     rs1=ViewBean1.executeQuery(SQL);
	 
	 if (rs1.next()){
	    bq1=rs1.getDouble("rmbpirce");
		bq2=rs1.getInt("num");
	 }
	 rs1.close();
	 qm1=bq1+qc1;
	 qm2=bq2+qc2;
	 
	  hj2+=bq1;
	  n2+=bq2;
	   hj3+=qm1;
	  n3+=qm2;
  %> <td width="14%" height="16"><%=bq2 %></td>
    <td width="14%" height="16"><%=FormtD.getFloat2(bq1,2) %></td>
   <td width="15%" height="16"><%=qm2 %></td>
    <td width="14%" height="16"><%=FormtD.getFloat2(qm1,2) %></td>
    
   
  </tr> 
  <%}rs.close(); %>
  <tr align="center"><td>合计</td><td><%=FormtD.getFloat2(n1,0) %></td><td><%=FormtD.getFloat2(hj1 ,2)%></td><td><%=FormtD.getFloat2(n2,0) %></td><td><%=FormtD.getFloat2(hj2,2) %></td>
  <td><%=FormtD.getFloat2(n3,0) %></td><td><%=FormtD.getFloat2(hj3,2) %></td>
  </tr>
</table>

<p></p>
<table border="0"   width="99%" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1"  >



  <tr>
    <td   height="13" colspan="2">销售经理：</td>
    
    
    <td  height="13" colspan="2">销售主管：</td>
   
    
    <td   height="13" colspan="2" >制表人：</td>
  
    
     
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
