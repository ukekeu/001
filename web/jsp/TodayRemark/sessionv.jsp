
 <jsp:useBean id="setpro" scope="session" class="setProperty.setProperty"/> 
<%@ include file="../public_js/checktime.jsp"%>
<%
	String user = setpro.getId();
	if (user==null) {
%> 
	   ���ѳ�ʱ,<a href="../default.htm" target="_blank">�����µ�¼</a> 
<%     
           out.close();
	}		
%>