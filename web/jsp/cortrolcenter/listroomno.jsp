<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.lang.*,common.*"%>
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
	<title>���ر�</title>
</head>
<script language="javascript" src="../public_js/public.js">
</script>
<%String loft=getbyte1(request.getParameter("loft")); %>
<body onload="setSelectMad(document.frm.loft,'<%= loft %>');">
<form name=frm>
ѡ������
<select name=loft onchange="document.frm.submit();"><option></option>
<%
String currLoft="";
String SQL="select s.name+r.loft  loft from room r,CRM_Project s  where r.seccode=s.serialno group by s.name+r.loft";
ResultSet rs=InsertBean.executeQuery(SQL);
while (rs.next()){
  String aa=getbyte(rs.getString("loft")) ;
  if (currLoft.equals(""))currLoft=aa;
  if (!loft.equals(""))currLoft=loft;
  %>
  <option value="<%=aa%>"><%=aa%></option>
  <%

}
rs.close();
 %>

</select>
 <table   border="0" CELLSPACING=1 CELLPADDING=3>
    <tr><td></td><td></td><td bgcolor='#DDE8E8' align="center">δ��</td>
	<td bgcolor='#00CCFF'  align="center">�Ϲ�</td>
	<td bgcolor='#E5C862'  align="center">����</td>
	<td bgcolor='#8DE4A6'  align="center">Ԥ��</td>
	<td bgcolor="#FF00FF"  align="center">�ٶ�</td>
	</table>
<table border="3" align=center>
<tr>
<td>����</td>
<td>����</td>
<td>����</td>
<td>����</td>
<td>����</td>
<td>����</td>
<td>����</td>
<td>����</td>
<td>����</td>
<td>����</td>
<td>����</td>
<td>����</td>
<td>����</td>
<td>����</td>
<td>����</td>
<td>����</td>
<td>����</td>
<td>����</td>
<td>����</td>
</tr>

<%
 SQL="select r.room_code ,r.salestate from room r,CRM_Project s where r.seccode=s.serialno  and s.name+r.loft='"+loft+"' order by  r.floor,r.room_code";
 
 rs=InsertBean.executeQuery(SQL);
 int i=0;
while (rs.next()){
 if (i==19){out.print("</tr>");i=0;}
 if (i==0)out.print("<tr>");
     String room_code=getbyte(rs.getString("room_code"));
     String state=getbyte(rs.getString("salestate"));
	 String bg="";
     if (state.equals("1")){ bg="BGCOLOR='#DDE8E8'";}
	 if (state.equals("2")){ bg="bgcolor='#00CCFF'"; }
	 if (state.equals("3")){ bg="bgcolor='#E5C862'";}
	 if (state.equals("4")){ bg="bgcolor='#8DE4A6'";}
	 if (state.equals("5")){ bg="bgcolor='#FF00FF'";}
	 if (state.equals("6")){ bg="bgcolor='#AACC6F'";}
 %><td <%=bg %>><%=room_code %></td>
 <%
 i++;

 }
 rs.close();
  %>
 
</table>
</form>



</body>
</html>
