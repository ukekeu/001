<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "设置权限" , 
                  "增加"
                ) ;
%>
<HTML>
<HEAD>
<TITLE>Untitled Document</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK"> 
</HEAD>
  <%@ page import="java.sql.*,java.util.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="dBean" scope="page" class="ConnDatabase.SDatabase" />
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
		
    String SID=getParameter(request,"id");
    String Str1="";
    String Str2="";
    String Str3="";
	String count=request.getParameter("Count");
	String StrS="";
	String [] sectionS=request.getParameterValues("section");
	String SecNos="";
    for (int i=0;i<sectionS.length;i++){
	   if (SecNos.equals(""))	 SecNos=sectionS[i];
	   else SecNos+="/"+sectionS[i];
	}
	
	String ModuleName=request.getParameter("ModuleName");
	String manpopedom=getParameter(request,"add")+getParameter(request,"edit")+getParameter(request,"find")+getParameter(request,"dele");
	String manstate=request.getParameter("manstate");
	
	String id = "-100" ;
	if( isZhu ) {
	    id = sZid ;
	}else{
	    id = SID ;
	}	
	
	boolean mmHave = false ;
	ResultSet rsF = fBean.executeQuery 
	                ( "select * from ManModuleCortrol where SellerId = '" + id + "' and "
	                + " ManModule = '" + ModuleName + "' " ) ;
	mmHave = rsF.next() ;
	rsF.close() ;
	if( mmHave ){
	    //为update操作	
	    StrS = " update ManModuleCortrol set Cortrol = '" + manpopedom + "' , State = '"
	           + manstate + "' , section = '" + SecNos + "' where SellerId = '" +  id 
	           + "' and ManModule = '" + ModuleName + "' " ;	    
	}else{
	    //为insert操作
    	StrS="insert into ManModuleCortrol(SellerId,ManModule,Cortrol,State,section) values(";
    	StrS+="'"+ id +"','"+ModuleName+"','"+manpopedom+"','"+manstate+"','"+SecNos+"')";	    
	}	
	aBean.executeUpdate(StrS);
		
    dBean.executeUpdate
        ( " delete from PopedomConrtrol where SellerId ='" + id
        + "' and ManModuleNo = '" +  ModuleName + "' " ) ;    
    
	for (int i=1;i<=Integer.parseInt(count);i++){
		String pp=request.getParameter("popedom"+String.valueOf(i));
	 	if (pp==null)pp="";
	 	if (!pp.equals("")){
            StrS="insert into PopedomConrtrol(SellerId,ManModuleNo,ModuleNo,checked) values(";                                
            Str2="','"+request.getParameter("ModuleNo"+String.valueOf(i))+"'";	 	
            StrS+="'"+ id +"','"+ModuleName+Str2+",'"+manpopedom+"')";
            aBean.executeUpdate(StrS);	 	
	 	}
	}
	

%>

<script>
alert("系统已设置权限，请继续");
window.history.back(1);
</script>
<BODY BGCOLOR="#FFFFFF" TEXT="#000000">
</BODY>
</HTML>
