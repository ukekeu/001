<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>

 

<html>
 
<head>
	<title>无销售记录收款登记</title>
</head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="javascript" src="../public_js/public.js">
</script>

<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/asiic.jsp"%> 
<%
String SecName=getbyte2(request.getParameter("SecName"));
String FindCustomer=China.getParameter(request,"name");
String FindRoom=China.getParameter(request,"room");
String RegionStr="";

String state="";
String fontColor="";

String strSection="";


String Loft="";
String strBuilding="";
 
  SecName=getbyte2(request.getParameter("SecName"));
  strSection=getbyte2(request.getParameter("SecNo"));
  Loft=getbyte2(request.getParameter("Loft"));		
  strBuilding=getbyte2(request.getParameter("Build"));
 

String FindStr="";	
if (!Loft.equals("")) FindStr=" and loft='"+Loft+"'";

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
       sql="select max(len(cell)) cell from "; 
 
 sql=sql+" RoomNo where SectionNo='"+strSection+"'";
		sql=sql+" and Building='"+strBuilding+"' and Region='"+Loft+"'";
 String checkCell=""; 
		rs=InsertBean.executeQuery(sql);
		if (rs.next())
		{
		checkCell=getbyte(rs.getString("cell"));
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
 // mxinF=intBeginF;
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
<script>
function findSub(para){
   document.frm.action=para+"?Build=<%=strBuilding %>";
   document.frm.submit();

//oncontextmenu="return false"
}
</script >	
<body topmargin="1"  >

  <%    
        String BuildPa=request.getParameter("Build");
        if (BuildPa==null)BuildPa="";
		String locaPara="Loft="+getbyte(request.getParameter("Loft"))+"&Build="+BuildPa+"&SecNo="+request.getParameter("SecNo")+"&SecName="+getbyte(request.getParameter("SecName"));
		
		String upp="ABCDEFGHIJKLOPQRST";
		upp=upp.trim();
		int nn=0;
        String RoomNoUp="";
		String  sqlU="select top 1 Room_code from Room where seccode=";
				sqlU=sqlU+"'"+strSection+"' and Building='";
				sqlU=sqlU+strBuilding+"' and loft='"+Loft+"'";
		ResultSet rsU=InsertBean1.executeQuery(sqlU);
	 
        if (rsU.next())RoomNoUp=rsU.getString("Room_code");
		rsU.close();
 
        if (RoomNoUp.equals("")){
		%>
		<script>
        alert("此栋还没有进行资料录入操作");
      
</script>
		 <%}else{%>
<form name=frm method="post" action="RoomCodeShow.jsp">
<% String sel=(String)request.getParameter("sel");
 
  
   if(sel==null) sel="0"; %>
 <%
	 String Str="";
    List list1=new LinkedList();//存放铺位编码
	List list2=new LinkedList();//存放铺位状态
	List list3=new LinkedList();//存放所在FLoor
    List list4=new LinkedList();//存放房号
    List list5=new LinkedList();//存放客户编码
    List list6=new LinkedList();//存放合同序号
	List list7=new LinkedList();//存放铺位序号
	List list8=new LinkedList();//存编码
	List list9=new LinkedList();//存放楼层附加字
    String floorshow="";
	String floortype="";
	String floormess="";
    String StrUpper="ABCDEFGHIJKLOPQ"; 
	String room_type="";
	
		int arrlen=0;
	 %>
  <input type=hidden name="sel" value="<%=sel %>">
  <table width="370" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=3;findSub('RoomCodeShow1.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>应急收款</font></a>
	</td>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=0;findSub('RoomCodeShow.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>购房客户</font></a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('RoomCodeShowT.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>一次退房退款</font></a>
	</td>
	 <td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;findSub('tf_list1.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>多次退房退款</font></a>
	</td>
	</tr></table>
<P align="center"><font size=4><b>收款登记</b></font></P>
 <input type=hidden name=cusname value="">
  <input type=hidden name=SecNo value="<%=strSection %>">
   <input type=hidden name=Loft value="<%=Loft %>">
 <input type=hidden name=secname value="">
<center>
<table width="90%" border="0"><tr>
<td bgcolor='#00CCFF'  align="center">认购</td>
<td bgcolor='#E5C862'  align="center">已售</td>
</tr>
</table>
房号:<input type=text name=room size=10>  客户姓名:<input type=text name=name ><input type=submit name=find value="查找">&nbsp;<input type=button name=yj_sk  onclick="opennewwin('ccreport_d.jsp','?url=8',120,170,50,50);" value="收款统计"> 
   <table width="90%" border="0" CELLSPACING=1 CELLPADDING=3>
 
   <tr>
 <%
 int colts=20;
	 
 String ss="select room_type,ts from LoftBuildCode where SECNO='"+strSection+"' and loft='"+Loft+"'";
 
   ResultSet ssr=InsertBean1.executeQuery(ss);
   if (ssr.next()){
    room_type=ssr.getString("room_type");
	colts=ssr.getInt("ts");
   }
 for(int j2=scell;j2<=ecell;j2++){
			if (scell>0){  
			  Rinfo=AsiicZH(j2,CellN1); 
			}
			 
			String sqlArr="select     r.code as roomcode,r.Room_code,r.saleState,r.Floor,r.Room, r.area,r.floorshow,r.floortype,r.floormess from room r   where   r.seccode=";
		   sqlArr=sqlArr+"'"+strSection+"'";
		    if (!FindRoom.equals("")) sqlArr+=" and r.Room_code='"+FindRoom+"'";
		   sqlArr=sqlArr+" and  cell='"+Rinfo+"'  and r.loft='"+Loft+"' and r.building='"+strBuilding+"' and r.floortype=0    order by  r.Floor";
 
		   ResultSet rsArr=InsertBean1.executeQuery(sqlArr);
		    String Rinfo1=Rinfo.trim();
           if (!Rinfo1.equals(""))Rinfo1=Rinfo1+"-";
		   int aryi=0;  
		   while (rsArr.next()){
		    
			list5.add(rsArr.getString("area"));
   	        list7.add(rsArr.getString("roomcode"));
		    list8.add(rsArr.getString("Room_code"));
			list2.add(rsArr.getString("SaleState"));
			 String FloorS=rsArr.getString("Floor");
			 String RoomS=rsArr.getString("Room");	
			 floormess=getbyte(rsArr.getString("floormess"));	
			 list9.add(floormess);
			list3.add(FloorS);
			list4.add(RoomS);
		 
			if (Integer.parseInt(RoomS)>=10)
			 list1.add(Rinfo+FloorS+RoomS);
			else
			  list1.add(Rinfo+FloorS+"0"+RoomS);
			 
			floorshow=rsArr.getString("floorshow");
			floortype=rsArr.getString("floortype");
			
		   } 
	      rsArr.close();
			 %>

		<td    align="center" width="1%"  valign="top"><b><%if (!Rinfo.equals("")) {out.print(Rinfo+"单元");}%></b>
		 <table border="0" align="center" width="100%"  CELLSPACING=1 CELLPADDING=0>
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
			     <td align="center" class=listtitle><font color="#ffffff"><%=NO%></font></td>
				 <%}
				 }else  if (!Lock.contains(String.valueOf(j))){
				 %>
				 <td align="center" class=listtitle><font color="#ffffff"><%=NO%></font></td>
				 <%} %>	
				 <%}else if (!Lock.contains(String.valueOf(j))){%>
				 <td align="center" class=listtitle><font color="#ffffff"><%=NO%></font></td>
				 
				 <%}
				 
				 }%>
	
		</tr>
		<%} %>
		<tr>
	<%
	 int hs=0;
	 String area="";
	for(int i=intBeginF;i<=intEndF;i++){
	hs=0;
	      String ro="";
		 ro=String.valueOf(i);
	 
	  if (room_type.indexOf("墅")<0&&room_type.indexOf("车")<0){
	%><td align="center" class=FloorC width="1%"><font color="#ffffff"><div id=A<%=String.valueOf(java.lang.Math.abs(i))+1 %>w1><%=i%></div></font></td>
		<%  }else{ %> 
		<div style='display:none' id=A<%=String.valueOf(java.lang.Math.abs(i))+1 %>w1><%=i%></div>
		
 
     	<%}	 
		String customer="";
		String contractno="";
		String loft="";
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
		String no="";
		String RoomNo="";
		 Rinfo1=Rinfo.trim();
        // if (!Rinfo1.equals(""))Rinfo1=Rinfo1+"-";
		no="";
		if (j>=10)
		    RoomNo=Rinfo+ro+String.valueOf(j);
			
	    else
		    RoomNo=Rinfo+ro+"0"+String.valueOf(j);
		arrlen+=1;
		 
		String roomcode="";
		if (list1.contains(RoomNo)){
		   int index=list1.indexOf(RoomNo);
		   state=(String)list2.get(index);
		   area=(String)list5.get(index);
		   roomcode=(String)list7.get(index);
		   loft=Loft+strBuilding+(String)list1.get(index);
		   RoomNo=(String)list8.get(index);
		   floormess=(String)list9.get(index);
		
		 }else{state="";}  
		 String bg="";
		 if(i==2 && j==6){
	      }
		 bg="BGCOLOR='#DDE8E8'";//默认背景色
		 if (state.equals("1")){ bg="BGCOLOR='#DDE8E8'";}
		 if (state.equals("2")){ bg="bgcolor='#00CCFF'"; }
		 if (state.equals("3")){ bg="bgcolor='#E5C862'";}
		 if (state.equals("4")){ bg="bgcolor='#E5C862'";}
		 if (state.equals("5")){ bg="bgcolor='#E5C862'";}
		 if (state.equals("6")){ bg="bgcolor='#E5C862'";}
		
		  no=RoomNo;
		 	
		    if (state.equals("2")){ RoomNo=no;}
			else if (state.equals("3")){ RoomNo=no;}
			else if (state.equals("1")){ RoomNo=no;}
			else if (state.equals("5")){ RoomNo=no;}
			else if (state.equals("2")){ RoomNo=no;}
			else if (state.equals("4")){ RoomNo=no;}
			else if (state.equals("6")){ RoomNo=no;}
		 
		%>
	 <td align="center"  width="1%"  <%=bg %>>
	 
	 <% if (state.equals("2")||state.equals("3")||state.equals("4")||state.equals("5")||state.equals("6")){ %>
	 <a href="#" title="收款登记" onclick="opennewwin('yingshi.jsp','?contractno=<%=contractno %>&cusno=<%=customer %>&loft=<%=SecName+loft %>&ldroomcode=<%=roomcode %>&checkQX=<%=request.getParameter("checkQX") %>',690,570,50,50);"><%=RoomNo%></a>
	 <%}else{ %> <a href="#" title="无销售记录收款登记" onclick="opennewwin('FactNoRecoInput.jsp','?SecNo=<%=strSection %>&loft=<%=Loft %>&RoomNo=<%=RoomNo %>&area=<%=area %>',690,570,50,50);"><%=RoomNo%></a>
	<%} %>
	 </td> 
	 <%}
	}%>
	 	<% floormess="";  %>
	</tr>
	<%  
	}%>
	
	</table>
	 <%} %>
  <%} %>
  
  </td>
  </tr></table>
   </center>
   <%InsertBean.closeConn();
    InsertBean1.closeConn();
   %>
</form> 
  <script>
  function opennewwin(url,para,wh,hg,lf,tp) {
   var today=new Date();
 var todayInMS=today.getTime();
    var mess="是否认购登录还是查看铺位资料？(如果是认购请单击‘确认’)";
	 var newwin=window.open(url+para,"newwin1"+todayInMS,"toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
	
  }
  function opennewwin1(para,wh,hg,lf,tp) {
     var today=new Date();
 var todayInMS=today.getTime();
	
	var newwin=window.open("rgList.jsp?"+para,"newwin1"+todayInMS,"toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,width=480,height=500,left=150,top=10");
	
  }
  </script>
 
</div>
</body>
</html>
