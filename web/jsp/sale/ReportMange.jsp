 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>报表管理</title>
  <%@ page contentType="text/html;charset=GBK" %>
  <%@ page import="java.sql.*,common.*" %>
  <%@ include file="../public_js/checktime.jsp"%>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <%@ include file="../public_js/getByteOut.jsp"%>     
  <%@ include file="../public_js/qx_checke.jsp"%>

<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>

</head>
<script>
function printReport(urlValue){
  openwin(urlValue,700,300,50,100);

}</script>
<body>
<%  String SecName=China.getParameter(request,"SecName");
    String SecNo=China.getParameter(request,"SecNo");
	String Loft= China.getParameter(request, "Loft") ;
	String Build=China.getParameter(request,"Build"); 
    String sel=(String)request.getParameter("sel");
    if(sel==null) sel="0";
%>
<form name=frm method="post" action="ReportMange.jsp">
<input type=hidden name=SecNo value="<%=SecNo%>">
<input type=hidden name=SecName value="<%=SecName%>">
<input type=hidden name=Loft value="<%=Loft %>">
<input type=hidden name=Build value="<%=Build %>">
<input type=hidden name=cusname value="">
<input type=hidden name=secname value="">

<table width="820" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("4")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=4;findSub('RoomCodeShowS.jsp');"><font color='<%if(sel.equals("4")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>合同登记</font></a>
	</td>
	  <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('ContractNoM.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>合同号管理</font></a>
	</td>
	 <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=0;findSub('ContractJz.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>鉴证管理</font></a>
	</td>
	 <td class="<%if(sel.equals("9")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=9;findSub('contract_yj.jsp');"><font color='<%if(sel.equals("9")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>移交管理</font></a>
	</td>
	<td class="<%if(sel.equals("6")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=6;findSub('rh_view.jsp');"><font color='<%if(sel.equals("6")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>入户管理</font></a>
	</td>
	<!--
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=0;findSub('contract_view.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>未审核合同</font></a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('contract_view.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>已审核合同</font></a>
	</td>
	-->
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=3;findSub('contract_yh_view.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>优惠审核</font></a>
	</td>
	
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;findSub('paymoneyProcess.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>付款进度</font></a>
	</td>
	<td class="<%if(sel.equals("7")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=7;findSub('contract_view.jsp');"><font color='<%if(sel.equals("7")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>办产权审核</font></a>
	</td>
	<td class="<%if(sel.equals("5")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=5;findSub('ReportMange.jsp');"><font color='<%if(sel.equals("5")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>报表管理</font></a>
	</td>
	<td class="<%if(sel.equals("8")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=8;findSub('contract_wycl.jsp');"><font color='<%if(sel.equals("8")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>违约处理</font></a>
	</td>
   </tr>
<input type=hidden name=sel value="<%=sel%>">
 </table>
<script>
function findSub(para){
   document.frm.action=para;
   document.frm.submit();


}
</script>
<table width="100%" cellspacing cellpadding>
  <tr>
    <td width="100%" height="40"></td>
  </tr>
  <tr>
    <td width="100%" align="center" bordercolor="#678DC0">
      <table width="425" cellspacing cellpadding>
        <tr>
          <td width="52" valign="top"><img border="0" src="../images/bb-pic.gif" width="52" height="242"></td>
          <td width="373" valign="top">
            <table width="100%" cellspacing cellpadding style="border: 1 solid #FFFFFF">
              <tr>
                
              <td width="100%" height="25" align="center" class=listtitle><b><font color="#FFFFFF" size="3">报表种类</font></b></td>
              </tr>
              <tr>
                <td width="100%">
                  <table width="100%" cellspacing="1" cellpadding>
                    <tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="#" onclick="openwin1('auto_select.jsp?PARA_SQL=viewSaleList&url=1&reporttype=sale&tablename=',700,300,20,10);" >销售明细报表</a></font></td><!--view_skprocess-->
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('auto_select.jsp?PARA_SQL=saleview&url=4&reporttype=sale&tablename=')">已售房产统计</a></font></td>
                    </tr>
                    <tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font class="FontColor" size="2" color="#000080"><a href="javascript:printReport('auto_select.jsp?PARA_SQL=yezhulist&url=2&reporttype=sale&tablename=')">业主资料表</a></font></td>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font class="FontColor" size="2" color="#000080"><a href="javascript:printReport('auto_select.jsp?PARA_SQL=ajcustomerlist&url=5&reporttype=sale&tablename=')">按揭客户明细表</a></font><!--<a href="javascript:printReport('auto_select.jsp?PARA_SQL=tairanAlAjWfkList&url=5&reporttype=sale&tablename=')">已按揭未放款客户明细表</a>-->
					  <input type="hidden" name="monthpic" value="1">
					  <!--<select name="monthpic">
                         
						  <option value="1" selected>直方图</option>
                          <option value="1">曲线图</option>
                        </select>
						-->
						</td>
                    </tr>

                    <tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('auto_select.jsp?PARA_SQL=saleview&url=12&reporttype=sale&tablename=')">预售分户汇总表</a></font></td>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('auto_print.jsp');">成交情况明细表</a><!--<a href="javascript:printReport('auto_select.jsp?PARA_SQL=tairanAlAjYfkList&url=7&reporttype=sale&tablename=')">已按揭已放款客户明细表</a></font>--></td>
                    </tr>
                   <tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('auto_select.jsp?PARA_SQL=SaleCountPic_View&url=8&reporttype=sale&tablename=')">月销售情况图</a></font></td>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('auto_select.jsp?PARA_SQL=ViewSectionData&url=9&reporttype=sale&tablename=')">楼盘资料表</a></font></td>
                    </tr>
                     <tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('auto_select2.jsp?PARA_SQL=viewSaleList&url=11&reporttype=sale&tablename=')">销售简报</a></font></td>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><!--<a href="javascript:printReport('auto_select1.jsp?PARA_SQL=viewSaleList&url=11&reporttype=sale&tablename=')">销售简报2(分栋)</a>-->
<a href="javascript:printReport('print_sale_s.jsp')">销售汇总表</a>
</font></td>
                    </tr>   
					  <tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('auto_select3.jsp')">销售统计表</a></font></td>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('auto_select.jsp?PARA_SQL=AjCountList&url=13&reporttype=sale&tablename=')">按揭情况统计表</a></font></td>
                    </tr>   
					  <tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('autoselect4.jsp?type=1')">销售周报</a></font></td>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('autoselect8.jsp?type=2')">销售月报</a></font></td>
                    </tr>  
					 <tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('autoselect4.jsp?type=3')">临订明细</a></font></td>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('printPrice.jsp?type=1');">打印价格表</a></font>  </td>
                    </tr>    
					 <tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('print_payment_con.jsp?type=1')">付款方式分析</a></font></td>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('print_payment_con.jsp?type=2');">退房情况</a></font>  </td>
                    </tr>   
					<tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('print_today_rep.jsp')">销售日报</a></font></td>
                   <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('autoselect5.jsp?type=1')">本周成交明细表</a></font></td>
                   
                    </tr>    
					<tr >
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('autoselect5.jsp?type=2')">客户调查表</a></font></td>
                   <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('autoselect5.jsp?type=3')">成交客户档案</a></font></td>
                   
                    </tr>    
					<tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('autoselect5.jsp?type=4')">销售明细表1</a></font></td>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('sale_select.jsp?PARA_SQL=viewSaleList')">销售情况查询</a></font></td>
                    
                   
                    </tr>    
					<tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('autoselect5.jsp?type=6')">优惠审批表</a></font></td>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('auto_select.jsp?PARA_SQL=viewSaleList&url=19&reporttype=sale&tablename=')">合同登记表</a></font></td>
                    
                   
                    </tr>   
					<tr>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('auto_select.jsp?PARA_SQL=ViewSectionData&url=20&reporttype=sale&tablename=')">预售价格明细表</a></font></td>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font color="#000080" class="FontColor" size="2"><a href="javascript:printReport('auto_select.jsp?PARA_SQL=ViewSectionData&url=22&reporttype=sale&tablename=')">全房明细表</a></font></td>
                    
                   
                    </tr>  
					  <tr>                      
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font   class=FontColor> <a href="javascript:printReport('../finance/autoselect4.jsp?url=10')" >总价变化明细表</a></font></td>
                                            <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font   class=FontColor><a href="javascript:printReport('autoselect9.jsp?type=5')" > 纳税申报表(列表)</a></font></td>
                     </tr>
					  <tr>                      
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font   class=FontColor> <a href="javascript:printReport('auto_select.jsp?PARA_SQL=viewSaleList&url=21&reporttype=sale&tablename=');" >纳税申报表(套打)</a></font></td>
                      <td width="50%" bgcolor="#EAEAEA" style="border-left: 1 solid #FFFFFF; border-right: 1 solid #CCCCCC; border-top: 1 solid #FFFFFF; border-bottom: 1 solid #CCCCCC" align="center"><font   class=FontColor> <a href="javascript:printReport('autoselect5.jsp?type=7')" > 计划回笼表</a></font></td>
                     </tr>
                  </table>
                </td>
              </tr>
		 
  <tr> 
    <td width="100%">&nbsp;</td> 
  </tr>
 
</table> 
<input type=hidden name=choose value="3">
<input type=hidden name=url value=1>
<input type=hidden name=rgorsale>

 </form>
</body> 
 
</html> 
