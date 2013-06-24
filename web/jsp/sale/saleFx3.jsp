 <%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
 <jsp:useBean id="FormtD" scope="page" class="test.PieChart"/>  
<jsp:useBean id="FormtD1" scope="page" class="test.BarChartDemo"/>  
<jsp:useBean id="FormtD2" scope="page" class="test.DIYseries"/>  
  <%FormtD1.main1("D:/xa/crmv9/jsp/picture/pic1.jpg"); %>
    <%FormtD2.main1("D:/xa/crmv9/jsp/picture/pic2.jpg","select min(floor) minfloor,max(floor) maxfloor from room where floor>0 and  seccode='zlhy'","ffsdfs"); %>

 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/asiic.jsp"%> 
<html>
<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
	<title>销售分析</title>
</head>

<body>
 <P align="center"><font size=5>分&nbsp;析&nbsp;结&nbsp;果</font></P>
<%

 String aa[]=request.getParameterValues("fxzb");
 String section=request.getParameter("section");
   String Loft=getbyte1(request.getParameter("Loft"));
  
 String Date1=getbyte1(request.getParameter("Date1"));
 String Date2=getbyte1(request.getParameter("Date2"));
String dateWhere="";
 if (!Date1.equals(""))dateWhere+=" and o.date between '"+Date1+"' and '"+Date2+"'";
if (!Loft.equals(""))dateWhere+=" and o.loft='"+Loft+"'";
 float sumNum=0;
 String SQL= SQL="SELECT  count(*) num  FROM customer c,order_contract o,room r where o.section='"+section+"' "+dateWhere+" and c.serialno=o.customer and o.section=r.seccode and o.loft=r.loft and o.room_no =r.room_code ";
ResultSet rs=ViewBean.executeQuery(SQL);
 if (rs.next())sumNum=rs.getFloat("num");

 rs.close();

 int sumnum=0;
SQL="SELECT count(*) num  FROM room r where r.seccode='"+section+"'";
 rs=ViewBean.executeQuery(SQL);
 if (rs.next())sumnum=rs.getInt("num");
 rs.close();
 String currRoomCode="";
  SQL="SELECT  top 1  right(room_no,1) room_no  FROM order_contract o where o.section='"+section+"'";

   rs=ViewBean.executeQuery(SQL);
 if (rs.next())currRoomCode=rs.getString("room_no");
 rs.close();
 
 
  for (int nn=0;nn<aa.length;nn++){
  String StrAge="";
 
  String age1=request.getParameter("age1");
  String age2=request.getParameter("age2");
  if (aa[nn].equals("cus_age"))StrAge=" and c.cus_age>="+age1+" and  c.cus_age<= "+age2;
   String money1=request.getParameter("money1");
  String money2=request.getParameter("money2");
  
  if (aa[nn].equals("o.rmbprice"))StrAge=" and o.rmbprice*1.0/10000>="+money1+" and  o.rmbprice*1.0/10000<= "+money2;
    Loft="";
	Loft=getbyte1(request.getParameter("Loft"));
	if (!Loft.equals("")) Loft=" and o.loft='"+Loft+"'";
  SQL="SELECT "+aa[nn]+",count(*) num  FROM customer c,order_contract o,room r where o.section='"+section+"' "+StrAge+Loft+dateWhere+" and c.serialno=o.customer and o.section=r.seccode and o.loft=r.loft and o.room_no =r.room_code  group by "+aa[nn] +" order by "+aa[nn];

 rs=ViewBean.executeQuery(SQL);

 String messtitle="";
 String roomfileds="";
 String k_sale="";
 if (aa[nn].equals("o.roomtype")){k_sale="roomtype";messtitle="户型";roomfileds=" and r.roomtype";}
 else  if (aa[nn].equals("o.loft")){k_sale="loft";messtitle="楼栋";roomfileds=" and r.loft";}
 else  if (aa[nn].equals("r.room")){k_sale="room";messtitle="房号";roomfileds=" and r.room";}
 else  if (aa[nn].equals("o.jzarea")){messtitle="建筑面积";roomfileds=" and r.area";}
 else  if (aa[nn].equals("o.floors")){k_sale="floor";messtitle="楼层";roomfileds=" and r.floor";}
 else  if (aa[nn].equals("o.payment1"))messtitle="付款方式";
 else  if (aa[nn].equals("o.zx")){k_sale="fitment";messtitle="装修标准";roomfileds=" and r.fiment";}
 else  if (aa[nn].equals("o.buildtype")){messtitle="用途";roomfileds=" and r.buildtype";}
 else  if (aa[nn].equals("o.ajbk"))messtitle="按揭银行";
 else  if (aa[nn].equals("o.ajyear"))messtitle="按揭年限";
 else  if (aa[nn].equals("c.region"))messtitle="客户所在区域";  
 
 
 
 
 List list1=new LinkedList();
 List list2=new LinkedList();
 List list3=new LinkedList();

if (!k_sale.equals("")){
 SQL="SELECT "+k_sale+",count(*) num  FROM room r where r.seccode='"+section+"'  group by "+k_sale+" order by "+k_sale;
 
ResultSet rs1=ViewBean1.executeQuery(SQL);
%>

<br> <br>
<table height=16  width="100%" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<tr><td height=16  width="20%">&nbsp;<%=messtitle %></td><td height=16  width="20%">可售套数</td><td height=16  width="20%">已销售套数</td><td height=16  width="20%">比例(占可销售)</td></tr>
<%list1.clear();list2.clear();
String nnn="0";
String a1="";
int k_n=0;
int y_n=0;
  while (rs.next()){
    
	if (aa[nn].equals("o.jzarea"))
     a1=FormtD.getFloat(rs.getFloat(aa[nn].substring(aa[nn].indexOf(".")+1)),3);
    else if (aa[nn].equals("r.room")){
	 a1=getbyte(rs.getString(aa[nn].substring(aa[nn].indexOf(".")+1)));
	 char BeR=currRoomCode.charAt(0);
     a1=AsiicZH(java.lang.Integer.parseInt(a1),BeR)  ;
    }
	else 
	 a1=getbyte(rs.getString(aa[nn].substring(aa[nn].indexOf(".")+1)));	
	if (a1.equals(""))a1="未知";
	nnn=getbyte(rs.getString("num"));
	list1.add(a1);
	list2.add(nnn);
}	
  rs.close();
   while (rs1.next()){
   String cc=getbyte(rs1.getString(k_sale));
   String n1=rs1.getString("num");
   k_n+=Integer.parseInt(n1);
    String num="0";
   if (list1.contains(cc)){
	 int index=list1.indexOf(cc);
	 num=(String)list2.get(index);
	 y_n+=Integer.parseInt(num);
   }
 %>
  <tr><td height=16  width="20%">&nbsp;<%=cc%></td><td height=16 
 width="20%">&nbsp;<%=n1 %></td>
 <td height=16  width="20%">&nbsp;<%=num %></td>
<td width="30%">&nbsp;<%if (Integer.parseInt(num)>0){ %><img src="../images/line.gif" height=16  width="<%=FormtD.getFloat2(Integer.parseInt(num)*1.0/Integer.parseInt(n1)*100,2) %>"><%=FormtD.getFloat2(Integer.parseInt(num)*1.0/Integer.parseInt(n1)*100,2) %>%<%} %></td>
</tr>
 <%
 }
 rs1.close();
 %>
 <tr  ><td >合计:</td><td>&nbsp;<%=k_n %></td><td>&nbsp;<%=y_n %></td><td>&nbsp;<img src="../images/line.gif" height=16  width="<%=y_n*1.0/k_n*100 %>"><%=FormtD.getFloat2(y_n*1.0/k_n*100,2)  %>%</td></tr>
 <%
 out.print("</table>");
 }else{
 
 %>
 
 <br> <br>
<table height=16  width="100%" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<tr><td height=16  width="20%">&nbsp;<%=messtitle %></td><td height=16  width="20%">已销售套数</td><td height=16  width="20%">比例(占已销售)</td></tr>
<%

  
  while (rs.next()){
    String a1="";
	if (aa[nn].equals("o.jzarea"))
     a1=FormtD.getFloat(rs.getFloat(aa[nn].substring(aa[nn].indexOf(".")+1)),3);
    else if (aa[nn].equals("r.room")){
	 a1=getbyte(rs.getString(aa[nn].substring(aa[nn].indexOf(".")+1)));
	 char BeR=currRoomCode.charAt(0);
     a1=AsiicZH(java.lang.Integer.parseInt(a1),BeR)  ;
    }
	else 
	 a1=getbyte(rs.getString(aa[nn].substring(aa[nn].indexOf(".")+1)));	
	if (a1.equals(""))a1="未知";
	String nnn=getbyte(rs.getString("num"));
	 int group=0;
/*SQL="SELECT count(*) num  FROM room r where r.seccode='"+section+"'"+roomfileds;
 rs=ViewBean.executeQuery(SQL);
 if (rs.next())sumnum=rs.getInt("num");
 rs.close();*/
%>
<tr><td height=16  width="20%">&nbsp;<%=a1%></td><td height=16  width="20%">&nbsp;<%=nnn %></td>
<td width="30%">&nbsp;<%if (Integer.parseInt(nnn)>0){ %><img src="../images/line.gif" height=16  width="<%=FormtD.getFloat(Integer.parseInt(nnn)/sumNum*100,2) %>"><%=FormtD.getFloat(Integer.parseInt(nnn)/sumNum*100,2) %>%<%} %></td>
	

</tr>
<%
  }
  rs.close();
 %>
 <tr ><td >合计:</td><td>&nbsp;<%=String.valueOf(sumNum).substring(0,String.valueOf(sumNum).indexOf(".")) %></td><td>&nbsp;<img src="../images/line.gif" height=16  width="<%=Integer.parseInt(String.valueOf(sumNum).substring(0,String.valueOf(sumNum).indexOf(".")))*1.0/sumnum*100 %>"><%=FormtD.getFloat2(Integer.parseInt(String.valueOf(sumNum).substring(0,String.valueOf(sumNum).indexOf(".")))*1.0/sumnum*100,2)  %>%(占可售套数)</td></tr>
</table>
 <br>
<%} 
}%>

</body>
</html>
