<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>查询</title>
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
    <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
 <%@ include file="../public_js/getByteOut.jsp"%>
  
<form name=rep>
<br><br>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<div align=left id=report1 style="background-color:#F7F7F7;height:100%px;overflow:auto;width:100%;z-index:2" contentEditable >
 <table width="99%"  border=0 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center">
    <td><font size=5>查询明细结果</font></td> 
  </tr>
  </table>
 <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center">
  <td>序号</td>  <td>项目</td>  <td>付款方式</td> <td>折扣</td> <td>总价</td> <td>变更差额</td>
   
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
   SqlStr="select sectionName+Loft+building+room_no roomno,payment1,disc, rmbprice,rg_sumprice-rmbprice c  from order_contract     where state<>3 and  " +  WhereSQL;
  int i=1;
   double cc=0;
    double ccc=0;
 int nn=0;
try{

  ResultSet rs=InsertBean.executeQuery(SqlStr);
 while (rs.next()){%>
 <tr>
  <td><%=i %></td>  <td><%=getbyte(rs.getString("roomno")) %>&nbsp;</td> 
  <td><%=getbyte(rs.getString("payment1")) %>&nbsp;</td> 
  <td><%=getbyte(rs.getString("disc")) %>&nbsp;</td>
  <td><%=getbyte(rs.getString("rmbprice")) %>&nbsp;</td>
  <td><%=getbyte(rs.getString("c")) %>&nbsp;</td> 
 
 </tr>
 <%i++;}

 SqlStr="select  sum(rmbprice) s,sum(rg_sumprice-rmbprice) c ,count(*) num,payment1 from order_contract     where state<>3 and      " +  WhereSQL+" group by payment1";

 rs.close();
 rs=InsertBean.executeQuery(SqlStr);
  while (rs.next()){
     float c=rs.getFloat("c");
	  float s=rs.getFloat("s");
	 cc+=c;
	  ccc+=s;
	 int a=rs.getInt("num");
	 nn+=a;
 %>
<tr><td>小计:</td><td><%=FormtD.getFloat(s,2) %></td>
<td><%=FormtD.getFloat(c,2) %></td>
<td><%=a%></td>
<td><%=getbyte(rs.getString("payment1")) %></td><td>&nbsp;</td>
</tr>
<%}
}catch(Exception s){out.print(s.getMessage()+SqlStr);out.close();} %>

<tr><td>合计:</td><td><%=FormtD.getFloat2(ccc,2) %> </td>
<td><%=FormtD.getFloat2(cc,2) %></td>
<td><%=nn%></td>
<td>&nbsp;</td><td>&nbsp;</td>
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
<DIV align=center id="printdiv">
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
  <input type="button" onclick="bringToExcel()" value="导出到Excel"> 
<br>导入前必须进行相应设置：<br>
　1.在IE工具栏中选择"internet选项"<br>
　2.选择"安全"->选择"本地intranet"后再点击"自定义级别"<br>
  3.把所有ActiveX启用都选中后点击确认退后。<br>
 </div>