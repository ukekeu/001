<%@ page contentType="text/html;charset=GBK" %><!--ҳ��ʾ���ı���-->
<%@ include file="../public_js/checktime.jsp"%><!--ϵͳʹ��ʱ��check-->
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>ҵ����ϸ��</title>
</head>
<%@ page language="java" import="java.sql.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
 <!--���ݿ����class-->
<jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/><!--ģ��Ȩ��check-->
<%@ include file="../public_js/getByteOut.jsp"%><!--����ת��function-->


<script language="JavaScript">
    var startnum="";
	var parasecname="";
	var parasecno="";
	var parabuild="";
	var paraloft="";
	function delsection() {
		if ( confirm("ȷʵ��ɾ���ö����еķ�������?"))
			window.location = "BuildingRoomDelete.jsp?Section="+document.cus.SecNo.value+"&Building="+document.cus.Building.value;
	}
	function Bdelsection() {
		if ( confirm("ȷʵ��ɾ���ö����е����ϣ������������ͷ������ϣ�?"))
			window.location = "BuildingDelete.jsp?Section="+document.cus.SecNo.value+"&Building="+document.cus.Building.value;
	}
	
	function View(){
	   if (parasecno==""){alert("��ѡ��һ��(ֻ�赥���б���ĳ��һ��)");}
		 else{window.location="RoomView.jsp?Search=aa"+"&SecNo="+parasecno+"&SecName="+parasecname+"&Build="+parabuild+"&Loft="+paraloft; }
	}  
	
	function savepara(para1,para2,para3,para4){
		 parasecname=para1;
		 parasecno=para2;
		 paraloft=para3;
		 parabuild=para4;
	}
</script>

<body >

<%String SecNo=request.getParameter("SecNo");
  String SecNa=request.getParameter("SecNa");
  String year=request.getParameter("yea");
  String month=request.getParameter("mon");
 %>
<script language="javascript" src="../public_js/public.js">
</script>
<form method="POST" name="cus" action="">
	<DIV align=center id="printdiv">
 <br><input type="button" name="Button" value="��ӡԤ��" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" name="Button" value="�� ��" onClick="bringToExcel();">
  
 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
   <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >
 <p align="center"><b><font size="3" class=FontColor><%=getbyte2(request.getParameter("seller")) %>ҵ����ϸ�� </b>
  </p>
   <table width="98%"  border=0 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<tr><td>1.�����Ϲ�    </td></tr>
</table>

 <table width="98%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
    <tr  align="center" > 
      <td  > ��� </td>
	  <td  > �ͻ����� </td>
      <TD  > ����λ </td>
	  <td > �Ϲ����� </td>
	  <td  > ǩԼ���� </td>
	   <td  > ���ʽ </td>
	   <td  > ��ͬ�� </td>
	   <!--<td > ���ڿ� </td>-->
	   <td > �ۼ��յ��� </td>
	 
	   
    </tr>
    <%
double sumprice=0;
double ysumprice=0;
double factprice=0;
ResultSet rs1=null;
String seller=getbyte2(request.getParameter("seller"));
String sql="select o.code,c.cus_name,o.sectionname+o.loft+o.room_no no,o.date,convert(char(24),o.visadate,121) visadate ,o.payment1,o.rmbprice from order_contract o ,customer c where o.state <>3 and o.seller like '%"+seller+"%' and o.customer=c.serialno and year(date)="+year+" and month(date)="+month;
ResultSet rs3=ViewBean2.executeQuery(sql);
int ii=0;

while (rs3.next()){
 ii++;
    String code=getbyte(rs3.getString("code"));
 %> 
  <tr  align="center"  > 
  
	    <td  ><%=ii %></td>
	    <td   align="left"><%=getbyte(rs3.getString("cus_name")) %></td>
		<td   align="left" > <%=getbyte(rs3.getString("no"))  %></td>
	    <td  > <%=rs3.getDate("date").toString()  %></td>
	    <td  > <%
		String visadate=getbyte(rs3.getString("visadate"));
		if (!visadate.equals(""))visadate=visadate.substring(0,10);
		 %><%=visadate %></td>
		 
		 <td   align="left"> <%=getbyte(rs3.getString("payment1")) %></td>
		<%
		 double iii=rs3.getDouble("rmbprice");
		 sumprice+=iii;
		  %>
		  <td  align="left" > <%=FormtD.getFloat3(iii,2) %></td>
		
		<%
		sql="select sum(shouldMoney)  Money1 ,sum(yijiao)  Money2 from GatheringRecord where ContactNo="+code;
		 rs1=ViewBean1.executeQuery(sql);
		 if (rs1.next()){
		 iii=rs1.getDouble("Money1");
		  ysumprice+=iii;
		  %>
		<!--<td  align="left" > <%//=FormtD.getFloat3(iii,2) %></td>-->
		<%
		 iii=rs1.getInt("Money2");
		factprice+=iii;
		
		 %>
	    <td   align="left"> <%=FormtD.getFloat3(iii,2) %></td>
		 <%}
		rs1.close(); %>
	</tr>
	
    <%

}rs3.close();
%>
 <tr><td colspan="6">�ϼ�:<%=ii %></td><td><%=FormtD.getFloat3(sumprice,2) %></td><!--<td><%=FormtD.getFloat3(ysumprice,2) %></td>--><td><%=FormtD.getFloat3(factprice,2) %></td></tr>
</table>  
    
  <table width="98%"  border=0 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<tr><td>2.����   </td></tr>
</table>  
 <table width="98%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
    <tr   align="center" > 
      <td  > ��� </td>
	  <td  > �ͻ����� </td>
      <TD  > ����λ </td>
	  <td > �Ϲ����� </td>
	  <td  > �˷����� </td>
	   <td  > ���ʽ </td>
	   <td  > ��ͬ�� </td>
	   <!--<td > ���ڿ� </td>-->
	   <td > �ۼ��յ��� </td>
	 
	   
    </tr>
  <%
 sql="select o.td_date,o.state,o.seller,o.code,c.cus_name,o.sectionname+o.loft+o.room_no no,o.date,convert(char(24),o.visadate,121) visadate ,o.payment1,o.rmbprice from order_contract o ,customer c where o.state=3 and o.seller  like '%"+seller+"%'  and  o.customer=c.serialno and year(date)="+year+" and month(date)="+month;
 rs3=ViewBean2.executeQuery(sql);

while (rs3.next()){
 ii++;
  int state=rs3.getInt("state");
  String sellers=getbyte(rs3.getString("seller"));

StringTokenizer st23 = new StringTokenizer(sellers,"/") ;

int count3 = st23.countTokens() ;
String td_date=getbyte(rs3.getString("td_date"));
if (!td_date.equals(""))td_date=td_date.substring(0,10);
    String code=getbyte(rs3.getString("code"));
 %> 
  <tr  align="center"   > 
  
	    <td  ><%if (state==3){out.print("<font color=red>");} %><%=ii %><%if (state==3){out.print("���� ");} %></td>
	    <td   align="left"><%=getbyte(rs3.getString("cus_name")) %></td>
		<td   align="left" > <%=getbyte(rs3.getString("no"))  %></td>
	       <td  > <%
		String visadate=getbyte(rs3.getString("date"));
		if (!visadate.equals(""))visadate=visadate.substring(0,10);
		 %><%=visadate %></td>
	    <td  > <%=td_date  %></td>
	
		 
		 <td   align="left"> <%=getbyte(rs3.getString("payment1")) %></td>
		<%
		 double iii=Double.parseDouble(FormtD.getFloat3(rs3.getDouble("rmbprice")/count3,2));
		 sumprice+=iii;
		  
		  %>
		  <td  align="left" ><%=FormtD.getFloat3(iii,2) %></td>
		
		<%
		sql="select sum(factmoney)  Money1  from factGatheringRecord where ContractNo="+code;
		 rs1=ViewBean1.executeQuery(sql);
		 
		 if (rs1.next()){
		 iii=rs1.getDouble("Money1");
		  factprice+=iii;
		
		  %>
		<!--<td  align="left" > <%=FormtD.getFloat3(iii,2) %></td>-->
		<%
		// iii=rs1.getDouble("Money2");
		//factprice+=iii;
		
		 %>
	    <td   align="left"> <%=FormtD.getFloat3(iii,2) %></td>
		 <%}
		rs1.close(); %>
	</tr>
	
    <%

}rs3.close();
%>
  </table>
   
  <table width="98%"  border=0 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<tr><td>3.�����ܼ۱仯    </td></tr>
</table>  
 <table width="98%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
    <tr  align="center" > 
      <td  > ��� </td>
	  <td  > �ͻ����� </td>
      <TD  > ����λ </td>
	  <td > �Ϲ����� </td>
	  <td  > �仯���� </td>
	  <td  > �仯ǰ�ܼ� </td>
	  <td  > �仯���ܼ� </td>
	   <td  > ���ʽ </td>
	   <td  > ��ͬ�� </td>
	   <!--<td > ���ڿ� </td>-->
	   <td > �ۼ��յ��� </td>
	 
	   
    </tr>
  <%
 sql="select l.log_date,o.state,o.seller,o.code,c.cus_name,o.sectionname+o.loft+o.room_no no,o.date,convert(char(24),o.visadate,121) visadate ,o.payment1,l.rmbprice,l.yrmbprice from order_contract o ,customer c,order_contract_log l where o.code=l.order_contract and  o.state<>3 and o.seller  like '%"+seller+"%'  and  o.seller like '%/%' and o.customer=c.serialno and  month(date)<>month(log_date) and year(log_date)="+year+" and month(log_date)="+month;
 rs3=ViewBean2.executeQuery(sql);

while (rs3.next()){
 ii++;
  int state=rs3.getInt("state");
  String sellers=getbyte(rs3.getString("seller"));

StringTokenizer st23 = new StringTokenizer(sellers,"/") ;

int count3 = st23.countTokens() ;
String log_date=getbyte(rs3.getString("log_date"));
if (!log_date.equals(""))log_date=log_date.substring(0,10);
    String code=getbyte(rs3.getString("code"));
 %> 
  <tr  align="center"  > 
  
	    <td  ><%if (state==3){out.print("<font color=red>");} %><%=ii %><%if (state==3){out.print("���� ");} %></td>
	    <td   align="left"><%=getbyte(rs3.getString("cus_name")) %></td>
		<td   align="left" > <%=getbyte(rs3.getString("no"))  %></td>
	       <td  > <%
		String visadate=getbyte(rs3.getString("date"));
		if (!visadate.equals(""))visadate=visadate.substring(0,10);
		 %><%=visadate %></td>
	    <td  > <%=log_date  %></td>
	<td  > <%=getbyte(rs3.getString("yrmbprice"))  %></td>
		 <td  > <%=getbyte(rs3.getString("rmbprice"))  %></td>
		 <td   align="left"> <%=getbyte(rs3.getString("payment1")) %></td>
		<%
		 double iii=Double.parseDouble(FormtD.getFloat3(rs3.getDouble("rmbprice")/count3,2));
		 sumprice+=iii;
		  
		  %>
		  <td  align="left" ><%=FormtD.getFloat3(iii,2) %></td>
		
		<%
		sql="select sum(factmoney)  Money1  from factGatheringRecord where ContractNo="+code;
		 rs1=ViewBean1.executeQuery(sql);
		 
		 if (rs1.next()){
		 iii=rs1.getDouble("Money1");
		  factprice+=iii;
		
		  %>
		<!--<td  align="left" > <%=FormtD.getFloat3(iii,2) %></td>-->
		<%
		// iii=rs1.getDouble("Money2");
		//factprice+=iii;
		
		 %>
	    <td   align="left"> <%=FormtD.getFloat3(iii,2) %></td>
		 <%}
		rs1.close(); %>
	</tr>
	
    <%

}rs3.close();
%>
  </table>
<%
String SQL="SELECT  s.roomcode,c.cus_name,l.name+r.loft+r.Room_code Room_code,s.StartDate,s.Subscription,s.billtype,s.bill_num,s.paytype,s.zto  from  SL_TemporarilyBuy s,room r,customer c,CRM_Project  l where s.Cusname=c.serialno and s.RoomCode=r.code and r.seccode=l.serialno and s.Receiver='"+request.getParameter("seller")+"'";
ResultSet rs=ViewBean2.executeQuery(SQL);

 %><!--
    <p align="center"><font size=3>�ٶ�������ϸ�� </p>
 
<table BORDER=0 width="102%" CELLSPACING=0 CELLPADDING=0 bordercolor="#FFFFFF" ALIGN=center class="tablefill" >
    <tr class=listtitle align="center" > 
      <td  > ��� </td>
	  <td  > �ͻ����� </td>
      <TD  > �ٶ���λ </td>
	  <td > �ٶ����� </td>
	  <td  > ���� </td>
	  <td  > Ʊ�� </td>
	  <td  > Ʊ�ݱ�� </td>
	  <td > ���ʽ </td>
	  <td > �Ƿ��ת </td>
   </tr>  -->
 <%
 //int i=0;
 //while (rs.next()){ 
 //i++;
 %><!--
    <tr ondblclick="openwin('InputDj.jsp?code='+room_code,550,480,100,10);" id=TR<%//=i %>  class=listcontent  align="center"  onmouseover="mout(this);"  onclick="savepara('<%//=getbyte(rs.getString("roomcode"))%>');changeclass1(this,'clickbg','listcontent');" title="˫������ȡ�Ǽ�">
      <td  > <%//=i %></td>
	  <td  align="left" > <%//=getbyte(rs.getString("cus_name")) %> </td>
      <TD align="left" > <%//=getbyte(rs.getString("room_code")) %> </td>
	  <td > <%//=getbyte(rs.getDate("StartDate").toString()) %> </td>
	  <td  ><%//=getbyte(rs.getString("Subscription")) %> </td>
	  <td  > <%/*
	   String BillType=getbyte(rs.getString("billtype"));
	   if (BillType.equals("0"))BillType="�վ�";
	   if (BillType.equals("1"))BillType="��Ʊ";
	   out.print(BillType);
	   */
	  %> <!--</td>
	  <td  > <%//=getbyte(rs.getString("bill_num")) %> </td>
	  <td > <%//=getbyte(rs.getString("paytype")) %></td>
	  <td > <%
	  /*
	  String sate=getbyte(rs.getString("zto")) ;
	   if (sate.equals("0"))sate="δ��ת";
	   if (sate.equals("1"))sate="�ѽ�ת";
	      out.print(sate);
		  */
	   %><!-- </td>
   </tr>  -->
 
 <%//}rs.close(); %>  
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
</form>
</html>