<%@ page import = "java.sql.*" contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />

<%
	String arr[] = request.getParameterValues( "s2" );
	String stid = request.getParameter("tid");
	String tname= request.getParameter("tname");
	boolean succ = true;
	String loupan = "" ;
	
	 
	if (arr!=null){
	for( int i = 0 ; i < arr.length ; i ++ ) {
	    loupan = loupan + arr[ i ] + "/" ;
	}
	
	if (loupan.indexOf("/")>0)loupan=loupan.substring(0,loupan.lastIndexOf("/"));
}
	String sq = " update ManModuleCortrol set section='" + loupan 
	           + "' where SellerId = '" + stid + "'" ;
 
	aBean.executeUpdate( sq ) ;	
	
	
%>
<script language=javascript>
		    alert("ÊÚÈ¨³É¹¦£¡"); 
   			var topage="loupan_i.jsp?zid=<%=stid %>&zname=<%=tname %>&x="+Math.random();
			window.location =topage;
		</script>
