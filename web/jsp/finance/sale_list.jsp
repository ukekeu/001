<%@ page contentType="text/html;charset=GBK" %>

 
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 
<title>�ͻ�������ϸ(��¥������)</title>
 
</head>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/checktime.jsp"%>
 
<% 
 
 double hj=0;
 
  String stdate = China.getParameter(request,"Date1") ;
  String endate = China.getParameter(request,"Date2") ;
  String SectionName=China.getParameter(request,"SecNo") ; 
   SectionName=SectionName.substring(0,SectionName.indexOf("-"));
  String Region = China.getParameter(request,"Region") ; 
   String room=getbyte1(request.getParameter("room"));
  String Loft=getbyte1(request.getParameter("Loft"));
  String datetype=getbyte1(request.getParameter("datetype"));
String saletype=getbyte1(request.getParameter("saletype"));
String orderbytype=getbyte1(request.getParameter("orderbytype"));
if (saletype.equals("1"))saletype=" and a.state=1";
else if (saletype.equals("2"))saletype=" and a.state=2";
else if (saletype.equals("3"))saletype=" and a.state<>3 ";
   String sql=""; 
   sql="select    a.*,b.cus_name from order_contract a,customer b  where a.customer=b.serialno and  a.state<>3 and  convert(char(10),a.date,120)<='"+endate+"' and a.section='"+SectionName+"' "+saletype;
    if (!Loft.equals(""))
	  sql+=" and a.loft='"+Loft+"' ";
	   if (!room.equals(""))
	  sql+=" and a.Room_no='"+room+"'";
	  
  sql+=" order by a.loft,a.floors,a.room_no";
  
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
 <font size=3><div id=tit align="center"><%if (getbyte1(request.getParameter("saletype")).equals("1")){out.print("�տ���ϸ��");}else if (getbyte1(request.getParameter("saletype")).equals("2")){out.print("�տ���ϸ��");}else{out.print("�տ���ϸ��");} %>  </div></font>
 
 <table width="99%"><tr><td colspan="3">�տ�ʱ���:<%=China.getParameter(request,"Date1")%>��<%=China.getParameter(request,"Date2") %>(<%if (getbyte1(request.getParameter("saletype")).equals("1")){out.print("ͳ�Ƴ��Ϲ�������"+endate+"֮ǰ����������");}else if (getbyte1(request.getParameter("saletype")).equals("2")){out.print("ͳ�Ƴ�ǩԼ������"+endate+"֮ǰ����������");}else if (getbyte1(request.getParameter("saletype")).equals("3")){out.print("ͳ�Ƴ��Ϲ�������"+endate+"֮ǰ����������,������ǩԼ��");} %>)</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></table>
 
 <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

 <tr  > 
<td  align="right">���</td>
 
<td  align="center">����</td>
<td  align="center">�������</td>
<td align="center">���</td>
<td w align="center">���ʽ</td>

<td  align="center">�ɽ�����</td>
<td  align="center">�ɽ��ܼ�</td>
<td  align="center">�Ϲ�����</td> 
<td  align="center" valign="middle"><table  width="99%"  height="100%" border=0 cellspacing='0'  cellpadding='0' bgcolor=ffffff  bordercolordark=ffffff bordercolorlight=000000><tr><td>�տ�����</td><td>�տ���</td><td>�վݱ��</td><td>�տ���</td></tr></table></td> 
	<%
	ResultSet rs1=null;
	ResultSet rs=null;
	try{
		 
	rs=ViewBean.executeQuery(sql);
	 
	 
	int i=0;
 
   while (rs.next()){
	 i++;
	 String code  =getbyte(rs.getString("code"));
     String sectionname =getbyte(rs.getString("sectionname"));
      room=getbyte(rs.getString("loft"))+getbyte(rs.getString("room_no"));
     String jzarea=FormtD.getFloat(rs.getFloat("jzarea"),3);
	 String payment =getbyte(rs.getString("payment1"));
	 String unitprice=FormtD.getFloat2(rs.getDouble("unitprice"),2);
	 String sumprice=FormtD.getFloat2(rs.getDouble("rmbprice"),2);
	  
	 String rg_date=rs.getDate("date").toString(); 
	 
  %>
 <tr   align="center">
<td   align="center"><%=i %></td>
<td  align="left">&nbsp;<%=sectionname %></td>
<td   align="left">&nbsp;<%=room%>��</td>
<td   align="center">&nbsp;<%=jzarea%>��</td>
 
<td    align="right">&nbsp;<%=payment %>��</td>
<td  align="left">&nbsp; <%=unitprice %></td>
<td  align="right">&nbsp;<%=sumprice %></td>
<td  align="right">&nbsp;<%=rg_date %></td> 
<td  align="right"  valign="bottom">
<%
sql="select Gather_Date,factmoney*CurrRate factmoney,Bill_Num,Receiver   from factgatheringrecord where contractno="+code+" and convert(char(10),Gather_Date,120)>='"+stdate+"' and convert(char(10),Gather_Date,120)<='"+endate+"'";
 rs1=ViewBean1.executeQuery(sql);
out.print("<table width=99% height='100%' border=0 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>");
while (rs1.next()){
out.print("<tr>");
out.print("<td>"+rs1.getDate("Gather_Date").toString()+"</td>");
out.print("<td>"+FormtD.getFloat2(rs1.getDouble("factmoney"),2)+"</td>");
hj+=rs1.getDouble("factmoney");
out.print("<td>"+rs1.getString("Bill_Num")+"</td>");
out.print("<td>"+getbyte(rs1.getString("Receiver"))+"</td>");
out.print("</tr>");
}
rs1.close();
sql="select factdate,factmonye,chekcer,id,checkperson,checkstate,checkdate from FactAjCharges where contractno="+code +" and convert(char(10),factdate,120)>='"+stdate+"' and convert(char(10),factdate,120)<='"+endate+"'";
 rs1=ViewBean1.executeQuery(sql);
 while (rs1.next()){
 out.print("<tr title='���ҿ�' bgcolor='#c0c0c0'>");
out.print("<td>"+rs1.getDate("factdate").toString()+"</td>");
out.print("<td>"+rs1.getString("factmonye")+"</td>");
hj+=rs1.getDouble("factmonye");
out.print("<td> </td>");
out.print("<td>"+getbyte(rs1.getString("chekcer"))+"</td>");
out.print("</tr>");
}
rs1.close();
out.print("</table>");

 %></td> 
</tr> 
 <%
 }
rs.close();  
%>
<tr><td>�ϼ�:</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td><%=FormtD.getFloat2(hj,2) %></td></tr>
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
 
  <%
}catch(Exception s){out.print(s.getMessage()+sql);out.close();}
  %>
 
 
 
</body>
 
</html>
