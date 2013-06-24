<html>
<head>
<title>delete</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

</head> 
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page import = "java.sql.*,common.*"%>
<jsp:useBean id = "bBean" scope = "page" class = "ConnDatabase.SDatabase" />
<%@ include file="../public_js/checktime.jsp"%>
<body bgcolor="#FFFFFF" text="#000000">
  <%String AdvertiseId=China.getParameter(request,"AdvertiseId");
    String sql="delete priceproject1 where id="+AdvertiseId;
	//"update priceproject1 set state=1 where id="+AdvertiseId;
  try{
    bBean.executeUpdate(sql);
	}catch(Exception s){out.print(s.getMessage());}
 %>
 <script>
 alert("数据删除成功！");
 opener.location.reload();
  window.close() ;
 </script>
</body>gfdsf
</html>