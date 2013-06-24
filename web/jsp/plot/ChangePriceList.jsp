<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script src="js/mad.js"> </script>
<script language="JavaScript" src='../public_js/basal.js'></script>
</head>
<script language="javascript" src="../public_js/public.js"></script>


  <%@ page contentType="text/html;charset=GBK" %>
  <%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
  <jsp:useBean id = "changePriceListBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id = "FormatD" scope = "page" class = "FormatData.FormatData" />
  <%@ include file="../public_js/checktime.jsp"%>
  <%
	String changePriceStr = "select * from section";
	ResultSet changePriceRS = null;
	int hasRecord = 0;
    String section = "";
	String building = "";
	String Floor="";
	String RoomNo="";
	String state="";
	String color="";
	String change2Str = "";
	String DZ=China.getParameter(request,"D");
	String T=China.getParameter(request,"TJ");
	String OK=China.getParameter(request,"Ok");
	String intEndF=request.getParameter("intEndF");
	String intEndR=request.getParameter("intEndR");
	String intBeginR=request.getParameter("intBeginR");
	String intBeginF=request.getParameter("intBeginF");
	String StrRoomType=China.getParameter(request,"roomtype");
	String StrCx=China.getParameter(request,"cx");
	String StrMinFloor=China.getParameter(request,"minFloor");
	String StrMaxFloor=China.getParameter(request,"maxFloor");
	String RoomNos="";
	String djtype="";
	String Region="";
    String sql="";
	String SqlView="";
	String StrScalce="";
	String DS="";
	String roomType="";
	String roomDirection="";
	String roomAreaMin="";
	String roomAreaMax="";
	String roomFloorMax="";
    String roomFloorMin="";
	String WhereSql="";
	section=China.getParameter(request,"SectionNO");
	building=China.getParameter(request,"Build");
	Region=China.getParameter(request,"RegionNO");
	
	roomType=China.getParameter(request,"roomtype");
	roomDirection=China.getParameter(request,"cx");
	roomAreaMin=China.getParameter(request,"minArea");
	roomAreaMax=China.getParameter(request,"maxArea");
	roomFloorMin=China.getParameter(request,"minFloor");
	roomFloorMax=China.getParameter(request,"maxFloor");
	
	if (!roomType.equals("")) WhereSql=" roomtype='"+roomType+"'";
	if (!roomDirection.equals("")&&WhereSql.equals(""))WhereSql=" direction='"+roomDirection+"'";
  	else if (!roomDirection.equals("")&&!WhereSql.equals(""))WhereSql+=" and direction='"+roomDirection+"'";
    if (!roomAreaMin.equals("")&&!roomAreaMax.equals("")&&WhereSql.equals(""))WhereSql=" area >="+roomAreaMin+" and area<="+roomAreaMax;
  	else if (!roomAreaMin.equals("")&&!roomAreaMax.equals("")&&!WhereSql.equals(""))WhereSql+=" and area >="+roomAreaMin+" and area<="+roomAreaMax;

    if (!roomFloorMin.equals("")&&!roomFloorMax.equals("")&&WhereSql.equals(""))WhereSql=" floor >="+roomFloorMin+" and floor<="+roomFloorMax;
  	else if (!roomFloorMin.equals("")&&!roomFloorMax.equals("")&&!WhereSql.equals(""))WhereSql+=" and floor >="+roomFloorMin+" and floor<="+roomFloorMax;
    String basicnum="";
	String Strscalce="";
	String Strscalce1="";
	String Strscalce2="";
	String StrPrice=request.getParameter("price");//取出基价值
	String jjb=request.getParameter("jjb");
	String jjb1=request.getParameter("yj");
	String GDVALUE=request.getParameter("GDmoney");//定价金额
    String GDVALUE1=request.getParameter("DJscale")+"/100.0";//定价比
	String GDVALUE2=request.getParameter("GDscale1")+"/100.0";//调价比
	String GDVALUE3=request.getParameter("GDmoney1");//调价金额

	float scale=0;
	//}
    djtype=China.getParameter(request,"dj");

   	if (T.equals("DJ1")&&jjb.equals("cj")){//按基价比定金，
       	Strscalce=request.getParameter("DJscale");//取出浮动比	
	}
	String StartFloor="";
	String RoomNos1="";
	if (!OK.equals("")){
	   if (WhereSql.equals("")){//按选中的房间来调（定价）
	    for(int i=Integer.parseInt(intBeginF);i<=Integer.parseInt(intEndF);i++){
	     for(int j=Integer.parseInt(intBeginR);j<=Integer.parseInt(intEndR);j++){
	       String str="Pr"+String.valueOf(i)+String.valueOf(j);
		   String str1="P"+String.valueOf(i)+String.valueOf(j);
		   str1=request.getParameter(str1);
	       if (str1!=null){
		      if (StartFloor.equals("")) StartFloor=String.valueOf(i);
			  if (RoomNos.equals(""))RoomNos="'"+request.getParameter(str)+"'";//取出选中的值
			  else RoomNos+=",'"+request.getParameter(str)+"'";//取出选中的值
  		    }    
		  }
		 } 
		}else{//按条件调(定)价
		 WhereSql="select floor,room_code from room where "
		         +"seccode='"+section+"' and building='"
				 +building+"'  and Loft='"+Region+"'"
				 +" and "+WhereSql+" and salestate=1 order by floor";
  	      ResultSet roomPriceRs=changePriceListBean.executeQuery(WhereSql);
     	  while (roomPriceRs.next())	 {
		    if (StartFloor.equals(""))StartFloor=roomPriceRs.getString("floor");
		    if (RoomNos.equals(""))RoomNos="'"+roomPriceRs.getString("room_code")+"'";
			else RoomNos+=",'"+roomPriceRs.getString("room_code")+"'";
		  }
		  roomPriceRs.close();
		 } 		
		 if (RoomNos.equals(""))
		 {
		   out.print("<script>");
		   out.print("alert('系统没找到此条件的数据!');");
		   out.print("window.history.back(1);");
		   out.print("</script>");
		 
		 }
				 RoomNos1=RoomNos;//"'"+request.getParameter(str)+"'";//取出选中的值
				 if (T.equals("TJ1")){//调价
				     if (jjb1.equals("ygdb"))
	                   {Strscalce="*((1"+GDVALUE2+"*(floor-"+StartFloor+")"+"))";}//按比例
					 else
  					   {Strscalce=""+GDVALUE3+"*(floor-"+StartFloor+")"+"";}//按固定金额
         		 if (djtype.equals("ykjS")){
                       sql="update room set unitprice=case when (floor>"+StartFloor+") then (Sumprice"+Strscalce+")/Area else unitprice*1 end,Sumprice=case when (floor>"+StartFloor+") then Sumprice"+Strscalce+" else Sumprice*1 end  ,tnunitprice= case when (floor>"+StartFloor+") then (Sumprice"+Strscalce+")/UsedArea else tnunitprice*1 end where Room_code in("+RoomNos1+") and seccode='"+section+"' and building='"+building+"'  and Loft='"+Region+"'";
					   SqlView="select code,room_code,floor,Area,UsedArea,tnunitprice,Nowtnunitprice=case when (floor>"+StartFloor+") then (Sumprice"+Strscalce+")/UsedArea else tnunitprice*1 end,Sumprice,NowSumprice=case when (floor>"+StartFloor+") then Sumprice"+Strscalce+" else Sumprice*1 end,unitprice,Nowunitprice=case when (floor>"+StartFloor+") then (Sumprice"+Strscalce+")/Area else unitprice*1 end from room where Room_code in("+RoomNos1+") and seccode='"+section+"' and building='"+building+"'  and Loft='"+Region+"'";
    	   	         }else if (djtype.equals("jzjj")){
		               sql="update room set unitprice=case when (floor>"+StartFloor+") then unitprice"+Strscalce+" else unitprice*1 end , Sumprice=case when (floor>"+StartFloor+") then Area*(unitprice"+Strscalce+") else Sumprice end,tnunitprice=case when (floor>"+StartFloor+") then (unitprice"+Strscalce+")*Area/UsedArea else tnunitprice end where Room_code in("+RoomNos1+") and seccode='"+section+"' and building='"+building+"'  and Loft='"+Region+"'";
					   SqlView="select code,room_code,floor,Area,UsedArea,tnunitprice,Nowtnunitprice=case when (floor>"+StartFloor+") then (unitprice"+Strscalce+")*Area/UsedArea else tnunitprice*1 end ,Sumprice,NowSumprice=case when (floor>"+StartFloor+") then Area*(unitprice"+Strscalce+") else Sumprice*1 end ,unitprice,Nowunitprice=case when (floor>"+StartFloor+") then unitprice"+Strscalce+" else unitprice*1 end from room where Room_code in("+RoomNos1+") and seccode='"+section+"' and building='"+building+"'  and Loft='"+Region+"'";
	                 }else if (djtype.equals("tnjj")){
  			             sql="update room set tnunitprice=case when (floor>"+StartFloor+") then tnunitprice"+Strscalce+" else tnunitprice*1 ,Sumprice=case when (floor>"+StartFloor+") then (tnunitprice"+Strscalce+")*UsedArea else Sumprice*1"+",unitprice=case when (floor>"+StartFloor+") then  (tnunitprice"+Strscalce+")*UsedArea/Area else unitprice*1 where Room_code in("+RoomNos1+") and seccode='"+section+"' and building='"+building+"'  and Loft='"+Region+"'";
						 SqlView="select code,room_code,floor,Area,UsedArea, tnunitprice,Nowtnunitprice=case when (floor>"+StartFloor+") then tnunitprice"+Strscalce+" else tnunitprice*1 end,Sumprice,NowSumprice=case when (floor>"+StartFloor+") then  (tnunitprice"+Strscalce+")*UsedArea"+" else Sumprice*1 end ,unitprice,Nowunitprice=case when (floor>"+StartFloor+") then  (tnunitprice"+Strscalce+")*UsedArea/Area  else unitprice*1 end from room where Room_code in("+RoomNos1+") and seccode='"+section+"' and building='"+building+"'  and Loft='"+Region+"'";
                     } 
					
				   // Strscalce=Strscalce;
	            }else if (T.equals("DJ1")){ //定价
                      if (jjb.equals("gdb"))
	                   {Strscalce="*((1"+GDVALUE1+"*(floor-"+StartFloor+")"+"))";}//按比例
					 else
  					   {Strscalce=GDVALUE+"*(floor-"+StartFloor+")"+"";}//按固定金额
			          String RoomNos2=RoomNos;//"'"+request.getParameter(str)+"'";//取出选中的值
				        if (djtype.equals("ykjS")){
			               sql="update room set unitprice= case when (floor>"+StartFloor+") then ("+StrPrice+Strscalce+")/Area else "+StrPrice+"*1/Area end,Sumprice= case when (floor>"+StartFloor+") then "+StrPrice+Strscalce+" else "+StrPrice+"*1 end ,tnunitprice=case when (floor>"+StartFloor+") then ("+StrPrice+Strscalce+")/UsedArea else "+StrPrice+"/UsedArea end where Room_code in("+RoomNos2+") and seccode='"+section+"' and building='"+building+"'  and Loft='"+Region+"'";

						   SqlView="select code,room_code,floor,Area,UsedArea, tnunitprice,Nowtnunitprice=case when (floor>"+StartFloor+") then  ("+StrPrice+Strscalce+")/UsedArea else tnunitprice*1 end ,Sumprice,NowSumprice=case when (floor>"+StartFloor+") then "+StrPrice+Strscalce+" else "+StrPrice+" end,unitprice,Nowunitprice=case when (floor>"+StartFloor+") then ("+StrPrice+Strscalce+")/Area else unitprice end from room where Room_code in("+RoomNos2+") and seccode='"+section+"' and building='"+building+"'  and Loft='"+Region+"'";
					    
						}else if (djtype.equals("jzjj")){
					       sql="update room set unitprice=case when (floor>"+StartFloor+") then "+StrPrice+Strscalce+" else "+StrPrice+"*1 end,Sumprice=case when (floor>"+StartFloor+") then("+StrPrice+Strscalce+")*Area else "+StrPrice+"*Area end "+",tnunitprice=case when (floor>"+StartFloor+") then ("+StrPrice+Strscalce+")*Area/UsedArea else "+StrPrice+"*Area/UsedArea end where Room_code in("+RoomNos2+") and seccode='"+section+"' and building='"+building+"'  and Loft='"+Region+"'";
						   SqlView="select code,room_code,floor,Area,UsedArea,tnunitprice,Nowtnunitprice=case when (floor>"+StartFloor+") then ("+StrPrice+Strscalce+")*Area/UsedArea else "+StrPrice+"*Area/UsedArea end ,Sumprice,NowSumprice=case when (floor>"+StartFloor+") then ("+StrPrice+Strscalce+")*Area"+" else "+StrPrice+"*Area end ,unitprice,Nowunitprice=case when (floor>"+StartFloor+") then "+StrPrice+Strscalce+" else "+StrPrice+" end  from room where Room_code in("+RoomNos2+") and seccode='"+section+"' and building='"+building+"'  and Loft='"+Region+"'";
				        }else if (djtype.equals("tnjj")){
			  			   sql="update room set tnunitprice=case when (floor>"+StartFloor+") then "+StrPrice+Strscalce+" else "+StrPrice+"*1 end,Sumprice=case when (floor>"+StartFloor+") then ("+StrPrice+Strscalce+")*UsedArea else "+StrPrice+"*UsedArea end"+",unitprice=case when (floor>"+StartFloor+") then ("+StrPrice+Strscalce+")*UsedArea/Area else "+StrPrice+"*UsedArea/Area end where Room_code in("+RoomNos2+") and seccode='"+section+"' and building='"+building+"'  and Loft='"+Region+"'";
						   SqlView="select code,room_code,floor,Area,UsedArea,tnunitprice,Nowtnunitprice=case when (floor>"+StartFloor+") then "+StrPrice+Strscalce+"else "+StrPrice+"*1 end,Sumprice,NowSumprice=case when (floor>"+StartFloor+") then ("+StrPrice+Strscalce+")*UsedArea else "+StrPrice+"*UsedArea end"+",unitprice,Nowunitprice=case when (floor>"+StartFloor+") then ("+StrPrice+Strscalce+")*UsedArea/Area else "+StrPrice+"*UsedArea/Area end from room where Room_code in("+RoomNos2+") and seccode='"+section+"' and building='"+building+"'  and Loft='"+Region+"'";
			            }
				  
					//Strscalce=Strscalce1;
			
	             }	 
      }
 %>

<body bgcolor="#FFFFFF" text="#000000" >

<form name="frm" method="post" action="" target="_blank">
   <a href="javascript:window.history.back(1)">返回</a>
    <input type=hidden name=SecNo value="<%=section%>">
    <input type=hidden name=Loft value="<%=Region %>">
    <input type=hidden name=Build value="<%=building%>">
    <input type=hidden name=choose>

   <table width="100%" border="0">
      <tr > 
      <td width="90%" align=center> <font size=3> 价格调整对照预览表</font>
    </td></tr></table>



	
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
//session.setAttribute("sql",sql);
//session.setAttribute("sqlView",SqlView);
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

<input type=button name=ok value="暂保留此价格" onclick="save();"><input type=button name=cancel value="返回，重新调(定)价" onclick="window.history.back(1);">
</center>
<input type=hidden name=sql value="<%=sql %>">
<input type=hidden name=sqlView value="<%=SqlView %>">
 </form>


<script>
function save(){
document.frm.action="SaveCharges.jsp";
document.frm.submit();
//window.history.back(1);
}
</script>
</body>
</html>
