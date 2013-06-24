 <%@ page contentType="text/html;charset=GBK" %>
<%@ page import = "java.sql.*" %>
 <jsp:useBean id = "Bean" scope = "page" class = "ConnDatabase.SDatabase" />
 <jsp:useBean id = "Bean1" scope = "page" class = "ConnDatabase.SDatabase" />
   <%@ include file="../jsp/public_js/getByteOut.jsp"%>
   <%@ include file="../jsp/public_js/checktime.jsp"%>
<%
	 

    String id=request.getParameter("id");
	  ResultSet rs=Bean.executeQuery("select checker,newsdate,newstitle,newstxt from news  where id="+id);
	 if (rs.next()){   
	 
%> 
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>阅读信息</title>
<LINK href="green.css" rel=stylesheet type=text/css>
<script language="javascript">
function change(nn,imgobj) {
if (document.images){
eval('document.images.'+nn+'.src="'+imgobj+'"');

}
}
</script>
</head>
<body   topmargin="0">
<form method="post" action="" name="form1">
 
        <table width="100%" cellspacing="1" cellpadding >
          <tr>
          <td width="398" height="5" colspan="2"></td>
        </tr>
        <tr class="bgcolor2">
            <td width="93" align="center"><font color="#FFFFFF">发布者</font></td>
            <td width="307">&nbsp;<font color="#FFFFFF"><%=rs.getString("checker")%>&nbsp;</font></td>
        </tr>
        <tr class="bgcolor2">
            <td width="93" align="center"><font color="#FFFFFF">发布时间</font></td>
            <td width="307" align="left">&nbsp;<font color="#FFFFFF"><%=rs.getString("newsdate")%></font></td> 
        </tr> 
		 
        <tr class="bgcolor2"> 
          <td width="93" align="center"><font color="#FFFFFF">标&nbsp;&nbsp;&nbsp; 
            题</font></td>
          <td width="307">&nbsp;<font color="#FFFFFF"><%=rs.getString("newstitle")%></font></td>
        </tr>
        <tr>
          <td width="398" colspan="2" height="10">&nbsp;</td>
        </tr>
         <tr>
          <td colspan="2"   ><%=rs.getString("newstxt")%></td>
        </tr>
  <% 
 }
 
rs.close(); 
Bean.executeUpdate("update  news set reads=reads+1 where id="+id);
 
   %>
</table>
</form>
</body>

</html>
