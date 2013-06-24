 
 <%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%> 
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="fa" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
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
String Cortrol=checke_qx(aBean,(String)session.getAttribute("loginid"),"F013");

 %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>收款审核表</title>


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



//审核
String checkstat[]=request.getParameterValues("checkstat");
String check_roomno=getbyte1(request.getParameter( "roomno" )) ;
if (checkstat!=null){
String ids="";
for (int aa=0;aa<checkstat.length;aa++){
   
      if (ids.equals(""))ids=checkstat[aa];
	  else ids+=","+checkstat[aa];
}
aBean.executeUpdate("update factGatheringRecord  set checkstate =1,checkDATE=getdate(),checkstateperson='"+(String)session.getAttribute("loginname") +"' where id in ("+ids +")") ;
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "收款审核" , 
                  "审核"+check_roomno
                ) ;	
}
//核销
String checkcancelS[]=request.getParameterValues("checkcancel");
if (checkcancelS!=null){
String ids="";
for (int aa=0;aa<checkcancelS.length;aa++){
   
      if (ids.equals(""))ids=checkcancelS[aa];
	  else ids+=","+checkcancelS[aa];
}
aBean.executeUpdate("update factGatheringRecord  set checkcancel =1,checkcanceldate=getdate(),checkcancelperson='"+(String)session.getAttribute("loginname") +"' where id in ("+ids +")") ;
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "票据核销" , 
                  "核销"+check_roomno
                ) ;	
}

//代收审核
String d_checkstat[]=request.getParameterValues("d_checkstat");
if (d_checkstat!=null){
String ids="";
for (int aa=0;aa<d_checkstat.length;aa++){
   
      if (ids.equals(""))ids=d_checkstat[aa];
	  else ids+=","+d_checkstat[aa];
}
aBean.executeUpdate("update FactGatheringTaxRecord  set checkperson='"+(String)session.getAttribute("loginname") +"',checkdate=getdate() ,checkstate =1 where code in ("+ids +")") ;
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "代收审核" , 
                  "审核"+check_roomno
                ) ;	
}


//放款审核
String fkcheckcancel[]=request.getParameterValues("fkcheckcancel");
if (fkcheckcancel!=null){
String ids="";
for (int aa=0;aa<fkcheckcancel.length;aa++){
   
      if (ids.equals(""))ids=fkcheckcancel[aa];
	  else ids+=","+fkcheckcancel[aa];
}
aBean.executeUpdate("update FactAjCharges  set checkperson='"+(String)session.getAttribute("loginname") +"',checkdate=getdate() ,checkstate =1 where id in ("+ids +")") ;
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "放款审核" , 
                  "审核"+check_roomno
                ) ;	
}



%>

<%
//判断此房是否被临定过及此客户是否诚意登记过
String LD="true";
String CY="true";
 String ldroomcode=request.getParameter("ldroomcode");
 String ldSQL="select * from  SL_TemporarilyBuy where  zto=0 and state=0  and roomcode="+ldroomcode+ " and Cusname='"+cusno+"'";


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
<body>

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
String pih="",ajbk="";

 String orderSQL="SELECT o.section,"; 
// orderSQL+=" o.section,o.payment,o.salerprice,o.salerprice-o.zs_first_money sjprice,o.ajmoney,c.signatory,o.floors,o.loft+o.building+o.room_no as roomno,o.sectionname,o.loft,o.building,o.room_no as room,o.section ,o.zs_first_money FROM order_contract o ,customer c where o.customer=c.serialno and o.code="+contractno;
orderSQL+="o.payment,o.salerprice+o.lu_tai_area*o.lu_tai_area_price+o.gaizhang_area*o.gaizhang_unitprice salerprice,o.rmbprice sjprice,o.ajmoney,";
orderSQL+="c.signatory,o.floors,o.loft+o.building+o.room_no as roomno,o.sectionname,";
orderSQL+="o.loft,o.building,o.room_no as room,o.section,o.zs_first_money,o.Y_lu_tai_area,";
orderSQL+="o.lu_tai_area,o.lu_tai_area_price,o.gaizhang_area,o.gaizhang_unitprice,";
orderSQL+="o.lu_tai_area*o.lu_tai_area_price+o.gaizhang_area*o.gaizhang_unitprice+";
orderSQL+="o.yang_tai_area*o.yang_tai_price pih,o.date,";
orderSQL+="o.Y_lu_tai_area*o.lu_tai_area_price+o.gaizhang_area*o.gaizhang_unitprice+";
orderSQL+="o.yang_tai_area*o.yang_tai_price pi,(o.salerprice-o.zs_first_money)-o.gaizhang_area*o.gaizhang_unitprice roomprice,";
orderSQL+="o.Y_yang_tai_area,o.yang_tai_area,o.yang_tai_price,o.ajbk  FROM order_contract o ,customer c";
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
		secno=getbyte(orderRs.getString("section"));
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
          ajbk =getbyte(orderRs.getString("ajbk"));
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
		 
		<%if (Payment.indexOf("揭")>0){ %>
		<td><%=AjPrice %></td>		
		<td><%=fa.getFloat2(sjprice-AjPrice-zs_first_money,2) %></td>
		<%} %>
    </tr>
	</table> 
	<!-- <p align=center>
     <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
    <tr   class=listtitle    align="center"><td>花园/露台<br>面积</td><td>花园/露台<br>核实面积</td><td>花园/露台<br>单价</td><td>改装面积</td><td>改装核实<br>面积</td><td>改装单价</td><td>阳台面积</td></tr>
	<tr    class=listcontent  align="center"><td><%=lu_tai_area %>&nbsp;</td><td><%=lu_tai_mapp_area %>&nbsp;</td>
	<td><%=lu_tai_area_price %>&nbsp;</td><td><%=gaizhang_area %>&nbsp;</td><td>&nbsp;</td>
	<td><%=gaizhang_unitprice %>&nbsp;</td><td><%=yang_tai_area %>&nbsp;</td>
	</tr>
	  
	</table>
	花园/露台款：<%=pi %>&nbsp;&nbsp;&nbsp;花园/露台核实款:<%=pih %>
	-->
	<hr>
	 <p align=center>
  <b><font size="3" color="#000080">应收一览表</font></b>
 </p><%
	if (Cortrol==null){Cortrol="";}
	%>
 
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
if (shouldQS.equals("0"))shouldQS ="定金";
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
          <td><%= state %></td>
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
     <td colspan=7>
	 <%if (request.getParameter("see")==null){ %>
      <input type=radio name=zhiType  checked value="bai">滞纳金比例<input type=text name=bili size=10>%
      <input type=radio name=zhiType value="gu">固定滞纳金<input type=text name=jinger size=10>
  <%if (Cortrol.indexOf("A")>=0){%>
      <input type=button name=b1 value="确定" onclick="zhiNaJing()" >
	  <%
	  }
	  }
	   if (yijiao-(SalePrice-AjPrice)>0) out.print(" <font color=red>余额:"+curry+fa.getFloat2(yijiao-(SalePrice-AjPrice),2)+"</font>");
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
	 
    <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
    <tr  class=listtitle  align="center">
        <td>序号</td>
		<td> 款项</font></td>
        <td> 交款<br>日期</font></td>
        <td> 交款<br>金额</font></td>
		<td>币种</font></td>
		<td><font color="#FFFFFF">汇率</font></td>
		 <td><font color="#FFFFFF">付款<br>类型</font></td>
       <!-- <td><font color="#FFFFFF">单据号</font></td>-->
        <td><font color="#FFFFFF">收款人</font></td>
		 <td><font color="#FFFFFF">打印票<br>据日期</font></td>
        <td><font color="#FFFFFF">审核操作</font></td>
		  <td><font color="#FFFFFF">核销</font></td>
    </tr>

    <%
    String sq = " select * from factGatheringRecord where contractno = '" + contractno + "' "
                + "  order by period , gather_date";
    //out.print(sq);
    ResultSet rs = fBean.executeQuery( sq ) ;
     int i2 = 0 ;    
	 String gather_date ="";
	 int rowID=0;
     String FactCurry="";
	 double sumfactmoney=0;
	 String FactCurryRate="";
	 String period ="0";
	 String periodN ="0",print_date="";
	 int num=0;
    while( rs.next() ) {
	 num++;
         rowID = rs.getInt( "id" ) ;
         period = rs.getString( "period" ) ;
		 periodN=String.valueOf(Integer.parseInt(period)+1);
         gather_date = formatDateTime( rs.getTimestamp( "gather_date" ) ) ;
         double factmoney = rs.getDouble( "factmoney" ) ;
         sumfactmoney=sumfactmoney+factmoney;
		
		 //out.print(period);
         String receiver = getbyte( rs.getString( "receiver" ) ) ;
		 String Billnum = getbyte( rs.getString( "Bill_num" ) ) ;
		 String BillType = getbyte( rs.getString( "BillType" ) ) ;
		 FactCurry=getbyte( rs.getString( "CurrName" ) );
		 FactCurryRate=getbyte( rs.getString( "CurrRate" ) );
		 String PayType= getbyte( rs.getString( "PayType" ) ) ;
		 String context= getbyte( rs.getString( "context" ) ) ;
		  print_date= getbyte( rs.getString( "printdate")) ;
		  int checkstate=rs.getInt("checkstate");
		  int checkcancel=rs.getInt("checkcancel");
		  String checkDATE= getbyte( rs.getString( "checkDATE")) ;
		  if (!checkDATE.equals(""))checkDATE=checkDATE.substring(0,10);
		  String checkcanceldate= getbyte( rs.getString( "checkcanceldate")) ;
		  if (!checkcanceldate.equals(""))checkcanceldate=checkcanceldate.substring(0,10);
		 String checkstateperson= getbyte( rs.getString( "checkstateperson")) ;
		 String checkcancelperson= getbyte( rs.getString( "checkcancelperson")) ;
		 if (!print_date.equals(""))print_date=print_date.substring(0,10);
		 if (BillType.equals("0"))BillType="收据";
		 if (BillType.equals("1"))BillType="发票";
		
		 String curryDX="";
		if (FactCurry.equals("￥"))curryDX="人民币";
		if (FactCurry.equals("HKD"))curryDX="港币";
		if (FactCurry.equals("USD"))curryDX="美元";
 if (period.equals("0"))period ="定金";
	else if (period.equals("1")) period ="房款";
	else if (period.equals("2")) period ="房款";
	else if (period.equals("2"))period ="房款";
	else if (period.equals("3"))period ="房款";	
    else if (period.equals("4"))period ="房款";	
	else if (period.equals("5"))period ="花园/露台款";	
 
	else if (period.equals("6"))period ="改装款";	
 
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
		  <table width="100%" border="0"><tr> 
		  <%if (checkstate==0){%>
		  <td><input type=checkbox name=checkstat value=<%=rowID %>></td>
		  <%}else{ %><td onmouseover="javascript:this.style.cursor='hand'" title="审核人:<%=checkstateperson %>"><%=checkDATE %></td><td><a href="#" onclick="cancelCheck(<%=rowID %>);">取消</a></td>
		  <%}
		   %></tr></table>
		  </td>    
		  <td > <table width="100%"><tr> 
		  <%if (checkcancel==0){%>
		   <td><input type=checkbox name=checkcancel value=<%=rowID %>></td>
		  <%}else{ %><td onmouseover="javascript:this.style.cursor='hand'" title="核销人:<%=checkcancelperson %>"><%=checkcanceldate %></td> <td><a href="#" onclick="cancelPj(<%=rowID %>);">取消</a></td>
		  <%}
		   %></tr></table>
		  </td>    
		 
        </tr>
	
    <%
       
    }
	if (Payment.indexOf("(")>0)Payment=Payment.substring(0,Payment.indexOf("("))  ;
    %>
		 <tr bgcolor="#EBEBEB" align="center">
     <td colspan=2>
    <b>合&nbsp;&nbsp;计:</td><td colspan=7 align="left"> <b><%= curry+fa.getFloat2(yijiao,2)+"("+fa.getFloat2(yijiao/SalePrice*100,2)+"%)"%> </b> </td> 
     <td colspan=2>
   <%if (Cortrol.indexOf("E")>=0){%>
		 <input type=button name=buttp value="确认审核" onclick="checkFact()" >&nbsp;<input type=button name=buttp value="确认核销" onclick="checkCancel()" >
		 <%} %>
  </td>
   
    </tr>
	
    </table>
	<%if (Payment.indexOf("揭")>0){ %>
	<br>
	<p align="center"><b><font size="3" color="#000080">银行放款记录</font></b></p>
	<table width="100%">
	<tr     align="center"><td colspan="2"> </td></tr> 
	<tr     align="left"><td colspan="2"></td></tr> 

	<tr  class=listtitle  align="center"><td>放款银行</td><td>放款日期</td><td>放款金额</td><td>登记人</td><td>审核</td></tr> 
	<%String Fsql="select id,convert(char(10),factdate,120) factdate,factmonye,chekcer, checkstate from FactAjCharges where contractno="+contractno; 
	 
	rs = fBean.executeQuery( Fsql ) ;
	while (rs.next()){
	String id=rs.getString("id");
	%>
	  <tr align="center">
	   <td><%=ajbk %></td>
	  <td><%=rs.getString("factdate") %></td>
	  <td><%=rs.getString("factmonye") %></td>
	   <td> <%=rs.getString("chekcer") %></td>
	    <td>   
		  <%
		  int checkstate =rs.getInt("checkstate");
		  if (checkstate==0){%>
		  <input type=checkbox name=fkcheckcancel value=<%=id %> onclick="if (this.checked)checkfk()">
		  <%}else{ %><font color=red>ok</font>
		  <%}
		   %>&nbsp;</td>
	  </tr>
	
	
	<%}rs.close(); %>
	
	
	 
	 </table>
	
	
	<%} %>
	<p align=center>
  <b><font size="3" color="#000080">代收一览</font></b>
 </p>
 <input type=button name=ds value="审 核" onclick="checkFact();">&nbsp;<input type=button name=outm value="代 付" onclick="outtax();">
 <table width="100%"  border="0" cellspacing="1"  cellpadding="1"  >
    <tr   class=TxtColor >
	 <td  >序号</td> 
      <td    >费用名称</td><td>金额</td> <td>收取日期</td> 
	  <td>票据编号</td> 
	  <td>代收人</td>
	   <td>代付日期</td>
	  <td>代付人</td>
	    <td>代付选择</td>
	   <td>审核</td>
    </tr>
	
  
    <%
 
	
	//设定查询

  String sql="select * from factGatheringTaxRecord where contractno ='"+contractno+"'";//order by room_no desc";
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
	int checkstate=rs.getInt("checkstate");
	String checkdate=getbyte(rs.getString("checkdate"));
	if (!checkdate.equals(""))checkdate=checkdate.substring(0,10);
	String checkperson=rs.getString("checkperson");
	String out_date=getbyte(rs.getString("out_date"));
	 if (!out_date.equals(""))out_date=out_date.substring(0,10);
	 String out_person=getbyte(rs.getString("out_person"));
	 boolean taxtype=rs.getBoolean("TaxName_type");
    %> 
    <tr class=listcontent id=TR<%=i%>  align="left"    onclick="changeclass1(this,'clickbg','listcontent');"><!--ondblClick="openwin1('TaxInput.jsp?code=<%=Order_Code %>',300,300,100,100);" -->
      <td  ><%=i%></td>
	   <td  ><%=taxname%></td>
	  <td  ><%=TaxMoney%></td>
	  <td  ><%=JKdate%></td>
      <td> <%=no %></td> 
	  <td> <%=handler %></td> 
	     <td> <%=out_date %></td> 	
		  <td> <%=out_person %></td> 	
		   <td> 
		   <%if (out_date.equals("")&&taxtype){%>
		     <input type=checkbox name="out_checkstat"  out_m=<%=TaxMoney %>  value=<%=id %>>
		     <input type=hidden name="out_m<%=id %>" value=<%=TaxMoney %>>
		  <%} %>
		   </td>	
	    <td >
		  
		  <%if (checkstate==0){%>
		  <input type=checkbox name="d_checkstat" value=<%=id %>>
		  <%}else{ %><font color=red><%=checkdate %><br><%=checkperson %></font>
		  <%}
		   %>&nbsp;
		  </td>    
    </tr>
    <%
  }catch(Exception ex){out.println(ex.getMessage());}

}
  rs.close();
%>
 <tr  align="left"  >
      <td  >合计：</td>
	   <td  >&nbsp;</td>
	  <td  ><%=fa.getFloat2(sumtax,2)%></td>
	  <td  >&nbsp;</td>
      <td> &nbsp;</td> 
	  <td> &nbsp;</td> 	
    </tr>
</table>
 
	<p align=center>
  <b><font size="3" color="#000080">开票明细</font></b>
 </p>
  <%if (request.getParameter("see")==null){ %>
	  <%if (Cortrol.indexOf("A")>=0){%>
  
    <!-- <input type="button" name=dd value="开票登记" onclick="dengji();">-->
    
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
		<td><!--<a href="#" onclick="fpmodi();">修改</a>&nbsp;<%if (!fpstate.equals("作废")){ %><a href="#" onclick="fpzf();">作废</a><%} %><%if (fpstate.equals("作废")){ %><a href="#" onclick="fpff();">恢复</a><%} %>--></td>
    </tr>
		   
	<%ii++;
		  }
		  rs.close();
				
	 %>
</table>
    <p align=center>
	 
	     <input type=hidden name=roomno value="<%=secname+roomno %>" >
        <input type=button name=buttc value=" 关闭 " onclick="window.close()" >
		
    </p>

 </form>

<script lang=javascript>

function checkFact(){
  if (confirm("确认你的审核吗？"))
  document.forms[0].submit();
  
}
function cancelCheck(para){
  if (confirm("确认取消审核吗？"))
   openwin2("cancelCheckMoney.jsp?code="+para+"&roomno=<%=roomno %>",40,30,100,100); 
}
function cancelPj(para){
  if (confirm("确认取消核销吗？"))
   openwin2("cancelCheckPJ.jsp?code="+para+"&roomno=<%=roomno %>",40,30,100,100); 
}
function checkfk(){
  if (confirm("确认你的审核吗？"))
  document.forms[0].submit();
  
}
function checkCancel(){
  if (confirm("确认你的核销吗？"))
  document.forms[0].submit();
  
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
    var newwink = window.open("printsj.jsp?CusNo="+cusno+"&contractno=" + contractno + "&no="+no + "&rowID=" + rowID+"&loft=<%=roomno %>" , "NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no");
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
var o_tax;
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
 
function getseldocs2() {
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
if (getseldocs2()==""){alert("请选择代付");return false;}
 
 openwin2("TaxOut.jsp?id="+getseldocs2()+"&outtax="+o_tax,400,300,100,100);

}
</script>

</body>
</html>

