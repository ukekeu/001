<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>换房登记</title>
</head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="javascript" src="../public_js/public.js"></script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>


<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/asiic.jsp"%> 
  <%@ include file="../public_js/CheckSection.jsp"%>
<%
      String SecName=request.getParameter("SecName");
	  String Loft =China.getParameter(request,"loft");
      String BuildPa=getbyte1(request.getParameter("Build"));
	  String strBuilding =BuildPa;
	  String strSection ="";
	  String secno=request.getParameter("Section");
	  strSection=secno;
	  String checker=China.getParameter(request,"checker");
	  String date=China.getParameter(request,"date");
	  String context=China.getParameter(request,"context");
	  String SQLPROJECT="SELECT NAME FROM CRM_Project where serialno='"+secno+"'";
	  	 ResultSet Rss = InsertBean.executeQuery(SQLPROJECT) ; 
		 if (Rss.next())SecName=getbyte(Rss.getString("name"));
		 Rss.close();
 %>
<script>


function changebuild(obj){
 
   var objvalue=obj.value;

   var html="";
   var i=0; 
   var arr=new Array();
   <%String sqlx= "select SerialNo,Name from CRM_Project  "+FindWhere;
 ResultSet Rsx = InsertBean.executeQuery(sqlx) ;
 while (Rsx.next()) {
String tmpid = Rsx.getString("SerialNo") ;%>
    if(objvalue=="<%=tmpid%>"){
	
html="";
i=0;
<%  int j=1;
    int x=0;
	String sqlUser = "select loft from Sectiontree where  SerialNo='"+tmpid+"'";
ResultSet userRs = InsertBean1.executeQuery(sqlUser) ;
while (userRs.next()) {
String housename = userRs.getString("loft") ;
if (housename == null)
  housename = "" ;
  housename = getbyte(housename) ;
%>
arr[i]="<option value='<%=housename%>'><%=housename%></option>";
++i;
    <%}userRs.close();%>
html="<select name='Loft' style='width=100;' onchange='document.frm.loft.value=this.value;document.frm.submit();'><option value=''></option>"+arr.join();
html=html+"</select>";
document.all("sub").innerHTML=html;

}
  <%}Rsx.close();%>
}

function submitC(){
  document.frm.action="RoomCodeShow.jsp";
  document.frm.submit();


}
function getseldocs1() {
     var x=0;
	 var seldocs = new Array();
     var seldocs1 = new Array();
	 var temp=document.frm.elements.length;

     for (i=0;i<document.frm.elements.length;i++) {
	   if ((document.frm.elements[i].type=="checkbox")&&(document.frm.elements[i].checked)&&(document.frm.elements[i].name=="yl"))
		 {
       		seldocs[x]="'"+document.frm.elements[i].value+"'";
			seldocs1[x]=document.frm.elements[i].value;
			x++;
   		 }
	  }	
     var returnvalue="";
	  if (seldocs!="")
	   returnvalue=seldocs+"/"+seldocs1;
   return returnvalue
}
function ylroom(){
    var rooms=getseldocs1();
    if (rooms==""){alert("请选择预留的房间！");return false;}
    var url="add_yl_rooms.jsp?rooms="+rooms+"&loft=<%=Loft %>&build=<%=strBuilding %>&secno=<%=strSection %>&secname=<%=SecName %>";
    var newWin = window.open(url,"roomfrm","height=250,width=410,left=150,top=50,resizable=yes,scrollbars=no,toolbar=no,location=no,directories=no,status=no,menubar=no");
    newWin.focus() ;
}
//setSelectMad(document.frm.Loft,'<%=Loft %>');
</script >	
<body oncontextmenu="return false"  <%if (!Loft.equals("")){ %>onload="aaa();"<%} %>  >
<div align="center">

<form name=frm method="post" action="">
<input type=hidden name=Section value="<%=strSection%>">
<input type=hidden name=SecName value="<%=SecName%>">
<input type=hidden name=loft value="<%=Loft%>">
 
<p align="center"><b>换房登记</b></p>
 <table width="90%" class=roomright border="0" CELLSPACING=1 CELLPADDING=3>
   
	 <tr>
	 <td  align="center">批 准 人：</td>
	 <td   align="left"><input type=text size=15 name="checker" value="<%=checker %>" ></td>
	 <td  align="center">换房日期：</td>
	 <td   align="left"><input type=text size=12  value="<%=date %>"name="date" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(date);" title="请选择换房日期"></td>
	</tr>
	 <tr>
	 <td  align="center">换房原因:</td>
	 <td  align="left" colspan="4"><input type=text size=40 value="<%=context %>" name="context" ></td>
	</tr>
	</table>
	<TABLE>
	  <tr>
                      <td width="50%" bgcolor="#EAEAEA"  align="center"><font size="2" color="#000080">选择楼盘:&nbsp;</font></td>
					  <td width="50%" bgcolor="#EAEAEA"  align="center">
					
					  <%
      String sql="select SerialNo,Name from CRM_Project "+FindWhere;
					   ResultSet rs2=InsertBean1.executeQuery(sql);
	                    String sec="";
	                    String no=""; %>
<select name="secno"    style="width=108;" onchange="document.frm.Section.value=this.value;changebuild(this);"   ><!---->-->
					      <option value=""></option>
						  <%while (rs2.next()){
	                          no=rs2.getString("SerialNo");
	                          sec=getbyte(rs2.getString("Name"));
     	                      out.print("<option value='"+no+"'>"+sec+"</option>");
	                         }
	                        rs2.close();
	                        String Sql = "" ;
                              %> 
							</select>
					</tr>
					 <tr>
                      <td width="50%" bgcolor="#EAEAEA" align="center"><font  size="2" color="#000080">选择栋号:&nbsp;</font></td>
					  <td width="50%" bgcolor="#EAEAEA" align="center" id="sub">
					 <select name="Loft"  style="width=110;" onchange="documnet.frm.loft.value=this.value;document.frm.submit();" >
					      <option value="<%=Loft %>"><%=Loft %></option>
						 
							</select>
					</tr> 
					 <tr>
                      <td width="50%" bgcolor="#EAEAEA" align="center"><font  size="2" color="#000080">录入单元号:&nbsp;</font></td>
					  <td width="50%" bgcolor="#EAEAEA" align="center" >
					 <input name="Build" value="<%= BuildPa%>" size=12 onchange="document.frm.submit();" >
					      
					</tr> 
					</TABLE>
	

<%

if (Loft.equals("")){out.close();}

String state="";
String room_type="";
  int colts=20;
	 
	 String ss="select room_type,ts from LoftBuildCode where SECNO='"+strSection+"' and loft='"+Loft+"'";
   ResultSet ssr=InsertBean1.executeQuery(ss);
   if (ssr.next()){
    room_type=ssr.getString("room_type");
	colts=ssr.getInt("ts");
   }
String sql1="select lockroom from lockroom where section ='"+strSection+"' and ";
 
sql1+=" loft='"+Loft+"'";
if (!BuildPa.equals(""))sql1+=" and Build='"+BuildPa+"'";
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

     
 
   sql="select floor from";
		sql=sql+" RoomNo where SectionNo='"+strSection+"'";
		sql=sql+" and Building='"+strBuilding+"' and Region='"+Loft+"' and floor=0";
ResultSet rs=InsertBean.executeQuery(sql);
int FF=1;
       sql="select max(len(cell)) cell from "; 
 
 sql=sql+" RoomNo where SectionNo='"+strSection+"'";
		sql=sql+" and Building='"+strBuilding+"' and Region='"+Loft+"'";
 String checkCell=""; 
		rs=InsertBean.executeQuery(sql);
		if (rs.next())
		{
		checkCell=rs.getString("cell");
		
		}
		rs.close();
		 
		if (checkCell.equals("2")){
  sql="select min(Floor) as BeginF,max(Floor) as EndF,";
		sql=sql+"min(Room) as BeginR,max(Room) as EndR, max(convert(int,cell))  as Ecell ,min(cell) as Scell from";
		sql=sql+" RoomNo where SectionNo='"+strSection+"'";
		sql=sql+" and Building='"+strBuilding+"' and Region='"+Loft+"'";
		
	  }else{
	  
	   sql="select min(Floor) as BeginF,max(Floor) as EndF,";
		sql=sql+"min(Room) as BeginR,max(Room) as EndR, max(cell)  as Ecell ,min(cell) as Scell from";
		sql=sql+" RoomNo where SectionNo='"+strSection+"'";
		sql=sql+" and Building='"+strBuilding+"' and Region='"+Loft+"'";
	
	  
	  }	
       rs=InsertBean.executeQuery(sql);
		
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
  // if (intBeginF<0)intBeginF=FF;
  intEndF=rs.getInt("EndF");
  intBeginR=rs.getInt("BeginR");
  intEndR=rs.getInt("EndR");
   Ecellname=getbyte(rs.getString("Ecell"));
  Scellname=getbyte(rs.getString("Scell"));
  if (Scellname.equals("")&&Ecellname.equals("")){ Ecellname=" ";Scellname=" ";}
}
 //out.println(intBeginF);
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

%> 
  <%    
       int nosalenum=0;
	   int rgnum=0;
	   int salenum=0;
	   int yl=0;
	   int ld=0;
  
     
		String locaPara="Loft="+request.getParameter("Loft")+"&Build="+BuildPa+"&SecNo="+request.getParameter("SecNo")+"&SecName="+request.getParameter("SecName");
		String upp="ABCDEFGHIJKLOPQRST";
		upp=upp.trim();
		int nn=0;
        String RoomNoUp="";
		String  sqlU="select top 1 Room_code from Room where seccode=";
				sqlU=sqlU+"'"+strSection+"' and Building='";
				sqlU=sqlU+strBuilding+"' and loft='"+Loft+"'";
				if (!BuildPa.equals(""))sqlU+=" and Building='"+BuildPa+"'";
		ResultSet rsU=InsertBean1.executeQuery(sqlU);
		
        if (rsU.next())RoomNoUp=rsU.getString("Room_code");
		rsU.close();

        if (!RoomNoUp.equals("")){
		%>
	
 <%for(int j2=scell;j2<=ecell;j2++){
			if (scell>0){  
			  Rinfo=AsiicZH(j2,CellN1); 
			} %>
  <table width="90%" border="0" CELLSPACING=1 CELLPADDING=3>
   <% if (room_type.indexOf("墅")<0&&room_type.indexOf("车")<0&&intEndR<=colts){//别墅不显示房间序号 %>
   <tr> 
		<td width="100" class=listtitle align="center"><font color="#FFFFFF"<b><%if (!Rinfo.equals("")) {out.print(Rinfo+"单元");}%>楼层\房号</b></font></td>
			<%
		
		RoomNoUp=RoomNoUp.substring(RoomNoUp.length()-1);
        char BeR=RoomNoUp.charAt(0);
		for(int j=intBeginR;j<=intEndR;j++){
		 String NO="";
			  NO=AsiicZH(j,BeR);//调用asiic转换方法
			if (LockRoomS.indexOf(String.valueOf(j))>=0||upp.indexOf(LockRoomS)>=0){
        
			 if (upp.indexOf(LockRoomS)>=0){
			 
			 
			 if (LockRoomS.indexOf(NO)<0){
			%>
		     <td align="center" class=listtitle><font color="#ffffff"><%=NO%></font></td>
			 <%}
			 }else  if (!Lock.contains(String.valueOf(j))){
			 %>
			 <td align="center" class=listtitle><font color="#ffffff"><%=NO%></font></td>
			 <%} %>	
			 <%}else  if (!Lock.contains(String.valueOf(j))){%>
			 <td align="center" class=listtitle><font color="#ffffff"><%=NO%></font></td>
			 
			 <%}
			 
			 }%>
			  <td align="center" class=listtitle><font color="#ffffff">楼层均价</font></td>	
	</tr>
	<%}
    List list1=new LinkedList();//存放房间编码
	List list2=new LinkedList();//存放房间状态
	List list3=new LinkedList();//存放所在FLoor
    List list4=new LinkedList();//存放房号
    List list5=new LinkedList();//存放建筑面积
    List list8=new LinkedList();//存放套内建筑面积
    List list6=new LinkedList();//存放当前总价
	List list9=new LinkedList();//存放当前套内建筑面积单价
	List list10=new LinkedList();//存放当前建筑面积单价
	List list7=new LinkedList();//存放当前楼层
	List list11=new LinkedList();//存放当前房类
	List list12=new LinkedList();//存放当前户型
    List list13=new LinkedList();//存放当前户型
    List list14=new LinkedList();//存放当前户型
	List list15=new LinkedList();//存放当前户型
	List list16=new LinkedList();//存放当前户型
	List list17=new LinkedList();//存放当前户型
	List list18=new LinkedList();//存放当前户型
	List list19=new LinkedList();//存放当前户型
	List list20=new LinkedList();//存放当前户型
	List list21=new LinkedList();//存放当前户型
	String floors="";
	String jzarea="";
	String tnarea="";
	String unitprice="";
	String tnunitprice="";
	String sumprice="";
	String roomtype="";
	String buildingtype="";
	String Fitment="";
	 String floorshow="";
	String floortype="";
	String yong_tu="";
	String lu_tai_area_price="0",lu_tai_area="0",ty_area="0",ty_area_price="0";
	String wd_area="0",wd_area_price="0";
    String StrUpper="ABCDEFGHIJKLOPQ"; 
	String sqlArr="select  distinct Room_code,saleState,Floor,Room,floorshow,floortype,area1,UsedArea,tnunitprice,unitprice,Sumprice1,Room_Type,roomtype,Fitment,lu_tai_area,lu_tai_area_price,ty_area,ty_area_price,wd_area,wd_area_price,yong_tu from roomstateview where seccode=";
		   sqlArr=sqlArr+"'"+strSection+"' and loft='"+Loft+"'";
		   if (!BuildPa.equals(""))sqlArr+=" and Building='"+BuildPa+"'";
		   sqlArr=sqlArr+"  and  cell='"+Rinfo+"'  and SaleState in (1,2,3,4,5,6)  order by  Floor";
		   ResultSet rsArr=InsertBean1.executeQuery(sqlArr);
		   int aryi=0;
		 
		    String Rinfo1=Rinfo;
          // if (!Rinfo1.equals(""))Rinfo1=Rinfo1+"-";
		   while (rsArr.next()){
		    
		    list14.add(rsArr.getString("Room_code"));
			list2.add(rsArr.getString("SaleState"));
			String FloorS=rsArr.getString("Floor");
			String RoomS=rsArr.getString("Room");
			floorshow=rsArr.getString("floorshow");
			floortype=rsArr.getString("floortype");
			list3.add(FloorS);
			list4.add(RoomS);
			 if (FloorS.indexOf("-")>=0)FloorS="";
			if (Integer.parseInt(RoomS)>=10)
			 list1.add(Rinfo+FloorS+RoomS);
			else
			  list1.add(Rinfo+FloorS+"0"+RoomS);
			
			list5.add(FormtD.getFloat1(rsArr.getFloat("area1"),4));
			list8.add(FormtD.getFloat1(rsArr.getFloat("UsedArea"),4));
			list6.add(FormtD.getFloat1(rsArr.getFloat("Sumprice1"),0));
			list9.add(FormtD.getFloat1(rsArr.getFloat("tnunitprice"),2));
			list10.add(FormtD.getFloat1(rsArr.getFloat("unitprice"),2));
			list11.add(getbyte(rsArr.getString("Room_Type")));
			list12.add(getbyte(rsArr.getString("roomtype")));
			
			list13.add(getbyte(rsArr.getString("Fitment")));
			list15.add(getbyte(rsArr.getString("lu_tai_area_price")));
			list16.add(getbyte(rsArr.getString("lu_tai_area")));
			list17.add(getbyte(rsArr.getString("ty_area")));
			list18.add(getbyte(rsArr.getString("ty_area_price")));
			list19.add(getbyte(rsArr.getString("wd_area")));
			list20.add(getbyte(rsArr.getString("wd_area_price")));
			list21.add(getbyte(rsArr.getString("yong_tu")));
			
			//list7.add(rsArr.getString("Sumprice"));
		   } 
	      rsArr.close();
		int arrlen=0;
	 int hs=0;
	 out.print("<tr>");
	for(int i=intBeginF;i<=intEndF;i++){
	hs=0;
  	  //if (i==0)continue;
	     String ro="";
	 if (i>=0)ro=String.valueOf(java.lang.Math.abs(i));
	 
	%>
	<%if (room_type.indexOf("墅")<0&&room_type.indexOf("车")<0){ %>
     <td align="center"  class=FloorC><font color="#ffffff"><%=i%></font></td>
		<%}
		int IntAvgSumPrice=0;;
		float FatAreaSum=0;
		for(int j=intBeginR;j<=intEndR;j++){
		if (hs==colts){hs=0;out.print("</tr><tr>"); }
		if (!Lock.contains(String.valueOf(j))){
		hs++;
		  no="";
		String RoomNo="";
		
		no="";
		 Rinfo1=Rinfo.trim();
        // if (!Rinfo1.equals(""))Rinfo1=Rinfo1+"-";
		   if (j>=10)
		    RoomNo=Rinfo+ro+String.valueOf(j);
		   else
		    RoomNo=Rinfo+ro+"0"+String.valueOf(j);
		
		arrlen+=1;
		
		
		if (list1.contains(RoomNo)){
		   
		   int index=list1.indexOf(RoomNo);
		   lu_tai_area_price=(String)list15.get(index);
		   lu_tai_area=(String)list16.get(index);
		   ty_area=(String)list17.get(index);
		   ty_area_price=(String)list18.get(index);
	       wd_area=(String)list19.get(index);
		   wd_area_price=(String)list20.get(index);
		   yong_tu=(String)list21.get(index);
		   RoomNo=(String)list14.get(index);
		   state=(String)list2.get(index);
		   floors=(String)list3.get(index);
		   jzarea=(String)list5.get(index);
     	   tnarea=(String)list8.get(index);
		   tnunitprice=(String)list9.get(index);
		   unitprice=(String)list10.get(index);
		   sumprice=(String)list6.get(index);
		   buildingtype=(String)list11.get(index);
		   roomtype=(String)list12.get(index);
		   Fitment=(String)list13.get(index);
		   IntAvgSumPrice+=Integer.parseInt((String)list6.get(index));
		   FatAreaSum+=Float.parseFloat((String)list5.get(index));
		 }else{state="";
		 lu_tai_area_price="0";
		 lu_tai_area="0";
		 ty_area="0";
		 ty_area_price="0";
		 wd_area="0";
		 wd_area_price="0";
		 
		 
		 }  
		 String bg="";
		 if(i==2 && j==6){
		//out.print(IntAvgSumPrice);
		//out.print("<br>"+FatAreaSum);
		}
		 if (state.equals("1")){ bg="BGCOLOR='#DDE8E8'";}
		 if (state.equals("2")){ bg="bgcolor='#00CCFF'"; }
		 if (state.equals("3")){ bg="bgcolor='#E5C862'";}
		 if (state.equals("4")){ bg="bgcolor='#8DE4A6'";}
		 if (state.equals("5")){ bg="bgcolor='#FF00FF'";}
		 if (state.equals("6")){ bg="bgcolor='#AACC6F'";}
		
		  no=RoomNo;
		
		    if (state.equals("2")){ RoomNo=no;}
			else if (state.equals("3")){ RoomNo=no;}
			else if (state.equals("1")){ RoomNo=no;}
			else if (state.equals("5")){ RoomNo=no;}
			else if (state.equals("2")){ RoomNo=no;}
			else if (state.equals("4")){ RoomNo=no;}
			else if (state.equals("6")){ RoomNo=no;}
		
		
		%>
	 <td align="center" BGCOLOR='#DDE8E8'>
	 <% if (state.equals("1")){nosalenum++; %>
	<a href="#" onclick="aa('<%=strSection %>','<%=no%>','<%=Loft %>','<%=floors %>','<%=tnarea %>','<%=jzarea %>','<%=tnunitprice %>','<%=unitprice %>','<%=sumprice %>','<%=buildingtype %>','<%=roomtype %>','<%=Fitment %>','<%=lu_tai_area_price %>','<%=lu_tai_area%>','<%=ty_area %>','<%=ty_area_price %>','<%=wd_area %>','<%=wd_area_price %>','<%=yong_tu %>','<%=BuildPa %>')"><%=RoomNo%></a>
	 <%}%>
	 </td> 
		<%}%>
	
		<%}  if (room_type.indexOf("墅")<0&&room_type.indexOf("车")<0){//别墅不显示楼层%>
	 <td><b><u><%=FormtD.getFloat(IntAvgSumPrice/FatAreaSum,2) %></u></b></td>	
	 <%} %>
	</tr>
	<% }
	}%>
  </table>
  <%} %>
  </form>  
  <script>
  function opennewwin(url,para,wh,hg,lf,tp) {
    var mess="是否认购登录还是查看房间资料？(如果是认购请单击‘确认’)";
	 var newwin=window.open(url+para,"newwin1","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
	
  }
  function opennewwin1(para,wh,hg,lf,tp) {
    
	
	var newwin=window.open("rgList.jsp?"+para,"newwin1","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,width=480,height=500,left=150,top=10");
	
  }
  
  function aa(a,b,c,d,e,f,g,h,i,j,k,o,p1,p2,p3,p4,p5,p6,p7,p8){
 // alert(opener.document.cus.roomno.value);
 if (document.frm.date.value==""){alert("请选择换房日期等信息");return false;}
 
  window.opener.idname.innerHTML="<%=SecName %>";
  window.opener.document.cus.sectio.value="<%=SecName %>";
  window.opener.document.cus.section.value="<%=secno %>";
  window.opener.document.cus.lutai_area_price.value=p1;
    window.opener.document.cus.lutai_area.value=p2;
	
	  window.opener.document.cus.ty_area.value=p3;
    window.opener.document.cus.ty_area_price.value=p4;
	  window.opener.document.cus.wd_area.value=p5;
    window.opener.document.cus.wd_area_price.value=p6;
	 
  window.opener.document.cus.roomno.value=b;
  window.opener.document.cus.loft.value=c;
  window.opener.idroomno.innerHTML=c+p8+b;   
  window.opener.document.cus.zx.value=o;
  window.opener.document.cus.fx.value=k;
  window.opener.document.cus.jzarea.value=f;
 
  window.opener.document.cus.G_jzarea.value=f;
  window.opener.idjzarea.innerHTML=f;
  window.opener.document.cus.fl.value=j;
  window.opener.document.cus.area.value=e;
  window.opener.idusearea.innerHTML=e;
  window.opener.document.cus.floor.value=d; 
  window.opener.document.cus.tnunitprice.value=g;
  window.opener.idunitprice.innerHTML=g;
  window.opener.idsumprice.innerHTML=i;
   window.opener.idsumprice1.innerHTML=i;
    window.opener.idyong_tu1.innerHTML=p7;
	 window.opener.document.cus.yong_tu.value=p7;
	 
	 window.opener.document.cus.build.value=p8;
	
  window.opener.document.cus.sumprice.value=i;
  window.opener.idsaleunitprice.innerHTML=h;
  window.opener.document.cus.jzunitprice.value=h;
 
  window.opener.document.cus.change.value="change";
  window.opener.document.cus.context.value=document.frm.context.value;
  window.opener.document.cus.checker.value=document.frm.checker.value;
  window.opener.charges();
  window.opener.count5();
  window.opener.gzcount();
    window.opener.countwd();
  window.opener.countty();
   window.opener.countlutai();
   window.opener.changeFirstMoney()
  close();
}
function aaa(){

setSelectMad(document.frm.secno,'<%=secno %>')
<%if (!Loft.equals("")){ %>

 document.frm.Section.value=document.frm.secno.value;
 
 changebuild(document.frm.secno);
 setSelectMad(document.frm.Loft,'<%=Loft %>')

 <%} %>
 }
</script>
<%InsertBean.closeConn();
    InsertBean1.closeConn();
 
   %>
</div>
</body>
</html>
