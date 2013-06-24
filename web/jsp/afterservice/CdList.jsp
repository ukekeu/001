<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 
 <jsp:useBean id="txt" scope="page" class="ConnDatabase.WriteToTxtBean"/>
<jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<title>输入打印报表条件</title>
<script language="JavaScript" src='../public_js/basal.js'></script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

</head>
<center>
<form name=frm method="post" action="rep_ajlist.jsp?codes=<%=request.getParameter("codes") %>">
  <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
  <input type="button" name="Button1" value="导出到EXCEL" onClick="bringToExcel();">

 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
 
  <div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >
  <P align="center">备注明细</p>
  <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
     <tr  > 
		<td  align="center">序号</td>
		<td  align="center">业主</td>
		 <td  align="center">备注日期</td>
		<td  align="center">备注</td>
   </tr>
  <%
   int num=0;
   int num2=0;
   String code="";
    String SecNo=request.getParameter("SecNo");
    String Loft=getbyte1(request.getParameter("Loft"));
   String Date1=request.getParameter("Date1");
   String Date2=request.getParameter("Date2");
   String ajbk=getbyte1(request.getParameter("ajbk"));
   String room=getbyte1(request.getParameter("room"));
   String whereSQL="";
   if (!Date1.equals("")&&!Date2.equals(""))
     whereSQL=" AND convert(char(10),bakdate,120)>='"+Date1+"' and convert(char(10),bakdate,120)<='"+Date2+"'";
  if (!SecNo.equals(""))
  whereSQL+=" and o.section='"+SecNo+"'";
    if (!Loft.equals(""))
  whereSQL+=" and o.Loft='"+Loft+"'";
     if (!ajbk.equals(""))
  whereSQL+=" and o.ajbk='"+ajbk+"'";
    if (!room.equals(""))
  whereSQL+=" and o.room_no='"+room+"'";
   String sql="SELECT o.sectionname+o.loft+o.room_no+'('+c.cus_name+')' room,q.bak,q.bakdate,q.state FROM order_contract o,customer c,cq_bak q WHERE o.code=q.contractno and  c.serialno=o.customer and o.state<>3 "+whereSQL;
   ResultSet rs = ViewBean.executeQuery(sql);
 
    int ii=1;
  int j=1;
 while (rs.next()){
    String cusname=getbyte(rs.getString("room"));
	String bak=getbyte(rs.getString("bak"));
	
	String bakdate=getbyte(rs.getString("bakdate"));
	if (!bakdate.equals(""))bakdate=bakdate.substring(0,10);
	String state=getbyte(rs.getString("state"));
   if (state.equals("1"))state="(业主要求不办产权)";
 
  %>
     <tr  > 
 
	    <td  align="center"><%=ii %></td>
		<td  align="center"><%=cusname %></td>
		<td  align="center"><%=bakdate %></td>
		<td  align="center"><%=bak+state %></td>
		
		 	<%
	   %>
     </tr  > 
   <% 
  
   ii++;
   
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
  opener.window.location.reload();
</script>

</body>       
</html>       
