<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%> 
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="fa" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/qx_checke.jsp"%>


<%@ include file="../public_js/getByteOut.jsp"%>
<%!
public String formatDateTime( java.sql.Timestamp dt ) throws Exception {
    if( dt == null ) {
        return "" ;
    }
    java.text.SimpleDateFormat f = new java.text.SimpleDateFormat( "yyyy-MM-dd" ) ;
    return f.format( dt ) ;
}
%>

 <%
String Cortrol=checke_qx(aBean,(String)session.getAttribute("loginid"),"F002");


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
String pay=request.getParameter( "pay" ) ;
String custype=request.getParameter( "custype" ) ;
if (ysID!=null){
   aBean.executeUpdate("delete GatheringRecord where id="+ysID ) ;
}

%>

<%
//判断此房是否被临定过及此客户是否诚意登记过
String LD="true";
String CY="true";

 String ldroomcode=request.getParameter("ldroomcode");
 String ldSQL="select * from  SL_TemporarilyBuy where zto=0  and   roomcode="+ldroomcode+ " and Cusname='"+cusno+"'";
 
   ResultSet ldRs=aBean.executeQuery(ldSQL);
   if (!ldRs.next()){LD="false"; }
   ldRs.close();
   String cySQL="select * from tb_chengyi where zto=0  and  serialNo='"+cusno+"'";
   ResultSet cyRs=aBean.executeQuery(cySQL);
   if (!cyRs.next()){CY="false";}
   cyRs.close();

 %>



<%
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
              + " and shouldDate <GETDATE() and state != 2  ";
				
    }else if ( zhiType.equals( "gu" ) ) {//按固定
        sqZ = " update GatheringRecord set demurrage = " + jinger
              + " where contactno = '" + contractno + "' "
              + " and cusno = '" + cusno + "' " 
              + " and shouldDate <GETDATE() and state != 2 ";
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
    
	&nbsp;
	<%if (LD.equals("true")){ %>
    <input type=button name=zld value="转临定定金为认购定金"   onclick="zto('ld')">
	<%}if (CY.equals("true")){ %>
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
String lu_tai_area="";
String lu_tai_mapp_area="";
String lu_tai_area_price=""; 
String gaizhang_area=""; 
String gaizhang_unitprice=""; 
String yang_tai_area=""; 
String yang_tai_mapp_area=""; 
String yang_tai_price="",roomprice=""; 
String pi="";
String pih="",rg_date="",sectionname="";

 String orderSQL="SELECT o.sectionname,";
orderSQL+="o.payment,o.salerprice+o.lu_tai_area*o.lu_tai_area_price+o.gaizhang_area*o.gaizhang_unitprice salerprice,o.salerprice-o.zs_first_money sjprice,o.ajmoney,";
orderSQL+="c.signatory,o.floors,o.loft+o.building+o.room_no as roomno,o.sectionname,";
orderSQL+="o.loft,o.building,o.room_no as room,o.section,o.zs_first_money,o.Y_lu_tai_area,";
orderSQL+="o.lu_tai_area,o.lu_tai_area_price,o.gaizhang_area,o.gaizhang_unitprice,";
orderSQL+="o.lu_tai_area*o.lu_tai_area_price+o.gaizhang_area*o.gaizhang_unitprice+";
orderSQL+="o.yang_tai_area*o.yang_tai_price pih,o.date,";
orderSQL+="o.Y_lu_tai_area*o.lu_tai_area_price+o.gaizhang_area*o.gaizhang_unitprice+";
orderSQL+="o.yang_tai_area*o.yang_tai_price pi,(o.salerprice-o.zs_first_money)-o.gaizhang_area*o.gaizhang_unitprice roomprice,";
orderSQL+="o.Y_yang_tai_area,o.yang_tai_area,o.yang_tai_price FROM order_contract o ,customer c";
orderSQL+=" where o.customer=c.serialno and o.code="+contractno;
     ResultSet orderRs = fBean.executeQuery( orderSQL ) ;
	 if (orderRs.next()){
	    sectionname=getbyte(orderRs.getString("sectionname"));
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

	 }
    orderRs.close();
	 
	 if (Payment.indexOf("揭")>0)Payment=Payment.substring(0,Payment.indexOf("揭")+1);
	 
  %>
   <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
    <tr class=listtitle    align="center">
        <td> <font color="#FFFFFF"> 客户姓名</font></td>
        
        <td><font color="#FFFFFF">房间号</font></td>
		
        <td><font color="#FFFFFF">付款方式</font></td>
  
        <td><font color="#FFFFFF">成交总价</font></td>
        <td><font color="#FFFFFF">实际成交总价</font></td>
		<td><font color="#FFFFFF">房间总价</font></td>
	    <%if (Payment.indexOf("揭")>0){ %>
		<td> <font color="#FFFFFF">按揭款</font></td>
		<td> <font color="#FFFFFF">首期款</font></td>
		<%} %>
		
    </tr>
	 <tr  class=listcontent  align="center">
        <td><a href="javascript:xiangqing();"><%=customer %></a></td>
        <td><a href="javascript:contractlist();"><%=roomno %></a></td>
     
        <td><%=Payment %></td>
 
		<td><%=fa.getFloat2(SalePrice,2) %></td>
		<td><%=fa.getFloat2(sjprice,2) %></td>
				<td><%=roomprice %></td>
		<%if (Payment.indexOf("揭")>0){ %>
		<td><%=AjPrice %></td>		
		<td><%=fa.getFloat2(SalePrice-AjPrice-zs_first_money,2) %></td>
		<%} %>
    </tr>
	</table>  
	<hr>
	 <p align=center>
  <b><font size="3" color="#000080">应收一览表</font></b>
 </p><%
	if (Cortrol==null){Cortrol="";}
	%>
    <table width=100% border="0"><tr height="16" bgcolor="#EAEAEA">
 <td align="left">
 
<%if (Cortrol.indexOf("A")>=0){%><a href="#" onclick="addpay();"><img src="../images/button_tg.gif" border="0"   alt="增加客户的付款明细"></a><%} %> <% if (Cortrol.indexOf("E")>=0){ %><a href="#" onclick="editpay();"><img src="../images/button_xg.gif"  border="0" alt="修改选中的付款明细"></a><%} %><%if (Cortrol.indexOf("D")>=0){ %><a href="#" onclick="deletepay();"><img src="../images/button_sc.gif"  border="0" ></a><%} %>
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
    String sq2 = " select g.*,c.signatory from GatheringRecord g,customer  c where c.serialno=g.cusno and  g.contactno = '" + contractno + "' "
                + " and g.cusno = '" + cusno + "' " + " order by g.shouldQS ";

    ResultSet rs2 = fBean.executeQuery( sq2 ) ;

    double weijiao = 0 ;
    double yijiao = 0 ;
    double zhiNaJing = 0 ;
    double ysmoney=0;
	String qs="";
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
	  <%if (request.getParameter("see")==null){ %>
	  <%if (Cortrol.indexOf("A")>=0){%>
   <a href="javascript:dengji()" >
     <img src="../images/button_ssdj.gif" border=0 >
    </a>
	<%} %>
	<%} %>
    <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
    <tr  class=listtitle   align="center">
          <td><font color="#FFFFFF">序号</font></td>
		<td><font color="#FFFFFF">款项</font></td>
        <td><font color="#FFFFFF">交款<br>日期</font></td>
        <td><font color="#FFFFFF">交款<br>金额</font></td>
		<td><font color="#FFFFFF">币种</font></td>
		<td><font color="#FFFFFF">汇率</font></td>
		 <td><font color="#FFFFFF">付款<br>类型</font></td>
      <!--  <td><font color="#FFFFFF">单据号</font></td>-->
        <td><font color="#FFFFFF">收款人</font></td>
		  <td><font color="#FFFFFF">打印票<br>据日期</font></td>
        <td><font color="#FFFFFF">操作</font></td>
		<td><font color="#FFFFFF">收据</font></td>
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
	String periodN ="0";
    int num=0;
	String print_date="";
    while( rs.next() ) {
	 num++;
         rowID = rs.getInt( "id" ) ;
         period = rs.getString( "period" ) ;
		// periodN=String.valueOf(Integer.parseInt(period)+1);
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
		 if (!print_date.equals(""))print_date=print_date.substring(0,10);
		 if (BillType.equals("0"))BillType="收据";
		 if (BillType.equals("1"))BillType="发票";
		
		 String curryDX="";
		if (FactCurry.equals("￥"))curryDX="人民币";
		if (FactCurry.equals("HKD"))curryDX="港币";
		if (FactCurry.equals("USD"))curryDX="美元";
    %>
	<%
 
	if (period.equals("0"))period ="订金";
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
		<!--   <td ><%= Billnum %></td>-->
          <td><%= receiver %></td>
		  
		 <td><%= print_date %></td>
          <td >
		  <%if (request.getParameter("see")==null){ %>
		  <%if (Cortrol.indexOf("E")>=0){%>
		  <img src="../images/edit.gif" alt='修改收款' onclick="Edit('<%= cusno %>','<%= contractno %>','<%= period %>','<%= rowID%>','<%=FactCurry%>','<%=FactCurryRate %>','<%=factmoney %>')" id=bian<%= i2 %> onmouseover="javascript:this.style.cursor='hand'">
		  <%}if (Cortrol.indexOf("D")>=0){%>
		  &nbsp;<img src="../images/button_sc.gif"  border="0"   onmouseover="javascript:this.style.cursor='hand'" title="删除" onclick="deleteFact('<%= rowID%>','<%=FactCurry%>','<%=FactCurryRate %>','<%=rate %>','<%=factmoney %>')">
		  <%} %>
		  <%} %>&nbsp;
		  </td>    
		  
		   <td >
		   <%if (request.getParameter("see")==null){ %>
		     <%if (Cortrol.indexOf("F")>=0){%>
		   <img src="../images/icon_print.gif" alt='打印收据单' onclick="printSJ('<%= cusno %>','<%= contractno %>','<%= period %>','<%= rowID%>')" id=bian<%= i2 %> onmouseover="javascript:this.style.cursor='hand'">
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
    <b>合&nbsp;&nbsp;计:</td><td colspan=7 align="left"> <b><%= curry+fa.getFloat2(yijiao,2)+"("+fa.getFloat2(yijiao/SalePrice*100,2)+"%)"%> </b> </td> 
     <td >
   
  </td>
    </tr>
    </table>
<p align=center>
  <b><font size="3" color="#000080">应交费用一览</font></b>
 </p>
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

   		sql="select * from GatheringTaxRecord where contactno ='"+contractno+"'";//order by room_no desc";
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

 i=0;
 while (rs.next()){

  try{
     i=i+1;
  //按FIELDS顺序一GET　VALUE
   String id=rs.getString("id");
    
   TaxName=getbyte(rs.getString("TaxName"));
   TaxMoney=rs.getFloat("TaxMoney");
   String state=rs.getString("state");
    %> 
    <tr class=listcontent id=TR<%=i%>  align="left"  title="双击可登记代收费用" ondblClick="openwin('ModiTax.jsp?id=<%=id %>&taxmoneys=<%=TaxMoney %>&name=<%=TaxName %>',300,300,100,100);" onclick="changeclass1(this,'clickbg','listcontent');">
      <td  ><%=i%></td>
	  <td  ><%=TaxName%></td>
	  <td  ><%=TaxMoney%></td>
      <td> 
	  <%if (state.equals("0")){ %>
	  <input name="tax" taxid=<%=id %> type="checkbox" value=<%=TaxMoney %>>
	  <input type=hidden name=taxname<%=id %> value="<%=id %>">
	  </td> 
		<%}else{out.print("已代收");} %>
    </tr>
    <%
  }catch(Exception ex){out.println(ex.getMessage());}

}
  rs.close();
%>
 
</table>
<p align=center>
  <b><font size="3" color="#000080">代收一览</font></b>
 </p>
<input type=button name=ds value="一次交完" onclick="dstax(1);">&nbsp; <input type=button name=ds value="只交部分" onclick="dstax(2);">

 <table width="100%"  border="0" cellspacing="1"  cellpadding="1"  >
    <tr   class=TxtColor >
	 <td  >序号</td> 
      <td    >费用名称</td><td>金额</td> 
	  <td>票据编号</td> 
	  <td>代收人</td>
    </tr>
	
  
    <%
 
	
	//设定查询

   		sql="select * from factGatheringTaxRecord where contractno ='"+contractno+"'";//order by room_no desc";
//设置查询结果的存放变量
 
 
 
   rs=fBean.executeQuery(sql);
 String JKdate="";
 i=0;
 while (rs.next()){

  try{
     i=i+1;
  //按FIELDS顺序一GET　VALUE
   String id=rs.getString("code");
    
   TaxMoney= rs.getFloat("money") ;
   JKdate=rs.getDate("date").toString();
   String no=getbyte(rs.getString("no"));
    String handler=getbyte(rs.getString("handler"));
    %> 
    <tr class=listcontent id=TR<%=i%>  align="left"  title="双击可登记代收费用" ondblClick="openwin('TaxInput.jsp?code=<%=Order_Code %>',300,300,100,100);" onclick="changeclass1(this,'clickbg','listcontent');">
      <td  ><%=i%></td>
	  <td  ><%=TaxMoney%></td>
	  <td  ><%=JKdate%></td>
      <td> <%=no %></td> 
	  <td> <%=handler %></td> 	
    </tr>
    <%
  }catch(Exception ex){out.println(ex.getMessage());}

}
  rs.close();
%>
 
</table>
    <p align=center>
        <input type=button name=buttc value=" 关闭 " onclick="window.close()" >
		<%if (Cortrol.indexOf("F")>=0){%>
		 <input type=button name=buttp value=" 打印付清楼款证明书 " onclick="printzms()" >
		  &nbsp;  <input type="button" value="打印认购书" name="submit1" onclick="printrg();">
	
		 <%} %>
    </p>

 </form>

<script lang=javascript>
function printrg(){
  window.open("printrs.jsp?code=<%=contractno %>");

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
    var newwink = window.open("printsj.jsp?CusNo="+cusno+"&contractno=" + contractno + "&no="+no + "&rowID=" + rowID+"&loft=<%=sectionname+roomno %>" , "NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no");
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
    var posi = posi + ",width=" + 350 ;

    var newwink2 = window.open("FactGatherInput.jsp?ysmoney=<%=ysmoney%>&FactNo=<%= contractno%>&period=<%=periodN %>&CusNo=<%= cusno%>&ycurry=<%=curry %>&yrate=<%=rate %>&loft=<%=roomno %>&signatory=<%=customer %>","NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
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
  openwin1('../sale/showContract.jsp?secname=<%=secname %>&secno=<%=secno %>&roomno=<%=room%>&build=<%=build%>&loft=<%=strloft %>&Floor=<%=floors %>&show=true',680,530,120,2);

}
</script>

</body>
</html>

