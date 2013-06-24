<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>计算费用</title>
</head>


<%@ page language="java" import="java.sql.*,java.util.*"%>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/logrecord.jsp" %>

 <body>
 <%String id=request.getParameter("id");
 String room=getbyte1(request.getParameter("room"));
 String logmess="删除";
 String SQL="update order_contract set fkdate=null where code in (select contractno from FactAjCharges WHERE ID="+id+")";
    ViewBean.executeUpdate(SQL);
    SQL="DELETE FactAjCharges WHERE ID="+id;
   ViewBean.executeUpdate(SQL);
   setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                 logmess, 
                  "放款"+room
                ) ;	
 
  %>
<script>
alert("已删除");
 opener.document.f1.submit(); 
window.close();
</script>

</body>
</html>
