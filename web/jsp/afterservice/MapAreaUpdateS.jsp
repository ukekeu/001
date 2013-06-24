<%@ page contentType="text/html;charset=GBK" %>

  <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
<title>更新实测面积</title>
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
	String sroom = China.getParameter(request, "sroom") ;
	String eroom = China.getParameter(request, "eroom") ;
	String sfloors = China.getParameter(request, "sfloors") ;
	String efloors = China.getParameter(request, "efloors") ;
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
		int i=1;
	 
		    String Loft = China.getParameter(request, "Loft2" + i) ;
			String Building = China.getParameter(request, "Building" + i) ;
			String room = China.getParameter(request, "Room" + i) ;
			String area = China.getParameter(request, "area" + i) ;
            String usedarea = China.getParameter(request, "usedarea" + i) ;
	     	String lutai = China.getParameter(request, "lutai" + i) ;
			String tyarea = China.getParameter(request, "tyarea" + i) ;
			String yangtaiz = China.getParameter(request, "yangtaiz" + i) ;
			String yangtai = China.getParameter(request, "yangtai" + i) ;
			String MappingArea= China.getParameter(request, "MappingArea" + i) ;
            String MappingUserArea=China.getParameter(request, "MappingUserArea" + i) ;
			String MappinglArea=China.getParameter(request, "MappinglArea" + i) ;
			String MappingtArea=China.getParameter(request, "MappingtArea" + i) ;
			String MappingyArea=China.getParameter(request, "MappingyArea" + i) ;
			String MappingdArea=China.getParameter(request, "MappingdArea" + i) ;
            String MappingytArea=China.getParameter(request, "MappingytArea" + i) ;
			String MappingyftjdArea=China.getParameter(request, "MappingyftjdArea" + i) ;
			String MappingyftydArea=China.getParameter(request, "MappingyftydArea" + i) ;
			String MappingywArea=China.getParameter(request, "MappingywArea" + i) ;
                
		 for(int jj=Integer.parseInt(sroom);jj<=Integer.parseInt(eroom);jj++){

		 for(int j=Integer.parseInt(sfloors);j<=Integer.parseInt(efloors);j++){
	     String sql="select * from Room where maap_state=0 and seccode='"+section+"' and building='"+Building+"'  and room="+String.valueOf(jj)+" and floor="+String.valueOf(j)+"   and Loft='"+loft+"'";
        
		   ResultSet rs= bBean.executeQuery(sql);
		  String eofs="false";
		   
		   if (rs.next()){
		    
			 insertStr = "insert into mapArea(section, building, loft, room, area," +
			 "y_area, UserArea,y_UserArea, lutai_area,y_lutai_area,lutai_price," +
			 "yangtai_zhao_area, y_yangtai_zhao_area,y_yangtai_zao_price,yangtai_area,y_yangtai_area,dt_area,dt_price,ty_area";
			 insertStr +=",y_ty_area,ty_price,area_rate,area_rate1,yxz_area,yxz_price,floors) values('"+ section + "', '" + Building +
			 "', '" + loft + "', '" + rs.getString("room_code") + "', " +rs.getString("area") + ", " + 
			 MappingArea + ", " + rs.getString("UsedArea")+ ", " + MappingUserArea  + ", " + 
			 rs.getString("lu_tai_area")+ ", " +  MappinglArea+ ", " +ltp+","+rs.getString("yang_tai_zhao_yarea")  +
			 ", " + MappingytArea+","+bxg+","+rs.getString("yang_tai_area") +","+MappingyArea+","+MappingdArea+","+dt+","+rs.getString("ty_area")+"," ;
			 insertStr +=MappingtArea+","+typ+","+retrievalPercent+","+percent1+","+MappingywArea+","+aqw+","+rs.getString("floor")+")";
	        aBean.executeUpdate(insertStr) ;
	         updateStr= "";
	
			 updateStr+="update room set maap_state=1,maap_date='"+mapDate+"',";
			 updateStr+="Area="+MappingArea+",yang_tai_area="+MappingyArea;
			 updateStr+=",UsedArea="+MappingUserArea+",lu_tai_area="+MappinglArea;
			 updateStr+=",yang_tai_zhao_sarea="+MappingytArea;
			 updateStr+=",ftjd_area="+MappingyftjdArea+",ftyd_area="+MappingyftydArea;
			 updateStr+=",ty_area="+MappingtArea+",dt_area="+MappingdArea;
			 updateStr+=",yxz_area="+MappingywArea; 
			 updateStr+=" where salestate<3 and  seccode = '"+ section;
		     updateStr+="' and building = '" + building + "' and loft = '" ;
		     updateStr+=loft + "' and room="+String.valueOf(jj)+" and floor="+String.valueOf(j);
			
			//aBean.executeUpdate(updateStr) ;
	 }
	
   }  
		}	
	
	} catch(Exception ee) {
		aBean.rollback();
		sGood = "0" ;
		out.print(ee.getMessage());
		 out.close();
		
	}
//}
			
	
%>

<form name="form33" method=post action="AreaMappingAS.jsp" >
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
