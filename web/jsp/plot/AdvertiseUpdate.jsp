<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

</head>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>

<%@ page import="java.sql.*, common.*" %>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
<body bgcolor="#FFFFFF" text="#000000">
<%
	String type = China.getParameter(request, "Type") ;
	String name = China.getParameter(request, "Name") ;
	String spec = China.getParameter(request, "Spec") ;
	String title= China.getParameter(request, "title") ;
	String time = China.getParameter(request, "Time") ;
	String format = China.getParameter(request, "format") ;
	String location = China.getParameter(request, "location") ;
	String times = China.getParameter(request, "Times") ;
	String totalPrice = China.getParameter(request, "TotalPrice") ;
	String beginDate = China.getParameter(request, "BeginDate") ;
	String finishDate = China.getParameter(request, "FinishDate") ;
	String target = China.getParameter(request, "Target") ;
	String attach = China.getParameter(request, "Attach") ;
	String picture = China.getParameter(request, "Picture") ;
	String ch = China.getParameter(request, "Ch") ;
	String assist = China.getParameter(request, "Assist") ;
	String zx = China.getParameter(request, "Zx") ;
	String chDate = China.getParameter(request, "ChDate") ;
	String region= China.getParameter(request, "region") ;
	if (time.equals(""))
		time = "0" ;
	 
	if (times.equals(""))
		times = "0" ;	
	if (totalPrice.equals(""))
		totalPrice = "0" ;	
	if (beginDate.equals(""))
		beginDate = "null" ;
	else 
		beginDate = "'" + beginDate + "'" ;		
	if (finishDate.equals(""))
		finishDate = "null" ;	
	else 
		finishDate = "'" + finishDate + "'" ;	
	String operation = China.getParameter(request, "Operation") ;
	String advertiseId = China.getParameter(request, "AdvertiseId") ;
	// out.print(operation) ;
	String section = (String) session.getAttribute("Advertise-Section") ;
	String insertStr = "insert into advertise(title,region,section, type, name, format, time, " + 
						"times,location,  totalPrice, beginDate, finishDate, target," +
						"attach, picture, ch, assist, zx, chDate) values('" +title+"','"+region+"','"+ section +
						"', '" + type + "', '" + name + "', '" + format + "', " + 
						time + ", " + times + ", '" + location + "', " +  totalPrice + ", " + beginDate + ", " + finishDate +
						", '" + target + "', '" + attach + "', '" + picture + 
						"', '" + ch + "', '" + assist + "', '" + zx + "', '" + 
						chDate + "')" ;
	String updateStr = "update advertise set title='"+title+"',type = '" + type + "', name = '" + name +
						"', spec = '" + spec + "', time = '" + time + "', format = '" + 
						format + "', location = '" + location + "', times = " + 
						times + ", totalPrice = " + totalPrice +", beginDate = " + 
						beginDate + ", finishDate = " + finishDate + ", target = '" +
						target + "', attach = '" + attach + "', picture = '" + picture +
						"', ch = '" + ch + "', assist = '" + assist + "', zx = '" + 
						zx + "', chDate = '" + chDate + "',region='"+region+"' where id = " + advertiseId ; 
	String deleteStr = "delete advertise where id = " + advertiseId ;					
  //out.print(insertStr) ;	
	String actualUnit = China.getParameter(request, "ActualUnit") ;
	String actualTimes = China.getParameter(request, "ActualTimes") ;
	String actualTotal = China.getParameter(request, "ActualTotal") ;
	String comeTimes = China.getParameter(request, "ComeTimes") ;
	String cusCount = China.getParameter(request, "CusCount") ;
	String saleCount = China.getParameter(request, "SaleCount") ;
	String saleArea = China.getParameter(request, "SaleArea") ;
	String saleMoney = China.getParameter(request, "SaleMoney") ;
	
	
	if (actualUnit.equals(""))
		actualUnit = "0" ;
	if (actualTimes.equals(""))
		actualTimes = "0" ;
	if (actualTotal.equals(""))
		actualTotal = "0" ;
	if (comeTimes.equals(""))
		comeTimes = "0" ;
	if (cusCount.equals(""))
		cusCount = "0" ;
	if (saleCount.equals(""))
		saleCount = "0" ;
	if (saleArea.equals(""))
		saleArea = "0" ;
	if (saleMoney.equals(""))
		saleMoney = "0" ;
	String finishStr = "update advertise set actualUnit = " + actualUnit +
					", actualTimes = " + actualTimes + ", actualTotal = " + 
					actualTotal + ", comeTimes = " + comeTimes + 
					", cusCount = " + cusCount + ", saleCount = " + saleCount +
					", saleArea = " + saleArea + ", saleMoney = " + saleMoney +
					", isFinish = '1' ,title='"+title+"'" +
					" where id = " + advertiseId ;
													
	// out.print(finishStr) ;
	String sOper = "更改" ;
	String sGood = "1" ;
		try {
			aBean.startTransaction();
			if (operation.equals("Insert")) {
				sOper = "添加" ;
				aBean.executeUpdate(insertStr);

                setlog( setlogBean , 
                                  ( String )session.getAttribute( "loginid" ) ,
                                  "广告管理" , 
                                  "增加"
                                ) ;
			}

			if (operation.equals("Modify"))
				aBean.executeUpdate(updateStr);
                setlog( setlogBean , 
                                  ( String )session.getAttribute( "loginid" ) ,
                                  "广告管理" , 
                                  "修改"
                                ) ;
			if (operation.equals("Delete")) {
				sOper = "删除" ;
				aBean.executeUpdate(deleteStr) ;
                setlog( setlogBean , 
                                  ( String )session.getAttribute( "loginid" ) ,
                                  "广告管理" , 
                                  "删除"
                                ) ;
			}	
			if (operation.equals("Finish")) {
				sOper = "完成添加" ;
				aBean.executeUpdate(finishStr) ;
			}	
			aBean.commit();
			aBean.endTransaction();
			
		} catch(Exception ee) {
			aBean.rollback();
			sGood = "0" ;
			//  out.print(ee) ;
		}
	//}
			
	
%>
<script>

	if ("<%= sGood %>" == "1") {
	

		alert("广告<%= sOper %>成功") ;

	} else {
		
		alert("广告<%= sOper %>失败") ;

	}
	 window.opener.window.location = "Advertise2002List.jsp?&x=" + Math.random() ;
		 window.close() ; 
	
</script>
</body>
</html>
