<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 <html>

<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<head>
	<title> 编号列表</title>
	<META http-equiv="Page-Enter" content="revealTrans(Transition=23,Duration=300.000)">
</head>
<body topmargin="1" oncontextmenu="return false"  >
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="fa" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/asiic.jsp"%> 
 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<%
  try{ 

%>

<script language="javascript" src="../public_js/public.js">
</script> 
<form name=cus method="post" action="crm_RoomCodeList1.jsp">
 <input type=hidden name=SecNo value="<%=China.getParameter(request,"SecNo") %>">
    <input type=hidden name=Loft value="<%=China.getParameter(request,"Loft") %>">
    <input type=hidden name=SecName value="<%=China.getParameter(request,"SecName") %>">
    <input type=hidden name=Build value="<%=China.getParameter(request,"Build") %>">
	<input type=hidden name="Search">
	<input type=hidden name="Find">
	<input type=hidden name=choose>
<%@ include file="room.jsp"%>
<% String sel=(String)request.getParameter("sel");
   if(sel==null) sel="0"; %>
  <input type=hidden name="sel" value="<%=sel %>">
   <table width="270" border="0" cellspacing="0" cellpadding="0" class="L2">

<tr>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=0;findSub('crm_RoomCodeList1.jsp');"> <font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>房源资料</font> 
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.cus.sel.value=2;findSub('crm_RoomCodeList3.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>销售情况</font></a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.cus.sel.value=1;findSub('Room_list.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>房源视图</font></a>
	</td>
	</tr></table>
	<script>
function findSub(para){
   document.cus.action=para+"?Search=b&Find=b";
   document.cus.submit();


}
</script>
<div align="center">
  <p><font color="#0000CC"><b><font size="3" class=FontColor> 
   <%if (!SecName.equals(Loft)){out.print(SecName);} %>  <%=Loft %>  <%=strBuilding%>编码表</font></b></font></p>

   
	  <input type=hidden name=Ecellname value="<%=Ecellname %>">
	  <input type=hidden name=Scellname value="<%=Scellname %>">
	
  <table width="85%" border="0" align="center" CELLSPACING=0 CELLPADDING=0 >	<tr><td nowrap=5>  <%if (!lock.equals("")){ %>
   <INPUT TYPE=button NAME=loke VALUE="此栋有禁用号(<%=lock %>)，点击可恢复" onclick="openwin1('listLoke.jsp?SecNo=<%=strSection%>&Loft=<%=Loft%>',200,150,100,100);">
   <%} %></td><td align="right">&nbsp;
   <%
 
 String room_type ="";
 int colts=20;
	 String ss="select room_type,ts from LoftBuildCode where SECNO='"+strSection+"' and loft='"+Loft+"'";
	 
   ResultSet ssr=InsertBean1.executeQuery(ss);
   if (ssr.next()){
    room_type=ssr.getString("room_type");
	colts=ssr.getInt("ts");
   }
   ssr.close();
 //权限确认
 
  String Cortrol=checke_qx(InsertBean,(String)session.getAttribute("loginid"),"B005");
  if (Cortrol==null)Cortrol="";
  if (Cortrol.indexOf("A")>=0){ %>
	<input type=button name=addroom value="增加编码" onclick="openwin1('add_new_room_code1.jsp?scell=<%=scell %>&Loft=<%=Loft%>&SecNo=<%=strSection%>&Build=<%=strBuilding %>&intEndF=<%=intEndF%>&intEndR=<%=intEndR%>&roomcode='+document.cus.checkroom.value,300,250,100,100);">
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
		 <%}else{  %>
		  <%for(int j2=scell;j2<=ecell;j2++){
			if (scell>0){  
			  Rinfo=AsiicZH(j2,CellN1); 
			}%>
  <table width="98%" border="0" CELLSPACING=1 CELLPADDING=3 >
  <%  if (room_type.indexOf("墅")<0&&room_type.indexOf("车")<0&&intEndR<=colts){%>
    <tr>
		
      <td  width="1%" align="center" class=listtitle><font color="#FFFFFF"<b><%if (!Rinfo.equals("")) {out.print(Rinfo+"单元");}%>楼层\房间</b></font></td>
		<%
		char BeF=RoomNoUp.charAt(0);
		RoomNoUp=RoomNoUp.substring(RoomNoUp.length()-1);
        char BeR=RoomNoUp.charAt(0);
		for(int j=intBeginR;j<=intEndR;j++){
	        String NO="";
		    NO=AsiicZH(j,BeR);
			if (LockRoomS.indexOf(String.valueOf(j))>=0||upp.indexOf(LockRoomS)>=0){
			 if (upp.indexOf(LockRoomS)>=0){
		 	 if (!Lock.contains(String.valueOf(j))){
			%>
		     <td align="center" width="1%"class=listtitle><font color="#ffffff"><%=NO%></font><%if (Cortrol.indexOf("D")>=0){  %><input type=checkbox name="Check<%=j%>" value="<%=j%>" checked onclick="LokeRoomNo('<%=strSection%>','<%=Loft %>','<%=j %>',this,'<%=strBuilding %>');"><%} %></td>
						 
			 <%}
			 }else if (!Lock.contains(String.valueOf(j))){
			 %>
			 <td align="center" width="1%" class=listtitle><font color="#ffffff"><%=NO%></font></td>
			 			   
			 <%} %>	
			 <%}
			 else if (!Lock.contains(String.valueOf(j))){
			 
			 %>
			 <td align="center" width="1%" class=listtitle><font color="#ffffff"><%=NO%></font><%if (Cortrol.indexOf("D")>=0){  %><input type=checkbox name="Check<%=j%>" value="<%=j%>" checked onclick="LokeRoomNo('<%=strSection%>','<%=Loft %>','<%=j %>',this,'<%=strBuilding %>');"><%} %></td>
			
			
			 <%}
			 
			 }%>
		 <td align="center"    width="1%"class=listtitle><font color="#ffffff">面积</td>	 
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
	String floormess="";//楼层附加字
	 String showfloors="";//显示楼层
	 
	String  sqlR="select RoomNo,state,Floor,room,floortype,floormess,ShowFloors from RoomNo where SectionNo=";
			sqlR=sqlR+"'"+strSection+"' and Building='";
			sqlR=sqlR+strBuilding+"'  and  cell='"+Rinfo+"' and  Region='"+Loft+"' and floortype=0  order by Floor,room";
		   ResultSet rsArr=InsertBean1.executeQuery(sqlR);
		   int aryi=0;
		 
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
			// if (FloorS.indexOf("-")>=0)FloorS="";
			 if (Integer.parseInt(RoomS)>=10){   
			 list1.add(Rinfo+FloorS+RoomS);
			}else{
			  list1.add(Rinfo+FloorS+"0"+RoomS);
			 
			  }
			 
		    aryi+=1;
			
		   } 
	      rsArr.close();
		  sqlR="select room_code,gl_area+area area from Room where seccode=";
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
	 for(int i=intBeginF;i<=intEndF;i++){
	   String ro="";
	 hs=0;
	// if (i>0)ro=String.valueOf(java.lang.Math.abs(i));
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
       	String RoomNo="";
		String no="";
		String floortype="";
		   if (j>=10)
		    RoomNo=Rinfo+ro+String.valueOf(j);
		   else
		    RoomNo=Rinfo+ro+"0"+String.valueOf(j);
		
		arrlen+=1;
 
		if (list1.contains(RoomNo)){
		   int index=list1.indexOf(RoomNo);
		   state=(String)list2.get(index);
		   RoomNo=(String)list5.get(index);
		   floortype=(String)list6.get(index);
		   floormess=(String)list7.get(index);
		     showfloors=(String)list8.get(index);
		 }else{state="";}  
		
	   if (!Lock.contains(String.valueOf(j))){
	 
	  hs++;
		if (state.equals("0"))
		
		{%>
		<td align="center" width="1%" class=roomright><a href="#<%=RoomNo %>" title="单击可输入房间资料" onclick="javascript:openwin1('crm_RoomInput.jsp?loft=<%=Loft %>&seccode=<%=strSection%>&building=<%=strBuilding%>&Floor=<%=i%>&Room=<%=j %>&Room_code=<%=RoomNo%>&MaxFloor=<%=intEndF%>&BengR=<%=intBeginR %>&EndR=<%=intEndR %>&RoomNoType=<%=RoomNo %>&floortype=<%=floortype %>&floormess=<%=floormess %>&cell=<%=Rinfo %>',531,570,150,10);" ><%=RoomNo%></a><%if (Cortrol.indexOf("D")>=0){  %><input type=checkbox name="Check<%=RoomNo%>" value="<%=RoomNo%>" checked onclick="clearRoomNo('<%=strSection%>','<%=Loft %>','<%=RoomNo %>',this,'<%=strBuilding %>');"><%} %></td>
		<%
		}else if (state.equals("1")){
		out.print("<td align='center' width='1%' class=roomright>");%>
		
		<a href="#<%=RoomNo %>" onclick="javascript:openwin1('crm_RoomEdit.jsp?loft=<%=Loft %>&seccode=<%=strSection%>&building=<%=strBuilding%>&Floor=<%=i%>&Room=<%=j %>&Room_code=<%=RoomNo%>&MaxFloor=<%=intEndF%>&BengR=<%=intBeginR %>&EndR=<%=intEndR %>&RoomNoType=<%=RoomNo %>&currNo=<%=j %>&floortype=<%=floortype %>&floormess=<%=floormess %>&cell=<%=Rinfo %>',560,570,150,10);" title="已输入,单击可查看房间资料"><font  color=red><%=RoomNo%></FONT></a><%if (Cortrol.indexOf("D")>=0){  %><input type=checkbox name="Check<%=RoomNo%>" value="<%=RoomNo%>" checked onclick="clearRoomNo('<%=strSection%>','<%=Loft %>','<%=RoomNo %>',this,'<%=strBuilding %>');"><%} %></td>
		<%}else if (state.equals("")){out.print("<td align='center' class=roomright>&nbsp;</td>");}
    	}
		if (list10.contains(RoomNo)){ 
		   int index1=list10.indexOf(RoomNo);
		 		   floors_area+=Double.parseDouble((String)list9.get(index1));
		
		}
		}
		 if (room_type.indexOf("墅")<0&&room_type.indexOf("车")<0){
		%><td width="1%"><%=fa.getFloat2(floors_area,2) %></td>
		  <script>//Aw1<%=Rinfo+String.valueOf(java.lang.Math.abs(i)) %>.innerHTML="<%if (!floormess.equals("")&&!showfloors.equals("")) out.print(String.valueOf(i)+floormess);else if (!floormess.equals("")&&showfloors.equals(""))  out.print(floormess);else  out.print(i);%>";</script>
	   <%} %>
	</tr>
	<% floors_area=0;}%>
 
	
	<%
	//显示地下楼层
	  floors_area=0;
	for(int i=mxinF;i<=-1;i++){
    %>
	<tr>
		<td align="center" class=FloorC><font color="#ffffff"><div id="A<%=String.valueOf(java.lang.Math.abs(i)) %>w1"><%=i%></div</font></td>
		<%for(int j=intBeginR;j<=intEndR;j++){
      
		String RoomNo="";
		String  floortype="";
           if (j>=10)
		    RoomNo=Rinfo+String.valueOf(j);
		   else
		    RoomNo=Rinfo+"0"+String.valueOf(j);
			
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
        <td  align="center" class=roomright><a href="#" onclick="javascript:openwin1('crm_RoomEdit.jsp?loft=<%=Loft %>&seccode=<%=strSection%>&building=<%=strBuilding%>&Floor=<%=i%>&Room=<%=j %>&Room_code=<%=RoomNo%>&MaxFloor=<%=intEndF%>&BengR=<%=intBeginR %>&EndR=<%=intEndR %>&RoomNoType=<%=RoomNo %>&floortype=<%=floortype %>&floormess=<%=floormess %>&cell=<%=Rinfo %>',530,520,150,10);" title="已输入"><font color=red><%=RoomNo%></FONT></a><%if (Cortrol.indexOf("D")>=0){  %><input type=checkbox name="Check<%=RoomNo%>" value="<%=RoomNo%>" checked onclick="clearRoomNo('<%=strSection%>','<%=Loft %>','<%=RoomNo %>',this);"><%} %></td> 
		<%
		}else {out.print("<td align='center' class=roomright></td>");}
		}
		if (list10.contains(RoomNo)){ 
		   int index1=list10.indexOf(RoomNo);
		 		   floors_area+=Double.parseDouble((String)list9.get(index1));
		
		}
	  }
	  
	   if (room_type.indexOf("墅")<0&&room_type.indexOf("车")<0){
	  %>
	  <td width="50"><%=fa.getFloat2(floors_area,2) %></td>
	    <script>A<%=String.valueOf(java.lang.Math.abs(i))%>w1.innerHTML="<%if (!floormess.equals("")&&!showfloors.equals("")) out.print(String.valueOf(i)+floormess);else if (!floormess.equals("")&&showfloors.equals(""))  out.print(floormess);else  out.print(i);%>";</script>
	 <%} %>
	</tr>
	<% }%>
  </table>
  
    <%} }%>
 <input type=hidden name=checkroom value="<%=checRoom %>">
 <%}catch(Exception s)  {out.print("系统处理发现问题如下:"+s+",可能是你还没有定义此栋的房间或车位编号,请点击[<a href='RoomCodeInput.jsp?SecName="+getbyte2(request.getParameter("SecName"))+"&Build="+getbyte2(request.getParameter("Build"))+"&Loft="+getbyte2(request.getParameter("Loft"))+"&SecNo="+getbyte2(request.getParameter("SecNo"))+"'><font color='red'>房源生成</font></a>]");} %>
</form>  
<script language="javascript" src="cancel_room_code.js"></script>
 <%InsertBean.closeConn();
  InsertBean1.closeConn();
 
  %>
</div>
</form>
</body>
</html>
