  <%@ page contentType="text/html;charset=GBK" %>
  <%@ page import="java.sql.*" %>
    <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="checkreg" scope="page" class="regcheck.writereadregedit"/> 
  <%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( aBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "�������" , 
                  "ɾ��"
                ) ;
				
checkreg.delAllReg();
								
%>
 
 

<html>
<head>
    <LINK href="../class/news.css" rel=stylesheet>
	<title>
	  ȡ��ע��
	</title>
	<dody>
</body>
<script>
alert("�´ε�¼�������¼�ϵͳ");
window.close();
</script>
</html>
