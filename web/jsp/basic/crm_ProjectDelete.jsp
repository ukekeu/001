<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>ɾ��¥������</title>
</head>

<body>
 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/logrecord.jsp" %>
  <%@ include file="../public_js/getByteOut.jsp"%>
<%
 String SecNo=getbyte1(request.getParameter("SecNo"));
try{
 
  InsertBean.executeUpdate("exec delete_project '"+SecNo+"'");
  InsertBean.executeUpdate("delete TS_SERVICER where TS_SECTION='"+SecNo+"'");
  
  response.sendRedirect("crm_Project_list.jsp?param="+request.getParameter("param"));
	 
}
catch(Exception se){
 
	InsertBean.rollback();
	out.print("ϵͳ�����������£�");
	out.print(se.getMessage());
	out.close(); 
}
%><%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "¥������" , 
                  "ɾ��(¥�̱�ţ�"+SecNo+")"
                ) ;
%>
 
</body>
</html>