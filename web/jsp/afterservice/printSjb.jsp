<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 
<title>����ע�Ǳ�</title>
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

String codes=getbyte1(request.getParameter("codes")); 
if (!codes.equals(""))
ViewBean.executeUpdate("update order_contract  set song_jian_date=getdate() where cq=1 and code in("+codes+")");
String Date2=getbyte1(request.getParameter("Date2"));
String Date1=getbyte1(request.getParameter("Date1"));
String SecNo=getbyte1(request.getParameter("SecNo"));
String Loft=getbyte1(request.getParameter("Loft"));
String Build=getbyte1(request.getParameter("Build"));
String yh=getbyte1(request.getParameter("ajbk"));
String sql="select c.cus_name,o.sectionname,o.cq_newroom,o.loft+o.building+o.room_no room,song_jian_date,o.ajbk ";
sql+="from order_contract o,customer c where";
sql+=" o.customer=c.serialno and  o.state<>3 ";
if (codes.equals(""))
sql+=" and not o.song_jian_date is null ";
if (!Loft.equals(""))
sql+=" and o.loft='"+Loft+"'";
if (!yh.equals(""))
sql+=" and o.AjBk='"+yh+"'";
if (!Date1.equals("")&&!Date2.equals(""))
sql+=" and convert(char(10),o.song_jian_date,120)>='"+Date1+"' and convert(char(10),o.song_jian_date,120)<='"+Date2+"'";
if (!codes.equals(""))
sql+=" and o.code in("+codes+")";
if (!SecNo.equals(""))

sql+=" and o.section='"+SecNo+"' ";
sql+=" order by o.loft+o.building+o.room_no";
 
%>
<body >
<form action="rh_view.jsp" method="post" name="frm">
 <DIV align=center id="printdiv">
 <!--<input class="buttoninput" type="button" value="��ӡԤ��" onclick="window.printdiv.style.display='none';factory.printing.Preview();"> -->
 <br><input type="button" name="Button" value="��ӡԤ��" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">&nbsp;<input type="button" name="Button1" value="������EXCEL" onClick="bringToExcel();">

 </div>

  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
  	 <div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >

 <center>
 <p align="center"><font size=4><b>�ͼ���</b></font></p>



	<%
	int i=0;
	ResultSet rs=null;
	 
	rs=ViewBean.executeQuery(sql);
	 
	//��������ֵ�ı���
     
 

   while (rs.next()){
	 
     i=i+1;
    // String code=rs.getString("ID");
	 String sectionname=getbyte(rs.getString("sectionname"));
     String Customer=getbyte(rs.getString("cus_name"));
	 String cq_newroom=getbyte(rs.getString("cq_newroom"));
	 String room=getbyte(rs.getString("room"));
	 String ajbk=getbyte(rs.getString("ajbk"));
	 
	if (i==1) {
  %>
  
 <table width="98%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<tr > 
<td  align="right">���</td>

<td  align="center">�ͻ�����</td>
<td  align="center">��    ַ</td>
<td  align="center">�·���</td>
<td  align="center">�ɷ���</td>
<td  align="center">����</td>
<td  align="center">��ע</td>
<%} %>
 <tr id=TR<%=i %> align="center" > 
<td   align="center"><%=i %></td>
<td  align="left">&nbsp; <%=Customer%></td>
<td   align="left">&nbsp; <%=sectionname%> </td>

<td  align="left">&nbsp; <%=cq_newroom%></td>
<td  align="left">&nbsp; <%=room%></td>
<td  align="left">&nbsp; <%=ajbk%></td>
<td  align="left">&nbsp;  </td>
 
 
</tr> 
 <%
if (i==30){i=0;out.print("</table><br><br>"); }
}
rs.close();
  if (i<30){i=0;out.print("</table><br><br>");}
%> 
 <br><br>
 
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
 opener.window.location.reload();
  </script>
</body>
 
</html>
