<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
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
	   aBean.executeUpdate("delete ChangeCode where id="+SID);
	   response.sendRedirect("Changescodeset.jsp");
	   return;
	}
	String Dept = getParameter(request,"Dept");
	String ItemName = getParameter(request,"ItemName");
	String Standard = getParameter(request,"Standard");
	String Money = getParameter(request,"Money");
	String DateC = getParameter(request,"DateC");
	String state = getParameter(request,"state");
	String state1 = getParameter(request,"state1");
	String StrSql="";		
		
	StrSql = "insert into ChangeCode(Dept,Item,Standard,state1,DateC,state)";
	StrSql += " values('";
	StrSql += Dept + "','" + ItemName+"','"+Standard + "','" + state1 + "','";
    StrSql +=DateC+"',"+state+")";
	try {
		aBean.executeUpdate(StrSql);
       //   out.print(StrSql);
		out.print("�û���ӳɹ�");
		response.sendRedirect("Changescodeset.jsp");
	}catch(Exception ee) {
		out.print("�û����ʧ�ܣ�����ID����ͬ�ˣ��������������ϵϵͳ����Ա");
              out.print(ee.getMessage());   
	} 
	
	//if (serv.equals(""))
	//	out.print("null");
	
%>
<BODY BGCOLOR="#FFFFFF" TEXT="#000000">
</BODY>
</HTML>
