<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<jsp:useBean id="userBean1" scope="page"  class="ConnDatabase.SDatabase"/>
<jsp:useBean id="userBean2" scope="page"  class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData" />
<%@ include file="../public_js/getByteOut.jsp"%>
 
<html>
 <head><title>费用收取情况直方图</title>
 <LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 </head>
<script language="javascript" src="../public_js/public.js"></script>
<script language="JavaScript">
 
function init(){
  var applet1=document.all.applet1;
  if(applet1){
	  var xtitle="月份";
	  var ytitle="房款";
	  
	  var unit=pm.unit.value;
	  if(unit==1) 
	  {
	    ytitle=ytitle+"(元)"; 
		window.unitspan.innerHTML="人民币元";
	  }
	  else if(unit==1000) 
	  {
	    ytitle=ytitle+"(千元)";
		window.unitspan.innerHTML="人民币千元";
	  }
	  else if(unit==10000) 
	  {
	    ytitle=ytitle+"(万元)";
		window.unitspan.innerHTML="人民币万元";
	  }
	  
	  var pre=pm.pre.value;
	  var ylen=200*pre/100;	   
	  var xbetween=50*pre/100;
      var width=(5+1)*xbetween+1600;
	  var height=40+ylen+40;
	  applet1.width=width;
	  applet1.height=height;
	  var xdate=pm.xdate.value;
	  var ydate=pm.ydate.value;
	  var ydate1=pm.ydate1.value;
	 
	  var val=ydate.split(",");
	  var val1=ydate1.split(",");
	  ydate="",ydate1=""; 
	  for(var i=0;i<val.length;i++)
	  {
	    if(ydate=="")
		{
		  ydate=""+(parseFloat(val[i])/unit);
		  ydate1=""+(parseFloat(val1[i])/unit);
		}
		else
		{
		  ydate=ydate+","+(parseFloat(val[i])/unit);
		  ydate1=ydate1+","+(parseFloat(val1[i])/unit);
		}
	  }
	  //alert(ydate);
	  applet1.setParameter(xtitle,ytitle,xdate,ydate,ydate1,ylen,xbetween);
	  applet1.repaint();
  }
 }
 
 
function init1(){
  var applet1=document.all.applet11;
  if(applet1){
	  var xtitle="月份";
	  var ytitle="首期款";
	  
	  var unit=pm.unit.value;
	  if(unit==1) 
	  {
	    ytitle=ytitle+"(元)"; 
		window.unitspan.innerHTML="人民币元";
	  }
	  else if(unit==1000) 
	  {
	    ytitle=ytitle+"(千元)";
		window.unitspan.innerHTML="人民币千元";
	  }
	  else if(unit==10000) 
	  {
	    ytitle=ytitle+"(万元)";
		window.unitspan.innerHTML="人民币万元";
	  }
	  
	  var pre=pm.pre.value;
	  var ylen=200*pre/100;	   
	  var xbetween=50*pre/100;
      var width=(5+1)*xbetween+100;
	  var height=40+ylen+40;
	  applet11.width=width;
	  applet11.height=height;
	  var xdate=pm.xdateA.value;
	  var ydate=pm.ydateA.value;
	  var ydate1=pm.ydate1A.value;
	 
	 

	  var val=ydate.split(",");
	  var val1=ydate1.split(",");
	  ydate="",ydate1=""; 
	  for(var i=0;i<val.length;i++)
	  {
	    if(ydate=="")
		{
		  ydate=""+(parseFloat(val[i])/unit);
		  ydate1=""+(parseFloat(val1[i])/unit);
		}
		else
		{
		  ydate=ydate+","+(parseFloat(val[i])/unit);
		  ydate1=ydate1+","+(parseFloat(val1[i])/unit);
		}
	  }
	  //alert(ydate);
	  applet11.setParameter(xtitle,ytitle,xdate,ydate,ydate1,ylen,xbetween);
	  applet11.repaint();
  }
 }
</script>
<body onload="init()">
<CENTER>
<form name=pm method=post>
<span id="printdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td colspan=4>
	  
	 费用单位:
	 <select name="unit" style="width:50" onchange="init();">
	  <option value="1" >元</option>
	  <option value="1000">千元</option>
	  <option value="10000" selected>万元</option>
	 </select>
	 查看比例:
	 <select name="pre" style="width:50" onchange="init();">
	  <option value=200>200<option value=190>180<option value=170>160</option><option value=150 selected>100</option><option value=140>80</option><option value=120>60</option><option value=110>40</option></select>
	 <script language="JavaScript">
	  /* setSelectMad(document.all.start_year,"<%//=start_year%>");
	   setSelectMad(document.all.start_month,"<%//=start_month%>");
	   setSelectMad(document.all.end_year,"<%//=end_year%>");
	   setSelectMad(document.all.end_month,"<%//=end_month%>");
	   setSelectMad(document.all.seluptown,"<%//=seluptown%>");
	   setSelectMad(document.all.selcharge,"<%//=selcharge%>");
	   */
	 </script>
	 <input type=button class=button name="view" onclick="viewit1();" value="查看">
	 
	</td>
  </tr>
</table>
</span>
<input type="hidden" name="isfind" value="">
<%
 
     String sqlstr1="",sqlstr2="",sqlstr3="";
	 String wherestr="";
	 String item="";
	 String ydatestr1="";
	 String ydatestr2="";
	 String xdatestr="";
	 int  chargemonth=0;
	 String ysum,ssum="",chargeyear;
	 ResultSet RS=null,RS1=null;
	 String uptownname="";
 
	 String chargename="";
 String Date1=getbyte1(request.getParameter("Date1"));
 String Date2=getbyte1(request.getParameter("Date2"));
  String section=getbyte1(request.getParameter("section"));
  String sectionname=section.substring(section.indexOf("-")+1);
  section=section.substring(0,section.indexOf("-"));
 String dateWhere="";
 if (!Date1.equals(""))dateWhere=" and shoulddate between '"+Date1+"' and '"+Date2+"'";
	 //获取应收数
	 sqlstr1="select sum(shouldmoney) ys,sum(yijiao) ss,substring(convert(char(24),shoulddate,120),1,7)  ym from gatheringrecord where contactno in (select code from order_contract where section='"+section+"')  " +dateWhere+" group by substring(convert(char(24),shoulddate,120),1,7) ";
	 //out.print(sqlstr1);
	 RS=userBean1.executeQuery(sqlstr1);
	 
	ydatestr1="";
	xdatestr="";
	ydatestr2="";
	chargeyear="";
	ysum="";
	ssum="";
	 while(RS.next())
	 {
	 
	   ysum=FormatD.getFloat1(RS.getFloat(1),3);
	   ssum=FormatD.getFloat1(RS.getFloat(2),3);
	  // ysum=RS.getString(1);
	  // ssum=RS.getString(2);
	   chargeyear=RS.getString(3);
	
	
	   if(ydatestr1.equals(""))
	   {
		  ydatestr1=ydatestr1+ysum;
		  ydatestr2=ydatestr2+ssum;
		  xdatestr=xdatestr+chargeyear;
	   }
	   else
	   {
	      ydatestr1=ydatestr1+","+ysum;
		  ydatestr2=ydatestr2+","+ssum;
		  xdatestr=xdatestr+","+chargeyear;
	   } 
	 }
	 
%>
<input type="hidden" name="xdate" value="<%=xdatestr%>">
<input type="hidden" name="ydate" value="<%=ydatestr1%>">
<input type="hidden" name="ydate1" value="<%=ydatestr2%>">
<center>
 
<br>
<table width="95%" border="0">
  <tr>
    <td align="center" width="25%"> 
     <b><%=sectionname%>收款进度分析统计图 </b> 
    </td>
	 
  </tr>
</table>
<table width="95%" border="0">
  <tr>
    <td align="center" width="25%"> 
    
    </td>
	<td align="center" width="50%">从左至右蓝色表示应收金额红色表示已收金额</td>
	<td align="right" width="25%">金额单位:<span id="unitspan">人民币万元</span></td>
  </tr>
</table>

<APPLET id="applet1" name="applet1" width=1000 height=300  code="chart.rectangle.class">
</applet>
<% //获取应收数
	 sqlstr1="select sum(shouldmoney) ys,sum(yijiao) ss,substring(convert(char(24),shoulddate,120),1,7)  ym from gatheringrecord where contactno in (select code from order_contract where section='"+section+"') and shouldqs<>0 " +dateWhere+" group by substring(convert(char(24),shoulddate,120),1,7) ";
	
	 RS=userBean1.executeQuery(sqlstr1);
	 
	
	 while(RS.next())
	 {
	 
	   ysum=FormatD.getFloat1(RS.getFloat(1),3);
	   ssum=FormatD.getFloat1(RS.getFloat(2),3);
	  // ysum=RS.getString(1);
	  // ssum=RS.getString(2);
	   chargeyear=RS.getString(3);
	
	
	   if(ydatestr1.equals(""))
	   {
		  ydatestr1=ydatestr1+ysum;
		  ydatestr2=ydatestr2+ssum;
		  xdatestr=xdatestr+chargeyear;
	   }
	   else
	   {
	      ydatestr1=ydatestr1+","+ysum;
		  ydatestr2=ydatestr2+","+ssum;
		  xdatestr=xdatestr+","+chargeyear;
	   } 
	 }
	 
%>
 
<center>
 <input type="hidden" name="xdateA" value="<%=xdatestr%>">
<input type="hidden" name="ydateA" value="<%=ydatestr1%>">
<input type="hidden" name="ydate1A" value="<%=ydatestr2%>">

<br>
<table width="95%" border="0">
  <tr>
    <td align="left" width="25%"> 
      制表日期:<%//=nowdate%>
    </td>
	<td align="center" width="50%">从左至右蓝色表示应收金额红色表示已收金额</td>
	<td align="right" width="25%">金额单位:<span id="unitspan">人民币万元</span></td>
  </tr>
</table>
<APPLET id="applet11" name="applet11" width=1000 height=300  code="chart.rectangle.class">
</applet>
</center>
</form>
</CENTER>
</body>
</html>