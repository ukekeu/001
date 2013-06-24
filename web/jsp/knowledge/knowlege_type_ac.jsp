<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%	
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "文档管理" , 
                  "增加"
                ) ;
			
%>
<html>

<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>

<body>
 <%@ page language="java" import="java.sql.*,common.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%
 
    String name=China.getParameter(request,"name");
   
	
	String handler=China.getParameter(request,"handler");
	String typestate=China.getParameter(request,"typestate");
	String date=request.getParameter("date");
	String  sql="";
	
	sql="insert into knowledge_type(type,user_id,typestate)"; 
	sql=sql+" values('"+name+"','"+handler+"',"+typestate+")";
	try{
     InsertBean.executeUpdate(sql);
	 %>
	 
	<script>
	  alert("系统已接受 信息!");
	  opener.window.location="<%if (typestate.equals("1")){ %>info_type_view.jsp?sel=1<%}else{ %>knowledge_type_view.jsp?sel=0<%} %>&sel=<%=request.getParameter("sel") %>";
	  close();
	</script> 
<%
	}
   catch(SQLException ex){
	 out.print(sql);
	 out.print("系统出错，请检查你的数据是否正确");
	 out.print(ex.getMessage());
	 out.close();
	}

%>

</body>
</html>
