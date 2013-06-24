  <%@ page contentType="text/html;charset=GBK" %>
  <%@ page import="java.sql.*" %>
    <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="checkreg" scope="page" class="regcheck.writereadregedit"/> 
  <%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( aBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "清空数据" , 
                  "删除"
                ) ;
				
checkreg.delAllReg();
								
%>
 
 

<html>
<head>
    <LINK href="../class/news.css" rel=stylesheet>
	<title>
	  取消注册
	</title>
	<dody>
</body>
<script>
alert("下次登录必须重新激系统");
window.close();
</script>
</html>
