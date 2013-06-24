<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%> 
 <%@ include file="../public_js/qx_checke.jsp"%>
 
<html>
<head>
	<title>销控表</title>
</head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="javascript" src="../public_js/public.js">
</script>
 
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean2" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/asiic.jsp"%>
<%
 

String strMessage=China.getParameter(request,"mess");
String SecName=request.getParameter("SecName");
String Region=China.getParameter(request,"Region");
String condi=China.getParameter(request,"condi");

String RegionStr="";
   
String state="";
String fontColor="";
String strYN=request.getParameter("yn");
String strSection="";


String Loft="";
String strBuilding="";
 
%> 
<SCRIPT language=javascript>
 
 
function submitC(){
  document.frm.action="printRoomCodeShowS.jsp";
  document.frm.submit();


}
function getseldocs1(para) {
     var x=0;
	 var seldocs = new Array();
     var seldocs1 = new Array();
	 var temp=document.frm.elements.length;
 
     for (i=0;i<document.frm.yl.length;i++) {
	 if (document.frm.yl[i].checked&&document.frm.yl[i].ylloft==para)
		 {
       		seldocs[x]="'"+document.frm.yl[i].value+"'";
			seldocs1[x]=document.frm.yl[i].value;
			x++;
   		 }
	  }	
     var returnvalue="";
	  if (seldocs!="")
	   returnvalue=seldocs;//+"/"+seldocs1
   return returnvalue
}
function choose(para,para1){

  for (i=0;i<document.frm.elements.length;i++) {
 
 if((document.frm.elements[i].type=="checkbox")&&(document.frm.elements[i].value==para)&&(document.frm.elements[i].name=="yl")&&(document.frm.elements[i].ylloft==para1))
   document.frm.elements[i].checked=true;
 
}
}
function searcherdata(){

  if (frm.pxshow.value=='1')
 frm.action='printRoomCodeShowS.jsp';
  else
  frm.action='printRoomCodeShowS1.jsp'; 
 
  frm.submit();
}

function showfull(){
<%if (!getbyte1(request.getParameter("section_select")).equals("")){ %>
setSelectMad(document.frm.section_select,'<%=getbyte1(request.getParameter("section_select")) %>');
setSelectMad(document.frm.condi,'<%=getbyte1(request.getParameter("condi")) %>');
setSelectMad(document.frm.pxshow,'<%=getbyte1(request.getParameter("pxshow")) %>');
<%} %>
}
</script >	 
<body topmargin="1" oncontextmenu="return false" onload="showfull();">


 
<form name=frm method="post" action="printRoomCodeShowS.jsp">
 
 
 
<table width="98%" >

<tr> 
<%@ include file="../public_js/CheckSection.jsp"%>
<%   


strSection=getbyte1(request.getParameter("section_select"));
int aaa=0;
	if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
      String sql="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";
	  ResultSet rs2=InsertBean2.executeQuery(sql);
	
	  String sec="";
	  String no="";
  %> <td   colspan="2"> 
 &nbsp;<select name="section_select" style="width:117" onchange="frm.submit();"> 
 <option value="">请选择楼盘名称</option>
<%
while (rs2.next()){
	   no=rs2.getString("SerialNo");
	 
	   sec=getbyte(rs2.getString("Name"));
	     if (strSection.equals(no))SecName=sec;
		   out.print("<option value='"+no+"'>"+sec+"</option>");
		
	  }
	    rs2.close();
     %> </select></td>
	 <% if (!strSection.equals("")){%>	
	  <td align="right"><a href='#' onclick="openwin2('../basic/ViewPic.jsp?menusel=1&SecNo=<%=no %>',550,500,100,100);"  title="项目图片"><img src="../images/t4.gif" border="0"></a></td>
	  <%} %> </tr><tr>
	 <td   >  
	 <%
   String  []  Lofts=request.getParameterValues("showLoft");
     Loft="";
   if (Lofts!=null){
   for (int a=0;a<Lofts.length;a++){
       if (Loft.equals(""))  Loft="'"+getbyte1(Lofts[a])+"'";
	   else Loft+=",'"+getbyte1(Lofts[a])+"'";
    }
   }
	String sqlUser = "select  loft from Sectiontree where  SerialNo='"+strSection+"' group by loft";
  String showop="";
ResultSet userRs = InsertBean2.executeQuery(sqlUser) ;
while (userRs.next()) {
showop="ok";
String housename = userRs.getString("loft") ;
	  %>
	  <input name="showLoft" onclick="searcherdata();" type="checkbox" <%if (Loft.indexOf(housename)>=0){out.print("checked");} %> value="<%=housename %>"><%=housename %>
	  <%}userRs.close(); %>
	  </td>
	 </tr>
	  <%if (!showop.equals("")) {%>
	 <tr><td > &nbsp;&nbsp;<select name=pxshow   onchange="searcherdata();">
	<option value="1">楼层降序</option>
	<option value="0">楼层升序</option>
	</select> &nbsp;<select name=condi onchange="submitC();">
	<option value="color">按色块</option>
	<option value="wen">按文字</option>
	<option value="pic">按图标</option>
	
	</select>&nbsp;<%if (!Loft.equals("")){ %> <input type=button name="EXCELTO" value="导出到EXCEL" onclick="document.frm.action='print_xsl_RoomCodeShowS.jsp';document.frm.target='_blank';document.frm.submit();document.frm.target='';">&nbsp; <input type="button" name="Button" value="打印预览" onClick="document.frm.action='printmanRoomCodeShowS.jsp';document.frm.submit();"><%} %>
</td>
	 </tr>
	  <%} %>
</table>
 
<table border="0"  width="100%"><tr>
<%

String manSQL="select Loft FROM sectiontree where SerialNo='"+strSection+"'";
  
if (!Loft.equals(""))manSQL+=" and Loft in ("+Loft+") ";

manSQL+="group by Loft";

ResultSet manRS=null;
 manRS=InsertBean2.executeQuery(manSQL);
 if (!Loft.equals("")){
 
 while (manRS.next()){
 aaa++;

 out.print("<td valign='top'>");
   Loft=getbyte(manRS.getString("Loft"));
String FindStr="";	
if (!Loft.equals("")) FindStr=" and loft='"+Loft+"'";
if (!strBuilding.equals("")) FindStr+=" and building='"+strBuilding+"'";

String sql1="select lockroom from lockroom where section ='"+strSection+"' and ";
sql1+=" loft='"+Loft+"' and build='"+strBuilding+"'";
ResultSet rsLock=null;
String lock="";
String LockRoomS="";
List Lock=new LinkedList();//存放禁用号
try{
  rsLock=InsertBean.executeQuery(sql1);
  
  while (rsLock.next()){
    String aaaa=rsLock.getString("LockRoom");
	if (lock.equals(""))lock=aaaa;
	else lock+=","+aaaa;
	   
	char lokeA=aaaa.charAt(0);
	if(!java.lang.Character.isDigit(lokeA)){
	  aaaa=String.valueOf(Character.getNumericValue(lokeA)-9);
	}
	 Lock.add(aaaa);
    if (LockRoomS.equals(""))
     LockRoomS=aaaa;
	else
	 LockRoomS+=","+aaaa;
     
 
  }
  rsLock.close();
}catch(Exception s)  {}
 
        sql="select floor from";
		sql=sql+" RoomNo where SectionNo='"+strSection+"'";
		sql=sql+" and Building='"+strBuilding+"' and Region='"+Loft+"' and floor=0";
ResultSet rs=InsertBean.executeQuery(sql);
int FF=1;
if (rs.next())FF=rs.getInt("floor");rs.close();
        sql="select min(Floor) as BeginF,max(Floor) as EndF,";
		sql=sql+"min(Room) as BeginR,max(Room) as EndR,max(cell) as Ecell ,min(cell) as Scell from";
		sql=sql+" RoomNo where SectionNo='"+strSection+"'";
		sql=sql+" and Building='"+strBuilding+"' and Region='"+Loft+"'";
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
  //mxinF=intBeginF;
   //if (intBeginF<0)intBeginF=FF;
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
String fsfc="";
  rs=InsertBean.executeQuery("select roomtype from LoftBuildCode where SecNo='"+strSection+"' and Loft='"+Loft+"' and roomtype=1");
 if (rs.next()){
   fsfc="1";
 }
  rs.close(); 
 %>
<input type=hidden name=SecNo value="<%=strSection%>">
<input type=hidden name=SecName value="<%=SecName%>">
<input type=hidden name=Loft value="<%=Loft %>">
<input type=hidden name=Build value="<%=strBuilding %>">
<input type=hidden name=cusname value="">
<input type=hidden name=secname value="">

<%
 String rg1="#00CCFF";
 String qy1="#E5C862";
 String yl1="#8DE4A6";
 String cz1="#AACC6F"; 
 String ld1="#FF00FF"; 
 String ws1="#DDE8E8";
if (!strSection.equals("")){
String SQL="select  *  from SaleStateColor WHERE secno='"+strSection+"'";

ResultSet rsColor=InsertBean.executeQuery(SQL);	
if (rsColor.next()){
   rg1=rsColor.getString("RG");
   qy1=rsColor.getString("QY");
   ld1=rsColor.getString("ld");   
   cz1=rsColor.getString("CZ");
   yl1=rsColor.getString("YL");   
   ws1=rsColor.getString("ws");  
}

rsColor.close();
}
if (rg1.equals("")){%>
<script>
        alert("还没有设置为销控表设置状态色块,请在系统管理中设置");
       
</script>
<%} %> 
 <%
//权限审核
String Cortrol=checke_qx(InsertBean,(String)session.getAttribute("loginid"),"JC004");
    if (Cortrol==null)Cortrol="";
 
 String sel=(String)request.getParameter("sel");
    if(sel==null) sel="0";	  
 %>

<p CLASS=FontColor align="center"><b><font size="3" ><%if (!SecName.equals(Loft)){out.print(SecName);} %><%=Loft+strBuilding %>销控表</font></b></p>
 <table width="98%" border="0"  align="center" CELLSPACING=1 CELLPADDING=3>
    <tr><td bgcolor='<%=ws1 %>' align="center">未售</td>
	<td bgcolor='<%=rg1 %>'  align="center">认购<img src='../images/mypw.gif' border='0' ></td>
	<td bgcolor='<%=qy1 %>'  align="center">签约<img src='../images/maIcon.gif' border='0' ></td>
	<td bgcolor='<%=yl1 %>'  align="center"><%  if (Cortrol.indexOf("Y")>=0){  %><a href="#" onclick="ylroom(1,'','<%=Loft %>');return false;" title="选择预留房间后点击[预留]" >预留</a><%}else{ %>预留<%} %><img src='../images/day2.gif' border='0' ></td>
	<td bgcolor="<%=ld1 %>"  align="center">临定<img src='../images/face39.gif' border='0' ></td>
	 
	<td   align="center">
	 </td>

	</tr>
	 <tr><td bgcolor='<%=ws1 %>' align="center"><div id=wy<%=aaa %>></div></td>
	<td bgcolor='<%=rg1 %>'  align="center"><div id=ry<%=aaa %>></div></td>
	<td bgcolor='<%=qy1 %>'  align="center"><div id=sy<%=aaa %>></div></td>
	<td bgcolor='<%=yl1 %>'  align="center"><div id=yy<%=aaa %>></div></td>
	<td bgcolor="<%=ld1 %>"  align="center"><div id=ly<%=aaa %>></div></td>
	<!--<td bgcolor='<%=cz1 %>'  align="center"><div id=re></div></td>-->
   <td   align="center"><div id=sum<%=aaa %>> </div>
	</td>
	
	</tr>
	 <tr><td bgcolor='<%=ws1 %>' align="center"><div id=w1<%=aaa %>></div></td>
	<td bgcolor='<%=rg1 %>'  align="center"><div id=r1<%=aaa %>></div></td>
	<td bgcolor='<%=qy1 %>'  align="center"><div id=s1<%=aaa %>></div></td>
	<td bgcolor='<%=yl1 %>'  align="center"><div id=y1<%=aaa %>></div></td>
	<td bgcolor="<%=ld1 %>"  align="center"><div id=l1<%=aaa %>></div></td>
	<!--<td bgcolor='<%=cz1 %>'  align="center"> <div id=re1></div>-->
	</td>
   <td   align="center"> 
	</td>
	</tr>
	</table>

  <%   // try{   
       int nosalenum=0;
	   int rgnum=0;
	   int salenum=0;
	   int rentnum=0;
	   int yl=0;
	   int ld=0;
  
        String BuildPa=request.getParameter("Build");
        if (BuildPa==null)BuildPa="";
		String locaPara="Loft="+request.getParameter("Loft")+"&Build="+BuildPa+"&SecNo="+request.getParameter("SecNo")+"&SecName="+request.getParameter("SecName");
		String upp="ABCDEFGHIJKLOPQRST";
		upp=upp.trim();
		int nn=0;
        String RoomNoUp="";
		String  sqlU="select top 1 Room_code from Room where seccode=";
				sqlU=sqlU+"'"+strSection+"' and Building='";
				sqlU=sqlU+strBuilding+"' and loft='"+Loft+"'  ";
		ResultSet rsU=InsertBean1.executeQuery(sqlU);
        if (rsU.next())RoomNoUp=rsU.getString("Room_code");
		rsU.close();
 
        if (RoomNoUp.equals("")){
		%>
		<script>
       // alert("此栋还没有进行房间资料录入操作");
        //window.location="../basic/RoomCodeShow1.jsp?<%=locaPara %>&notbg=y";
       //}
</script>
		 <%}else{
		  

%> 
<script>
  function px(para){
    if (para=="asc")document.frm.action="RoomCodeShowS.jsp";
	else document.frm.action="RoomCodeShowDS.jsp";
     document.frm.submit();
  
  }
	
	</script>
 <table width="100%" align="center" border="0" CELLSPACING=0 CELLPADDING=0>
   <tr valign="top"> 
 <%for(int j2=scell;j2<=ecell;j2++){
			if (scell>0){  
			  Rinfo=AsiicZH(j2,CellN1); 
			} %>
 
		 
	<%
    List list1=new LinkedList();//存放铺位编码
	List list2=new LinkedList();//存放铺位状态
	List list3=new LinkedList();//存放所在FLoor
    List list4=new LinkedList();//存放房号
    List list5=new LinkedList();//存放建筑面积
    List list6=new LinkedList();//存放当前单元code
    List list7=new LinkedList();//存放房号
	List list8=new LinkedList();//存放楼层附加字
	List list9=new LinkedList();//存放楼层附加字
	List list10=new LinkedList();//存放是否退过房，而锁定
	List list11=new LinkedList();//存放是否退日期
	List list12=new LinkedList();//存放已售总价
	List list13=new LinkedList();//存放楼层附加字
	List list14=new LinkedList();//存放业主
	List list15=new LinkedList();//存按揭日期
	List list16=new LinkedList();//存按揭银行
	List list17=new LinkedList();//存房间ID
	String floorshow="",showfloors="";
	String floortype="";
	String floormess="";
	String l6="";
    String l5="";
    String StrUpper="ABCDEFGHIJKLOPQRST"; 
	  int colts=20;
	  String room_type="";
	 String ss="select type,ts from CRM_Project where serialno='"+strSection+"'";
   ResultSet ssr=InsertBean1.executeQuery(ss);
   if (ssr.next()){
    room_type=ssr.getString("type");
	colts=ssr.getInt("ts");
   }
   ssr.close();
   
	String sqlArr="select    a.dis, a.tddate,a.Room_code,a.saleState,a.Floor,a.Room,a.area,a.code,a.sumprice,a.floorshow,a.floortype,a.floormess,b.showfloors from roomstateview a,roomno b  where   a.seccode+a.loft+a.room_code= b.SectionNo+b.region+b.roomno and a.seccode=";
		   sqlArr=sqlArr+"'"+strSection+"'";
		   sqlArr=sqlArr+FindStr+" and  a.cell='"+Rinfo+"' and a.floortype=0   order by a.Floor";
		   ResultSet rsArr=InsertBean1.executeQuery(sqlArr);
   
		   int aryi=0;
		   while (rsArr.next()){
		     
		    list7.add(rsArr.getString("Room_code"));
			list2.add(rsArr.getString("SaleState"));
			String FloorS=rsArr.getString("Floor");
			String RoomS=rsArr.getString("Room");
			floorshow=rsArr.getString("floorshow");
			floortype=rsArr.getString("floortype");
			list3.add(FloorS);
			list4.add(RoomS);
			if (Integer.parseInt(RoomS)>=10)
			 list1.add(Rinfo+FloorS+RoomS);
			else
			  list1.add(Rinfo+FloorS+"0"+RoomS);
			
			list5.add(rsArr.getString("area"));
			list6.add(rsArr.getString("code"));
			list8.add(getbyte(rsArr.getString("floormess")));
			list9.add(getbyte(rsArr.getString("showfloors")));
			list10.add(rsArr.getString("dis"));
			list11.add(getbyte(rsArr.getString("tddate")));
			list12.add(getbyte(rsArr.getString("sumprice")));
		   } 
	      rsArr.close();
		  
		  
		  
		    sqlArr="select   r.code as roomcode,r.Room_code,r.saleState,r.Floor,r.Room,r.floormess,o.customer,o.code,r.floorshow,r.floortype,convert(char(10),o.fkdate,120) fkdate ,o.ajbk,o.ajhtno,c.cus_name,o.ajmoney/10000.0 ajmoney  from room r,order_contract o,customer c  where o.state<>3  and c.serialno=o.customer and r.seccode=o.section and o.loft=r.loft and o.building=r.building and o.room_no=r.room_code and r.seccode=";
		    sqlArr=sqlArr+"'"+strSection+"'";
		    sqlArr=sqlArr+" and  r.cell='"+Rinfo+"' and o.floors=r.floor and r.loft='"+Loft+"' and r.building='"+strBuilding+"' and r.floortype=0    order by  r.Floor";
         rsArr=InsertBean1.executeQuery(sqlArr);
		  while (rsArr.next()){
		   list17.add(getbyte(rsArr.getString("roomcode")));
		  list16.add(getbyte(rsArr.getString("ajbk")));
		  list15.add(getbyte(rsArr.getString("fkdate")));
		  list14.add(getbyte(rsArr.getString("cus_name")));	
         } 
	      rsArr.close();
 
 
		int arrlen=0;
		 
	 %>
	 <td align="center" valign="top"><%if (!Rinfo.equals("")) {out.print(Rinfo+"单元");}%>
	 <table border="0" width="100%" CELLSPACING=1 CELLPADDING=0>
	  <%  if (room_type.indexOf("墅")<0&&room_type.indexOf("车")<0&&intEndR<=colts){//别墅不显示房间序号 %>
	   <tr>
	    <td  width="1%" bgcolor="#800000" align="center"><img src="../images/1.gif" border="0"></td>

		 		<%
		char BeF=RoomNoUp.charAt(0);
		RoomNoUp=RoomNoUp.substring(RoomNoUp.length()-1);
 
        char BeR=RoomNoUp.charAt(0);
		for(int j=intBeginR;j<=intEndR;j++){
	        String NO="";
		   NO=AsiicZH(j,BeR);//调用asiic转换方法
		 
			if (LockRoomS.indexOf(String.valueOf(j))>=0||upp.indexOf(LockRoomS)>=0){
			 if (upp.indexOf(LockRoomS)>=0){
			 if (!Lock.contains(String.valueOf(j))){
			%>
		     <td align="center" class=listtitle  <%  if (Cortrol.indexOf("Y")>=0){ %> <%} %>  width="5%"><font color="#ffffff"><%=NO%></font><!--<input type=checkbox name="Check<%=j%>" value="<%=j%>" checked onclick="LokeRoomNo('<%=strSection%>','<%=Loft %>','<%=j %>',this);">--></td>
			 <%}
			 }else if (!Lock.contains(String.valueOf(j))){//LockRoomS.indexOf(String.valueOf(j))<0
			 %>
			 <td align="center" class=listtitle  <%  if (Cortrol.indexOf("Y")>=0){ %><%} %>  width="5%"><font color="#ffffff"><%=NO%></font></td>
			 <%} %>	
			 <%}else if (!Lock.contains(String.valueOf(j))){ %>
			 <td align="center" class=listtitle  <%  if (Cortrol.indexOf("Y")>=0){ %> <%} %>  width="5%"><font color="#ffffff"><%=NO%></font><!--<input type=checkbox name="Check<%=j%>" value="<%=j%>" checked onclick="LokeRoomNo('<%=strSection%>','<%=Loft %>','<%=j %>',this);">--></td>
			 
			 <%}
			 
			 }%>
			 
		 	</tr><%} %>
	 <tr>
		
	<%
	 
		int hs=0;
	for(int i=intEndF;i>=intBeginF;i--){
	hs=0;
	    if (room_type.indexOf("墅")<0&&room_type.indexOf("车")<0){
	%><td align="center" class=FloorC width="1%"><font color="#ffffff"><div id=A<%=String.valueOf(java.lang.Math.abs(i))+1 %>w1><%=i%></div></font></td>
		<%  }else{ %> 
		<div style='display:none' id=A<%=String.valueOf(java.lang.Math.abs(i))+1 %>w1><%=i%></div>
		<%}
		float IntAvgSumPrice=0;;
		float FatAreaSum=0;
		for(int j=intBeginR;j<=intEndR;j++){
 
 
	 if (hs==colts){hs=0;out.print("</tr><tr>"); 
	     if (room_type.indexOf("墅")<0&&room_type.indexOf("车")<0){//别墅不显示楼层
	%><td align="center" class=FloorC width="1%"><font color="#ffffff"><div id=A<%=String.valueOf(java.lang.Math.abs(i))+1 %>w1><%=i%></div></font></td>
		<%  }else{ %> 
		<div style='display:none' id=A<%=String.valueOf(java.lang.Math.abs(i))+1 %>w1><%=i%></div>
		
 
     	<%}
	 }
		if (!Lock.contains(String.valueOf(j))){
		hs++;
		 
		  no="";
		String RoomNo="";
		String cus_name="";
		String roomid="";
		String ajbk="";
		String ajdate="";
		no="";
		String dis="0",tddate="";
	    if (j>=10)
		    RoomNo=Rinfo+String.valueOf(i)+String.valueOf(j);
		else
		    RoomNo=Rinfo+String.valueOf(i)+"0"+String.valueOf(j);
		arrlen+=1;
		
		if (list1.contains(RoomNo)){
		   int index=list1.indexOf(RoomNo);
		   state=(String)list2.get(index);
		   roomid=(String)list6.get(index);
	 	   RoomNo=(String)list7.get(index);
		   floormess=(String)list8.get(index);
		   showfloors=(String)list9.get(index); 
		   if(!state.equals("1")){
                      try{
                        l6=(String)list6.get(index);
                        l5=(String)list5.get(index);
                       String  l7=(String)list12.get(index);
                      if (l6.equals("")||l6==null)l6="0";
                      if (l5.equals("")||l5==null)l5="0";   
					  if (l7.equals("")||l7==null)l7="0";      
                      IntAvgSumPrice+=Float.parseFloat(l7);
		             FatAreaSum+=Float.parseFloat(l5);
                      }catch(Exception s){}
		   }
		 }else{state="";}  
		 if (list17.contains(roomid)){
		   int index=list17.indexOf(roomid);
		   cus_name=(String)list14.get(index);
		   ajdate =(String)list15.get(index);
		   ajbk =(String)list16.get(index);
		}
		 String bg="";
		 if(i==3 && j==4){
	   	 }
		 if (state.equals("1")){ bg="BGCOLOR='"+ws1+"'";}
		 if (state.equals("2")){ bg="bgcolor='"+rg1+"'"; }
		 if (state.equals("3")){ bg="bgcolor='"+qy1+"'";}
		 if (state.equals("4")){ bg="bgcolor='"+yl1+"'";}
		 if (state.equals("5")){ bg="bgcolor='"+ld1+"'";}
		// if (state.equals("6")){ bg="bgcolor='"+ws1+"'";}
		 if (state.equals("7")){ bg="bgcolor='"+cz1+"'";rentnum++;}
		  no=RoomNo;
		  
		    if (condi.equals("wen")){
		     bg="BGCOLOR='"+ws1+"'";
            if (state.equals("3")){ RoomNo="已售"+no;}
            else if (state.equals("2")){ RoomNo="已认购"+no;}
            else if (state.equals("4")){ RoomNo="已预留"+no;}
          //  else if (state.equals("6")){ RoomNo="已鉴证"+no;}
			else if (state.equals("1")){ RoomNo="未售"+no;}
			else if (state.equals("5")){ RoomNo="临定"+no;} 
			else if (state.equals("7")){ RoomNo="出租"+no;} 
		 }else if (condi.equals("pic")){
		    bg="BGCOLOR='"+ws1+"'";
		    if (state.equals("2")){ RoomNo=no+"<img src='../images/mypw.gif' border='0' title='已认购房号："+no+"'>";}
			else if (state.equals("3")){ RoomNo=no+"<img src='../images/maIcon.gif' border='0' title='已售房号："+no+"' >";}
			else if (state.equals("1")){ RoomNo=no+"&nbsp;&nbsp;";}
			else if (state.equals("5")){ RoomNo=no+"<img src='../images/day2.gif' border='0' title='已临定房号："+no+"'>";}
			else if (state.equals("2")){ RoomNo=no;}
			else if (state.equals("4")){ RoomNo=no+"<img src='../images/face39.gif' border='0' title='已预留房号："+no+"'>";}
			else if (state.equals("6")){ RoomNo=no;}
			else if (state.equals("7")){ RoomNo=no;}
		 }else{
		    if (state.equals("2")){ RoomNo=no;}
			else if (state.equals("3")){ RoomNo=no;}
			else if (state.equals("1")){ RoomNo=no;}
			else if (state.equals("5")){ RoomNo=no;}
			else if (state.equals("2")){ RoomNo=no;}
			else if (state.equals("4")){ RoomNo=no;}
			else if (state.equals("6")){ RoomNo=no;}
		 }
		  
		if (!tddate.equals(""))tddate=tddate.substring(0,10);
		%>
		 
	 <td align="center" width="5%"  <%=bg %> <%if (dis.equals("1")){ %>title="锁定日期:<%=tddate %>"<%} %>>
	<%if (fsfc.equals("")){ %>
	 <% if (state.equals("1")&&dis.equals("0")){nosalenum++; %>
	<%  if (Cortrol.indexOf("A")>=0){  %><a href="#<%=RoomNo %>" onclick="opennewwin('roomdata.jsp','?secname=<%=SecName %>&secno=<%=strSection%>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&state=1',720,530,120,5)"><%} %><%=RoomNo%><%  if (Cortrol.indexOf("A")>=0){  %></a><%} %>
	  <% }else if (state.equals("1")&&dis.equals("1")){  %>
	   <a href="#"> <%=RoomNo%>[锁定] </a>
	  <%}else if (state.equals("3")){ salenum++;%>
      <a href="#<%=RoomNo%>" ><%=RoomNo%><br><%=cus_name %><br><% if (!ajdate.equals(""))out.println(ajdate+"("+ajbk+")"); %></a> 
	 <%}else if (state.equals("2")){rgnum++;%>
	    <a href="#<%=RoomNo%>"><%=RoomNo%><br><%=cus_name %></a> 
	
	  
	 <%}else if (state.equals("4")){yl++;%>
	  <%  if (Cortrol.indexOf("Y")>=0){  %><a href="#<%=RoomNo%>" onclick="choose('<%=RoomNo%>','<%=Loft %>');ylroom(2,'<%= RoomNo%>','<%=Loft %>');"><%} %><%=RoomNo%><%  if (Cortrol.indexOf("A")>=0){  %></a><%} %>
	 <%}else if (state.equals("6")){ %>
	  <a href="#<%=RoomNo %>"  <%  if (Cortrol.indexOf("E")>=0){  %> onclick="opennewwin('ContractList.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&show=false',480,500,150,10)"<%} %>><%=RoomNo%></a> 
	  <%}else if (state.equals("5")){ ld++;%>
	  <a href="#<%=RoomNo %>"  <%  if (Cortrol.indexOf("A")>=0){  %> onclick="opennewwin('roomdata1.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&state=5',720,530,120,5)"<%} %>><%=RoomNo%></a>
	 <%} else if (state.equals("7") ){%>
	 <a href="#<%=RoomNo %>"  <%  if (Cortrol.indexOf("E")>=0){  %> onclick="opennewwin('show_rent_contract.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&state=5',720,530,120,5)"<%} %>> <%=RoomNo%></a>
	 <%}else{ %>&nbsp;<%} %>
	 <%}else if (state.equals("1")&&!dis.equals("1")){ nosalenum++; %>
	 <%  if (Cortrol.indexOf("A")>=0){  %><a href="#<%=RoomNo %>" onclick="opennewwin('roomdata.jsp','?secname=<%=SecName %>&secno=<%=strSection%>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&state=1',720,530,120,5)"><%} %><%=RoomNo%><%  if (Cortrol.indexOf("A")>=0){  %></a><%} %>
	 
	
	 <%}else  if (state.equals("2")){rgnum++;%>
	  <a href="#<%=RoomNo%>"  <%  if (Cortrol.indexOf("E")>=0){  %> onclick="opennewwin('ContractInput2.jsp','?roomcode=<%=l6 %>&secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&show=true',750,530,120,2);"<%} %>><%=RoomNo%></a> 
	
	 <%}else  if (state.equals("3")){salenum++; %>
	  <a href="#<%=RoomNo%>"  <%  if (Cortrol.indexOf("E")>=0){  %> onclick="opennewwin('ContractInput2.jsp','?roomcode=<%=l6 %>&secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&show=true',750,530,120,2);"<%} %>><%=RoomNo%></a> 
	  <%} %>   
	 </td> 
		<%}%>
	
		<%}

%>
	 <script>A<%=String.valueOf(java.lang.Math.abs(i))+1 %>w1.innerHTML="<% if (!floormess.equals("")) out.print(String.valueOf(i)+floormess);else out.print(i);%>";</script>
	
	</tr>
	
	
	<%
	}
	for(int i=mxinF;i<=-1;i++){
	 %>
	<tr> 
     	<%
		float IntAvgSumPrice=0;;
		float FatAreaSum=0;
		for(int j=intBeginR;j<=intEndR;j++){
		if (!Lock.contains(String.valueOf(j))){
		  no="";
		String RoomNo="";
		no="";
	    if (j>=10)
		    RoomNo=Rinfo+String.valueOf(i)+String.valueOf(j);
		else
		    RoomNo=Rinfo+String.valueOf(i)+"0"+String.valueOf(j);
		arrlen+=1;
		
		if (list1.contains(RoomNo)){
		   int index=list1.indexOf(RoomNo);
		   state=(String)list2.get(index);
		    RoomNo=(String)list7.get(index);
			floormess=(String)list8.get(index);
			showfloors=(String)list9.get(index); 
		   if(!state.equals("1")){
                      try{
                        l6=(String)list6.get(index);
                        l5=(String)list5.get(index);
                       String  l7=(String)list12.get(index);
                      if (l6.equals("")||l6==null)l6="0";
                      if (l5.equals("")||l5==null)l5="0";   
					  if (l7.equals("")||l7==null)l7="0";   
					   
                      IntAvgSumPrice+=Float.parseFloat(l7);  
		              FatAreaSum+=Float.parseFloat(l5);
                      }catch(Exception s){}
		   }
		 }else{state="";}  
		 String bg="";
		 if(i==3 && j==4){
	   	 }
		 if (state.equals("1")){ bg="BGCOLOR='#DDE8E8'";}
		 if (state.equals("2")){ bg="bgcolor='#00CCFF'"; }
		 if (state.equals("3")){ bg="bgcolor='#E5C862'";}
		 if (state.equals("4")){ bg="bgcolor='#8DE4A6'";}
		 if (state.equals("5")){ bg="bgcolor='#FF00FF'";}
		 if (state.equals("6")){ bg="bgcolor='#AACC6F'";}
		 if (state.equals("7")){ bg="bgcolor='#AACC6F'";rentnum++;}
		  no=RoomNo;
		 
		   if (condi.equals("wen")){
		    bg="bgcolor='#c0c0c0'";
            if (state.equals("3")){ RoomNo="已售"+no;}
            else if (state.equals("2")){ RoomNo="已认购"+no;}
            else if (state.equals("4")){ RoomNo="已预留"+no;}
          //  else if (state.equals("6")){ RoomNo="已鉴证"+no;}
			else if (state.equals("1")){ RoomNo="未售"+no;}
			else if (state.equals("5")){ RoomNo="临定"+no;} 
			else if (state.equals("7")){ RoomNo="出租"+no;} 
		 }else if (condi.equals("pic")){
		    bg="bgcolor='#c0c0c0'";
		    if (state.equals("2")){ RoomNo=no+"<img src='../images/mypw.gif' border='0' title='已认购房号："+no+"'>";}
			else if (state.equals("3")){ RoomNo=no+"<img src='../images/maIcon.gif' border='0' title='已售房号："+no+"' >";}
			else if (state.equals("1")){ RoomNo=no+"&nbsp;&nbsp;";}
			else if (state.equals("5")){ RoomNo=no+"<img src='../images/day2.gif' border='0' title='已临定房号："+no+"'>";}
			else if (state.equals("2")){ RoomNo=no;}
			else if (state.equals("4")){ RoomNo=no+"<img src='../images/face39.gif'  border='0' title='已预留房号："+no+"'>";}
			else if (state.equals("6")){ RoomNo=no;}
			else if (state.equals("7")){ RoomNo=no;}
		 }else{
		    if (state.equals("2")){ RoomNo=no;}
			else if (state.equals("3")){ RoomNo=no;}
			else if (state.equals("1")){ RoomNo=no;}
			else if (state.equals("5")){ RoomNo=no;}
			else if (state.equals("2")){ RoomNo=no;}
			else if (state.equals("4")){ RoomNo=no;}
			else if (state.equals("6")){ RoomNo=no;}
		 }
		  
		
		%>
		 
	  <td align="center" width="5%"  <%=bg %>>
	 <% if (state.equals("1")){nosalenum++; %>
	 <%  if (Cortrol.indexOf("A")>=0){  %><a href="#<%=RoomNo%>" onclick="opennewwin('roomdata.jsp','?secname=<%=SecName %>&secno=<%=strSection%>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&state=1',720,530,120,5)"><%} %><%=RoomNo%><%  if (Cortrol.indexOf("A")>=0){  %></a><%} %>
	 <%}else if (state.equals("2")){rgnum++; %>
       <a href="#<%=RoomNo%>"  <%  if (Cortrol.indexOf("E")>=0){  %> onclick="opennewwin('modiContractInput.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&show=true',720,530,120,2)"<%} %>><%=RoomNo%></a> 
	 <%}else if (state.equals("3")){salenum++;%>
	  <a href="#<%=RoomNo%>"  <%  if (Cortrol.indexOf("E")>=0){  %> onclick="opennewwin('modiContractInput.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&show=true',720,530,120,2)"<%} %>><%=RoomNo%></a> 
	 <%}else if (state.equals("4")){yl++;%>
	<%  if (Cortrol.indexOf("Y")>=0){  %>   <a href="#<%=RoomNo%>"onclick="choose('<%=RoomNo%>','<%=Loft %>');ylroom(2,'<%= RoomNo%>','<%=Loft %>');"><%} %><%=RoomNo%><%  if (Cortrol.indexOf("Y")>=0){  %></a><%} %>
	 <%}else if (state.equals("6")){ %>
	  <a href="#<%=RoomNo%>"  <%  if (Cortrol.indexOf("E")>=0){  %> onclick="opennewwin('ContractList.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&show=false',480,500,150,10)"<%} %>><%=RoomNo%></a> 
	  <%}else if (state.equals("5")){ ld++;%>
	  <a href="#<%=RoomNo%>"  <%  if (Cortrol.indexOf("A")>=0){  %> onclick="opennewwin('roomdata1.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&state=5',720,530,120,5)"<%} %>><%=RoomNo%></a>
	 <%} else if (state.equals("7") ){%>
	 <a href="#<%=RoomNo%>" <%  if (Cortrol.indexOf("E")>=0){  %>  onclick="opennewwin('show_rent_contract.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&state=5',680,530,120,5)"<%} %>> <%=RoomNo%></a>
	 <%}else{ %>&nbsp;<%} %>
	 </td>
	 
	 
	
		<%}%>
		
		
		<%}%>
	 
 </tr>
	
	
	 
	<%}
	out.print("</td></tr></table>");
	} %>
	
  <%} %>
</td></tr>
	  </table>
  
  <script>
  
function ylroom(para,para1,para2){
    var rooms=getseldocs1(para2);
    if (rooms==""){alert("请选择预留的房间！");return false;}
	var url="";
	if (para==1) 
      url="add_yl_rooms.jsp?rooms="+rooms+"&loft="+para2+"&build=<%=strBuilding %>&secno=<%=strSection %>&secname=<%=SecName %>";
    else 
	   url="show_yl_rooms.jsp?rooms="+para1+"&loft="+para2+"&&build=<%=strBuilding %>&secno=<%=strSection %>&secname=<%=SecName %>";
  
    var newWin = window.open(url,"roomfrm","height=650,width=710,left=150,top=50,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no");
    newWin.focus() ;
}
  function opennewwin(url,para,wh,hg,lf,tp) {
   var newwin=window.open(url+para,"newwin1","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
	
  }
  function printT(){
  pri.innerHTML="";
  print();
  
  }
  function opennewwin1(para,wh,hg,lf,tp) {
    
	
	var newwin=window.open("rgList.jsp?"+para,"newwin1","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,width=480,height=500,left=150,top=10");
	
  }
   
  wy<%=aaa %>.innerHTML = "<%=nosalenum %>";
  w1<%=aaa %>.innerHTML = "<%=FormtD.getFloat(Float.parseFloat(String.valueOf(nosalenum))/(ld+nosalenum+yl+salenum+rgnum)*100,2) %>%";
  ry<%=aaa %>.innerHTML = "<%=rgnum %>";
  r1<%=aaa %>.innerHTML = "<%=FormtD.getFloat(Float.parseFloat(String.valueOf(rgnum))/(ld+nosalenum+yl+salenum+rgnum)*100,2) %>%";
  sy<%=aaa %>.innerHTML = "<%=salenum %>";
  s1<%=aaa %>.innerHTML = "<%=FormtD.getFloat(Float.parseFloat(String.valueOf(salenum))/(ld+nosalenum+yl+salenum+rgnum)*100,2) %>%";
  yy<%=aaa %>.innerHTML = "<%=yl %>";
  y1<%=aaa %>.innerHTML = "<%=FormtD.getFloat(Float.parseFloat(String.valueOf(yl))/(ld+nosalenum+yl+salenum+rgnum)*100,2) %>%";
  ly<%=aaa %>.innerHTML = "<%=ld %>";
 l1<%=aaa %>.innerHTML = "<%=FormtD.getFloat(Float.parseFloat(String.valueOf(ld))/(ld+nosalenum+yl+salenum+rgnum)*100,2) %>%";
 // re.innerHTML = "<%=rentnum %>";
  //re1.innerHTML = "<%=FormtD.getFloat(Float.parseFloat(String.valueOf(rentnum))/(ld+nosalenum+yl+salenum+rgnum)*100,2) %>%";

  sum<%=aaa %>.innerHTML = "合计：<%=ld+nosalenum+yl+salenum+rgnum+rentnum %>";
   
  </script>
  </td>
<%//}catch(Exception s){}%>
<%} }%>
</tr></table>
 
</form>  
 

</body>
</html>
