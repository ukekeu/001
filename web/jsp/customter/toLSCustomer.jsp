<%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>תΪ��ʧ�ͻ�</title>
</head>

<body>
 <%@ page language="java" import="java.sql.*"%>
  <%@ include file="../public_js/getByteOut.jsp"%>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <%
 try{
	 String customer=getbyte1(request.getParameter("cusno"));	 
	 String SQL="update customer set state=1 where SerialNo in ("+customer+")";
	 ViewBean1.executeUpdate(SQL);
 
  } catch (Exception e) { 
		out.println(e.toString());
		out.close();
}
	
%>
<SCRIPT>opener.document.forms[0].submit();window.close();</SCRIPT>
</body>
</html>
 