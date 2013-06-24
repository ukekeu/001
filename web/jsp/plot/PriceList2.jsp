<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>定价试算表</title>
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
<%@ include file="../public_js/logrecord.jsp" %>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/asiic.jsp"%>
<%   
	List list11=new LinkedList();//存放房间编码
	List list12=new LinkedList();//存放建筑面积
	List list13=new LinkedList();//存放单价
	List list14=new LinkedList();//存放总价
	List list15=new LinkedList();//存放总价
	int sumnum=0;
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
 
String paymentname=getbyte1(request.getParameter("projectname"));	
String strMessage=request.getParameter("mess");
String SecName=China.getParameter(request,"SecName");
String strSection=request.getParameter("SecNo");
String Region=China.getParameter(request,"Loft");
String floortype=China.getParameter(request,"floortype");
if (floortype.equals(""))floortype=" and floortype=0";
else floortype=" and floortype="+floortype;
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
String lock="";
String LockRoomS="";
List Lock=new LinkedList();//存放禁用号
try{
  rsLock=InsertBean.executeQuery(sql1);
  
  while (rsLock.next()){
    String aaa=rsLock.getString("LockRoom");
	if (lock.equals(""))lock=aaa;
	else lock+=","+aaa;
	   
	char lokeA=aaa.charAt(0);
	if(!java.lang.Character.isDigit(lokeA)){
	  aaa=String.valueOf(Character.getNumericValue(lokeA)-9);
	}
	 Lock.add(aaa);
    if (LockRoomS.equals(""))
     LockRoomS=aaa;
	else
	 LockRoomS+=","+aaa;
     
 
  }
  rsLock.close();
}catch(Exception s)  {}
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
	String zhiroom=request.getParameter("zhiroom");
	String zhiprice=request.getParameter("zhiprice");
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
	String[] tmpArray1=new String[500];
	String[] tmpArray2=new String[500];
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
  float IntPrvSumPrice=0;
  String floor="";
  String jzarea="";
  String AreaStr="";
  String StrAreaType2="";
  float FatAreaVar=0;//临时保留建筑面积
  float IntSumPriceVar=0;//临时保留总价
  String Pfloor="";
	 sql="select unitprice as price  from room where seccode='"+section
	   +"' and Loft='"+Region+"' and building='"+building+"'"
	   +" and Room_code='"+	StrBasicRoom+"'"+floortype;
	   String type=request.getParameter("ch");
	   if (type.equals("1")){
	    StrAreaType="*Area/UsedArea";
	    StrAreaType1="*Area";
	    StrPriceName="unitprice ";
	    StrPriceName1="TNunitprice ";
	  }else{
	    StrAreaType="/UsedArea";
		
	    StrAreaType2="/area";//建筑单价
	    StrPriceName="unitprice ";
	    StrPriceName1="TNunitprice ";
	  
	  
	  }
	  
	ResultSet priceRs=null;

	 
	  StrPrice=gdprice;
	 
	float scale=0;
	int x=0;
	int xx=0;
	String astr="";
    String bstr="";
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
	 String Rinfo="";
	 
	if (!OK.equals("")){
	  changePriceListBean.executeUpdate("delete 试算价目表 where payment='"+paymentname+"' and sectionno='"+section+"' and loft='"+Region+"'");
	  for(int j2=scell;j2<=ecell;j2++){
			if (scell>0){  
			  Rinfo=AsiicZH(j2,CellN1); 
			}
			
	   for(int i=Integer.parseInt(intBeginF);i<=Integer.parseInt(intEndF);i++){
	 
	     for(int j=Integer.parseInt(intBeginR);j<=Integer.parseInt(intEndR);j++){
		  strroom="";
		  String Fn="";
		
		  if (i<0) Fn="_"+String.valueOf(java.lang.Math.abs(i));
		  else Fn=String.valueOf(i);
		   if (StartFloor.equals("")) StartFloor=String.valueOf(i);
		   tmpArray1[x]="Pr"+Rinfo+Fn+"A"+String.valueOf(j);
		   strroom=China.getParameter(request,tmpArray1[x]);
		   tmpArray2[x]="P"+Rinfo+Fn+"A"+String.valueOf(j);
		 
		// if (j==1)
		  //out.print(request.getParameter("P"+String.valueOf(i)+"A"+String.valueOf(j))+"<br>");
		   if(!strroom.equals(""))x++;
		    
		   
		 }		
	   }     
	   }
	    for(int j2=scell;j2<=ecell;j2++){
			if (scell>0){  
			  Rinfo=AsiicZH(j2,CellN1); 
			}
	 
	  
	   for(x=0;x<Integer.parseInt(allint);x++){
	        String str=tmpArray1[xx];
		   String str1=tmpArray2[xx];
		   xx++;
		  
		   str1=China.getParameter(request,str1);
		
		   String str3="Q"+Rinfo+String.valueOf(x);
		   str3=China.getParameter(request,str3);
		   if(!str3.equals("0"))str1=str1+"+"+str3;
		   String str4="R"+Rinfo+String.valueOf(x);
		     
		    str4=China.getParameter(request,str4);
		   if(!str4.equals("0"))str1=str1+"+"+str4;
		   
		   String str5="S"+Rinfo+String.valueOf(x);
		 
		    str5=China.getParameter(request,str5);
			
		   if(!str5.equals("0"))str1=str1+"+"+str5;
		
		   String str6="";
     	   //  str6=China.getParameter(request,str6);
	       String str10="Ts"+Rinfo+String.valueOf(x);
			    str10=China.getParameter(request,str10);
		   if(x<Integer.parseInt(sums)){
		   //  for(int y=x;y<=Integer.parseInt(sums);y++){
			   String str7="Ts"+Rinfo+String.valueOf(x);
			    str7=China.getParameter(request,str7);
    		   String str8="T"+Rinfo+String.valueOf(x);
			    str8=China.getParameter(request,str8);
				
				//if(!str7.equals(floorRoom)){
				 if(!str7.equals(str9)){
			       
				  if(str8.equals("")){str8="+0";}
				  else{	  if(str8.equals("0"))str8="+0";
				          str6=str6+str8;str9=str7;
					}
				   
				  }
				//  if(y==Integer.parseInt(sums)-1)str9=floorRoom;
				//}
			// }
		   }
		     
		 
		  
		  str1=str1+"+"+request.getParameter("T"+Rinfo+x);
		 
			String str2="";
			 
			 try{
			 
	        if (!str1.equals("")){
			
			  if (str1.substring(0,1).equals("-"))str2="-";
			  else str2="+";
			 try{
			  if (choosetype.equals("2")){//String.valueOf(Float.parseFloat(str1)/100)
			    str1=StrPrice+"*(1"+str2+"("+str1+")/100.0"+")";
				
				}
			  
			  else str1="("+StrPrice+"+"+str1+")";
		     }catch(Exception s){}
			
			 
			  RoomNos="'"+getbyte1(request.getParameter(str))+"'";//取出选中的值(房间号)
			  if (x==0){
			  	   RoomNos2="'"+getbyte1(request.getParameter(str))+"'";
			  }
			  else{
			   RoomNos2+=",'"+getbyte1(request.getParameter(str))+"'";//取出选中的值(房间号)
			   }
			  
			    StrNowPrice1="  when (room_code='"+getbyte1(request.getParameter(str))+"') "
			    +" then " +str1+ StrAreaType;

				if (type.equals("1")){
				  if(request.getParameter(str).equals(zhiroom))
				   StrNowPrice1="  when (room_code='"+zhiroom+"')"+" then " +zhiprice+"*Area/usedarea" ;
				   cStrNowPrice1=cStrNowPrice1+StrNowPrice1;
				   StrNowPrice2="  when (room_code='"+getbyte1(request.getParameter(str))+"') "
			       +" then " +str1;
				   if(request.getParameter(str).equals(zhiroom))
				   StrNowPrice2="  when (room_code='"+zhiroom+"')"+" then " +zhiprice ;
				   cStrNowPrice2=cStrNowPrice2+StrNowPrice2 ;
			   
	               NowSumPrice="  when (room_code='"
				   +getbyte1(request.getParameter(str))+"')"
			      +" then " +str1+StrAreaType1;
				  if(request.getParameter(str).equals(zhiroom))
				   NowSumPrice="  when (room_code='"+zhiroom+"')"+" then " +zhiprice+"*Area" ;
				 cNowSumPrice=cNowSumPrice+NowSumPrice;
				 }else{
				
				 
				  if(request.getParameter(str).equals(zhiroom))
				   StrNowPrice1="  when (room_code='"+zhiroom+"')"+" then " +zhiprice+"/usedarea" ;
				   cStrNowPrice1=cStrNowPrice1+StrNowPrice1;
				   StrNowPrice2="  when (room_code='"+request.getParameter(str)+"') "
			       +" then " +str1+"/area";//建筑面积单价
				  
				   if(request.getParameter(str).equals(zhiroom))
				   StrNowPrice2="  when (room_code='"+zhiroom+"')"+" then " +zhiprice +"/area";
				   cStrNowPrice2=cStrNowPrice2+StrNowPrice2 ;
			  
	               NowSumPrice="  when (room_code='"
				   +getbyte1(request.getParameter(str))+"')"
			      +" then " +str1;//总价
						
				  if(getbyte1(request.getParameter(str)).equals(zhiroom))
				   NowSumPrice="  when (room_code='"+zhiroom+"')"+" then " +zhiprice+"" ;
				   
				 cNowSumPrice=cNowSumPrice+NowSumPrice;
				 
				   
				}
				 	
				
				
  		    }    

       SumPrice1="SumPrice= case "+NowSumPrice+" end";//当前总价
	   cSumPrice1="SumPrice= case "+cNowSumPrice+" end";//当前总价
	    //out.print(NowSumPrice);
	   NowSumPrice="NowSumPrice= case "+NowSumPrice+" end";//当前总价
	
	   Price2=StrPriceName+"= case"+StrNowPrice2+ " end ";//当前建筑或套单价
	   cPrice2=StrPriceName+"= case"+cStrNowPrice2+ " end ";//当前建筑或套单价
	 	
	//   if (type.equals("0"))StrNowPrice2+="/area";
	   StrNowPrice2="Now"+StrPriceName+"= case"+StrNowPrice2+ " end ";//当前建筑或套单价
	   Price1=StrPriceName1+"= case"+StrNowPrice1+ " end ";//当前建筑或套单价 
	   cPrice1=StrPriceName1+"= case"+cStrNowPrice1+ " end ";//当前建筑或套单价 
	   StrNowPrice1="Now"+StrPriceName1+"= case"+StrNowPrice1+ " end ";//当前建筑或套单价 

	   SqlView="select seccode,loft,room,room_code,yong_tu,code,room_code,floor,Area,UsedArea, tnunitprice,unitprice,"
	   +"sumprice,"+NowSumPrice+","+StrNowPrice2+","+StrNowPrice1+",cell from room where "
	   +" room_code ="+RoomNos+" and seccode='"+section+"' and "
	   +"building='"+building+"'  and Loft='"+Region+"' and salestate=1"+floortype;

	
	    RoomNos1=RoomNos;//"'"+request.getParameter(str)+"'";//取出选中的值

  ResultSet change2RS = null;
	try{
		change2RS = changePriceListBean.executeQuery(SqlView+" order by floor");
		int i=0;
 
		while (change2RS.next()) {
		    sumnum++;
		    i=i+1;
			 astr=change2RS.getString("seccode");
			 bstr=change2RS.getString("loft");
			String roomn=change2RS.getString("room");
			String cstr=change2RS.getString("room_code");
			
			String yong_tu=change2RS.getString("yong_tu");
			list15.add(yong_tu);
			int code = change2RS.getInt("Code");
			String room = change2RS.getString("room_code");
			list11.add(room);
			String cell= change2RS.getString("cell");
			 
			if (!floor.equals(""))Pfloor=floor;//保存前一记录的楼层号
			floor = change2RS.getString("floor");
			String dstr=floor;
		   if (!StrFloors.equals("")&&!StrFloors.equals(floor)){//如果不属于同一楼层，则输出上一楼层的小计
		     IntSumPrice=0;
			 FatSumArea=0;
			 IntRoomNum=0;
			 FatAreaVar=Float.parseFloat(jzarea);
			 IntSumPriceVar=IntPrvSumPrice;
		   }
		    StrFloors=String.valueOf(floor);
			jzarea=FormatD.getFloat(change2RS.getFloat("Area"),2);
			list12.add(jzarea.toString());
			FatSumArea+=Float.parseFloat(jzarea);	
			AllSumArea+= Float.parseFloat(jzarea);
			//int salestate=change2RS.getInt("SaleState");
			float area=change2RS.getFloat("UsedArea");
			AreaStr=FormatD.getFloat1(area,4);  
		    String tnunitPrice = FormatD.getFloat(change2RS.getFloat("tnunitprice"),2);	
			String unitPrice =FormatD.getFloat(change2RS.getFloat("unitprice"),2);
		    String sumPrice = FormatD.getFloat(change2RS.getFloat("sumprice"),0);
			 
			IntPrvSumPrice=change2RS.getFloat("Nowsumprice");
			
			
			
			//if (type.equals("0"))IntPrvSumPrice=Integer.parseInt(request.getParameter("gdprice"));
			//out.print(Integer.parseInt(FormatD.getFloat1(IntPrvSumPrice*Float.parseFloat(jzarea),0)));
			AllSumPrice+=IntPrvSumPrice;
		    String NowsumPrice = FormatD.getFloat1(IntPrvSumPrice,0);
		
			list14.add(NowsumPrice);
		    String NowtnunitPrice = FormatD.getFloat1(change2RS.getFloat("Nowtnunitprice"),2);	
			IntSumPrice+=IntPrvSumPrice;
		    String Nowunitprice= change2RS.getFloat("Nowunitprice")+"";
			list13.add(Nowunitprice);
            AllSumNum++;
			rr=tt;
			
			String ss="insert into 试算价目表 select '"+paymentname+"','";
			ss+=astr+"','"+bstr+"','"+cstr+"',"+roomn+","+dstr+","+NowtnunitPrice+",";
			ss+=Nowunitprice+","+AreaStr+","+jzarea+","+NowsumPrice+",getdate(),'"+yong_tu+"',0,'"+strBuilding+"','"+cell+"',0,0,0";
		 
			InsertBean1.executeUpdate(ss);
			
			 
  	IntRoomNum++;
   }
   change2RS.close();
}catch(Exception s){} 
}catch(Exception s){ }
}
 } }
 setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "价格管理" , 
                  "定价("+astr+bstr+",方案名称:"+paymentname+")"
                ) ;
 
	 sql="update room set " +cSumPrice1+","+cPrice2+","
	   +cPrice1+ " where room_code in("+RoomNos2+") and seccode='"
	   +section+"' and building='"+building+"'  and Loft='"+Region+"' and salestate=1"; 
    IntSumPrice=0;
	FatSumArea=0;
	IntRoomNum=0;
    StringTokenizer st22 = new StringTokenizer(LockRoomS,",") ;
    int count22 = st22.countTokens() ;
		String locaPara="Loft="+Region+"&Build="+strBuilding+"&SecNo="+strSection+"&SecName="+SecName;
		String upp="ABCDEFGHIJKLOPQRST";
		upp=upp.trim();
		int nn=0;
        String RoomNoUp="";
		String  sqlU="select top 1 RoomNo,state from RoomNo where SectionNo=";
				sqlU=sqlU+"'"+strSection+"' and Building='";
				sqlU=sqlU+strBuilding+"' and Region='"+Region+"'"+floortype;
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
<center>
  <div align=left id=report1 style="background-color:#F7F7F7;height:200%;overflow:auto;width:98%;z-index:2" contentEditable>

<p align="center"><font size=3><b><%=SecName %>人民币价目表</font></b></p>

 <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF">
   <%for(int j2=scell;j2<=ecell;j2++){
			if (scell>0){  
			  Rinfo=AsiicZH(j2,CellN1); 
			} %>
    <tr>
		<td align="center" height="10"><font size="2"><b>楼栋</b></font></td>
		<td align="center" height="10" colspan="<%=3*Integer.parseInt(loftnum) %>"><font size="2"><b><%=Region+strBuilding %><%if (!Rinfo.equals("")) {out.print(Rinfo+"单元");}%></b></font></td>
		<td align="center" height="10"><font size="2"><b>楼栋</b></font></td>	
	</tr>
   <tr>
		<td align="center" height="10"><font size="2"><b>单位</b></font></td>
		<%
		if (RoomNoUp.indexOf("-")>=0)RoomNoUp=RoomNoUp.substring(RoomNoUp.indexOf("-")+1);
		 char BeF=RoomNoUp.charAt(0);
		RoomNoUp=RoomNoUp.substring(RoomNoUp.length()-1);
        char BeR=RoomNoUp.charAt(0);

		//int nn=0;
		for(int j=Integer.parseInt(intBeginR);j<=Integer.parseInt(intEndR);j++){
   String NO="";
			     NO=AsiicZH(j,BeR);//调用asiic转换方法
			if (LockRoomS.indexOf(String.valueOf(j))>=0||upp.indexOf(LockRoomS)>=0){
        
			 if (upp.indexOf(LockRoomS)>=0){
			
				 
			 if (LockRoomS.indexOf(NO)<0){
			%>
		     <td align="center" colspan="3" height="10"><font size="2"><b><%=NO%></b></font></td>
			 <%}
			 }else if (!Lock.contains(String.valueOf(j))){
			 %>
			 <td align="center" height="10" colspan="3"><font size="2"><b><%=NO%></b></font></td>
			 <%} %>	
			 <%}else{%>
			 <td align="center" height="10" colspan="3"><font size="2"><b><%=NO%></b></font></td>
			 
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
	List list9=new LinkedList();//
	int arryFloor[]=new int[1];//临时保存楼层号
    String StrUpper="ABCDEFGHIJKLOPQ"; 
	String floorshow="";
	  
	String sqlArr="select  distinct Room_code,saleState,Floor,Room,area,Sumprice,floorshow from roomstateview where seccode=";
		   sqlArr=sqlArr+"'"+strSection+"'";
		   sqlArr=sqlArr+" and  loft='"+Region+"' and cell='"+Rinfo+"' and building='"+strBuilding+"'  and SaleState in (1,2,3,4,5,6,8)  order by  Floor";
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
			list6.add(getbyte(rsArr.getString("Sumprice")));
			floorshow=getbyte(rsArr.getString("floorshow"));
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
		 String FNO="";
	
		 
		 %>
   		<td align="center" height="10"><font size="2"><b><%=iii%></b></font></td>
		<%} %>
		 
		<%  
		String area11="";
		String unitprice11="";
		String sumprice11="";
		 if (!Lock.contains(String.valueOf(j))){ 
		%>
		<%if (!state.equals("")){
	      int index1=list11.indexOf(RoomNo);
		  if(index1==-1){
		    area11="";
			unitprice11="";
			sumprice11="";
		  }else {
		   area11=(String)list12.get(index1);
		   unitprice11=(String)list13.get(index1);
		   unitprice11=unitprice11.substring(0,unitprice11.indexOf("."));
		   sumprice11=(String)list14.get(index1);
		   }
	      }%>
		<td align="center" height="10"><font size="2">&nbsp;<%=area11 %></font></td>
		<td align="center" height="10"><font size="2">&nbsp;<%=unitprice11 %></font></td>
	     <td align="center" height="10"><font size="2">&nbsp;<%=sumprice11 %></font></td> 
		<%   
        
		}%>
		<%}
		 String FNO="";
	 
		 //FNO=AsiicZH(iii,BeF);//调用asiic转换方法
	    // FNO=AsiicFloorType(FNO,floorshow);//调用楼层转换方法(是否正数或负数)
	
		%>
	   <td align="center" height="10"><font size="2"><b><%=iii%></b></font></td>

	</tr>
	<%} %>
	
	 <script>
	  function butoncheck(){
	  // document.frm.Ok.disabled=getseldocs1();//!(frm.checked);
	  }
	  
	  function ChangePrice(frm){
	  if (frm.checked)document.frm.price.value=0;
	  
	  
	  }
	   </script>
	<% }%>
	<%
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
 int AllSumNum1=0;
 float AllSumArea1=0;
 float AllSumPrice1=0;
 float avg=0;
 sql="select count(*) nn,sum(area) area,sum(Sumprice) Sumprice,sum(Sumprice)/sum(area) avg from room where  seccode='"+strSection+"' and  loft='"+Region+"' and salestate=1";
 
  try{
  rsLock=InsertBean.executeQuery(sql);
  if (rsLock.next()){
    AllSumNum1=rsLock.getInt("nn");
	AllSumArea1=rsLock.getFloat("area");
	AllSumPrice1=rsLock.getFloat("Sumprice");
	avg=rsLock.getFloat("avg");
  }
  rsLock.close();
   }catch(Exception s)  {out.print(s.getMessage());}  
  int AllSumNum2=0;
 float AllSumArea2=0;
 float AllSumPrice2=0;
 float avg1=0;
   sql="select count(*) nn,sum(jzarea) area,sum(salerprice*rate) Sumprice ,sum(salerprice*rate)/sum(jzarea) avg   from order_contract where   loft='"+Region+"' and  section='"+strSection+"' and state !=3";
  try{
 
  rsLock=InsertBean.executeQuery(sql);
  if (rsLock.next()){
    AllSumNum2=rsLock.getInt("nn");
	AllSumArea2=rsLock.getFloat("area");
	AllSumPrice2=rsLock.getFloat("Sumprice");
	avg1=rsLock.getFloat("avg");
  }
  rsLock.close();
   }catch(Exception s)  {out.print(s.getMessage());}  
  sql="update room set " +cSumPrice1+","+cPrice2+","
	   +cPrice1+ " where room_code in("+RoomNos2+") and seccode='"
	   +section+"' and building='"+building+"'  and Loft='"+Region+"' and salestate=1"; %>
<br>
 <center>
 <%String roomtypeSQL="SELECT yong_tu,SUM(sumprice) sumprice,sum(area) area,SUM(sumprice)/sum(area) avgprice,count(*)  d from room "; 
    roomtypeSQL+= " where room_code in("+RoomNos2+") and seccode='"+strSection;
	roomtypeSQL+="' and building='"+building+"'  and Loft='"+Region+"' and salestate=1 group by yong_tu";
	 
	 rsLock=InsertBean.executeQuery(roomtypeSQL);
 
	 %>

 
 
 <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF">
   <tr>
   <td align="center">用途</td>   
    <td align="center">面积</td>  
	  <td align="center">均价</td>   
   <td align="center">总金额</td>  
  
	 <td align="center">套数</td>
	 </tr>
   <%
 
   while (rsLock.next()){ 
      float countsumprice=0;
      String yongtu=rsLock.getString("yong_tu") ;
	  float countarea=rsLock.getFloat("area");
      for (int a=0;a<sumnum;a++){
	       	String aaa=(String)list15.get(a);
		    if (aaa.equals(yongtu)){
			 countsumprice+=java.lang.Float.parseFloat((String)list14.get(a));
			}
      }
      
   %>
   <tr><td align="center"><%=yongtu%></td>
       <td align="center"><%=FormatD.getFloat(countarea,2) %></td> 
     <td align="center"><%=FormatD.getFloat(countsumprice/countarea,2) %></td>
	
	 <td align="center"><%=FormatD.getFloat(countsumprice,2) %></td>
	 <td align="center"><%=rsLock.getString("d") %></td></tr>
   </tr>
   <%}rsLock.close(); %>

 </table>
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
        <td height="10"><font size="2"><%=AllSumNum1 %></font></td>
        
	<td height="10"><font size="2"><%=FormatD.getFloat(AllSumArea1,2) %></font></td>
        
	<td height="10"><font size="2"><%=FormatD.getFloat(AllSumPrice1,2) %></font></td>
        
	<td height="10"><font size="2"><%=FormatD.getFloat(avg,2) %></font></td>

        <td height="10"><font size="2"><%=AllSumNum2%></font></td>
      <td height="10"><font size="2"><%=FormatD.getFloat(AllSumArea2,2) %></font></td>
        
	<td height="10"><font size="2"><%=FormatD.getFloat(AllSumPrice2,2) %></font></td>
        <td height="10"><font size="2"><%=FormatD.getFloat(avg1,2)%></font></td>
	</tr>
 <tr align="center"> 
    <td  height="10"><font size="2"><b>&nbsp;小计</td>
    <td colspan="2"  height="10"><font size="2"><b>&nbsp;套数</b><%=AllSumNum1+AllSumNum2 %></font></td>
    <td colspan="2"  height="10"><font size="2"><b>&nbsp;建筑面积</b><%=FormatD.getFloat(AllSumArea2+AllSumArea1,2) %></font></td>
    <td colspan="2" height="10"><font size="2"><b>&nbsp;总价</b><%=FormatD.getFloat(AllSumPrice1+AllSumPrice2,2) %></font></td>
    <td colspan="2" height="10"><font size="2"><b>&nbsp;均价</b><%=FormatD.getFloat((AllSumPrice1+AllSumPrice2)/(AllSumArea2+AllSumArea1),2)%></font></td>
  </tr>
  <tr align="center"> 
    <td colspan="9" height="10"><font size="2"><b>&nbsp;楼盘合计</td>
  </tr>
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
  <%
  
    AllSumNum1=0;
  AllSumArea1=0;
  AllSumPrice1=0;
  avg=0;
 sql="select count(*) nn,sum(area) area,sum(Sumprice) Sumprice,sum(Sumprice)/sum(area) avg from room where  seccode='"+strSection+"' and salestate=1";
 
  try{
  rsLock=InsertBean.executeQuery(sql);
  if (rsLock.next()){
    AllSumNum1=rsLock.getInt("nn");
	AllSumArea1=rsLock.getFloat("area");
	AllSumPrice1=rsLock.getFloat("Sumprice");
	avg=rsLock.getFloat("avg");
  }
  rsLock.close();
   }catch(Exception s)  {out.print(s.getMessage());}  
   AllSumNum2=0;
  AllSumArea2=0;
  AllSumPrice2=0;
  avg1=0;
   sql="select count(*) nn,sum(jzarea) area,sum(salerprice*rate) Sumprice ,sum(salerprice*rate)/sum(jzarea) avg   from order_contract where  section='"+strSection+"' and state !=3";
  try{
 
  rsLock=InsertBean.executeQuery(sql);
  if (rsLock.next()){
    AllSumNum2=rsLock.getInt("nn");
	AllSumArea2=rsLock.getFloat("area");
	AllSumPrice2=rsLock.getFloat("Sumprice");
	avg1=rsLock.getFloat("avg");
  }
  rsLock.close();
   }catch(Exception s)  {out.print(s.getMessage());}  
   %>
 <tr align="center">
        <td height="10"><font size="2">1</font></td>
        <td height="10"><font size="2"><%=AllSumNum1 %></font></td>
        
	<td height="10"><font size="2"><%=FormatD.getFloat(AllSumArea1,2) %></font></td>
        
	<td height="10"><font size="2"><%=FormatD.getFloat(AllSumPrice1,2) %></font></td>
        
	<td height="10"><font size="2"><%=FormatD.getFloat(avg,2) %></font></td>

        <td height="10"><font size="2"><%=AllSumNum2%></font></td>
      <td height="10"><font size="2"><%=FormatD.getFloat(AllSumArea2,2) %></font></td>
        
	<td height="10"><font size="2"><%=FormatD.getFloat(AllSumPrice2,2) %></font></td>
        <td height="10"><font size="2"><%=FormatD.getFloat(avg1,2)%></font></td>
	</tr>
 <tr align="center"> 
    <td  height="10"><font size="2"><b>&nbsp;小计</td>
    <td colspan="2"  height="10"><font size="2"><b>&nbsp;套数</b><%=AllSumNum1+AllSumNum2 %></font></td>
    <td colspan="2"  height="10"><font size="2"><b>&nbsp;建筑面积</b><%=FormatD.getFloat(AllSumArea2+AllSumArea1,2) %></font></td>
    <td colspan="2" height="10"><font size="2"><b>&nbsp;总价</b><%=FormatD.getFloat(AllSumPrice1+AllSumPrice2,2) %></font></td>
    <td colspan="2" height="10"><font size="2"><b>&nbsp;均价</b><%=FormatD.getFloat((AllSumPrice1+AllSumPrice2)/(AllSumArea2+AllSumArea1),2)%></font></td>
  </tr>
  </table>
 </div>
  <%} %>
<input type=hidden name=sql value="<%=sql %>">
<input type=hidden name=sqlView value="<%=getbyte1(SqlView) %>">
<p align="center"> <div   id="divprint" align="center"><input type=button name="savePrice" value="退  出" onclick="window.close();">

 &nbsp;&nbsp;<input type=button name="printPrice" onclick="prin();" value="打印价格表">&nbsp;<input type="button" onclick="bringToExcel()" value="导出到Excel"></div>
</p>
<script>
  function bringToExcel(){

   // get all the text
   var pasteText = document.all.report1.innerHTML;

   // copy all the text to clipboard
   window.clipboardData.setData ("Text", pasteText);

     // Start Excel and get Application object.     
     var oXL = new ActiveXObject("Excel.Application");     
     oXL.Visible = true;   
     // Get a new workbook.     
     var oWB = oXL.Workbooks.Add();     
     var oSheet = oWB.ActiveSheet;     
     oSheet.Paste();     
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
</script>

<table><tr><td>
第一次导入前必须进行相应设置：<br>
  1.在IE版本必须是IE5.5以上<br>
　2.在IE工具栏中选择"internet选项"<br>
　3.选择"安全"->选择"intranet"后再点击"自定义级别"<br>
  4.把所有ActiveX禁用的都选为启用。<br>
  </td></tr></table>
</center>
 </form>

</center>
<script>
function prin(){
divprint.innerHTML="";
print();
}
function save(){
 if(confirm("确定保存该价格方案")){
document.frm.action="savepricelist.jsp";
document.frm.submit();}
//window.history.back(1);
}
</script>
</body>
</html>
