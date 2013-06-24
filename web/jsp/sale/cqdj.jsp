<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>私有房地产权登记申请审批表</title>
<STYLE type=text/css>
BODY {
	FONT-SIZE: 15pt; LINE-HEIGHT: 10pt; FONT-FAMILY: 宋体
}
tr {
	FONT-SIZE: 10pt;  FONT-FAMILY: 宋体
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
</head>
<%
String htno=getbyte1(request.getParameter("htno"));
String nocq="";
 String SQLcq="SELECT * FROM  cq_bak WHERE contractno="+htno;
	  ResultSet rscq=ViewBean.executeQuery(SQLcq) ;
	  if (rscq.next())	{
	    nocq=rscq.getString("state");
		if (!nocq.equals("0"))nocq="checked";
		
	   }
	  rscq.close();
 if (nocq.equals("checked")){
 %>
 <script>
 alert("业主要求不办理产权，详情请看备注");window.close();
 </script>
 <%
  }
 
String chho=getbyte1(request.getParameter("chho"));
 String secno="";
 String Loft="";
 String room="";
 
  secno=getbyte1(request.getParameter("SecNo"));
  Loft=getbyte1(request.getParameter("Loft"));
  room=getbyte1(request.getParameter("room"));
  
 String SQL="SELECT o.contractno,o.yong_tu,o.code,c.cus_age,c.cus_name,c.ID_Card,c.cus_sex,c.address,c.phone,c.sj,o.sectionname,o.loft,o.room_no,";
        SQL+="o.visadate,o.area,o.jzarea,o.jzarea-o.area ftarea,o.room_sumprice/o.area ";
		SQL+="tnunitprice,o.room_sumprice/o.jzarea jzunitprice,o.room_sumprice,";
		SQL+="o.lu_tai_area,o.lu_tai_area_price,o.lu_tai_area*o.lu_tai_area_price luprice";
		SQL+=",o.gaizhang_area,o.gaizhang_unitprice,o.gaizhang_area*o.gaizhang_unitprice gzprice,cq_no,q_tax,q_tax_rate*100 q_tax_rate ";
		
		SQL+=" FROM ORDER_CONTRACT o,customer c WHERE o.state<>3 and o.customer=c.serialno and o.section='"+secno+"'";
        SQL+=" and o.loft='"+Loft+"' and o.room_no='"+room+"'";
   

 String cus_name="",phone="",sj="",sectionname="",loft="",card_id="",visadate="";
   String room_no="",area="",jzarea="",ftarea="",tnunitprice="",address="";
   String gaizhang_area="",gaizhang_unitprice="",gzprice="",cus_sex="",code="";
   String jzunitprice="",room_sumprice="",lu_tai_area="",lu_tai_area_price="",luprice="";
   String yong_tu="",cus_age="",cq_no="",q_tax="",q_tax_rate="",contractno="";
    ResultSet rs=ViewBean.executeQuery(SQL);
  
	
	if (rs.next()){
	   contractno=getbyte(rs.getString("contractno"));
	   yong_tu=getbyte(rs.getString("yong_tu"));
	   code=getbyte(rs.getString("code"));
	   cus_age=getbyte(rs.getString("cus_age"));
	   cus_name=getbyte(rs.getString("cus_name"));
	   card_id=getbyte(rs.getString("ID_Card"));
	   cus_sex=getbyte(rs.getString("cus_sex"));
	   address=getbyte(rs.getString("address"));
	   phone=getbyte(rs.getString("phone"));
	   sj=getbyte(rs.getString("sj"));
	   sectionname=getbyte(rs.getString("sectionname"));
	   loft=getbyte(rs.getString("loft"));
	   room_no=getbyte(rs.getString("room_no"));
	   visadate=getbyte(rs.getString("visadate"));
	   if (!visadate.equals(""))visadate=visadate.substring(0,10);
	   area=Format.getFloat1(rs.getFloat("area"),3);
	   jzarea=Format.getFloat1(rs.getFloat("jzarea"),3);
	   ftarea=Format.getFloat1(rs.getFloat("ftarea"),3);
	   tnunitprice=Format.getFloat1(rs.getFloat("tnunitprice"),2);
	   jzunitprice=Format.getFloat1(rs.getFloat("jzunitprice"),2);
	   room_sumprice=Format.getFloat1(rs.getFloat("room_sumprice"),2);
	   lu_tai_area=Format.getFloat1(rs.getFloat("lu_tai_area"),3);
	   lu_tai_area_price=Format.getFloat1(rs.getFloat("lu_tai_area_price"),2);
	   luprice=Format.getFloat1(rs.getFloat("luprice"),2); 
	   gaizhang_area=Format.getFloat1(rs.getFloat("gaizhang_area"),3);
	   gaizhang_unitprice=Format.getFloat1(rs.getFloat("gaizhang_unitprice"),2);
	   gzprice=Format.getFloat1(rs.getFloat("gzprice"),2);
	   cq_no=getbyte(rs.getString("cq_no"));
	   q_tax_rate=getbyte(rs.getString("q_tax_rate"));
	   q_tax=getbyte(rs.getString("q_tax"));
	}
	rs.close();
	
	if (code.equals("")){%>
	<script>alert("不存在此房资料");window.close();</script>
	<%
	out.close();}
	  String dh="";
	  String th="";
	  String jg="";
	  String floors="";
	
	  String date="";
	 
	  String jj="";
	
	  String jz="";

	  String ts="";
	  String  qsxz="",syx="",htn="";
	  String p1="",p2="",p3="",p4="",p5="",p6="",p7="",cq_addr="";
	SQL="SELECT * FROM LoftBuildCode WHERE SecNo='"+secno+"'";
    SQL+=" and loft='"+Loft+"'";
	rs=ViewBean.executeQuery(SQL);
    if (rs.next()){
	    jg=getbyte(rs.getString("JieGou"));
		
	    floors=getbyte(rs.getString("floors"));
        dh=getbyte(rs.getString("DiHao"));
	    th=getbyte(rs.getString("tuHao"));
	    
	    date=getbyte(rs.getString("JianChenDate"));
	    jj=getbyte(rs.getString("JianZhuJiDi_area"));
	    jz=getbyte(rs.getString("JianZhuSum_area"));
	    ts=getbyte(rs.getString("ZongNum"));
	    if (!date.equals(""))date=date.substring(0,10);
		p1=getbyte(rs.getString("p1"));
		p2=getbyte(rs.getString("p2"));
		p3=getbyte(rs.getString("p3"));
		p4=getbyte(rs.getString("p4"));
	    p5=getbyte(rs.getString("p5"));
	    cq_addr=getbyte(rs.getString("cq_addr"));
		qsxz=getbyte(rs.getString("tdxz"));
		syx=getbyte(rs.getString("fwxz"));
         htn=getbyte(rs.getString("htwh"));
		 qsxz=getbyte(rs.getString("fwxz"));
		 syx=getbyte(rs.getString("tdxz"));
	}
	rs.close(); 
	String SaleArea="",cq_sd="",cq_ed="",useyear="";
	String y="",m="",d="",ftjd_area="",AreaNo="";
	String y1="",m1="",d1="",GroundArea="",developcom="";
	
   SQL="SELECT SaleArea, cq_sd, cq_ed ,useyear,GroundArea,developcom,AreaNo FROM crm_project WHERE SerialNo='"+secno+"'";
   rs=ViewBean.executeQuery(SQL);
    if (rs.next()){
	   SaleArea=getbyte(rs.getString("SaleArea"));
	   cq_sd=getbyte(rs.getString("cq_sd"));
	   cq_ed=getbyte(rs.getString("cq_ed"));
	   useyear=getbyte(rs.getString("useyear"));
	   GroundArea=Format.getFloat1(rs.getFloat("GroundArea"),2);
	   if (!cq_sd.equals("")){
	   cq_sd=cq_sd.substring(0,10);
	
	   y=cq_sd.substring(0,4);
	   cq_sd=cq_sd.substring(5,10);
	   m=cq_sd.substring(0,2);
	   d=cq_sd.substring(3);
	   }
	   if (!cq_ed.equals(""))cq_ed=cq_ed.substring(0,10);
	   developcom=getbyte(rs.getString("developcom"));
	   AreaNo=getbyte(rs.getString("AreaNo"));
	   
	   
	}
	rs.close(); 
	String ApportionArea="",s_year="",e_year="";
	SQL=" select ftjd_area,area,UsedArea, ApportionArea,e_year,s_year FROM room WHERE seccode='"+secno+"'";
    SQL+=" and  loft='"+Loft+"' and room_code='"+room+"'";
	  rs=ViewBean.executeQuery(SQL);
    if (rs.next()){
	  ftjd_area=Format.getFloat1(rs.getFloat("ftjd_area"),2);
	  s_year=getbyte(rs.getString("s_year"));
	  e_year=getbyte(rs.getString("e_year"));
	  //jzarea=Format.getFloat1(rs.getFloat("area"),2);
	 // UsedArea=Format.getFloat1(rs.getFloat("UsedArea"),2);
	  ApportionArea=Format.getFloat1(rs.getFloat("ApportionArea"),2);
	}
	rs.close();
	String jzzd_area="",ft="";
	SQL=" SELECT htno,ftyd_area,jzzd_area,s_year,e_year,yong_tu,htn FROM CQ_DJ where htno="+code;
	  rs=ViewBean.executeQuery(SQL);
 
	  if (rs.next()){
	
	     cq_sd=getbyte(rs.getString("s_year"));
	     cq_ed=getbyte(rs.getString("e_year"));
		 if (cq_sd.equals(""))cq_sd=s_year;
		 if (cq_ed.equals(""))cq_ed=e_year;
	    if (!cq_sd.equals("")){
	     cq_sd=cq_sd.substring(0,10);
	     y=cq_sd.substring(0,4);
	     cq_sd=cq_sd.substring(5,10);
	     m=cq_sd.substring(0,2);
	     d=cq_sd.substring(3);
	     }
	     if (!cq_ed.equals("")){
	     cq_ed=cq_ed.substring(0,10);
	     y1=cq_ed.substring(0,4);
	     cq_ed=cq_ed.substring(5,10);
	     m1=cq_ed.substring(0,2);
	     d1=cq_ed.substring(3);
	     }
		jzzd_area=getbyte(rs.getString("jzzd_area"));
		 ft=getbyte(rs.getString("ftyd_area"));
		 
	  }
	  rs.close();
	  
	  
	  String tmpDoc = "rgbook.doc";
String url = "http://"+request.getServerName()+":"+request.getServerPort()+"/bjhcrm/jsp/sale/"+tmpDoc;
String cusname="",cardid="";
 if (cus_name.indexOf("/")>0){cusname=cus_name.substring(0,cus_name.indexOf("/"));}else{cusname=cus_name;}
 if (card_id.indexOf("/")>0){cardid=card_id.substring(0,card_id.indexOf("/"));}else{cardid=card_id;} 
 
 
	String age="";
	if (card_id.indexOf("/")>0){age=card_id.substring(0,card_id.indexOf("/"));
	
	}else{age=card_id;}
	String sex="";
	if (age.length()==15||age.length()==18)
	  sex=age.substring(age.length() -1) ;
	if (!sex.equals("")){
	    try{ if (Integer.parseInt(sex)%2==0&&Integer.parseInt(sex)!=0) cus_sex="女";
		 else cus_sex="男";
		 }catch(Exception s){ cus_sex="无";}
		}
 
	if (age.length()==15){age=age.substring(6,10);}
	else if (age.length()==18){age=age.substring(8,12);}
 
StringBuffer sb = new StringBuffer();
sb.append("<document>");
sb.append("<doc url=\""+url+"\"/>");
sb.append("<bookmark name=\"A1\" value=\""+cusname+"\"/>");
sb.append("<bookmark name=\"A2\" value=\""+cus_sex+"\"/>");
sb.append("<bookmark name=\"A3\" value=\""+age+"\"/>");
sb.append("<bookmark name=\"A4\" value=\""+cardid+"\"/>");
sb.append("<bookmark name=\"A5\" value=\" \"/>");
sb.append("<bookmark name=\"A6\" value=\" \"/>");
//共有人
 SQL="SELECT * FROM cq_gyrqk WHERE htno="+code;
 rs=ViewBean.executeQuery(SQL);
 int num11=1;
while (rs.next()){
 if (num11==1){
sb.append("<bookmark name=\"B1\" value=\""+rs.getString("cusname")+" \"/>");
sb.append("<bookmark name=\"B2\" value=\""+rs.getString("sex")+" \"/>");
sb.append("<bookmark name=\"B3\" value=\""+rs.getString("age")+" \"/>");
sb.append("<bookmark name=\"B4\" value=\""+rs.getString("id") +" \"/>");
sb.append("<bookmark name=\"B5\" value=\""+rs.getString("gx")+" \"/>");
sb.append("<bookmark name=\"B6\" value=\""+rs.getString("num")+" \"/>");
}else  if (num11==2){

sb.append("<bookmark name=\"C1\" value=\""+rs.getString("cusname")+" \"/>");
sb.append("<bookmark name=\"C2\" value=\""+rs.getString("sex")+" \"/>");
sb.append("<bookmark name=\"C3\" value=\""+rs.getString("age")+" \"/>");
sb.append("<bookmark name=\"C4\" value=\""+rs.getString("id") +" \"/>");
sb.append("<bookmark name=\"C5\" value=\""+rs.getString("gx")+" \"/>");
sb.append("<bookmark name=\"C6\" value=\""+rs.getString("num")+" \"/>");

 }else  if (num11==3){
 
 sb.append("<bookmark name=\"D1\" value=\""+rs.getString("cusname")+" \"/>");
sb.append("<bookmark name=\"D2\" value=\""+rs.getString("sex")+" \"/>");
sb.append("<bookmark name=\"D3\" value=\""+rs.getString("age")+" \"/>");
sb.append("<bookmark name=\"D4\" value=\""+rs.getString("id") +" \"/>");
sb.append("<bookmark name=\"D5\" value=\""+rs.getString("gx")+" \"/>");
sb.append("<bookmark name=\"D6\" value=\""+rs.getString("num")+" \"/>");
 
 }num11++;
 }
 rs.close();
 sb.append("<bookmark name=\"E0\" value=\""+developcom+" \"/>");
sb.append("<bookmark name=\"E1\" value=\""+room_sumprice+" \"/>");
sb.append("<bookmark name=\"E3\" value=\""+q_tax_rate+" \"/>");
sb.append("<bookmark name=\"E4\" value=\""+q_tax+" \"/>");
sb.append("<bookmark name=\"E5\" value=\""+AreaNo+sectionname+loft+" \"/>");
sb.append("<bookmark name=\"E6\" value=\""+room_no+"房全套 \"/>");
sb.append("<bookmark name=\"E7\" value=\""+jzarea+" \"/>");
sb.append("<bookmark name=\"E8\" value=\""+visadate+"购买 \"/>");
sb.append("<bookmark name=\"E9\" value=\"私有 \"/>");
sb.append("<bookmark name=\"E10\" value=\""+yong_tu+" \"/>");

sb.append("<bookmark name=\"E11\" value=\""+jg+" \"/>");
sb.append("<bookmark name=\"E12\" value=\""+floors+" \"/>");
sb.append("<bookmark name=\"E13\" value=\""+date+" \"/>");


sb.append("<bookmark name=\"E14\" value=\""+jj+" \"/>");
sb.append("<bookmark name=\"E15\" value=\""+jz+" \"/>");
sb.append("<bookmark name=\"E16\" value=\""+date+" \"/>");

sb.append("<bookmark name=\"F1\" value=\"自墙 \"/>");
sb.append("<bookmark name=\"F2\" value=\"自墙 \"/>");
sb.append("<bookmark name=\"F3\" value=\"自墙 \"/>");
sb.append("<bookmark name=\"F4\" value=\"自墙 \"/>");

sb.append("<bookmark name=\"F5\" value=\""+p1+" \"/>");
sb.append("<bookmark name=\"F6\" value=\""+p2+" \"/>");
sb.append("<bookmark name=\"F7\" value=\""+p3+" \"/>");
sb.append("<bookmark name=\"F8\" value=\""+p4+" \"/>");
sb.append("<bookmark name=\"F9\" value=\""+dh+" \"/>");
sb.append("<bookmark name=\"F10\" value=\""+th+" \"/>");
sb.append("<bookmark name=\"F11\" value=\""+syx+" \"/>");
sb.append("<bookmark name=\"F12\" value=\""+p5+" \"/>");
sb.append("<bookmark name=\"F13\" value=\""+ft+" \"/>");
sb.append("<bookmark name=\"F14\" value=\""+jzzd_area+" \"/>");
sb.append("<bookmark name=\"F15\" value=\""+htn+" \"/>");
sb.append("<bookmark name=\"F16\" value=\""+yong_tu+" \"/>");


sb.append("<bookmark name=\"F17\" value=\""+y+" \"/>");
sb.append("<bookmark name=\"F18\" value=\""+m+" \"/>");
sb.append("<bookmark name=\"F19\" value=\""+d+" \"/>");
sb.append("<bookmark name=\"F20\" value=\""+y1+" \"/>");
sb.append("<bookmark name=\"F21\" value=\""+m1+" \"/>");
sb.append("<bookmark name=\"F22\" value=\""+d1+" \"/>");
sb.append("</document>");
out.println(sb.toString());
 
  %>
 
<body>
<DIV align=center id="printdiv">
注意:在打印之前必须设置纸张及距，在菜单"文件"中选择"页面设置",<br><br>选择纸张类型"a4",方向选择"纵向",边距"左为20"，上为"20"，右为15，下为10
  <!--<input class="buttoninput" type="button" value="打印预览" onclick="window.printdiv.style.display='none';factory.printing.Preview();"> -->
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
  <center>
  <div align=left id=report1 style="background-color:#F7F7F7;height:200%;overflow:auto;width:90%;z-index:2" contentEditable>
 <table width="98%"  border=0 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr height="10"  >
    <td width="37"> </td>
    <td width="37">&nbsp;&nbsp;</td>
    <td width="72"> <br> </td>
    <td width="80">&nbsp;&nbsp;</td>
    <td width="62"> </td>
    <td width="122"> </td>
    <td width="49"></td>
    <td width="255" colspan="3">&nbsp;&nbsp;</td>
    <td width="120" colspan="2"></td>
  </tr>
  <tr height="30" valign="bottom" >
    <td width="100" colspan="2" align="center"> </td>
    <td width="320" colspan="4" align="left"><br><%if (cus_name.indexOf("/")>0){out.println(cus_name.substring(0,cus_name.indexOf("/")));}else{out.println(cus_name);} %></td>
    <td width="144" colspan="2"> </td>
    <td width="255" colspan="2"  ><br>&nbsp;&nbsp;<%if (card_id.indexOf("/")>0){out.println(card_id.substring(0,card_id.indexOf("/")));}else{out.println(card_id);} %></td>
    <td width="120" colspan="2">　</td>
  </tr>
  <tr height="5"  >
    <td width="37"> </td>
    <td width="37">&nbsp;&nbsp;</td>
    <td width="72"> <br> </td>
    <td width="80">&nbsp;&nbsp;</td>
    <td width="62"> </td>
    <td width="122"> </td>
    <td width="49"></td>
    <td width="255" colspan="3">&nbsp;&nbsp;</td>
    <td width="120" colspan="2"></td>
  </tr>
  <tr height="26"  valign="top" >
     <td width="37"><%
	   age="";
	if (card_id.indexOf("/")>0){age=card_id.substring(0,card_id.indexOf("/"));
	
	}else{age=card_id;}
	  sex="";
	if (age.length()==15||age.length()==18)
	  sex=age.substring(age.length() -1) ;
	if (!sex.equals("")){
	    try{ if (Integer.parseInt(sex)%2==0&&Integer.parseInt(sex)!=0) cus_sex="女";
		 else cus_sex="男";
		 }catch(Exception s){ cus_sex="无";}
		}
	out.println(cus_sex);
	//if (cus_sex.indexOf("/")>0){out.println(cus_sex.substring(0,cus_sex.indexOf("/")));}else{out.println(cus_sex);} %></td>
    <td width="72"> <br> </td>
    <td width="80"><%
	if (age.length()==15){age=age.substring(6,10);}
	else if (age.length()==18){age=age.substring(8,12);}
	out.print(age);
	 %></td>
    <td width="62"> </td>
	   <td width="37"> </td>
    <td width="122" align="center">&nbsp; </td>
    <td width="49"></td>
    <td width="255" colspan="3">&nbsp;<%=address %></td>
    <td width="120" colspan="2"></td>
  </tr>
  <tr height="10"  >
    <td width="148" colspan="3"> </td>
    <td width="647" colspan="7" align="center">&nbsp;</td>
    <td width="120" colspan="2">　</td>
  </tr>
  <tr height="30"  valign="top" >
    <td width="148" colspan="3"> </td>
    <td width="647" colspan="7"  >&nbsp;&nbsp;&nbsp;<%=cq_addr %></td>
    <td width="120" colspan="2">　</td>
  </tr>
     <tr height="20"   > 
    <td width="100" colspan="3"> </td>
    <td width="280" colspan="3" align="left">&nbsp;&nbsp;&nbsp;<%if (developcom.indexOf(" ")>=0){out.print(developcom.substring(0,developcom.indexOf(" ")));}else{out.print(developcom);} %></td>
    <td width="144" colspan="2"> </td>
    <td width="255" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<%=cq_no %></td>
    <td width="120" colspan="2">　</td>
  </tr>
  <tr height="20"  >
    <td width="148" colspan="3"> </td>
    <td width="647" colspan="7" align="center">&nbsp;</td>
    <td width="120" colspan="2">　</td>
  </tr>
  <tr height="20" valign="top">
    <td width="148" colspan="3"> </td>
    <td width="242" colspan="3" v>&nbsp;&nbsp;&nbsp;<%=visadate %>购买</td>
    <td width="144" colspan="2"> </td>
    <td width="210" valign="top" colspan="2">&nbsp;&nbsp;&nbsp;<%=loft+room_no+"号房,<br>全套" %><%=jzarea  %>M<sup>2</sup></td>
    <td width="120" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=syx %></td>
  </tr>
  <tr height="40" valign="bottom">
    <td width="148" colspan="3"> </td>
    <td width="242" colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;出让</td>
    <td width="144" colspan="2"> </td>
    <td width="120">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=yong_tu %></td>
    <td width="199" align="right"  colspan="3">&nbsp;<%= qsxz%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
    <tr height="10"  >
    <td width="148" colspan="3"> </td>
    <td width="647" colspan="7" align="center">&nbsp;</td>
    <td width="120" colspan="2">　</td>
  </tr>
  <tr height="40" valign="top">
    <td width="148" colspan="3"> </td>
    <td width="242" colspan="3" align="center"><%=dh %></td>
    <td width="270" colspan="3"> </td>
    <td width="205" colspan="3">&nbsp;&nbsp;&nbsp;<%=th %></td>
  </tr>
    <tr height="20">
    <td width="148" colspan="3"> </td>
    <td width="242" colspan="3" align="center"></td>
    <td width="270" colspan="3"> </td>
    <td width="205" colspan="3">&nbsp;&nbsp;&nbsp;</td>
  </tr>
  <tr height="30" valign="top">
    <td width="148" colspan="3"> </td>
    <td width="242" colspan="3" align="center" valign="top"><%=jg %></td>
    <td width="144" colspan="2"> </td>
    <td width="120" valign="top">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=floors %></td>
    <td width="142" colspan="2"> </td>
    <td width="57" align="right" valign="top"><%if (!date.equals("")){out.println(date.substring(0,7));} %>&nbsp;&nbsp;&nbsp;</td>
  </tr>
  <tr height="30" valign="top">
    <td width="148" colspan="3"> </td>
    <td width="114" colspan="3" align="center">&nbsp;&nbsp;&nbsp;<%=jj %></td>
    <td width="144" colspan="2"> </td>
    <td width="331" colspan="4" align="center">&nbsp; &nbsp;&nbsp;<%=jz %></td>
  </tr>
  <tr height="30">
    <td width="148" colspan="3"> </td>
    <td width="114" colspan="2"></td>
    <td width="177" colspan="2"></td>
    <td width="285" colspan="3"></td>
    <td width="135" colspan="2"></td>
  </tr>
  <tr height="15">
    <td width="148" colspan="3"> </td>
    <td width="114" colspan="2"></td>
    <td width="177" colspan="2"></td>
    <td width="285" colspan="3"></td>
    <td width="135" colspan="2"></td>
  </tr>
  <tr valign="top" height="30">
    <td width="148" colspan="3"> </td>
    <td width="114" colspan="2" align="center">自墙</td>
    <td width="177" colspan="2" align="center">自墙</td>
    <td width="285" colspan="3" align="center">自墙</td>
    <td width="135" colspan="2">自墙</td>
  </tr>
 <tr valign="bottom" height="10">
    <td width="148" colspan="3"> </td>
    <td width="114" colspan="2" align="right"> </td>
    <td width="177" colspan="2" align="right"> </td>
    <td width="285" colspan="3" align="center"> </td>
    <td width="135" colspan="2"> </td>
  </tr>
  <tr  height="30">
    <td width="148" colspan="3"> </td>
    <td width="114" colspan="2" align="center"><%=p1 %></td>
    <td width="177" colspan="2" align="center"><%=p2 %></td>
    <td width="285" colspan="3" align="center"><%=p3 %></td>
    <td width="135" colspan="2"><%=p4 %></td>
  </tr>
    <tr valign="bottom" height="20">
    <td width="148" colspan="3"> </td>
    <td width="114" colspan="2" align="right"> </td>
    <td width="177" colspan="2" align="right"> </td>
    <td width="285" colspan="3" align="center"> </td>
    <td width="135" colspan="2"> </td>
  </tr>
 <tr height="30" valign="top">
    <td width="37" rowspan="7">　</td>
    <td width="105" colspan="2">　</td>
    <td width="242" colspan="3">　</td>
    <td width="460" colspan="6" align="right"><%=p5 %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
  <tr height="30" valign="top">
  <!-- <td width="27" rowspan="3">　</td>--> 
    <td width="72">　</td>
    <td width="242" colspan="3">　</td>
    <td width="481" colspan="6" align="right"><%=ft %>&nbsp;&nbsp;&nbsp;</td>
   </tr>
  <tr height="30">
    <td width="72"></td>
    <td width="242" colspan="3">　</td>
    <td width="481" colspan="6" align="right"><%=jzzd_area %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
 
  </tr>
  <tr height="35">
    <td width="72">　</td>
    <td width="242" colspan="3">　</td>
    <td width="481" colspan="6">　</td>
  </tr>
  <tr height="20">
    <td width="105" colspan="2">  </td>
    <td width="242" colspan="3">市国土局房产局</td>
    <td width="481" colspan="6" align="right"><%=htn %>&nbsp;&nbsp;&nbsp;　&nbsp;&nbsp;&nbsp;　&nbsp;&nbsp;&nbsp;　</td>
  </tr>
  <tr  height="50">
    <td width="105" colspan="2">　</td>
     <td width="723" colspan="9"><%="&nbsp;&nbsp;&nbsp;&nbsp;"+y+"&nbsp;&nbsp;"+m+"&nbsp;&nbsp;"+d %>&nbsp;&nbsp;<%="&nbsp;&nbsp;"+y1+"&nbsp;&nbsp;&nbsp;&nbsp;"+m1+"&nbsp;&nbsp;&nbsp;&nbsp;"+d1 %></td>

  </tr>
  <tr height="30">
    <td width="305" colspan="3" align="center"> </td>
     <td width="423" colspan="8"><%=yong_tu %>　 </td>

  </tr>
  <tr height="30">
    <td width="37" rowspan="2"></td>
    <td width="105" colspan="2">　</td>
    <td width="242" colspan="3">　</td>
    <td width="481" colspan="6">　</td>
  </tr>
  <tr height="30">
    <td width="105" colspan="2">　</td>
    <td width="242" colspan="3">　</td>
    <td width="481" colspan="6">　</td>
  </tr>
</table>
</div>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
  <div align=left id=report1 style="background-color:#F7F7F7;height:200%;overflow:auto;width:90%;z-index:2" contentEditable>
<!--第二页--> 
<%
 
 SQL="SELECT * FROM cq_gyrqk WHERE htno="+code;
		  rs=ViewBean.executeQuery(SQL);
		

 %> 
 <table width="90%"  border=0 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr height="30">
    <td width="100%" colspan="8">　</td>
  </tr>
 <tr height="30">
    <td width="100%" colspan="8">　</td>
  </tr>
  <%int num1=1;
		 while (rs.next()){
  %>
  <tr height="30">
    <td width="14%"><%=rs.getString("cusname") %></td>
    <td width="6%"><%=rs.getString("sex") %></td>
    <td width="13%"><%=rs.getString("age") %></td>
    <td width="13%"><%=rs.getString("jg") %></td>
    <td width="16%"><%=rs.getString("id") %></td>
    <td width="15%"><%=rs.getString("gx") %></td>
    <td width="10%"><%=rs.getString("num") %></td>
    <td width="16%"><%=rs.getString("address") %></td>
  </tr>
  <%num1++;}rs.close();
  for (int ad=num1;ad<11;ad++){
   %>
  <tr height="30">
    <td width="10%">　</td>
    <td width="3%">　</td>
    <td width="7%">　</td>
    <td width="10%">　</td>
    <td width="16%">　</td>
    <td width="10%">　</td>
    <td width="8%">　</td>
    <td width="16%">　</td>
  </tr>
  <%} %>
  </table>
   <table width="90%"  border=0 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

  <tr height="30">
    <td width="80%" colspan="8"> </td>
  </tr>
  <tr height="38">
    
    <td width="16%">　</td>
    <td width="10%">　</td>
    <td width="8%">　</td>
    <td width="16%">　</td>
  </tr>
  <%
 
 SQL="SELECT * FROM cq_zjqk WHERE htno="+code;
		  rs=ViewBean.executeQuery(SQL);
		
 num1=1;
		 while (rs.next()){
 %>
    <tr height="30" align="center">
    
    <td width="16%"><%=rs.getString("zj_name") %></td>
    <td width="10%"><%=rs.getString("zj_no") %></td>
    <td width="8%"><%=rs.getString("zj_num") %></td>
    <td width="16%"><%=rs.getString("zj_bak") %></td>
  </tr>
   <%num1++;}rs.close();
  
   %>
    <tr height="30">
    
    <td width="16%">　</td>
    <td width="10%">　</td>
    <td width="8%">　</td>
    <td width="16%">　</td>
  </tr>
  <tr height="30">
    <td width="80%" colspan="4"> </td>
  </tr>
  <tr height="30">
    <td width="80%" colspan="4">　
      <p>　</p>
      <p>　</p>
      <p>　</td>
  </tr>
</table>
</div>
  <div align=left id=report1 style="background-color:#F7F7F7;height:200%;overflow:auto;width:90%;z-index:2" contentEditable>
<!--第三页-->
 <table width="90%"  height="1250" border=0 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr height="30">
    <td width="100%" colspan="8"></td>
  </tr>
   <tr height="30">
    <td width="100%"  align="center">
	<font size=4><br>&nbsp;全套建筑面积<%=jzarea %>   M<sup>2</sup><br><br>套内建筑面积<%=area %>M<sup>2</sup>
    <br><br>&nbsp;&nbsp;&nbsp;共有分摊面积<%=ApportionArea %>   M<sup>2</sup></font>
   </td>
  </tr>

  

  </table>
</center>
</body>

</html>


