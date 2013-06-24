<%@ page contentType="text/html;charset=GBK" %>

 
<html>
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
  String yong_tu=getbyte1(request.getParameter("yong_tu"));
  ResultSet rs=null;
	ResultSet rs1=null;	
   String sql=""; 
   String sectionname="";
   sql="select name from crm_project where serialno='"+SectionName+"'";
   rs=ViewBean.executeQuery(sql);
	if (rs.next())sectionname=rs.getString("name");
	rs.close();
   sql="select    * from room where  seccode='"+SectionName+"'";
   sql+=" and not seccode+loft+room_code in ( select section+loft+room_no from order_contract where   state<>3  and  section='"+SectionName+"' ";
    if (!Loft.equals(""))
	  sql+=" and loft='"+Loft+"' ";
   sql+= "and convert(char(10),date,120)<='"+stdate+"')";
       if (!Loft.equals(""))
	  sql+=" and loft='"+Loft+"' order by loft,room_code";
	 
   int nn=0;
   double a1=0;
   double a2=0;
   int a3=0;
  double b1=0;
   double b2=0;
   int b3=0;
   
   double c1=0;
   double c2=0;
   int c3=0;
 %>


  
<body>
<form action="rgsview.jsp" method="post" name="frm">
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<div align=left id=report1 style="background-color:#F7F7F7;height:100%px;overflow:auto;width:100%;z-index:2" contentEditable >
 <font size=3><div id=tit align="center"><%=sectionname %>-未售情况明细表(截止日期：<%=stdate %>)  </div></font>
 
 <p>&nbsp;</p>
 <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

 <tr  > 
<td  align="right">序号</td>
 
<td  align="center">栋号</td>

<td  align="center">房号</td>
<td  align="center">用途</td>
<td align="center">户型</td>
<td w align="center">建筑面积</td>
<td w align="center">套内面积</td> 
<td w align="center">建筑面积单价</td>
<td w align="center">预售总价</td>
 
 
 
	<%
	
	int i=0;
	 try{
		 
	rs=ViewBean.executeQuery(sql);
	 
	 

 
   while (rs.next()){
	 i++;
	  
  %>
 <tr   align="center">
<td   align="center"><%=i %></td>
 
<td   align="left">&nbsp;<%=getbyte(rs.getString("loft"))%>　</td>
 <td   align="left">&nbsp;<%=getbyte(rs.getString("room_code"))%>　</td>
 <td   align="left">&nbsp;<%=getbyte(rs.getString("yong_tu"))%>　</td>
 <td   align="center"><%=getbyte(rs.getString("roomtype"))%>　</td>
 
<td    align="right"><%=getbyte(rs.getString("area"))%>　</td>
<td  align="right"><%=getbyte(rs.getString("usedarea")) %></td>
<td   align="center"><%=getbyte(rs.getString("unitprice"))%>　</td>
 
<td    align="right"><%=getbyte(rs.getString("sumprice")) %>　</td>
 
 

 
 
</tr> 
 <%
 }
rs.close();  
 }catch(Exception s){out.print(s.getMessage() );out.close();}%>
   
 </table>
 
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
</script><DIV align=center id="printdiv">
<input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'"><input type="button" onclick="bringToExcel()" value="导出到Excel"><br>
导入前必须进行相应设置：<br>
　1.在IE工具栏中选择"internet选项"<br>
　2.选择"安全"->选择"本地intranet"后再点击"自定义级别"<br>
  3.把所有ActiveX启用都选中后点击确认退后。<br>
 
  
 </div>
 
 
</body>
 
</html>
