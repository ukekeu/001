<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel="stylesheet" type="text/css" href="UltraGrid.css">	
<title>市场调查表</title>
</head>
<script language="javascript" src="../public_js/public.js"></script>
  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/checktime.jsp"%>
 
<%
String codes=getbyte1(request.getParameter("codes"));
String deletecode=getbyte1(request.getParameter("deletecode"));
String SQL="";
if (!deletecode.equals("")){
   SQL="delete  CustomerDc where code="+deletecode;
   ViewBean.executeUpdate(SQL);
}
if (!codes.equals("")){
   SQL="insert into CustomerDc(codeName) values('"+codes+"')";
   ViewBean.executeUpdate(SQL);
}
SQL="select * from CustomerDc";
ResultSet rs=ViewBean.executeQuery(SQL);	
 %>
<body>
<form name=frm>
 <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
 <div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >
<div id=titlestr><p align=center class=FontColor><font size=3><b>市场调查表</b></font></p></div>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="98%" id="AutoNumber1">
  <tr align="center"  class=listtitle>
    <td width="5%">序号</td>
    <td width="15%">调查项</td>
	 <td width="75%">调查内容</td>
	 
  </tr>
  <%
  int i=0;
   while (rs.next()){
     i++;
   %>
 <tr align="center">
    <td width="5%" ><%=i %></td>
    <td width="15%" align="left">&nbsp;<%=rs.getString("codeName") %></td>
	<td width="75%" align="left">
	<%
	 SQL="select  CodeValue,code from CustomerDcValue where dcCode="+rs.getString("code");
	 
	 ResultSet rs1=ViewBean1.executeQuery(SQL);	
    while (rs1.next()){
	    String codcename=rs1.getString("CodeValue");
		String code=rs1.getString("code");
	     %>
		   <input name="codcename" type="checkbox" value="<%=code %>"   ><%=codcename %> 
		 <% 
       }
	rs1.close();
	 %>
	
	</td>
	 
  </tr>
  <%}
  rs.close(); %>
  
</table>


</div>
<DIV align=center id="printdiv">
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
  <input type="button" onclick="bringToExcel()" value="导出到Excel"> 
<br>导入前必须进行相应设置：<br>
　1.在IE工具栏中选择"internet选项"<br>
　2.选择"安全"->选择"本地intranet"后再点击"自定义级别"<br>
  3.把所有ActiveX启用都选中后点击确认退后。<br>
 </div>
</form> 

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
