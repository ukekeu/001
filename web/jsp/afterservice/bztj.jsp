<%@ page contentType="text/html;charset=GBK" %>

<%@ page language="java" import="java.sql.*,java.util.*,common.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
 
<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>��֤ͳ�������</title>
</head>

<body>
<%
    String date1=request.getParameter("Date1");
	String date2=request.getParameter("Date2");
	String SecNo=request.getParameter("SecNo");
 %>
  <DIV align=center id="printdiv">
 <!--<input class="buttoninput" type="button" value="��ӡԤ��" onclick="window.printdiv.style.display='none';factory.printing.Preview();"> -->

����ǰ���������Ӧ���ã�<br>
��1.��IE��������ѡ��"internetѡ��"
��2.ѡ��"��ȫ"->ѡ��"internet"���ٵ��"�Զ��弶��"<br>
  3.������ActiveX���ö�ѡ�к���ȷ���˺�<br>
<input type="button" name="Button" value="��ӡԤ��" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">&nbsp;<input type="button" name="Button1" value="������EXCEL" onClick="bringToExcel();">
 
 </div>

  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
  <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >
<p align="center">����Ŀ��֤���ͳ�Ʊ�</p>
���ڶ�:<%=date1 %>��<%=date2 %>
 <table width="95%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

  <tr align="center">
    <td width="10%" rowspan="3">��Ŀ����</td>
    <td width="38%" colspan="5">����</td>
    <td width="52%" colspan="6">�ۼ�</td>
  </tr>
  <tr align="center">
    <td width="8%" rowspan="2">�ͼ�</td>
    <td width="16%" colspan="2">��֤</td>
    <td width="8%" rowspan="2">����ע��</td>
    <td width="8%" rowspan="2">���·�֤</td>
    <td width="9%" rowspan="2">δ�ͼ�</td>
    <td width="9%" rowspan="2">���ͼ�</td>
    <td width="9%" rowspan="2">�ѳ�֤</td>
    <td width="9%" rowspan="2">�ѷ�֤</td>
    <td width="8%" rowspan="2">δ��֤</td>
    <td width="8%" rowspan="2">��֤</td>
  </tr>
  <tr align="center">
    <td width="8%">����</td>
    <td width="8%">һ����</td>
  </tr>
  <%
  
	
	List list1=new LinkedList();//���ʽ
	List list2=new LinkedList();//�ϼ�����
    String SQL="SELECT COUNT(*) NUM,sectionname,substring(payment1,0,4) from order_contract where section='"+SecNo+"'";// where " song_jian_date>='"+date1+"' and   ";
	SQL+="  group by sectionname,substring(payment1,0,4)";//song_jian_date<='"+date2+"'
	ResultSet rs=null;
    rs=ViewBean.executeQuery(SQL);
	while (rs.next()){
	  String sectionname=rs.getString("sectionname");
    //�ͼ�
	
	 SQL="SELECT COUNT(*) NUM from order_contract  where   song_jian_date>='"+date1+"' and   ";
	 SQL+=" song_jian_date<='"+date2+"' and  sectionname='"+sectionname+"'";
	 ResultSet rs1=null;
     rs1=ViewBean1.executeQuery(SQL);
	 int num=0;
	 if (rs1.next()){
	   num=rs1.getInt("NUM");
	    
	 }
	 rs1.close();
	
	
	
	
	 SQL="SELECT COUNT(*) NUM,substring(payment1,0,4) pay from order_contract  where   cq_date>='"+date1+"' and   ";
	 SQL+=" cq_date<='"+date2+"' and  sectionname='"+sectionname+"'  group by substring(payment1,0,4)";//
	   rs1=null;
     rs1=ViewBean1.executeQuery(SQL);
	   num=0;
	 
  %>
  <tr align="center">
    <td width="8%"><%= sectionname%></td>
    <td width="8%"><%=num %></td>
	<%
	while (rs1.next()){
	   num++;
	   out.print(" <td width='8%'>"+rs1.getString("num")+"��</td>");
	   // list1.add(rs1.getString("num"));
	   // list1.add(rs1.getString("pay"));
	 }
	 for (int j=num;j<=1;j++){
	   out.print(" <td width='8%'>��</td>");

	 }
	 rs1.close();
	
	 SQL="SELECT COUNT(*) NUM  from order_contract  where   yhzj_date>='"+date1+"' and   ";
	 SQL+=" yhzj_date<='"+date2+"' and  sectionname='"+sectionname+"'";//
	   rs1=null;
     rs1=ViewBean1.executeQuery(SQL);
	   num=0;
	 if (rs1.next()){
	   num=rs1.getInt("NUM");
	    
	 }
	 rs1.close();
	 %>
 
    <td width="8%"><%=num %></td>
	<%
	 SQL="SELECT COUNT(*) NUM  from order_contract  where   cq_lingquDate>='"+date1+"' and   ";
	 SQL+=" cq_lingquDate<='"+date2+"' and  sectionname='"+sectionname+"'";//
	   rs1=null;
     rs1=ViewBean1.executeQuery(SQL);
	   num=0;
	 if (rs1.next()){
	   num=rs1.getInt("NUM");
	    
	 }
	 rs1.close();
	
	
	 %>
    <td width="8%"><%=num %></td>
	<%
	 SQL="SELECT COUNT(*) NUM  from order_contract  where   song_jian_date is null and  sectionname='"+sectionname+"'";//
	   rs1=null;
     rs1=ViewBean1.executeQuery(SQL);
	   num=0;
	 if (rs1.next()){
	   num=rs1.getInt("NUM");
	    
	 }
	 rs1.close();
	
	
	 %>
    <td width="8%"><%=num %></td>
  <%
	 SQL="SELECT COUNT(*) NUM  from order_contract  where  not  song_jian_date is null and  sectionname='"+sectionname+"'";//
	   rs1=null;
     rs1=ViewBean1.executeQuery(SQL);
	   num=0;
	 if (rs1.next()){
	   num=rs1.getInt("NUM");
	 }
	 rs1.close();
	 %>
    <td width="8%"><%=num %></td>
	<%
	 SQL="SELECT COUNT(*) NUM  from order_contract  where   cq_date is null and  sectionname='"+sectionname+"'";//
	 rs1=null;
     rs1=ViewBean1.executeQuery(SQL);
	 num=0;
	 if (rs1.next()){
	   num=rs1.getInt("NUM");
	    
	 }
	 rs1.close();
	 %>
     <td width="8%"><%=num %></td>
	<%
	 SQL="SELECT COUNT(*) NUM  from order_contract  where   cq_lingquDate is null and  sectionname='"+sectionname+"'";//
	   rs1=null;
     rs1=ViewBean1.executeQuery(SQL);
	   num=0;
	 if (rs1.next()){
	   num=rs1.getInt("NUM");
	    
	 }
	 rs1.close();
	
	
	 %>
    <td width="8%"><%=num %></td>
   <%
	 SQL="SELECT COUNT(*) NUM  from order_contract  where   not  cq_date is null and   cq_lingquDate is null and  sectionname='"+sectionname+"'";//
	   rs1=null;
     rs1=ViewBean1.executeQuery(SQL);
	   num=0;
	 if (rs1.next()){
	   num=rs1.getInt("NUM");
	    
	 }
	 rs1.close();
	
	
	 %>
    <td width="8%"><%=num %></td>
    <td width="9%">&nbsp;��</td> 
  </tr>
 <%}
 rs.close(); %>

</table> 
<table width="95%" border="0"><tr><td>&nbsp;</td></tr></table>
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
