<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>会员介绍客户一览</title>
<script language=javascript src="js/mad.js"> </script>
<script language=javascript src="../public_js/basal.js"> </script>
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

</head>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%> 
   

<%@ include file="../public_js/Repalce.jsp"%>
 
   
  <%
  
	int totalnum=0;
    String condtion="";		
    String eof="false";
	String sqlWhere="";
    String start="";
    String find="",strSecName="";
 
	 
	java.text.DecimalFormat df2 = new java.text.DecimalFormat("#######.####"); 
    java.text.DecimalFormat df1 = new java.text.DecimalFormat("###,###,###.####"); 
    
	 
    String findStr = "" ,seller="";
	String addressno=getbyte1(request.getParameter("addressno")); 
	
    String orderbytype=request.getParameter("orderbytype");
	String orderby=request.getParameter("orderby");
	String orderStr="";
	if(orderbytype==null)orderbytype="1";
	if(orderby==null)orderby="1";
    if(orderbytype.equals("1")){
	   orderStr = " order by loft,floors,room_no";
	}else {orderStr = " order by date ";}
	if(orderby.equals("0")){
	   orderStr = orderStr + " desc ";}
 if(!addressno.equals("")){
	   findStr = "  memberno='"+addressno+"'";}
 
		String sql="select  * from PrintReportContract where   " +findStr +orderStr;
	 
%>
<body topmargin="1"  >
 
<p align=center class=FontColor><font size=3><b> 会员介绍客户一览</b></font></p>
 
<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1  ALIGN=center  >
<tr  class=TXTColor> 
<td  align="right">序号</td>
<td  align="center">
 签约状态
</td>

<td  align="center">客户姓名</td>
<td  align="center">联系电话</td>
<td  align="center">房间代码</td>
<td  align="center">户型</td>
<td align="center">面积</td>
<!--<td  align="center">套内面积</td>-->
<td  align="center">成交总价</td>
<!--<td  align="center">折扣</td>-->
<td w align="center">付款方式</td>

<td  align="center">认购日期</td>
<td w align="center">额外优惠</td>
 <td  align="center">备  注</td>
	<%
	ResultSet rs=null;
	try{
		
	rs=ViewBean.executeQuery(sql);
	
	//保存输入值的变量
    String SerialNo="";
	String ContractNo="";
    String section="";
    String building="";
    String Room_no="";
    String area="";
    String area1="";
    String Customer="";
    String payment="";
    String buildtype="";
    String roomtype="";
	String salerprice;
    String ysumprice="";
	String date="";
	String cusno="";
	String secno="";
	String currency="";
	String sale=request.getParameter("sale");
	String subscription="";
	String disc="";
	String phone="";
	String Note="";
	String loft="";
	String floors="";
    String shouYouHui = "" ;
	String youhuidisc="";
	String youhuibak="";
	int i=0;
	 
   while (rs.next()){
	 eof="true";
     i=i+1;
   //按FIELDS顺序一GET　VALUE
  
	  
     SerialNo=getbyte(rs.getString("SerialNo"));
     Customer=getbyte(rs.getString("signatory"));
	  
     secno=getbyte(rs.getString("section"));
	 loft=getbyte(rs.getString("loft"));
     building=getbyte(rs.getString("building"));
	 
     Room_no=rs.getString("Room_no");

	 area=df2.format(rs.getFloat("area"));
	 area1=df2.format(rs.getFloat("jzarea"));
	 payment=getbyte(rs.getString("payment"));
	 if (payment.indexOf("揭")>0)payment=payment.substring(0,payment.indexOf("揭")+1);
	 buildtype=getbyte(rs.getString("buildtype"));
	 roomtype=getbyte(rs.getString("roomtype")); 
     ysumprice=df1.format(rs.getFloat("ysumprice"));
	 salerprice=df1.format(rs.getFloat("salerprice"));
	 seller=getbyte(rs.getString("Seller"));
	 boolean state=rs.getBoolean("state");

     //Fomrat date 
	 date=getbyte(rs.getDate("date").toString());
	 String rgdate=date;
	 
	 cusno=rs.getString("cusno");
	 section=getbyte(rs.getString("Name"));  
	 subscription=rs.getString("subscription");
	 currency=getbyte(rs.getString("currency"));
	 disc=getbyte(rs.getString("disc"));	
	 Note=getbyte(rs.getString("Note")); 
	 phone=getbyte(rs.getString("Phone"));
     ContractNo=getbyte(rs.getString("ContractNo"));

     shouYouHui=getbyte(rs.getString("youhui"));
	 floors=getbyte(rs.getString("floors"));
	 strSecName=getbyte(rs.getString("sectionname"));
	 youhuidisc=getbyte(rs.getString("ewdisc"));
	  youhuibak=getbyte(rs.getString("youhuibeizhu"));
	 
  %>
 <tr id=TR<%=i %> align="center" class=listcontent onmouseover="mout(this) ;" Onclick="savepara('<%=SerialNo%>','<%=secno%>','<%=building%>','<%=Room_no%>','<%=cusno%>','<%=section %>','<%=Customer %>','<%=date%>','<%=payment%>','<%=ysumprice%>','<%=seller%>','<%=subscription %>');changeclass1(this,'clickbg','listcontent');"  > 
<td   align="center"><%=i %></td>
<td  align="left">&nbsp;<%if (state){out.print("已签约");}else{out.print("未签约");} %>
 
</td>
<td   align="left">&nbsp;<a href="#" onclick="openwin('showContract.jsp?secno=<%=secno %>&roomno=<%=Room_no %>&build=<%=building %>&loft=<%=loft %>&Floor=<%=floors %>','')"><%out.print(Repalce(Customer,"/"));%></a>　</td>
<td  align="left">&nbsp;<%=Repalce(phone.trim(),"/").trim() %>&nbsp;</td>

<td   align="center">&nbsp;<%if (!strSecName.equals(loft)){out.print(strSecName);} %><%=loft+building+Room_no %>　</td>
<td  align="left">&nbsp;<%=roomtype%>　</td>
<td    align="right">&nbsp;<%=area1 %>　</td>
 
<td   align="right">&nbsp;<%=salerprice %></td>
 
<td  align="left">&nbsp;<a href="#" onclick="openwin('ShowPayView1.jsp?cusno=<%=cusno %>',400,300,200,50)"><%=payment %></a></td>
<td  align="left"&nbsp;><%=date %>　</td>
<td  align="left"&nbsp;><%=youhuidisc%>　</td>

<td  align="left"&nbsp;><%=youhuibak %>　</td>

 

</tr> 
 <%
 }
rs.close();
  out.print("</table>");

}catch(Exception s){out.print(s.getMessage()+sql);out.close();}
 
 %> </table>
     
 <%
 
String SQL="SELECT * from  SendMessage where messageType  =4  and customer='"+addressno+"'";
  rs=ViewBean.executeQuery(SQL);

 %>
    <p align="center"><font size=3>已发送短信明细表</font></p>
	  
<table BORDER=0 width="102%" CELLSPACING=0 CELLPADDING=0 bordercolor="#FFFFFF" ALIGN=center class="tablefill" >
    <tr class=listtitle align="center" > 
      <td  ><font color=white>序号</font></td>
	  <td  ><font color=white>会员名称</font></td>
      <TD  ><font color=white>短信内容</font></td>
	  <td ><font color=white>发送日期</font></td>

	  <td  ><font color=white>短信类别</font></td>
	 	  <td  ><font color=white>发送人</font></td>
   </tr>  
 <%
 int i=0;
 while (rs.next()){ 
 i++;
 %>
    <tr ondblclick="openwin('InputDj.jsp?code='+room_code,550,480,100,10);" id=TR<%=i %>  class=listcontent  align="center"  onmouseover="mout(this);"  onclick="changeclass1(this,'clickbg','listcontent');" title="双击可收取登记">
      <td  > <%=i %></td>
	  <td  align="left" > <%=getbyte(rs.getString("customer")) %> </td>
      <TD align="left" > <%=getbyte(rs.getString("message")) %> </td>
	  <td > <%=getbyte(rs.getDate("messageDate").toString()) %> </td>
	  <td  ><%
	  String messagetype =getbyte(rs.getString("messagetype")) ;
	  if (messagetype.equals("4"))out.print("客户关怀");
	 
	  
	  %> </td>
	  <td  > <%
	   String SendmessagePerosn=getbyte(rs.getString("SendmessagePerosn"));
	 
	   out.print(SendmessagePerosn);
	  %> </td>
	  
   </tr>  
 
 <%}rs.close(); %>  
 
</body>
 
</html>
