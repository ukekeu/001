<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>ɾ��Ӧ�����׷ѻ�˰��</title>
</head>


<%@ page language="java" import="java.sql.*,java.util.*"%>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>

 <body>
 <%String id=request.getParameter("id");
   String factmoney=request.getParameter("money");
   String SQL="";
   
      
	 
	   SQL="DELETE FACTGatheringTaxRecord WHERE CODE="+id;
    ViewBean.executeUpdate(SQL);
	  setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "���շ���" , 
                  "ɾ��"
                ) ;
  %>
<script>
alert("��ɾ��");
opener.document.f1.submit();
window.close();
</script>

</body>
</html>
