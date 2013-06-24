<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/news.css" rel=stylesheet>
<title>今日应签约客户</title>
</head>

<%@ page language="java" import="java.sql.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="setpro" scope="session" class="setProperty.setProperty"/> 

<body>
<DIV id="Layer1" style="position: absolute; left: 0; top: -7; width: 600; height: 242; z-index: 1">
<hr width=635> 
</div>
<DIV id="Layer1" style="position: absolute; left: 0; top: 5; width: 635; height: 242; z-index: 1">
<script language="javascript" src="../public_js/public.js">
</script>
  <form method="POST" name="cus" action="QYCustomerPrt.jsp">
  <%
  //get session value

	String user = setpro.getId();
	String type = setpro.getType();
	boolean sale = setpro.getSale();
	boolean hasRight = false;
	if (user==null)
	 {%> 你已超时,<a href="../default.htm" target="_blank">请重新登录</a> <%out.close();}%> 
  
   <table BORDER=0 width="100%" class=parent id=KB3Parent CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
  <tr bgcolor="#CFE6EB">
      <td valign="top" colspan="2"> 
        <p align="center"><b><font size="3" color="#000080">今日应签约客户</font></b>
      </td>
    </tr>
    <tr> 
      <td valign="top" height="10" colspan="2"></td>
    </tr>	
	</table>
    
<%
String StrWhere="";
StrWhere=request.getParameter("PrintState");
String DisplayS=request.getParameter("StrWhereD");

String sql="";

	//Fomrat date
    java.text.SimpleDateFormat Sdate =null;
    Sdate=new java.text.SimpleDateFormat("MM-dd-yyyy");
	String Today=Sdate.format(new java.util.Date()).toString();
		
	//设定查询
	if (StrWhere.length()>0) {
		if (DisplayS.equals("Today")) {
	   		sql="select * from VIEW_QYCustomer where ID>0 and "+StrWhere+" and VisaDate='"+Today+"'  order by ID DESC";
			hasRight = true;
		}else{
			sql="select * from VIEW_QYCustomer where ID >0 and  VisaDate<'"+Today+"' order by ID DESC";
			hasRight = true;
		}
//out.print(sql);
//设置查询结果的存放变量
int ID=0;
String Section="";
String Building="";
String Room="";
String CusName="";
String SerialNo="";
String Date="";
String SalePrice="";
String State="";

//out.print(sql);
//Add try...catch for search,2001-09-06
try{
	ResultSet rs=ViewBean.executeQuery(sql);
	if(rs.next()){
		Section=rs.getString("Name");
	}
%>
 <table BORDER=0 width="100%" class=parent id=KB3Parent CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
  <tr bgcolor="#CFE6EB">
      <td width="504" valign="top" bgcolor="#96C7D1">楼盘: <%=Section%></td>      
    </tr>
  </table>
   <table BORDER=0 width="100%" class=parent id=KB3Parent CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
  <tr bgcolor="#CFE6EB">
      <td width="13%" align="center" height="23" bgcolor="#CFE6EB" >栋号</td>
      <td width="9%" align="center" height="23" bgcolor="#CFE6EB" >房号</td>
      <td width="13%" align="center" height="23" bgcolor="#CFE6EB" >客户</td>
      <td width="16%" align="center" height="23" bgcolor="#CFE6EB" >认购书编号</td>
      <td width="14%" align="center" height="23" bgcolor="#CFE6EB" >认购日期</td>
      <td align="center" height="23" width="17%" bgcolor="#CFE6EB" >成交价</td>
    </tr>
<%
	while (rs.next()){
	  //按FIELDS顺序一GET　VALUE
	  ID=rs.getInt("ID");
	  
	  Building=rs.getString("building");
	  Room=rs.getString("Room_no");
	  CusName=rs.getString("Cus_Name");
	  SerialNo=rs.getString("SerialNo");
	  Date=rs.getString("Date");
	  //Fomrat date
	  java.text.SimpleDateFormat date =null;
	  date=new java.text.SimpleDateFormat("yyyy-MM-dd");
	  Date=date.format(date.parse(Date));
	  
	  SalePrice=rs.getString("SalerPrice");
	  //Modify by freejoy,2001-09-05, format the Money
	  java.text.DecimalFormat MoneyFormat = new java.text.DecimalFormat(" ###,###,##0.00");
	  SalePrice=MoneyFormat.format(java.lang.Float.parseFloat(SalePrice));
	  if(java.lang.Integer.parseInt(SalePrice.substring(SalePrice.indexOf(".")+1))==0){
		   SalePrice=SalePrice.substring(0,SalePrice.indexOf("."));
	  } 
 %> 
    
	<tr align="center" BGCOLOR="#e6f9ff"  onmouseout="mOut(this,'#e6f9ff');" onmouseover="mOvr(this,'#EAECEC');"> 
      <td width="13%"  height="16" style="border-style: solid; border-width: 1"><%=Building%></td>
      <td width="9%"  height="16" style="border-style: solid; border-width: 1"><%=Room%></td>
      <td width="13%"  height="16" style="border-style: solid; border-width: 1"><%=CusName%></td>
      <td width="16%"  height="14" style="border-style: solid; border-width: 1"><%=SerialNo%></td>
      <td width="14%"  height="14" style="border-style: solid; border-width: 1"><%=Date%></td>
      <td height="10" width="17%" style="border-style: solid; border-width: 1"><%=SalePrice%></td>
    </tr>
    <%
  }
  rs.close();
  
}catch(Exception se){
	out.print("系统出错，出错如下：");
	out.print(se.getMessage());
	out.print(sql);
	out.close(); 
}
}
%> 
  </table>
  <hr size="1" color="#C0C0C0">
</div>
</body>
</form>
</html>