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

}


%>
<body>

<form name=f1 method="post">  


	 <%
 String Payment="";
 double SalePrice=Float.parseFloat(request.getParameter("SalePrice"));
 double AjPrice=0;
 String customer="";
 String roomno="";
 double ysSumMoney=0;
 String room="";
 String strloft="";
 String build="";
 String secname="";
 String secno="";
 %>
  
	<hr>
	 <p align=center>
  <b><font size="3" color="#000080">应收一览表</font></b>
 </p>
    <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
     <tr bgcolor="#678DC0"  align="center">
        <td><font color="#FFFFFF">序号</font></td>
        <td><font color="#FFFFFF">付款期限</font></td>
        <td><font color="#FFFFFF">应交款</font></td>
		<td><font color="#FFFFFF">已交款</font></td>
        <td><font color="#FFFFFF">欠款</font></td>
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
    int jj = 0 ;
	int prin=1;
	int ysid=0;
	String signatory="";
	 String shouldDate="";
    String curry="";
	String rate="0"; 
    String statevalue="";
    int i=0;
    while( rs2.next() ) {
        jj++;
     	ysid=rs2.getInt("id");
        String shouldQS = rs2.getString( "shouldQS" ) ;
        shouldDate = formatDateTime( rs2.getTimestamp( "shouldDate" ) ) ;
        double shouldmoney = rs2.getDouble( "shouldmoney" ) ;
	    ysSumMoney+=shouldmoney;
        double ciQiYiJiao = rs2.getDouble( "yijiao" ) ;
        double qianKuan = shouldmoney - ciQiYiJiao ;
		if (qianKuan<=0)qianKuan=0;
        double demurrage = rs2.getDouble( "demurrage" ) ; 
		String state = getbyte( rs2.getString( "state" ) ) ;
		curry= getbyte( rs2.getString( "curry" ) ) ;
		rate= fa.getFloat( rs2.getFloat( "rate" ),4)  ;
		signatory=getbyte(rs2.getString( "signatory" ) );
		statevalue=state;
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
      <!--  <tr  class=listcontent id=TR<%=i%> align="center"   <%if (!state.equals("已交完")){ %> title="选中此行可进行收款登记" onclick="setpara( '<%= shouldQS %>' , '<%= qianKuan+demurrage%>' , '<%= shouldmoney %>','<%=ysid %>','<%=shouldDate %>','<%=state %>','<%=ciQiYiJiao %>' );changeclass1(this,'clickbg','listcontent');" 　onmouseover="mout(this);"<%}else{out.print("title='本期款已交完'");} %>>-->
 
	    <tr  class=listcontent id=TR<%=i%> align="center"     onclick="setpara( '<%= shouldQS %>' , '<%= qianKuan+demurrage%>' , '<%= shouldmoney %>','<%=ysid %>','<%=shouldDate %>','<%=statevalue %>' );changeclass1(this,'clickbg','listcontent');" 　onmouseover="mout(this);">
          <td><%= jj %></td>
          <td><%= shouldDate %></td>
          <td ><%= fa.getFloat2(shouldmoney,2)+"("+fa.getFloat2(shouldmoney/SalePrice*100,2)+"%)" %></td>
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
     <td colspan=2>
<b>合&nbsp;&nbsp;计:</td><td><b><%= curry+fa.getFloat2(ysSumMoney,2)+"("+fa.getFloat2(ysSumMoney*100.0/SalePrice,2)+"%)"%></b></td><td><b><%= curry+fa.getFloat2(yijiao,2)%></b></td> <td><b> <%= curry+fa.getFloat2(weijiao,2)%></b></td> <td ><b> <%= curry+fa.getFloat2(zhiNaJing,2)%></td></b> 
       <td >
   
  </td>
    </tr>

    <tr bgcolor="#EBEBEB" >
     <td colspan=7>
    
	  <%
	   if (yijiao-(ysSumMoney)>0) out.print(" <font color=red>余额:"+curry+fa.getFloat2(yijiao-(ysSumMoney),2)+"</font>");
	 
	   %>
     <td>
    </tr>

    </table>


 <p align=center>
  <b><font size="3" color="#000080">实收一览表</font></b>
 </p>
 
    <table width="100%"  align="center" border="0" cellspacing="1"   cellpadding="1"  >
    <tr bgcolor="#678DC0"  align="center">
        <td><font color="#FFFFFF">序号</font></td>
        <td><font color="#FFFFFF">交款日期</font></td>
        <td><font color="#FFFFFF">交款金额</font></td>
		<td><font color="#FFFFFF">币种</font></td>
		<td><font color="#FFFFFF">汇率</font></td>
		 <td><font color="#FFFFFF">付款类型</font></td>
        <td><font color="#FFFFFF">单据号</font></td>
        <td><font color="#FFFFFF">收款人</font></td>
      
    </tr>

    <%
    String sq = " select * from factGatheringRecord where contractno = '" + contractno + "' "
                + " order by period , gather_date";    
    ResultSet rs = fBean.executeQuery( sq ) ;
	
    int i2 = 0 ;    
	 String gather_date ="";
	 int rowID=0;
    String FactCurry="";
	 String FactCurryRate="";
   int num=0;
    while( rs.next() ) {
	 num++;
         rowID = rs.getInt( "id" ) ;
        String period = rs.getString( "period" ) ;
        gather_date = formatDateTime( rs.getTimestamp( "gather_date" ) ) ;
        double factmoney = rs.getDouble( "factmoney" ) ;
       
         String receiver = getbyte( rs.getString( "receiver" ) ) ;
		 String Billnum = getbyte( rs.getString( "Bill_num" ) ) ;
		 String BillType = getbyte( rs.getString( "BillType" ) ) ;
		 FactCurry=getbyte( rs.getString( "CurrName" ) );
		 FactCurryRate=getbyte( rs.getString( "CurrRate" ) );
		 String PayType= getbyte( rs.getString( "PayType" ) ) ;
		 String context= getbyte( rs.getString( "context" ) ) ;
		 if (BillType.equals("0"))BillType="收据";
		 if (BillType.equals("1"))BillType="发票";
		
		 String curryDX="";
		if (FactCurry.equals("￥"))curryDX="人民币";
		if (FactCurry.equals("HKD"))curryDX="港币";
		if (FactCurry.equals("USD"))curryDX="美元";
    %>
        <tr class=listcontent align=center  title="<%=context %>">
          <td><%= num%></td>
          <td><%= gather_date %></td>
          <td><%= fa.getFloat2(factmoney ,2)%></td>
		  <td><%= curryDX%></td>
		 <td><%= FactCurryRate%></td>
		 
          <td ><%= PayType %></td>
		   <td ><%= Billnum %></td>
          <td><%= receiver %></td>
                 </tr>
	
    <%
     
    }  
	%>
		 <tr bgcolor="#EBEBEB" align="center">
     <td colspan=2>
    <b>合&nbsp;&nbsp;计:</td><td colspan=7 align="left"> <b><%= curry+fa.getFloat2(yijiao,2)+"("+fa.getFloat2(yijiao/SalePrice*100,2)+"%)"%> </b> </td> 
     <td >
   
  </td>
    </tr>
    </table>
	
<p align="center">   <b><font size="3" color="#000080">代收费用一览</font></b> </p>
 
 <table width="100%"  border="0" cellspacing="1"  cellpadding="1"  >
    <tr   class=TxtColor  align="center">
	 <td  >序号</td> 
      <td>费用名称</td><td>金额</td> 
	    <td>代收日期</td> 
	  <td>代收金额</td> 
	 <td>代收状态</td> 
    </tr>
	
    <%
 String	sql="select taxname_type,id,TaxName,TaxMoney,state,TaxMoney-factmoney q,convert(char(10),factdate,120) factdate ,factmoney from GatheringTaxRecord where contactno ='"+contractno+"'";//order by room_no desc";
//设置查询结果的存放变量
int ID=0;
String state="";
String TaxName="";
float TaxMoney=0;
String Order_Code="";
String Sectionname="";
String ajSection="";
String taxtype1="";
float q=0;
 
 
   rs=aBean.executeQuery(sql);

   i=0;
 while (rs.next()){

  try{
     i=i+1;
  //按FIELDS顺序一GET　VALUE
    taxtype1=rs.getString("taxname_type");
    TaxName=getbyte(rs.getString("TaxName"));
    TaxMoney=rs.getFloat("TaxMoney");
   
    q=rs.getFloat("q");
    %> 
    <tr  align="center" class=listcontent id=TR2<%=i%>     title="双击可登记代收费用"  onclick="changeclass1(this,'clickbg','listcontent');">
      <td  ><%=i%></td>
	  <td  ><%=TaxName%></td>
	  <td  ><%=TaxMoney%></td>
	  <td  ><%=getbyte(rs.getString("factdate"))%></td>
	   <td  ><%=rs.getString("factmoney")%></td>
       <td><%if (q==0){ %><font color=red>√</font><%} %></td>
   
    </tr>
    <%
  }catch(Exception ex){out.println(ex.getMessage());}

}

  rs.close();
  %>
  </table>
    <p align=center>
			 <input type="button" name="winclose" value="关闭窗口"  onclick="window.close();">
			 

    </p>

 </form>

<script lang=javascript>
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
function printSJ( cusno , contractno , no , rowID,room ) {
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
  
    var newwink = window.open("zmoney.jsp?contractno=<%=contractno %>&cusno=<%=cusno %>&rate=<%=rate %>&choose="+choose , "NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
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
var factmoney="";
function setpara( periodpass , qianPass , shouldPass,ysid,ysdate ,jk,fact) {
    period = periodpass ;
    qianKuan = qianPass ;
    shouldmoney = shouldPass ;
	ysID=ysid;
	ysDate=ysdate;
	jkstate=jk;
	factmoney=fact;
}
function printzms(){
  open("print.jsp?contractno=<%=contractno %>","prntwin","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no")
}

function deleteFact(aa,aa1,aa2,aa3,aa4){
    openwin("deleteFactGathering.jsp?id="+aa+"&FactCurry="+aa1+"&FactCurryRate="+aa2+"&rate="+aa3+"&deletemoney="+aa4+"&contractno=<%=contractno %>&cusno=<%=cusno %>","aa",10,10,10,10)

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

    var newwink2 = window.open("FactGatherInput.jsp?FactNo=<%= contractno%>&CusNo=<%= cusno%>&ycurry=<%=curry %>&yrate=<%=rate %>&loft=<%=roomno %>&signatory=<%=customer %>","NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
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
  openwin1('../sale/ContractInput.jsp?secname=<%=secname %>&secno=<%=secno %>&roomno=<%=room%>&build=<%=build%>&loft=<%=strloft %>&show=true',680,530,120,2);

}
</script>

</body>
</html>

