<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta  http-equiv="Expires" content="-1">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>还款计划表</title>
</head>
<%@ page language="java" import="java.sql.*,java.util.*"%>
<%@ include file="../public_js/checktime.jsp"%>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%
String seleyear=getbyte1(request.getParameter("seleyear"));
if (seleyear.equals(""))seleyear="0";
 %>
 <script language="javascript" src="../public_js/public.js"></script>
 
<body onload="setSelectMad(document.frm.seleyear,'<%=seleyear %>');">
<form name=frm >
<table>
<tr><td>银行等本金还款计划表</td></tr>
<tr><td><select name=seleyear onchange="document.frm.year.value=this.value;document.frm.submit();">
<option>选择年限</option>
<%for (int jj=1;jj<=30;jj++){ %>
<option value="<%=jj %>">第<%=jj %>年</option>
<%} %>
</select>
</td></tr>
</table><br>


<% 
String year=getbyte1(request.getParameter("year"));
String dkmoney=getbyte1(request.getParameter("dkmoney"));
 
	String ajStr = "select Year,bj,monthtax from ajllgkb  where year="+year+" and  type=2 order by  year";
		 
		 
		   ResultSet rs=ViewBean.executeQuery(ajStr);
	float bj=0;
	int yea=0;
	float yeartax=0;	   
	if (rs.next()) {// && i < pageSize)
 	   yea = rs.getInt("Year");
		bj = rs.getFloat("bj");
        yeartax = rs.getFloat("monthtax");
	}
	rs.close();	

 %>
<input type=hidden name=year  value="<%=year %>">
<input type=hidden name=dkmoney  value="<%=dkmoney %>">

<table width="90%">
<tr><td>期数</td><td>本金(元)</td><td>供款(元)</td></tr>
<% 
if (seleyear.equals("")){
for (int i=0;i<yea*12;i++){
int j=i+1;

%>
<tr><td>第<%=j %>月</td><td><%=bj %></td><td><%=bj*Integer.parseInt(dkmoney)+((Integer.parseInt(dkmoney)*10000-bj*i*Integer.parseInt(dkmoney))*yeartax/1000) %></td></tr>

<%

}
}else{
for (int i=((Integer.parseInt(seleyear)-1)*12+1);i<yea*12;i++){
int j=i+1;
%>
<tr><td>第<%=j %>月</td><td><%=bj %></td><td><%=bj*Integer.parseInt(dkmoney)+((Integer.parseInt(dkmoney)*10000-bj*i*Integer.parseInt(dkmoney))*yeartax/1000) %></td></tr>
<%
}
}
%>
</table>
</form>
</body>

</html>
