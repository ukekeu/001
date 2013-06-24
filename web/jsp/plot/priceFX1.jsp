<%@ page contentType="text/html;charset=GBK" %>

<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/>  
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<LINK href="../class/line.css" rel=stylesheet>
	<title>销售圴价对比分析图</title>
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
<%String photo="2";//request.getParameter("photo");
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
ResultSet rs=null;


%>
<input type="hidden" name="show" value="<%=request.getParameter("show")%>">
 
 
 
  <div style="display:none">
  <%if(!photo.equals("3")){%>&nbsp;&nbsp;查看比例:<select name="pre" style="width:50" onchange="init();"><option value=200>200<option value=180>180<option value=160>160</option><option value=140>140</option><option value=120>120</option><option value=100 selected>100</option><option value=80>80</option><option value=60>60</option><option value=40>40</option></select>%<%}%>
X轴标题：<input type="text" class="textinput"  name="xtitle" value="月份">
Y轴标题:<input type="text" class="textinput"  name="ytitle" value="费用(万元)">
X轴数据：<input type="text" class="textinput"  name="xdate" value="一月,二月,三月,四月,五月">
输入数据：<input type="text" class="textinput"  name="ydate" value="5,6,7,8">
Y轴高度：<input type="text" class="textinput"  name="ylen" <%if(photo.equals("3")){%> value="340"<%}else{%>value="200"<%}%>>
X轴间隔宽度：<input type="text" class="textinput"  name="xbetween" <%if(photo.equals("3")){%>value="160"<%}else{%>value="60"<%}%>>
 </div>
 <p align="center"><font size=4><b>&nbsp;销&nbsp;售&nbsp;均&nbsp;价&nbsp;比&nbsp;较&nbsp;图</b></font></p>
 <table width="100%" border="0"  >
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
 
   String SecName=getbyte2(request.getParameter("SecName"));
    String SecNo=getbyte2(request.getParameter("SecNo"));
	String Loft= getbyte2(request.getParameter("Loft")) ;
	String Build= getbyte2(request.getParameter("Build")) ;
  if (pp==0)out.print("<tr>");
  out.print("<td align=center><br>");
 
	int iii=0;
   String SQL="select payment ,avg(price1) price from  试算价目表 where sectionno='"+SecNo+"' and loft='"+Loft+"' and ( building='"+Build+"'or building is null) group by payment";
	    rs = ViewBean.executeQuery(SQL);
 
	 
	 iii=0;
	  while(rs.next()){
	      
          if(xdate.equals("")){
           
			 xdate=rs.getString("payment");
			 
			 ydate=rs.getFloat(2)+"";
		  }else{
             xdate=xdate+","+rs.getString("payment");
			 ydate=ydate+","+rs.getFloat(2)+"";
		  }
		  iii++;
	  }rs.close();
  
  int xdate_len=5;
String nn="1";
  %>
  <center>
 
<APPLET id="applet1<%=nn %>" name="applet1<%=nn %>" width=320 height=220  <%if(photo.equals("2")){%>code="charts.rectangle.class"<%}if(photo.equals("1")){%>code="charts.graph.class"<%}if(photo.equals("3")){%>code="charts.arc.class"<%}%>>
</applet>
</applet>
</center>
<script language="JavaScript">
<!--

function init1(){
  var applet1=document.all.applet11;
  if(applet1){
	  
     // applet1.width=500;
	 // applet1.heigth=800;
	  //alert(document.all.xdate.value);
	  var xtitle="<%=xtitle%>";
	  var ytitle="<%=ytitle%>";
	  var xdate="<%=xdate%>";
	  var ydate="<%=ydate%>";
	  <%if(photo.equals("3")){%>
	   var pre=100;
	  <%}else{%>
	  var pre=parseInt(document.all.pre.value);
	  <%}%>
	  var ylen=parseInt(document.all.ylen.value)*pre/100;	   
	  var xbetween=parseInt(document.all.xbetween.value)*pre/100;
      var width=(<%=xdate_len%>+1)*xbetween+120;
	 <%if(!photo.equals("3")){%>
	  var height=40+ylen+40;
	  applet1.width=width;
	  applet1.height=height;
	  <%}%>
	 
 applet1.setParameter(xtitle,ytitle,xdate,ydate,ylen,xbetween,"元/平方米");
 
	  applet1.repaint();
  }
 }

 setTimeout(init1,1000);
//-->
</script>

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