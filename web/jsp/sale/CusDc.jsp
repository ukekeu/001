<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "���ÿͻ������" , 
                  "���"
                ) ;
%>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<title>���ÿͻ������</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/line.css" >
</head>
<%
String Date2=request.getParameter("Date2");
String Date1=request.getParameter("Date1");
String SecNo=request.getParameter("SecNo");
 
%>
<body bgcolor="#FFFFFF" text="#000000">
<p align="center"><font size="5"><b>���ÿͻ������</font></b></p>
 
 
<table width="110%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr align="center"> 
    <td>���</td> 
	<td>����</td> 
	<td>����</td>
	<td>����</td>
	 <td>ְҵ</td>   
	 <td>�绰</td>
     <td>��Ϣ<br>��Դ</td>   
     <td>��ס<br>����</td> 
    <td>����<br>����</td> 
     <td>�Ƿ�<br>����</td>
	<td>����<br>��ʩ</td>	
	<td>�ͻ�����</td>
	<td>���</td>
	<td>˽�˹���</td>  
	  </tr>	  
<%
 String  SQL="SELECT c.visit_date, c.cus_name,c.cus_age,c.work,c.phone+c.sj phone,c.KNOWLEDGE_FROM,C.REGION,c.demand,c.likes,c.Chamberes_tabt,c.purpose,c.seller FROM customer c where  c.section='"+SecNo+"' and c.visit_date between '"+Date1+"' and  '"+Date2+"'";
 
  ResultSet  rs=InsertBean.executeQuery(SQL);
	int j=0;
	while (rs.next()){ j++;
	%>
	<tr>
	<td><%=j %>
	<td><%=rs.getDate("visit_date").toString() %>&nbsp;</td>
	<td><%=getbyte(rs.getString("cus_name")) %>&nbsp;</td>
	<td><%=getbyte(rs.getString("cus_age")) %>&nbsp;</td>
	<td><%=getbyte(rs.getString("work")) %>&nbsp;</td>
	<td><%=getbyte(rs.getString("phone")) %>&nbsp;</td>	 
	<td><%=getbyte(rs.getString("KNOWLEDGE_FROM")) %>&nbsp;</td>
	<td><%=getbyte(rs.getString("region")) %>&nbsp;</td>
	<td><%=getbyte(rs.getString("demand")) %>&nbsp;</td>
	
	<td><%=getbyte(rs.getString("likes")) %>&nbsp;</td>
	<td><%=getbyte(rs.getString("Chamberes_tabt")) %>&nbsp;</td>
	<td><input type=text name=aa   class=unnamed1></td>
   <td><input type=text name=aa1 size=10   class=unnamed1></td>
    <td><%=getbyte(rs.getString("seller")) %>&nbsp;</td>
   
	<%
     }
  rs.close();
   %>
  </tr>
  </table>
  
  
</body>
</html>
