<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>

<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>

<body><%@ page language="java" import="com.jspsmart.upload.*,java.sql.*"%>
 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%
	String id=request.getParameter("id");
	try{
     InsertBean.executeUpdate("insert into my_knowledge select type,title,text,adjunct,'"+(String )session.getAttribute( "loginname")+"',register_date,0,0 from knowledge_data where id="+id);
	 %>
	 
	<script>
	  alert("系统已接受信息!");opener.window.location="knowledge_view.jsp";
	  
	  close();
	</script> 
<%
	}
   catch(SQLException ex){
	 out.print("系统出错，请检查你的数据是否正确");
	 out.print(ex.getMessage());
	 out.close();
	}

%>

</body>
</html>
