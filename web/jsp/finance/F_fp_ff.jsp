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
<title>��Ʊ�Ǽ�</title>

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
	    	alert("�����뷢Ʊ��ţ�");
	        aForm.No.focus();
	        return (false);
	    	}
		
	    if (aForm.Date1.value.length<1)
	    	{
	    	alert("���������ڣ�");
	        aForm.Date1.focus();
	        return (false);
	    	}		
		if (aForm.FactMoney.value.length<1)
	    	{
	    	alert("�����뷢Ʊ��");
	        aForm.FactMoney.focus();
	        return (false);
	    	}		
		if(isNaN(aForm.FactMoney.value)){
			alert("�����������֣�");
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
   String SQL="update F_invoice set state=0";
   SQL+=" WHERE order_contract="+contractno;
   ViewBean.executeUpdate(SQL);
%>
<script>
alert("�ѻָ�");
opener.window.location.reload();
window.close();

</script>

 
  
   
       
       
</body>       
</html>       
