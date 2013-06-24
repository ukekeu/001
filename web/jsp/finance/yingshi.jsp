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
<title>收支管理</title>


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
 String ldSQL="select * from  SL_TemporarilyBuy where  zto=0 and state=0 and roomcode="+ldroomcode+ " and Cusname='"+cusno+"'";
   ResultSet ldRs=aBean.executeQuery(ldSQL);
  
   if (!ldRs.next()){LD="false"; }
  
   ldRs.close();
   String cySQL="select * from tb_chengyi where zto=0  and send=1 and serialNo='"+cusno+"'";
   ResultSet cyRs=aBean.executeQuery(cySQL);
   if (!cyRs.next()){CY="false";}
   cyRs.close();
  
if( request.getParameter( "zhiType" ) != null  ) {
    String zhiType = request.getParameter( "zhiType" ) ;
    String bili = request.getParameter( "bili" ) ;
    if( bili.equals( "" ) ) {
        bili = "0" ;
    }
	
    String jinger = getbyte1(request.getParameter( "jinger" )) ;
    if( jinger.equals( "" ) ) {
        jinger = "0" ;
    }
    String sqZ = "" ;
    String sqClear = "" ;
	
    if( zhiType.equals( "bai" ) ) {//按百分计算
        sqZ = " update GatheringRecord set demurrage =demurrage+ datediff(day,shouldDate,getdate())*( shouldmoney - yijiao ) * " + bili + " /100 "
              + " where contactno = '" + contractno + "' "
              + " and cusno = '" + cusno + "' " 
              + " and convert(char(10),shouldDate,120) <convert(char(10),GETDATE(),120) and state != 2  ";
			 
    }else if ( zhiType.equals( "gu" ) ) {//按固定
        sqZ = " update GatheringRecord set demurrage = " + jinger
              + " where contactno = '" + contractno + "' "
              + " and cusno = '" + cusno + "' " 
              + " and convert(char(10),shouldDate,120) <convert(char(10),GETDATE(),120)  and state != 2 ";
    }
	
	try{
    aBean.executeUpdate( sqZ ) ;
	}catch(Exception s){out.print(sqZ);}

}
 
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
int i2 = 0 ;    
String gather_date ="";
int rowID=0;
String FactCurry="";
double sumfactmoney=0;
String FactCurryRate="",jsbak="";
String period ="0", context="";
String periodN ="0",print_date="";
int num=0;
int salestate=0; 
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
    String orderSQL="";
	  ResultSet orderRs =null;
	  String hs_lu="",hs_bxg="",hs_dt="",hs_g="";
	String bxgz="",dtz="",bxgzp="",dtzp="";
	String yxz_area="",yxz_area_price="";
	float ytzss=0,c_lt_price=0,c_ty_price=0,yxzprice=0;
  ResultSet rs2=null;
  String sq2="",sq="";
 String flag = "";
  ResultSet rs=null;
%>
<body topmargin="0" >
 
<form name=f1 method="post" action="yingshi.jsp?contractno=<%=contractno %>&loft=<%=loft %>&cusno=<%=cusno %>">  
 <%String sel=(String)request.getParameter("sel");
    if(sel==null) sel="1";	   %>
<table width="280" border="0" cellspacing="0" cellpadding="0" class="L2" >
  
<tr  valign="top">
    <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	  <a href="#" onclick="document.f1.sel.value=1;findSub('yingshi.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>房款管理</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.f1.sel.value=2;findSub('yingshi.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>税/配套费</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.f1.sel.value=3;findSub('yingshi.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>票据管理</font></a>
	</td>
<input type=hidden name=contractno value="<%=contractno%>">
<input type=hidden name=sel value="<%=sel%>">

<input type=hidden name=cusno value="<%=cusno%>">
<input type=hidden name=loft value="<%=loft%>">
</table>
<script>
function findSub(para){   
   document.f1.action=para;
   document.f1.submit();
}
 
</script>
<% if (sel.equals("1")){ %>
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
 orderSQL="SELECT o.floors,o.jqfk_date,o.sectionname,o.section,"; 
// orderSQL+=" o.section,o.payment,o.salerprice,o.salerprice-o.zs_first_money sjprice,o.ajmoney,c.signatory,o.floors,o.loft+o.building+o.room_no as roomno,o.sectionname,o.loft,o.building,o.room_no as room,o.section ,o.zs_first_money FROM order_contract o ,customer c where o.customer=c.serialno and o.code="+contractno;
orderSQL+="o.state salestate,o.payment,o.salerprice+o.lu_tai_area*o.lu_tai_area_price+o.gaizhang_area*o.gaizhang_unitprice salerprice,o.room_sumprice sjprice,o.ajmoney,o.salerprice/o.area tnunitprice,o.ysumprice-o.rmbprice cj_f,o.ysumprice hsprice,";
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
 
       orderRs = fBean.executeQuery( orderSQL ) ;
	 
	 if (orderRs.next()){
	    jqfk_date=getbyte(orderRs.getString("jqfk_date"));
		if (!jqfk_date.equals(""))jqfk_date=jqfk_date.substring(0,10);
	    sectionname=getbyte(orderRs.getString("sectionname")).trim();
	    section=getbyte(orderRs.getString("section"));
		salestate=orderRs.getInt("salestate");
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
		
		secname=getbyte(orderRs.getString("sectionname")).trim();
		strloft=getbyte(orderRs.getString("loft"));
		build=getbyte(orderRs.getString("building"));
		
		 
		room=getbyte(orderRs.getString("room")).trim();
		// if (floors<0)roomno=strloft+build+"地下"+(-floors)+"层"+room;
		secno=section;
		ld=secno+strloft;
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
  
        <td><font color="#FFFFFF">预售房价</font></td>
        <td><font color="#FFFFFF">成交房价</font></td>
		<td><font color="#FFFFFF">优惠</font></td>
	    <%if (Payment.indexOf("揭")>0){ %>
		<td> <font color="#FFFFFF">按揭款</font></td>
		<td> <font color="#FFFFFF">首期款</font></td>
		<%} %>
		
    </tr>
	 <tr  class=listcontent  align="center">
        <td><%if (request.getParameter("see")==null){ %><a href="javascript:xiangqing();"><%=customer %></a><%}else{ %><%=customer %><% }%></td>
        <td><%if (request.getParameter("see")==null){ %><a href="javascript:contractlist();"><%=roomno %></a><%}else{ %><%=roomno %><%} %></td>
     
        <td><%=Payment %></td>
 
		<td><%=hsprice  %></td>
		<td><%=fa.getFloat2(sjprice,2) %></td>
		<td><%=ce %></td>
		<%if (Payment.indexOf("揭")>0){ %>
		<td><%=AjPrice %></td>		
		<td><%=fa.getFloat2(sjprice-AjPrice-zs_first_money,2) %></td>
		<%} %>
    </tr>
	</table>  
	<%
	/*
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
	 orderRs.close();	*/
	 %>
	 
	
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
        <td><font color="#FFFFFF"> </font></td>
     </tr>

    <%	
	
	
  sq2 = " select sum(g.shouldmoney*g.rate) zys from GatheringRecord g,customer  c where c.serialno=g.cusno and  g.contactno = '" + contractno + "' "
                + " and g.cusno = '" + cusno + "'";
    ResultSet rs12 = fBean.executeQuery( sq2 ) ;
  double zysk=0;
if (rs12.next()) zysk=rs12.getDouble("zys");
rs12.close();

sq2 = " select sum(g.factmoney*g.currrate) zys from factGatheringRecord g,customer  c where c.serialno=g.cusno and  g.contractno = '" + contractno + "' "
                + " and g.cusno = '" + cusno + "'";
     rs12 = fBean.executeQuery( sq2 ) ;
  double zssk=0;
if (rs12.next()) zssk=rs12.getDouble("zys");
rs12.close();
 
if (zysk==zssk&&zssk>0){
 sq2="update  GatheringRecord set state=2, yijiao=shouldmoney where contactno = '" + contractno + "' ";
 
fBean.executeUpdate( sq2 ) ;
}
	 int skok=0;
       sq2 = " select g.*,g.shouldmoney-g.yijiao qk,c.signatory from GatheringRecord g,customer  c where c.serialno=g.cusno and  g.contactno = '" + contractno + "' "
                + " and g.cusno = '" + cusno + "' " + " order by g.shouldQS,shouldDate ";
      rs2 = fBean.executeQuery( sq2 ) ;
      String skstate="";
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
            skstate = "&nbsp;" ;prin=0;skok++;
        }else if( state.equals( "1" ) ) {
            skstate = "&nbsp;" ;prin=0;skok++;
        }else if( state.equals( "2" ) ) {
            skstate = "<font color=red>√</font>" ;
			
        }else{
            skstate = "" ;
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
else if (shouldQS.equals("13"))shouldQS ="屋面款";	
else if (shouldQS.equals("15"))shouldQS ="附属房产款";	

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
          <td>
		  <table border="0" width="100%"><tr><td width="60%">
		  <%if (state.equals("2")){out.print(skstate+"&nbsp;&nbsp;");}else{ if (Cortrol.indexOf("A")>=0&&skok==1){%><a href="#d"  onclick="dengji(<%=fa.getFloat3(qianKuan,3) %>,<%=qs %>);">收款</a><%}} %> 
		  </td><td width="40%">
		  <%if (Cortrol.indexOf("F")>=0){
		   if (shouldmoney>0&&!state.equals("2")){
		   %>
		   <img src="../images/icon_print.gif" alt='打印收据单' onclick="printSJ1('<%= cusno %>','<%= contractno %>','','<%= ysid%>')"  onmouseover="javascript:this.style.cursor='hand'">
		   <%
		  } else if (!state.equals("2")) {
		   %> <img src="../images/icon_print.gif" alt='打印收据单' onclick="printSJ4('<%= cusno %>','<%= contractno %>','','<%= ysid%>')"  onmouseover="javascript:this.style.cursor='hand'">
		  <%}
		   } %>
		   </td></tr></table>
		   </td>
		   
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
 </p><%
      if(statestr.equals("2"))
        flag="1";
      else flag="0";%>
	  <%if (request.getParameter("see")==null){ %>
	 
	  <%if (Cortrol.indexOf("A")>=0){%>
	   <input type=button name=facm value="退款" onclick="outdengji();">
   
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
        <td><font color="#FFFFFF">单据号</font></td> 
        <td><font color="#FFFFFF">收款人</font></td>
		 
        <td><font color="#FFFFFF">操作</font></td>
		 
    </tr>

    <%
      sq = " select id,period, gather_date,factmoney,receiver,Bill_num";
	sq+=",BillType,CurrName,CurrRate,PayType,context,printdate,checkstate,convert(char(10),checkdate,120) checkdate,checkstateperson, ";
	sq+="CurrRate*factmoney ff,jsbak from factGatheringRecord where contractno = '" + contractno + "' "
                + "  order by period , gather_date";
    //out.print(sq);
      rs = fBean.executeQuery( sq ) ;
    
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
		if (FactCurry.equals("RMB"))curryDX="人民币";
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
		else if (period.equals("13"))period ="屋面款";	
	else if (period.equals("15"))period ="附属房产款";	
	String checkdate=getbyte( rs.getString( "checkdate")) ;
	String checkstateperson=getbyte( rs.getString( "checkstateperson")) ;
	 
%>
        <tr class=listcontent align=center  title="<%=context %>">
          <td><%= num%></td>
          <td><%= period %></td>
		    <td><%= gather_date %></td>
          <td><%if (factmoney<0){out.print("<font color='#ff0000'>");} %><%= fa.getFloat2(factmoney ,2)%><%if (factmoney<0){out.print("</font>");} %></td>
		
		  <td><%= curryDX%></td>
		 <td><%= FactCurryRate%></td>
		 
          <td ><%= PayType %></td>
		   <td ><%= Billnum %></td> 
          <td><%= receiver %></td>
	 
          <td >
		  <table border="0"><tr>
		  <%if (checkstate==0){ %>
		  <%if (Cortrol.indexOf("E")>=0){%>
		  <td>
		  <img src="../images/edit.gif" alt='修改收款' onclick="Edit('<%= cusno %>','<%= contractno %>','<%= period %>','<%= rowID%>','<%=FactCurry%>','<%=FactCurryRate %>','<%=factmoney %>')" id=bian<%= i2 %> onmouseover="javascript:this.style.cursor='hand'">
		 </td>
		  <%}if (Cortrol.indexOf("D")>=0){%>
		 <td><img src="../images/button_sc.gif"  border="0"   onmouseover="javascript:this.style.cursor='hand'" title="删除" onclick="deleteFact('<%= rowID%>','<%=FactCurry%>','<%=FactCurryRate %>','<%=rate %>','<%=factmoney %>')">
		   </td><%} %>
		  <%}else{ if (Cortrol.indexOf("Q")>=0){%>
		   <td> <img src="../images/edit.gif" alt='修改收款' onclick="Edit('<%= cusno %>','<%= contractno %>','<%= period %>','<%= rowID%>','<%=FactCurry%>','<%=FactCurryRate %>','<%=factmoney %>')" id=bian<%= i2 %> onmouseover="javascript:this.style.cursor='hand'"></td><%} %>
		<td  onmouseover="javascript:this.style.cursor='hand'" title="审核人:<%=checkstateperson %>,审核日间:<%=checkdate %>"><font color="red">核</font> </td><%} %>
	 
		   
		     <%if (Cortrol.indexOf("F")>=0||print_date.equals("")){%>
			
			 <% if (factmoney>0){ %>
		    <td><img src="../images/icon_print.gif" alt='打印收据单'  onclick="printSJ('<%= cusno %>','<%= contractno %>','<%= period %>','<%= rowID%>')" id=bian<%= i2 %> onmouseover="javascript:this.style.cursor='hand'">
		       </td><%}else{ %>
              <td><img src="../images/icon_print.gif" alt='打印收据单'  onclick="printSJt('<%= cusno %>','<%= contractno %>','<%= period %>','<%= rowID%>')" id=bian<%= i2 %> onmouseover="javascript:this.style.cursor='hand'">
			   </td><%} %>
		   <%} %>
		  </tr></table>
		   </td>    
        </tr>
	
    <%
       
    }
	if (Payment.indexOf("(")>0)Payment=Payment.substring(0,Payment.indexOf("("))  ;
    %>
		 <tr bgcolor="#EBEBEB" align="center">
     <td colspan=2>
    <b>合&nbsp;&nbsp;计:</td><td colspan=7 align="left"> <b>￥<%=fa.getFloat2(sumfactmoney,2)%> 
	<%sq = " select PayType,sum(factmoney) factmoney     from factGatheringRecord where contractno = '" + contractno + "'    group by PayType";
    //out.print(sq);
      rs = fBean.executeQuery( sq ) ;
	 while (rs.next()){
	 out.print("&nbsp;"+rs.getString("PayType")+":"+fa.getFloat2(rs.getDouble("factmoney"),2) );
	  }rs.close(); %></b>
	</td> 
     <td >  
      <% if (sumfactmoney-ysSumMoney>0) out.print(" <font color=red>余额:"+curry+fa.getFloat2(sumfactmoney-ysSumMoney,2)+"</font>");
	  %>
  </td>
    </tr>
    </table>
	 
	<%if (Payment.indexOf("揭")>0||Payment.indexOf("公积")>0){ %>
	<p align="center"> <b><font size="3" color="#000080">银行放款记录</font></b></p>
	<table width="100%" border="0" cellspacing="1"   cellpadding="1">
	<tr     align="center"><td colspan="2"></td></tr> 
	<tr     align="left"><td colspan="2">
	<%if (salestate==2&&Cortrol.indexOf("A")>=0){ %>
	<input type=button name=ajm value="放款登记" onclick="openwin2('AjInput.jsp?aj=<%=AjPrice %>&cusno=<%=cusno %>&code=<%=contractno %>&room=<%=roomno %>',400,350,100,100);">
	<%} %>
	</td></tr> 
 
	<tr  class=listtitle  align="center"><td>按揭银行</td><td>放款日期</td><td>款项属性</td><td>票据号</td><td>放款金额</td><td>登记人</td><td>审核</td><td> </td></tr> 
	<%String Fsql="select id,ajbk,pjno,convert(char(10),factdate,120) factdate,factmonye,chekcer,id,checkperson,checkstate,checkdate,case when FactMoneyType=0 then '商业货款' else '公积金' end ajtype from FactAjCharges where contractno="+contractno; 
	 String ajid="";
	rs = fBean.executeQuery( Fsql ) ;
	while (rs.next()){%>
	  <tr align="center" class=listcontent>
	  
	  <td><%=ajbk%></td>
	  <td><%=rs.getString("factdate") %></td>
	  <td><%=rs.getString("ajtype") %></td>
	    <td><%=getbyte(rs.getString("pjno")) %></td>
	   <td><%=rs.getString("factmonye") %></td>
	  
	   <td> <%=rs.getString("chekcer") %></td>
	   <td><%
	   ajid=rs.getString("id");
	   boolean checkstate=rs.getBoolean("checkstate") ;
	   if (checkstate){
	   out.print(getbyte("<font color='red'>"+rs.getString("checkperson"))+"&nbsp;"+ rs.getDate("checkdate").toString()+"</font>");
	   
	   }
	  
	    %>
		</td>
	    <td width="10%">
		<table><tr>
		 <%if (Cortrol.indexOf("D")>=0&&!checkstate){%>
		<td><img src="../images/button_sc.gif"  border="0"   onmouseover="javascript:this.style.cursor='hand'"  onclick="if (confirm('确认删除吗？'))openwin('deleteAj.jsp?id= <%=ajid%>&room=<%=roomno %>',10,10,10,10);"> 
		</td><%}
		if (Cortrol.indexOf("E")>=0&&!checkstate){%><td><img src="../images/edit.gif" alt='修改收款' onmouseover="javascript:this.style.cursor='hand'" onclick="openwin('AjEdit.jsp?code= <%=rs.getString("id") %>&room=<%=roomno %>',400,350,100,100);">
		<%}else  if (Cortrol.indexOf("Q")>=0&&checkstate){ %>
		 <td><img src="../images/edit.gif" alt='修改收款'  onmouseover="javascript:this.style.cursor='hand'" onclick="openwin('AjEdit.jsp?code= <%=rs.getString("id") %>&room=<%=roomno %>',400,350,100,100);">
		<%} %>
		<td>
		</tr></table>
		</td>
		
	  </tr>
	
	
	<%}rs.close(); %>
	
	
	 
	 </table>
	
	
	<%} %>
	<% } else if (sel.equals("2")){   %>
<p align=center>
  
 
   <b><font size="3" color="#000080">应收费用一览</font></b>

 </p> 
  <%if (Cortrol.indexOf("A")>=0){%> <input type=button name=ds value="一次交完" onclick="dstax(1);"></a>&nbsp; <input type=button name=ds value="只交部分" onclick="dstax(2);">&nbsp;<!-- <input type=button name=cpt value="取消配套费" onclick="cancelpt();">&nbsp;--> <input type=button name=add value="补收项目" onclick="addtax();"><%}if (Cortrol.indexOf("F")>=0){%>   &nbsp; <input type=button name=pr value="打印收据" onclick="printdstax1();"><%} %>
 
 <table width="100%"  border="0" cellspacing="1"  cellpadding="1"  >
    <tr   class=TxtColor  align="center">
	 <td >序号</td> <td >费用名称</td><td >费用类型</td><td>应收金额</td> <td>未收金额</td>  <td>交款状态</td>  <td width="10%">&nbsp;</td> 
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
double TaxMoney=0;
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
   TaxMoney=rs.getDouble("TaxMoney");
   String state=rs.getString("state");
    q=rs.getFloat("q");
	cancel=rs.getInt("cancel");
 
	taxname_type=rs.getInt("taxname_type");
	String cancelbak=rs.getString("cancelbak");
    %> 
    <tr class=listcontent id=TR2<%=i%>  align="center"  title="双击可登记代收费用"  onclick="changeclass1(this,'clickbg','listcontent');">
      <td   ><%=i%><input name="tax" taxid=<%=id %> type="checkbox"  taxvalue=<%=TaxMoney %> value=<%=q %>>
	  <input type=hidden name=taxname<%=id %> value="<%=id %>"></td>
	  <td  ><%=TaxName%></td>
	    <td  ><%if (taxname_type==0)out.println("配套费");else out.println("税费");%></td>
	  <td  ><%=TaxMoney%></td>
	   <td  ><b><%=q%></b></td>
      <td> 
	  <%if (state.equals("0")&&cancel==0){ %>
	  未收/未付清
	   <%}else{out.print("已代收");} %>
	  </td> 
		
	 
 

   <input type=hidden name=prtaxname_y<%=id %> value="<%=TaxName %>">
 
  <td width="10%"> <%if (Cortrol.indexOf("D")>=0){%>
		  &nbsp;<img src="../images/button_sc.gif"  border="0"   onmouseover="javascript:this.style.cursor='hand'" title="删除" onclick="deleteC(<%=id %>)";>
		  <%} %>
		  <%if (Cortrol.indexOf("E")>=0){%><img src="../images/edit.gif" border="0"  onmouseover="javascript:this.style.cursor='hand'" alt='修改' onclick="openwin2('ModiTax.jsp?id=<%=id %>&taxmoneys=<%=TaxMoney %>&name=<%=TaxName %>&taxname_type=<%=taxname_type %>&state=<%=state %>',300,300,100,100);" ><%} %>
		 	<%if (TaxName.indexOf("契税")>=0) {%> <input type=checkbox name=hs value=1 onclick="hsjs(this.checked);">实结<%} %>
		  </td>
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
 <tr><td  colspan="9"> 税费合计：<%=fa.getFloat(taxprice,2) %>&nbsp;&nbsp;&nbsp;配套合计：<%=fa.getFloat(peitaoprice,2) %>&nbsp;&nbsp;&nbsp;&nbsp;合计：<%=fa.getFloat(peitaoprice+taxprice,2) %></td></tr>

</table>
<p align=center>
  <b><font size="3" color="#000080">已代收一览</font></b>
 </p>
<%if (Cortrol.indexOf("A")>=0){%> <input type=button name=outm value="代 付" onclick="outtax();">&nbsp; <input type=button name=pr value="退 款" onclick="openwin('CancelTax.jsp?code=<%=contractno %>',400,300,100,100);">&nbsp; <!--<input type=button name=pr value="补 交" onclick="openwin('AddTax.jsp?code=<%=contractno %>',400,200,100,100);">&nbsp; <%}if (Cortrol.indexOf("F")>=0){%>   &nbsp; <input type=button name=pr value="打印收据" onclick="printdstax();"><%} %>-->
 <table width="100%"  border="0" cellspacing="1"  cellpadding="1"  >
    <tr   class=TxtColor  align="center">
	 <td  >序号</td> 
      <td    >费用名称</td><td>金额</td> <td>收取日期</td> 
	 
	  <td>经手人</td>
	  <td>票据号</td>
	  
	  <td>代付</td>
    <td>&nbsp;</td>
	 
	
    </tr>
	
  
    <%
 
	
	//设定查询

   		sql="select * from factGatheringTaxRecord where contractno ='"+contractno+"'";//order by room_no desc";
//设置查询结果的存放变量
 
 
 
   rs=fBean.executeQuery(sql);
 String JKdate="";
 i=0;
 double sumtax=0;
 boolean dscheck=false;
 while (rs.next()){

  try{
     i=i+1;
  //按FIELDS顺序一GET　VALUE
   String id=rs.getString("code");
   String taxname=rs.getString("taxname");
   TaxMoney= rs.getDouble("money") ;
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
	 String dsbak=getbyte(rs.getString("bak"));
    %> 
	 <input type=hidden name=prtaxname<%=id %> value="<%=taxname %>">
    <tr class=listcontent id=TR1<%=i%>  align="center"  title="备注：<%=dsbak %>"  onclick="changeclass1(this,'clickbg','listcontent');">
      <td  ><%=i%> 
	   <input type=checkbox name="out_checkstat" <%if (taxname_type==0||!out_date.equals("")){out.print("disabled");} %>  out_m=<%=TaxMoney %>  value=<%=id %>>
	   <input type=hidden name="out_m<%=id %>" value=<%=TaxMoney %>>
	</td>
	   <td  ><%=taxname%></td>
	    <td  ><%if (TaxMoney<0){out.print("<font color='#ff0000'>");} %><%=TaxMoney%><%if (TaxMoney<0){out.print("</font>");} %></td>
	
	  <td  ><%=JKdate%></td>
       
	  <td> <%=handler %></td> 	
	    <td> <%=no %></td> 	
	<td><%if (!out_date.equals("")) %><font color=red>√</font></td>
	 
	 <td width="10%">
	 <table>
	 <tr>
		  <% 
	 if (!dscheck){%>
	   <%if (Cortrol.indexOf("D")>=0){%>
		  <td><img src="../images/button_sc.gif"  border="0"   onmouseover="javascript:this.style.cursor='hand'" title="删除" onclick="deleteFC('<%=id%>','<%=TaxMoney %>')";>
		  </td>
		  <%} %>
		    <% if (Cortrol.indexOf("E")>=0){%> 
			<td><img src="../images/edit.gif" border="0"  onmouseover="javascript:this.style.cursor='hand'" alt='修改'  onclick="openwin('ModiTaxDs.jsp?dsbak=<%=dsbak %>&no=<%=no %>&JKdate=<%=JKdate %>&id=<%=id %>&taxmoneys=<%=TaxMoney %>&name=<%=taxname %>&taxname_type=<%=taxname_type %>',300,300,100,100);" >
	        </td>
	   <%}
	 } else{ if (Cortrol.indexOf("Q")>=0){%>
	 <td><img src="../images/edit.gif" border="0"  onmouseover="javascript:this.style.cursor='hand'" alt='修改'  onclick="openwin('ModiTaxDs.jsp?dsbak=<%=dsbak %>&no=<%=no %>&JKdate=<%=JKdate %>&id=<%=id %>&taxmoneys=<%=TaxMoney %>&name=<%=taxname %>&taxname_type=<%=taxname_type %>',300,300,100,100);" >
	 </td>
	
	 <td><img src="../images/button_sc.gif"  border="0"   onmouseover="javascript:this.style.cursor='hand'" title="删除" onclick="deleteFC('<%=id%>','<%=TaxMoney %>')";>
	  </td>  
		     
	 <%}out.print("<td><font color=red>已核</font></td>") ;}
	    %>
		</tr>
		</table>
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
  <b><font size="3" color="#000080">已代付一览</font></b>
 </p>

 <table width="100%"  border="0" cellspacing="1"  cellpadding="1"  >
    <tr   class=TxtColor align="center" >
	 <td  >序号</td> 
      <td    >费用名称</td> 
	  
	   <td>代付日期</td>
	   <td>代付金额</td>
	  <td>代付人</td>
	  <td>审核人</td>
	  <td>审核日期</td>
	  
	  <td></td>
    </tr>
	
  
    <%
 
	
	//设定查询

    sql="select * from factGatheringTaxRecord where contractno ='"+contractno+"' and taxname_type=1 AND out_money>0";//order by room_no desc";
 TaxMoney=0;
 rs=fBean.executeQuery(sql);
 
    i=0;
   sumtax=0;
   double outtax=0;
 while (rs.next()){

  try{
     i=i+1;
  //按FIELDS顺序一GET　VALUE
   String id=rs.getString("code");
   String taxname=rs.getString("taxname");
   TaxMoney= rs.getDouble("money") ;
   sumtax+=TaxMoney;
      JKdate=rs.getDate("date").toString();
    String outno=getbyte(rs.getString("no"));
    String handler1=getbyte(rs.getString("handler"));
	int out_check=rs.getInt("out_check");
	String out_check_date=getbyte(rs.getString("out_check_date"));
	if (!out_check_date.equals(""))out_check_date=out_check_date.substring(0,10);
	String out_checkperson=getbyte(rs.getString("out_checkperson"));
    outtax+=rs.getDouble("out_money");
	String out_date=getbyte(rs.getString("out_date"));
	String out_money=getbyte(rs.getString("out_money"));
 	 if (!out_date.equals(""))out_date=out_date.substring(0,10);
	 String out_person=getbyte(rs.getString("out_person"));
	 boolean taxtype=rs.getBoolean("TaxName_type");
	  
    %> 
    <tr class=listcontent id=TR<%=i%>  align="center" title="双击可登记代付" ondblClick="openwin2('TaxOut.jsp?id=<%=id %>&outtax=<%=out_money %>',300,300,100,100);"  onclick="changeclass1(this,'clickbg','listcontent');"><!--" -->
      <td  ><%=i%></td>
	   <td  ><%=taxname%></td>
	  
	     <td> <%=out_date %></td> 	
		  <td> <%=out_money %></td> 	
		   <td> 
		   <%=out_person%>
		   </td>	
	      <td><%=out_checkperson %></td>
		   <td><%=out_check_date %></td>
		  <td width="10%">  
		  <% 
	 if (out_check==0){%>
	    <%if (Cortrol.indexOf("D")>=0){%>
		  &nbsp;<img src="../images/button_sc.gif"  border="0"   onmouseover="javascript:this.style.cursor='hand'" title="删除" onclick="deleteFC('<%=id%>','<%=TaxMoney %>')";>
		  <%} %>
		 
	   <% 
	   	 } else{ if (Cortrol.indexOf("Q")>=0){%> 
	 <%if (Cortrol.indexOf("D")>=0){%>
		  &nbsp;<img src="../images/button_sc.gif"  border="0"   onmouseover="javascript:this.style.cursor='hand'" title="删除" onclick="deleteOFC('<%=id%>','<%=TaxMoney %>')";>
		  <%} %>
	 <%}out.print("<font color=red>已核</font>") ;}
	    %>
		  </td>
    </tr>
    <%
  }catch(Exception ex){out.println(ex.getMessage());}

}
  rs.close();
%>
 <tr  align="center"  >
      <td  >合计：</td>
	   <td  >&nbsp;</td>
	  <td  >&nbsp;</td>
	  <td  >&nbsp;<%=fa.getFloat3(outtax,2) %></td>
	   <td  >&nbsp;</td>
	 
      <td></td> 
	  <td> &nbsp;</td> 	
    </tr>
</table>


<% } else if (sel.equals("3")){   %>
<p align=center>
  <b><font size="3" color="#000080">收据明细</font></b>
 </p>
 
   <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
    <tr  class=listtitle  align="center">
        <td><font color="#FFFFFF">序号</font></td>
		<td><font color="#FFFFFF">票据编号</font></td>
        <td><font color="#FFFFFF">开票日期</font></td>
        <td><font color="#FFFFFF">开票金额</font></td>
		  <td><font color="#FFFFFF">付款方式</font></td>
        <td><font color="#FFFFFF">开票人</font></td>
		 <td><font color="#FFFFFF">状态</font></td>
		 
    </tr>
	<%
	  sq = " select factmoney,receiver,Bill_num";
	sq+=",BillType,CurrName,CurrRate,PayType,context,convert(char(10),printdate,120) printdate,checkstate, ";
	sq+="convert(numeric(9,2),CurrRate*factmoney) ff,checkcancel,checkcanceldate,checkcancelperson from factGatheringRecord where Bill_num<>'' and  contractno = '" + contractno + "' "
                + "  order by period , gather_date";
       jj=0;
       rs = fBean.executeQuery( sq ) ;
	 while (rs.next()){jj++;
	   String canceldate=getbyte(rs.getString("checkcanceldate")) ;
	   if (canceldate.equals(""))canceldate="未核销";
	 %>
	   <tr  class=listcontent align="center">
        <td> <%=jj %> </td>
		<td> <%=rs.getString("Bill_num") %> </td>
        <td> <%=getbyte(rs.getString("printdate")) %> </td>
        <td> <%=rs.getString("ff") %> </td>
		 <td> <%=rs.getString("PayType") %> </td>
        <td> <%=rs.getString("receiver") %> </td>
		<td> <%=canceldate%> </td>
		 
		 
    </tr>
	<% }
	rs.close();%>
	 </table>
	<p align=center>
  <b><font size="3" color="#000080">发票明细</font></b>
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
		 
		 <td> </td>
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
		else fpstate="正常";
		String  fpcode=getbyte(rs.getString("code"));
		%>
		  <td><%=fpstate %></td>
		<td><a href="#" onclick="fpmodi('<%=fpcode %>');">修改</a>&nbsp;<%if (!fpstate.equals("作废")){ %><a href="#" onclick="fpzf('<%=getbyte(rs.getString("code")) %>');">作废</a><%} %><%if (fpstate.equals("作废")){ %><a href="#" onclick="fpff();">恢复</a><%} %> 
      <%if (fpstate.equals("正常")){ %>
	   <img src="../images/icon_print.gif" alt="打印发票" onclick="printfp('<%= cusno %>','<%= fpcode %>','','');" id="bian<%= i2 %>" onmouseover="javascript:this.style.cursor='hand'">
		<%}else{ %>
		&nbsp;&nbsp;
		<%} %>
		</td>
       	 
    </tr>
		   
	<%ii++;
		  }
		  rs.close();
	 }			
	 %>
</table>
<p>&nbsp;结算日期<INPUT TYPE=TEXT NAME="jq_date" size=12 value="<%=jq_date %>" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(jq_date);return false;">结算备注:<input type=text name=bak size=50 value="<%=Jq_BAK %>" onchange="modibak();">
</p>
<p>交房日期:<INPUT TYPE=TEXT NAME="jf_date" size=12 value="<%=jf_date %>"  onblur="jfbak();"  ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(jf_date);document.forms[0].jf_date.focus();"return false;">(选择交楼日期后需要点击页面一次才能更新)
</p>
    <p align=center>
        <input type=button name=buttc value=" 关闭 " onclick="window.close()" >
		  &nbsp;
		 
		   <input type="button" value="结算清单" name="submit1" onclick="printrg();">
		 
	 &nbsp;  <input type="button" value="打印购房清单" name="submit2" onclick="openwin('goufangqingdan.jsp?code=<%=contractno %>',500,450,10,10);">
	
		 <input type=button name=buttp value="楼款证明书 " onclick="printzms()" >
		 <input type=button name=buttp value="付清楼款证明书 " onclick="printzms1()" >
		
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

function fpmodi(para) {

  
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

    var newwink2 = window.open("F_fp_modi.jsp?contractno="+para,"NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
    newwink2.focus();
   

}

function fpzf(para) {

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

    var newwink2 = window.open("F_fp_zf.jsp?contractno="+para,"NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
 
   }

}

function fpff() {

  if (confirm("确认恢复?")){
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
  openwin("TaxInput.jsp?code="+taxnameid+"&taxmoney="+taxmoney+"&id=<%=contractno %>",300,200,100,100);
 else
    openwin("TaxInput1.jsp?code="+taxnameid+"&taxmoney="+taxmoney+"&id=<%=contractno %>",300,200,100,100);
 

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
 
  if (document.forms[ 0 ].tax.length){
  if (document.forms[ 0 ].tax){

  for (var ii=0;ii< document.forms[ 0 ].tax.length;ii++){
     if (document.forms[ 0 ].tax[ii].checked){
	 
	    taxmoney+=parseFloat(document.forms[ 0 ].tax[ii].taxvalue);
		 var id=document.forms[ 0 ].tax[ii].taxid;
		 var dd=eval("document.forms[ 0 ].prtaxname_y"+id);
		 
		if (taxnameid=="")		  
		   taxnameid=dd.value;
		else
		   taxnameid+=","+dd.value;  
	 
	 }
	 document.forms[ 0 ].tax[ii].checked=false;
  }
  }
  }else    if (document.forms[ 0 ].tax.checked){
   taxmoney=parseFloat(document.forms[ 0 ].tax.taxvalue);
  taxnameid=parseFloat(document.forms[ 0 ].tax.taxid);
  }
  
 if (taxnameid==""){alert("请选择代收的税费名称");return false;}
 taxmoney= Math.round(parseFloat(taxmoney)*100,3)/100;
 document.forms[ 0 ].tax.checked=false;
  openwin2("printtaxsj1.jsp?code="+taxnameid+"&taxmoney="+taxmoney+"&id=<%=contractno %>&section=<%=section %>",450,300,100,100);
 

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
function deleteC(para){
if (confirm("确认删除吗？删除时会连已收费用也删除且删除后不能恢复")){
 var newwink = openwin2("deleteC.jsp?id="+para ,40,30,10,10);
   // newwink.focus();
}
}
function deleteFC(para,para1){
if (confirm("确认删除吗？删除后不能恢复")){
 var newwink = openwin2("deleteFC.jsp?id="+para+"&money="+para1 ,40,30,10,10);
  //  newwink.focus();
}}
function deleteOFC(para,para1){
if (confirm("确认删除吗？删除后不能恢复")){
 var newwink = openwin2("deleteOFC.jsp?id="+para+"&money="+para1 ,40,30,10,10);
  //  newwink.focus();
}}

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
	  //if (period<<%=i %>) {alert("只能删除最后一期付款,如果删除后数据不正确，可修改数据");return false;}
	  //else{
  	   if (confirm("确认删除吗?")){
	    document.f1.action="yingshi.jsp?ysID="+ysID+"&cusno=<%= cusno %>&contractno=<%= contractno %>";
	    document.f1.submit();
		//}
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
    var newwink = openwin2("printsj.jsp?CusNo="+cusno+"&contractno=" + contractno + "&no="+no + "&rowID=" + rowID+"&loft=<%=sectionname.trim()+roomno.trim()%>" ,450,300,100,100);
  
}    
function printfp( cusno , contractno , no , rowID ) {
    var newwink = openwin2("printfp.jsp?CusNo="+cusno+"&contractno=" + contractno + "&no="+no + "&rowID=" + rowID+"&loft=<%=sectionname.trim()+roomno.trim()%>" ,450,300,100,100);
 
}    
function printSJ_aj( cusno , contractno , no , rowID ) {
    var newwink = openwin2("printsj_aj.jsp?CusNo="+cusno+"&contractno=" + contractno + "&no="+no + "&rowID=" + rowID+"&loft=<%=sectionname+roomno %>" ,450,300,100,100);
     
}  
function printSJt( cusno , contractno , no , rowID ) {
    var newwink = openwin2("printsj_t.jsp?section=<%=section %>&ld=<%=ld %>&CusNo="+cusno+"&contractno=" + contractno + "&no="+no + "&rowID=" + rowID+"&loft=<%=sectionname.trim()+roomno.trim() %>" ,450,300,100,100);
   
}    
function printSJ1( cusno , contractno , no , rowID ) {
    var newwink = openwin2("printsj1.jsp?CusNo="+cusno+"&contractno=" + contractno + "&no="+no + "&rowID=" + rowID+"&loft=<%=sectionname+roomno %>" ,450,300,100,100);
    
}    
function printSJ4( cusno , contractno , no , rowID ) {
    var newwink = openwin2("print_ys_t.jsp?section=<%=section %>&CusNo="+cusno+"&contractno=" + contractno + "&no="+no + "&rowID=" + rowID+"&loft=<%=sectionname+roomno %>&ld=<%=ld %>" ,450,300,100,100);
   
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
  openwin("print.jsp?contractno=<%=contractno %>","prntwin",10,10,10,10)
}
function printzms1(){
  openwin("printzms.jsp?contractno=<%=contractno %>","prntwin",10,10,10,10)
}
function deleteFact(aa,aa1,aa2,aa3,aa4){
   if (confirm("确认删除实收登记吗？删除后不能恢复")) 
   {
    if (parseFloat(aa4)>0)
      openwin("deleteFactGathering.jsp?id="+aa+"&FactCurry="+aa1+"&FactCurryRate="+aa2+"&rate="+aa3+"&deletemoney="+aa4+"&contractno=<%=contractno %>&cusno=<%=cusno %>","aa",10,10,10,10)
   else
      openwin("deleteFactGathering1.jsp?id="+aa+"&FactCurry="+aa1+"&FactCurryRate="+aa2+"&rate="+aa3+"&deletemoney="+aa4+"&contractno=<%=contractno %>&cusno=<%=cusno %>","aa",10,10,10,10)
     
   }
   
}
function dengji(para1,para2) {

  
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

    var newwink2 = window.open("FactGatherInput.jsp?ysmoney="+para1+"&FactNo=<%= contractno%>&period="+para2+"&CusNo=<%= cusno%>&ycurry=<%=curry %>&yrate=<%=rate %>&loft=<%=roomno %>&signatory=<%=customer %>&SecNo=<%=section %>","NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
    newwink2.focus();
   

}
function outdengji() {

  
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

    var newwink2 = window.open("FactGatherout.jsp?ysmoney=0&FactNo=<%= contractno%>&period=&CusNo=<%= cusno%>&ycurry=<%=curry %>&yrate=<%=rate %>&loft=<%=roomno %>&signatory=<%=customer %>&SecNo=<%=section %>","NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
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
 var o_tax=0;
function getseldocs3() {
     var x=0;
	 o_tax=0;
	 var seldocs = new Array();
	 var temp=f1.elements.length;
     for (i=0;i<f1.elements.length;i++) {
       if ((f1.elements[i].type=="checkbox")&&(f1.elements[i].checked)&&(f1.elements[i].name=="out_checkstat"))
		 { 
		    seldocs[x]=f1.elements[i].value ;
			  var id=f1.elements[i].value;
			  var dd=eval("document.forms[ 0 ].out_m"+id);
		    
			 o_tax+=parseFloat(dd.value);
			x++;
   		 }
	  }	

   return seldocs ;
}
function outtax(){
if (getseldocs3()==""){alert("请选择代付");return false;}
 
 openwin2("TaxOut.jsp?id="+getseldocs3()+"&outtax="+o_tax,400,300,100,100);

}
function hf(para){
 if (confirm("确认恢复吗？"))
  openwin("hf_ptf.jsp?id="+para);
}
</script>
 
</body>
</html>

