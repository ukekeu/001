<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "收款凭证" , 
                  "浏览"
                ) ;
%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>收款明细表</title>
</head> 
<script language="javascript" src="../public_js/basal.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

<script language="javascript" src="../public_js/public.js">
</script>
<script language=javascript src="../sale/js/mad.js"> </script>
 
<body>

<%
String SecNo=request.getParameter("SecNo");
String Date1=request.getParameter("Date1");
String Date2=request.getParameter("Date2");

String sel=(String)request.getParameter("sel");
String chhosetype=(String)request.getParameter("chhosetype");
  
   if(sel==null) sel="1";				
   if(chhosetype==null) chhosetype="1";	

String SQL="SELECT vono, 日期,期间,摘要,科目代码,科目名称,币别,原币金额,借方,贷方,经办人,结算方式 from KVoucher order by vono desc,借方 desc";
ResultSet rs = ViewBean.executeQuery(SQL) ;
 
 %>
 <form name=frm>
<input type=hidden name=sel value="<%=sel%>">
 <input type=hidden name=SecNo value="<%=SecNo%>">
 <input type=hidden name=Date1 value="<%=Date1%>">
 <input type=hidden name=Date2 value="<%=Date2%>">
 <table width="95%" border=0 cellspacing='0'  cellpadding='0'>
  <tr align="center"> 
   <td class="titlesize"> 凭证明细表</td>
  </tr>
  </table>
  <br>
    <table width="270" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;document.frm.action='FactGatherList.jsp';document.frm.submit();"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>未生成细表</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;document.frm.action='FactGatherList1.jsp';document.frm.submit();"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>凭证明细</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;document.frm.action='FactGatherList.jsp';document.frm.submit();"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>已生成明细</font></a>
	</td>
	</tr>
	</table>
 <table width="95%" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr> 
   <td>&nbsp;</td><td>日期</td><td>期间</td><td>摘要</td>
   <td>科目代码</td><td>科目名称</td>
   <td>币别</td><td>原币金额</td><td>借方</td><td>贷方</td>
   <td>结算方式</td><td>经办人</td> 
  </tr>
  <%
  String vono1="";
  String vono="";
   while (rs.next()){
    vono1=rs.getString("vono");
	if (vono1.equals(vono)&&!vono.equals("")){
	%>
	
	<%
	}
   %> 
   <tr> 
   <td>&nbsp;<input type="checkbox" value="" name=vo></td><td><%=getbyte(rs.getDate("日期").toString())%>&nbsp;</td>
<td><%=getbyte(rs.getString("期间"))%>&nbsp;</td>
<td><%=getbyte(rs.getString("摘要")) %>&nbsp;</td>
<td><%=getbyte(rs.getString("科目代码"))%>&nbsp;</td>
<td><%=getbyte(rs.getString("科目名称"))%>&nbsp;</td>
<td><%=getbyte(rs.getString("币别"))%>&nbsp;</td>
<td><%=getbyte(rs.getString("原币金额"))%>&nbsp;</td>
<td><%=getbyte(rs.getString("借方"))%>&nbsp;</td>
<td><%=getbyte(rs.getString("贷方")) %>&nbsp;</td>
<td><%=getbyte(rs.getString("结算方式")) %>&nbsp;</td>
<td><%=getbyte(rs.getString("经办人")) %>&nbsp;</td>
  </tr>
  <%}
  rs.close(); %>
</body>
</form>
</html>