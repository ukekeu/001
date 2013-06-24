<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%> 
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/> 
<%@ include file="../public_js/getByteOut.jsp"%>

<html>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<head>
	<title>临订订金管理</title>
</head>
<script language="javascript" src="../public_js/public.js">
</script>
<body>
<%
 
String SQL="SELECT  s.roomcode,c.cus_name,l.name+r.loft+r.Room_code Room_code,s.StartDate,s.Subscription,s.billtype,s.bill_num,s.paytype,s.zto  from  SL_TemporarilyBuy s,room r,customer c,section l where s.Cusname=c.serialno and s.RoomCode=r.code and r.seccode=l.serialno";
ResultSet rs=aBean.executeQuery(SQL);

 %>
    <p align="center"><font size=3>临订订金明细表</font></p>
	<!-- <img src="../picture/button_tg.gif" title="订金收取"  onclick="openwin('InputDj.jsp?code='+room_code,550,480,100,10);"><img  src="../picture/button_xg.gif" title="修改" onclick="openwin('InputDj.jsp?code='+room_code,550,480,100,10);" > -->
 
<table BORDER=0 width="102%" CELLSPACING=0 CELLPADDING=0 bordercolor="#FFFFFF" ALIGN=center class="tablefill" >
    <tr class=listtitle align="center" > 
      <td  ><font color=white>序号</font></td>
	  <td  ><font color=white>客户名称</font></td>
      <TD  ><font color=white>临订单位</font></td>
	  <td ><font color=white>临订日期</font></td>
	  <td  ><font color=white>订金</font></td>
	  <td  ><font color=white>票据</font></td>
	  <td  ><font color=white>票据编号</font></td>
	  <td ><font color=white>付款方式</font></td>
	  <td ><font color=white>是否结转</font></td>
   </tr>  
 <%
 int i=0;
 while (rs.next()){ 
 i++;
 %>
    <tr ondblclick="openwin('InputDj.jsp?code='+room_code,550,480,100,10);" id=TR<%=i %>  class=listcontent  align="center"  onmouseover="mout(this);"  onclick="savepara('<%=getbyte(rs.getString("roomcode"))%>');changeclass1(this,'clickbg','listcontent');" title="双击可收取登记">
      <td  > <%=i %></td>
	  <td  align="left" > <%=getbyte(rs.getString("cus_name")) %> </td>
      <TD align="left" > <%=getbyte(rs.getString("room_code")) %> </td>
	  <td > <%=getbyte(rs.getDate("StartDate").toString()) %> </td>
	  <td  ><%=getbyte(rs.getString("Subscription")) %> </td>
	  <td  > <%
	   String BillType=getbyte(rs.getString("billtype"));
	   if (BillType.equals("0"))BillType="收据";
	   if (BillType.equals("1"))BillType="发票";
	   out.print(BillType);
	  %> </td>
	  <td  > <%=getbyte(rs.getString("bill_num")) %> </td>
	  <td > <%=getbyte(rs.getString("paytype")) %></td>
	  <td > <%
	  String sate=getbyte(rs.getString("zto")) ;
	   if (sate.equals("0"))sate="未结转";
	   if (sate.equals("1"))sate="已结转";
	      out.print(sate);
	   %> </td>
   </tr>  
 
 <%}rs.close(); %>  
<script>
var room_code="";
 function savepara(para){
	  room_code=para;
  }
</script>
</body>
</html>
