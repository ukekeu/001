<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>删除应收配套费或税费</title>
</head>


<%@ page language="java" import="java.sql.*,java.util.*"%>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>

 <body>
 <%String id=request.getParameter("id");
   String SQL="delete factGatheringTaxRecord where TaxName in (select TaxName from GatheringTaxRecord WHERE ID="+id+") and contractno in (select contactno from GatheringTaxRecord WHERE ID="+id+") ";
 
    ViewBean.executeUpdate(SQL);
     SQL="DELETE GatheringTaxRecord WHERE ID="+id;
    ViewBean.executeUpdate(SQL);
   setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "应收费用" , 
                  "删除"
                ) ;
  %>
<script>
 alert("已删除");
opener.document.f1.submit();
window.close();
</script>

</body>
</html>
