
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 
<%@ include file="../public_js/getByteOut.jsp"%>
 
<html>
<head>
	<title>导入价格</title>
</head>

<body>
<%
try{
String SecNo=getbyte1(request.getParameter("SecNo"));
String Loft=getbyte1(request.getParameter("Loft"));
String SQL="select * from room where seccode='"+SecNo+"' order by loft,floor,room";
 ViewBean1.executeUpdate("UPDATE 试算价目表 SET STATE=0 where sectionno='"+SecNo+"'");
 ResultSet rs = ViewBean.executeQuery(SQL) ;
 while (rs.next()){

String ss="insert into 试算价目表 select '开盘价格','";
			ss+=SecNo+"','"+rs.getString("loft")+"','"+rs.getString("room_code")+"',"+rs.getString("room");
			ss+=","+rs.getString("floor")+","+rs.getString("tnunitprice")+",";
			ss+=rs.getString("unitprice")+","+rs.getString("usedarea")+","+rs.getString("area");
			ss+=","+rs.getString("sumprice")+",getdate(),'"+rs.getString("yong_tu")+"',1,'"+rs.getString("building");
			ss+="','"+rs.getString("cell")+"',1,0,1";

		ViewBean1.executeUpdate(ss);
		

 }
 rs.close();
SQL="select loft from room where seccode='"+SecNo+"' group by  loft";
rs = ViewBean.executeQuery(SQL) ;
 while (rs.next()){
String ss="insert into createPricePaymentState select getdate(),'";
		ss+=SecNo+"','"+rs.getString("loft")+"'";
 
		ViewBean1.executeUpdate(ss);
 }
 rs.close();

  %>
<script>
opener.window.location="PriceProjectList.jsp?SecNo=<%=SecNo %>&Loft=<%=Loft %>";
window.close();
</script>
<%}catch(Exception e){out.print(e.getMessage());out.close();} %> 
</body>
</html>
