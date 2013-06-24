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
<title>销售合同</title>

</head>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
 
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script> 
 <%
  String  sqlrg="";
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"S003");
 //按揭款位数
  String ajkw="10000";
   ResultSet wRs=ViewBean.executeQuery("select state_type from hsm_ajk where section_no='"+request.getParameter("secno")+"'");
   if (wRs.next()){

     if (wRs.getString("state_type").equals("1"))
		  ajkw="1000";

   }
wRs.close();

  String contractno=getbyte2(request.getParameter("contractno"));
  String secno=getbyte2(request.getParameter("secno"));
  String loft=getbyte2(request.getParameter("loft"));
  String build=getbyte2(request.getParameter("build"));
  String room=getbyte2(request.getParameter("roomno"));
  String Floor=request.getParameter("Floor");
  String see=request.getParameter("see");
  int checstate=1;
  if(see==null)see="";
   
  //读取合同资料
      sqlrg="select o.code,o.serialno,o.ContractNo,o.Customer,o.sectionname as secname,o.building,";
	  sqlrg+="o.Room_no,o.buildtype,o.roomtype,o.payment,(salerprice-zs_first_money)/o.jzarea as sjsalejzPrice,tnunitprice as sjsaleUsePrice,";
	  sqlrg+="o.area,o.zx,o.unitprice,o.salerprice,unitprice as salejzPrice,tnunitprice saleUsePrice,o.AjMoney,o.MonthPayMoney,";
	  sqlrg+="o.subscription,o.jldate,o.currency,o.state,o.room_sumprice,o.room_sumprice-o.ajmoney firstmoney,";
	  sqlrg+="convert(char(24),o.date,120) date,o.note,o.AjBk,o.AjYear,o.AJcs,o.Ajtype,o.jzarea";
	  sqlrg+=",c.signatory,o.JLdate,o.VisaDate,o.jzdate,o.ajdate,o.httype,o.yh_zs,o.count_type";
	  sqlrg+=",o.disc,c.ID_Card,c.Phone,c.sj,c.Address,c.Zip_Code,DATEDIFF(dd,date,qytxdate) qytxdate ,";
	 sqlrg+="o.CusType,o.currency,o.rate,o.seller,o.OutDate,o.FkDate,o.bxState,o.room_sumprice+o.youhui youhuiprice,";
	  sqlrg+="o.bxMoney,o.firstState,o.yhMoney,o.GzState,o.ewdisc,c.bbj,c.sj,o.youhui,o.youhui_date,o.youhuibeizhu,o.state,o.loke,datediff(mi,o.lokedate,getdate()) as nn,o.zs_first_money,o.rmbprice-o.zs_first_money as factprice ,(o.rmbprice-o.zs_first_money)/o.jzarea as fsalejzPrice,(o.rmbprice-o.zs_first_money)/o.area as fsaleUsePrice,checkstate,checkperson,checkdate ";
	  sqlrg+=",o.gaizhang_area,o.gaizhang_unitprice, o.gaizhang_area*o.gaizhang_unitprice as g_sumprice   ";
	  sqlrg+=" ,o.cq_lingquDate,o.song_jian_date,o.cq_date,o.yhzj_date,o.y_area,o.Y_jzarea from  Order_Contract o,customer c  ";
	  sqlrg+=" where     o.Customer=c.serialNo   ";
 
	  sqlrg+=" and o.code='"+contractno+"'";
  
	  ResultSet rs3=ViewBean.executeQuery(sqlrg);
  
	   String song_jian_date="",cq_date="",yhzj_date=""; 
	   String code="",cq_lingquDate="";
	   String rgno="",yh_zs="";
	   String youhui_date="";
	   String ContractNo="";
	   String secname="";
	   String buildtype="";
	   String roomtype="";
	   String httype="";
	   String zx="";
	   String cusno="";
	   String area="";;
	   float unitprice;
	   float saleprice;
	   float subscription;
	   String date="";
	   String year="";
	   String month="";
	   String VisaDate="";
	   String note="";
	   String price="";
	   String salprice="";
	   String saleJzPrice="";
	   String saleUsePrice="";
	   String sjsaleJzPrice="";
	   String sjsaleUsePrice="";
	   String fsaleJzPrice="";
	   String fsaleUsePrice="";
	   String firstmoney="";
	   String payment="";
	   String dj="";
	   String area1="";
	   String ajbk="";
	   String ajyr="";
	   String ajcs="";
	   String ajtype="";
	   String ajmoney="";
	   String monthpay="";
	   String cusname="";
	   String StrBBJ="";
	   String StrSJ="";
	   String JLdate="";
	   String disc1="";
       String disc2="";
	   String ID_Card="";
	   String Phone="";
	   String Address="";
	   String Zip_Code ="";
	   String custype="";
	   String curry="";
	   String rate="";
	   String seller="";
	   String StrAjDate="";
	   String StrCaDate="";
	   String StrJzDate="";
	   String StrAjState="";
	   String StrGzState="";
	   String StrBxState="";
	   String StrBxMoney="";
	   String StrFkDate="";
	   String StrEwDisc="";
	   String StrYhMoney="";
	   String StrFirstState="";
	   String gaizhang_area="";
	   String gaizhang_unitprice="";
	   String g_sumprice="";
	   String StrState="";
	   String youhui="";
	   String sj="";
	   String qytxdate="";
	    String state="";
		String loke="",count_type="";
		int nn=0;
		String factprice="0";
		String zs_first_money="0";
	   String youhuibeizhu="";
	   String checkperson="";
	   String checkDate="";
	   boolean checkstate=false;
	   float qd_tnarea=0;
	   float qd_jzarea=0;
	   float hs_tnarea=0;
	   float hs_jzarea=0;
	   
	   String room_price="",youhuiprice="";
	   //out.close();
	  while(rs3.next()){  
	     code=rs3.getString("code");  
	     rgno=getbyte(rs3.getString("serialno"));  
		 ContractNo=getbyte(rs3.getString("ContractNo"));  
		 cusno=getbyte(rs3.getString("Customer"));  
	     secname=getbyte(rs3.getString("secname"));           
	     build=getbyte(rs3.getString("building"));           
		 room=rs3.getString("Room_no");  
		 buildtype=getbyte(rs3.getString("buildtype")); 
		 roomtype=getbyte(rs3.getString("roomtype"));
		 payment=getbyte(rs3.getString("payment"));
		 sjsaleJzPrice=Format.getFloat1(rs3.getFloat("sjsaleJzPrice"),2); 
		 sjsaleUsePrice=Format.getFloat1(rs3.getFloat("sjsaleusePrice"),2); 
		//payment=payment.substring(0,payment.lastIndexOf("."))+"*"+payment.substring(payment.lastIndexOf(".")+1)+"*期";
		 area=rs3.getString("area"); 
		 zx=getbyte(rs3.getString("zx"));
		 unitprice=rs3.getFloat("unitprice"); 
		 price=String.valueOf(unitprice);
		 salprice=rs3.getString("salerprice"); 
		 saleJzPrice=Format.getFloat1(rs3.getFloat("saleJzPrice"),2); 
		 saleUsePrice=Format.getFloat1(rs3.getFloat("saleusePrice"),2); 
		 ajmoney =rs3.getString("AjMoney"); 
		 monthpay =rs3.getString("MonthPayMoney"); 
		 if (payment.indexOf("揭")>=0)
	 
		firstmoney=rs3.getString("firstmoney"); 
		// salprice=String.valueOf(saleprice);
		 subscription=rs3.getFloat("subscription"); 
		 dj=String.valueOf(subscription);
		 JLdate=getbyte(rs3.getString("jldate")); 
		 curry=rs3.getString("currency"); 
		 date=getbyte(rs3.getString("date")); 
		 if (!date.equals(""))date=date.substring(0,10);
		 note=getbyte(rs3.getString("note")); 
		  ajbk=getbyte(rs3.getString("AjBk")); 
		 ajyr=rs3.getString("AjYear"); 
         ajcs=rs3.getString("AJcs"); 
		 ajtype=getbyte(rs3.getString("Ajtype")); 
		 area1=rs3.getString("jzarea"); 
		 cusname=getbyte(rs3.getString("signatory")); 
		 JLdate=rs3.getString("JLdate"); 
		 VisaDate=getbyte(rs3.getString("VisaDate")); 
		 StrJzDate=getbyte(rs3.getString("jzDate")); 
		 StrAjDate=getbyte(rs3.getString("ajDate")); 
		 httype=getbyte(rs3.getString("httype")); 
		 disc1=rs3.getString("disc"); 
		 count_type=rs3.getString("count_type"); 
		 disc2=disc1.substring(disc1.indexOf("*")+1);
 		 if (disc1.indexOf("*")>=0)
		  disc1=disc1.substring(0,disc1.indexOf("*"));
		  ID_Card=rs3.getString("ID_Card"); 
	      Phone=rs3.getString("Phone"); 
		  sj=rs3.getString("sj");
	      Address=getbyte(rs3.getString("Address")); 
	      Zip_Code =rs3.getString("Zip_Code"); 
		  qytxdate=getbyte(rs3.getString("qytxdate"));  
		
		  custype=getbyte(rs3.getString("custype")); 
		  curry=getbyte(rs3.getString("currency"));
		  StrState=getbyte(rs3.getString("state"));
		  room_price=getbyte(rs3.getString("room_sumprice"));
		  youhuiprice=getbyte(rs3.getString("youhuiprice"));
		  rate=getbyte(rs3.getString("rate"));
		  seller=getbyte(rs3.getString("seller"));
		  StrCaDate=getbyte(rs3.getString("outdate"));
		  StrFkDate=getbyte(rs3.getString("fkdate"));
		  StrBxState=getbyte(rs3.getString("bxState"));
   	      StrBxMoney=getbyte(rs3.getString("bxMoney"));
		  StrFirstState=getbyte(rs3.getString("firstState"));
		  StrYhMoney=getbyte(rs3.getString("yhMoney"));
		  StrGzState=getbyte(rs3.getString("GzState"));
		  StrEwDisc=getbyte(rs3.getString("ewdisc"));
		  StrBBJ=getbyte(rs3.getString("BBJ"));
		  StrSJ=getbyte(rs3.getString("SJ"));
		  youhui=getbyte(rs3.getString("youhui"));
		  yh_zs=getbyte(rs3.getString("yh_zs"));
		  youhui_date=getbyte(rs3.getString("youhui_date"));
		  if (!youhui_date.equals(""))youhui_date=youhui_date.substring(0,10);
		  youhuibeizhu=getbyte(rs3.getString("youhuibeizhu"));
		  state=getbyte(rs3.getString("state"));
		  loke=getbyte(rs3.getString("loke"));
	      if (loke.equals(""))loke="0";
          	nn=rs3.getInt("nn");
		  zs_first_money=rs3.getString("zs_first_money");
		  fsaleJzPrice=Format.getFloat1(rs3.getFloat("fsaleJzPrice"),2); 
		  fsaleUsePrice=Format.getFloat1(rs3.getFloat("fsaleusePrice"),2); 
		   if (payment.indexOf("揭")>=0)
		 firstmoney=String.valueOf(Float.parseFloat(firstmoney)-Float.parseFloat(zs_first_money));
		  factprice=rs3.getString("factprice");	
		  checkstate=rs3.getBoolean("checkstate");	
		  if (checkstate){
		    checkperson=getbyte(rs3.getString("checkperson"));
		    checkDate=getbyte(rs3.getString("checkDate"));
		  }
		  gaizhang_area=Format.getFloat1(rs3.getFloat("gaizhang_area"),2); 
	      gaizhang_unitprice=Format.getFloat1(rs3.getFloat("gaizhang_unitprice"),2);
	      g_sumprice=Format.getFloat1(rs3.getFloat("g_sumprice"),2);
		  checstate=rs3.getInt("state");
		  cq_lingquDate=getbyte(rs3.getString("cq_lingquDate"));
		    if (!cq_lingquDate.equals(""))cq_lingquDate=cq_lingquDate.substring(0,10);
		  song_jian_date=getbyte(rs3.getString("song_jian_date"));
		  if (!song_jian_date.equals(""))song_jian_date=song_jian_date.substring(0,10);
		  cq_date=getbyte(rs3.getString("cq_date"));
		  if (!cq_date.equals(""))cq_date=cq_date.substring(0,10);
		  yhzj_date=getbyte(rs3.getString("yhzj_date"));
		  if (!yhzj_date.equals(""))yhzj_date=yhzj_date.substring(0,10);
		  hs_tnarea=rs3.getFloat("y_area");
		  hs_jzarea=rs3.getFloat("y_jzarea");
      	  }
		  
	  rs3.close(); 

	  %>      
   

<%
 //读取客户交款资料
 String chargesSQL="SELECT sum(factmoney) as factmoney FROM FactGatheringRecord WHERE contractno='"+code+"' group by contractno ";
 ResultSet chargesRS=null;

 String factmoney="0";
 try{
  chargesRS=ViewBean.executeQuery(chargesSQL);
 if (chargesRS.next())factmoney=chargesRS.getString("factmoney");
 
 }catch(Exception s){}
chargesRS.close();
 
 %> 

<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
 
  <script>
  function fullData(){
  document.cus.dicprice.defaultValue="<%=youhuiprice %>";
   setSelectMad(document.cus.counttype,"<%=count_type %>");
   //setSelectMad1(document.cus.pay,"<%=payment %>");
   <%if (payment.indexOf("揭")>=0){ %>
   	 document.cus.fkc.disabled=false;
	 document.cus.ajc.disabled=false;
	 document.cus.ajbk.disabled=false;
   <%}else{ %>
   	 document.cus.fkc.disabled=true;
	 document.cus.ajc.disabled=true;
 	 document.cus.ajbk.disabled=true;
   <%} %> 
   setSelectMad(document.cus.custype,"<%=custype %>");
   setSelectMad(document.cus.httype,"<%=httype %>");
   setSelectMad(document.cus.ajyr,"<%=ajyr %>");
   
   setSelectMad(document.cus.ajbk,"<%=ajbk %>");
   setSelectMad(document.cus.bx,"<%=StrBxState %>");
   setSelectMad(document.cus.gz,"<%=StrGzState %>");
  
} 
 
</SCRIPT>

<%
String SecNo=getbyte2(request.getParameter("secno"));
String Loft=getbyte2(request.getParameter("loft"));
String Build=getbyte2(request.getParameter("build"));
String RoomNo=getbyte2(request.getParameter("roomno"));
String floors=getbyte2(request.getParameter("Floor"));
String UseArea="";
String SaleArea="";
String SaleUnitPrice="";
String UserUnitPrice="";
String SaleSumPrice="";
String Fitment="";
String RoomType="";
String Room_Type="";
String floor="";
String Code="";
String Y_UsedArea="";
String Y_Area="",maap_state="";
String RoomSql="select maap_state,Code,UsedArea,Y_UsedArea,Area,Y_Area,Unitprice,TNunitprice,Sumprice,Fitment,RoomType,Room_Type,floor ";
RoomSql+=",room_price,yang_tai_area,yong_tu,lu_tai_area_price,lu_tai_area,lu_tai_area*lu_tai_area_price lu from room";
RoomSql+=" where seccode='"+SecNo+"' and loft='"+Loft+"' and building='";
RoomSql+=Build+"' and room_code='"+RoomNo+"' and Floor="+Floor;

ResultSet rs=null;
float checksumprice=0;
String room_price1="",yang_tai_area="",yong_tu="",lu_tai_area_price="",lu_tai_area="",lu="";
try{
  rs=ViewBean.executeQuery(RoomSql);
  if (rs.next())  {
    maap_state=getbyte(rs.getString("maap_state"));
    Code=rs.getString("Code");
    UseArea=Format.getFloat1(rs.getFloat("UsedArea"),3);
	Y_UsedArea=Format.getFloat1(rs.getFloat("Y_UsedArea"),3);
    SaleArea=Format.getFloat1(rs.getFloat("Area"),3);
	Y_Area=Format.getFloat1(rs.getFloat("Y_Area"),3);
    SaleUnitPrice=Format.getFloat1(rs.getFloat("Unitprice"),2);
	UserUnitPrice=Format.getFloat1(rs.getFloat("TNunitprice"),2);
	checksumprice=rs.getFloat("Sumprice");
	SaleSumPrice=Format.getFloat1(checksumprice,1);
	Fitment=getbyte(rs.getString("Fitment"));
	RoomType=getbyte(rs.getString("RoomType"));
	Room_Type=getbyte(rs.getString("Room_Type"));
    floor=getbyte(rs.getString("Floor"));
	room_price1=Format.getFloat1(rs.getFloat("room_price"),2);
	yang_tai_area=Format.getFloat1(rs.getFloat("yang_tai_area"),2);
	yong_tu=getbyte(rs.getString("yong_tu"));
	lu_tai_area_price=Format.getFloat1(rs.getFloat("lu_tai_area_price"),2);
	lu_tai_area=Format.getFloat1(rs.getFloat("lu_tai_area"),2);
	lu=Format.getFloat1(rs.getFloat("lu"),2);
	 
  }
  rs.close();
}

catch(Exception s){out.print(s.getMessage());}
String h_UseArea=UseArea;
String h_SaleArea=SaleArea;
//if (checstate==2){UseArea=SaleArea;SaleArea=Y_Area;}

 %>

 <body onload="fullData();">

<form method="POST" name="cus" action="ModiContract.jsp"> 
<input type="hidden" value="<%=code %>" name="code">
<input type=hidden name=change>
<input type=hidden name=context>
<input type=hidden name=checker>
<input type=hidden name="ajc"   size="15"  >
<input type=hidden name="fkc"   size="15"  >
<input type=hidden name=oldajmoney value="<%=ajmoney %>">
<input type=hidden name=oldpay value="<%=payment %>">
<input type=hidden name=oldsalprice value="<%=salprice %>">
<input type=hidden name=url value="ModiContract.jsp">
<input type=hidden name=oldRoom value="<%=request.getParameter("roomno") %>">
 <input type=hidden name="oldFloor" readonly value="<%=request.getParameter("Floor") %>">
<input type=hidden name=hiarea value="<%=SaleArea%>">
<input type=hidden name=olddate value="<%=SaleArea%>">
<input type=hidden name=floor value="<%=floors%>">
<input type=hidden name=hisumprice value="<%=SaleSumPrice%>">
  <p align=center><font size=3><b>销售资料</b></font></p>

     <table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif">　<img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>房间资料</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"><font color="#FF6600">&nbsp;</font></td>
</tr>
</table>	
 <table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#ffffff" class="tablefill">
 
      <td width="15%" align=left class=roomleft>&nbsp;楼盘名称</td>
      <td width="19%" align=left class=roomright>&nbsp;<%=getbyte2(request.getParameter("secname")) %> 
        <input type=hidden name="sectio" readonly value="<%=getbyte2(request.getParameter("secname")) %>" size="10"  >
        <input type=hidden name="section"  value="<%=getbyte2(request.getParameter("secno")) %>" size="10"  >
      </td>
      <td width="15%" align=left class=roomleft>&nbsp;房&nbsp;间&nbsp;号&nbsp;</td>
      <td   align=left class=roomright width="20%"><div id="idroomno">&nbsp;<%=getbyte2(request.getParameter("loft")) %><%=getbyte2(request.getParameter("build")) %><%=getbyte2(request.getParameter("roomno")) %></div></td>
      <td   align=left class=roomleft width="12%">&nbsp;交楼日期</td>
      <td width="19%" class=roomright align=left>&nbsp;<%if (!JLdate.equals("")){out.print(JLdate.substring(0,10));} %> 
        　</td>
    </tr>
	 
	    <input type=hidden name="roomno" readonly value="<%=getbyte2(request.getParameter("roomno")) %>" size="15"   onChange="toUpper(document.cus.roomno)">
        <input type="hidden" name="loft" readonly="readonly" size="15" value="<%=getbyte2(request.getParameter("loft")) %>">
		<input type="hidden" name="oldloft" readonly="readonly" size="15" value="<%=getbyte2(request.getParameter("loft")) %>">
		<input type=hidden name="build" readonly value="<%=getbyte2(request.getParameter("build")) %>"   size="15"   onChange="toUpper(document.cus.build)">
    	<INPUT TYPE=hidden NAME=Date2 value="<%=getbyte2(request.getParameter("jldate")) %>" size=10 readonly title="请选择认购日期" onkeydown="key(document.cus.pay)">
        <input type=hidden name="jzarea" readonly  value="<%=SaleArea %>"  size="15"  >
		<input type=hidden name="area" readonly value="<%=UseArea%>"  size="15"  >
		<input type=hidden name="tnunitprice" readonly  value="<%=UserUnitPrice%>"  size="15"  >
   	    <input type=hidden name="jzunitprice" readonly value="<%=SaleUnitPrice%>"  size="15"  >
        <input type=hidden name="fx" readonly  value="<%=RoomType %>"  size="15"   onChange="toUpper(document.cus.roomno)">
        <input type=hidden name="sumprice" readonly value="<%=SaleSumPrice %>"  size="15"  >
		<input type=hidden name="zx" readonly value="<%=Fitment %>"  size="15"   >
        <input type=hidden name="fl"  readonly value="<%=Room_Type%>" size="15"  >
		<input type=hidden name="yang_tai_area"  readonly value="<%=yang_tai_area%>" size="15"  >
      
    <tr> 
      <td width="15%" align=left class=roomleft>&nbsp;建筑面积</td>
      <td width="19%" align=left class=roomright><div id="idjzarea">&nbsp;<%=area1 %></div></td>
      <td width="15%" align=left class=roomleft>&nbsp;套内建筑面积</td>
      <td   align=left class=roomright width="20%"><div id="idusearea">&nbsp;<%=area%></div></td>
      <td   align=left class=roomleft width="12%">&nbsp;套内建筑<br>&nbsp;面积单价</td>
      <td width="19%" class=roomright align=left><div id="idunitprice">&nbsp;<%=UserUnitPrice%></div></td>
    </tr>
	<%if (hs_tnarea>0){ %>
   <tr> 
      <td width="15%" align=left class=roomleft>&nbsp;核实建筑面积</td>
      <td width="19%" align=left class=roomright>&nbsp;<%=hs_jzarea %></td>
      <td width="15%" align=left class=roomleft>&nbsp;核实套内面积</td>
      <td   align=left class=roomright width="20%">&nbsp;<%=hs_tnarea%></td>
      <td   align=left class=roomleft width="12%"></td>
      <td width="19%" class=roomright align=left></td>
    </tr>
  <%} %>
	 <tr> 
      <td width="15%" align=left class=roomleft>&nbsp;建筑面积单价</td>
      <td width="19%" align=left class=roomright>&nbsp;<%=SaleUnitPrice%></td>
      <td width="15%" align=left class=roomleft>&nbsp;预售总价</td>
      <td   align=left class=roomright width="20%">&nbsp;<%=SaleSumPrice %></td>
      <td   align=left class=roomleft width="12%">&nbsp;房间总价</td>
      <td width="19%" class=roomright align=left>&nbsp;<%=room_price1 %> 　</td>
    </tr>
	<tr> 
      <td width="15%" align=left class=roomleft>&nbsp;花园/露台面积</td>
      <td width="19%" align=left class=roomright>&nbsp;<%=lu_tai_area%></td>
      <td width="15%" align=left class=roomleft>&nbsp;花园/露台单价</td>
      <td   align=left class=roomright width="20%">&nbsp;<%=lu_tai_area_price %></td>
      <td   align=left class=roomleft width="12%">&nbsp;阳台面积</td>
      <td width="19%" class=roomright align=left>&nbsp;<%=yang_tai_area %> 　</td>
    </tr>
	 <tr> 
      <td width="15%" align=left class=roomleft>&nbsp;用途</td>
      <td width="19%" align=left class=roomright>&nbsp;<%=yong_tu%></td>
      <td width="15%" align=left class=roomleft>&nbsp;</td>
      <td   align=left class=roomright width="20%">&nbsp;</td>
      <td   align=left class=roomleft width="12%">&nbsp;</td>
      <td width="19%" class=roomright align=left>&nbsp;</td>
    </tr>
  </table>
    <table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#ffffff" class="tablefill">        
	 <tr> 
      <td colspan="8" align="center"  bgcolor="#CFE6EB"></td> 
    </tr>
  <tr><td colspan="6">
  <table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif"><img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>客户资料</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"></td>
</tr>
</table>	
 
 </td></tr>  <tr> 
      <input type=hidden name="cusname" value="<%=cusno %>">
      <td width="16%" class=roomleft >&nbsp;客户姓名</td>
     <input type=hidden name="cusname2" value="<%=cusname %>">
      <td colspan="5" class=roomright>&nbsp;<input type=text disabled  name="cusname1"  size=40 onchange="aa();" value="<%=cusname %>"  onkeydown="key(document.cus.carid)" title="如果多个姓名，请用'/'分隔">
       <!-- <font color=red>*</font> 
        <input type=button name=FindB  value="查找" onclick="FindOption();">
        -->　 
<script>
  function aa(){
    var aa=document.cus.cusname1.value;
    var aa1=document.cus.cusname2.value;
    if (aa!=aa1){
       if (confirm("你已变更了客户姓名，是否保留原客户姓名？"))
          setSelectMad(document.cus.editnow,"2");
       else
          setSelectMad(document.cus.editnow,"1");        

     }else{
     setSelectMad(document.cus.editnow,"1");
   }
}
</script>
   </tr>
    <tr> 
      <td width="16%" class=roomleft>&nbsp;身份证号</td>
      <td class=roomright colspan="5">&nbsp;<input type=text disabled name="carid"   size=50  value="<%=ID_Card %>"  onkeydown="key(document.cus.tel)">
        　</td>
    </tr>
    <tr> 
      <td width="16%" class=roomleft>&nbsp;联系电话</td>
      <td class=roomright colspan="5">&nbsp;<input type=text disabled name="tel"  size=30   value="<%=Phone %>" onKeyDown="key(document.cus.bbj)">
        手机： 
        <input type=text disabled name="sj"  size=11  value="<%=sj %>" onKeyDown="key(document.cus.addr)">
        　</td>
    </tr>
    <tr> 
      <td width="16%" class=roomleft>&nbsp;联系地址</td>
      <td class=roomright colspan="5">&nbsp;<input type=text disabled  name="Address"  size=50  value="<%=Address %>" onKeyDown="key(document.cus.shouji)"> 
      </td>
    </tr>
    <!--
    <tr> 
      <td width="16%" class=roomleft >&nbsp;联系地址</td>
      <td  class=roomright>&nbsp; 
        <input type=text disabled name="addr"  value="<%=Address %>" size=30  onkeydown="key(document.cus.post)">
        邮编: 
        <input type=text disabledsize=6 value="<%=Zip_Code %>" Onblur="check(document.cus.post);"  maxlength="6" name=post>
        　</td>
    </tr>
    -->
    <tr> 
      <td class=roomleft>&nbsp;优惠赠送 </td>
      <td class=roomright colspan="5">&nbsp;<input type=text disabledname=youhui size=50 value="<%=yh_zs %>"> 
        <select name=largees OnChange="chang();">
          <%
	    String StrSql="select type,codename from CODE where type='S' and child=0 order by type";
     ResultSet codeRS=null;
    
    codeRS=ViewBean.executeQuery(StrSql);
   %>
          <%out.print("<option>请选择赠品</option>");
		   while (codeRS.next()){
			 out.print("<option>"+getbyte(codeRS.getString("codename"))+"</option>");
		   }
		   codeRS.close();
				%>
        </select> </td>
    </tr>
    <tr> 
      <td width="16%" class=roomleft >&nbsp;客户类型</td>
      <td  class=roomright colspan="5">&nbsp;<select name=custype>
          <option value=个人>个人</option>
          <option value=企业>企业</option>
        </select>  &nbsp;<select name=rh><option value=0>不入户</option>
   <option value=1>需要入户</option>
        </select> &nbsp;入户数:<input type=text disabled size=8 name=rhn>&nbsp;销售员:&nbsp; <select name="seller"  multiple size=1.5  onblur="SelectedSeller();">
          <option value="<%=seller %>" selected><%=seller %></option>
          <option ></option>
          <option ></option>
          <option ></option>
        </select> <input type=button name=listlar value="<<" onclick="list1();" title="增加销售员"> 
        <input type=button name=rem value=">>" onclick="remo();"  title="删除销售员"> 
        <!--
        <font color=red>*</font> 滞纳金比: 
        <input type=text disabledsize=4 name=demurrage value=0.01>
        % </td>
        -->
        <input type=hidden name=demurrage value=0> </tr>
    <tr> 
      <td width="16%"    class=roomleft>&nbsp;备&nbsp;注</td>
      <td  class=roomright colspan="5"> &nbsp;<textarea rows="3" name="note" cols="50"  ><%=note %></textarea> 
      </td>
    </tr>
   <tr><td colspan="6">
  <table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif"><img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>认购资料</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"></td>
</tr>
</table>	
 
 </td></tr>
    <tr> 
      <td width="12%" class=roomleft>&nbsp;认购编号</td>
      <td width="12%" class=roomright>&nbsp;<input type=text disabledname="rgsno" value="<%=rgno %>"   size="10"   onChange="toUpper(document.cus.rgsno)" onKeyDown="key(document.cus.cale1)" onBlur="checkedOrderNoExist();"  title="只能是英文字母、数字及"-"组成">
       　</td>
      <td width="19%" class=roomleft>&nbsp;认购日期</td>
      <td width="19%" class=roomright>&nbsp;<input type=text disabledname=Date1 size=10 title="请选择认购日期"  value="<%=date.substring(0,10) %>" readonly onchange="key(document.cus.pay);" onKeyDown="key(document.cus.VisaDate)">
        <input type=button name=cale1 value=".." onClick="fPopUpCalendarDlg(Date1);return false;" title="请选择认购日期">
       </td>
	  
      <td width="15%" class=roomleft>&nbsp;付款方式</td>
      <td width="23%" class=roomright>&nbsp;<select name="pay"      style="width : 100" onKeyDown="key(document.cus.VisaDate)" onChange="charges();"><!--onChange="charges();"-->
    <%if (payment.indexOf(".")<0)payment=payment+".";%>     
     <option value="<%=payment.substring(0,payment.indexOf("."))+"-"+disc1+"-"+dj+"*"+payment.substring(payment.lastIndexOf(".")+1)+"#g" %>"><%=payment %></option>
                 <%
     String sql="select * from PayMent where seccoe='"+SecNo+"'";
       rs3=ViewBean.executeQuery(sql);
	  String pay="";
	  String dic="";
	  String dj1="";
	  String qdate="";
	  String ajdate="";	  
	  String num="";
	   String gddate="";	
     while (rs3.next()){
	    pay=getbyte(rs3.getString("PayName"));
		num=rs3.getString("num");
	    dic=rs3.getString("Discont");
		dj1=rs3.getString("prepay");
		qdate=rs3.getString("qdate");
		ajdate=rs3.getString("ajdate");
		gddate=getbyte(rs3.getString("gddate"));
		String dic1=String.valueOf(dic);
	    out.print("<option value='"+pay+"-"+dic1+"-"+dj1+"*"+num+"#"+qdate+"."+ajdate+"g"+gddate+"'>"+pay+"*"+num+"*期</option>");
	  }
	  
	    rs3.close();
     %>
        </select> 
        <input type=hidden name=dis size=6 readonly>
        </td>
		
    <tr> 
	    <td width="19%"  colspan="5"> 
	  <%String discSQL="SELECT * FROM  contract_disc  WHERE bt=0 and  disc_type<>'正常折扣'  and   order_no='"+SecNo+Loft+RoomNo+"' order by state desc";
	             rs=ViewBean.executeQuery(discSQL);
			 String yy="";	 
			  while (rs.next()){
			    String dis=rs.getString("disc");
				float yh=rs.getFloat("youhui");
			    String obj=rs.getString("discObj");
				if (yh==0)yy+=" 按"+obj+rs.getString("disc")+"折";
				else yy+=" 按"+obj+"优惠"+rs.getString("youhui")+"元";
				}rs.close();
			  
			   %>
	  <a href="#12" onclick="document.all.discreco.style.display=(document.all.discreco.style.display=='none')?'block':'none';" title="点击显示详细的优惠记录"><font color=red><div id=yhview>优 惠:<%=yy %></div></font></a>
	</td> <td width="19%">  </td></tr>
    </tr> <tr><td colspan="6"> 
	  <div id="discreco" style="display:none">
	   <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
	  <tr bgcolor="#c0c0c0" align="center"><td>折扣类型</td><td>日期</td><td>优惠</td><td>折扣</td><td>计算对象</td><td>折前总价</td><td>折前单价</td><td>关系人</td><td>审核人</td></tr>
	 <%
	      discSQL="SELECT * FROM  contract_disc  WHERE  disc_type<>'正常折扣'  and  order_no='"+SecNo+Loft+RoomNo+"' order by state desc";
	             rs=ViewBean.executeQuery(discSQL);
				 
				 int aaa12=0;
			  while (rs.next()){ 		aaa12++;	   
	  %>
	   <tr id=A<%=aaa12 %> align="center"  onmouseover="mout(this) ;changeclass1(this,'clickbg','#ffffff');" title="折扣备注:<%=rs.getString("disc_bak") %>"><td><%=rs.getString("disc_type")  %></td><td><%=rs.getDate("disc_date").toString() %></td>
	   
	   <td><%=rs.getString("youhui") %></td><td><%=rs.getString("disc") %></td><td><%=rs.getString("discObj") %></td>
	   <td><%=rs.getString("discPrice") %></td><td><%=rs.getString("discUnit") %></td><td><%=rs.getString("gxr") %></td><td><%=rs.getString("checker") %></td>
	     </tr>
	   <%}rs.close(); %>
	  </table>
	  </div>
	  </td>
    
 </tr>
<%String oldajcs="";
       try{  if (payment.indexOf("(")>0)oldajcs=payment.substring(payment.indexOf("(")+1,payment.indexOf("%"));
	   }catch(Exception s){}
      %>
<input type="hidden" name=oldajcs size=3 value=<%=oldajcs %>>
    <tr> 
      <td width="12%" class=roomleft >&nbsp;成数年限</td>
      <td width="12%"    class=roomright>&nbsp;<input type=text disabled name=ajcs size=3 value=<%=ajcs %>>
<select name=ajyr    style="width : 40" onclick="count();"  onblur="bxRate();" onchange="document.cus.ewyh.focus();">
  <option></option>
  <%for (int i=1;i<=30;i++){
out.print("<option value="+String.valueOf(i)+">"+String.valueOf(i)+"年</option>");
} %>
</select>
       </td>
	<input type=hidden name=yukuan value=0>
      <td width="19%" class=roomleft>&nbsp;首&nbsp;期&nbsp;款</td>
      <td width="19%" class=roomright  >&nbsp;<input  type=text disabled size=9  value="<%=firstmoney%>" name=firstMoney   onblur="check(this);countsq();">
        (元)　</td>
      <td width="15%" class=roomleft>&nbsp;按揭款</td>
      <td width="23%" class=roomright  >&nbsp;<input  type=text disabled size=10 value="<%=ajmoney %>"  name=ajmoney onblur="check(this);countAj();">(元)　</td>
      
     
    </tr>
    <tr>
<td width="19%" class=roomleft >&nbsp;成交房款</td>
      <td width="19%"    class=roomright>&nbsp;<input type=text disabled name="dicprice" value="<%=room_price %>"  defaultValue="<%=youhuiprice %>" size="10" onchange="check(this);charges();" onkeydown="key(document.cus.cjjzprice);">元
   <input type=hidden name="countdiscprice" value="<%=room_price %>">
        <input type=hidden value=0 readonly name="MonthMoney"     size="10"  >
      </td>
      <td width="15%" class=roomleft>&nbsp;定 金</td>
      <td width="23%" class=roomright  >&nbsp;<input type=text disabled value="<%=dj %>" name="earnest"  readonly   size="10"  >
    </td>     
      <td width="19%" class=roomleft >&nbsp;成交总价</td>
      <td width="19%"    class=roomright>&nbsp;<input type=text disabled name="Adicprice"     size="10" value="<%=salprice %>" onkeydown="key(document.cus.cjjzprice);">元
      
      </td>
    </tr>
    <tr>
      <td width="12%" class=roomleft >&nbsp;成交建筑<br>&nbsp;面积单价</td>
      <td width="12%" class=roomright >&nbsp;<input type=text disabled name="cjjzprice" value="<%=saleJzPrice %>" size=10 ></td>
      <td width="19%" class=roomleft >&nbsp;成交套内<br>&nbsp;建筑面积单价</td>
      <td width="19%"    class=roomright>&nbsp;<input type=text disable dname="cjtnprice"  value="<%=saleUsePrice %>" size=10> 元　</td>
       <td width="19%" class=roomleft >&nbsp;合同类别</td>
      <td width="19%" class=roomright >&nbsp;<select name="httype"><option value=0>内销</option><option value=1>外销</option></select></td>  
   
    </tr>
	<!--
	<tr>
	<td width="19%" class=roomleft>&nbsp;送首期款
     </td>
	 <td width="19%" class=roomright>&nbsp;<input type=text disabled size=10 value=<%=zs_first_money %>  name="firstmoney"  onchange="sendfirst(this);">
     </td>
	 <td width="19%" class=roomleft>&nbsp;实际成交总价
     </td>
	 <td width="19%" class=roomright>&nbsp;<input type=text disabled size=10 value=<%=factprice %> name="factprice" readonly>元
     </td>
	  <td width="15%" class=roomleft>&nbsp;币&nbsp;&nbsp;&nbsp;&nbsp;种</td>
      <td width="23%" class=roomright  >&nbsp;<select name="curry" style="width : 40" OnChange="CurrRa();">
         <option value="￥">人民币</option>
          <option value="HKD">港元</option>
          <option value="USD">美元</option>
        </select><input type=text disabledname="rate"  value=1.0  size="4" title="汇率" >
        　　</td>
	 </tr>
	
      <tr>
      <td width="12%" class=roomleft >&nbsp;实际成交建筑<br>&nbsp;面积单价</td>
      <td width="12%" class=roomright >&nbsp;<input type=text disabledname="sjcjjzprice" size=10 value="<%=sjsaleJzPrice %>" readonly></td>
      <td width="19%" class=roomleft >&nbsp;实际成交套内<br>&nbsp;建筑面积单价</td>
      <td width="19%" class=roomright >&nbsp;<input type=text disabledname="sjcjtnprice" size=8 value="<%=sjsaleUsePrice %>" readonly> 元/M<sup>2</sup>　</td>
	-->
	 <tr>
	  <td width="19%" class=roomleft >&nbsp;合同计价方式</td>
      <td width="19%" class=roomright >&nbsp;<select name="counttype" style="width : 90">
          <option value="0">套内面积</option>
          <option value="1">建筑面积</option>
        </select></td> 
	    </tr>
	 
	  <tr>
      <td width="12%" class=roomleft >&nbsp;花园/露台面积</td>
      <td width="12%" class=roomright >&nbsp;<input type=text disabledonblur="countlutai();" name="lutai_area" size=10 value="<%=lu_tai_area %>"  ></td>
      <td width="19%" class=roomleft >&nbsp;花园/露台单价</td>
      <td width="19%" class=roomright >&nbsp;<input type=text disabledonblur="countlutai();" name="lutai_area_price" size=8  value="<%=lu_tai_area_price %>"  > 元/M<sup>2</sup>　</td> 
	   <td width="19%" class=roomleft >&nbsp;花园/露台总价</td>
      <td width="19%" class=roomright >&nbsp;<input type=text disabledname="tai_area_sumprice" size=8 readonly  value="<%=lu %>" > 元</td>  </tr>
  
	   </tr>
 
  <script>
	   function countlutai(){
	      if (document.cus.lutai_area.value!=""&&document.cus.lutai_area_price.value!=""){
		    document.cus.Adicprice.value=parseFloat(document.cus.dicprice.value)+parseFloat(document.cus.lutai_area.value)*parseFloat(document.cus.lutai_area_price.value)
		  }
	   }
	   function gzcount(){
	         if (document.cus.G_jzarea.value!=""&&document.cus.G_unitprice.value!=""){
		         document.cus.cjjzprice.value=parseFloat(document.cus.cjjzprice.value)-parseFloat(document.cus.G_unitprice.value);
	             document.cus.dicprice.value=parseFloat(document.cus.G_jzarea.value)*parseFloat(document.cus.cjjzprice.value);
				 document.cus.G_sumprice.value=parseFloat(document.cus.G_jzarea.value)*parseFloat(document.cus.G_unitprice.value);
			     document.cus.cjtnprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.area.value),2);
                 document.cus.cjtnprice.value=subs1(document.cus.cjtnprice.value,2);
	             document.cus.cjjzprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.jzarea.value),2);
                 document.cus.cjjzprice.value=subs1(document.cus.cjjzprice.value,2); 
			
			 }
	   
	   
	   }
	   </script>
	       <tr><td colspan="6">
  <table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif"><img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>合同资料</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"></td>
</tr>
</table>	
 
 </td></tr> <tr > 
      <td width="16%"  class=roomleft>已交首期款</td>
      <td width="18%"  class=roomright>&nbsp;<input type=text disabledsize=12 value="<%=factmoney %>"><input type=hidden name="firstFT" value="1" style="width : 105"></td>
      <td width="16%"  class=roomleft>合同编号</td>
      <td width="18%"  class=roomright>&nbsp;<input type=text disabled readonly name="constractno" value="<%=ContractNo %>"    size="10"    onBlur="checkedOrderNoExist1();"   OnChange="toUpper(document.cus.constractno)" onkeydown="key(document.cus.QYDate)" ><input type=button name=adc value=".." title="选择合同号" onclick="openwin('ContractNoList.jsp?SecNo=<%=secno %>',200,350,100,100);"></td>
      <td width="14%"  class=roomleft>签约日期
      </td> 
      <td width="18%"  class=roomright>&nbsp;<INPUT type=text disabled  NAME=QYDate value="<%if (state.equals("2"))out.println(VisaDate.substring(0,10)); %>" size=10 readonly title="请选择签约日期"   onkeydown="key(document.cus.kkrate)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(QYDate);" title="请选择认购日期"></td>
    </tr>
	  <tr > 
      <td width="16%"  class=roomleft>改装建筑面积</td>
      <td width="18%"  class=roomright>&nbsp;<INPUT type=text disabled name="G_jzarea" value="<%=gaizhang_area %>" size="12"  ></td>
      <td width="16%"  class=roomleft>改装建筑单价</td>
      <td width="18%"  class=roomright>&nbsp;<input type=text disabled name="G_unitprice" onblur="gzcount();" size="12" value="<%=gaizhang_unitprice %>"   onblur="checkedOrderNoExist(this.value);" OnChange="if (document.cus.rgsno.value=='')document.cus.rgsno.value=document.cus.constractno.value;toUpper(document.cus.constractno)" onkeydown="key(document.cus.QYDate)" title="只能是英文字母、数字及"-"组成"></td>
      <td width="14%"  class=roomleft>改装总款
      </td>
      <td width="18%"  class=roomright>&nbsp;<INPUT type=text disabled  NAME=G_sumprice size=10  value="<%=g_sumprice %>"  readonly  > </td>
    </tr>
 <input type="hidden" name="qydate" value="<%=qytxdate %>">
    <tr bordercolor="#FFFFFF"> 
      <td width="16%" class=roomleft>按揭银行</td>
      <td width="18%" class=roomright>&nbsp;<select name=ajbk disabled style="width : 105">
         <option></option>
		      <%
	     StrSql="select type,codename from CODE where type='T' order by type";
        codeRS=null;
    
    codeRS=ViewBean.executeQuery(StrSql);
   %>
				  <%
		   while (codeRS.next()){
			 out.print("<option value='"+getbyte(codeRS.getString("codename"))+"'>"+getbyte(codeRS.getString("codename"))+"</option>");
		   }
		   codeRS.close();
				%> 
		</td>
      <td width="14%" class=roomleft>按揭日期</td>
      <td width="18%" class=roomright>&nbsp;<INPUT type=text disabled value="<%if (!StrAjDate.equals("")&&Integer.parseInt(StrAjDate.substring(0,4))>=2000)out.println(StrAjDate.substring(0,10)); %>"  NAME=ajDate size=10  onkeydown="key(document.cus.ajDate)"></td>
      <td width="16%" class=roomleft>银行放款日期</td>
      <td width="18%" class=roomright>&nbsp;<INPUT type=text disabled value="<%if (!StrFkDate.equals("")&&Integer.parseInt(StrFkDate.substring(0,4))>=2000)out.println(StrFkDate.substring(0,10)); %>"  NAME=fkDate size=10  onkeydown="key(document.cus.ajDate)"></td>
    </tr>
    <tr bordercolor="#FFFFFF"> 
      <td width="16%" class=roomleft>公证状态</td>
      <td width="18%" class=roomright>&nbsp;<select name="gz" style="width : 105"><option value="0">未办</option><option value="1">已办</option></select></td>
      <td width="14%" class=roomleft>保险状态</td>
      <td width="18%" class=roomright>&nbsp;<select name="bx" style="width : 105"><option value="0">未办</option><option value="1">已办</option></select></td>
      <td width="16%" class=roomleft>保险金额</td>
      <td width="18%" class=roomright>&nbsp;<input type=text disabled size=13 value="<%=StrBxMoney %>" name=bxmoney></td>
    </tr>
      <tr bordercolor="#FFFFFF"> 
      <td width="16%" class=roomleft>送件日期</td>
      <td width="18%" class=roomright>&nbsp;<%=song_jian_date %></td>
      <td width="14%" class=roomleft>出证日期</td>
      <td width="18%" class=roomright>&nbsp;<%=cq_date %></td>
	   <td width="14%" class=roomleft>注记日期</td>
      <td width="18%" class=roomright>&nbsp;<%=yhzj_date %></td>
          </tr>
  <tr bordercolor="#FFFFFF"> 
      <td width="16%" class=roomleft>领证日期</td>
      <td width="18%" class=roomright>&nbsp;<%=cq_lingquDate %></td>
      
          </tr>
    <input type=hidden name=caDate value="1800-01-01">
    <input type=hidden name=ajtxdate value="0">
	 <input type=hidden name=orderstate value="1">
  </table>
  </table>
    <p align="center"> 
       <jsp:include page="../finance/showGatheringProcess.jsp" flush="true">
     <jsp:param name="contractno" value="<%=code%>"/>
	  <jsp:param name="cusno" value="<%=cusno%>"/>
	  <jsp:param name="SalePrice" value="<%=salprice%>"/>
   
  </jsp:include>
  <p align="center"> 
    <input type=hidden name=saveorder value="modi">
	<%
	//String check=request.getParameter("check");
	//if (check!=null)
	 %>
  </P>
　
</center>
</form>
</body>

</html>
