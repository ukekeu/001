<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 
<title>资金回笼表</title>
<script language=javascript src="js/mad.js"> </script>
<script language=javascript src="../public_js/basal.js"> </script>
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
</head>
<%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
 
<jsp:useBean id="fa" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
  <%
	
 
String Date2=request.getParameter("Date2");
String Date1=request.getParameter("Date1");
String SecNo=request.getParameter("SecNo");
String SecName="";
SecName=SecNo.substring(SecNo.indexOf("-")+1);
SecNo=SecNo.substring(0,SecNo.indexOf("-"));
String Loft=request.getParameter("Loft");
String sql="select sum(f.shouldMoney) shouldMoney ,sum(f.yijiao) yijiao,sum(f.shouldMoney)-sum(f.yijiao) qk, convert(char(7),f.shouldDate,120) shouldDate";
 
sql+=" from order_contract o,GatheringRecord f where";
sql+="  o.code=f.contactno and f.shouldMoney>0 and o.state<>3 and f.state<3   ";
if (!Loft.equals(""))
sql+=" and o.loft='"+Loft+"'";
sql+=" and o.section='"+SecNo+"' ";
if (!Date1.equals("")&&!Date2.equals(""))
sql+=" and convert(char(10),f.shouldDate,120)>='"+Date1+"' and convert(char(10),f.shouldDate,120)<='"+Date2+"'";
sql+=" group by convert(char(7),f.shouldDate,120)  ";
 
%>
<body >
<form action="rh_view.jsp" method="post" name="frm">
 <DIV align=center id="printdiv">
 <!--<input class="buttoninput" type="button" value="打印预览" onclick="window.printdiv.style.display='none';factory.printing.Preview();"> -->
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">&nbsp;<input type="button" name="Button1" value="导出到EXCEL" onClick="bringToExcel();">

 </div>

  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
  	 <div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >

 <center>
 <p align="center"><font size=4><b><%=Date1 %>至<%=Date2 %>项目计划回笼资金</b></font></p>



	<%
	int i=0;
	ResultSet rs=null;
	try{
		
	rs=ViewBean.executeQuery(sql);
	 
	//保存输入值的变量
     
 

   while (rs.next()){
	 
     i=i+1;
    
	 String shouldDate=rs.getString("shouldDate");
	 String shouldMoney=fa.getFloat3(rs.getDouble("shouldMoney"),2);
	 String yijiao=fa.getFloat3(rs.getDouble("yijiao"),2);
	 String qk=fa.getFloat3(rs.getDouble("qk"),2);	 
	if (i==1) {
  %>
  
 <table width="98%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<tr > 
<td  align="right">序号</td>
 
<td w align="center">年月</td>
<td  align="center">应收房款</td>
 <td  align="center">实收房款</td>
  <td  align="center">欠款</td>

<%} %>
 <tr id=TR<%=i %> align="center" > 
<td   align="center"><%=i %></td>
 <td  align="left">&nbsp; <%=shouldDate%></td>

<td  align="left"><%=shouldMoney%></td>
<td  align="left"><%=yijiao%></td>

<td  align="left"><%=qk%></td>
 
 
</tr> 
 <%
if (i==30){i=0;out.print("</table><br><br>"); }
}
rs.close();
  sql="select sum(f.shouldMoney) shouldMoney ,sum(f.yijiao) yijiao,sum(f.shouldMoney)-sum(f.yijiao) qk ";
 
sql+=" from order_contract o,GatheringRecord f where";
sql+="  o.code=f.contactno and f.shouldMoney>0 and o.state<>3 and f.state<3   ";
if (!Loft.equals(""))
sql+=" and o.loft='"+Loft+"'";
sql+=" and o.section='"+SecNo+"' ";
if (!Date1.equals("")&&!Date2.equals(""))
sql+=" and convert(char(10),f.shouldDate,120)>='"+Date1+"' and convert(char(10),f.shouldDate,120)<='"+Date2+"'";
 rs=ViewBean.executeQuery(sql);
if (rs.next()){
 
 %> 
  <tr  align="left"  > 
 <td  align="right">合计</td>
 
<td  >&nbsp;</td>
<td   ><%=fa.getFloat3(rs.getDouble("shouldMoney"),2) %></td>
 <td   ><%=fa.getFloat3(rs.getDouble("yijiao"),2) %></td>
  <td  ><%=fa.getFloat3(rs.getDouble("qk"),2) %></td>
</tr>
 <%
 }rs.close();
 }catch(Exception s){out.print(s.getMessage()+sql);out.close();} %>
 <br><br>
  </table>
  </center> 
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
</body>
 
</html>
