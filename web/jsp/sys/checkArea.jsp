<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>检测面积</title>
</head>
  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<body oncontextmenu="return false" >
<table >
<tr><td>单位</td><td>房间建筑面积/套内面积/测绘前原建筑面积/测绘前原套内面积/</td><td>合同建筑面积/套内面积</td></tr>

<%  
 //ViewBean.executeUpdate("ALTER TABLE  LoftBuildCode add htwh VARCHAR(100) default ''"); 
 String sql="select o.sectionname+r.loft+r.room_code room,r.area rarea,r.Y_Area,r.Y_UsedArea,r.usedarea ,o.jzarea,o.area tnarea from room r ,order_contract o where o.state=1 and r.seccode+r.loft+r.room_code=o.section+o.loft+o.room_no and r.salestate<>1 and r.area<>o.jzarea";
 ResultSet rs=ViewBean.executeQuery(sql);
 while (rs.next()){
 %>
 <tr><td><%=rs.getString("room") %></td>
 <td><%=rs.getString("rarea") %>/<%=rs.getString("usedarea") %>/<%=rs.getString("Y_Area") %>/<%=rs.getString("Y_UsedArea") %></td>
 
 <td><%=rs.getString("jzarea") %>/<%=rs.getString("tnarea") %></td>
 
 </tr>
 <%}
 rs.close(); %>
</table>

</body>
</html>
