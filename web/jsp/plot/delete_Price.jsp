<html>

 
<head>
<title>����۸��</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script src="../sale/js/mad.js"> </script>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<script language="javascript" src="../public_js/public.js"></script>
  <%@ page contentType="text/html;charset=GBK" %>
  <%@ page import="java.sql.*,common.*" %>
  <%@ include file="../public_js/checktime.jsp"%>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id = "FormatD" scope = "page" class = "FormatData.FormatData" />
  <%@ include file="../public_js/getByteOut.jsp"%>     
  <%@ include file="../public_js/qx_checke.jsp"%>
  <%@ include file="../public_js/logrecord.jsp" %>
  
 

<body>
<% 
    String SecName=getbyte2(request.getParameter("SecName"));
    String SecNo=getbyte2(request.getParameter("SecNo"));
	String Loft= getbyte2(request.getParameter("Loft")) ;
	String payment=getbyte2(request.getParameter("payment")) ;
    String ok= getbyte1(request.getParameter("ok")); 
	 
	  String SQL="delete  �����Ŀ�� where sectionno='"+SecNo+"' and loft='"+Loft+"' and payment='"+payment+"'";
	  aBean.executeUpdate(SQL);
	   setlog( setlogBean ,  
                  ( String )session.getAttribute( "loginid" ) ,
                  "�۸񷽰�" , 
                  "ɾ��("+SecName+Loft+")"
                ) ;
%>
	<script>
    alert("ϵͳɾ���۸������!");	
	opener.window.location.reload();
  	window.close();
	</script>
 
<body >
 �� 
	  
	  
</body>
</html>
