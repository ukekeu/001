<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<title>������ϸ</title>
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
<a href="javascript:window.history.back(1);">����</a>
<div align="center">
<table width="100%" border="0">
  <tr>
    <td>
      <div align="center"><font size=3>Ӧ������ϸ</font></div>
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
      <div align="center">������</div>
    </td>
    
    <td bgcolor="#cfe6eb"> 
      <div align="center">Ӧ��������</div>
    </td>
    <td bgcolor="#cfe6eb"> 
      <div align="center">Ӧ������</div>
    </td>
   <td bgcolor="#cfe6eb"> 
      <div align="center">�Ƿ��ѽ�</div>
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
		if (state==0){st="δ��";}
		else if (state==1){st="�ѽ�����";}
		else if (state==2){st="�ѽ���";}
        String type="";
		if (num==0){type="����";}
		else if (num>0&&num<4){type="����";}
		else  if (num==5){type="��԰/¶̨��";}
		else  if (num==6){type="��װ��";}
%>
    <tr align="center" BGCOLOR="#e6f9ff"  onmouseout="mOut(this,'#e6f9ff');" onmouseover="mOvr(this,'#EAECEC');" >
    
	<td style="border-style: solid; border-width: 1" ><%=type %> </td>
 
    <td style="border-style: solid; border-width: 1" ><%=paymentdate.substring(0,10)%></td>
    <td style="border-style: solid; border-width: 1" ><%=scale %>(Ԫ)</td>
    <td style="border-style: solid; border-width: 1" > <%=st %>  </td>
  </tr>
 <%}
 out.print("</table>");
  paymentRS.close();

  if (cusno!=null){
  %>
  <p>
  �Ѹ������:<br>
  <table width="100%" border="1" cellpadding="0" cellspacing="0">
  <tr> 
     <td bgcolor="#cfe6eb"> 
      <div align="center">������</div>
    </td>
 
    <td bgcolor="#cfe6eb"> 
      <div align="center">ʵ������</div>
    </td>
    <td bgcolor="#cfe6eb"> 
      <div align="center">ʵ�ս��</div>
    </td>
	<td bgcolor="#cfe6eb"> 
      <div align="center">Ʊ�ݱ��</div>
    </td>
	<td bgcolor="#cfe6eb"> 
      <div align="center">������</div>
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
	if (num==0){type="����";}
		else if (num>0&&num<4){type="����";}
		else  if (num==5){type="��԰/¶̨��";}
		else  if (num==6){type="��װ��";}
       %>
	    <tr align="center" BGCOLOR="#e6f9ff"  onmouseout="mOut(this,'#e6f9ff');" onmouseover="mOvr(this,'#EAECEC');" >
        <td style="border-style: solid; border-width: 1" > <%=type %> </td>
	   
        <td style="border-style: solid; border-width: 1" ><%=paymentdate.substring(0,10)%></td>
        <td style="border-style: solid; border-width: 1" ><%=scale %>(Ԫ)</td>
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
