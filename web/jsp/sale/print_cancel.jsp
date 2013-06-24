 
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
<body>
<% 
String secName="";
String Date1=request.getParameter("Date1");
String Date2=request.getParameter("Date2");
String td=request.getParameter("td");

String SQLwhere="";
if (!Date1.equals("")&&!Date2.equals("")){
 Date1=" and date between '"+Date1+"' and '"+Date2+"'";
 SQLwhere=" and tf_date between '"+request.getParameter("Date1")+"' and '"+Date2+"'";
}
 
String sectionNo=getbyte1(request.getParameter("SecNo"));

 secName=sectionNo.substring(sectionNo.indexOf("|")+1);
sectionNo=sectionNo.substring(0,sectionNo.indexOf("|"));
SQLwhere+=" and o.section='"+sectionNo+"'";
String Strtitle=secName+"退房明细表";
if (td.equals("1"))Strtitle=secName+"挞定明细表";
else if (td.equals(""))Strtitle=secName+"退定明细表";
else if (td.equals("2"))Strtitle=secName+"退房明细表";
	
 %>
 <div align=left id=report1 style="height:100%px;overflow:auto;width:100%;z-index:2" contentEditable >
<table width="98%" cellspacing="0" cellpadding="0">
 <tr align="center" ><td  ><b><font size=4><%=Strtitle  %></font></b> </td></tr>
</table>
<br>
 
 <table width="98%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF">
  
  <tr bgcolor='#EAECEC' align="center">  
    <td  >套数</td>
    <td>面积M<sup>2</sup></td>
    <td>占已售比率</td>
  </tr>
  <%
    
   String SQL="select sum(jzarea) jzarea from  order_contract where state<>3  "+Date1+" and section ='"+sectionNo+"'"; 
 
	  ResultSet rs=ViewBean2.executeQuery(SQL);
	  double jzarea=0;
	  
     if (rs.next()){
	   jzarea=rs.getDouble("jzarea");
	   
	 }
	 
	 rs.close();
	  int i=1;
   if (td.equals("1")){
  //  SQL="select sum(jzarea) jzarea from  TFRecord where subscription=0 and section ='"+secName+"' "+SQLwhere; 
 SQL="select sum(o.jzarea) jzarea,count(*) num from TFRecord t,customer c,order_contract o where o.state=3 and t.customer=c.SerialNo  and t.subscription=0  and  c.serialno=o.customer and t.section=o.sectionNAME and c.section=o.section "+SQLwhere;
	   rs=ViewBean2.executeQuery(SQL);
	  
	   if (rs.next()){
	     out.print("<tr>");
   	     out.print("<td align='center'>"+rs.getInt("num")+"</td>");
		 double jzarea1=rs.getDouble("jzarea");
		 out.print("<td align='center'>"+Format.getFloat2(jzarea1,2)+"</td>");
   	     out.print("<td align='center'>"+Format.getFloat2((jzarea1/jzarea)*100,2)+"%</td></tr>");		 
	   }
	   rs.close();
	  }else if (td.equals("2")){
	 SQL="select sum(o.jzarea) jzarea,count(*) num from TFRecord t,customer c,order_contract o where o.state=3 and t.customer=c.SerialNo  and t.subscription>0  and  c.serialno=o.customer and t.section=o.sectionNAME and c.section=o.section "+SQLwhere;
 
	   rs=ViewBean2.executeQuery(SQL);
	   
	   if (rs.next()){
	     out.print("<tr>");
   	     out.print("<td align='center'>"+rs.getInt("num")+"</td>");
		 double jzarea1=rs.getDouble("jzarea");
		 out.print("<td align='center'>"+Format.getFloat2(jzarea1,2)+"</td>");
   	     out.print("<td align='center'>"+Format.getFloat2((jzarea1/jzarea)*100,2)+"%</td></tr>");		 
	    }
	   rs.close();
	   }else if (td.equals("")){
	 SQL="select sum(o.jzarea) jzarea,count(*) num from TFRecord t,customer c,order_contract o where o.state=3 and t.customer=c.SerialNo    and  c.serialno=o.customer and t.section=o.sectionNAME and c.section=o.section "+SQLwhere;
 
	   rs=ViewBean2.executeQuery(SQL);
	   
	   if (rs.next()){
	     out.print("<tr>");
   	     out.print("<td align='center'>"+rs.getInt("num")+"</td>");
		 double jzarea1=rs.getDouble("jzarea");
		 out.print("<td align='center'>"+Format.getFloat2(jzarea1,2)+"</td>");
   	     out.print("<td align='center'>"+Format.getFloat2((jzarea1/jzarea)*100,2)+"%</td></tr>");		 
	    }
	   rs.close();
	   }
	 %>
</table>
 <% if (td.equals("1")){ %>
 
<table width="98%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF">
  
  <tr bgcolor='#EAECEC' align="center">  
    <td >&nbsp;序号</td>
    <td>客户姓名</td>
    <td>联系电话</td>
	<td>联系地址</td>
	<td>原认购日期</td>
	<td>挞定单位</td>
	<td>挞定面积</td>
	<td>挞定总价</td>
	<td>定金</td>
	<td>挞定原因</td>
		<td>挞定日期</td>
			<td>审批人</td>
  </tr>
<%
SQL="select o.date,c.cus_name,c.sj,c.phone,c.address,o.loft+o.room_no room,o.jzarea,o.rmbprice,o.subscription,t.tf_date,t.context,t.checker from TFRecord t,customer c,order_contract o where o.state=3 and t.customer=c.SerialNo  and t.subscription=0  and  c.serialno=o.customer and t.section=o.sectionNAME and c.section=o.section "+SQLwhere;
   rs=ViewBean2.executeQuery(SQL);
  
    i=1;
   while (rs.next()){
%>
 <tr align="center">  
    <td >&nbsp;<%=i %></td>
    <td>&nbsp;<%=getbyte(rs.getString("cus_name")) %></td>
    <td>&nbsp;<%=getbyte(rs.getString("sj"))+getbyte(rs.getString("phone")) %></td>
	<td>&nbsp;<%=getbyte(rs.getString("address")) %></td>
	<td>&nbsp;<%=rs.getDate("date").toString() %></td>
	<td>&nbsp;<%=getbyte(rs.getString("room")) %></td>
	<td>&nbsp;<%=getbyte(rs.getString("jzarea")) %></td>
	<td>&nbsp;<%=getbyte(rs.getString("rmbprice")) %></td>
	<td>&nbsp;<%=getbyte(rs.getString("subscription")) %></td>
	
	<td>&nbsp;<%=getbyte(rs.getString("context")) %></td>
	<td>&nbsp;<%=getbyte(rs.getDate("tf_date").toString()) %></td>
	<td>&nbsp;<%=getbyte(rs.getString("checker")) %></td>
  </tr>
<%i++;}
rs.close();
out.print(" </table>");
 }else  if (td.equals("2")){
 %>

 
<table width="98%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF">
  
  <tr bgcolor='#EAECEC' align="center">  
    <td >&nbsp;序号</td>
    <td>客户姓名</td>
    <td>联系电话</td>
	<td>联系地址</td>
	<td>原认购日期</td>
	<td>退房单位</td>
	<td>退房面积</td>
	<td>退房总价</td>
	<td>退定金</td>
	<td>退房原因</td>
		<td>退房日期</td>
			<td>审批人</td>
  </tr>
<%
SQL="select o.date,c.cus_name,c.sj,c.phone,c.address,o.loft+o.room_no room,o.jzarea,o.rmbprice,o.subscription,t.tf_date,t.context,t.checker from TFRecord t,customer c,order_contract o where o.state=3 and t.customer=c.SerialNo  and t.subscription>0  and  c.serialno=o.customer and t.section=o.sectionNAME and c.section=o.section "+SQLwhere;
   rs=ViewBean2.executeQuery(SQL);  
    i=1;
   while (rs.next()){
%>
 <tr align="center">  
    <td >&nbsp;<%=i %></td>
    <td>&nbsp;<%=getbyte(rs.getString("cus_name")) %></td>
    <td>&nbsp;<%=getbyte(rs.getString("sj"))+getbyte(rs.getString("phone")) %></td>
	<td>&nbsp;<%=getbyte(rs.getString("address")) %></td>
		<td>&nbsp;<%=rs.getDate("date").toString() %></td>
	<td>&nbsp;<%=getbyte(rs.getString("room")) %></td>
	<td>&nbsp;<%=getbyte(rs.getString("jzarea")) %></td>
	<td>&nbsp;<%=getbyte(rs.getString("rmbprice")) %></td>
	<td>&nbsp;<%=getbyte(rs.getString("subscription")) %></td>
	
	<td>&nbsp;<%=getbyte(rs.getString("context")) %></td>
	<td>&nbsp;<%=getbyte(rs.getDate("tf_date").toString()) %></td>
	<td>&nbsp;<%=getbyte(rs.getString("checker")) %></td>
  </tr>
<%i++;}
rs.close();
 }else  if (td.equals("")){
 
 %>
 
 
<table width="98%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF">
  
  <tr bgcolor='#EAECEC' align="center">  
    <td >&nbsp;序号</td>
    <td>客户姓名</td>
    <td>联系电话</td>
	<td>联系地址</td>
	<td>原认购日期</td>
	<td>退房单位</td>
	<td>退房面积</td>
	<td>退房总价</td>
	<td>退定金</td>
	<td>原因</td>
		<td>日期</td>
		<td>类别</td>
			<td>审批人</td>
  </tr>
<%
SQL="select o.date,c.cus_name,c.sj,c.phone,c.address,o.loft+o.room_no room,o.jzarea,o.rmbprice,o.subscription,t.tf_date,t.context,t.checker from TFRecord t,customer c,order_contract o where o.state=3 and t.customer=c.SerialNo  and t.subscription>0  and  c.serialno=o.customer and t.section=o.sectionNAME and c.section=o.section "+SQLwhere;
   rs=ViewBean2.executeQuery(SQL);  
    i=1;
   while (rs.next()){
    double  tdj=rs.getDouble("subscription");
%>
 <tr align="center">  
    <td >&nbsp;<%=i %></td>
    <td>&nbsp;<%=getbyte(rs.getString("cus_name")) %></td>
    <td>&nbsp;<%=getbyte(rs.getString("sj"))+getbyte(rs.getString("phone")) %></td>
	<td>&nbsp;<%=getbyte(rs.getString("address")) %></td>
		<td>&nbsp;<%=rs.getDate("date").toString() %></td>
	<td>&nbsp;<%=getbyte(rs.getString("room")) %></td>
	<td>&nbsp;<%=getbyte(rs.getString("jzarea")) %></td>
	<td>&nbsp;<%=getbyte(rs.getString("rmbprice")) %></td>
	<td>&nbsp;<%=getbyte(rs.getString("subscription")) %></td>
	
	<td>&nbsp;<%=getbyte(rs.getString("context")) %></td>
	<td>&nbsp;<%=getbyte(rs.getDate("tf_date").toString()) %></td>
	<td>&nbsp;<%if (tdj>0){out.print("退定");}else{out.print("挞定");}%></td>
	<td>&nbsp;<%=getbyte(rs.getString("checker")) %></td>
  </tr>
<%i++;}
rs.close();
  } %>
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
</script>
<input type="button" onclick="bringToExcel()" value="导出到Excel"><br>
导入前必须进行相应设置：<br>
　1.在IE工具栏中选择"internet选项"<br>
　2.选择"安全"->选择"本地intranet"后再点击"自定义级别"<br>
  3.把所有ActiveX启用都选中后点击确认退后。<br>
 
</body>

</html>
 