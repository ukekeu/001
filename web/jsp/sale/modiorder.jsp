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
<title>��������</title>
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
  //���ұ��շ�
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
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"QT021");
 //���ҿ�λ��
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
   
  //��ȡ��ͬ����
      sqlrg="select   o.rg_sumprice,o.gjj,o.gjjy,o.sydk,o.jl_bak,o.jldate, o.countType,o.gxr,o.code,o.serialno,o.ContractNo,o.Customer,o.sectionname as secname,o.building,";
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
	  sqlrg+=",ty_area,ty_area_price,ty_area_price*ty_area typrice,y_area,y_jzarea,o.wd_area,o.wd_area_price,o.wd_area_price*o.wd_area wdprice,memberno,membert,datediff(d,date,getdate()) c_day from  Order_Contract o,customer c   ";
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
		String rg_sumprice="0";
		String zs_first_money="0";
	   String youhuibeizhu="";
	   String checkperson="";
	   String checkDate="";
	   boolean checkstate=false,countType=false;
	   String memberno="";
	   boolean membert=false;
	   String tnunitprice="";
	   String rh="",rhn="";
	   int c_day=0;
	     String gjj="0",sydk="0",gjjy="0";
	   String room_price="",youhuiprice="",payment1="",lzp="";
     String room_price1="",yang_tai_area="",yong_tu="",lu_tai_area_price="",lu_tai_area="",lu="";
	 String ty_area="0",ty_area_price="0",typrice="0";
	 String wd_area="0",wd_area_price="0",wdprice="0";
	  while(rs3.next()){  
	    rg_sumprice=getbyte(rs3.getString("rg_sumprice"));
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
		//payment=payment.substring(0,payment.lastIndexOf("."))+"*"+payment.substring(payment.lastIndexOf(".")+1)+"*��";
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
		 //if (payment.indexOf("��")>=0)
	  
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
 		 //if (disc1.indexOf("*")>=0)
		  //disc1=disc1.substring(0,disc1.indexOf("*"));
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
		   //if (payment.indexOf("��")>=0)
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
		  c_day=rs3.getInt("c_day");
      	  }
		   
	  rs3.close(); 
	 //�ж��Ƿ�����������
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
 //��ȡ�ͻ���������
 String chargesSQL="SELECT sum(factmoney) as factmoney FROM FactGatheringRecord WHERE contractno='"+code+"' group by contractno ";
 ResultSet chargesRS=null;

 String factmoney="0";
 try{
  chargesRS=ViewBean.executeQuery(chargesSQL);
 if (chargesRS.next())factmoney=chargesRS.getString("factmoney");
 
 }catch(Exception s){}
chargesRS.close();

//���ɱ����������

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
		 alert("���Ϲ�����Ѿ�ʹ��");
		 
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
	alert("�˺�ͬ����Ѿ�ʹ��");
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
String Code="",gl_unitprice="0",gl_area="0";
String fsfc="",fsfcmoney="0",br="0",fsfcroom="";
String RoomSql="select Y_Area,Y_UsedArea ,gl_unitprice,gl_area,floor,Code,case when gl_tnprice>0 then  gl_tnarea+UsedArea else UsedArea end UsedArea,case when gl_unitprice>0 then  gl_area+Area else Area end    Area,Unitprice,TNunitprice,gl_area*gl_unitprice+Sumprice Sumprice,Fitment,RoomType,Room_Type,floor ";
RoomSql+=",gl_area*gl_unitprice+room_price room_price,yang_tai_area,yong_tu,lu_tai_area_price,lu_tai_area,lu_tai_area*lu_tai_area_price lu from room";
RoomSql+=" where seccode='"+SecNo+"' and loft='"+Loft+"' and building='";
RoomSql+=Build+"' and room_code='"+RoomNo+"' and Floor="+Floor;

double checksumprice=0;
try{
  rs=ViewBean.executeQuery(RoomSql);
  if (rs.next())  {
   gl_unitprice=rs.getString("gl_unitprice");
    gl_area=rs.getString("gl_area");
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
  String fsfccode="";
   rs=ViewBean.executeQuery("select b.yong_tu,b.unitprice,b.area,a.roomcode,a.br,b.sumprice,b.room_code from fsfc a,room b where a.roomcode=b.code and a.order_contract="+code);
   while (rs.next())  {
      String fsyong_tu=getbyte(rs.getString("yong_tu"));
	  String fsunitprice=getbyte(rs.getString("unitprice"));
	  String fsarea=getbyte(rs.getString("area"));
     if (fsfc.equals(""))
       fsfc=getbyte(rs.getString("roomcode"));
	 
	 else
	    fsfc+=","+getbyte(rs.getString("roomcode"));  
     if (fsfcroom.equals(""))		
	    fsfcroom=fsyong_tu+getbyte(rs.getString("room_code"))+"("+fsarea+"M<sup>2</sup>,"+fsunitprice+"Ԫ/M<sup>2</sup>,";
	 else
	     fsfcroom+="<br>"+fsyong_tu+getbyte(rs.getString("room_code"))+"("+fsarea+"M<sup>2</sup>,"+fsunitprice+"Ԫ/M<sup>2</sup>,";
	
	fsfcm+= rs.getDouble("sumprice");
	fsfcroom+=rs.getString("sumprice")+"Ԫ)";
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
 String sel=(String)request.getParameter("sel");
    if(sel==null) sel="1";	
 %>

 <body <%if (sel.equals("1")){ %> onload="fullData();" <%} %> topmargin="0"  >


<form method="POST" name="cus" action="ModiContract.jsp"> 
<input type="hidden" value="<%=code %>" name="code">
<input type=hidden name=change>
<input type=hidden name=context>
<input type=hidden name=checker>
<input type=hidden name=discSQL value="">
<input type=hidden name=oldajmoney value="<%=ajmoney %>">
<input type=hidden name=oldpay value="<%=payment %>">
<input type=hidden name=oldsalprice value="<%=salprice %>">
<input type=hidden name=url value="ModiContract.jsp">
<input type=hidden name=oldRoom value="<%=getbyte2(request.getParameter("roomno")) %>">
 <input type=hidden name="oldFloor" readonly value="<%=request.getParameter("Floor") %>">
<input type=hidden name=hiarea value="<%=SaleArea%>">
<input type=hidden name=olddate value="<%=SaleArea%>">
  <input type=hidden name=floor value="<%=floors%>">
   <input type=hidden name=Floor value="<%=floors%>"> 
<input type=hidden name=hisumprice value="<%=salprice%>">
<input type=hidden name=secno value="<%=secno%>">
 <input type=hidden name="sectio" readonly value="<%=getbyte2(request.getParameter("secname")) %>" size="10"  >
         <input type=hidden name="oldsectio" readonly value="<%=getbyte2(request.getParameter("secname")) %>" size="10"  >
       
	    <input type=hidden name="section"  value="<%=getbyte2(request.getParameter("secno")) %>" size="10"  >
           <input type=hidden name="oldsection"  value="<%=getbyte2(request.getParameter("secno")) %>" size="10"  >
   
	    <input type=hidden name="roomno" readonly value="<%=getbyte2(request.getParameter("roomno")) %>" size="15"   onChange="toUpper(document.cus.roomno)">
        <input type="hidden" name="loft" readonly="readonly" size="15" value="<%=getbyte2(request.getParameter("loft")) %>">
		<input type="hidden" name="oldloft" readonly="readonly" size="15" value="<%=getbyte2(request.getParameter("loft")) %>">
		<input type=hidden name="oldbuild" readonly value="<%=getbyte2(request.getParameter("build")) %>"   size="15"   onChange="toUpper(document.cus.build)">
    	
		<input type=hidden name="build" readonly value="<%=getbyte2(request.getParameter("build")) %>"   size="15"   onChange="toUpper(document.cus.build)">
    	<INPUT TYPE=hidden NAME=Date2 value="<%=request.getParameter("jldate") %>" size=10 readonly title="��ѡ���Ϲ�����" onkeydown="key(document.cus.pay)">
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
 
<table width="180" border="0" cellspacing="0" cellpadding="0" class="L2" >
  
<tr  valign="top">
    <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	  <a href="#" onclick="document.cus.sel.value=1;findSub('modiorder.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>��ͬ����</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.cus.sel.value=2;findSub('modiorder.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�������</font></a>
	</td>
	 <script>
	   function findSub(para){   
         document.cus.action=para;
         document.cus.submit();
      }
	  </script>
<input type=hidden name=contractno value="<%=code%>">
<input type=hidden name=sel value="<%=sel%>">
</table>
<%if (sel.equals("1")){ %>
 
    <table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#ffffff" class="tablefill">
   <tr> 
      <td colspan="8" align="center"> 
	  
	  <%if (Cortrol.indexOf("A")>=0 ){ 
	    if (StrJzDate.equals("")){
	  %>
	  
	   <%}else{out.println("<font color=red>�˷��ѱ���</font>");} %>
	   
	  <%} 
	  if (!zmbak.equals("")){%>
	   <input type=button name=zmrecord  onclick="openwin('zm_list.jsp?htno=<%=code %>',450,300,100,100);" value="�鿴ת����¼"> 
	   <%} %>
	  </td>
    </tr>
	</table>	
     <table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif">��<img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>��������</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"><font color="#FF6600">&nbsp;</font></td>
</tr>
</table>	
 <table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#ffffff" class="tablefill">
 
      <td width="12%" align=left class=roomleft>&nbsp;¥������</td>
      <td width="19%" align=left class=roomright><div id="idname"><%=getbyte2(request.getParameter("secname")) %></div> 
      
	  </td>
      <td width="15%" align=left class=roomleft>&nbsp;��&nbsp;��&nbsp;��&nbsp;</td>
      <td   align=left class=roomright width="20%"><div id="idroomno"><%=getbyte2(request.getParameter("loft")) %><%=getbyte2(request.getParameter("build")) %><%=getbyte2(request.getParameter("roomno")) %></div></td>
      <td   align=left class=roomleft width="12%">&nbsp;��¥����</td>
      <td width="19%" class=roomright align=left><%=JLdate.substring(0,10) %> 
        ��</td>
    </tr>
	  
      
    <tr> 
      <td width="15%" align=left class=roomleft>&nbsp;�������</td>
      <td width="19%" align=left class=roomright><div id="idjzarea"><%=area1 %></div></td>
      <td width="15%" align=left class=roomleft>&nbsp;���ڽ������</td>
      <td   align=left class=roomright width="20%"><div id="idusearea"><%=area%></div></td>
      <td   align=left class=roomleft width="12%">&nbsp;���ڽ���<br>&nbsp;�������</td>
      <td width="19%" class=roomright align=left><div id="idunitprice"><%=UserUnitPrice%></div></td>
    </tr>
  <%if (y_tnarea>0){ %>
   <tr> 
      <td width="15%" align=left class=roomleft>&nbsp;��ʵ�������</td>
      <td width="19%" align=left class=roomright>&nbsp;<%=y_jzarea %></td>
      <td width="15%" align=left class=roomleft>&nbsp;��ʵ�������</td>
      <td   align=left class=roomright width="20%">&nbsp;<%=y_tnarea%></td>
      <td   align=left class=roomleft width="12%"></td>
      <td width="19%" class=roomright align=left></td>
    </tr>
  <%} %>
	 <tr> 
      <td width="15%" align=left class=roomleft>&nbsp;�����������</td>
      <td width="19%" align=left class=roomright><div id="idsaleunitprice"><%=SaleUnitPrice%></div></td>
      <td width="15%" align=left class=roomleft>&nbsp;Ԥ���ܼ�</td>
      <td   align=left class=roomright width="20%"><div id="idsumprice"><%=SaleSumPrice %></div></td>
      <td   align=left class=roomleft width="12%">&nbsp;�����ܼ�</td>
      <td width="19%" class=roomright align=left><div id="idsumprice1"><%=room_price1 %></div></td>
    </tr>
	<!--
	<tr> 
      <td width="15%" align=left class=roomleft>&nbsp;��԰/¶̨���</td>
      <td width="19%" align=left class=roomright>&nbsp;<%=lu_tai_area%></td>
      <td width="15%" align=left class=roomleft>&nbsp;��԰/¶̨����</td>
      <td   align=left class=roomright width="20%">&nbsp;<%=lu_tai_area_price %></td>
      <td   align=left class=roomleft width="12%">&nbsp;��̨���</td>
      <td width="19%" class=roomright align=left>&nbsp;<%=yang_tai_area %> ��</td>
    </tr>-->
	 <tr> 
      <td width="15%" align=left class=roomleft>&nbsp;��;</td>
      <td width="19%" align=left   class=roomright><div id="idyong_tu1"><%=yong_tu%></div></td>
         <td width="15%" align=left class=roomleft>&nbsp;��¥���</td>
      <td width="19%" align=left class=roomright>&nbsp;<%=gl_area%></td>
	  <td width="15%" align=left class=roomleft>&nbsp;��¥����</td>
      <td width="19%" align=left class=roomright>&nbsp;<%=gl_unitprice%></td>
    </tr>
	<tr> 
        <input type=hidden name="checkefsfcmoney"  value="<%=fsfcroom %>">
      <td   align=left class=roomleft width="20%">&nbsp;��������<input type=hidden name="fsfcmoney"  value="<%=fsfcmoney %>"></td>
      <td   align=left  colspan="5"  class=roomright width="12%"><div id="idfsfc"><%=fsfcroom %><%if (!fsfcroom.equals("")){out.print("("+fsfcmoney+")");} %></div> <input type=hidden name="fsfc" size=8 readonly  value="<%=fsfc %>"><%if (fsfc.equals("")){ %><INPUT TYPE="button"  NAME=xzfcfs value="���" title="��ӿͻ�����ĸ�������" onclick="document.cus.br.checked=false;openwin2('RoomCodeShowFS.jsp?SecNo=<%=SecNo %>&Loft=<%=Loft %>&SecName=<%=getbyte2(request.getParameter("secname")) %>',800,400,50,50);"><%}else{ %>&nbsp;<INPUT TYPE="button"  NAME=xzfcfs value="ȡ��" title="ȡ���ͻ�����ĸ�������" onclick="if (confirm('ȷ��ȡ����?')){cancelfsfc();document.cus.fsfc.value='';openwin2('cancelFsfc.jsp?br=<%=br %>&code=<%=code %>&fsfccode=<%=fsfc %>',100,100,50,50);}"><%} %><input type=checkbox name=br value=1 <%if (br.equals("1")){out.print("checked");} %> onclick="chfsfc(this);">���뷿��</td>
   
    </tr>
 <tr><td colspan="6">
  <table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif">��<img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>�ͻ�����</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"></td>
</tr>
</table>	
 
 </td></tr>
   

 
     <tr> 
      <input type=hidden name="cusname" value="<%=cusno %>">
      <td width="16%" class=roomleft >&nbsp;�ͻ�����</td>
     <input type=hidden name="cusname2" value="<%=cusname %>">
      <td colspan="5" class=roomright>&nbsp;<input type=text   name="cusname1"  size=60 onchange="aa();" value="<%=cusname %>"  onkeydown="key(document.cus.carid)" title="����������������'/'�ָ�">
<script>
  function aa(){
    var aa=document.cus.cusname1.value;
    var aa1=document.cus.cusname2.value;
    if (aa!=aa1){
       if (confirm("���ѱ���˿ͻ���������¼�����ԭ��"))
         { document.cus.editnow.value="2";
		  document.all.T.style.display=(document.cus.editnow.value=='2')?'block':'none';
		  document.cus.zmyy.readOnly=false;
		   document.cus.zmyy.focus();}
       else{
          document.cus.editnow.value="1";
		  document.all.T.style.display=(document.cus.editnow.value=='2')?'block':'none';       
           document.cus.zmyy.readOnly=true;
		   }
     }else{
    document.cus.editnow.value="1";
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
      
<input type=hidden name="editnow"  �� value="1"><input type=button name=FindB  value="����" onclick="xiangqing();"> 
    </tr>
	
	 <tr> 
	 <td colspan="6">
	 <div id="T" style="display:none">
	 <table width="100%">
	  
      <td width="16%" class=roomleft>&nbsp;ת��ԭ��</td>
      <td class=roomright >&nbsp;<input type=text  readonly name="zmyy"  size=50 >
	  <INPUT TYPE="text"  NAME=zmdate   size=10 readonly title="��ѡ��ת������"    ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(zmdate);" title="��ѡ������">
        ��</td>
		
		</table>
		
		</td>
    </tr>
	
    <tr> 
      <td width="16%" class=roomleft>&nbsp;֤����</td>
      <td class=roomright colspan="5">&nbsp;<input type=text  name="carid"  size=60  value="<%=ID_Card %>"  onchange="countAge();" onkeydown="key(document.cus.tel)">
        ��</td>
    </tr><input type=hidden name=age>
    <tr> 
      <td width="16%" class=roomleft>&nbsp;��ϵ�绰</td>
      <td class=roomright colspan="5" >&nbsp;<input type=text  name="tel"  size=30   value="<%=Phone %>" onKeyDown="key(document.cus.sj)"> �ֻ�&nbsp;<input type=text  name="sj"  size=23  value="<%=sj %>" onKeyDown="key(document.cus.Address)">
        ��</td>
    </tr>
    <tr> 
      <td width="16%" class=roomleft>&nbsp;��ϵ��ַ</td>
      <td class=roomright colspan="5">&nbsp;<input type=text  name="Address"  size=46  value="<%=Address %>" onKeyDown="key(document.cus.zip)"> �ʱ�&nbsp;<input type=text  name="zip"  size=7  value="<%=Zip_Code %>" onKeyDown="key(document.cus.custype)">
      </td>
    </tr>
    
	<tr> 
      <td class=roomleft>&nbsp;�Ƿ�ҵ������ </td>
      <td class=roomright colspan="5">&nbsp;<input type=checkbox name=memberT onKeyDown="key(document.cus.youhui)" value=1  <%if (membert){out.print("checked");} %>  ><input type=text name=memberNO  readonly value="<%=memberno %>" maxlength="50"><input type=button name=FindC  value="����" onclick="FindOption1();"> 
	  </td>
	  </tr>
    <tr> 
      <td class=roomleft>&nbsp;�Ż����� </td>
      <td class=roomright colspan="5">&nbsp;<input type=text name=youhui onKeyDown="key(document.cus.custype)" size=46 value="<%=yh_zs %>"> 
        <select name=largees OnChange="chang();">
          <%
	    String StrSql="select type,codename from CODE where type='S' and child=0 order by type";
     ResultSet codeRS=null;
    
    codeRS=ViewBean.executeQuery(StrSql);
   %>
          <%out.print("<option>��ѡ����Ʒ</option>");
		   while (codeRS.next()){
			 out.print("<option>"+getbyte(codeRS.getString("codename"))+"</option>");
		   }
		   codeRS.close();
				%>
        </select> </td>
    </tr>
    <tr> 
      <td width="16%" class=roomleft >&nbsp;�ͻ�����</td>
      <td  class=roomright colspan="5">&nbsp;<select name=custype onKeyDown="key(document.cus.note)" >
          <option value=����>����</option>
          <option value=��ҵ>��ҵ</option>
        </select>  &nbsp;<select name=rh><option value=0>���뻧</option>
   <option value=1>��Ҫ�뻧</option>
        </select> &nbsp;�뻧��:<input type=text  size=7 value="<%=rhn %>" name=rhn>&nbsp; 
        
        <input type=hidden name=demurrage value=0> </tr>
    <tr> 
     <td width="16%"     class=roomleft>&nbsp;��&nbsp;ע</td>
      <td  class=roomright colspan="5">&nbsp;<textarea rows="3" name="note" onKeyDown="key(document.cus.listlar)" cols="35"  ><%=note %></textarea> &nbsp;&nbsp;����Ա&nbsp; <select name="seller"  multiple size=3  onblur="SelectedSeller();" style="width:100">
          <option value="<%=seller %>" selected><%=seller %></option>
          <option ></option>
          <option ></option>
          <option ></option>
          <option ></option>
        </select> <input type=button name=listlar value="<<" onclick="list1();" title="��������Ա"> 
        <input type=button name=rem value=">>" onclick="remo();"  title="ɾ������Ա"> 
        
      </td>
    </tr>
  
 <tr><td colspan="6">
  <table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif">��<img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>�Ϲ�����</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"></td>
</tr>
</table>	
 
 </td></tr>

      
    <tr> 
      <td width="12%" class=roomleft>&nbsp;�Ϲ����</td>
   <td width="12%" class=roomright>&nbsp;<input type=text name="rgsno" value="<%=rgno %>"  size="10"   onChange="toUpper(document.cus.rgsno)" onKeyDown="key(document.cus.cale1)" onBlur="checkedOrderNoExist();" title="ֻ����Ӣ����ĸ�����ּ�"-"���"></td>
 
      <td width="19%" class=roomleft>&nbsp;�Ϲ�����</td>
      <td width="19%" class=roomright>&nbsp;<input type=TEXT name=Date1 size=10 title="��ѡ���Ϲ�����"  value="<%=date.substring(0,10) %>" readonly onchange="key(document.cus.pay);" onKeyDown="key(document.cus.VisaDate)">
        <input type=button name=cale1 value=".." onClick="fPopUpCalendarDlg(Date1);return false;" title="��ѡ���Ϲ�����">
       </td>
	  
      <td width="15%" class=roomleft>&nbsp;���ʽ</td>
      <td width="23%" class=roomright>&nbsp;<select name="pay"      style="width : 150" onKeyDown="key(document.cus.VisaDate)" onChange="charges();changeFirstMoney();"><!--onChange="charges();"-->
    <%if (payment.indexOf(".")<0)payment=payment+".";%>     
     <option value=""></option>
                 <%
     String sql="select * from PayMent where seccoe='"+SecNo+"'";
       rs3=ViewBean.executeQuery(sql);
	  String pay="";
	  String dic;
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
		if (!gddate.equals(""))gddate=gddate.substring(0,10);
		String dic1=String.valueOf(dic);
	   	out.print("<option value='"+pay+"-"+dic1+"-"+dj1+"|"+num+"#"+qdate+"."+ajdate+"g"+gddate+"'>"+pay+"."+num+"��*"+dic+"��"+"</option>");
	   }
	  
	    rs3.close();
     %>
        </select> 
        <input type=hidden name=dis size=6 readonly value="<%=disc1 %>">
		<input type=hidden name=rg_sumprice size=6 readonly value="<%=rg_sumprice %>">
        </td>
    </tr>
	<%if (Cortrol.indexOf("K")>=0){  %>
	
	<input type="hidden" name="ewyh" size=10  onchange="check(this);count5();"  onkeydown="key(document.cus.curry);">
	<input  type=hidden name=abcd  onchange="count3();" size=8 title="�����ʽ��98*95*95" onkeydown="key(document.cus.curry);">
	 
    <tr> 
	    <td width="19%"  colspan="5"> 
	  <%String discSQL="SELECT * FROM  contract_disc  WHERE  disc_type<>'�����ۿ�'  and   order_no='"+SecNo+Loft+RoomNo+"' order by state desc";
	             rs=ViewBean.executeQuery(discSQL);
			 String yy="";	 
			  while (rs.next()){
			    String dis=rs.getString("disc");
				float yh=rs.getFloat("youhui");
			    String obj=rs.getString("discObj");
				if (yh==0)yy+=" ��"+obj+rs.getString("disc")+"��";
				else yy+=" ��"+obj+"�Ż�"+rs.getString("youhui")+"Ԫ";
				}rs.close();
			  
			   %>
	  <a href="#12" onclick="document.all.discreco.style.display=(document.all.discreco.style.display=='none')?'block':'none';" title="�����ʾ��ϸ���Żݼ�¼"><font color=red><div id=yhview>�� ��:<%=yy %></div></font></a>
	</td> <td width="19%">  <a href="#"   onclick="openwin3('disc.jsp?code=<%=SecNo+Loft+RoomNo %>&discPrice=<%=room_price %>&discUnit=<%=saleJzPrice %>',700,400,100,100);"">����Ż�</a> <br>
	   </td></tr>
	  <tr><td colspan="6"> 
	  <div id="discreco" style="display:none">
	   <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
	  <tr bgcolor="#c0c0c0" align="center"><td>�ۿ�����</td><td>����</td><td>�Ż�</td><td>�ۿ�</td><td>�������</td><td>��ǰ�ܼ�</td><td>��ǰ����</td><td>��ϵ��</td><td>�����</td></tr>
	 <%
	     discSQL="SELECT * FROM  contract_disc  WHERE  disc_type<>'�����ۿ�'  and  order_no='"+SecNo+Loft+RoomNo+"' order by state desc";
	             rs=ViewBean.executeQuery(discSQL);
				 int aaa12=0;
			  while (rs.next()){ 		aaa12++;	   
	  %>
	   <tr id=A<%=aaa12 %> align="center"  onmouseover="mout(this) ;changeclass1(this,'clickbg','#ffffff');" title="�ۿ۱�ע:<%=rs.getString("disc_bak") %>"><td><%=rs.getString("disc_type")  %></td><td><%=rs.getDate("disc_date").toString() %></td>
	   
	   <td><%=rs.getString("youhui") %></td><td><%=rs.getString("disc") %></td><td><%=rs.getString("discObj") %></td>
	   <td><%=rs.getString("discPrice") %></td><td><%=rs.getString("discUnit") %></td><td><%=rs.getString("gxr") %></td><td><%=rs.getString("checker") %></td>
	     </tr>
	   <%}rs.close(); %>
	  </table>
	  </div>
	  </td>
    
 </tr>
 <%}  %>
	 
<%String oldajcs="";
       try{  if (payment.indexOf("(")>0)oldajcs=payment.substring(payment.indexOf("(")+1,payment.indexOf("%"));
	   }catch(Exception s){}
      %>
<input type="hidden" name=oldajcs size=3 value=<%=oldajcs %>>
   <tr><td class=roomleft>&nbsp;��������</td>
	    <td width="18%" class=roomright>&nbsp;<select name=ajbk   style="width : 80">
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
		<td class=roomleft>&nbsp;���������</td>
		<td class=roomright>&nbsp;<input type=text name=gjj size=10 onKeyDown="key(document.cus.gjjy);" value="<%=gjj %>"  Onblur="check(this);dkcount1();">(Ԫ)</td>
		 <td width="12%" class=roomleft >&nbsp;��������</td> 
      <td width="15%"    class=roomright  >&nbsp;<select name=gjjy  onKeyDown="key(document.cus.sydk)"   onchange="count();"  style="width : 80" >
          <option></option>
		  <option value=0.5>0.5��</option>
          <%for (int i=1;i<=30;i++){
		out.print("<option value="+String.valueOf(i)+">"+String.valueOf(i)+"��</option>");
		} %>
        </select></td>
	   </tr>
    <tr>
	 <td width="15%" class=roomleft>&nbsp;�� �� ��</td>
        <td width="19%" class=roomright  >&nbsp;<input  type=text size=10  value="<%=ajmoney %>"     name=ajmoney onblur="check(this);countAj();changeFirstMoney();" onChange="dkcount1();">(Ԫ)��</td>
   <td class=roomleft>&nbsp;��ҵ  ����</td>
		<td class=roomright>&nbsp;<input type=text name=sydk size=10  onKeyDown="key(document.cus.ajyr)" value="<%=sydk %>" OnBlur="check(this);dkcount2();">(Ԫ)</td>
      <td width="12%" class=roomleft >&nbsp;��������</td><input type=hidden name=oldajcs size=4>
      <td width="15%"    class=roomright  >&nbsp;<select name=ajyr      onchange="count();"  style="width : 80" ><!--onblur="bxRate();"-->
          <option></option>
		  <option value=0.5>0.5��</option>
          <%for (int i=1;i<=30;i++){
		out.print("<option value="+String.valueOf(i)+">"+String.valueOf(i)+"��</option>");
		} %>
        </select></td>
		  </tr>
<input type="hidden" name=ajcs size=3 value=<%=ajcs %>>
     
	<input type=hidden name=yukuan value=0>
     
       <input type=hidden name=oldprice value="<%=firstmoney %>">
    
       <input type=hidden name="oldfirstMoney"     size="10" value="<%=firstmoney %>"> 
   
 <tr>
<td width="19%" class=roomleft >&nbsp;�ɽ�����</td>
      <td width="19%"    class=roomright  >&nbsp;�Զ���Ϊ׼:<input type=checkbox name=bz <%if (Cortrol.indexOf("C")<0){ %> title="�����Ȩ" disabled <%} %>  value=1 <%if (countType){ %> checked <%} %>onclick="checkcount();"></td><td><input type=text name="dicprice" value="<%=room_price %>"  defaultValue="<%=youhuiprice %>" size="10" onblur="check(this);ykj_count();changeFirstMoney();"     <%if (countType||Cortrol.indexOf("C")==-1){ %>   readonly <%} %> >Ԫ
   <input type=hidden name="countdiscprice" value="<%=room_price %>">
        <input type=hidden value=0 readonly name="MonthMoney"     size="10"  >
		<td width="23%" class=roomright  >&nbsp;<select name="curry" style="width : 40" OnChange="CurrRa();">
         <option value="RMB">RMB</option>
          <option value="HKD">HKD</option>
          <option value="USD">USD</option>
        </select><input type=text name="rate"  value=1.0  size="4" title="����" >
      </td>
	   <td width="19%" class=roomleft>&nbsp;��&nbsp;��&nbsp;��</td>
      <td width="19%" class=roomright  >&nbsp;<input  type=text size=10  value="<%=firstmoney%>" name=firstMoney   onblur="check(this);countsq();dkcount1();" onchange="changeFirstMoney();">
        (Ԫ)��</td>
     
  <input type=hidden name="Adicprice"     size="10" value="<%=salprice %>" onkeydown="key(document.cus.cjjzprice);"> 
      
    </tr>
    <tr>
      <td width="12%" class=roomleft >&nbsp;�ɽ�����<br>&nbsp;�������</td>
      <td width="12%" class=roomright >&nbsp;<input type=text name="cjjzprice"   value="<%=saleJzPrice %>" size=10 onblur="document.cus.dicprice.value=subs1(parseFloat(this.value)*parseFloat(document.cus.jzarea.value),<%=sumlen %>);document.cus.cjtnprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.area.value),<%=unitlen %>);ykj_count();"></td>
      <td width="19%" class=roomleft >&nbsp;�ɽ����ڽ�<br>&nbsp;���������</td>
      <td width="19%"    class=roomright>&nbsp;<input type=text name="cjtnprice" readonly  value="<%=saleUsePrice %>" size=10> Ԫ��</td>
       <td width="15%" class=roomleft>&nbsp;�Ϲ�����</td>
      <td width="23%" class=roomright  >&nbsp;<input type=text value="<%=dj %>" name="earnest"  onblur="check(this);"   size="10" title="�����д0����ʾ�����ʽ��ʽΪ׼" ><br>(0��ʾ�����ʽΪ׼)
    </td>     
    </tr>
		 <input type=hidden size=10 value=0  name="firstmoney" value=<%=zs_first_money %> onchange="sendfirst(this);">
	<input type=hidden size=10 name="factprice" readonly value=<%=factprice %>>
	<input type=hidden name="sjcjjzprice" size=10  readonly  value="<%=sjsaleJzPrice %>" >
	<input type=hidden name="sjcjtnprice" size=8 readonly  value="<%=sjsaleUsePrice %>">
	<tr>
	 <td width="19%" class=roomleft >&nbsp;�Ƽ۷�ʽ</td>
      <td width="19%" class=roomright >&nbsp;<select name="counttype" style="width : 80">
          <option value="0">�������</option>
          <option value="1">�������</option>
        </select></td> 
	 
	 <td width="19%" class=roomleft >&nbsp;��ͬ���</td>
      <td width="19%" class=roomright >&nbsp;<select name="httype" style="width : 80"><option value=0 <%if (httype.equals("0")){out.print("selected");} %>>����</option><option value=1  <%if (httype.equals("1")){out.print("selected");} %>>����</option></select></td>  
   
		<td width="15%" class=roomleft>&nbsp;</td>
      <td width="23%" class=roomright  >
        ����</td>
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
      <td width="12%" class=roomleft >&nbsp;¶̨���</td>
      <td width="12%" class=roomright >&nbsp;<input type=text  onchange="countlutai();" name="lutai_area" size=10 value="<%=lu_tai_area %>"  ></td>
      <td width="19%" class=roomleft >&nbsp;¶̨����</td>
      <td width="19%" class=roomright >&nbsp;<input type=text onblur="countlutai();" name="lutai_area_price" size=8  value="<%=lu_tai_area_price %>"  > Ԫ/M<sup>2</sup>��</td> 
	   <td width="19%" class=roomleft >&nbsp;¶̨�ܼ�</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="tai_area_sumprice" size=8 readonly  value="<%=lzp %>" > Ԫ</td>  </tr>
  
	   </tr>
	    <tr>
      <td width="12%" class=roomleft >&nbsp;��԰���</td>
      <td width="12%" class=roomright >&nbsp;<input type=text name="ty_area" onchange="countty();"  size=10 value="<%=ty_area %>"  ></td>
      <td width="19%" class=roomleft >&nbsp;��԰����</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="ty_area_price" size=8   onblur="countty();" value="<%=ty_area_price %>"  > Ԫ/M<sup>2</sup>��</td> 
	   <td width="19%" class=roomleft >&nbsp;��԰�ܼ�</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="ty_area_sumprice" size=8 readonly  value="<%=typrice %>" > Ԫ</td>  </tr>
  
	   </tr>
	    <tr>
      <td width="12%" class=roomleft >&nbsp;�������</td>
      <td width="12%" class=roomright >&nbsp;<input type=text name="wd_area" onchange="countwd();"  size=10 value="<%=wd_area %>"  ></td>
      <td width="19%" class=roomleft >&nbsp;���浥��</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="wd_area_price" size=8   onblur="countwd();" value="<%=wd_area_price %>"  > Ԫ/M<sup>2</sup>��</td> 
	   <td width="19%" class=roomleft >&nbsp;�����ܼ�</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="wd_area_sumprice" size=8 readonly  value="<%=wdprice %>" > Ԫ</td>  </tr>
  
	   </tr>-->
 
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
	   <!--
	    <table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif">��<img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>��ͬ����</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"><font color="#FF6600">&nbsp;</font></td>
</tr>
</table>	
    
    <tr > 
      <td width="16%"  class=roomleft>�ѽ����ڿ�</td>
      <td width="18%"  class=roomright>&nbsp;<input type=text size=12 value="<%=factmoney %>"><input type=hidden name="firstFT" value="1" style="width : 105"></td>
      <td width="16%"  class=roomleft>��ͬ���</td>
      <td width="18%"  class=roomright>&nbsp;<input type="text"   name="constractno" value="<%=ContractNo %>"    size="10"    onBlur="checkedOrderNoExist1();"   OnChange="toUpper(document.cus.constractno)" onkeydown="key(document.cus.QYDate)" ><input type=button name=adc value=".." title="ѡ���ͬ��" onclick="openwin('ContractNoList.jsp?SecNo=<%=secno %>',200,350,100,100);"></td>
      <td width="14%"  class=roomleft>ǩԼ����
      </td> 
      <td width="18%"  class=roomright>&nbsp;<INPUT TYPE="text"  NAME=QYDate value="<%if (state.equals("2"))out.println(VisaDate.substring(0,10)); %>" size=10 readonly title="��ѡ��ǩԼ����"   onkeydown="key(document.cus.kkrate)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(QYDate);" title="��ѡ��ǩԼ����"></td>
    </tr>
	   <tr > 
	   <INPUT TYPE="hidden"  NAME=oldjldate value="<%=jldate %>"  >
      <td width="16%"  class=roomleft>��¥����</td>
      <td width="18%"  class=roomright>&nbsp;<INPUT TYPE="text"  NAME=jldate value="<%=jldate %>" size=10 readonly title="��ѡ��¥����"    ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(jldate);" title="��ѡ���Ϲ�����"></td>
      <td width="16%"  class=roomleft>��¥��ע</td>
      <td width="18%"  class=roomright colspan="3">&nbsp;<textarea cols="43" rows="2" name="jlbak"><%=jlbak %></textarea></td>
    </tr>
	<INPUT TYPE="hidden" name="G_jzarea"  value="<%=area %>" size="12"  ya="<%=UseArea %>">
	<input type="hidden" name="G_unitprice" onblur="gzcount();" size="12" value="<%=gaizhang_unitprice %>"   onblur="checkedOrderNoExist(this.value);" onkeydown="key(document.cus.QYDate)" title="ֻ����Ӣ����ĸ�����ּ�"-"���">
	<INPUT TYPE="hidden"  NAME=G_sumprice size=10  value="<%=g_sumprice %>"  readonly  >
	-->
	<!--
	  <tr > 
      <td width="16%"  class=roomleft>��װ���</td>
      <td width="18%"  class=roomright>&nbsp;<INPUT TYPE="text" name="G_jzarea"  value="<%=area %>" size="12"  ya="<%=UseArea %>"></td>
      <td width="16%"  class=roomleft>��װ����</td>
      <td width="18%"  class=roomright>&nbsp;<input type="text" name="G_unitprice" onblur="gzcount();" size="12" value="<%=gaizhang_unitprice %>"   onblur="checkedOrderNoExist(this.value);" onkeydown="key(document.cus.QYDate)" title="ֻ����Ӣ����ĸ�����ּ�"-"���"></td>
      <td width="14%"  class=roomleft>��װ�ܿ�</td>
      <td width="18%"  class=roomright>&nbsp;<INPUT TYPE="text"  NAME=G_sumprice size=10  value="<%=g_sumprice %>"  readonly  > </td>
    </tr>
	-->
	<INPUT TYPE="hidden" name="G_jzarea"  value="<%=area %>" size="12"  ya="<%=UseArea %>">
	<input type="hidden" name="G_unitprice" onblur="gzcount();" size="12" value="<%=gaizhang_unitprice %>"   onblur="checkedOrderNoExist(this.value);" onkeydown="key(document.cus.QYDate)" title="ֻ����Ӣ����ĸ�����ּ�"-"���">
	<INPUT TYPE="hidden"  NAME=G_sumprice size=10  value="<%=g_sumprice %>"  readonly  >
	
	 <input type="hidden"   name="constractno" value="<%=ContractNo %>" >
	 <input type="hidden" name="QYDate" value="<%if (state.equals("2"))out.println(VisaDate.substring(0,10)); %>">
	 <input type="hidden" value="<%if (!StrAjDate.equals("")&&Integer.parseInt(StrAjDate.substring(0,4))>=2000)out.println(StrAjDate.substring(0,10)); %>"  NAME=ajDate >
	 <input type="hidden"  value="<%if (!StrFkDate.equals("")&&Integer.parseInt(StrFkDate.substring(0,4))>=2000)out.println(StrFkDate.substring(0,10)); %>"  NAME=fkDate >
	 <input type="hidden" name="qydate" value="<%=qytxdate %>">
	 <input type="hidden" name="gddate" >
	 <input type=hidden name=ajc value=".." onclick="fPopUpCalendarDlg(fkDate);" title="��ѡ��ſ�����">
	 <input type=hidden name=fkc value=".." onclick="fPopUpCalendarDlg(fkDate);" title="��ѡ��ſ�����">
  <input type="hidden" name="jldate"  value="<%=jldate %>">
    <INPUT TYPE="hidden"  NAME=oldjldate value="<%=jldate %>"  >
	 
	<input type=hidden name="firstFT" value="1" style="width : 105">
  <!--  <tr bordercolor="#FFFFFF"> 
     
      <td width="14%" class=roomleft>��������</td>
      <td width="18%" class=roomright>&nbsp;<INPUT TYPE="text" value="<%if (!StrAjDate.equals("")&&Integer.parseInt(StrAjDate.substring(0,4))>=2000)out.println(StrAjDate.substring(0,10)); %>"  NAME=ajDate size=10  onkeydown="key(document.cus.ajDate)"><input type=button name=ajc value=".." onclick="fPopUpCalendarDlg(ajDate);return false;" title="��ѡ�񰴽�����"></td>
      <td width="16%" class=roomleft>���зſ�����</td>
      <td width="18%" class=roomright>&nbsp;<INPUT TYPE="text" value="<%if (!StrFkDate.equals("")&&Integer.parseInt(StrFkDate.substring(0,4))>=2000)out.println(StrFkDate.substring(0,10)); %>"  NAME=fkDate size=10  onkeydown="key(document.cus.ajDate)"><input type=button name=fkc value=".." onclick="fPopUpCalendarDlg(fkDate);" title="��ѡ��ſ�����"></td>
    </tr>
    <tr bordercolor="#FFFFFF"> 
      <td width="16%" class=roomleft>��֤״̬</td>
      <td width="18%" class=roomright>&nbsp;<select name="gz" style="width : 105"><option value="0">δ��</option><option value="1">�Ѱ�</option></select></td>
      <td width="14%" class=roomleft>����״̬</td>
      <td width="18%" class=roomright>&nbsp;<select name="bx" style="width : 105"><option value="0">δ��</option><option value="1">�Ѱ�</option></select></td>
      <td width="16%" class=roomleft>���ս��</td>
      <td width="18%" class=roomright>&nbsp;<input type=text size=13 value="<%=StrBxMoney %>" name=bxmoney></td>
    </tr>-->
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
	 
	 <tr>
	 <td width="19%" class=roomleft >&nbsp;˰�Ѻϼ�</td>
      <td width="19%" class=roomright >&nbsp;<input type=text size=10 name=tax value="<%=taxprice %>" readonly></td> 
	 
	 <td width="19%" class=roomleft >&nbsp;���׺ϼ�</td>
      <td width="19%" class=roomright >&nbsp;<input type=text size=10 name=tax value="<%=peitaoprice %>" readonly></td>  
   
		<td width="15%" class=roomleft>&nbsp;���ںϼ�</td>
      <td width="23%" class=roomright  >&nbsp;<input type=text size=10 name=tax value="<%=Format.getFloat3(s_price,2) %>" readonly></td>
	 </tr>
    
	 <tr bordercolor="#FFFFFF"> 
      <td  class=roomright colspan="6">&nbsp;���¼���:����ƻ�<input type=checkbox name=modijh value=1>&nbsp;˰��<input type=checkbox name=moditax value=1>&nbsp;���׷�<input name="modip" type="checkbox" value="1">&nbsp;<font color=red>���ͻ��ĸ��ʽ���ܷ���仯ʱ������ѡ��ѡ��</font></td>
    </tr>
    <input type=hidden name=caDate value="1800-01-01">
    <input type=hidden name=ajtxdate value="0">
	 <input type=hidden name=orderstate value="1">
	  
  </table>
   <p align="center"> 
  <%//}
 
  if (checkstate){
   %>
     �˺�ͬ��ͨ�������������ˣ�<%=checkperson %>&nbsp;��������:<%=checkDate %>
	  <%}
		 if (Cortrol.indexOf("F")>=0&&ContractNo.equals("")){// &&  (!userstate.equals("1") || loginuserid.equals("userid")) && see.equals("1")) %>
    <%} %><input type="button" value="��ӡ�Ϲ���" name="submit2" onclick="printrs();">
	
    
  <% 
  if ((loke.equals("1")&&nn>loke_time)||loke.equals("0")||loke_time==0){ %>
    <%}else{ out.print("<script>alert('���ݱ���ռ�ã�"+loke_time+"���Ӻ���ˢ�£��Զ�����');close();</script>");out.close();}%>

    <input type=hidden name=saveorder value="modi">
	 <%
		 if (Cortrol.indexOf("A")>=0&&c_day==0){
		     if (StrJzDate.equals("")){
		 // &&  (!userstate.equals("1") || loginuserid.equals("userid")) && see.equals("1")) %>
    <input type="button" value="�ᡡ��" name="submit1" onclick="SaveContract();">
	<% }
	 }else if (c_day>0){out.print("���ݱ����������ܱ������޸ĺ�����ݡ�");} %>
	&nbsp;&nbsp; 
	 <%
	   String reportAddrs=(String)session.getAttribute("reportAddr");
		 if (Cortrol.indexOf("F")>=0&&!ContractNo.equals("")){// &&  (!userstate.equals("1") || loginuserid.equals("userid")) && see.equals("1")) %>
    <input type="button" value="��ӡ��ͬ" name="submit2" onclick="openwin('szhtbook.jsp?code=<%=code %>',500,450,10,10);"><!--openwin('contractbook.jsp?code=<%=code %>-->
	 &nbsp;
	 
	 <input type="button" value="����Э��" name="submit4" onclick="openwin('buchongxy.jsp?code=<%=code %>',500,450,10,10);">
	
	<%} %>
    &nbsp;&nbsp; 
	<input type="button" value="��ӡ�����嵥" name="reset" onclick="window.open('../finance/paylist.jsp?contractno=<%=code %>&cusno=<%=cusno %>&pay=<%=pay1 %>');">
   &nbsp;&nbsp; 
    <input type="button" value="�� ��" name="reset" onclick="window.close();">
  </P>
  <%}else if(sel.equals("2")){ %>
	 <p align=center>
  <b><font size="3" color="#000080">Ӧ��һ����</font></b>
 </p>  
  <%if (Cortrol.indexOf("A")>=0 ){ %>
 <input type=button name=fac value="������" onclick="addpay();">
   <%}if (Cortrol.indexOf("E")>=0 ){ %>
 <input type=button name=modi value="��  ��" onclick="editpay();">
  <%}if (Cortrol.indexOf("D")>=0 ){ %>
 <input type=button name=de value="ɾ  ��" onclick="deletepay();">
 <%} %>
    <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
     <tr  class=listtitle  align="center">
        <td><font color="#FFFFFF">���</font></td>
		 <td><font color="#FFFFFF">����</font></td>
        <td><font color="#FFFFFF">��������</font></td>
        <td><font color="#FFFFFF">Ӧ����</font></td>
		<td><font color="#FFFFFF">�ѽ���</font></td>
        <td><font color="#FFFFFF">δ����</font></td>
        <td><font color="#FFFFFF">���ɽ�</font></td>
   
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
            state = "δ��" ;prin=0;
        }else if( state.equals( "1" ) ) {
            state = "������" ;prin=0;
        }else if( state.equals( "2" ) ) {
            state = "�ѽ���" ;
        }else{
            state = "" ;
        }
        weijiao = weijiao + qianKuan + demurrage ;
        yijiao = yijiao + ciQiYiJiao ;
        zhiNaJing = zhiNaJing + demurrage ;
	%>
	<%
	qs=shouldQS;
	if (shouldQS.equals("0"))shouldQS ="����";
	else if (shouldQS.equals("1")) shouldQS ="����";
	else if (shouldQS.equals("2"))shouldQS ="����";
	else if (shouldQS.equals("3"))shouldQS ="����";	
	else if (shouldQS.equals("4"))shouldQS ="����";	
	else if (shouldQS.equals("5"))shouldQS ="��԰/¶̨��";	 
	else if (shouldQS.equals("6"))shouldQS ="��װ��";	  
	else if (shouldQS.equals("7"))shouldQS ="���ɽ�";	
	else if (shouldQS.equals("13"))shouldQS ="�����";	
 	else if (shouldQS.equals("15"))shouldQS ="����������";  
%>
 	    <tr  class=listcontent id=TR<%=i%> align="center"     onclick="setpara( '<%= qs %>' , '<%= qianKuan+demurrage%>' , '<%= shouldmoney %>','<%=ysid %>','<%=shouldDate %>','<%=statevalue %>' );changeclass1(this,'clickbg','listcontent');" ��onmouseover="mout(this);">
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
<b>��&nbsp;&nbsp;��:</td><td><b><%= curry+Format.getFloat2(ysSumMoney,2)%></b></td><td><b><%= curry+Format.getFloat2(yijiao,2)%></b></td> <td><b> <%= curry+Format.getFloat2(weijiao,2)%></b></td> <td ><b> <%= curry+Format.getFloat2(zhiNaJing,2)%></td></b> 
       <td >
   
  </td>
    </tr>
	</table> 
	
 <p align=center>
  <b><font size="3" color="#000080">ʵ��һ����</font></b>
 </p> 
    <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
    <tr  class=listtitle  align="center">
        <td><font color="#FFFFFF">���</font></td>
		<td><font color="#FFFFFF">����</font></td>
        <td><font color="#FFFFFF">����<br>����</font></td>
        <td><font color="#FFFFFF">����<br>���</font></td>
		<td><font color="#FFFFFF">����</font></td>
		<td><font color="#FFFFFF">����</font></td>
		 <td><font color="#FFFFFF">����<br>����</font></td>
       <!-- <td><font color="#FFFFFF">���ݺ�</font></td>-->
        <td><font color="#FFFFFF">�տ���</font></td>
		 <td><font color="#FFFFFF">��ӡƱ<br>������</font></td>
        <td><font color="#FFFFFF">�Ƿ����</font></td>
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
		 if (BillType.equals("0"))BillType="�վ�";
		 if (BillType.equals("1"))BillType="��Ʊ";
		
		 String curryDX="";
		if (FactCurry.equals("��"))curryDX="�����";
		if (FactCurry.equals("HKD"))curryDX="�۱�";
		if (FactCurry.equals("USD"))curryDX="��Ԫ";
    %>
	<%
 
	if (period.equals("0"))period ="����";
	else if (period.equals("1")) period ="����";
	else if (period.equals("2")) period ="����";
	else if (period.equals("2"))period ="����";
	else if (period.equals("3"))period ="����";	
    else if (period.equals("4"))period ="����";	
	else if (period.equals("5"))period ="��԰/¶̨��";	
 	else if (period.equals("6"))period ="��װ��";	
	else if (period.equals("7"))period ="���ɽ�";
	
	else if (period.equals("8"))period ="������";	
	else if (period.equals("9"))period ="��װ����";	
	else if (period.equals("10"))period ="��԰/¶̨����";	
	else if (period.equals("11"))period ="��̨�ֲ��";	
	else if (period.equals("13"))period ="�����";	
	 	else if (period.equals("15"))period ="����������";	
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
		 
		 &nbsp;<font color="red">�����</font><%} %>
		  </td>  
        </tr>
	
    <%
       
    }
	//if (payment.indexOf("(")>0)payment=payment.substring(0,payment.indexOf("("))  ;
    %>
		 <tr bgcolor="#EBEBEB" align="center">
     <td colspan=2>
    <b>��&nbsp;&nbsp;��:</td><td colspan=7 align="left"> <b>��<%=Format.getFloat2(sumfactmoney,2)%> </b><br>��ע��<%=context %> </td> 
     <td > 
      <% if (yijiao-ysSumMoney>0) out.print(" <font color=red>���:"+curry+Format.getFloat2(yijiao-ysSumMoney,2)+"</font>");
	  %>
  </td>
    </tr>
    </table>
	 
	<%if (payment.indexOf("��")>0){ %>
	<p align="center"> <b><font size="3" color="#000080">���зſ��¼</font></b></p>
	<table width="100%">
	  
	<tr  class=listtitle  align="center"><td>��������</td><td>�ſ�����</td><td>�ſ���</td><td>�Ǽ���</td><td>���</td></tr> 
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
 
<p align="center">   <b><font size="3" color="#000080">Ӧ������һ��</font></b> </p>
<input type=button name=add value="������Ŀ" onclick="addtax();">
 <table width="100%"  border="0" cellspacing="1"  cellpadding="1"  >
    <tr   class=TxtColor >
	 <td  >���</td> 
      <td    >��������</td><td>���</td> 
	 <td>����</td> 
    </tr>
	
  
    <%
String sql1="";
  String 		sql="select id,TaxName,TaxMoney,state,TaxMoney-factmoney q from GatheringTaxRecord where contactno ='"+code+"'";//order by room_no desc";
//���ò�ѯ����Ĵ�ű���
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
  //��FIELDS˳��һGET��VALUE
   String id=rs.getString("id");
    
   TaxName=getbyte(rs.getString("TaxName"));
   TaxMoney=rs.getFloat("TaxMoney");
    state=rs.getString("state");
    q=rs.getFloat("q");
    %> 
    <tr class=listcontent id=TR2<%=i%>  align="left"  title="˫���ɵǼǴ��շ���"  onclick="changeclass1(this,'clickbg','listcontent');">
      <td  ><%=i%></td>
	  <td  ><%=TaxName%></td>
	  <td  ><%=TaxMoney%></td>
       <td><img src="../images/button_sc.gif"  border="0"   onmouseover="javascript:this.style.cursor='hand'" title="ɾ��" onclick="deleteC(<%=id %>)";></td>
   
    </tr>
    <%
  }catch(Exception ex){out.println(ex.getMessage());}

}

  rs.close();
 sql="select sum(TaxMoney) TaxMoney,taxname_type from GatheringTaxRecord where contactno ='"+code+"' group by taxname_type";//order by room_no desc";
   rs=ViewBean.executeQuery(sql);
  double  taxprice=0,peitaoprice=0;
   while (rs.next()){
     if (rs.getBoolean("taxname_type"))taxprice=rs.getDouble("TaxMoney");
	 else peitaoprice=rs.getDouble("TaxMoney");
 }
 rs.close();
 %>
 <tr><td>˰�Ѻϼƣ�<%=Format.getFloat3(taxprice,2) %></td><td>���׺ϼƣ�<%=Format.getFloat3(peitaoprice,2) %></td><td>�ϼƣ�<%=Format.getFloat3(peitaoprice+taxprice,2) %></td></tr>

</table>
  <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1  ALIGN=center  >
<tr  class=TXTColor align="center"> <td>ԭ��¥����</td><td>�ֽ�¥����</td><td>��ע</td></tr>
  <%
    String jlSQL="SELECT * FROM JL_BAK WHERE CON_NO="+code;
     rs=ViewBean.executeQuery(jlSQL);
	 while (rs.next()){
   %>
  <tr align="center"><td><%=rs.getDate("old_jl").toString() %></td><td><%=rs.getDate("new_jl").toString() %></td><td><%=rs.getString("bak") %></td></tr>
  
  
  <%}rs.close(); %>
  </table>
  
<p align=center>
  <b><font size="3" color="#000080">����(��)һ��</font></b>
 </p>
  <table width="100%"  border="0" cellspacing="1"  cellpadding="1"  >
    <tr   class=TxtColor >
	 <td  >���</td> 
      <td    >��������</td><td>���</td> <td>��ȡ����</td> 
	  <td>Ʊ�ݱ��</td> 
	  <td>������</td>
	  <td>��������</td>
	  <td>������</td>
	  
	
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
	   out.print("<font color=red>�����</font>") ;}
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

<script>
function deletepay(){
    if (ysID!=""){
	  if (period<<%=i %>) {alert("ֻ��ɾ�����һ�ڸ���,���ɾ�������ݲ���ȷ�����޸�����");return false;}
	  else{
  	   if (confirm("ȷ��ɾ����?")){
	    openwin2("../finance/deletePay.jsp?ysID="+ysID,10,10,10,10);
	    
		}
	  }	
	 }else{alert("��ѡ��ɾ������");} 
	 
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
    }else{alert("��ѡ���޸ĵ�����");}
	}
</script>
     <%} %>
</center>
<script>
 
	 function dkcount(){
	   document.cus.sydk.value= document.cus.ajmoney.value;
		 }
	function dkcount1(){
	 
	    if (document.cus.gjj.value=="")
		document.cus.gjj.value="0";
	     document.cus.sydk.value= parseInt(document.cus.ajmoney.value)-parseInt(document.cus.gjj.value);

		 }	 
	function dkcount2(){
	   if (parseInt(document.cus.sydk.value)>0)
	     document.cus.gjj.value= parseInt(document.cus.ajmoney.value)-parseInt(document.cus.sydk.value);
	   else
	      document.cus.gjj.value= document.cus.ajmoney.value;	 
		 }	 	 
function setpara(periodpass ,qianPass , shouldPass,ysid,ysdate,jk) {
    period = periodpass ;
    qianKuan = qianPass ;
    shouldmoney = shouldPass ;
	ysID=ysid;
	ysDate=ysdate;
	jkstate=jk;
	
}

function printrs(){
   window.open("printRG.jsp?code=<%=code %>");

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
function addtax(){
  openwin("../finance/AddDsTax.jsp?id=<%=code %>",300,300,100,100);
 

}		
function deleteC(para){
if (confirm("ȷ��ɾ����ɾ��ʱ�������շ���Ҳɾ����ɾ�����ָܻ�")){
 var newwink = openwin2("../finance/deleteC.jsp?id="+para ,40,30,10,10);
   // newwink.focus();
}
} 	  
</script>

</form>
<%}catch(Exception s){  out.print(s.getMessage()+"��ˢ�����ر���ٵ���ղ��Ϲ��ķ���,������������ģ�����ϵ����Ա��ϵͳ�����о�����");out.close();} %>
 <%ViewBean.closeConn();
  
  %>
</body>

</html>
