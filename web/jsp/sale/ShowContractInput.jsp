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
<title>查阅销售资料</title>
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
try{
String userstate=(String) session.getAttribute("userstate");
  //按揭保险费
    String bxcharges="0";
	 int loke_time=0;
  String bxrate="select insurance_rate, insurance_year from insurance_rate ";
   ResultSet bxRs=ViewBean.executeQuery(bxrate);
	try{
  out.print("<script>");
  out.print("var Ratebx=new Array();");
  out.print("var Yearbx=new Array();");
  int iii=0;

   while (bxRs.next()){
     out.print("Ratebx["+String.valueOf(iii)+"]="+"\""+getbyte(bxRs.getString("insurance_rate"))+"\""+";");
     out.print("Yearbx["+String.valueOf(iii)+"]="+"\""+bxRs.getString("insurance_year")+"\""+";");
	 iii++;
      }	 
}catch(Exception s){  out.print(s.getMessage());out.close();}
bxRs.close();
out.print("</script>");
	
  %>

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


  String secno=getbyte2(request.getParameter("secno"));
  String loft=getbyte2(request.getParameter("loft"));
  String build=getbyte2(request.getParameter("build"));
  String room=getbyte2(request.getParameter("roomno"));
  String Floor=getbyte2(request.getParameter("Floor"));
  String see=request.getParameter("see");
  if(see==null)see="";
   
  //读取合同资料
      sqlrg="select   o.gjj,o.gjjy,o.sydk,o.jl_bak,o.jldate, o.countType,o.gxr,o.code,o.serialno,o.ContractNo,o.Customer,o.sectionname as secname,o.building,";
	  sqlrg+="o.Room_no,o.buildtype,o.roomtype,o.payment,o.payment1,(salerprice-zs_first_money)/o.jzarea as sjsalejzPrice,(salerprice-zs_first_money)/o.area as sjsaleUsePrice,";
	  sqlrg+="o.area,o.zx,o.unitprice,o.tnunitprice,o.salerprice,o.unitprice as salejzPrice,o.tnunitprice saleUsePrice,o.AjMoney,o.MonthPayMoney,";
	  sqlrg+="o.subscription,o.jldate,o.currency,o.state,o.room_sumprice,o.room_sumprice-o.ajmoney firstmoney,";
	  sqlrg+="convert(char(24),o.date,120) date,o.note,o.AjBk,o.AjYear,o.AJcs,o.Ajtype,o.jzarea";
	  sqlrg+=",c.signatory,o.JLdate,o.VisaDate,o.jzdate,o.ajdate,o.httype,o.yh_zs,o.count_type";
	  sqlrg+=",o.disc,c.ID_Card,c.Phone,c.sj,c.Address,c.Zip_Code,DATEDIFF(dd,date,qytxdate) qytxdate ,";
	 sqlrg+="o.CusType,o.currency,o.rate,o.seller,o.OutDate,o.FkDate,o.bxState,o.room_sumprice+o.youhui youhuiprice,";
	 sqlrg+="o.bxMoney,o.firstState,o.yhMoney,o.GzState,o.ewdisc,c.bbj,c.sj,o.youhui,o.youhui_date,o.youhuibeizhu,";
	 sqlrg+=" o.state,o.loke,datediff(mi,o.lokedate,getdate()) as nn,o.zs_first_money,";
	 sqlrg+=" o.rmbprice-o.zs_first_money as factprice ,(o.rmbprice-o.zs_first_money)/o.jzarea as fsalejzPrice,";
	  sqlrg+=" (o.rmbprice-o.zs_first_money)/o.area as fsaleUsePrice,checkstate,checkperson,checkdate ";
	  sqlrg+=",o.gaizhang_area,o.gaizhang_unitprice, o.gaizhang_area*o.gaizhang_unitprice as g_sumprice ";
	   sqlrg+=",o.rh,o.rhn,o.lu_tai_area,o.lu_tai_area_price,o.lu_tai_area*o.lu_tai_area_price lzp ";
	  sqlrg+=",ty_area,ty_area_price,ty_area_price*ty_area typrice,y_area,y_jzarea,o.wd_area,o.wd_area_price,o.wd_area_price*o.wd_area wdprice,memberno,membert from  Order_Contract o,customer c   ";
	  sqlrg+=" where o.state<>3 and   o.Customer=c.serialNo and ";
	  sqlrg+="o.section='"+secno+"' and loft='"+loft+"' and building='"+build+"'";
	  sqlrg+=" and Room_no='"+room+"' and Floors="+Floor;
  
	  ResultSet rs3=ViewBean.executeQuery(sqlrg);
	 
	   String gzstate="",bxstate="",jldate="";
	   String code="",gxr="",jlbak="";
    
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
	   float y_tnarea=0;
	   float y_jzarea=0;
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
	   boolean checkstate=false,countType=false;
	   String memberno="";
	   boolean membert=false;
	   String tnunitprice="";
	   String rh="",rhn="";
	     String gjj="0",sydk="0",gjjy="0";
	   String room_price="",youhuiprice="",payment1="",lzp="";
     String room_price1="",yang_tai_area="",yong_tu="",lu_tai_area_price="",lu_tai_area="",lu="";
	 String ty_area="0",ty_area_price="0",typrice="0";
	 String wd_area="0",wd_area_price="0",wdprice="0";
	  while(rs3.next()){  
	    gjj=getbyte(rs3.getString("gjj"));  
	     gjjy=rs3.getString("gjjy");
         sydk=getbyte(rs3.getString("sydk"));  
	    jlbak=getbyte(rs3.getString("jl_bak"));  
	     jldate=getbyte(rs3.getString("jldate"));  
		 if (!jldate.equals(""))jldate=jldate.substring(0,10);
	     countType=rs3.getBoolean("countType");
	 
	     gxr=getbyte(rs3.getString("gxr"));  
	     code=rs3.getString("code");  
	     rgno=getbyte(rs3.getString("serialno"));  
		 ContractNo=getbyte(rs3.getString("ContractNo"));  
		 cusno=getbyte(rs3.getString("Customer"));  
	     secname=getbyte(rs3.getString("secname")).trim();           
	     build=getbyte(rs3.getString("building"));           
		 room=rs3.getString("Room_no");  
		 buildtype=getbyte(rs3.getString("buildtype")); 
		 roomtype=getbyte(rs3.getString("roomtype"));
		 payment=getbyte(rs3.getString("payment"));
		 payment1=getbyte(rs3.getString("payment1"));
		 sjsaleJzPrice=Format.getFloat1(rs3.getFloat("sjsaleJzPrice"),2); 
		 sjsaleUsePrice=Format.getFloat1(rs3.getFloat("sjsaleusePrice"),2); 
		//payment=payment.substring(0,payment.lastIndexOf("."))+"*"+payment.substring(payment.lastIndexOf(".")+1)+"*期";
		 area=rs3.getString("area"); 
		 zx=getbyte(rs3.getString("zx"));
		 //unitprice=rs3.getFloat("unitprice"); 
		 //tnunitprice=rs3.getString("tnunitprice"); 
		// price=String.valueOf(unitprice);
		 salprice=rs3.getString("salerprice"); 
		 saleJzPrice=Format.getFloat1(rs3.getFloat("unitprice"),2); 
		 saleUsePrice=Format.getFloat1(rs3.getFloat("tnunitprice"),2); 
		 ajmoney =rs3.getString("AjMoney"); 
		 monthpay =rs3.getString("MonthPayMoney"); 
		 //if (payment.indexOf("揭")>=0)
	  
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
		 disc1=String.valueOf(rs3.getFloat("disc")); 
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
		  if (StrEwDisc.equals("0"))StrEwDisc="";
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
		   //if (payment.indexOf("揭")>=0)
		 //firstmoney=String.valueOf(Float.parseFloat(firstmoney)-Float.parseFloat(zs_first_money));
		  factprice=rs3.getString("factprice");	
		  checkstate=rs3.getBoolean("checkstate");	
		  if (checkstate){
		    checkperson=getbyte(rs3.getString("checkperson"));
		    checkDate=getbyte(rs3.getString("checkDate"));
		  }
		  gaizhang_area=Format.getFloat1(rs3.getFloat("gaizhang_area"),2); 
	      gaizhang_unitprice=Format.getFloat1(rs3.getFloat("gaizhang_unitprice"),2);
	      g_sumprice=Format.getFloat1(rs3.getFloat("g_sumprice"),2);
		  rh=rs3.getString("rh");
		  rhn=getbyte(rs3.getString("rhn"));
		  if (rhn.equals(""))rhn="0";
		  lu_tai_area=Format.getFloat1(rs3.getFloat("lu_tai_area"),2);
		  lu_tai_area_price=Format.getFloat1(rs3.getFloat("lu_tai_area_price"),2);
		  lzp=Format.getFloat1(rs3.getFloat("lzp"),2);
		  ty_area=rs3.getString("ty_area");
	      ty_area_price=rs3.getString("ty_area_price");
	      typrice=Format.getFloat3(rs3.getDouble("typrice"),2);
		  wd_area=rs3.getString("wd_area");
	      wd_area_price=rs3.getString("wd_area_price");
	      wdprice=Format.getFloat3(rs3.getDouble("wdprice"),2);
		  y_tnarea=rs3.getFloat("y_area");
		  y_jzarea=rs3.getFloat("y_jzarea");
		  memberno=getbyte(rs3.getString("memberno"));
		  membert=rs3.getBoolean("membert");
		 
      	  }
		   
	  rs3.close(); 
	  ViewBean.executeUpdate("UPDATE Order_Contract SET out=1 where state<>3 and code="+code);
	//判断是否有事务设置
 String SQL="select  loke_time from DataTransSet WHERE section_no='"+secno+"'";

ResultSet LRs=ViewBean.executeQuery(SQL);	
if (!LRs.next()){
  loke="0";
}else{
  loke_time=LRs.getInt("loke_time");
}
	String   LokeSQL="UPDATE Order_Contract SET  LOKE=1,LOKEDATE=getdate() where state<>3 and code="+code;
    if (loke.equals("0")||nn>loke_time)
      ViewBean.executeUpdate(LokeSQL);
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

//生成币另汇率数组

String RateSql="select * from currrate";
ResultSet RateRs=null;

try{
  RateRs=ViewBean.executeQuery(RateSql);

  out.print("<script>");
  out.print("var RateName=new Array();");
  out.print("var RateValue=new Array();");
  int iii=0;

   while (RateRs.next()){
     out.print("RateName["+String.valueOf(iii)+"]="+"\""+getbyte(RateRs.getString("CurrName"))+"\""+";");
     out.print("RateValue["+String.valueOf(iii)+"]="+"\""+RateRs.getString("CurrRate")+"\""+";");
	 iii++;
      }	 
}catch(Exception s){  out.print(s.getMessage());out.close();}
RateRs.close();
out.print("</script>");


 RateSql="select SerialNo,ContractNo from order_contract where section='"+request.getParameter("secno")+"'";
 RateSql="select SerialNo,contractno from order_contract where  state<>3 and  loft+room_no <>'"+loft+room+"' and section='"+request.getParameter("secno")+"'";
try{
  RateRs=ViewBean.executeQuery(RateSql);

  out.print("<script>");
  out.print("var OrderNo=new Array();");
  out.print("var OrderNo1=new Array();");
  int iii=0;
   while (RateRs.next()){
     out.print("OrderNo["+String.valueOf(iii)+"]="+"\""+getbyte(RateRs.getString("SerialNo"))+"\""+";");
     out.print("OrderNo1["+String.valueOf(iii)+"]="+"\""+getbyte(RateRs.getString("ContractNo"))+"\""+";");
	 iii++;
      }	 
}catch(Exception s){  out.print(s.getMessage());out.close();}
RateRs.close();
out.print("</script>");
 %>
<script>
 function checkedOrderNoExist(){
 
    if (document.cus.rgsno.value=="")return false;
   var ii=0;
   var exist=0;
    for (var i=0;i<OrderNo.length;i++){
	    if (document.cus.rgsno.value==OrderNo[i]&&OrderNo[i]!=""){
		 alert("此认购编号已经使用");
		 
		 document.cus.rgsno.focus();
		 return false;
             
		}
	  
	}
   
 
 }
 function checkcount(){
 
    if(!document.cus.bz.checked){
    document.cus.dicprice.readOnly=document.cus.bz.checked;
    document.cus.dicprice.focus();
	document.cus.dicprice.select();
	}else{ document.cus.dicprice.value= document.cus.dicprice.defaultValue;}
	
    }
 function checkedOrderNoExist1(){
    if (document.cus.constractno.value=="")return false;
	var exist=0;
    for (var i=0;i<OrderNo1.length;i++){
	    if (document.cus.constractno.value==OrderNo1[i]&&OrderNo1[i]!=""){
	alert("此合同编号已经使用");
		 document.cus.constractno.focus();
		 return false;
		 
		}
	
	}
  
 }

 </script>

<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<% 
ResultSet rs=null;
String SecNo=getbyte2(request.getParameter("secno"));
String Loft=getbyte2(request.getParameter("loft"));
String Build=getbyte2(request.getParameter("build"));
String RoomNo=getbyte2(request.getParameter("roomno"));
String floors=request.getParameter("Floor");
String datalen="select PRICE_TYPE,unitlen,sumlen,disc ,salepricecounttype  from SALE_PRICE_TYPE WHERE secno='"+SecNo+"'";
String price_type="1";
String unitlen="0";
String unitlen1="1";
String sumlen="0";
String discType="1";
String salepricecounttype="0";
  rs=ViewBean.executeQuery(datalen);	
if (rs.next()){
  price_type=rs.getString("PRICE_TYPE");
  unitlen=rs.getString("unitlen");
  if (unitlen.equals("2"))unitlen1="100";
  sumlen=rs.getString("sumlen");
  discType=rs.getString("disc");
  salepricecounttype=rs.getString("salepricecounttype");
}
rs.close();
  %>
<%@ include file="contract_pub.jsp"%>
<%
int floorA=0;
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
String fsfc="",fsfcmoney="0",br="0",fsfcroom="";
String RoomSql="select floor,Code,UsedArea,Y_UsedArea,Area,Y_Area,Unitprice,TNunitprice,Sumprice,Fitment,RoomType,Room_Type,floor ";
RoomSql+=",room_price,yang_tai_area,yong_tu,lu_tai_area_price,lu_tai_area,lu_tai_area*lu_tai_area_price lu from room";
RoomSql+=" where seccode='"+SecNo+"' and loft='"+Loft+"' and building='";
RoomSql+=Build+"' and room_code='"+RoomNo+"' and Floor="+Floor;

double checksumprice=0;
try{
  rs=ViewBean.executeQuery(RoomSql);
  if (rs.next())  {
    floorA =rs.getInt("floor");
    Code=rs.getString("Code");
	if (y_tnarea>0){
    UseArea=Format.getFloat1(rs.getFloat("Y_UsedArea"),3);
    SaleArea=Format.getFloat1(rs.getFloat("Y_Area"),3);
	}else{
    UseArea=Format.getFloat1(rs.getFloat("UsedArea"),3);
    SaleArea=Format.getFloat1(rs.getFloat("Area"),3);
	
	}
    SaleUnitPrice=Format.getFloat1(rs.getFloat("Unitprice"),2);
	UserUnitPrice=Format.getFloat1(rs.getFloat("TNunitprice"),2);
	checksumprice=rs.getDouble("Sumprice");
	SaleSumPrice=Format.getFloat3(checksumprice,2);
	Fitment=getbyte(rs.getString("Fitment"));
	RoomType=getbyte(rs.getString("RoomType"));
	Room_Type=getbyte(rs.getString("Room_Type"));
    floor=getbyte(rs.getString("Floor"));
	room_price1=Format.getFloat3(rs.getDouble("room_price"),2);
	yang_tai_area=Format.getFloat1(rs.getFloat("yang_tai_area"),2);
	yong_tu=getbyte(rs.getString("yong_tu"));
	//lu_tai_area_price=Format.getFloat1(rs.getFloat("lu_tai_area_price"),2);
	//lu_tai_area=Format.getFloat1(rs.getFloat("lu_tai_area"),2);
	lu=Format.getFloat1(rs.getFloat("lu"),2);
  }
  rs.close();
  double fsfcm=0;
   rs=ViewBean.executeQuery("select b.yong_tu,b.unitprice,b.area,a.roomcode,a.br,b.sumprice,b.room_code from fsfc a,room b where a.roomcode=b.code and a.order_contract="+code);
   while (rs.next())  {
      String fsyong_tu=getbyte(rs.getString("yong_tu"));
	  String fsunitprice=getbyte(rs.getString("unitprice"));
	  String fsarea=getbyte(rs.getString("area"));
     if (fsfc.equals(""))
       fsfc=fsyong_tu+getbyte(rs.getString("roomcode"));
	 else
	    fsfc+=","+getbyte(rs.getString("roomcode"));  
     if (fsfcroom.equals(""))		
	    fsfcroom=fsyong_tu+getbyte(rs.getString("room_code"))+"("+fsarea+"M<sup>2</sup>,"+fsunitprice+"元/M<sup>2</sup>,";
	 else
	     fsfcroom+="<br>"+fsyong_tu+getbyte(rs.getString("room_code"))+"("+fsarea+"M<sup>2</sup>,"+fsunitprice+"元/M<sup>2</sup>,";
	
	fsfcm+= rs.getDouble("sumprice");
	fsfcroom+=rs.getString("sumprice")+"元)";
     br=getbyte(rs.getString("br"));
   }
    fsfcmoney=Format.getFloat3(fsfcm,2);
 
    rs.close();
}
catch(Exception s){out.print(s.getMessage());}
 rs=ViewBean.executeQuery("select * from zm_bak where htno="+code);
 
 String zmbak="";
 if (rs.next())zmbak="a";
 rs.close();
 %>

 <body onload="document.cus.rgsno.focus();fullData();">

<form method="POST" name="cus" action="ModiContract.jsp"> 
<input type="hidden" value="<%=code %>" name="code">
<input type=hidden name=change>
<input type=hidden name=context>
<input type=hidden name=checker>
<input type=hidden name=oldajmoney value="<%=ajmoney %>">
<input type=hidden name=oldpay value="<%=payment %>">
<input type=hidden name=oldsalprice value="<%=salprice %>">
<input type=hidden name=url value="ModiContract.jsp">
<input type=hidden name=oldRoom value="<%=getbyte2(request.getParameter("roomno")) %>">
 <input type=hidden name="oldFloor" readonly value="<%=request.getParameter("Floor") %>">
<input type=hidden name=hiarea value="<%=SaleArea%>">
<input type=hidden name=olddate value="<%=SaleArea%>">
  <input type=hidden name=floor value="<%=floors%>">
<input type=hidden name=hisumprice value="<%=salprice%>">
  <p align=center><font size=3><b>查阅销售资料</b></font></p>

    <table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#ffffff" class="tablefill">
   <tr> 
      <td colspan="8" align="center"> 
	  
	  <%if (Cortrol.indexOf("A")>=0 ){ 
	    if (StrJzDate.equals("")){
	  %>
	  
	 
	  <%}else{out.println("<font color=red>此房已备案</font>");} %>
	   
	  <%} 
	  if (!zmbak.equals("")){%>
	   <input type=button name=zmrecord  onclick="openwin('zm_list.jsp?htno=<%=code %>',450,300,100,100);" value="查看转名记录"> 
	   <%} %>
	  </td>
    </tr>
	</table>	
     <table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif">　<img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>房间资料</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"><font color="#FF6600">&nbsp;</font></td>
</tr>
</table>	
 <table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#ffffff" class="tablefill">
 
      <td width="15%" align=left class=roomleft>&nbsp;楼盘名称</td>
      <td width="19%" align=left class=roomright><div id="idname"><%=secname %></div> 
        <input type=hidden name="sectio" readonly value="<%=getbyte2(request.getParameter("secname")) %>" size="10"  >
         <input type=hidden name="oldsectio" readonly value="<%=getbyte2(request.getParameter("secname")) %>" size="10"  >
       
	    <input type=hidden name="section"  value="<%=getbyte2(request.getParameter("secno")) %>" size="10"  >
           <input type=hidden name="oldsection"  value="<%=getbyte2(request.getParameter("secno")) %>" size="10"  >
   
	  </td>
      <td width="15%" align=left class=roomleft>&nbsp;房&nbsp;间&nbsp;号&nbsp;</td>
      <td   align=left class=roomright width="20%"><div id="idroomno"><%=getbyte2(request.getParameter("loft")) %><%=getbyte2(request.getParameter("build")) %><%=getbyte2(request.getParameter("roomno")) %></div></td>
      <td   align=left class=roomleft width="12%">&nbsp;交楼日期</td>
      <td width="19%" class=roomright align=left><%=JLdate.substring(0,10) %> 
        　</td>
    </tr>
	 
	    <input type=hidden name="roomno" readonly value="<%=getbyte2(request.getParameter("roomno")) %>" size="15"   onChange="toUpper(document.cus.roomno)">
        <input type="hidden" name="loft" readonly="readonly" size="15" value="<%=getbyte2(request.getParameter("loft")) %>">
		<input type="hidden" name="oldloft" readonly="readonly" size="15" value="<%=getbyte2(request.getParameter("loft")) %>">
		<input type=hidden name="oldbuild" readonly value="<%=getbyte2(request.getParameter("build")) %>"   size="15"   onChange="toUpper(document.cus.build)">
    	
		<input type=hidden name="build" readonly value="<%=getbyte2(request.getParameter("build")) %>"   size="15"   onChange="toUpper(document.cus.build)">
    	<INPUT TYPE=hidden NAME=Date2 value="<%=request.getParameter("jldate") %>" size=10 readonly title="请选择认购日期" onkeydown="key(document.cus.pay)">
        <input type=hidden name="jzarea" readonly  value="<%=SaleArea %>"  size="15"  >
		<input type=hidden name="area" readonly value="<%=UseArea%>"  size="15"  >
		<input type=hidden name="tnunitprice" readonly  value="<%=UserUnitPrice%>"  size="15"  >
   	    <input type=hidden name="jzunitprice" readonly value="<%=SaleUnitPrice%>"  size="15"  >
        <input type=hidden name="fx" readonly  value="<%=RoomType %>"  size="15"   onChange="toUpper(document.cus.roomno)">
        <input type=hidden name="sumprice" readonly value="<%=SaleSumPrice %>"  size="15"  >
		<input type=hidden name="zx" readonly value="<%=Fitment %>"  size="15"   >
        <input type=hidden name="fl"  readonly value="<%=Room_Type%>" size="15"  >
		 <input type=hidden name="yong_tu"  readonly value="<%=yong_tu%>" size="15"  >
		<input type=hidden name="yang_tai_area"  readonly value="<%=yang_tai_area%>" size="15"  >
      
    <tr> 
      <td width="15%" align=left class=roomleft>&nbsp;建筑面积</td>
      <td width="19%" align=left class=roomright><div id="idjzarea"><%=area1 %></div></td>
      <td width="15%" align=left class=roomleft>&nbsp;套内建筑面积</td>
      <td   align=left class=roomright width="20%"><div id="idusearea"><%=area%></div></td>
      <td   align=left class=roomleft width="12%">&nbsp;套内建筑<br>&nbsp;面积单价</td>
      <td width="19%" class=roomright align=left><div id="idunitprice"><%=UserUnitPrice%></div></td>
    </tr>
  <%if (y_tnarea>0){ %>
   <tr> 
      <td width="15%" align=left class=roomleft>&nbsp;核实建筑面积</td>
      <td width="19%" align=left class=roomright>&nbsp;<%=y_jzarea %></td>
      <td width="15%" align=left class=roomleft>&nbsp;核实套内面积</td>
      <td   align=left class=roomright width="20%">&nbsp;<%=y_tnarea%></td>
      <td   align=left class=roomleft width="12%"></td>
      <td width="19%" class=roomright align=left></td>
    </tr>
  <%} %>
	 <tr> 
      <td width="15%" align=left class=roomleft>&nbsp;建筑面积单价</td>
      <td width="19%" align=left class=roomright><div id="idsaleunitprice"><%=SaleUnitPrice%></div></td>
      <td width="15%" align=left class=roomleft>&nbsp;预售总价</td>
      <td   align=left class=roomright width="20%"><div id="idsumprice"><%=SaleSumPrice %></div></td>
      <td   align=left class=roomleft width="12%">&nbsp;房间总价</td>
      <td width="19%" class=roomright align=left><div id="idsumprice1"><%=room_price1 %></div></td>
    </tr>
	<!--
	<tr> 
      <td width="15%" align=left class=roomleft>&nbsp;花园/露台面积</td>
      <td width="19%" align=left class=roomright>&nbsp;<%=lu_tai_area%></td>
      <td width="15%" align=left class=roomleft>&nbsp;花园/露台单价</td>
      <td   align=left class=roomright width="20%">&nbsp;<%=lu_tai_area_price %></td>
      <td   align=left class=roomleft width="12%">&nbsp;阳台面积</td>
      <td width="19%" class=roomright align=left>&nbsp;<%=yang_tai_area %> 　</td>
    </tr>-->
	 <tr> 
      <td width="15%" align=left class=roomleft>&nbsp;用途</td>
      <td width="19%" align=left colspan="5" class=roomright><div id="idyong_tu1"><%=yong_tu%></div></td>
      
    </tr>
	<tr> 
        <input type=hidden name="checkefsfcmoney"  value="<%=fsfcroom %>">
      <td   align=left class=roomleft width="20%">&nbsp;附属房产<input type=hidden name="fsfcmoney"  value="<%=fsfcmoney %>"></td>
      <td   align=left  colspan="5"  class=roomright width="12%"><div id="idfsfc"><%=fsfcroom %><%if (!fsfcroom.equals("")){out.print("("+fsfcmoney+")");} %></div> <input type=hidden name="fsfc" size=8 readonly  value="<%=fsfc %>"><%if (fsfc.equals("")){ %><INPUT TYPE="button"  NAME=xzfcfs value="添加" title="添加客户购买的附属房产" onclick="document.cus.br.checked=false;openwin2('RoomCodeShowFS.jsp?SecNo=<%=SecNo %>&Loft=<%=Loft %>&SecName=<%=getbyte2(request.getParameter("secname")) %>',800,400,50,50);"><%}else{ %>&nbsp;<INPUT TYPE="button"  NAME=xzfcfs value="取消" title="取消客户购买的附属房产" onclick="if (confirm('确认取消吗?')){cancelfsfc();document.cus.fsfc.value='';openwin2('cancelFsfc.jsp?br=<%=br %>&code=<%=code %>&fsfccode=<%=fsfc %>',100,100,50,50);}"><%} %><input type=checkbox name=br value=1 <%if (br.equals("1")){out.print("checked");} %> onclick="chfsfc(this);">并入房款</td>
   
    </tr>
  </table>
    <table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#ffffff" class="tablefill">        
	 <tr> 
      <td colspan="8" align="center"  bgcolor="#CFE6EB"></td> 
    </tr>
   </table>
 <table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif">　<img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>客户资料</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"><font color="#FF6600">&nbsp;</font></td>
</tr>
</table>	
  <table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#ffffff" class="tablefill">
     <tr> 
      <input type=hidden name="cusname" value="<%=cusno %>">
      <td width="16%" class=roomleft >&nbsp;客户姓名</td>
     <input type=hidden name="cusname2" value="<%=cusname %>">
      <td colspan="2" class=roomright>&nbsp;&nbsp;<input type=text   name="cusname1"  size=00 onchange="aa();" value="<%=cusname %>"  onkeydown="key(document.cus.carid)" title="如果多个姓名，请用'/'分隔">
       <!-- <font color=red>*</font> 
        <input type=button name=FindB  value="查找" onclick="FindOption();">
        -->　 
<script>
  function aa(){
    var aa=document.cus.cusname1.value;
    var aa1=document.cus.cusname2.value;
    if (aa!=aa1){
       if (confirm("你已变更了客户姓名，请录入更名原因"))
         { setSelectMad(document.cus.editnow,"2");
		  document.all.T.style.display=(document.cus.editnow.value=='2')?'block':'none';
		  document.cus.zmyy.readOnly=false;
		   document.cus.zmyy.focus();}
       else{
          setSelectMad(document.cus.editnow,"1"); 
		  document.all.T.style.display=(document.cus.editnow.value=='2')?'block':'none';       
           document.cus.zmyy.readOnly=true;
		   }
     }else{
     setSelectMad(document.cus.editnow,"1");
   }
}
 function bb(){
   if (document.cus.editnow.value=='2'){
		  document.all.T.style.display=(document.cus.editnow.value=='2')?'block':'none';
		  document.cus.zmyy.readOnly=false;
		  document.cus.zmyy.focus();}
       else{
	      document.all.T.style.display=(document.cus.editnow.value=='2')?'block':'none';       
           document.cus.zmyy.readOnly=true;
		   }
 }
</script>
       <select name="editnow" onchange="bb();"  ><option value="1">更新现客户</option> <option value="2">转名(保留原客户)</option>
</select>         　 
        <input type=button name=FindB  value="查找" onclick="FindOption();"> <input type=button name=FindB  value="详情" onclick="xiangqing();"> 
    </tr>
	
	 <tr> 
	 <td colspan="4">
	 <div id="T" style="display:none">
	 <table width="100%">
	  
      <td width="16%" class=roomleft>&nbsp;转名原因</td>
      <td class=roomright>&nbsp; <input type=text  readonly name="zmyy"  size=50     onkeydown="key(document.cus.carid)">
	  <INPUT TYPE="text"  NAME=zmdate   size=10 readonly title="请选择转名日期"    ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(zmdate);" title="请选择日期">
        　</td>
		
		</table>
		
		</td>
    </tr>
	
    <tr> 
      <td width="16%" class=roomleft>&nbsp;身份证号</td>
      <td class=roomright>&nbsp; <input type=text  name="carid"  size=60  value="<%=ID_Card %>"  onchange="countAge();" onkeydown="key(document.cus.tel)">
        　</td>
    </tr><input type=hidden name=age>
    <tr> 
      <td width="16%" class=roomleft>&nbsp;联系电话</td>
      <td class=roomright >&nbsp;&nbsp;<input type=text  name="tel"  size=30   value="<%=Phone %>" onKeyDown="key(document.cus.sj)"> 手机 <input type=text  name="sj"  size=23  value="<%=sj %>" onKeyDown="key(document.cus.Address)">
        　</td>
    </tr>
    <tr> 
      <td width="16%" class=roomleft>&nbsp;联系地址</td>
      <td class=roomright >&nbsp; <input type=text  name="Address"  size=60  value="<%=Address %>" onKeyDown="key(document.cus.memberT)"> 
      </td>
    </tr>
    
	<tr> 
      <td class=roomleft>&nbsp;是否业主介绍： </td>
      <td class=roomright>&nbsp; <input type=checkbox name=memberT onKeyDown="key(document.cus.youhui)" value=1  <%if (membert){out.print("checked");} %>  ><input type=text name=memberNO  readonly value="<%=memberno %>" maxlength="50"><input type=button name=FindC  value="查找" onclick="FindOption1();"> 
	  </td>
	  </tr>
    <tr> 
      <td class=roomleft>&nbsp;优惠赠送 </td>
      <td class=roomright>&nbsp; <input type=text name=youhui onKeyDown="key(document.cus.custype)" size=50 value="<%=yh_zs %>"> 
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
      <td  class=roomright>&nbsp; <select name=custype onKeyDown="key(document.cus.note)" >
          <option value=个人>个人</option>
          <option value=企业>企业</option>
        </select>  &nbsp;<select name=rh><option value=0>不入户</option>
   <option value=1>需要入户</option>
        </select> &nbsp;入户数:<input type=text  size=7 value="<%=rhn %>" name=rhn>&nbsp; 
        
        <input type=hidden name=demurrage value=0> </tr>
    <tr> 
     <td width="16%" rowspan="5"   class=roomleft>&nbsp;备&nbsp;注</td>
      <td  class=roomright>&nbsp; <textarea rows="3" name="note" onKeyDown="key(document.cus.listlar)" cols="35"  ><%=note %></textarea> &nbsp;销售员:&nbsp; <select name="seller"  multiple size=3  onblur="SelectedSeller();" style="width:100">
          <option value="<%=seller %>" selected><%=seller %></option>
          <option ></option>
          <option ></option>
          <option ></option>
          <option ></option>
        </select> <input type=button name=listlar value="<<" onclick="list1();" title="增加销售员"> 
        <input type=button name=rem value=">>" onclick="remo();"  title="删除销售员"> 
        
      </td>
    </tr>
    </tr>
  </table>
 <table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif">　<img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>认购资料</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"><font color="#FF6600">&nbsp;</font></td>
</tr>
</table>	
  <table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#ffffff" class="tablefill">
     
    <tr> 
      <td width="12%" class=roomleft>&nbsp;认购编号</td>
   <td width="12%" class=roomright>&nbsp;<input type=text name="rgsno" value="<%=rgno %>"  size="7"   onChange="toUpper(document.cus.rgsno)" onKeyDown="key(document.cus.cale1)" onBlur="checkedOrderNoExist();" title="只能是英文字母、数字及"-"组成"><input type=button name=adc value=".." title="选择合同号" onclick="openwin('RgNoList.jsp?SecNo=<%=SecNo %>',200,350,100,100);"></td>
 
      <td width="19%" class=roomleft>&nbsp;认购日期</td>
      <td width="19%" class=roomright>&nbsp;<input type=TEXT name=Date1 size=10 title="请选择认购日期"  value="<%=date.substring(0,10) %>" readonly onchange="key(document.cus.pay);" onKeyDown="key(document.cus.VisaDate)">
        <input type=button name=cale1 value=".." onClick="fPopUpCalendarDlg(Date1);return false;" title="请选择认购日期">
       </td>
	  
      <td width="15%" class=roomleft>&nbsp;付款方式</td>
      <td width="23%" class=roomright>&nbsp;<select name="pay"      style="width : 150" onKeyDown="key(document.cus.VisaDate)" onChange="charges();"><!--onChange="charges();"-->
    <%if (payment.indexOf(".")<0)payment=payment+".";%>     
     <option value=""></option>
                 <%
     String sql="select * from PayMent where seccoe='"+SecNo+"'";
       rs3=ViewBean.executeQuery(sql);
	  String pay="";
	  float dic;
	  String dj1="";
	  String qdate="";
	  String ajdate="";	  
	  String num="";
	   String gddate="";	
     while (rs3.next()){
	    pay=getbyte(rs3.getString("PayName"));
		num=rs3.getString("num");
	    dic=rs3.getFloat("Discont");
		dj1=rs3.getString("prepay");
		qdate=rs3.getString("qdate");
		ajdate=rs3.getString("ajdate");
		gddate=getbyte(rs3.getString("gddate"));
		if (!gddate.equals(""))gddate=gddate.substring(0,10);
		String dic1=String.valueOf(dic);
	   	out.print("<option value='"+pay+"-"+dic1+"-"+dj1+"*"+num+"#"+qdate+"."+ajdate+"g"+gddate+"'>"+pay+"."+num+"期*"+dic+"折"+"</option>");
	   }
	  
	    rs3.close();
     %>
        </select> 
        <input type=hidden name=dis size=6 readonly value="<%=disc1 %>">
        </td>
    </tr>
	 <%if (Cortrol.indexOf("K")>=0){  %>
    <tr> 
      <td width="19%" class=roomleft>&nbsp;额外优惠</td>
      <td width="19%" class=roomright   >&nbsp;<input type="hidden" name="ewyh1" size=10 value="<%=youhui %>"><input type="text" name="ewyh" size=10 value="<%=youhui %>"  onchange="check(this);count5();"   onkeydown="key(document.cus.curry);">
      </td>

	   <td width="15%" class=roomleft>&nbsp;额外折扣</td>
      <td width="23%"    class=roomright>&nbsp;<input  type=hidden name=abcd1 value="<%=StrEwDisc %>"><input  type=text name=abcd value="<%=StrEwDisc %>" onchange="check(this);count3();" size=8 title="输入格式：99" onkeydown="key(document.cus.curry);">%        
        　</td>

	  <td width="15%" class=roomleft>&nbsp;优惠日期</td>
      <td width="23%"    class=roomright>&nbsp;<input  type=text name=youhui_date  value="<%=youhui_date %>" size=12 onkeydown="key(document.cus.curry);"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(youhui_date);" title="请选择认购日期">
      </td><input type=hidden name="ajtype" value="0">
    
	 </tr>
	 <tr> 
      <td width="19%" class=roomleft>&nbsp;优惠备注</td>
      <td width="19%" class=roomright  colspan="3"  >&nbsp;<input  type=text name=youhuibeizhu  value="<%=youhuibeizhu %>" size=44 onkeydown="key(document.cus.curry);">&nbsp;</td><td width="15%" class=roomleft>&nbsp;关&nbsp;系&nbsp;人&nbsp;&nbsp;</td><td class=roomright >&nbsp;<input type=text size=10 name=gxr value="<%=gxr %>" >
 
    
 </tr>
 <%}else{ %>
	 <input  type="hidden" name="ewyh" size=10 >
	 <input  type=hidden name=youhuibeizhu  size=12 >
	 <input  type=hidden name=abcd  >
	
	<%} %>
	 
<%String oldajcs="";
       try{  if (payment.indexOf("(")>0)oldajcs=payment.substring(payment.indexOf("(")+1,payment.indexOf("%"));
	   }catch(Exception s){}
      %>
<input type="hidden" name=oldajcs size=3 value=<%=oldajcs %>>
   <tr><td class=roomleft>&nbsp;按揭银行</td>
	    <td width="18%" class=roomright>&nbsp;<select name=ajbk   style="width : 90">
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
        </select></td>
		<td class=roomleft>&nbsp;公积金贷款</td>
		<td class=roomright>&nbsp;<input type=text name=gjj size=9 onKeyDown="key(document.cus.gjjy);" value="<%=gjj %>"  Onblur="dkcount1();">(元)</td>
		 <td width="12%" class=roomleft >&nbsp;贷款年限</td> 
      <td width="15%"    class=roomright  >&nbsp;<select name=gjjy  onKeyDown="key(document.cus.sydk)"   onchange="count();"  style="width : 80" >
          <option></option>
		  <option value=0.5>0.5年</option>
          <%for (int i=1;i<=30;i++){
		out.print("<option value="+String.valueOf(i)+">"+String.valueOf(i)+"年</option>");
		} %>
        </select></td>
	   </tr>
    <tr>
	 <td width="15%" class=roomleft>&nbsp;按 揭 额</td>
        <td width="19%" class=roomright  >&nbsp;<input  type=text size=10  value="<%=ajmoney %>"     name=ajmoney onblur="check(this);countAj();" onChange="dkcount1();">(元)　</td>
   <td class=roomleft>&nbsp;商业  贷款</td>
		<td class=roomright>&nbsp;<input type=text name=sydk size=9  onKeyDown="key(document.cus.ajyr)" value="<%=sydk %>" OnBlur="dkcount2();">(元)</td>
      <td width="12%" class=roomleft >&nbsp;按揭年限</td><input type=hidden name=oldajcs size=4>
      <td width="15%"    class=roomright  >&nbsp;<select name=ajyr      onchange="count();"  style="width : 80" ><!--onblur="bxRate();"-->
          <option></option>
		  <option value=0.5>0.5年</option>
          <%for (int i=1;i<=30;i++){
		out.print("<option value="+String.valueOf(i)+">"+String.valueOf(i)+"年</option>");
		} %>
        </select></td>
		  </tr>
<input type="hidden" name=ajcs size=3 value=<%=ajcs %>>
     
	<input type=hidden name=yukuan value=0>
     
     
     
   
 <tr>
<td width="19%" class=roomleft >&nbsp;成交房款</td>
      <td width="19%"    class=roomright  >&nbsp;以定价为准:<input type=checkbox name=bz value=1 <%if (countType){ %> checked <%} %>onclick="checkcount();"></td><td><input type=text name="dicprice" value="<%=room_price %>"  defaultValue="<%=youhuiprice %>" size="10" onblur="check(this);ykj_count();"    <%if (countType||Cortrol.indexOf("C")==-1){ %>   readonly <%} %> >元
   <input type=hidden name="countdiscprice" value="<%=room_price %>">
        <input type=hidden value=0 readonly name="MonthMoney"     size="10"  >
		<td width="23%" class=roomright  >&nbsp;<select name="curry" style="width : 40" OnChange="CurrRa();">
         <option value="￥">￥</option>
          <option value="HKD">HKD</option>
          <option value="USD">USD</option>
        </select><input type=text name="rate"  value=1.0  size="4" title="汇率" >
      </td>
	   <td width="19%" class=roomleft>&nbsp;首&nbsp;期&nbsp;款</td>
      <td width="19%" class=roomright  >&nbsp;<input  type=text size=10  value="<%=firstmoney%>" name=firstMoney   onblur="check(this);countsq();">
        (元)　</td>
     
  <input type=hidden name="Adicprice"     size="10" value="<%=salprice %>" onkeydown="key(document.cus.cjjzprice);"> 
      
    </tr>
    <tr>
      <td width="12%" class=roomleft >&nbsp;成交建筑<br>&nbsp;面积单价</td>
      <td width="12%" class=roomright >&nbsp;<input type=text name="cjjzprice" readonly value="<%=saleJzPrice %>" size=10 ></td>
      <td width="19%" class=roomleft >&nbsp;成交套内建<br>&nbsp;筑面积单价</td>
      <td width="19%"    class=roomright>&nbsp;<input type=text name="cjtnprice" readonly  value="<%=saleUsePrice %>" size=10> 元　</td>
       <td width="15%" class=roomleft>&nbsp;定 金</td>
      <td width="23%" class=roomright  >&nbsp;<input type=text value="<%=dj %>" name="earnest" disabled  onblur="check(this);"   size="10"  >
    </td>     
    </tr>
		 <input type=hidden size=10 value=0  name="firstmoney" value=<%=zs_first_money %> onchange="sendfirst(this);">
	<input type=hidden size=10 name="factprice" readonly value=<%=factprice %>>
	<input type=hidden name="sjcjjzprice" size=10  readonly  value="<%=sjsaleJzPrice %>" >
	<input type=hidden name="sjcjtnprice" size=8 readonly  value="<%=sjsaleUsePrice %>">
	<tr>
	 <td width="19%" class=roomleft >&nbsp;合同计价方式</td>
      <td width="19%" class=roomright >&nbsp;<select name="counttype" style="width : 90">
          <option value="0">套内面积</option>
          <option value="1">建筑面积</option>
        </select></td> 
	 
	  <td width="15%" class=roomleft>&nbsp;</td>
      <td width="23%" class=roomright  >
        　　</td>
		<td width="15%" class=roomleft>&nbsp;</td>
      <td width="23%" class=roomright  >
        　　</td>
	 </tr>
	   <input type=hidden onblur="countlutai();" name="lutai_area" size=10 value="<%=lu_tai_area %>"  >
	   <input type=hidden onblur="countlutai();" name="lutai_area_price" size=8  value="<%=lu_tai_area_price %>"  >
	   <input type=hidden name="tai_area_sumprice" size=8 readonly  value="<%=lzp %>" >
	   <input type=hidden name="ty_area" onblur="countty();"  size=10 value="<%=ty_area %>"  >
	   <input type=hidden name="ty_area_price" size=8   onblur="countty();" value="<%=ty_area_price %>"  >
	   <input type=hidden name="ty_area_sumprice" size=8 readonly  value="<%=typrice %>" >
	   <input type=hidden name="wd_area_sumprice" size=8 readonly  value="<%=wdprice %>" >
	   <input type=hidden name="wd_area_price" size=8   onblur="countwd();" value="<%=wd_area_price %>"  >
	   <input type=hidden name="wd_area" onblur="countwd();"  size=10 value="<%=wd_area %>"  >

     <!--
	 
	  <tr>
      <td width="12%" class=roomleft >&nbsp;露台面积</td>
      <td width="12%" class=roomright >&nbsp;<input type=text  onchange="countlutai();" name="lutai_area" size=10 value="<%=lu_tai_area %>"  ></td>
      <td width="19%" class=roomleft >&nbsp;露台单价</td>
      <td width="19%" class=roomright >&nbsp;<input type=text onblur="countlutai();" name="lutai_area_price" size=8  value="<%=lu_tai_area_price %>"  > 元/M<sup>2</sup>　</td> 
	   <td width="19%" class=roomleft >&nbsp;露台总价</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="tai_area_sumprice" size=8 readonly  value="<%=lzp %>" > 元</td>  </tr>
  
	   </tr>
	    <tr>
      <td width="12%" class=roomleft >&nbsp;花园面积</td>
      <td width="12%" class=roomright >&nbsp;<input type=text name="ty_area" onchange="countty();"  size=10 value="<%=ty_area %>"  ></td>
      <td width="19%" class=roomleft >&nbsp;花园单价</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="ty_area_price" size=8   onblur="countty();" value="<%=ty_area_price %>"  > 元/M<sup>2</sup>　</td> 
	   <td width="19%" class=roomleft >&nbsp;花园总价</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="ty_area_sumprice" size=8 readonly  value="<%=typrice %>" > 元</td>  </tr>
  
	   </tr>
	    <tr>
      <td width="12%" class=roomleft >&nbsp;屋面面积</td>
      <td width="12%" class=roomright >&nbsp;<input type=text name="wd_area" onchange="countwd();"  size=10 value="<%=wd_area %>"  ></td>
      <td width="19%" class=roomleft >&nbsp;屋面单价</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="wd_area_price" size=8   onblur="countwd();" value="<%=wd_area_price %>"  > 元/M<sup>2</sup>　</td> 
	   <td width="19%" class=roomleft >&nbsp;屋面总价</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="wd_area_sumprice" size=8 readonly  value="<%=wdprice %>" > 元</td>  </tr>
  
	   </tr>-->
  </table>
  <script>
    function gzarea(){
        if (document.cus.G_jzarea.value!=""){
		document.cus.area.value=subs1(parseFloat(document.cus.area.value)-parseFloat(document.cus.G_jzarea.value),2);
		// count5();   
		}
    
    }
    function countwd(){
	      if (document.cus.wd_area.value!=""&&document.cus.wd_area_price.value!=""){
		     document.cus.wd_area_sumprice.value=parseFloat(document.cus.wd_area.value)*parseFloat(document.cus.wd_area_price.value)
		  }
	   }
	function countlutai(){
	      if (document.cus.lutai_area.value!=""&&document.cus.lutai_area_price.value!=""){
		     document.cus.tai_area_sumprice.value=parseFloat(document.cus.lutai_area.value)*parseFloat(document.cus.lutai_area_price.value)
		  }
	   }
	function countty(){
	      if (document.cus.ty_area.value!=""&&document.cus.ty_area_price.value!=""){
		     document.cus.ty_area_sumprice.value=parseFloat(document.cus.ty_area.value)*parseFloat(document.cus.ty_area_price.value)
		  }
	   }
	   function gzcount(){
	         if (document.cus.G_jzarea.value!=""&&document.cus.G_unitprice.value!=""&&parseFloat(document.cus.G_unitprice.value)>0){
		          count5();   
			     document.cus.cjtnprice.value=subs1(parseFloat(document.cus.cjtnprice.value)-parseFloat(document.cus.G_unitprice.value),2);
	        
				 document.cus.dicprice.value=subs1(parseFloat(document.cus.G_jzarea.value)*parseFloat(document.cus.cjtnprice.value),2);
				 document.cus.G_sumprice.value=subs1(parseFloat(document.cus.G_jzarea.value)*parseFloat(document.cus.G_unitprice.value),2);
			     document.cus.cjjzprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.jzarea.value),2);
               //  document.cus.cjtnprice.value=subs1(document.cus.cjtnprice.value,2);
	           //  document.cus.cjjzprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.jzarea.value),2);
               //  document.cus.cjjzprice.value=subs1(document.cus.cjjzprice.value,2); 
			    document.cus.Adicprice.value= document.cus.dicprice.value;
				   var ajcs=document.cus.pay.value;
                    ajcs=ajcs.substring(0,ajcs.indexOf("g"));
                   document.cus.ajmoney.value=parseInt(parseInt(document.cus.dicprice.value,10)*parseFloat(ajcs.substring(ajcs.indexOf("(")+1,ajcs.indexOf("%")),10)/100/<%=ajkw%>)*<%=ajkw%>;
                    document.cus.firstMoney.value=subs1(parseFloat(document.cus.dicprice.value)-parseInt( document.cus.ajmoney.value),2);  
			      document.cus.ajcs.value=subs1(parseInt(document.cus.ajmoney.value)/parseFloat(document.cus.dicprice.value)*100,2);
			 }else if  (document.cus.G_unitprice.value==""||document.cus.G_unitprice.value=="0"){
			  count5();
			 }
			 
	   
	   
	   }
	   </script>
	    <table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif">　<img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>合同资料</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"><font color="#FF6600">&nbsp;</font></td>
</tr>
</table>	
    <table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#ffffff" class="tablefill">
    
    <tr > 
      <td width="16%"  class=roomleft>已交首期款</td>
      <td width="18%"  class=roomright>&nbsp;<input type=text size=12 value="<%=factmoney %>"><input type=hidden name="firstFT" value="1" style="width : 105"></td>
      <td width="16%"  class=roomleft>合同编号</td>
      <td width="18%"  class=roomright>&nbsp;<input type="text"   name="constractno" value="<%=ContractNo %>"    size="10"    onBlur="checkedOrderNoExist1();"   OnChange="toUpper(document.cus.constractno)" onkeydown="key(document.cus.QYDate)" ><input type=button name=adc value=".." title="选择合同号" onclick="openwin('ContractNoList.jsp?SecNo=<%=secno %>',200,350,100,100);"></td>
      <td width="14%"  class=roomleft>签约日期
      </td> 
      <td width="18%"  class=roomright>&nbsp;<INPUT TYPE="text"  NAME=QYDate value="<%if (state.equals("2"))out.println(VisaDate.substring(0,10)); %>" size=10 readonly title="请选择签约日期"   onkeydown="key(document.cus.kkrate)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(QYDate);" title="请选择认购日期"></td>
    </tr>
	   <tr > 
	   <INPUT TYPE="hidden"  NAME=oldjldate value="<%=jldate %>"  >
      <td width="16%"  class=roomleft>交楼日期</td>
      <td width="18%"  class=roomright>&nbsp;<INPUT TYPE="text"  NAME=jldate value="<%=jldate %>" size=10 readonly title="请选择交楼日期"    ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(jldate);" title="请选择认购日期"></td>
      <td width="16%"  class=roomleft>交楼备注</td>
      <td width="18%"  class=roomright colspan="3">&nbsp;<textarea cols="43" rows="2" name="jlbak"><%=jlbak %></textarea></td>
    </tr>
	<INPUT TYPE="hidden" name="G_jzarea"  value="<%=area %>" size="12"  ya="<%=UseArea %>">
	<input type="hidden" name="G_unitprice" onblur="gzcount();" size="12" value="<%=gaizhang_unitprice %>"   onblur="checkedOrderNoExist(this.value);" onkeydown="key(document.cus.QYDate)" title="只能是英文字母、数字及"-"组成">
	<INPUT TYPE="hidden"  NAME=G_sumprice size=10  value="<%=g_sumprice %>"  readonly  >
	<!--
	  <tr > 
      <td width="16%"  class=roomleft>改装面积</td>
      <td width="18%"  class=roomright>&nbsp;<INPUT TYPE="text" name="G_jzarea"  value="<%=area %>" size="12"  ya="<%=UseArea %>"></td>
      <td width="16%"  class=roomleft>改装单价</td>
      <td width="18%"  class=roomright>&nbsp;<input type="text" name="G_unitprice" onblur="gzcount();" size="12" value="<%=gaizhang_unitprice %>"   onblur="checkedOrderNoExist(this.value);" onkeydown="key(document.cus.QYDate)" title="只能是英文字母、数字及"-"组成"></td>
      <td width="14%"  class=roomleft>改装总款</td>
      <td width="18%"  class=roomright>&nbsp;<INPUT TYPE="text"  NAME=G_sumprice size=10  value="<%=g_sumprice %>"  readonly  > </td>
    </tr>
	-->
 <input type="hidden" name="qydate" value="<%=qytxdate %>">
 <input type="hidden" name="gddate" >
    <tr bordercolor="#FFFFFF"> 
      <td width="19%" class=roomleft >合同类别</td>
      <td width="19%" class=roomright >&nbsp;<select name="httype" style="width : 105"><option value=0 <%if (httype.equals("0")){out.print("selected");} %>>内销</option><option value=1  <%if (httype.equals("1")){out.print("selected");} %>>外销</option></select></td>  
   
      <td width="14%" class=roomleft>按揭日期</td>
      <td width="18%" class=roomright>&nbsp;<INPUT TYPE="text" value="<%if (!StrAjDate.equals("")&&Integer.parseInt(StrAjDate.substring(0,4))>=2000)out.println(StrAjDate.substring(0,10)); %>"  NAME=ajDate size=10  onkeydown="key(document.cus.ajDate)"><input type=button name=ajc value=".." onclick="fPopUpCalendarDlg(ajDate);return false;" title="请选择认购日期"></td>
      <td width="16%" class=roomleft>银行放款日期</td>
      <td width="18%" class=roomright>&nbsp;<INPUT TYPE="text" value="<%if (!StrFkDate.equals("")&&Integer.parseInt(StrFkDate.substring(0,4))>=2000)out.println(StrFkDate.substring(0,10)); %>"  NAME=fkDate size=10  onkeydown="key(document.cus.ajDate)"><input type=button name=fkc value=".." onclick="fPopUpCalendarDlg(fkDate);" title="请选择认购日期"></td>
    </tr>
    <tr bordercolor="#FFFFFF"> 
      <td width="16%" class=roomleft>公证状态</td>
      <td width="18%" class=roomright>&nbsp;<select name="gz" style="width : 105"><option value="0">未办</option><option value="1">已办</option></select></td>
      <td width="14%" class=roomleft>保险状态</td>
      <td width="18%" class=roomright>&nbsp;<select name="bx" style="width : 105"><option value="0">未办</option><option value="1">已办</option></select></td>
      <td width="16%" class=roomleft>保险金额</td>
      <td width="18%" class=roomright>&nbsp;<input type=text size=13 value="<%=StrBxMoney %>" name=bxmoney></td>
    </tr>
   <%
   sql="select sum(TaxMoney) TaxMoney,taxname_type from GatheringTaxRecord where contactno ='"+code+"' group by taxname_type";//order by room_no desc";
   rs=ViewBean.executeQuery(sql);
   double taxprice=0,peitaoprice=0;
   while (rs.next()){
     if (rs.getBoolean("taxname_type"))taxprice=rs.getDouble("TaxMoney");
	 else peitaoprice=rs.getDouble("TaxMoney");
 }
 rs.close();
 double s_price=0;
	sql="SELECT (rmbprice-ajmoney)+lu_tai_area_price*lu_tai_area+gaizhang_area*gaizhang_unitprice sumprice from order_contract where code="+code;
    rs=ViewBean.executeQuery(sql);
	 
	if (rs.next()){
	   s_price=rs.getDouble("sumprice");
	
	}
	s_price+=peitaoprice+taxprice;
	rs.close();
    %>
    <tr bordercolor="#FFFFFF"> 
      <td width="16%" class=roomleft>税费合计</td>
      <td width="18%" class=roomright>&nbsp;<input type=text size=13 name=tax value="<%=taxprice %>" readonly></td>
       <td width="16%" class=roomleft>配套合计</td>
      <td width="18%" class=roomright>&nbsp;<input type=text size=13 name=tax value="<%=peitaoprice %>" readonly></td>
     
	  <td width="14%" class=roomleft>首期合计</td>
      <td width="18%" class=roomright>&nbsp;<input type=text size=13 name=tax value="<%=Format.getFloat3(s_price,2) %>" readonly></td>
      <td width="16%" class=roomleft> </td>
      <td width="18%" class=roomright>&nbsp;</td>
    </tr>
	 <tr bordercolor="#FFFFFF"> 
 
     
      <td width="18%"  colspan="6" class=roomright>&nbsp;重新计算付款计划:<input type=checkbox name=modijh value=1>&nbsp;重新计算税费:<input type=checkbox name=moditax value=1>&nbsp;&nbsp;<font color=red>当客户的付款方式或总房款变化时，建议选择本选项</font></td>
    </tr>
    <input type=hidden name=caDate value="1800-01-01">
    <input type=hidden name=ajtxdate value="0">
	 <input type=hidden name=orderstate value="1">
  </table>
  
  <%//}
  if (checkstate){
   %>
     此合同已通过审批，审批人：<%=checkperson %>&nbsp;审批日期:<%=checkDate %>
	  <%
		 if (Cortrol.indexOf("F")>=0&&ContractNo.equals("")){// &&  (!userstate.equals("1") || loginuserid.equals("userid")) && see.equals("1")) %>
    <input type="button" value="打印认购书" name="submit2" onclick="printrs();">
	<%} %>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    <input type="button" value="退 出" name="reset" onclick="window.close();">
  <%out.close();}
  if ((loke.equals("1")&&nn>loke_time)||loke.equals("0")||loke_time==0){ %>
    <%}else{ out.print("<script>alert('数据被人占用，"+loke_time+"分钟后请刷新，自动解锁');close();</script>");out.close();}%>
  <p align="center"> 
    <input type=hidden name=saveorder value="modi">
	 <%
		 if (Cortrol.indexOf("A")>=0){
		     if (StrJzDate.equals("")){
		 // &&  (!userstate.equals("1") || loginuserid.equals("userid")) && see.equals("1")) %>
   <% }
	 } %>
	&nbsp;&nbsp; 
	 <%
	   String reportAddrs=(String)session.getAttribute("reportAddr");
		 if (Cortrol.indexOf("F")>=0&&!ContractNo.equals("")){// &&  (!userstate.equals("1") || loginuserid.equals("userid")) && see.equals("1")) %>
    <input type="button" value="打印合同" name="submit2" onclick="openwin('szhtbook.jsp?code=<%=code %>',500,450,10,10);"><!--openwin('contractbook.jsp?code=<%=code %>-->
	 &nbsp;
	 
	 <input type="button" value="补充协议" name="submit4" onclick="openwin('buchongxy.jsp?code=<%=code %>',500,450,10,10);">
	
	<%} %>
    &nbsp;&nbsp; 
	<input type="button" value="打印付款清单" name="reset" onclick="window.open('../finance/paylist.jsp?contractno=<%=code %>&cusno=<%=cusno %>&pay=<%=pay1 %>');">
   &nbsp;&nbsp; 
    <input type="button" value="退 出" name="reset" onclick="window.close();">
  </P>
  
	 <p align=center>
  <b><font size="3" color="#000080">应收一览表</font></b>
 </p>  
   
    <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
     <tr  class=listtitle  align="center">
        <td><font color="#FFFFFF">序号</font></td>
		 <td><font color="#FFFFFF">款项</font></td>
        <td><font color="#FFFFFF">付款期限</font></td>
        <td><font color="#FFFFFF">应交款</font></td>
		<td><font color="#FFFFFF">已交款</font></td>
        <td><font color="#FFFFFF">未交款</font></td>
        <td><font color="#FFFFFF">滞纳金</font></td>
   
     </tr>

    <%
	 
    String sq2 = " select g.*,c.signatory from GatheringRecord g,customer  c where c.serialno=g.cusno and  g.contactno = '" + code + "' "
                + " and g.cusno = '" + cusno + "' " + " order by shouldDate,g.shouldQS ";
    ResultSet rs2 = ViewBean.executeQuery( sq2 ) ;
 
    double weijiao = 0 ;
    double yijiao = 0 ;
    double zhiNaJing = 0 ;
    double ysmoney=0;
    int jj = 0 ;
	int prin=1;
	int ysid=0;
	String signatory="";
	 String shouldDate="";
     curry="";
	 rate="0"; 
	 String gather_date="";
    String statevalue="";
    String statestr="";
    int i=0;
	double ysSumMoney=0;
   String qs="";
    while( rs2.next() ) {
        jj++;
     	ysid=rs2.getInt("id");
        String shouldQS = rs2.getString( "shouldQS" ) ;
		qs=shouldQS;
        shouldDate = rs2.getDate( "shouldDate" ).toString() ;
		gather_date =shouldDate;
        double shouldmoney = rs2.getDouble( "shouldmoney" ) ;
		
        ysSumMoney+=shouldmoney;
        if(jj==1)
             ysmoney=shouldmoney;	    
        double ciQiYiJiao = rs2.getDouble( "yijiao" ) ;
        double qianKuan = shouldmoney - ciQiYiJiao ;
		if (qianKuan<=0)qianKuan=0;
        double demurrage = rs2.getDouble( "demurrage" ) ; 
		state = getbyte( rs2.getString( "state" ) ) ;
		curry= getbyte( rs2.getString( "curry" ) ) ;
		rate= Format.getFloat( rs2.getFloat( "rate" ),4)  ;
		signatory=getbyte(rs2.getString( "signatory" ) );
		statevalue=state;
        if(jj==1)
                statestr=state;
        if( state.equals( "0" ) ) {
            state = "未交" ;prin=0;
        }else if( state.equals( "1" ) ) {
            state = "交款中" ;prin=0;
        }else if( state.equals( "2" ) ) {
            state = "已交完" ;
        }else{
            state = "" ;
        }
        weijiao = weijiao + qianKuan + demurrage ;
        yijiao = yijiao + ciQiYiJiao ;
        zhiNaJing = zhiNaJing + demurrage ;
	%>
	<%
	qs=shouldQS;
if (shouldQS.equals("0"))shouldQS ="订金";
else if (shouldQS.equals("1")) shouldQS ="房款";
else if (shouldQS.equals("2"))shouldQS ="房款";
else if (shouldQS.equals("3"))shouldQS ="房款";	
else if (shouldQS.equals("4"))shouldQS ="房款";	
else if (shouldQS.equals("5"))shouldQS ="花园/露台款";	 
else if (shouldQS.equals("6"))shouldQS ="改装款";	  
else if (shouldQS.equals("7"))shouldQS ="滞纳金";	
 	else if (shouldQS.equals("15"))shouldQS ="附属房产款";  
%>
 
 
	    <tr  class=listcontent id=TR<%=i%> align="center"     onclick="setpara( '<%= qs %>' , '<%= qianKuan+demurrage%>' , '<%= shouldmoney %>','<%=ysid %>','<%=shouldDate %>','<%=statevalue %>' );changeclass1(this,'clickbg','listcontent');" 　onmouseover="mout(this);">
          <td><%= jj %></td>
		     <td><%= shouldQS %></td>
          <td><%= shouldDate %></td>
		   <% if (qs.equals("5")){ %>
          <td ><%= Format.getFloat2(shouldmoney,2)%></td>
         <%}else{ %>
		     <td ><%= Format.getFloat2(shouldmoney,2) %></td>
         <%} %>
         <td><%= Format.getFloat2(ciQiYiJiao,2) %></td>
          <td><%= Format.getFloat2(qianKuan ,2)%></td>
          <td><%= Format.getFloat2(demurrage,2) %></td>
         
		   
        </tr>
    <%
        i ++ ;
    }
   i--;
    %>

    <tr bgcolor="#EBEBEB" align="center">
     <td colspan=3>
<b>合&nbsp;&nbsp;计:</td><td><b><%= curry+Format.getFloat2(ysSumMoney,2)%></b></td><td><b><%= curry+Format.getFloat2(yijiao,2)%></b></td> <td><b> <%= curry+Format.getFloat2(weijiao,2)%></b></td> <td ><b> <%= curry+Format.getFloat2(zhiNaJing,2)%></td></b> 
       <td >
   
  </td>
    </tr>
	</table> 
	
 <p align=center>
  <b><font size="3" color="#000080">实收一览表</font></b>
 </p> 
    <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
    <tr  class=listtitle  align="center">
        <td><font color="#FFFFFF">序号</font></td>
		<td><font color="#FFFFFF">款项</font></td>
        <td><font color="#FFFFFF">交款<br>日期</font></td>
        <td><font color="#FFFFFF">交款<br>金额</font></td>
		<td><font color="#FFFFFF">币种</font></td>
		<td><font color="#FFFFFF">汇率</font></td>
		 <td><font color="#FFFFFF">付款<br>类型</font></td>
       <!-- <td><font color="#FFFFFF">单据号</font></td>-->
        <td><font color="#FFFFFF">收款人</font></td>
		 <td><font color="#FFFFFF">打印票<br>据日期</font></td>
        <td><font color="#FFFFFF">是否审核</font></td>
    </tr>

    <%
    String sq = " select id,period, gather_date,factmoney,receiver,Bill_num";
	sq+=",BillType,CurrName,CurrRate,PayType,context,printdate,checkstate, ";
	sq+="CurrRate*factmoney ff,jsbak from factGatheringRecord where contractno = '" +code+ "' "
                + "  order by period , gather_date";
      rs = ViewBean.executeQuery( sq ) ;
      int i2 = 0 ;    
	   int rowID=0;
	   int checkstate1=0;
     String FactCurry="";
	 double sumfactmoney=0;
	 double  factmoney1 =0;
	 String FactCurryRate="",jsbak="";
	 String period ="0", context="";
	 String periodN ="0",print_date="";
	   int num1=0; 
    while( rs.next() ) {
	 num1++;
         rowID = rs.getInt( "id" ) ;
         period = rs.getString( "period" ) ;
		 
         gather_date =   rs.getDate( "gather_date" ).toString() ;
          factmoney1 = rs.getDouble( "factmoney" ) ;
  
         String receiver = getbyte( rs.getString( "receiver" ) ) ;
		 String Billnum = getbyte( rs.getString( "Bill_num" ) ) ;
		 String BillType = getbyte( rs.getString( "BillType" ) ) ;
		 FactCurry=getbyte( rs.getString( "CurrName" ) );
		 FactCurryRate=getbyte( rs.getString( "CurrRate" ) );
		 String PayType= getbyte( rs.getString( "PayType" ) ) ;
		   context= getbyte( rs.getString( "context" ) ) ;
		  print_date= getbyte( rs.getString( "printdate")) ;
		     checkstate1=rs.getInt("checkstate");
			jsbak=getbyte( rs.getString( "jsbak")) ;
			         double ff = rs.getDouble( "ff" ) ;
			  sumfactmoney+=ff;
		 if (!print_date.equals(""))print_date=print_date.substring(0,10);
		 if (BillType.equals("0"))BillType="收据";
		 if (BillType.equals("1"))BillType="发票";
		
		 String curryDX="";
		if (FactCurry.equals("￥"))curryDX="人民币";
		if (FactCurry.equals("HKD"))curryDX="港币";
		if (FactCurry.equals("USD"))curryDX="美元";
    %>
	<%
 
	if (period.equals("0"))period ="定金";
	else if (period.equals("1")) period ="房款";
	else if (period.equals("2")) period ="房款";
	else if (period.equals("2"))period ="房款";
	else if (period.equals("3"))period ="房款";	
    else if (period.equals("4"))period ="房款";	
	else if (period.equals("5"))period ="花园/露台款";	
 	else if (period.equals("6"))period ="改装款";	
	else if (period.equals("7"))period ="滞纳金";
	
	else if (period.equals("8"))period ="房款差额";	
	else if (period.equals("9"))period ="改装款差额";	
	else if (period.equals("10"))period ="花园/露台款差额";	
	else if (period.equals("11"))period ="阳台罩差额";	
	 	else if (period.equals("15"))period ="附属房产款";	
%>
        <tr class=listcontent align=center  title="<%=context %>">
          <td><%= num1%></td>
          <td><%= period %></td>
		    <td><%= gather_date %></td>
          <td><%= Format.getFloat2(factmoney1 ,2)%></td>
		  <td><%= curryDX%></td>
		 <td><%= FactCurryRate%></td>
		 
          <td ><%= PayType %></td>
		  <!--<td ><%= Billnum %></td>-->
          <td><%= receiver %></td>
		   
		 <td><%= print_date %></td>
          <td >
		  <%if (checkstate1==1){ %>
		 
		 &nbsp;<font color="red">已审核</font><%} %>
		  </td>  
        </tr>
	
    <%
       
    }
	//if (payment.indexOf("(")>0)payment=payment.substring(0,payment.indexOf("("))  ;
    %>
		 <tr bgcolor="#EBEBEB" align="center">
     <td colspan=2>
    <b>合&nbsp;&nbsp;计:</td><td colspan=7 align="left"> <b>￥<%=Format.getFloat2(sumfactmoney,2)%> </b><br>备注：<%=context %> </td> 
     <td > 
      <% if (yijiao-ysSumMoney>0) out.print(" <font color=red>余额:"+curry+Format.getFloat2(yijiao-ysSumMoney,2)+"</font>");
	  %>
  </td>
    </tr>
    </table>
	 
	<%if (payment.indexOf("揭")>0){ %>
	<p align="center"> <b><font size="3" color="#000080">银行放款记录</font></b></p>
	<table width="100%">
	  
	<tr  class=listtitle  align="center"><td>按揭银行</td><td>放款日期</td><td>放款金额</td><td>登记人</td><td>审核</td></tr> 
	<%String Fsql="select factdate,factmonye,chekcer,id,checkperson,checkstate,checkdate from FactAjCharges where contractno="+code; 
	 
	 rs = ViewBean.executeQuery( Fsql ) ;
	while (rs.next()){%>
	  <tr align="center">
	  
	  <td><%=ajbk%></td>
	  <td><%=rs.getDate("factdate").toString() %></td>
	  <td><%=rs.getString("factmonye") %></td>
	   <td> <%=rs.getString("chekcer") %></td>
	   <td><%
	  
	   if (rs.getBoolean("checkstate")){
	   out.print(getbyte("<font color='red'>"+rs.getString("chekcer"))+"&nbsp;"+ rs.getDate("checkdate").toString()+"</font>");
	   
	   }
	  
	    %>
		</td>
	    
	  </tr>
	
	
	<%}rs.close();} %>
	
	
	 
	 </table>
	
<p align=center>
  <b><font size="3" color="#000080">应交费用一览</font></b>
 </p>
  <!--<input type=button  name=count value="计算费用" onclick="openwin('TaxCount1.jsp?code=<%=code %>',10,10,10,10);">-->
 <table width="100%"  border="0" cellspacing="1"  cellpadding="1"  >
    <tr   class=TxtColor >
	 <td  >序号</td> 
      <td    >费用名称</td><td>金额</td> 
	  <!--<td>修改</td> -->
    </tr>
	
  
    <%
String sql1="";
   		sql="select id,TaxName,TaxMoney,state,TaxMoney-factmoney q from GatheringTaxRecord where contactno ='"+code+"'";//order by room_no desc";
//设置查询结果的存放变量
int ID=0;
String CusNo="";
String CusName="";
String CusPhone="";
String TaxName="";
String Lofts="";
float TaxMoney=0;
String Order_Code="";
String Sectionname="";
String ajSection="";
float q=0;
 
 
   rs=ViewBean.executeQuery(sql);

 i=0;
 while (rs.next()){

  try{
     i=i+1;
  //按FIELDS顺序一GET　VALUE
   String id=rs.getString("id");
    
   TaxName=getbyte(rs.getString("TaxName"));
   TaxMoney=rs.getFloat("TaxMoney");
    state=rs.getString("state");
    q=rs.getFloat("q");
    %> 
    <tr class=listcontent id=TR2<%=i%>  align="left"  title="双击可登记代收费用"  onclick="changeclass1(this,'clickbg','listcontent');">
      <td  ><%=i%></td>
	  <td  ><%=TaxName%></td>
	  <td  ><%=TaxMoney%></td>
     
    </tr>
    <%
  }catch(Exception ex){out.println(ex.getMessage());}

}

  rs.close();
 sql="select sum(TaxMoney) TaxMoney,taxname_type from GatheringTaxRecord where contactno ='"+code+"' group by taxname_type";//order by room_no desc";
   rs=ViewBean.executeQuery(sql);
    taxprice=0;peitaoprice=0;
   while (rs.next()){
     if (rs.getBoolean("taxname_type"))taxprice=rs.getFloat("TaxMoney");
	 else peitaoprice=rs.getFloat("TaxMoney");
 }
 rs.close();
 %>
 <tr><td>税费合计：<%=Format.getFloat3(taxprice,2) %></td><td>配套合计：<%=Format.getFloat3(peitaoprice,2) %></td><td>合计：<%=Format.getFloat3(peitaoprice+taxprice,2) %></td></tr>

</table>
  <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1  ALIGN=center  >
<tr  class=TXTColor align="center"> <td>原交楼日期</td><td>现交楼日期</td><td>备注</td></tr>
  <%
    String jlSQL="SELECT * FROM JL_BAK WHERE CON_NO="+code;
     rs=ViewBean.executeQuery(jlSQL);
	 while (rs.next()){
   %>
  <tr align="center"><td><%=rs.getDate("old_jl").toString() %></td><td><%=rs.getDate("new_jl").toString() %></td><td><%=rs.getString("bak") %></td></tr>
  
  
  <%}rs.close(); %>
  </table>
  
<p align=center>
  <b><font size="3" color="#000080">代收(付)一览</font></b>
 </p>
  <table width="100%"  border="0" cellspacing="1"  cellpadding="1"  >
    <tr   class=TxtColor >
	 <td  >序号</td> 
      <td    >费用名称</td><td>金额</td> <td>收取日期</td> 
	  <td>票据编号</td> 
	  <td>代收人</td>
	  <td>代付日期</td>
	  <td>代付人</td>
	  
	
    </tr>
	
  
    <%
 
 sql="select * from factGatheringTaxRecord where contractno ='"+code+"'";//order by room_no desc";
 rs=ViewBean.executeQuery(sql);
 String JKdate="";
 i=0;
 float sumtax=0;
 boolean dscheck=false;
 while (rs.next()){

  try{
     i=i+1;
 
   String id=rs.getString("code");
   String taxname=rs.getString("taxname");
   TaxMoney= rs.getFloat("money") ;
   sumtax+=TaxMoney;
   JKdate=getbyte(rs.getString("date"));
   if (!JKdate.equals(""))JKdate=JKdate.substring(0,10);
   String no=getbyte(rs.getString("no"));
    String handler=getbyte(rs.getString("handler"));
	dscheck=rs.getBoolean("checkstate");
	int taxname_type=rs.getInt("taxname_type");
	String out_date=getbyte(rs.getString("out_date"));
	 if (!out_date.equals(""))out_date=out_date.substring(0,10);
	 String out_person=getbyte(rs.getString("out_person"));
    %> 
    <tr class=listcontent id=TR1<%=i%>  align="left"    onclick="changeclass1(this,'clickbg','listcontent');">
      <td  ><%=i%></td>
	   <td  ><%=taxname%></td>
	  <td  ><%=TaxMoney%></td>
	  <td  ><%=JKdate%></td>
      <td> <%=no %></td> 
	  <td> <%=handler %></td> 	
	    <td> <%=out_date %></td> 	
		  <td> <%=out_person %></td> 	
	   
     <td><% 
	 if (dscheck){
	   out.print("<font color=red>已审核</font>") ;}
	    %>
	</td>
    </tr>
    <%
  }catch(Exception ex){out.println(ex.getMessage());}

}
  rs.close();
 
 sql="select sum(money) TaxMoney,taxname_type from factGatheringTaxRecord where contractno ='"+code+"' group by taxname_type";//order by room_no desc";
   rs=ViewBean.executeQuery(sql);
   taxprice=0;
   peitaoprice=0;
   while (rs.next()){
     if (rs.getBoolean("taxname_type"))taxprice=rs.getDouble("TaxMoney");
	 else peitaoprice=rs.getDouble("TaxMoney");
 }
 rs.close();
 %>
 <tr><td colspan="2">税费合计：<%=Format.getFloat2(taxprice,2) %></td><td colspan="2">配套合计：<%=Format.getFloat2(peitaoprice,2) %></td><td colspan="2">合计：<%=Format.getFloat2(peitaoprice+taxprice,2) %></td></tr>

</table>
     
</center>
<script>

	 function dkcount(){
	   document.cus.sydk.value= document.cus.ajmoney.value;
		 }
	function dkcount1(){
	  // if (parseInt(document.cus.gjj.value)>0)
	     document.cus.sydk.value= parseInt(document.cus.ajmoney.value)-parseInt(document.cus.gjj.value);
		 }	 
	function dkcount2(){
	   if (parseInt(document.cus.sydk.value)>0)
	     document.cus.gjj.value= parseInt(document.cus.ajmoney.value)-parseInt(document.cus.sydk.value);
		 }	
function setpara(periodpass ,qianPass , shouldPass,ysid,ysdate,jk) {
    period = periodpass ;
    qianKuan = qianPass ;
    shouldmoney = shouldPass ;
	ysID=ysid;
	ysDate=ysdate;
	jkstate=jk;
	
}
function addpay(){
  
    var spa = 60 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa / 2 ;
    var lef = spa / 2 ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=" + 200 ;
    var posi = posi + ",width=" + 300 ;
    var newwink = window.open("../finance/GatherInput.jsp?CusNo=<%= cusno %>&contractno=<%= code %>&period=<%=i+1 %>&eDate=<%=gather_date %>&rate=<%=rate %>&curry=<%=curry %>&ysSumMoney=<%=ysSumMoney %>" , "NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
    newwink.focus();

}
function editpay(){
  
    var spa = 60 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa / 2 ;
    var lef = spa / 2 ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=" + 250 ;
    var posi = posi + ",width=" + 300 ;
    if (ysID!=""){
	
    var newwink = window.open("../finance/GatherModify1.jsp?ysID="+ysID+"&shouldmoney="+shouldmoney+"&ysDate="+ysDate+"&period="+period+"&jkstate="+jkstate+"&qianKuan="+qianKuan, "NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
    newwink.focus();
    }else{alert("请选中修改的数据");}
	}
function deletepay(){
    if (ysID!=""){
	  if (period<<%=i %>) {alert("只能删除最后一期付款,如果删除后数据不正确，可修改数据");return false;}
	  else{
  	   if (confirm("确认删除吗?")){
	    openwin2("../finance/deletePay.jsp?ysID="+ysID,10,10,10,10);
	    
		}
	  }	
	 }else{alert("请选中删除数据");} 
	 
}
function printrs(){
  window.open("../finance/printrs.jsp?code=<%=code %>");

}
function printtax(){
window.open("printtax.jsp?code=<%=code %>&section=<%=SecNo %>&loft=<%=Loft %>");


}
 function ykj_count(){

    document.cus.cjtnprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.area.value),<%=unitlen %>);
    document.cus.cjjzprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.jzarea.value),<%=unitlen %>);
   document.cus.Adicprice.value=document.cus.dicprice.value;
   
  document.cus.countdiscprice.value=document.cus.dicprice.value;
  document.cus.firstMoney.value=subs1(parseFloat(document.cus.dicprice.value)-parseInt(document.cus.ajmoney.value),<%=unitlen %>);


}

function cancelfsfc(){
 
   document.cus.sumprice.value=parseInt(document.cus.sumprice.value)-parseInt(document.cus.fsfcmoney.value);
   document.cus.fsfcmoney.value="0";
   
 
}	 

function chfsfc(para){
 
 if (para.checked){document.cus.sumprice.value=parseInt(document.cus.sumprice.value)+parseInt(document.cus.fsfcmoney.value);charges();}
 else{ document.cus.sumprice.value=parseInt(document.cus.sumprice.value)-parseInt(document.cus.fsfcmoney.value);charges();}
 
}	 
</script>
</form>
<%}catch(Exception s){  out.print(s.getMessage()+"请刷新销控表后，再点击刚才认购的房号,如果还是这样的，请联系管理员在系统管理中纠错处理。");out.close();} %>
</body>

</html>
