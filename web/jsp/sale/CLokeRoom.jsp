<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page import="java.sql.*,common.*" %>
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/logrecord.jsp" %>
 <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
	<title>��������Ԫ</title>
</head>

<body>

<%

String rooms=getbyte2(request.getParameter("rooms")); 
String loft=getbyte2(request.getParameter("loft")); 
String secno=getbyte2(request.getParameter("secno")); 
String build=getbyte2(request.getParameter("build")); 
String secname=getbyte2(request.getParameter("secname")); 
 String sql8 ="update room set dis=0,tddate=null ";
	   sql8+=" where room_code in ("+rooms+") and seccode='"+secno+"' and loft='"+loft+"'";
   InsertBean.executeUpdate(sql8); 
   setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "��������Ԫ" , 
                  "����"+secname+loft+build+rooms
                ) ;
   
   %>
   <script>
   alert("�ѽ���ѡ��Ԫ,��ȷ��ˢ��");
   opener.window.location.reload();
   window.close();
   
   </script>

</body>
</html>
