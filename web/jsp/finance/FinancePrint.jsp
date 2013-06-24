<%@ page contentType="text/html;charset=GBK" %>
 
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>财务报表</title>
<%@ page language="java" import="java.sql.*" %> 
<script language="javascript" src="../public_js/public.js"></script>
<script language="javascript" src="../public_js/menu.js">
</script>
</head>
<body topmargin="0"  class=tree > 
<form name=rep method=POST > 
      			  <table width="100%"  border="0" >
				    
					    <tr>                      
                      <td   height=20   align="center"><a href="#" onclick="aad2(s1,250);printReport('ccreport.jsp?url=1')" >资金回笼汇总表</a><img src="../images/h.gif"  name="s1"  value="1"></td>
                       </tr>
					   <tr>                      
                         <td   height=20   align="center"><a href="#" onclick="aad2(s2,250);printReport('ccreport.jsp?url=2')" >销售情况统计表</a><img src="../images/h.gif"  name="s2"  value="2"> </td>
					 </tr>
					  <tr>                      
                      <td   height=20   align="center"><a href="#" onclick="aad2(s3,250);printReport('ccreport.jsp?url=5')" >资金回笼明细表</a><img src="../images/h.gif"  name="s3"  value="3"></td>
                       </tr>
					   <tr>                      
                        <td   height=20   align="center"><a href="#" onclick="aad2(s4,250);printReport('ccreport.jsp?url=6')" >尚差房款明细表1</a><img src="../images/h.gif"  name="s4"  value="4"></td>
					 </tr>
					   <tr>                      
                        <td   height=20   align="center"><a href="#" onclick="aad2(s4,250);printReport('ccreport.jsp?url=16')" >尚差房款明细表2</a><img src="../images/h.gif"  name="s4"  value="4"></td>
					 </tr>
					 <tr>                      
                      <td   height=20   align="center"><a href="#" onclick="aad2(s5,250);printReport('ccreport.jsp?url=3')" >销售收款汇总表</a><img src="../images/h.gif"  name="s5"  value="5"></td>
                      	 </tr>
					  <tr>                      
                        <td   height=20   align="center"><a href="#" onclick="aad2(s6,250);printReport('ccreport.jsp?url=4')" >客户收款明细表</a><img src="../images/h.gif"  name="s6"  value="6"></td>
					 </tr>
					 <tr>                      
                      <td   height=20   align="center"><a href="#" onclick="aad2(s7,250);printReport('ccreport_d.jsp?url=1')" >收款日报统计表</a><img src="../images/h.gif"  name="s7"  value="7"></td>
                     </tr>
					 <tr>                      
                          <td   height=20   align="center"><a href="#" onclick="aad2(s8,250);printReport('ccreport_d.jsp?url=7')" >收据核销明细</a><img src="../images/h.gif"  name="s8"  value="8"></td>
					 </tr>
				    　
                 <tr>                      
                      <td   height=20   align="center"><a href="#" onclick="aad2(s9,250);printReport('autoselect4.jsp?url=0')" >收款统计情况表</a><img src="../images/h.gif"  name="s9"  value="9"></td>
                       </tr>
					  <tr>                      
                        <td   height=20   align="center"><a href="#" onclick="aad2(s10,250);printReport('autoselect4.jsp?url=5')" >收款明细统计表</a><img src="../images/h.gif"  name="s10"  value="10"></td>
					 </tr>
					   <tr>                      
                      <td   height=20   align="center"><a href="#" onclick="aad2(s11,250);printReport('Ajautoselect5.jsp?url=0')" >计划到帐款明细</a><img src="../images/h.gif"  name="s11"  value="11"></td>
                      </tr>
					   <tr>                      
                        <td   height=20   align="center"><a href="#" onclick="aad2(s12,250);printReport('Ajautoselect5.jsp?url=1')" >催办按揭统计表</a><img src="../images/h.gif"  name="s12"  value="12"></td>
                    </tr>
					  <tr>                      
                      <td   height=20   align="center"><a href="#" onclick="aad2(s13,250);printReport('Ajautoselect4.jsp?url=2')" >按揭放款汇总表</a><img src="../images/h.gif"  name="s13"  value="13"></td>
                     </tr>
					  <tr>                      
                        <td   height=20   align="center"><a href="#" onclick="aad2(s14,250);printReport('Ajautoselect4.jsp?url=4')" >按揭情况明细表</a><img src="../images/h.gif"  name="s14"  value="14"></td>
                    </tr>
					 
					  <tr>                      
                      <td   height=20   align="center"><a href="#" onclick="aad2(s15,250);printReport('autoselect4.jsp?url=1')" >配套费代收明细</a><img src="../images/h.gif"  name="s15"  value="15"></td>
               
					 </tr>
					   <tr>                      
                      <td   height=20   align="center"><a href="#" onclick="aad2(s16,250);printReport('autoselect4.jsp?url=6')" >业主产权核对表</a><img src="../images/h.gif"  name="s16"  value="16"></td>
                       </tr>
					 
					   <tr>                      
                       <td   height=20   align="center"><a href="#" onclick="aad2(s17,250);printReport('autoselect4.jsp?url=7')" >费用代收核对表</a><img src="../images/h.gif"  name="s17"  value="17"></td>
                     </tr>
					  <tr>                      
                      <td   height=20   align="center"><a href="#" onclick="aad2(s18,250);printReport('autoselect5.jsp?url=8')" >开具发票统计表</a><img src="../images/h.gif"  name="s18"  value="18"></td>
                      </tr>
					   
					 <tr>                      
                       <td   height=20   align="center"><a href="#" onclick="aad2(s19,250);printReport('autoselect4.jsp?url=12')" >房款欠款汇总表</a><img src="../images/h.gif"  name="s19"  value="19"></td>
                     </tr>
					  <tr>                      
                      <td   height=20   align="center"><a href="#" onclick="aad2(s20,250);printReport('Ajautoselect4.jsp?url=5')" >临定定金明细</a><img src="../images/h.gif"  name="s20"  value="20"></td>
                      </tr>
					  <tr>                      
                      <td   height=20   align="center"><a href="#" onclick="aad2(s21,250);printReport('Ajautoselect4.jsp?url=6')" >诚意金收取明细</a><img src="../images/h.gif"  name="s21"  value="21"></td>
                     </tr>
					  <tr>                      
                        <td   height=20   align="center"><a href="#" onclick="aad2(s22,250);printReport('Ajautoselect4.jsp?url=7')" > 首期计划回款表</a><img src="../images/h.gif"  name="s22"  value="22"></td>
                       </tr>
					   <tr>                      
                           <td   height=20   align="center"><a href="#" onclick="aad2(s23,250);printReport('print_payment_con.jsp?type=1')" >付款方式分析</a><img src="../images/h.gif"  name="s23"  value="23"></td>
                       </tr>
					     <tr>                      
                        <td   height=20   align="center"><a href="#" onclick="aad2(s24,250);printReport('print_jf_con.jsp?type=3');" > 业主交房统计表</a><img src="../images/h.gif"  name="s24"  value="24"></td>
                   
                     </tr>  
					    <tr>                      
                         <td   height=20   align="center"><a href="#" onclick="aad2(s25,250);printReport('autoselect7.jsp?url=13')" >客户交款明细表</a><img src="../images/h.gif"  name="s25"  value="25"></td>

                     </tr>
					 <tr>                      
                        <td   height=20   align="center"><a href="#" onclick="aad2(s26,250);printReport('print_jf_con.jsp?type=1');" >销售明细统计表</a><img src="../images/h.gif"  name="s26"  value="26"></td>
                     </tr>        
					     <tr>                      
                           <td   height=20   align="center"><a href="#" onclick="aad2(s27,250);printReport('print_jf_con.jsp?type=2')" >收款币别汇总表</a><img src="../images/h.gif"  name="s27"  value="27"></td>

                     </tr>    
                  </table> 
 

</form>

<script lang=javascript>
function printReport(urlValue){
parent.frmright.window.location=urlValue;
 
}
</script>

</body> 
 
</html> 
