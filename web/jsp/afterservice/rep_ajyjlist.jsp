<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
	<title>�����ƽ���ϸ��</title>
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
 <jsp:useBean id="txt" scope="page" class="ConnDatabase.WriteToTxtBean"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
  
<form name=rep>
<br><br>
<div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >
 <table width="100%"  border=0 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center">
  <td  rowspan="2"><font size=5>�㶫����(����)���޹�˾<br>&nbsp;<br>&nbsp;��λ����д��������</font></td>
  <td><font size=5>���ҷ��ز�Ȩ֤�ƽ���ϸ��</font></td> 
  </tr>
  </table>
 <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center">
  <td>���</td>  <td>����</td>  <td>��ַ</td>  <td>�·���</td>
    <td>�ɷ���</td>  <td>���ز�Ȩ֤��</td>  <td>��ע</td>
  </tr>	
 <%
   String PARA_SQL=China.getParameter(request,"PARA_SQL");//����
   String constractno=China.getParameter(request,"url1");
   String if_name=China.getParameter(request,"if_name");
   String if_value=China.getParameter(request,"if_value");
   String reporttype=request.getParameter("reporttype1");//�������/sale:Ϊ���۱���,finace:Ϊ���񱨱�
   String tablename=request.getParameter("tablename1");//�����VIEW��ʹ������function,��ֻ�ܸ���Table Name
   String ifvalue[]=request.getParameterValues("ifvalue");//��ȡ����ֵ
   String reportState=China.getParameter(request,"reportState");
  
   String WhereSQL="";
   String WhereSQL1="";
   String SqlStr="";
   String TableNameStr=""; 

 for (int ii=0;ii<ifvalue.length;ii++){//ת��ֵ��Ϊ�������
   if (WhereSQL.equals(""))WhereSQL=getbyte1(ifvalue[ii]);
   else WhereSQL+="  "+getbyte1(ifvalue[ii]);
 }
 
  
TableNameStr=PARA_SQL;
  if (tablename==null)tablename="";
  if (!tablename.equals(""))TableNameStr=tablename;
  if(TableNameStr.equals("SaleCountPic_View"))TableNameStr="rgsview";
   SqlStr="select cus_name,sectionname,cq_newroom,romno,cq_no,cq_bak from "+TableNameStr+"     where " +  WhereSQL;
  int i=1;
try{

  ResultSet rs=InsertBean.executeQuery(SqlStr);
 while (rs.next()){%>
 <tr>
  <td><%=i %></td>  <td><%=getbyte(rs.getString("cus_name")) %>&nbsp;</td> 
   <td><%=getbyte(rs.getString("sectionname")) %>&nbsp;</td> 
    <td><%=getbyte(rs.getString("cq_newroom")) %>&nbsp;</td>
    <td><%=getbyte(rs.getString("romno")) %>&nbsp;</td>
	  <td><%=getbyte(rs.getString("cq_no")) %>&nbsp;</td> 
	   <td><%=getbyte(rs.getString("cq_bak")) %>&nbsp;</td>
 
 
 
 </tr>

 <%i++;}
}catch(Exception s){out.print(s.getMessage()+SqlStr);out.close();}
 

%>
</table>
<p align="center">�ƽ����ϱ����ز�Ȩ֤</p>
 <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="left">
  <td>�ƽ�����</td>  <td>���շ���</td>
  </tr>
   <tr  align="left">
  <td>�����ˣ�</td>  <td>�����ˣ�</td>
  </tr>
    <tr  align="left">
  <td>���ڣ�</td>  <td>���ڣ�</td>
  </tr>
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
</script>
<input type="button" onclick="bringToExcel()" value="������Excel"><br>
����ǰ���������Ӧ���ã�<br>
��1.��IE��������ѡ��"internetѡ��"<br>
��2.ѡ��"��ȫ"->ѡ��"����intranet"���ٵ��"�Զ��弶��"<br>
  3.������ActiveX���ö�ѡ�к���ȷ���˺�<br>