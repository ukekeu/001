<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<title>eWebEditor</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style>
body,td,input,textarea {font-size:9pt}
</style>

<script language=javascript>
var URLParams = new Object() ;
var aParams = document.location.search.substr(1).split('&') ;
for (i=0 ; i < aParams.length ; i++) {
	var aParam = aParams[i].split('=') ;
	URLParams[aParam[0]] = aParam[1] ;
}

URLParams["style"] = (URLParams["style"]) ? URLParams["style"].toLowerCase() : "popup";

var objField=eval("opener.document."+URLParams["form"] + "." + URLParams["field"]);

function doSave(){
	objField.value = eWebEditor1.getHTML();
	self.close();
}

function setValue(){
	try{
		if (eWebEditor1.bInitialized){
			eWebEditor1.setHTML(objField.value);
		}else{
			setTimeout("setValue();",1000);
		}
	}
	catch(e){
		setTimeout("setValue();",1000);
	}
}
</script>

</head>
<body>

<script language=javascript>

document.write ("<FORM method='POST' name='myform'>");
document.write ("<INPUT type='hidden' name='content1' value=''>");
document.write ("<IFRAME ID='eWebEditor1' src='ewebeditor.jsp?id=content1&style=" + URLParams["style"] + "' frameborder='0' scrolling='no' width='100%' height='100%'></IFRAME>");
document.write ("</FORM>");

setTimeout("setValue();",1000);

</script>

</body>
</html>