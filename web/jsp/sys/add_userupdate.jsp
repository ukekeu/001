<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>

<HTML>
<HEAD>
<TITLE>保存用户资料</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK"> 
</HEAD>
  <%@ page import="java.sql.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id='md5' scope='request' class='crypt.MD5'/>
  <%@ include file="../public_js/getByteOut.jsp"%>
  <%@ include file="../public_js/logrecord.jsp" %>
<%   
    
	String loginID = getbyte1(request.getParameter("loginID"));
	String loginName = getbyte1(request.getParameter("loginName"));
	String IN = md5.getMD5ofStr(loginID);
	String JOB = getbyte1(request.getParameter("JOB"));
	String TEL = getbyte1(request.getParameter("TEL"));
	String DEPT = getbyte1(request.getParameter("DEPT"));
	String company=getbyte1(request.getParameter("company"));
	String mac=getbyte1(request.getParameter("mac"));
	String StrSql="";		
	String StrSql1="";		
	
	StrSql1="select *  from cortrolman where SerialNo='"+loginID+"'";
	 ResultSet rs1=null;
     try {
		rs1=aBean.executeQuery(StrSql1);
      if  (rs1.next()){
	     out.print("<script>") ;
    	 out.print("alert('英文名："+loginID+"已被使用，请重新命名');") ;
		 out.print("window.history.back(1);") ;
		 out.print("</script>") ;
	  } 	
      rs1.close();
	 

	}catch(Exception ee) {out.println(ee.getMessage());return;}
	StrSql = "insert into cortrolman(SerialNo,Name,tel,job,password,DEPT,active,IN_NO,company,mac)";
	StrSql += " values('";
	StrSql += loginID + "','" + loginName+"','"+TEL + "','" + JOB + "','"+md5.getMD5ofStr(loginID)+"','"+DEPT+"',1,'"+IN+"','"+company+"','"+mac+"')";
	try {
        setlog( setlogBean , 
                          ( String )session.getAttribute( "loginid" ) ,
                          "用户管理" , 
                          "增加["+loginID+"]"
                        ) ;
		aBean.executeUpdate(StrSql);
 
		 
		out.println("<SCRIPT LANGUAGE=JAVASCRIPT>");
	    out.println("alert('用户登录的默认密码与帐号一样，用户添加成功！！');"); 
		out.println("opener.window.document.forms[0].submit();");
		out.println("window.close();");
		out.println("</SCRIPT>");
	}catch(Exception ee) {
        out.println("<SCRIPT LANGUAGE=JAVASCRIPT>");
	    out.println("alert('用户添加失败，可能ID号相同了！');"); 
		 
		out.println("</SCRIPT>");
	} 
 
	
%>
<BODY BGCOLOR="#FFFFFF" TEXT="#000000">
</BODY>
</HTML>
