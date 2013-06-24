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
	List list15=new LinkedList();//存放总价
	List list16=new LinkedList();//存放状态
	int sumnum=0;
 
 
String SecName=getbyte1(request.getParameter("SecName"));
String strSection=request.getParameter("SecNo");
String Region=getbyte1(request.getParameter("Loft"));
String floortype=getbyte1(request.getParameter("floortype"));
if (floortype.equals(""))floortype=" and floortype=0";
else floortype=" and floortype="+floortype;
String RegionStr="";
float AllSumArea=0;
int AllSumPrice=0;
int AllSumNum=0;
String state="";

int tab=0; 
String strYN=request.getParameter("yn");
String loftnum=request.getParameter("loftnum");
String strBuilding="";
strBuilding=China.getParameter(request,"Build");
String SecNo=getbyte1(request.getParameter("SecNo"));
String Loft= getbyte1(request.getParameter("Loft"));
String payment=getbyte1(request.getParameter("payment")) ;
   
String sql1="select lockroom from lockroom where section ='"+SecNo+"' and ";
sql1+=" loft='"+Loft+"' group by lockroom";
 
ResultSet rsLock=null;
String lock="";
String LockRoomS="";
int lokenum=0;
List Lock=new LinkedList();//存放禁用号
try{
  rsLock=InsertBean.executeQuery(sql1);
  
  while (rsLock.next()){
    lokenum++;
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
	section=getbyte2(request.getParameter("SectionNO"));
	building=getbyte2(request.getParameter("Build"));
	Region=getbyte2(request.getParameter("RegionNO"));
	djtype=getbyte2(request.getParameter("dj"));
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
 int tt=0;
	int rr=0;

	SqlView="select * from  room where seccode='"+SecNo+"' and loft='"+Loft+"'";

	   ResultSet change2RS = null;
	 
		change2RS = changePriceListBean.executeQuery(SqlView+" order by floor");
		int i=0;

		while (change2RS.next()) {
		    sumnum++;
		    i=i+1;
			String astr=change2RS.getString("seccode");
			String bstr=change2RS.getString("loft");
			String cstr="";
			
			String yong_tu=change2RS.getString("yong_tu");
			list15.add(yong_tu);
			int code = change2RS.getInt("Code");
			String room = change2RS.getString("room_code");
			list11.add(room);
			
			if (!floor.equals(""))Pfloor=floor;//保存前一记录的楼层号
			floor = change2RS.getString("floor");
			String dstr=floor;
		   if (!StrFloors.equals("")&&!StrFloors.equals(floor)){//如果不属于同一楼层，则输出上一楼层的小计
		  
			 FatAreaVar=Float.parseFloat(jzarea);
			 IntSumPriceVar=IntPrvSumPrice;
		   }
		    StrFloors=String.valueOf(floor);
			jzarea=FormatD.getFloat(change2RS.getFloat("Area"),2);
			list12.add(jzarea.toString());
			FatSumArea+=Float.parseFloat(jzarea);	
			AllSumArea+= Float.parseFloat(jzarea);
		 
			float area=change2RS.getFloat("usedArea");
			AreaStr=FormatD.getFloat1(area,2);  
	 
			 
			IntPrvSumPrice=change2RS.getFloat("xy_sumprice");
			
			
			AllSumPrice+=IntPrvSumPrice;
		    String NowsumPrice = FormatD.getFloat1(IntPrvSumPrice,0);
		
			list14.add(NowsumPrice);
		    String NowtnunitPrice = FormatD.getFloat1(change2RS.getFloat("xy_tnprice1"),2);	
			IntSumPrice+=IntPrvSumPrice;
		    String Nowunitprice= change2RS.getFloat("xy_jzprice")+"";
			
			list16.add(change2RS.getString("salestate"));
			list13.add(Nowunitprice);
            AllSumNum++;
			rr=tt;
			
			 
  	IntRoomNum++;
   }
   change2RS.close();
 
       sql="select min(Floor) as BeginF,max(Floor) as EndF,";
		sql=sql+"min(Room) as BeginR,max(Room) as EndR,max(cell) as Ecell ,min(cell) as Scell from";
		sql=sql+" RoomNo where SectionNo='"+strSection+"'";
		sql=sql+" and Building='"+strBuilding+"' and Region='"+Loft+"'";
      ResultSet   rs=InsertBean.executeQuery(sql);
		 
 int intBeginF=0;
 int intEndF=0;
 int intBeginR=0;
 int intEndR=0;
int mxinF=0;
 String Ecellname="";
String Scellname="";
String Rinfo="";
if (rs.next()){
  intBeginF=rs.getInt("BeginF");
  mxinF=intBeginF;
 //  if (intBeginF<0)intBeginF=FF;
  intEndF=rs.getInt("EndF");
  intBeginR=rs.getInt("BeginR");
  intEndR=rs.getInt("EndR");
   Ecellname=getbyte(rs.getString("Ecell"));
  Scellname=getbyte(rs.getString("Scell"));
  if (Scellname.equals("")&&Ecellname.equals("")){ Ecellname=" ";Scellname=" ";}
}
  
rs.close(); 
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

       StringTokenizer st22 = new StringTokenizer(LockRoomS,",") ;
       int count22 = st22.countTokens() ;
		String upp="ABCDEFGHIJKLOPQRST";
		upp=upp.trim();
		int nn=0;
        String RoomNoUp="";
		String  sqlU="select top 1 RoomNo,state from RoomNo where SectionNo=";
				sqlU=sqlU+"'"+SecNo+"' and Building='";
				sqlU=sqlU+strBuilding+"' and Region='"+Loft+"'";
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
<form method="post" name=form1  >
    <input type=hidden name=SecNo value="<%=strSection %>">
    <input type=hidden name=Loft value="<%=Region %>">
    <input type=hidden name=SecName value="<%=SecName %>">
    <input type=hidden name=Building value="<%=strBuilding %>">
    <input type=hidden name=choose>
    <input type=hidden name=RegionNA value="<%=RegionStr %>">
    <input type=hidden name=RegionNO value="<%=Region %>">
    <input type=hidden name=SectionNA value="<%=SecName %>">
    <input type=hidden name=SectionNO value="<%=strSection %>">
    <input type=hidden name=intEndR value="<%=intEndR %>">
    <input type=hidden name=intEndF value="<%=intEndF %>">
    <input type=hidden name=intBeginR value="<%=intBeginR %>">
    <input type=hidden name=intBeginF value="<%=intBeginF %>">
    
    <input type=hidden name=choose>
<center>
  <div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable>

<p align="center"><font size=3><b><%=SecName %>人民币价目表</font></b></p>
   <%for(int j2=scell;j2<=ecell;j2++){
			if (scell>0){  
			  Rinfo=AsiicZH(j2,CellN1); 
			} %>
 <table width="99%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF">
    <tr>
		<td align="center" height="10"><font size="2"><b>楼栋</b></font></td>
		<td align="center" height="10" colspan="<%=3*(intEndR-lokenum )%>"><font size="2"><b><%=Loft %><%if (!Rinfo.equals("")) {out.print(Rinfo+"单元");}%></b></font></td>
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
		for(int j=intBeginR;j<=intEndR;j++){
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
		<%for(int u=0;u<intEndR-lokenum;u++) {%>
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
	String sqlArr="select  distinct Room_code,saleState,Floor,Room,area,xy_Sumprice as Sumprice,floorshow from roomstateview where seccode=";
		   sqlArr=sqlArr+"'"+SecNo+"'";
		   sqlArr=sqlArr+"  and  cell='"+Rinfo+"'  and  loft='"+Loft+"' and building='"+strBuilding+"'  and SaleState in (1,2,3,4,5,6,8)  order by  Floor";
		
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
	<%for(int iii=intEndF;iii>=intBeginF;iii--){%>
	<tr >
		<%
		int IntAvgSumPrice=0;;
		float FatAreaSum=0;
		for(int j=intBeginR;j<=intEndR;j++){
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
	
		// FNO=AsiicZH(iii,BeF);//调用asiic转换方法
	   //  FNO=AsiicFloorType(FNO,floorshow);//调用楼层转换方法(是否正数或负数)
		
		 %>
   		<td align="center" height="10"><font size="2"><b><%=iii%></b></font></td>
		<%}%>
		
		<%  
		String area11="";
		String unitprice11="";
		String sumprice11="";
		String strstate=""; 
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
		   strstate=(String)list16.get(index1);
		   }
	      }
		  String bgcolor="";
		  if (strstate.equals("1"))bgcolor="#00CCFF";
		 
		  %>
		<td align="center" height="10" bgcolor="<%=bgcolor %>"><font size="2">&nbsp;<%=area11 %></font></td>
		<td align="center" height="10"  bgcolor="<%=bgcolor %>"><font size="2">&nbsp;<%=unitprice11 %></font></td>
	     <td align="center" height="10"  bgcolor="<%=bgcolor %>"><font size="2">&nbsp;<%=sumprice11 %></font></td> 
		<%   
        
		}%>
		<%}
		 String FNO="";
	 
		 
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
	
	}%> 
<br>
  </table>
 </div>
  <%} %>
 
<p align="center"> <div   id="divprint" align="center"><input type="button" onclick="bringToExcel()" value="导出到Excel"></div>
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
