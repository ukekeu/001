<%@ page contentType="text/html;charset=GBK" %>

<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
	<title>���а�����ϸ��</title>
</head>
<script>
self.resizeTo(screen.availWidth,screen.availHeight)
self.moveTo(0,0)
self.focus()
</script>

<body>
 <%@ page language="java" import="java.sql.*,common.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="UpdateRs" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
 <%@ include file="../public_js/getByteOut.jsp"%>
  
<form name=rep>
<DIV align=center id="printdiv">
 <input type="button" name="Button" value="��ӡԤ��" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" onclick="bringToExcel()" value="������Excel"> 
 <br>
 <font size=1>
����ǰ���������Ӧ���ã� 
��1.��IE��������ѡ��"internetѡ��" 
��2.ѡ��"��ȫ"->ѡ��"����internet"���ٵ��"�Զ��弶��" 
  3.������ActiveX���ö�ѡ�к���ȷ���˺� </font>
  </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<div align=left id=report1 style="height:100%;overflow:auto;width:100%;z-index:2" contentEditable >

 <table width="99%"  border=0 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center">
  <td  rowspan="2"><font size=5> <%=getbyte1(request.getParameter("bk")) %>���а�����ϸ��</font></td> 
  </tr>
  </table>
  <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

   <tr>
   <td rowspan="2" >���</td><td rowspan="2" >����</td>  <td rowspan="2" >����</td>  <td rowspan="2" >���</td>  <td rowspan="2" >�ܼ�</td>
    <td rowspan="2" >��ͬǩ������</td><td rowspan="2" >�����ʽ�</td>  <td rowspan="2" >�����ʽ�</td>  <td colspan="2">������</td>
      <td rowspan="2" >��������</td>  <td rowspan="2" >��׼����</td>  <td rowspan="2" >�����Ǽ�����</td>  <td rowspan="2" >��ע</td>
��  </tr>
   <tr>
  <td>����</td>
  <td>ʼ����</td>
   </tr>
  
 <%
String  codes=request.getParameter("codes");
String  checkedAj=getbyte(request.getParameter("checkedAj"));
String  ajDate=getbyte(request.getParameter("ajDate"));
String  bank_person=getbyte(request.getParameter("bank_person"));
 String loft="",section="";
   
 String  SqlStr="select section,loft,roomno,cus_name,sectionname,jzarea,salerprice,visadate,salerprice-ajmoney first,ajmoney,ajyear,case when AjDate is null then AjDate else dateadd(yy,ajyear,ajdate)   end endd,ajdate,aj_send_date,aj_gt_dj_date,convert(char(10),fkdate,120) fkdate from viewsalelist    where payment1 like '%��%' and  not visadate is null and  code in ("+codes+")";
  int i=1;
 
try{
String sql="update order_contract set aj_type="+request.getParameter("aj_type")+",aj_send_date='"+request.getParameter("ajDate1")+"',AjBk='"+getbyte1(request.getParameter("bk"))+"'";
if (checkedAj.equals("1")){
sql+=",bank_person='"+bank_person+"',ajdate='"+ajDate+"'";
}
sql+=" where payment1 like '%��%' and  not visadate is null and    code in ("+codes+")";
 
 InsertBean.executeUpdate(sql);
  
  ResultSet rs=InsertBean.executeQuery(SqlStr);

 while (rs.next()){
 section=getbyte(rs.getString("section"));
  loft=getbyte(rs.getString("loft"));
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
	     String ajdate =getbyte(rs.getString("ajdate"));
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
opener.window.location="AjListS.jsp?SecNo=<%=section %>&Loft=<%=loft %>";
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
 // opener.document.forms[0].submit();
</script>
