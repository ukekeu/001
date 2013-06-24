<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>

 
<html>
<head>
	<title>房间编号列表</title>
</head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="javascript" src="../public_js/public.js">
</script>

<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
<jsp:useBean id="formtD" scope="page" class="FormatData.FormatData" />
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/asiic.jsp"%>
<%

String strMessage=China.getParameter(request,"mess");
String SecName=request.getParameter("SecName");
String Region=China.getParameter(request,"Region");
String condi=China.getParameter(request,"condi");

String RegionStr="";
  if (Region.indexOf("*")>0){
	    RegionStr=Region.substring(Region.indexOf("*")+1);
	   Region=Region.substring(0,Region.indexOf("*"));
		}
String state="";
String fontColor="";
String strYN=request.getParameter("yn");
String strSection="";


String Loft="";
String strBuilding="";

  SecName=China.getParameter(request,"SecName");
  
  strSection=China.getParameter(request,"SecNo");
  String SecNo=strSection; try{strSection=strSection.substring(0,strSection.indexOf("*"));}catch(Exception s){}
  Loft=China.getParameter(request,"Loft");	
  strBuilding=China.getParameter(request,"Building");

if (strBuilding==null) strBuilding="";

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
String  sql="select floor from";
		sql=sql+" RoomNo where SectionNo='"+strSection+"'";
		sql=sql+"  and Region='"+Loft+"' and floor=0";
		if (!strBuilding.equals("")) 
       sql+="  and building='"+strBuilding+"'";
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
%> 
<div align="center">
  <p><font color="#0000CC"><b><font size="5" color="#000000">
  <%=SecName %> <%=Loft %> <%=strBuilding %>销控情况表</font></b></font></p>
<form method="POST" name="form1" action="RoomInsert.jsp">
<form name=form1 method="post" action="">
<input type=hidden name=SecNo value="<%=strSection%>">
<input type=hidden name=SecName value="<%=SecName%>">
<input type=hidden name=Loft value="<%=Loft %>">
<input type=hidden name=Building value="<%=strBuilding %>">
<input type=hidden name=choose>
<input type=hidden name=Floor>
<input type=hidden name=RoomType>
<input type=hidden name=UnitPrice>
<input type=hidden name=area>
<input type=hidden name=RoomCode>
<input type=hidden name=tj1>

	
    <input type=hidden name=choose>
  

  <%
		String locaPara="Loft="+Loft+"&Build="+strBuilding+"&SecNo="+strSection+"&SecName="+SecName;
		String upp="ABCDEFGHIJKLOPQRST";
		upp=upp.trim();
		int nn=0;
        String RoomNoUp="";
		String  sqlU="select top 1 RoomNo,state from RoomNo where SectionNo=";
				sqlU=sqlU+"'"+strSection+"' and Building='";
				sqlU=sqlU+strBuilding+"' and Region='"+Loft+"'";//out.print(sqlU);
		ResultSet rsU=InsertBean1.executeQuery(sqlU);
        if (rsU.next())RoomNoUp=rsU.getString("RoomNo");
		rsU.close();
        if (RoomNoUp.equals("")){
		%>
		<script>
       alert("此栋还没有进行房间编号操作");
        //window.location="../basic/RoomCodeInput.jsp?<%=locaPara %>";
  
</script>
		 <%}else{%>
   <%for(int j2=scell;j2<=ecell;j2++){
			if (scell>0){  
			  Rinfo=AsiicZH(j2,CellN1); 
			} %>
  <table width="90%" border="0" CELLSPACING=1 CELLPADDING=3>
   <tr>
		<td width="10%" bgcolor="#489A80" align="center"><font color="#FFFFFF"<b><%if (!Rinfo.equals("")) {out.print(Rinfo+"单元");}%>楼层\房号</b></font></td>
		 
	<%
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
		     <td align="center" width="10%"  class=listtitle  width="20%"><font color="#ffffff"><%=NO%></font></td>
			 <%}
			 }else if (!Lock.contains(String.valueOf(j))){
			 %>
			 <td align="center" width="10%"  class=listtitle  width="20%"><font color="#ffffff"><%=NO%></font> </td>
			 <%} %>	
			 <%}else{%>
			 <td align="center" width="10%"  class=listtitle  width="20%"><font color="#ffffff"><%=NO%></font> </td>
			 
			 <%}
			 
			 }%>  <td width="10%"  align="center" class=listtitle><font color="#ffffff">楼层均价</font></td>	
	</tr>
	<%
	
    List list1=new LinkedList();//存放房间编码
	List list2=new LinkedList();//存放房间状态
	List list3=new LinkedList();//存放所在FLoor
    List list4=new LinkedList();//存放房号
	List list6=new LinkedList();//存放选房计价
	List list7=new LinkedList();//存放楼层]
	List list8=new LinkedList();//存放楼层附加字
 
	String floormess="";//楼层附加字
	String Floor="";
	String  sqlR="select RoomNo.RoomNo,Room.type state,RoomNo.Floor,RoomNo.room,Room.floormess from RoomNo,room where ";
	 sqlR+="room.seccode=roomno.sectionno and room.loft=roomno.region and  ";
	 sqlR+="room.room_code=roomno.roomno and RoomNo.SectionNo=";
			sqlR=sqlR+"'"+strSection+"' and RoomNo.Building='";
			sqlR=sqlR+strBuilding+"' and  room.cell='"+Rinfo+"'  and  RoomNo.Region='"+Loft+"' and room.type=1";;
		   ResultSet rsArr=InsertBean1.executeQuery(sqlR);
		   int aryi=0;
		   
		   while (rsArr.next()){
		    list6.add(rsArr.getString("RoomNo"));
			list2.add(rsArr.getString("state"));

			 String FloorS=rsArr.getString("Floor");
			list7.add(FloorS);

			 String RoomS=rsArr.getString("Room");
			if (Integer.parseInt(RoomS)>=10)
			 list1.add(Rinfo+FloorS+RoomS);
			else
			  list1.add(Rinfo+FloorS+"0"+RoomS);
			  list8.add(getbyte(rsArr.getString("floormess")));
		    aryi+=1;
		   } 
	      rsArr.close();
		int arrlen=0;
	 %>
	<%String StrUpper="ABCDEFGHIJKLOPQ"; %> 
	<%for(int i=intBeginF;i<=intEndF;i++){//if (FF==i &&FF==0) {FF=1;  continue;}%>
	<tr>
		<td align="center" width="10%"  class=FloorC><font color="#ffffff"><div id=A<%=i+1 %>w1><%=i%></div></font></td>
		<%for(int j=intBeginR;j<=intEndR;j++){
       	String RoomNo="";
		String no="";
		
		   if (j>=10)
		    RoomNo=Rinfo+String.valueOf(i)+String.valueOf(j);
		   else
		    RoomNo=Rinfo+String.valueOf(i)+"0"+String.valueOf(j);
		
	
		arrlen+=1;
      
		if (list1.contains(RoomNo)){
		   int index=list1.indexOf(RoomNo);
		   state=(String)list2.get(index);
		   RoomNo=(String)list6.get(index);
   	       Floor=(String)list7.get(index);
		   floormess=(String)list8.get(index);
		 }else{state="";RoomNo="";}  
		 
   if (LockRoomS.trim().indexOf(String.valueOf(j))<0){
		if (!state.equals("1"))
		
		{%>
		<td  width="10%" id="TR<%=i %><%=j %>" align="center" class=roomright onclick="changeclass1(this,'clickbg','listcontent');savepara('<%=strSection%>','<%=Loft%>','<%=RoomNo%>','<%=Floor %>','<%=strBuilding %>');"><a href="#" ><%=RoomNo.substring(RoomNo.indexOf("-")+1)%></td>
		<%		
		}else{out.print("<td align='center'   BGCOLOR='#DDE8E8'  id='TR"+String.valueOf(i)+String.valueOf(j)+"' >"+RoomNo.substring(RoomNo.indexOf("-")+1)+"<img src='../images/mypw.gif' border='0' title='已认购房号'></td>");}
    	RoomNo="";
		}
		
		}
		
		%>
		 <script>A<%=i+1 %>w1.innerHTML="<% if (!floormess.equals("")) out.print(floormess);else out.print(i);%>";</script>
	
	</tr>
	<% }%>
  </table>
  <%} %>
  <%} %>
</form>  
  <script>
  var secno="";
   var secname="";
   var roomno="";
   var build="";
   var unitprice="";
   var sumprice="";
   var area="";
   var roomtype="";
   var fitment="";
   var jzarea="";
   var tnunitprice="";
   var loft="";
   var cx="";
   var code="";	
    var Floor="";	
  function opennewwin(url,para,wh,hg,lf,tp) {
    var mess="是否认购登录还是查看房间资料？(如果是认购请单击‘确认’)";
	 var newwin=window.open(url+para,"newwin1","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
	
  }
  function opennewwin1(para,wh,hg,lf,tp) {
    
	
	var newwin=window.open("rgList.jsp?"+para,"newwin1","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,width=480,height=500,left=150,top=10");
	
  }

   function savepara(para1,para2,para3,para4,para5){
			  secno=para1;
			  loft=para2;
		      Floor=para4;
			  roomno=para3;
			  build=para5;
			  }
			  
	function view(){
	       if (secno==""){alert("请选择房间(只需单击列表中某行)");}
		   else{openwin1("../basic/showroomdate.jsp?secno="+secno+"&roomno="+roomno+"&build="+build+"&floor="+Floor+"&show=true&loft="+loft,400,450,100,10); }
	}
	function fx(){
	      openwin1("KFfx.jsp?secno=<%=strSection %>",600,450,100,10);  
	}
	
	function reco(){
	       if (secno==""){alert("请选择房间(只需单击列表中某行)");}
		   else{openwin1("ld_sale.jsp?secno="+secno+"&roomno="+roomno+"&build="+build+"&floor="+Floor+"&show=true&loft="+loft,690,450,100,10); }
	}
 function Changes(){
      if (secno==""){alert("请选择房间(只需单击列表中某行一次)");}
	    else{window.location="../sys/ChangesList.jsp?sumprice="+sumprice;}
	 } 
  function LDROOM(){

      if (secno==""){alert("请选择房间");}
	    else{openwin1("../sale/TemporarilyBuy1.jsp?secno="+secno+"&secname="+secname+"&roomno="+roomno+"&build="+build+"&loft="+loft+"&jzarea="+jzarea+"&code="+code,550,400,100,10);}
	 } 
 function AJ(){
       if (secno==""){alert("请选择房间");}
		    else{openwin1("../public_js/calculator1.jsp?secno="+secno+"&secname="+secname+"&roomno="+roomno+"&build="+build+"&loft="+loft+"&sumprice="+sumprice+"&area="+area,500,400,100,10);}
	 } 	 
function Plan(){
      if (secno==""){alert("请选择房间");}
	    else{window.location="../sale/BuyPlanBook.jsp?secno="+secno+"&secname="+secname+"&roomno="+roomno+"&build="+build+"&loft="+loft+"&unitprice="+unitprice+"&sumprice="+sumprice+"&area="+area+"&roomtype="+roomtype+"&area="+area+"&jzarea="+jzarea+"&tnunitprice="+tnunitprice;}
	 } 
function ChooseRoom(){
      if (secno==""){alert("请选择房间");}
	    else{openwin1("../sale/ChooseRoomCount.jsp?secno="+secno+"&secname="+secname+"&roomno="+roomno+"&build="+build+"&loft="+loft,450,300,200,100);}
	 } 	 
	 
function openRoom() 
{
    var spa = 60 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa / 2 ;
    var lef = spa / 2 ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=" + hei ;
    var posi = posi + ",width=" + wid ;
    
    var newwin=window.open( "room_view.jsp?secno=" + secno + "&roomno=" + roomno + "&build=" + build ,"NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
    newwin.focus();
}	 
 
</script>

</div>
</body>
</html>
 