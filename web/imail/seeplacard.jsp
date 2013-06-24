 <%@ page contentType="text/html;charset=GBK" %>
<%@ page import = "java.sql.*,java.util.*" %>
 <jsp:useBean id = "Bean" scope = "page" class = "ConnDatabase.SDatabase" />
 <jsp:useBean id = "Bean1" scope = "page" class = "ConnDatabase.SDatabase" />
   <%@ include file="../jsp/public_js/getByteOut.jsp"%>
   <%@ include file="../jsp/public_js/checktime.jsp"%>
<%
	 

    String id=request.getParameter("id");
	  ResultSet rs=Bean.executeQuery("select * from gonggao where id="+id);
	 if (rs.next()){   
	 
   
	 
 

	
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>系统公告</title>
<LINK href="green.css" rel=stylesheet type=text/css>
<script language="javascript">
function change(nn,imgobj) {
if (document.images){
eval('document.images.'+nn+'.src="'+imgobj+'"');

}
}

function openwin(url,wh,hg,lf,tp) {
  var newwin=window.open(url,"newwin","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
  newwin.focus();
  return false;
}
</script>
</head>
<body  topmargin="0">
<form method="post" action="seeplacard.asp" name="form1">
  <table width="445" cellspacing cellpadding>
   
    <tr> 
      <td width="100%" valign="top" align="center"> 
        <table width="445" cellspacing="1" cellpadding >
          <tr>
          <td width="398" height="5" colspan="2"></td>
        </tr>
        <tr class="bgcolor2">
            <td width="93" align="center"><font color="#FFFFFF">发布者</font></td>
            <td width="307">&nbsp;<font color="#FFFFFF"><%=rs.getString("writerid")%>&nbsp;</font></td>
        </tr>
        <tr class="bgcolor2">
            <td width="93" align="center"><font color="#FFFFFF">发布时间</font></td>
            <td width="307" align="left">&nbsp;<font color="#FFFFFF"><%=rs.getString("date")%></font></td> 
        </tr> 
		 <tr class="bgcolor2">
            <td width="93" align="center"><font color="#FFFFFF">发布部门</font></td>
            <td width="307" align="left">&nbsp;<font color="#FFFFFF"><%=rs.getString("deptid")%></font></td> 
        </tr> 
        <tr class="bgcolor2"> 
          <td width="93" align="center"><font color="#FFFFFF">标&nbsp;&nbsp;&nbsp; 
            题</font></td>
          <td width="307">&nbsp;<font color="#FFFFFF"><%=rs.getString("subject")%></font></td>
        </tr>
        <tr>
          <td width="398" colspan="2"  bgcolor="#FFFFFF"> 
		   <%=rs.getString("body")%> 
		  
		  
		  
		  
		 </td>
        </tr>
        <tr><td><%
		
		String adjunct=getbyte(rs.getString("filename"));
		if (!adjunct.equals("")){%>
		<font color="#FFFFFF">有附件：
	 <%StringTokenizer st22 = new StringTokenizer(adjunct,"&") ;
	  while (st22.hasMoreElements()) {
	  adjunct=(String)st22.nextElement();
	  %>
	 
	   <a href="#" onclick="openwin('downFile.jsp?fileurel=/jsp/knowledge/<%=adjunct %>',10,10,10,10);"><img src="../jsp/images/i_sign.gif" border=0></a>
	 
	 <%}} %></font></td></tr> 
      </table>
      </td>
  </tr>
</table>
    <% 
	}
	rs.close();  %>      
</form>
</body>

</html>
