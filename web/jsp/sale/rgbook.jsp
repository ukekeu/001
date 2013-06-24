<%@ page contentType="teXt/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<HTML><HEAD><TITLE>房地产买卖认购书</TITLE>
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
	 String secno=getbyte2(request.getParameter("secno"));
     String loft=getbyte2(request.getParameter("loft"));
	 String roomno=getbyte2(request.getParameter("roomno"));
	 String floors=request.getParameter("Floor");
	 String  code=request.getParameter("code");
	 //读取业主资料
	 String SQL="SELECT DATEDIFF(DD,o.VISADATE ,o.JLDATE) CD,c.cus_name,c.phone+' '+c.sj phone,c.id_card,c.zip_code,c.address,";
	 SQL+="o.section,o.loft,o.room_no,o.xiaoshoutype,o.floors,o.jzarea,o.area,dateadd(dd,30,visadate) ajdate,o.yong_tu,";
	 SQL+="o.jzarea-o.area ft,o.subscription,o.count_type,o.rmbprice,o.rmbprice-o.ajmoney firstMoney,(o.rmbprice-o.ajmoney)*1.0/o.rmbprice*100 firstbl,o.rmbprice/o.area tnunitprice,o.rmbprice/o.jzarea unitprice,o.payment1,o.JLdate,o.ajyear,o.ajmoney,o.ajmoney*100.0/o.rmbprice ajb,o.visadate,DATEDIFF(dd,o.visadate,o.jldate) num,datediff(dd,dateadd(dd,30,visadate),o.jldate) num1 from order_contract o,customer c where c.serialno=o.customer and o.section='"+secno+"'";
	 SQL+=" and o.loft='"+loft+"' and o.room_no='"+roomno+"' and floors="+floors;
	String   SQL1="UPDATE ORDER_CONTRACT SET printrg=1 where section='"+secno+"'";
	 SQL1+=" and loft='"+loft+"' and room_no='"+roomno+"' and floors="+floors;
     InsertBean.executeUpdate(SQL1);
	 ResultSet rs=InsertBean.executeQuery(SQL);
	
	 String cus_name="",id_card="",zip_code="",phone="",address="",Type="";
	 String section="", room_no="", tnunitprice="",ajdate="",subscription="";
	  String jzarea="",tnarea="",ft="",uppercaseMoney="",unitprice="",firstMoney="",firstbl="";
	 boolean xiaoshoutype=false,count_type=false;
	 int xcnum=0,ysnum=0,cd=0;
	 String yroomno="";
	 String payment1="",JLdate="",ajb="",ajmoney="",ajyear="",visadate="";
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
		//ajdate=rs.getDate("ajdate").toString();
		ft=FormtD.getFloat1(rs.getFloat("ft"),2);
		 
		subscription=rs.getString("subscription");
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
		//visadate=rs.getDate("visadate").toString();
		xcnum=rs.getInt("num");
		ysnum=rs.getInt("num1");
	 }
	 rs.close();
	%> <%// jys,
	StringTokenizer st22 = new StringTokenizer(cus_name,"/") ;
	int count2 = st22.countTokens() ;
	String cusname1="",cusname2="〤",cusname3="〤",cusname4="〤";
	String tel1="〤",tel2="〤",tel3="〤",tel4="〤";
	String zjh1="〤",zjh2="〤",zjh3="〤",zjh4="〤";
	int ddd=0;
	while (st22.hasMoreElements()) {
	   if (ddd==0)cusname1=(String)st22.nextElement();
	   else if (ddd==1)cusname2=(String)st22.nextElement();
	    else if (ddd==2)cusname3=(String)st22.nextElement();
		else if (ddd==3)cusname4=(String)st22.nextElement();
	   ddd++;
	}
	st22 = new StringTokenizer(phone,"/") ;
	ddd=0;
	while (st22.hasMoreElements()) {
	   if (ddd==0)tel1=(String)st22.nextElement();
	   else if (ddd==1)tel2=(String)st22.nextElement();
	    else if (ddd==2)tel3=(String)st22.nextElement();
		else if (ddd==3)tel4=(String)st22.nextElement();
	   ddd++;
	}
	st22 = new StringTokenizer(id_card,"/") ;
	ddd=0;
	while (st22.hasMoreElements()) {
	   if (ddd==0)zjh1=(String)st22.nextElement();
	   else if (ddd==1)zjh2=(String)st22.nextElement();
	    else if (ddd==2)zjh3=(String)st22.nextElement();
		else if (ddd==3)zjh4=(String)st22.nextElement();
	   ddd++;
	}
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
 
 
String tmpDoc = "rgbook.doc";
String url = "http://"+request.getServerName()+":"+request.getServerPort()+"/bjhcrm/jsp/sale/"+tmpDoc;
 
StringBuffer sb = new StringBuffer();
sb.append("<document>");
sb.append("<doc url=\""+url+"\"/>");
sb.append("<bookmark name=\"A1\" value=\""+developcom+"\"/>");
sb.append("<bookmark name=\"A2\" value=\""+zzzsh+"\"/>");
 
sb.append("<bookmark name=\"A3\" value=\""+fr+"\"/>");
sb.append("<bookmark name=\"A4\" value=\""+phone2+"\"/>"); 
 
sb.append("<bookmark name=\"p1\" value=\""+cusname1+"\"/>");
sb.append("<bookmark name=\"p2\" value=\""+zjh1+"\"/>");
 
sb.append("<bookmark name=\"p3\" value=\""+tel1+"\"/>");
sb.append("<bookmark name=\"p4\" value=\""+cusname2+"\"/>");
sb.append("<bookmark name=\"p5\" value=\""+zjh2+"\"/>");
 
sb.append("<bookmark name=\"p6\" value=\""+tel2+"\"/>");
sb.append("<bookmark name=\"p7\" value=\""+cusname3+"\"/>");
sb.append("<bookmark name=\"p8\" value=\""+zjh3+"\"/>");
 
sb.append("<bookmark name=\"p9\" value=\""+tel3+"\"/>");
sb.append("<bookmark name=\"p10\" value=\""+cusname4+"\"/>");
sb.append("<bookmark name=\"p11\" value=\""+zjh4+"\"/>");
 
sb.append("<bookmark name=\"p12\" value=\""+tel4+"\"/>");

sb.append("<bookmark name=\"p13\" value=\""+name+"\"/>");

sb.append("<bookmark name=\"p14\" value=\""+loft+"\"/>");
 
sb.append("<bookmark name=\"p16\" value=\""+yroomno+"\"/>");
sb.append("<bookmark name=\"p17\" value=\""+Type+"\"/>");

sb.append("<bookmark name=\"p18\" value=\""+tnarea+"\"/>");
sb.append("<bookmark name=\"p19\" value=\""+jzarea+"\"/>");

sb.append("<bookmark name=\"p20\" value=\""+a1+"\"/>");
sb.append("<bookmark name=\"p21\" value=\""+a2+"\"/>");
sb.append("<bookmark name=\"p22\" value=\""+a3+"\"/>");

 if (!cq_ed.equals("")){
  a1=cq_ed.substring(0,4);
  a2=cq_ed.substring(5,7);
  a3=cq_ed.substring(8,10);
}
sb.append("<bookmark name=\"p23\" value=\""+a1+"\"/>");
sb.append("<bookmark name=\"p24\" value=\""+a2+"\"/>");
sb.append("<bookmark name=\"p25\" value=\""+a3+"\"/>");
 
   
	
	   String p1="〤",p2="〤",p3="〤",p4="〤",p5="〤",p6="〤",p7="〤",p8="〤";
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
	  
      
	  sb.append("<bookmark name=\"p27\" value=\""+p1 +"\"/>");
	  sb.append("<bookmark name=\"p28\" value=\""+p2 +"\"/>");
	  sb.append("<bookmark name=\"p29\" value=\""+p3 +"\"/>");
	  sb.append("<bookmark name=\"p30\" value=\""+p4 +"\"/>");
	  sb.append("<bookmark name=\"p31\" value=\""+p5 +"\"/>");
	  sb.append("<bookmark name=\"p32\" value=\""+p6+"\"/>");
	  sb.append("<bookmark name=\"p33\" value=\""+p7+"\"/>");
	  sb.append("<bookmark name=\"p34\" value=\""+p8 +"\"/>");
	  sb.append("<bookmark name=\"p35\" value=\""+uppercaseMoney +"\"/>");
      sb.append("<bookmark name=\"p36\" value=\""+tnunitprice +"\"/>");
      
	  p1="〤";p2="〤";p3="〤";p4="〤";p5="〤";p6="〤";p7="〤";p8="〤";
	  
	    execRs=InsertBean1.executeQuery("exec dbo.L2U "+subscription+",1 ");//大写金额转换存储过程
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
	  
	  
      
	  
	 // sb.append("<bookmark name=\"p37\" value=\""+p1 +"\"/>");
	  sb.append("<bookmark name=\"p38\" value=\""+p2 +"\"/>");
	   sb.append("<bookmark name=\"p39\" value=\""+p3 +"\"/>");
	   sb.append("<bookmark name=\"p40\" value=\""+p4+"\"/>");
	    sb.append("<bookmark name=\"p41\" value=\""+p5+"\"/>");
	   sb.append("<bookmark name=\"p42\" value=\""+p6 +"\"/>");
	  sb.append("<bookmark name=\"p43\" value=\""+subscription +"\"/>");
	  
     sb.append("<bookmark name=\"p45\" value=\""+floors +"\"/>");
     
	  
  String pa1=" " ;
 if (payment1.indexOf("一次")>=0){pa1="一";}
 else if (payment1.indexOf("分期")>=0){pa1="二";}
 else {pa1="三";}
   sb.append("<bookmark name=\"p37\" value=\""+pa1 +"\"/>");
   
     
 
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
   