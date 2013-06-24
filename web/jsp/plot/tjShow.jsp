<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>价目表</title>
</head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 
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
String SecName=getbyte1(request.getParameter("secname"));
String strSection=request.getParameter("SecNo");
String Region=getbyte1(request.getParameter("Loft"));

String RegionStr="";
float AllSumArea=0;
int AllSumPrice=0;
int AllSumNum=0;

  float FatAreaVar=0;//临时保留建筑面积
  int IntSumPriceVar=0;//临时保留总价
float FatSumArea=0;
  int   IntSumPrice=0;
  int   IntRoomNum=0;
  float FatAvgPrice=0;
  int IntPrvSumPrice=0;
String state="";
	String StrFloors="";
  String floor="";
  String Pfloor="";
  String jzarea="";
  String AreaStr="";
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
List Lock=new LinkedList();//存放禁用号
try{
  rsLock=InsertBean.executeQuery(sql1);
  
  while (rsLock.next()){
    String aaa=rsLock.getString("LockRoom");
	 
	 Lock.add(aaa);
    if (LockRoomS.equals(""))
     LockRoomS=aaa;
	else
	 LockRoomS+=","+aaa;
     
 
  }
  rsLock.close();
}catch(Exception s)  {}
String  sql="";

String intEndF="";
String intEndR="";
String intBeginR="";
String intBeginF="";

sql="select max(floor) maxfloor,min(floor) minfloor,max(room) maxroom,min(room) minroom from room where seccode ='"+strSection+"' and ";
sql+=" loft='"+Region+"'";// and build='"+strBuilding+"'
try{
  rsLock=InsertBean.executeQuery(sql);
  while (rsLock.next()){
    intEndF=rsLock.getString("maxfloor");
	intBeginF=rsLock.getString("minfloor");
	intEndR=rsLock.getString("maxroom");
	intBeginR=rsLock.getString("minroom");
  }
  rsLock.close();
}catch(Exception s)  {out.print("err");}   

if (intEndF!=null){

sql="select  count(*) num from room where seccode ='"+strSection+"' and ";
sql+=" loft='"+Region+"'";
if (!LockRoomS.equals(""))
 sql+=" and room not in("+LockRoomS+") ";
 
sql+=" GROUP BY room";// and build='"+strBuilding+"'
int ii=0;

try{
  rsLock=InsertBean.executeQuery(sql);
  while (rsLock.next()){
	ii++;

  }
  rsLock.close();
}catch(Exception s)  {out.print("err"+sql);}    

loftnum=String.valueOf(ii);
String changePriceStr = "";
	ResultSet changePriceRS = null;
	int hasRecord = 0;
    String section = "";
	String building = "";
	String Floor="";
	String RoomNo="";
	String color="";
   
	String change2Str = ""; 
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
 

String SqlView="";
SqlView="select code,room_code,floor,Area,UsedArea, tnunitprice,unitprice,";
SqlView+="sumprice, sumprice Nowsumprice, tnunitprice NowtnunitPrice,unitprice Nowunitprice from room where    seccode='"+strSection+"' and "
	   +"building='"+building+"'  and Loft='"+Region+"' and salestate=1";
SqlView=getbyte1(request.getParameter("sqlView"));

  ResultSet change2RS = null;	
	try{
		change2RS = changePriceListBean.executeQuery(SqlView+" order by floor");
		int i=0;
	
		while (change2RS.next()) {
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
			jzarea=FormatD.getFloat(change2RS.getFloat("Area"),4);
			list12.add(jzarea.toString());
			FatSumArea+=Float.parseFloat(jzarea);	
			AllSumArea+= Float.parseFloat(jzarea);
			//int salestate=change2RS.getInt("SaleState");
			float area=change2RS.getFloat("UsedArea");
			AreaStr=FormatD.getFloat(area,4);  
		    String tnunitPrice = FormatD.getFloat1(change2RS.getFloat("tnunitprice"),2);	
			String unitPrice =FormatD.getFloat1(change2RS.getFloat("unitprice"),2);
		    String sumPrice = FormatD.getFloat1(change2RS.getFloat("sumprice"),0);
			IntPrvSumPrice=change2RS.getInt("Nowsumprice");
		
			AllSumPrice+=IntPrvSumPrice;
		    String NowsumPrice = IntPrvSumPrice+"";
			list14.add(NowsumPrice);		
		    String NowtnunitPrice = FormatD.getFloat1(change2RS.getFloat("Nowtnunitprice"),2);	
			IntSumPrice+=IntPrvSumPrice;
		    String Nowunitprice= change2RS.getFloat("Nowunitprice")+"";
			list13.add(Nowunitprice);
            AllSumNum++;
			rr=tt;		
 %>

  <%	IntRoomNum++;
   }
   change2RS.close();
}catch(Exception s){out.print(s.getMessage());%>

<%}

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
		 <%}else{ %>
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
 
 <table width="<%if (Integer.parseInt(loftnum)<=4){out.print(25*Integer.parseInt(loftnum));}else{ out.print(15*Integer.parseInt(loftnum));}%>%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF">    <tr>
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
			 }else if (!Lock.contains(String.valueOf(j))){
			 %>
			 <td align="center" height="10" colspan="3"><font size="2"><b><%=j%></b></font></td>
			 <%} %>	
			 <%}else{%>
			 <td align="center" height="10" colspan="3"><font size="2"><b><%=j%></b></font></td>
			 
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
    String StrUpper="ABCDEFGHIJKHOPQ"; 
	
	String sqlArr="select  distinct Room_code,saleState,Floor,Room,area,Sumprice from room where seccode=";
		   sqlArr=sqlArr+"'"+strSection+"'";
		   sqlArr=sqlArr+" and  loft='"+Region+"' and building='"+strBuilding+"'  and SaleState in (1,2,3,4,5,6,8)  order by  Floor";
		sqlArr=getbyte1(request.getParameter("sqlView"));
		//out.print(sqlArr+"<br>");
		
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
			String aa=getbyte(rsArr.getString("area"));
			list5.add(aa);
		 
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
		 if (!Lock.contains(String.valueOf(j))){
		%>
		<%if (!state.equals("")){
		  int index1=list11.indexOf(RoomNo);

		  if(index1==-1){
		    area11="";
			unitprice11="";
			sumprice11="";
		  }else {
		   area11=(String)list5.get(index1);
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
 int AllSumPrice1=0;
 sql="select count(*) nn,sum(area) area,sum(Sumprice) Sumprice from room where  seccode='"+strSection+"' and  loft!='"+Region+"' and salestate=1";
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
  sql="update room set " +cSumPrice1+","+cPrice2+","
	   +cPrice1+ " where room_code in("+RoomNos2+") and seccode='"
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
        <td height="10"><font size="2"><%=AllSumNum %></font></td>
        
	<td height="10"><font size="2"><%=FormatD.getFloat(AllSumArea,2) %></font></td>
        
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
    <td colspan="2"  height="10"><font size="2"><b>&nbsp;建筑面积</b><%=FormatD.getFloat(AllSumArea+AllSumArea_S,2) %></font></td>
    <td colspan="2" height="10"><font size="2"><b>&nbsp;总价</b><%=FormatD.getFloat(AllSumPrice+AllSumPrice_S,4) %></font></td>
    <td colspan="2" height="10"><font size="2"><b>&nbsp;均价</b><%=FormatD.getFloat((AllSumPrice+AllSumPrice_S)/(AllSumArea+AllSumArea_S),4)%></font></td>
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
        <td height="10"><font size="2"><%=AllSumNum+AllSumNum1 %></font></td>
        
	<td height="10"><font size="2"><%=FormatD.getFloat(AllSumArea+AllSumArea1,2) %></font></td>
        
	<td height="10"><font size="2"><%=FormatD.getFloat(AllSumPrice+AllSumPrice1,0) %></font></td>
        
	<td height="10"><font size="2"><%=FormatD.getFloat((AllSumPrice+AllSumPrice1)/(AllSumArea+AllSumArea),4) %></font></td>

        <td height="10"><font size="2"><%=AllSumNum2%></font></td>
        <td height="10"><font size="2"><%=AllSumArea2%></font></td>
        <td height="10"><font size="2"><%=AllSumPrice2%></font></td>
        <td height="10"><font size="2"><%=FormatD.getFloat(AllSumPrice2/AllSumArea2,4)%></font></td>
	</tr>
 <tr align="center"> 
    <td  height="10"><font size="2"><b>&nbsp;合计</td>
    <td colspan="2"  height="10"><font size="2"><b>&nbsp;套数</b><%=AllSumNum+AllSumNum1+ AllSumNum2%></font></td>
    <td colspan="2"  height="10"><font size="2"><b>&nbsp;建筑面积</b><%=FormatD.getFloat(AllSumArea+AllSumArea1+AllSumArea2,2)%></font></td>
    <td colspan="2" height="10"><font size="2"><b>&nbsp;总价</b><%=FormatD.getFloat(AllSumPrice+AllSumPrice1+AllSumPrice2,4) %></font></td>
    <td colspan="2" height="10"><font size="2"><b>&nbsp;均价</b><%=FormatD.getFloat((AllSumPrice+AllSumPrice1+AllSumPrice2)/(AllSumArea+AllSumArea1+AllSumArea2),4)%></font></td>
  </tr> 
 </table>
  <%} %>
<input type=hidden name=sql value="<%=sql %>">
<input type=hidden name=sqlView value="<%=SqlView %>">

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
<%}else{%>
<script>
alert("此楼可能没有房间或车位或铺位资料，不能打印");
window.close();

</script>
 <%} %>
</body>
</html>
