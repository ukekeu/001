<%@ page contentType="text/html;charset=gb2312" %>

<%@ include file="../public_js/logrecord.jsp" %>
<%@ include file="../public_js/getByteOut.jsp"%>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "��Ա����" , 
                  "ɾ��"
                ) ;
%>

<html>
<head>
	<title>ɾ���ͻ�</title>
</head>

<body>
 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
<%
  String sql="";
  String cusno=request.getParameter("cusno");
 String con=request.getParameter("del");

 
         sql="delete VIPCUSTOMER where code='"+cusno+"'";  
        
		 InsertBean.executeUpdate(sql);
	 

		 InsertBean.executeUpdate(sql);
		 %>
		 <script>
		 alert("��ɾ��");
	       opener.window.location.reload();
		   window.close();
		    </script>
		 
		   
</body>
</html>