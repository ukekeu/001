<%@ page contentType="text/html;charset=GBK" %>

<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
	<title>���а�����ϸ��</title>
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

</head>
<script>
self.resizeTo(screen.availWidth,screen.availHeight)
self.moveTo(0,0)
self.focus()
</script>

<body>
 <%@ page language="java" import="java.sql.*,common.*,java.util.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="UpdateRs" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
 <%@ include file="../public_js/getByteOut.jsp"%>
  
<form name=rep>
 
 <input type="button" onclick="bringToExcel()" value="������Excel"> 
<div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >

 <table width="99%"  border=0 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center">
  <td  rowspan="2"><font size=5> <%=getbyte1(request.getParameter("bk")) %>���а�����ϸ��</font></td> 
  </tr>
  </table>
  <table width="99%" align="center"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

   <tr align="center">
   <td rowspan="2" >���</td><td rowspan="2" >����</td>  <td rowspan="2" >����</td>  <td rowspan="2" >���</td>  <td rowspan="2" >�ܼ�</td>
    <td rowspan="2" >��ͬǩ������</td><td rowspan="2" >�����ʽ�</td>  <td rowspan="2" >�����ʽ�</td>  <td colspan="2">������</td>
      <td rowspan="2" >��������</td>  <td rowspan="2" >��׼����</td>  <td rowspan="2" >�����Ǽ�����</td>  <td rowspan="2" >��ע</td>
��  </tr>
   <tr align="center">
  <td>����</td>
  <td>ʼ����</td>
   </tr>

 
 ��

   
 <%
 
  String Date1=request.getParameter("Date1");
 String Date2=request.getParameter("Date2");
 
 
StringTokenizer st22 = new StringTokenizer(Date1,"-") ;
StringTokenizer st23 = new StringTokenizer(Date2,"-") ;
int count2 = st22.countTokens() ;
int count3 = st23.countTokens() ;

 
 String same = "";
 /*
try{
 while (st22.hasMoreElements()) {
    
	
	 if (same.equals("")){Date1=(String)st22.nextElement();   same = Date1;}
	 else {Date1+="/"+(String)st22.nextElement();} 
 
}
 }catch(Exception s){}
 same="";
 while (st23.hasMoreElements()) {
       
	 if (same.equals("")){Date2=(String)st23.nextElement(); same = Date2;}
	 else {Date2+="/"+(String)st23.nextElement();}
}
 */
 String SecNo=getbyte(request.getParameter("SecNo"));
  String ajdate=" and ajdate>='"+Date1+"' and  ajdate<='"+Date2+"'";
  if (!SecNo.equals(""))SecNo=" and section='"+SecNo+"'";
   
 String  SqlStr="select roomno,cus_name,sectionname,jzarea,salerprice,visadate,salerprice-ajmoney first,ajmoney,ajyear,case when AjDate is null then AjDate else dateadd(yy,ajyear,ajdate)   end endd,ajdate,aj_send_date,aj_gt_dj_date,fkdate from viewsalelist    where payment1 like '%����%' and  not visadate is null "+ajdate+SecNo;
  int i=1;
  
try{
    ResultSet rs=InsertBean.executeQuery(SqlStr);
 
 while (rs.next()){
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
	       ajdate =getbyte(rs.getString("ajdate"));
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

����ǰ���������Ӧ���ã�<br>
��1.��IE��������ѡ��"internetѡ��"<br>
��2.ѡ��"��ȫ"->ѡ��"����internet"���ٵ��"�Զ��弶��"<br>
  3.������ActiveX���ö�ѡ�к���ȷ���˺�<br>