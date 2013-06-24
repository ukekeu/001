<%@ page contentType="text/html;charset=GBK" %>
 


 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>

<html>
<head> 
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>客户分析</title>

</head>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>


 <script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script>
function fxType(para){
document.cus.ty.value=para;
 
}
function fx(){
 var choose=document.cus.photo.value;
 
 if (choose=="3")
  document.cus.action="customerFX.jsp";
 else if (choose=="2")
    document.cus.action="customerFX.jsp";
 else if (choose=="1")	
    document.cus.action="cusFx.jsp";
	
 document.cus.submit();
}
</script>
<body>

<!--DemandAnalysepic.jsp-->
<form name=cus method="post" action="" target="_blank"> 
 
<p align=center><font size=4 class=FontColor><b>选择客户分析条件</b></font><p>

<table BORDER=0 width="50%" class=parent id=KB3Parent CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
  
		<tr><td class=roomleft  width="25%">
     		&nbsp;分析指标：
		</td><td  class=roomright>
 
		&nbsp;<select  multiple size=8  name="fxzb" style="width : 104" onchange="fxType(this.text)" >
		 
 
        <option value=wenhua>学历  </option> 
    
        <option value=job>职业 </option>   
	    <option  value=Sex>性别</option>           
        <option  value=age>年龄</option>           
         
		<option  value=hy>婚姻状况</option>
		<option  value=sr>月收入</option>
        <option  value=ah>爱好</option>
	 

      </select></td>  

</tr>
<tr><td class=roomleft>图表类型</td><td class=roomright>&nbsp;<select name="photo"><option value=3>饼图</option><option value=2>直方柱状图</option><option value=1>横向直方图</option></select></td></tr>
<tr><td class=roomleft>数据源</td><td class=roomright>&nbsp;<select name="cus_state"><option value=3>所有客户</option><option value=2>成交客户</option><option value=1>未成交客户</option></select></td></tr>
  </table>
 <input type=hidden name=ty >
  <p align=center>	<input type=button name="Count" value="提 交" onclick="fx();">
<input type=button name="Count" value="重 填">

	</p>  
  </form>


</body>

</html>
