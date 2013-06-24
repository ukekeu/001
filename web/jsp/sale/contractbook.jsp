<%@ page contentType="teXt/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<HTML><HEAD><TITLE>房地产买卖合同套打</TITLE>
<META http-equiv=Content-Type content="teXt/html; charset=gb2312">
<META content="MSHTML 6.00.2800.1106" name=GENERATOR>
<META content=FrontPage.Editor.Document name=ProgId>
<STYLE type=teXt/css>BODY {
	FONT-SIZE: 15pt; LINE-HEIGHT: 10pt; FONT-FAMILY: 宋体
}
TABLE {
	FONT-SIZE: 10pt; FONT-FAMILY: 宋体
}
A:link {
	COLOR: #0000cc; TEXT-DECORATION: none
}
A:visited {
	COLOR: #0000cc; TEXT-DECORATION: none
}
A:active {
	COLOR: #ff0000; TEXT-DECORATION: none
}
A:hover {
	TEXT-DECORATION: underline
}
.unnamed1 {
	FONT-SIZE: 9pt; FONT-FAMILY: "宋体"
}
.unnamed2 {
	FONT-SIZE: 15pt
}
</STYLE>
</HEAD>
<BODY bgColor=#ffffff> 
 <%//try{
	 
	 String  code=request.getParameter("code");
	 //读取业主资料
	 String SQL="SELECT DATEDIFF(DD,o.VISADATE ,o.JLDATE) CD,c.cus_name,c.phone+' '+c.sj phone,c.id_card,c.zip_code,c.address,";
	 SQL+="o.section,o.loft,o.room_no,o.xiaoshoutype,o.floors,o.jzarea,o.area,dateadd(dd,30,visadate) ajdate,o.yong_tu,";
	 SQL+="o.jzarea-o.area ft,o.roomtype ,o.salerprice,o.count_type,o.rmbprice,o.rmbprice-o.ajmoney firstMoney,(o.rmbprice-o.ajmoney)*1.0/o.rmbprice*100 firstbl,o.rmbprice/o.area tnunitprice,o.rmbprice/o.jzarea unitprice,o.payment1,o.JLdate,o.ajyear,o.ajmoney,o.ajmoney*100.0/o.rmbprice ajb,o.visadate,DATEDIFF(dd,o.visadate,o.jldate) num,datediff(dd,dateadd(dd,30,visadate),o.jldate) num1 from order_contract o,customer c where c.serialno=o.customer and o.code="+code;
	 ResultSet rs=InsertBean.executeQuery(SQL);
	 String cus_name="",id_card="",zip_code="",phone="",address="",Type="";
	 String section="",loft="",room_no="",floors="",tnunitprice="",ajdate="";
	  String jzarea="",tnarea="",ft="",uppercaseMoney="",unitprice="",firstMoney="",firstbl="";
	 boolean xiaoshoutype=false,count_type=false;
	 String salerprice="0";
	 int xcnum=0,ysnum=0,cd=0;
	 String yroomno="";
	 String payment1="",JLdate="",ajb="",ajmoney="",ajyear="",visadate="",roomtype="";
	 if (rs.next()){
	    cd=rs.getInt("cd") ;
	    cus_name=rs.getString("cus_name");
		phone=rs.getString("phone");
		id_card=rs.getString("id_card");
		zip_code=rs.getString("zip_code");
		address=rs.getString("address");
		section=rs.getString("section");
		loft=rs.getString("loft");
		 if (loft.indexOf("-")>=0)loft=loft.substring(0,loft.indexOf("-"));
 		
		room_no=rs.getString("room_no");
		yroomno=room_no;
		if (room_no.indexOf("-")>=0)room_no=room_no.substring(room_no.indexOf("-")+1);
		xiaoshoutype =rs.getBoolean("xiaoshoutype");
		floors=rs.getString("floors");
		if (floors.equals("0"))floors="地下";
		else if (Integer.parseInt(floors)<0){floors="地下"+floors.substring(floors.indexOf("-")+1)+"层";}
		jzarea=FormtD.getFloat1(rs.getFloat("jzarea"),2);
		tnarea=FormtD.getFloat1(rs.getFloat("area"),2);
		Type=rs.getString("yong_tu");
		ajdate=rs.getDate("ajdate").toString();
		ft=FormtD.getFloat1(rs.getFloat("ft"),2);
		roomtype=rs.getString("roomtype");
	    salerprice=rs.getString("salerprice");
		count_type=rs.getBoolean("count_type");
		uppercaseMoney=rs.getString("rmbprice");
		firstMoney=rs.getString("firstMoney");
		firstbl=FormtD.getFloat(rs.getFloat("firstbl"),2);
		tnunitprice=FormtD.getFloat1(rs.getFloat("tnunitprice"),2);
		unitprice=FormtD.getFloat1(rs.getFloat("unitprice"),2);
		payment1=rs.getString("payment1");
		JLdate=rs.getString("JLdate");
		ajyear=rs.getString("ajyear");
		ajmoney=rs.getString("ajmoney");
		ajb=FormtD.getFloat(rs.getFloat("ajb"),2);
		if (!JLdate.equals(""))JLdate=JLdate.substring(0,10);
		visadate=rs.getDate("visadate").toString();
		xcnum=rs.getInt("num");
		ysnum=rs.getInt("num1");
	 }
	 rs.close();
	%> <%// jys,
    SQL="select   Region,developcom,tdsyqcrpzno,gytzno,NAME,AreaNo,qddkfs,tudishiyong_no,GroundArea,Type,useyear,cq_sd,cq_ed";
	SQL+=" ,guihua_no,shigong_no,yushou_no,jiegou,chenggao,wuyei_com ";
		SQL+=" ,fr,frdh,dlr,dlrzh,dlrdz,dlryb,yyzzh,zzzsh ,fryb,frdz,zc_addr";
	SQL+=" from crm_project where serialno='"+section+"'";
 
    rs=InsertBean.executeQuery(SQL);
	String name="",GroundArea="",qddkfs="",tudishiyong_no="",Region="";
	String useyear="",cq_sd="",cq_ed="",guihua_no="",shigong_no="";
	String yushou_no="",AreaNo="",jiegou="",chenggao="",wuyei_com="";
	String gytzno="",tdsyqcrpzno="",fryb="",frdz="";
String jiaolouDate="";
String fr="X";
String	phone2="X";
String dlr="X";
String	phone1="X";
String	dlrdz="X";
String	zipcode="X";
String	yyzzh="X";
String	zzzsh="X"; 
int jlday=0;
String yang_tai_area="",jys=""; 
String developcom="",zcadd="";
	if (rs.next()){
	  // jys=getbyte(rs.getString("jys"));
	  Region=getbyte(rs.getString("Region"));
	  if (jys.equals("")){
	  Region="汕头市"+Region+"土地房产交易所";
	  }else{Region=jys;}
	  developcom =getbyte(rs.getString("developcom"));
	  tdsyqcrpzno=getbyte(rs.getString("tdsyqcrpzno"));
	  gytzno=getbyte(rs.getString("gytzno"));
	  name=rs.getString("NAME");
	 
	  qddkfs=getbyte(rs.getString("qddkfs"));
	  tudishiyong_no=getbyte(rs.getString("tudishiyong_no"));
	  GroundArea=FormtD.getFloat1(rs.getFloat("GroundArea"),2);
	 
	  
	  guihua_no=getbyte(rs.getString("guihua_no"));
	  shigong_no=getbyte(rs.getString("shigong_no"));
	  yushou_no=getbyte(rs.getString("yushou_no"));
	  jiegou=getbyte(rs.getString("jiegou"));
	  chenggao=getbyte(rs.getString("chenggao"));
	  wuyei_com=getbyte(rs.getString("wuyei_com"));
	  fr=getbyte(rs.getString("fr"));
	phone2=getbyte(rs.getString("frdh"));
	dlr=getbyte(rs.getString("dlr"));
	phone1=getbyte(rs.getString("dlrzh"));
	dlrdz=getbyte(rs.getString("dlrdz"));
	zipcode=getbyte(rs.getString("dlryb"));
	yyzzh=getbyte(rs.getString("yyzzh"));
	zzzsh=getbyte(rs.getString("zzzsh")); 
	fryb=getbyte(rs.getString("fryb")); 
	frdz=getbyte(rs.getString("frdz")); 
	zcadd=getbyte(rs.getString("zc_addr")); 
	}
	rs.close();
	//if (gytzno.equals(""))gytzno="X";
	//if (tdsyqcrpzno.equals(""))tdsyqcrpzno="X";
	SQL="select Serve_Date,useryear, s_year,e_year,cg,counttype,yang_tai_area from room where seccode='"+section+"' and loft='"+loft+"'and room_code='"+yroomno+"'";
     boolean counttype=false;
	  rs=InsertBean.executeQuery(SQL);
	  if (rs.next()){
	  
	   useyear=rs.getString("useryear");
	  cq_sd=getbyte(rs.getString("s_year"));
	  cq_ed=getbyte(rs.getString("e_year"));
	  chenggao=getbyte(rs.getString("cg"));
	  counttype=rs.getBoolean("counttype");
	  float aaaa=rs.getFloat("yang_tai_area");
	  if (aaaa>0)
	   yang_tai_area =FormtD.getFloat(aaaa,2);
	   else
	   yang_tai_area="X";
	  }
	 
	  rs.close();
	  String ysxkz="";//楼栋中的预售许可证
	 SQL="SELECT  case when jiaolouDate  is not null then DATEDIFF(DD,jiaolouDate ,'"+visadate+"')  else -1 end  aa,zzzh,sgxkz,ghxkz,zdmj,tdsyqcrh,fzdbr,gytdsyz,yyzzh,FZS,ysxkz,cq_addr FROM LoftBuildCode WHERE SecNo='"+section+"' and Loft='"+loft+"'"; 
	  rs=InsertBean.executeQuery(SQL);
	  if (rs.next()){
	    jlday=rs.getInt("aa");
	    String fzs=getbyte(rs.getString("fzs"));
		String yyy=getbyte(rs.getString("yyzzh"));
		String gytdsyz1=getbyte(rs.getString("gytdsyz"));
		String fzdbr=getbyte(rs.getString("fzdbr"));
		String tdsyqcrh=getbyte(rs.getString("tdsyqcrh"));
		String zdmj=getbyte(rs.getString("zdmj"));
		String ghxkz=getbyte(rs.getString("ghxkz"));
		String sgxkz=getbyte(rs.getString("sgxkz"));
		ysxkz=getbyte(rs.getString("ysxkz"));
		String zzzh=getbyte(rs.getString("zzzh"));
		 AreaNo=getbyte(rs.getString("cq_addr"));
		if (!fzs.equals(""))
		developcom=fzs;
		if (!yyy.equals(""))
		yyzzh=yyy;
		if (!fzdbr.equals(""))
		fr=fzdbr;
		if (!tdsyqcrh.equals(""))
		tdsyqcrpzno=tdsyqcrh;
		if (!gytdsyz1.equals(""))
		gytzno=gytdsyz1;
		if (!zdmj.equals(""))
		GroundArea=zdmj;
		if (!ghxkz.equals(""))
		guihua_no=ghxkz;
		if (!sgxkz.equals(""))
		shigong_no=sgxkz;
		if (!zzzh.equals(""))
		zzzsh=zzzh;
		
	  }
	  rs.close();
	  if (!ysxkz.equals(""))yushou_no=ysxkz;//如果楼栋中存在预售许可证，则以楼栋数据为准
	  if (yyzzh.indexOf("/")>=0)yyzzh=yyzzh.substring(0,yyzzh.indexOf("/"))+"<br>"+yyzzh.substring(yyzzh.indexOf("/")+1);
 
 
  String a1="",a2="",a3="";

 if (!cq_sd.equals("")){ 
 a1=cq_sd.substring(0,4);
  a2=cq_sd.substring(5,7);
  a3=cq_sd.substring(8,10);
}

String ydxz="";
if (Type.indexOf("别墅")>=0||Type.indexOf("车位")>=0||Type.indexOf("车库")>=0||Type.indexOf("住宅")>=0)
 ydxz="住宅用地";
else
  ydxz="综合用地";
 
 
String tmpDoc = "AA3.doc";
String url = "http://"+request.getServerName()+":"+request.getServerPort()+"/crm/jsp/sale/"+tmpDoc;
 
StringBuffer sb = new StringBuffer();
sb.append("<document>");
sb.append("<doc url=\""+url+"\"/>");
sb.append("<bookmark name=\"A1\" value=\""+developcom+"\"/>");
sb.append("<bookmark name=\"A2\" value=\""+zcadd+"\"/>");
sb.append("<bookmark name=\"A3\" value=\""+yyzzh+"\"/>");
sb.append("<bookmark name=\"A4\" value=\""+zzzsh+"\"/>");
sb.append("<bookmark name=\"A5\" value=\""+fr+"\"/>");
sb.append("<bookmark name=\"A6\" value=\""+phone2+"\"/>");
sb.append("<bookmark name=\"A7\" value=\""+fryb+"\"/>");
sb.append("<bookmark name=\"A8\" value=\""+dlr+"\"/>");
sb.append("<bookmark name=\"A9\" value=\""+dlrdz+"\"/>");
sb.append("<bookmark name=\"A10\" value=\""+zipcode+"\"/>");
sb.append("<bookmark name=\"A11\" value=\""+phone1+"\"/>");
sb.append("<bookmark name=\"A12\" value=\""+cus_name+"\"/>");
sb.append("<bookmark name=\"A13\" value=\""+cus_name+"\"/>");
sb.append("<bookmark name=\"A14\" value=\""+id_card+"\"/>");
sb.append("<bookmark name=\"A15\" value=\""+address+"\"/>");
sb.append("<bookmark name=\"A17\" value=\""+phone+"\"/>");
sb.append("<bookmark name=\"A16\" value=\""+zip_code+"\"/>");
sb.append("<bookmark name=\"A18\" value=\""+qddkfs+"\"/>");
sb.append("<bookmark name=\"A19\" value=\""+AreaNo+"\"/>");
sb.append("<bookmark name=\"A20\" value=\""+gytzno+" "+tdsyqcrpzno+" "+tudishiyong_no+"\"/>");
sb.append("<bookmark name=\"A21\" value=\""+GroundArea+"\"/>");
sb.append("<bookmark name=\"A22\" value=\""+ydxz+"\"/>");
sb.append("<bookmark name=\"A23\" value=\""+a1+"\"/>");
sb.append("<bookmark name=\"A24\" value=\""+a2+"\"/>");
sb.append("<bookmark name=\"A25\" value=\""+a3+"\"/>");

 if (!cq_ed.equals("")){
  a1=cq_ed.substring(0,4);
  a2=cq_ed.substring(5,7);
  a3=cq_ed.substring(8,10);
}
sb.append("<bookmark name=\"A26\" value=\""+a1+"\"/>");
sb.append("<bookmark name=\"A27\" value=\""+a2+"\"/>");
sb.append("<bookmark name=\"A28\" value=\""+a3+"\"/>");
sb.append("<bookmark name=\"A29\" value=\""+name+"\"/>");
sb.append("<bookmark name=\"A30\" value=\""+guihua_no+"\"/>");
sb.append("<bookmark name=\"A31\" value=\""+shigong_no+"\"/>");
sb.append("<bookmark name=\"A32\" value=\""+shigong_no+"\"/>");

 String str1="",str2="";
   if (xiaoshoutype){str1="√";str2="X";}
   else {str1="X";str2="√";}
   if (jlday>=0){str1="√";str2="X";}
  sb.append("<bookmark name=\"A33\" value=\""+str1+"\"/>");
  sb.append("<bookmark name=\"A34\" value=\""+str2+"\"/>");
  sb.append("<bookmark name=\"A35\" value=\""+loft.trim()+"\"/>");
  sb.append("<bookmark name=\"A36\" value=\""+floors+"\"/>");
  if (yroomno.indexOf("-")>=0){
  sb.append("<bookmark name=\"A37\" value=\""+yroomno.substring(2)+"\"/>");
  }else{
  sb.append("<bookmark name=\"A37\" value=\""+yroomno +"\"/>");
  }

   sb.append("<bookmark name=\"A38\" value=\""+Type +"\"/>");
   sb.append("<bookmark name=\"A39\" value=\""+jiegou +"\"/>");
   sb.append("<bookmark name=\"A40\" value=\""+chenggao +"\"/>");
 
   sb.append("<bookmark name=\"A43\" value=\""+jzarea +"\"/>");
   sb.append("<bookmark name=\"A44\" value=\""+tnarea +"\"/>");
   sb.append("<bookmark name=\"A45\" value=\""+ft +"\"/>");
   String hc="";
   if (xcnum>0)hc="√";else hc="X";
   sb.append("<bookmark name=\"A46\" value=\""+hc +"\"/>");
    if (xcnum>0)hc="√";else hc="X";
   sb.append("<bookmark name=\"A47\" value=\""+hc +"\"/>");
    //计算方式
   String fs="";
   if (count_type)fs="1";
   else fs="2";
   if (counttype)fs="3";
      sb.append("<bookmark name=\"A48\" value=\""+fs +"\"/>");
    
	
	   String p1="X",p2="X",p3="X",p4="X",p5="X",p6="X",p7="X",p8="X";
	   String uppercaseMoney1="";
	  String upperMoney="";
		ResultSet execRs=InsertBean1.executeQuery("exec dbo.L2U "+uppercaseMoney+",1 ");//大写金额转换存储过程
             if (execRs.next())
				upperMoney=getbyte(execRs.getString("dd"));
				execRs.close();
				
			 upperMoney=upperMoney.substring(0,upperMoney.indexOf("元")+1);
		 if (upperMoney.length()==10){  
		  for (int ii=1;ii<12;ii++){
		   if (ii==1)
		      p4= upperMoney.substring(ii-1,ii);
			  if (ii==3)
		      p5= upperMoney.substring(ii-1,ii);  
			    if (ii==5)
		      p6= upperMoney.substring(ii-1,ii);  
			  if (ii==7)
		      p7= upperMoney.substring(ii-1,ii);  
			    if (ii==9)
		      p8= upperMoney.substring(ii-1,ii);  
			  }
		  }else   if (upperMoney.length()==12){
		   for (int ii=1;ii<12;ii++){
		      if (ii==1)
		      p3= upperMoney.substring(ii-1,ii);
			  if (ii==3)
		      p4= upperMoney.substring(ii-1,ii);  
			    if (ii==5)
		      p5= upperMoney.substring(ii-1,ii);  
			  if (ii==7)
		      p6= upperMoney.substring(ii-1,ii);  
			    if (ii==9)
		      p7= upperMoney.substring(ii-1,ii);  
			   if (ii==11)
		      p8= upperMoney.substring(ii-1,ii);  
		   }
		  }else  if (upperMoney.length()==14){
		   for (int ii=1;ii<14;ii++){
		      if (ii==1)
		      p2= upperMoney.substring(ii-1,ii);
			  if (ii==3)
		      p3= upperMoney.substring(ii-1,ii);  
			    if (ii==5)
		      p4= upperMoney.substring(ii-1,ii);  
			  if (ii==7)
		      p5= upperMoney.substring(ii-1,ii);  
			    if (ii==9)
		      p6= upperMoney.substring(ii-1,ii);  
			   if (ii==11)
		      p7= upperMoney.substring(ii-1,ii);  
			     if (ii==13)
		      p8= upperMoney.substring(ii-1,ii);  
		   }
		   }else  if (upperMoney.length()==16){
		   for (int ii=1;ii<16;ii++){
		      if (ii==1)
		      p1= upperMoney.substring(ii-1,ii);
			  if (ii==3)
		      p2= upperMoney.substring(ii-1,ii);  
			    if (ii==5)
		      p3= upperMoney.substring(ii-1,ii);  
			  if (ii==7)
		      p4= upperMoney.substring(ii-1,ii);  
			    if (ii==9)
		      p5= upperMoney.substring(ii-1,ii);  
			   if (ii==11)
		      p6= upperMoney.substring(ii-1,ii);  
			     if (ii==13)
		      p7= upperMoney.substring(ii-1,ii);  
			      if (ii==15)
		      p8= upperMoney.substring(ii-1,ii); 
		   }
		  }
	  if (!fs.equals("1")){
      sb.append("<bookmark name=\"A49\" value=\""+"×" +"\"/>");
      sb.append("<bookmark name=\"A50\" value=\""+"×" +"\"/>");
	  sb.append("<bookmark name=\"A51\" value=\""+"×" +"\"/>");
	  sb.append("<bookmark name=\"A52\" value=\""+"×" +"\"/>");
	  sb.append("<bookmark name=\"A53\" value=\""+"×" +"\"/>");
	  sb.append("<bookmark name=\"A54\" value=\""+"×" +"\"/>");
	  sb.append("<bookmark name=\"A55\" value=\""+"×" +"\"/>");
	  sb.append("<bookmark name=\"A56\" value=\""+"×" +"\"/>");
	  sb.append("<bookmark name=\"A57\" value=\""+"×" +"\"/>");
	  sb.append("<bookmark name=\"A58\" value=\""+"×" +"\"/>");
   }
    if (fs.equals("1")){
      sb.append("<bookmark name=\"A49\" value=\""+unitprice +"\"/>");
      sb.append("<bookmark name=\"A50\" value=\""+"人民" +"\"/>");
	  sb.append("<bookmark name=\"A51\" value=\""+p1 +"\"/>");
	  sb.append("<bookmark name=\"A52\" value=\""+p2 +"\"/>");
	  sb.append("<bookmark name=\"A53\" value=\""+p3 +"\"/>");
	  sb.append("<bookmark name=\"A54\" value=\""+p4 +"\"/>");
	  sb.append("<bookmark name=\"A55\" value=\""+p5 +"\"/>");
	  sb.append("<bookmark name=\"A56\" value=\""+p6+"\"/>");
	  sb.append("<bookmark name=\"A57\" value=\""+p7+"\"/>");
	  sb.append("<bookmark name=\"A58\" value=\""+p8 +"\"/>");
   }
    if (!fs.equals("2")){
      sb.append("<bookmark name=\"A59\" value=\""+"×" +"\"/>");
      sb.append("<bookmark name=\"A60\" value=\""+"×" +"\"/>");
	  sb.append("<bookmark name=\"A61\" value=\""+"×" +"\"/>");
	  sb.append("<bookmark name=\"A62\" value=\""+"×" +"\"/>");
	  sb.append("<bookmark name=\"A63\" value=\""+"×" +"\"/>");
	  sb.append("<bookmark name=\"A64\" value=\""+"×" +"\"/>");
	  sb.append("<bookmark name=\"A65\" value=\""+"×" +"\"/>");
	  sb.append("<bookmark name=\"A66\" value=\""+"×" +"\"/>");
	  sb.append("<bookmark name=\"A67\" value=\""+"×" +"\"/>");
	  sb.append("<bookmark name=\"A68\" value=\""+"×" +"\"/>");
    }
  
    if (fs.equals("2")){
	 
      sb.append("<bookmark name=\"A59\" value=\""+tnunitprice+"\"/>");
      sb.append("<bookmark name=\"A60\" value=\""+"人民" +"\"/>");
	  sb.append("<bookmark name=\"A61\" value=\""+p1 +"\"/>");
	  sb.append("<bookmark name=\"A62\" value=\""+p2 +"\"/>");
	  sb.append("<bookmark name=\"A63\" value=\""+p3 +"\"/>");
	  sb.append("<bookmark name=\"A64\" value=\""+p4 +"\"/>");
	  sb.append("<bookmark name=\"A65\" value=\""+p5 +"\"/>");
	  sb.append("<bookmark name=\"A66\" value=\""+p6 +"\"/>");
	  sb.append("<bookmark name=\"A67\" value=\""+p7 +"\"/>");
	  sb.append("<bookmark name=\"A68\" value=\""+p8 +"\"/>");
   }
   if (!fs.equals("1")){
      sb.append("<bookmark name=\"A69\" value=\""+"×" +"\"/>");
      sb.append("<bookmark name=\"A70\" value=\""+"×" +"\"/>");
	  sb.append("<bookmark name=\"A71\" value=\""+"×" +"\"/>");
	  sb.append("<bookmark name=\"A72\" value=\""+"×" +"\"/>");
	  sb.append("<bookmark name=\"A73\" value=\""+"×" +"\"/>");
	  sb.append("<bookmark name=\"A74\" value=\""+"×" +"\"/>");
	  sb.append("<bookmark name=\"A75\" value=\""+"×" +"\"/>");
	  sb.append("<bookmark name=\"A76\" value=\""+"×" +"\"/>");
	 
   }
   
   if (fs.equals("3")){
      sb.append("<bookmark name=\"A69\" value=\""+p1 +"\"/>");
      sb.append("<bookmark name=\"A70\" value=\""+p2 +"\"/>");
	  sb.append("<bookmark name=\"A71\" value=\""+p3 +"\"/>");
	  sb.append("<bookmark name=\"A72\" value=\""+p4 +"\"/>");
	  sb.append("<bookmark name=\"A73\" value=\""+p5 +"\"/>");
	  sb.append("<bookmark name=\"A74\" value=\""+p6 +"\"/>");
	  sb.append("<bookmark name=\"A75\" value=\""+p7+"\"/>");
	  sb.append("<bookmark name=\"A76\" value=\""+p8 +"\"/>");
	 
   }
  String pa1=" " ;
 if (payment1.indexOf("一次")>=0){pa1="1";}
 else if (payment1.indexOf("分期")>=0){pa1="2";}
 else {pa1="3";}
   sb.append("<bookmark name=\"A83\" value=\""+pa1 +"\"/>");
   
   

 if (xcnum<0){//现房
    if (payment1.indexOf("按揭")>=0) 
	  JLdate=ajdate;
	else 
      JLdate=visadate;
 }else{//预售
     if (payment1.indexOf("按揭")>=0&&ysnum<0) 
	      JLdate=ajdate;
 }
   %>
  <%String ajstr="";
  String ajstr1="";
  String ajstr2="";
  if (pa1.equals("1")){
  if (payment1.indexOf("按揭")<0&&payment1.indexOf("分期")<0){ajstr="买受人应在"+visadate+"前付给出卖人上述总房款的"+firstbl+"%,计￥"+firstMoney+"元;";}
   sb.append("<bookmark name=\"A84\" value=\""+ajstr +"\"/>");
   }else{
      sb.append("<bookmark name=\"A84\" value=\""+"×" +"\"/>");
   }
    if (pa1.equals("2")){
  if (payment1.indexOf("分期")>=0){
   String facSQL="SELECT sum(shouldmoney-yijiao) qk,sum(yijiao) jk FROM GatheringRecord WHERE contactno="+code;
   rs=InsertBean.executeQuery(facSQL);
   String qk="0",jk="0";
   if (rs.next()){
     qk=rs.getString("qk");
	  jk=rs.getString("jk");
   }
   rs.close();
     ajstr="买受人应在"+visadate+"前付给出卖人上述总房款的90%,计￥"+jk+"元，剩下10%在"+JLdate+"前付清，计￥"+qk+"元;";
	
	}
	sb.append("<bookmark name=\"A85\" value=\""+ajstr +"\"/>");
  }else{
  sb.append("<bookmark name=\"A85\" value=\""+"×" +"\"/>");
  
  }
  if (pa1.equals("3")){
   if (payment1.indexOf("按揭")>=0){ ajstr="按揭:买受人应在"+visadate+"前付给出卖人上述总房款的"+firstbl+"%,计￥"+firstMoney+"元;";
  ajstr1="对剩余的"+ajb+"%总房款，计￥"+ajmoney+"元(由银行提供"+ajyear+"年按揭)，买受人应授权";
  ajstr2="按揭银行于"+ajdate+"前付给出卖人。";
  }
   sb.append("<bookmark name=\"A86\" value=\""+ajstr +ajstr1+ajstr2+"\"/>");
   }else{
     sb.append("<bookmark name=\"A86\" value=\""+"×" +"\"/>");
   }
   
   
  String gg="select * from loft_zhuangxiu where SECNO='"+section+"' and loft='"+loft+"' and yong_tu ='"+Type+"' and type=1";
 
 rs=InsertBean.executeQuery(gg);
 String b1="X",b2="X",b3="X",b4="X",b5="X",b6="X",b7="X",b8="X";
 String waiqiang="X",nieqing="X",dingpeng="X",dimian="X",mengchuang="X",chufang="X",wc="X",yangtai="X",dianti="X";
 String other="X",fentanshoming="X",paybak="",buchongxieyi="";
 if (rs.next()){
 
 
   waiqiang=getbyte(rs.getString("waiqiang"));
   nieqing=getbyte(rs.getString("nieqing"));
    dingpeng=getbyte(rs.getString("dingpeng"));
	dimian=getbyte(rs.getString("dimian"));
	mengchuang=getbyte(rs.getString("mengchuang"));
	chufang=getbyte(rs.getString("chufang"));
	wc=getbyte(rs.getString("wc"));
	yangtai=getbyte(rs.getString("yangtai"));
	dianti=getbyte(rs.getString("dianti"));
	other=getbyte(rs.getString("other"));
	//buchongxieyi=getbyte(rs.getString("buchongxieyi"));
 }
 rs.close();	
  gg="select * from loft_zhuangxiu where SECNO='"+section+"' and loft='"+loft+"' and yong_tu ='"+Type+"' and type=3";
 
 rs=InsertBean.executeQuery(gg);
  if (rs.next()){
 fentanshoming=getbyte(rs.getString("fentanshoming"));
  }
 rs.close();	
 gg="select * from loft_zhuangxiu where SECNO='"+section+"' and loft='"+loft+"' and yong_tu ='"+Type+"' and type=4";
 
 rs=InsertBean.executeQuery(gg);
  if (rs.next()){
   
   b1=getbyte(rs.getString("gonggongsheshi1"));
   b2=getbyte(rs.getString("gonggongsheshi2"));
   b3=getbyte(rs.getString("gonggongsheshi3"));
   b4=getbyte(rs.getString("gonggongsheshi4"));
   b5=getbyte(rs.getString("gonggongsheshi5"));
   b6=getbyte(rs.getString("gonggongsheshi6"));
   b7=getbyte(rs.getString("gonggongsheshi7")); 
   b8=getbyte(rs.getString("gonggongsheshi8")); 
   String yongt=getbyte(rs.getString("yong_tu")); 
    }
 rs.close();	
 gg="select * from loft_zhuangxiu where SECNO='"+section+"' and loft='"+loft+"' and yong_tu ='"+Type+"' and type=5";
 
 rs=InsertBean.executeQuery(gg);
  if (rs.next()){
    paybak=getbyte(rs.getString("paybak")); 
  
 }
   if (b1.equals(""))	b1="X";
   if (b2.equals(""))	b2="X";
   if (b3.equals(""))	b3="X";
   if (b4.equals(""))	b4="X";
   if (b5.equals(""))	b5="X";
   if (b6.equals(""))	b6="X";
   if (b7.equals(""))	b7="X"; 
   if (b8.equals(""))	b8="X";  
   %>
 <%
 
  %> 
  <%
  
  //违约条款
   a1="";
  a2="";
  a3="";
 String a4="";
 String a5="";
 String a6="";
 String a7="";
 String a8="";
 String a9="";
 String a10=""; 
 String a11="";
 String a12="";
 String a13="";
 String a14="";
 String a15="";
 String bak1="X";
 String bak2="X";
 String bak3="X";
 String bak4="X";
 String bak5="X";
 String bak6="X";
 String bak7="X";
 String bak8="X";
 String bak9="X";
 String bak10="X";
 String bak11="X";
 String bak12="X";
 String bak13="X";
 String bak14="X";
 
  String bak15="";
 String bak16="";
 String bak17="";
 String bak18="";
 String bak19="";
  String bak20="";
 String bak21="";
   String choose1="1";
   String choose2="1";
   String choose3="1";
    String choose4="1";
  String wy="select * from contractWYTK  where sectionno='"+section+"' and yong_tu='"+Type+"'";
    
	  rs=InsertBean.executeQuery(wy);
 if (rs.next()){
   a1=getbyte(rs.getString("a1"));
   a2=getbyte(rs.getString("a2"));
   a3=getbyte(rs.getString("a3"));
   a4=getbyte(rs.getString("a4"));
   a5=getbyte(rs.getString("a5"));
   a6=getbyte(rs.getString("a6"));
   a7=getbyte(rs.getString("a7"));
   a8=getbyte(rs.getString("a8"));
   a9=getbyte(rs.getString("a9"));
   a10=getbyte(rs.getString("a10"));
   a11=getbyte(rs.getString("a11"));
   a12=getbyte(rs.getString("a12"));
   a13=getbyte(rs.getString("a13"));
   a14=getbyte(rs.getString("a14"));
   a15=getbyte(rs.getString("a15"));
   bak1=getbyte(rs.getString("bak1"));
   bak2=getbyte(rs.getString("bak2"));
   bak3=getbyte(rs.getString("bak3"));
   bak4=getbyte(rs.getString("bak4"));
   bak5=getbyte(rs.getString("bak5"));
   bak6=getbyte(rs.getString("bak6"));
   bak7=getbyte(rs.getString("bak7"));
     bak8=getbyte(rs.getString("bak8"));
   bak9=getbyte(rs.getString("bak9"));
   
     bak10=getbyte(rs.getString("bak10"));
   bak11=getbyte(rs.getString("bak11"));
   bak12=getbyte(rs.getString("bak12"));
   bak13=getbyte(rs.getString("bak13"));
   bak14=getbyte(rs.getString("bak14"));
   bak15=getbyte(rs.getString("bak15"));
   bak16=getbyte(rs.getString("bak16"));
   bak17=getbyte(rs.getString("bak17"));
   bak18=getbyte(rs.getString("bak18"));
   bak19=getbyte(rs.getString("bak19"));
     bak20=getbyte(rs.getString("bak20"));
   bak21=getbyte(rs.getString("bak21"));
   choose1=getbyte(rs.getString("choose1"));
   choose2=getbyte(rs.getString("choose2")); 
   choose3=getbyte(rs.getString("choose3"));
    choose4=getbyte(rs.getString("choose4"));
	//buchongxieyi=getbyte(rs.getString("xy"));
 }
rs.close();
   sb.append("<bookmark name=\"A87\" value=\""+choose1 +"\"/>");
   sb.append("<bookmark name=\"A88\" value=\""+a1 +"\"/>");
  
    sb.append("<bookmark name=\"A89\" value=\""+a2 +"\"/>");
    sb.append("<bookmark name=\"A90\" value=\""+a3 +"\"/>");
	
    sb.append("<bookmark name=\"A91\" value=\""+a4 +"\"/>");
	
    sb.append("<bookmark name=\"A92\" value=\""+a5 +"\"/>");
	 sb.append("<bookmark name=\"A93\" value=\""+bak1 +"\"/>");
	 
  a1=JLdate.substring(0,4);
  a2=JLdate.substring(5,7);
  a3=JLdate.substring(8,10);
sb.append("<bookmark name=\"A94\" value=\""+a1 +"\"/>");

sb.append("<bookmark name=\"A95\" value=\""+a2 +"\"/>");
sb.append("<bookmark name=\"A96\" value=\""+a3 +"\"/>");

sb.append("<bookmark name=\"A97\" value=\""+"1" +"\"/>");
sb.append("<bookmark name=\"A98\" value=\""+"45" +"\"/>");
sb.append("<bookmark name=\"A99\" value=\""+bak17 +"\"/>");
sb.append("<bookmark name=\"A101\" value=\""+bak18 +"\"/>");
sb.append("<bookmark name=\"A100\" value=\""+bak19 +"\"/>");
	  
sb.append("<bookmark name=\"A102\" value=\""+choose2 +"\"/>");
sb.append("<bookmark name=\"A103\" value=\""+a6 +"\"/>");
sb.append("<bookmark name=\"A104\" value=\""+a7 +"\"/>");
sb.append("<bookmark name=\"A105\" value=\""+a8 +"\"/>");
sb.append("<bookmark name=\"A106\" value=\""+a9 +"\"/>");
sb.append("<bookmark name=\"A107\" value=\""+a10 +"\"/>");
sb.append("<bookmark name=\"A108\" value=\""+a11 +"\"/>");
String bak="";
  if (bak2.equals(""))bak="X";else bak=bak2;  
sb.append("<bookmark name=\"A109\" value=\""+bak +"\"/>");
sb.append("<bookmark name=\"A119\" value=\""+bak5+bak20 +bak21 +"\"/>");
sb.append("<bookmark name=\"A120\" value=\""+choose4+"\"/>");
sb.append("<bookmark name=\"A121\" value=\""+choose4+"\"/>");
sb.append("<bookmark name=\"A122\" value=\""+bak8+"\"/>");
sb.append("<bookmark name=\"A123\" value=\""+bak9+"\"/>");
sb.append("<bookmark name=\"A124\" value=\""+b1+"\"/>");
sb.append("<bookmark name=\"A125\" value=\""+b2+"\"/>");
sb.append("<bookmark name=\"A126\" value=\""+b3+"\"/>");
sb.append("<bookmark name=\"A127\" value=\""+b4+"\"/>");
sb.append("<bookmark name=\"A128\" value=\""+b5+"\"/>");
sb.append("<bookmark name=\"A129\" value=\""+b6+"\"/>");
sb.append("<bookmark name=\"A130\" value=\""+b7+"\"/>");
sb.append("<bookmark name=\"A131\" value=\""+b8+"\"/>");

sb.append("<bookmark name=\"A132\" value=\""+a12+"\"/>");
sb.append("<bookmark name=\"A133\" value=\""+choose3+"\"/>");
sb.append("<bookmark name=\"A134\" value=\""+a13+"\"/>");
sb.append("<bookmark name=\"A135\" value=\""+a14+"\"/>");
sb.append("<bookmark name=\"A136\" value=\""+a15+"\"/>"); 

   sb.append("<bookmark name=\"A137\" value=\""+Repalce2(bak3,"\n")+"\"/>");
 sb.append("<bookmark name=\"A138\" value=\""+Repalce2(bak4,"\n")+"\"/>");


 sb.append("<bookmark name=\"A139\" value=\""+Repalce2(bak11,"\n")+"\"/>");
 sb.append("<bookmark name=\"A140\" value=\""+Repalce2(bak12,"\n")+"\"/>");
 sb.append("<bookmark name=\"A141\" value=\""+Repalce2(bak12,"\n")+"\"/>");
 sb.append("<bookmark name=\"A142\" value=\""+Repalce2(bak13,"\n")+"\"/>");
 sb.append("<bookmark name=\"A143\" value=\""+Repalce2(bak14,"\n")+"\"/>");
sb.append("<bookmark name=\"A144\" value=\""+Type+"\"/>");

sb.append("<bookmark name=\"A145\" value=\""+Repalce2(bak7,"\n")+"\"/>");

 String paystr="2";
if (payment1.indexOf("一次性")>=0)paystr="1";

sb.append("<bookmark name=\"A146\" value=\""+paystr+"\"/>");

sb.append("<bookmark name=\"A147\" value=\""+waiqiang+"\"/>");
sb.append("<bookmark name=\"A148\" value=\""+nieqing+"\"/>");///
sb.append("<bookmark name=\"A149\" value=\""+dingpeng+"\"/>");
sb.append("<bookmark name=\"A150\" value=\""+dimian+"\"/>");
sb.append("<bookmark name=\"A151\" value=\""+mengchuang+"\"/>");
sb.append("<bookmark name=\"A152\" value=\""+chufang+"\"/>");
sb.append("<bookmark name=\"A153\" value=\""+wc+"\"/>");
sb.append("<bookmark name=\"A154\" value=\""+yangtai+"\"/>");
sb.append("<bookmark name=\"A155\" value=\""+dianti+"\"/>");
sb.append("<bookmark name=\"A156\" value=\""+other+"\"/>");
 sb.append("<bookmark name=\"A157\" value=\""+buchongxieyi+"\"/>");
 
sb.append("</document>");
out.println(sb.toString());
  %>
  
<!-- http://localhost/liwbr32.asp //-->
<OBJECT ID="BookmarkRplr" CLASSID="CLSID:D5D79C43-201A-4064-93A5-8FA6F768DF9E"
CODEBASE="liwbr32.CAB#version=1,1,0,4"></OBJECT>
<div id="renderMessage">正在下载...</div>
<script event="onload" for="window">
	execute();
</script>
<script language="javascript">
function execute(){
    BookmarkRplr.XMLString='<%=sb.toString()%>';
	BookmarkRplr.execute();
	while (BookmarkRplr.Busy){
		document.all.renderMessage.innerHTML = BookmarkRplr.Message;
	}
	document.all.renderMessage.innerHTML = BookmarkRplr.Message;
	 
}
</script>
<input type="submit" value="如果下载数据不成功或者长时间停顿，请重新点击这个按钮尝试..." onclick="execute();">
<%//}catch(Exception s){  out.print(s.getMessage());out.close();}%>   
   