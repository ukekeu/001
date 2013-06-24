<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%> 
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="fa" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<%!
public String formatDateTime( java.sql.Timestamp dt ) throws Exception {
    if( dt == null ) {
        return "" ;
    }
    java.text.SimpleDateFormat f = new java.text.SimpleDateFormat( "yyyy-MM-dd" ) ;
    return f.format( dt ) ;
}
%>
 <%//String Cortrol=(String)session.getAttribute("popedomStr"); 
String Cortrol=checke_qx(aBean,(String)session.getAttribute("loginid"),"F004");
  
 %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>已退房客户收款明细表</title>


<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

<script language="javascript" src="../public_js/public.js">
</script>
<script language="javascript" src="../public_js/basal.js">
</script>
</head>

<%

String contractno = request.getParameter( "contractno" ) ;
String cusno = request.getParameter( "cusno" ) ;
String loft= request.getParameter( "loft" ) ;
String ysID=request.getParameter( "ysID" ) ;
if (ysID!=null){
   aBean.executeUpdate("delete GatheringRecord where id="+ysID ) ;
}
String jqdate=getbyte1(request.getParameter("jqdate"));
if (!jqdate.equals("")){
   aBean.executeUpdate("update order_contract set ytz_jq_date=getdate() where code="+contractno);

}
String jqfkdate=getbyte1(request.getParameter("jqfkdate"));
String jqfk_date=getbyte1(request.getParameter("jqfk_date"));
if (!jqfk_date.equals("")&&!jqfkdate.equals("")){
  aBean.executeUpdate("update order_contract set jqfk_date='"+jqfk_date+"' where code="+contractno);


}
%>

<%
//判断此房是否被临定过及此客户是否诚意登记过
String LD="true";
String CY="true";
 String ldroomcode=request.getParameter("ldroomcode");
 String ldSQL="select * from  SL_TemporarilyBuy where  zto=0  and roomcode="+ldroomcode+ " and Cusname='"+cusno+"'";


   ResultSet ldRs=aBean.executeQuery(ldSQL);
   if (!ldRs.next()){LD="false"; }
  
   ldRs.close();
   String cySQL="select * from tb_chengyi where zto=0  and  serialNo='"+cusno+"'";
   ResultSet cyRs=aBean.executeQuery(cySQL);
   if (!cyRs.next()){CY="false";}
   cyRs.close();
 %><%

if( request.getParameter( "zhiType" ) != null  ) {
    String zhiType = request.getParameter( "zhiType" ) ;
    String bili = request.getParameter( "bili" ) ;
    if( bili.equals( "" ) ) {
        bili = "0" ;
    }
    String jinger = request.getParameter( "jinger" ) ;
    if( jinger.equals( "" ) ) {
        jinger = "0" ;
    }
    String sqZ = "" ;
    String sqClear = "" ;
	
    if( zhiType.equals( "bai" ) ) {//按百分计算
        sqZ = " update GatheringRecord set demurrage = ( shouldmoney - yijiao ) * " + bili + " /100 "
              + " where contactno = '" + contractno + "' "
              + " and cusno = '" + cusno + "' " 
              + " and convert(char(24),shouldDate,111) <convert(char(24),GETDATE(),111) and state != 2  ";
				
    }else if ( zhiType.equals( "gu" ) ) {//按固定
        sqZ = " update GatheringRecord set demurrage = " + jinger
              + " where contactno = '" + contractno + "' "
              + " and cusno = '" + cusno + "' " 
              + " and convert(char(24),shouldDate,111) <convert(char(24),GETDATE(),111)  and state != 2 ";
    }
	
	try{
    aBean.executeUpdate( sqZ ) ;
	}catch(Exception s){out.print(sqZ);}

}
   
%>
<body topmargin="0" oncontextmenu="return false">

<form name=f1 method="post" action="yingshi.jsp?contractno=<%=contractno %>&loft=<%=loft %>&cusno=<%=cusno %>">  
 <table border="0" width="100%">
  <tr bgcolor="#EAEAEA">
   <td>
  	<%
	 
	if (LD.equals("true")){ %>
    <input type=button name=zld value="转临定定金为认购定金"   onclick="zto('ld')">
	<%}
	if (CY.equals("true")){ %>
    <input type=button name=zld value="转诚意定金为认购定金" onclick="zto('cy')">
	<%} %>
   </td>
  </tr>
 </table>
 
	 <%
 String tnunitprice="0";	 
 String Payment="";
 double SalePrice=0,sjprice=0;
 double AjPrice=0;
 String customer="";
 String roomno="";
 double ysSumMoney=0;
 String room="";
 String strloft="";
 String build="";
 String secname="";
 String secno="";
 int floors=0;
 int zs_first_money=0;
 String section="";
String lu_tai_area="";
String lu_tai_mapp_area="";
String lu_tai_area_price=""; 
String gaizhang_area=""; 
String gaizhang_unitprice=""; 
String yang_tai_area=""; 
String yang_tai_mapp_area=""; 
String yang_tai_price="",roomprice=""; 
String pi="",rg_date="";
String pih="",ajbk="",sectionname="";
String ytz_jq_date="",Jq_BAK="",jq_date="";
String ce="",hsprice="",maap_state="";
String gz_c="",cj_l="";
String ty_area="";
String c_ty_area="";
String ty_area_price="";
String cj_t="",yxz_jq_date="",jf_date="",ld="";
 
 String orderSQL="SELECT o.floors,o.jqfk_date,o.sectionname,o.section,"; 
// orderSQL+=" o.section,o.payment,o.salerprice,o.salerprice-o.zs_first_money sjprice,o.ajmoney,c.signatory,o.floors,o.loft+o.building+o.room_no as roomno,o.sectionname,o.loft,o.building,o.room_no as room,o.section ,o.zs_first_money FROM order_contract o ,customer c where o.customer=c.serialno and o.code="+contractno;
orderSQL+="o.payment,o.salerprice+o.lu_tai_area*o.lu_tai_area_price+o.gaizhang_area*o.gaizhang_unitprice salerprice,o.salerprice-o.zs_first_money sjprice,o.ajmoney,o.salerprice/o.area tnunitprice,o.cj_f,o.cj_f+o.rmbprice hsprice,";
orderSQL+="c.signatory,o.floors,o.loft+o.building+o.room_no as roomno,o.sectionname,";
orderSQL+="o.loft,o.building,o.room_no as room,o.section,o.zs_first_money,o.Y_lu_tai_area,";
orderSQL+="o.lu_tai_area,o.lu_tai_area_price,o.gaizhang_area,o.gaizhang_unitprice,";
orderSQL+="o.lu_tai_area*o.lu_tai_area_price+o.gaizhang_area*o.gaizhang_unitprice+";
orderSQL+="o.yang_tai_area*o.yang_tai_price pih,o.date,o.gz_c,o.cj_l,";
orderSQL+="o.ty_area,c_ty_area,ty_area_price,cj_t,";
orderSQL+="o.Y_lu_tai_area*o.lu_tai_area_price+o.gaizhang_area*o.gaizhang_unitprice+";
orderSQL+="o.yang_tai_area*o.yang_tai_price pi,(o.salerprice-o.zs_first_money-o.gaizhang_area*o.gaizhang_unitprice) roomprice,";
orderSQL+="o.Y_yang_tai_area,o.yang_tai_area,o.yang_tai_price,o.ajbk,o.ytz_jq_date,o.Jq_BAK,o.jq_date,o.maap_state,yxz_jq_date,o.jf_date FROM order_contract o ,customer c";
orderSQL+=" where  o.customer=c.serialno and o.code="+contractno;

     ResultSet orderRs = fBean.executeQuery( orderSQL ) ;
	 if (orderRs.next()){
	    jqfk_date=getbyte(orderRs.getString("jqfk_date"));
		if (!jqfk_date.equals(""))jqfk_date=jqfk_date.substring(0,10);
	    sectionname=getbyte(orderRs.getString("sectionname"));
	    section=getbyte(orderRs.getString("section"));
	    Payment=getbyte(orderRs.getString("payment"));
	    SalePrice=orderRs.getDouble("salerprice");
		sjprice=orderRs.getDouble("sjprice");
  	    AjPrice=orderRs.getDouble("ajmoney");
		customer=getbyte(orderRs.getString("signatory"));
		tnunitprice=getbyte(orderRs.getString("tnunitprice"));
		ce=fa.getFloat2(orderRs.getDouble("cj_f"),2);
		hsprice=fa.getFloat2(orderRs.getDouble("hsprice"),2);
		floors=orderRs.getInt("floors");
		roomno=getbyte(orderRs.getString("roomno"));
		
		secname=getbyte(orderRs.getString("sectionname"));
		strloft=getbyte(orderRs.getString("loft"));
		build=getbyte(orderRs.getString("building"));
		
		 
		room=getbyte(orderRs.getString("room"));
		// if (floors<0)roomno=strloft+build+"地下"+(-floors)+"层"+room;
		ld=section+strloft;
		secno=getbyte(orderRs.getString("section"));
		zs_first_money=orderRs.getInt("zs_first_money");
		  lu_tai_area=fa.getFloat( orderRs.getFloat("Y_lu_tai_area"),3);
		  lu_tai_mapp_area=fa.getFloat( orderRs.getFloat("lu_tai_area"),3);
		  lu_tai_area_price=fa.getFloat1( orderRs.getFloat("lu_tai_area_price"),3); 
		  gaizhang_area=fa.getFloat( orderRs.getFloat("gaizhang_area"),3); 
		  gaizhang_unitprice=fa.getFloat( orderRs.getFloat("gaizhang_unitprice"),3); 
		  pih=fa.getFloat( orderRs.getFloat("pih"),3); 
		  rg_date=orderRs.getDate("date").toString();
		  gz_c=fa.getFloat( orderRs.getFloat("gz_c"),2); 
		  if (gz_c.equals("0"))gz_c="";
		  cj_l=fa.getFloat( orderRs.getFloat("cj_l"),2); 
		 
		  if (cj_l.equals("0"))cj_l="";
		  ty_area=orderRs.getString("ty_area");
		  c_ty_area=orderRs.getString("c_ty_area");
		 ty_area_price=orderRs.getString("ty_area_price");
		  cj_t=orderRs.getString("cj_t");
		  pi=fa.getFloat( orderRs.getFloat("pi"),3); 
		  roomprice=fa.getFloat2( orderRs.getDouble("roomprice"),2); 
		  yang_tai_area=fa.getFloat( orderRs.getFloat("Y_yang_tai_area"),3); 
          yang_tai_mapp_area=fa.getFloat( orderRs.getFloat("yang_tai_area"),3); 
          yang_tai_price=fa.getFloat( orderRs.getFloat("yang_tai_price"),3); 
          ajbk =orderRs.getString("ajbk");
		  ytz_jq_date=getbyte(orderRs.getString("ytz_jq_date"));
		  if (!ytz_jq_date.equals(""))ytz_jq_date=ytz_jq_date.substring(0,10);
		  Jq_BAK=getbyte(orderRs.getString("Jq_BAK"));
		  jq_date=getbyte(orderRs.getString("jq_date"));
		  if (!jq_date.equals(""))jq_date=jq_date.substring(0,10);
		  maap_state=getbyte(orderRs.getString("maap_state"));
		  yxz_jq_date=getbyte(orderRs.getString("yxz_jq_date"));
		   if (!yxz_jq_date.equals(""))yxz_jq_date=yxz_jq_date.substring(0,10);
		   jf_date=getbyte(orderRs.getString("jf_date"));
		    if (!jf_date.equals(""))jf_date=jf_date.substring(0,10);
		 }
    orderRs.close();

	 if (Payment.indexOf("揭")>0)Payment=Payment.substring(0,Payment.indexOf("揭")+1);
	 
  %>
   <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
    <tr    class=listtitle   align="center">
        <td> <font color="#FFFFFF"> 客户姓名</font></td>
        
        <td><font color="#FFFFFF">房间号</font></td>
		
        <td><font color="#FFFFFF">付款方式</font></td>
  
        <td><font color="#FFFFFF">核实房价</font></td>
        <td><font color="#FFFFFF">签定房价</font></td>
		<td><font color="#FFFFFF">差额</font></td>
	    <%if (Payment.indexOf("揭")>0){ %>
		<td> <font color="#FFFFFF">按揭款</font></td>
		<td> <font color="#FFFFFF">首期款</font></td>
		<%} %>
		
    </tr>
	 <tr  class=listcontent  align="center">
        <td><%if (request.getParameter("see")==null){ %><a href="javascript:xiangqing();"><%=customer %></a><%}else{ %><%=customer %><% }%></td>
        <td><%if (request.getParameter("see")==null){ %><a href="javascript:contractlist();"><%=roomno %></a><%}else{ %><%=roomno %><%} %></td>
     
        <td><%=Payment %></td>
 
		<td><%if (maap_state.equals("1")){out.print(hsprice);} %></td>
		<td><%=fa.getFloat2(sjprice,2) %></td>
		<td><%if (maap_state.equals("1")){out.print(ce);} %></td>
		<%if (Payment.indexOf("揭")>0){ %>
		<td><%=AjPrice %></td>		
		<td><%=fa.getFloat2(SalePrice-AjPrice-zs_first_money,2) %></td>
		<%} %>
    </tr>
	</table>  
	<%
	String hs_lu="",hs_bxg="",hs_dt="",hs_g="";
	String bxgz="",dtz="",bxgzp="",dtzp="";
	String yxz_area="",yxz_area_price="";
	float ytzss=0,c_lt_price=0,c_ty_price=0,yxzprice=0;
	String bxgSQL="SELECT yang_tai_zhao_sarea,yang_tai_zhao_price,";
	bxgSQL+="dt_area,dt_area_price,yang_tai_zhao_sarea*yang_tai_zhao_price+dt_area*dt_area_price price ";
	bxgSQL+=",lu_tai_area,usedarea,yxz_area,yxz_area_price,yxz_area_price*yxz_area yxzprice,c_ty_price,c_lt_price  FROM room WHERE seccode='"+section+"'";
	bxgSQL+=" and loft='"+strloft+"' and room_code='"+room+"'";
	 orderRs = fBean.executeQuery( bxgSQL ) ;
	 if (orderRs.next()){ 
	   bxgz=fa.getFloat(orderRs.getFloat("yang_tai_zhao_sarea"),2);
	   bxgzp=fa.getFloat(orderRs.getFloat("yang_tai_zhao_price"),2);
	   dtz=fa.getFloat(orderRs.getFloat("dt_area"),2);
	   dtzp=fa.getFloat(orderRs.getFloat("dt_area_price"),2);
	   hs_g=fa.getFloat(orderRs.getFloat("usedarea"),2);
	   hs_lu=fa.getFloat(orderRs.getFloat("lu_tai_area"),2);
	   ytzss=orderRs.getFloat("price");
	   yxz_area=orderRs.getString("yxz_area");
	   yxz_area_price=orderRs.getString("yxz_area_price");
	   yxzprice=orderRs.getFloat("yxzprice");
	   c_ty_price=orderRs.getFloat("c_ty_price");
	   c_lt_price=orderRs.getFloat("c_lt_price");
	 }
	 orderRs.close();	
	 %>
    <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
    <tr   class=listtitle    align="center"><td>露台面积</td><td>露台核实面积</td><td>露台单价</td><td>签定总价</td><td>差额单价</td><td>差额</td>
	</tr>
		 
	<tr    class=listcontent  align="center"><td><%=lu_tai_mapp_area %>&nbsp;</td><td><%=lu_tai_area%>&nbsp;</td>
	<td><%=lu_tai_area_price %>&nbsp;</td><td><%=Float.parseFloat(lu_tai_mapp_area)*Float.parseFloat(lu_tai_area_price) %></td><td><%=c_lt_price %></td><td><%=cj_l %></td>
	</tr>
	<tr   class=listtitle    align="center"><td>花园面积</td><td>花园核实面积</td><td>花园单价</td><td>签定总价</td><td>差额单价</td><td>差额</td>
	</tr>

	<tr    class=listcontent  align="center"><td><%=ty_area %>&nbsp;</td><td><%if (maap_state.equals("1")){out.print(c_ty_area);} %>&nbsp;</td>
	<td><%=ty_area_price %>&nbsp;</td><td><%=Float.parseFloat(ty_area)*Float.parseFloat(ty_area_price) %></td><td><%=c_ty_price %></td><td><%=cj_t %></td>
	</tr>
	<%if (!gaizhang_unitprice.equals("0")&&!gaizhang_unitprice.equals("0.0")){ %>
	<tr class=listtitle align="center"><td>改装面积</td><td>改装核实面积</td><td>改装单价</td><td>签定改装款</td><td>核实改装款</td><td>差额</td>
    </tr>
	<tr align="center"><td><%=gaizhang_area %>&nbsp;</td><td><%if (maap_state.equals("1")){out.print(hs_g);} %></td><td><%=gaizhang_unitprice %>&nbsp;</td>
	<td><%=pi %></td><td><%if (maap_state.equals("1")){out.print(Float.parseFloat(gaizhang_unitprice)*Float.parseFloat(hs_g));} %></td>
	
	<td><%=gz_c %></td>
	</tr>
	<%} %>
	</table>
	 
 <!--<input type=button name=addbxg value="增　加" onclick="addz();">&nbsp; <input type=button name=addbxg value="修 改" onclick="modiz();">-->
  <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
    <tr    class=listtitle   align="center">
	<td>不锈钢罩面积</td><td>不锈钢罩单价</td>
	<td>锻铁面积</td><td>锻铁单价</td>
	<td>合计</td>
	<td>预收</td>
	<td>差额</td><td>结清日期</td>
	<TD></td>
	</tr>
	<%
	String ysytzSQL="select sum(money) money from factGatheringTaxRecord where  taxname like '%罩%' and contractno ='"+contractno+"'";
	float ytzk=0;

	orderRs = fBean.executeQuery( ysytzSQL ) ;
	if (orderRs.next()){
	  ytzk=orderRs.getFloat("money");
	}
	orderRs.close();
	 %>
	<tr  class=listcontent   align="center">
	<td><%=bxgz %></td><td><%=bxgzp %></td>
	<td><%=dtz %></td><td><%=dtzp %></td>
	<td><%=fa.getFloat(ytzss ,2)%></td>
	<td><%=fa.getFloat(ytzk,2)  %></td>
	<td><%if (ytzss>0)out.print(fa.getFloat(ytzss-ytzk,2));  %></td>
	<td>&nbsp;<%
		 
	 out.print(ytz_jq_date);
	
	 %><%if (ytz_jq_date.equals("")) {%><input type=checkbox value=1  name=jqdate title="如果客户结清，请选择" onclick="if (confirm('确认客户已结清吗？'))jqmodi(2);" >结清(如果客户结清，请选择)<%} %>
	 </td>
	<td> <%if (Cortrol.indexOf("Q")>=0){ %><a href="#" onclick="modiz();">修改</a><%} %></td>
	</tr>
	  
	</table>
	<table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
    <tr    class=listtitle   align="center">
	<td>防盗安全网面积</td><td>防盗安全网单价</td>
	<td>合计</td>
	<td>预收</td>
	<td>差额</td><td>结清日期</td>
	<TD></td>
	</tr>
	<%
	 ysytzSQL="select sum(money) money from factGatheringTaxRecord where  taxname like '%安全网%' and contractno ='"+contractno+"'";
	 ytzk=0;
	 
	orderRs = fBean.executeQuery( ysytzSQL ) ;
	if (orderRs.next()){
	  ytzk=orderRs.getFloat("money");
	}
	orderRs.close();
	 %>
	<tr  class=listcontent   align="center">
	<td><%=yxz_area %></td><td><%=yxz_area_price %></td>
	
	<td><%=yxzprice%></td>
	<td><%=fa.getFloat(ytzk,2)  %></td>
	<td><%if (yxzprice>0)out.print(fa.getFloat(yxzprice-ytzk,2));  %></td>
	<td>&nbsp;<%
		 
	 out.print(yxz_jq_date);
	
	 %><%if (yxz_jq_date.equals("")) {%><input type=checkbox value=1  name=aqwjqdate title="如果客户结清，请选择" onclick="if (confirm('确认客户已结清吗？'))jqmodi(1);" >结清(如果客户结清，请选择)<%} %>
	 </td>
	<td> <%if (Cortrol.indexOf("Q")>=0){ %><a href="#" onclick="modiaq();">修改</a><%} %></td>
	</tr>
	  
	</table>
	
	
	 <p align=center>
  <b><font size="3" color="#000080">应收一览表</font></b>
 </p> <%
	if (Cortrol==null){Cortrol="";}
	%>
    <table width=100% border="0"><tr height="16" bgcolor="#EAEAEA">
 <td align="left">
 <%if (request.getParameter("see")==null){ %>
<%if (Cortrol.indexOf("A")>=0){%>
 <input type=button name=fac value="增　加" onclick="addpay();">
<%} %> <% if (Cortrol.indexOf("E")>=0){ %>
 <input type=button name=modi value="修  改" onclick="editpay();">
<%}if (Cortrol.indexOf("D")>=0){ %>
 <input type=button name=de value="删  除" onclick="deletepay();">
<%} %>
<%} %>
  </td>
 
    </tr>
	</table>
	
    <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
     <tr  class=listtitle  align="center">
        <td><font color="#FFFFFF">序号</font></td>
		 <td><font color="#FFFFFF">款项</font></td>
        <td><font color="#FFFFFF">付款期限</font></td>
        <td><font color="#FFFFFF">应交款</font></td>
		<td><font color="#FFFFFF">已交款</font></td>
        <td><font color="#FFFFFF">未交款</font></td>
        <td><font color="#FFFFFF">滞纳金</font></td>
        <td><font color="#FFFFFF">状态</font></td>
     </tr>

    <%
    String sq2 = " select g.*,g.shouldmoney-g.yijiao qk,c.signatory from GatheringRecord g,customer  c where c.serialno=g.cusno and  g.contactno = '" + contractno + "' "
                + " and g.cusno = '" + cusno + "' " + " order by g.shouldQS ";
    ResultSet rs2 = fBean.executeQuery( sq2 ) ;
    double weijiao = 0 ;
    double yijiao = 0 ;
    double zhiNaJing = 0 ;
    double ysmoney=0;
    int jj = 0 ;
	int prin=1;
	int ysid=0;
	String signatory="";
	 String shouldDate="";
    String curry="";
	String rate="0"; 
    String statevalue="";
    String statestr="";
    int i=0;
   String qs="";
    while( rs2.next() ) {
        jj++;
     	ysid=rs2.getInt("id");
        String shouldQS = rs2.getString( "shouldQS" ) ;
		qs=shouldQS;
        shouldDate = formatDateTime( rs2.getTimestamp( "shouldDate" ) ) ;

        double shouldmoney = rs2.getDouble( "shouldmoney" ) ;
        ysSumMoney+=shouldmoney;
        if(jj==1)
             ysmoney=shouldmoney;	    
        double ciQiYiJiao = rs2.getDouble( "yijiao" ) ;
        double qianKuan = rs2.getDouble( "qk" ) ;
		
		
        double demurrage = rs2.getDouble( "demurrage" ) ; 
		String state = getbyte( rs2.getString( "state" ) ) ;
		curry= getbyte( rs2.getString( "curry" ) ) ;
		rate= fa.getFloat( rs2.getFloat( "rate" ),4)  ;
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
if (shouldQS.equals("0"))shouldQS ="定金";
else if (shouldQS.equals("1")) shouldQS ="房款";
else if (shouldQS.equals("2"))shouldQS ="房款";
else if (shouldQS.equals("3"))shouldQS ="房款";	
else if (shouldQS.equals("4"))shouldQS ="房款";	
else if (shouldQS.equals("5"))shouldQS ="花园/露台款";	 
else if (shouldQS.equals("6"))shouldQS ="改装款";	  
else if (shouldQS.equals("7"))shouldQS ="滞纳金";	  
else if (shouldQS.equals("8"))shouldQS ="房款差额";	
else if (shouldQS.equals("9"))shouldQS ="改装款差额";	
else if (shouldQS.equals("10"))shouldQS ="花园/露台款差额";	

%>
 
 
	    <tr  class=listcontent id=TR<%=i%> align="center"     onclick="setpara( '<%= qs %>' , '<%= qianKuan+demurrage%>' , '<%= shouldmoney %>','<%=ysid %>','<%=shouldDate %>','<%=statevalue %>' );changeclass1(this,'clickbg','listcontent');" 　onmouseover="mout(this);">
          <td><%= jj %></td>
		     <td><%= shouldQS %></td>
          <td><%= shouldDate %></td>
		   <% if (qs.equals("5")){ %>
          <td ><%= fa.getFloat2(shouldmoney,3)%></td>
         <%}else{ %>
		     <td ><%= fa.getFloat2(shouldmoney,2)+"("+fa.getFloat2(shouldmoney/SalePrice*100,2)+"%)" %></td>
         <%} %>
         <td><%= fa.getFloat2(ciQiYiJiao,2) %></td>
          <td><%= fa.getFloat2(qianKuan ,2)%></td>
          <td><%= fa.getFloat2(demurrage,2) %></td>
          <td><%= state %><%if (Cortrol.indexOf("F")>=0){
		   if (shouldmoney>0){
		   %>
		   <img src="../picture/icon_print.gif" alt='打印收据单' onclick="printSJ1('<%= cusno %>','<%= contractno %>','','<%= ysid%>')"  onmouseover="javascript:this.style.cursor='hand'">
		   <%
		  } else {
		   %> <img src="../picture/icon_print.gif" alt='打印收据单' onclick="printSJ4('<%= cusno %>','<%= contractno %>','','<%= ysid%>')"  onmouseover="javascript:this.style.cursor='hand'">
		
		   <%}
		   } %></td>
		   
        </tr>
    <%
        i ++ ;
    }
   i--;
    %>

    <tr bgcolor="#EBEBEB" align="center">
     <td colspan=3>
<b>合&nbsp;&nbsp;计:</td><td><b><%= curry+fa.getFloat2(ysSumMoney,2)+"("+fa.getFloat2(ysSumMoney*100.0/SalePrice,2)+"%)"%></b></td><td><b><%= curry+fa.getFloat2(yijiao,2)%></b></td> <td><b> <%= curry+fa.getFloat2(weijiao,2)%></b></td> <td ><b> <%= curry+fa.getFloat2(zhiNaJing,2)%></td></b> 
       <td >
   
  </td>
    </tr>

    <tr bgcolor="#EBEBEB" >
     <td colspan=8>
	 <%if (request.getParameter("see")==null){ %>
      <input type=radio name=zhiType  checked value="bai">滞纳金比例<input type=text name=bili size=10>%
      <input type=radio name=zhiType value="gu">固定滞纳金<input type=text name=jinger size=10>
  <%if (Cortrol.indexOf("A")>=0){%>
      <input type=button name=b1 value="确定" onclick="zhiNaJing()" > 房款结清日期:<INPUT TYPE=TEXT NAME="jqfk_date" size=8 value="<%=jqfk_date %>" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(jqfk_date);return false;"><%if (jqfk_date.equals("")){ %><input type=checkbox value=1  name=jqfkdate title="如果客户结清房款，请选择" onclick="fkjq();" ><%} %>
	  <%
	  }
	  }
	    %>
     <td>
    </tr>

    </table>

 <p align=center>
  <b><font size="3" color="#000080">实收一览表</font></b>
 </p><%String flag = "";
      if(statestr.equals("2"))
        flag="1";
      else flag="0";%>
	  <%if (request.getParameter("see")==null){ %>
	 
	  <%if (Cortrol.indexOf("A")>=0){%>
	   <input type=button name=facm value="增　加" onclick="dengji();">
   
	<%} %>
	<%} %>
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
        <td><font color="#FFFFFF">操作</font></td>
		<td><font color="#FFFFFF">收据</font></td>
    </tr>

    <%
    String sq = " select id,period, gather_date,factmoney,receiver,Bill_num";
	sq+=",BillType,CurrName,CurrRate,PayType,context,printdate,checkstate, ";
	sq+="CurrRate*factmoney ff,jsbak from factGatheringRecord where contractno = '" + contractno + "' "
                + "  order by period , gather_date";
    //out.print(sq);
    ResultSet rs = fBean.executeQuery( sq ) ;
     int i2 = 0 ;    
	 String gather_date ="";
	 int rowID=0;
     String FactCurry="";
	 double sumfactmoney=0;
	 String FactCurryRate="",jsbak="";
	 String period ="0", context="";
	 String periodN ="0",print_date="";
	 int num=0; 
    while( rs.next() ) {
	 num++;
         rowID = rs.getInt( "id" ) ;
         period = rs.getString( "period" ) ;
		// periodN=String.valueOf(Integer.parseInt(period)+1);
         gather_date = formatDateTime( rs.getTimestamp( "gather_date" ) ) ;
         double factmoney = rs.getDouble( "factmoney" ) ;
       
		
		 //out.print(period);
         String receiver = getbyte( rs.getString( "receiver" ) ) ;
		 String Billnum = getbyte( rs.getString( "Bill_num" ) ) ;
		 String BillType = getbyte( rs.getString( "BillType" ) ) ;
		 FactCurry=getbyte( rs.getString( "CurrName" ) );
		 FactCurryRate=getbyte( rs.getString( "CurrRate" ) );
		 String PayType= getbyte( rs.getString( "PayType" ) ) ;
		   context= getbyte( rs.getString( "context" ) ) ;
		  print_date= getbyte( rs.getString( "printdate")) ;
		    int checkstate=rs.getInt("checkstate");
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
	 
%>
        <tr class=listcontent align=center  title="<%=context %>">
          <td><%= num%></td>
          <td><%= period %></td>
		    <td><%= gather_date %></td>
          <td><%= fa.getFloat2(factmoney ,2)%></td>
		  <td><%= curryDX%></td>
		 <td><%= FactCurryRate%></td>
		 
          <td ><%= PayType %></td>
		  <!--<td ><%= Billnum %></td>-->
          <td><%= receiver %></td>
		   
		 <td><%= print_date %></td>
          <td >
		  <%if (checkstate==0){ %>
		  <%if (Cortrol.indexOf("E")>=0){%>
		  <img src="../picture/edit.gif" alt='修改收款' onclick="Edit('<%= cusno %>','<%= contractno %>','<%= period %>','<%= rowID%>','<%=FactCurry%>','<%=FactCurryRate %>','<%=factmoney %>')" id=bian<%= i2 %> onmouseover="javascript:this.style.cursor='hand'">
		  <%}if (Cortrol.indexOf("D")>=0){%>
		  &nbsp;<img src="../picture/button_sc.gif"  border="0"   onmouseover="javascript:this.style.cursor='hand'" title="删除" onclick="deleteFact('<%= rowID%>','<%=FactCurry%>','<%=FactCurryRate %>','<%=rate %>','<%=factmoney %>')">
		  <%} %>
		  <%}else{ if (Cortrol.indexOf("Q")>=0){%> <img src="../picture/edit.gif" alt='修改收款' onclick="Edit('<%= cusno %>','<%= contractno %>','<%= period %>','<%= rowID%>','<%=FactCurry%>','<%=FactCurryRate %>','<%=factmoney %>')" id=bian<%= i2 %> onmouseover="javascript:this.style.cursor='hand'"><%} %>
		 &nbsp;<font color="red">已审核</font><%} %>
		  </td>    
		  		   <td >
		   <%if (request.getParameter("see")==null){ %>
		     <%if (Cortrol.indexOf("F")>=0){%>
			 <% if (factmoney>0){ %>
		   <img src="../picture/icon_print.gif" alt='打印收据单' onclick="printSJ('<%= cusno %>','<%= contractno %>','<%= period %>','<%= rowID%>')" id=bian<%= i2 %> onmouseover="javascript:this.style.cursor='hand'">
		      <%}else{ %>
             <img src="../picture/icon_print.gif" alt='打印收据单' onclick="printSJt('<%= cusno %>','<%= contractno %>','<%= period %>','<%= rowID%>')" id=bian<%= i2 %> onmouseover="javascript:this.style.cursor='hand'">
			  <%} %>
		   <%} %>
		   <%} %>&nbsp;
		   </td>    
        </tr>
	
    <%
       
    }
	if (Payment.indexOf("(")>0)Payment=Payment.substring(0,Payment.indexOf("("))  ;
    %>
		 <tr bgcolor="#EBEBEB" align="center">
     <td colspan=2>
    <b>合&nbsp;&nbsp;计:</td><td colspan=7 align="left"> <b>￥<%=fa.getFloat2(sumfactmoney,2)%> </b><br>备注：<%=context %> </td> 
     <td > 
      <% if (yijiao-ysSumMoney>0) out.print(" <font color=red>余额:"+curry+fa.getFloat2(yijiao-ysSumMoney,2)+"</font>");
	  %>
  </td>
    </tr>
    </table>
	 
	<%if (Payment.indexOf("揭")>0){ %>
	<p align="center"> <b><font size="3" color="#000080">银行放款记录</font></b></p>
	<table width="100%">
	<tr     align="center"><td colspan="2"></td></tr> 
	<tr     align="left"><td colspan="2"><input type=button name=ajm value="放款登记" onclick="openwin('AjInput.jsp?aj=<%=AjPrice %>&cusno=<%=cusno %>&code=<%=contractno %>',400,350,100,100);"></td></tr> 
 
	<tr  class=listtitle  align="center"><td>按揭银行</td><td>放款日期</td><td>放款金额</td><td>登记人</td><td>审核</td><td>删除</td></tr> 
	<%String Fsql="select factdate,factmonye,chekcer,id,checkperson,checkstate,checkdate from FactAjCharges where contractno="+contractno; 
	 
	rs = fBean.executeQuery( Fsql ) ;
	while (rs.next()){%>
	  <tr align="center">
	  
	  <td><%=ajbk%></td>
	  <td><%=rs.getDate("factdate").toString() %></td>
	  <td><%=rs.getString("factmonye") %></td>
	   <td> <%=rs.getString("chekcer") %></td>
	   <td><%
	   boolean checkstate=rs.getBoolean("checkstate") ;
	   if (checkstate){
	   out.print(getbyte("<font color='red'>"+rs.getString("chekcer"))+"&nbsp;"+ rs.getDate("checkdate").toString()+"</font>");
	   
	   }
	  
	    %>
		</td>
	    <td><a href="#" onclick="openwin('deleteAj.jsp?id= <%=rs.getString("id") %>',10,10,10,10);">删除</a></td>
		<td>  <img src="../picture/icon_print.gif" alt='打印收据单' onclick="printSJ_aj('<%= cusno %>','<%= contractno %>','<%= period %>','<%= rowID%>')" id=bian<%= i2 %> onmouseover="javascript:this.style.cursor='hand'">
		 </td>
	  </tr>
	
	
	<%}rs.close(); %>
	
	
	 
	 </table>
	
	
	<%} %>
<p align=center>
  <b><font size="3" color="#000080">应交费用一览</font></b>
 </p> 
  <%if (Cortrol.indexOf("A")>=0){%><input type=button name=ds value="一次交完" onclick="dstax(1);">&nbsp; <input type=button name=ds value="只交部分" onclick="dstax(2);">&nbsp; <input type=button name=cpt value="取消配套费" onclick="cancelpt();">&nbsp; <input type=button name=add value="补增项目" onclick="addtax();"><%}if (Cortrol.indexOf("F")>=0){%>   &nbsp; <input type=button name=pr value="打印收据" onclick="printdstax1();"><%} %>
 <!--<input type=button  name=count value="计算费用" onclick="openwin('TaxCount1.jsp?code=<%=contractno %>',10,10,10,10);">-->
 <table width="100%"  border="0" cellspacing="1"  cellpadding="1"  >
    <tr   class=TxtColor >
	 <td  >序号</td> 
      <td    >费用名称</td><td>金额</td> <td>欠收</td> 
	  <td>状态</td> 
	   <td>取消</td> 
	    <td>修改</td> 
		 <td>选择</td> 
    </tr>
	
  
    <%
String sql="";
String sql1="";
	
	//设定查询

   		sql="select id,TaxName,TaxMoney,state,TaxMoney-factmoney q,cancel,taxname_type,cancelbak from GatheringTaxRecord where contactno ='"+contractno+"'";//order by room_no desc";
//设置查询结果的存放变量
int ID=0;
int taxname_type=0;
String RoomNo="";
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
int cancel=0; 
 
   rs=fBean.executeQuery(sql);

 i=0;
 while (rs.next()){

  try{
     i=i+1;
  //按FIELDS顺序一GET　VALUE
   String id=rs.getString("id");
    
   TaxName=getbyte(rs.getString("TaxName"));
   TaxMoney=rs.getFloat("TaxMoney");
   String state=rs.getString("state");
    q=rs.getFloat("q");
	cancel=rs.getInt("cancel");
 
	taxname_type=rs.getInt("taxname_type");
	String cancelbak=rs.getString("cancelbak");
    %> 
    <tr class=listcontent id=TR2<%=i%>  align="left"  title="双击可登记代收费用"  onclick="changeclass1(this,'clickbg','listcontent');">
      <td  ><%=i%></td>
	  <td  ><%=TaxName%></td>
	  <td  ><%=TaxMoney%></td>
	   <td  ><b><%=q%></b></td>
      <td> 
	  <%if (state.equals("0")&&cancel==0){ %>
	  <input name="tax" taxid=<%=id %> type="checkbox" value=<%=q %>>
	  <input type=hidden name=taxname<%=id %> value="<%=id %>">
	  </td> 
		<%}else{out.print("已代收");} %>
		<td  title="<%=cancelbak %>"><%if (cancel==0&&taxname_type==0){ %>  <input name="canceltax"  type="checkbox" value=<%=id %>><%}else if (taxname_type==0){out.print("<a href='#' title='"+cancelbak+"'><font color=red>"+cancelbak+"<br>&nbsp;<a href='#' onclick='hf("+id +")'>回复</a></font></a>");} %></td>
   <td><%if (Cortrol.indexOf("E")>=0){%><a href="#" onclick="openwin('ModiTax.jsp?id=<%=id %>&taxmoneys=<%=TaxMoney %>&name=<%=TaxName %>&taxname_type=<%=taxname_type %>',300,300,100,100);" >修改</a>
    <%} %>
	<%if (TaxName.indexOf("契税")>=0) {%><br><input type=checkbox name=hs value=1 onclick="hsjs(this.checked);">按实结算<%} %>
   </td> <input type=hidden name=prtaxname_y<%=id %> value="<%=TaxName %>">
   <td>   <input name="prtax_y" taxid=<%=id %> type="checkbox" value=<%=TaxMoney %>></td>
    </tr>
    <%
  }catch(Exception ex){out.println(ex.getMessage());}

}

  rs.close();
 sql="select sum(TaxMoney) TaxMoney,taxname_type  from GatheringTaxRecord where cancel=0 and  contactno ='"+contractno+"' group by taxname_type";//order by room_no desc";
   rs=fBean.executeQuery(sql);
   float taxprice=0,peitaoprice=0;
   while (rs.next()){
     if (rs.getBoolean("taxname_type"))taxprice=rs.getFloat("TaxMoney");
	 else peitaoprice=rs.getFloat("TaxMoney");
 }
 rs.close();
 %>
 <tr><td>税费合计：<%=fa.getFloat(taxprice,2) %></td><td>配套合计：<%=fa.getFloat(peitaoprice,2) %></td><td>合计：<%=fa.getFloat(peitaoprice+taxprice,2) %></td></tr>

</table>
<p align=center>
  <b><font size="3" color="#000080">代收(付)一览</font></b>
 </p>
&nbsp;<%if (Cortrol.indexOf("A")>=0){%> <input type=button name=pr value="退 款" onclick="openwin('CancelTax.jsp?code=<%=contractno %>',400,200,100,100);">&nbsp; <input type=button name=pr value="补 交" onclick="openwin('AddTax.jsp?code=<%=contractno %>',400,200,100,100);">&nbsp; <%}if (Cortrol.indexOf("F")>=0){%>   &nbsp; <input type=button name=pr value="打印收据" onclick="printdstax();"><%} %>
 <table width="100%"  border="0" cellspacing="1"  cellpadding="1"  >
    <tr   class=TxtColor >
	 <td  >序号</td> 
      <td    >费用名称</td><td>金额</td> <td>收取日期</td> 
	  <td>票据编号</td> 
	  <td>代收人</td>
	  <td>代付日期</td>
	  <td>代付人</td>
	    <td>选择</td>
    <td>修改</td>
	
    </tr>
	
  
    <%
 
	
	//设定查询

   		sql="select * from factGatheringTaxRecord where contractno ='"+contractno+"'";//order by room_no desc";
//设置查询结果的存放变量
 
 
 
   rs=fBean.executeQuery(sql);
 String JKdate="";
 i=0;
 float sumtax=0;
 boolean dscheck=false;
 while (rs.next()){

  try{
     i=i+1;
  //按FIELDS顺序一GET　VALUE
   String id=rs.getString("code");
   String taxname=rs.getString("taxname");
   TaxMoney= rs.getFloat("money") ;
   sumtax+=TaxMoney;
   JKdate=getbyte(rs.getString("date"));
   if (!JKdate.equals(""))JKdate=JKdate.substring(0,10);
   String no=getbyte(rs.getString("no"));
    String handler=getbyte(rs.getString("handler"));
	dscheck=rs.getBoolean("checkstate");
	taxname_type=rs.getInt("taxname_type");
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
	  <td> 
	  	  <input type=hidden name=prtaxname<%=id %> value="<%=taxname %>">
	   <input name="prtax" taxid=<%=id %> type="checkbox" value=<%=TaxMoney %>>
	   </td>
     <td><% 
	 if (!dscheck){
	   if (Cortrol.indexOf("E")>=0){%> <a href="#" onclick="openwin('ModiTaxDs.jsp?JKdate=<%=JKdate %>&id=<%=id %>&taxmoneys=<%=TaxMoney %>&name=<%=taxname %>&taxname_type=<%=taxname_type %>',300,300,100,100);" >修改</a>
	   
	   <%}
	 } else{ if (Cortrol.indexOf("Q")>=0){%><a href="#" onclick="openwin('ModiTaxDs.jsp?JKdate=<%=JKdate %>&id=<%=id %>&taxmoneys=<%=TaxMoney %>&name=<%=taxname %>&taxname_type=<%=taxname_type %>',300,300,100,100);" >修改</a><%}out.print("<font color=red>已审核</font>") ;}
	    %>
	</td>
    </tr>
    <%
  }catch(Exception ex){out.println(ex.getMessage());}

}
  rs.close();
 
 sql="select sum(money) TaxMoney,taxname_type from factGatheringTaxRecord where contractno ='"+contractno+"' group by taxname_type";//order by room_no desc";
   rs=fBean.executeQuery(sql);
   taxprice=0;
   peitaoprice=0;
   while (rs.next()){
     if (rs.getBoolean("taxname_type"))taxprice=rs.getFloat("TaxMoney");
	 else peitaoprice=rs.getFloat("TaxMoney");
 }
 rs.close();
 %>
 <tr><td colspan="2">税费合计：<%=fa.getFloat(taxprice,2) %></td><td colspan="2">配套合计：<%=fa.getFloat(peitaoprice,2) %></td><td colspan="2">合计：<%=fa.getFloat(peitaoprice+taxprice,2) %></td></tr>

</table>


	<p align=center>
  <b><font size="3" color="#000080">开票明细</font></b>
 </p>
  <%if (request.getParameter("see")==null){ %>
	  <%if (Cortrol.indexOf("A")>=0){%>
  
     <input type="button" name=dd value="开票登记" onclick="dengji1();">
    
	<%} %>
	<%} %>
   <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
    <tr  class=listtitle  align="center">
        <td><font color="#FFFFFF">序号</font></td>
		<td><font color="#FFFFFF">发票编号</font></td>
        <td><font color="#FFFFFF">开票日期</font></td>
        <td><font color="#FFFFFF">开票金额</font></td>
        <td><font color="#FFFFFF">开票人</font></td>
		 <td><font color="#FFFFFF">状态</font></td>
    </tr>
	<%
	    sq = " select * from F_invoice where order_contract = '" + contractno + "' "
                + "  order by invoice_date";
           rs = fBean.executeQuery( sq ) ;
		   int ii=1;
		   while (rs.next()){
	%>	   
	   <tr  class=listcontent  align="center">
        <td><%=ii %></td>
		<td><%=getbyte(rs.getString("invoice_no")) %></td>
        <td><%=getbyte(rs.getDate("invoice_date").toString()) %></td>
        <td><%=getbyte(rs.getString("invoice_money")) %></td>
        <td><%=getbyte(rs.getString("invoice_person")) %></td>
		<%String fpstate=getbyte(rs.getString("state")); 
		if (fpstate.equals("1"))fpstate="作废";
		%>
		  <td><%=fpstate %></td>
		<td><a href="#" onclick="fpmodi();">修改</a>&nbsp;<%if (!fpstate.equals("作废")){ %><a href="#" onclick="fpzf();">作废</a><%} %><%if (fpstate.equals("作废")){ %><a href="#" onclick="fpff();">恢复</a><%} %></td>
    </tr>
		   
	<%ii++;
		  }
		  rs.close();
				
	 %>
</table>
<p>结算备注:<input type=text name=bak size=50 value="<%=Jq_BAK %>" onchange="modibak();">&nbsp;<INPUT TYPE=TEXT NAME="jq_date" size=12 value="<%=jq_date %>" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(jq_date);return false;">
</p>
<p>交房日期:<INPUT TYPE=TEXT NAME="jf_date" size=12 value="<%=jf_date %>"  onblur="jfbak();"  ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(jf_date);document.forms[0].jf_date.focus();"return false;">(选择交楼日期后需要点击页面一次才能更新)
</p>
    <p align=center>
        <input type=button name=buttc value=" 关闭 " onclick="window.close()" >
		  &nbsp;
		 
		   <input type="button" value="结算清单" name="submit1" onclick="printrg();">
		 
	 &nbsp;  <input type="button" value="打印购房清单" name="submit2" onclick="openwin('goufangqingdan.jsp?code=<%=contractno %>',500,450,10,10);">
	
		 <input type=button name=buttp value=" 打印付清楼款证明书 " onclick="printzms()" >
		
    </p>

 </form>
<%fBean.closeConn();
 aBean.closeConn();
 %>
<script lang=javascript>
function modibak(){
   if (document.forms[0].jq_date.value!=""){
     if (confirm("是否保存修改?")) 
   openwin2("modibak.jsp?code=<%=contractno %>&bak="+document.forms[0].bak.value+"&jq_date="+document.forms[0].jq_date.value,1,1,1,1);

   
   }
 

}
function jfbak(){
   if (document.forms[0].jf_date.value!=""){
     if (confirm("是否保存交房日期?")) 
   openwin2("jf_modi.jsp?code=<%=contractno %>&bak="+document.forms[0].bak.value+"&jf_date="+document.forms[0].jf_date.value,1,1,1,1);

   
   }
 

}
function fkjq(){
 if (document.forms[0].jqfkdate.checked)
 {
   if (document.forms[0].jqfk_date.value==""){alert("请选择房款结清日期");return false;}
   if (confirm("确认客户已结清所有房款吗？"))document.fl.submit();
 }

}
function dengji1() {

  
    var spa = 300 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa / 2 ;
    var lef = spa ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=" + 250 ;
    var posi = posi + ",width=" +450 ;

    var newwink2 = window.open("F_fp_Input.jsp?contractno=<%=contractno%>","NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
    newwink2.focus();
   

}

function fpmodi() {

  
    var spa = 300 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa / 2 ;
    var lef = spa ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=" + 250 ;
    var posi = posi + ",width=" +450 ;

    var newwink2 = window.open("F_fp_modi.jsp?contractno=<%=contractno%>","NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
    newwink2.focus();
   

}

function fpzf() {

  if (confirm("确认作废?")){
    var spa = 300 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa / 2 ;
    var lef = spa ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=" + 250 ;
    var posi = posi + ",width=" +450 ;

    var newwink2 = window.open("F_fp_zf.jsp?contractno=<%=contractno%>","NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
    newwink2.focus();
   }

}

function fpff() {

  if (confirm("确认作废?")){
    var spa = 300 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa / 2 ;
    var lef = spa ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=" + 250 ;
    var posi = posi + ",width=" +450 ;

    var newwink2 = window.open("F_fp_ff.jsp?contractno=<%=contractno%>","NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
    newwink2.focus();
   }

}

function printrg(){
 if (document.forms[0].bak.value==""){alert("请填写结算备注");return false;}
  if (document.forms[0].jq_date.value==""){alert("请结算日期");return false;}

  window.open("jieqingdan.jsp?code=<%=contractno %>&bak="+document.forms[0].bak.value+"&jq_date="+document.forms[0].jq_date.value);

}
function cancelpt(){
 
   if (getseldocs2()==""){alert("请选择需要取消的配套费");return false;}
  if (confirm("确认取消选择的配套费吗？取消后，系统将不能再恢复！")){
	 openwin("cancelPt.jsp?codes="+getseldocs2(),300,200,10,10);
  
  }

}

function getseldocs2() {
     var x=0;
	 var seldocs = new Array();
	 var temp=f1.elements.length;
     for (i=0;i<f1.elements.length;i++) {
       if ((f1.elements[i].type=="checkbox")&&(f1.elements[i].checked)&&(f1.elements[i].name=="canceltax"))
		 { 
		    seldocs[x]=f1.elements[i].value ;
			x++;
   		 }
	  }	

   return seldocs ;
}
function dstax(para){
  var taxmoney=0;
  var taxnameid="";
  if (document.forms[ 0 ].tax.length){
  if (document.forms[ 0 ].tax){
  for (var ii=0;ii< document.forms[ 0 ].tax.length;ii++){
     if (document.forms[ 0 ].tax[ii].checked){
	 
	    taxmoney+=parseFloat(document.forms[ 0 ].tax[ii].value);
		 var id=document.forms[ 0 ].tax[ii].taxid;
		 var dd=eval("document.forms[ 0 ].taxname"+id);
		 
		if (taxnameid=="")		  
		   taxnameid=dd.value;
		else
		   taxnameid+=","+dd.value;  
	 
	 }document.forms[ 0 ].tax[ii].checked=false;
  }
  }
  }else    if (document.forms[ 0 ].tax.checked){
   taxmoney=parseFloat(document.forms[ 0 ].tax.value);
  taxnameid=parseFloat(document.forms[ 0 ].tax.taxid);
  }
 if (taxnameid==""){alert("请选择代收的税费名称");return false;}
 taxmoney= Math.round(parseFloat(taxmoney)*100,3)/100;
 if (para==1)
  openwin("TaxInput.jsp?code="+taxnameid+"&taxmoney="+taxmoney+"&id=<%=contractno %>",300,300,100,100);
 else
    openwin("TaxInput1.jsp?code="+taxnameid+"&taxmoney="+taxmoney+"&id=<%=contractno %>",300,300,100,100);
 

}

function printdstax(){
  var taxmoney=0;
  var taxnameid="";
  if (document.forms[ 0 ].prtax.length){
  if (document.forms[ 0 ].prtax){
  for (var ii=0;ii< document.forms[ 0 ].prtax.length;ii++){
     if (document.forms[ 0 ].prtax[ii].checked){
	 
	    taxmoney+=parseFloat(document.forms[ 0 ].prtax[ii].value);
		 var id=document.forms[ 0 ].prtax[ii].taxid;
		 var dd=eval("document.forms[ 0 ].prtaxname"+id);
		 
		if (taxnameid=="")		  
		   taxnameid=dd.value;
		else
		   taxnameid+=","+dd.value;  
	 
	 }
	 document.forms[ 0 ].prtax[ii].checked=false;
  }
  }
  }else    if (document.forms[ 0 ].prtax.checked){
   taxmoney=parseFloat(document.forms[ 0 ].prtax.value);
  taxnameid=parseFloat(document.forms[ 0 ].prtax.taxid);
  }
  
 if (taxnameid==""){alert("请选择代收的税费名称");return false;}
 taxmoney= Math.round(parseFloat(taxmoney)*100,3)/100;
 document.forms[ 0 ].prtax.checked=false;
  openwin("printtaxsj.jsp?code="+taxnameid+"&taxmoney="+taxmoney+"&id=<%=contractno %>&section=<%=section %>",300,300,100,100);
 

}


function printdstax1(){
  var taxmoney=0;
  var taxnameid="";
  if (document.forms[ 0 ].prtax_y.length){
  if (document.forms[ 0 ].prtax_y){
  for (var ii=0;ii< document.forms[ 0 ].prtax_y.length;ii++){
     if (document.forms[ 0 ].prtax_y[ii].checked){
	 
	    taxmoney+=parseFloat(document.forms[ 0 ].prtax_y[ii].value);
		 var id=document.forms[ 0 ].prtax_y[ii].taxid;
		 var dd=eval("document.forms[ 0 ].prtaxname_y"+id);
		 
		if (taxnameid=="")		  
		   taxnameid=dd.value;
		else
		   taxnameid+=","+dd.value;  
	 
	 }
	 document.forms[ 0 ].prtax_y[ii].checked=false;
  }
  }
  }else    if (document.forms[ 0 ].prtax_y.checked){
   taxmoney=parseFloat(document.forms[ 0 ].prtax_y.value);
  taxnameid=parseFloat(document.forms[ 0 ].prtax_y.taxid);
  }
  
 if (taxnameid==""){alert("请选择代收的税费名称");return false;}
 taxmoney= Math.round(parseFloat(taxmoney)*100,3)/100;
 document.forms[ 0 ].prtax_y.checked=false;
  openwin("printtaxsj1.jsp?code="+taxnameid+"&taxmoney="+taxmoney+"&id=<%=contractno %>&section=<%=section %>",300,300,100,100);
 

}
function addtax(){
  openwin("AddDsTax.jsp?id=<%=contractno %>",300,300,100,100);
 

}
function addz(){
   openwin("YtaizInput.jsp?id=<%=contractno %>",300,300,100,100);
}
function modiz(){
   openwin("YtaizModi.jsp?roomno=<%=roomno %>&section=<%=section %>",300,300,100,100);
}
function modiaq(){
   openwin("yxzModi.jsp?roomno=<%=roomno %>&section=<%=section %>",300,300,100,100);
}

function jqmodi(para){
 openwin("jqModi.jsp?roomno=<%=roomno %>&section=<%=section %>&contractno=<%=contractno %>&type="+para,300,300,100,100);


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
    var newwink = window.open("GatherInput.jsp?CusNo=<%= cusno %>&contractno=<%= contractno %>&period=<%=i+1 %>&eDate=<%=gather_date %>&rate=<%=rate %>&curry=<%=curry %>&ysSumMoney=<%=ysSumMoney %>" , "NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
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
	
    var newwink = window.open("GatherModify.jsp?ysID="+ysID+"&shouldmoney="+shouldmoney+"&ysDate="+ysDate+"&period="+period+"&jkstate="+jkstate+"&qianKuan="+qianKuan, "NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
    newwink.focus();
    }else{alert("请选中修改的数据");}
	}
function deletepay(){
    if (ysID!=""){
	  if (period<<%=i %>) {alert("只能删除最后一期付款,如果删除后数据不正确，可修改数据");return false;}
	  else{
  	   if (confirm("确认删除吗?")){
	    document.f1.action="yingshi.jsp?ysID="+ysID+"&cusno=<%= cusno %>&contractno=<%= contractno %>";
	    document.f1.submit();
		}
	  }	
	 }else{alert("请选中删除数据");} 
	 
}
function Edit( cusno , contractno , no , rowID,curry1,rate1,money1) {

    var spa = 60 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa / 2 ;
    var lef = spa / 2 ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=" + 400 ;
    var posi = posi + ",width=" + 350 ;

    var newwink = window.open("FactGatherDataD.jsp?CusNo="+cusno+"&contractno=" + contractno + "&no="+no + "&rowID=" + rowID+"&oldcurry="+curry1+"&oldrate="+rate1+"&oldmoney="+money1+"&ht_rate=<%=rate %>" , "NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
  
    newwink.focus();
}    
function printSJ( cusno , contractno , no , rowID ) {
    var newwink = window.open("printsj.jsp?CusNo="+cusno+"&contractno=" + contractno + "&no="+no + "&rowID=" + rowID+"&loft=<%=sectionname+roomno %>" , "NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no");
    newwink.focus();
}    
function printSJ_aj( cusno , contractno , no , rowID ) {
    var newwink = window.open("printsj_aj.jsp?CusNo="+cusno+"&contractno=" + contractno + "&no="+no + "&rowID=" + rowID+"&loft=<%=sectionname+roomno %>" , "NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no");
    newwink.focus();
}  
function printSJt( cusno , contractno , no , rowID ) {
    var newwink = window.open("printsj_t.jsp?section=<%=section %>&ld=<%=ld %>&CusNo="+cusno+"&contractno=" + contractno + "&no="+no + "&rowID=" + rowID+"&loft=<%=sectionname+roomno %>" , "NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no");
    newwink.focus();
}    
function printSJ1( cusno , contractno , no , rowID ) {
    var newwink = window.open("printsj1.jsp?CusNo="+cusno+"&contractno=" + contractno + "&no="+no + "&rowID=" + rowID+"&loft=<%=sectionname+roomno %>" , "NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no");
    newwink.focus();
}    
function printSJ4( cusno , contractno , no , rowID ) {
    var newwink = window.open("print_ys_t.jsp?CusNo="+cusno+"&contractno=" + contractno + "&no="+no + "&rowID=" + rowID+"&loft=<%=sectionname+roomno %>" , "NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no");
    newwink.focus();
}
function zhiNaJing() {
    if( checkValue() ) {
        document.forms[ 0 ].action = "yingshi.jsp?contractno="+ "<%= contractno%>" + "&cusno=" + "<%= cusno%>"
        document.forms[ 0 ].submit() ;
    }
}

function checkValue() {
    if( ! document.forms[ 0 ].zhiType[ 0 ].checked && ! document.forms[ 0 ].zhiType[ 1 ].checked ) {
        alert( "请选择滞纳金的类型!" ) ;
        return false ;
    }
    
    if( isNaN( document.forms[ 0 ].bili.value ) ) {
        alert( "请输入数值!" ) ;
        return false ;
    }

    if( isNaN( document.forms[ 0 ].jinger.value ) ) {
        alert( "请输入数值!" ) ;
        return false ;
    }
    return true ;
}


function zto(choose){//转为定金
    var spa = 60 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa / 2 ;
    var lef = spa / 2 ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height="  ;
    var posi = posi + ",width="  ;
  
    var newwink = window.open("zmoney.jsp?rg_date=<%=rg_date %>&cusname=<%=customer %>&room=<%=secname+roomno %>&contractno=<%=contractno %>&cusno=<%=cusno %>&roomcode=<%=ldroomcode%>&choose="+choose+"&rate=<%=rate %>" , "NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
    newwink.focus();
   	}

function guangbi() {    
    opener.window.location.reload() ;
    close() ;
}

var period = "" ;
var qianKuan = "" ;
var shouldmoney = "" ;
var ysDate="";
var ysID="";
var jkstate="";

function setpara(periodpass ,qianPass , shouldPass,ysid,ysdate,jk) {
    period = periodpass ;
    qianKuan = qianPass ;
    shouldmoney = shouldPass ;
	ysID=ysid;
	ysDate=ysdate;
	jkstate=jk;
	
}
function printzms(){
  open("print.jsp?contractno=<%=contractno %>","prntwin","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no")
}
function deleteFact(aa,aa1,aa2,aa3,aa4){
   if (confirm("确认删除实收登记吗？删除后不能恢复")) openwin("deleteFactGathering.jsp?id="+aa+"&FactCurry="+aa1+"&FactCurryRate="+aa2+"&rate="+aa3+"&deletemoney="+aa4+"&contractno=<%=contractno %>&cusno=<%=cusno %>","aa",10,10,10,10)

}
function dengji() {

  
    var spa = 300 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa / 2 ;
    var lef = spa ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=" + 400 ;
    var posi = posi + ",width=" +550 ;

    var newwink2 = window.open("FactGatherInput.jsp?ysmoney=<%=ysmoney%>&FactNo=<%= contractno%>&period=<%=periodN %>&CusNo=<%= cusno%>&ycurry=<%=curry %>&yrate=<%=rate %>&loft=<%=roomno %>&signatory=<%=customer %>&SecNo=<%=section %>","NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
    newwink2.focus();
   

}
function xiangqing() {
	
    var spa = 400 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa/3 ;
    var lef = spa / 2 ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=400"  ;
    var posi = posi + ",width=550";
    var newwin1=window.open("../customter/editcustomer.jsp?edit=editcus&cusno=<%=cusno%>","NewsW1","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
 
}
function contractlist(){
  openwin2('../sale/showoldContract.jsp?contractno=<%=contractno %>&secname=<%=secname %>&secno=<%=secno %>&roomno=<%=room%>&build=<%=build%>&loft=<%=strloft %>&Floor=<%=floors %>&show=true',680,530,120,2);

} 
function hsjs(para){
 if (para){
  if (confirm("确认按实结算吗？"))
   openwin("q_tax_hs.jsp?code=<%=contractno %>",10,10,10,10)
 }
 
}
function hf(para){
 if (confirm("确认恢复吗？"))
  openwin("hf_ptf.jsp?id="+para);
}
</script>
 
</body>
</html>

