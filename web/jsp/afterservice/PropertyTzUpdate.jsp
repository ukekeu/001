<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

</head>
<%@ page contentType="text/html;charset=GBK" %>

  <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <%@ include file="../public_js/getByteOut.jsp"%>
<body bgcolor="#FFFFFF" text="#000000">
<%
	
	String saleId = China.getParameter(request, "SaleId") ;
	String notifyDate = China.getParameter(request, "NotifyDate") ;
	
	
	String getSale = "select customer as cusNo, section  as secNo, loft, building, room_no as room from order_contract where " + 
					" code = " + saleId ;
	ResultSet cRs = aBean.executeQuery(getSale) ;
	String cusNo = "", section = "", loft = "", building = "", room = "" ;				
	if (cRs.next()) {
		cusNo = cRs.getString("cusNo") ;
		section = cRs.getString("secNo") ;
		loft = getbyte(cRs.getString("loft")) ;
		building = getbyte(cRs.getString("building")) ;
		room = cRs.getString("room") ;
	}
	cRs.close() ;
	
	
	String operation = China.getParameter(request, "Operation") ;
	// out.print(operation) ;
	String sExist = "select * from property where saleId = " + saleId ;
	ResultSet aRs = aBean.executeQuery(sExist) ;
	String sInsert = "" ;
	if (aRs.next()) {
		sInsert = "update property set tzDate = '" + notifyDate + "', tzHandler = '" +
					session.getAttribute("loginid") + 
					"', tz = '1' " + 
					" where saleId = '" + 
					saleId + "'" ;
	} else {
		sInsert = "insert into property(customer, section, loft, building, room_code," +
					"tzDate, tzHandler, saleId, tz) values('" + 
					cusNo + "', '" + section + "', '" + loft + "', '" + building + 
					"', '" + room + "', '" + notifyDate + "', '" + session.getAttribute("loginid") + 
					"', " + saleId + ", '1')" ;
					
	}
	aRs.close() ;
	// out.print(sInsert) ;
	String sOper = "更改" ;
	String sGood = "1" ;
		try {
			aBean.startTransaction();
			if (operation.equals("Insert")) {
				sOper = "添加" ;
				aBean.executeUpdate(sInsert);
			}	
			 
			aBean.commit();
			aBean.endTransaction();
			
		} catch(Exception ee) {
			aBean.rollback();
			sGood = "0" ;
			out.print(ee) ;
		}
	//}
			
	String sectionS = (String) session.getAttribute("Property-Section") ;
	String buildingS = (String) session.getAttribute("Property-Building") ;
	String loftS = (String) session.getAttribute("Property-Loft") ;		
	String secNameS = (String) session.getAttribute("Property-SectionName") ;
%>
<script>

	if ("<%= sGood %>" == "1") {
	

		alert("资料<%= sOper %>成功") ;

	} else {
		
		alert("资料<%= sOper %>失败") ;

	}
	    opener.document.cus.SecNo.value="<%=getbyte1(request.getParameter("Section"))%>";
   	opener.document.cus.Loft.value="<%=getbyte1(request.getParameter("Loft"))%>";		  
	   	opener.document.cus.build.value="<%=getbyte1(request.getParameter("Building"))%>";	 opener.document.cus.action = "Property2002List.jsp?x=" + Math.random() ;

		opener.document.cus.submit() 
	window.close() ;
	// window.location = "AjDoc.jsp?AjId=&x=" + Math.random() ;
</script>
</body>
</html>
