<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "销售周报" , 
                  "浏览"
                ) ;
%>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<title>成交客户明细表</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/line.css" >
</head>
<%
String Date2=request.getParameter("Date2");
String Date1=request.getParameter("Date1");
String SecNo=request.getParameter("SecNo");

String Loft=getbyte1(request.getParameter("Loft"));
if (!Loft.equals(""))Loft=" and o.loft='"+Loft+"'";
String sectionname="";
 
%>
<body bgcolor="#FFFFFF" text="#000000">
<p align="center"><font size="5"><b><div id=tit align="center">成交客户明细表</div></font></b></p>
 
 
 
<br>

  
<table width="100%"   cellspacing='0'  cellpadding='0'  >
  <tr   align="right"> 
    <td>时间段: <%=Date1 %>至<%=Date2 %></td> 
 
  </tr>	  
  </table>
<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr align="center"> 
    <td>序号</td>  <td>姓名</td> <td>房号</td>  <td>面积</td> 
    <td>单价</td>  <td>总价</td>  <td>付款方式</td><td>折扣</td><td>客户来源款方式</td><td>居住区域</td>
	<td>职业</td>	<td>爱好</td><td>业务员</td>  <td>备注</td>
  </tr>	  
<%
 String  SQL="SELECT o.sectionname,o.loft+o.building+o.room_no room,o.jzarea,c.cus_name,o.payment1,(o.rmbprice-o.zs_first_money)/o.jzarea unitprice,o.rmbprice-o.zs_first_money rmbprice ,c.region,o.seller,o.note,o.disc,c.visitstate,c.region,c.work,c.likes,o.seller FROM order_contract o,customer c where o.section='"+SecNo+"' and o.STATE=1 and o.date between '"+Date1+"' and  '"+Date2+"' and  o.customer=c.serialno "+Loft;

    int i=0;
	int j=0;
	int aa=0;
    ResultSet rs=InsertBean.executeQuery(SQL);
	j=0;   
	while (rs.next()){ aa++;
	sectionname=getbyte(rs.getString("sectionname")) ;
	%>
	<tr>
	<td><%=aa %>
	<td><%=getbyte(rs.getString("cus_name")) %></td>
	<td><%=getbyte(rs.getString("room")) %></td>
	<td><%=FormtD.getFloat(rs.getFloat("jzarea"),4) %></td>
	
	
	<td><%=FormtD.getFloat(rs.getFloat("unitprice"),0) %></td>
	<td><%=FormtD.getFloat(rs.getFloat("rmbprice"),0) %></td>	
	<td><%=getbyte(rs.getString("payment1")) %></td>
	<td><%=getbyte(rs.getString("disc")) %></td>	
	<td>
	 <%String state=getbyte(rs.getString("visitstate"));
	   if (state.equals("0")){out.print("上门");j++;}
	   else {out.print("来电");i++;}
	
	 %>&nbsp;</td>	
	<td><%=getbyte(rs.getString("region")) %>&nbsp;</td>
	<td><%=getbyte(rs.getString("work")) %>&nbsp;</td>
	 <td><%=getbyte(rs.getString("likes")) %>&nbsp;</td>
    <td><%=getbyte(rs.getString("seller")) %>&nbsp;</td>
    <td><%=getbyte(rs.getString("note")) %>&nbsp;</td>	
	<%
     }
  rs.close();
   %>
  </tr>
  </table>
  <br>
   
  <%
    SQL="SELECT c.visitstate,count(*) num from customer c where c.visit_date   between '"+Date1+"' and  '"+Date2+"' and  c.section='"+SecNo+"'  group by c.visitstate ";
   
     rs=InsertBean.executeQuery(SQL);  
	int ii=0;
	int jj=0;
	while (rs.next()){
	 String state=rs.getString("visitstate");
	 if (state.equals("0"))ii=rs.getInt("num");
	 else jj=rs.getInt("num");
	 }
	 rs.close();
   %>
  <table width="100%"  border="0"  cellspacing='0'  cellpadding='0' >
   <tr align="center"> 
    <td align="left" colspan="2">一、</td>  
  </tr>
  <tr align="left"> 
     <td align="left">&nbsp;</td>  <td>上门客户:<input type=text name=dd value="<%if (ii>0)out.print(ii); %>" class=unnamed1>  批 </td>    
  </tr>
   <tr align="left"> 
   <td align="left">&nbsp;</td>   <td>电话进线:<input type=text name=dd value="<%if (jj>0)out.print(jj); %>" class=unnamed1>  条 </td>   </td>   
  </tr>
 </table>
  
    <table width="100%"   cellspacing='0'  cellpadding='0' >
  <tr align="left"> 
    <td  colspan="2"> 二、本周客户反馈信息:</td>   
  </tr>
   <tr align="left"> 
   <td>&nbsp;</td> <td>&nbsp;&nbsp;1.<input type=text name=dd  class=unnamed1 size=100>  </td>    
  </tr>
    <tr align="left"> 
   <td>&nbsp;</td> <td>&nbsp;&nbsp;2.<input type=text name=dd   class=unnamed1 size=100>  </td>    
  </tr>
    <tr align="left"> 
    <td>&nbsp;</td><td>&nbsp;&nbsp;3.<input type=text name=dd   class=unnamed1 size=100>  </td>    
  </tr>
 </table>
   <table width="100%"   cellspacing='0'  cellpadding='0' >
  <tr align="left"> 
    <td > &nbsp;</td>   
  </tr>
  </table>
 <table align="left"><tr><td align="left">
  <%
   
   SQL="SELECT count(*) num , sum(o.jzarea) jzarea,sum(o.rmbprice)/sum(o.jzarea) unitprice ,sum(o.rmbprice) price FROM order_contract o,customer c where o.section='"+SecNo+"' and o.STATE=1 and o.date between '"+Date1+"' and  '"+Date2+"' and  o.customer=c.serialno "+Loft;

   rs=InsertBean.executeQuery(SQL);

   int ts=0;
   double ar=0;
   int pr=0;
   float un=0;
   if (rs.next())	  {
    out.print("三、本周销售情况<br>");
   out.print("&nbsp;&nbsp;&nbsp;&nbsp;套&nbsp;数:<input type=text name=dd  value="+rs.getString("num")+" class=unnamed1><br>");
   out.print("&nbsp;&nbsp;&nbsp;&nbsp;面&nbsp;积:<input type=text name=dd1  value="+FormtD.getFloat(rs.getFloat("jzarea"),4) +" class=unnamed1><br>");
   out.print("&nbsp;&nbsp;&nbsp;&nbsp;单&nbsp;价:<input type=text name=dd2  value="+FormtD.getFloat(rs.getFloat("unitprice"),0)+" class=unnamed1><br>");
   out.print("&nbsp;&nbsp;&nbsp;&nbsp;总&nbsp;价:<input type=text name=dd  value="+FormtD.getFloat(rs.getFloat("price"),0)+" class=unnamed1><br>");
   
   
   }
   %>
   </td>
   <td>
  <%
   
    SQL=" SELECT count(*) num , sum(o.jzarea) jzarea,sum(o.rmbprice)/sum(o.jzarea) unitprice ,sum(o.rmbprice) price  FROM order_contract o where o.state=1 and  o.section='"+SecNo+"' "+Loft;
   rs=InsertBean.executeQuery(SQL);
    ts=0;
    ar=0;
    pr=0;
    un=0;
   if (rs.next())	  {
    out.print("四、累计销售情况<br>");
   out.print("&nbsp;&nbsp;&nbsp;&nbsp;套&nbsp;数:<input type=text name=dd  value="+rs.getString("num")+" class=unnamed1><br>");
   out.print("&nbsp;&nbsp;&nbsp;&nbsp;面&nbsp;积:<input type=text name=dd1  value="+FormtD.getFloat(rs.getFloat("jzarea"),4) +" class=unnamed1><br>");
   out.print("&nbsp;&nbsp;&nbsp;&nbsp;单&nbsp;价:<input type=text name=dd2  value="+FormtD.getFloat(rs.getFloat("unitprice"),0)+" class=unnamed1><br>");
   out.print("&nbsp;&nbsp;&nbsp;&nbsp;总&nbsp;价:<input type=text name=dd  value="+FormtD.getFloat(rs.getFloat("price"),0)+" class=unnamed1><br>");
   
   
   }
   %>
   </td>
  <script>
  tit.innerText="<%=sectionname %>成交客户明细表";
  
  </script>
</body>
</html>
