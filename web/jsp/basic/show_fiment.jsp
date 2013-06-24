<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
 <%@ page import="java.sql.*,common.*" %>
 <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
 <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
	<title>ืฐะÞฯ๊ว้</title>
</head>

<body>
<% String zx=getbyte1(request.getParameter("zx"));

String SQL="SELECT BAK FROM CODE WHERE TYPE='X' and codename='"+zx+"'";
 
ResultSet rs=aBean.executeQuery(SQL);
if (rs.next()){
  zx=getbyte(rs.getString("bak"));
}
rs.close();

 %>
<table><tr><td><textarea cols="50" rows="15"><%=zx %></textarea></td></tr></table>

</body>
</html>
