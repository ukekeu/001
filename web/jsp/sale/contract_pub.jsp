<%@ page contentType="text/html;charset=GBK" %>
<%//���ɰ�������
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
//alert( document.cus.MonthMoney.value);
    }

	function count1(){ 
 if (document.cus.pay.value.indexOf("��")>0){
  var ajcs=document.cus.pay.value;
  ajcs=ajcs.substring(0,ajcs.indexOf("g"));
 
  document.cus.ajmoney.value=parseInt(parseInt(document.cus.dicprice.value,10)*parseFloat(ajcs.substring(ajcs.indexOf("(")+1,ajcs.indexOf("%")),10)/100/<%=ajkw%>)*<%=ajkw%>;
  document.cus.sydk.value= document.cus.ajmoney.value;
  document.cus.firstMoney.value=subs1(parseFloat(document.cus.dicprice.value)-parseInt(document.cus.ajmoney.value),<%=sumlen %>);
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

<script>function Validate(aForm)
   { 
   
     
	
      if( isNaN( aForm.firstMoney.value ) )
        {
            alert( "��������Ч��ֵ" ) ;
            aForm.firstMoney.focus() ;
            return false ;
        }

        if( isNaN( aForm.ajmoney.value ) )
        {
            alert( "��������Ч��ֵ" ) ;
            aForm.ajmoney.focus() ;
            return false ;
        }

		 if (aForm.Date1.value.length<1)
	    	{
	    	alert("�������ѡ���Ϲ����ڣ�");
	        aForm.Date1.focus();
	        return (false);
	    	}
		
      
		if (aForm.pay.value.length<1)
		{
	        alert("��ѡ��ͻ��ĸ��ʽ!");
	        aForm.pay.focus();
	        return false;
		}
		
	   if (aForm.cusname1.value==""){
	     alert("��ѡ��ͻ�������ͻ�����");
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
     alert("�����������������");
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
	  //�Խ��������ۿ�
	   if (parseInt(document.cus.jzunitprice.value)>0)
	   { char=(parseFloat(document.cus.jzunitprice.value)*1.0*eval(st.substring(st.indexOf("-")+1,st.lastIndexOf("-")))/parseFloat(discnum))*parseFloat(document.cus.jzarea.value)/parseFloat(document.cus.area.value)*parseFloat(document.cus.area.value);
	   }
	   
	   <%}else{ //��Ԥ���ܼ۽����ۿۼ���%>
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

   
   if (st.indexOf("��")>=0)
     document.cus.ajtxdate.value=datestr.substring(datestr.indexOf(".")+1,datestr.indexOf("g"));
   else
     document.cus.ajtxdate.value="";
    if (st.indexOf("��")>=0){
        var type1="0"; 
	    var year2=document.cus.ajyr.value; 
	    if (type1!=""){
          count1();
		  if (year2!="")  count();//������˸��ʽ�������¼����¹�
		   
        }
			document.cus.firstMoney.value=Math.round(parseFloat(document.cus.firstMoney.value)*100)/100;
	
		 }
 if (isNaN(document.cus.qydate.value))
   {
    document.cus.gddate.checked=true;
	//else{ document.cus.qydate.focus();document.cus.qydate.select();}
 }
 
 }
 
   function countDisc(para){
       var dic_arr=para.split("*");
	   var disn=1;
	   for (var dd=0;dd<dic_arr.length;dd++){
	         disn=disn*100;
	  	}
	 return disn
   
   }
  function chargeshf(){
     checkValue();

   var st=""
   if (document.cus.area.value==""||document.cus.jzunitprice.value==""){
     alert("�����������������");
    cus.area.focus();
	return false;
   }
   else{
      st=document.cus.pay.value;
     st=st.substring(0,st.indexOf("g"));
	  document.cus.dis.value=st.substring(st.indexOf("-")+1,st.lastIndexOf("-"));
	  var char="";
	    var discnum=countDisc(st.substring(st.indexOf("-")+1,st.lastIndexOf("-")));
	   if (parseInt(document.cus.sumprice.value)>0)
	    char=parseFloat(document.cus.sumprice.value)*1.0*eval(st.substring(st.indexOf("-")+1,st.lastIndexOf("-"))/parseFloat(discnum));
      var  varst=String(char);
	   document.cus.dicprice.value=subs1(char,<%=sumlen %>);
      if (char==""){char="0";document.cus.dicprice.value="0";}
	  document.cus.cjtnprice.value=subs1(parseFloat(char)/parseFloat(document.cus.area.value),<%=unitlen %>);
      document.cus.cjtnprice.value=subs1(document.cus.cjtnprice.value,<%=unitlen %>);
	  document.cus.sjcjtnprice.value= document.cus.cjtnprice.value;
	  document.cus.cjjzprice.value=subs1(parseFloat(char)/parseFloat(document.cus.jzarea.value),<%=unitlen %>);
	  document.cus.cjjzprice.value=subs1(document.cus.cjjzprice.value,<%=unitlen %>);
	  document.cus.sjcjjzprice.value=	  document.cus.cjjzprice.value;
	 
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
document.cus.Adicprice.value=parseFloat(document.cus.dicprice.value);//+parseFloat(document.cus.tai_area_sumprice.value);
   if (st.indexOf("��")>=0)
     document.cus.ajtxdate.value=datestr.substring(datestr.indexOf(".")+1,datestr.indexOf("g"));
   else
     document.cus.ajtxdate.value="";
    if (st.indexOf("��")>=0){
        var type1="0"; 
	    var year2=document.cus.ajyr.value; 
	    if (type1!=""){
          count1();
		  if (year2!="")  count();//������˸��ʽ�������¼����¹�
		   
        }
    }
 if (isNaN(document.cus.qydate.value))
   {
    if (confirm("ǩԼ���������ǹ̶�������"))document.cus.gddate.checked=true;
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
			   if (isNaN(dic_arr[dd])){alert("�ۿ�������");document.cus.abcd.focus();return false;}
			 if (parseFloat(dic_arr[dd])<=0){alert("�ۿ�������");document.cus.abcd.focus();return false;}
	   	   }
		  <%if (discType.equals("0")){ %>
	  //�Խ��������ۿ�
	   if (parseInt(document.cus.jzunitprice.value)>0)
	   { 
	   	   //�Խ��������   
              var yjzunit=document.cus.cjjzprice.value;    
			  document.cus.cjjzprice.value=subs1(parseFloat(document.cus.cjjzprice.value)*1.0*eval(document.cus.abcd.value)/disn*1.0,<%=sumlen %>);
	 		  document.cus.cjtnprice.value= subs1(parseFloat(yjzunit)*1.0*eval(document.cus.abcd.value)/disn*1.0*parseFloat(document.cus.jzarea.value)/parseFloat(document.cus.area.value),<%=unitlen%>);
               document.cus.dicprice.value=subs1(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value),<%=sumlen %>);
          
	      }
	   
	   <%}else{ //��Ԥ���ܼ۽����ۿۼ���%>
	    if (parseInt(document.cus.sumprice.value)>0)
	   { 
	   
	   document.cus.dicprice.value=subs1(parseFloat(document.cus.dicprice.value)*1.0*eval(document.cus.abcd.value)/disn*1.0,<%=sumlen %>) ;
	    document.cus.cjtnprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.area.value),<%=unitlen %>);
       document.cus.cjjzprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.jzarea.value),<%=unitlen %>);
   
	   }
	   
	   <%} %>
	   	  <%if (salepricecounttype.equals("1")){ %> 
	          document.cus.dicprice.value=subs1(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value),<%=sumlen %>);
              <%} %>
	    }else{
	
	 document.cus.dicprice.value=def_Value;
	 document.cus.cjtnprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.area.value),<%=unitlen %>);
     document.cus.cjjzprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.jzarea.value),<%=unitlen %>);
       <%if (salepricecounttype.equals("1")){ %> 
	  document.cus.dicprice.value=subs1(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value),<%=sumlen %>);
    <%} %>
     
	}
	     //document.cus.ewyh.value=""; 
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
			   if (isNaN(dic_arr[dd])){alert("�ۿ�������");document.cus.abcd.focus();return false;}
			 if (parseFloat(dic_arr[dd])<=0){alert("�ۿ�������");document.cus.abcd.focus();return false;}
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
  if (varstr.indexOf("��")>=0){
     document.cus.ajyr.disabled=false;
	 document.cus.ajbk.disabled=false;
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
	  document.cus.ajcs.value="";
	  document.cus.firstMoney.value="0"
	  document.cus.MonthMoney.value="0"
	  
   }
}
function FindOption(){

openwin("FindCustomer.jsp?section="+document.cus.section.value+"&FindCus=",400,380,300,100);  //+document.cus.cusname1.value
 }
 
function FindOption1(){

openwin("FindMeber.jsp?section="+document.cus.section.value+"&FindCus=",400,380,300,100);  //+document.cus.cusname1.value
 }
 function show(){
   
  var pay=document.cus.pay.value;
  var dicprice=document.cus.dicprice.value;
  var year1=document.cus.Date1.value;//.options[0].text;
  if (year1==""){alert("��ѡ�����Ϲ�����");return;}
  var ajyr=document.cus.ajyr.options[document.cus.ajyr.selectedIndex].text;
  var ajcs=document.cus.ajcs.options[document.cus.ajcs.selectedIndex].text;
  var ajmoney=document.cus.ajmoney.value;
   if (pay.indexOf("��")>=0){
    if (ajyr==""&&ajcs==""){alert("����ǰ��Ҹ����ѡ�񰴽����ޡ��������С����Ҳ���");return false;}
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
  //����ƽ���׽��ۺ���ܼ�
   var changes= document.cus.oneprice.value;
   var area=document.cus.area.value;
   var sumpri=document.cus.sumprice.value
   if (changes==""){alert("������ƽ���׽��۽����");return false;}
   document.cus.hisumprice.value=parseFloat(document.cus.hisumprice.value)-parseFloat(document.cus.area.value)*parseInt(document.cus.oneprice.value);
 
 }
  function ajm(){
   var price="";
   var ajm="";
   var ajcs="";
   if (document.cus.ajcs.options[document.cus.ajcs.selectedIndex].text!=""){
   price=document.cus.dicprice.value;
   price=parseInt(parseFloat(price)/<%=ajkw%>*(10-parseFloat(document.cus.ajcs.options[document.cus.ajcs.selectedIndex].text))/10)*<%=ajkw%>;
   document.cus.ajmoney.value=price;
   document.cus.sydk.value= document.cus.ajmoney.value;
  }else{ document.cus.ajmoney.value="0";document.cus.sydk.value= document.cus.ajmoney.value;} 
 }
 function chang(){
   var note1=document.cus.youhui.value;
   
   if( document.cus.largees.selectedIndex == 0 ) {
        return false ;
   }

   if (note1=="")
      note1=document.cus.largees.options[document.cus.largees.selectedIndex].text;
   else  	  
    note1=note1+"��"+document.cus.largees.options[document.cus.largees.selectedIndex].text;
    document.cus.youhui.value=note1;
 }

 function CurrRa(){
 //����ת��
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
 //���㱣�շ�
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
	
   //if (document.cus.dicprice.value!=""&&document.cus.abcd.value!="")disc();
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
   document.cus.sydk.value= document.cus.ajmoney.value;
   var ws=String(parseInt(document.cus.ajmoney.value)/<%=ajkw %>);
    if (ws.indexOf(".")>0){
   ws=ws.substring(ws.indexOf(".")+1);
   if (parseInt(ws)>0){if (confirm("���ҿ�ֻ��������Ϊ��λ���Ƿ�ת����")){
   document.cus.ajmoney.value=parseInt(parseInt(document.cus.ajmoney.value)/<%=ajkw %>)*<%=ajkw %>;
   document.cus.sydk.value= document.cus.ajmoney.value;
   document.cus.firstMoney.value=subs1(parseFloat(document.cus.dicprice.value)-parseFloat(document.cus.ajmoney.value),<%=unitlen %>);
  }
  }
   }
  document.cus.firstMoney.value=subs1(parseFloat(document.cus.dicprice.value)-parseInt(document.cus.ajmoney.value),<%=unitlen %>);
   document.cus.firstMoney.value=Math.round(parseFloat(document.cus.firstMoney.value)*<%=unitlen1%>)/<%=unitlen1%>;
   document.cus.ajcs.value=subs1(parseInt(document.cus.ajmoney.value)/parseFloat(document.cus.dicprice.value)*100,1);

 if (parseFloat(document.cus.ajcs.value)>80){alert("���ҳ�������8��");}
  }
var ValuePrice="";
function count5(){
charges();//�����ʽ���ۿ�
  if (document.cus.abcd){
   if (document.cus.abcd.value!=""){
count3();//�����ۿ�
}
}
//�����Ż�...
 
   if (document.cus.ewyh.value!=""){
     document.cus.dicprice.value=parseFloat(document.cus.dicprice.value)-parseInt(document.cus.ewyh.value);
     if (document.cus.pay.value.indexOf("��")>=0){
    document.cus.firstMoney.value=subs1(parseFloat(document.cus.firstMoney.value)-parseInt(document.cus.ewyh.value),<%=unitlen %>);
     }
     } 
   
     document.cus.cjtnprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.area.value),<%=unitlen %>);
     document.cus.cjjzprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.jzarea.value),<%=unitlen %>);
     document.cus.cjtnprice.value=subs1(document.cus.cjtnprice.value,<%=unitlen %>) ;
  	 document.cus.cjjzprice.value=subs1(document.cus.cjjzprice.value,<%=unitlen %>) ;
	// alert(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value));
	 <%if (salepricecounttype.equals("1")){ %> 
	  document.cus.dicprice.value=subs1(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value),<%=sumlen %>);
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
    alert("���Ҳ���������8��!");
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
  
 if (document.cus.firstmoney.value==""){return false;}
check(para);
if (document.cus.ajmoney.value!=""&&document.cus.ajmoney.value!="0"){
document.cus.factprice.value=subs1(parseFloat(document.cus.dicprice.value)-parseInt(document.cus.firstmoney.value),<%=unitlen %>);
document.cus.firstMoney.value=subs1(parseFloat(document.cus.dicprice.value)-parseInt(document.cus.ajmoney.value),<%=unitlen %>);
document.cus.firstMoney.value=subs1(parseFloat(document.cus.firstMoney.value)-parseInt(document.cus.firstmoney.value),<%=unitlen %>);
}else if (document.cus.firstMoney.value==""){

document.cus.factprice.value=parseInt(document.cus.dicprice.value)-parseInt(document.cus.firstmoney.value);
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


 
  function fullData(){
  document.cus.dicprice.defaultValue="<%=youhuiprice %>";
   setSelectMad(document.cus.counttype,"<%=count_type %>");

     setSelectMad3(document.cus.pay,"<%=payment.substring(0,payment.indexOf("."))%>");//+"��*"+disc1+"��" 
   <%if (payment.indexOf("��")>=0){ %>
   	 //document.cus.fkc.disabled=false;
	 //document.cus.ajc.disabled=false;
	 document.cus.ajbk.disabled=false;
   <%}else{ %>
   	 //document.cus.fkc.disabled=true;
	// document.cus.ajc.disabled=true;
 	 document.cus.ajbk.disabled=true;
   <%} %> 
   setSelectMad(document.cus.custype,"<%=custype %>");
   setSelectMad(document.cus.httype,"<%=httype %>");
   setSelectMad(document.cus.ajyr,"<%=ajyr %>");
   setSelectMad(document.cus.curry,"<%=curry %>");
   if (document.cus.ajbk)
   setSelectMad(document.cus.ajbk,"<%=ajbk %>");
     if (document.cus.bx)
   setSelectMad(document.cus.bx,"<%=StrBxState %>");
    if (document.cus.gz)
   setSelectMad(document.cus.gz,"<%=StrGzState %>");
   <%//} %>
    setSelectMad(document.cus.rh,"<%=rh %>");
	 setSelectMad(document.cus.gjjy,"<%=gjjy %>");
	  setSelectMad(document.cus.ajbk,"<%=ajbk %>");
} 
 var counterAjMoney="0";
     function ykj_count(){
	   <%if (Cortrol.indexOf("C")==-1){ %>
    if (!document.cus.bz.checked&&parseInt(document.cus.dicprice.value)>0){
	<%} %> 
     
      char=document.cus.dicprice.value;
	  document.cus.cjtnprice.value=subs1(parseFloat(char)/parseFloat(document.cus.area.value),<%=unitlen %>);
      document.cus.cjtnprice.value=subs1(document.cus.cjtnprice.value,<%=unitlen %>);
	  document.cus.sjcjtnprice.value= document.cus.cjtnprice.value;
	  document.cus.cjjzprice.value=subs1(parseFloat(char)/parseFloat(document.cus.jzarea.value),<%=unitlen %>);
	  document.cus.cjjzprice.value=subs1(document.cus.cjjzprice.value,<%=unitlen %>);
	  document.cus.sjcjjzprice.value=	  document.cus.cjjzprice.value;
	
	
	 <%if (Cortrol.indexOf("C")==-1){ %>
	}
  <%} %> 
  //count1();
  }

    </script>
<script> 
function tfo(){	
    window.location="TFRecordInput.jsp?code=<%=code %>";

   <%String pay1=payment;
     if (pay1.indexOf("��")>0)pay1=pay1.substring(0,pay1.indexOf("��")+1);
   
    %>
     }


  function RList(){
		   openwin("RoomCodeShow2.jsp?secno=<%=secno %>",500,450,100,10);
    }
	 function checkdisc(para){
	    var discC=parseFloat(<%=(String)session.getAttribute("disc") %>);
		if  (para>discC){alert("�ۿ����󣬿�������û�д�Ȩ�޵��ۿ�");document.cus.disc.focus();return false;}
	   return true;
	 }

	function SaveContract(){
	//if (document.cus.dis){
	 // if (checkdisc(document.cus.dis.value)){alert("�ۿ����󣬿�������û�д�Ȩ�޵��ۿ�");document.cus.dis.focus();return false;}
    //}
	 if (isNaN(document.cus.qydate.value))
         document.cus.gddate.value="1";
	 
    if (document.cus.Date1.value!="" &&document.cus.QYDate.value!=""){
      if (document.cus.Date1.value>document.cus.QYDate.value){
          alert("�Ϲ����ڲ��ܴ���ǩԼ����");
           return false;

      }
    }
     if (document.cus.ajDate.value!="" &&document.cus.QYDate.value!=""){
      if (document.cus.ajDate.value<document.cus.QYDate.value){
          alert("ǩԼ���ڲ��ܴ��ڰ�������");
           return false;

      }
    }
 if (document.cus.fkDate.value!="" &&document.cus.ajDate.value!=""){
      if (document.cus.fkDate.value<document.cus.ajDate.value){
          alert("�������ڲ��ܴ��ڷſ�����");
           return false;

      }
    }
  if (document.cus.constractno.value!=""){
      if (document.cus.QYDate.value==""){
          alert("ǩԼ���ڲ���Ϊ��");
           return false;

      }
    }	
if (document.cus.pay.value.length<1)
		{
	        alert("��ѡ��ͻ��ĸ��ʽ!");
	        document.cus.pay.focus();
	        return false;
		}	
if (document.cus.memberT.checked&&document.cus.memberNO.value==""){
	   alert("����д���ܵ�ҵ�����ڵ�Ԫ");
	   document.cus.memberNO.focus();
	   return false;
	 
	 }
	   if (!document.cus.memberT.checked&&document.cus.memberNO.value!=""){
	   alert("��ѡ��ҵ������ѡ��ͻ�Ϊҵ������");
	   document.cus.memberNO.focus();
	   return false;
	 
	 }
 if (document.cus.editnow.value=="2"&&document.cus.zmdate.value==""){
	  alert("��ѡ��ͻ�ת������");
	 return false;
	 }
	  if (document.cus.editnow.value=="2"&&document.cus.zmyy.value==""){
	  alert("��¼��ͻ�ת��ԭ��");
	  document.cus.zmyy.focus();
	 return false;
	 }
 
 
 
if (confirm("ȷ�ϱ��浱ǰ������"))	
 { document.cus.submit1.disabled=true;
 document.cus.action="ModiContract.jsp";
  document.cus.submit();
  }
  }

  function countAge(){

  var cardidS=document.cus.carid.value;
  var cardidSS=cardidS;
  var currDat=new Date();  
  var year=currDat.getYear();
  document.cus.age.value="";

  var ages="";
  if (cardidS!=""){	
   var arry=cardidS.split("/");//ת��Ϊarry
	for (var jj=0;jj<arry.length;jj++){
	  if (!isNaN(arry[jj])){
		  if (ages=="")
		   { 
		    if (arry[jj].length==18)
		      // ages=String(parseInt(year)-parseInt(arry[jj].substring(6,10)));
			  ages="19"+arry[jj].substring(6,12);
		    else if (arry[jj].length==15)
		       ages="19"+arry[jj].substring(6,10);
			else{ alert("��Щ���֤��λ������,ϵͳֻ������ȷ���������");} 
		   }
		  else
		    {
			if (arry[jj].length==18)
		       ages+="/"+"19"+arry[jj].substring(6,12);
		    else if (arry[jj].length==15)
		       ages+="/"+"19"+arry[jj].substring(6,10);
			else {alert("��Щ���֤��λ������,ϵͳֻ������ȷ���������"); }
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

   if (para=="�����ۿ�"&&para2=="�ܼ�"){//�ܼ۶����ۿ�
      document.cus.dicprice.value=subs1(parseFloat(document.cus.dicprice.value)*1.0*parseFloat(para1)/100.0,<%=sumlen %>);
	    if (parseFloat(document.cus.area.value)>0)
      document.cus.cjtnprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.area.value),<%=unitlen %>);
      document.cus.cjjzprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.jzarea.value),<%=unitlen %>);
   
	   <%if (salepricecounttype.equals("1")){ %> 
	    document.cus.dicprice.value=subs1(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value),<%=sumlen %>);
       <%} %>
   }else if (para=="�����Ż�"&&para2=="�ܼ�"){//�����Ż�
         document.cus.dicprice.value=subs1(parseFloat(document.cus.dicprice.value)-parseFloat(para1),<%=sumlen %>);
	 
       //  document.cus.dicprice.value=subs1(parseFloat(document.cus.dicprice.value)*parseFloat(para1),<%=sumlen %>);
	     if (parseFloat(document.cus.area.value)>0)
         document.cus.cjtnprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.area.value),<%=unitlen %>);
         document.cus.cjjzprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.jzarea.value),<%=unitlen %>);
      
	   <%if (salepricecounttype.equals("1")){ %> 
	     document.cus.dicprice.value=subs1(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value),<%=sumlen %>);
       <%} %>
  }else if (para=="�����ۿ�"&&para2=="��������"){//���۶����Ż�
        var aaaa=subs1(parseFloat(document.cus.cjjzprice.value)*parseFloat(para1)/100.0,<%=unitlen %>);
        document.cus.cjjzprice.value=aaaa;
	    document.cus.dicprice.value=subs1(parseFloat(document.cus.jzarea.value)*parseFloat(aaaa),<%=sumlen %>);
		  if (parseFloat(document.cus.area.value)>0)
        document.cus.cjtnprice.value=subs1(parseFloat(document.cus.dicprice.value)/parseFloat(document.cus.area.value),<%=unitlen %>);
          
		<%if (salepricecounttype.equals("1")){ %> 
	     document.cus.dicprice.value=subs1(parseFloat(document.cus.cjtnprice.value)*parseFloat(document.cus.area.value),<%=sumlen %>);
       <%} %>
  }else if (para=="�����Ż�"&&para2=="��������"){//�����Ż�
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
	changeFirstMoney();
	 
}
function changeFirstMoney(){
 
 if (parseFloat(document.cus.oldfirstMoney.value)!=parseFloat(document.cus.firstMoney.value))	{
       document.cus.modijh.checked=true;
	   document.cus.moditax.checked=true;
	   document.cus.modip.checked=true;
	   
}else{
        document.cus.modijh.checked=false;
	   document.cus.moditax.checked=false;
	   document.cus.modip.checked=false;
  
}
}
</script>