function Validate(aForm)
   {
  
      
		if (aForm.BeginF.value.length<1)
	    	{
	    	alert("请输入起始楼层！");
	        aForm.BeginF.focus();
	        return (false);
	    	}		
		
	   if (aForm.BeginR.value.length<1)
	    	{
	    	alert("请输入起始房号！");
	        aForm.BeginF.focus();
	        return (false);
	    	}		
	  	  
      return (true);		
	}	
function check(aa,para){
   var a1=aa.value;
   if (para=="A"){
    if (parseInt(a1)>parseInt(document.cus.intEndF.value))
	{
	  alert("楼层数不能超过"+document.cus.intEndF.value);
	  document.cus.BeginF.value="";
	}
	}else{
	 
	  if (parseInt(a1)>parseInt(document.cus.intEndR.value))
	{
	  alert("房号数不能超过"+document.cus.intEndR.value);
	  document.cus.BeginR.value="";
	}
	
	}
  }  
function toUpper(aa){
    var a=aa.value;
	if (a!=""){
	var upp="ABCDEFGHIJKO";
    aa.value=a.toUpperCase();

	 if (aa.name=="EndR"){
	 if (isNaN(a)&&(upp.indexOf(document.cus.BeginR.value)<0||upp.indexOf(document.cus.EndR.value)<0)){
	    alert("如果是以字母来编码，只能在A--O");
	    aa.focus();
		aa.select();
	    return false;
	 }
	 }
	} 
  }
   function SaveRoomCode(strurl){
    if (Validate(document.cus))
	{document.cus.action=strurl;
	 check();
	// document.cus.submit();
     }
   }