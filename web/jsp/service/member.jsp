<%@ page contentType="text/html;charset=GBK" %>
 

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
 
<title>业主资料</title>
</head>
 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ include file="../public_js/getByteOut.jsp"%>
 

<body>
<%
String cusno =request.getParameter("cusno");
String sql="insert into VIPCUSTOMER(cus_name,sex,age,sfzh,hy,of_tel,sj,wy_addr,con_no,ho_addr,zipcode) select customer.cus_name,customer.cus_sex,customer.cus_age,customer.ID_Card,customer.marriage,customer.phone,customer.sj,Order_Contract.sectionname+Order_Contract.loft+Order_Contract.building+Order_Contract.room_no,Order_Contract.ContractNo,customer.address,customer.zip_code from   customer,Order_Contract where  Order_Contract.customer=customer.serialno and customer.member=0 and Order_Contract.customer in ("+cusno+")";
   ViewBean.executeUpdate(sql);
   sql="update customer set member=1 where serialno in ("+cusno+")";
 ViewBean.executeUpdate(sql);

 %>
<script>alert("已导入");
opener.window.location.reload();
	close();</script>

</body>
</html>
