<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<head>
	<title>房间编号列表</title>
</head>
<body >
<script language="javascript" src="../public_js/public.js"></script>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/asiic.jsp"%>
<%
String strMessage=request.getParameter("mess");
String notbg=request.getParameter("notbg");
String SecName="";
String SecNo="";
String Loft="";
String strBuilding="";//(String)session.getAttribute("sess_build");

if (notbg==null){
 SecName=China.getParameter(request,"SecName");
 SecNo=China.getParameter(request,"SecNo");
 Loft=China.getParameter(request,"Loft");
 strBuilding=China.getParameter(request,"Build");
}else{
 SecName=request.getParameter("SecName");
 SecNo=request.getParameter("SecNo");
 Loft=request.getParameter("Loft");
 strBuilding=request.getParameter("Build");
}
if (strMessage==null){strMessage="";}

String strYN=request.getParameter("yn");
String strSection=China.getParameter(request,"SecNo");


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
String type  ="";
String state="";
if (rs.next()){
  intBeginF=rs.getInt("BeginF");
  mxinF=intBeginF;
  // if (intBeginF<0)intBeginF=FF;
  intEndF=rs.getInt("EndF");
  intBeginR=rs.getInt("BeginR");
  intEndR=rs.getInt("EndR");
   Ecellname=getbyte(rs.getString("Ecell"));
  Scellname=getbyte(rs.getString("Scell"));
  if (Scellname.equals("")){ Scellname=" ";}
  if (Ecellname.equals("")){ Ecellname=" ";}
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
	 String ss="select room_type,ts from LoftBuildCode where SECNO='"+strSection+"'";
   ResultSet ssr=InsertBean1.executeQuery(ss);
   if (ssr.next()){
    room_type=ssr.getString("room_type");
	colts=ssr.getInt("ts");
   } 
%> 
<% String sel=(String)request.getParameter("sel");
   if(sel==null) sel="0"; %>
   
   <form name=frm action="RoomSelect.jsp">
  <input type=hidden name="sel" value="<%=sel %>">
   <table width="180" border="0" cellspacing="0" cellpadding="0" class="L2">
   <tr>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=0;findSub('RoomSelect.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>虚拟销控</font> </a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('PriceProjectList_xy.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>虚拟价格</font></a>
	</td>	 
	</tr></table>
	<script>
function findSub(para){
alert("s");document.frm.submit();
}
</script>
<div align="center">
  <p><font color="#0000CC"><b><font size="5" color="#000000"> <%=SecName %>  <%=Loft %>虚拟销控 </font></b></font></p>
 
    <input type=hidden name=SecNo value="<%=SecNo %>">
    <input type=hidden name=Loft value="<%=Loft %>">
    <input type=hidden name=SecName value="<%=SecName %>">
    <input type=hidden name=Build value="<%=strBuilding %>">
	<input type=hidden name="Search">
	<input type=hidden name="Find">
	
    <input type=hidden name=choose>
  <table width="85%" border="0" align="center" CELLSPACING=0 CELLPADDING=0 >
    
	<tr >
	 <td >禁用:<%if (lock.equals("")){out.print("无");}else{out.print(lock);} %></td><td colspan="5">&nbsp;&nbsp;<input type="Button" name="choose" onclick="ylroom();return false;" value="放盘选择单位">&nbsp;&nbsp;
	 <input type="Button" name="sel2" onclick="javascript: window.open('PaymentSelect.jsp?SecNo='+document.frm.SecNo.value,'roomfrm','height=250,width=480,left=150,top=50,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no');" value="推荐付款方式">&nbsp;&nbsp;<input type="Button" name="se2" onclick="chooseallroom();return false;" value="放盘所有单位">&nbsp;&nbsp;<input type="Button" name="se2" onclick="cancelroom();return false;" value="取消放盘单位">
	 </td>
	</tr>
  </table>
  <%
		String locaPara="Loft="+Loft+"&Build="+strBuilding+"&SecNo="+strSection+"&SecName="+SecName;
		String upp="ABCDEFGHIJKLOPQRST";
		upp=upp.trim();
		int nn=0;
        String RoomNoUp="";
		String  sqlU="select top 1 RoomNo,state from RoomNo where SectionNo=";
				sqlU=sqlU+"'"+strSection+"' and Building='";
				sqlU=sqlU+strBuilding+"' and Region='"+Loft+"'";
		ResultSet rsU=InsertBean1.executeQuery(sqlU);
        if (rsU.next())RoomNoUp=rsU.getString("RoomNo");
		rsU.close();
        if (RoomNoUp.equals("")){
		%>
		<script>
       if (confirm("此栋还没有进行房间编号操作，是否现在进行？")){
        window.location="RoomCodeInput.jsp?<%=locaPara %>";
       }
</script>
		 <%}else{%>
<table width="99%" border="0" CELLSPACING=1 CELLPADDING=1>
   <tr> 		 
  <%for(int j2=scell;j2<=ecell;j2++){
			if (scell>0){  
			  Rinfo=AsiicZH(j2,CellN1); 
			} 
			  
			%>
 
	<td width="1%"   align="center"><b><%if (!Rinfo.equals("")) {out.print(Rinfo+"单元");}%>楼层\房号</b> 
		
		<table width="99%" border="0" CELLSPACING=1 CELLPADDING=1>
             <% if (room_type.indexOf("墅")<0&&room_type.indexOf("车")<0){%>
	       <tr>
	         <td  width="1%" bgcolor="#800000" align="center"><img src="../images/1.gif" border="0"></td>
			
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
		     <td align="center" class=listtitle width="10%"><font color="#ffffff"><%=NO%> <input type=checkbox name="Check<%//=RoomNo%>" value="<%//=RoomNo%>" onclick="chooseRoom('<%=NO %>',this.checked)"> </font></td>
			 <%}
			 }else if (!Lock.contains(String.valueOf(j))){
			 %>
			 <td align="center" class=listtitle width="10%"><font color="#ffffff"><%=NO%> <input type=checkbox name="Check<%//=RoomNo%>" value="<%//=RoomNo%>" onclick="chooseRoom('<%=NO %>',this.checked)"> </font> </td>
			 <%} %>	
			 <%}else if (!Lock.contains(String.valueOf(j))){%>
			 <td align="center" class=listtitle width="10%"><font color="#ffffff"><%=NO%> <input type=checkbox name="Check<%//=RoomNo%>" value="<%//=RoomNo%>" onclick="chooseRoom('<%=NO %>',this.checked)"> </font> </td>
			 
			 <%}
			 
			 }%>

	    </tr>
		<%} %>
		<tr>
		<%
		List list1=new LinkedList();//存放房间编码
		List list2=new LinkedList();//存放房间状态
		List list3=new LinkedList();//存放所在FLoor
	    List list4=new LinkedList();//存放房号
		List list5=new LinkedList();//存放选房计价
		List list6=new LinkedList();//存放选房计价
		List list7=new LinkedList();//存放楼层附加字
		String floormess="";//楼层附加字
		String  sqlR="select RoomNo.RoomNo,Room.salestate state,RoomNo.Floor,RoomNo.room,Room.type,Room.floormess from RoomNo, room where ";
		 sqlR+="room.seccode=roomno.sectionno and room.loft=roomno.region and  ";
		 sqlR+="room.room_code=roomno.roomno and Room.seccode=";
			sqlR=sqlR+"'"+strSection+"' and Room.Building='";
			sqlR=sqlR+strBuilding+"' and  Room.cell='"+Rinfo+"'  and  Room.loft='"+Loft+"'";
	 
		   ResultSet rsArr=InsertBean1.executeQuery(sqlR);
		   int aryi=0;
		    String Rinfo1=Rinfo;
          // if (!Rinfo1.equals(""))Rinfo1=Rinfo1+"-";
		   while (rsArr.next()){
		    list6.add(getbyte(rsArr.getString("RoomNo")));
			list2.add(rsArr.getString("state"));
			 String FloorS=rsArr.getString("Floor");
			 String RoomS=rsArr.getString("Room");
			list3.add(FloorS);
			list4.add(RoomS);
			if (FloorS.indexOf("-")>=0||FloorS.equals("0"))FloorS="";
			if (Integer.parseInt(RoomS)>=10)
			 list1.add(Rinfo+FloorS+RoomS);
			else
			  list1.add(Rinfo+FloorS+"0"+RoomS);
			  list5.add(rsArr.getString("type"));
			  list7.add(getbyte(rsArr.getString("floormess")));
		      aryi+=1;
		   } 
	      rsArr.close();
		 
		  int arrlen=0;
	      int hs=0;
	    %>
	  <%String StrUpper="ABCDEFGHIJKLOPQ"; %> 
	   <%for(int i=intBeginF;i<=intEndF;i++){	
			       hs=0;
			       String ro="";
			        if (room_type.indexOf("墅")<0&&room_type.indexOf("车")<0){
			      %><td align="center" class=FloorC width="1%"><div id=A<%=String.valueOf(java.lang.Math.abs(i))+1 %>w1><%=i%></div></td>
				   <%  } 
				  String customer="";
				  String contractno="";
				  String loft="";
				  for(int j=intBeginR;j<=intEndR;j++){
				  if (hs==colts){hs=0;out.print("</tr><tr>"); 
			      if (room_type.indexOf("墅")<0&&room_type.indexOf("车")<0){//别墅不显示楼层
			    %><td align="center" class=FloorC width="1%"><div id=A<%=String.valueOf(java.lang.Math.abs(i))+1 %>w1><%=i%></div></td>
				 <%  } 
			     }
			 	if (!Lock.contains(String.valueOf(j))){
				   Rinfo1=Rinfo;
		            hs++;
		          
				 
				   String RoomNo="";
				   String no="";
				   String floors="";
				   if (j>=10)
				      RoomNo=Rinfo+String.valueOf(i)+String.valueOf(j);
				   else
				    RoomNo=Rinfo+String.valueOf(i)+"0"+String.valueOf(j);
			    	arrlen+=1;
					
		          type="0";
				 if (list1.contains(RoomNo)){
				   int index=list1.indexOf(RoomNo);
				   state=(String)list2.get(index);
				   floors=(String)list3.get(index);
				   type=(String)list5.get(index);
				   RoomNo=(String)list6.get(index);
				 
				   floormess=(String)list7.get(index);
				 }else{state="";}
			   out.print("<td align='center' class=roomright>");
				 if (state.equals("1")){
				%>		
				 <input type=checkbox name=yl value="<%=RoomNo %>" <%if(type.equals("1")){out.print("checked");} %>><a href="#" onclick="javascript:openwin('../basic/showroomdate.jsp?floor=<%=floors %>&loft=<%=Loft %>&secno=<%=strSection%>&build=<%=strBuilding%>&floor=<%=i%>&show=true&roomno=<%=RoomNo%>&MaxFloor=<%=intEndF%>&BengR=<%=intBeginR %>&EndR=<%=intEndR %>&RoomNoType=<%=RoomNo %>&currNo=<%=j %>',400,500,150,10);" title="已输入,单击可查看房间资料"><font  color=red><%=RoomNo%></FONT>
				<%}%>
		  <%out.print("</td>");  
		  }
	} %>
   </tr>
	<% }  
	 %>
  </table>
		
		
		
 
  </td>
  <%}   %>
 
  </tr></table>
  <% }%>
  <script>
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
    if (rooms==""){alert("请选择计价的房间！");return false;}
    var url="SaveRoomYL.jsp?rooms="+rooms+"&loft=<%=Loft %>&build=<%=strBuilding %>&secno=<%=strSection %>&secname=<%=SecName %>";
    var newWin = window.open(url,"roomfrm","height=250,width=410,left=150,top=50,resizable=yes,scrollbars=no,toolbar=no,location=no,directories=no,status=no,menubar=no");
    newWin.focus() ;
}
function cancelroom(){
 openwin("CancelChoose.jsp?loft=<%=Loft %>&build=<%=strBuilding %>&secno=<%=strSection %>",10,10,10,10);

}
function chooseallroom(){

 openwin("ChooseAllRoom.jsp?loft=<%=Loft %>&build=<%=strBuilding %>&secno=<%=strSection %>",10,10,10,10);
}
function chooseRoom(dd,para){
 
   for (var i=0;i<document.frm.yl.length;i++){
     var ddd=document.frm.yl[i].value;
	 ddd=ddd.substring(ddd.length-dd.length);
	
   if (para){
   if(!document.frm.yl[i].checked&&ddd==dd)document.frm.yl[i].checked=true;
  
  }else if(ddd==dd){
  document.frm.yl[i].checked=false;
  }
  }

}
function chhoseFloor(dd,para){

for (var i=0;i<document.frm.yl.length;i++){
     var ddd=document.frm.yl[i].value;
	 ddd=ddd.substring(0,dd.length);
   if (para){
if(!document.frm.yl[i].checked&&ddd==dd)document.frm.yl[i].checked=true;
  
  }else if(ddd==dd){
  document.frm.yl[i].checked=false;
  }
  }

}
  </script>
</form>  


</div>
</body>
</html>
