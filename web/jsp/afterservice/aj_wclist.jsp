<%@ page contentType="text/html;charset=GBK" %>

<%@ page language="java" import="java.sql.*,common.*,java.util.*" %>
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/Repalce.jsp"%>
<HTML>
<%@ include file="../public_js/checktime.jsp"%>

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>��ɸ���Ŀ������ϸ��</title>
</head>

<body>
<div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >
 <p align="center"><b><font size=4>����ɸ���Ŀ������ϸ��</font></b></p>
 
 <%
 String date1=request.getParameter("Date1");
 String date2=request.getParameter("Date2");
 String SecNo=getbyte(request.getParameter("SecNo"));
  String ajdate=" and ajdate>='"+date1+"' and  ajdate<='"+date2+"'";
  if (!SecNo.equals(""))SecNo=" and section='"+SecNo+"'";
String AJSQL="select AJBK,count(*) num from order_contract  where ajbk<>'' and  payment1 like '%����%' "+SecNo+ajdate+" GROUP BY AJBK";

 ResultSet rs=InsertBean.executeQuery(AJSQL);
int y=0;
int num1=0;
 while (rs.next()){
 num1++;
 }
 rs.close();
 
  %>
 <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
 
  <tr  align="center">
    <td width="14%" rowspan="2">��Ŀ��</td>
    <td width="42%" colspan="<%=num1 %>">��������(��)</td>
    <td width="44%" colspan="<%=num1 %>">���ҽ��(Ԫ)</td>
  </tr>
<%


String sql="select sectionname from order_contract  where payment1 like '%����%' "+SecNo+ajdate+" group by sectionname";
  rs=InsertBean.executeQuery(sql);

 String[] bks= new String[5];
 String[] bkk= new String[5];
 String[] bkn= new String[5];

 String sectionname="";
 int aa=0;
 while (rs.next()){
  int i=0;
  sectionname=getbyte(rs.getString("sectionname"));
  sql="select ajbk,count(*) n,sum(ajmoney) ajk from order_contract  where payment1 like '%����%' and ajbk<>''"+ajdate+" and    sectionname='"+sectionname+"' group by ajbk";
 ResultSet rs1=InsertBean1.executeQuery(sql);

 while (rs1.next()){
    bks[i]=getbyte(rs1.getString("ajbk"));
    bkk[i]=getbyte(rs1.getString("ajk"));
	bkn[i]=getbyte(rs1.getString("n"));
	i++;
 }	
 rs1.close();

if (aa==0){
 %>

  <tr  align="center">
  <% for (int j=0;j<i;j++){ %>
    <td width="14%">&nbsp;<%=bks[j] %></td>
   <%} %>
    <% for (int j1=0;j1<i;j1++){ %>
    <td width="14%">&nbsp;<%=bks[j1] %></td>
   <%} %>
  </tr>
  <%} %>
  <tr  align="center">
  <td>&nbsp;<%=sectionname %></td>
   <% for (int jj=0;jj<i;jj++){ %>
    <td width="14%">&nbsp;<%=bkn[jj] %></td>
   <%} %>
    <% for (int j=0;j<i;j++){ %>
    <td width="14%">&nbsp;<%=bkk[j] %></td>
   <%} %>
  </tr>
 

<%  
 aa++;}
rs.close();
 %>
 
 <%sql="select ajbk,count(*) n,sum(ajmoney) ajk from order_contract  where payment1 like '%����%' and ajbk<>'' "+SecNo+" "+ajdate+"  group by ajbk";
   ResultSet rs1=InsertBean1.executeQuery(sql);
   int i=0;
   int num=0;
 while (rs1.next()) {
    bks[i]=getbyte(rs1.getString("ajbk"));
    bkk[i]=getbyte(rs1.getString("ajk"));
	bkn[i]=getbyte(rs1.getString("n"));
	i++;
	num++;
	}
 %>
   <tr  align="center">
  <td>&nbsp;С��</td>
   <% for (int jj=0;jj<i;jj++){ %>
    <td width="14%">&nbsp;<%=bkn[jj] %></td>
   <%} %>
    <% for (int j=0;j<i;j++){ %>
    <td width="14%">&nbsp;<%=bkk[j] %></td>
   <%} %>
  </tr>
 <%sql="select count(*) n,sum(ajmoney) ajk from order_contract  where payment1 like '%����%' and ajbk<>'' "+SecNo+ajdate;
     rs1=InsertBean1.executeQuery(sql);
     i=0;
 while (rs1.next()) {
    bkk[i]=getbyte(rs1.getString("ajk"));
	bkn[i]=getbyte(rs1.getString("n"));
	i++;
	}
 %>
   <tr align="center">
  <td>&nbsp;�ϼ�</td>
   <% for (int jj=0;jj<i;jj++){ %>
    <td width="14%" colspan="<%=num %>">&nbsp;<%=bkn[jj] %></td>
   <%} %>
    <% for (int j=0;j<i;j++){ %>
    <td width="14%"  colspan="<%=num %>">&nbsp;<%=bkk[j] %></td>
   <%} %>
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
<input type="button" onclick="bringToExcel()" value="������Excel"><br>
����ǰ���������Ӧ���ã�<br>
��1.��IE��������ѡ��"internetѡ��"<br>
��2.ѡ��"��ȫ"->ѡ��"����intranet"���ٵ��"�Զ��弶��"<br>
  3.������ActiveX���ö�ѡ�к���ȷ���˺�<br>
</body>

</html>
