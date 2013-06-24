<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
 <%@ include file="../public_js/getByteOut.jsp"%>
  
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 
<title>销售佣金提成明细表</title>
 <script language="javascript" src="../public_js/public.js">
</script>
<script language="javascript" src="../public_js/basal.js">
</script>
</head>

 
<% 
 
  String stdate = China.getParameter(request,"Date1") ;
  String endate = China.getParameter(request,"Date2") ;
  String SectionName=China.getParameter(request,"SecNo") ; 
  if (SectionName.equals(""))out.close();
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
   ResultSet rs1=null;
	ResultSet rs=null;
	double yjRate=0;
	List list1=new LinkedList();//存放提成比较
	List list2=new LinkedList();//存放当前用途
   sql="select scale/1000 scale,yong_tu  from commision_scale where section_no='"+SectionName+"'";
   rs=ViewBean.executeQuery(sql);
 
   while (rs.next()){
   list2.add(getbyte(rs.getString("yong_tu")));
   list1.add(getbyte(rs.getString("scale")));
   }
   rs.close();
 
   
   sql="select    a.*,b.cus_name from order_contract a,customer b  where a.customer=b.serialno and   convert(char(10),a.date,120)<='"+endate+"' and a.seller<>''    and a.state<>3  and a.section='"+SectionName+"' "+saletype;
    if (!Loft.equals(""))
	  sql+=" and a.loft='"+Loft+"' ";
	   if (!room.equals(""))
	  sql+=" and a.Room_no='"+room+"'";
	    if (!yong_tu.equals(""))
	  sql+=" and a.yong_tu='"+yong_tu+"'";
  sql+=" order by a.seller,a.loft,a.floors,a.room_no";
  
   int nn=0;
   double sump=0;
   double suma=0;
   double suml=0;
  double sum2=0;
   double sum3=0;
   double sum4=0;
   double sum5=0;
 %>


  
<body>
<form action="sale_list_yjok.jsp" method="post" name="frm">
   <Input type=hidden name=Date2 value="<%=endate %>">
 <Input type=hidden name=Date1 value="<%=stdate %>">
 <Input type=hidden name=SecNo value="<%=China.getParameter(request,"SecNo") %>">
  <Input type=hidden name=Loft value="<%=China.getParameter(request,"Loft") %>">
 <font size=3><div id=tit align="center"><%if (getbyte1(request.getParameter("saletype")).equals("1")){out.print("佣金计算明细表");}else if (getbyte1(request.getParameter("saletype")).equals("2")){out.print("佣金计算明细表");}else{out.print("佣金计算明细表");} %>  </div></font>
 
 <table width="99%"><tr><td colspan="3">时间段:<%=China.getParameter(request,"Date1")%>到<%=China.getParameter(request,"Date2") %></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;请确认提成比例</td><td><input type="button"  name=ok1 onclick="document.frm.submit();" value="打印/预览"></td></tr></table>
 
 <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

 <tr  > 
<td  align="right">序号</td>
 <td  align="center">销售员</td> 
<td  align="center">房间代码</td>
<td align="center">面积</td>
<td w align="center">付款方式</td>
 
<td  align="center">成交总价</td>
<td  align="center">认购日期</td> 
<td  align="center">提成比例(‰)</td> 
<td  align="center" >累计收款金额</td> 
<td  align="center" >本期收款金额</td> 
<td align="center">佣金</td>
	<%
		String sell="";
	try{
		 
	rs=ViewBean.executeQuery(sql);
	  double  sumarea=0;
    int sumsalek=0;
	double ljsk=0;
	double bqsk=0;
	 
	int i=0;
 
   while (rs.next()){
     yjRate=0;
	 i++;
	 String seller=getbyte(rs.getString("seller"));
	 String code  =getbyte(rs.getString("code"));
     String sectionname =getbyte(rs.getString("sectionname"));
      room=getbyte(rs.getString("loft"))+getbyte(rs.getString("room_no"));
     String jzarea=FormtD.getFloat(rs.getFloat("jzarea"),3);
	 String payment =getbyte(rs.getString("payment1"));
	 yjRate=rs.getDouble("yjRate")/1000;
	 String unitprice=FormtD.getFloat2(rs.getDouble("unitprice"),2);
	 String sumprice=FormtD.getFloat2(rs.getDouble("rmbprice"),2);
	    yong_tu=getbyte(rs.getString("yong_tu"));
	 String rg_date=rs.getDate("date").toString(); 
	 if (list2.contains(yong_tu)){
	 	   int index=list2.indexOf(yong_tu);
		   yjRate=Double.valueOf((String)list1.get(index));
	 }

  if (sell.equals(""))sell=seller;
	else if  (!sell.equals(seller)){
	
	%>  
	<tr align="right">
	<td ><b>小计：</b></td>
	 
		<td  >&nbsp;</td>
			<td  >&nbsp;</td>
			<td><%=FormtD.getFloat2(sumarea,2) %></td>
			<td  >&nbsp;</td>
				<td  ><%=sumsalek %></td>
				<td  >&nbsp;</td>
	<td  ><%=FormtD.getFloat2(yjRate*1000,2) %></td>
	<td  ><%=FormtD.getFloat2(ljsk,2)%>&nbsp;</td>
		 
	
	<td  ><%=FormtD.getFloat2(bqsk,2) %>&nbsp;</td>
    <td  ><%=FormtD.getFloat2(bqsk*yjRate,2) %>&nbsp;</td>
	</tr>
	<% 
	  sumarea=0;
      sumsalek=0;
	  ljsk=0;
      bqsk=0;
	  sell=seller;
	}
	   sumsalek+=rs.getInt("rmbprice");
	   sumarea+=rs.getDouble("jzarea");
   %>
  
 <tr   align="center">
<td   align="center"><%=i %></td>
<td  align="left">&nbsp;<%=seller %></td>
 <td  align="left">&nbsp;<%=sectionname+room %></td>
<td   align="center">&nbsp;<%=jzarea%>　</td>
 
<td    align="center">&nbsp;<%=payment %>　</td>
 
<td  align="right">&nbsp;<%=sumprice %></td>
<td  align="center">&nbsp;<%=rg_date %></td> 
<td  align="right">&nbsp;<%=FormtD.getFloat2(yjRate*1000,2) %></td> 
<td align="right">
<%sql="select sum(factmoney*currrate) as factmoney from factgatheringrecord where     convert(char(10),Gather_Date,120)<='"+endate+"' and contractno="+code;
 rs1=ViewBean1.executeQuery(sql);
 double money1=0;
while (rs1.next()){
  money1+=rs1.getDouble("factmoney");
}
rs1.close();
sql="select sum(factmonye) as factmoney from FactAjCharges where    convert(char(10),factdate,120)<='"+endate+"' and contractno="+code;
 rs1=ViewBean1.executeQuery(sql);
 while (rs1.next()){
    money1+=rs1.getDouble("factmoney");
}
rs1.close();
out.print(FormtD.getFloat2(money1,2));
ljsk+=money1;
 %>
</td>
<td  align="right"  valign="bottom">
<%
sql="select sum(factmoney*currrate) as factmoney from factgatheringrecord where   convert(char(10),Gather_Date,120)>='"+stdate+"' and convert(char(10),Gather_Date,120)<='"+endate+"' and contractno="+code;
 rs1=ViewBean1.executeQuery(sql);
 money1=0;
while (rs1.next()){
  money1+=rs1.getDouble("factmoney");
}
rs1.close();
sql="select sum(factmonye) as factmoney from FactAjCharges where  convert(char(10),factdate,120)>='"+stdate+"' and convert(char(10),factdate,120)<='"+endate+"' and contractno="+code;
 rs1=ViewBean1.executeQuery(sql);
 while (rs1.next()){
    money1+=rs1.getDouble("factmoney");
}
rs1.close();
 out.print(FormtD.getFloat2(money1,2));
bqsk+=money1;
 %>
 <input type=hidden name=sk<%=i %> value="<%=FormtD.getFloat3(money1,2) %>"    >
 </td> 
 <td align="right"  > <%=FormtD.getFloat3(yjRate*money1,2) %> </td>
</tr> 
 <%
 }
rs.close();  
%>
<tr align="right">
	<td ><b>小计：</b></td>
	 
		<td  >&nbsp;</td>
			<td  >&nbsp;</td>
			<td><%=FormtD.getFloat2(sumarea,2) %></td>
			<td  >&nbsp;</td>
				<td  ><%=sumsalek %></td>
				<td  >&nbsp;</td>
	<td  ><%=FormtD.getFloat2(yjRate*1000,2) %></td>
	<td  ><%=FormtD.getFloat2(ljsk,2)%></td>
		 
	
	<td  ><%=FormtD.getFloat2(bqsk,2) %>&nbsp;</td>
    <td  ><%=FormtD.getFloat2(bqsk*yjRate,2) %>&nbsp;</td>
	</tr>
 </table> 
<input type="button" onclick="document.frm.submit();" value="打印/预览"><br>
 
  <%
}catch(Exception s){out.print(s.getMessage()+sql);out.close();}

%>
 
 
 
</body>
 
</html>
