    <%@ page contentType="text/html;charset=GBK" %>
	<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<title>保存合同数据2</title>
</head>
<body>
 <%@ page language="java" import="java.sql.*,common.*,java.util.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="InsertBean2" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/Repalce.jsp"%>

<%@ include file="../public_js/logrecord.jsp" %>
		
<%@ include file="../public_js/getByteOut.jsp"%>
 <% 
//*****客户资料
  
   String cusname=China.getParameter(request,"cusname");
   String Cus_Name=China.getParameter(request,"cusname1");
   String Phone=China.getParameter(request,"tel");
   String ID_Card=China.getParameter(request,"carid");
   String Address=China.getParameter(request,"Address");
   String Zip_Code=China.getParameter(request,"post");
   String bbj=China.getParameter(request,"bbj");
    String csDate=China.getParameter(request,"csDate");
   String sj=China.getParameter(request,"sj");
   
 
   String sql1="";
        if (!csDate.equals(""))csDate=" csDate='"+csDate+"',";
		sql1="update customer set Cus_Name='"+Cus_Name+"',bbj='"+bbj+"',sj='"+sj+"',";
        sql1+="signatory='"+Cus_Name+"',Phone='"+Phone+"',ID_Card='"+ID_Card+"',";
		if (!csDate.equals(""))sql1+=csDate;
		 
        sql1+="Address='"+Address+"',Zip_Code='"+Zip_Code+"' where SerialNo='"+cusname+"'";

   int d= InsertBean.executeUpdate(sql1);
   
 
     
  %>
  <%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "客户资料" , 
                  "修改("+getbyte1(request.getParameter("sectio"))+getbyte1(request.getParameter("loft"))+getbyte1(request.getParameter("roomno"))+"-"+Cus_Name+")"
                ) ;
%>	
  <script>
  
   window.close();
  </script>
</body>
</html>
 
 
 
