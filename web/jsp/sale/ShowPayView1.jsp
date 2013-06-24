<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<title>付款明细</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/news.css" rel=stylesheet>
<script src="js/mad.js"> </script>
<script language="javascript" src="../public_js/public.js">
</script>

</head>

<body bgcolor="#FFFFFF" text="#000000">
<%@ page import = "java.sql.*" %>
<jsp:useBean id = "paymentListBean" scope = "page" class = "ConnDatabase.SDatabase" />
<jsp:useBean id="relatime" scope="page" class="relaDateInfo.relaDateInfo"/>
<a href="javascript:window.history.back(1);">返回</a>
<div align="center">
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center"><font size=3>应付款明细</font></div>
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>

<%

String cusno=request.getParameter("cusno");

 %>
<table width="100%" border="1" cellpadding="0" cellspacing="0">
  <tr> 
    <td bgcolor="#cfe6eb"> 
      <div align="center">款类型</div>
    </td>
    
    <td bgcolor="#cfe6eb"> 
      <div align="center">应付款日期</div>
    </td>
    <td bgcolor="#cfe6eb"> 
      <div align="center">应付款金额</div>
    </td>
   <td bgcolor="#cfe6eb"> 
      <div align="center">是否已交</div>
    </td>
  </tr>
  
   <%
	String paymentStr ="select * from GatheringRecord where cusno='"+cusno+"'";
	float djm=0;
	ResultSet paymentRS = paymentListBean.executeQuery(paymentStr);
   
		while (paymentRS.next()) {
		int  num = paymentRS.getInt("shouldQS");
	    String  paymentdate = paymentRS.getString("shouldDate");
		int scale=paymentRS.getInt("shouldMoney");
		int state=paymentRS.getInt("state");
		String st="";
		if (state==0){st="未交";}
		else if (state==1){st="已交部份";}
		else if (state==2){st="已交清";}
        String type="";
		if (num==0){type="订金";}
		else if (num>0&&num<4){type="房款";}
		else  if (num==5){type="花园/露台款";}
		else  if (num==6){type="改装款";}
%>
    <tr align="center" BGCOLOR="#e6f9ff"  onmouseout="mOut(this,'#e6f9ff');" onmouseover="mOvr(this,'#EAECEC');" >
    
	<td style="border-style: solid; border-width: 1" ><%=type %> </td>
 
    <td style="border-style: solid; border-width: 1" ><%=paymentdate.substring(0,10)%></td>
    <td style="border-style: solid; border-width: 1" ><%=scale %>(元)</td>
    <td style="border-style: solid; border-width: 1" > <%=st %>  </td>
  </tr>
 <%}
 out.print("</table>");
  paymentRS.close();

  if (cusno!=null){
  %>
  <p>
  已付款情况:<br>
  <table width="100%" border="1" cellpadding="0" cellspacing="0">
  <tr> 
     <td bgcolor="#cfe6eb"> 
      <div align="center">款类型</div>
    </td>
 
    <td bgcolor="#cfe6eb"> 
      <div align="center">实收日期</div>
    </td>
    <td bgcolor="#cfe6eb"> 
      <div align="center">实收金额</div>
    </td>
	<td bgcolor="#cfe6eb"> 
      <div align="center">票据编号</div>
    </td>
	<td bgcolor="#cfe6eb"> 
      <div align="center">经手人</div>
    </td>
  </tr>
  <%
    paymentStr = "select * from FactGatheringRecord where cusno='"+cusno+"'";
	try{
	  ResultSet FactRS = paymentListBean.executeQuery(paymentStr);
      while (FactRS.next()){
	    int  num = FactRS.getInt("Period");
	    String  paymentdate = FactRS.getString("Gather_Date");
		int scale=FactRS.getInt("factmoney");
		String BillNo=FactRS.getString("Bill_Num");
		String Receiver=FactRS.getString("Receiver");
		String type="";
	if (num==0){type="订金";}
		else if (num>0&&num<4){type="房款";}
		else  if (num==5){type="花园/露台款";}
		else  if (num==6){type="改装款";}
       %>
	    <tr align="center" BGCOLOR="#e6f9ff"  onmouseout="mOut(this,'#e6f9ff');" onmouseover="mOvr(this,'#EAECEC');" >
        <td style="border-style: solid; border-width: 1" > <%=type %> </td>
	   
        <td style="border-style: solid; border-width: 1" ><%=paymentdate.substring(0,10)%></td>
        <td style="border-style: solid; border-width: 1" ><%=scale %>(元)</td>
		<td style="border-style: solid; border-width: 1" ><%=BillNo %></td>
		<td style="border-style: solid; border-width: 1" ><%=Receiver %></td>
       </tr>
	
	<%} 
	 out.print("</table>");
	 FactRS.close();
	}catch(Exception s){out.print(s.getMessage());}
  }
  %>
</div>
</body>
</html>
