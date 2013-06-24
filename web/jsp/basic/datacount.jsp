<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 <html>

<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<head>
	<title> 数据统计</title>
	<META http-equiv="Page-Enter" content="revealTrans(Transition=23,Duration=300.000)">
</head>
<body topmargin="1">
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="fa" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/asiic.jsp"%> 

<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<%
String SecNo=getbyte1(request.getParameter("SecNo"));
String SQL="SELECT sum(area) jzarea,count(*) num ,sum(sumprice) sumprice  from Room  WHERE SECCODE='"+SecNo+"'";
double sum_jzarea=0;
 ResultSet rs=null;
 // try{
  rs=ViewBean.executeQuery(SQL);
  
  if (rs.next()){sum_jzarea=rs.getDouble("jzarea");

 %>
  <table BORDER=0 width="100%" class=parent id=KB3Parent CELLSPACING=1 CELLPADDING=3 ALIGN=center >
  <tr >
      <td  class=listtitle align="center"   >本楼盘总建筑面积</td>
      <td class='listcontent'  align="center"    ><%=fa.getFloat2(sum_jzarea,2) %></td> 
	  
      <td  class=listtitle align="center"   >总套数</td>
      <td class='listcontent'  align="center"    ><%=rs.getInt("num")%></td> 
	  
      <td  class=listtitle align="center"   >预计销售总款</td>
      <td class='listcontent'  align="center"    ><%=fa.getFloat2(rs.getDouble("sumprice"),0) %></td> 
   	    </tr>
</table>
<%  }rs.close(); %>
   <table BORDER=0 width="100%" class=parent id=KB3Parent CELLSPACING=1 CELLPADDING=3 ALIGN=center >
  <tr class=listtitle>
      <td   align="center"     >楼栋名称</td>
	  <td   align="center"     >总套数 </td>
      <td   align="center"    >建筑面积</td>
	  <td   align="center"    >套内建筑面积</td>
	  
	  <td   align="center"    >总价</td>
  </tr>
  <%  SQL="SELECT loft,sum(area) jzarea ,sum(usedarea) tnarea,sum(sumprice)  sumprice,count(*) num  from Room  WHERE SECCODE='"+SecNo+"' group by loft order by loft";
 
  rs=ViewBean.executeQuery(SQL);
  
  while (rs.next()){ 
  %>
   <tr class='listcontent'>
      <td   align="center"   ><%=rs.getString("Loft") %></td>
	    <td   align="center"    ><%=rs.getString("num") %> </td>
      <td   align="center"   ><%=fa.getFloat2(rs.getDouble("jzarea"),2) %></td>
	   <td   align="center"   ><%=fa.getFloat2(rs.getDouble("tnarea"),2) %></td>
	    <td   align="center"   ><%=fa.getFloat2(rs.getDouble("sumprice"),0) %></td>
  </tr>
  <%  
  }
  rs.close(); %>
  </table>
 <table BORDER=0 width="100%" class=parent id=KB3Parent CELLSPACING=1 CELLPADDING=3 ALIGN=center >
  <tr class=listtitle>
      <td   align="center"    >楼栋名称</td>
	   <td   align="center"      >总套数 </td>
      <td   align="center"     >房间户型</td>
      <td   align="center"     >建筑面积</td>
	  	  <td   align="center"    >套内建筑面积</td>
	  
	  <td   align="center"    >总价</td>
  </tr>
  <%  SQL="SELECT Loft, Roomtype, SUM(Area) AS jzarea,sum(usedarea) tnarea,sum(sumprice)  sumprice,count(*) num FROM Room WHERE (SECCODE='"+SecNo+"')"+
      " GROUP BY Loft, Roomtype ORDER BY Loft, Roomtype";
 
  rs=ViewBean.executeQuery(SQL);
  
  while (rs.next()){
  %>
   <tr class='listcontent'>
      <td   align="center"   ><%=rs.getString("Loft") %></td>
	   <td   align="center"    ><%=rs.getString("num") %> </td>
	     <td   align="center"   ><%=rs.getString("Roomtype") %></td>
      <td   align="center"   ><%=fa.getFloat2(rs.getDouble("jzarea"),2) %></td>
	     <td   align="center"   ><%=fa.getFloat2(rs.getDouble("tnarea"),2) %></td>
	    <td   align="center"   ><%=fa.getFloat2(rs.getDouble("sumprice"),0) %></td>

  </tr>
  <%  
  }
  rs.close(); 
  
   
  %>
   </table>
</body>
</html>
