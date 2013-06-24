<%@ page contentType="text/html;charset=GBK" %>

 

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>付款进度</title>
<script language=javascript src="js/mad.js"> </script>
<script language=javascript src="../public_js/basal.js"> </script>
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
</head>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
    <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<body topmargin="1">
<%
    String strLoft = getbyte1(request.getParameter("Loft"));
    String SecNo = getbyte1(request.getParameter("SecNo"));
    String strBuild =  getbyte1(request.getParameter("Build"));
	String strSecName =getbyte1( request.getParameter("SecName"));
    String sel=(String)request.getParameter("sel");
    if(sel==null) sel="0";	  
	    java.text.DecimalFormat df1 = new java.text.DecimalFormat("###,###,###.###"); 
		java.text.DecimalFormat df2 = new java.text.DecimalFormat("###,###,###"); 
 %>
<form action="contract_view.jsp" method="post" name="frm">
<input type=hidden name=SecNo value="<%=SecNo %>">
 
<input type=hidden name=Loft value="<%=strLoft %>">
<input type=hidden name=Build value="<%=strBuild %>">
 <input type=hidden name=SecName value="<%=strSecName %>">
 
<table width="650" border="0" cellspacing="0" cellpadding="0" class="L2">
     
<tr>
    <td class="<%if(sel.equals("4")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=4;findSub('jy_list.jsp');"><font color='<%if(sel.equals("4")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>交易一览</font></a>
	</td>
	  <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('ContractNoM.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>合同号管理</font></a>
	</td>
	
	  <td class="<%if(sel.equals("5")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=5;findSub('contract_check.jsp');"><font color='<%if(sel.equals("5")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>合同审核</font></a>
	</td>
	 <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=0;findSub('ContractJz.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>备案管理</font></a>
	</td>
	<!-- <td class="<%if(sel.equals("9")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=9;findSub('contract_yj.jsp');"><font color='<%if(sel.equals("9")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>移交管理</font></a>
	</td>
	-->
	<td class="<%if(sel.equals("6")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=6;findSub('rh_view.jsp');"><font color='<%if(sel.equals("6")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>入户管理</font></a>
	</td>
	
  <!--
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('contract_view.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>已审核合同</font></a>
	</td>
	-->
	
	
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;findSub('paymoneyProcess.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>付款进度</font></a>
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
<p align=center class=FontColor><font size=4><b><%if (!strSecName.equals(strLoft)){out.print(strSecName);} %><%=strLoft %> </b></font></p>
<input type=button name=outexce value="导出到ECXECL" onclick="openwin1('paymentprocessExcel.jsp?Loft<%=strLoft %>&SecNo=<%=SecNo %>',100,100,100,100);">
<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1  ALIGN=center  >
<tr  class=TXTColor> 
<td  align="right">序号</td>
<td  align="center">客户姓名</td>
<td  align="right">房间代码</td>

<td  align="center">面积</td>
<td  align="center">成交总价(元)</td>
<td  align="center">付款方式</td>
<td  align="center">付款进度</td>
</tr>
 
<%
  String SQL="SELECT romno , jzarea,cus_name,saleRprice*rate saleprice,payment1 ,case when salerprice>0 then factmoney*1.0/salerprice*rate*100 else 0 end  process FROM viewsalelist WHERE  section='"+SecNo+"' ";
  if (!strLoft.equals(""))SQL+=" and   LOFT='"+strLoft+"'";
 
		 ResultSet rs=ViewBean.executeQuery(SQL+"order by romno");
         int i=0;
         while (rs.next()){ 
		    i++;
		    String  romno=getbyte(rs.getString("romno"));
		    String  jzarea=FormtD.getFloat3(rs.getDouble("jzarea"),2);
		    String  cus_name=getbyte(rs.getString("cus_name"));
			String  saleprice=FormtD.getFloat3(rs.getDouble("saleprice"),2);
			String  payment=getbyte(rs.getString("payment1"));
			double  process= rs.getDouble("process");
			%>
			<tr  class=listcontent > 
			<td  align="center"><%=i %></td>
			<td  align="center"><%=cus_name %></td>
			<td  align="right"><%=romno %></td>
			
			<td  align="center"><%=jzarea %></td>
			<td  align="center"><%=saleprice %></td>
			<td  align="center"><%=payment %></td>
			<td  align="left">&nbsp;
			<img src="../images/line.gif" height=16  width="<%=FormtD.getFloat3(process,2) %>"> 
			<%=FormtD.getFloat3(process,2) %>%
			</td>
			</tr>
		<% }%>
		 
 
</body>
</html>
