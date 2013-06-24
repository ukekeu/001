<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>打印销售报表</title>
</head>
<SCRIPT>
self.resizeTo(screen.availWidth,screen.availHeight)
self.moveTo(0,0)
self.focus()
</script>

<body leftMargin=0 topMargin=0>
 <%@ page language="java" import="java.sql.*,common.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="UpdateRs" scope="page" class="ConnDatabase.SDatabase"/>
  <%@ include file="../public_js/getByteOut.jsp"%>
<form name=rep>
 <%String reportAddrs=(String)session.getAttribute("reportAddr"); %>
 <%

    // String RMB=China.getParameter(request,"RMB");
    String secno=China.getParameter(request,"SecNo");

String Loft = China.getParameter(request,"Loft");
String build = China.getParameter(request,"build");
String lb1 = "" ;
if( ! secno.equals( "" ) ) {
    if( ! Loft.equals( "" ) ) {
        lb1 = " and loft = '" + Loft + "' " ;
        if( ! build.equals( "" ) ) {
            lb1 = lb1 + " and building = '" + build + "' " ;
        }
    }
}



    String StartDate=China.getParameter(request,"Date1");
    String EndDate=China.getParameter(request,"Date2");
    String Choose=China.getParameter(request,"choose");
    String WhereSQL="";
    String WhereSQL1="";
    String SqlStr="";
    //ghjgh


    if (Choose.equals("1")){
        SqlStr="update View_GatheringListP set out='0'";
        if (!secno.equals("")) WhereSQL=" update View_GatheringListP set out='1' where  section='"+secno+"'" + lb1 ;
        if (!StartDate.equals("")&&!EndDate.equals(""))
        {
            WhereSQL+=" and SUBSTRING(CONVERT(char(24), shouldDate, 120), 1, 10) between '"+StartDate+"' and '"+EndDate+"'";
        }
    }
  if (Choose.equals("2")){
	  SqlStr="update View_ArrearSumList set out='0'";
      if (!secno.equals("")) WhereSQL=" update View_ArrearSumList set out='1' where  section='"+secno+"'" + lb1 ;
   /* if (!StartDate.equals("")&&!EndDate.equals(""))
     {
	  WhereSQL+=" and SUBSTRING(CONVERT(char(24), shouldDate, 120), 1, 10) between '"+StartDate+"' and '"+EndDate+"'";
	}*/
   }
  if (Choose.equals("3")){
	  SqlStr="update ViewTaxSumRep set out='0'";
      if (!secno.equals("")) WhereSQL=" update ViewTaxSumRep set out='1' where  section='"+secno+"'" + lb1 ;
     }

    if (Choose.equals("6")){
	  SqlStr="update ViewAjMoneyProcess set out='0'";
      if (!secno.equals("")) WhereSQL=" update ViewAjMoneyProcess set out='1' where  secno='"+secno+"'" + lb1 ;
   // if (!StartDate.equals("")&&!EndDate.equals(""))
    // {
	//  WhereSQL+=" and SUBSTRING(CONVERT(char(24), shouldDate, 120), 1, 10) between '"+StartDate+"' and '"+EndDate+"'";
	//}
   }		
	if (Choose.equals("11")||Choose.equals("12")){
	    SqlStr="update  View_SKPrint set out='0'";
      if (!secno.equals("")) WhereSQL=" update View_SKPrint set out='1' where  section='"+secno+"'" + lb1 ;
    if (!StartDate.equals("")&&!EndDate.equals(""))
      {
	  WhereSQL+=" and SUBSTRING(CONVERT(char(24), Gather_Date, 120), 1, 10) between '"+StartDate+"' and '"+EndDate+"'";
	 }
	}
	
	if (Choose.equals("4")){
	    SqlStr="update  TaxViewList set out='0'";
      if (!secno.equals("")) WhereSQL=" update TaxViewList set out='1' where  section='"+secno+"'" + lb1 ;
    /*if (!StartDate.equals("")&&!EndDate.equals(""))
      {
	  WhereSQL+=" and SUBSTRING(CONVERT(char(24), Gather_Date, 120), 1, 10) between '"+StartDate+"' and '"+EndDate+"'";
	 }*/
	}
	if (Choose.equals("5")){
	   SqlStr="update RepFactViewList set out='0'";
      if (!secno.equals("")) WhereSQL=" update RepFactViewList set out='1' where  section='"+secno+"'" + lb1 ;
    if (!StartDate.equals("")&&!EndDate.equals(""))
     {
	  WhereSQL+=" and SUBSTRING(CONVERT(char(24), InDate, 120), 1, 10) between '"+StartDate+"' and '"+EndDate+"'";
	 }
    }
	
   if (Choose.equals("8")){
	    SqlStr="update  View_yjsk set out='0'";
      if (!secno.equals("")) WhereSQL=" update View_yjsk set out='1' where  section='"+secno+"'" + lb1 ;
    if (!StartDate.equals("")&&!EndDate.equals(""))
      {
	  WhereSQL+=" and SUBSTRING(CONVERT(char(24), shouldDate, 120), 1, 10) between '"+StartDate+"' and '"+EndDate+"'";
	 }
	}
	 if (Choose.equals("9")){
	    SqlStr="update  saleview set out='0'";
      if (!secno.equals("")) WhereSQL=" update saleview set out='1' where  payment like '%"+"揭"+"%'  and section='"+secno+"'" + lb1 ;
   	}
	if (Choose.equals("13")){
	    SqlStr="update  SaleMoneyIncome_View set out='0'";
    if (!secno.equals("")) WhereSQL=" update SaleMoneyIncome_View set out='1' where  section='"+secno ;
    }
	if (Choose.equals("14")){
	    SqlStr="update  View_YJSK set out='0'";
    if (!secno.equals("")) WhereSQL=" update View_YJSK set out='1' where  section='"+secno+"'" + lb1 ;
    }
   	
try{
    int b=InsertBean.executeUpdate(SqlStr);
    int a=InsertBean.executeUpdate(WhereSQL);
}catch(Exception s){out.print(Choose+SqlStr);}


 if (Choose.equals("1")) response.sendRedirect(reportAddrs+"ArrearMxRep.rpt");
 if (Choose.equals("2")) response.sendRedirect(reportAddrs+"ArrearSumRep.rpt");
 if (Choose.equals("3")) response.sendRedirect(reportAddrs+"TaxDSSumChargesRep.rpt");
 if (Choose.equals("11")) response.sendRedirect(reportAddrs+"SaleSKProcessRep.rpt");
 if (Choose.equals("5")) response.sendRedirect(reportAddrs+"TaxDSChargesRep.rpt");
 if (Choose.equals("4")) response.sendRedirect(reportAddrs+"TaxYJChargesRep.rpt");
 if (Choose.equals("6")) response.sendRedirect(reportAddrs+"AjMoneyProcessRep.rpt");
 if (Choose.equals("7")) response.sendRedirect(reportAddrs+"YJRepSum.rpt");
 if (Choose.equals("8")) response.sendRedirect(reportAddrs+"YJSKRep.rpt");
 if (Choose.equals("9")) response.sendRedirect(reportAddrs+"AjMonthpayMoneyRep.rpt");
 if (Choose.equals("12")) response.sendRedirect(reportAddrs+"SaleSkSumReprot.rpt");
 if (Choose.equals("13")) response.sendRedirect(reportAddrs+"FactMoneyAndShouldMoney1.rpt");
 if (Choose.equals("14")) response.sendRedirect(reportAddrs+"YJSKPicRep.rpt");

%>

</form>
</body>
</html>
