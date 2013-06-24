<HTML>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<HEAD>
<TITLE>Untitled Document</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK"> 
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<script language=javascript src="js/mad.js"></script>
</HEAD>
<%@ page import = "java.sql.*" %>
  <jsp:useBean id = "aBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id='md5' scope='request' class='crypt.MD5'/>
<%@ include file="../public_js/getByteOut.jsp"%>
<BODY oncontextmenu="return false" >
<FORM NAME="aform" METHOD="post" ACTION="" onsubmit="return submitValidate()"><TABLE WIDTH="60%" BORDER="0" CELLSPACING="5" CELLPADDING="2" ALIGN="CENTER"><TR><TD COLSPAN="3">
</FORM> 
<%  String id = request.getParameter("id");
	String serialno=request.getParameter("serialno");
	String insertStr = "";
	ResultSet aRS = null;	
	if (!id.equals("")) {
		
		insertStr = "update CortrolMan set password='" + md5.getMD5ofStr(serialno) + "',IN_NO='"+md5.getMD5ofStr(serialno)+"' where id=" + id ;
out.print(insertStr);
		try {
			aBean.executeUpdate(insertStr);
            setlog( setlogBean , 
                              ( String )session.getAttribute( "loginid" ) ,
                              "修改密码" , 
                              "修改"
                            ) ;
			out.println("<SCRIPT LANGUAGE=JAVASCRIPT>");
	        out.println("alert('密码重置成功！！');"); 
		    out.println("window.opener.location.reload();");
		    out.println("window.close();");
		    out.println("</SCRIPT>");
		}catch(Exception e) {
			out.println("<SCRIPT LANGUAGE=JAVASCRIPT>");
	        out.println("alert('密码重置失败！');"); 
			out.println("window.close();");
		    out.println("</SCRIPT>");
		}
	}	
		
%>

</BODY>
</HTML>