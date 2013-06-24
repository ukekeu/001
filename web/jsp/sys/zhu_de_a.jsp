<%@ page import = "java.sql.*" contentType="text/html;charset=GBK" %>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "×é²Ù×÷" , 
                  "É¾³ý"
                ) ;
%>

<%
	int rows = new Integer( request.getParameter("rows") ).intValue();	
	int a[] = new int[rows];
	String sql = "";
	String sql2 = "" ;
	boolean succ= true;	
	
	for( int i=0 ; i<rows ; i++ ){
		String sTid = request.getParameter("ic" + i);
		if( sTid!= null ) {
			sql = "delete from team where tid = " + sTid;
			int temp = aBean.executeUpdate(sql);
			
			sql2 = "delete from teaman where tid = " + sTid;
			int temp2 = aBean.executeUpdate( sql2 );
			
			if( temp == 0 ) {
				succ = false;
			}
		}
	}	
	response.sendRedirect("zhu.jsp?delete=" + succ);
%>

