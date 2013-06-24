<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%try{ %>
<html>
<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
	<title>编号列表</title>
</head>
<body   oncontextmenu="return false"   >
<script language="javascript" src="../public_js/public.js"></script>
<%@ page language="java" import="java.sql.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="fa" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/asiic.jsp"%> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<%
String strMessage=getbyte2(request.getParameter("mess"));
String SecName=getbyte2(request.getParameter("SecName"));
String Region=getbyte2(request.getParameter("Region"));
String Loft=getbyte2(request.getParameter("Loft"));
if (strMessage==null){strMessage="";}
	 String checRoom="";
 
String strYN=request.getParameter("yn");
String strSection=getbyte2(request.getParameter("Section"));

 

   if (strSection!=null){
	 
 	  if (strSection.indexOf("*")>0){
	    SecName=strSection.substring(strSection.indexOf("*")+1);
		SecName=new String(SecName.getBytes("ISO8859_1"),"GBK");
	   strSection=strSection.substring(0,strSection.indexOf("*"));
		}
	
		if (strMessage.equals("")){
		strSection=new String(strSection.getBytes("ISO8859_1"),"GBK");
		}
	}
    String strBuilding="";//(String)session.getAttribute("sess_build");
    strBuilding=getbyte2(request.getParameter("Building"));
	
   if (strBuilding!=null){
     if (strMessage.equals("")){
	    strBuilding=new String(strBuilding.getBytes("ISO8859_1"),"GBK");
	  } 
	}
	 

String Ecellname=getbyte2(request.getParameter("Ecellname"));
String Scellname=getbyte2(request.getParameter("Scellname"));

String cellname="",Rinfo="";
String sql1="select lockroom from lockroom where section ='"+strSection+"' and ";
sql1+=" loft='"+Loft+"' and build='"+strBuilding+"'";
ResultSet rsLock=null;
String LockRoomS="";
String lock="";
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
 String state="";
 String floormess="";//楼层附加字
 String showfloors="";//显示楼层
int mxinF=0;
if (rs.next()){
  intBeginF=rs.getInt("BeginF");
 // mxinF=intBeginF;
 // if (intBeginF<0)intBeginF=FF;
  intEndF=rs.getInt("EndF");
  intBeginR=rs.getInt("BeginR");
  intEndR=rs.getInt("EndR");

}

 int scell=0,ecell=0;
char  CellN1=Scellname.charAt(0);
char  CellN2=Ecellname.charAt(0);

if (!Scellname.equals("")&&!Ecellname.equals("")){
   CellN1=Scellname.charAt(0);
   CellN2=Ecellname.charAt(0);

if(java.lang.Character.isDigit(CellN1)){
	 scell=java.lang.Integer.parseInt(request.getParameter("Scellname"));
	 ecell=java.lang.Integer.parseInt(request.getParameter("Ecellname"));
}
else{
     scell=Character.getNumericValue(CellN1)-9;
	 ecell=Character.getNumericValue(CellN2)-9;
}
 
}
rs.close();

 String room_type ="";
 int colts=20;
	 String ss="select room_type,ts from LoftBuildCode where SECNO='"+strSection+"' and loft='"+Loft+"'";
	
    ResultSet ssr=InsertBean.executeQuery(ss);
   if (ssr.next()){
    room_type=ssr.getString("room_type");
	colts=ssr.getInt("ts");
   }
   ssr.close();
  
   
   
   
   
%> 
 
<div align="center">
  <p><font color="#0000CC"><b><font size="5" color="#000000"><%if (!SecName.equals(Loft)){out.print(SecName);} %><%=Loft %><%=strBuilding %>编号</font></b></font></p>
<form method="POST" name="cus" action="crm_RoomCodeList2.jsp">
 <input type=hidden name=SecNo value="<%=strSection %>">
    <input type=hidden name=Loft value="<%=Loft %>">
		  <input type=hidden name=Section value="<%=strSection %>">
	  <input type=hidden name=Region value="<%=Loft %>">
    <input type=hidden name=SecName value="<%=SecName %>">
    <input type=hidden name=Build value="<%=strBuilding %>">
	  <input type=hidden name=Ecellname value="<%=Ecellname %>">
	  <input type=hidden name=Scellname value="<%=Scellname %>">
  <table width="75%" border="0">
    
	<tr><td nowrap=6>  <%if (!lock.equals("")){ %>
   <INPUT TYPE=button NAME=loke VALUE="此栋有禁用号(<%=lock %>)，点击可恢复" onclick="openwin1('listLoke.jsp?SecNo=<%=strSection %>&Loft=<%=Loft%>',200,150,100,100);">
   <%} %></td><td align="right">&nbsp;
	<%
 //权限确认
String Cortrol=checke_qx(InsertBean,(String)session.getAttribute("loginid"),"B005");
 
   if (Cortrol==null)Cortrol="";
   
   %><%if (Cortrol.indexOf("A")>=0){ %>
	<input type=button name=addroom value="增加编码" onclick="openwin1('add_new_room_code.jsp?scell=<%=scell %>&Loft=<%=Loft%>&SecNo=<%=strSection%>&Build=<%=strBuilding %>&intEndF=<%=intEndF%>&intEndR=<%=intEndR%>&roomcode='+document.cus.checkroom.value,300,250,100,100);">
	
	<input type=button name=addroom value="导入房间资料" onclick="openwin1('ExcelToRoom.jsp?SecNo=<%=strSection %>&Loft=<%=Loft%>',300,250,100,100);">
	
	<%} %>
	<input type=button name=addroom value="面积统计" onclick="openwin1('datacount.jsp?SecNo=<%=strSection%>',450,350,100,100);">
	
	</td></tr>
  </table>
    <%@ include file="check_room_code.jsp"%>
		<script>
       if (confirm("此栋还没有进行房间编号操作，是否现在进行？")){
        window.location="RoomCodeInput.jsp?<%=locaPara %>";
       }
</script>
		 <%}else{%>
		 
  <%for(int j2=scell;j2<=ecell;j2++){
			if (scell>0){  
			  Rinfo=AsiicZH(j2,CellN1); 
			} %>
  <table width="98%" border="0" CELLSPACING=1 CELLPADDING=3>
  <%  if (room_type.indexOf("墅")<0&&room_type.indexOf("车")<0&&intEndR<=colts){%>
   <tr>
		<td width="100" bgcolor="#999999" align="center"><font color="#FFFFFF"<b><%if (!Rinfo.equals("")) {out.print(Rinfo+"单元");}%>楼层\房间</b></font></td>
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
		     <td align="center" class=listtitle><font color="#ffffff"><%=NO%></font><input type=checkbox name="Check<%=j%>" value="<%=j%>" checked onclick="LokeRoomNo('<%=strSection%>','<%=Loft %>','<%=j %>',this,'<%=strBuilding %>');"></td>
			 <%}
			 }else if (!Lock.contains(String.valueOf(j))){
			 %>
			 <td align="center" class=listtitle><font color="#ffffff"><%=NO%></font><input type=checkbox name="Check<%=j%>" value="<%=j%>" checked onclick="LokeRoomNo('<%=strSection%>','<%=Loft %>','<%=j %>',this,'<%=strBuilding %>');"></td>
			 <%} %>	
			 <%}else if (!Lock.contains(String.valueOf(j))){%>
			 <td align="center" class=listtitle><font color="#ffffff"><%=NO%></font><input type=checkbox name="Check<%=j%>" value="<%=j%>" checked onclick="LokeRoomNo('<%=strSection%>','<%=Loft %>','<%=j %>',this,'<%=strBuilding %>');"></td>
			 
			 <%}
			 
			 }%> <td align="center" width="50" class=listtitle><font color="#ffffff">面积</td>	
	</tr>
	<%}
	
    List list1=new LinkedList();//存放房间编码
	List list2=new LinkedList();//存放房间状态
	List list3=new LinkedList();//存放所在FLoor
    List list4=new LinkedList();//存放房号
	List list5=new LinkedList();//存放房号
    List list6=new LinkedList();//存放楼层类别
    List list7=new LinkedList();//存放楼层附加字
	List list8=new LinkedList();//存放显示楼层标致
	List list9=new LinkedList();//存放显示楼层建筑面积
	List list10=new LinkedList();//存放显示已有资料的房号
	String  sqlR="select RoomNo,state,Floor,room,floortype,floorshow,floormess,ShowFloors from RoomNo where SectionNo=";
			sqlR=sqlR+"'"+strSection+"' and Building='";
			sqlR=sqlR+strBuilding+"' and  cell='"+Rinfo+"' and  Region='"+Loft+"' and floortype=0   order by roomno";
		   ResultSet rsArr=InsertBean1.executeQuery(sqlR);
		   int aryi=0;
            String Rinfo1=Rinfo;
         //  if (!Rinfo1.equals(""))Rinfo1=Rinfo1+"-";
		   while (rsArr.next()){

		     list5.add(getbyte(rsArr.getString("RoomNo")));
			 checRoom=(String)list5.get(aryi); 
			list2.add(rsArr.getString("state"));
			 String FloorS=rsArr.getString("Floor");
			 String RoomS=rsArr.getString("Room");
			 list6.add(rsArr.getString("floortype"));
			 list7.add(getbyte(rsArr.getString("floormess")));
			 list8.add(getbyte(rsArr.getString("ShowFloors")));
			
			list3.add(FloorS);
			list4.add(RoomS);
		   //  if (FloorS.indexOf("-")>=0||FloorS.equals("0"))FloorS="";
			if (Integer.parseInt(RoomS)>=10){
			 list1.add(Rinfo1+FloorS+RoomS);
			 
			}else{
			  list1.add(Rinfo1+FloorS+"0"+RoomS);
			 //  out.print(Rinfo+FloorS+"0"+RoomS);
			  }
			  // out.print(Rinfo1+FloorS+RoomS);
		    aryi+=1;
			 
		   } 
	      rsArr.close();
		   sqlR="select room_code,gl_area+area area  from Room where seccode=";
			sqlR=sqlR+"'"+strSection+"' and Building='";
			sqlR=sqlR+strBuilding+"'  and  cell='"+Rinfo+"' and  loft='"+Loft+"' and floortype=0  order by Floor,room";
		    rsArr=InsertBean1.executeQuery(sqlR);
			 while (rsArr.next()){
		     list9.add(getbyte(rsArr.getString("area")));
			 list10.add(getbyte(rsArr.getString("room_code")));
			 
			 }  
			  rsArr.close();
		 int arrlen=0;
		 double floors_area=0;
	     int hs=0;
		 out.print("<tr>");
	 %>
	
	<%for(int i=intBeginF;i<=intEndF;i++){
	 String ro="";
	floors_area=0;
	// if (i>0)ro=String.valueOf(java.lang.Math.abs(i));
	 hs=0;
	 ro=String.valueOf(i);
	if (hs==0)out.print("<tr>");
	  if (room_type.indexOf("墅")<0&&room_type.indexOf("车")<0){
	%><td align="center" class=FloorC width="1%"><font color="#ffffff"><div id=A<%=String.valueOf(java.lang.Math.abs(i))+1 %>w1><%=i%></div></font></td>
		<%  }else{ %> 
		<div style='display:none' id=A<%=String.valueOf(java.lang.Math.abs(i))+1 %>w1><%=i%></div>
		
 
     	<%}
		 
		for(int j=intBeginR;j<=intEndR;j++){
		 if (hs==colts){hs=0;out.print("</tr><tr>"); 
	     if (room_type.indexOf("墅")<0&&room_type.indexOf("车")<0){//别墅不显示楼层
	%><td align="center" class=FloorC width="1%"><font color="#ffffff"><div id=A<%=String.valueOf(java.lang.Math.abs(i))+1 %>w1><%=i%></div></font></td>
		<%  }else{ %> 
		<div style='display:none' id=A<%=String.valueOf(java.lang.Math.abs(i))+1 %>w1><%=i%></div>
		
 
     	<%}
	 }
        Rinfo1=Rinfo;
     //  if (!Rinfo1.equals(""))Rinfo1=Rinfo1+"-";
		String RoomNo="";
		String  floortype="";
		
           if (j>=10)
		   
		    RoomNo=Rinfo1+ro+String.valueOf(j);
		   else
		    RoomNo=Rinfo1+ro+"0"+String.valueOf(j);
  
		 if (list1.contains(RoomNo)){
		   int index=list1.indexOf(RoomNo);
		   state=(String)list2.get(index);
		   RoomNo=(String)list5.get(index);
		 
		   floortype=(String)list6.get(index);
	       floormess=(String)list7.get(index);
		   showfloors=(String)list8.get(index);
		 }else{state="";}  
	 //  if (LockRoomS.indexOf(String.valueOf(j))<0){
	   if (!Lock.contains(String.valueOf(j))){
	     hs++;
		if (state.equals("0"))
		{%>
		<td align="center" class=roomright><a href="#" onclick="javascript:openwin1('crm_RoomInput.jsp?loft=<%=Loft %>&seccode=<%=strSection%>&building=<%=strBuilding%>&Floor=<%=i%>&Room=<%=j %>&Room_code=<%=RoomNo%>&MaxFloor=<%=intEndF%>&BengR=<%=intBeginR %>&EndR=<%=intEndR %>&RoomNoType=<%=RoomNo %>&floortype=<%=floortype %>&floormess=<%=floormess %>&cell=<%=Rinfo %>',510,500,150,10);" ><%=RoomNo%></a><%if (Cortrol.indexOf("D")>=0){  %><input type=checkbox name="Check<%=RoomNo%>" value="<%=RoomNo%>" checked onclick="clearRoomNo('<%=strSection%>','<%=Loft %>','<%=RoomNo %>',this,'<%=strBuilding %>');"><%} %></td>
		<%
		}else 	if (state.equals("1")){
		%>
        <td  align="center" class=roomright><a href="#" onclick="javascript:openwin1('crm_RoomEdit.jsp?loft=<%=Loft %>&seccode=<%=strSection%>&building=<%=strBuilding%>&Floor=<%=i%>&Room=<%=j %>&Room_code=<%=RoomNo%>&MaxFloor=<%=intEndF%>&BengR=<%=intBeginR %>&EndR=<%=intEndR %>&RoomNoType=<%=RoomNo %>&floortype=<%=floortype %>&floormess=<%=floormess %>&cell=<%=Rinfo %>',510,500,150,10);" title="已输入"><font color=red><%=RoomNo%></FONT></a><%if (Cortrol.indexOf("D")>=0){  %><input type=checkbox name="Check<%=RoomNo%>" value="<%=RoomNo%>" checked onclick="clearRoomNo('<%=strSection%>','<%=Loft %>','<%=RoomNo %>',this,'<%=strBuilding %>');"><%} %></td> 
		<%
		}else {out.print("<td align='center' class=roomright></td>");}
		}
		if (list10.contains(RoomNo)){ 
		   int index1=list10.indexOf(RoomNo);
		 		   floors_area+=Double.parseDouble((String)list9.get(index1));
		
		}
	  }
	    if (room_type.indexOf("墅")<0&&room_type.indexOf("车")<0){
	  %><td width="50"><%=fa.getFloat2(floors_area,2) %></td>
	  <script>//w1<%=String.valueOf(java.lang.Math.abs(i)) %>.innerHTML="<% if (!floormess.equals("")&&!showfloors.equals("")) out.print(String.valueOf(i)+floormess);else if (!floormess.equals("")&&showfloors.equals(""))  out.print(floormess);else  out.print(i);%>";</script>
	  <%} %>
	</tr>
	<% }%>
	
	
	<%for(int i=mxinF;i<=-1;i++){
	 floors_area=0;
	 
	%>
	<tr>
		<td align="center" class=FloorC><font color="#ffffff"><div id=A<%=String.valueOf(java.lang.Math.abs(i)) %>w1><%=i%></div</font></td>
		<%for(int j=intBeginR;j<=intEndR;j++){
      
		String RoomNo="";
		String  floortype="";
           if (j>=10)
		    RoomNo=Rinfo1+String.valueOf(j);
		   else
		    RoomNo=Rinfo1+ "0"+String.valueOf(j);
			
		 if (list1.contains(RoomNo)){
		   int index=list1.indexOf(RoomNo);
		   state=(String)list2.get(index);
		   RoomNo=(String)list5.get(index);
		   floortype=(String)list6.get(index);
	       floormess=(String)list7.get(index);
		    showfloors=(String)list8.get(index);
		 }else{state="";}  
		 
       if (!Lock.contains(String.valueOf(j))){
		if (state.equals("0"))
		{%>
		<td align="center" class=roomright><a href="#" onclick="javascript:openwin1('crm_RoomInput.jsp?loft=<%=Loft %>&seccode=<%=strSection%>&building=<%=strBuilding%>&Floor=<%=i%>&Room=<%=j %>&Room_code=<%=RoomNo%>&MaxFloor=<%=intEndF%>&BengR=<%=intBeginR %>&EndR=<%=intEndR %>&RoomNoType=<%=RoomNo %>&floortype=<%=floortype %>&floormess=<%=floormess %>&cell=<%=Rinfo %>',510,500,150,10);" ><%=RoomNo%></a><%if (Cortrol.indexOf("D")>=0){  %><input type=checkbox name="Check<%=RoomNo%>" value="<%=RoomNo%>" checked onclick="clearRoomNo('<%=strSection%>','<%=Loft %>','<%=RoomNo %>',this);"><%} %></td>
		<%
		}else 	if (state.equals("1")){
		%>
        <td  align="center" class=roomright><a href="#" onclick="javascript:openwin1('crm_RoomEdit.jsp?loft=<%=Loft %>&seccode=<%=strSection%>&building=<%=strBuilding%>&Floor=<%=i%>&Room=<%=j %>&Room_code=<%=RoomNo%>&MaxFloor=<%=intEndF%>&BengR=<%=intBeginR %>&EndR=<%=intEndR %>&RoomNoType=<%=RoomNo %>&floortype=<%=floortype %>&floormess=<%=floormess %>&cell=<%=Rinfo %>',510,500,150,10);" title="已输入"><font color=red><%=RoomNo%></FONT></a><%if (Cortrol.indexOf("D")>=0){  %><input type=checkbox name="Check<%=RoomNo%>" value="<%=RoomNo%>" checked onclick="clearRoomNo('<%=strSection%>','<%=Loft %>','<%=RoomNo %>',this);"><%} %></td> 
		<%
		}else {out.print("<td align='center' class=roomright></td>");}
		}
		if (list10.contains(RoomNo)){ 
		   int index1=list10.indexOf(RoomNo);
		 		   floors_area+=Double.parseDouble((String)list9.get(index1));
		
		}
	  }%>
	  <td width="50"><%=fa.getFloat2(floors_area,2) %></td>
	    <script>A<%=String.valueOf(java.lang.Math.abs(i)) %>w1.innerHTML="<% if (!floormess.equals("")&&!showfloors.equals("")) out.print(String.valueOf(i)+floormess);else if (!floormess.equals("")&&showfloors.equals(""))  out.print(floormess);else  out.print(i);%>";</script>
	
	</tr>
	<% }%>
	
  </table>
  <%} 
  }

  %>
   <input type=hidden name=checkroom value="<%=checRoom %>">
</form>  
</div>
 <script language="javascript" src="cancel_room_code.js"></script>
 <% 
 
 InsertBean.closeConn();
  InsertBean1.closeConn();
  }catch(Exception s)  {} %>
  
</body>
</html>
                  