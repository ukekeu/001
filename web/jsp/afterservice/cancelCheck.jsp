<html>
<head>
<title>取消实测的审核</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

</head>

<form name=frm>
<input type=hidden name=SecNo>
<input type=hidden name=Loft>
<input type=hidden name=SecName>
<input type=hidden name=Build>
<input type=hidden name=choose>


 </form>
<%@ page contentType="text/html;charset=GBK" %>
  <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
<body bgcolor="#FFFFFF" text="#000000">
<%
	
	String mapUnit = China.getParameter(request, "mappingunit") ;
	String mapDate = China.getParameter(request, "mappingdate") ;
	String retrievalPercent = China.getParameter(request, "percent") ;
	String percent1= China.getParameter(request, "percent1") ;
	String state= China.getParameter(request, "state") ;
	String maxRoomNo = China.getParameter(request, "MaxRoomNo") ;
	String operation = China.getParameter(request, "ccc") ;
	 String section=China.getParameter(request, "SecNo");
	String loft=China.getParameter(request, "Loft");
	String building=China.getParameter(request, "Build");
	 if (!operation.equals("")){
	   String SQL=" delete GatheringRecord where contactno in ( SELECT CODE FROM ORDER_CONTRACT WHERE section+loft+room_no in ( select section+loft+room from MapArea where id in ("+operation+"))and shouldQS in (10,8,9)) ";
      aBean.executeUpdate(SQL);
	   SQL=" delete GatheringTaxRecord where ContactNo in ( SELECT CODE FROM ORDER_CONTRACT WHERE section+loft+room_no in ( select section+loft+room from MapArea where id in ("+operation+"))) ";//and moneytype=1
        aBean.executeUpdate(SQL);
	    
	    SQL="update ORDER_CONTRACT  set Y_jzarea=0,y_area=0,maap_state=0,cj_f=0,gz_c=0,cj_l=0,cj_t=0 WHERE section+loft+room_no in ( select section+loft+room from MapArea where id in ("+operation+")) ";
        aBean.executeUpdate(SQL);
	    SQL="update room  set maap_state=0,area=y_area,UsedArea=y_UsedArea,sumprice=y_area*unitprice,room_price=y_area*unitprice,y_sumprice=y_area*unitprice,dt_area=dt_y_area,lu_tai_area=lu_tai_mapp_area,ty_area=ty_y_area,wd_area=wd_y_area WHERE seccode+loft+room_code in ( select section+loft+room from MapArea where id in ("+operation+")) ";
        aBean.executeUpdate(SQL);
	   SQL="update MapArea  set checked=0 where id in ("+operation+") ";
       aBean.executeUpdate(SQL);
	   
    }
%>

<form name="form33" method=post action="HistroyPriceList.jsp" >
	<input type=hidden name="SecNo" value="<%= section %>" >
	<input type=hidden name="Build" value="<%= building %>" >
	<input type=hidden name="Loft" value="<%= loft %>" >
	  <input type=hidden name="sel" value="1">
</form>
<script>

	 alert("已取消通过的审核");
	 document.form33.submit() ;
	 
</script>
</body>
</html>
 
	
</script>
</body>
</html>
