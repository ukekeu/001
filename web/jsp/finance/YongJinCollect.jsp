<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>成交情况明细表</title>
 <script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
</head>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/getByteOut.jsp"%>
    <%@ include file="../public_js/qx_checke.jsp"%>
 <%
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"F002");


 %>

 <script language="javascript" src="../public_js/public.js">
</script>
<body bgcolor="#FFFFFF" text="#000000">
<%
String str_date=getbyte1(request.getParameter("Date1"));
String end_date=getbyte1(request.getParameter("Date2"));
String str_secno=getbyte1(request.getParameter("SecNo"));
String FindSeller=getbyte1(request.getParameter("se"));
if (!FindSeller.equals(""))FindSeller=" and o.seller ='"+FindSeller.trim()+"'";

String where=FindSeller;
  if (!str_date.equals("")&&!end_date.equals(""))
   where+=" and o.date between '"+str_date+"' and '"+end_date+"'";
// if (!str_secno.equals("")) where+=" and o.section='"+str_secno+"'";


String sell="";
 
String SQL="";
 %>
 <p align="center"><font size=3>销售佣金提成明细表</font></p>
 <center><%=str_date %>---<%=end_date %></center>
 <%@ include file="../public_js/CheckSection.jsp"%>
<%
double yjRate=0;
double yjRate1=0;
double yjRate2=0;
double yjRate3=0;
 String defaultA="";
	 String section=getbyte1(request.getParameter("section"));
 
if (!section.equals(""))section= " and o.section='"+section+"'";
 
ResultSet rs1=null;
 String dd="select sum(o.jzarea) jzarea,sum(o.RMBPrice) sumprice,sum(o.RMBPrice)/sum(o.jzarea) aveprice from   Order_Contract o,customer c where o.state<>3 and c.serialno=o.customer" +where+section;
 
 rs1 = ViewBean1.executeQuery(dd) ;
if (rs1.next()){

String sum_AREA=Format.getFloat(rs1.getFloat("jzarea"),2);
float sum_sumprice=rs1.getFloat("sumprice");
String ave=Format.getFloat(rs1.getFloat("aveprice"),0);
 

  
%>
 <% rs1 = ViewBean1.executeQuery("select *  from commision_scale where  section_no='"+getbyte1(request.getParameter("section"))+"'") ; 
if (rs1.next()){
  yjRate=rs1.getDouble("scale")/1000;
  yjRate1=rs1.getDouble("deduct1")/100;
  yjRate2=rs1.getDouble("deduct2")/100;
  yjRate3=rs1.getDouble("deduct3")/100;
}
rs1.close(); 
 
%>
<table>
<%String dd3=String.valueOf(sum_sumprice*yjRate);
if (dd3.indexOf(".")>0)dd3=dd3.substring(0,dd3.indexOf("."));
%>
<tr><td>总销售面积:</td><td><%=sum_AREA%></td><td>总销金额:</td><td><%=Format.getFloat(sum_sumprice,0)%></td><td>总销均价:</td><td><%=ave%></td><td>总佣金:</td><td><%=dd3  %></td><td><%if (!getbyte1(request.getParameter("section")).equals("")){ %><%if (Cortrol.indexOf("A")>=0){ %> <input type=button name=ok value="保 存 佣　金" onclick="openwin('count_YJ.jsp?section=<%=getbyte1(request.getParameter("section")) %>',10,10,10,10);"><%} }%></td>
</table>
<%}
rs1.close();
%>
<form name=frm>
楼盘：<select name="section" onchange="document.frm.submit();"> 
   <option>请选择楼盘名称，方可计算佣金</option>
<%  
if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql1="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";
   rs1=ViewBean1.executeQuery(sql1);	
	  String sec="";
	  String no1="";
      while (rs1.next()){
	   no1=rs1.getString("SerialNo");
	   sec=getbyte(rs1.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
	  if (!no1.equals(""))defaultNo=no1;
	    rs1.close();
	
     %> </select>
	
销售员:<select size="1" name="se" onkeydown="key(document.cus.tj)"  >
   <option value=""></option>
<%String selle="select  seller from seller where section_no in ("+SectionS+")";
rs1=ViewBean.executeQuery(selle);
  while (rs1.next()){
	   String Name=getbyte(rs1.getString("seller"));
       out.print("<option value='  "+Name+"'>"+Name+"</option>") ;
	}
  rs1.close();
  %>
	  
</select>   认购日期: 从<input type=input name=Date1 size=10 readonly value="" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;">到<input type=input name=Date2 size=10 readonly value="" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date2);return false;">
<input type=submit name=dda value="查 找">&nbsp;<%if (Cortrol.indexOf("A")>=0){ %> <input type=button name=ok value=" 发放" onclick="openwin('yj_out.jsp?secno=<%=getbyte1(request.getParameter("section")) %>',500,500,10,10);"><%} %>
<br>佣金计算说明:销售金额的<%=yjRate %>%,分三次发放：签认购书付<%=yjRate1 %>%，签约付<%=yjRate2 %>%,办按揭付<%=yjRate3 %>%
<table width="100%" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr> 
    <td rowspan="2" 　> 
      <div align="center">序号</div>
    </td>
   
    <td rowspan="2" 　 > 
      <div align="center">购买单位</div>
    </td>
    <td rowspan="2" 　> 
      <div align="center">面积</div>
    </td>
 
   <td rowspan="2" 　> 
      <div align="center">实际成交总价</div>
    </td>	
     
	 <td rowspan="2" 　> 
      <div align="center">认购日期</div>
    </td>	
	 <td rowspan="2" 　> 
      <div align="center">签约日期</div>
    </td>	
	 <td rowspan="2" 　> 
      <div align="center">按揭日期</div>
    </td>	
 <td rowspan="2" 　> 
      <div align="center">付款方式</div>
    </td>	
	   <td rowspan="2" 　 > 
      <div align="center">销售员</div>
    </td>
    <td rowspan="2" 　 > 
      <div align="center">佣金1</div>
    </td>
     <td rowspan="2" 　 > 
      <div align="center">佣金2 </div>
    </td>
     <td rowspan="2" 　 > 
      <div align="center">佣金3 </div>
    </td>
 <td rowspan="2" 　 > 
      <div align="center">佣金合计 </div>
    </td>
  </tr>
  <tr> </tr>
  <%
  int i=1;
float  sumarea=0;
int sumprice=0;
double y1=0;
double y3=0;
double y2=0;
double yjocunt=0;
String section1=getbyte1(request.getParameter("section"));
defaultA=section1;
if (!section1.equals(""))section1= " and o.section='"+section1+"'";
else{ section1= " and o.section='"+defaultNo+"'";
  //   defaultA=defaultNo;
    }


 SQL="SELECT o.introductive,c.cus_name,o.loft+o.Room_no Room_no,o.jzarea,o.unitprice,(o.rmbprice-o.zs_first_money)/o.jzarea saleunitprice,(o.rmbprice-o.zs_first_money) RMBPrice,o.youhui,o.date, o.visadate,o.ajdate,o.payment1,o.seller,o.SerialNo,o.subscription  from   Order_Contract o,customer c where  o.state<>3 and c.serialno=o.customer" +where+section1;
SQL+=" and o.seller='' order by o.seller, o.payment1,c.cus_name,o.SerialNo ";

  ResultSet rs2 = ViewBean1.executeQuery(SQL) ;
  
 
  
  
  while (rs2.next()){
  
  String introductive=rs2.getString("introductive");
  String da="";
if (introductive.equals("1")) da="(介绍)";
  String ro=getbyte(rs2.getString("room_no").trim()) ;
 
  float aa=rs2.getFloat("jzarea");
   sumarea+=aa;
  String are=Format.getFloat(aa,3) ;
   double salePrice=rs2.getDouble("RMBPrice");
   sumprice+=salePrice;
    String payment1=getbyte(rs2.getString("payment1"));
	String ygdate=rs2.getDate("date").toString();
	String qydate=getbyte(rs2.getString("visadate"));
	if (!qydate.equals(""))qydate=qydate.substring(0,10);
	String ajdate=getbyte(rs2.getString("ajdate"));
	if (!ajdate.equals(""))ajdate=ajdate.substring(0,10);
	String seller=getbyte(rs2.getString("seller").trim());
	yjocunt= salePrice*yjRate;
	%>  
	
  <tr align="center"> 
    <td 　 height="19">&nbsp;<%=i++ %></td>
  
    <td  align="left"  height="19">&nbsp;<%=ro%></td>
    <td  align="left" height="19">&nbsp;<%=are%></td>
 <%

  

  %>
<td  align="left" height="19">&nbsp;<%=Format.getFloat2(salePrice,0)%></td>

 <td  align="left" height="19">&nbsp;<%=ygdate%></td>
 <td  align="left" height="19">&nbsp;<%=qydate%></td>
 <td  align="left" height="19">&nbsp;<%=ajdate%></td>
<td  align="left" height="19">&nbsp;<%=payment1%></td>
    <td  align="left"  height="19">&nbsp;<%=seller+da%></td>
<%	
double yj1= 0;
double yj2=0;
double yj3=0; 
if (introductive.equals("0")){
   if (payment1.indexOf("揭")>=0){
  yj1= yjocunt*yjRate1 ;
 
  
  //y1+=salePrice*0.003*0.3;
  yj2=yjocunt*yjRate2 ;
  //y2+=salePrice*0.003*0.4;
  yj3=yjocunt*yjRate3;
  
 // y3+=salePrice*0.003*0.3;
  }else{
     yj1=yjocunt*yjRate1;
   //  y1+=salePrice*0.003*0.3;
     yj2=yjocunt*(yjRate2+yjRate3);
    // y2+=salePrice*0.003*0.7;

  

   }
}else{
  yj1=yjocunt*yjRate1*0.7;
  //y1+=salePrice*0.003*0.3*0.7;
  yj2= yjocunt*yjRate2*0.7;
   //y2+=salePrice*0.003*0.4*0.7;
  yj3=yjocunt*yjRate3*0.7;
   //y3+=salePrice*0.003*0.3*0.7;

}
try{
  y3+=yj3;
 y2+=yj2;
 y1+=yj1;
}catch(Exception s){}

 %>
    <td  align="left" height="19" >&nbsp;<%=Format.getFloat2(yj1,0)%></td>
    <%
	   
	 
	%>
	 <td  align="left" height="19" >&nbsp;<%=Format.getFloat2(yj2,0)%></td>
    <td 　  height="19">&nbsp;<%if (payment1.indexOf("揭")>=0){out.print(Format.getFloat2(yj3,0));} 
 %></td>
<%
String sumyj=String.valueOf(salePrice*0.003);
try{
if (sumyj.indexOf(".")>0)sumyj=sumyj.substring(0,sumyj.indexOf("."));
}catch(Exception s){}
 
%>
<td><%=Format.getFloat2(yjocunt,0)%></td>

  </tr>
  <%}
  rs2.close(); 
 if (y1>0){
 %>
 
 <tr>
	<td ><b>小计：</b></td>
	<td  >&nbsp;</td>
	<td><%=Format.getFloat(sumarea,3) %></td>
	<td  ><%=Format.getFloat(sumprice,0) %></td>
	<td  >&nbsp;</td>
	<td  >&nbsp;</td>
		<td  >&nbsp;</td>
			<td  >&nbsp;</td>
				<td  >&nbsp;</td>
	<td  ><%=Format.getFloat2(y1,0) %></td>
	<td  ><%=Format.getFloat2(y2,0)%></td>
	<td  ><%=Format.getFloat2(y3,0) %></td>
<td  ><%=Format.getFloat2(yjocunt,0) %></td>
	</tr>
	<% 
	  sumarea=0;
 sumprice=0;
 y1=0;
 y3=0;
 y2=0;
 
	 }

 SQL="SELECT o.introductive,c.cus_name,o.loft+o.Room_no Room_no,o.jzarea,o.unitprice,o.RMBPrice/o.jzarea saleunitprice,o.RMBPrice,o.youhui,o.date,o.visadate,o.ajdate,o.payment1,o.seller,o.SerialNo,o.subscription  from   Order_Contract o,customer c where  o.state<>3 and c.serialno=o.customer" +where+section1;

SQL+=" and o.seller<>'' order by o.seller,o.payment1, c.cus_name,o.SerialNo ";
ResultSet rs=null;
double yj1= 0;
double yj2=0;
double yj3=0; 
try{

  rs = ViewBean.executeQuery(SQL) ;
  
  while (rs.next()){
  String introductive=rs.getString("introductive");
  String da="";
if (introductive.equals("1")) da="(介绍)";
  String ro=getbyte(rs.getString("room_no").trim()) ;
 
  float aa=rs.getFloat("jzarea");
  
  String are=Format.getFloat(aa,3) ;
   float salePrice=rs.getFloat("RMBPrice");
  
    String payment1=getbyte(rs.getString("payment1"));
		String ygdate=rs.getDate("date").toString();
	String qydate=getbyte(rs.getString("visadate"));
	if (!qydate.equals(""))qydate=qydate.substring(0,10);
	String ajdate=getbyte(rs.getString("ajdate"));
	if (!ajdate.equals(""))ajdate=ajdate.substring(0,10);
	String seller=getbyte(rs.getString("seller").trim());
	yjocunt= salePrice*yjRate;
	if (sell.equals(""))sell=seller;
	else if  (!sell.equals(seller)){
	%>  
	<tr>
	<td ><b>小计：</b></td>
	<td  >&nbsp;</td>
	<td><%=Format.getFloat(sumarea,3) %></td>
	<td  ><%=Format.getFloat(sumprice,0) %></td>
	<td  >&nbsp;</td>
	<td  >&nbsp;</td>
		<td  >&nbsp;</td>
			<td  >&nbsp;</td>
				<td  >&nbsp;</td>
	<td  ><%=Format.getFloat2(y1,0) %></td>
	<td  ><%=Format.getFloat2(y2,0)%></td>
	<td  ><%=Format.getFloat2(y3,0) %></td>
<td  ><%=Format.getFloat2(y3+y2+y1,0) %></td>
	</tr>
	<%sell=seller;
	  sumarea=0;
 sumprice=0;
 y1=0;
 y3=0;
 y2=0;
	}
	 sumarea+=aa;
    sumprice+=salePrice;
   %>
  <tr align="center"> 
    <td 　 height="19">&nbsp;<%=i++ %></td>
  
    <td  align="left"  height="19">&nbsp;<%=ro%></td>
    <td  align="left" height="19">&nbsp;<%=are%></td>
 <%

  

  %>
<td  align="left" height="19">&nbsp;<%=Format.getFloat(salePrice,0)%></td>
  <td  align="left" height="19">&nbsp;<%=ygdate%></td>
 <td  align="left" height="19">&nbsp;<%=qydate%></td>
 <td  align="left" height="19">&nbsp;<%=ajdate%></td>
<td  align="left" height="19">&nbsp;<%=payment1%></td>
    <td  align="left"  height="19">&nbsp;<%=seller+da%></td>
<%	

if (introductive.equals("0")){
   if (payment1.indexOf("揭")>=0){
  yj1= yjocunt*yjRate1 ;
 
  
  //y1+=salePrice*0.003*0.3;
  yj2=yjocunt*yjRate2 ;
  //y2+=salePrice*0.003*0.4;
  yj3=yjocunt*yjRate3;
  
 // y3+=salePrice*0.003*0.3;
  }else{
     yj1=yjocunt*yjRate1;
   //  y1+=salePrice*0.003*0.3;
     yj2=yjocunt*(yjRate2+yjRate3);
    // y2+=salePrice*0.003*0.7;

  

   }
}else{
  yj1=yjocunt*yjRate1*0.7;
  //y1+=salePrice*0.003*0.3*0.7;
  yj2= yjocunt*yjRate2*0.7;
   //y2+=salePrice*0.003*0.4*0.7;
  yj3=yjocunt*yjRate3*0.7;
   //y3+=salePrice*0.003*0.3*0.7;

}
try{
  y3+=yj3;
 y2+=yj2;
 y1+=yj1;
}catch(Exception s){}

 %>
      <td  align="left" height="19" >&nbsp;<%=Format.getFloat2(yj1,0)%></td>
    <%
	   
	 
	%>
	 <td  align="left" height="19" >&nbsp;<%=Format.getFloat2(yj2,0)%></td>
    <td 　  height="19">&nbsp;<%if (payment1.indexOf("揭")>=0){out.print(Format.getFloat2(yj3,0));} 
 %></td>

<%
String sumyj=String.valueOf(salePrice*0.003);
try{
if (sumyj.indexOf(".")>0)sumyj=sumyj.substring(0,sumyj.indexOf("."));
}catch(Exception s){}
 
%>
<td><%= Format.getFloat2(yjocunt,0)%></td>
  </tr>
  <%}
  rs.close(); 
  if (y1>0){
  %>
  <tr>
	<td ><b>小计：</b></td>
	<td  >&nbsp;</td>
	<td><%=Format.getFloat(sumarea,3) %></td>
	<td  ><%=Format.getFloat(sumprice,0) %></td>
	<td  >&nbsp;</td>
	<td  >&nbsp;</td>
		<td  >&nbsp;</td>
			<td  >&nbsp;</td>
				<td  >&nbsp;</td>
	<td  ><%=Format.getFloat2(y1,0) %></td>
	<td  ><%=Format.getFloat2(y2,0)%></td>
	<td  ><%=Format.getFloat2(y3,0) %></td>
<td  ><%=Format.getFloat2(y3+y2+y1,0) %></td>
	</tr>
	<% 
	  sumarea=0;
 sumprice=0;
 y1=0;
 y3=0;
 y2=0;
	 }
   %>
  
  <%
  }catch(Exception s){out.print(s.getMessage()+SQL);}
  %>

</table>
</form>
<script>
setSelectMad(document.frm.section,'<%=defaultA%>');
setSelectMad(document.frm.se,'<%=getbyte1(request.getParameter("se"))%>');
</script>
</body>
</html>
