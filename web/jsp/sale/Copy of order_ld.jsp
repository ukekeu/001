<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>销售资料登记</title>
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>

<%
  String userstate=(String) session.getAttribute("userstate");
  //按揭保险费
    String bxcharges="0";
  String bxrate="select insurance_rate, insurance_year from insurance_rate ";
   ResultSet bxRs=fBean.executeQuery(bxrate);
	try{

  out.print("<script>");
  out.print("var Ratebx=new Array();");
  out.print("var Yearbx=new Array();");
  int iii=0;

   while (bxRs.next()){
     out.print("Ratebx["+String.valueOf(iii)+"]="+"\""+getbyte(bxRs.getString("insurance_rate"))+"\""+";");
     out.print("Yearbx["+String.valueOf(iii)+"]="+"\""+bxRs.getString("insurance_year")+"\""+";");
	 iii++;
      }	 
}catch(Exception s){  out.print(s.getMessage());out.close();}
bxRs.close();
out.print("</script>");
	
  %>
<%
//权限审核
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"S002");
String Cortrol1=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"C002");
 //按揭款位数
  String ajkw="10000";
   ResultSet wRs=fBean.executeQuery("select state_type from hsm_ajk where section_no='"+request.getParameter("secno")+"'");
   if (wRs.next()){

     if (wRs.getString("state_type").equals("1"))
		  ajkw="1000";

   }
wRs.close();

//生成币另汇率数组

String RateSql="select * from currrate";
ResultSet RateRs=null;

try{
  RateRs=ViewBean.executeQuery(RateSql);

  out.print("<script>");
  out.print("var RateName=new Array();");
  out.print("var RateValue=new Array();");
  int iii=0;

   while (RateRs.next()){
     out.print("RateName["+String.valueOf(iii)+"]="+"\""+getbyte(RateRs.getString("CurrName"))+"\""+";");
     out.print("RateValue["+String.valueOf(iii)+"]="+"\""+RateRs.getString("CurrRate")+"\""+";");
	 iii++;
      }	 
}catch(Exception s){  out.print(s.getMessage());out.close();}
RateRs.close();
out.print("</script>");


 RateSql="select * from order_contract where section='"+request.getParameter("secno")+"'";

try{
  RateRs=ViewBean.executeQuery(RateSql);

  out.print("<script>");
  out.print("var OrderNo=new Array();");
  int iii=0;
   while (RateRs.next()){
     out.print("OrderNo["+String.valueOf(iii)+"]="+"\""+getbyte(RateRs.getString("SerialNo"))+"\""+";");
	 iii++;
      }	 
}catch(Exception s){  out.print(s.getMessage());out.close();}
RateRs.close();
out.print("</script>");
 %>
 <script>
 function checkedOrderNoExist(){
    if (document.cus.rgsno.value=="")return false;
    for (var i=0;i<OrderNo.length;i++){
	    if (document.cus.rgsno.value==OrderNo[i]){
		 alert("此认购编号已经使用");
		 document.cus.rgsno.focus();
		 return false;
		}
	
	}
 
 
 }
 
 </script>
<body onload="document.cus.rgsno.focus();">
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

<%//生成按揭数组
String SQLLL="select * from ajllgkb order by type,year";
ResultSet Rs=null;
java.text.DecimalFormat df2 = new java.text.DecimalFormat("#######.####"); 
try{
  Rs=ViewBean.executeQuery(SQLLL);
  out.print("<script>");
  
   out.print("var type2=new Array();");
   out.print("var monthtax=new Array();");
   out.print("var yeartax=new Array();");
   out.print("var bxsum=new Array();");
   out.print("var lxsum=new Array();");
   out.print("var dkll=new Array();");
   out.print("var monthout=new Array();");
   out.print("var year1=new Array();");
  int i=0;
   while (Rs.next()){
     out.print("type2["+String.valueOf(i)+"]="+"\""+Rs.getString("type")+"\""+";");
     out.print("year1["+String.valueOf(i)+"]="+"\""+Rs.getString("year")+"\""+";");
	 out.print("monthtax["+String.valueOf(i)+"]="+"\""+df2.format(Rs.getFloat("monthtax"))+"\""+";");
	 out.print("yeartax["+String.valueOf(i)+"]="+"\""+df2.format(Rs.getFloat("yeartax"))+"\""+";");
	 out.print("bxsum["+String.valueOf(i)+"]="+"\""+df2.format(Rs.getFloat("oneinterestsum"))+"\""+";");
	 out.print("lxsum["+String.valueOf(i)+"]="+"\""+df2.format(Rs.getFloat("suminterest"))+"\""+";");
	 out.print("dkll["+String.valueOf(i)+"]="+"\""+df2.format(Rs.getFloat("monthmoney"))+"\""+";");
	 out.print("monthout["+String.valueOf(i)+"]="+"\""+df2.format(Rs.getFloat("monthpay"))+"\""+";");
	i=i+1;
  }	 
}catch(Exception s){}
Rs.close();
out.print("</script>");


 
//读取客户临定数据
String ldroom=request.getParameter("code");
String ldSQL="select SL_TemporarilyBuy.*,customer.signatory,customer.address from  SL_TemporarilyBuy,customer where customer.serialno=SL_TemporarilyBuy.cusname and  roomcode="+ldroom;
ResultSet ldRs=null;
String ldCusname="";
String ldCusno="";
String ldCuscardid="";
String ldCustel="";
String ldseller="";
String ldCussj="";
String ldDJ="";
String ldsaleprice="";
String ldDate="",ldAddress="";
try{
  ldRs=ViewBean.executeQuery(ldSQL);
  if (ldRs.next()){
     ldDate=getbyte(ldRs.getString("StartDate"));
	 if (ldDate.indexOf(" ")>=0)ldDate=ldDate.substring(0,ldDate.indexOf(" "));
     ldDJ=getbyte(ldRs.getString("subscription"));
     ldseller=getbyte(ldRs.getString("receiver"));
	 ldCusno=getbyte(ldRs.getString("cusname"));
     ldCustel=getbyte(ldRs.getString("tel"));
	  ldCussj=getbyte(ldRs.getString("sj"));
	
	 ldsaleprice=getbyte(ldRs.getString("saleprice"));
     ldCuscardid=getbyte(ldRs.getString("cardid"));
	 ldCusname=getbyte(ldRs.getString("signatory"));
	 ldAddress=getbyte(ldRs.getString("address"));
  }

}catch(Exception s){  out.print(s.getMessage());out.close();}
ldRs.close();
 String SecNo=getbyte2(request.getParameter("secno"));
  String Loft=getbyte2(request.getParameter("loft"));
  String Build=getbyte2(request.getParameter("build"));
  String RoomNo=getbyte2(request.getParameter("roomno"));
   String Floor=getbyte2(request.getParameter("Floor"));
   String datalen="select PRICE_TYPE,unitlen,sumlen,disc ,salepricecounttype from SALE_PRICE_TYPE WHERE secno='"+SecNo+"'";
String price_type="1";
String unitlen="0";
String unitlen1="1";
String sumlen="0";
String discType="1";
String salepricecounttype="1";
 
  ldRs=ViewBean.executeQuery(datalen);	
if (ldRs.next()){
  price_type=ldRs.getString("PRICE_TYPE");
  unitlen=ldRs.getString("unitlen");
  if (unitlen.equals("2"))unitlen1="100";
  sumlen=ldRs.getString("sumlen");
  discType=ldRs.getString("disc");
  salepricecounttype=ldRs.getString("salepricecounttype");
}
ldRs.close();
//读取诚意数据
        String cusSerial = "" ;
        String cusName = "" ;
        String cusID = "" ;
        String cusPhone = "" ;
        String cusType = "" ;
        String ref_cusname=request.getParameter("ref_cusname");
		String ref_phone=request.getParameter("ref_phone");
		String ref_id_card=request.getParameter("ref_id_card");
		String ref_money=request.getParameter("ref_money");
		String ref_id=request.getParameter("ref_id");
		if (ref_money==null)ref_money="";
		if (ref_id==null)cusSerial="";
		if (ref_cusname!=null){
		  cusName=ref_cusname;
		  cusPhone=ref_phone;
		  cusID=ref_id_card;
		  cusSerial=ref_id;
		}
 %>
 <script>function count(){

   var type1="0";//document.cus.ajtype.options[document.cus.ajtype.selectedIndex].value;
   var year2=document.cus.ajyr.options[document.cus.ajyr.selectedIndex].value;
   if (type1==""||year2==""){return;}
   for (var j=0;j<type2.length;j++){
      if (type2[j]==type1&&year1[j]==year2){
	   document.cus.MonthMoney.value=subs1(parseFloat(monthout[j])*parseFloat(document.cus.ajmoney.value)/<%=ajkw%>,<%=unitlen %>);
	   break;
	  }else{
	   document.cus.MonthMoney.value="0";
	  }
     }

    }
	
	function count1(){ 
  var ajcs=document.cus.pay.value;
  ajcs=ajcs.substring(0,ajcs.indexOf("g"));
//  document.cus.ajcs.value=subs1(ajcs.substring(ajcs.indexOf("(")+1,ajcs.indexOf("%")),<%=unitlen %>);
  document.cus.ajmoney.value=parseInt(parseInt(document.cus.dicprice.value,10)*parseFloat(ajcs.substring(ajcs.indexOf("(")+1,ajcs.indexOf("%")),10)/100/<%=ajkw%>)*<%=ajkw%>;

  document.cus.firstMoney.value=parseInt(document.cus.dicprice.value)-parseInt(document.cus.ajmoney.value);
 if (document.cus.dicprice.value!="")
  document.cus.yukuan.value=parseInt(document.cus.dicprice.value,10)*parseFloat(ajcs.substring(ajcs.indexOf("(")+1,ajcs.indexOf("%")),10)/100-parseInt(parseInt(document.cus.dicprice.value,10)*parseFloat(ajcs.substring(ajcs.indexOf("(")+1,ajcs.indexOf("%")),10)/100/<%=ajkw%>)*<%=ajkw%>;

if (isNaN(document.cus.yukuan.value))document.cus.yukuan.value="0";
 if (parseInt(document.cus.dicprice.value)>0)  
document.cus.ajcs.value=subs1(parseFloat(document.cus.ajmoney.value)/parseFloat(document.cus.dicprice.value)*100,<%=unitlen %>); 
else
document.cus.ajcs.value=subs1(ajcs.substring(ajcs.indexOf("(")+1,ajcs.indexOf("%")),<%=unitlen %>);
if (document.cus.oldajcs.value=="")document.cus.oldajcs.value= document.cus.ajcs.value;
 
 
 }
 
 </script>

<SCRIPT language=javascript>
 
   function Validate(aForm)
   {
   
   
   
/*      if (aForm.rgsno.value.length<1)
	    	{
	    	alert("请输入认购书编号！");
	        aForm.rgsno.focus();
	        return (false);
	    	}	
*/

        if( isNaN( aForm.firstMoney.value ) )
        {
            alert( "请输入有效数值" ) ;
            aForm.firstMoney.focus() ;
            return false ;
        }

        if( isNaN( aForm.ajmoney.value ) )
        {
            alert( "请输入有效数值" ) ;
            aForm.ajmoney.focus() ;
            return false ;
        }

		 if (aForm.Date1.value.length<1)
	    	{
	    	alert("请输入或选择认购日期！");
	        aForm.Date1.focus();
	        return (false);
	    	}
		
      
		if (aForm.pay.value.length<1)
		{
	        alert("请选择客户的付款方式!");
	        aForm.pay.focus();
	        return false;
		}
		
	   if (aForm.cusname1.value==""){
	     alert("请选择客户或输入客户资料");
	     aForm.cusname1.focus();
		 return false;
	   }
	
	    return (true);
   }
   
   function setfocus()
   {
   		cus.rgsno.focus();
   }
   
   var counterAjMoney="0";
   function charges(){
   checkValue();

   var st=""
   if (document.cus.area.value==""||document.cus.jzunitprice.value==""){
     alert("请先输入面积及单价");
    cus.area.focus();
	return false;
   }
   else{
      st=document.cus.pay.value;
     st=st.substring(0,st.indexOf("g"));
	  document.cus.dis.value=st.substring(st.indexOf("-")+1,st.lastIndexOf("-"));
	  var char="";
	   <%if (discType.equals("0")){ %>
	  //对建筑单价折扣
	   if (parseInt(document.cus.jzunitprice.value)>0)
	   { char=(parseFloat(document.cus.jzunitprice.value)*1.0*parseFloat(st.substring(st.indexOf("-")+1,st.lastIndexOf("-"))/100.0))*parseFloat(document.cus.jzarea.value)/parseFloat(document.cus.area.value)*parseFloat(document.cus.area.value);
	   }
	   
	   <%}else{ //对预售总价进行折扣计算%>
	    if (parseInt(document.cus.sumprice.value)>0)
	   { char=(parseFloat(document.cus.sumprice.value)*1.0*parseFloat(st.substring(st.indexOf("-")+1,st.lastIndexOf("-"))/100.0)) ;
	   }
	   
	   <%} %>
	  var  varst=String(char);
	
	  document.cus.dicprice.value=subs1(char,<%=sumlen %>);
      if (char==""){char="0";document.cus.dicprice.value="0";}
	  document.cus.cjtnprice.value=subs1(parseFloat(char)/parseFloat(document.cus.area.value),<%=unitlen %>);
      document.cus.cjtnprice.value=subs1(document.cus.cjtnprice.value,<%=unitlen %>);
	  document.cus.sjcjtnprice.value= document.cus.cjtnprice.value;
	  document.cus.cjjzprice.value=subs1(parseFloat(char)/parseFloat(document.cus.jzarea.value),<%=unitlen %>);
	  document.cus.cjjzprice.value=subs1(document.cus.cjjzprice.value,<%=unitlen %>);
	  document.cus.sjcjjzprice.value=	  document.cus.cjjzprice.value;
	 
	 document.cus.earnest.value=st.substring(st.lastIndexOf("-")+1,st.indexOf("*"));  
	   
   }
     var datestr=document.cus.pay.value.substring(document.cus.pay.value.indexOf("#")+1);
   if (datestr.substring(datestr.indexOf("g")+1)==""&&datestr.substring(0,datestr.indexOf("."))!="")

     document.cus.qydate.value=datestr.substring(0,datestr.indexOf("."));
   else if (datestr.substring(datestr.indexOf("g")+1)!="")
    document.cus.qydate.value=datestr.substring(datestr.indexOf("g")+1)
   
   counterAjMoney=document.cus.ajmoney.value;
<%if (salepricecounttype.equals("0")){ %>   
if (document.cus.counttype.value=="0")
		document.cus.dicprice.value=subs1(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value),<%=sumlen %>);
<%} %>
document.cus.countdiscprice.value=document.cus.dicprice.value;
 
document.cus.dicprice.defaultValue=document.cus.dicprice.value;
document.cus.factprice.value=document.cus.dicprice.value;
document.cus.Adicprice.value=parseFloat(document.cus.dicprice.value);//+parseFloat(document.cus.tai_area_sumprice.value);

   
   if (st.indexOf("揭")>=0)
     document.cus.ajtxdate.value=datestr.substring(datestr.indexOf(".")+1,datestr.indexOf("g"));
   else
     document.cus.ajtxdate.value="";
    if (st.indexOf("揭")>=0){
        var type1="0"; 
	    var year2=document.cus.ajyr.value; 
	    if (type1!=""){
          count1();
		  if (year2!="")  count();//如果改了付款方式，则重新计算月供
		   
        }
		 document.cus.firstMoney.value=Math.round(parseFloat(document.cus.firstMoney.value)*<%=unitlen1%>)/<%=unitlen1%>;
 
    }
 if (isNaN(document.cus.qydate.value))
   {
    document.cus.gddate.checked=true;
	//else{ document.cus.qydate.focus();document.cus.qydate.select();}
 }
 }
  function chargeshf(){
     checkValue();

   var st=""
   if (document.cus.area.value==""||document.cus.jzunitprice.value==""){
     alert("请先输入面积及单价");
    cus.area.focus();
	return false;
   }
   else{
      st=document.cus.pay.value;
     st=st.substring(0,st.indexOf("g"));
	  document.cus.dis.value=st.substring(st.indexOf("-")+1,st.lastIndexOf("-"));
	  var char="";
	   if (parseInt(document.cus.sumprice.value)>0)
	    char=parseFloat(document.cus.sumprice.value)*1.0*parseFloat(st.substring(st.indexOf("-")+1,st.lastIndexOf("-"))/100.0);
      var  varst=String(char);
	 
	  document.cus.dicprice.value=subs1(char,<%=sumlen %>);
      if (char==""){char="0";document.cus.dicprice.value="0";}
	  document.cus.cjtnprice.value=subs1(parseFloat(char)/parseFloat(document.cus.area.value),<%=unitlen %>);
      document.cus.cjtnprice.value=subs1(document.cus.cjtnprice.value,<%=unitlen %>);
	  document.cus.sjcjtnprice.value= document.cus.cjtnprice.value;
	  document.cus.cjjzprice.value=subs1(parseFloat(char)/parseFloat(document.cus.jzarea.value),<%=unitlen %>);
	  document.cus.cjjzprice.value=subs1(document.cus.cjjzprice.value,<%=unitlen %>);
	  document.cus.sjcjjzprice.value=	  document.cus.cjjzprice.value;
	 
	 document.cus.earnest.value=st.substring(st.lastIndexOf("-")+1,st.indexOf("*"));  
	   
   }
     var datestr=document.cus.pay.value.substring(document.cus.pay.value.indexOf("#")+1);
   if (datestr.substring(datestr.indexOf("g")+1)==""&&datestr.substring(0,datestr.indexOf("."))!="")

     document.cus.qydate.value=datestr.substring(0,datestr.indexOf("."));
   else if (datestr.substring(datestr.indexOf("g")+1)!="")
    document.cus.qydate.value=datestr.substring(datestr.indexOf("g")+1)
   
   counterAjMoney=document.cus.ajmoney.value;
<%if (salepricecounttype.equals("0")){ %>   
if (document.cus.counttype.value=="0")
		document.cus.dicprice.value=subs1(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value),<%=sumlen %>);
<%} %>
document.cus.countdiscprice.value=document.cus.dicprice.value;
 
document.cus.dicprice.defaultValue=document.cus.dicprice.value;
document.cus.factprice.value=document.cus.dicprice.value;
document.cus.Adicprice.value=parseFloat(document.cus.dicprice.value);//+parseFloat(document.cus.tai_area_sumprice.value);

   
   if (st.indexOf("揭")>=0)
     document.cus.ajtxdate.value=datestr.substring(datestr.indexOf(".")+1,datestr.indexOf("g"));
   else
     document.cus.ajtxdate.value="";
    if (st.indexOf("揭")>=0){
        var type1="0"; 
	    var year2=document.cus.ajyr.value; 
	    if (type1!=""){
          count1();
		  if (year2!="")  count();//如果改了付款方式，则重新计算月供
		   
        }
    }
 if (isNaN(document.cus.qydate.value))
   {
    if (confirm("签约提醒日期是固定的日期"))document.cus.gddate.checked=true;
	else{ document.cus.qydate.focus();document.cus.qydate.select();}
 }
    }
   var LSprice="";
   function to(){
   if (document.cus.countdiscprice.value!="")
   document.cus.dicprice.value=document.cus.countdiscprice.value;
   }
  function disc(){

      var dic_arr ;
	   var def_Value;
	 	def_Value= document.cus.dicprice.defaultValue;
	    if (document.cus.abcd.value!=""){
      dic_arr=document.cus.abcd.value.split("*");
	  
	
	   var disn=1;
	   for (var dd=0;dd<dic_arr.length;dd++){
	         disn=disn*100;
			   if (isNaN(dic_arr[dd])){alert("折扣数据误");document.cus.abcd.focus();return false;}
			 if (parseFloat(dic_arr[dd])<=0){alert("折扣数据误");document.cus.abcd.focus();return false;}
	   	   }
		     <%if (discType.equals("0")){ %>
	  //对建筑单价折扣
	   if (parseInt(document.cus.jzunitprice.value)>0)
	   { 
	   	   //对建筑单打扣   
              var yjzunit=document.cus.cjjzprice.value;    
			  document.cus.cjjzprice.value=subs1(parseFloat(document.cus.cjjzprice.value)*1.0*eval(document.cus.abcd.value)/disn*1.0,<%=sumlen %>);
	 		  document.cus.cjtnprice.value= subs1(parseFloat(yjzunit)*1.0*eval(document.cus.abcd.value)/disn*1.0*parseFloat(document.cus.jzarea.value)/parseFloat(document.cus.area.value),<%=unitlen%>);
      
	      }
	   
	   <%}else{ //对预售总价进行折扣计算%>
	    if (parseInt(document.cus.sumprice.value)>0)
	   { 
	   
	    document.cus.dicprice.value=subs1(parseFloat(document.cus.dicprice.value)*1.0*eval(document.cus.abcd.value)/disn*1.0,<%=sumlen %>) ;
	    document.cus.cjtnprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.area.value),<%=unitlen %>);
        document.cus.cjjzprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.jzarea.value),<%=unitlen%>);

	   }
	   
	   <%} %>           
	    }else{
	
	 document.cus.dicprice.value=def_Value;
	 document.cus.cjtnprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.area.value),<%=unitlen %>);
     document.cus.cjjzprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.jzarea.value),<%=unitlen %>);
       <%if (salepricecounttype.equals("0")){ %>
			  document.cus.dicprice.value= subs1(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value),<%=sumlen %>);
             <%} %>  
	}
	   document.cus.ewyh.value=""; 
	   document.cus.Adicprice.value= document.cus.dicprice.value;
  }
   function disc1(){
      var dic_arr ;
	
	  var def_Value=document.cus.dicprice.value;
	 if (document.cus.abcd.value!=""){
      dic_arr=document.cus.abcd.value.split("*");
	
	   var disn=1;
	   for (var dd=0;dd<dic_arr.length;dd++){
	         disn=disn*100;
			   if (isNaN(dic_arr[dd])){alert("折扣数据误");document.cus.abcd.focus();return false;}
			 if (parseFloat(dic_arr[dd])<=0){alert("折扣数据误");document.cus.abcd.focus();return false;}
	   	   }
		   
 document.cus.dicprice.value=parseInt(def_Value)*eval(document.cus.abcd.value)/disn*1.0;
  document.cus.dicprice.value=Math.round(parseFloat(document.cus.dicprice.value)); document.cus.cjtnprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.area.value),<%=unitlen %>);
     document.cus.cjjzprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.jzarea.value),<%=unitlen %>);

    }else{
	
	 document.cus.dicprice.value=def_Value;
	 document.cus.cjtnprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.area.value),<%=unitlen %>);
     document.cus.cjjzprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.jzarea.value),<%=unitlen %>);
    
     
	}
	 document.cus.cjjzprice.value=subs1(document.cus.cjjzprice.value,<%=unitlen %>);
	 document.cus.cjtnprice.value=subs1(document.cus.cjtnprice.value,<%=unitlen %>);
  }
  
  function checkValue(){
  var pay=document.cus.pay.value;
 pay=pay.substring(0,pay.indexOf("g"));
  var varstr=pay.substring(0,pay.indexOf("-"));
  if (varstr.indexOf("揭")>=0){
    document.cus.ajyr.disabled=false;
	  document.cus.ajbk.disabled=false;
	 //document.cus.ajtype.disabled=false;
	document.cus.ajmoney.disabled=false;
	 document.cus.ajcs.disabled=false;
	 document.cus.firstMoney.disabled=false;
	 document.cus.MonthMoney.disabled=false;
	 document.cus.ajDate.disabled=false;
	 document.cus.fkDate.disabled=false;
	 
	 }
	else{ 
	  document.cus.ajmoney.value="0";
  	  document.cus.ajmoney.disabled=true;
      document.cus.ajyr.disabled=true;
 	  document.cus.ajbk.disabled=true;
	  
	  document.cus.ajcs.disabled=true;
	  document.cus.firstMoney.disabled=true;
	  document.cus.MonthMoney.disabled=true;
	  document.cus.ajDate.disabled=true;
	  document.cus.fkDate.disabled=true;
	  document.cus.fkDate.value="";
	  document.cus.ajDate.value="";
      document.cus.ajyr.value="";
 	  document.cus.ajbk.value="";
	 // document.cus.ajtype.value="";
	  document.cus.ajcs.value="";
	  document.cus.firstMoney.value="0"
	  document.cus.MonthMoney.value="0"
	  
   }
}
function FindOption(){

openwin("FindCustomer.jsp?section="+document.cus.section.value+"&FindCus=",400,380,300,100);  //+document.cus.cusname1.value
 }
 
 function show(){
   
  var pay=document.cus.pay.value;
  var dicprice=document.cus.dicprice.value;
  var year1=document.cus.Date1.value;//.options[0].text;
  if (year1==""){alert("请选择人认购日期");return;}
  var ajyr=document.cus.ajyr.options[document.cus.ajyr.selectedIndex].text;
  var ajcs=document.cus.ajcs.options[document.cus.ajcs.selectedIndex].text;
  var ajmoney=document.cus.ajmoney.value;
   if (pay.indexOf("揭")>=0){
    if (ajyr==""&&ajcs==""){alert("如果是按揭付款，请选择按揭年限、按揭银行、按揭层数");return false;}
   }
       openwin("ShowPaytView.jsp?pay="+pay+"&dicprice="+dicprice+"&date1="+year1+"&ajyr="+ajyr+"&ajcs="+ajcs+"&ajmoney="+ajmoney,400,<%=unitlen %>00,<%=unitlen %>00,50);  
  }
 function list(){
    openwin("largess.jsp?list=list",300,300,<%=unitlen %>00,50);  
 }
 function list1(){
    openwin("seleview.jsp?list=list&section=<%=request.getParameter("secno")%>",300,300,<%=unitlen %>00,50);  
 }
 function remo(){
  document.cus.seller.options[document.cus.seller.selectedIndex]=null;
 for (var j=0;j<document.cus.seller.length;j++){
	 if (document.cus.seller.options[j].text!="")
	 document.cus.seller.options[j].selected=true;
	}
}
 function SelectedSeller(){
 for (var j=0;j<document.cus.seller.length;j++){
	 if (document.cus.seller.options[j].text!="")
	 document.cus.seller.options[j].selected=true;
	}
}
 function UnitDepreciate(){
  //计算平方米降价后的总价
   var changes= document.cus.oneprice.value;
   var area=document.cus.area.value;
   var sumpri=document.cus.sumprice.value
   if (changes==""){alert("请输入平方米降价金额数");return false;}
   document.cus.hisumprice.value=parseFloat(document.cus.hisumprice.value)-parseFloat(document.cus.area.value)*parseInt(document.cus.oneprice.value);
 
 }
 function UnitManageChanges(){
   //计算送一年管理费后的总价
   var para1=document.cus.manageChages.value;
   if (para1==""){alert("请输入平方米管理费");return false;}
   document.cus.hisumprice.value=parseFloat(document.cus.hisumprice.value)-parseFloat(para1)*parseInt(document.cus.area.value)*12;
 }
 
 function ajm(){
   var price="";
   var ajm="";
   var ajcs="";
   if (document.cus.ajcs.options[document.cus.ajcs.selectedIndex].text!=""){
   price=document.cus.dicprice.value;
   price=parseInt(parseFloat(price)/<%=ajkw%>*(10-parseFloat(document.cus.ajcs.options[document.cus.ajcs.selectedIndex].text))/10)*<%=ajkw%>;
   document.cus.ajmoney.value=price;
  }else{ document.cus.ajmoney.value="0";} 
 }
 function chang(){
   var note1=document.cus.youhui.value;
   
   if( document.cus.largees.selectedIndex == 0 ) {
        return false ;
   }

   if (note1=="")
      note1=document.cus.largees.options[document.cus.largees.selectedIndex].text;
   else  	  
    note1=note1+"、"+document.cus.largees.options[document.cus.largees.selectedIndex].text;
    document.cus.youhui.value=note1;
 }

 function CurrRa(){
 //汇率转换
   var curryName=document.cus.curry.options[document.cus.curry.selectedIndex].value;
   for (var jj=0;jj<RateName.length;jj++)
    {
	  if (RateName[jj]==curryName)
	  {
	   document.cus.rate.value=RateValue[jj];
	//   document.cus.dicprice.value=parseFloat(document.cus.countdiscprice.value)/parseFloat(document.cus.rate.value);
	   break;
	  }
	}
 
 } 
 function bxRate(){
 //计算保险费
   var bxyr=document.cus.ajyr.options[document.cus.ajyr.selectedIndex].value;
   for (var jj=0;jj<Ratebx.length;jj++)
    {
	  if (Yearbx[jj]==bxyr)
	  {
		 document.cus.bxmoney.value=subs1(parseFloat(Ratebx[jj])*parseFloat(document.cus.dicprice.value)/<%=ajkw%>,<%=unitlen %>);
		 document.cus.bxmoney.value=subs1(document.cus.bxmoney.value,<%=unitlen %>);
		 break;
	  }
	}
 
 } 
 function count3(){
     charges();
	
   if (document.cus.dicprice.value!=""&&document.cus.abcd.value!="")disc();
    if (parseInt(counterAjMoney)>0&&parseFloat(document.cus.yukuan.value)>=0)
	    { document.cus.yukuan.value=String(parseFloat(document.cus.yukuan.value)+(parseInt(counterAjMoney)-parseInt(document.cus.ajmoney.value)));

		}
	   document.cus.Adicprice.value= document.cus.dicprice.value;
        document.cus.ajcs.value=subs1(parseFloat(document.cus.ajmoney.value)/parseFloat(document.cus.dicprice.value)*100,<%=unitlen %>);
		count4();
 }
  function count4(){
   if (parseInt(document.cus.firstMoney.value)==0)return false;
   document.cus.ajmoney.value=parseFloat(document.cus.dicprice.value)-parseFloat(document.cus.firstMoney.value);
   document.cus.ajmoney.value=parseInt(document.cus.ajmoney.value);
   var ws=String(parseInt(document.cus.ajmoney.value)/<%=ajkw %>);
    if (ws.indexOf(".")>0){
   ws=ws.substring(ws.indexOf(".")+1);
   if (parseInt(ws)>0){if (confirm("按揭款只能是以万为单位！是否转换？")){
   document.cus.ajmoney.value=parseInt(parseInt(document.cus.ajmoney.value)/<%=ajkw %>)*<%=ajkw %>;
   document.cus.firstMoney.value=parseFloat(document.cus.dicprice.value)-parseFloat(document.cus.ajmoney.value);
  }
  }
   }
  document.cus.firstMoney.value=subs1(parseFloat(document.cus.dicprice.value)-parseInt(document.cus.ajmoney.value),<%=unitlen %>);
   document.cus.firstMoney.value=Math.round(parseFloat(document.cus.firstMoney.value)*<%=unitlen1%>)/<%=unitlen1%>;
 if (parseFloat(document.cus.ajcs.value)>80){alert("按揭成数大于8层");}
  }
var ValuePrice="";
function count5(){
charges();//按付款方式打折扣
   if (document.cus.abcd.value!="")
count3();//额外折扣
//额外优惠...

   if (document.cus.ewyh.value!=""){
     document.cus.dicprice.value=parseFloat(document.cus.dicprice.value)-parseInt(document.cus.ewyh.value);
     if (document.cus.pay.value.indexOf("揭")>=0){
    document.cus.firstMoney.value=parseInt(document.cus.firstMoney.value)-parseInt(document.cus.ewyh.value);
     }
     } 
   
     document.cus.cjtnprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.area.value),<%=unitlen %>);
     document.cus.cjjzprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.jzarea.value),<%=unitlen %>);
     document.cus.cjtnprice.value=subs1(document.cus.cjtnprice.value,<%=unitlen %>) ;
  	 document.cus.cjjzprice.value=subs1(document.cus.cjjzprice.value,<%=unitlen %>) ;
	// alert(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value));
	  document.cus.dicprice.value=subs1(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value),<%=unitlen %>);
    

	   document.cus.Adicprice.value= document.cus.dicprice.value;
	//disc1();
	 
count4();

}


function countAj(){
   document.cus.firstMoney.value=parseInt(document.cus.dicprice.value)-parseInt(document.cus.ajmoney.value);
   document.cus.ajcs.value=subs1(parseInt(document.cus.ajmoney.value)/parseFloat(document.cus.dicprice.value)*100,<%=unitlen %>);
   document.cus.ajcs.value=subs1(document.cus.ajcs.value,<%=unitlen %>);
     if (parseFloat(document.cus.ajcs.value)>80){
    alert("按揭层数超过了8层!");
	document.cus.ajmoney.focus();
   }
}
function countsq(){
   document.cus.ajmoney.value=parseInt(document.cus.dicprice.value)-parseInt(document.cus.firstMoney.value);
count4();
 
 
}
function sjprice(){
 document.cus.sjcjtnprice.value=subs1(parseFloat(document.cus.factprice.value)/parseFloat(document.cus.area.value),<%=unitlen %>);
    document.cus.sjcjjzprice.value=subs1(parseFloat(document.cus.factprice.value)/parseFloat(document.cus.jzarea.value),<%=unitlen %>);
}

function xiangqing() {
	//var cusname = document.forms[ 0 ].cusname.value ;
	//if( cusname == "" ) {
		//alert( "请选择客户!" ) ;
		//return false ;
	//}
     var cusname1=document.cus.cusname1.value;
	var cusname=document.cus.cusname.value;
	var carid=document.cus.carid.value;
	var tel=document.cus.tel.value;
	var sj=document.cus.sj.value;
	var addr=document.cus.Address.value;
    var spa = 400 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa / 2 ;
    var lef = spa / 2 ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=450"  ;
    var posi = posi + ",width=550";

	if (cusname=="")
    var newwin=window.open( "../customter/customerin.jsp?addnew=addnew&cusname="+cusname1+"&tel="+tel+"&carid="+carid+"&sj="+sj+"&addr="+addr ,"NewsW","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
	else
	var newwin=window.open( "../customter/editcustomer.jsp?edit=editcus&cusno="+cusname+"&tel="+tel+"&carid="+carid+"&sj="+sj+"&addr="+addr,"NewsW","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );

}
var fistValue="";
function fq_sendfirst(para){
if (document.cus.firstmoney.value==""&&fistValue!=""){document.cus.factprice.value=fistValue;return false;}
   if (document.cus.firstmoney.value==""){return false;}
   check(para);
   if (fistValue=="")fistValue=document.cus.dicprice.value;
   
   
document.cus.factprice.value=parseInt(document.cus.dicprice.value)-parseInt(document.cus.firstmoney.value);
   sjprice();
}
function aj_sendfirst(para){
  
//if (document.cus.firstmoney.value==""&&fistValue!=""){document.cus.dicprice.value=fistValue;}
 if (document.cus.firstmoney.value==""){return false;}
//if (fistValue=="")fistValue=document.cus.dicprice.value;
 
check(para);
if (document.cus.ajmoney.value!=""&&document.cus.ajmoney.value!="0"){
document.cus.factprice.value=parseInt(document.cus.dicprice.value)-parseInt(document.cus.firstmoney.value);
document.cus.firstMoney.value=parseInt(document.cus.dicprice.value)-parseInt(document.cus.ajmoney.value);
document.cus.firstMoney.value=parseInt(document.cus.firstMoney.value)-parseInt(document.cus.firstmoney.value);sjprice();
}else if (document.cus.firstMoney.value==""){

document.cus.factprice.value=parseInt(document.cus.dicprice.value)-parseInt(document.cus.firstmoney.value);
 
//document.cus.dicprice.value=parseInt(document.cus.dicprice.value)-parseInt(document.cus.firstmoney.value);
sjprice();
}else if (document.cus.firstMoney.value=="0"){

document.cus.factprice.value=parseInt(document.cus.dicprice.value)-parseInt(document.cus.firstmoney.value);
 
document.cus.dicprice.value=parseInt(document.cus.dicprice.value)-parseInt(document.cus.firstmoney.value);sjprice();
}
    
}
function sendfirst(para){
   if (document.cus.firstMoney.value!="0")
    aj_sendfirst(para);
   else 
    fq_sendfirst(para);
   	
}


</SCRIPT>
<%
 
 
String UseArea="";
String SaleArea="";
String SaleUnitPrice="";
String UserUnitPrice="";
String SaleSumPrice="";
String Fitment="";
String RoomType="";
String Room_Type="";
String floor="";
String Code="";
String ty_area="0",ty_area_price="0",typrice="0";
String wd_area="0",wd_area_price="0",wdprice="0";
String LDSql="select UsedArea,Area,Unitprice,TNunitprice,Sumprice,Fitment,RoomType,Room_Type,floor ";
LDSql+=",ty_area,ty_area_price,ty_area*ty_area_price typrice,wd_area,wd_area_price,wd_area*wd_area_price wdprice from room";

LDSql+=" where seccode='"+SecNo+"' and loft='"+Loft+"' and building='";
LDSql+=Build+"' and room_code='"+RoomNo+"'";
LDSql+="and Floor="+Floor;
ResultSet rsLD=null;

try{
  rsLD=ViewBean.executeQuery(LDSql);
  if (rsLD.next())  {
    UseArea=Format.getFloat1(rsLD.getFloat("UsedArea"),3);
    SaleArea=Format.getFloat1(rsLD.getFloat("Area"),3);
    SaleUnitPrice=Format.getFloat1(rsLD.getFloat("Unitprice"),2);
	UserUnitPrice=Format.getFloat1(rsLD.getFloat("TNunitprice"),2);
	SaleSumPrice=Format.getFloat1(rsLD.getFloat("Sumprice"),1);
	Fitment=getbyte(rsLD.getString("Fitment"));
	RoomType=getbyte(rsLD.getString("RoomType"));
	Room_Type=getbyte(rsLD.getString("Room_Type"));
   floor=getbyte(rsLD.getString("Floor"));
  }
  rsLD.close();
}
catch(Exception s){out.print(s.getMessage());}


 

 

   String Ai="select * from order_contract where state<>3 and  loft='"+Loft+"' and section='"+SecNo+"' and room_no='"+RoomNo+"' and floors="+Floor;

   ResultSet exist=ViewBean.executeQuery(Ai);
   if (exist.next()){
   exist.close();
   %>
   <script>
   alert("此单位已被认购,不能保存");
   window.close();
   </script>
   <%out.close();
   } 
   exist.close();
   //
String lokesql="UPDATE room SET saleLOKE=1,salelokedate=getdate() where seccode='"+SecNo+"' and loft='"+Loft+"'";
lokesql+=" and building='"+Build+"' and room_code='"+RoomNo+"' and  Floor="+Floor;
 
 ViewBean.executeUpdate(lokesql);
String RoomSql="select Code,UsedArea,Area,Unitprice,TNunitprice,Sumprice,Fitment,RoomType,Room_Type,floor ";
RoomSql+=",room_price,yang_tai_area,yong_tu,lu_tai_area_price,lu_tai_area,lu_tai_area*lu_tai_area_price lu from room";
RoomSql+=" where seccode='"+SecNo+"' and loft='"+Loft+"' and building='";
RoomSql+=Build+"' and room_code='"+RoomNo+"' and Floor="+Floor;
ResultSet rs=null;

float checksumprice=0;
String room_price="",yang_tai_area="",yong_tu="",lu_tai_area_price="",lu_tai_area="",lu="";
try{
  rs=ViewBean.executeQuery(RoomSql);
  if (rs.next())  {
    Code=rs.getString("Code");
	
    UseArea=Format.getFloat1(rs.getFloat("UsedArea"),3);
    SaleArea=Format.getFloat1(rs.getFloat("Area"),3);
    SaleUnitPrice=Format.getFloat1(rs.getFloat("Unitprice"),2);
	UserUnitPrice=Format.getFloat1(rs.getFloat("TNunitprice"),2);
	checksumprice=rs.getFloat("Sumprice");
	SaleSumPrice=Format.getFloat1(checksumprice,1);
	Fitment=getbyte(rs.getString("Fitment"));
	RoomType=getbyte(rs.getString("RoomType"));
	Room_Type=getbyte(rs.getString("Room_Type"));
    floor=getbyte(rs.getString("Floor"));
	room_price=Format.getFloat1(rs.getFloat("room_price"),2);
	yang_tai_area=Format.getFloat1(rs.getFloat("yang_tai_area"),2);
	yong_tu=getbyte(rs.getString("yong_tu"));
	lu_tai_area_price=Format.getFloat1(rs.getFloat("lu_tai_area_price"),2);
	lu_tai_area=Format.getFloat1(rs.getFloat("lu_tai_area"),2);
	lu=Format.getFloat1(rs.getFloat("lu"),2);
  }
  rs.close();
}
catch(Exception s){out.print(s.getMessage());}
java.text.SimpleDateFormat date =null;
date=new java.text.SimpleDateFormat("yyyy-MM-dd");
String TodayDate=date.format(new java.util.Date()).toString();
int curyear=Integer.parseInt(TodayDate.substring(0,4));
int curmonth=Integer.parseInt(TodayDate.substring(5,7));
int curday=Integer.parseInt(TodayDate.substring(8,10));
 %>
<form method="POST" name="cus" action=""> 
<input type=hidden name=floor value="<%=floor%>">
  <p align=center><font size=3><b>销售资料登记</b></font></p>
   <table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif">　<img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>房间资料</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"><font color="#FF6600"> &nbsp;</font></td>
</tr>
</table>	
  <table border=0 width="100%" cellspacing=0 cellpadding=0 align=center bordercolor="#ffffff" class="tablefill">
 
    <tr> 
   
     
	  <td width="15%" align=left class=roomleft>&nbsp;楼盘名称</td>
      <td width="19%" align=left class=roomright>&nbsp;<%=getbyte2(request.getParameter("secname")) %> 
        <input type=hidden name="sectio" readonly value="<%=getbyte2(request.getParameter("secname")) %>" size="10"  >
        <input type=hidden name="section"  value="<%=getbyte2(request.getParameter("secno")) %>" size="10"  >
      </td>
      <td width="15%" align=left class=roomleft>&nbsp;房&nbsp;间&nbsp;号&nbsp;</td>
      <td   align=left class=roomright width="20%">&nbsp;<%=getbyte2(request.getParameter("loft")) %><%=getbyte2(request.getParameter("build"))+getbyte2(request.getParameter("roomno")) %> 
        　 </td>
      <td   align=left class=roomleft width="12%">&nbsp;交楼日期</td>
      <td width="19%" class=roomright align=left>&nbsp;<%=request.getParameter("jldate") %> 
        　</td>
    </tr>
	     <input type=hidden name="ldroomno" readonly value="<%=getbyte2(request.getParameter("roomno")) %>"size="15"   onChange="toUpper(document.cus.roomno)">
 
	    <input type=hidden name="roomno" readonly value="<%=getbyte2(request.getParameter("roomno")) %>"size="15"   onChange="toUpper(document.cus.roomno)">
        <input type="hidden" name="loft" readonly="readonly" size="15" value="<%=getbyte2(request.getParameter("loft")) %>">
		<input type=hidden name="build" readonly value="<%=getbyte2(request.getParameter("build")) %>"   size="15"   onChange="toUpper(document.cus.build)">
    	<INPUT TYPE=hidden NAME=Date2 value="<%=request.getParameter("jldate") %>" size=10 readonly title="请选择认购日期" onkeydown="key(document.cus.pay)">
        <input type=hidden name="jzarea" readonly  value="<%=SaleArea %>"  size="15"  >
		<input type=hidden name="area" readonly value="<%=UseArea%>"  size="15"  >
		<input type=hidden name="tnunitprice" readonly  value="<%=UserUnitPrice%>"  size="15"  >
   	    <input type=hidden name="jzunitprice" readonly value="<%=SaleUnitPrice%>"  size="15"  >
        <input type=hidden name="fx" readonly  value="<%=RoomType %>"  size="15"   onChange="toUpper(document.cus.roomno)">
        <input type=hidden name="sumprice" readonly value="<%=room_price %>"  size="15"  >
		 <input type=hidden name="Asumprice" readonly value="<%=SaleSumPrice %>"  size="15"  >
		
		<input type=hidden name="zx" readonly value="<%=Fitment %>"  size="15"   >
        <input type=hidden name="fl"  readonly value="<%=Room_Type%>" size="15"  >
		<input type=hidden name="yong_tu"  readonly value="<%=yong_tu%>" size="15"  >
		<input type=hidden name="yang_tai_area"  readonly value="<%=yang_tai_area%>" size="15"  >
       	<input type=hidden name="lu_tai_area_price"  readonly value="<%=lu_tai_area_price%>" size="15"  >
       	<input type=hidden name="lu_tai_area"  readonly value="<%=lu_tai_area%>" size="15"  >
 
	 
   
	  
    <tr> 
      <td width="15%" align=left class=roomleft>&nbsp;建筑面积</td>
      <td width="19%" align=left class=roomright>&nbsp;<%=SaleArea %></td>
      <td width="15%" align=left class=roomleft>&nbsp;套内建筑面积</td>
      <td   align=left class=roomright width="20%">&nbsp;<%=UseArea%></td>
      <td   align=left class=roomleft width="12%">&nbsp;套内建筑<br>&nbsp;面积单价</td>
      <td width="19%" class=roomright align=left>&nbsp;<%=UserUnitPrice%></td>
    </tr>
 
	  <tr> 
      <td width="15%" align=left class=roomleft>&nbsp;建筑面积单价</td>
      <td width="19%" align=left class=roomright>&nbsp;<%=SaleUnitPrice%></td>
      <td width="15%" align=left class=roomleft>&nbsp;预售总价</td>
      <td   align=left class=roomright width="20%">&nbsp;<%=SaleSumPrice %></td>
      <td   align=left class=roomleft width="12%">&nbsp;房间总价</td>
      <td width="19%" class=roomright align=left>&nbsp;<%=room_price %> 　</td>
    </tr>
	<tr> 
      <td width="15%" align=left class=roomleft>&nbsp;花园/露台面积</td>
      <td width="19%" align=left class=roomright>&nbsp;<%=lu_tai_area%></td>
      <td width="15%" align=left class=roomleft>&nbsp;花园/露台单价</td>
      <td   align=left class=roomright width="20%">&nbsp;<%=lu_tai_area_price %></td>
      <td   align=left class=roomleft width="12%">&nbsp;阳台面积</td>
      <td width="19%" class=roomright align=left>&nbsp;<%=yang_tai_area %> 　</td>
    </tr>
  </table>
    <table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#ffffff" class="tablefill">        
	 <tr> 
      <td colspan="8" align="center"  class="title1"></td> 
    </tr>
   </table>
 <table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif">　<img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>客户资料</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"><font color="#FF6600"> &nbsp;</font></td>
</tr>
</table>	
  <table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#ffffff" class="tablefill">
   
    <tr> 
      <%
       
	if (cusSerial.equals("null"))	cusSerial ="";
       if (cusName.equals("null"))  	cusName="";
       if (cusID.equals("null"))	       cusID="";
       if (cusPhone.equals("null"))	cusPhone="";

      %>
    
      <input type=hidden name="cusname" value="<%= ldCusno %>" >
      <td width="16%" class=roomleft >&nbsp;客户姓名</td>
      <td colspan="2" class=roomright>&nbsp;&nbsp;<input type=text value="<%=ldCusname %>" onchange="aa();"  name="cusname1"  size=40  onkeydown="key(document.cus.carid)" title="如果多个姓名，请用'/'分隔"  ><!--value="<%= cusName%>"-->

<input type=hidden name="cusname2" value="<%=ldCusname %>">
        <font color=red>*</font><select name="editnow"><option value="1">更新现客户</option> <option value="2">保留现客户</option>
</select> 
<script>
  function aa(){
    var aa=document.cus.cusname1.value;
    var aa1=document.cus.cusname2.value;
    if (aa!=aa1){
       if (confirm("你已变更了客户姓名，是否保留原客户姓名？"))
          setSelectMad(document.cus.editnow,"2");
       else
          setSelectMad(document.cus.editnow,"1");        

     }else{
     setSelectMad(document.cus.editnow,"1");
   }
}
</script>
      <input type=button name=FindB  value="查找" onclick="FindOption();"> 
        <%if (Cortrol1.indexOf("A")>=0) {%>
        <input type=button name=FindB1  value="增加" onclick="xiangqing();"> 
        <%} %>
    </tr>
    <tr> 
      <td width="16%" class=roomleft>&nbsp;身份证号</td>
      <td class=roomright>&nbsp; <input type=text  name="carid" title="如果多个，请用'/'分隔"   size=68   onkeydown="key(document.cus.tel)" value="<%= ldCuscardid%>" >
        　</td>
    </tr>
    <tr> 
      <td width="16%" class=roomleft>&nbsp;联系电话</td>
      <td class=roomright >&nbsp; <input type=text  name="tel"  size=30 title="如果多个，请用'/'分隔"   onKeyDown="key(document.cus.youhui)" value="<%= ldCustel%>">
        手机&nbsp; <input type=text  name="sj"  size=30 title="如果多个，请用'/'分隔"   onKeyDown="key(document.cus.youhui)" value="<%=ldCussj %>"> 
      </td>
    </tr>
    <tr> 
      <td width="16%" class=roomleft>&nbsp;联系地址</td>
      <td class=roomright >&nbsp; <input type=text  name="Address"  size=68  value="<%=ldAddress %>" onKeyDown="key(document.cus.shouji)"> 
      </td>
    </tr>
    <tr> 
      <td width="16%" class=roomleft >&nbsp;客户类型</td>
      <td  class=roomright>&nbsp; <select name=custype>
          <option value=个人 <% if( cusType.equals( "个人" ) ) { out.print( "selected" ) ; } %> >个人</option>
          <option value=企业 <% if( cusType.equals( "企业" ) ) { out.print( "selected" ) ; } %> >企业</option>
        </select>  &nbsp;<select name=rh><option value=0>不入户</option>
   <option value=1>需要入户</option>
        </select> &nbsp;入户数:<input type=text  size=8 name=rhn value="0">&nbsp;销售员:&nbsp; <select name="seller"  multiple size=1.5  onblur="SelectedSeller();" style="width:100">
          <option ></option>
          <option ></option>
          <option ></option>
          <option ></option>
        </select> <input type=button name=listlar value="<<" onclick="list1();" title="增加销售员"> 
        <input type=button name=rem value=">>" onclick="remo();"  title="删除销售员"> 
        <!-- 
         滞纳金比: <input type=text size=4 name=demurrage value=0.01>% 
         -->
      </td>
    </tr>
    <tr> 
      <td class=roomleft>&nbsp;优惠赠送 </td>
      <td class=roomright>&nbsp; <input type=text name=youhui size=50 maxlength="50"> 
        <select name=largees OnChange="chang();">
          <%
	    String StrSql="select type,codename from CODE where type='S' and child=0 order by type";
     ResultSet codeRS=null;
    
    codeRS=ViewBean.executeQuery(StrSql);
   %>
          <%out.print("<option>请选择赠品</option>");
		   while (codeRS.next()){
			 out.print("<option>"+getbyte(codeRS.getString("codename"))+"</option>");
		   }
		   codeRS.close();
				%>
        </select> </td>
    </tr>
    <tr> 
      <td width="16%" rowspan="5"   class=roomleft>&nbsp;备&nbsp;注</td>
      <td  class=roomright>&nbsp; <textarea rows="3" name="note" cols="50"  ></textarea> 
      </td>
    </tr>
  </table>
   <table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif">　<img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>认购资料</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"><font color="#FF6600"> &nbsp;</font></td>
</tr>
</table>	
  <table BORDER=2 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#ffffff" class="tablefill">
   
    <tr> 
      <td width="12%" class=roomleft>&nbsp;认购编号</td>
      <td width="12%" class=roomright>&nbsp;<input type=text name="rgsno"   size="10"   onChange="toUpper(document.cus.rgsno)" onKeyDown="key(document.cus.cale1)" onBlur="checkedOrderNoExist();" title="只能是英文字母、数字及"-"组成"><input type=button name=adc value=".." title="选择合同号" onclick="openwin('RgNoList.jsp?SecNo=<%=SecNo %>',<%=unitlen %>00,350,100,100);"></td>
      <td width="19%" class=roomleft>&nbsp;认购日期</td>
      <td width="19%" class=roomright>&nbsp;<input type=TEXT value="<%=curyear+"-"+curmonth+"-"+curday %>" name=Date1 size=10 title="请选择认购日期"  readonly onchange="key(document.cus.pay);" onKeyDown="key(document.cus.VisaDate)"><input type=button name=cale1 value=".." onClick="fPopUpCalendarDlg(Date1);return false;" title="请选择认购日期">
        <font color=red>*</font>　</td>
      <td width="15%" class=roomright colspan="2">&nbsp;付款方式:<select name="pay"     onChange="charges();" style="width : 150" onKeyDown="key(document.cus.VisaDate)">
          <option></option>
            <%
       String sql="select * from PayMent where  TYPE=0 and seccoe='"+SecNo+"'";
      ResultSet rs3=ViewBean.executeQuery(sql);
	  String pay="";
	  float dic;
	  String dj1="";
	  String qdate="";
	  String ajdate="";	  
	  String gddate="";	 
	  String num="";
     while (rs3.next()){
	    pay=getbyte(rs3.getString("PayName"));
		num=rs3.getString("num");
	    dic=rs3.getFloat("Discont");
		dj1=rs3.getString("prepay");
		qdate=rs3.getString("qdate");
		ajdate=rs3.getString("ajdate");
		gddate=getbyte(rs3.getString("gddate"));
		if (gddate.indexOf(" ")>0)gddate=gddate.substring(0,gddate.indexOf(" "));
		String dic1=String.valueOf(dic);
	    out.print("<option value='"+pay+"-"+dic1+"-"+dj1+"*"+num+"#"+qdate+"."+ajdate+"g"+gddate+"'>"+pay+"*"+dic+"折*"+num+"期</option>");
	  }
	  
	    rs3.close();
     %>
        </select></td>
    
        <input type=hidden name=dis size=6 readonly>
       
    </tr>
 
    <%if (Cortrol.indexOf("K")>=0){  %>
    <tr> 
      <td width="19%" class=roomleft>&nbsp;额外优惠</td>
      <td width="19%" class=roomright   >&nbsp;<input type="hidden" name="ewyh1" size=10 ><input type="text" name="ewyh" size=10   onchange="check(this);count5();"   onkeydown="key(document.cus.curry);">
      </td>

	   <td width="15%" class=roomleft>&nbsp;额外折扣</td>
      <td width="23%"    class=roomright>&nbsp;<input  type=hidden name=abcd1  ><input  type=text name=abcd   onchange="check(this);count3();" size=8 title="输入格式：99" onkeydown="key(document.cus.curry);">%        
        　</td>

	  <td width="15%" class=roomleft>&nbsp;优惠日期</td>
      <td width="23%"    class=roomright>&nbsp;<input  type=text name=youhui_date   size=12 onkeydown="key(document.cus.curry);"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(youhui_date);" title="请选择认购日期">
      </td><input type=hidden name="ajtype" value="0">
    
	 </tr>
	 <tr> 
      <td width="19%" class=roomleft>&nbsp;优惠备注</td>
      <td width="19%" class=roomright  colspan="5"  >&nbsp;<input  type=text name=youhuibeizhu   size=50 onkeydown="key(document.cus.curry);">关系人&nbsp;&nbsp;<input type=text size=10 name=gxr  >
 
    
 </tr>
 <%}else{ %>
	 <input  type="hidden" name="ewyh" size=10 >
	 <input  type=hidden name=youhuibeizhu  size=12 >
	 <input  type=hidden name=abcd  >
	
	<%} %>
	 <!-- <select name=ajcs style="width : 40" disabled onBlur="count1();"  onchange="document.cus.ajyr.focus();">
          <option></option>
          <%for (int i=1;i<=10;i++){
		out.print("<option value="+String.valueOf(i)+">"+String.valueOf(i)+"0%</option>");
		} %>
       <!--  </select>-->
    <tr>
      <td width="12%" class=roomleft >&nbsp;成数年限</td><input type=hidden name=oldajcs size=4>
      <td width="15%"    class=roomright  >&nbsp;<input type=text name=ajcs size=4>%<select name=ajyr disabled    onchange="count();" onblur="bxRate();" style="width : 35" >
          <option></option>
          <%for (int i=1;i<=30;i++){
		out.print("<option value="+String.valueOf(i)+">"+String.valueOf(i)+"年</option>");
		} %>
        </select></td>
		<td width="19%" class=roomleft>&nbsp;首&nbsp;期&nbsp;款</td>
        <td width="19%" class=roomright >&nbsp;<input  type=text size=9  value ="0"   name=firstMoney disabled  onblur="check(this);countsq();">(元)</td>
        <td width="15%" class=roomleft>&nbsp;按揭额</td>
        <td width="23%" class=roomright  >&nbsp;<input  type=text size=10 value ="0"    disabled name=ajmoney onblur="check(this);countAj();">(元)　</td>
    </tr>

    <tr> 
      <td width="19%" class=roomleft >&nbsp;房&nbsp;款</td>
      <td width="19%"    class=roomright>&nbsp;<input type=text name="dicprice"  defaultValue=""  size="10" <%if (!(checksumprice>0)){ %>   onblur="check(this);charges();"     <%}else{out.print("readonly title='已有定价，不能直接填写'");} %> onkeydown="key(document.cus.cjjzprice);">元
        <input type=hidden name="countdiscprice" >
        <input type=hidden value=0 readonly name="MonthMoney"     size="10"  >
      </td>
      <td width="15%" class=roomleft>&nbsp;定 金</td>
      <td width="23%" class=roomright  >&nbsp;<input type=text name="earnest"  readonly   size="10"  >
        　</td>
		 <td width="19%" class=roomleft >&nbsp;成交总价</td>
      <td width="19%"    class=roomright>&nbsp;<input type=text name="Adicprice"     size="10" <%if (!(checksumprice>0)){ %>   onblur="check(this);charges();"     <%}else{out.print("readonly title='已有定价，不能直接填写'");} %> onkeydown="key(document.cus.cjjzprice);">元
      
      </td>
     
    </tr>
	<input type=hidden name=yukuan value=0>
   <tr>
      <td width="12%" class=roomleft >&nbsp;成交建筑<br>&nbsp;面积单价</td>
      <td width="12%" class=roomright >&nbsp;<input type=text name="cjjzprice" size=10   onchange="if (parseInt(document.cus.dicprice.value)<=0)document.cus.dicprice.value=parseFloat(this.value)*parseFloat(document.cus.jzarea.value);charges();document.cus.sumprice.value=0;"></td>
      <td width="19%" class=roomleft >&nbsp;成交套内<br>&nbsp;建筑面积单价</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="cjtnprice" size=8 onchange="if (parseInt(document.cus.dicprice.value)<=0)document.cus.dicprice.value=parseFloat(this.value)*parseFloat(document.cus.area.value);charges();document.cus.sumprice.value=0;"> 元/M<sup>2</sup>　</td>  
      <td width="19%" class=roomleft >&nbsp;合同类别</td>
      <td width="19%" class=roomright >&nbsp;<select name="httype"><option value=0>内销</option><option value=1>外销</option></select></td>  
   
	</tr> <input type=hidden size=10 value=0  name="firstmoney"  onchange="sendfirst(this);">
	<input type=hidden size=10 name="factprice" readonly>
	<input type=hidden name="sjcjjzprice" size=10  readonly>
	<input type=hidden name="sjcjtnprice" size=8 readonly>
	<tr>
	  <td width="19%" class=roomleft >&nbsp;合同计价方式</td>
      <td width="19%" class=roomright >&nbsp;<select name="counttype" style="width : 90">
          <option value="0">套内面积</option>
          <option value="1">建筑面积</option>
        </select></td> 
	 
	  <td width="15%" class=roomleft>&nbsp;币&nbsp;&nbsp;&nbsp;&nbsp;种</td>
      <td width="23%" class=roomright  >&nbsp;<select name="curry" style="width : 70" OnChange="CurrRa();">
          <option value="￥">人民币</option>
          <option value="HKD">港元</option>
          <option value="USD">美元</option>
        </select><input type=text name="rate"  value=1.0  size="4" title="汇率"  onblur="check(this);">
        　　</td>
	 </tr>
	  <!--<tr>
      <td width="12%" class=roomleft >&nbsp;实际成交建筑<br>&nbsp;面积单价</td>
      <td width="12%" class=roomright >&nbsp;<input type=text name="sjcjjzprice" size=10  readonly></td>
      <td width="19%" class=roomleft >&nbsp;实际成交套内<br>&nbsp;建筑面积单价</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="sjcjtnprice" size=8 readonly> 元/M<sup>2</sup>　</td> 
	    <td width="19%" class=roomleft >&nbsp;合同计价方式</td>
      <td width="19%" class=roomright >&nbsp;<select name="counttype" style="width : 90">
          <option value="套内面积">套内面积</option>
          <option value="建筑面积">建筑面积</option>
        </select></td> 
	   </tr>
	   -->
        <tr>
      <td width="12%" class=roomleft >&nbsp;露台面积</td>
      <td width="12%" class=roomright >&nbsp;<input type=text name="lutai_area" onblur="countlutai();"  size=10 value="<%=lu_tai_area %>"  ></td>
      <td width="19%" class=roomleft >&nbsp;露台单价</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="lutai_area_price" size=8   onblur="countlutai();" value="<%=lu_tai_area_price %>"  > 元/M<sup>2</sup>　</td> 
	   <td width="19%" class=roomleft >&nbsp;露台总价</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="tai_area_sumprice" size=8 readonly  value="<%=lu %>" > 元</td>  </tr>
  
	   </tr>
	     <tr>
      <td width="12%" class=roomleft >&nbsp;花园面积</td>
      <td width="12%" class=roomright >&nbsp;<input type=text name="ty_area" onblur="countty();"  size=10 value="<%=ty_area %>"  ></td>
      <td width="19%" class=roomleft >&nbsp;花园单价</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="ty_area_price" size=8   onblur="countty();" value="<%=ty_area_price %>"  > 元/M<sup>2</sup>　</td> 
	   <td width="19%" class=roomleft >&nbsp;花园总价</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="ty_area_sumprice" size=8 readonly  value="<%=typrice %>" > 元</td>  </tr>
  
	   </tr>
	     <tr>
      <td width="12%" class=roomleft >&nbsp;屋面面积</td>
      <td width="12%" class=roomright >&nbsp;<input type=text name="wd_area" onblur="countwd();"  size=10 value="<%=wd_area %>"  ></td>
      <td width="19%" class=roomleft >&nbsp;屋面单价</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="wd_area_price" size=8   onblur="countwd();" value="<%=wd_area_price %>"  > 元/M<sup>2</sup>　</td> 
	   <td width="19%" class=roomleft >&nbsp;屋面总价</td>
      <td width="19%" class=roomright >&nbsp;<input type=text name="wd_area_sumprice" size=8 readonly  value="<%=wdprice %>" > 元</td>  </tr>
  
	   </tr>
	   <tr><td colspan="4" class=roomleft>&nbsp;签约提醒延迟天数/日期:<input type="test" size=10 name="qydate"  ><input type=checkbox name=gddate value=1> 固定日期</td></tr>
	   <script>
	   function countlutai(){
	      if (document.cus.lutai_area.value!=""&&document.cus.lutai_area_price.value!=""){
		   // document.cus.Adicprice.value=parseFloat(document.cus.dicprice.value)+parseFloat(document.cus.lutai_area.value)*parseFloat(document.cus.lutai_area_price.value)
		     document.cus.tai_area_sumprice.value=parseFloat(document.cus.lutai_area.value)*parseFloat(document.cus.lutai_area_price.value);
		  }
	   }
	    function countty(){
	      if (document.cus.ty_area.value!=""&&document.cus.ty_area_price.value!=""){
		     document.cus.ty_area_sumprice.value=parseFloat(document.cus.ty_area.value)*parseFloat(document.cus.ty_area_price.value)
		  }
	   }
	    function countwd(){
	      if (document.cus.wd_area.value!=""&&document.cus.wd_area_price.value!=""){
		     document.cus.wd_area_sumprice.value=parseFloat(document.cus.wd_area.value)*parseFloat(document.cus.wd_area_price.value)
		  }
	   }
	   </script>
  </table>
<%if(userstate.equals("1")){ %>
<INPUT TYPE="hidden"  NAME=QYDate size=10>
<INPUT TYPE="hidden"  NAME=ajbk size=10 >
<INPUT TYPE="hidden"  NAME=ajDate size=10 >
<INPUT TYPE="hidden"  NAME=fkDate size=10 >
 
<input type=hidden size=13 value="0" name=bxmoney>
<input type="hidden" value="0" name="firstFT">
<input type="hidden"  name="constractno">
<input type="hidden" value="0" name="gz">
<input type="hidden" value="0" name="bx">
<%}else{ %>
    <table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#ffffff" class="tablefill">
    <tr class="roomleft" align="center"> 
      <td width="16%" height="25" colspan="6"><font size="3">签&nbsp;约&nbsp;明&nbsp;细</font></td>
     
    </tr>
    <tr > 
      <td width="16%"  class=roomleft>首期款状态</td>
      <td width="18%"  class=roomright>&nbsp;<select name="firstFT" style="width : 105"><option value="0">未交</option><option value="1">已交</option></select></td>
      <td width="16%"  class=roomleft>合同编号</td>
      <td width="18%"  class=roomright>&nbsp;<input type="text" name="constractno"  size="12"    onblur="checkedOrderNoExist(this.value);" OnChange="if (document.cus.rgsno.value=='')document.cus.rgsno.value=document.cus.constractno.value;toUpper(document.cus.constractno)" onkeydown="key(document.cus.QYDate)" title="只能是英文字母、数字及"-"组成"></td>
      <td width="14%"  class=roomleft>签约日期
      </td>
      <td width="18%"  class=roomright>&nbsp;<INPUT TYPE="text"  NAME=QYDate size=10  title="请选择签约日期"  OnChange="document.cus.Date1.value=document.cus.QYDate.value;" onkeydown="key(document.cus.kkrate)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(QYDate);document.cus.Date1.value=document.cus.QYDate.value;return false;" title="请选择认购日期"></td>
    </tr>
   <input type="hidden" name="qydate">
    <tr bordercolor="#FFFFFF"> 
      <td width="16%" class=roomleft>按揭银行</td>
      <td width="18%" class=roomright>&nbsp;<select name=ajbk disabled style="width : 105">
         <option></option>
		  <%
	     StrSql="select type,codename from CODE where type='T' order by type";
        codeRS=null;
    
    codeRS=ViewBean.executeQuery(StrSql);
   %>
				  <%
		   while (codeRS.next()){
			 out.print("<option>"+getbyte(codeRS.getString("codename"))+"</option>");
		   }
		   codeRS.close();
				%>
        </select></td>
      <td width="14%" class=roomleft>按揭日期</td>
      <td width="18%" class=roomright>&nbsp;<INPUT TYPE="text"  disabled NAME=ajDate size=10  onkeydown="key(document.cus.ajDate)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(ajDate);return false;" title="请选择认购日期"></td>
      <td width="16%" class=roomleft>银行放款日期</td>
      <td width="18%" class=roomright>&nbsp;<INPUT TYPE="text" disabled NAME=fkDate size=10  onkeydown="key(document.cus.ajDate)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(fkDate);" title="请选择认购日期"></td>
    </tr>

    <tr bordercolor="#FFFFFF"> 
      <td width="16%" class=roomleft>公证状态</td>
      <td width="18%" class=roomright>&nbsp;<select name="gz" style="width : 105"><option value="0">未办</option><option value="1">已办</option></select></td>
      <td width="14%" class=roomleft>保险状态</td>
      <td width="18%" class=roomright>&nbsp;<select name="bx" style="width : 105"><option value="0">未办</option><option value="1">已办</option></select></td>
      <td width="16%" class=roomleft>保险金额</td>
      <td width="18%" class=roomright>&nbsp;<input type=text size=13 value="0" name=bxmoney></td>
    </tr>
    <!--
    <tr bordercolor="#FFFFFF"> 
      <td width="16%" class=roomleft>是否按揭</td>
      <td width="18%" class=roomright>&nbsp;<select name="aj" style="width : 105"><option value="1">不按揭</option><option value="0">按揭</option></select></td>
    </tr>
    <tr bordercolor="#FFFFFF"> 
      <td width="16%" class=roomleft>备案日期</td>
      <td width="18%" class=roomright>&nbsp;<INPUT TYPE="text"  NAME=baDate size=10  onkeydown="key(document.cus.ajDate)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(baDate);" title="请选择认购日期"></td>
      <td width="14%" class=roomleft>出案日期</td>
      <td width="18%" class=roomright>&nbsp;<INPUT TYPE="text"  NAME=caDate size=10  onkeydown="key(document.cus.ajDate)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(caDate);" title="请选择认购日期"></td>
    </tr>    
    -->

  </table>
  <%} %>
  <p align="center"> 
    <input type=hidden name=saveorder value="insert">
  <input type=hidden name=ajtxdate >
   <%if (Cortrol.indexOf("A")>=0) {%>
    <input type="button" value="提　交" name="submit1" onclick="SaveContract();">
	<%} %>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    <input type="button" value="退 出" name="reset" onclick="window.close();">
  </P>
     <script>
	 function SaveContract(){
      if (document.cus.Date2.value==""){alert("交楼日期不能为空,请先在房间资料中填写");return false;}
  
   if (Validate(document.cus)){
 
    var datestr=document.cus.pay.value.substring(document.cus.pay.value.indexOf("#")+1);
   if (datestr.substring(datestr.indexOf("g")+1)==""&&datestr.substring(0,datestr.indexOf("."))!="")

     document.cus.qydate.value=datestr.substring(0,datestr.indexOf("."));
   else if (datestr.substring(datestr.indexOf("g")+1)!="")
    document.cus.qydate.value=datestr.substring(datestr.indexOf("g")+1)
     document.cus.action="order_save.jsp?ref_money=<%=ref_money %>&code=<%=Code %>";
	 document.cus.submit();
   }
 }
	 
	 </script>
</form>
</body>
</html>
