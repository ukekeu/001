<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page import = "java.sql.*" %>
<%@ include file="../public_js/qx_checke.jsp"%>
<jsp:useBean id = "ajListBean" scope = "page" class = "ConnDatabase.SDatabase" />
<%@ include file="../public_js/logrecord.jsp" %>

<html>
<head>
	<title></title>
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>

<body leftMargin=1 topMargin=0 rightMargin=0>
 <% String sel=(String)request.getParameter("sel");
 
  
   if(sel==null) sel="1"; %>
 
    <p align="center"><b><font size="3">我的任务提醒</font></b></P>
	<center>
<table width="90%" border=0 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

<tr><td>
<table width="360" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("1")){out.print("paneselect3");}else{out.print("panemenu3");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('../TodayRemark/QYCustomer.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>应签约客户</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;findSub('../TodayRemark/SKCustomer.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>应交款客户</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('../TodayRemark/TxAjCustomer.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>办按揭客户</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("paneselect3");}else{out.print("panemenu3");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('../TodayRemark/CACustomer.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>应出案客户</font></a>
	</td>
	</tr></table>
  
  
</center>
<script>
function findSub(para){
   document.frm.action=para;
   document.frm.submit();


}
</script>
</body>
</html>
