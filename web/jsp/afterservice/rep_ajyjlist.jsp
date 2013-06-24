<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
	<title>按揭移交明细表</title>
</head>
<script>
self.resizeTo(screen.availWidth,screen.availHeight)
self.moveTo(0,0)
self.focus()
</script>

<body>
 <%@ page language="java" import="java.sql.*,common.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="UpdateRs" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="txt" scope="page" class="ConnDatabase.WriteToTxtBean"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
  
<form name=rep>
<br><br>
<div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >
 <table width="100%"  border=0 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center">
  <td  rowspan="2"><font size=5>广东龙光(集团)有限公司<br>&nbsp;<br>&nbsp;此位置填写银行名称</font></td>
  <td><font size=5>按揭房地产权证移交明细表</font></td> 
  </tr>
  </table>
 <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center">
  <td>序号</td>  <td>姓名</td>  <td>地址</td>  <td>新房号</td>
    <td>旧房号</td>  <td>房地产权证号</td>  <td>备注</td>
  </tr>	
 <%
   String PARA_SQL=China.getParameter(request,"PARA_SQL");//表名
   String constractno=China.getParameter(request,"url1");
   String if_name=China.getParameter(request,"if_name");
   String if_value=China.getParameter(request,"if_value");
   String reporttype=request.getParameter("reporttype1");//报表类别/sale:为销售报表,finace:为财务报表
   String tablename=request.getParameter("tablename1");//如果在VIEW中使用特殊function,则只能更新Table Name
   String ifvalue[]=request.getParameterValues("ifvalue");//读取条件值
   String reportState=China.getParameter(request,"reportState");
  
   String WhereSQL="";
   String WhereSQL1="";
   String SqlStr="";
   String TableNameStr=""; 

 for (int ii=0;ii<ifvalue.length;ii++){//转换值成为组合条件
   if (WhereSQL.equals(""))WhereSQL=getbyte1(ifvalue[ii]);
   else WhereSQL+="  "+getbyte1(ifvalue[ii]);
 }
 
  
TableNameStr=PARA_SQL;
  if (tablename==null)tablename="";
  if (!tablename.equals(""))TableNameStr=tablename;
  if(TableNameStr.equals("SaleCountPic_View"))TableNameStr="rgsview";
   SqlStr="select cus_name,sectionname,cq_newroom,romno,cq_no,cq_bak from "+TableNameStr+"     where " +  WhereSQL;
  int i=1;
try{

  ResultSet rs=InsertBean.executeQuery(SqlStr);
 while (rs.next()){%>
 <tr>
  <td><%=i %></td>  <td><%=getbyte(rs.getString("cus_name")) %>&nbsp;</td> 
   <td><%=getbyte(rs.getString("sectionname")) %>&nbsp;</td> 
    <td><%=getbyte(rs.getString("cq_newroom")) %>&nbsp;</td>
    <td><%=getbyte(rs.getString("romno")) %>&nbsp;</td>
	  <td><%=getbyte(rs.getString("cq_no")) %>&nbsp;</td> 
	   <td><%=getbyte(rs.getString("cq_bak")) %>&nbsp;</td>
 
 
 
 </tr>

 <%i++;}
}catch(Exception s){out.print(s.getMessage()+SqlStr);out.close();}
 

%>
</table>
<p align="center">移交以上本房地产权证</p>
 <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="left">
  <td>移交方：</td>  <td>接收方：</td>
  </tr>
   <tr  align="left">
  <td>经办人：</td>  <td>经办人：</td>
  </tr>
    <tr  align="left">
  <td>日期：</td>  <td>日期：</td>
  </tr>
  </table>
  <br>
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