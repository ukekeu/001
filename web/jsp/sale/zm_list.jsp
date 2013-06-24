<%@ page contentType="text/html;charset=GBK" %>

 

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>业主转名记录</title>
<script language=javascript src="js/mad.js"> </script>
<script language=javascript src="../public_js/basal.js"> </script>
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
</head>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<body topmargin="1">
<%
    String htno = getbyte1(request.getParameter("htno"));
     
    %>
<form action="sk_process.jsp" method="post" name="frm">
 
 
 
<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1  ALIGN=center  >
<tr  class=TXTColor> 
<td  align="right">序号</td>
<td  align="center">原客户名称</td>
<td  align="right">现客户名称</td>

<td  align="center">转名日期</td>
<td  align="center">转名原因</td>
　
</tr>
 
<%
  String SQL="SELECT * from zm_bak where htno="+htno;
 
	    
 
		  ResultSet rs=ViewBean.executeQuery(SQL+"order by zmdate desc");
         int i=0;
         while (rs.next()){ 
		    i++;
		    String  oldname=getbyte(rs.getString("oldname"));
		    String  newname=getbyte(rs.getString("newname"));
		    String  zmdate=getbyte(rs.getString("zmdate"));
			if (!zmdate.equals(""))zmdate=zmdate.substring(0,10);
			String  context=getbyte(rs.getString("context"));
			 
			%>
			<tr  class=listcontent > 
			<td  align="center"><%=i %></td>
			<td  align="center"><%=oldname %></td>
			<td  align="right"><%=newname %></td>
			
			<td  align="center"><%=zmdate %></td>
			<td  align="center"><%=context %></td>
			 
			</tr>
		<% }%>
		 
 
</body>
</html>
