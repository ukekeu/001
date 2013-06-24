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
String Cortrol=checke_qx(aBean,(String)session.getAttribute("loginid"),"S002");

 %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>收款明细表</title>


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

<form name=f1 method="post">  
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
 String floors="";
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
String pih="";
String cj_f="";
 String orderSQL="SELECT o.section,"; 
// orderSQL+=" o.section,o.payment,o.salerprice,o.salerprice-o.zs_first_money sjprice,o.ajmoney,c.signatory,o.floors,o.loft+o.building+o.room_no as roomno,o.sectionname,o.loft,o.building,o.room_no as room,o.section ,o.zs_first_money FROM order_contract o ,customer c where o.customer=c.serialno and o.code="+contractno;
orderSQL+="o.payment,o.salerprice+o.lu_tai_area*o.lu_tai_area_price+o.gaizhang_area*o.gaizhang_unitprice salerprice,o.salerprice-o.zs_first_money sjprice,o.ajmoney,";
orderSQL+="c.signatory,o.floors,o.loft+o.building+o.room_no as roomno,o.sectionname,";
orderSQL+="o.loft,o.building,o.room_no as room,o.section,o.zs_first_money,o.Y_lu_tai_area,";
orderSQL+="o.lu_tai_area,o.lu_tai_area_price,o.gaizhang_area,o.gaizhang_unitprice,";
orderSQL+="o.lu_tai_area*o.lu_tai_area_price+o.gaizhang_area*o.gaizhang_unitprice+";
orderSQL+="o.yang_tai_area*o.yang_tai_price pih,o.date,";
orderSQL+="o.Y_lu_tai_area*o.lu_tai_area_price+o.gaizhang_area*o.gaizhang_unitprice+";
orderSQL+="o.yang_tai_area*o.yang_tai_price pi,(o.salerprice-o.zs_first_money-o.gaizhang_area*o.gaizhang_unitprice) roomprice,";
orderSQL+="o.Y_yang_tai_area,o.yang_tai_area,o.yang_tai_price,cj_f FROM order_contract o ,customer c";
orderSQL+=" where o.customer=c.serialno and o.code="+contractno;
 	
     ResultSet orderRs = fBean.executeQuery( orderSQL ) ;
	 if (orderRs.next()){
	    section=getbyte(orderRs.getString("section"));
	    Payment=getbyte(orderRs.getString("payment"));
	    SalePrice=orderRs.getDouble("salerprice");
		sjprice=orderRs.getDouble("sjprice");
  	    AjPrice=orderRs.getDouble("ajmoney");
		customer=getbyte(orderRs.getString("signatory"));
		floors=getbyte(orderRs.getString("floors"));
		roomno=getbyte(orderRs.getString("roomno"));
		secname=getbyte(orderRs.getString("sectionname"));
		strloft=getbyte(orderRs.getString("loft"));
		build=getbyte(orderRs.getString("building"));
		room=getbyte(orderRs.getString("room"));
		secno=section;
		zs_first_money=orderRs.getInt("zs_first_money");
		  lu_tai_area=fa.getFloat( orderRs.getFloat("Y_lu_tai_area"),3);
		  lu_tai_mapp_area=fa.getFloat( orderRs.getFloat("lu_tai_area"),3);
		  lu_tai_area_price=fa.getFloat( orderRs.getFloat("lu_tai_area_price"),3); 
		  gaizhang_area=fa.getFloat( orderRs.getFloat("gaizhang_area"),3); 
		  gaizhang_unitprice=fa.getFloat( orderRs.getFloat("gaizhang_unitprice"),3); 
		  pih=fa.getFloat( orderRs.getFloat("pih"),3); 
		  rg_date=orderRs.getDate("date").toString();
		  pi=fa.getFloat( orderRs.getFloat("pi"),3); 
		  roomprice=fa.getFloat2( orderRs.getDouble("roomprice"),2); 
		  yang_tai_area=fa.getFloat( orderRs.getFloat("Y_yang_tai_area"),3); 
          yang_tai_mapp_area=fa.getFloat( orderRs.getFloat("yang_tai_area"),3); 
          yang_tai_price=fa.getFloat( orderRs.getFloat("yang_tai_price"),3); 
		  cj_f=fa.getFloat( orderRs.getFloat("cj_f"),3); 

	 }
    orderRs.close();

	 if (Payment.indexOf("揭")>0)Payment=Payment.substring(0,Payment.indexOf("揭")+1);
	 
  %>
   <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
    <tr    class=listtitle   align="center">
        <td> <font color="#FFFFFF"> 客户姓名</font></td>
        
        <td><font color="#FFFFFF">房间号</font></td>
		
        <td><font color="#FFFFFF">付款方式</font></td>
  
        <td><font color="#FFFFFF">成交总价</font></td>
        <td><font color="#FFFFFF">成交房款</font></td>
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
 
		<td><%=fa.getFloat2(SalePrice,2) %></td>
		<td><%=fa.getFloat2(sjprice,2) %></td>
		<td><%=cj_f %></td>
		<%if (Payment.indexOf("揭")>0){ %>
		<td><%=AjPrice %></td>		
		<td><%=fa.getFloat2(SalePrice-AjPrice-zs_first_money,2) %></td>
		<%} %>
    </tr>
	</table>  <p align=center>
     <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
    <tr   class=listtitle    align="center"><td>露台面积</td><td>露台核实面积</td><td>花园/露台单价</td><td>改装面积</td><td>改装核实面积</td><td>改装单价</td><td>阳台面积</td></tr>
	<tr    class=listcontent  align="center"><td><%=lu_tai_area %>&nbsp;</td><td><%=lu_tai_mapp_area %>&nbsp;</td>
	<td><%=lu_tai_area_price %>&nbsp;</td><td><%=gaizhang_area %>&nbsp;</td><td>&nbsp;</td>
	<td><%=gaizhang_unitprice %>&nbsp;</td><td><%=yang_tai_area %>&nbsp;</td>
	</tr>
	  
	</table>
	  
	
	
	 <p align=center>
  <b><font size="3" color="#000080">应收一览表</font></b>
 </p> <%
	if (Cortrol==null){Cortrol="";}
	%>
    <table width=100% border="0"><tr height="16" bgcolor="#EAEAEA">
 <td align="left">
 <%//if (request.getParameter("see")==null){ %>
<%//if (Cortrol.indexOf("A")>=0){%>
 <input type=button name=fac value="增　加" onclick="addpay();">
<%//} %> <%// if (Cortrol.indexOf("E")>=0){ %>
 <input type=button name=modi value="修  改" onclick="editpay();">
<%//}if (Cortrol.indexOf("D")>=0){ %>
 <input type=button name=de value="删  除" onclick="deletepay();">
<%//} %>
<%//} %>
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
    String sq2 = " select g.*,c.signatory from GatheringRecord g,customer  c where c.serialno=g.cusno and  g.contactno = '" + contractno + "' "
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
        double qianKuan = shouldmoney - ciQiYiJiao ;
		if (qianKuan<=0)qianKuan=0;
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
if (shouldQS.equals("0"))shouldQS ="订金";
else if (shouldQS.equals("1")) shouldQS ="房款";
else if (shouldQS.equals("2"))shouldQS ="房款";
else if (shouldQS.equals("3"))shouldQS ="房款";	
else if (shouldQS.equals("4"))shouldQS ="房款";	
else if (shouldQS.equals("5"))shouldQS ="花园/露台款";	 
else if (shouldQS.equals("6"))shouldQS ="改装款";	  
%>
 
 
	    <tr  class=listcontent id=TR<%=i%> align="center"     onclick="setpara( '<%= qs %>' , '<%= qianKuan+demurrage%>' , '<%= shouldmoney %>','<%=ysid %>','<%=shouldDate %>','<%=statevalue %>' );changeclass1(this,'clickbg','listcontent');" 　onmouseover="mout(this);">
          <td><%= jj %></td>
		     <td><%= shouldQS %></td>
          <td><%= shouldDate %></td>
		   <% if (qs.equals("5")){ %>
          <td ><%= fa.getFloat2(shouldmoney,2)%></td>
         <%}else{ %>
		     <td ><%= fa.getFloat2(shouldmoney,2)+"("+fa.getFloat2(shouldmoney/SalePrice*100,2)+"%)" %></td>
         <%} %>
         <td><%= fa.getFloat2(ciQiYiJiao,2) %></td>
          <td><%= fa.getFloat2(qianKuan ,2)%></td>
          <td><%= fa.getFloat2(demurrage,2) %></td>
          <td><%= state %><%if (Cortrol.indexOf("F")>=0){%>
		 <!--  <img src="../images/icon_print.gif" alt='打印收据单' onclick="printSJ1('<%= cusno %>','<%= contractno %>','','<%= ysid%>')"  onmouseover="javascript:this.style.cursor='hand'">-->
		   <%} %></td>
		   
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
<!--
    <tr bgcolor="#EBEBEB" >
     <td colspan=7>
	 <%//if (request.getParameter("see")==null){ %>
      <input type=radio name=zhiType  checked value="bai">滞纳金比例<input type=text name=bili size=10>%
      <input type=radio name=zhiType value="gu">固定滞纳金<input type=text name=jinger size=10>
  <%//if (Cortrol.indexOf("A")>=0){%>
      <input type=button name=b1 value="确定" onclick="zhiNaJing()" >
	  <%
	//  }
	 //}
		   %>
     <td>
    </tr>
-->
    </table>


 <p align=center>
  <b><font size="3" color="#000080">实收一览表</font></b>
 </p><%String flag = "";
      if(statestr.equals("2"))
        flag="1";
      else flag="0";%>
	  <%if (request.getParameter("see")==null){ %>
	  <%if (Cortrol.indexOf("A")>=0){%>
	 <!--  <input type=button name=fac value="增　加" onclick="dengji();">-->
   
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
	 
    </tr>
    <%
    String sq = " select id,period, gather_date,factmoney,receiver,Bill_num";
	sq+=",BillType,CurrName,CurrRate,PayType,context,printdate,checkstate, ";
	sq+="CurrRate*factmoney ff,jsbak from factGatheringRecord where checkstate=1 and contractno = '" + contractno + "' "
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
		   
		 
             
        </tr>
	
    <%
       
    }
	if (Payment.indexOf("(")>0)Payment=Payment.substring(0,Payment.indexOf("("))  ;
    %>
		 <tr bgcolor="#EBEBEB" align="center">
     <td colspan=2>
    <b>合&nbsp;&nbsp;计:</td><td colspan=5 align="left"> <b>￥<%=fa.getFloat2(sumfactmoney,2)%> </b><br>备注：<%=context %> </td> 
     <td >
    <% if (sumfactmoney-(ysSumMoney)>0) out.print(" <font color=red>余额:"+curry+fa.getFloat2(sumfactmoney-ysSumMoney,2)+"</font>");
	  %>
  </td>
    </tr>
    </table>
	<%if (Payment.indexOf("揭")>0){ %>
	
	<table width="100%">
	<tr     align="center"><td colspan="2"> <b><font size="3" color="#000080">银行放款记录</font></b></td></tr> 
	<tr     align="left"><td colspan="2">
	<%if (Cortrol.indexOf("A")>=0){%>
	<!--<input type=button name=ajm value="放款登记" onclick="openwin1('AjInput.jsp?aj=<%=AjPrice %>&cusno=<%=cusno %>&code=<%=contractno %>',400,350,100,100);"></td></tr> -->
     <%} %>
	<tr  class=listtitle  align="center"><td>放款日期</td><td>放款金额</td><td>登记人</td></tr> 
	<%String Fsql="select * from FactAjCharges where contractno="+contractno; 
	 
	rs = fBean.executeQuery( Fsql ) ;
	while (rs.next()){%>
	  <tr align="center"><td><%=rs.getDate("factdate").toString() %></td>
	  <td><%=rs.getString("factmonye") %></td>
	   <td> <%=rs.getString("chekcer") %></td>
	  </tr>
	
	
	<%}rs.close(); %>
	
	
	 
	 </table>
	
	
	<%} %>
<p align=center>
  <b><font size="3" color="#000080">应交费用一览</font></b>
 </p>
 <!--<input type=button  name=count value="计算费用" onclick="openwin('TaxCount1.jsp?code=<%=contractno %>',10,10,10,10);">-->
 <table width="100%"  border="0" cellspacing="1"  cellpadding="1"  >
    <tr   class=TxtColor >
	 <td  >序号</td> 
      <td    >费用名称</td><td>金额</td> 
	  <td>状态</td> 
    </tr>
	
  
    <%
String sql="";
String sql1="";
	
	//设定查询

   		sql="select id,TaxName,TaxMoney,state,TaxMoney-factmoney q,cancel from GatheringTaxRecord where contactno ='"+contractno+"'";//order by room_no desc";
//设置查询结果的存放变量
int ID=0;
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
    %> 
    <tr class=listcontent id=TR2<%=i%>  align="left"  title="双击可登记代收费用" ondblClick="openwin('ModiTax.jsp?id=<%=id %>&taxmoneys=<%=TaxMoney %>&name=<%=TaxName %>',300,300,100,100);" onclick="changeclass1(this,'clickbg','listcontent');">
      <td  ><%=i%></td>
	  <td  ><%=TaxName%></td>
	  <td  ><%=TaxMoney%></td>
      <td> 
	  <%if (state.equals("0")){ %>
	  <a href="#" onclick="openwin('ModiTax.jsp?id=<%=id %>&taxmoneys=<%=TaxMoney %>&name=<%=TaxName %>',300,300,100,100);" >修改</a>
	<%}else{out.print("已代收");} %>
	  <%if (cancel==1){out.print("被业主取消");} %>
	   </td> 
		
    </tr>
    <%
  }catch(Exception ex){out.println(ex.getMessage());}

}
 rs.close();
 sql="select sum(TaxMoney) TaxMoney,taxname_type from GatheringTaxRecord where contactno ='"+contractno+"' group by taxname_type";//order by room_no desc";
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
  <b><font size="3" color="#000080">代收一览</font></b>
 </p>
 <%//if (Cortrol.indexOf("A")>=0){%>
<!-- <input type=button name=ds value="一次交完" onclick="dstax(1);">&nbsp; <input type=button name=ds value="只交部分" onclick="dstax(2);">&nbsp; <input type=button name=pr value="打印收据" onclick="printdstax();">-->
 <%//} %>
 <table width="100%"  border="0" cellspacing="1"  cellpadding="1"  >
    <tr   class=TxtColor >
	 <td  >序号</td> 
      <td    >费用名称</td><td>金额</td> <td>收取日期</td> 
	  <td>票据编号</td> 
	  <td>代收人</td>
	    <td>收据</td>

    </tr>
	
  
    <%
 
	
	//设定查询

   		sql="select * from factGatheringTaxRecord where checkstate=1 and  contractno ='"+contractno+"'";//order by room_no desc";
//设置查询结果的存放变量
 
 
 
   rs=fBean.executeQuery(sql);
 String JKdate="";
 i=0;
 float sumtax=0;
 while (rs.next()){

  try{
     i=i+1;
  //按FIELDS顺序一GET　VALUE
   String id=rs.getString("code");
   String taxname=rs.getString("taxname");
   TaxMoney= rs.getFloat("money") ;
   sumtax+=TaxMoney;
   JKdate=rs.getDate("date").toString();
   String no=getbyte(rs.getString("no"));
    String handler=getbyte(rs.getString("handler"));
    %> 
    <tr class=listcontent id=TR1<%=i%>  align="left"    onclick="changeclass1(this,'clickbg','listcontent');">
      <td  ><%=i%></td>
	   <td  ><%=taxname%></td>
	  <td  ><%=TaxMoney%></td>
	  <td  ><%=JKdate%></td>
      <td> <%=no %></td> 
	  <td> <%=handler %></td> 	
	  <td> 
	  	  <input type=hidden name=prtaxname<%=id %> value="<%=taxname %>">
	   <input name="prtax" taxid=<%=id %> type="checkbox" value=<%=TaxMoney %>></td>
   
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
<p>结算备注:<input type=text name=bak size=50 value="<%=jsbak %>">&nbsp;<INPUT TYPE=TEXT NAME="jq_date" size=12 value="" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(jq_date);return false;">
</p>
    <p align=center>
        <input type=button name=buttc value=" 关闭 " onclick="window.close()" >
		 
    </p>

 </form>

<script lang=javascript>
function printrg(){
 if (document.forms[0].bak.value==""){alert("请填写结算备注");return false;}
  window.open("jieqingdan.jsp?code=<%=contractno %>&bak="+document.forms[0].bak.value+"&jq_date="+document.forms[0].jq_date.value);

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
	 
	 }
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
  }
  }
  }else    if (document.forms[ 0 ].prtax.checked){
   taxmoney=parseFloat(document.forms[ 0 ].prtax.value);
  taxnameid=parseFloat(document.forms[ 0 ].prtax.taxid);
  }
 if (taxnameid==""){alert("请选择代收的税费名称");return false;}
 taxmoney= Math.round(parseFloat(taxmoney)*100,3)/100;

  openwin("printtaxsj.jsp?code="+taxnameid+"&taxmoney="+taxmoney+"&id=<%=contractno %>",300,300,100,100);
 

}

function addz(){
   openwin("YtaizInput.jsp?id=<%=contractno %>",300,300,100,100);
}
function modiz(){
   openwin("YtaizModi.jsp?id=<%=contractno %>",300,300,100,100);
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
    var newwink = window.open("GatherInput.jsp?CusNo=<%= cusno %>&contractno=<%= contractno %>&period=<%=i+1 %>&eDate=<%=gather_date %>&rate=<%=rate %>&curry=<%=curry %>&ysSumMoney=<%=ysSumMoney %>&Payment=<%=Payment %>" , "NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
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
	
    var newwink = window.open("GatherModify1.jsp?ysID="+ysID+"&shouldmoney="+shouldmoney+"&ysDate="+ysDate+"&period="+period+"&jkstate="+jkstate+"&qianKuan="+qianKuan, "NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
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
    var newwink = window.open("printsj.jsp?CusNo="+cusno+"&contractno=" + contractno + "&no="+no + "&rowID=" + rowID+"&loft=<%=roomno %>" , "NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no");
    newwink.focus();
}    
function printSJ1( cusno , contractno , no , rowID ) {
    var newwink = window.open("printsj1.jsp?CusNo="+cusno+"&contractno=" + contractno + "&no="+no + "&rowID=" + rowID+"&loft=<%=roomno %>" , "NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no");
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
  openwin2('../sale/showContract.jsp?secname=<%=secname %>&secno=<%=secno %>&roomno=<%=room%>&build=<%=build%>&loft=<%=strloft %>&Floor=<%=floors %>&show=true',680,530,120,2);

} 
window.close();
</script>

</body>
</html>

