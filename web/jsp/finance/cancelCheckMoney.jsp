<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>ȡ������˵��տ�Ǽ�</title>

</head>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ include file="../public_js/logrecord.jsp" %>
 <%@ include file="../public_js/getByteOut.jsp"%>
<body>
<%String code=request.getParameter("code");
 
  String SQL="UPDATE factGatheringRecord SET checkstate=0,checkDATE=null,checkstateperson=''  where id="+code;
  ViewBean.executeUpdate(SQL);
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "�տ����" , 
                  "ȡ��"+getbyte(request.getParameter("roomno"))
                ) ;	
 %>
<script>
alert("��ȡ������");
opener.document.f1.submit();
window.close();

</script>

</body>
</html>
