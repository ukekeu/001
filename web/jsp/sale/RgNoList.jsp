<html>

 
<head>
<title>�Ϲ����б�</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script src="../sale/js/mad.js"> </script>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<script language="javascript" src="../public_js/public.js"></script>
  <%@ page contentType="text/html;charset=GBK" %>
  <%@ page import="java.sql.*,common.*" %>
  <%@ include file="../public_js/checktime.jsp"%>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <%@ include file="../public_js/getByteOut.jsp"%>     
  <%@ include file="../public_js/qx_checke.jsp"%>
  
  
 

<body>
<% 
      String SecName=China.getParameter(request,"SecName");
    String SecNo=China.getParameter(request,"SecNo");
	String Loft= China.getParameter(request, "Loft") ;
	String Build=China.getParameter(request,"Build");
 
	
 
%>
<body > 
<form name=frm method="post">
 <table width="100%" cellpadding="0" cellspacing="0" border="0"> 
<tr> <td width="100%"> <div align="center"><font size=3><b><%=SecName %>�Ϲ���һ����</b></font></div></td><td width="38%">&nbsp;</td></tr> 
</table>
 
  <% 
   String sql="SELECT *  FROM ContractNo WHERE  type=0 and section='"+SecNo+"' and state=1";
   ResultSet rs = aBean.executeQuery(sql);
   out.print(" <select name='ContractNo' size='19'  multiple style='width: 200' onchange='choose(this.value);'>");
    int ii=0;
	 out.print("<option selected></option>");
	 while (rs.next()){
	   String ContractNo=rs.getString("ContractNo");
	   if (ii==0)
       out.print("<option value='"+ContractNo+"' >"+ContractNo+"</option>") ;
	   else
	   out.print("<option value='"+ContractNo+"' >"+ContractNo+"</option>") ;
	   ii++;
	  }
	  out.print("</select>");
	  rs.close();
	 
	
 
   
 %>
  </form>
 <script>
 function choose(para){
 	 window.opener.document.cus.rgsno.value=para;
	 window.close();
   }
 
 </script> 
	  
	  
	  
</body>
</html>
