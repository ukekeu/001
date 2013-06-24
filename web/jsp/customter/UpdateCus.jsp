<%@ page contentType="text/html;charset=GBK" %>
  <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
<html>
<head>
<title>批量更新客户信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

</head>
 

<body bgcolor="#FFFFFF" text="#000000">
<%
	String section = China.getParameter(request, "Section") ;
	String maxRoomNo = China.getParameter(request, "MaxRoomNo") ;
	int maxNo = 0;
	String sExist="";
	try {
		maxNo = Integer.parseInt(maxRoomNo) ;
	} catch (Exception e) {
	}	
	String sOper = "更改" ;
	String sGood = "1" ;
	String insertStr="";
	String updateStr ="";			 
	try {
		//aBean.startTransaction();
		for (int i = 1; i <=maxNo; i++) {
	 
		  
			String B= China.getParameter(request, "B" + i) ;
			String C = China.getParameter(request, "C" + i) ;
			String D = China.getParameter(request, "D" + i) ;
            String E = China.getParameter(request, "E" + i) ;
	     	String F = China.getParameter(request, "F" + i) ;
			String G = China.getParameter(request, "G" + i) ;
			String H = China.getParameter(request, "H" + i) ;
			String I = China.getParameter(request, "I" + i) ;
			String J= China.getParameter(request, "J" + i) ;
            String K=China.getParameter(request, "K" + i) ;
			String L=China.getParameter(request, "L" + i) ;
			String O=China.getParameter(request, "O" + i) ; 
      if (!B.equals("")){
 
      String sql="insert into customer(Section,Cus_Name,  Knowledge_From,Phone, "; 
            sql=sql+" visit_date, seller,demand,region,yixianmianji) values(";
		   sql=sql+" '" + section + "', '" + B + "', '" +H + "', '" ; 
		   sql=sql+G + "', '" +I+ "', '" + O  + "', '" + K+"','";
		   sql=sql+ J+"','"+ L+"')";
		 

      aBean.executeUpdate(sql) ;  
     aBean.executeUpdate("update customer set SerialNo=ltrim(rtrim(section))+'-'+ltrim(rtrim(str(code))) where SerialNo='' or SerialNo is null") ;
	  
	    sql=" select max(code) code from  customer";
	     ResultSet codeRS=null;
		 codeRS=bBean.executeQuery(sql);
		 String maxcode="";
		 if (codeRS.next())maxcode=codeRS.getString("code");
		 codeRS.close();
		 if (!maxcode.equals("")){	
	        sql="insert into customer_xq(customer,xq_code) values("+maxcode+","+H+")";
			 if (!H.equals(""))
			aBean.executeUpdate(sql);
			 sql="insert into customer_xq(customer,xq_code) values("+maxcode+","+K+")";
			  if (!K.equals(""))
			aBean.executeUpdate(sql);
			 sql="insert into customer_xq(customer,xq_code) values("+maxcode+","+L+")";
			 if (!L.equals(""))
			aBean.executeUpdate(sql);
		 }	
		}	
	   }
		//aBean.commit();
		//aBean.endTransaction();
		
	} catch(Exception ee) {
		aBean.rollback();
		sGood = "0" ;
		out.print(ee.getMessage());
		 out.close();
		
	}
//}
			
	
%>
 <script>
 
 opener.window.close();

 window.close();</script>
</body>
</html>
