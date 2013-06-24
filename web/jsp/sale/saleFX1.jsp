<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/>  


  <jsp:useBean id="FormtD3" scope="page" class="test.PieChart"/>  
<jsp:useBean id="FormtD1" scope="page" class="test.BarChartDemo"/>  
<jsp:useBean id="FormtD2" scope="page" class="test.DIYseries"/>  
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
  <%//FormtD1.main1("D:/xa/crmv9/jsp/picture/pic1.jpg"); %>
    <%//FormtD2.main1("D:/xa/crmv9/jsp/picture/pic2.jpg","select min(floor) minfloor,max(floor) maxfloor from room where floor>0 and  seccode='zlhy'","ffsdfs"); %>

<html>
<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<LINK href="../class/line.css" rel=stylesheet>
	<title>销售分析</title>
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
  
 if (!Date1.equals("")&&Date2.equals(""))dateWhere=" and o.date between >='"+Date1+"''"; 
 else  if (!Date2.equals("")&&!Date1.equals(""))dateWhere=" and o.date between '"+Date1+"' and '"+Date2+"'"; 
 else    if (!Date2.equals("")&&Date1.equals(""))dateWhere=" and o.date<='"+Date2+"'"; 
 
 
 if (!Loft.equals(""))dateWhere+=" and o.loft='"+Loft+"'";
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
 
 
 
 
 <p align="center"><font size=4><b>&nbsp;销&nbsp;售&nbsp;数&nbsp;据&nbsp;分&nbsp;析</b></font></p>
 <table width="100%" border="0"  >
<% 
  String xdate="";
  String ydate="";
  float sum=0;
  float charges_money=0;
  int pp=0;
  for (int nn=0;nn<aa.length;nn++){

 String messtitle="";
 if (aa[nn].equals("o.roomtype"))messtitle="户型";
 else  if (aa[nn].equals("o.loft"))messtitle="楼栋";
 else  if (aa[nn].equals("r.room"))messtitle="房号";
 else  if (aa[nn].equals("o.jzarea"))messtitle="建筑面积";
 else  if (aa[nn].equals("o.floors"))messtitle="楼层";
 else  if (aa[nn].equals("o.payment1"))messtitle="付款方式";
 else  if (aa[nn].equals("o.zx"))messtitle="装修标准";
 else  if (aa[nn].equals("o.buildtype"))messtitle="用途";
 else  if (aa[nn].equals("o.ajbk"))messtitle="按揭银行";
 else  if (aa[nn].equals("o.ajyear"))messtitle="按揭年限";
 else  if (aa[nn].equals("c.region"))messtitle="客户所在区域";    
    String pic="";
  if (pp==0)out.print("<tr>");
  out.print("<td align=center>按"+messtitle+"分析<br>");
    xdate="";
    ydate="";
	 Loft="";
	Loft=getbyte1(request.getParameter("Loft"));
	if (!Loft.equals("")) Loft=" and o.loft='"+Loft+"'";
	
	Calendar calendar = Calendar.getInstance();
	String filename = String.valueOf(calendar.getTimeInMillis());	
  String  SQL="SELECT "+aa[nn]+",count(*) num  FROM customer c,order_contract o,room r where o.section='"+section+"' "+Loft+dateWhere+" and c.serialno=o.customer and o.section=r.seccode and o.loft=r.loft and o.room_no =r.room_code  group by "+aa[nn];
  pic=FormtD3.drawToFile("D:/"+ request.getContextPath()+"/crmv9/jsp/picture/pic"+filename+".jpg",SQL,messtitle);  
 if (!pic.equals(""))
 out.print("<img src='../picture/pic"+filename+".jpg'>");
 
out.print("</td>");
pp++;
if (pp==2){pp=0;out.print("</tr>");}
} %>
<br>

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