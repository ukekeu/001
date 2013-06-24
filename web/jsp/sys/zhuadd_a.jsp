<%@ page import = "java.sql.*" contentType="text/html;charset=GBK" %>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "组操作" , 
                  "增加"
                ) ;
%>

<%
	String tname = getbyte1( request.getParameter("in1") );
	String towner = "steven"; 
	boolean succ = true;
	String sql = "insert into team( tname,towner ) values('" + tname + "','" + towner +"')";
	int temp = aBean.executeUpdate(sql);
	if( temp <= 0 ){
		succ = false;
	}
	out.println("<SCRIPT LANGUAGE=JAVASCRIPT>");
	out.println("alert('添加组成功！！');"); 
	out.println("window.opener.location.reload();");
	out.println("window.close();");
	out.println("</SCRIPT>");
%>


