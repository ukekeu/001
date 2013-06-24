<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
  <jsp:useBean id="FormtD1" scope="page" class="test.PieChart"/>   
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<LINK href="../class/line.css" rel=stylesheet>
	<title>投诉分析</title>
</head>

<body>
<script language="JavaScript">
<!--
 function ok(x){
	 document.all.photo.value=x;
	 form1.action="list_charges_plan.jsp?type=5&ch_type=3";
	 form1.submit();
 }
//-->
</script>
<%String photo=request.getParameter("photo");
  if(photo==null){
     photo="3";
  }
  String fxtype=request.getParameter("fxtype");
  String charges_type=request.getParameter("charges_type");
  if(charges_type==null){
      charges_type="0";
  }
  if(charges_type.equals("")){
      charges_type="0";
  }
  if(photo.equals("1")){
      charges_type="0";
  }
  String pre=request.getParameter("pre");
%>
<input type="hidden" name="photo" value="<%=photo%>">
 
<%
 String aa[]=request.getParameterValues("fxzb");
 
 
 String section=request.getParameter("section");
int begin_year=0,begin_month=0;
ResultSet rs=ViewBean.executeQuery("select datepart(year,min(visit_date)),datepart(month,min(visit_date)) from customer where section='"+section+"'");

if(rs.next()){
	begin_year=rs.getInt(1);
	begin_month=rs.getInt(2);
}rs.close();
 String Date1=getbyte1(request.getParameter("Date1"));
 String Date2=getbyte1(request.getParameter("Date2"));
   String Loft=getbyte1(request.getParameter("Loft"));
  String dateWhere="";
 if (!Date1.equals(""))dateWhere=" and TS_DATE between '"+Date1+"' and '"+Date2+"'";
 
String yy1=Date1.substring(0,Date1.indexOf("-"));
Date1=Date1.substring(Date1.indexOf("-")+1);
String mm1=Date1.substring(0,Date1.indexOf("-"));
if(Date1.equals("")){
   yy1=begin_year+"";
   mm1=begin_month+"";
}
java.util.Date now=new java.util.Date();
int curyear=now.getYear()+1900;
int curmonth=now.getMonth()+1;
String yy2=Date2.substring(0,Date2.indexOf("-"));
Date2=Date2.substring(Date2.indexOf("-")+1);
String mm2=Date2.substring(0,Date2.indexOf("-"));
if(Date2.equals("")){
   yy2=curyear+"";
   mm2=curmonth+"";
}

%>
<input type="hidden" name="show" value="<%=request.getParameter("show")%>">
 
 
   <p align="center"><font size=4><b>&nbsp;投&nbsp;诉&nbsp;数&nbsp;据&nbsp;分&nbsp;析</b></font></p>
 
<%String xtitle=getbyte1(request.getParameter("xtitle"));
  if(xtitle.equals("")){
      xtitle="";
  }
 

  String ytitle=getbyte1(request.getParameter("ytitle"));
 
  if(ytitle.equals("")){
     ytitle="";
  }
 
  String xdate="";
  String ydate="";
  float sum=0;
  float charges_money=0;
  int pp=0;
 
 String messtitle="";
 
   
 
	int iii=0;
  String  SQL="SELECT TS_TYPE,count(*) num  FROM TS_SERVICER where TS_SECTION ='"+section+"' "+dateWhere+"    group by TS_TYPE";
 String pic=FormtD1.drawToFile("D:/zlcrm/crmv9/jsp/picture/pictr"+section+".jpg",SQL,"投诉分析");  

 if (!pic.equals(""))
 out.print("<p align='center'><img src='../picture/pictr"+section+".jpg'></p>");
 
  %>
 
 <center>
  
<%
     xdate="";
	 ydate="";
	 iii=0;
    SQL="SELECT case when TS_state=0 then '未派单' when TS_state=1 then '已派单' when TS_state=2 then '已处理' when TS_state=3 then '已反馈' end TS_state,count(*) num  FROM TS_SERVICER where TS_SECTION ='"+section+"' "+dateWhere+"    group by TS_state";
   pic=FormtD1.drawToFile("D:/zlcrm/crmv9/jsp/picture/pictr1"+section+".jpg",SQL,"投诉分析");  
 
 if (!pic.equals(""))
 out.print("<p align='center'><img src='../picture/pictr1"+section+".jpg'></p>");

  
  %>
  

<table>
<tr><td>备注说明：</td></tr><tr><td>
&nbsp;&nbsp;&nbsp;&nbsp;<input type=text  name=aa   class=unnamed1 size=100  >
</td></tr>
<tr><td>
<input type=text  name=aa   class=unnamed1 size=104  >
</td></tr>
</table>
</body>
</html>