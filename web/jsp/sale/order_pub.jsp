<%@ page contentType="text/html;charset=GBK" %>
<%

  String userstate=(String) session.getAttribute("userstate");
   
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
 
//生成按揭数组
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
 
function count(){

   var type1="0"; 
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
 if (document.cus.pay.value.indexOf("揭")>0){
  var ajcs=document.cus.pay.value;
  ajcs=ajcs.substring(0,ajcs.indexOf("g"));
 
  document.cus.ajmoney.value=parseInt(parseInt(document.cus.dicprice.value,10)*parseFloat(ajcs.substring(ajcs.indexOf("(")+1,ajcs.indexOf("%")),10)/100/<%=ajkw%>)*<%=ajkw%>;
  document.cus.firstMoney.value=subs1(parseFloat(document.cus.dicprice.value)-parseInt(document.cus.ajmoney.value),<%=unitlen %>);
  document.cus.sydk.value= document.cus.ajmoney.value;
 if (document.cus.dicprice.value!="")
  document.cus.yukuan.value=parseInt(document.cus.dicprice.value,10)*parseFloat(ajcs.substring(ajcs.indexOf("(")+1,ajcs.indexOf("%")),10)/100-parseInt(parseInt(document.cus.dicprice.value,10)*parseFloat(ajcs.substring(ajcs.indexOf("(")+1,ajcs.indexOf("%")),10)/100/<%=ajkw%>)*<%=ajkw%>;
if (isNaN(document.cus.yukuan.value))document.cus.yukuan.value="0";
 if (parseInt(document.cus.dicprice.value)>0)  
document.cus.ajcs.value=subs1(parseFloat(document.cus.ajmoney.value)/parseFloat(document.cus.dicprice.value)*100,<%=unitlen %>); 
else
document.cus.ajcs.value=subs1(ajcs.substring(ajcs.indexOf("(")+1,ajcs.indexOf("%")),<%=unitlen %>);
if (document.cus.oldajcs.value=="")document.cus.oldajcs.value= document.cus.ajcs.value;
 
 }
 }
 
 </script>

<SCRIPT language=javascript>
 
   function Validate(aForm)
   {
 

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
  function ykj_count(){
    <%if (Cortrol.indexOf("C")==-1){ %>
    if (!document.cus.bz.checked&&parseInt(document.cus.dicprice.value)>0){
	<%} %> 
      char=document.cus.dicprice.value;
	  document.cus.cjtnprice.value=subs1(parseFloat(char)/parseFloat(document.cus.area.value),<%=unitlen %>);
      document.cus.cjtnprice.value=subs1(document.cus.cjtnprice.value,<%=unitlen%>);
	  document.cus.sjcjtnprice.value= document.cus.cjtnprice.value;
	  document.cus.cjjzprice.value=subs1(parseFloat(char)/parseFloat(document.cus.jzarea.value),<%=unitlen %>);
	  document.cus.cjjzprice.value=subs1(document.cus.cjjzprice.value,<%=unitlen %>);
	  document.cus.sjcjjzprice.value=	  document.cus.cjjzprice.value;
	 document.cus.Adicprice.value=document.cus.dicprice.value;
	  document.cus.firstMoney.value=subs1(parseFloat(document.cus.dicprice.value)-parseInt(document.cus.ajmoney.value),<%=unitlen %>);

	 <%if (Cortrol.indexOf("C")==-1){ %>
	}
  <%} %> 
  }
  function checkcount(){
    if(!document.cus.bz.checked){
    document.cus.dicprice.readOnly=document.cus.bz.checked;
    document.cus.dicprice.focus();
	document.cus.dicprice.select();
	}else{count5();}
	
    }
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
	  var discnum=countDisc(st.substring(st.indexOf("-")+1,st.lastIndexOf("-")));
	  var char="";
	  <%if (discType.equals("0")){ %>
	  //对建筑单价折扣
	   if (parseInt(document.cus.jzunitprice.value)>0)
	   { char=(parseFloat(document.cus.jzunitprice.value)*1.0*eval(st.substring(st.indexOf("-")+1,st.lastIndexOf("-")))/parseFloat(discnum))*parseFloat(document.cus.jzarea.value)/parseFloat(document.cus.area.value)*parseFloat(document.cus.area.value);
	   }
	   
	   <%}else{ //对预售总价进行折扣计算%>
	    if (parseInt(document.cus.sumprice.value)>0)
	   { char=(parseFloat(document.cus.sumprice.value)*1.0*eval(st.substring(st.indexOf("-")+1,st.lastIndexOf("-")))/parseFloat(discnum)) ;
	   }
	   
	   <%} %>
	  var  varst=String(char);

	  document.cus.dicprice.value=subs1(char,<%=sumlen %>);
	  	
 
      if (char==""){char="0";document.cus.dicprice.value="0";}
	  document.cus.cjtnprice.value=subs1(parseFloat(char)/parseFloat(document.cus.area.value),<%=unitlen %>);
      document.cus.cjjzprice.value=subs1(parseFloat(char)/parseFloat(document.cus.jzarea.value),<%=unitlen %>);
	 
	 document.cus.earnest.value=st.substring(st.lastIndexOf("-")+1,st.indexOf("|"));  
	   
   }
     var datestr=document.cus.pay.value.substring(document.cus.pay.value.indexOf("#")+1);
   if (datestr.substring(datestr.indexOf("g")+1)==""&&datestr.substring(0,datestr.indexOf("."))!="")

     document.cus.qydate.value=datestr.substring(0,datestr.indexOf("."));
   else if (datestr.substring(datestr.indexOf("g")+1)!="")
    document.cus.qydate.value=datestr.substring(datestr.indexOf("g")+1)
  
   counterAjMoney=document.cus.ajmoney.value;
<%if (salepricecounttype.equals("1")){ %>   
if (document.cus.counttype.value=="0")
		document.cus.dicprice.value=subs1(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value),<%=sumlen %>);
<%} %>
 
document.cus.countdiscprice.value=document.cus.dicprice.value;
 
document.cus.dicprice.defaultValue=document.cus.dicprice.value;
document.cus.factprice.value=document.cus.dicprice.value;
document.cus.Adicprice.value=document.cus.dicprice.value;//+parseFloat(document.cus.tai_area_sumprice.value);

   
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
			document.cus.firstMoney.value=Math.round(parseFloat(document.cus.firstMoney.value)*100)/100;
	
		 }
 if (isNaN(document.cus.qydate.value))
   {
    document.cus.gddate.checked=true;
	//else{ document.cus.qydate.focus();document.cus.qydate.select();}
 }
 
 }
   var LSprice="";
   function to(){
   if (document.cus.countdiscprice.value!="")
   document.cus.dicprice.value=document.cus.countdiscprice.value;
   }
   
   function countDisc(para){
       var dic_arr=para.split("*");
	   var disn=1;
	   for (var dd=0;dd<dic_arr.length;dd++){
	         disn=disn*100;
	  	}
	 return disn
   
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
			  document.cus.cjjzprice.value=subs1(parseFloat(document.cus.cjjzprice.value)*1.0*eval(document.cus.abcd.value)/disn*1.0,<%=unitlen %>);
	 		  document.cus.cjtnprice.value= subs1(parseFloat(yjzunit)*1.0*eval(document.cus.abcd.value)/disn*1.0*parseFloat(document.cus.jzarea.value)/parseFloat(document.cus.area.value),<%=unitlen%>);
               document.cus.dicprice.value=subs1(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value),<%=sumlen %>);
          
	      }
	   
	   <%}else{ //对预售总价进行折扣计算%>
	    if (parseInt(document.cus.sumprice.value)>0)
	   { 
	   
	   document.cus.dicprice.value=subs1(parseFloat(document.cus.dicprice.value)*1.0*eval(document.cus.abcd.value)/disn*1.0,<%=sumlen %>) ;
	    document.cus.cjtnprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.area.value),<%=unitlen %>);
     document.cus.cjjzprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.jzarea.value),<%=unitlen%>);

	   }
	   
	   <%} %>
		   
		       <%if (salepricecounttype.equals("1")){ %>
			  document.cus.dicprice.value= subs1(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value),<%=sumlen %>);
             <%} %>
		  }else{
	
	 document.cus.dicprice.value=def_Value;
	 document.cus.cjtnprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.area.value),<%=unitlen %>);
     document.cus.cjjzprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.jzarea.value),<%=unitlen%>);
       <%if (salepricecounttype.equals("1")){ %>
	  document.cus.dicprice.value=subs1(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value),<%=sumlen %>);
       <%} %>
	}
	
	    
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
  document.cus.dicprice.value=subs1(parseFloat(document.cus.dicprice.value),<%=sumlen %>); document.cus.cjtnprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.area.value),<%=unitlen %>);
     document.cus.cjjzprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.jzarea.value),<%=unitlen %>);
   
    }else{
	
	 document.cus.dicprice.value=def_Value;
	 document.cus.cjtnprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.area.value),<%=unitlen %>);
     document.cus.cjjzprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.jzarea.value),<%=unitlen %>);
    
     
	}
	   <%if (salepricecounttype.equals("1")){ %>
	  if (document.cus.counttype.value=="0")
		document.cus.dicprice.value=subs1(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value),<%=sumlen %>);
       <%} %>

	   document.cus.Adicprice.value= document.cus.dicprice.value;
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
	  document.cus.sydk.value="0";
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

openwin("FindCustomer.jsp?section="+document.cus.section.value+"&FindCus=",600,380,300,100);  //+document.cus.cusname1.value
 }
 
function FindOption1(){

openwin("FindMeber.jsp?section="+document.cus.section.value+"&FindCus=",400,380,300,100);  //+document.cus.cusname1.value
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
  document.cus.sydk.value= document.cus.ajmoney.value;
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

 function count3(){
     charges();
	 if (document.cus.dicprice.value!=""&&document.cus.abcd.value!="")disc();
  
 
	  if (parseInt(counterAjMoney)>0&&parseFloat(document.cus.yukuan.value)>=0)
	    { document.cus.yukuan.value=String(parseFloat(document.cus.yukuan.value)+(parseInt(counterAjMoney)-parseInt(document.cus.ajmoney.value)));

		}
		 <%if (salepricecounttype.equals("1")){ %>
	if (document.cus.counttype.value=="0")
		document.cus.dicprice.value=Math.round(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value)*<%=unitlen1 %>)/<%=unitlen1 %>;
    <%} %>
 
		  document.cus.Adicprice.value= document.cus.dicprice.value;
        document.cus.ajcs.value=subs1(parseFloat(document.cus.ajmoney.value)/parseFloat(document.cus.dicprice.value)*100,<%=unitlen %>);
		count4(); }
  function count4(){
   if (parseInt(document.cus.firstMoney.value)==0)return false;
   document.cus.ajmoney.value=parseFloat(document.cus.dicprice.value)-parseFloat(document.cus.firstMoney.value);
  document.cus.ajmoney.value=parseInt(document.cus.ajmoney.value);
   document.cus.sydk.value= document.cus.ajmoney.value;
   var ws=String(parseInt(document.cus.ajmoney.value)/<%=ajkw %>);
     
    if (ws.indexOf(".")>0){
   ws=ws.substring(ws.indexOf(".")+1);
   if (parseInt(ws)>0){if (confirm("按揭款只能是以万为单位！是否转换？")){
   document.cus.ajmoney.value=parseInt(parseInt(document.cus.ajmoney.value)/<%=ajkw %>)*<%=ajkw %>;
   document.cus.firstMoney.value=subs1(parseFloat(document.cus.dicprice.value)-parseFloat(document.cus.ajmoney.value),<%=unitlen %>);

  }
  }
   }
    document.cus.firstMoney.value=subs1(parseFloat(document.cus.dicprice.value)-parseInt(document.cus.ajmoney.value),<%=unitlen %>);
 //  document.cus.firstMoney.value=Math.round(parseFloat(document.cus.firstMoney.value)*100)/100;
  if (parseFloat(document.cus.ajcs.value)>80){alert("按揭成数大于8层");}
   document.cus.sydk.value= document.cus.ajmoney.value;
 }
var ValuePrice="";
function count5(){
charges();//按付款方式打折扣

count3();//额外折扣

//额外优惠...
   //额外优惠...
   
   if (document.cus.ewyh.value!=""){
     document.cus.dicprice.value=subs1(parseFloat(document.cus.dicprice.value)-parseInt(document.cus.ewyh.value),<%=sumlen %>);
   
	 if (document.cus.pay.value.indexOf("揭")>=0){
    document.cus.firstMoney.value=subs1(parseFloat(document.cus.firstMoney.value)-parseInt(document.cus.ewyh.value),<%=unitlen %>);
     }
     } 
      document.cus.cjtnprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.area.value),<%=unitlen %>);
     document.cus.cjjzprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.jzarea.value),<%=unitlen %>);
     document.cus.cjtnprice.value=subs1(document.cus.cjtnprice.value,<%=unitlen %>) ;
  	 document.cus.cjjzprice.value=subs1(document.cus.cjjzprice.value,<%=unitlen %>) ;
	  <%if (salepricecounttype.equals("1")){ %>
	if (document.cus.counttype.value=="0")
		document.cus.dicprice.value=Math.round(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value)*<%=unitlen1 %>)/<%=unitlen1 %>;
    <%} %>

	   document.cus.Adicprice.value= document.cus.dicprice.value;
	//disc1();
	 count1();

}
function countAj(){
   document.cus.firstMoney.value=subs1(parseFloat(document.cus.dicprice.value)-parseInt(document.cus.ajmoney.value),<%=unitlen %>);
   
   document.cus.ajcs.value=subs1(parseInt(document.cus.ajmoney.value)/parseFloat(document.cus.dicprice.value)*100,<%=unitlen %>);
   document.cus.ajcs.value=subs1(document.cus.ajcs.value,<%=unitlen %>);
   if (parseFloat(document.cus.ajcs.value)>80){
    alert("按揭层数超过了8层!");
	document.cus.ajmoney.focus();
   }
}
function countsq(){
   document.cus.ajmoney.value=parseInt(document.cus.dicprice.value)-parseInt(document.cus.firstMoney.value);
    document.cus.sydk.value= document.cus.ajmoney.value;
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
document.cus.factprice.value=subs1(parseFloat(document.cus.dicprice.value)-parseInt(document.cus.firstmoney.value),<%=unitlen %>);
document.cus.firstMoney.value=subs1(parseFloat(document.cus.dicprice.value)-parseInt(document.cus.ajmoney.value),<%=unitlen %>);
document.cus.firstMoney.value=subs1(parseFloat(document.cus.firstMoney.value)-parseInt(document.cus.firstmoney.value),<%=unitlen %>);
sjprice();
}else if (document.cus.firstMoney.value==""){

document.cus.factprice.value=parseInt(document.cus.dicprice.value)-parseInt(document.cus.firstmoney.value);
 
//document.cus.dicprice.value=parseInt(document.cus.dicprice.value)-parseInt(document.cus.firstmoney.value);
sjprice();
}else if (document.cus.firstMoney.value=="0"){

document.cus.factprice.value=parseInt(document.cus.dicprice.value)-parseInt(document.cus.firstmoney.value);
 
document.cus.dicprice.value=parseInt(document.cus.dicprice.value)-parseInt(document.cus.firstmoney.value);sjprice();
  if (document.cus.counttype.value=="0")
		document.cus.dicprice.value=Math.round(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value)*<%=unitlen1 %>)/<%=unitlen1 %>;
 

   document.cus.Adicprice.value= document.cus.dicprice.value;
}
    
}
function sendfirst(para){
   if (document.cus.firstMoney.value!="0")
    aj_sendfirst(para);
   else 
    fq_sendfirst(para);
   	
}

function countAge(){

  var caridS=document.cus.carid.value;
  var caridSS=caridS;
  var currDat=new Date();  
  var year=currDat.getYear();
  document.cus.age.value="";

  var ages="";
  if (caridS!=""){	
   var arry=caridS.split("/");//转换为arry
	for (var jj=0;jj<arry.length;jj++){
	  if (!isNaN(arry[jj])){
		  if (ages=="")
		   { 
		    if (arry[jj].length==18)
		      // ages=String(parseInt(year)-parseInt(arry[jj].substring(6,10)));
			  ages="19"+arry[jj].substring(6,12);
		    else if (arry[jj].length==15)
		       ages="19"+arry[jj].substring(6,10);
			else{ alert("有些身份证号位数有误,系统只计算正确号码的年龄"); } 
		   }
		  else
		    {
			if (arry[jj].length==18)
		       ages+="/"+"19"+arry[jj].substring(6,12);
		    else if (arry[jj].length==15)
		       ages+="/"+"19"+arry[jj].substring(6,10);
			else {alert("有些身份证号位数有误,系统只计算正确号码的年龄"); }
			}
			
		}else if (arry[jj].length==18) {
		   if (ages=="")
		       ages="19"+arry[jj].substring(6,12);
		  else
		       ages+="/"+"19"+arry[jj].substring(6,12);
		 }
	 }
  }

  document.cus.age.value="20";
}

function discCount(para,para1,para2){
   if (para=="额外折扣"&&para2=="总价"){//总价额外折扣
      document.cus.dicprice.value=subs1(parseFloat(document.cus.dicprice.value)*1.0*parseFloat(para1)/100.0,<%=sumlen %>);
	  if (parseFloat(document.cus.area.value)>0)
      document.cus.cjtnprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.area.value),<%=unitlen %>);
      document.cus.cjjzprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.jzarea.value),<%=unitlen %>);
     
	   <%if (salepricecounttype.equals("1")){ %> 
	    document.cus.dicprice.value=subs1(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value),<%=sumlen %>);
       <%} %>
   }else if (para=="额外优惠"&&para2=="总价"){//额外优惠
         document.cus.dicprice.value=subs1(parseFloat(document.cus.dicprice.value)-parseFloat(para1),<%=sumlen %>);
        // document.cus.dicprice.value=subs1(parseFloat(document.cus.dicprice.value)*parseFloat(para1),<%=sumlen %>);
		   if (parseFloat(document.cus.area.value)>0)
         document.cus.cjtnprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.area.value),<%=unitlen %>);
         document.cus.cjjzprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.jzarea.value),<%=unitlen %>);
       <%if (salepricecounttype.equals("1")){ %> 
	     document.cus.dicprice.value=subs1(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value),<%=sumlen %>);
       <%} %>
  }else if (para=="额外折扣"&&para2=="建筑单价"){//单价额外优惠
        var aaaa=subs1(parseFloat(document.cus.cjjzprice.value)*parseFloat(para1)/100.0,<%=unitlen %>);
        document.cus.cjjzprice.value=aaaa;
	    document.cus.dicprice.value=subs1(parseFloat(document.cus.jzarea.value)*parseFloat(aaaa),<%=sumlen %>);
		  if (parseFloat(document.cus.area.value)>0)
        document.cus.cjtnprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.area.value),<%=unitlen %>);
        <%if (salepricecounttype.equals("1")){ %> 
	     document.cus.dicprice.value=subs1(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value),<%=sumlen %>);
       <%} %>
  }else if (para=="额外优惠"&&para2=="建筑单价"){//额外优惠
       var aaaa=subs1(parseFloat(document.cus.cjjzprice.value)-parseFloat(para1),<%=unitlen %>);
       document.cus.cjjzprice.value=aaaa;
	    document.cus.dicprice.value=subs1(parseFloat(document.cus.jzarea.value)*parseFloat(aaaa),<%=sumlen %>);
		  if (parseFloat(document.cus.area.value)>0)
        document.cus.cjtnprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.area.value),<%=unitlen %>);
        <%if (salepricecounttype.equals("1")){ %> 
	     document.cus.dicprice.value=subs1(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value),<%=sumlen %>);
       <%} %>
 } 
    document.cus.Adicprice.value= document.cus.dicprice.value;
	count1();
	document.cus.firstMoney.value= parseFloat(document.cus.dicprice.value)-parseFloat(document.cus.ajmoney.value);
	
}
</SCRIPT>