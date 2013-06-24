<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>客户意向/来信来源/关注问题统计</title>
</head>
<%@ page language="java" import="java.sql.*,java.util.Date" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<body >
<%@ include file="../public_js/getByteOut.jsp"%>
<%!
   public String ShowPay(String FieldName,String SecNo) throws Exception  {
	 String  paymentStr = "select "+FieldName +",count(*) as  num from customer where section='"+SecNo+"' group by "+FieldName;
	 String  str="";
	 ResultSet paymentRS=null;
	//try{
	   ConnDatabase.SDatabase paymentListBean1=new ConnDatabase.SDatabase();
	   paymentRS = paymentListBean1.executeQuery(paymentStr);
		while (paymentRS.next()) {
		String groupname= getbyte(paymentRS.getString(FieldName));
		int  num = paymentRS.getInt("num");
		if (groupname.equals(""))groupname="未知";
	     str=str+"<tr align='center' class=listcontent >";
         str+="<td width='80%' bgcolor='#d1eaff'>"+groupname+" &nbsp;</td>";
         str+="<td  >"+String.valueOf(num)+" &nbsp;</td>";
         str+="</tr>";

 }  
   paymentRS.close();
   return str;
   
 }

%>

<p  align=center>客户分析统计表</b></font></P>
<table BORDER=0 width="100%"  CELLSPACING=1 CELLPADDING=1 ALIGN=center >
  <tr  align="center" class=TXTColor>
    <td  valign="top" colspan=2>统计类别
	</td><td width="20%">人 数</td>
  </tr>
  <tr><td  align="center"width="20%" class=TXTColor>
  <b>客户意向</b></td>
  <td width="70%" colspan="2">	
      <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >
      <%
	  try{
	 
	  out.print(ShowPay("demand",request.getParameter("SecNo")));
	  }catch(Exception s){out.print(s.getMessage());} %>
      </table>
    </td>
   </tr>
   <tr><td  align="center"width="20%" class=TXTColor>
  <b>信息来源</b></td>
  <td width="53%" colspan="2">	
      <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >
      <%out.print(ShowPay("Knowledge_From",request.getParameter("SecNo"))); %>
      </table>
    </td>
   </tr>
   <tr><td  align="center"width="20%" class=TXTColor>
  <b>关注问题</b></td>
  <td colspan="2">	
      <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >
     <%out.print(ShowPay("attention",request.getParameter("SecNo"))); %>
      </table>
    </td>
   </tr>
    <tr><td  align="center"width="20%" class=TXTColor>
  <b>客户所在区域</b></td>
  <td colspan="2">	
      <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >
     <%out.print(ShowPay("region",request.getParameter("SecNo"))); %>
      </table>
    </td>
   </tr>
   
   

</table>

</body>

</html>
