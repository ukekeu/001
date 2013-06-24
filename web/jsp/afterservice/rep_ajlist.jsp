<%@ page contentType="text/html;charset=GBK" %>

<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
	<title>银行按揭明细表</title>
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
  <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
 <%@ include file="../public_js/getByteOut.jsp"%>
  
<form name=rep>
<DIV align=center id="printdiv">
 <input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" onclick="bringToExcel()" value="导出到Excel"> 
 <br>
 <font size=1>
导入前必须进行相应设置： 
　1.在IE工具栏中选择"internet选项" 
　2.选择"安全"->选择"本地internet"后再点击"自定义级别" 
  3.把所有ActiveX启用都选中后点击确认退后。 </font>
  </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<div align=left id=report1 style="height:100%;overflow:auto;width:100%;z-index:2" contentEditable >

 <table width="99%"  border=0 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center">
  <td  rowspan="2"><font size=5> <%=getbyte1(request.getParameter("bk")) %>银行按揭明细表</font></td> 
  </tr>
  </table>
  <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

   <tr>
   <td rowspan="2" >序号</td><td rowspan="2" >姓名</td>  <td rowspan="2" >座落</td>  <td rowspan="2" >面积</td>  <td rowspan="2" >总价</td>
    <td rowspan="2" >合同签订日期</td><td rowspan="2" >自有资金</td>  <td rowspan="2" >按揭资金</td>  <td colspan="2">按揭期</td>
      <td rowspan="2" >呈批日期</td>  <td rowspan="2" >批准日期</td>  <td rowspan="2" >国土登记日期</td>  <td rowspan="2" >备注</td>
　  </tr>
   <tr>
  <td>年期</td>
  <td>始　终</td>
   </tr>
  
 <%
String  codes=request.getParameter("codes");
String  checkedAj=getbyte(request.getParameter("checkedAj"));
String  ajDate=getbyte(request.getParameter("ajDate"));
String  bank_person=getbyte(request.getParameter("bank_person"));
 String loft="",section="";
   
 String  SqlStr="select section,loft,roomno,cus_name,sectionname,jzarea,salerprice,visadate,salerprice-ajmoney first,ajmoney,ajyear,case when AjDate is null then AjDate else dateadd(yy,ajyear,ajdate)   end endd,ajdate,aj_send_date,aj_gt_dj_date,convert(char(10),fkdate,120) fkdate from viewsalelist    where payment1 like '%揭%' and  not visadate is null and  code in ("+codes+")";
  int i=1;
 
try{
String sql="update order_contract set aj_type="+request.getParameter("aj_type")+",aj_send_date='"+request.getParameter("ajDate1")+"',AjBk='"+getbyte1(request.getParameter("bk"))+"'";
if (checkedAj.equals("1")){
sql+=",bank_person='"+bank_person+"',ajdate='"+ajDate+"'";
}
sql+=" where payment1 like '%揭%' and  not visadate is null and    code in ("+codes+")";
 
 InsertBean.executeUpdate(sql);
  
  ResultSet rs=InsertBean.executeQuery(SqlStr);

 while (rs.next()){
 section=getbyte(rs.getString("section"));
  loft=getbyte(rs.getString("loft"));
%>
    <tr  align="center">
   <td ><%=i %></td> 
   <td><%=getbyte(rs.getString("cus_name")) %>&nbsp;</td>
	 <td ><%=getbyte(rs.getString("roomno")) %>&nbsp;</td>
	 <td ><%=FormtD.getFloat1(rs.getFloat("jzarea"),2) %>&nbsp;</td>
	 <td ><%= FormtD.getFloat(rs.getFloat("salerprice"),2) %>&nbsp;</td> 
	 <td ><%=getbyte(rs.getString("visadate")) %>&nbsp;</td>
     <td ><%=FormtD.getFloat(rs.getFloat("first"),2) %>&nbsp;</td>
	 <td ><%=FormtD.getFloat(rs.getFloat("ajmoney"),0) %>&nbsp;</td>
	 <td ><%=getbyte(rs.getString("ajyear")) %>&nbsp;</td>
	 <%String ajsd=getbyte(rs.getString("ajdate")) ;
	   String ajed=getbyte(rs.getString("endd")); 
	   if (!ajsd.equals(""))ajsd=ajsd.substring(0,10);
   	   if (!ajed.equals(""))ajed=ajed.substring(0,10);
	 %>
     <td><%=ajsd %>--<%=ajed %></td>
      <td ><%String aj_send_date= getbyte(rs.getString("aj_send_date"));
	       if (!aj_send_date.equals(""))out.print(aj_send_date.substring(0,10));
	   %>&nbsp;</td> 
	  <td ><%
	     String ajdate =getbyte(rs.getString("ajdate"));
		 if (!ajdate.equals(""))out.print(ajdate.substring(0,10));
		  %>&nbsp;</td>
	  <td ><%String aj_gt_dj_date=getbyte(rs.getString("aj_gt_dj_date"));
	       if (!aj_gt_dj_date.equals(""))out.print(aj_gt_dj_date.substring(0,10));
	  
	   %>&nbsp;</td>
	  <td ><%=getbyte(rs.getString("fkdate")) %>&nbsp;</td>
     </tr>
   <%i++;
  }
 rs.close();
}catch(Exception s){out.print(s.getMessage()+SqlStr);out.close();}
 %>
</table>
 
  
  <br>
  </div>
 
<script>
opener.window.location="AjListS.jsp?SecNo=<%=section %>&Loft=<%=loft %>";
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
 // opener.document.forms[0].submit();
</script>
