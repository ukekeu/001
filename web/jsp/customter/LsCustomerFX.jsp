<%@ page contentType="text/html;charset=GBK" %>

<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<jsp:useBean id="FormtD3" scope="page" class="test.PieChart"/>  
<%	
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "��ʧԭ��" , 
                  "����"
                ) ;
			
%>

<html>
<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
	<title>��ʧԭ�����</title>
</head>

<body>
<script language="JavaScript">
<!--
 function ok(x){
	 document.all.photo.value=x;
	 form1.action="list_charges_plan.jsp?type=5&ch_type=3";
	 form1.submit();
 }
//-->
</script>
 
<%
String SecNo=getbyte1(request.getParameter("SecNo")); 
 
try{
  Calendar calendar = Calendar.getInstance();
  String filename = String.valueOf(calendar.getTimeInMillis());	
  String messtitle="�ͻ���ʧ����";
  String SQL="select b.codevalue name ,count(*) num from CustomerLsCode a,LsCode b where a.codevalue=b.code ";
  SQL+=" AND  customer like '%"+SecNo+"%'";
  SQL+=" GROUP BY b.codevalue";
   String pic= FormtD3.drawToFile("D:/"+ request.getContextPath()+"/crmv9/jsp/picture/yxfxpic"+filename+".jpg",SQL,messtitle);  
  if (!pic.equals(""))
    out.print("<img src='../picture/yxfxpic"+filename+".jpg'>");
 
 
 }catch(Exception s){}

 %>
</body>
</html>