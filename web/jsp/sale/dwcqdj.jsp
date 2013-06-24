<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<html>

<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
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
 String secno=getbyte1(request.getParameter("SecNo"));
 String Loft=getbyte1(request.getParameter("Loft"));
 String room=getbyte1(request.getParameter("room"));
 String SQL="SELECT o.yong_tu,o.code,c.cus_age,c.cus_name,c.ID_Card,c.cus_sex,c.address,c.phone,c.sj,o.sectionname,o.loft,o.room_no,";
        SQL+="o.visadate,o.area,o.jzarea,o.jzarea-o.area ftarea,o.room_sumprice/o.area ";
		SQL+="tnunitprice,o.room_sumprice/o.jzarea jzunitprice,o.room_sumprice,";
		SQL+="o.lu_tai_area,o.lu_tai_area_price,o.lu_tai_area*o.lu_tai_area_price luprice";
		SQL+=",o.gaizhang_area,o.gaizhang_unitprice,o.gaizhang_area*o.gaizhang_unitprice gzprice,o.cq_no";
		
		SQL+=" FROM ORDER_CONTRACT o,customer c WHERE o.state<>3 and o.customer=c.serialno and o.section='"+secno+"'";
        SQL+=" and o.loft='"+Loft+"' and o.room_no='"+room+"'";
   
  
 String cus_name="",phone="",sj="",sectionname="",loft="",card_id="",visadate="";
   String room_no="",area="",jzarea="",ftarea="",tnunitprice="",address="";
   String gaizhang_area="",gaizhang_unitprice="",gzprice="",cus_sex="",code="";
   String jzunitprice="",room_sumprice="",lu_tai_area="",lu_tai_area_price="",luprice="";
   String yong_tu="",cus_age="",cq_no="";
    ResultSet rs=ViewBean.executeQuery(SQL);
  
	
	if (rs.next()){
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
	  String p1="",p2="",p3="",p4="",p5="",cq_addr="";
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
	}
	rs.close(); 
	String SaleArea="",cq_sd="",cq_ed="",useyear="";
	String y="",m="",d="",ftjd_area="";
	String y1="",m1="",d1="",GroundArea="",developcom="";
	
   SQL="SELECT SaleArea, cq_sd, cq_ed ,useyear,GroundArea,developcom FROM crm_project where SerialNo='"+secno+"'";
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
	   
	   
	   
	}
	rs.close(); 
	String ApportionArea="";
	SQL=" select ftjd_area,area,UsedArea, ApportionArea FROM room WHERE seccode='"+secno+"'";
    SQL+=" and  loft='"+Loft+"' and room_code='"+room+"'";
	  rs=ViewBean.executeQuery(SQL);
    if (rs.next()){
	  ftjd_area=Format.getFloat1(rs.getFloat("ftjd_area"),2);
	  //jzarea=Format.getFloat1(rs.getFloat("area"),2);
	 // UsedArea=Format.getFloat1(rs.getFloat("UsedArea"),2);
	  ApportionArea=Format.getFloat1(rs.getFloat("ApportionArea"),2);
	}
	rs.close();
String frxm="",dlrxm="",sfzh="",qs="";
 SQL="SELECT fr,dlr,sfzH,qs FROM cq_qy WHERE  htno="+code;
		  rs=ViewBean.executeQuery(SQL);
 if (rs.next())		  {
   frxm=getbyte(rs.getString("fr"));
   dlrxm=getbyte(rs.getString("dlr"));
   sfzh=getbyte(rs.getString("sfzH"));
   qs=getbyte(rs.getString("qs"));	
 }
	rs.close();
 String qsxz="",syx="",jzzd_area="",ft="",htn="";
	SQL=" SELECT htno,ftyd_area,jzzd_area,s_year,e_year,yong_tu,qsxz,syx,htn FROM CQ_DJ where htno="+code;
	  rs=ViewBean.executeQuery(SQL);
 
	  if (rs.next()){
	
	     cq_sd=getbyte(rs.getString("s_year"));
	     cq_ed=getbyte(rs.getString("e_year"));
		 
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
		 qsxz=getbyte(rs.getString("qsxz"));
		 syx=getbyte(rs.getString("syx"));
		 jzzd_area=getbyte(rs.getString("jzzd_area"));
		 ft=getbyte(rs.getString("ftyd_area"));
		 htn=getbyte(rs.getString("htn"));
	  }
	  rs.close();
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
 <tr><td></td></tr>
  <tr><td></td></tr>
 </table>
 <table width="98%"  border=0 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr height="30" valign="bottom" >
    <td width="100" colspan="2" align="center"> </td>
    <td width="320" colspan="4" align="center"><%if (cus_name.indexOf("/")>0){out.println(cus_name.substring(0,cus_name.indexOf("/")));}else{out.println(cus_name);} %></td>
    <td width="144" colspan="2"> </td>
    <td width="255" colspan="2"  >&nbsp;&nbsp;<%=address %></td>
    <td width="120" colspan="2">　</td>
  </tr>
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
  <tr height="26"  valign="top" >
    <td width="37"> </td>
    <td width="37">&nbsp;&nbsp;</td>
    <td width="72">&nbsp; </td>
    <td width="80">&nbsp;&nbsp;<%=frxm %></td>
    <td width="62"> </td>
    <td width="122" align="center">&nbsp; </td>
    <td width="49"></td>
    <td width="255" colspan="3"><%=dlrxm %></td>
    <td width="120" colspan="2"><%=sfzh %></td>
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
   
  <tr height="30"  > 
    <td width="148" colspan="3"> </td>
    <td width="242" colspan="5" align="right"><%if (developcom.indexOf(" ")>=0){out.print(developcom.substring(0,developcom.indexOf(" ")));out.print("<br>"+developcom.substring(developcom.indexOf(" ")+1));}else{out.print(developcom);} %></td>
    
    <td width="255" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td width="120" colspan="2"><%=cq_no %>　</td>
  </tr>
  
  <tr height="30" >
    <td width="148" colspan="3"> </td>
    <td width="242" colspan="3" ><%=visadate %> 购买</td>
    <td width="144" colspan="2"> </td>
    <td width="180">&nbsp;&nbsp;<%=loft+room_no+"全套&nbsp;"+jzarea %>M<sup>2</sup> </td>
    <td width="30" align="left"></td>
    <td width="120" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;<%=syx %></td>
  </tr>
  <tr height="30" valign="bottom">
    <td width="148" colspan="3"> </td>
    <td width="242" colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;出让</td>
    <td width="144" colspan="2"> </td>
    <td width="120">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td width="142" colspan="2"> </td>
    <td width="57" align="right">&nbsp;&nbsp;&nbsp;<%=qsxz %></td>
  </tr>
   <tr height="20">
    <td width="148" colspan="3"> </td>
    <td width="242" colspan="3" align="center"> </td>
    <td width="270" colspan="3"> </td>
    <td width="205" colspan="3">&nbsp;&nbsp;&nbsp; </td>
  </tr>
  <tr height="30">
    <td width="148" colspan="3"> </td>
    <td width="242" colspan="3" align="center"><%=dh %></td>
    <td width="270" colspan="3"> </td>
    <td width="205" colspan="3">&nbsp;&nbsp;&nbsp;<%=th %></td>
  </tr>
    <tr height="30">
    <td width="148" colspan="3"> </td>
    <td width="242" colspan="3" align="center"></td>
    <td width="270" colspan="3"> </td>
    <td width="205" colspan="3">&nbsp;&nbsp;&nbsp;</td>
  </tr>
  <tr height="30" valign="top">
    <td width="148" colspan="3"> </td>
    <td width="242" colspan="3" align="center"><%=jg %></td>
    <td width="144" colspan="2"> </td>
    <td width="120">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=floors %></td>
    <td width="142" colspan="2"> </td>
    <td width="57" align="right"><%if (!date.equals("")){out.println(date.substring(0,7));} %></td>
  </tr>
  <tr height="30">
    <td width="148" colspan="3"> </td>
    <td width="242" colspan="3" align="center"><%=jj %></td>
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
   <tr height="40">
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
    <td width="135" colspan="2" align="center">自墙</td>
  </tr>

  <tr  height="30">
    <td width="148" colspan="3"> </td>
    <td width="114" colspan="2" align="center"><%=p1 %></td>
    <td width="177" colspan="2" align="center"><%=p2 %></td>
    <td width="285" colspan="3" align="center"><%=p3 %></td>
    <td width="135" colspan="2" align="center"><%=p4 %></td>
  </tr>
  <tr height="20">
    <td width="148" colspan="3"> </td>
    <td width="114" colspan="2"></td>
    <td width="177" colspan="2"></td>
    <td width="285" colspan="3"></td>
    <td width="135" colspan="2"></td>
  </tr>
  <tr valign="bottom" height="10">
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
    <td width="481" colspan="6" align="right"><%=p5 %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
    <tr height="30" valign="top">
    <td width="27" rowspan="3">　</td>
    <td width="72">　</td>
    <td width="242" colspan="3">　</td>
    <td width="481" colspan="6" align="right"><%=ft %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
 
  </tr>
  <tr height="30" valign="bottom">
    <td width="27" rowspan="3">　</td>
    <td width="72">　</td>
    <td width="242" colspan="3">　</td>
    <td width="481" colspan="6" align="right"><%=jzzd_area %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
 
  </tr>
  <tr height="30">
    <td width="72"></td>
    <td width="242" colspan="3">　</td>
    <td width="481" colspan="6">　</td>
  </tr>
  <tr height="30">
    <td width="72">　</td>
    <td width="242" colspan="3">　</td>
    <td width="481" colspan="6">　</td>
  </tr>
  <tr height="60">
    <td width="105" colspan="2" align="right"> </td>
    <td width="242" colspan="3" align="center">市国土局房产局　</td>
  <td width="481" colspan="6" align="right"><%=htn %>&nbsp;&nbsp;&nbsp;　&nbsp;&nbsp;&nbsp;　&nbsp;&nbsp;&nbsp;　</td>

  </tr>
  
  <tr valign="top" height="30" valign="top">
    <td width="105" colspan="2">　</td>
     <td width="723" colspan="9"><%=y+"&nbsp;&nbsp;&nbsp;&nbsp;"+m+"&nbsp;&nbsp;&nbsp;&nbsp;"+d %>&nbsp;&nbsp;<%="&nbsp;&nbsp;&nbsp;&nbsp;"+y1+"&nbsp;&nbsp;&nbsp;&nbsp;"+m1+"&nbsp;&nbsp;&nbsp;&nbsp;"+d1 %></td>

  </tr>
  <tr height="30">
    <td width="305" colspan="3" align="center"> </td>
     <td width="423" colspan="8">&nbsp;&nbsp;&nbsp;<%=yong_tu %>　 </td>

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

 <div align=left id=report1 style="background-color:#F7F7F7;height:200%;overflow:auto;width:90%;z-index:2" contentEditable>
<!--第二页-->
 <table width="90%"  height="150" border=0 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr height="30">
    <td width="100%" colspan="8"></td>
  </tr>
   <tr height="30">
    <td width="100%"  align="center">
	 <%=qs %> </td>
  </tr>

  

  </table>
  <table width="90%"  height="1100" border=0 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr height="30">
    <td width="100%" colspan="8"></td>
  </tr>
   <tr height="30">
    <td width="100%"  align="center">
	  </td>
  </tr>

  

  </table>
  </div>
  <div align=left id=report1 style="background-color:#F7F7F7;height:200%;overflow:auto;width:90%;z-index:2" contentEditable>
<!--第三页--> 
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
 
</center>
</body>

</html>


