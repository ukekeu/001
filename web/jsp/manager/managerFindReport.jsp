<%@ page contentType="text/html;charset=GBK" %>
 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>领导查询报表</title>
 <script language="javascript" src="../public_js/menu.js">
</script>
 
<%@ include file="../public_js/checktime.jsp"%>
 

</head>

 
<body class=tree>
<form name=rep method=POST ACTION="PrintReport.jsp" target="_blank">
<table width="100%" align="center" cellspacing="1" cellpadding border="0">

<tr align="center">

<td width="100%"   align="center" height="25" colspan="2"> <font size="3"><b>销售报表</b></font> 
</td>
</tr>

<tr>
<td     align="right"><a href="#" onclick="aad2(s38,250);printReport('../sale/auto_select2.jsp?PARA_SQL=viewSaleList&url=11&reporttype=sale&tablename=')">销售简报</a><img src="../images/h.gif"  name="s38"  value="2"> </td>
<td     align="right"><a href="#" onclick="aad2(s37,250);printReport('../sale/print_sale_s.jsp')">销售汇总表</a><img src="../images/h.gif"  name="s37"  value="2"> 
</td>
</tr>   

<tr>
<td     align="right"><a href="#" onclick="aad2(s36,250);printReport('../sale/autoselect4.jsp?type=1')">销售周报</a><img src="../images/h.gif"  name="s36"  value="2"> </td>
<td     align="right"><a href="#" onclick="aad2(s35,250);printReport('../sale/autoselect8.jsp?type=2')">销售月报</a><img src="../images/h.gif"  name="s35"  value="2"> </td>
</tr>  
<tr>
<td     align="right"><a href="#" onclick="aad2(s34,250);printReport('../sale/autoselect4.jsp?type=3')">临订明细</a><img src="../images/h.gif"  name="s34"  value="2"> </td>
<td     align="right"><a href="#" onclick="aad2(s33,250);printReport('../manager/autoselect4.jsp?url=5')" >销售一览表</a><img src="../images/h.gif"  name="s33"  value="2"> </td>
</tr>    
<tr>
<td     align="right"><a href="#" onclick="aad2(s32,250);printReport('../sale/print_payment_con.jsp?type=1')">付款方式分析</a><img src="../images/h.gif"  name="s32"  value="2"> </td>
<td     align="right"><a href="#" onclick="aad2(s31,250);printReport('../sale/print_payment_con.jsp?type=2');">退定明细表</a><img src="../images/h.gif"  name="s31"  value="2"> </td>
</tr>   
<tr>
<td     align="right"> <a href="#" onclick="aad2(s30,250);printReport('../sale/auto_count.jsp?type=1');" >未售统计表</a><img src="../images/h.gif"  name="s30"  value="2"> </td>

<td     align="right"><a href="#" onclick="aad2(s29,250);printReport('../customter/auto_select3.jsp?para=1');">客户档案表</a><img src="../images/h.gif"  name="s29"  value="2"> </td>

</tr>    
<tr >
<td     align="right"><a href="#" onclick="aad2(s28,250);printReport1('../sale/auto_select.jsp?PARA_SQL=ViewSectionData&url=9&reporttype=sale&tablename=')">楼盘资料表</a><img src="../images/h.gif"  name="s28"  value="2"> </td>

<td     align="right"><a href="#" onclick="aad2(s27,250);printReport('../sale/autoselect5.jsp?type=9');" >更名明细表</a><img src="../images/h.gif"  name="s27"  value="2"> </td>

</tr>    
<tr>
<td     align="right"><a href="#" onclick="aad2(s26,250);printReport('../sale/autoselect5.jsp?type=4')">销售明细表</a><img src="../images/h.gif"  name="s26"  value="2"> </td>
<td     align="right"><a href="#" onclick="aad2(s25,250);printReport1('../sale/sale_select.jsp?PARA_SQL=viewSaleList')">销售情况查询</a><img src="../images/h.gif"  name="s25"  value="2"> </td>


</tr>    
<tr>
<td     align="right"><a href="#" onclick="aad2(s24,250);printReport('../sale/autoselect5.jsp?type=6')">优惠审批表</a><img src="../images/h.gif"  name="s24"  value="2"> </td>
<td     align="right"><a href="#" onclick="aad2(s23,250);printReport('../sale/fxfx.jsp?url=1');" >户型销售统计</a><img src="../images/h.gif"  name="s23"  value="2"> </td>


</tr>   


<tr>                      
<td     align="right"> <a href="#" onclick="aad2(s22,250);printReport('../sale/autoselect5.jsp?type=8');" >换房明细表</a><img src="../images/h.gif"  name="s22"  value="2"> </td>
<td     align="right"> <a href="#" onclick="aad2(s21,250);printReport('../sale/autoselect5.jsp?type=7')" > 计划回笼表</a><img src="../images/h.gif"  name="s21"  value="2"> </td>
</tr>



<tr >

<td width="100%"  align="center" height="25" colspan="2"> <hr> </td>
</tr>

<tr>  

<tr >

<td width="100%"  align="center" height="25" colspan="2"> <font size="3"><b>财务报表</b></font> </td>
</tr>

<tr>                      
<td     align="right"> <a href="#" onclick="aad2(s1,250);printReport('../finance/autoselect4.jsp?url=0')" >收款统计情况表</a><img src="../images/h.gif"  name="s1"  value="2"> </font></td>
<td     align="right"> <a href="#" onclick="aad2(s2,250);printReport('../finance/autoselect4.jsp?url=5')" >收款明细统计表</a><img src="../images/h.gif"  name="s2"  value="2"> </font></td>
</tr>
<tr>                      
<td     align="right"> <a href="#" onclick="aad2(s3,250);printReport('../finance/Ajautoselect4.jsp?url=2')" >按揭放款汇总表</a><img src="../images/h.gif"  name="s3"  value="2"> </font></td>
<td     align="right"> <a href="#" onclick="aad2(s4,250);printReport('../finance/Ajautoselect4.jsp?url=4')" >按揭额明细表</a><img src="../images/h.gif"  name="s4"  value="2"> </font></td>
</tr>
<tr>                      
<td     align="right"> <a href="#" onclick="aad2(s5,250);printReport('../finance/autoselect4.jsp?url=1')" >配套费明细表</a><img src="../images/h.gif"  name="s5"  value="2"> </font></td>
<td     align="right"> <a href="#" onclick="aad2(s6,250);printReport('../finance/autoselect4.jsp?url=14')" >佣金提成计算表</a><img src="../images/h.gif"  name="s6"  value="2"> </font></td>

</tr>
<tr>                      
<td     align="right"> <a href="#" onclick="aad2(s7,250);printReport('../finance/autoselect4.jsp?url=6')" >产权核对表</a><img src="../images/h.gif"  name="s7"  value="2"> </font></td>
<td     align="right"> <a href="#" onclick="aad2(s8,250);printReport('../finance/autoselect4.jsp?url=7')" >代收核对表</a><img src="../images/h.gif"  name="s8"  value="2"> </font></td>
</tr>
<tr>                      
<td     align="right"> <a href="#" onclick="aad2(s9,250);printReport('../finance/autoselect5.jsp?url=8')" >开具发票情况</a><img src="../images/h.gif"  name="s9"  value="2"> </font></td>
<td     align="right"> <a href="#" onclick="aad2(s10,250);printReport('../finance/autoselect4.jsp?url=9')" >各项目总体情况表</a><img src="../images/h.gif"  name="s10"  value="2"> </font></td>
</tr>
<tr>                      
<td     align="right"> <a href="#" onclick="aad2(s11,250);printReport('../finance/autoselect4.jsp?url=11')" >欠款明细表</a><img src="../images/h.gif"  name="s11"  value="2"> </font></td>
<td     align="right"> <a href="#" onclick="aad2(s12,250);printReport('../finance/autoselect4.jsp?url=12')" >欠款汇总表</a><img src="../images/h.gif"  name="s12"  value="2"> </font></td>
</tr>
<tr>                      
<td     align="right"> <a href="#" onclick="aad2(s13,250);printReport('../finance/Ajautoselect4.jsp?url=5')" >临订订金明细</a><img src="../images/h.gif"  name="s13"  value="2"> </font></td>
<td     align="right"> <a href="#" onclick="aad2(s14,250);printReport('../finance/Ajautoselect4.jsp?url=6')" >诚意金明细</a><img src="../images/h.gif"  name="s14"  value="2"> </font></td>
</tr>
<tr>                      
<td     align="right"> <a href="#" onclick="aad2(s15,250);printReport('../finance/Ajautoselect4.jsp?url=7')" > 计划回笼表</a><img src="../images/h.gif"  name="s15"  value="2"> </font></td>
<td     align="right"> <a href="#" onclick="aad2(s16,250);printReport('../finance/print_payment_con.jsp?type=1')" > 付款方式分析</a><img src="../images/h.gif"  name="s16"  value="2"> </font></td>
</tr>
<tr>                      
<td     align="right"> <a href="#" onclick="aad2(s17,250);printReport('../finance/print_jf_con.jsp?type=3');" > 交房清单</a><img src="../images/h.gif"  name="s17"  value="2"> </font></td>
<td     align="right"> <a href="#" onclick="aad2(s18,250);printReport('../finance/autoselect7.jsp?url=13')" >客户交款明细表</a><img src="../images/h.gif"  name="s18"  value="2"> </font></td>
</tr>  
<tr>                      
<td     align="right"> <a href="#" onclick="aad2(s19,250);printReport('../finance/print_jf_con.jsp?type=1');" > 认购销售统计表</a><img src="../images/h.gif"  name="s19"  value="2"> </font></td>
<td     align="right"> <a href="#" onclick="aad2(s20,250);printReport('../finance/print_jf_con.jsp?type=2')" >认购销售汇总表</a><img src="../images/h.gif"  name="s20"  value="2"> </font></td>

</tr>            
</table> 
<input type=hidden name=choose value="3">
<input type=hidden name=url>
<input type=hidden name=rgorsale>

</form>

<script lang=javascript>
function printReport(urlValue){
 parent.frmright.window.location=urlValue;
}
function printReport1(urlValue){
parent.frmright.window.location=urlValue;
}
</script>

</body> 
 
</html> 
