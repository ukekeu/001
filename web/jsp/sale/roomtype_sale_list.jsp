<%@ page contentType="text/html;charset=GBK" %>

 
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 
<title>按户型统计销售情况</title>
 
</head>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/checktime.jsp"%>
 
<% 
 
 
 
  String stdate = China.getParameter(request,"Date1") ;
  String endate = China.getParameter(request,"Date2") ;
  String SectionName=China.getParameter(request,"SecNo") ; 
  String Region = China.getParameter(request,"Region") ; 
   String room=getbyte1(request.getParameter("room"));
  String Loft=getbyte1(request.getParameter("Loft")); 

   String sql=""; 
 
 %>
 
<body>
<form action="rgsview.jsp" method="post" name="frm">
   	<DIV align=center id="printdiv">
 <input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" name="Button1" value="导出到EXCEL" onClick="bringToExcel();">
<br>
<table><tr><td>导入前必须进行相应设置：</td></tr>
<tr><td>　1.在IE工具栏中选择"internet选项"</td></tr>
<tr><td>　2.选择"安全"->选择"本地intranet"后再点击"自定义级别"</td></tr>
<tr><td>　3.把所有ActiveX启用都选中后点击确认退后。</td></tr>
</table>
 
 
 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >
 <font size=3><div id=tit align="center">户型销售统计表</div></font>
 
 <table width="80%"><tr><td colspan="3">时间段:<%=China.getParameter(request,"Date1")%>到<%=China.getParameter(request,"Date2") %></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></table>
  <p>按项目楼栋统计</p>
 <table width="80%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
 <tr align="center">
    <td   rowspan="2">序号</td>
    <td   rowspan="2">楼栋</td>
    <td   rowspan="2">户型</td>
    <td   rowspan="2">可售面积</td>
    <td   rowspan="2">可售套数</td>
    <td   colspan="2">已售面积</td>
    <td  colspan="2">已售套数</td>
  </tr>
  <tr align="center">
    <td >面积</td>
    <td  >比重</td>
    <td  >套数</td>
    <td  >比重</td>
  </tr>

<%
double sumarea=0;
double sumarea1=0;
int sumnum=0;
int sumnum1=0;
String SQL="SELECT loft,ROOMTYPE,SUM(area) area,count(*) num from room where roomtype<>'' and seccode='"+SectionName+"'";
 if (!Loft.equals(""))
	  SQL+=" and loft='"+Loft+"' ";
	   SQL+=" group by loft,roomtype order by loft ";
ResultSet rs=null;
ResultSet rs1=null;
	try{
		 
	rs=ViewBean.executeQuery(SQL);
	 
	 
	int i=0;
 
   while (rs.next()){
   i++;
   String ld=rs.getString("Loft");
   String fx=rs.getString("ROOMTYPE") ;
   double ksarea=rs.getDouble("area") ;

   int kst=rs.getInt("num");
   sumnum+=kst;
   sumarea+=ksarea;
 %>
 
 <tr  > 
<td  align="right"><%=i %></td>
 
<td  align="center"><%=ld %></td>
<td  align="center"><%=fx%></td>
 
<td align="center" ><%=FormtD.getFloat3(ksarea,2)%></td> 
<td align="center"><%= kst%></td> 
<%
   
   sql="select    sum(jzarea) area,count(*)  num from order_contract   where  state<>3 and convert(char(10),date,120)>='"+stdate+"' and convert(char(10),date,120)<='"+endate+"' and section='"+SectionName+"'  and loft='"+ld+"' and roomtype='"+fx+"'";
 rs1=ViewBean1.executeQuery(sql);
 
  double yarea=0;
  int nn=0;
  if (rs1.next()){
     yarea=rs1.getDouble("area");
	 nn=rs1.getInt("num");
	  sumnum1+=nn;
   sumarea1+=yarea;
  
  }
  rs1.close();
  %>
<td align="center"><%=FormtD.getFloat3(yarea,2) %> </td> 
<td align="center"><%=FormtD.getFloat3(yarea/ksarea*100,2) %>%</td> 
<td align="center"><%=nn %></td> 
<td align="center"><%=FormtD.getFloat2(nn*1.0/kst*100,2)  %>%</td> 
</tr>
<%}
rs.close(); %>
<tr align="center" ><td>合计:</td><td>&nbsp;</td><td>&nbsp;</td>
<td><%=FormtD.getFloat3(sumarea,2) %></td><td><%=sumnum %></td>
<td><%=FormtD.getFloat3(sumarea1,2) %></td><td><%=FormtD.getFloat3(sumarea1/sumarea*100,2) %>% </td>
<td><%=FormtD.getFloat3(sumnum1,2) %></td><td><%=FormtD.getFloat2(sumnum1*1.0/sumnum*100,2) %>%  </td>

</tr>
 </table>
  <p>按项目统计</p>
 
 <table width="80%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
 <tr align="center">
    <td   rowspan="2">序号</td>
 
    <td   rowspan="2">户型</td>
    <td   rowspan="2">可售面积</td>
    <td   rowspan="2">可售套数</td>
    <td   colspan="2">已售面积</td>
    <td  colspan="2">已售套数</td>
  </tr>
  <tr align="center">
    <td >面积</td>
    <td  >比重</td>
    <td  >套数</td>
    <td  >比重</td>
  </tr>

<%
  SQL="SELECT ROOMTYPE,SUM(area) area,count(*) num from room where roomtype<>'' and seccode='"+SectionName+"'";
 if (!Loft.equals(""))
	  SQL+=" and loft='"+Loft+"' ";
	   SQL+=" group by  roomtype  ";
 
	 
		 
	rs=ViewBean.executeQuery(SQL);
	 
	 
	  i=0;
 
   while (rs.next()){
   i++;
  
   String fx=rs.getString("ROOMTYPE") ;
   double ksarea=rs.getDouble("area") ;
   int kst=rs.getInt("num");
 %>
 
 <tr  > 
<td  align="right"><%=i %></td>
 
 
<td  align="center"><%=fx%></td>
 
<td align="center" ><%=FormtD.getFloat3(ksarea,2)%></td> 
<td align="center"><%= FormtD.getFloat3(kst,2)%></td> 
<%
   
   sql="select    sum(jzarea) area,count(*)  num from order_contract   where  state<>3 and convert(char(10),date,120)>='"+stdate+"' and convert(char(10),date,120)<='"+endate+"' and section='"+SectionName+"'   and roomtype='"+fx+"'";
 rs1=ViewBean1.executeQuery(sql);
 
  double yarea=0;
  int  nn=0;
  if (rs1.next()){
     yarea=rs1.getDouble("area");
	 nn=rs1.getInt("num");
  
  }
  rs1.close();
  %>
<td align="center"><%=FormtD.getFloat3(yarea,2) %> </td> 
<td align="center"><%=FormtD.getFloat3(yarea/ksarea*100,2) %>%</td> 
<td align="center"><%=nn %></td> 
<td align="center"><%=FormtD.getFloat2(nn*1.0/kst*100,2)  %>%</td> 
</tr>
<%}
rs.close(); %>

<tr align="center" ><td>合计:</td><td>&nbsp;</td>
<td><%=FormtD.getFloat3(sumarea,2) %></td><td><%=sumnum %></td>
<td><%=FormtD.getFloat3(sumarea1,2) %></td><td><%=FormtD.getFloat3(sumarea1/sumarea*100,2) %>% </td>
<td><%=FormtD.getFloat3(sumnum1,2) %></td><td><%=FormtD.getFloat2(sumnum1*1.0/sumnum*100,2) %>%  </td>

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
     oSheet.Paste();     
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
</script> 
 
  <%
}catch(Exception s){out.print(s.getMessage()+sql);out.close();}
  %>
 
 
 
</body>
 
</html>
