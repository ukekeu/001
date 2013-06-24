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
	
	
	
	
	
	
		