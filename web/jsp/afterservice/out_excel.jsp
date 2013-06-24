<%@ page contentType="text/html;charset=GBK" %>

 
<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 
<title>销售明细表</title>
 
</head>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
 <%@ include file="../public_js/getByteOut.jsp"%>

 
<% 
 
 
 
  String stdate = China.getParameter(request,"Date1") ;
  String endate = China.getParameter(request,"Date2") ;
  String SectionName=China.getParameter(request,"SecNo") ; 
  String Region = China.getParameter(request,"Region") ; 
   String room=getbyte1(request.getParameter("room"));
  String Loft=getbyte1(request.getParameter("Loft"));
  String yong_tu=getbyte1(request.getParameter("yong_tu"));

   String sql=""; 
   sql="select    * from SALE_VIEW_ZQQ where   seccode='"+SectionName+"' ";
    if (!Loft.equals(""))
	  sql+=" and loft='"+Loft+"' ";
	   if (!room.equals(""))
	  sql+=" and Room_no='"+room+"'";
	    if (!yong_tu.equals(""))
	  sql+=" and yong_tu='"+yong_tu+"'";
  sql+=" order by loft,floor,room,room_no";
 
   int nn=0;
   double sump=0;
   double suma=0;
   double suml=0;
  double sum2=0;
   double sum3=0;
   double sum4=0;
   double sum5=0;
 %>


  
<body>
<form action="rgsview.jsp" method="post" name="frm">
  
<div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >
 <font size=3><div id=tit align="center">出售情况表  </div></font>
 
 <table width="99%"><tr><td colspan="3">时间段:<%=China.getParameter(request,"Date1")%>到<%=China.getParameter(request,"Date2") %></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></table>
 
 <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

 <tr  > 
<td  align="right">序号</td>
 <td  align="right">房号</td>
<td  align="center">购房人(单位)名称</td>
<td  align="center">建筑面积</td>
<td align="center">售 价(M<sup>2</sup>)</td>
<td w align="center">产价(M<sup>2</sup>)</td>

<td  align="center">权属来源</td>
<td  align="center">备注</td>
  
	<%
	ResultSet rs=null;
	try{
		 
	rs=ViewBean.executeQuery(sql);
	 
	 
	int i=0;
 
   while (rs.next()){
	 i++;
	  
     String sectionname =getbyte(rs.getString("sectionname"));
      room=getbyte(rs.getString("loft"))+getbyte(rs.getString("room_no"));
	  String cus_name =getbyte(rs.getString("cus_name"));
     String jzarea=FormtD.getFloat(rs.getFloat("jzarea"),3);
 
	 String unitprice=FormtD.getFloat2(rs.getDouble("unitprice"),2);
	 
  %>
 <tr   align="center">
<td   align="center"><%=i %></td>
<td  align="left">&nbsp;<%=room %></td>
 <td  align="left">&nbsp;<%=cus_name %></td>
<td   align="center">&nbsp;<%=jzarea%>　</td>
 
<td  align="left">&nbsp; <%=unitprice %></td>
  
<td  align="right">&nbsp; </td>
 <td  align="right">&nbsp; </td>
 <td  align="right">&nbsp; </td>
</tr> 
 <%
 }
rs.close();  
 
 %>
    
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
 
  <%
}catch(Exception s){out.print(s.getMessage()+sql);out.close();}
  %>
 
 
 
</body>
 
</html>
