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
<body>

<form name=f1 method="post"> 
<DIV align=center id="printdiv">
<font size=3>

</font><!--<input class="buttoninput" type="button" value="打印预览" onclick="window.printdiv.style.display='none';factory.printing.Preview();"> -->
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 </div>
   <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<p align=center>
  <b><font size="3" color="#000080">付款清单</b>
 </p> 

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
orderSQL+="o.payment,o.ty_area*o.ty_area_price+o.salerprice+o.lu_tai_area*o.lu_tai_area_price+o.gaizhang_area*o.gaizhang_unitprice salerprice,o.salerprice-o.zs_first_money sjprice,o.ajmoney,";
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
  <table width="90%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
    <tr    align="center">
        <td>  客户姓名</td>
        
        <td>房间号</td>
		
        <td>付款方式</td>
  
        <td>成交总价</td>
      
		
	    <%if (Payment.indexOf("揭")>0){ %>
		<td> 按揭款</td>
		<td> 首期款</td>
		<%} %>
		
    </tr>
	 <tr    align="center">
        <td><%if (request.getParameter("see")==null){ %><a href="javascript:xiangqing();"><%=customer %></a><%}else{ %><%=customer %><% }%></td>
        <td><%if (request.getParameter("see")==null){ %><a href="javascript:contractlist();"><%=roomno %></a><%}else{ %><%=roomno %><%} %></td>
     
        <td><%=Payment %></td>
 
		<td><%=fa.getFloat2(SalePrice,2) %></td>
	 
		
		<%if (Payment.indexOf("揭")>0){ %>
		<td><%=AjPrice %></td>		
		<td><%=fa.getFloat2(SalePrice-AjPrice-zs_first_money,2) %></td>
		<%} %>
    </tr>
	</table> 
	
	 <p align=center>
  <b><font size="3" color="#000080">应付首期款一览表</b>
 </p> <%
	if (Cortrol==null){Cortrol="";}
	%>
   
  <table width="90%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
    <tr  align="center">
        <td>序号</td>
		 <td>款项</td>
        <td>付款期限</td>
        <td>应交款</td>
	
      
     </tr>

    <%
	  ResultSet rs = null ;
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
 
 
	    <tr id=TR<%=i%> align="center"     onclick="setpara( '<%= qs %>' , '<%= qianKuan+demurrage%>' , '<%= shouldmoney %>','<%=ysid %>','<%=shouldDate %>','<%=statevalue %>' );changeclass1(this,'clickbg','listcontent');" 　onmouseover="mout(this);">
          <td><%= jj %></td>
		     <td><%= shouldQS %></td>
          <td><%= shouldDate %></td>
		   <% if (qs.equals("5")){ %>
          <td ><%= fa.getFloat2(shouldmoney,2)%></td>
         <%}else{ %>
		     <td ><%= fa.getFloat2(shouldmoney,2) %></td>
         <%} %>
        
		   
        </tr>
    <%
        i ++ ;
    }
   i--;
    %>

    <tr align="center">
     <td >
<b>合&nbsp;&nbsp;计:</td><td>&nbsp;</td><td>&nbsp;</td><td><b><%= curry+fa.getFloat2(ysSumMoney,2)%></b></td>  </b> 
       
    </tr> 
    </table>
 
<p align=center>
  <b><font size="3" color="#000080">应付税费及配套费一览</b>
 </p>
 <table width="90%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
    <tr  >
	 <td  >序号</td> 
      <td    >费用名称</td><td>金额</td> 
	 
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
    <tr  id=TR2<%=i%>  align="left"  title="双击可登记代收费用" ondblClick="openwin('ModiTax.jsp?id=<%=id %>&taxmoneys=<%=TaxMoney %>&name=<%=TaxName %>',300,300,100,100);" onclick="changeclass1(this,'clickbg','listcontent');">
      <td  ><%=i%></td>
	  <td  ><%=TaxName%></td>
	  <td  ><%=TaxMoney%></td>
     
		
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
 <tr><td>税费合计：<%=fa.getFloat(taxprice,2) %>&nbsp;</td><td>&nbsp;配套合计：<%=fa.getFloat(peitaoprice,2) %></td><td>&nbsp;合计：<%=fa.getFloat(peitaoprice+taxprice,2) %><br>&nbsp;</td></tr>
 
</table>
<br>&nbsp;
<p align=center>
   

</body>
</html>

