<%@ page contentType="text/html;charset=GBK" %>

 
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 
<title>������ͳ���������</title>
 
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
 <input type="button" name="Button" value="��ӡԤ��" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" name="Button1" value="������EXCEL" onClick="bringToExcel();">
<br>
<table><tr><td>����ǰ���������Ӧ���ã�</td></tr>
<tr><td>��1.��IE��������ѡ��"internetѡ��"</td></tr>
<tr><td>��2.ѡ��"��ȫ"->ѡ��"����intranet"���ٵ��"�Զ��弶��"</td></tr>
<tr><td>��3.������ActiveX���ö�ѡ�к���ȷ���˺�</td></tr>
</table>
 
 
 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >
 <font size=3><div id=tit align="center">��������ͳ�Ʊ�</div></font>
 
 <table width="80%"><tr><td colspan="3">ʱ���:<%=China.getParameter(request,"Date1")%>��<%=China.getParameter(request,"Date2") %></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></table>
  <p>����Ŀ¥��ͳ��</p>
 <table width="80%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
 <tr align="center">
    <td   rowspan="2">���</td>
    <td   rowspan="2">¥��</td>
    <td   rowspan="2">����</td>
    <td   rowspan="2">�������</td>
    <td   rowspan="2">��������</td>
    <td   colspan="2">�������</td>
    <td  colspan="2">��������</td>
  </tr>
  <tr align="center">
    <td >���</td>
    <td  >����</td>
    <td  >����</td>
    <td  >����</td>
  </tr>

<%
double sumarea=0;
double sumarea1=0;
int sumnum=0;
int sumnum1=0;
String SQL="SELECT loft,Direction,SUM(area) area,count(*) num from room where Direction<>'' and seccode='"+SectionName+"'";
 if (!Loft.equals(""))
	  SQL+=" and loft='"+Loft+"' ";
	   SQL+=" group by loft,Direction order by loft ";
ResultSet rs=null;
ResultSet rs1=null;
	try{
		 
	rs=ViewBean.executeQuery(SQL);
	 
	 
	int i=0;
 
   while (rs.next()){
   i++;
   String ld=rs.getString("Loft");
   String fx=rs.getString("Direction") ;
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
  sql="select    sum(o.jzarea) area,count(*)  num from order_contract o,room r   where o.section+o.loft+o.room_no=r.seccode+r.loft+r.room_code and o.state<>3 and convert(char(10),o.date,120)>='"+stdate+"' and convert(char(10),o.date,120)<='"+endate+"' and o.section='"+SectionName+"'   and r.Direction='"+fx+"'";
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
<tr align="center" ><td>�ϼ�:</td><td>&nbsp;</td><td>&nbsp;</td>
<td><%=FormtD.getFloat3(sumarea,2) %></td><td><%=sumnum %></td>
<td><%=FormtD.getFloat3(sumarea1,2) %></td><td><%=FormtD.getFloat3(sumarea1/sumarea*100,2) %>% </td>
<td><%=FormtD.getFloat3(sumnum1,2) %></td><td><%=FormtD.getFloat2(sumnum1*1.0/sumnum*100,2) %>%  </td>

</tr>
 </table>
  <p>����Ŀͳ��</p>
 
 <table width="80%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
 <tr align="center">
    <td   rowspan="2">���</td>
 
    <td   rowspan="2">����</td>
    <td   rowspan="2">�������</td>
    <td   rowspan="2">��������</td>
    <td   colspan="2">�������</td>
    <td  colspan="2">��������</td>
  </tr>
  <tr align="center">
    <td >���</td>
    <td  >����</td>
    <td  >����</td>
    <td  >����</td>
  </tr>

<%
  SQL="SELECT Direction,SUM(area) area,count(*) num from room where Direction<>'' and seccode='"+SectionName+"'";
 if (!Loft.equals(""))
	  SQL+=" and loft='"+Loft+"' ";
	   SQL+=" group by  Direction  ";
 
	 
		 
	rs=ViewBean.executeQuery(SQL);
	 
	 
	  i=0;
 
   while (rs.next()){
   i++;
  
   String fx=rs.getString("Direction") ;
   double ksarea=rs.getDouble("area") ;
   int kst=rs.getInt("num");
 %>
 
 <tr  > 
<td  align="right"><%=i %></td>
 
 
<td  align="center"><%=fx%></td>
 
<td align="center" ><%=FormtD.getFloat3(ksarea,2)%></td> 
<td align="center"><%= FormtD.getFloat3(kst,2)%></td> 
<%
   
   sql="select    sum(o.jzarea) area,count(*)  num from order_contract o,room r   where o.section+o.loft+o.room_no=r.seccode+r.loft+r.room_code and o.state<>3 and convert(char(10),o.date,120)>='"+stdate+"' and convert(char(10),o.date,120)<='"+endate+"' and o.section='"+SectionName+"'   and r.Direction='"+fx+"'";
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

<tr align="center" ><td>�ϼ�:</td><td>&nbsp;</td>
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
