<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
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
	
	String id = SID ;
	
    //为update操作	
    StrS = " update ManModuleCortrol set Cortrol = '" + manpopedom + "' , State = '"
           + manstate + "' , section = '" + SecNos + "' where SellerId = '" +  id 
           + "' and ManModule = '" + ModuleName + "' " ;
    //out.print( StrS + "<br><br>");           	    
	aBean.executeUpdate(StrS);
		
    String sq2 = " delete from PopedomConrtrol where SellerId ='" + id
               + "' and ManModuleNo = '" +  ModuleName + "' " ;
    //out.print( sq2 + "<br><br>");               
    dBean.executeUpdate( sq2 ) ;
    
	for (int i=1;i<=Integer.parseInt(count);i++) {
		String pp=request.getParameter("popedom"+String.valueOf(i));
	 	if (pp==null)pp="";
	 	if (!pp.equals("")){
            StrS="insert into PopedomConrtrol(SellerId,ManModuleNo,ModuleNo) values(";                                
            Str2="','"+request.getParameter( "ModuleNo" + String.valueOf(i) )+"'" ;
            StrS += "'" + id + "','" + ModuleName + Str2 + ")";
            //out.print( StrS + "<br><br>");
            aBean.executeUpdate(StrS);	 	
	 	}
	}
%>

<script>

</script>

<BODY BGCOLOR="#FFFFFF" TEXT="#000000">
<script lang=javascript>
    <%if( ( ( Boolean )session.getAttribute( "isZhu" ) ).booleanValue() ) {%>
        opener.location = "usermodulelist.jsp?zid=" + "<%= session.getAttribute( "zid" ) %>" + "&zname=" + "<%= session.getAttribute( "zname" ) %>";
    <%}else{%>
        opener.location = "usermodulelist.jsp?SerialNo=" + "<%= session.getAttribute( "SerialNo" ) %>";    
    <%}%>
    window.close();
</script>
</BODY>
</HTML>
