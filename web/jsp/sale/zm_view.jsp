<%@ page contentType="text/html;charset=GBK" %>

 

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>业主转名记录</title>
<script language=javascript src="js/mad.js"> </script>
<script language=javascript src="../public_js/basal.js"> </script>
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
</head>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<body topmargin="1">
<%
    String  SecNo=China.getParameter(request,"SecNo");
    String  Date1=China.getParameter(request,"Date1");
	String  Loft=China.getParameter(request,"Loft");	
	String  Date2=China.getParameter(request,"Date2");
     
    %>
<form action="sk_process.jsp" method="post" name="frm">
 
 <input type="button" onclick="bringToExcel()" value="导出到Excel">
<div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2"   >
<p align="center" class=FontColor><font size=3><b> 客户更名明细表</font></b></p>
 时间段：<%=Date1 %>到<%=Date2 %>

 <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

<tr   > 
<td  align="center">序号</td>
<td  align="center">房间代码</td>
<td  align="center">认购日期</td>
<td  align="center">建筑面积</td>
<td  align="center">总款</td>

<td  align="center">原客户名称</td>
<td  align="center">新客户名称</td>

<td  align="center">转名日期</td>
<td  align="center">转名原因</td>
　
</tr>
 
<%
	
	  Date1=" and  b.section='"+SecNo+"' and convert(char(10), a.zmdate,120)>='"+Date1+"' and  convert(char(10), a.zmdate,120)<='"+Date2+"'";
	if (!Loft.equals(""))Date1+=" and b.loft='"+Loft+"'";
	
  String SQL="SELECT DISTINCT a.oldname,a.newname,a.zmdate,a.context,b.loft+b.room_no room,b.date,b.jzarea,b.rmbprice from zm_bak a,Order_Contract b where a.newname<>a.oldname and a.htno=b.code "+Date1;
 
 
		  ResultSet rs=ViewBean.executeQuery(SQL+"order by zmdate desc");
         int i=0;
         while (rs.next()){ 
		    i++;
			String   room=getbyte(rs.getString("room"));
			String   jzarea=getbyte(rs.getString("jzarea"));
			String   rmbprice=getbyte(rs.getString("rmbprice"));
			String   date=getbyte(rs.getDate("date").toString());
		    String  oldname=getbyte(rs.getString("oldname"));
		    String  newname=getbyte(rs.getString("newname"));
		    String  zmdate=getbyte(rs.getString("zmdate"));
			if (!zmdate.equals(""))zmdate=zmdate.substring(0,10);
			String  context=getbyte(rs.getString("context"));
			 
			%>
			<tr   > 
			<td  align="center"><%=i %></td>
			<td  align="center"><%=room %></td>
			<td  align="center"><%=date %></td>
			<td  align="right"><%=jzarea %></td>
			<td  align="center"><%=rmbprice %></td>
			
			
			<td  align="center"><%=oldname %></td>
		 <td  align="right"><%=newname %></td>
			
			<td  align="center"><%=zmdate %></td>
			<td  align="center"><%=context %></td>
			 
			</tr>
		<% }%>
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
 
</body>
</html>
