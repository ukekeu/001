<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>

<HTML>
<HEAD>
<TITLE>���Ĳ���Ա����</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK"> 
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
        setlog( setlogBean , 
                          ( String )session.getAttribute( "loginid" ) ,
                          "����Ա����" , 
                          "ɾ��"
                        ) ;
	   aBean.executeUpdate("delete cortrolman where id="+SID);
	   response.sendRedirect("cortrolman.jsp");
	   return;
	}
	String ID= getParameter(request,"ID");
	String EN = getParameter(request,"EN");
	String CN = getParameter(request,"CN");
	String JOB = getParameter(request,"JOB");
	String TEL = getParameter(request,"TEL");
	String DEPT = getParameter(request,"DEPT");
	String marginno=getParameter(request,"marginno");
	String company=getParameter(request,"company");
	String mac=getParameter(request,"mac");
	String StrSql="";		
	String StrSql1="";		
	
	StrSql1="select *  from cortrolman where SerialNo='"+EN+"'";
	 ResultSet rs1=null;
	// out.println(StrSql1);
    
		rs1=aBean.executeQuery(StrSql1);
      if  (rs1.next()){
	    if(!marginno.equals(EN)){
	     out.print("<script>") ;
    	 out.print("alert('Ӣ������"+EN+"�ѱ�ʹ�ã�����������');") ;
		 out.print("window.history.back(1);") ;
		 out.print("</script>") ;
		 }else{
	   
	StrSql = "update cortrolman set mac='"+mac+"',SerialNo='"+EN+"',Name='" + CN+"',tel='"+TEL + "',job='" + JOB + "',dept='"+DEPT+"',company='"+company+"' where ID="+ID;
	
	try {
        setlog( setlogBean , 
                          ( String )session.getAttribute( "loginid" ) ,
                          "����Ա����" , 
                          "�޸�"
                        ) ;
		aBean.executeUpdate(StrSql);
		
		StrSql ="update manage_user set username='"+EN+"',name='"+CN+"',deptid='"+DEPT+"' where username='"+marginno+"'";
		aBean.executeUpdate(StrSql);
		 
		//aBean.ShowConnNum();
		//aBean.freeCon();//free conntion
		out.println("<SCRIPT LANGUAGE=JAVASCRIPT>");
	    out.println("alert('�û��޸ĳɹ�����');"); 
		out.println("opener.window.document.forms[0].submit();");
		out.println("window.close();");
		out.println("</SCRIPT>");
	}catch(Exception ee) {
	    out.println(ee);
        out.println("<SCRIPT LANGUAGE=JAVASCRIPT>");
	    out.println("alert('�û��޸�ʧ�ܣ�����ID����ͬ�ˣ��������������ϵϵͳ����Ա��');"); 
		out.println("window.close();");
		out.println("</SCRIPT>");
	} 
	} 	
    } rs1.close();
	//if (serv.equals(""))
	//	out.print("null");
	
%>
<BODY BGCOLOR="#FFFFFF" TEXT="#000000">
</BODY>
</HTML>
