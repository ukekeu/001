<%@ page contentType="text/html;charset=GBK" %>

<%@ include file="../public_js/checktime.jsp"%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>选房计价</title>
</head>
<%@ page language="java" import="java.sql.*,java.util.*,common.*" %> 
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="fat" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<body >

<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
 <%
 
  String code=getbyte2(request.getParameter("code"));
  String yh=getbyte2(request.getParameter("yh"));
 if (yh.indexOf("*")>=0)yh=fat.getFloat3(Double.parseDouble(yh.substring(0,yh.indexOf("*")))*Double.parseDouble(yh.substring(yh.indexOf("*")+1))/100,2);
 yh="97";
  ViewBean.executeUpdate("update room set readnum=readnum+1 where code in("+code+")");
   
  String sql="select R.seccode ,R.tnunitprice,R.loft,R.loft+R.room_code room_code,R.Room_Type,R.yong_tu,R.Area,R.RoomType,R.Direction,R.usedArea,R.Unitprice,R.Sumprice,S.Name from Room R inner join CRM_Project S on S.SerialNo=R.seccode where R.code in ("+code+")";
		 
		 String area="";
		 String jzarea="";
	  
		 String unitprice="",tnunitprice="";
		  String sumprice="";
		  String name="";
		  String room="";
		  String yongtu="";
		  String roomtype="";
		  String SaleArea="";
		  String room_code="";
		  String seccode="";
		ResultSet rs=ViewBean.executeQuery(sql);
		while (rs.next()){
		 seccode=getbyte(rs.getString("seccode"));
		  if (!roomtype.equals(""))
		     roomtype+=",";
		   roomtype+=getbyte(rs.getString("RoomType"));
		  if (!jzarea.equals(""))
		     jzarea+=",";
		   jzarea+=rs.getString("Area");
		   if (!area.equals(""))
		     area+=","; 
		   area+=rs.getString("usedArea");
		   
		    if (!unitprice.equals(""))
		     unitprice+=","; 
		   unitprice+= rs.getString("Unitprice");
		    if (!tnunitprice.equals(""))
		     tnunitprice+=","; 
		   tnunitprice+=rs.getString("tnunitprice");
		     if (!sumprice.equals(""))
		     sumprice+=","; 
			 
		   sumprice+= rs.getString("Sumprice");
		    if (!room_code.equals(""))
		     room_code+=","; 
			 room_code+=getbyte(rs.getString("room_code"));
	
		   name=getbyte(rs.getString("Name"));
		}rs.close();	
		
		
  StringTokenizer A1 = new StringTokenizer(room_code,",") ;
  int I1 = A1.countTokens() ; 
   StringTokenizer A2 = new StringTokenizer(jzarea,",") ;
  int I2 = A2.countTokens() ; 
   StringTokenizer A3 = new StringTokenizer(area,",") ;
  int I3 = A3.countTokens() ; 
   StringTokenizer A4 = new StringTokenizer(unitprice,",") ;
  int I4 = A4.countTokens() ; 
   StringTokenizer A5 = new StringTokenizer(tnunitprice,",") ;
  int I5 = A5.countTokens() ; 
   StringTokenizer A6 = new StringTokenizer(sumprice,",") ;
  int I6 = A6.countTokens() ; 
    StringTokenizer A7 = new StringTokenizer(roomtype,",") ;
  int I7 = A6.countTokens() ;
 %>
<form name=cus method=POST ACTION="">
<p align=center><font size=3 class=FontColor><b>意向房间基本资料</b></font></p>
<center>
  
<table BORDER=0 width="90%" CELLSPACING=1 CELLPADDING1 ALIGN=center bordercolor="#000000" class="tablefill">
<tr align="center" >
 <td>试算意向</td>
 <%try{
 int n=0;
 for (int nn=0;nn<I1;nn++) {n++;
 %>
 <td>意向单位<%=n %></td> 
 <%
}
 }catch(Exception s){}%> 
 </tr>
 <tr align="center" >
 <td>房号</td>
 <%try{
 while (A1.hasMoreElements()) {
 %>
 <td><%= (String)A1.nextElement()%></td> 
 <%
}
 }catch(Exception s){}%> 
 </tr>
  <tr align="center" >
 <td>户型</td>
 <%try{
 while (A7.hasMoreElements()) {
 %>
 <td><%= (String)A7.nextElement()%></td> 
 <%
}
 }catch(Exception s){}%> 
 </tr>
 <tr align="center" >
 <td>建筑面积(M<sup>2</sup>)</td>
 <%try{
 while (A2.hasMoreElements()) {
 %>
 <td><%= (String)A2.nextElement()%></td> 
 <%
}
 }catch(Exception s){}%> 
 </tr>
  <tr align="center" >
 <td>套内建筑面积(M<sup>2</sup>)</td>
 <%try{
 while (A3.hasMoreElements()) {
 %>
 <td><%= (String)A3.nextElement()%></td> 
 <%
}
 }catch(Exception s){}%> 
 </tr>
 
  <tr align="center" >
 <td>折前建筑面积单价(元/M<sup>2</sup>)</td>
 <%try{
 while (A4.hasMoreElements()) {
 %>
 <td><%= (String)A4.nextElement()%></td> 
 <%
}
 }catch(Exception s){}%> 
 </tr>
   <tr align="center" >
 <td>折前套内建筑面积单价(元/M<sup>2</sup>)</td>
 <%try{
 while (A5.hasMoreElements()) {
 %>
 <td><%= (String)A5.nextElement()%></td> 
 <%
}
 }catch(Exception s){}%> 
 </tr>
 
   <tr align="center" >
 <td>折前总价(元)</td>
 <%try{
 while (A6.hasMoreElements()) {
 %>
 <td><%= fat.getFloat2(Double.parseDouble((String)A6.nextElement()),0)%></td> 
 <%
}
 }catch(Exception s){}%> 
 </tr>
 <%if (java.lang.Integer.parseInt(yh)>0){ %>
 <tr align="center"><td>额外优惠</td>
  <% 
  
 for (int nnn=0;nnn<I1;nnn++) { 
 %>
 <td><%=yh %></td> 
 <%
  }
 %> 
 </tr>
 <tr align="center"><td>额外优惠后总价</td>
  <% 
     StringTokenizer A61 = new StringTokenizer(sumprice,",") ;
  int I61 = A61.countTokens() ; 
   try{
 while (A61.hasMoreElements()) {
 %>
 <td><%= fat.getFloat2(Double.parseDouble((String)A61.nextElement())*Double.parseDouble(yh)/100,0)%></td> 
 <%
}
 }catch(Exception s){}%> 
 
 </tr>
 
 <%} %>
 
</table>
<p align=center><font class=FontColor><b>
选择付款方式:
    <%
       sql="select * from PayMent where state=1 and seccoe='"+seccode+"' order by PayName";
      ResultSet rs3=ViewBean.executeQuery(sql);
	  String pay="";
	  String dic="0";
	  String dj="";
	  float dj1;
	  String num="";
	  String id="";
	  int i=0;
	  String pay1="";
	  String prepay="";
      String checkdisc="0";
  %>
  <table>
 <%
 String cs="";
 while (rs3.next()){
	    id=rs3.getString("ID");
		pay=getbyte(rs3.getString("PayName"));
		if (pay.indexOf("揭")>=0){
          	cs=pay.substring(pay.indexOf("(")+1,pay.indexOf("%"));
	     }
			
		if (pay.indexOf("%")>=0)
		pay1=pay.substring(0,pay.indexOf("%"))+"成"+pay.substring(pay.indexOf("%")+1);
		else pay1=pay;
		num=rs3.getString("num");
	   dic=rs3.getString("Discont");
		if (checkdisc.equals("0"))checkdisc=dic;
		 
		prepay=rs3.getString("prepay");
		String dic1=String.valueOf(dic);
		if (i==0){
		  out.print("<tr>");
		 }
	     out.print("<td><input type='checkbox' name=pay value="+id+" checked>"+pay+"*"+num+"*期</td>");
		 i++;
		 if (i==2)i=0;
		 if (i==0)out.print("</tr>");
	  }rs3.close();
	ViewBean.executeUpdate("update ChooseRoomDiscSet set discNum1="+getbyte2(request.getParameter("yh"))+" , discNum2="+getbyte2(request.getParameter("hy"))+" where sectionno='"+seccode+"'" );
     %></table>
	 
	 
  <input type=hidden vlaue="1" name=tax></b></font></p>
  <p align=center><input type=button name=submit1 value="提  交" onclick="SubCheck()">&nbsp;&nbsp;<input type=button name=close value="退  出"  onclick="window.close();">
</center>
 
</FORM>
<script>
 function SubCheck(){
      var FT="";
	  var paylist="";
	  
	  if (document.cus.pay.length){
		 for (var i=0;i<document.cus.pay.length;i++) {
		   if (document.cus.pay[i].checked){
		   if (paylist!="")paylist+=",";
		   paylist+=document.cus.pay[i].value;FT="TRUE";}
		 }
	     if (FT=="")
	     { 
		  alert("请选择付款方式");
		  return false;
		 }
	    
	 }else{
	  if (!document.cus.pay.checked)
	   { alert("请选择付款方式");
	     return false;
	   }	 
	   paylist=document.cus.pay.value
	 }
     <%//if (Double.parseDouble(dic)==Double.parseDouble(checkdisc)){ %> 
     window.location="printzybook1200710.jsp?code=<%=getbyte2(request.getParameter("code")) %>&paylist="+paylist+"&yh=<%=getbyte2(request.getParameter("yh")) %>&hy=<%=getbyte2(request.getParameter("hy")) %>&dic1=<%=dic %>";
   <%//}else{ %>
   // window.location="printzybook_new.jsp?code=<%=getbyte2(request.getParameter("code")) %>&paylist="+paylist+"&yh=<%=getbyte2(request.getParameter("yh")) %>&hy=<%=getbyte2(request.getParameter("hy")) %>&dic1=<%=dic %>";
  <%//} %>
   }
 SubCheck();
</script>
</body>

</html>
