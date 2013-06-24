
<SCRIPT language=javascript>

  function Validate(aForm)
   {
   
    if (parseFloat(aForm.Area.value)==0){
    alert("请录入房间的建筑面积");
	aForm.Area.focus();
	return false;
   
   }
   if (parseFloat(aForm.UsedArea.value)==0){
    alert("请录入房间的使用面积");
	aForm.UsedArea.focus();
	return false;
   
   }
   
   if (aForm.FirstRoom.value==""||aForm.EndRoom.value==""){
     alert("请选择起始房号");
	 return false;
   
   }
	if (aForm.FirstFloor.value=="")
		{
	        alert("请选择起始楼层值！");
	        aForm.FirstFloor.focus();
	        return false;
		}
		if (parseInt(aForm.EndFloor.value)<parseInt(aForm.FirstFloor.value))
		{
	        alert("请选择最大楼层值！");
	        aForm.EndFloor.focus();
	        return false;
		}
		
	    return (true);
   }
function charges(){
   
        if( parseInt( document.forms[0].JZAreaUnitPrice.value ) < 0 ) {
            alert("请输入有效单价!");
            document.forms[0].JZAreaUnitPrice.focus();
            return false;
        }
        if (document.cus.JZAreaUnitPrice.value=="0"||document.cus.Area.value=="0")return false;
	document.forms[0].SumPrice.value=subs1(parseFloat(document.cus.Area.value)*parseFloat(document.cus.JZAreaUnitPrice.value),2);	
   if (parseFloat(document.forms[0].UsedArea.value)>0)	
    document.cus.TNAreaUnitPrice.value=parseFloat(document.forms[0].SumPrice.value)/parseFloat(document.forms[0].UsedArea.value);
	document.cus.TNAreaUnitPrice.value=subs1(document.cus.TNAreaUnitPrice.value,2);
	 
   }
   
 function charges2(){
<%if (price_type.equals("0")) { %>
   if (parseInt(document.forms[0].SumPrice.value)<=0)return false; 
   if (parseFloat(document.forms[0].Area.value)<=0)return false; document.cus.JZAreaUnitPrice.value=subs1(parseFloat(document.forms[0].SumPrice.value)/parseFloat(document.forms[0].Area.value),2);
	document.cus.JZAreaUnitPrice.value=subs1(document.cus.JZAreaUnitPrice.value,2);
 <%} %>	 
 <%if (price_type.equals("1")) { %>
 document.forms[0].SumPrice.value=subs1(parseFloat(document.cus.JZAreaUnitPrice.value)*parseFloat(document.forms[0].Area.value),2);
 <%} %>
 <%if (price_type.equals("2")) { %>
 document.forms[0].SumPrice.value=subs1(parseFloat(document.cus.TNAreaUnitPrice.value)*parseFloat(document.forms[0].UsedArea.value),2);
 <%} %>
   }
   
   
 function blur_TNAreaUnitPrice() 
 {  
 
        if( parseInt( document.forms[0].UsedArea.value ) < 0 ) {
            alert("请输入有效套内面积!");
            document.forms[0].UsedArea.focus();
            return false;
        }
        if (document.cus.UsedArea.value=="0")return false;
		<%if (price_type.equals("2")) { %>
	  document.cus.SumPrice.value=subs1(parseFloat(document.forms[0].TNAreaUnitPrice.value)*parseFloat(document.forms[0].UsedArea.value),2);
	  
	
    <%}else if (price_type.equals("1")) { %>
	
	 document.cus.TNAreaUnitPrice.value=parseFloat( document.cus.SumPrice.value)/parseFloat(document.forms[0].UsedArea.value);
	 document.cus.TNAreaUnitPrice.value=subs1(document.cus.TNAreaUnitPrice.value,2);
	 <%} %>
	 
	 
 }
   
  function charges1(){

   if (document.cus.SumPrice.value=="0"||document.cus.UsedArea.value=="0"){
    // alert("请先输入套内面积及总价");
    // cus.Area.focus();
     return (false);
     }
  
   
   var char=parseFloat(document.cus.SumPrice.value)/parseFloat(document.cus.UsedArea.value);
     
    document.cus.TNAreaUnitPrice.value=subs1(char,2);
   }
 function FTAREA(){
    if (document.cus.UsedArea.value==""||document.cus.Area.value==""){
     alert("请先输入建筑面积及分摊面积");
     cus.UsedArea.focus();
     return (false);
     } 

  var area=parseFloat(document.cus.Area.value)-parseFloat(document.cus.UsedArea.value);
      
    document.cus.Apportion.value=subs1(area,2);
     
<%if (price_type.equals("1")) { %>
	if (parseFloat( document.cus.SumPrice.value)>0)
	 document.cus.TNAreaUnitPrice.value=Math.round((parseFloat( document.cus.SumPrice.value)/parseFloat(document.forms[0].UsedArea.value))*100)/100;
	 <%} %> 
 }
  function toUpper(aa){
    var a=aa.value;
    aa.value=a.toUpperCase();
  }
   function setfocus()
   {
   		cus.SumPrice.focus();
   }
  function show(para){
    openwin1("show_fiment.jsp?zx="+para,390,300,150,150);
  }
  
</SCRIPT>