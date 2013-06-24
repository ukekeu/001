<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
	<title>客户分析</title>
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
 String cus_state=request.getParameter("cus_state");
 String cus_type="";
 if (cus_state.equals("1")){cus_state=" and ftsale=0";cus_type="未&nbsp;成&nbsp;交";}
 else  if (cus_state.equals("3")){cus_state=" ";cus_type="所&nbsp;有&nbsp;";}
 else  if (cus_state.equals("2")){cus_state=" and ftsale<>0";cus_type="成&nbsp;交&nbsp;";}
 
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
 <p align="center"><font size=4><b>客&nbsp;户&nbsp;数&nbsp;据&nbsp;分&nbsp;析</b></font></p>
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
  for (int nn=0;nn<aa.length;nn++){

 String messtitle="";
 if (aa[nn].equals("sr"))messtitle="月总收入";
 else  if (aa[nn].equals("wh"))messtitle="教育程度";
 else  if (aa[nn].equals("sex"))messtitle="性别";
 else  if (aa[nn].equals("age"))messtitle="年龄";
 
 else  if (aa[nn].equals("Job"))messtitle="职业";
 else  if (aa[nn].equals("ah"))messtitle="爱好";
 else  if (aa[nn].equals("tc"))messtitle="特长";
   		 

 
  
  if (pp==0)out.print("<tr>");
  out.print("<td align=center>按"+messtitle+"分析<br>");
    xdate="";
    ydate="";
  String  SQL="SELECT "+aa[nn]+",count(*) num  FROM VIPCUSTOMER  group by "+aa[nn];
 
 rs=ViewBean.executeQuery(SQL);
 int iii=0;

   while (rs.next()){
     //type[iii]=getbyte(rs.getString(aa));
	 iii++;
   
   }
  String type[]=new String[iii];
 
  rs.close();
   SQL="SELECT "+aa[nn]+",count(*) num  FROM VIPCUSTOMER  group by "+aa[nn];
 rs=ViewBean.executeQuery(SQL);
   iii=0;
 
   while (rs.next()){
     String aaa=getbyte(rs.getString(aa[nn]));
	 if (aaa.equals(""))aaa="未知";
 
    type[iii]=aaa;
	 iii++;
   
   }

  String sqlpay="";
 
  if(!photo.equals("3")){
	
  SQL="SELECT "+aa[nn]+",count(*) num  FROM VIPCUSTOMER   group by "+aa[nn];
 rs=ViewBean.executeQuery(SQL);
	 // out.print(sqlpay);
	  //out.close();
	    
	  rs=ViewBean.executeQuery(SQL);
	  while(rs.next()){
		  charges_money=rs.getFloat("num");
		  sum=charges_money;
		 if(xdate.equals("")){
			ydate=charges_money+"";
			String aaa=getbyte(rs.getString(aa[nn]));
	       
			xdate=aaa;
		 }else{
			if(photo.equals("1")){
			   ydate=ydate+","+charges_money;
			}else{
			   ydate=ydate+","+sum;
			}
			String aaa=getbyte(rs.getString(aa[nn]));
	        if (aaa.equals(""))aaa="未知";
			 
			xdate=xdate+","+aaa;
		 }
	  }rs.close();
  }else{
    
  SQL="SELECT "+aa[nn]+",count(*) num  FROM VIPCUSTOMER   group by "+aa[nn];
	  rs=ViewBean.executeQuery(SQL);
	  
	 // out.print(sqlpay);
	 iii=0;
	  while(rs.next()){
	 
          if(xdate.equals("")){
           
			 xdate=type[iii];
			 
			 ydate=rs.getFloat(2)+"";
		  }else{
             xdate=xdate+","+type[iii];
			 ydate=ydate+","+rs.getFloat(2)+"";
		  }
		  iii++;
	  }rs.close();
  }
 
  int xdate_len=5;
  %>
 
 <center>
 
<APPLET id="applet1<%=nn %>" name="applet1<%=nn %>" width=320 height=220  <%if(photo.equals("2")){%>code="charts.rectangle.class"<%}if(photo.equals("1")){%>code="charts.graph.class"<%}if(photo.equals("3")){%>code="charts.arc.class"<%}%>>
</applet>
</center>
<script language="JavaScript">
<!--

function init<%=nn %>(){
  var applet1=document.all.applet1<%=nn %>;
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
      var width=(<%=xdate_len%>+1)*xbetween+80;
	 <%if(!photo.equals("3")){%>
	  var height=40+ylen+40;
	  applet1.width=width;
	  applet1.height=height;
	  <%}%>
	  applet1.setParameter(xtitle,ytitle,xdate,ydate,ylen,xbetween,"人");
	  applet1.repaint();
  }
 }

 setTimeout(init<%=nn %>,1000);
//-->
</script>
<%
out.print("</td>");
pp++;
if (pp==2){pp=0;out.print("</tr>");}
} %>
</body>
</html>