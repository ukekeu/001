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
<title>�˷��ͻ��˿����</title>


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
//�жϴ˷��Ƿ��ٶ������˿ͻ��Ƿ����Ǽǹ�
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
	
    String jinger = getbyte1(request.getParameter( "jinger" )) ;
    if( jinger.equals( "" ) ) {
        jinger = "0" ;
    }
    String sqZ = "" ;
    String sqClear = "" ;
	
    if( zhiType.equals( "bai" ) ) {//���ٷּ���
        sqZ = " update GatheringRecord set demurrage = ( shouldmoney - yijiao ) * " + bili + " /100 "
              + " where contactno = '" + contractno + "' "
              + " and cusno = '" + cusno + "' " 
              + " and convert(char(10),shouldDate,120) <convert(char(10),GETDATE(),120) and state != 2  ";
			 
    }else if ( zhiType.equals( "gu" ) ) {//���̶�
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
<body topmargin="0" oncontextmenu="return false">

<form name=f1 method="post" action="yingshi.jsp?contractno=<%=contractno %>&loft=<%=loft %>&cusno=<%=cusno %>">  
 <%String sel=(String)request.getParameter("sel");
    if(sel==null) sel="1";	   %>
<table width="280" border="0" cellspacing="0" cellpadding="0" class="L2" >
  
<tr  valign="top">
    <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	  <a href="#" onclick="document.f1.sel.value=1;findSub('yingshi_t.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�������</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.f1.sel.value=2;findSub('yingshi_t.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>˰/���׷�</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.f1.sel.value=3;findSub('yingshi_t.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>Ʊ�ݹ���</font></a>
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
    <input type=button name=zld value="ת�ٶ�����Ϊ�Ϲ�����"   onclick="zto('ld')">
	<%}
	if (CY.equals("true")){ %>
    <input type=button name=zld value="ת���ⶨ��Ϊ�Ϲ�����" onclick="zto('cy')">
	<%} %>
   </td>
  </tr>
 </table>
 
	 <%
 orderSQL="SELECT o.floors,o.jqfk_date,o.sectionname,o.section,"; 
// orderSQL+=" o.section,o.payment,o.salerprice,o.salerprice-o.zs_first_money sjprice,o.ajmoney,c.signatory,o.floors,o.loft+o.building+o.room_no as roomno,o.sectionname,o.loft,o.building,o.room_no as room,o.section ,o.zs_first_money FROM order_contract o ,customer c where o.customer=c.serialno and o.code="+contractno;
orderSQL+="o.payment,o.salerprice+o.lu_tai_area*o.lu_tai_area_price+o.gaizhang_area*o.gaizhang_unitprice salerprice,o.room_sumprice sjprice,o.ajmoney,o.salerprice/o.area tnunitprice,o.ysumprice-o.rmbprice cj_f,o.ysumprice hsprice,";
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
		// if (floors<0)roomno=strloft+build+"����"+(-floors)+"��"+room;
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

	 if (Payment.indexOf("��")>0)Payment=Payment.substring(0,Payment.indexOf("��")+1);
	 
  %>
   <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
    <tr    class=listtitle   align="center">
        <td> <font color="#FFFFFF"> �ͻ�����</font></td>
        
        <td><font color="#FFFFFF">�����</font></td>
		
        <td><font color="#FFFFFF">���ʽ</font></td>
  
        <td><font color="#FFFFFF">Ԥ�۷���</font></td>
        <td><font color="#FFFFFF">�ɽ�����</font></td>
		<td><font color="#FFFFFF">���</font></td>
	    <%if (Payment.indexOf("��")>0){ %>
		<td> <font color="#FFFFFF">���ҿ�</font></td>
		<td> <font color="#FFFFFF">���ڿ�</font></td>
		<%} %>
		
    </tr>
	 <tr  class=listcontent  align="center">
        <td><%if (request.getParameter("see")==null){ %><a href="javascript:xiangqing();"><%=customer %></a><%}else{ %><%=customer %><% }%></td>
        <td><%if (request.getParameter("see")==null){ %><a href="javascript:contractlist();"><%=roomno %></a><%}else{ %><%=roomno %><%} %></td>
     
        <td><%=Payment %></td>
 
		<td><%=hsprice  %></td>
		<td><%=fa.getFloat2(sjprice,2) %></td>
		<td><%=ce %></td>
		<%if (Payment.indexOf("��")>0){ %>
		<td><%=AjPrice %></td>		
		<td><%=fa.getFloat2(SalePrice-AjPrice-zs_first_money,2) %></td>
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
  <b><font size="3" color="#000080">Ӧ��һ����</font></b>
 </p>  
	
    <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
     <tr  class=listtitle  align="center">
        <td><font color="#FFFFFF">���</font></td>
		 <td><font color="#FFFFFF">����</font></td>
        <td><font color="#FFFFFF">��������</font></td>
        <td><font color="#FFFFFF">Ӧ����</font></td>
		<td><font color="#FFFFFF">�ѽ���</font></td>
        <td><font color="#FFFFFF">δ����</font></td>
        <td><font color="#FFFFFF">���ɽ�</font></td>
        <td><font color="#FFFFFF">״̬</font></td>
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
	
       sq2 = " select g.*,g.shouldmoney-g.yijiao qk,c.signatory from GatheringRecord g,customer  c where c.serialno=g.cusno and  g.contactno = '" + contractno + "' "
                + " and g.cusno = '" + cusno + "' " + " order by g.shouldQS ";
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
            skstate = "&nbsp;" ;prin=0;
        }else if( state.equals( "1" ) ) {
            skstate = "&nbsp;" ;prin=0;
        }else if( state.equals( "2" ) ) {
            skstate = "<font color=red>��</font>" ;
        }else{
            skstate = "" ;
        }
        weijiao = weijiao + qianKuan + demurrage ;
        yijiao = yijiao + ciQiYiJiao ;
        zhiNaJing = zhiNaJing + demurrage ;
        weijiao = weijiao + qianKuan + demurrage ;
        yijiao = yijiao + ciQiYiJiao ;
        zhiNaJing = zhiNaJing + demurrage ;
	%>
	<%
	qs=shouldQS;

if (shouldQS.equals("0"))shouldQS ="����";
else if (shouldQS.equals("1")) shouldQS ="����";
else if (shouldQS.equals("2"))shouldQS ="����";
else if (shouldQS.equals("3"))shouldQS ="����";	
else if (shouldQS.equals("4"))shouldQS ="����";	
else if (shouldQS.equals("5"))shouldQS ="��԰/¶̨��";	 
else if (shouldQS.equals("6"))shouldQS ="��װ��";	  
else if (shouldQS.equals("7"))shouldQS ="���ɽ�";	  
else if (shouldQS.equals("8"))shouldQS ="������";	
else if (shouldQS.equals("9"))shouldQS ="��װ����";	
else if (shouldQS.equals("10"))shouldQS ="��԰/¶̨����";	
else if (shouldQS.equals("15"))shouldQS ="����������";	

%>
 
 
	    <tr  class=listcontent id=TR<%=i%> align="center"     onclick="setpara( '<%= qs %>' , '<%= qianKuan+demurrage%>' , '<%= shouldmoney %>','<%=ysid %>','<%=shouldDate %>','<%=statevalue %>' );changeclass1(this,'clickbg','listcontent');" ��onmouseover="mout(this);">
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
          <td><%if (state.equals("2")){out.print(skstate+"&nbsp;&nbsp;");}else{ %><a href="#d"  onclick="dengji(<%=fa.getFloat3(shouldmoney,3) %>,<%=qs %>);">�տ�</a><%} %><%if (Cortrol.indexOf("F")>=0){
		   if (shouldmoney>0&&!state.equals("2")){
		   %>
		   <img src="../images/icon_print.gif" alt='��ӡ�վݵ�' onclick="printSJ1('<%= cusno %>','<%= contractno %>','','<%= ysid%>')"  onmouseover="javascript:this.style.cursor='hand'">
		   <%
		  } else if (!state.equals("2")) {
		   %> <img src="../images/icon_print.gif" alt='��ӡ�վݵ�' onclick="printSJ4('<%= cusno %>','<%= contractno %>','','<%= ysid%>')"  onmouseover="javascript:this.style.cursor='hand'">
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
<b>��&nbsp;&nbsp;��:</td><td><b><%= curry+fa.getFloat2(ysSumMoney,2)+"("+fa.getFloat2(ysSumMoney*100.0/SalePrice,2)+"%)"%></b></td><td><b><%= curry+fa.getFloat2(yijiao,2)%></b></td> <td><b> <%= curry+fa.getFloat2(weijiao,2)%></b></td> <td ><b> <%= curry+fa.getFloat2(zhiNaJing,2)%></td></b> 
       <td >
   
  </td>
    </tr>

   

    </table>

 <p align=center>
  <b><font size="3" color="#000080">ʵ��һ����</font></b>
 </p><%
      if(statestr.equals("2"))
        flag="1";
      else flag="0";%>
	  <%if (request.getParameter("see")==null){ %>
	 
	  <%if (Cortrol.indexOf("A")>=0){%>
	   <input type=button name=facm value="�˿�Ǽ�" onclick="outdengji();">
   
	<%} %>
	<%} %>
    <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
    <tr  class=listtitle  align="center">
        <td><font color="#FFFFFF">���</font></td>
		<td><font color="#FFFFFF">����</font></td>
        <td><font color="#FFFFFF">����<br>����</font></td>
        <td><font color="#FFFFFF">����<br>���</font></td>
		<td><font color="#FFFFFF">����</font></td>
		<td><font color="#FFFFFF">����</font></td>
		 <td><font color="#FFFFFF">����<br>����</font></td>
       <!-- <td><font color="#FFFFFF">���ݺ�</font></td>-->
        <td><font color="#FFFFFF">�տ���</font></td>
		 <td><font color="#FFFFFF">��ӡƱ<br>������</font></td>
        <td><font color="#FFFFFF">����</font></td>
		 
    </tr>

    <%
      sq = " select id,period, gather_date,factmoney,receiver,Bill_num";
	sq+=",BillType,CurrName,CurrRate,PayType,context,printdate,checkstate, ";
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
		 if (BillType.equals("0"))BillType="�վ�";
		 if (BillType.equals("1"))BillType="��Ʊ";
		
		 String curryDX="";
		if (FactCurry.equals("��"))curryDX="�����";
		if (FactCurry.equals("HKD"))curryDX="�۱�";
		if (FactCurry.equals("USD"))curryDX="��Ԫ";
    %>
	<%
 
	if (period.equals("0"))period ="����";
	else if (period.equals("1")) period ="����";
	else if (period.equals("2")) period ="����";
	else if (period.equals("2"))period ="����";
	else if (period.equals("3"))period ="����";	
    else if (period.equals("4"))period ="����";	
	else if (period.equals("5"))period ="��԰/¶̨��";	
 	else if (period.equals("6"))period ="��װ��";	
	else if (period.equals("7"))period ="���ɽ�";
	
	else if (period.equals("8"))period ="������";	
	else if (period.equals("9"))period ="��װ����";	
	else if (period.equals("10"))period ="��԰/¶̨����";	
	else if (period.equals("11"))period ="��̨�ֲ��";	
	else if (period.equals("15"))period ="����������";	
	 
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
		  <img src="../images/edit.gif" alt='�޸��տ�' onclick="Edit('<%= cusno %>','<%= contractno %>','<%= period %>','<%= rowID%>','<%=FactCurry%>','<%=FactCurryRate %>','<%=factmoney %>')" id=bian<%= i2 %> onmouseover="javascript:this.style.cursor='hand'">
		  <%}if (Cortrol.indexOf("D")>=0){%>
		  &nbsp;<img src="../images/button_sc.gif"  border="0"   onmouseover="javascript:this.style.cursor='hand'" title="ɾ��" onclick="deleteFact('<%= rowID%>','<%=FactCurry%>','<%=FactCurryRate %>','<%=rate %>','<%=factmoney %>')">
		  <%} %>
		  <%}else{ if (Cortrol.indexOf("Q")>=0){%> <img src="../images/edit.gif" alt='�޸��տ�' onclick="Edit('<%= cusno %>','<%= contractno %>','<%= period %>','<%= rowID%>','<%=FactCurry%>','<%=FactCurryRate %>','<%=factmoney %>')" id=bian<%= i2 %> onmouseover="javascript:this.style.cursor='hand'"><%} %>
		 &nbsp;<font color="red">�����</font><%} %>
	 
		   
		     <%if (Cortrol.indexOf("Q")>=0||print_date.equals("")){%>
			
			 <% if (factmoney>0){ %>
		   <img src="../images/icon_print.gif" alt='��ӡ�վݵ�'  onclick="printSJ('<%= cusno %>','<%= contractno %>','<%= period %>','<%= rowID%>')" id=bian<%= i2 %> onmouseover="javascript:this.style.cursor='hand'">
		      <%}else{ %>
             <img src="../images/icon_print.gif" alt='��ӡ�վݵ�'  onclick="printSJt('<%= cusno %>','<%= contractno %>','<%= period %>','<%= rowID%>')" id=bian<%= i2 %> onmouseover="javascript:this.style.cursor='hand'">
			  <%} %>
		   <%} %>
		  
		   </td>    
        </tr>
	
    <%
       
    }
	if (Payment.indexOf("(")>0)Payment=Payment.substring(0,Payment.indexOf("("))  ;
    %>
		 <tr bgcolor="#EBEBEB" align="center">
     <td colspan=2>
    <b>��&nbsp;&nbsp;��:</td><td colspan=7 align="left"> <b>��<%=fa.getFloat2(sumfactmoney,2)%> </b></td> 
     <td > 
      <% if (yijiao-ysSumMoney>0) out.print(" <font color=red>���:"+curry+fa.getFloat2(yijiao-ysSumMoney,2)+"</font>");
	  %>
  </td>
    </tr>
    </table>
	 
	<%if (Payment.indexOf("��")>0){ %>
	<p align="center"> <b><font size="3" color="#000080">���зſ��¼</font></b></p>
	<table width="100%">
	<tr     align="center"><td colspan="2"></td></tr> 
	 
	<tr  class=listtitle  align="center"><td>��������</td><td>�ſ�����</td><td>�ſ���</td><td>�Ǽ���</td><td>���</td><td> </td></tr> 
	<%String Fsql="select factdate,factmonye,chekcer,id,checkperson,checkstate,checkdate from FactAjCharges where contractno="+contractno; 
	 String ajid="";
	rs = fBean.executeQuery( Fsql ) ;
	while (rs.next()){%>
	  <tr align="center">
	  
	  <td><%=ajbk%></td>
	  <td><%=rs.getDate("factdate").toString() %></td>
	  <td><%=rs.getString("factmonye") %></td>
	   <td> <%=rs.getString("chekcer") %></td>
	   <td><%
	   ajid=rs.getString("id");
	   boolean checkstate=rs.getBoolean("checkstate") ;
	   if (checkstate){
	   out.print(getbyte("<font color='red'>"+rs.getString("chekcer"))+"&nbsp;"+ rs.getDate("checkdate").toString()+"</font>");
	   
	   }
	  
	    %>
		</td>
	    <td width="10%"> <%if (Cortrol.indexOf("D")>=0){%><img src="../images/button_sc.gif"  border="0"   onmouseover="javascript:this.style.cursor='hand'"  onclick="if (confirm('ȷ��ɾ����'))openwin('deleteAj.jsp?id= <%=ajid%>',10,10,10,10);"> <%}if (Cortrol.indexOf("E")>=0){%>&nbsp;&nbsp; <img src="../images/edit.gif" alt='�޸��տ�'  onclick="openwin('AjEdit.jsp?code= <%=contractno%>',400,350,100,100);"><%} %></td>
		
	  </tr>
	
	
	<%}rs.close(); %>
	
	
	 
	 </table>
	
	
	<%} %>
	<% } else if (sel.equals("2")){   %>
<p align=center>
  
 
   <b><font size="3" color="#000080">Ӧ������һ��</font></b>

 </p> 
 
 <table width="100%"  border="0" cellspacing="1"  cellpadding="1"  >
    <tr   class=TxtColor  align="center">
	 <td >���</td> <td >��������</td><td >��������</td><td>Ӧ�ս��</td> <td>δ�ս��</td>  <td>����״̬</td>  <td width="10%">&nbsp;</td> 
    </tr>
	
  
    <%
String sql="";
String sql1="";
	
	//�趨��ѯ

   		sql="select id,TaxName,TaxMoney,state,TaxMoney-factmoney q,cancel,taxname_type,cancelbak from GatheringTaxRecord where contactno ='"+contractno+"'";//order by room_no desc";
//���ò�ѯ����Ĵ�ű���
 
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
  //��FIELDS˳��һGET��VALUE
   String id=rs.getString("id");
    
   TaxName=getbyte(rs.getString("TaxName"));
   TaxMoney=rs.getFloat("TaxMoney");
   String state=rs.getString("state");
    q=rs.getFloat("q");
	cancel=rs.getInt("cancel");
 
	taxname_type=rs.getInt("taxname_type");
	String cancelbak=rs.getString("cancelbak");
    %> 
    <tr class=listcontent id=TR2<%=i%>  align="center"  title="˫���ɵǼǴ��շ���"  onclick="changeclass1(this,'clickbg','listcontent');">
      <td   ><%=i%><input name="tax" taxid=<%=id %> type="checkbox"  taxvalue=<%=TaxMoney %> value=<%=q %>>
	  <input type=hidden name=taxname<%=id %> value="<%=id %>"></td>
	  <td  ><%=TaxName%></td>
	    <td  ><%if (taxname_type==0)out.println("���׷�");else out.println("˰��");%></td>
	  <td  ><%=TaxMoney%></td>
	   <td  ><b><%=q%></b></td>
      <td> 
	  <%if (state.equals("0")&&cancel==0){ %>
	  δ��
	   <%}else{out.print("�Ѵ���");} %>
	  </td> 
		
	 
 

   <input type=hidden name=prtaxname_y<%=id %> value="<%=TaxName %>">
 
  <td width="10%"> <%if (Cortrol.indexOf("D")>=0){%>
		  &nbsp;<img src="../images/button_sc.gif"  border="0"   onmouseover="javascript:this.style.cursor='hand'" title="ɾ��" onclick="deleteC(<%=id %>)";>
		  <%} %>
		  <%if (Cortrol.indexOf("E")>=0){%><img src="../images/edit.gif" border="0"  onmouseover="javascript:this.style.cursor='hand'" alt='�޸�' onclick="openwin('ModiTax.jsp?id=<%=id %>&taxmoneys=<%=TaxMoney %>&name=<%=TaxName %>&taxname_type=<%=taxname_type %>&state=<%=state %>',300,300,100,100);" ><%} %>
		 	<%if (TaxName.indexOf("��˰")>=0) {%> <input type=checkbox name=hs value=1 onclick="hsjs(this.checked);">ʵ��<%} %>
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
 <tr><td  colspan="9"> ˰�Ѻϼƣ�<%=fa.getFloat(taxprice,2) %>&nbsp;&nbsp;&nbsp;���׺ϼƣ�<%=fa.getFloat(peitaoprice,2) %>&nbsp;&nbsp;&nbsp;&nbsp;�ϼƣ�<%=fa.getFloat(peitaoprice+taxprice,2) %></td></tr>

</table>
<p align=center>
  <b><font size="3" color="#000080">����һ��</font></b>
 </p>
<%if (Cortrol.indexOf("A")>=0){%> <input type=button name=pr value="�� ��" onclick="openwin('CancelTax.jsp?code=<%=contractno %>',400,200,100,100);">&nbsp; <!--<input type=button name=pr value="�� ��" onclick="openwin('AddTax.jsp?code=<%=contractno %>',400,200,100,100);">&nbsp; <%}if (Cortrol.indexOf("F")>=0){%>   &nbsp; <input type=button name=pr value="��ӡ�վ�" onclick="printdstax();"><%} %>-->
 <table width="100%"  border="0" cellspacing="1"  cellpadding="1"  >
    <tr   class=TxtColor  align="center">
	 <td  >���</td> 
      <td    >��������</td><td>���</td> <td>��ȡ����</td> 
	 
	  <td>������</td>
	  <td>��Ʊ����</td>
	  
	   
    <td>&nbsp;</td>
	 
	
    </tr>
	
  
    <%
 
	
	//�趨��ѯ

   		sql="select * from factGatheringTaxRecord where contractno ='"+contractno+"'";//order by room_no desc";
//���ò�ѯ����Ĵ�ű���
 
 
 
   rs=fBean.executeQuery(sql);
 String JKdate="";
 i=0;
 float sumtax=0;
 boolean dscheck=false;
 while (rs.next()){

  try{
     i=i+1;
  //��FIELDS˳��һGET��VALUE
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
	String out_date=getbyte(rs.getString("printdate"));
	 if (!out_date.equals(""))out_date=out_date.substring(0,10);
	 String out_person=getbyte(rs.getString("out_person"));
    %> 
	 <input type=hidden name=prtaxname<%=id %> value="<%=taxname %>">
    <tr class=listcontent id=TR1<%=i%>  align="center"    onclick="changeclass1(this,'clickbg','listcontent');">
      <td  ><%=i%> 
	   <input name="prtax" taxid=<%=id %> type="checkbox" value=<%=TaxMoney %>>
	</td>
	   <td  ><%=taxname%></td>
	  <td  ><%=TaxMoney%></td>
	  <td  ><%=JKdate%></td>
       
	  <td> <%=handler %></td> 	
	    <td> <%=out_date %></td> 	
		 
	 
    
	 <td width="10%"> <%if (Cortrol.indexOf("D")>=0){%>
		  &nbsp;<img src="../images/button_sc.gif"  border="0"   onmouseover="javascript:this.style.cursor='hand'" title="ɾ��" onclick="deleteFC('<%=id%>','<%=TaxMoney %>')";>
		  <%} %>
		  <% 
	 if (!dscheck){
	   if (Cortrol.indexOf("E")>=0){%> <img src="../images/edit.gif" border="0"  onmouseover="javascript:this.style.cursor='hand'" alt='�޸�'  onclick="openwin('ModiTaxDs.jsp?JKdate=<%=JKdate %>&id=<%=id %>&taxmoneys=<%=TaxMoney %>&name=<%=taxname %>&taxname_type=<%=taxname_type %>',300,300,100,100);" >
	   
	   <%}
	 } else{ if (Cortrol.indexOf("Q")>=0){%><img src="../images/edit.gif" border="0"  onmouseover="javascript:this.style.cursor='hand'" alt='�޸�'  onclick="openwin('ModiTaxDs.jsp?JKdate=<%=JKdate %>&id=<%=id %>&taxmoneys=<%=TaxMoney %>&name=<%=taxname %>&taxname_type=<%=taxname_type %>',300,300,100,100);" ><%}out.print("<font color=red>�����</font>") ;}
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
 <tr><td colspan="2">˰�Ѻϼƣ�<%=fa.getFloat(taxprice,2) %></td><td colspan="2">���׺ϼƣ�<%=fa.getFloat(peitaoprice,2) %></td><td colspan="2">�ϼƣ�<%=fa.getFloat(peitaoprice+taxprice,2) %></td></tr>

</table>
<% } else if (sel.equals("3")){   %>
<p align=center>
  <b><font size="3" color="#000080">�վ���ϸ</font></b>
 </p>
 
   <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
    <tr  class=listtitle  align="center">
        <td><font color="#FFFFFF">���</font></td>
		<td><font color="#FFFFFF">Ʊ�ݱ��</font></td>
        <td><font color="#FFFFFF">��Ʊ����</font></td>
        <td><font color="#FFFFFF">��Ʊ���</font></td>
		  <td><font color="#FFFFFF">���ʽ</font></td>
        <td><font color="#FFFFFF">��Ʊ��</font></td>
		 <td><font color="#FFFFFF">״̬</font></td>
		 
    </tr>
	<%
	  sq = " select factmoney,receiver,Bill_num";
	sq+=",BillType,CurrName,CurrRate,PayType,context,printdate,checkstate, ";
	sq+="convert(numeric(9,2),CurrRate*factmoney) ff,checkcancel,checkcanceldate,checkcancelperson from factGatheringRecord where printdate<>'' and  contractno = '" + contractno + "' "
                + "  order by period , gather_date";
       jj=0;
       rs = fBean.executeQuery( sq ) ;
	 while (rs.next()){jj++;
	   String canceldate=getbyte(rs.getString("checkcanceldate")) ;
	   if (canceldate.equals(""))canceldate="δ����";
	 %>
	   <tr  class=listcontent align="center">
        <td> <%=jj %> </td>
		<td> <%=rs.getString("Bill_num") %> </td>
        <td> <%=rs.getDate("printdate").toString() %> </td>
        <td> <%=rs.getString("ff") %> </td>
		 <td> <%=rs.getString("PayType") %> </td>
        <td> <%=rs.getString("receiver") %> </td>
		<td> <%=canceldate%> </td>
		 
		 
    </tr>
	<% }
	rs.close();%>
	 </table>
	<p align=center>
  <b><font size="3" color="#000080">��Ʊ��ϸ</font></b>
 </p>
  <%if (request.getParameter("see")==null){ %>
	  <%if (Cortrol.indexOf("A")>=0){%>
  
     <input type="button" name=dd value="��Ʊ�Ǽ�" onclick="dengji1();">
    
	<%} %>
	<%} %>
   <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
    <tr  class=listtitle  align="center">
        <td><font color="#FFFFFF">���</font></td>
		<td><font color="#FFFFFF">��Ʊ���</font></td>
        <td><font color="#FFFFFF">��Ʊ����</font></td>
        <td><font color="#FFFFFF">��Ʊ���</font></td>
        <td><font color="#FFFFFF">��Ʊ��</font></td>
		 <td><font color="#FFFFFF">״̬</font></td>
		 
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
		if (fpstate.equals("1"))fpstate="����";
		else fpstate="����";
		%>
		  <td><%=fpstate %></td>
		<td><a href="#" onclick="fpmodi('<%=getbyte(rs.getString("code")) %>');">�޸�</a>&nbsp;<%if (!fpstate.equals("����")){ %><a href="#" onclick="fpzf('<%=getbyte(rs.getString("code")) %>');">����</a><%} %><%if (fpstate.equals("����")){ %><a href="#" onclick="fpff();">�ָ�</a><%} %> 
      <%if (fpstate.equals("����")){ %>
	   <img src="../images/icon_print.gif" alt='��ӡ�վݵ�' onclick="printfp('<%= cusno %>','<%= contractno %>','','')" id=bian<%= i2 %> onmouseover="javascript:this.style.cursor='hand'">
		<%} %>
		</td>
       	 
    </tr>
		   
	<%ii++;
		  }
		  rs.close();
	 }			
	 %>
</table>
 
  

 </form>

<script lang=javascript>
function modibak(){
   if (document.forms[0].jq_date.value!=""){
     if (confirm("�Ƿ񱣴��޸�?")) 
   openwin2("modibak.jsp?code=<%=contractno %>&bak="+document.forms[0].bak.value+"&jq_date="+document.forms[0].jq_date.value,1,1,1,1);

   
   }
 

}
function jfbak(){
   if (document.forms[0].jf_date.value!=""){
     if (confirm("�Ƿ񱣴潻������?")) 
   openwin2("jf_modi.jsp?code=<%=contractno %>&bak="+document.forms[0].bak.value+"&jf_date="+document.forms[0].jf_date.value,1,1,1,1);

   
   }
 

}
function fkjq(){
 if (document.forms[0].jqfkdate.checked)
 {
   if (document.forms[0].jqfk_date.value==""){alert("��ѡ�񷿿��������");return false;}
   if (confirm("ȷ�Ͽͻ��ѽ������з�����"))document.fl.submit();
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

  if (confirm("ȷ������?")){
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
    newwink2.focus();
   }

}

function fpff() {

  if (confirm("ȷ�ϻָ�?")){
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
 if (document.forms[0].bak.value==""){alert("����д���㱸ע");return false;}
  if (document.forms[0].jq_date.value==""){alert("���������");return false;}

  window.open("jieqingdan.jsp?code=<%=contractno %>&bak="+document.forms[0].bak.value+"&jq_date="+document.forms[0].jq_date.value);

}
function cancelpt(){
 
   if (getseldocs2()==""){alert("��ѡ����Ҫȡ�������׷�");return false;}
  if (confirm("ȷ��ȡ��ѡ������׷���ȡ����ϵͳ�������ٻָ���")){
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
 if (taxnameid==""){alert("��ѡ����յ�˰������");return false;}
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
  
 if (taxnameid==""){alert("��ѡ����յ�˰������");return false;}
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
  
 if (taxnameid==""){alert("��ѡ����յ�˰������");return false;}
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
if (confirm("ȷ��ɾ����ɾ��ʱ�������շ���Ҳɾ����ɾ�����ָܻ�")){
 var newwink = openwin2("deleteC.jsp?id="+para ,40,30,10,10);
   // newwink.focus();
}
}
function deleteFC(para,para1){
if (confirm("ȷ��ɾ����ɾ�����ָܻ�")){
 var newwink = openwin2("deleteFC.jsp?id="+para+"&money="+para1 ,40,30,10,10);
  //  newwink.focus();
}}function editpay(){
  
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
    }else{alert("��ѡ���޸ĵ�����");}
	}
function deletepay(){
    if (ysID!=""){
	  if (period<<%=i %>) {alert("ֻ��ɾ�����һ�ڸ���,���ɾ�������ݲ���ȷ�����޸�����");return false;}
	  else{
  	   if (confirm("ȷ��ɾ����?")){
	    document.f1.action="yingshi.jsp?ysID="+ysID+"&cusno=<%= cusno %>&contractno=<%= contractno %>";
	    document.f1.submit();
		}
	  }	
	 }else{alert("��ѡ��ɾ������");} 
	 
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
    newwink.focus();
}    
function printfp( cusno , contractno , no , rowID ) {
    var newwink = openwin2("printfp.jsp?CusNo="+cusno+"&contractno=" + contractno + "&no="+no + "&rowID=" + rowID+"&loft=<%=sectionname.trim()+roomno.trim()%>" ,450,300,100,100);
    newwink.focus();
}    
function printSJ_aj( cusno , contractno , no , rowID ) {
    var newwink = openwin2("printsj_aj.jsp?CusNo="+cusno+"&contractno=" + contractno + "&no="+no + "&rowID=" + rowID+"&loft=<%=sectionname+roomno %>" ,450,300,100,100);
    newwink.focus();
}  
function printSJt( cusno , contractno , no , rowID ) {
    var newwink = openwin2("printsj_t.jsp?section=<%=section %>&ld=<%=ld %>&CusNo="+cusno+"&contractno=" + contractno + "&no="+no + "&rowID=" + rowID+"&loft=<%=sectionname.trim()+roomno.trim() %>" ,450,300,100,100);
    newwink.focus();
}    
function printSJ1( cusno , contractno , no , rowID ) {
    var newwink = openwin2("printsj1.jsp?CusNo="+cusno+"&contractno=" + contractno + "&no="+no + "&rowID=" + rowID+"&loft=<%=sectionname+roomno %>" ,450,300,100,100);
    newwink.focus();
}    
function printSJ4( cusno , contractno , no , rowID ) {
    var newwink = openwin2("print_ys_t.jsp?CusNo="+cusno+"&contractno=" + contractno + "&no="+no + "&rowID=" + rowID+"&loft=<%=sectionname+roomno %>&ld=<%=ld %>" ,450,300,100,100);
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
        alert( "��ѡ�����ɽ������!" ) ;
        return false ;
    }
    
    if( isNaN( document.forms[ 0 ].bili.value ) ) {
        alert( "��������ֵ!" ) ;
        return false ;
    }

    if( isNaN( document.forms[ 0 ].jinger.value ) ) {
        alert( "��������ֵ!" ) ;
        return false ;
    }
    return true ;
}


function zto(choose){//תΪ����
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
   if (confirm("ȷ��ɾ��ʵ�յǼ���ɾ�����ָܻ�")) 
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
  openwin2('../sale/showt_oldContract.jsp?contractno=<%=contractno %>&secname=<%=secname %>&secno=<%=secno %>&roomno=<%=room%>&build=<%=build%>&loft=<%=strloft %>&Floor=<%=floors %>&show=true',680,530,120,2);

} 
function hsjs(para){
 if (para){
  if (confirm("ȷ�ϰ�ʵ������"))
   openwin("q_tax_hs.jsp?code=<%=contractno %>",10,10,10,10)
 }
 
}
function hf(para){
 if (confirm("ȷ�ϻָ���"))
  openwin("hf_ptf.jsp?id="+para);
}
</script>
 
</body>
</html>

