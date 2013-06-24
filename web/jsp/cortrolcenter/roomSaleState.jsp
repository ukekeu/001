<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>

 <%@ include file="../public_js/qx_checke.jsp"%>
 
<html>
<head>
	<title>实时销控表</title>
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
  document.frm.action="manRoomCodeShowS.jsp";
  document.frm.submit();


}
function getseldocs1() {
     var x=0;
	 var seldocs = new Array();
     var seldocs1 = new Array();
	 var temp=document.frm.elements.length;
 
     for (i=0;i<document.frm.yl.length;i++) {
	 if (document.frm.yl[i].checked)
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
function ylroom(){
    var rooms=getseldocs1();
    if (rooms==""){alert("请选择预留的房间！");return false;}
    var url="add_yl_rooms.jsp?rooms="+rooms+"&loft=<%=Loft %>&build=<%=strBuilding %>&secno=<%=strSection %>&secname=<%=SecName %>";
    var newWin = window.open(url,"roomfrm","height=350,width=510,left=150,top=50,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no");
    newWin.focus() ;
}
function choose(para){

  for (i=0;i<document.frm.elements.length;i++) {
 
 if((document.frm.elements[i].type=="checkbox")&&(document.frm.elements[i].value==para)&&(document.frm.elements[i].name=="yl"))
   document.frm.elements[i].checked=true;
   else document.frm.elements[i].checked=false;
}
}
function openwinzy(url,wh,hg,lf,tp) {
  var newwin=window.open(url,"newwin","toolbar=no,location=no,directories=yes,status=yes,menubar=yes,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
  newwin.focus();
  return false;
}
   var sendmess="";
function chhoseData1(){
sendmess="";
   for (var i=0;i<document.frm.chooseroom.length;i++){
 	 
	  if (document.frm.chooseroom[i].checked){
	    var aa=document.frm.chooseroom[i].value;
		
	    if (sendmess!="")
		 
		 sendmess+=","+aa;
	    else
		   sendmess=aa;
	    document.frm.chooseroom[i].checked=false;
	  }
    }
	 if (sendmess==""){alert("请选择需要试算的单位");}
	 else { openwinzy("zy1.jsp?code="+sendmess+"&yh="+document.frm.yh.value+"&hy="+document.frm.hy.value,550,450,100,100);}

}
function searcherdata(){

  if (frm.pxshow.value=='1')
  frm.action='roomSaleState.jsp';
  else
  frm.action='roomSaleState1.jsp'; 
 
  frm.submit();
}

</script >	 
<body oncontextmenu="return false"  topmargin="1" onload="setSelectMad(document.frm.section_select,'<%=getbyte1(request.getParameter("section_select")) %>');setSelectMad(document.frm.pxshow,'<%=getbyte1(request.getParameter("pxshow")) %>');">
 


 
<form name=frm method="post" action="roomSaleState.jsp">
 
 
 
<table width="98%"  border="0">

<tr> 
<%@ include file="../public_js/CheckSection.jsp"%>
<%   strSection=getbyte1(request.getParameter("section_select"));
int aaa=0;
	if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
      String sql="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";
	  ResultSet rs2=InsertBean2.executeQuery(sql);
	
	  String sec="";
	  String no="";
  %> <td  width="100%"  >
 &nbsp;<select name="section_select" style="width:117" onchange="frm.submit();"> 
 <option value="">请选择楼盘名称<option>
<%
while (rs2.next()){
	   no=rs2.getString("SerialNo");
	 
	   sec=getbyte(rs2.getString("Name"));
	     if (strSection.equals(no))SecName=sec;
		   out.print("<option value='"+no+"'>"+sec+"</option>");
		
	  }
	    rs2.close();
     %> </select><font color=red>*</font> </td> 
	 </tr>
	 <tr>
	 <td    width="100%"  >   
	 
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
 
ResultSet userRs = InsertBean2.executeQuery(sqlUser) ;
while (userRs.next()) {
String housename = userRs.getString("loft") ;
	  %>
	  <input name="showLoft"  onclick="searcherdata();" type="checkbox" <%if (Loft.indexOf(housename)>=0){out.print("checked");} %> value="<%=housename %>"><%=housename %>
	  <%}userRs.close(); %>
	  </td>
	 </tr>
	 <tr><td > &nbsp;&nbsp;<select name=pxshow   onchange="searcherdata();">
	<option value="1">楼层降序</option>
	<option value="0">楼层升序</option>
	</select></td></tr>
	<%if (!Loft.equals("")){ %>
<tr><td align="right">VIP卡号：<input type=text name=vipno size=15 > &nbsp;&nbsp;	房号：<input type=text name=saleroom size=10 > &nbsp;&nbsp;<input type=button name=ss value="查找VIP号认购单位" onclick="saleFind();"></td></tr>
    <%} %>
</table>
 
<table border="0"  width="100%"><tr>
<%

String manSQL="select Loft FROM sectiontree where SerialNo='"+strSection+"'";

   if(Loft.equals(""))  Loft="''";
manSQL+=" and Loft in ("+Loft+")";
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
int colts=20;
	  String room_type="";
	 String ss="select type,ts from CRM_Project where serialno='"+strSection+"'";
   ResultSet ssr=InsertBean1.executeQuery(ss);
   if (ssr.next()){
    room_type=ssr.getString("type");
	colts=ssr.getInt("ts");
   }
   ssr.close();
String fsfc="";
  rs=InsertBean.executeQuery("select roomtype from LoftBuildCode where SecNo='"+strSection+"' and Loft='"+Loft+"' and roomtype=1");
 if (rs.next()){
   fsfc="1";
 }
  rs.close(); 
 %>
 

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
String Cortrol=checke_qx(InsertBean,(String)session.getAttribute("loginid"),"QT12");
    if (Cortrol==null)Cortrol="";
	
 String sel=(String)request.getParameter("sel");
    if(sel==null) sel="0";	  
 %>

<p CLASS=FontColor align="center"><b><font size="3" ><%if (!SecName.equals(Loft)){out.print(SecName);} %><%=Loft+strBuilding %>销控表</font></b></p>
 <table width="98%" border="0"  align="center" CELLSPACING=1 CELLPADDING=3>
    <tr><td bgcolor='<%=ws1 %>' align="center">未售</td>
	<td bgcolor='<%=rg1 %>'  align="center">已售<img src='../images/mypw.gif' border='0' ></td>
	 
	 
	<td   align="center">
	 </td>

	</tr>
	 <tr><td bgcolor='<%=ws1 %>' align="center"><div id=wy<%=aaa %>></div></td>
	<td bgcolor='<%=rg1 %>'  align="center"><div id=ry<%=aaa %>></div></td>
	 
   <td   align="center"><div id=sum<%=aaa %>> </div>
	</td>
	
	</tr>
	 <tr><td bgcolor='<%=ws1 %>' align="center"><div id=w1<%=aaa %>></div></td>
	<td bgcolor='<%=rg1 %>'  align="center"><div id=r1<%=aaa %>></div></td>
	 
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
		String locaPara="Loft="+getbyte1(request.getParameter("Loft"))+"&Build="+BuildPa+"&SecNo="+getbyte1(request.getParameter("SecNo"))+"&SecName="+getbyte1(request.getParameter("SecName"));
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
 <table width="100%" align="center" border="0" CELLSPACING=1 CELLPADDING=3>
   <tr valign="top"> 
 <%for(int j2=scell;j2<=ecell;j2++){
			if (scell>0){  
			  Rinfo=AsiicZH(j2,CellN1); 
			} %>
 
		 
	<%
    List list1=new LinkedList();//存放铺位编码
	List list2=new LinkedList();//存放实时销售状态
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
	
	String floorshow="",showfloors="";
	String floortype="";
	String floormess="";
	String l6="";
    String l5="";
    String StrUpper="ABCDEFGHIJKLOPQRST"; 
	String sqlArr="select   a.dis, a.tddate,a.Room_code,a.ssstate,a.Floor,a.Room,a.area,a.code,a.sumprice,a.floorshow,a.floortype,a.floormess,b.showfloors from roomstateview a,roomno b where a.seccode+a.loft+a.room_code= b.SectionNo+b.region+b.roomno and a.seccode=";
		   sqlArr=sqlArr+"'"+strSection+"'";
		   sqlArr=sqlArr+FindStr+" and  a.cell='"+Rinfo+"' and a.floortype=0   order by a.Floor";
		   ResultSet rsArr=InsertBean1.executeQuery(sqlArr);
 
		   int aryi=0;
		   while (rsArr.next()){
		    list7.add(rsArr.getString("Room_code"));
			list2.add(rsArr.getString("ssstate"));
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
		int arrlen=0;
	 %>
	 <td align="center" valign="top"><%if (!Rinfo.equals("")) {out.print(Rinfo+"单元");}%>
	 <table border="0" width="100%">
	   <%  if (room_type.indexOf("墅")<0&&room_type.indexOf("车")<0){//别墅不显示房间序号 
	   if (intEndR<=colts){%>
	   <tr>
	    <td  width="10%" bgcolor="#800000" align="center"><font color="#FFFFFF"<b>楼层\房号</b></font></td>

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
		     <td align="center" class=listtitle width="10%"><font color="#ffffff"><%=NO%></font><!--<input type=checkbox name="Check<%=j%>" value="<%=j%>" checked onclick="LokeRoomNo('<%=strSection%>','<%=Loft %>','<%=j %>',this);">--></td>
			 <%}
			 }else if (!Lock.contains(String.valueOf(j))){//LockRoomS.indexOf(String.valueOf(j))<0
			 %>
			 <td align="center" class=listtitle width="10%"><font color="#ffffff"><%=NO%></font></td>
			 <%} %>	
			 <%}
			 else  if (!Lock.contains(String.valueOf(j))){
			 
			 %>
			 <td align="center" class=listtitle width="10%"><font color="#ffffff"><%=NO%></font><!--<input type=checkbox name="Check<%=j%>" value="<%=j%>" checked onclick="LokeRoomNo('<%=strSection%>','<%=Loft %>','<%=j %>',this);">--></td>
			 
			 <%}
			 
			 }%>
			 
		 	</tr>
	 <tr>
		
	<%}}
 
	out.print("<tr>");
	int hs=0;
	for(int i=intEndF;i>=intBeginF;i--){
	hs=0;
	
	    if (room_type.indexOf("墅")<0&&room_type.indexOf("车")<0){//别墅不显示楼层
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
		
		    RoomNo=(String)list7.get(index);
			floormess=(String)list8.get(index);
			 	showfloors=(String)list9.get(index); 
			 
		   if(state.equals("0")){
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
		 
		 if (state.equals("0")){ bg="BGCOLOR='"+ws1+"'";}
		 if (state.equals("1")){ bg="bgcolor='"+rg1+"'"; }
		  
		  no=RoomNo;
		  
		 
		  
		if (!tddate.equals(""))tddate=tddate.substring(0,10);
		%>
	 <td align="center" width="1%"  <%=bg %> <%if (dis.equals("1")){ %>title="锁定日期:<%=tddate %>"<%} %>>
	<%if (fsfc.equals("")){ %>
	 <% if (state.equals("0")&&dis.equals("0")){ nosalenum++;%>
	<%=RoomNo%> <input name="chooseroom" type="checkbox" value="<%=l6 %>" onclick="choosesaleroom(this,'<%=RoomNo %>','<%=Loft %>','<%=strSection %>');">
	  <% }else if (state.equals("1")&&dis.equals("1")){  %>
	   <a href="#"> <%=RoomNo%>[锁定] </a>
	  <%}else if (state.equals("1")){rgnum++; %>
       <%=RoomNo%> 
 	 <%} %>
	  
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
		 if (state.equals("0")){ bg="BGCOLOR='#DDE8E8'";}
		 if (state.equals("1")){ bg="bgcolor='#00CCFF'"; }
		 
		
		%>
	  <td align="center" width="10%"  <%=bg %>>
	 <% if (state.equals("0")){nosalenum++; %>
    <%=RoomNo%> <input name="chooseroom" type="checkbox" value="<%=l6 %>">
	 <%}else if (state.equals("2")){rgnum++; %>
       <a href="#<%=RoomNo%>" onclick="opennewwin('ContractInput.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&show=true',720,530,120,2)"><%=RoomNo%></a> 
	 <%}else if (state.equals("1")){salenum++;%>
	 <%=RoomNo%>
	 <%}else if (state.equals("4")){yl++;%>
	<%  if (Cortrol.indexOf("Y")>=0){  %>   <input type=checkbox name=yl value="<%=RoomNo %>"><a href="#<%=RoomNo%>" onclick="choose('<%=RoomNo%>');ylroom();"><%} %><%=RoomNo%><%  if (Cortrol.indexOf("Y")>=0){  %></a><%} %>
	 <%}else if (state.equals("6")){ %>
	  <a href="#<%=RoomNo%>" onclick="opennewwin('ContractList.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&show=false',480,500,150,10)"><%=RoomNo%></a> 
	  <%}else if (state.equals("5")){ ld++;%>
	  <a href="#<%=RoomNo%>" onclick="opennewwin('roomdata1.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&state=5',720,530,120,5)"><%=RoomNo%></a>
	 <%} else if (state.equals("7") ){%>
	 <a href="#<%=RoomNo%>" onclick="opennewwin('show_rent_contract.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&state=5',680,530,120,5)"> <%=RoomNo%></a>
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
  
  function opennewwin(url,para,wh,hg,lf,tp) {
   var newwin=window.open(url+para,"newwin1","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
	
  }
  function printT(){
  pri.innerHTML="";
  print();
  
  }
  function saleFind()
  
  {
   opennewwin("saleFind.jsp?vipno="+document.frm.vipno.value+"&saleroom="+document.frm.saleroom.value,'',300,200,200,200);

  
  }
   function keyFind(){ 
 
      if (event.keyCode==13){
	    return false;
		 
		 }
    
	}
  function choosesaleroom(p1,p2,p3,p4){
    if (p1.checked){
	  if (confirm("确认是认购："+p3+p2+"吗？"))
	 {
	 p1.checked=false;
	 
	 opennewwin("saleRoom.jsp?vipno="+document.frm.vipno.value+"&secno="+p4+"&loft="+p3+"&room="+p2+"&code="+p1.value,'',10,10,10,10);
	  }p1.checked=false;
	  
	
	
	
	}
  
  }
  function opennewwin1(para,wh,hg,lf,tp) {
    
	
	var newwin=window.open("rgList.jsp?"+para,"newwin1","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,width=480,height=500,left=150,top=10");
	
  }
   
  wy<%=aaa %>.innerHTML = "<%=nosalenum %>";
  w1<%=aaa %>.innerHTML = "<%=FormtD.getFloat(Float.parseFloat(String.valueOf(nosalenum))/(ld+nosalenum+yl+salenum+rgnum)*100,2) %>%";
  ry<%=aaa %>.innerHTML = "<%=rgnum %>";
  r1<%=aaa %>.innerHTML = "<%=FormtD.getFloat(Float.parseFloat(String.valueOf(rgnum))/(ld+nosalenum+yl+salenum+rgnum)*100,2) %>%";
 
  // re.innerHTML = "<%=rentnum %>";
  //re1.innerHTML = "<%=FormtD.getFloat(Float.parseFloat(String.valueOf(rentnum))/(ld+nosalenum+yl+salenum+rgnum)*100,2) %>%";

  sum<%=aaa %>.innerHTML = "合计：<%=ld+nosalenum+yl+salenum+rgnum+rentnum %>";
   
  </script>
  </td>
<%//}catch(Exception s){}%>
<%} }%>
</tr></table>
 
</form>  
 
 <%InsertBean.closeConn();
  InsertBean1.closeConn();
 InsertBean2.closeConn();
  %>
</body>
</html>
