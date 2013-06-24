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
  <%@ page import = "java.sql.*,common.*"%>
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
	String AreaStr="";
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
	section=China.getParameter(request,"SectionNO");
	building=China.getParameter(request,"Build");
	Region=China.getParameter(request,"RegionNO");
	djtype=China.getParameter(request,"dj");
    String basicnum="";
	String Strscalce="";
	String Strscalce1="";
	String Strscalce2="";
	String StrPrice="";
	String StrAreaType="";
	String StrAreaType1="";
	String StrTnPrice="";//套内单价;
	String StrJzPrice="";//建筑单价;
	String NowSumPrice="";
	String StrPriceName="";//单价类型(建筑、套内单价)
	String StrPriceName1="";//单价类型(建筑、套内单价)
	String StrBasicRoom=request.getParameter("basicRoom");//取出基价房间号
	//取出基价房的单价

	if (djtype.equals("tnjj")){
	   StrPriceName="TNUnitprice ";
	   StrPriceName1="unitprice ";
	   sql="select tnUnitprice  as price from room where seccode='"+section
	   +"' and Loft='"+Region+"' and building='"+building+"'"
	   +" and Room_code='"+	StrBasicRoom+"'";
	   StrAreaType="*UsedArea/Area";
	   StrAreaType1="*UsedArea";
	}else if (djtype.equals("jzjj")){
	  
	  sql="select unitprice as price  from room where seccode='"+section
	   +"' and Loft='"+Region+"' and building='"+building+"'"
	   +" and Room_code='"+	StrBasicRoom+"'";
	   StrAreaType="*Area/UsedArea";
	    StrAreaType1="*Area";
	   StrPriceName="unitprice ";
	   StrPriceName1="TNunitprice ";
	}
	ResultSet priceRs=null;

	try{
	   priceRs=changePriceListBean.executeQuery(sql);
	   if (priceRs.next())StrPrice=priceRs.getString("price");
	}catch(Exception s){}
	priceRs.close();
	
	
	/*String jjb=request.getParameter("jjb");
	String jjb1=request.getParameter("yj");
	String GDVALUE=request.getParameter("GDmoney");//定价金额
    String GDVALUE1=request.getParameter("DJscale");//定价比
	String GDVALUE2=request.getParameter("GDscale1");//调价比
	String GDVALUE3=request.getParameter("GDmoney1");//调价金额
    */
	float scale=0;
	//}
   /* 
   	if (T.equals("DJ1")&&jjb.equals("cj")){//按基价比定金，
       	Strscalce=request.getParameter("DJscale");//取出浮动比	
		if (Strscalce.indexOf("+")==0){
	           Strscalce=Strscalce.substring(Strscalce.indexOf("+")+1);
	           scale=java.lang.Float.parseFloat(Strscalce);
			   DS="1+";
	    }else if (Strscalce.indexOf("-")==0){
		       Strscalce=Strscalce.substring(Strscalce.indexOf("-")+1);
	           scale=java.lang.Float.parseFloat(Strscalce);
   			   DS="1-";
		}else {scale=1;}
		
		Strscalce=String.valueOf(scale);  
		Strscalce1=Strscalce;
	}*/
	String StartFloor="";
	String RoomNos1="";
	String RoomRate="0";
    String StrNowPrice1="";
    String StrNowPrice2="";
	if (!OK.equals("")){
	   for(int i=Integer.parseInt(intBeginF);i<=Integer.parseInt(intEndF);i++){
	     for(int j=Integer.parseInt(intBeginR);j<=Integer.parseInt(intEndR);j++){
	       String str="Pr"+String.valueOf(i)+String.valueOf(j);
		   String str1="P"+String.valueOf(i)+String.valueOf(j);
		    str1=China.getParameter(request,str1);
	        if (!str1.equals("")){
		      if (StartFloor.equals("")) StartFloor=String.valueOf(i);
			  if (RoomNos.equals("")){
			   RoomNos="'"+request.getParameter(str)+"'";//取出选中的值(房间号)
			   RoomRate=" update room set "+StrPriceName+"="
			   +" case when (room_code='"+request.getParameter(str)+"') "
			   +" then " +StrPrice+"*(1"+str1+"/100)";
			    
			   // StrNowPrice=//"Now"+StrPriceName1+"="
				StrNowPrice1="  when (room_code='"+request.getParameter(str)+"') "
			    +" then " +StrPrice+"*(1"+str1+"/100)"+ StrAreaType;
				StrNowPrice2="  when (room_code='"+request.getParameter(str)+"') "
			    +" then " +StrPrice+"*(1"+str1+"/100)";
	            NowSumPrice="  when (room_code='"
				+request.getParameter(str)+"')"
			    +" then " +StrPrice+"*(1"+str1+"/100)"+StrAreaType1;
			   }
			  else{
			   RoomNos+=",'"+request.getParameter(str)+"'";//取出选中的值(房间号)
			   RoomRate+=" when (room_code='"+request.getParameter(str)+"') "
			   +"then " +StrPrice+"*(1"+str1+"/100)";
			   //"Now"+StrPriceName1+"="
			    StrNowPrice1+="  when (room_code='"+request.getParameter(str)+"') "
			    +" then " +StrPrice+"*(1"+str1+"/100)"+ StrAreaType;
				
				 StrNowPrice2+="  when (room_code='"+request.getParameter(str)+"') "
			    +" then " +StrPrice+"*(1"+str1+"/100)";
				
				
	            NowSumPrice+="  when (room_code='"
				+request.getParameter(str)+"')"
			    +" then " +StrPrice+"*(1"+str1+"/100)"+StrAreaType1;
			   
			   
			   }
  		    }    
		  }		
	   }      

	   NowSumPrice="NowSumPrice= case "+NowSumPrice+" end";//当前总价
	   StrNowPrice2="Now"+StrPriceName+"= case"+StrNowPrice2+ " end ";//当前建筑或套单价
	   StrNowPrice1="Now"+StrPriceName1+"= case"+StrNowPrice1+ " end ";//当前建筑或套单价 
	  
	   SqlView="select code,room_code,floor,Area,UsedArea, tnunitprice,unitprice,"
	   +"sumprice,"+NowSumPrice+","+StrNowPrice2+","+StrNowPrice1+" from room where "
	   +" room_code in("+RoomNos+") and seccode='"+section+"' and "
	   +"building='"+building+"'  and Loft='"+Region+"'";
	   
	   sql="update room set " +NowSumPrice+","+StrNowPrice2+","
	   +StrNowPrice1+ " room_code in("+RoomNos+") and seccode='"
	   +section+"' and building='"+building+"'  and Loft='"+Region+"'";
	    RoomNos1=RoomNos;//"'"+request.getParameter(str)+"'";//取出选中的值
				/* if (T.equals("TJ1")){//调价
				     if (jjb1.equals("ygdb"))
	                   {Strscalce="*(1"+GDVALUE2+"*(floor-"+StartFloor+")"+")";}//按比例
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
	            }/*else if (T.equals("DJ1")){ //定价
                      if (jjb.equals("gdb"))
	                   {Strscalce="*(1"+GDVALUE1+"*(floor-"+StartFloor+")"+")";}//按比例
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
			
	             }	 */
      }
//out.print(SqlView);

 %>

<body bgcolor="#FFFFFF" text="#000000" >

<form name="frm" method="post" action="ChangePriceList.jsp" onsubmit="return Validate(this);">
   <a href="javascript:window.history.back(1)">返回</a>
    <input type=hidden name=SecNo value="<%=section%>">
    <input type=hidden name=Loft value="<%=Region %>">
    <input type=hidden name=Build value="<%=building%>">
    <input type=hidden name=choose>

   <table width="100%" border="0">
      <tr > 
      <td width="90%" align=center> <font size=3> 价格调整对照预览表</font>
    </td</td></tr></table>

<center>

	<table width="100%" border="0" cellpadding="1" cellspacing="1">
  <tr align="center" class=TXTColor> 
      <td rowspan="2"  > 房号 </td>
      <td rowspan="2"  > 建筑面积(M2) </td>
      <td rowspan="2"  > 套内面积(M2) </td>
      <td colspan="3"  >原 价 </td>
      <td colspan="3"  >现 价 </td>
    </tr>
    <tr align="center" class=TXTColor> 
      <td  >建筑单价</td>
      <td  >套内单价</td>
      <td  >总 价</td>
      <td  >建筑单价</td>
      <td  >套内单价</td>
      <td  >总 价</td>
    </tr>

    
  <%
  String StrFloors="";
  float FatSumArea=0;
  int   IntSumPrice=0;
  int   IntRoomNum=0;
  float FatAvgPrice=0;
  int IntPrvSumPrice=0;
  int floor=0;
  String jzarea="";
  float FatAreaVar=0;//临时保留建筑面积
  int IntSumPriceVar=0;//临时保留总价
  ResultSet change2RS = null;
	try{
		change2RS = changePriceListBean.executeQuery(SqlView+" order by floor");
		int i=0;

		while (change2RS.next()) {
		    i=i+1;
			hasRecord = 1;
		 %>
		 <%
		   if (!StrFloors.equals("")&&!StrFloors.equals(String.valueOf(floor))){
		     out.print("<tr><td colspan=3><font color=red>"+String.valueOf(floor)+"</font><font color=red>楼总套数:</font><font color=red>"+IntRoomNum+"</font></td>");
		     out.print("<td ><font color=red>总面积:</font></td><td><font color=red>"+FormatD.getFloat(FatSumArea,4)+"</font></td>");
			 out.print("<td  colspan=2><font color=red>总金额:</font><font color=red>"+FormatD.getFloat(IntSumPrice,1)+"</font></td>");
			 out.print("<td ><font color=red>均价:</font></td><td><font color=red>"+FormatD.getFloat((IntSumPrice)/FatSumArea,2)+"</font></td>");
			 out.print("</tr>");
			 out.print("<tr><td colospan=6>&nbsp;</td></tr>");
			 IntSumPrice=0;
			 FatSumArea=0;
			 IntRoomNum=0;
			 FatAreaVar=Float.parseFloat(jzarea);
			 IntSumPriceVar=IntPrvSumPrice;
			 
		   }
		
		 StrFloors=String.valueOf(floor);
		%>
		 <%
		 	int code = change2RS.getInt("Code");
			String room = change2RS.getString("room_code");
			floor = change2RS.getInt("floor");
		
			jzarea=FormatD.getFloat(change2RS.getFloat("Area"),4);
			FatSumArea+=Float.parseFloat(jzarea);	 
			//int salestate=change2RS.getInt("SaleState");
			float area=change2RS.getFloat("UsedArea");
			AreaStr=FormatD.getFloat(area,4);  
		    String tnunitPrice = FormatD.getFloat(change2RS.getFloat("tnunitprice"),2);	
			String unitPrice =FormatD.getFloat(change2RS.getFloat("unitprice"),2);
		    String sumPrice = FormatD.getFloat(change2RS.getFloat("sumprice"),0);
			IntPrvSumPrice=change2RS.getInt("Nowsumprice");
		    String NowsumPrice = FormatD.getFloat(IntPrvSumPrice,0);
		    String NowtnunitPrice = FormatD.getFloat(change2RS.getFloat("Nowtnunitprice"),2);	
			IntSumPrice+=IntPrvSumPrice;
		    String Nowunitprice= FormatD.getFloat(change2RS.getFloat("Nowunitprice"),2);

 %>

  
  <tr align="right" class=listcontent> 
   
   
    <tr align="right" class=listcontent> 
       <td > <%=room.trim() %></td>
      <td > <%=jzarea.trim() %></td>
      <td ><%=AreaStr.trim() %></td>
      <td ><%=unitPrice %></td>
    
      <td ><%= tnunitPrice %></td>
	   <td ><%= sumPrice %></td>
      <td ><%=Nowunitprice %></td>
      <td ><%= NowtnunitPrice %></td>
      <td ><%= NowsumPrice %></td>
    </tr>
   
  </tr>

    
  <%	IntRoomNum++;
   }
   change2RS.close();
}catch(Exception s){out.print(s.getMessage());%>
<script>//alert("系统定(调)价出错，房间资料没有面积数据");window.history.back(1);</script>

<%}
session.setAttribute("sql",sql);
session.setAttribute("sqlView",SqlView);
  //if (!StrFloors.equals("")&&!StrFloors.equals(String.valueOf(floor))){
     out.print("<tr><td colspan=3><font color=red>"+String.valueOf(floor)+"</font><font color=red>楼总套数:</font><font color=red>"+IntRoomNum+"</font></td>");
     out.print("<td ><font color=red>总面积:</font></td><td><font color=red>"+FormatD.getFloat(FatSumArea,4)+"</font></td>");
	 out.print("<td  colspan=2><font color=red>总金额:</font><font color=red>"+FormatD.getFloat(IntSumPrice,1)+"</font></td>");
	 out.print("<td ><font color=red>均价:</font></td><td><font color=red>"+FormatD.getFloat((IntSumPrice)/FatSumArea,2)+"</font></td>");
	 out.print("</tr>");
    IntSumPrice=0;
	FatSumArea=0;
	IntRoomNum=0;
 //  }   
   %>
   
</table>
<input type=button name=ok value="暂保留此价格" onclick="save();"><input type=button name=cancel value="返回，重新调(定)价" onclick="window.history.back(1);">
 </form>

</center>
<script>
function save(){

open("SaveCharges.jsp");
//window.history.back(1);
}
</script>
</body>
</html>
