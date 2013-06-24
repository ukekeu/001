<%@ page import="java.sql.*,java.util.*" contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "设置权限" , 
                  "删除"
                ) ;
%>

<HTML>
<HEAD>
<TITLE>Untitled Document</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK"> 
</HEAD>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<%!
public String getParameter(javax.servlet.http.HttpServletRequest request,String para)
							throws Exception  {
	String temp = "";
	temp = request.getParameter(para);
	if (temp == null)
		temp = "";
	temp = new String(temp.getBytes("ISO8859_1"),"GBK");
	return temp;	
}
%>
<%  
	String sZid = request.getParameter( "zid" );
	boolean isZhu = false;
	if( sZid != null ) {
		isZhu = true;
	}
	
	String ModuleName=request.getParameter("ModuleName");
	String SID=getParameter(request,"id");	
	String id = "-100" ;
	if( isZhu ) {
	    id = sZid ;
	}else{
	    id = SID ;
	}		

    //删除	
    String StrS = " delete from ManModuleCortrol where SellerId = '" + id + "' and "
                 + " ManModule = '" + ModuleName + "' " ;
	aBean.executeUpdate( StrS );
	
	StrS = " delete from PopedomConrtrol where SellerId ='" + id
          + "' and ManModuleNo = '" +  ModuleName + "' " ;
    aBean.executeUpdate( StrS ) ;
%>

<script>
alert("权限已删除,请继续");
window.history.back(1);
</script>
<BODY BGCOLOR="#FFFFFF" TEXT="#000000">
</BODY>
</HTML>
