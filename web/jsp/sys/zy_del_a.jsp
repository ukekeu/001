<%@ page import = "java.sql.*" contentType="text/html;charset=GBK" %>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "组成员操作" , 
                  "删除"
                ) ;
%>

<%
	String arr[] = request.getParameterValues( "s2" );
	String stid = request.getParameter("tid");
	
	boolean succ = true;
	for( int i = 0 ; i < arr.length ; i ++ ) {
		String sql = "delete from teaman where tid = " + stid + " and "
		            + " mid = " + arr[i];
		int temp = 0 ;
		try{
			temp = aBean.executeUpdate(sql);
		}catch(Exception es ){
			es.printStackTrace();
		}
		
		if( temp == 0 ) {
			succ = false ;
		}
	}
	response.sendRedirect( "zhuyuang.jsp?delete=" + succ );
%>



