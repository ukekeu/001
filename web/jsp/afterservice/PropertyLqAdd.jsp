<%@ page contentType="text/html;charset=GBK" %>
<HTML>
<HEAD>
<TITLE>��Ȩ��ȡ�Ǽ�</TITLE> 
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; chamisRset=gb2312"> 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
</head>
  <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
  <%@ include file="../public_js/getByteOut.jsp"%>
 

<%
	 
	String code = request.getParameter("code");
	
%>
 
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
<body  >
 
 
<form method="post"  name="frm" > 
 

<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
  <TR align="center"> 
    <TD > 
      <font size="4"> ��Ȩ��ȡ�Ǽ� </font><br><br> 
    </TD>
  </TR>
   
</TABLE>
  <table BORDER=0 width="100%" CELLSPACING=1   ALIGN=left  >
    <tr > 
	      <TD WIDTH="17%" class=roomleft>
	        &nbsp;   ��ȡ�� 
	      </TD>
	      <TD WIDTH="27%" class=roomright>
	        <input type="text" name="LqPerson"  >
	      </TD>
		    <TD WIDTH="17%" class=roomleft>
	         &nbsp;  ���֤�� 
	      </TD>
	      <TD WIDTH="27%" class=roomright>
	        <input type="text" name="lqid"  >
	      </TD>
	  </tr>
	  <tr>
	  <TD WIDTH="17%" class=roomleft>
          &nbsp;   ���Ȩ��ϵ 
      </TD>
	    <TD WIDTH="27%" class=roomright>
        <input type="text" name="gx"   >
      </TD>
      <td width="17%"class=roomleft>
           &nbsp; ��ȡ���� 
      </td>
      <td width="35%" class=roomright> 
         
          <input type="text" name="LqDate" size="10" onFocus="blur()">
          <input type=button name=cale value=".." onClick="fPopUpCalendarDlg(LqDate);return false;" title="��ѡ������">
       
      </td>
     </TR>
    <tr   > 
	 <TD WIDTH="17%" class=roomleft height="35"> 
          &nbsp;��ע 
      </TD>
      <TD  class=roomright height="35"> 
           <input type=text name=txt value="" >
       </TD>
      <TD WIDTH="17%" class=roomleft height="35"> 
         &nbsp;    ������ 
      </TD>
      <TD  class=roomright height="35"> 
           <input type=text size=10 name=handler value="<%= session.getAttribute("loginname") %>" >
       </TD>
    </TR>
	<tr><td align="center" colspan="4">  &nbsp;</td></tr>
		<tr><td align="center" colspan="4">  &nbsp;</td></tr>

	<tr><td align="center" colspan="4"> 
   <input type=hidden name=code value="<%=request.getParameter("code") %>">
		<input type="button" name="Submit3" value="��  ��" onclick="return AddGh()">
      
        <input type="button" name="Submit2" value="��  ��" onclick="window.close()">
 </td></tr>
  </TABLE>
  
 
</form>
 
</body>
<script>
	function AddGh() {
		if (isNull(document.forms[0].LqDate, "��������ȡ��")) 
			return false ;
		if (isNull(document.forms[0].LqDate, "��ȡ����")) 
			return false ;	
		if (document.forms[0].LqDate.value<"<%=request.getParameter("cq_date") %>"){
		  alert("��ȡ���ڲ���С�ڳ�֤����");return false ;	
		}
		document.forms[0].action = "PropertyLqUpdate.jsp" ;
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
