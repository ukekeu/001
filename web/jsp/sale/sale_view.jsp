<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>��ѯ</title>
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
    <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
 <%@ include file="../public_js/getByteOut.jsp"%>
  
<form name=rep>
<br><br>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<div align=left id=report1 style="background-color:#F7F7F7;height:100%px;overflow:auto;width:100%;z-index:2" contentEditable >
 <table width="99%"  border=0 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center">
    <td><font size=5>��ѯ��ϸ���</font></td> 
  </tr>
  </table>
 <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  align="center">
  <td>���</td>  <td>��Ŀ</td>  <td>���ʽ</td> <td>�ۿ�</td> <td>�ܼ�</td> <td>������</td>
   
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
   SqlStr="select sectionName+Loft+building+room_no roomno,payment1,disc, rmbprice,rg_sumprice-rmbprice c  from order_contract     where state<>3 and  " +  WhereSQL;
  int i=1;
   double cc=0;
    double ccc=0;
 int nn=0;
try{

  ResultSet rs=InsertBean.executeQuery(SqlStr);
 while (rs.next()){%>
 <tr>
  <td><%=i %></td>  <td><%=getbyte(rs.getString("roomno")) %>&nbsp;</td> 
  <td><%=getbyte(rs.getString("payment1")) %>&nbsp;</td> 
  <td><%=getbyte(rs.getString("disc")) %>&nbsp;</td>
  <td><%=getbyte(rs.getString("rmbprice")) %>&nbsp;</td>
  <td><%=getbyte(rs.getString("c")) %>&nbsp;</td> 
 
 </tr>
 <%i++;}

 SqlStr="select  sum(rmbprice) s,sum(rg_sumprice-rmbprice) c ,count(*) num,payment1 from order_contract     where state<>3 and      " +  WhereSQL+" group by payment1";

 rs.close();
 rs=InsertBean.executeQuery(SqlStr);
  while (rs.next()){
     float c=rs.getFloat("c");
	  float s=rs.getFloat("s");
	 cc+=c;
	  ccc+=s;
	 int a=rs.getInt("num");
	 nn+=a;
 %>
<tr><td>С��:</td><td><%=FormtD.getFloat(s,2) %></td>
<td><%=FormtD.getFloat(c,2) %></td>
<td><%=a%></td>
<td><%=getbyte(rs.getString("payment1")) %></td><td>&nbsp;</td>
</tr>
<%}
}catch(Exception s){out.print(s.getMessage()+SqlStr);out.close();} %>

<tr><td>�ϼ�:</td><td><%=FormtD.getFloat2(ccc,2) %> </td>
<td><%=FormtD.getFloat2(cc,2) %></td>
<td><%=nn%></td>
<td>&nbsp;</td><td>&nbsp;</td>
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
    
   var oWB = oXL.Workbooks.Add();     
     var oSheet = oWB.ActiveSheet;     
         var selectArea=document.body.createTextRange(); //�����ı����� 
        selectArea.moveToElementText(report1);//���ı�����۽���printData 
        selectArea.select();//ѡ��printData 
        selectArea.execCommand("Copy");//��printData���Ƶ����а��� 
         oSheet.Paste();//�����а��е����ݸ��Ƶ�Excel��     
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
</script>
<DIV align=center id="printdiv">
 <br><input type="button" name="Button" value="��ӡԤ��" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
  <input type="button" onclick="bringToExcel()" value="������Excel"> 
<br>����ǰ���������Ӧ���ã�<br>
��1.��IE��������ѡ��"internetѡ��"<br>
��2.ѡ��"��ȫ"->ѡ��"����intranet"���ٵ��"�Զ��弶��"<br>
  3.������ActiveX���ö�ѡ�к���ȷ���˺�<br>
 </div>