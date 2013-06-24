
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.sql.*,common.*,java.util.*,java.util.Date" %> 
 <jsp:useBean id = "Bean" scope = "page" class = "ConnDatabase.SDatabase" />
 <jsp:useBean id = "Bean1" scope = "page" class = "ConnDatabase.SDatabase" />
 
<jsp:useBean id="relatime" scope="page" class="relaDateInfo.relaDateInfo"/>
  <%@ include file="../public_js/getByteOut.jsp"%>

<html>
<head>
	<title>当前计划内容</title>
</head>
<LINK href="green.css" rel=stylesheet type=text/css>
<body>
 <form name=frm action="">
 
 
<table width="100%" cellspacing="1" cellpadding >
          <tr>
          <td width="398" height="5" colspan="2"></td>
        </tr>
		  <tr class="bgcolor2">
             <td width="25%" align="center"><font color="#FFFFFF">计划完成时间</font></td> <td width="60%" align="center"><font color="#FFFFFF">工作内容</font></td><td>&nbsp;</td>
            </tr>
<%
String dele=request.getParameter("dele");
if (dele!=null){
 
Bean.executeUpdate("delete dayplan where   code="+dele);
%>
<script>opener.document.forms[0].submit();window.close();</script>

<%
out.close();
}

String plandate=request.getParameter("id");
 String userid=(String)session.getAttribute("loginid");
 String   ggSQL="select name,code,sdate,edate, context from dayplan where   sdate<='"+plandate+"' and  '"+plandate+"' <=edate and (userid='"+(String)session.getAttribute("loginid")+"'  ) order by sdate ";
 ResultSet   rs=Bean.executeQuery(ggSQL);
 
 String id="";
 while (rs.next()){
 String name=getbyte1(rs.getString("name"));
 id=rs.getString("code");

 %>
  
		 <tr  class="bgcolor2">
	 
         <td width="15%" align="left" class=listbody>&nbsp;<%=rs.getDate("sdate").toString()+"到"+rs.getDate("edate").toString()%></td> 
         <td class=listbody width="70%"><%=rs.getString("context")%></td>
	   <td class=listbody width="15%" ><a href="#" onclick="if (confirm('确认删除吗？')){document.frm.dele.value=<%=id%>;document.frm.submit();}">删除</a></td>
        </tr>
		<%
  
 
 }
 rs.close();
 %>

</table>
<p align="center">
<input type=hidden name=dele value="">

 
</form>
</body>
</html>
