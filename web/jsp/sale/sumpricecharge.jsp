<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,java.util.*,common.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<html>
<head>
	<title>�ۿ���ϸ��</title>
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<%
   String discSQL="";
try{
String Date1=request.getParameter("Date1");
String Date2=request.getParameter("Date2");
String SecNo=getbyte1(request.getParameter("SecNo"));
String SecNo1=SecNo.substring(0,SecNo.indexOf("-"));
SecNo=SecNo.substring(SecNo.indexOf("-")+1);
String Loft=getbyte1(request.getParameter("Loft"));
/*
StringTokenizer st22 = new StringTokenizer(Date1,"-") ;
StringTokenizer st23 = new StringTokenizer(Date2,"-") ;
int count2 = st22.countTokens() ;
int count3 = st23.countTokens() ;

 
 String same = "";
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
String SQL="select o.loft+o.building+o.room_no roomno,o.date,o.rmbprice,o.ysumprice ,o.ysumprice-o.rmbprice cj ,o.payment1,o.Note,o.disc ";
SQL+=" from order_contract o  WHERE o.state<>3 and o.ysumprice-o.rmbprice>0    and ";
if (!Loft.equals(""))
SQL+=" o.loft='"+Loft+"' and";

SQL+="  o.section='"+SecNo1+"'  and convert(char(10),o.date,120) >='"+Date1+"' and  convert(char(10),o.date,120) <='"+Date2+"' order by o.loft,o.floors,o.room_no";
ResultSet rs=null;
ResultSet rs1=null;
 
rs=ViewBean.executeQuery(SQL);

 %>
<body>
 <div align=left id=report1  >
<CENTER>
 <p align="center"><font size="2">�ۿ���ϸͳ�Ʊ�</font></p>
 
<table   width="120%" ><tr ><td>��Ŀ��<%=SecNo %></td><td align="right"><%=Date1+"--"+Date2 %></td></tr></table>
<table width="120%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr align="center">
<td  >���</td>
    <td  >��λ</td>
<td  >Ԥ���ܿ�</td>
	<td  >�Ϲ�����</td>
	<td  >�ɽ��ܿ�</td>
     
	<td  >�仯���</td>
	<td  >���ʽ</td>
	<td  >���ʽ�ۿ�</td>
<td >�����Ż�</td>
<td >��ϵ��</td>
<td >�Ż�����</td>
<td >�Żݱ�ע </td>
<td >������</td>
    <td  >��ע</td>
  </tr>
  <%int iii=0;
  while (rs.next()){

  iii++;
      discSQL="SELECT * FROM  contract_disc  WHERE   disc_type<>'�����ۿ�' and  order_no='"+SecNo1+rs.getString("roomno")+"' order by state desc";
	           
				    rs1=ViewBean1.executeQuery(discSQL);
			 String yy="";	 
		     String gxr="";
			 String discdate="";
			 String checker="";
			  String disc_bak="";
			  while (rs1.next()){
			      String dis=getbyte(rs1.getString("disc"));
			      float yh=rs1.getFloat("youhui");
			      String obj=rs1.getString("discObj");
				  if (!dis.equals(""))yy+=" ��"+obj+rs1.getString("disc")+"��";
	             if (yh>0) yy+=" ��"+obj+"�Ż�"+rs1.getString("youhui")+"Ԫ";
				 gxr=getbyte(rs1.getString("gxr"));
				 discdate=getbyte(rs1.getString("disc_date"));
				 if (!discdate.equals(""))discdate=discdate.substring(0,10);
				 checker=getbyte(rs1.getString("checker"));
				 disc_bak=getbyte(rs1.getString("disc_bak"));
			  }rs1.close();
   %>
  <tr><td height="16">&nbsp;<%=iii %></td>
    <td height="16">&nbsp;<%=rs.getString("roomno") %></td>
	<td height="16">&nbsp;<%=rs.getString("ysumprice") %></td>
	<td height="16">&nbsp;<%=rs.getDate("date").toString() %></td>
 
    <td height="16">&nbsp;<%=rs.getString("rmbprice") %></td>
	<td height="16">&nbsp;<%=rs.getString("cj") %></td>
    <td height="16">&nbsp;<%=rs.getString("payment1") %></td>
    <td height="16">&nbsp; <%=rs.getString("disc") %></td>
<td height="16">&nbsp; <%=yy %></td>
<td height="16">&nbsp; <%=gxr %></td>
<td height="16">&nbsp; <%=discdate %></td>
<td height="16">&nbsp; <%=disc_bak %></td>
<td height="16">&nbsp; <%=checker %></td>
    <td height="16" width=10%>&nbsp; <%=rs.getString("Note").trim() %></td>
  </tr>
  <%}
  rs.close(); 
  %>
 
</table>
  <%
}catch(Exception s){out.print(s.getMessage()+discSQL);out.close();}
  %>
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
        var selectArea=document.body.createTextRange(); //�����ı����� 
        selectArea.moveToElementText(report1);//���ı�����۽���printData 
        selectArea.select();//ѡ��printData 
        selectArea.execCommand("Copy");//��printData���Ƶ����а��� 
         oSheet.Paste();//�����а��е����ݸ��Ƶ�Excel��    
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
</script>
<input type="button" onclick="bringToExcel()" value="������Excel">
</body>
</html>
