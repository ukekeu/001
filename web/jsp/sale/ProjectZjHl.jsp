<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 
<title>�ʽ������</title>
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
	
 
String Date2=request.getParameter("Date2");
String Date1=request.getParameter("Date1");
String SecNo=request.getParameter("SecNo");
String Loft=request.getParameter("Loft");
String sql="select c.cus_name,o.loft+o.building+o.room_no room,o.rmbprice,";
sql+="o.payment1,o.date,o.visadate,f.shouldDate,f.shouldMoney,f.id ";
sql+="from order_contract o,customer c,GatheringRecord f where";
sql+=" o.customer=c.serialno and o.code=f.contactno and f.shouldMoney>0 and o.state<>3 and f.state<2 and f.cusno=o.customer ";
if (!Loft.equals(""))
sql+=" and o.loft='"+Loft+"'";
sql+=" and o.section='"+SecNo+"' ";
if (!Date1.equals("")&&!Date2.equals(""))
sql+=" and convert(char(10),f.shouldDate,120)>='"+Date1+"' and convert(char(10),f.shouldDate,120)<='"+Date2+"'";
sql+=" order by o.loft+o.room_no";
 
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
 <p align="center"><font size=4><b><%=Date1 %>��<%=Date2 %>��Ŀ�ƻ������ʽ�</b></font></p>



	<%
	int i=0;
	ResultSet rs=null;
	try{
		
	rs=ViewBean.executeQuery(sql);
	 
	//��������ֵ�ı���
     
 

   while (rs.next()){
	 
     i=i+1;
      String code=rs.getString("ID");
     String Customer=getbyte(rs.getString("cus_name"));
	 String room=getbyte(rs.getString("room"));
	 String shouldDate=rs.getDate("shouldDate").toString();
	 String shouldMoney=fa.getFloat(rs.getFloat("shouldMoney"),2);
	if (i==1) {
  %>
  
 <table width="98%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<tr > 
<td  align="right">���</td>
<td  align="center">��    ��</td>
<td  align="center">�ͻ�����</td>
<td  align="center">Ӧ������</td>
<td w align="center">Ӧ������</td>
<td  align="center">ʵ�շ���</td>
<td  align="center">ʵ������</td>
<td  align="center">�ջؽ��</td>
<td  align="center">����</td>
<td w align="center">ʵ�պϼ�</td>
<td w align="center">ʵ������</td>
<%} %>
 <tr id=TR<%=i %> align="center" > 
<td   align="center"><%=i %></td>
<td  align="left">&nbsp; <%=room%></td>
<td   align="left">&nbsp; <%=Customer%> </td>

<td  align="left">&nbsp; <%=shouldMoney%></td>
<td  align="left">&nbsp; <%=shouldDate%></td>

<td  align="left">&nbsp;  </td>
<td  align="left">&nbsp;  </td>
<td  align="left">&nbsp;  </td>
<td  align="left">&nbsp;  </td>
<td  align="left">&nbsp;  </td>
 <td  align="left">&nbsp; </td>
 
</tr> 
 <%
//if (i==30){i=0;out.print("</table><br><br>"); }
}
rs.close();
 
 sql="select  sum(f.shouldMoney) shouldMoney ";
sql+="from order_contract o,customer c,GatheringRecord f where";
sql+=" o.customer=c.serialno and o.code=f.contactno and f.shouldMoney>0 and  o.state<>3 and f.state<3 and f.cusno=o.customer  ";
if (!Loft.equals(""))
sql+=" and o.loft='"+Loft+"'";
sql+=" and o.section='"+SecNo+"' ";
if (!Date1.equals("")&&!Date2.equals(""))
sql+=" and convert(char(10),f.shouldDate,120)>='"+Date1+"' and convert(char(10),f.shouldDate,120)<='"+Date2+"'";
 	rs=ViewBean.executeQuery(sql);
	if (rs.next()){
%>
<tr>
<td>�ϼ�:</td><td>&nbsp;</td> 
<td>&nbsp;</td>
<td>&nbsp;<%=fa.getFloat(rs.getFloat("shouldMoney"),2) %></td>
<td>&nbsp;</td> 
<td>&nbsp;</td>
<td>&nbsp;</td> 
<td>&nbsp;</td> 
<td>&nbsp;</td> 
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>

<%}
rs.close();
  out.print("</table>");

}catch(Exception s){out.print(s.getMessage()+sql);out.close();}
 
 %> </table>
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
    var selectArea=document.body.createTextRange(); //�����ı����� 
        selectArea.moveToElementText(report1);//���ı�����۽���printData 
        selectArea.select();//ѡ��printData 
        selectArea.execCommand("Copy");//��printData���Ƶ����а��� 
         oSheet.Paste();//�����а��е����ݸ��Ƶ�Excel��     
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
 
  </script>
</body>
 
</html>
