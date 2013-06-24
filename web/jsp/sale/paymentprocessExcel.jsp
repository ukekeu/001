<%@ page contentType="text/html;charset=GBK" %>

 

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>付款进度</title>
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
<body>
<%
    String strLoft = getbyte1(request.getParameter("Loft"));
    String SecNo = getbyte1(request.getParameter("SecNo"));
    String strBuild =  getbyte1(request.getParameter("Build"));
	String strSecName =getbyte1( request.getParameter("SecName"));
    String sel=(String)request.getParameter("sel");
    if(sel==null) sel="0";	  
	    java.text.DecimalFormat df1 = new java.text.DecimalFormat("###,###,###.###"); 
		java.text.DecimalFormat df2 = new java.text.DecimalFormat("###,###,###"); 
 %>
<form action="contract_view.jsp" method="post" name="frm">
<input type=hidden name=SecNo value="<%=SecNo %>">
 
<input type=hidden name=Loft value="<%=strLoft %>">
<input type=hidden name=Build value="<%=strBuild %>">
 <input type=hidden name=SecName value="<%=strSecName %>">
 
 
  <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >

<p align=center class=FontColor><font size=4><b><%if (!strSecName.equals(strLoft)){out.print(strSecName);} %><%=strLoft %> </b></font></p>
 
 <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

<tr   > 
<td  align="right">序号</td>
<td  align="center">客户姓名</td>
<td  align="right">房间代码</td>

<td  align="center">面积</td>
<td  align="center">成交总价(元)</td>
<td  align="center">付款方式</td>
<td  align="center">付款进度</td>
</tr>
 
<%
  String SQL="SELECT romno , jzarea,cus_name,saleRprice*rate saleprice,payment1 ,factmoney  process FROM viewsalelist WHERE  section='"+SecNo+"' order by romno";
    
	    if (!strLoft.equals(""))SQL+=" and   LOFT='"+strLoft+"'";

 
		  ResultSet rs=ViewBean.executeQuery(SQL);
         int i=0;
         while (rs.next()){ 
		    i++;
		    String  romno=getbyte(rs.getString("romno"));
		    String  jzarea=df1.format(rs.getFloat("jzarea"));
		    String  cus_name=getbyte(rs.getString("cus_name"));
			String  saleprice=df1.format(rs.getFloat("saleprice"));
			String  payment=getbyte(rs.getString("payment1"));
			float  process= rs.getFloat("process");
			%>
			<tr   > 
			<td  align="center"><%=i %></td>
			<td  align="center"><%=cus_name %></td>
			<td  align="right"><%=romno %></td>
			
			<td  align="center"><%=jzarea %></td>
			<td  align="center"><%=saleprice %></td>
			<td  align="center"><%=payment %></td>
			<td  align="left">&nbsp;<%=process %> 
			 
			</td>
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
     oSheet.Paste();     
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
 bringToExcel();
 window.close();
  </script>
</body>
</html>
