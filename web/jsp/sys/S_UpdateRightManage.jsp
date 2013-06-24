<%@ page import = "java.util.*,java.sql.*,common.*" contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />

<%@ include file="../public_js/logrecord.jsp" %>
<html>
<head>
	<title>系统管理 --> 经理管理</title>
</head>

<body>

<%
	
	String sNo = request.getParameter("id") ;
	String sSeed = China.getParameter(request, "ad" + sNo) ;

	String sUpdateStr = "update CortrolMan set state = '"+sSeed+"' where id =" + sNo   ;
	String sOperStr = "更改" ;
	String sGood = "1" ;
		try {
			
				aBean.executeUpdate(sUpdateStr) ;
				// out.print(sUpdateStr) ;
		} catch (Exception e) {
			sGood = "0" ;
			 out.print(e) ;
		}		
		
%>
<script>

	 alert("成功更改") ;
	 document.location = "sluserlist.jsp?x=" + Math.random() ;
	
</script>
</body>
</html>
