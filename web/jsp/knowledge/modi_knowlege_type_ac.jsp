<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>

<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>

<body>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ page language="java" import="java.sql.*,common.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%
 
    String id=request.getParameter("id");
   
	
	String handler=getbyte2(request.getParameter("user"));
 
	String  sql="";
	
	sql="update  knowledge_type set user_id='"+ handler+"' where id="+id;
	 
	try{
     InsertBean.executeUpdate(sql);
	 %>
	 
	<script>
	  alert("ϵͳ�ѽ��� ��Ϣ!");
	  opener.window.location="knowledge_type_view.jsp";
	  close();
	</script> 
<%
	}
   catch(SQLException ex){
	 out.print(sql);
	 out.print("ϵͳ����������������Ƿ���ȷ");
	 out.print(ex.getMessage());
	 out.close();
	}

%>

</body>
</html>
