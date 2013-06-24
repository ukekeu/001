<%@ page import = "java.sql.*" contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />

<%
    String id = request.getParameter( "id" ) ;
	int rows = new Integer( request.getParameter("rows") ).intValue();	
	int a[] = new int[rows];
	String sql = "";
	String sql2 = "" ;
	boolean succ= true;	
	
	for( int i=0 ; i<rows ; i++ ){
		String mm = request.getParameter("ic" + i);
		if( mm != null ) {
			sql = "delete from ManModuleCortrol where SellerId = '" + id
			      + "' and ManModule = '" + mm + "' " ;
			//out.print( sql + "<br><br>");
			int temp = aBean.executeUpdate(sql);			
			
			sql2 = "delete from PopedomConrtrol where SellerId = '" + id 
			      + "' and ManModuleNo='" + mm + "' " ;
			//out.print( sql2 + "<br><br>");
			int temp2 = aBean.executeUpdate( sql2 );
			if( temp == 0 ) {
				succ = false;
			}
		}
	}
%>

<script lang=javascript>
    <%if( ( ( Boolean )session.getAttribute( "isZhu" ) ).booleanValue() ) {%>
        document.location = "usermodulelist.jsp?zid=" + "<%= session.getAttribute( "zid" ) %>" + "&zname=" + "<%= session.getAttribute( "zname" ) %>";
    <%}else{%>
        document.location = "usermodulelist.jsp?SerialNo=" + "<%= session.getAttribute( "SerialNo" ) %>";    
    <%}%>
</script>

