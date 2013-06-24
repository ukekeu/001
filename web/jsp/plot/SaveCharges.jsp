<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>


<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page import = "java.sql.*,common.*"%>
  <jsp:useBean id = "changePriceListBean" scope = "page" class = "ConnDatabase.SDatabase" />
<jsp:useBean id = "FormatD" scope = "page" class = "FormatData.FormatData" />
  <%
  String SQL=China.getParameter(request,"sql");
  String priceSQL=China.getParameter(request,"price");
  String SqlView=China.getParameter(request,"sqlView");
  String  savePrice=China.getParameter(request,"savePrice");
   %>
<body>
<%  if (!savePrice.equals("")){  %>

<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "价格管理" , 
                  "调价定价"
                ) ;
%>

<script>
alert("系统已接受你的调(定)价");

</script>
<%} %>
<form name=frm  method="post">
<table width="100%" border="0">
      <tr > 
      <td width="90%" align=center> <font size=3> 价格调整对照预览表</font>
    </td</td></tr></table>

<center>

	<table width="100%" border="1" cellspacing='0'  cellpadding='2' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000 >
  <tr align="center" class=TXTColor> 
      <td rowspan="2"  > 房号 </td>
      <td rowspan="2"  > 建筑面积(M2) </td>
      <td rowspan="2"  > 套内面积(M2) </td>
      <td colspan="3"  >原 价 </td>
      <td colspan="3"  bgcolor="#AA7B46" >现 价 </td>
    </tr>
    <tr align="center" class=TXTColor> 
      <td  >建筑单价</td>
      <td  >套内单价</td>
      <td  >总 价</td>
      <td  bgcolor="#AA7B46">建筑单价</td>
      <td  bgcolor="#AA7B46">套内单价</td>
      <td  bgcolor="#AA7B46">总 价</td>
    </tr>

    
  <%
  String StrFloors="";
  float FatSumArea=0;
  int   IntSumPrice=0;
  int   IntRoomNum=0;
  float FatAvgPrice=0;
  int IntPrvSumPrice=0;
float AllSumArea=0;
int AllSumPrice=0;
int AllSumNum=0;
  String floor="";
  String jzarea="";
  String AreaStr="";
  float FatAreaVar=0;//临时保留建筑面积
  int IntSumPriceVar=0;//临时保留总价
  String Pfloor="";

  ResultSet change2RS = null;
	try{
		change2RS = changePriceListBean.executeQuery(SqlView+" order by floor");
		int i=0;

		while (change2RS.next()) {
		    i=i+1;
			int code = change2RS.getInt("Code");
			String room = change2RS.getString("room_code");
			if (!floor.equals(""))Pfloor=floor;//保存前一记录的楼层号
			floor = change2RS.getString("floor");
			%>
		  <%
		   if (!StrFloors.equals("")&&!StrFloors.equals(floor)){//如果不属于同一楼层，则输出上一楼层的小计
		     out.print("<tr align=center><td colspan=3><font color=red>"+Pfloor+"</font><font color=red>楼总套数:</font><font color=red>"+IntRoomNum+"</font></td>");
		     out.print("<td  colspan=2><font color=red>建筑面积:"+FormatD.getFloat(FatSumArea,4)+"</font></td>");
	         out.print("<td  colspan=2><font color=red>总金额:</font><font color=red>"+FormatD.getFloat(IntSumPrice,1)+"</font></td>");
		     out.print("<td colspan=2><font color=red>均价:"+FormatD.getFloat((IntSumPrice)/FatSumArea,2)+"</font></td>");
			 out.print("</tr>");
			  out.print("<tr><td colspan=9>&nbsp;</td></tr>");
		     IntSumPrice=0;
			 FatSumArea=0;
			 IntRoomNum=0;
			 FatAreaVar=Float.parseFloat(jzarea);
			 IntSumPriceVar=IntPrvSumPrice;
			 
		   }
		
		 StrFloors=String.valueOf(floor);
		%>
			<%
			
		
			jzarea=FormatD.getFloat(change2RS.getFloat("Area"),4);
			FatSumArea+=Float.parseFloat(jzarea);	
			AllSumArea+= Float.parseFloat(jzarea);
			//int salestate=change2RS.getInt("SaleState");
			float area=change2RS.getFloat("UsedArea");
			AreaStr=FormatD.getFloat(area,4);  
		    String tnunitPrice = FormatD.getFloat(change2RS.getFloat("tnunitprice"),2);	
			String unitPrice =FormatD.getFloat(change2RS.getFloat("unitprice"),2);
		    String sumPrice = FormatD.getFloat(change2RS.getFloat("sumprice"),0);
			IntPrvSumPrice=change2RS.getInt("Nowsumprice");
			AllSumPrice+=IntPrvSumPrice;
		    String NowsumPrice = FormatD.getFloat(IntPrvSumPrice,0);
		    String NowtnunitPrice = FormatD.getFloat(change2RS.getFloat("Nowtnunitprice"),2);	
			IntSumPrice+=IntPrvSumPrice;
		    String Nowunitprice= FormatD.getFloat(change2RS.getFloat("Nowunitprice"),2);
            AllSumNum++;
 %>


  
    <tr align="right"  bgcolor="#DDE8E8"> 
       <td > <%=room.trim()%></td>
      <td > <%=jzarea.trim() %></td>
      <td ><%=AreaStr.trim() %></td>
      <td ><%=unitPrice %></td>
    
      <td ><%= tnunitPrice %></td>
	   <td ><%= sumPrice %></td>
      <td  bgcolor="#E8DEDE"><%=Nowunitprice %></td>
      <td  bgcolor="#E8DEDE"><%= NowtnunitPrice %></td>
      <td  bgcolor="#E8DEDE"><%= NowsumPrice %></td>
    </tr>
    
  <%	IntRoomNum++;
   }
   change2RS.close();
}catch(Exception s){out.print(s.getMessage());%>

<%}

//输出最后一楼层的小计
     out.print("<tr align=center><td colspan=3><font color=red>"+floor+"</font><font color=red>楼总套数:</font><font color=red>"+IntRoomNum+"</font></td>");
     out.print("<td  colspan=2><font color=red>建筑面积"+FormatD.getFloat(FatSumArea,4)+"</font></td>");
	 out.print("<td  colspan=2><font color=red>总金额:</font><font color=red>"+FormatD.getFloat(IntSumPrice,1)+"</font></td>");
	out.print("<td colspan=2><font color=red>均价:"+FormatD.getFloat((IntSumPrice)/FatSumArea,2)+"</font></td>");
	 out.print("</tr>");
    IntSumPrice=0;
	FatSumArea=0;
	IntRoomNum=0;

   %>
   
</table>
<br>
 <center>
  <table width="80%" border="1" cellspacing='0'  cellpadding='2' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000 >
  <tr align="center">
  <td ><font size=4>总套数</font></td><td ><font size=4>总建筑面积</font></td><td><font size=4>总金额</font></td><td><font size=4>均价</font></td>
  </tr>
  <tr align="center">
	<td><%=AllSumNum %></td>
	<td><%=FormatD.getFloat(AllSumArea,4) %></td>
	<td><%=FormatD.getFloat(AllSumPrice,0) %></td>
	<td><%=FormatD.getFloat(AllSumPrice/AllSumArea,2) %></td>
	</tr>
 </table>
  </center>
<%
 if (SQL==null)  SQL="";
  if (!savePrice.equals("")){
	try{
	
	changePriceListBean.executeUpdate(SQL);
   }catch(Exception s){out.print(s.getMessage()+"error");
   out.println(SQL);
   }
   }

 %>

 <input type=hidden name=sql value="<%=SQL %>">
  <input type=hidden name=sqlView value="<%=SqlView %>">
 <%  if (savePrice.equals("")){  %>

<p align="center"> <input type=submit name="savePrice" value="保存价格"></p>
<%}else{ %>
<div   id="divprint" align="center"> <input type=button name="printPrice" onclick="prin();" value="打印价格表"></div>
<%} %>
<script>
function prin(){
divprint.innerHTML="";
print();
}
</script>
</form>
</body>
</html>
