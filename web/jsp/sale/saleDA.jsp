<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "成交客户档案" , 
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
<title>成交客户档案</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/line.css" >
</head>
<%
String Date2=request.getParameter("Date2");
String Date1=request.getParameter("Date1");
String SecNo=request.getParameter("SecNo");
 
%>
<body bgcolor="#FFFFFF" text="#000000">
<p align="center"><font size="5"><b>成交客户档案</font></b></p>
 
 
<table width="110%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr align="center"> 
    <td>序号</td> <td>日期</td> <td>姓名</td> <td>电话</td><td>手机</td> <td>职业</td>  <td>房号</td>  <td>面积M<sup>2</sup></td> <td>总价(元)</td><td>付款<br>方式</td><td>信息<br>来源</td>    <td>居住<br>区域</td><td>是否<br>打球</td><td>会所<br>设施</td><td>客户分析</td>
<td>购买<br>用途</td>	<td>私人顾问</td>  <td>备注</td>
  </tr>	  
<%
 String  SQL="SELECT o.date, c.cus_name,c.cus_age,c.phone,c.sj,c.work,o.loft+o.room_no room,o.jzarea,o.rmbprice,o.payment1,c.KNOWLEDGE_FROM,C.REGION,c.likes,c.Chamberes_tabt,c.purpose,o.seller,o.note FROM order_contract o,customer c where  o.section='"+SecNo+"' and date between '"+Date1+"' and  '"+Date2+"'  and c.serialno=o.customer and o.state<>3";
 
  ResultSet  rs=InsertBean.executeQuery(SQL);
	int j=0;
	while (rs.next()){ j++;
	%>
	<tr>
	<td><%=j %>
	<td><%=rs.getDate("date").toString() %>&nbsp;</td>
	<td><%=getbyte(rs.getString("cus_name")) %>&nbsp;</td>
	<td><%=getbyte(rs.getString("phone")) %>&nbsp;</td>
	<td><%=getbyte(rs.getString("sj")) %>&nbsp;</td>
	 
	<td><%=getbyte(rs.getString("work")) %>&nbsp;</td>
	<td><%=getbyte(rs.getString("room")) %>&nbsp;</td>
	<td><%=FormtD.getFloat(rs.getFloat("jzarea"),4) %>&nbsp;</td>
	<td><%=FormtD.getFloat(rs.getFloat("rmbprice"),0) %>&nbsp;</td>			
	<td><%=getbyte(rs.getString("payment1")) %>&nbsp;</td>
	<td><%=getbyte(rs.getString("KNOWLEDGE_FROM")) %>&nbsp;</td>
	<td><%=getbyte(rs.getString("region")) %>&nbsp;</td>
	<td><%=getbyte(rs.getString("likes")) %>&nbsp;</td>
	<td><%=getbyte(rs.getString("Chamberes_tabt")) %>&nbsp;</td>
	<td><input type=text name=aa   class=unnamed1></td>
	 <td><%=getbyte(rs.getString("purpose")) %>&nbsp;</td>
    <td><%=getbyte(rs.getString("seller")) %>&nbsp;</td>
    <td><%=getbyte(rs.getString("note")) %>&nbsp;</td>	
	<%
     }
  rs.close();
   %>
  </tr>
  </table>
  
  
</body>
</html>
