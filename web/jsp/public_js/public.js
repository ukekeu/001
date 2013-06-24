
function changeWin(){
	if(parent.forum.cols!="10,*")
	{
		parent.forum.cols="10,*";
		document.all.menuSwitch.innerHTML="<font class=point>4</font>";
	}
	else
	{
		parent.forum.cols="140,*";
		document.all.menuSwitch.innerHTML="<font class=point>3</font>";
	}
}


function subs1(para1,para2){
      //对数字进行小数位取舍
	 // para1为数字，para2为长度
	  var varst=String(para1);
	  var len=para2;
	  var lenstr="0";
 
		 if (para2==0)
	 varst= Math.round(para1*1)/1;
	 else  if (para2==1)
	  varst= Math.round(para1*10)/10;
	 else  if (para2==2)
	  varst= Math.round(para1*100)/100;
	return varst;
	   }

var TRID="";
function Butcolo(src,clrOver,clrIn){ 
 if (TRID==""){TRID=src.id;}
 else{
    var aa=eval(""+TRID+"");
	aa.bgColor=clrIn;
	TRID=src.id;
   }
    
	if (!src.contains(event.fromElement)) { 
		src.style.cursor = 'hand'; 
		src.bgColor = clrOver; 
	}
}
//计算日期（在当前日期上加一天得出下一天的日期）
function nextWeek(daynum,currdate){
  var currdate=currdate;
  var yea=currdate.substring(0,currdate.indexOf("-"));
  currdate=currdate.substring(currdate.indexOf("-")+1);
  var mon=currdate.substring(0,currdate.indexOf("-"));
   var day=currdate.substring(currdate.indexOf("-")+1);
   
   var today=new Date(yea,mon,day);
   var todayInMS=today.getTime();
   var num="60*60*24*"+daynum+"*1000";
   var nextWeekInMS=todayInMS+eval(num);
   var month=new Date(nextWeekInMS).getMonth();
   
  if (month==0)month=12;
   if (month<12)
   yea=new Date(nextWeekInMS).getYear();
  
   return yea+"-"+month+"-"+new Date(nextWeekInMS).getDate();
}
	
function  changeclass1(src,clrOver,clrIn){ 

 if (TRID==""){TRID=src.id;}
 else{
    var aa=eval(""+TRID+"");
	aa.className=clrIn;
	TRID=src.id;

   }
   
	if (!src.contains(event.fromElement)) { 
		src.style.cursor = 'hand'; 
		src.className = clrOver; 
	}
}
function mout(src)  { 
	if (!src.contains(event.fromElement)) { 
		src.style.cursor = 'hand'; 
	}
} 
function mOvr(src,clrOver){ 
	if (!src.contains(event.fromElement)) { 
		src.style.cursor = 'hand'; 
		src.bgColor = clrOver; 
	}
}
function mOut(src,clrIn)  { 
	if (!src.contains(event.toElement)) { 
		src.style.cursor = 'default'; 
		src.bgColor = clrIn; 
	}
} 
function openwin(url,wh,hg,lf,tp) {
    var today=new Date();
 var todayInMS=today.getTime();
  var newwin=window.open(url,"newwin"+todayInMS,"toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
  newwin.focus();
  return false;
}
function openwin1(url,wh,hg,lf,tp) {
 
    var today=new Date();
 var todayInMS=today.getTime();
  var newwin=window.open(url,"newwin1"+todayInMS,"toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
  newwin.focus();
  return false;
}
function openwin3(url,wh,hg,lf,tp) {
   var today=new Date();
 var todayInMS=today.getTime();
  var newwin=window.open(url,"newwin3"+todayInMS,"toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
  newwin.focus();
  return false;
}
function openwin2(url,wh,hg,lf,tp) {
   var today=new Date();
 var todayInMS=today.getTime();
  var newwin=window.open(url,"newwin2"+todayInMS,"toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
  newwin.focus();
  return false;
}
function check(aa){
   var a1=aa.value;
   if (a1!=""){
   if (isNaN(a1)){
      alert("只能用数字表达");
	  //aa.value=0;
	   aa.focus();
	  return false;
	}else{
	 if (parseFloat(a1)<0){
	     alert("只能用正数表达");
	       
	  	  return false;
	 }
	
	} 
	 return true; 
    }
  }  
  function checkNaN(aa){
   var a1=aa.value;
  
   if (isNaN(a1)){
      alert("只能用数字表达");
	  aa.value="";
	  aa.value=0;
	  aa.focus();
	  return false;
	} else{
	 if (parseFloat(a1)<0){
	     alert("只能用正数表达");
	       
	  	  return false;
	 }
	
	} 
	 return true; 
  }  
  function toUpper(aa){
  var a=aa.value;
    aa.value=a.toUpperCase();
  }
 
function ltrim(tempStr)  {
				 var str3
				 
				 str3 = tempStr
				 if (str3 == " ") {
				 		str3 = ""
						return str3
				 }		
				 if (str3.charat(0) == " ") {
				 				
								str3 = str3.substring(1)
								str3 = ltrim(str3)
				 }
				 return str3
		 
}



function setSelectMad(selectObject,setValue)  {
		 for(var i = 0;i < selectObject.options.length;i ++) 
		 		 if (selectObject.options[i].value == setValue) {
				 	   selectObject.selectedIndex = i;
		 			break;
				 }
}

function setSelectMad1(selectObject,setValue)  {
		 for(var i = 0;i < selectObject.options.length;i ++) 
		 		 if (selectObject.options[i].text == setValue) {
				 	   selectObject.selectedIndex = i;
		 			break;
				 }
}
function setSelectMad2(selectObject,setValue)  {
		 for(var i = 0;i < selectObject.options.length;i ++) 
	
		 		 if (selectObject.options[i].value.indexOf(setValue)>=0) {
				 	   selectObject.selectedIndex = i;
		 			break;
				 }
	 
}
function setSelectMad3(selectObject,setValue)  {
		 for(var i = 0;i < selectObject.options.length;i ++) 
	         {   var aa=selectObject.options[i].text;
				aa=aa.substring(0,aa.indexOf("."));
				//if (aa.indexOf("(")>=0) 
				 
				//aa=aa.substring(0,aa.lastIndexOf("("));
				 
		 		 if (aa==setValue) {
				 	   selectObject.selectedIndex = i;
		 			break;
				 }
	   }
}
function isInteger(field,errorMessage) {
  			temp = trim(field.value);
			//alert("temp:" +temp);
			fail = true;
			for(var i = 0;i < temp.length ;i ++) {
				if (temp.charAt(i) > "9" || temp.charAt(i) <"0") {
					fail = false;
					break;
				}
			}
			if (!fail) {
				alert(errorMessage);
				field.focus();
			}
			return fail; 
		}
		
function isNull(field,errorMessage) {
	temp = trim(field.value);
	//alert("temp" + temp);
	fail = false;
	if (temp.length == 0 ) {
		fail = true;
		alert(errorMessage);
		field.focus();
	}
	return fail;
}	

function isYear(field,errorMessage) {
	temp = trim(field.value);
	if (!isInteger(field,errorMessage))
		return false;
	fail = true;
	//alert("year" + temp);
	if (temp > 2050 || temp < 1990) {
		fail = false;
		alert(errorMessage);
		field.focus();
	}
	return fail;

}

function isMonth(field,errorMessage) {
	
	temp = trim(field.value);
	if (!isInteger(field,errorMessage))
		return false;
	fail = true;
	//alert("month" + temp);
	if (temp > 12 || temp < 1) {
		fail = false;
		alert(errorMessage);
		field.focus();
	}
	return fail;
}	

function isDay(field,errorMessage) {
	temp = trim(field.value);
	if (!isInteger(field,errorMessage))
		return false;
	fail = true;
	if (temp > 31 || temp < 1) {
		fail = false;
		alert(errorMessage);
		field.focus();
	}
	return fail;
}

function isNumeric(field,errorMessage) {
	temp = trim(field.value);
	fail = true;
	if (isNaN(temp)) {
		alert(errorMessage);
		fail = false;
		field.focus();
 	}		
	return fail;	
	
}
	
function trim(temp) {
	if (temp.length == 0)  {
		//alert("a" + temp + "b");
		return temp;
	}	
	var hasChar = false;
	for(i = 0;i < temp.length ;i ++)  {
		if (temp.charAt(i) != " ") {
			hasChar = true;
			break;
		}	
	}
	if (hasChar)
		temp = temp.substring(i);
	else  {
		temp = "";
		return temp;
	}	
	//alert("ltrim:" + temp + "b");
	//return temp;
	for(j = temp.length - 1;j > - 1;j --) {
		if (temp.charAt(j) !== " ")
			break;
	}
	temp = temp.substring(0,j + 1);
	//alert("rtrim:" + temp);
	return temp;
	//alert("a" + temp + "b");*/
}	
function MM_findObj(n, d) { //v3.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document); return x;
}
function MM_showHideLayers() { //v3.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v='hide')?'hidden':v; }
    obj.visibility=v; }
}	
function detail(tmp) {
				//alert("tmp : " + tmp) ;
				//alert("divs : " + document.all.tags("DIV").length ) ;
				var divs = document.all.tags("DIV") ;
				for ( i = 0 ; i < divs.length ; i ++ ) {
					//alert("value : " + document.all.tags("DIV")[i].id) ;
					if (divs[i].id) {
						var tt = divs[i].id ;
						if (tt.indexOf("detail") > -1) {
							if (tt == "detail" + tmp) 
								document.all.tags("DIV")[i].style.display = (document.all.tags("div")[i].style.display == "block")?"none":"block" ;
							else 
								document.all.tags("DIV")[i].style.display = "none" ;
						}
					}			
				}
				
			} 	
	
	function key(para){ 

      if (event.keyCode==13){
        if (para) {
		 para.focus();
		 if (para.type=="text") para.select();
		 }
    }
	}
	
	function detail(tmp) {
				//alert("tmp : " + tmp) ;
				//alert("divs : " + document.all.tags("DIV").length ) ;
				var divs = document.all.tags("DIV") ;
				for ( i = 0 ; i < divs.length ; i ++ ) {
					//alert("value : " + document.all.tags("DIV")[i].id) ;
					if (divs[i].id) {
						var tt = divs[i].id ;
						if (tt.indexOf("detail") > -1) {
							if (tt == "detail" + tmp) 
								document.all.tags("DIV")[i].style.display = (document.all.tags("div")[i].style.display == "block")?"none":"block" ;
							else 
								document.all.tags("DIV")[i].style.display = "none" ;
						}
					}			
				}
				
			}	
              