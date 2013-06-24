<%@ page import = "java.sql.*" contentType="text/html;charset=GBK" %>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "组操作" , 
                  "修改"
                ) ;
%>
<%
	String sTid = request.getParameter("tid");
	String tname = new String ( request.getParameter("in1").getBytes("ISO8859_1") );
	boolean succ = true;
	String sql = "update team set tname = '" + tname + "' where tid = " + sTid;
	int temp = aBean.executeUpdate(sql);
	if( temp <= 0 ){
		succ = false;
	}
	out.println("<SCRIPT LANGUAGE=JAVASCRIPT>");
	out.println("alert('修改组成功！！');"); 
	out.println("window.opener.location.reload();");
	out.println("window.close();");
	out.println("</SCRIPT>");
%>

