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
	String basicprice=request.getParameter("basicprice");
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
  String area11="";

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
	  StrPrice=basicprice;
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
			 <td align="center" height="10"><font size="2"><b><%=j%></b></font></td>
			 <%} %>	
			 <%}else{%>
			 <td align="center" height="10"><font size="2"><b><%=j%></b></font></td>
			 
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
	cSumPrice1=" sumprice=case ";
	cPrice2=" unitprice = case ";
	cPrice1=" TNunitprice = case ";
    String StrUpper="ABCDEFGHIJKHOPQ"; 
	String sqlArr="select  distinct Room_code,saleState,Floor,Room,area,Sumprice from room where seccode=";
		   sqlArr=sqlArr+"'"+strSection+"'";
		   sqlArr=sqlArr+" and  loft='"+Region+"' and building='"+strBuilding+"'  and SaleState in (1,2,3,4,5,6,8)  order by  Floor";
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
			//out.println(RoomArry[aryi]);
		   } 
	      rsArr.close();
		int arrlen=0;
	 %>
	<%try{for(int iii=Integer.parseInt(intEndF);iii>=Integer.parseInt(intBeginF);iii--){%>
	<tr >
		<% if (iii==0) continue;
		int IntAvgSumPrice=0;;
		float FatAreaSum=0;
		for(int j=Integer.parseInt(intBeginR);j<=Integer.parseInt(intEndR);j++){
		RoomNo="";
		String no="";
		RoomNo=String.valueOf(iii)+"|"+String.valueOf(j);
		arrlen+=1;
		try{if (list9.contains(RoomNo)){
		   int index=list9.indexOf(RoomNo);
		       RoomNo=(String)list1.get(index);//取出由楼层+房间号对应的房间编码
		   area11=(String)list5.get(index);
		   state=(String)list2.get(index);
		 }else{state="";RoomNo="";}  
		
	      String FloorNo=RoomNo.substring(0,1);
		 char FloNo=FloorNo.charAt(0);//判断楼层是否以字母编号
		
		if (arryFloor[0]!=iii){
		 arryFloor[0]=iii;
		 %>
   		<td align="center" height="10"><font size="2"><b><%=iii%></b></font></td>
		<%}%>
		
		<%  	
		float unitprice11=0;
		float sumprice11=0;
		String totalroom="";
		 if (iii<0)
		 totalroom="total"+"a_"+String.valueOf(java.lang.Math.abs(iii))+"A"+String.valueOf(j);
      else
	  	 totalroom="total"+String.valueOf(java.lang.Math.abs(iii))+"A"+String.valueOf(j);
		
		String modulus=China.getParameter(request,totalroom);
		
		String unitpricetemp="";
		if(modulus.equals("")|| modulus==null)modulus="0";		
		 if (!LockRoomS.trim().equals(String.valueOf(j))){ 		
		 try{
	      unitprice11=Float.parseFloat(StrPrice)*Float.parseFloat(modulus);
		}catch(Exception s){out.print(s.getMessage()+totalroom);}	   
		   cPrice2+=" when (room_code='"+RoomNo+"')"+" then " +unitprice11;
		   cSumPrice1+="  when (room_code='"+RoomNo+"')"+" then " +unitprice11+"*Area" ;
		   cPrice1+="  when (room_code='"+RoomNo+"')"+" then " +unitprice11+"*Area/UsedArea " ;
		   sumprice11=unitprice11*Float.parseFloat(area11);
		 if (RoomNos2.equals(""))RoomNos2="'"+RoomNo+"'";
		 else RoomNos2+=",'"+RoomNo+"'";
		  
	     %>
		<td align="center" height="10"><font size="2">&nbsp;<%if(unitprice11!=0)out.print(area11); %></font></td>
		<td align="center" height="10"><font size="2">&nbsp;<%if(unitprice11!=0)out.print(FormatD.getFloat(unitprice11,2) );%></font></td>
	     <td align="center" height="10"><font size="2">&nbsp;<%if(unitprice11!=0)out.print(FormatD.getFloat(sumprice11,2) );%></font></td> 
		<%   
        
		}}catch(Exception s)
		{//out.print(s.getMessage()+"1234567");
		}%>
		<%}
		%>
 
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
	<% }
	}catch(Exception s){out.print(s.getMessage()+"a");}%>
	<%
	int AllSumNum_S=0;
	float AllSumArea_S=0;
	int AllSumPrice_S=0;
	//计算已售
   sql="select count(*) nn,sum(jzarea) area,sum(salerprice*rate) Sumprice from order_contract where  section='"+strSection+"' and  loft='"+Region+"' and building='"+strBuilding+"' and state !=3";
   // out.print(sql);
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
 int AllSumPrice1=0;
 //计算未售
 sql="select count(*) nn,sum(area) area,sum(Sumprice) Sumprice from room where  seccode='"+strSection+"' and  loft='"+Region+"' and salestate not in (2,3)";

  try{
  rsLock=InsertBean.executeQuery(sql);
  if (rsLock.next()){
    AllSumNum1=rsLock.getInt("nn");
	AllSumArea1=rsLock.getFloat("area");
	AllSumPrice1=rsLock.getInt("Sumprice");
  }
  rsLock.close();
   }catch(Exception s)  {out.print(s.getMessage());}  
  int AllSumNum2=0;
 float AllSumArea2=0;
 int AllSumPrice2=0;
 //计算整个楼盘的已售
   sql="select count(*) nn,sum(jzarea) area,sum(salerprice*rate) Sumprice from order_contract where  section='"+strSection+"' and state !=3";
  try{
  rsLock=InsertBean.executeQuery(sql);
  if (rsLock.next()){
    AllSumNum2=rsLock.getInt("nn");
	AllSumArea2=rsLock.getFloat("area");
	AllSumPrice2=rsLock.getInt("Sumprice");
  }
  rsLock.close();
   }catch(Exception s)  {out.print(s.getMessage());}  
   
   int AllSumNum3=0;
 float AllSumArea3=0;
 int AllSumPrice3=0;
 //计算未售
 sql="select count(*) nn,sum(area) area,sum(Sumprice) Sumprice from room where  seccode='"+strSection+"'   and salestate not in (2,3)";

  try{
  rsLock=InsertBean.executeQuery(sql);
  if (rsLock.next()){
    AllSumNum3=rsLock.getInt("nn");
	AllSumArea3=rsLock.getFloat("area");
	AllSumPrice3=rsLock.getInt("Sumprice");
  }
  rsLock.close();
   }catch(Exception s)  {out.print(s.getMessage());}  
   
  sql="update room set " +cSumPrice1+" end,"+cPrice2+" end,"
	   +cPrice1+ " end where room_code in("+RoomNos2+") and seccode='"
	   +section+"' and building='"+building+"'  and Loft='"+Region+"' and salestate=1"; %>
<br>
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
        <td height="10"><font size="2"><%=AllSumNum1 %></font></td>
        
	<td height="10"><font size="2"><%=FormatD.getFloat(AllSumArea1,2) %></font></td>
        
	<td height="10"><font size="2"><%=FormatD.getFloat(AllSumPrice1,0) %></font></td>
        
	<td height="10"><font size="2"><%=FormatD.getFloat(AllSumPrice1/AllSumArea1,0) %></font></td>

        <td height="10"><font size="2"><%=AllSumNum_S%></font></td>
        <td height="10"><font size="2"><%=AllSumArea_S%></font></td>
        <td height="10"><font size="2"><%=AllSumPrice_S%></font></td>
        <td height="10"><font size="2"><%=FormatD.getFloat(AllSumPrice_S/AllSumArea_S,2)%></font></td>
	</tr>
 <tr align="center"> 
    <td  height="10"><font size="2"><b>&nbsp;小计</td>
    <td colspan="2"  height="10"><font size="2"><b>&nbsp;套数</b><%=AllSumNum1+AllSumNum_S %></font></td>
    <td colspan="2"  height="10"><font size="2"><b>&nbsp;建筑面积</b><%=FormatD.getFloat(AllSumArea1+AllSumArea_S,2) %></font></td>
    <td colspan="2" height="10"><font size="2"><b>&nbsp;总价</b><%=FormatD.getFloat(AllSumPrice1+AllSumPrice_S,0) %></font></td>
    <td colspan="2" height="10"><font size="2"><b>&nbsp;均价</b><%=FormatD.getFloat((AllSumPrice+AllSumPrice_S)/(AllSumArea+AllSumArea_S),0)%></font></td>
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
  <tr align="center">
        <td height="10"><font size="2">1</font></td>
        <td height="10"><font size="2"><%=AllSumNum3 %></font></td>
        
	<td height="10"><font size="2"><%=FormatD.getFloat(AllSumArea3,2) %></font></td>
        
	<td height="10"><font size="2"><%=FormatD.getFloat(AllSumPrice3,0) %></font></td>
        
	<td height="10"><font size="2"><%=FormatD.getFloat((AllSumPrice3)/(AllSumArea3),0) %></font></td>

        <td height="10"><font size="2"><%=AllSumNum2%></font></td>
        <td height="10"><font size="2"><%=AllSumArea2%></font></td>
        <td height="10"><font size="2"><%=AllSumPrice2%></font></td>
        <td height="10"><font size="2"><%=FormatD.getFloat(AllSumPrice2/AllSumArea2,4)%></font></td>
	</tr>
 <tr align="center"> 
    <td  height="10"><font size="2"><b>&nbsp;合计</td>
    <td colspan="2"  height="10"><font size="2"><b>&nbsp;套数</b><%=AllSumNum3+ AllSumNum2%></font></td>
    <td colspan="2"  height="10"><font size="2"><b>&nbsp;建筑面积</b><%=FormatD.getFloat(AllSumArea3+AllSumArea2,2)%></font></td>
    <td colspan="2" height="10"><font size="2"><b>&nbsp;总价</b><%=FormatD.getFloat(AllSumPrice3+AllSumPrice2,0) %></font></td>
    <td colspan="2" height="10"><font size="2"><b>&nbsp;均价</b><%=FormatD.getFloat((AllSumPrice3+AllSumPrice2)/(AllSumArea3+AllSumArea2),0)%></font></td>
  </tr> 
 </table>
  <%} %>
<input type=hidden name=sql value="<%=sql %>">
<input type=hidden name=sqlView value="<%=SqlView %>">

</center>
 </form>
<p align="center"> <div   id="divprint" align="center"><input type=button name="savePrice" value="传递价格" onclick="save();">

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
