<%@ page contentType="text/html;charset=GBK" %>

 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>报表管理</title>
<%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<script language="javascript" src="../public_js/menu.js">
</script>
<script language="javascript">
　
 
function printReport(urlValue){
parent.frmright.window.location=urlValue;
 
}
</script> 
</head>

<body class=tree>
<form name=cus method=POST ACTION="PrintSaleRe.jsp" target="_blank" onsubmit="return checkDate();">
 
                  <table width="100%" align="center" cellspacing="1" cellpadding border="0">
                    
					    <tr>
                        <td align="center" height="20" ><a href="#" onclick="aad2(s1,250);printReport('print_payment_con.jsp?type=2');">退房明细统计表</a><img src="../images/h.gif"  name="s1"  value="1"></td>
                    </tr> 
					  <tr>
                        <td align="center" height="20" ><a href="#" onclick="aad2(s2,250);printReport('autoselect5.jsp?type=14');">换房明细统计表</a><img src="../images/h.gif"  name="s2"  value="2"></td>
                    </tr> 
					<!--<tr>
                      <td ><a href="#" onclick="aad2(s1,250);printReport('print_today_rep.jsp')">销售日报</a></td>
                   
                    </tr>  -->
					<tr>
                    <td align="center" height="20" ><a href="#" onclick="aad2(s3,250);printReport('../customter/auto_select3.jsp?para=1');">成交客户明细表</a><img src="../images/h.gif"  name="s3"  value="3"></td>
                   
                    </tr>  
					<tr >
                        <td align="center" height="20" ><a href="#" onclick="aad2(s4,250);printReport('auto_select.jsp?PARA_SQL=ViewSectionData&url=9&reporttype=sale&tablename=')">房源资料明细表</a><img src="../images/h.gif"  name="s4"  value="4"></td>
                  
                         
                    </tr>  
					<tr >
                       
                 <td align="center" height="20"  ><a href="#" onclick="aad2(s5,250);printReport('autoselect5.jsp?type=9');" >客户更名明细表</a><img src="../images/h.gif"  name="s5"  value="5"></td>
                        
                    </tr>   
					<tr>
                      <td align="center" height="20" ><a href="#" onclick="aad2(s6,250);printReport('autoselect5.jsp?type=4')">销售明细统计表</a><img src="../images/h.gif"  name="s6"  value="6"></td>
                    
                    </tr> 
					  
					 
				 
					  <tr>                      
                      <td align="center" height="20" > <a href="#" onclick="aad2(s7,250);printReport('../finance/autoselect4.jsp?url=10')" >折扣明细统计表</a><img src="../images/h.gif"  name="s7"  value="7"></td>
                      </tr>
					 
                   
					  <tr>                      
                      <td align="center" height="20" > <a href="#" onclick="aad2(s8,250);printReport('auto_count.jsp?type=1');" >未售明细统计表</a><img src="../images/h.gif"  name="s8"  value="8"></td>
                        </tr>
					   
					   
					     <tr>                      
                      <td align="center" height="20" > <a href="#" onclick="aad2(s9,250);printReport('../finance/Ajautoselect4.jsp?url=2')" >按揭放款汇总表</a><img src="../images/h.gif"  name="s9"  value="9"></td>
                     </tr>
					 <tr>
                    <td  align="center" height="20" > 
					<a href="#" onclick="aad2(s10,250);printReport('print_sale_s.jsp')">销&nbsp;售&nbsp;汇&nbsp;总&nbsp;表</a><img src="../images/h.gif"  name="s10"  value="10">
					</td>
                    </tr> 
					    <tr>                      
                        <td align="center" height="20" > <a href="#" onclick="aad2(s11,250);printReport('../finance/Ajautoselect4.jsp?url=4')" >按揭明细统计表</a><img src="../images/h.gif"  name="s11"  value="11"></td>
                    </tr>
					<!--
					    <tr>                      
                      <td > <a href="#" onclick="aad2(s1,250);printReport('../sale/autoselect15.jsp?url=1')" >银行按揭贷款月度明细表</a></td>
                     </tr>
					
					    <tr>                      
                        <td > <a href="#" onclick="aad2(s1,250);printReport('../sale/autoselect15.jsp?url=2')" >一次性收款月度明细报表</a></td>
                    </tr>
					
					  <tr>                      
                      <td > <a href="#" onclick="aad2(s1,250);printReport('../sale/autoselect15.jsp?url=3')" >分期付款月度明细报表</a></td>
                     </tr>-->
					  <tr>                      
                       <td  align="center" height="20" > <a href="#" onclick="aad2(s12,250);printReport('../sale/autoselect15.jsp?url=4')" >销售月度汇总表</a><img src="../images/h.gif"  name="s12"  value="12"></td>
                    </tr>
					 <tr>                      
                      <td  align="center" height="20"> <a href="#" onclick="aad2(s13,250);printReport('sale_charges_count.jsp')" >营销费用统计</a><img src="../images/h.gif"  name="s13"  value="13"></td>
                        </tr>
						<tr>
                        <td align="center" height="20" > <a href="#" onclick="aad2(s14,250);printReport('fxfx.jsp?url=1');" >户型销售统计</a><img src="../images/h.gif"  name="s14"  value="14"></td>
                     </tr>   
					 <tr>
                      <td align="center" height="20" > <a href="#" onclick="aad2(s15,250);printReport('fxfx.jsp?url=2');" >朝向销售统计</a><img src="../images/h.gif"  name="s15"  value="15"></td>
                      </tr> 
					  <tr>
                       <td align="center" height="20" ><a href="#" onclick="aad2(s16,250);printReport('sale_select.jsp?PARA_SQL=viewSaleList')">销售情况查询</a><img src="../images/h.gif"  name="s16"  value="16"></td>
                     </tr> 
					  <tr>
                      <td align="center" height="20" ><a href="#" onclick="aad2(s17,250);printReport('print_payment_con.jsp?type=1')">付款方式分析</a><img src="../images/h.gif"  name="s17"  value="17"></td>
                      </tr>  
					   <tr>
                      <td  align="center" height="20" ><a href="#" onclick="aad2(s18,250);printReport('auto_select2.jsp?PARA_SQL=viewSaleList&url=11&reporttype=sale&tablename=')">销&nbsp;售&nbsp;简&nbsp;报</a><img src="../images/h.gif"  name="s18"  value="18"></td>
                   
                    </tr>   
					
					<tr>
                      <td align="center" height="20" ><a href="#" onclick="aad2(s19,250);printReport('autoselect4.jsp?type=1')">销&nbsp;售&nbsp;周&nbsp;报</a><img src="../images/h.gif"  name="s19"  value="19"></td>
                     </tr>  
					<tr>
                      <td align="center" height="20" ><a href="#" onclick="aad2(s20,250);printReport('autoselect8.jsp?type=2')">销&nbsp;售&nbsp;月&nbsp;报</a><img src="../images/h.gif"  name="s20"  value="20"></td>
                    </tr>  
					<tr>
                      <td align="center" height="20" ><a href="#" onclick="aad2(s21,250);printReport('autoselect11.jsp?type=3')">临&nbsp;定&nbsp;明&nbsp;细</a><img src="../images/h.gif"  name="s21"  value="21"></td>
                        </tr>   
					 <tr>
                       <td align="center" height="20" ><a href="#" onclick="aad2(s22,250);printReport('printPrice.jsp?type=1');">打印价格表</a><img src="../images/h.gif"  name="s22"  value="22"></td>
                    </tr>    
					
					  <!--
					 <tr>                      
                         <td > <a href="#" onclick="aad2(s1,250);printReport('autoselect5.jsp?type=11')" >销售台帐</a></td>
                      </tr>
					 <tr>                      
                      <td > <a href="#" onclick="aad2(s1,250);printReport('autoselect5.jsp?type=12')" >动态销售统计表</a></td>
                     </tr>
					  <tr>                      
                        <td > <a href="#" onclick="aad2(s1,250);printReport('autoselect5.jsp?type=13')" >楼盘销售周(月)报</a></td>
                    </tr>-->
                  </table>
               
<input type=hidden name=choose value="3">
<input type=hidden name=url value=1>
<input type=hidden name=rgorsale>

 </form>
</body> 
 
</html> 
