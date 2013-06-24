<html>
<head>
<title>更新产权数据</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

</head>
<%@ page contentType="text/html;charset=GBK" %>
  <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <%@ include file="../public_js/getByteOut.jsp"%>
<body bgcolor="#FFFFFF" text="#000000">
<%
	
	String code = China.getParameter(request, "code") ;
	String lqPerson = China.getParameter(request, "LqPerson") ;
	String lqDate = China.getParameter(request, "LqDate") ;
	String txt = China.getParameter(request, "txt") ;
	String gx = China.getParameter(request, "gx") ;
	String lqid = China.getParameter(request, "lqid") ;
	String handler= China.getParameter(request, "handler") ;
	String SQL="UPDATE ORDER_CONTRACT set cq_lingquR_id='"+lqid+"'";
	       SQL+=",cq_lingquR='"+lqPerson+"',cq_lingquGX='"+gx+"'";
		   SQL+=",cq_lingquDate='"+lqDate+"',cq_handler='"+handler+"'";
		   SQL+=",cq_bak='"+txt+"' where code="+code;
	 
		try {
			aBean.startTransaction();
	 		aBean.executeUpdate(SQL);
 			aBean.commit();
			aBean.endTransaction();
			
		} catch(Exception ee) {
			aBean.rollback();
			 
			out.print(ee+SQL) ;
			out.close();
		}
	  
%>
<script>
    alert("产权领取登记完成!");
	opener.window.location.reload();
	window.close() ;
	 
</script>
</body>
</html>
