<html>
<head>
<title>调价明细对照表</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script src="js/mad.js"> </script>
<script language="JavaScript" src='../public_js/basal.js'></script>
</head>
<script language="javascript" src="../public_js/public.js"></script>


<%@ page contentType="text/html;charset=GBK" %>
  <%@ page import = "java.sql.*,common.*"%>
  <jsp:useBean id = "changePriceListBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id = "changePriceListBean1" scope = "page" class = "ConnDatabase.SDatabase" />
    <jsp:useBean id = "FormatD" scope = "page" class = "FormatData.FormatData" />
	<%@ include file="../public_js/getByteOut.jsp"%>
  <%@ include file="../public_js/checktime.jsp"%>
  <%@ include file="../public_js/asiic.jsp"%>
  <%@ include file="../public_js/logrecord.jsp" %>
  <%
	String changePriceStr = "";
	ResultSet changePriceRS = null;
	int hasRecord = 0;
    String section = "";
	String building = "";
	String Floor="";
	String RoomNo="";
	String state="";
	String color="";

	String change2Str = "";
	String paym=China.getParameter(request,"paym");
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
	String choosetype="";
	
String Scellname=getbyte1(request.getParameter("Scellname"));
String Ecellname=getbyte1(request.getParameter("Ecellname"));
  if (Scellname.equals("")){Scellname=" ";}
 if (Ecellname.equals("")){ Ecellname=" ";}

 int scell=0,ecell=0;
 
 
 
char  CellN1=Scellname.charAt(0);
char  CellN2=Ecellname.charAt(0);

if (!Scellname.equals("")&&!Ecellname.equals("")){
   CellN1=Scellname.charAt(0);
   CellN2=Ecellname.charAt(0);

if(java.lang.Character.isDigit(CellN1)){
	 scell=java.lang.Integer.parseInt(Scellname);
	 ecell=java.lang.Integer.parseInt(Ecellname);
}
else{
     scell=Character.getNumericValue(CellN1)-9;
	 ecell=Character.getNumericValue(CellN2)-9;
}
 
}
if (scell<0)scell=0;
if (ecell<0)ecell=0;
 
	section=China.getParameter(request,"SectionNO");
	building=China.getParameter(request,"Build");
	Region=China.getParameter(request,"RegionNO");
	djtype=China.getParameter(request,"dj");
	choosetype=China.getParameter(request,"choosetype");
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
	String StrBasicRoom=request.getParameter("basicRoom");//取出基价 
	//取出基价房的单价
 
	if (djtype.equals("tnjj")){
	   StrPriceName="TNUnitprice ";
	   StrPriceName1="unitprice ";
	   StrAreaType="*UsedArea/Area";
	   StrAreaType1="*UsedArea";
	   StrPrice="TNUnitprice";
	}else if (djtype.equals("jzjj")){
	    StrAreaType="*Area/UsedArea";
	    StrAreaType1="*Area";
	    StrPriceName="unitprice ";
	    StrPriceName1="TNunitprice ";
	    StrPrice="unitprice";
	}else if (djtype.equals("zj")){
	    StrAreaType="/UsedArea";
	    StrAreaType1="/area";
	    StrPriceName="unitprice ";
	    StrPriceName1="TNunitprice ";
	    StrPrice="sumprice";
	}
	
	float scale=0;
	
	String StartFloor="";
	String RoomNos1="";
	String RoomRate="0";
    String StrNowPrice1="";
    String StrNowPrice2="";
	String zjrate="",Rinfo="";
	if (!OK.equals("")){
	changePriceListBean.executeUpdate("delete 试算价目表 where  paymenttype=1 and  payment='"+paym+"' and sectionno='"+section+"' and loft='"+Region+"'");
	   for(int j2=scell;j2<=ecell;j2++){
			if (scell>0){  
			  Rinfo=AsiicZH(j2,CellN1); 
			}
			 
	   for(int i=Integer.parseInt(intBeginF);i<=Integer.parseInt(intEndF);i++){
	     for(int j=Integer.parseInt(intBeginR);j<=Integer.parseInt(intEndR);j++){
	       String str="Pr"+Rinfo+String.valueOf(i)+String.valueOf(j);
		   String str1="P"+Rinfo+String.valueOf(i)+String.valueOf(j);
		    str1=China.getParameter(request,str1);
			String str2="";
			 
	        if (!str1.equals("")){
			  if (str1.substring(0,1).equals("+"))str2="+";
			  if (choosetype.equals("2"))str1=StrPrice+"*(1"+"+"+str2+String.valueOf(Float.parseFloat(str1)/100)+")"; 
			  else str1="("+StrPrice+"+"+str1+")";
			
		      if (StartFloor.equals("")) StartFloor=String.valueOf(i);
			   
			  if (RoomNos.equals("")){
			   RoomNos="'"+request.getParameter(str)+"'";//取出选中的值(房间号)
			   RoomRate=" update room set "+StrPriceName+"="
			   +" case when (room_code='"+request.getParameter(str)+"') "
			   +" then " +str1;
				StrNowPrice1="  when (room_code='"+request.getParameter(str)+"') "
			    +" then " +str1+ StrAreaType;
				StrNowPrice2="  when (room_code='"+request.getParameter(str)+"') "
			    +" then " +str1+StrAreaType1;
	            NowSumPrice="  when (room_code='"
				+request.getParameter(str)+"')"
			    +" then " +str1;
				if (!djtype.equals("zj")){
				   NowSumPrice+=StrAreaType1;
				}
				 
			   }
			  else{
			
			   RoomNos+=",'"+request.getParameter(str)+"'";//取出选中的值(房间号)
			   RoomRate+=" when (room_code='"+request.getParameter(str)+"') "
			   +"then " +str1;
			   //"Now"+StrPriceName1+"="
			   //现套内单价
			    StrNowPrice1+="  when (room_code='"+request.getParameter(str)+"') "
			    +" then " +str1+ StrAreaType;
				  
				if (djtype.equals("zj")){
				
				//现总价
				NowSumPrice+="  when (room_code='"+request.getParameter(str)+"') "
			    +" then " +str1;
				
				//现建筑单价
	             StrNowPrice2+="  when (room_code='"
				+request.getParameter(str)+"')"
			    +" then " +str1+StrAreaType1;
				  
				}else{
				//现建筑单价
				  StrNowPrice2+="  when (room_code='"+request.getParameter(str)+"') "
			    +" then " +str1;
				//现总价
			    NowSumPrice+="  when (room_code='"
				+request.getParameter(str)+"')"
			    +" then " +str1+StrAreaType1;
				
				 
				}
			 
			   }
  		    }    
		  }		
	   }      
	 }
      String SumPrice1="SumPrice= case "+NowSumPrice+" end";//原总价
	   NowSumPrice="NowSumPrice= case "+NowSumPrice+" end";//当前总价
	  String Price2=StrPriceName+"= case"+StrNowPrice2+ " end ";//当前建筑或套单价
 
	   StrNowPrice2="Now"+StrPriceName+"= case"+StrNowPrice2+ " end ";//当前建筑或套单价
	   String Price1=StrPriceName1+"= case"+StrNowPrice1+ " end ";//当前建筑或套单价 
	   StrNowPrice1="Now"+StrPriceName1+"= case"+StrNowPrice1+ " end ";//当前建筑或套单价 

	   SqlView="select cell,yong_tu,salestate,code,room,room_code,floor,room,Area,UsedArea, tnunitprice,unitprice,"
	   +"sumprice,"+NowSumPrice+","+StrNowPrice2+","+StrNowPrice1+" from room where "
	   +" room_code in("+RoomNos+") and seccode='"+section+"' and "
	   +"building='"+building+"'  and Loft='"+Region+"'";
	  // out.print(SqlView);
	   sql="update room set " +SumPrice1+","+Price2+","
	   +Price1+ " where room_code in("+RoomNos+") and seccode='"
	   +section+"' and building='"+building+"'  and Loft='"+Region+"'";
	    RoomNos1=RoomNos;//"'"+request.getParameter(str)+"'";//取出选中的值
 
      } 
 %>

<body bgcolor="#FFFFFF" text="#000000" >


<form name="frm" method="post" action="" target="_blank">
   <a href="#" onclick="parent.window.location='PriceProjectList.jsp?SecNo=<%=section %>&Loft=<%=Region %>';window.close();">退出</a>
    <input type=hidden name=SecNo value="<%=section%>">
    <input type=hidden name=Loft value="<%=Region %>">
    <input type=hidden name=Build value="<%=building%>">
    <input type=hidden name=choose>

   <table width="100%" border="0">
      <tr > 
      <td width="90%" align=center> <font size=4> 价格调整对照预览表</font>
    </td</td></tr></table>
<br>
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
  double IntPrvSumPrice=0;
float AllSumArea=0;
double AllSumPrice=0;
int AllSumNum=0;
  String floor="";
  String jzarea="";
  String AreaStr="";
  float FatAreaVar=0;//临时保留建筑面积
  double IntSumPriceVar=0;//临时保留总价
  String Pfloor="";
  ResultSet change2RS = null;
	try{
	 
		change2RS = changePriceListBean.executeQuery(SqlView+" order by floor,room");
		int i=0;

	 
	         
		while (change2RS.next()) {
		    i=i+1;
			String yong_tu=getbyte(change2RS.getString("yong_tu"));
			int code = change2RS.getInt("Code");
			String roomn= change2RS.getString("room");
			String room = change2RS.getString("room_code");
			if (!floor.equals(""))Pfloor=floor;//保存前一记录的楼层号
			floor = change2RS.getString("floor");
			String cell=change2RS.getString("cell");
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
			
		
			jzarea=FormatD.getFloat(change2RS.getFloat("Area"),2);
			FatSumArea+=Float.parseFloat(jzarea);	
			AllSumArea+= Float.parseFloat(jzarea);
			//int salestate=change2RS.getInt("SaleState");
			float area=change2RS.getFloat("UsedArea");
			AreaStr=FormatD.getFloat(area,2);  
		    String tnunitPrice = FormatD.getFloat(change2RS.getFloat("tnunitprice"),2);	
			String unitPrice =FormatD.getFloat(change2RS.getFloat("unitprice"),2);
		    String sumPrice = FormatD.getFloat(change2RS.getFloat("sumprice"),2);
			IntPrvSumPrice=change2RS.getDouble("Nowsumprice");
			AllSumPrice+=IntPrvSumPrice;
		    String NowsumPrice = FormatD.getFloat3(IntPrvSumPrice,2);
		    String NowtnunitPrice = FormatD.getFloat3(change2RS.getDouble("Nowtnunitprice"),2);	
			IntSumPrice+=IntPrvSumPrice;
		    String Nowunitprice= FormatD.getFloat3(change2RS.getDouble("Nowunitprice"),2);
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
  
 
   String ss="insert into 试算价目表 select '"+paym+"','";
		 ss+=section+"','"+Region+"','"+room+"',"+roomn+","+floor+","+NowtnunitPrice+",";
		 	ss+=Nowunitprice+","+AreaStr+","+jzarea+","+NowsumPrice+",getdate(),'"+yong_tu+"',0,'"+building+"','"+cell+"',0,1,0";
		 
  ////String ss="insert into 试算价目表 select '"+paym+"','";
		//	ss+=section+"','"+Region+"','"+room+"',"+room+","+floor+","+NowtnunitPrice+",";
		//	ss+=Nowunitprice+","+AreaStr+","+jzarea+","+NowsumPrice+",getdate(),'"+yong_tu+"',0,'"+building+"'";
		 
		
		   changePriceListBean1.executeUpdate(ss);
		// out.print(ss+"<br>");
		 
   }
   change2RS.close();
}catch(Exception s){out.print(s.getMessage());%>

<%//}
}
 setlog( setlogBean ,( String )session.getAttribute( "loginid" ) ,"价格管理" , "调价("+section+Region+",方案名称:"+paym+")"
                ) ;
//输出最后一楼层的小计
     out.print("<tr align=center><td colspan=3><font color=red>"+floor+"</font><font color=red>楼总套数:</font><font color=red>"+IntRoomNum+"</font></td>");
     out.print("<td  colspan=2><font color=red>建筑面积"+FormatD.getFloat(FatSumArea,4)+"</font></td>");
	 out.print("<td  colspan=2><font color=red>总金额:</font><font color=red>"+FormatD.getFloat3(IntSumPrice,2)+"</font></td>");
	out.print("<td colspan=2><font color=red>均价:"+FormatD.getFloat3((IntSumPrice)/FatSumArea,2)+"</font></td>");
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
	<td><%=FormatD.getFloat3(AllSumPrice,2) %></td>
	<td><%=FormatD.getFloat3(AllSumPrice/AllSumArea,2) %></td>
	</tr>
 </table>
<input type=hidden name=sql value="<%=sql %>">
<input type=hidden name=sqlView value="<%=SqlView %>">
<input type=button name=ok value="打印价格表" onclick="save();">&nbsp;<input type=button name=cancel value="返回，重新调(定)价" onclick="window.history.back(1);">
</center>
 </form>

</center>
<script>
opener.window.location="PriceProjectList_xy.jsp?sel=1&SecNo=<%=section %>&Loft=<%=Region %>";
function save(){

//document.frm.action="SaveCharges.jsp";
document.frm.action="PriceListView.jsp?SecName=&SecNo=<%=section %>&Loft=<%=Region %>&Build=&payment=<%=paym  %>";
document.frm.submit();
//window.history.back(1);
}
</script>
</body>
</html>
