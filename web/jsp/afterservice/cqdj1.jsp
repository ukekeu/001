<%@ page contentType="text/html;charset=GBK" %>
<HTML>
<HEAD>
<TITLE> 交楼通知</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chamisRset=gb2312"> 
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
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
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
			alert("请输入栋号");
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
<input type=hidden name=cusno value="<%=cusno %>">

<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
  <TR> 
    <TD COLSPAN="2"> 
        <DIV ALIGN="CENTER">产权资料登记</DIV>
    </TD>
  </TR>
  <TR> 
    <TD COLSPAN="2" height=10></TD>
  </TR>
</TABLE>
  <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
    <tr bgcolor="#CFE6EB"> 
      <td width="15%"> 
        <div align="CENTER">使用开始年限</div>
      </td>
      <td width="30%" bgcolor="#e2e2e2"> 
        <div align="left"> 
		 
          <input type="text" name="s_year" size="10">
          <input type=button name=cale value=".." onClick="fPopUpCalendarDlg(s_year);return false;" title="请选择日期">
        </div>
      </td>
      <td width="15%"> 
        <div align="CENTER">使用结束年限</div>
      </td>
      <td width="30%" bgcolor="#e2e2e2"> 
        <div align="left"> 
		 
          <input type="text" name="e_year" size="10">
          <input type=button name=cale value=".." onClick="fPopUpCalendarDlg(e_year);return false;" title="请选择日期">
        </div>
      </td>
      
    </TR>
	<tr bgcolor="#CFE6EB"> 
      <td width="15%"> 
        <div align="CENTER">建筑占地面积</div>
      </td>
      <td width="30%" bgcolor="#e2e2e2"> 
        <div align="left"> 
		 
          <input type="text" name="jzarea" size="10">
        </div>
      </td>
      <td width="15%"> 
        <div align="CENTER">分摊用地面积</div>
      </td>
      <td width="30%" bgcolor="#e2e2e2"> 
        <div align="left"> 
		 
          <input type="text" name="ftarea" size="10">
          </div>
      </td>
      
    </TR>
	<tr bgcolor="#CFE6EB"> 
      <td width="15%"> 
        <div align="CENTER">房屋所有权性质</div>
      </td>
      <td width="30%" bgcolor="#e2e2e2"> 
        <div align="left"> 
		 
          <input type="text" name="fwq" size="10">
        </div>
      </td>
      <td width="15%"> 
        <div align="CENTER">土地权属性质</div>
      </td>
      <td width="30%" bgcolor="#e2e2e2"> 
        <div align="left"> 
		 
          <input type="text" name="qsxz" size="10">
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
  <%String Cortrol=(String)session.getAttribute("popedomStr"); 
   if (Cortrol==null){Cortrol="";}
    if (Cortrol.indexOf("A")>=0){ %> 
    <td>
      <div align="center">
        
		<input type="button" name="Submit3" value="添加" onclick="return AddGh()">
      </div>
    </td>
	<%} %>
    <td>
      <div align="center">
        <input type="button" name="Submit2" value="返回" onclick="window.close()">
      </div>
    </td>
  </tr>
</table>
</form>
<p>&nbsp; </p>
</BODY>
<script>
	function AddGh() {
		
		if (isNull(document.forms[0].NotifyDate, "请选择通知日期")) 
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
