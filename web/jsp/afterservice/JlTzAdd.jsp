<%@ page contentType="text/html;charset=GBK" %>
<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<HEAD>
<TITLE> ��¥֪ͨ</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chamisRset=gb2312"> 
<link rel="stylesheet" href="../class/news.css" >
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
    <jsp:useBean id="setpro" scope="session" class="setProperty.setProperty"/>   
<%@ include file="../public_js/getByteOut.jsp"%>
<%
	
  %>

<%
	String section = "";
	section = request.getParameter("SecNo");
	
%><script>
	function submitv() {
		if (document.aform.Building.value == "") {
			alert("�����붰��");
			return false;
		}	
	}
	
function loadForm() {
	
	
		
	}

</script>
<script language="javascript" src="../public_js/public.js">

</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
<body onload="loadForm();">
<%
	String saleId = China.getParameter(request, "SaleId") ;
	String cusno = China.getParameter(request, "cusno") ;	
%>
<%!
	public String getFloat(float temp,int lens) {
		java.text.DecimalFormat df = null;
		if (lens == 4)
			df = new java.text.DecimalFormat("###.#####");
		if (lens == 2)
			df = new java.text.DecimalFormat("###,###,###.##");
		if (lens == 1)
			df = new java.text.DecimalFormat("###,###,###");	
		return df.format(temp).toString();
	}

%>
<form method="post"> 
<input type=hidden name=code value="<%=request.getParameter("code") %>">

<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
  <TR> 
    <TD COLSPAN="2"> 
        <DIV ALIGN="CENTER">��¥֪ͨ</DIV>
    </TD>
  </TR>
  <TR> 
    <TD COLSPAN="2" height=10></TD>
  </TR>
</TABLE>
  <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
    <tr bgcolor="#CFE6EB"> 
      <td width="15%"> 
        <div align="CENTER">֪ͨ����</div>
      </td>
      <td width="30%" bgcolor="#e2e2e2"> 
        <div align="left"> 
		<%
			java.sql.Timestamp ts2 = new java.sql.Timestamp(System.currentTimeMillis()) ;
			String nowDate = ts2.toString().substring(0, 10) ;
		%>
          <input type="text" name="NotifyDate" size="10" value="<%= nowDate %>" onFocus="blur()">
          <input type=button name=cale value=".." onClick="fPopUpCalendarDlg(NotifyDate);return false;" title="��ѡ������">
        </div>
      </td>
      <td width="10%"> 
        <div align="center">������</div>
      </td>
      <td width="20%" bgcolor="#e2e2e2"> 
        <div align="left"></div>
        <div align="CENTER"></div>
        <div align="left"><input type=text size=10 name=handler value="<%=session.getAttribute("loginname") %>">

        </div>
      </td>
      <%
	  	Timestamp ts = new Timestamp(System.currentTimeMillis()) ;
		String currentDate = ts.toString().substring(0, 10) ;
	  %>
    </TR>
  </TABLE>
  

<table width="60%" border="0" align="center">
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
  
    <%@ include file="../public_js/qx_checke.jsp"%>
 
    <td>
      <div align="center">
        
		<input type="button" name="Submit3" value="�� ��" onclick="return AddGh()">
      </div>
    </td>
	 
    <td>
      <div align="center">
        <input type="button" name="Submit2" value="�� ��" onclick="window.close()">
      </div>
    </td>
  </tr>
</table>
</form>
<p>&nbsp; </p>
</BODY>
<script>
	function AddGh() {
		
		if (isNull(document.forms[0].NotifyDate, "��ѡ��֪ͨ����")) 
			return false ;	
		document.forms[0].action = "JlTzUpdate.jsp?Operation=Insert&SaleId=<%= saleId %>" ;
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
</script>
</HTML>
