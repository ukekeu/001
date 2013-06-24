<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>房间编号列表</title>
</head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="javascript" src="../public_js/public.js"></script>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id = "changePriceListBean" scope = "page" class = "ConnDatabase.SDatabase" />
<jsp:useBean id = "FormatD" scope = "page" class = "FormatData.FormatData" />
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/asiic.jsp"%>
<%
	List list11=new LinkedList();//存放房间编码
	List list12=new LinkedList();//存放建筑面积
	List list13=new LinkedList();//存放单价
	List list14=new LinkedList();//存放总价
String strMessage=request.getParameter("mess");
String SecName=China.getParameter(request,"SecName");
String strSection=request.getParameter("SecNo");
String Region=China.getParameter(request,"Loft");
String RegionStr="";
float AllSumArea=0;
int AllSumPrice=0;
int AllSumNum=0;
String state="";

int tab=0;
if (strMessage==null){strMessage="";}

String strYN=request.getParameter("yn");
String loftnum=request.getParameter("loftnum");
   String strBuilding="";//(String)session.getAttribute("sess_build");
   strBuilding=China.getParameter(request,"Build");

   

String sql1="select lockroom from lockroom where section ='"+strSection+"' and ";
sql1+=" loft='"+Region+"' and build='"+strBuilding+"'";
ResultSet rsLock=null;
String LockRoomS="";
try{
  rsLock=InsertBean.executeQuery(sql1);
  while (rsLock.next()){
    LockRoomS=rsLock.getString("LockRoom");
  }
  rsLock.close();
}catch(Exception s)  {out.print("err");}    
String  sql="";
String intEndF=request.getParameter("intEndF");
String intEndR=request.getParameter("intEndR");
String intBeginR=request.getParameter("intBeginR");
String intBeginF=request.getParameter("intBeginF");
String changePriceStr = "";
	ResultSet changePriceRS = null;
	int hasRecord = 0;
    String section = "";
	String building = "";
	String Floor="";
	String RoomNo="";
	String color="";
   
	String change2Str = "";
	String  savePrice=China.getParameter(request,"savePrice");
	String gdprice=request.getParameter("gdprice");
	String floorRoom=request.getParameter("floorRoom");
	String DZ=China.getParameter(request,"D");
	String T=China.getParameter(request,"TJ");
	String OK=China.getParameter(request,"Ok");
	String sums=request.getParameter("sum");

	String allint=request.getParameter("allint");
	String StrRoomType=China.getParameter(request,"roomtype");
	String StrCx=China.getParameter(request,"cx");
	String StrMinFloor=China.getParameter(request,"minFloor");
	String StrMaxFloor=China.getParameter(request,"maxFloor");
	String RoomNos="";
	String djtype="";
	String SqlView="";
	String StrScalce="";
	String DS="";
	String choosetype="";
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
	String[] tmpArray1=new String[200];
	String[] tmpArray2=new String[200];
	String StrAreaType="";
	String StrAreaType1="";
	String StrTnPrice="";//套内单价;
	String StrJzPrice="";//建筑单价;
	String NowSumPrice="";
	String StrPriceName="";//单价类型(建筑、套内单价)
	String StrPriceName1="";//单价类型(建筑、套内单价)
	String StrBasicRoom=request.getParameter("basicRoom");//取出基价房间号
	String StrFloors="";
  float FatSumArea=0;
  int   IntSumPrice=0;
  int   IntRoomNum=0;
  float FatAvgPrice=0;
  int IntPrvSumPrice=0;
  String floor="";
  String jzarea="";
  String AreaStr="";

  float FatAreaVar=0;//临时保留建筑面积
  int IntSumPriceVar=0;//临时保留总价
  String Pfloor="";
	 sql="select unitprice as price  from room where seccode='"+section
	   +"' and Loft='"+Region+"' and building='"+building+"'"
	   +" and Room_code='"+	StrBasicRoom+"'";
	   StrAreaType="*Area/UsedArea";
	    StrAreaType1="*Area";
	   StrPriceName="unitprice ";
	   StrPriceName1="TNunitprice ";
	
	ResultSet priceRs=null;

	try{
	   priceRs=changePriceListBean.executeQuery(sql);
	   if (priceRs.next())StrPrice=priceRs.getString("price");
	}catch(Exception s){}
	priceRs.close();
	//}
	//if (StrBasicRoom.equals("")){
	  StrPrice=gdprice;
	//}
	float scale=0;
	int x=0;
	String cSumPrice1="";
	String cPrice2="";
	String cPrice1="";
	String StartFloor="";
	String RoomNos1="";
	String RoomNos2="";
	String RoomRate="0";
    String StrNowPrice1="";
    String StrNowPrice2="";
	String strroom="";
	String SumPrice1="";
	int tt=0;
	int rr=0;
	String Price2="";
	String cStrNowPrice1="";
	String cStrNowPrice2="";
	String cNowSumPrice="";
	String Price1="";
	String str9=""; 
	OK="1";
	if (!OK.equals("")){
	   for(int i=Integer.parseInt(intBeginF);i<=Integer.parseInt(intEndF);i++){
	     for(int j=Integer.parseInt(intBeginR);j<=Integer.parseInt(intEndR);j++){
		  strroom="";
		   if (StartFloor.equals("")) StartFloor=String.valueOf(i);
		   tmpArray1[x]="Pr"+String.valueOf(i)+String.valueOf(j);
		   strroom=China.getParameter(request,tmpArray1[x]);
		   tmpArray2[x]="P"+String.valueOf(i)+String.valueOf(j);
		   if(!strroom.equals(""))x++;
		   
		   
		 }		
	   }   
	   for(x=0;x<Integer.parseInt(allint);x++){
	       String str=tmpArray1[x];
		   String str1=tmpArray2[x];
		       str1=China.getParameter(request,str1);
		   
		   String str3="Q"+String.valueOf(x);
		   str3=China.getParameter(request,str3);
		   if(!str3.equals("0"))str1=str1+str3;
		   String str4="R"+String.valueOf(x);
		    str4=China.getParameter(request,str4);
		   if(!str4.equals("0"))str1=str1+str4;
		   String str5="S"+String.valueOf(x);
		    str5=China.getParameter(request,str5);
		   if(!str5.equals("0"))str1=str1+str5;
		   String str6="";
     	   //  str6=China.getParameter(request,str6);
	       String str10="Ts"+String.valueOf(x);
			    str10=China.getParameter(request,str10);
		   if(x<Integer.parseInt(sums)){
		     for(int y=x;y<=Integer.parseInt(sums);y++){
			   String str7="Ts"+String.valueOf(y);
			    str7=China.getParameter(request,str7);
    		   String str8="T"+String.valueOf(y);
			    str8=China.getParameter(request,str8);
				if(y==Integer.parseInt(sums)-1)str9=floorRoom;
				if(!str7.equals(floorRoom)){
				 if(!str7.equals(str9)){
			       
				  if(str8.equals("")){str8="+0";}else{
				  if(str8.equals("0"))str8="+0";
				   str6=str6+str8;str9=str7;}
				   
				  }
				  
				}
			 }
		   }
		   if(x==Integer.parseInt(sums))str6="+0";
		   if(x>Integer.parseInt(sums)){
		      for(int y=Integer.parseInt(sums);y<=x;y++){
			    
			   String str7="Ts"+String.valueOf(y);
			    str7=China.getParameter(request,str7);
				
    		   String str8="T"+String.valueOf(y);
	
	     		//if(!str7.equals(floorRoom)){
				 if(!str7.equals(str9)){
			       str8=China.getParameter(request,str8);
				  if(str8.equals("")){str8="+0";}else{
				   if(str8.equals("0"))str8="+0";
				   str6=str6+str8;str9=str7;}
				  }
				  if(y==Integer.parseInt(sums)-1)str9=floorRoom;
				}
			 //}
		   }
		   
		   //out.print(str6+"<br>");
		   
		    
		   if(!str6.equals("0"))str1=str1+str6;
			//out.print(str1+"<br>");
			String str2="";
			
	        if (!str1.equals("")){
			  if (str1.substring(0,1).equals("+"))str2="+";
			  if (choosetype.equals("2"))str1=StrPrice+"*(1"+str2+String.valueOf(Float.parseFloat(str1)/100)+")";
			  
			  else str1="("+StrPrice+"+"+str1+")";
		      
			  RoomNos="'"+request.getParameter(str)+"'";//取出选中的值(房间号)
			  if (x==0){
			  
			   RoomNos2="'"+request.getParameter(str)+"'";
			  }
			  else{
			   RoomNos2+=",'"+request.getParameter(str)+"'";//取出选中的值(房间号)
			   }
			    StrNowPrice1="  when (room_code='"+request.getParameter(str)+"') "
			    +" then " +str1+ StrAreaType;
				cStrNowPrice1=cStrNowPrice1+StrNowPrice1;
				StrNowPrice2="  when (room_code='"+request.getParameter(str)+"') "
			    +" then " +str1;
				cStrNowPrice2=cStrNowPrice2+StrNowPrice2;
	            NowSumPrice="  when (room_code='"
				+request.getParameter(str)+"')"
			    +" then " +str1+StrAreaType1;
				cNowSumPrice=cNowSumPrice+NowSumPrice;
  		    }    
	  
       SumPrice1="SumPrice= case "+NowSumPrice+" end";//当前总价
	   cSumPrice1="SumPrice= case "+cNowSumPrice+" end";//当前总价
	   NowSumPrice="NowSumPrice= case "+NowSumPrice+" end";//当前总价
	   Price2=StrPriceName+"= case"+StrNowPrice2+ " end ";//当前建筑或套单价
	   cPrice2=StrPriceName+"= case"+cStrNowPrice2+ " end ";//当前建筑或套单价
	   
	   StrNowPrice2="Now"+StrPriceName+"= case"+StrNowPrice2+ " end ";//当前建筑或套单价
	   Price1=StrPriceName1+"= case"+StrNowPrice1+ " end ";//当前建筑或套单价 
	   cPrice1=StrPriceName1+"= case"+cStrNowPrice1+ " end ";//当前建筑或套单价 
	   StrNowPrice1="Now"+StrPriceName1+"= case"+StrNowPrice1+ " end ";//当前建筑或套单价 
	  
	   SqlView="select code,room_code,floor,Area,UsedArea, tnunitprice,unitprice,"
	   +"sumprice,"+NowSumPrice+","+StrNowPrice2+","+StrNowPrice1+" from room where "
	   +" room_code ="+RoomNos+" and seccode='"+section+"' and "
	   +"building='"+building+"'  and Loft='"+Region+"' and salestate=1";
	   //out.print(SqlView);
	  
	    RoomNos1=RoomNos;//"'"+request.getParameter(str)+"'";//取出选中的值
  

  ResultSet change2RS = null;
	try{
		change2RS = changePriceListBean.executeQuery(SqlView+" order by floor");
		int i=0;

		if (change2RS.next()) {
		    i=i+1;
			int code = change2RS.getInt("Code");
			String room = change2RS.getString("room_code");
			list11.add(room);
			if (!floor.equals(""))Pfloor=floor;//保存前一记录的楼层号
			floor = change2RS.getString("floor");
			%>
		  <%
		   if (!StrFloors.equals("")&&!StrFloors.equals(floor)){//如果不属于同一楼层，则输出上一楼层的小计
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
			list12.add(jzarea.toString());
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
			list14.add(NowsumPrice);
		    String NowtnunitPrice = FormatD.getFloat(change2RS.getFloat("Nowtnunitprice"),2);	
			IntSumPrice+=IntPrvSumPrice;
		    String Nowunitprice= FormatD.getFloat(change2RS.getFloat("Nowunitprice"),2);
			list13.add(Nowunitprice);
            AllSumNum++;
			rr=tt;
 %>

  <%	IntRoomNum++;
   }
   change2RS.close();
}catch(Exception s){out.print(s.getMessage());%>

<%}
}
    }
	 sql="update room set " +cSumPrice1+","+cPrice2+","
	   +cPrice1+ " where room_code in("+RoomNos2+") and seccode='"
	   +section+"' and building='"+building+"'  and Loft='"+Region+"' and salestate=1";

    IntSumPrice=0;
	FatSumArea=0;
	IntRoomNum=0;
    StringTokenizer st22 = new StringTokenizer(LockRoomS,",") ;
    int count22 = st22.countTokens() ;
		String locaPara="Loft="+Region+"&Build="+strBuilding+"&SecNo="+strSection+"&SecName="+SecName;
		String upp="ABCDEFGHIJKOPQRST";
		upp=upp.trim();
		int nn=0;
        String RoomNoUp="";
		String  sqlU="select top 1 RoomNo,state from RoomNo where SectionNo=";
				sqlU=sqlU+"'"+strSection+"' and Building='";
				sqlU=sqlU+strBuilding+"' and Region='"+Region+"'";
		ResultSet rsU=InsertBean1.executeQuery(sqlU);
        if (rsU.next())RoomNoUp=rsU.getString("RoomNo");
		rsU.close();
        if (RoomNoUp.equals("")){
		%>
		<script>
       alert("此栋还没有进行房间编号操作"))
  
</script>
		 <%}else{%>
<body>
<form method="post" name=frm  target="_blank">
    <input type=hidden name=SecNo value="<%=strSection %>">
    <input type=hidden name=Loft value="<%=Region %>">
    <input type=hidden name=SecName value="<%=SecName %>">
    <input type=hidden name=Build value="<%=strBuilding %>">
    <input type=hidden name=choose>
    <input type=hidden name=RegionNA value="<%=RegionStr %>">
    <input type=hidden name=RegionNO value="<%=Region %>">
    <input type=hidden name=SectionNA value="<%=SecName %>">
    <input type=hidden name=SectionNO value="<%=strSection %>">
    <input type=hidden name=intEndR value="<%=intEndR %>">
    <input type=hidden name=intEndF value="<%=intEndF %>">
    <input type=hidden name=intBeginR value="<%=intBeginR %>">
    <input type=hidden name=intBeginF value="<%=intBeginF %>">
    <input type=hidden name=SecNo value="<%=section%>">
    <input type=hidden name=Loft value="<%=Region %>">
    <input type=hidden name=Build value="<%=building%>">
    <input type=hidden name=choose>
<div align="center">
<p><font size=3><b><%=SecName %>人民币价目表</font></b></p>

 <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF">
    <tr>
		<td align="center" height="10"><font size="2"><b>楼栋</b></font></td>
		<td align="center" height="10" colspan="<%=3*Integer.parseInt(loftnum) %>"><font size="2"><b><%=Region %></b></font></td>
		<td align="center" height="10"><font size="2"><b>楼栋</b></font></td>	
	</tr>
   <tr>
		<td align="center" height="10"><font size="2"><b>单位</b></font></td>
		<%
		RoomNoUp=RoomNoUp.substring(RoomNoUp.length()-1);
        char BeR=RoomNoUp.charAt(0);

		//int nn=0;
		for(int j=Integer.parseInt(intBeginR);j<=Integer.parseInt(intEndR);j++){
			if (LockRoomS.indexOf(String.valueOf(j))>=0||upp.indexOf(LockRoomS)>=0){
        
			 if (upp.indexOf(LockRoomS)>=0){
			   String NO="";
			     NO=AsiicZH(j,BeR);//调用asiic转换方法
				 
			 if (LockRoomS.indexOf(NO)<0){
			%>
		     <td align="center" colspan="3" height="10"><font size="2"><b><%=NO%></b></font></td>
			 <%}
			 }else if (LockRoomS.indexOf(String.valueOf(j))<0){
			 %>
			 <td align="center"  colspan="3"  height="10"><font size="2"><b><%=j%></b></font></td>
			 <%} %>	
			 <%}else{%>
			 <td align="center"  colspan="3"  height="10"><font size="2"><b><%=j%></b></font></td>
			 
			 <%}
			 
			 }%>  
		<td align="center" height="10"><font size="2"><b>单位</b></font></td>	
	</tr>
	 <tr>
		<td align="center" height="10"><font size="2"><b>楼层</b></font></td>
		<%for(int u=0;u<Integer.parseInt(loftnum);u++) {%>
		<td align="center" height="10"><font size="2"><b>面积</b></font></td>
		<td align="center" height="10"><font size="2"><b>单价</b></font></td>
		<td align="center" height="10"><font size="2"><b>总价</b></font></td>
		<%} %>
		<td align="center" height="10"><font size="2"><b>楼层</b></font></td>
	</tr>	  
	<%
	List list1=new LinkedList();//存放房间编码
	
	List list2=new LinkedList();//存放房间状态
	List list3=new LinkedList();//存放所在FLoor
    List list4=new LinkedList();//存放房号
	List list5=new LinkedList();//存放建筑面积
    List list6=new LinkedList();//存放当前总价
	List list7=new LinkedList();//存放当前单价
	List list9=new LinkedList();//
	int arryFloor[]=new int[1];//临时保存楼层号
    String StrUpper="ABCDEFGHIJKHOPQ"; 
	String sqlArr="select  distinct Room_code,saleState,Floor,Room,area,unitprice,Sumprice from room where seccode=";
		   sqlArr=sqlArr+"'"+strSection+"'";
		   sqlArr=sqlArr+" and  loft='"+Region+"' and building='"+strBuilding+"'  and SaleState =1  order by  Floor";
		   ResultSet rsArr=InsertBean1.executeQuery(sqlArr);
		   int aryi=0;
		   while (rsArr.next()){
		    
		    list1.add(getbyte(rsArr.getString("Room_code")));
			list2.add(getbyte(rsArr.getString("SaleState")));
			String flo=getbyte(rsArr.getString("Floor"));
			list3.add(flo);
			String roo=getbyte(rsArr.getString("Room"));
			list4.add(roo);
			list9.add(flo+"|"+roo);
			list5.add(getbyte(rsArr.getString("area")));
			list7.add(getbyte(rsArr.getString("unitprice")));
			list6.add(getbyte(rsArr.getString("Sumprice")));
			
			//out.println(RoomArry[aryi]);
		   } 
	      rsArr.close();
		int arrlen=0;
	 %>
	<%for(int iii=Integer.parseInt(intEndF);iii>=Integer.parseInt(intBeginF);iii--){%>
	<tr >
		<%
		int IntAvgSumPrice=0;;
		float FatAreaSum=0;
		for(int j=Integer.parseInt(intBeginR);j<=Integer.parseInt(intEndR);j++){
		RoomNo="";
		String no="";
		RoomNo=String.valueOf(iii)+"|"+String.valueOf(j);
		arrlen+=1;
		if (list9.contains(RoomNo)){
		   int index=list9.indexOf(RoomNo);
		   RoomNo=(String)list1.get(index);//取出由楼层+房间号对应的房间编码
		   
		   state=(String)list2.get(index);
		 }else{state="";}  
		
	      String FloorNo=RoomNo.substring(0,1);
		 char FloNo=FloorNo.charAt(0);//判断楼层是否以字母编号
		
		if (arryFloor[0]!=iii){
		 arryFloor[0]=iii;
		 %>
   		<td align="center" height="10"><font size="2"><b><%=iii%></b></font></td>
		<%}%>
		
		<%  
		String area11="";
		String unitprice11="";
		String sumprice11="";
		 if (!LockRoomS.trim().equals(String.valueOf(j))){ 
		%>
		<%if (!state.equals("")){
	      int index1=list1.indexOf(RoomNo);
		 
		   area11=(String)list5.get(index1);
		   
		   unitprice11=(String)list7.get(index1);
		   unitprice11=unitprice11.substring(0,unitprice11.indexOf("."));
		   sumprice11=(String)list6.get(index1);
		 
	      }%>
		<td align="center" height="10"><font size="2">&nbsp;<%=area11 %></font></td>
		<td align="center" height="10"><font size="2">&nbsp;<%=unitprice11 %></font></td>
	     <td align="center" height="10"><font size="2">&nbsp;<%=sumprice11 %></font></td> 
		<%   
        
		}%>
		<%}%>
	   <td align="center" height="10"><font size="2"><b><%=iii%></b></font></td>

	</tr>
	
	 <script>
	  function butoncheck(){
	  // document.frm.Ok.disabled=getseldocs1();//!(frm.checked);
	  }
	  
	  function ChangePrice(frm){
	  if (frm.checked)document.frm.price.value=0;
	  
	  
	  }
	   </script>
	<% }%>
	<%AllSumNum=0;
	  AllSumArea=0;
	  AllSumPrice=0;
	sql="select count(*) nn,sum(area) area,sum(Sumprice) Sumprice from room where  seccode='"+strSection+"' and  loft='"+Region+"' and building='"+strBuilding+"' and salestate=1";
  try{
  rsLock=InsertBean.executeQuery(sql);
  if (rsLock.next()){
    AllSumNum=rsLock.getInt("nn");
	AllSumArea=rsLock.getFloat("area");
	AllSumPrice=rsLock.getInt("Sumprice");
  }
  rsLock.close();
   }catch(Exception s)  {out.print(s.getMessage());} 
	int AllSumNum_S=0;
	float AllSumArea_S=0;
	int AllSumPrice_S=0; 
   sql="select count(*) nn,sum(jzarea) area,sum(salerprice*rate) Sumprice from order_contract where  section='"+strSection+"' and  loft='"+Region+"' and building='"+strBuilding+"' and state !=3";
  try{
  rsLock=InsertBean.executeQuery(sql);
  if (rsLock.next()){
    AllSumNum_S=rsLock.getInt("nn");
	AllSumArea_S=rsLock.getFloat("area");
	AllSumPrice_S=rsLock.getInt("Sumprice");
  }
  rsLock.close();
 }catch(Exception s)  {out.print(s.getMessage());}     
  sql="update room set " +cSumPrice1+","+cPrice2+","
	   +cPrice1+ " where room_code in("+RoomNos2+") and seccode='"
	   +section+"' and building='"+building+"'  and Loft='"+Region+"' and salestate=1"; %>
<br>
 <center>
 <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF">
   <tr align="center">
    <td  height="10"><font size="2"><b>序号</b></font></td> 
    <td  height="10"><font size="2"><b>未售套数</b></font></td>
    
    <td  height="10"><font size="2"><b>未售建筑面积</b></font></td>
    
    <td height="10"><font size="2"><b>未售总价</b></font></td>
    
    <td height="10"><font size="2"><b>未售均价</b></font></td>
    <td  height="10"><font size="2"><b>已售套数</b></font></td>
    <td  height="10"><font size="2"><b>已售建筑面积</b></font></td>
    <td height="10"><font size="2"><b>已售总价</b></font></td>
    <td height="10"><font size="2"><b>已售均价</b></font></td>
  </tr>
  <tr align="center">
        <td height="10"><font size="2">1</font></td>
        <td height="10"><font size="2"><%=AllSumNum %></font></td>
        
	<td height="10"><font size="2"><%=FormatD.getFloat(AllSumArea,4) %></font></td>
        
	<td height="10"><font size="2"><%=FormatD.getFloat(AllSumPrice,0) %></font></td>
        
	<td height="10"><font size="2"><%=FormatD.getFloat(AllSumPrice/AllSumArea,2) %></font></td>

        <td height="10"><font size="2"><%=AllSumNum_S%></font></td>
        <td height="10"><font size="2"><%=AllSumArea_S%></font></td>
        <td height="10"><font size="2"><%=AllSumPrice_S%></font></td>
        <td height="10"><font size="2"><%=FormatD.getFloat(AllSumPrice_S/AllSumArea_S,2)%></font></td>
	</tr>
 <tr align="center"> 
    <td  height="10"><font size="2"><b>&nbsp;小计</td>
    <td colspan="2"  height="10"><font size="2"><b>&nbsp;套数</b><%=AllSumNum+AllSumNum_S %></font></td>
    <td colspan="2"  height="10"><font size="2"><b>&nbsp;建筑面积</b><%=Float.parseFloat(FormatD.getFloat(AllSumArea,4))+AllSumArea_S %></font></td>
    <td colspan="2" height="10"><font size="2"><b>&nbsp;总价</b><%=FormatD.getFloat((Float.parseFloat(FormatD.getFloat(AllSumPrice,4))+AllSumPrice_S),4) %></font></td>
    <td colspan="2" height="10"><font size="2"><b>&nbsp;均价</b><%=FormatD.getFloat((Float.parseFloat(FormatD.getFloat(AllSumPrice,4))+AllSumPrice_S) /(Float.parseFloat(FormatD.getFloat(AllSumArea,4))+AllSumArea_S),4)%></font></td>
  </tr>
 </table>
  <%} %>
<input type=hidden name=sql value="<%=sql %>">
<input type=hidden name=sqlView value="<%=SqlView %>">
<p align="center"> <div   id="divprint" align="center">

<!--input type=button name="savePrice" value="传递价格" onclick="save();"-->

 &nbsp;&nbsp;<input type=button name="printPrice" onclick="prin();" value="打印价格表"></div>
</p>
</center>
 </form>

</center>
<script>
function prin(){
divprint.innerHTML="";
print();
}
function save(){
 if(confirm("确定传递该价格方案")){
document.frm.action="savepricelist.jsp";
document.frm.submit();}
//window.history.back(1);
}
</script>
</body>
</html>
