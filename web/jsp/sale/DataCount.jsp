<%response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0);  %>
<%@ page contentType="text/html;charset=GBK" %>
<html>

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>销售数据分析</title>
</head>
 <%@ page language="java" import="java.sql.*,java.util.Date,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
  <jsp:useBean id="FormtD1" scope="page" class="test.BarChartDemo"/>  
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<%
String strSecName=getbyte1(request.getParameter("SecName"));
String strBuild=getbyte1(request.getParameter("Build"));
String strLoft=getbyte1(request.getParameter("Loft"));
String strSecNo=getbyte1(request.getParameter("SecNo"));
String WhereSQL="",WhereSQL1="";
WhereSQL=" where seccode='"+strSecNo+"'";
WhereSQL1=" where section='"+strSecNo+"'";
if (!strLoft.equals("")){
WhereSQL+="  and  loft='"+strLoft+"'";
WhereSQL1+="  and  loft='"+strLoft+"'";
}
ResultSet rs=null;
String SQL="",Date="";
String num="0",area="0",price="0",num1="0",price1="0";
  SQL="select sum(AREA) area,sum(AREA*unitprice) sumprice,count(*) num,getdate() as date from room "+WhereSQL;
  rs= ViewBean.executeQuery(SQL) ;

if (rs.next()){
   area=FormatD.getFloat2(rs.getDouble("area"),2);
   price=FormatD.getFloat2(rs.getDouble("sumprice"),2);
   num=rs.getString("num");
   Date=rs.getDate("date").toString();
   num1=num;
}
rs.close();

 %>

<body>
<form action="DataCount1.jsp" method="post" name="frm">
<input type=hidden name=SecNo value="<%=strSecNo %>">
<input type=hidden name=SecName value="<%=strSecName %>">
<input type=hidden name=Loft value="<%=strLoft %>">
<input type=hidden name=Build value="<%=strBuild %>">
<p align="center"><font size=4><b><%=strSecName+strLoft %>累计销售分析情况表</b></font></p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;统计日期 :<%=Date %>
<center>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="88%" id="AutoNumber1">
  <tr>
    <td width="13%" rowspan="3" align="center">总体情况</td>
    <td width="13%" align="center">可售套数</td>
    <td width="54%"><%=num %>　</td>
  </tr>
  <tr>
    <td width="13%" align="center">可售面积</td>
    <td width="54%"><%=area %>　</td>
  </tr>
  <tr>
    <td width="13%" align="center">可售金额</td>
    <td width="54%"><%=price %>　</td>
  </tr>
 
  <%
  if (!strLoft.equals(""))
    SQL="select sum(AREA) area,sum(AREA*unitprice) sumprice,count(*) num from room  where not seccode+loft+room_code in (select section+loft+room_no from order_contract  where state<>3 and section='"+strSecNo+"'  and loft='"+strLoft+"' ) and  seccode='"+strSecNo+"'  and loft='"+strLoft+"'";
  else
        SQL="select sum(AREA) area,sum(AREA*unitprice) sumprice,count(*) num from room  where not seccode+loft+room_code in (select section+loft+room_no from order_contract  where state<>3 and section='"+strSecNo+"'  ) and  seccode='"+strSecNo+"'";    rs= ViewBean.executeQuery(SQL) ;
if (rs.next()){
   area=FormatD.getFloat2(rs.getDouble("area"),2);
   price=FormatD.getFloat2(rs.getDouble("sumprice"),2);
   num=rs.getString("num");
}
rs.close();

   %>
   <tr>
    <td width="13%" rowspan="3" align="center">未售情况</td>
    <td width="13%" align="center">未售套数</td>
    <td width="54%"><%=num %></td>
  </tr>
  <tr>
    <td width="13%" align="center">未售面积</td>
    <td width="54%"><%=area %></td>
  </tr>
  <tr>
    <td width="13%" align="center">未售金额</td>
    <td width="54%"><%=price %></td>
  </tr>
 
   <% 
   int sum_ajmoney=0;
    SQL="select sum(jzAREA) area,sum(rmbprice+cj_f) sumprice,count(*) num,sum(ajmoney) aj from order_contract "+WhereSQL1+" and state<>3";
    rs= ViewBean.executeQuery(SQL) ;
	 
if (rs.next()){
   area=FormatD.getFloat2(rs.getDouble("area"),3);
   price1=getbyte(rs.getString("sumprice"));
   if (price1.equals(""))price1="0";
 
   price=FormatD.getFloat2(Double.parseDouble(price1),2);
   num=rs.getString("num");
   sum_ajmoney=rs.getInt("aj");
}
rs.close();

   %>
   <tr>
    <td width="13%" rowspan="4" align="center">已售情况</td>
    <td width="13%" align="center">已售套数</td>
    <td width="54%"><%=num %></td>
  </tr>
  <tr>
    <td width="13%" align="center">已售面积</td>
    <td width="54%"><%=area %></td>
  </tr>
  <tr>
    <td width="13%" align="center">已售金额</td>
    <td width="54%"><%=price %></td>
  </tr>
  <tr>
    <td width="13%" align="center">销 售 率</td>
    <td width="54%"><%if (Double.parseDouble(num1)!=0){out.print(FormatD.getFloat2(Double.parseDouble(num)/Double.parseDouble(num1)*100,2));} %>%</td>
  </tr>
  
     <%
    SQL="select sum(factmoney*currrate) price from factGatheringRecord  where contractno in (select code from order_contract "+WhereSQL1+" and state<>3 )";
    rs= ViewBean.executeQuery(SQL) ;
	 
	
if (rs.next()){
    
   price=FormatD.getFloat3(rs.getDouble("price"),2);
   
}
rs.close();

   %>
     <%
	  String ajmoney="0";
    SQL="select sum(factmonye) price from    FactAjCharges where contractno in (select code from order_contract "+WhereSQL1+" and state<>3 )";
    rs= ViewBean.executeQuery(SQL) ;
if (rs.next()){
    ajmoney=FormatD.getFloat3(rs.getDouble("price"),0);
   price=FormatD.getFloat3(Double.parseDouble(price)+Double.parseDouble(ajmoney),2);
   
}
rs.close();

   %>
   <%
   String qk_price="0";
    SQL="select sum(shouldMoney*rate-YIJIAO) price from GatheringRecord  where       convert(char(10),shouldDate,120) <= convert(char(10),getdate(),120) and  contactno in (select code from order_contract "+WhereSQL1+" and state<>3 )";
    rs= ViewBean.executeQuery(SQL) ;
if (rs.next()){
    
   qk_price=FormatD.getFloat2(rs.getDouble("price"),2);
   
}
rs.close();

   %>
     <%
   String wdq_price="0";
    SQL="select sum(shouldMoney*rate-YIJIAO) price from GatheringRecord  where    convert(char(10),shouldDate,120) > convert(char(10),getdate(),120) and  contactno in (select code from order_contract "+WhereSQL1+" and state<>3 )";
   
    rs= ViewBean.executeQuery(SQL) ;
if (rs.next()){
    
   wdq_price=FormatD.getFloat2(rs.getDouble("price"),2);
   
}
rs.close();
 %>
    
  <tr>
    <td width="13%" rowspan="3" align="center">回款情况</td>
   
    <td width="13%" colspan="3" >
	<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
	<tr align="center"><td>可回款额</td><td>到期欠款</td><td>未到期款</td><td>未放款</td></tr>
	<tr align="center"><td><%=FormatD.getFloat2(Double.parseDouble(price1)-Double.parseDouble(price),2) %></td>
	<td><%=qk_price %></td><td><%=wdq_price %></td><td><%=FormatD.getFloat2(sum_ajmoney- Double.parseDouble(ajmoney),0)%></td></tr>
	</table>
	
	</td>
  
  </tr>
 
  <tr>
    <td width="13%" align="center">已回款额</td>
    <td width="54%" colspan="2"><%=FormatD.getFloat2(Double.parseDouble(price),2)  %></td>
  </tr>
  <tr>
    <td width="13%" align="center">回 款 率</td>
    <td width="54%" colspan="2"><% if (Double.parseDouble(price1)!=0){out.print(FormatD.getFloat2(Double.parseDouble(price)/Double.parseDouble(price1)*100,2));} %>%</td>
  </tr>
   <tr>
    <td width="13%" align="center">备注</td>
    <td width="54%" colspan="2">已售金额包括实测面积后计算的差价</td>
  </tr>
  </table>
　</center>
<a href="#" onclick="openwin('saleFx.jsp',500,450,100,100);">按图形分析</a>&nbsp;&nbsp;<!--<a href="#" onclick="openwin('autoselect10.jsp',300,400,100,100);">按时段对比统计</a>-->&nbsp;&nbsp;<a href="#" onclick="document.frm.action='DataCount1.jsp';document.frm.submit();">按销售面积对比分析</a>
 
<%

 //当前日期
 Calendar nowcal=new GregorianCalendar();
 int nowyear=nowcal.get(Calendar.YEAR);
 int nowmonth=(nowcal.get(Calendar.MONTH)+1);
 int nowday=nowcal.get(Calendar.DATE);
 String nowdate=""+nowyear+"-"+nowmonth+"-"+nowday;
 String strnowmonth=""+nowmonth;
 if(strnowmonth.length()==1) strnowmonth="0"+strnowmonth;
 String strnowday=""+nowday;
 if(strnowday.length()==1) strnowday="0"+strnowday;
 String strnowdate=""+nowyear+"-"+strnowmonth+"-"+strnowday;

String photo="2";
String aa[]=request.getParameterValues("fxzb");
String section=request.getParameter("section");
int begin_year=0,begin_month=0;



%>

  
	  <%String chooseyear=getbyte(request.getParameter("chooseyear"));
   String choosemonth=getbyte(request.getParameter("choosemonth"));
   if (!chooseyear.equals(""))nowyear=Integer.parseInt(chooseyear);
   if (!choosemonth.equals(""))nowmonth=Integer.parseInt(choosemonth);
  String sql="select convert(char(7),date,120) yearmonth ,count(*)*5  num,sum(jzarea)/10 jzarea,sum(rmbprice)/100000 sumprice from  order_contract "+WhereSQL1+" and  state<>3  group by convert(char(7),date,120)";
  String picurl=strSecNo;
	 
	
	Calendar calendar = Calendar.getInstance();
	String filename = String.valueOf(calendar.getTimeInMillis());	
    %> 
	 <%photo=FormtD1.main1("D:/"+ request.getContextPath()+"/crmv9/jsp/picture/1xspic1"+filename+".jpg","每月销售套数、面向、销售额","销售数据","销售分析",sql,3,"销售套数 [*5]","销售面积 [平方米/10]","销售总额 [十万]",""); %>
	 <table width="100%" border="0"><tr><td align="center">
    <%if (!photo.equals("")){%>
	<img src="../picture/<%=photo%>">
	<%}%>
 
  </td></tr></table>
 
 
</form>
<script language="javascript" src="../public_js/public.js">
</script>
</body>

</html>