<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "ɾ���ٶ�" , 
                  "ɾ��"
                ) ;
%>

<HTML>
<HEAD>
<TITLE>ɾ���ٶ�</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK"> 
</HEAD>
  <%@ page import="java.sql.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />

<%@ include file="../public_js/getByteOut.jsp"%>
<body>
<%
String code = getbyte(request.getParameter("code"));
String bak = getbyte(request.getParameter("bak"));
 
String StrSql="update  SL_TemporarilyBuy  set state=1,cancelbak='"+bak+"' where roomcode="+code;
if (!bak.equals("")) {
try {
	 aBean.executeUpdate(StrSql);	 
	// StrSql="update  room  set salestate=1  where code="+code;
	 //aBean.executeUpdate(StrSql);
    }catch(Exception ee) {
		out.print(ee);
        out.close();
	} 
 %>
<script>
alert("ϵͳ�ѽ���ȡ���ٶ�");
opener.window.document.frm.submit();
window.close();
</script>
<%}%>
<form name=cus>
<input type=hidden name=code value=<%=code%>>
ȡ��ԭ��:<input type=text name=bak > <input type=button name=aaa value="ȷ��" onclick="document.cus.submit();">
</form>
</body>
</html>
