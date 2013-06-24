<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%> 
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="fa" scope="page" class="FormatData.FormatData"/> 
<html>
<head>
	<title>Untitled</title>
</head>

<body>
<%
String SQL="SELECT RMBPRICE*q_tax_rate*1.0/100 aa,code FROM ORDER_CONTRACT ";
 ResultSet  rs=fBean.executeQuery(SQL);
 while (rs.next()){
     String rmbprice=rs.getString("aa");
	  ResultSet execRs=aBean.executeQuery("exec dbo.L2U "+rmbprice+",0 ");//大写金额转换存储过程
            String upperMoney="";
			 if (execRs.next())
				upperMoney=execRs.getString("dd");
				execRs.close();
    SQL="UPDATE ORDER_CONTRACT SET q_tax_up='"+upperMoney+"' where code="+rs.getString("code");
 try{aBean.executeUpdate(SQL);
  }catch(Exception s){out.print(SQL);}
 
 
 }
 %>


</body>
</html>
