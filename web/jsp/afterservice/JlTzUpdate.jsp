<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

</head>
<%@ page contentType="text/html;charset=GBK" %>

  <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <%@ include file="../public_js/getByteOut.jsp"%>
   <%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "交楼管理" , 
                  "交楼通知"
                ) ;
%>
<body bgcolor="#FFFFFF" text="#000000">
<%
	
	String saleId = China.getParameter(request, "SaleId") ;
	String handler = China.getParameter(request, "handler") ;
	String code = China.getParameter(request, "code") ;
	String notifyDate = China.getParameter(request, "NotifyDate") ;

	
	String getSale = "update    Order_Contract set jl_notie =1 where " + 
					" code in( " + code+")" ;
	 
				aBean.executeUpdate(getSale);
			  
	 
%>
<script>
 
	opener.document.cus.submit();
	window.close() ;
</script>
</body>
</html>
