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
<title>业主统计表</title>
</head>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script Language="JavaScript" src="../public_js/basal.js"></script>
<%@ page language="java" import="java.sql.*,java.util.Date" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<body >
<%@ include file="../public_js/getByteOut.jsp"%>
<%!
   public String ShowPay(String FieldName,String sd,String ed) throws Exception  {
	 String  paymentStr = "select "+FieldName +",count(*) as  num from customer";
	 paymentStr+=" where serialno in (select customer from order_contract)  ";
 paymentStr+=" group by "+FieldName;
	 String  str="";
	 ResultSet paymentRS=null;
	//try{
	   ConnDatabase.SDatabase paymentListBean1=new ConnDatabase.SDatabase();
	   paymentRS = paymentListBean1.executeQuery(paymentStr);
		while (paymentRS.next()) {
		String groupname= getbyte(paymentRS.getString(FieldName));
		if(groupname.equals(""))groupname="未知";
             int  num = paymentRS.getInt("num");
	     str=str+"<tr align='center' class=listcontent >";
         str+="<td width='80%' bgcolor='#d1eaff'>"+groupname+" &nbsp;</td>";
         str+="<td  >"+String.valueOf(num)+" &nbsp;</td>";
         str+="</tr>";

 }  
   paymentRS.close();
   return str;
   
 }

%>
<%
String sd=getbyte1( request.getParameter( "sd" ) ) ;
String ed=getbyte1( request.getParameter( "ed" ) ) ;
 %>
 <form method="post">
<p  align=center>业主区域统计表</b></font></P>
 <!--<tr>
      <td   align="left" class=roomleft >登记日期</td>
      <td  class=roomright >
从<input type=text name=sd size=11 value="" readonly><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(sd);return false;" >
 到<input type=text name=ed size=11 value="" readonly><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(ed);return false;" ><input type=submit name=dd value="查询"></td>
    </tr>-->
<table BORDER=0 width="100%"  CELLSPACING=1 CELLPADDING=1 ALIGN=center >
  <tr  align="center" class=TXTColor>
    <td  valign="top" colspan=2>统计类别
	</td><td width="20%">人 数</td>
  </tr>
   
   <tr><td  align="center"width="20%" class=TXTColor>
  <b>区域</b></td>
  <td colspan="2">	
      <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >
     <%out.print(ShowPay("region",sd,ed)); %>
      </table>
    </td>
   </tr>
   

</table>
</form>
</body>

</html>
