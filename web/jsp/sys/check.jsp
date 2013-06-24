<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<html>
<head>
	<title>Êý¾Ý¾À´í</title>
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<body oncontextmenu="return false" > 
<%
  String SQL="SELECT section+loft+room_no  gg,state FROM order_contract WHERE state<>3 and section in ('lxhydq','ygyx')";
  ResultSet rs= ViewBean.executeQuery(SQL);
  while (rs.next()){
  
    String sql="update room set salestate="+rs.getString("state")+"+1 where seccode+loft+room_code ='"+rs.getString("gg")+"'";
	
	 ViewBean1.executeUpdate(sql);
   }
  

 %>
</body>
</html>
