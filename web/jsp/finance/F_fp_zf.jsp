<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="mBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/news.css" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>发票登记</title>

</head>

<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>

<SCRIPT language=javascript>
function steven(){
    if ( Validate(document.cus1) ){
      //  document.cus1.action="FactGatherInsert.jsp?dsd";
        document.cus1.submit();
    }
}
     function Validate(aForm)
   {

		if (aForm.No.value.length<1)
	    	{
	    	alert("请输入发票编号！");
	        aForm.No.focus();
	        return (false);
	    	}
		
	    if (aForm.Date1.value.length<1)
	    	{
	    	alert("请输入日期！");
	        aForm.Date1.focus();
	        return (false);
	    	}		
		if (aForm.FactMoney.value.length<1)
	    	{
	    	alert("请输入发票金额！");
	        aForm.FactMoney.focus();
	        return (false);
	    	}		
		if(isNaN(aForm.FactMoney.value)){
			alert("金额必须是数字！");
	        aForm.FactMoney.focus();
	        return (false);
		}
		
 
		 
		//--Add End	
	    return (true);
   }
       
</SCRIPT>


<body onload="document.cus1.No.focus();" bgcolor="#EBEBEB">
<%
 
 String contractno=getbyte1(request.getParameter("contractno"));
   String SQL="update F_invoice set state=1";
   SQL+=" WHERE code="+contractno;
   ViewBean.executeUpdate(SQL);
%>
<script>
alert("已作废");
opener.findSub('yingshi.jsp');
window.close();

</script>

 
  
   
       
       
</body>       
</html>       
