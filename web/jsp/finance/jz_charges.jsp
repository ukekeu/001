<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

<html>
<head>
<title>���۽�ת</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel=stylesheet href="../class/news.css" >
</head>
  <%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="FormatD" scope="session" class="FormatData.FormatData"/>
 
 <%
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"F011");


 %>
  <%
    String  roomno="";
	double jzarea=0;
	double  unitprice=0;
	int     sumprice=0;
	double  factsumprice=0;
	int     no=0;

	
	String dates=request.getParameter("Date1");
	String dates1=request.getParameter("Date2");
	String SecNo=request.getParameter("SecNo");
	String choose=request.getParameter("choose");
	String ch1="";
	String ch2="";
	if (choose==null){choose="0";ch1="checked";}
	if (choose.equals("1")) ch2="checked";
	else ch1="checked";
	String Loft=request.getParameter("Loft");
	String secname=request.getParameter("SecName");
	String loftname=request.getParameter("loftname");
	String WhereSQL="";
	if(!SecNo.equals(""))
	  WhereSQL +=" and  section='"+SecNo+"'";
	if(!Loft.equals(""))
	  WhereSQL +=" and Loft='"+Loft+"'";
    if (choose.equals("1"))
        WhereSQL +=" and jzState='1'";
     else
	    WhereSQL +=" and jzState ='0'";
	  
	String WhereSQL1="";
//	if (!dates.equals(""))
//	WhereSQL1=WhereSQL+" and date>='"+dates+"' and  date<='"+dates1+"'";
//    WhereSQL+=WhereSQL1;
	String sdate="";
	String edate="";
	String whereDate="";
	
  dates="2003-01-01";
  dates1="2003-01-01";
	
   %>
<body  ><!-ondblclick="printd();"->
<p align="center"><font size=3><b>�����ת����</b></font></p>
<!--
<p align="center" ><font size=3><b><%=dates.substring(0,dates.indexOf("-"))+"��"+dates.substring(dates.indexOf("-")+1,dates.lastIndexOf("-"))+"��"+dates.substring(dates.lastIndexOf("-")+1,dates.length())+"��"+"��"+dates1.substring(0,dates1.indexOf("-"))+"��"+dates1.substring(dates1.indexOf("-")+1,dates.lastIndexOf("-"))+"��"+dates1.substring(dates1.lastIndexOf("-")+1,dates1.length())+"��"%></font></b></p>
-->
<form name=frm method=post>

<p align="left" >¥�����ƣ�<%if (!secname.equals(Loft)){out.print(secname);} %><%=Loft %> &nbsp;&nbsp;<%if (Cortrol.indexOf("A")>=0){ %> ��ת���ڣ�<input type=text size=12 name=jzdate><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(jzdate);return false;">&nbsp;<input type=button name=jz value="�ᡡ��" onclick="jzData(jz);"><%} %></p>
<input type="radio" name=choose value="0" onclick="document.frm.submit();" <%=ch1 %>>δ��ת&nbsp;<input type="radio" name=choose value="1" onclick="document.frm.submit();" <%=ch2 %>>�ѽ�ת&nbsp;&nbsp;&nbsp;<%if (Cortrol.indexOf("P")>=0){ %> <input type=button name=prin value="��ӡ����" onclick="openwin('auto_select4.jsp',300,350,100,100);"><%} %>
<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
 
  <tr align="center"> 
   <td >���</td>
    <td >����&nbsp;</td>
	<td >�������&nbsp;M<sup>2</sup></td>
    <td >��������&nbsp;</td>
	 <td >�����ܼ�&nbsp;</td>
    <td >���ʽ��&nbsp;</td>
	<td >��ת</td>
 
  
  </tr>
  <% 
       //������
	String countSQL="SELECT code,room_no,jzarea,sumprice / jzarea as unitprice, sumprice,factmoney FROM  view_jzcharges WHERE code>0";
    if (choose.equals("1"))
      countSQL+="and  code in (select code from view_jzcharges where factmoney>=sumprice )" ;countSQL+=WhereSQL;
int i=0;
 
try{
  	ResultSet aRS = aBean.executeQuery(countSQL);
	while (aRS.next()){
	   no=aRS.getInt("code");
	   roomno=aRS.getString("room_no");
	   jzarea=aRS.getDouble("jzarea");
	   unitprice=aRS.getDouble("unitprice");
	   sumprice=aRS.getInt("sumprice");
	   factsumprice=aRS.getDouble("factmoney");
	   jzarea=aRS.getDouble("jzarea");
	   i++;
	 
  
  %>
  <tr align="center"> 
    <td >&nbsp;<%=i %></td>
	 <td >&nbsp;<%=roomno %></td>
    <td >&nbsp;<%=jzarea %></td>
    <td >&nbsp;<%=unitprice %></td>
    <td >&nbsp;<%=FormatD.getFloat(sumprice ,0)%></td>
    <td >&nbsp;<%=FormatD.getFloat2(factsumprice ,0)%></td>
	 <td >&nbsp;<input type="checkbox" name="jz" value="<%=no%>"></td>
   
  </tr>
  <%
	  
   }
	aRS.close();
	
	
	
}catch(Exception s)	{out.print(countSQL);out.close();}
 
  %>
</table>
  <P>&nbsp;</p>
  <table width="100%">
 <tr>
 <td width="65%"></td>
 <td width="20%" align="center"><font size=4></font></td>
 <td width="15%"></td>
 </tr>
 </table>
 <table width="100%">
 <%java.util.Date curDate=new java.util.Date();
  int CurYear=curDate.getYear()+1900;
      int CurMonth=curDate.getMonth()+1;
      int CurDay=curDate.getDate(); %>
 <tr>
 <td width="10%"></td>
 <td width="75%" align="center"><font size=4>ͳ������:<%=CurYear %>��<%=CurMonth %>��<%=CurDay %>��</font></td>
 <td width="15%"></td>
 </tr>
 </table>
 </form>
<script>
function dda(){
var today=new Date();
var dd1=String(today.getMonth()+1);
dd.innerText=today.getYear()+"��"+dd1+"��"+today.getDay()+"��";
}


function printd(){
if (confirm("��ӡ��"))
  print();

}
function getseldocs2(indexstring) {
     var x=0;
	 var seldocs = new Array();
	 var temp=document.frm.elements.length;
     for (i=0;i<document.frm.elements.length;i++) {
       if ((document.frm.elements[i].type=="checkbox")&&(document.frm.elements[i].checked))
		 { 
		
       		seldocs[x]=document.frm.elements[i].value ;
			x++;
   		 }
	  }	
   return seldocs ;
}
function jzData(jz){
  if (getseldocs2(jz)!=""&&document.frm.jzdate.value!=""){
   if (confirm("ȷ�Ͻ�תѡ�������������"))
   window.location="jz_order_charges.jsp?code="+getseldocs2(jz)+"&jzdate="+document.frm.jzdate.value;
  }else{

  alert("��ѡ����Ҫ��ת������");
  }
}
</script>

</body>
</html>
