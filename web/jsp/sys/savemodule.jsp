<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>

<HTML>
<HEAD>
<TITLE>Untitled Document</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK"> 
</HEAD>
  <%@ page import="java.sql.*" %>
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
<%  String SID=getParameter(request,"id");
   
    if (!(SID.equals(""))){
    setlog( setlogBean,(String)session.getAttribute("loginid" ),"模块设置","删除") ;
	   aBean.executeUpdate("delete ModuleCortrol where id="+SID);
	   response.sendRedirect("modulelist.jsp");
	   return;
	}
	String MModuleNo = getParameter(request,"MModuleNo");
	String MModuleName = getParameter(request,"MModuleName");
	String CModuleName = getParameter(request,"CModuleName");
    String ModuleUrl = getParameter(request,"ModuleUrl");
	String pc=request.getParameter("PC");
	String CModuleNo = "";
	String StrSql="";		
	String StrSql1="";		

	StrSql1="select count(*) as num,max(CModuleNo) as CModuleNo  from ModuleCortrol where MModuleNo='"+MModuleNo+"'";
	  ResultSet rs1=null;
    try {
		rs1=aBean.executeQuery(StrSql1);
      if  (rs1.next()){
	    if (rs1.getInt("num")>=1){
		CModuleNo=rs1.getString("CModuleNo");
		if (MModuleNo.length()==2)CModuleNo=CModuleNo.substring(2);
		CModuleNo=CModuleNo.substring(CModuleNo.indexOf(MModuleNo)+1);
		
		if (Integer.parseInt(CModuleNo)+1>=10)
		CModuleNo=MModuleNo+"0"+String.valueOf(Integer.parseInt(CModuleNo)+1);
		else CModuleNo=MModuleNo+"00"+String.valueOf(Integer.parseInt(CModuleNo)+1);
		}
	    else{CModuleNo=MModuleNo+"001";}
	 } 	
      rs1.close();    
	}catch(Exception ee) {out.println(ee.getMessage());	out.print(CModuleNo+StrSql1);return;}
	
	StrSql = "insert into ModuleCortrol(MModuleNo,MModuleName,CModuleNo,CModuleName,Url,NEXUS)";
	StrSql += " values('";
	StrSql += MModuleNo + "','" + MModuleName+"','"+CModuleNo + "','" + CModuleName + "','"+ModuleUrl+"','"+pc+"')";
	try {
    setlog( setlogBean,(String)session.getAttribute("loginid" ),"模块设置","增加") ;
		aBean.executeUpdate(StrSql);
	    //aBean.ShowConnNum();
		//aBean.freeCon();//free conntion

		out.print("用户添加成功");
		response.sendRedirect("moduleset.jsp");
	}catch(Exception ee) {
		out.print("用户添加失败，可能ID号相同了，请重新输入或联系系统管理员");
              out.print(ee.getMessage());   
	} 
	
	//if (serv.equals(""))
	//	out.print("null");
	
%>
<BODY BGCOLOR="#FFFFFF" TEXT="#000000">
</BODY>
</HTML>
