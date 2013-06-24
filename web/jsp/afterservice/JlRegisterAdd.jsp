<%@ page contentType="text/html;charset=GBK" %>
<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<HEAD>
<TITLE>交楼登记</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chamisRset=gb2312"> 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language=javascript src="../sale/js/mad.js"> </script>
</script>
<script language="javascript" src="../public_js/public.js">

</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
</head>
  <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
   <jsp:useBean id="setpro" scope="session" class="setProperty.setProperty"/>   
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
 
 
<script language="javascript" src="../public_js/public.js">

</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
<body > 
<%
	
	String saleId = China.getParameter(request, "SaleId") ;
	String code= China.getParameter(request, "code") ;
	 
%>
 
<form method="post"> 

<input type=hidden name="code" value="<%= code %>" >

<p align="center" class=FontColor><b><font size=3>交楼登记</font></b></p>

  <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
    <tr bgcolor="#CFE6EB"> 
      
      <td width="17%"> 
        <div align="CENTER">交楼日期</div>
      </td>
      <td width="27%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="JlDate" size="10" onFocus="blur()" value="" >
          <input type=button name=cale value=".." onClick="fPopUpCalendarDlg(JlDate);" title="请选择日期">
        </div>
      </td> 
    </TR>
 
  </TABLE>
  

<table width="60%" border="0" align="center">
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
 
    <td>
      <div align="center">
        
		<input type="button" name="Submit3" value="提 交" onclick="return AddGh()">
      </div>
    </td>
	 
    <td>
      <div align="center">
        <input type="button" name="Submit2" value="退 出" onclick="window.close()">
      </div>
    </td>
  </tr>
</table>
</form>
<p>&nbsp; </p>
</BODY>
<script>
	function AddGh() {
		
		if (isNull(document.forms[0].JlDate, "请选择交楼日期")) 
			return false ;	
		document.forms[0].action = "JlRegisterUpdate.jsp?Operation=Insert&code=<%=code%>" ;
		document.forms[0].submit() ;
	}
	
	function SetCheck(setValue) {
		if (setValue == "1" && document.forms[0].AlertDay.value != "")
			for (i = 0; i < document.forms[0].elements.length; i++) {
				if (document.forms[0].elements[i].name == "AlertRadio" && document.forms[0].elements[i].value == setValue) {
					document.forms[0].elements[i].checked = true ;
					break ;
				}	
			}
	}
	
	function SubmitSelf() {
		document.forms[0].action = "JlRegisterAdd.jsp?code=<%=code %>&x=" + Math.random() ;
		document.forms[0].submit() ;
	}
</script>
</HTML>
