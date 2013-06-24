
 <jsp:useBean id="setpro" scope="session" class="setProperty.setProperty"/> 
<%@ include file="../public_js/checktime.jsp"%>
<%
	String user = setpro.getId();
	if (user==null) {
%> 
	   你已超时,<a href="../default.htm" target="_blank">请重新登录</a> 
<%     
           out.close();
	}		
%>