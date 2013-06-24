<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>删除楼盘资料</title>
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
	out.print("系统出错，出错如下：");
	out.print(se.getMessage());
	out.close(); 
}
%><%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "楼盘资料" , 
                  "删除(楼盘编号："+SecNo+")"
                ) ;
%>
 
</body>
</html>