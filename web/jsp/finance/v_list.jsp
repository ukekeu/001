<%@ page contentType="text/html;charset=GBK" %>

 
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 
<title>导出凭证</title>
 
</head>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/checktime.jsp"%>
 
<% 
 
 
 
  String stdate = China.getParameter(request,"Date1") ;
  String endate = China.getParameter(request,"Date2") ;
  String SectionName=China.getParameter(request,"SecNo") ; 
   SectionName=SectionName.substring(0,SectionName.indexOf("-"));
  String Region = China.getParameter(request,"Region") ; 
   String room=getbyte1(request.getParameter("room"));
  String Loft=getbyte1(request.getParameter("Loft"));
  String yong_tu=getbyte1(request.getParameter("yong_tu"));
String saletype=getbyte1(request.getParameter("saletype"));
if (saletype.equals("1"))saletype=" and a.state=1";
else if (saletype.equals("2"))saletype=" and a.state=2";
else if (saletype.equals("0"))saletype=" ";
   String sql=""; 
   sql="select    c.id,a.sectionname+a.loft+a.room_no as room,b.cus_name,c.factmoney*c.currrate as factmoney,c.Gather_Date,c.Receiver,c.PayType from order_contract a,customer b,factgatheringrecord c  where c.checkstate=1 and c.v=0 and  c.contractno=a.code and a.customer=b.serialno and  a.state<>3 and convert(char(10),a.date,120)>='"+stdate+"' and convert(char(10),a.date,120)<='"+endate+"' and a.section='"+SectionName+"' "+saletype;
    if (!Loft.equals(""))
	  sql+=" and a.loft='"+Loft+"' ";
	   if (!room.equals(""))
	  sql+=" and a.Room_no='"+room+"'";
	    if (!yong_tu.equals(""))
	  sql+=" and a.yong_tu='"+yong_tu+"'";
  sql+=" order by a.loft,a.floors,a.room_no,c.Gather_Date";
  
  ResultSet rs=null;
   int nn=0,i=1;
   double sump=0;
   double suma=0;
   double suml=0;
  double sum2=0;
   double sum3=0;
   double sum4=0;
   double sum5=0;
  try{
  	rs=ViewBean.executeQuery(sql);
  
 %>

<script>
function chhoseData(dd){
   for (var i=0;i<document.frm.v.length;i++){
 	  document.frm.v[i].checked=dd;
	 
    }

}

</script>
  
<body>
<form action="check_v.jsp" method="post" name="frm">
  <input type=button name=ok value="提交" onclick="frm.submit();">
 
 <font size=3><div id=tit align="center"><%if (getbyte1(request.getParameter("saletype")).equals("1")){out.print("收款明细表");}else if (getbyte1(request.getParameter("saletype")).equals("2")){out.print("收款明细表");}else{out.print("收款明细表");} %>  </div></font>
 
 <table width="99%"><tr><td colspan="3">时间段:<%=China.getParameter(request,"Date1")%>到<%=China.getParameter(request,"Date2") %></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></table>
 
 <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

 <tr  > 
<td  align="right">序号</td>
 
<td  align="center">客户名称</td>
<td  align="center">房间代码</td>
<td align="center">交款时间</td>
<td w align="center">付款方式</td>

<td  align="center">交款金额</td>
 
<td  align="center" valign="middle">
选择<input type=checkbox name=vv onclick="chhoseData(this.checked);" >
 </td>
 </tr>
 <%while (rs.next()){ %>  
 <tr   align="center">
<td   align="center"><%=i %></td>
<td  align="left">&nbsp;<%=rs.getString("cus_name") %></td>
<td   align="left">&nbsp;<%=rs.getString("room") %>　</td>
<td   align="center">&nbsp;<%=rs.getDate("Gather_Date").toString()%>　</td>
 
<td    align="right">&nbsp;<%=rs.getString("PayType") %>　</td>
<td  align="left">&nbsp; <%=rs.getString("factmoney") %></td>
 <td><input type=checkbox name=v value="<%= rs.getString("id") %>"></td> 
</tr> 
 <%
 i++;
 }
rs.close();  
%>
 </table>
 
 
 
  <%
}catch(Exception s){out.print(s.getMessage()+sql);out.close();}
  %>
 
 
 
</body>
 
</html>
