<%@ page contentType="text/html;charset=GBK" %>

  <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" /><HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
<title>更新实测基建面积</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

</head>

<form name=frm>
<input type=hidden name=SecNo>
<input type=hidden name=Loft>
<input type=hidden name=SecName>
<input type=hidden name=Build>
<input type=hidden name=choose>


 </form>

<body bgcolor="#FFFFFF" text="#000000">
<%
	String section = China.getParameter(request, "Section") ;
	String mapUnit = China.getParameter(request, "mappingunit") ;
	String mapDate = China.getParameter(request, "mappingdate") ;
	String retrievalPercent = China.getParameter(request, "percent") ;
	String percent1= China.getParameter(request, "percent1") ;
	String state= China.getParameter(request, "state") ;
	String maxRoomNo = China.getParameter(request, "MaxRoomNo") ;
	String operation = China.getParameter(request, "Operation") ;
	// out.print(operation) ;
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
	//String section=China.getParameter(request, "SecNo");
	String loft=China.getParameter(request, "Loft");
	String building=China.getParameter(request, "Build");
    String bxg=China.getParameter(request, "bxg");
	String dt=China.getParameter(request, "dt");
	String ltp=China.getParameter(request, "ltp");
	String typ=China.getParameter(request, "typ");
	String aqw=China.getParameter(request, "aqw");
	String jstype=China.getParameter(request, "jstype");
	//out.print(loft);
			 
	try {
		//aBean.startTransaction();
		for (int i = 1; i <=maxNo; i++) {
	 
		    String Loft = China.getParameter(request, "Loft2" + i) ;
			String Building = China.getParameter(request, "Building" + i) ;
			String room = China.getParameter(request, "Room" + i) ; 
			String MappingyftjdArea=China.getParameter(request, "MappingyftjdArea" + i) ;
			String MappingyftydArea=China.getParameter(request, "MappingyftydArea" + i) ;
			 
			String floors=China.getParameter(request, "floors" + i) ;
      if (Float.parseFloat(MappingyftjdArea)>0&&Float.parseFloat(MappingyftydArea)>0){
  
	 updateStr= "";
	
	 updateStr+="update room set  ";
	 updateStr+=" ftjd_area="+MappingyftjdArea+",ftyd_area="+MappingyftydArea;
	  
	 
	 updateStr+=" where seccode = '"+ section;
     updateStr+="' and building = '" + building + "' and loft = '" ;
     updateStr+=loft + "' and Room_code = '" + room + "'" ;
	 
	 aBean.executeUpdate(updateStr);
		}	
	   }
		//aBean.commit();
		//aBean.endTransaction();
		
	} catch(Exception ee) {
		aBean.rollback();
		sGood = "0" ;
		out.print(ee.getMessage()+insertStr);
		 out.close();
		
	}
//}
			
	
%>

<form name="form33" method=post action="AreaMapPingB.jsp" >
	<input type=hidden name="SecNo" value="<%= section %>" >
	<input type=hidden name="Build" value="<%= building %>" >
	<input type=hidden name="Loft" value="<%= loft %>" >
</form>
<script>

	if ("<%= sGood %>" == "1") {
	

		alert("资料保存成功") ;

	} else {
		
		alert("资料<%= sOper %>失败") ;

	}
	document.form33.submit() ;
	// window.location = "HistroyPriceList.jsp?SecNo=<%= section %>&Build=<%= building %>&Loft=<%= loft %>" ;
	
</script>
</body>
</html>
