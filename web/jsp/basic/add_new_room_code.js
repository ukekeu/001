function Validate(aForm)
   {
  
      
		if (aForm.BeginF.value.length<1)
	    	{
	    	alert("��������ʼ¥�㣡");
	        aForm.BeginF.focus();
	        return (false);
	    	}		
		
	   if (aForm.BeginR.value.length<1)
	    	{
	    	alert("��������ʼ���ţ�");
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
	  alert("¥�������ܳ���"+document.cus.intEndF.value);
	  document.cus.BeginF.value="";
	}
	}else{
	 
	  if (parseInt(a1)>parseInt(document.cus.intEndR.value))
	{
	  alert("���������ܳ���"+document.cus.intEndR.value);
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
	    alert("���������ĸ�����룬ֻ����A--O");
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