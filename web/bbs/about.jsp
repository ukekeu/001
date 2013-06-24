<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="incdb.jsp"%>
<%@ include file="../jsp/public_js/checktime.jsp"%>
<jsp:useBean id="user" class="test.bbsuser" scope="page"/>
<jsp:useBean id="board" class="test.bbsboard" scope="page"/>
<%
java.sql.ResultSet sqlRst; 
sqlRst=board.listBoard(7);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>首页</title>
<base target="rtop">

<link rel="stylesheet" type="text/css" href="bbs03.css">

</head>
<body>
<div align="center">
  <center>
  <table border="0" width="500">
<%
int ii=0;
while(sqlRst.next()){
ii++;
 if (ii==1)out.print("<tr>");
%>
  
      <td width="50%" align="center"><a href="#" onclick="window.open('bbslist.jsp?boardid=<%=sqlRst.getString("boardid")%>');return false;"><%=sqlRst.getString("boardname")%></a></td>
 <% if (ii==2){ii=0;out.print("</tr>"); }%>
 
<%}
sqlRst.close();//关闭结果集
%>  
  </table>
  </center>
</div>
<p>     
</body>   
</html>   