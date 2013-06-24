<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
 
<html>
 
<head>
	<title>代付审核销控表</title>
</head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="javascript" src="../public_js/public.js">
</script>

<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/asiic.jsp"%> 
<%
String ref_id = request.getParameter( "ref_id" ) ;
if( ref_id == null ) {
    session.setAttribute( "xiaoKongFrom" , "" ) ;
}else{
    session.setAttribute( "xiaoKongFrom" , "chengyi" ) ;
    session.setAttribute( "ref_id" , ref_id ) ;
}

String strMessage=China.getParameter(request,"mess");
String SecName=request.getParameter("SecName");
 
String condi=China.getParameter(request,"condi");
String FindCustomer=China.getParameter(request,"name");
String FindRoom=China.getParameter(request,"room");
 

String state="";
String fontColor="";
String strYN=request.getParameter("yn");
String strSection="";

 
String Loft="";
String strBuilding="";
 
  SecName=getbyte2(request.getParameter("SecName"));
  strSection=getbyte2(request.getParameter("SecNo"));
  Loft=getbyte2(request.getParameter("Loft"));		
  strBuilding=getbyte2(request.getParameter("Build"));
  

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
  // if (intBeginF<0)intBeginF=FF;
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
//计算最大房号
        sql="select min(Floor) as BeginF,max(Floor) as EndF,";
		sql=sql+"min(Room) as BeginR,max(Room) as EndR from";
		sql=sql+" roomstateview where seccode='"+strSection+"'";
		sql=sql+FindStr+" and SaleState in (1,2,3,4,5,6)  ";
		
   rs=InsertBean.executeQuery(sql);
   if (rs.next())  intEndR=rs.getInt("EndR");
   rs.close();
%> 

<body topmargin="1"  oncontextmenu="return false">

  <%    
        String BuildPa=request.getParameter("Build");
        if (BuildPa==null)BuildPa="";
		String locaPara="Loft="+request.getParameter("Loft")+"&Build="+BuildPa+"&SecNo="+request.getParameter("SecNo")+"&SecName="+request.getParameter("SecName");
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
<form name=frm method="post" >
<%
 String sel=(String)request.getParameter("sel");
 if(sel==null) sel="1";	  
  
 %> 

<P align="center"><font size=4><b>代付核对</b></font></P>
 <input type=hidden name=cusname value="">
 <input type=hidden name=secname value="">
   <input type=hidden name=SecNo value="<%=strSection %>">
   <input type=hidden name=Loft value="<%=Loft %>">
<center>
<table width="80%" border="0"><tr>
<td bgcolor='#00CCFF'  align="center">认购</td>
<td bgcolor='#E5C862'  align="center">已售</td>
</tr>
</table>
房号:<input type=text name=room size=10>  客户姓名:<input type=text name=name ><input type=submit name=find value="查找">
  <%for(int j2=scell;j2<=ecell;j2++){
			if (scell>0){  
			  Rinfo=AsiicZH(j2,CellN1); 
			} %>
  <table width="90%" border="0" CELLSPACING=1 CELLPADDING=3>
   <tr>
		<td width="100" bgcolor="#489A80" align="center"><font color="#FFFFFF"<b><%if (!Rinfo.equals("")) {out.print(Rinfo+"单元");}%>楼层\房号</b></font></td>
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
			 }else if (!Lock.contains(String.valueOf(j))){
			 %>
			 <td align="center" class=listtitle><font color="#ffffff"><%=NO%></font></td>
			 <%} %>	
			 <%}else{%>
			 <td align="center" class=listtitle><font color="#ffffff"><%=NO%></font></td>
			 
			 <%}
			 
			 }%>

	</tr>
	<%
    List list1=new LinkedList();//存放铺位编码
	List list2=new LinkedList();//存放铺位状态
	List list3=new LinkedList();//存放所在FLoor
    List list4=new LinkedList();//存放房号
    List list5=new LinkedList();//存放客户编码
    List list6=new LinkedList();//存放合同序号
	List list7=new LinkedList();//存放铺位序号
	List list8=new LinkedList();//存编码
    String floorshow="";
	String floortype="";
    String StrUpper="ABCDEFGHIJKLOPQ"; 
	String sqlArr="select   r.code as roomcode,r.Room_code,r.saleState,r.Floor,r.Room,o.customer,o.code,r.floorshow,r.floortype from room r,order_contract o,customer c  where o.state<>3 and c.serialno=o.customer and r.seccode=o.section and o.loft=r.loft and o.building=r.building and o.room_no=r.room_code and r.seccode=";
		   sqlArr=sqlArr+"'"+strSection+"'";
		   if (!FindCustomer.equals("")) sqlArr+=" and c.signatory='"+FindCustomer+"'";
		   if (!FindRoom.equals("")) sqlArr+=" and r.Room_code='"+FindRoom+"'";
		   sqlArr=sqlArr+" and  cell='"+Rinfo+"' and r.loft='"+Loft+"' and r.building='"+strBuilding+"' and r.floortype=0    order by  r.Floor";
 
		    
		   ResultSet rsArr=InsertBean1.executeQuery(sqlArr);
		
		   int aryi=0;
		   while (rsArr.next()){
   	        list7.add(rsArr.getString("roomcode"));
		    list8.add(rsArr.getString("Room_code"));
			list2.add(rsArr.getString("SaleState"));
			 String FloorS=rsArr.getString("Floor");
			 String RoomS=rsArr.getString("Room");	
			list3.add(FloorS);
			list4.add(RoomS);
			//if (FloorS.indexOf("-")>=0||FloorS.equals("0"))FloorS="";
			if (Integer.parseInt(RoomS)>=10)
			 list1.add(Rinfo+FloorS+RoomS);
			else
			  list1.add(Rinfo+FloorS+"0"+RoomS);
			list5.add(rsArr.getString("customer"));
			list6.add(rsArr.getString("code"));
			floorshow=rsArr.getString("floorshow");
			floortype=rsArr.getString("floortype");
			
		   } 
	      rsArr.close();
		int arrlen=0;
	 %>
	<%for(int i=intBeginF;i<=intEndF;i++){
	 
	String FNO="";
	StrUpper="12";
	char BeF=StrUpper.charAt(0);
	FNO=AsiicZH(i,BeF);//调用asiic转换方法
	FNO=AsiicFloorType(FNO,floorshow);//调用楼层转换方法(是否正数或负数)
	%>
	<tr> 
     <td align="center"  class=FloorC><font color="#ffffff"><%=FNO%></font></td>
		<%
		String customer="";
		String contractno="";
		String loft="";
		for(int j=intBeginR;j<=intEndR;j++){
		if (!Lock.contains(String.valueOf(j))){
		String no="";
		String RoomNo="";
		no="";
		if (j>=10)
		    RoomNo=Rinfo+String.valueOf(i)+String.valueOf(j);
	    else
		    RoomNo=Rinfo+String.valueOf(i)+"0"+String.valueOf(j);
		arrlen+=1;
		String roomcode="";
		if (list1.contains(RoomNo)){
		   int index=list1.indexOf(RoomNo);
		   state=(String)list2.get(index);
		   customer=(String)list5.get(index);
		   contractno=(String)list6.get(index);
		   roomcode=(String)list7.get(index);
		   loft=Loft+strBuilding+(String)list1.get(index);
		   RoomNo=(String)list8.get(index);
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
	 <td align="center"  <%=bg %>>
	 <% if (state.equals("2")||state.equals("3")||state.equals("4")||state.equals("5")||state.equals("6")){ %>
	 <a href="#" title="收款登记" onclick="openwin('F_checkOutmoney.jsp?contractno=<%=contractno %>&cusno=<%=customer %>&loft=<%=SecName+loft %>&ldroomcode=<%=roomcode %>&checkQX=<%=request.getParameter("checkQX") %>',650,570,50,50);"><%=RoomNo%></a>
	 <%}else{ %>&nbsp;<%} %>
	 </td> 
	 <%}
	}%>
	</tr>
	<%  
	 }
	}%>
  </table>
  <%} %>
   </center>
</form> 
   <%InsertBean.closeConn();
    InsertBean1.closeConn();
   %>
</div>
</body>
</html>
