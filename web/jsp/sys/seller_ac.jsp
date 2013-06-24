<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>

<HTML>
<HEAD>
<TITLE>　保存数据</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK"> 
</HEAD>
<script language="JavaScript" src='../public_js/public.js'></script>
  <%@ page import="java.sql.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/getByteOut.jsp"%>
<%  String id = getbyte1(request.getParameter("id"));
	String section = getbyte1(request.getParameter("section"));
	String seller_name = getbyte1(request.getParameter("name"));
	String mail = getbyte1(request.getParameter("mail"));
	String tel = getbyte1(request.getParameter("tel"));
	String code = getbyte1(request.getParameter("code"));
	String sex = getbyte1(request.getParameter("sex"));
	String StrSql="";		
	String StrSql1="";		
		
	if (id.equals("")){
	
	StrSql1="select *  from seller where seller='"+seller_name+"' and section_No='"+section+"'";
	 ResultSet rs1=null;
    try {
		rs1=aBean.executeQuery(StrSql1);
		
      if  (rs1.next()){
	
	     out.print("<script>") ;
     	out.print("alert('编号已被使用，使用销售员是:"+getbyte(rs1.getString("seller "))+"');");	 out.print("window.history.back(1);") ;
		 out.print("</script>") ;
		
	  } 	
      rs1.close();

	}catch(Exception ee) {out.println(ee.getMessage()+"error");return;}
	StrSql = "insert into seller(section_No,seller_no,seller,sex,tel,mail)";
	StrSql += " values('";
	StrSql += section + "','" + code+"','"+seller_name + "','" +sex+"','"+ tel + "','"+mail+"')";

	try {
        setlog( setlogBean , 
                          ( String )session.getAttribute( "loginid" ) ,
                          "销售员设置" , 
                          "增加"
                        ) ;
		aBean.executeUpdate(StrSql);
		
		out.println("<SCRIPT LANGUAGE=JAVASCRIPT>");
	    out.println("alert('用户添加成功！！');"); 
	    out.println("setSelectMad(opener.document.frm.section,'"+section +"');");
		out.println("opener.document.forms[0].submit();");
		out.println("window.close();");
		out.println("</SCRIPT>");
	}catch(Exception ee) {
        out.println("<SCRIPT LANGUAGE=JAVASCRIPT>");
	    out.println("alert('添加失败');"); 
		out.println("window.close();");
		out.println("</SCRIPT>");
	} 
	}else{
	  StrSql = "Update seller set  section_No='"+section+"',seller_no='"+code+"',seller='"+seller_name+"',sex='"+sex+"',tel='"+tel+"',mail='"+mail+"' where code="+id;
	try {
        setlog( setlogBean , 
                          ( String )session.getAttribute( "loginid" ) ,
                          "销售员设置" , 
                          "修改"
                        ) ;
						
		aBean.executeUpdate(StrSql);
		
		out.println("<SCRIPT LANGUAGE=JAVASCRIPT>");
	    out.println("alert('修改成功！！');"); 
		 
		out.println("setSelectMad(opener.document.frm.section,'"+section +"');");
		out.println("opener.document.forms[0].submit();");
		out.println("window.close();");
		out.println("</SCRIPT>");
	}catch(Exception ee) {
        out.println("<SCRIPT LANGUAGE=JAVASCRIPT>");
	    out.println("alert('修改失败');"); 
		out.println("window.close();");
		out.println("</SCRIPT>");
	 
	}
  }
	
%>
<BODY BGCOLOR="#FFFFFF" TEXT="#000000">
</BODY>
</HTML>
