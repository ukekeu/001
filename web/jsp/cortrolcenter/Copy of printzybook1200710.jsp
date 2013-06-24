<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<link rel=stylesheet href="../class/line.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>打印选房试算表(包括二次或二次以上置业的月供)</title>
</head>
<%@ page language="java" import="java.sql.*,java.util.*,common.*" %> 
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="fat" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<script>

this.resizeTo(screen.availWidth,screen.availHeight)
this.moveTo(0,0)
this.focus()
</script>
<body topmargin="0" onload="print();">

 
 <%
  String code=getbyte2(request.getParameter("code"));
    String yh=getbyte2(request.getParameter("yh"));
    
   if (yh.indexOf("*")>=0)yh=fat.getFloat3(Double.parseDouble(yh.substring(0,yh.indexOf("*")))*Double.parseDouble(yh.substring(yh.indexOf("*")+1))/100,2);
 
String paylist=getbyte2(request.getParameter("paylist"));
  ViewBean.executeUpdate("update room set readnum=readnum+1 where code in("+code+")");
  String sql="select getdate()curdate ,R.yang_tai_area+R.Area  as sy_area,R.yang_tai_area,R.tnunitprice,R.loft,R.loft+R.room_code room_code,R.Room_Type,R.yong_tu,R.Area,R.RoomType,R.Direction,R.usedArea,R.Unitprice,R.Sumprice,S.Name,S.developcom from Room R inner join CRM_Project S on S.SerialNo=R.seccode where R.code in ("+code+")";
		 
		 String area="";
		 String jzarea="";
	  
		 String unitprice="",tnunitprice="";
		  String sumprice="";
		  String name="";
		  String room="";
		  String yongtu="";
		  String roomtype="";
		  String SaleArea="";
		  String room_code="";
		  String curdate="";
		  String developcom="";
		  String yang_tai_area="";
		   String sy_area="";
		ResultSet rs=ViewBean.executeQuery(sql);
		while (rs.next()){
		 curdate=rs.getString("curdate");
		  if (!roomtype.equals(""))
		     roomtype+=",";
		   roomtype+=getbyte(rs.getString("RoomType"));
		  if (!jzarea.equals(""))
		     jzarea+=",";
		   jzarea+=rs.getString("Area");
		   if (!area.equals(""))
		     area+=","; 
		   area+=rs.getString("usedArea");
		   
		    if (!unitprice.equals(""))
		     unitprice+=","; 
		   unitprice+= rs.getString("Unitprice");
		    if (!tnunitprice.equals(""))
		     tnunitprice+=","; 
		   tnunitprice+=rs.getString("tnunitprice");
		     if (!sumprice.equals(""))
		     sumprice+=","; 
			 
		   sumprice+= rs.getString("Sumprice");
		   
		    if (!room_code.equals(""))
		     room_code+=","; 
			 room_code+=getbyte(rs.getString("room_code"));
	     
		    if (!yang_tai_area.equals(""))
		     yang_tai_area+=","; 
			 yang_tai_area+=getbyte(rs.getString("yang_tai_area"));
		  if (!sy_area.equals(""))
		     sy_area+=","; 
			 sy_area+=getbyte(rs.getString("sy_area"));
		 
		   name=getbyte(rs.getString("Name"));
		   developcom=getbyte(rs.getString("developcom"));
		}rs.close();	
		
			
	
  StringTokenizer A1 = new StringTokenizer(room_code,",") ;
  int I1 = A1.countTokens() ; 
   StringTokenizer A2 = new StringTokenizer(jzarea,",") ;
  int I2 = A2.countTokens() ; 
   StringTokenizer A3 = new StringTokenizer(area,",") ;
  int I3 = A3.countTokens() ; 
   StringTokenizer A4 = new StringTokenizer(unitprice,",") ;
  int I4 = A4.countTokens() ; 
   StringTokenizer A5 = new StringTokenizer(tnunitprice,",") ;
  int I5 = A5.countTokens() ; 
   StringTokenizer A6 = new StringTokenizer(sumprice,",") ;
  int I6 = A6.countTokens() ; 
    StringTokenizer A7 = new StringTokenizer(roomtype,",") ;
	
  int I7 = A7.countTokens() ;
  
    StringTokenizer A8 = new StringTokenizer(yang_tai_area,",") ;
	  int I8 = A8.countTokens() ;
	   StringTokenizer A9 = new StringTokenizer(sy_area,",") ;
	  int I9 = A9.countTokens() ;
    String jzarea1[]=new String[I2];
   String tnarea1[]=new String[I3];	 
   String sumprice1[]=new String[I6];	
      String yang_tai[]=new String[I8];	
	  String sy_areas[]=new String[I9];	
 %>
<form name=cus method=POST ACTION="">
<p align=center><font size=5 class=FontColor><b><%=name %>价格试算明细表</b></font></p>
<center>
  <table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING1 ALIGN=center  >
  <tr><td>客户姓名:<input type=text name=lx class=unnamed1 ></td><td>诚意客户号:<input type=text name=lx class=unnamed1 ></td><td>试算日期:<%=curdate.substring(0,16) %></td></tr>
  </table>
<table BORDER=1 width="100%" height="78%" CELLSPACING=0 CELLPADDING1=0 ALIGN=center bordercolor="#000000" class="tablefill">
<tr align="center" >
 <td colspan="3" bgcolor="#808080"  width="30%">试算意向</td>
 <%try{
 int n=0;
 for (int nn=0;nn<I1;nn++) {n++;
 %>
 <td  bgcolor="#808080" >意向单位<%=n %></td> 
 <%
}
 }catch(Exception s){}%> 
 </tr>
 <tr   align="center" >
 <td  colspan="3">房号</td>
 <%try{
 while (A1.hasMoreElements()) {
 %>
 <td>&nbsp;<b><%= (String)A1.nextElement()%></b></td> 
 <%
}
 }catch(Exception s){}%> 
 </tr>
  <tr   align="center" >
 <td  colspan="3">户型</td>
 <%try{
 while (A7.hasMoreElements()) {
 %>
 <td>&nbsp;<b><%= (String)A7.nextElement()%></b></td> 
 <%
}
 }catch(Exception s){}%> 
 </tr>
 <tr align="center" >
 <td colspan="3">建筑面积(M<sup>2</sup>)</td>
 <%try{
 int jj=0;
 while (A2.hasMoreElements()) {
  String aaa=(String)A2.nextElement();
 jzarea1[jj]=aaa;
 
 %>
 <td><%= aaa%></td> 
 <%jj++;
}
 }catch(Exception s){}%> 
 </tr>
  <tr align="center" >
 <td colspan="3">套内建筑面积(M<sup>2</sup>)</td>
 <%try{
  int jj=0;
 while (A3.hasMoreElements()) {
 String bbb=(String)A3.nextElement();
 tnarea1[jj]=bbb;
 %>
 <td><%= bbb%></td> 
 <%jj++;
}
 }catch(Exception s){}%> 
 </tr>
 
  <tr align="center" >
 <td colspan="3">赠送面积(M<sup>2</sup>)</td>
 <%try{
  int jj=0;
 while (A8.hasMoreElements()) {
 String bbb=(String)A8.nextElement();

 %>
 <td><%= bbb%></td> 
 <%jj++;
}
 }catch(Exception s){}%> 
 </tr>
 
 
 <%try{
  int jj=0;
 while (A9.hasMoreElements()) {
 String bbb=(String)A9.nextElement();
 sy_areas[jj]=bbb;
 jj++;
}
 }catch(Exception s){}%> 
 
 
 <!--
  <tr align="center" >
 <td colspan="3">折前建筑面积单价(元/M<sup>2</sup>)</td>
 <%try{ 
 while (A4.hasMoreElements()) {
 
  
 %>
 <td><%= (String)A4.nextElement()%></td> 
 <% 
}
 }catch(Exception s){}%> 
 </tr>
   <tr align="center" >
 <td colspan="3">折前套内建筑面积单价(元/M<sup>2</sup>)</td>
 <%try{
 while (A5.hasMoreElements()) {
 %>
 <td><%= (String)A5.nextElement()%></td> 
 <%
}
 }catch(Exception s){}%> 
 </tr>
 -->
   <tr align="center" >
 <td colspan="3">折前总价(元)</td>
 <%try{
 int jj=0;
 while (A6.hasMoreElements()) {
 
  String ccc=(String)A6.nextElement();
  sumprice1[jj] =ccc;
 %>
 <td><%= fat.getFloat2(Double.parseDouble(ccc),0)%></td> 
 <%jj++;
}
 }catch(Exception s){}%>  
 </tr>
<%//if (java.lang.Integer.parseInt(yh)>0){
 String hy=getbyte2(request.getParameter("hy"));
  if (!hy.equals("0")){
 %>
 <tr align="center"  ><td colspan="3">诚意客户额外优惠</td>
  <% 
  
 for (int nnn=0;nnn<I1;nnn++) { 
 %>
 <td><%=getbyte2(request.getParameter("hy")) %>折</td> 
 <%
  }
 %> 
 </tr> 
 
 <%} %>
  <tr   align="center" >
 <td  colspan="3">开盘优惠</td>
 <%try{A7 = new StringTokenizer(roomtype,",") ;
 int jj=0;
 while (A7.hasMoreElements()) {
 %>
 <td>&nbsp;<b><%String hx= (String)A7.nextElement();
 String factsumprice=sumprice1[jj];
 
   if (hx.indexOf("二")==0){out.print("10万");sumprice1[jj]=String.valueOf(Double.parseDouble(factsumprice)-100000);}
   else    if (hx.indexOf("三")==0){out.print("12万");sumprice1[jj]=String.valueOf(Double.parseDouble(factsumprice)-120000);}
    else    if (hx.indexOf("四")==0){out.print("13万");sumprice1[jj]=String.valueOf(Double.parseDouble(factsumprice)-130000);}
	
 
 %></b></td> 
 <%jj++;
}
 }catch(Exception s){}%> 
 </tr>
 <%//if (java.lang.Integer.parseInt(yh)>0){
  if (!yh.equals("0")){
 %>
 <tr align="center"  ><td colspan="3">开盘折扣</td>
  <% 
  
 for (int nnn=0;nnn<I1;nnn++) { 
 %>
 <td><%=getbyte2(request.getParameter("yh")) %>折</td> 
 <%
  }
 %> 
 </tr>
 <!--
   
<tr align="center"><td colspan="3">一次性付款97折折后总价</td>
   <% 
   sql="select * from PayMent where  id in("+paylist+")  and PayName like '%一次%'  order by PayName ";
		rs=ViewBean.executeQuery(sql);
			String PayName="";
		double disc=0;
   while (rs.next()){
    disc= rs.getDouble("Discont");
  }
  rs.close();
 
   double ewyh= Double.parseDouble(yh);
   if (ewyh==0)ewyh=100;
double hyyh=Double.parseDouble(hy);
if (hyyh==0)hyyh=100;
double zcyh=Double.parseDouble(request.getParameter("dic1"));
     StringTokenizer  A611 = new StringTokenizer(sumprice,",") ;
     int  I611 = A611.countTokens() ; 
     try{
       int jj=0;
      while (A611.hasMoreElements()) {
        String eee=(String)A611.nextElement();
        //sumprice1[jj] =eee;
    %>
     <td><%=fat.getFloat2(Double.parseDouble(sumprice1[jj])*disc/100*ewyh/100*hyyh/100,0)%></td> 
    <%jj++;
//fat.getFloat2(Double.parseDouble(sumprice1[jj])*0.99*0.98*0.98/1000000)
       }
    }catch(Exception s){}%> 
 
 </tr>

  
<tr align="center"><td colspan="3">按揭付款98折折后总价</td>
   <% 
   sql="select * from PayMent where  id in("+paylist+")  and PayName like '%按揭%'  order by PayName ";
		rs=ViewBean.executeQuery(sql);
			  PayName="";
		  disc=0;
   while (rs.next()){
    disc= rs.getDouble("Discont");
  }
  rs.close();
 
     ewyh= Double.parseDouble(yh);
   if (ewyh==0)ewyh=100;
  hyyh=Double.parseDouble(hy);
if (hyyh==0)hyyh=100;
  zcyh=Double.parseDouble(request.getParameter("dic1"));
     StringTokenizer  A613 = new StringTokenizer(sumprice,",") ;
     int  I613 = A613.countTokens() ; 
     try{
       int jj=0;
      while (A613.hasMoreElements()) {
        String eee=(String)A613.nextElement();
       // sumprice1[jj] =eee;
    %>
     <td><%=fat.getFloat2(Double.parseDouble(sumprice1[jj])*disc/100*ewyh/100*hyyh/100,0)%></td> 
    <%jj++;
//fat.getFloat2(Double.parseDouble(sumprice1[jj])*0.99*0.98*0.98/1000000)
       }
    }catch(Exception s){}%> 
 
 </tr>
-->
 

<tr align="center"><td colspan="3">折后建筑面积单价(元/M<sup>2</sup>)</td>
  <% 
   
  
     StringTokenizer  A6111 = new StringTokenizer(sumprice,",") ;
     I611 = A6111.countTokens() ; 
     try{
       int jj=0;
      while (A6111.hasMoreElements()) {
        String eee=(String)A6111.nextElement();
       // sumprice1[jj] =eee;
	  
	  
    %>
     <td><%=fat.getFloat2(Double.parseDouble(sumprice1[jj])*disc/100*ewyh/100*hyyh/100/Double.parseDouble(jzarea1[jj]),0)%></td> 
    <%jj++;
        }
    }catch(Exception s){}%> 
 
 </tr>

 

<tr align="center"><td colspan="3">折算单价(元/M<sup>2</sup>)</td>
  <% 
   
  
     StringTokenizer  A61111 = new StringTokenizer(sy_area,",") ;
     I611 = A61111.countTokens() ;

     try{  
       int jj=0;
      while (A61111.hasMoreElements()) {
	  	  
        String eee=(String)A61111.nextElement();		 
    %>
     <td><%=fat.getFloat2(Double.parseDouble(sumprice1[jj])*disc/100*ewyh/100*hyyh/100/Double.parseDouble(sy_areas[jj]),0)%></td> 
    <%jj++;
        }
    }catch(Exception s){out.print(s);  }%> 
 
 </tr>
 
 <%}%>
<!--
<%
 sql="select * from PayMent where  id in("+paylist+")  and PayName like '%一次%'  order by PayName ";
		rs=ViewBean.executeQuery(sql);
	
 	String PayName="";
		double disc=0;
 while (rs.next()){
      PayName=rs.getString("PayName");
	%>	
	<tr align="center">
	 <td   >建筑面积单价(元/M<sup>2</sup>)</td>
	<% 
  
  double yh1= Double.parseDouble(yh);
   if (yh1==0)yh1=100;
double hy1=Double.parseDouble(hy);
if (hy1==0)hy1=100;
   disc= rs.getDouble("Discont");
   
   try{
for (int arr=0;arr<I1;arr++) {
 
 %>
 <td><%=fat.getFloat2(Double.parseDouble(sumprice1[arr])*yh1*hy1/10000*disc/100/Double.parseDouble(jzarea1[arr]),2)%></td> 
 <%
 
}
 }catch(Exception s){out.print(s);}%> 
  
	</tr>
	<tr align="center">
	
	<td   >套内建筑面积单价(元/M<sup>2</sup>)</td>
	 <% try{
for (int arr=0;arr<I1;arr++) {
 
 %>
 <td><%=fat.getFloat2(Double.parseDouble(sumprice1[arr])*yh1*hy1/10000*disc/100/Double.parseDouble(tnarea1[arr]),2)%></td> 
 <%
 
}
 }catch(Exception s){out.print(s);}%> 
  
	</tr>
	<tr align="center">
	
	<td   >总价(元 )</td>
	 <% try{
for (int arr=0;arr<I1;arr++) {
 
 %>
 <td><%=fat.getFloat2(Double.parseDouble(sumprice1[arr])*yh1*hy1/10000*disc/100,0)%></td> 
 <%
 
}
 }catch(Exception s){out.print(s);}%> 
  
	</tr>



	<%}
		rs.close();
 %>
-->
<%
 sql="select top 1 * from PayMent where  id in("+paylist+")  and PayName like '%按揭%'  order by PayName ";
		rs=ViewBean.executeQuery(sql);
		  PayName="";
		  disc=0;
 
 while (rs.next()){
      PayName=rs.getString("PayName");
	%>	
	<tr align="center">
	<td width=15%  rowspan="2">一次置业<%//= PayName%><br> 8成按揭<%//=rs.getInt("Discont") %></td>
	
 

	<% 
  
	  
  double yh1= Double.parseDouble(yh);
   if (yh1==0)yh1=100;
double hy1=Double.parseDouble(hy);
if (hy1==0)hy1=100;
   disc= rs.getDouble("Discont");
    %> 
  
	 		 
	<%if (PayName.indexOf("揭")>=0) { %>
	
	 
	
	<td   colspan="2">首期款</td>
	 <% 
	 String csnum="";
	 try{
	 if (PayName.indexOf("揭")>=0){
          	//csnum=PayName.substring(PayName.indexOf("(")+1,PayName.indexOf("%"));
	     }
for (int arr=0;arr<I1;arr++) {
    if(Double.parseDouble(jzarea1[arr])>90)csnum="70.00";
    else csnum="80.00";
  double ajk=(Double.parseDouble(sumprice1[arr])*yh1*hy1/10000*disc/100*Double.parseDouble(csnum)/100);
  int ajm=(int)ajk/10000;
//out.println(ajm);
 %>
 <td> <%=fat.getFloat2(Double.parseDouble(sumprice1[arr])*yh1*hy1/10000*disc/100-ajm*10000,0)%></td> 
 <%
 
}
 }catch(Exception s){out.print(s);}%> 
  
	</tr>
	<tr align="center">
	
	<td   colspan="2">按揭款</td>
	 <% 
	   csnum="";
	 try{
	 if (PayName.indexOf("揭")>=0){
          	//csnum=PayName.substring(PayName.indexOf("(")+1,PayName.indexOf("%"));
	     }
for (int arr=0;arr<I1;arr++) {
    if(Double.parseDouble(jzarea1[arr])>90)csnum="70.00";
    else csnum="80.00";
   double ajk=(Double.parseDouble(sumprice1[arr])*yh1*hy1/10000*disc/100*Double.parseDouble(csnum)/100);     
 %>
 <td><%= fat.getFloat2(Double.parseDouble(String.valueOf((int)ajk/10000))*10000,0)%></td> 
 <%
 
}
 }catch(Exception s){out.print(s);}%> 
  
	</tr>
	<%} %>
	<%	
		}
		rs.close();
		
		%>
	
		<%
	  yh=getbyte2(request.getParameter("yh"));
             
          if (yh.indexOf("*")>=0)yh=fat.getFloat3(Double.parseDouble(yh.substring(0,yh.indexOf("*")))*Double.parseDouble(yh.substring(yh.indexOf("*")+1))/100,2);
       
		  if ( Double.parseDouble(yh)==0) 
              yh="100";
		
		 %>
		 
		 
 
	
	 <% 
	  String ajStr = "";//"select id,year,MonthTax,yearTax,yong_tu,MonthPay,lx from ajllgkb  where type=3  and yong_tu=0 and year=5";//where id >=" + String.valueOf(firstPos);
	ResultSet ajRS = null;//ViewBean.executeQuery(ajStr);	
  //平均法
 double pjpay=0;
 
 int year=10;
 yh=getbyte2(request.getParameter("yh"));

if (yh.indexOf("*")>=0)yh=fat.getFloat3(Double.parseDouble(yh.substring(0,yh.indexOf("*")))*Double.parseDouble(yh.substring(yh.indexOf("*")+1))/100,2);
  
 if ( Double.parseDouble(yh)==0) 
       yh="100";
	   
 while (year<=30){ %>
 
	  <tr align="center">
	  <%if (year==10){ %>
	<td  rowspan="3" align="center">一次置业按揭月供款<br>(等额本息还款法)</td>
	<%} %>
	<td   colspan="2" ><%=year %>年月供款 </td>
	
	 <% 
	    ajStr = "select id,year,MonthTax,yearTax,yong_tu,MonthPay,lx from ajllgkb  where type=3  and yong_tu=0 and year="+year;//where id >=" + String.valueOf(firstPos);
	  ajRS = ViewBean.executeQuery(ajStr);	
 //平均法
   pjpay=0;
	while (ajRS.next()) { 
	  pjpay=ajRS.getDouble("MonthPay");
	  
	}
 
	ajRS.close();
	 try{
for (int arr=0;arr<I1;arr++) {
 //if (arr==0)out.print("<td   >70% </td>");
  double ajcs=0;
  if(Double.parseDouble(jzarea1[arr])>90)ajcs=0.7;
    else ajcs=0.8;
  Double ajkmoney= (Double.parseDouble(sumprice1[arr])*disc/100*Double.parseDouble(yh)/100*Double.parseDouble(hy)/100*ajcs);
  int ajkk=(int)(ajkmoney/10000);
 %>
 <td><%=fat.getFloat2(ajkk*pjpay,0)%></td> 
 <%
 
}
 }catch(Exception s){out.print(s);}%> 
 </tr> 
 <%year+=10;}
 
  %>  
 
 	
		
<%
 sql="select top 1 * from PayMent where  id in("+paylist+")  and PayName like '%按揭%'  order by PayName ";
		rs=ViewBean.executeQuery(sql);
		  PayName="";
		  disc=0;
 
 while (rs.next()){
      PayName=rs.getString("PayName");
	%>	
	<tr align="center">
	<td width=15%  rowspan="2">二次或二次以上置业<%//= PayName%><br> 6成按揭<%//=rs.getInt("Discont") %></td>
	 <!--<td  rowspan="<%if (PayName.indexOf("揭")<0) {%>3<%}else{ %>3<%} %>">折<br>后<br>价<br>格</td> -->
	 
	
	
 

	<% 
  
	  
  double yh1= Double.parseDouble(yh);
   if (yh1==0)yh1=100;
double hy1=Double.parseDouble(hy);
if (hy1==0)hy1=100;
   disc= rs.getDouble("Discont");
 if (PayName.indexOf("揭")>=0) { %>
	
 
	
	<td   colspan="2">首期款</td>
	 <% 
	 String csnum="";
	 try{
	 if (PayName.indexOf("揭")>=0){
          	//csnum=PayName.substring(PayName.indexOf("(")+1,PayName.indexOf("%"));
	     }
for (int arr=0;arr<I1;arr++) {
   // if(Double.parseDouble(jzarea1[arr])>90)csnum="70.00";
  //  else csnum="80.00";
  csnum="60.00";
  double ajk=(Double.parseDouble(sumprice1[arr])*yh1*hy1/10000*disc/100*Double.parseDouble(csnum)/100);
  int ajm=(int)ajk/10000;
//out.println(ajm);
 %>
 <td> <%=fat.getFloat2(Double.parseDouble(sumprice1[arr])*yh1*hy1/10000*disc/100-ajm*10000,0)%></td> 
 <%
 
}
 }catch(Exception s){out.print(s);}%> 
  
	</tr>
	<tr align="center">
	
	<td   colspan="2">按揭款</td>
	 <% 
	   csnum="";
	 try{
	 if (PayName.indexOf("揭")>=0){
          	//csnum=PayName.substring(PayName.indexOf("(")+1,PayName.indexOf("%"));
	     }
for (int arr=0;arr<I1;arr++) {
   // if(Double.parseDouble(jzarea1[arr])>90)csnum="70.00";
    //else csnum="80.00";
	 csnum="60.00";
   double ajk=(Double.parseDouble(sumprice1[arr])*yh1*hy1/10000*disc/100*Double.parseDouble(csnum)/100);     
 %>
 <td><%= fat.getFloat2(Double.parseDouble(String.valueOf((int)ajk/10000))*10000,0)%></td> 
 <%
 
}
 }catch(Exception s){out.print(s);}%> 
  
	</tr>
	<%} %>
	<%	
		}
		rs.close();
		
		%>
	
	 <% 
	 
   pjpay=0;
 
   year=10;
 yh=getbyte2(request.getParameter("yh"));

if (yh.indexOf("*")>=0)yh=fat.getFloat3(Double.parseDouble(yh.substring(0,yh.indexOf("*")))*Double.parseDouble(yh.substring(yh.indexOf("*")+1))/100,2);
  
 if ( Double.parseDouble(yh)==0) 
       yh="100";
	   
 while (year<=30){ %>
 
	  <tr align="center">
	  <%if (year==10){ %>
	<td  rowspan="3" align="center">二次或二次以上置业<br>按揭月供款<br>(等额本息还款法)</td>
	<%} %>
	<td   colspan="2" ><%=year %>年月供款 </td>
	
	 <% 
	    ajStr = "select id,year,MonthTax,yearTax,yong_tu,MonthPay MonthPay,lx from ajllgkb  where type=3  and yong_tu=0 and year="+year;//where id >=" + String.valueOf(firstPos);
	  ajRS = ViewBean.executeQuery(ajStr);	
 //平均法
   pjpay=0;
	while (ajRS.next()) { 
	  pjpay=ajRS.getDouble("MonthPay");
	  
	}
	ajRS.close();
	 try{
for (int arr=0;arr<I1;arr++) {

  double ajcs=0;
 
  ajcs=0.6;
  Double ajkmoney= (Double.parseDouble(sumprice1[arr])*disc/100*Double.parseDouble(yh)/100*Double.parseDouble(hy)/100*ajcs);
  int ajkk=(int)(ajkmoney/10000);
 %>
 <td><%=fat.getFloat2(ajkk*pjpay,0)%></td> 
 <%
 
}
 }catch(Exception s){out.print(s);}%> 
 </tr> 
 <%year+=10;}
 
  %>  
 
 
</table> 
   <table BORDER=0 width="90%" CELLSPACING=0 CELLPADDING1 ALIGN=center  > 
  <tr  ><td>1、以上价格不含购房而产生的相关税费；</td></tr>
  <tr><td>2、折后总价=折前价格-开盘优惠*开盘折扣 ；</td></tr>
     <tr><td>3、以上优惠及折扣仅限开盘当天，第二日自动失效；</td></tr>
 <tr><td>4、以上数据仅供参考，最终以双方签署的买卖合同为准；</td></tr>
  　<tr><td>5、本活动最终解释权归<%=developcom %>；</td></tr>
  </table>
 　</center> 
 
 
</FORM> 
</body>

</html>
