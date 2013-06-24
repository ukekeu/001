 
 <%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 
 <%@ include file="../public_js/getByteOut.jsp"%>

<html>
<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
	<title>打印临定明细表</title>
</head>

<body>
<%
String secName=getbyte1(request.getParameter("secName"));
String Date1=request.getParameter("Date1");
String Date2=request.getParameter("Date2");
String sectionNo=getbyte1(request.getParameter("SecNo"));
if (!sectionNo.trim().equals(""))sectionNo=" and seccode='"+sectionNo+"'";
 
 String SQL="select * from  View_LdList where state=0 and  substring(CONVERT(char(24),  StartDate, 120),1,10)>='"+Date1+"' and   substring(CONVERT(char(24), StartDate, 120),1,10)<='"+Date2+"'"+sectionNo;
ResultSet rs=  ViewBean.executeQuery(SQL);
 
 int i=0;
 %>

<table width="100%"   cellspacing='0'  cellpadding='0'  >
<tr   align="center"> 
    <td><font size=3><b><%=secName %>临定明细表</b></font></td> 
 
  </tr>	 
  <tr   align="right"> 
    <td>&nbsp;</td> 
 
  </tr>	 
  <tr   align="right"> 
    <td>&nbsp;时间段: <%=Date1 %>至<%=Date2 %></td> 
 
  </tr>	  
  </table>
<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr align="center"> 
    <td>序号</td>  <td>姓名</td><td>电话</td> <td>日期</td><td>房号</td>  <td>面积</td> <td>临定总价</td><td>付款方式</td><td>已交定金</td><td>交款日期</td><td>业务员</td>   
  </tr>	
  <%while (rs.next()) {i++;%>  
   <tr align="center"> 
    <td><%=i%></td>  <td><%=getbyte(rs.getString("cus_name")) %>&nbsp;</td>
	<td><%=getbyte(rs.getString("tel"))+" "+ getbyte(rs.getString("sj"))%>&nbsp;</td>
	<td><%=getbyte(rs.getString("StartDate"))%>&nbsp;</td>
	 <td><%=getbyte(rs.getString("loft"))+getbyte(rs.getString("building"))+getbyte(rs.getString("room_code")) %></td>
	   <td><%=getbyte(rs.getString("area")) %></td> 
	   <td><%=getbyte(rs.getString("saleprice")) %></td>  
	      <td><%=getbyte(rs.getString("payment")) %>&nbsp;</td>  
	   <td><%=getbyte(rs.getString("fact_dj")) %></td>  
	   <td><%=getbyte(rs.getString("fact_date")) %>&nbsp;</td>  
	     <td><%=getbyte(rs.getString("receiver")) %>&nbsp;</td>   
  </tr>	
  
  <%}rs.close(); %>
</body>
</html>
