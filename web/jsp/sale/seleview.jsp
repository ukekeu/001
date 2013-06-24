<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<title>添加销售员</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/news.css" rel=stylesheet>
<script src="js/mad.js"> </script>
<script language="javascript" src="../public_js/public.js">
</script>

</head>

<body bgcolor="#FFFFFF" text="#000000">
<%@ page import = "java.sql.*" %>
<jsp:useBean id = "LargessBean" scope = "page" class = "ConnDatabase.SDatabase" />
<%@ include file="../public_js/getByteOut.jsp"%>
<div align="center">
<SCRIPT language=javascript>
   function Validate(aForm)
   {
      if (aForm.largessname.value.length<1)
	    	{
	    	alert("请输入赠送品名");
	        aForm.largessname.focus();
	        return (false);
	    	}	
		
	return true;		
	}	
function choose(){

if ((document.frm.sellerName.selectedIndex)>-1){
	var sellerid=document.frm.sellerName.options[document.frm.sellerName.selectedIndex].text;
	var name=document.frm.sellerName.options[document.frm.sellerName.selectedIndex].text
	if (window.opener.document.cus.seller.options[0].text==""){
    	window.opener.document.cus.seller.options[0].text=name;
		window.opener.document.cus.seller.options[0].value=sellerid;
	   window.opener.document.cus.seller.options[0].selected=true;

	}else if(window.opener.document.cus.seller.options[1].text==""){
		
     	window.opener.document.cus.seller.options[1].text=name;
		window.opener.document.cus.seller.options[1].value=sellerid
	   window.opener.document.cus.seller.options[0].selected=true;
	   window.opener.document.cus.seller.options[1].selected=true;
	}else if(window.opener.document.cus.seller.options[2].text==""){
		window.opener.document.cus.seller.options[2].text=name;
		window.opener.document.cus.seller.options[2].value=sellerid;
	    window.opener.document.cus.seller.options[0].selected=true;
	    window.opener.document.cus.seller.options[1].selected=true;
		window.opener.document.cus.seller.options[2].selected=true;
	}else if(window.opener.document.cus.seller.options[3].text==""){
		window.opener.document.cus.seller.options[3].text=name;
		window.opener.document.cus.seller.options[3].value=sellerid;
	    window.opener.document.cus.seller.options[0].selected=true;
	    window.opener.document.cus.seller.options[1].selected=true;
		window.opener.document.cus.seller.options[2].selected=true;
		window.opener.document.cus.seller.options[3].selected=true;
	}else if(window.opener.document.cus.seller.options[4].text==""){
		window.opener.document.cus.seller.options[4].text=name;
		window.opener.document.cus.seller.options[4].value=sellerid;
	    window.opener.document.cus.seller.options[0].selected=true;
	    window.opener.document.cus.seller.options[1].selected=true;
		window.opener.document.cus.seller.options[2].selected=true;
		window.opener.document.cus.seller.options[3].selected=true;
		window.opener.document.cus.seller.options[4].selected=true;
	}
}	
}
</script>	
<form name=frm method="post" action="" onsubmit="return Validate(this);">		
<%
   String sql="select seller from seller where section_no='"+request.getParameter("section")+"'";
   try{
 
     ResultSet rs=LargessBean.executeQuery(sql);
	  out.print(" <select name='sellerName' size='15'  multiple style='width: 200' onchange='choose();'>");
     while (rs.next()){
	   
	 	   String Name=getbyte(rs.getString("seller"));
       out.print("<option value='  "+Name+"'>"+Name+"</option>") ;
	  }
	  out.print("</select>");
	  rs.close();
	}catch(Exception s)   {out.println(s.getMessage());}
	

%>
<div align="center"><input type=button name=winclose value="返 回" onclick="window.close();"></div>
</form>
</div>
</body>
</html>
