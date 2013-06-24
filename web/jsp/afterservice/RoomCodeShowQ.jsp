<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
 

<html>
 
<head>
	<title>产权销控图</title>
</head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="javascript" src="../public_js/public.js">
</script>

<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="InsertBean2" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/asiic.jsp"%> 

<body   topmargin="1"   >
<script>
function findSub(para){
   document.cus.action=para;
   document.cus.submit();
 }
</script>
  <%String sel=(String)request.getParameter("sel");
if(sel==null) sel="0";  

String state="";
String fontColor="";
 
String strSection="";

int iii=0;
String Loft="";
String strBuilding="";
String SecName=China.getParameter(request,"secname");
strSection=China.getParameter(request,"SecNo");
Loft=China.getParameter(request,"Loft");	
strBuilding=China.getParameter(request,"Build");

%>
<form name=cus method="post"  action="RoomCodeShowQ.jsp">
   <input type=hidden name="sel" value="<%=sel %>">
   <table width="620" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=0;findSub('PropertyWBList.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>待办产权</font></a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.cus.sel.value=1;findSub('RoomCodeShowQ.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>产权销控图</font></a>
	</td>
	  <td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=2;findSub('PropertyYBList.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>已送办产权</font></a>
	</td>
	 <td class="<%if(sel.equals("6")){out.print("paneselect6");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=3;findSub('PropertyZJList.jsp');"><font color='<%if(sel.equals("6")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>合同注记</font></a>
	</td>
	 <td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=3;findSub('PropertyAList.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>已领产权</font></a>
	</td>
	 <td class="<%if(sel.equals("5")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=5;findSub('PropertyWCList.jsp');"><font color='<%if(sel.equals("5")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>未审批合同</font></a>
	</td>
	 <td class="<%if(sel.equals("4")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=4;findSub('PropertyRpt.jsp');"><font color='<%if(sel.equals("4")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>报表管理</font></a>
	</td>
	</tr></table>
	<input type="button" name=out1 onclick="bringToExcel()" value="导出到Excel">
	  <input type="hidden" name=secname value="<%=SecName %>">
 <input type=hidden name=secName value="<%=SecName %>">
 <input type=hidden name=SecNo value="<%=strSection %>">
 <input type=hidden name=Loft value="<%=China.getParameter(request,"Loft") %>">
 <input type=hidden name=Build value="<%=China.getParameter(request,"Build") %>">
 <input type=hidden name="sel" value="<%=sel %>">
 <div align=left id=report1 style="background-color:#F7F7F7;height:600px;overflow:auto;width:100%;z-index:2" contentEditable > 
	<P align="center"><b><font size=3><%=China.getParameter(request,"secname")%>出证明细表</FONT></b></P>
	<center>
	<table width="80%" border="0">
	    <tr>
		<td  bgcolor="#green" align="center">已申请办证</td>
		<td bgcolor="#ffff00"  align="center">一次性送件</td>
		<td   bgcolor="#c0c0c0" align="center">按揭送件</td>
		<td  bgcolor="#ff0000" align="center">一次性出证</td>
		<td  bgcolor="#00ffff"  align="center">按揭/分期出证</td>
		 
		</tr>
	</table>
	</center>
	 
<%
 

String FindStr="";	
if (!Loft.equals("")) FindStr=" and loft='"+Loft+"'";
if (!strBuilding.equals("")) FindStr+=" and building='"+strBuilding+"'";
String SQL1="select loft,building from order_contract where  state<>3 and section='"+strSection+"' "+FindStr+" group by loft,building";
ResultSet rs3=InsertBean2.executeQuery(SQL1);
while (rs3.next()){
    Loft=getbyte(rs3.getString("Loft"));
    strBuilding=getbyte(rs3.getString("building"));
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
 String ss="select room_type,ts from LoftBuildCode where SECNO='"+strSection+"' and loft='"+Loft+"'";
  
   ResultSet ssr=InsertBean1.executeQuery(ss);
   if (ssr.next()){
    room_type=ssr.getString("room_type");
	colts=ssr.getInt("ts");
   }
        String upp="ABCDEFGHIJKLOPQRST";
		upp=upp.trim();
		int nn=0;
        String RoomNoUp="";
		String  sqlU="select top 1 Room_code from Room where seccode=";
				sqlU=sqlU+"'"+strSection+"' and Building='";
				sqlU=sqlU+strBuilding+"' and loft='"+Loft+"'";
		ResultSet rsU=InsertBean.executeQuery(sqlU);
 
        if (rsU.next())RoomNoUp=rsU.getString("Room_code");
		rsU.close();
        if (RoomNoUp.equals("")){continue;}
		%>


 
 
<center>
 
 <P align="center"><b><font size=3><%= Loft+strBuilding%></FONT></b></P>
	  <table width="99%" border="0" CELLSPACING=1 CELLPADDING=3>
   <tr> 
   <%for(int j2=scell;j2<=ecell;j2++){
			if (scell>0){  
			  Rinfo=AsiicZH(j2,CellN1); 
			} %>
 
		<td width="1%"   align="center" valign="top"><b><%if (!Rinfo.equals("")) {out.print(Rinfo+"单元");}%></b>
		<table border="0" align="center" width="100%"  CELLSPACING=1 CELLPADDING=0>
			  <%  if (room_type.indexOf("墅")<0&&room_type.indexOf("车")<0){%>
	         <tr>
	         <td  width="1%" bgcolor="#800000" align="center"><img src="../images/1.gif" border="0"></td>
		<%
		try{
		RoomNoUp=RoomNoUp.substring(RoomNoUp.length()-1);
        char BeR=RoomNoUp.charAt(0);
 
	
		for(int j=intBeginR;j<=intEndR;j++){
		  String NO="";
			  NO=AsiicZH(j,BeR);//调用asiic转换方法 
			
			if (LockRoomS.indexOf(String.valueOf(j))>=0||upp.indexOf(LockRoomS)>=0){
        
			 if (upp.indexOf(LockRoomS)>=0){
			 
			 
			 if (LockRoomS.indexOf(NO)<0){
			%>
		     <td align="center" width="1%" class=listtitle><font color="#ffffff"><%=NO%></font></td>
			 <%}
			 }else if (!Lock.contains(String.valueOf(j))){
			 %>
			 <td align="center" width="1%" class=listtitle><font color="#ffffff"><%=NO%></font></td>
			 <%} %>	
			 <%}else{%>
			 <td align="center" width="1%" class=listtitle><font color="#ffffff"><%=NO%></font></td>
			 
			 <%}
			 
			 }
			 }catch(Exception s){}
			 %>
     </tr>
		<%} %>
		<tr>
	<%
    List list1=new LinkedList();//存放铺位编码
	List list2=new LinkedList();//存放铺位状态
	List list3=new LinkedList();//存放所在FLoor
    List list4=new LinkedList();//存放房号
    List list5=new LinkedList();//存放客户编码
    List list6=new LinkedList();//存放合同序号
	List list7=new LinkedList();//存放铺位序号
	List list8=new LinkedList();//存编码
	List list9=new LinkedList();//存产权办理状态
	List list10=new LinkedList();//存按揭银行
	List list11=new LinkedList();//存按揭合同号
	List list12=new LinkedList();//存放楼层附加字
	List list13=new LinkedList();//存放申办状态
    String floorshow="";
	String floortype="";
	String floormess="";
    String StrUpper="ABCDEFGHIJKLOPQ"; 
	String sqlArr="select   o.cq ,r.code as roomcode,r.Room_code,r.saleState,r.Floor,r.Room,r.floormess,";
	       sqlArr+=" o.customer,o.code,r.floorshow,r.floortype,o.song_jian_date , ";
		    sqlArr+=" o.payment1,o.cq_date  from ";
		   sqlArr+=" room r,order_contract o,customer c  where o.state=2    and ";
		   sqlArr+=" c.serialno=o.customer and r.seccode=o.section and o.loft=r.loft";
		   sqlArr+=" and o.building=r.building and o.room_no=r.room_code and r.seccode=";
		   sqlArr=sqlArr+"'"+strSection+"'";
		   sqlArr=sqlArr+" and  r.cell='"+Rinfo+"'  and o.floors=r.floor and r.loft='"+Loft+"' and r.building='"+strBuilding+"'";
		   sqlArr+=" and r.floortype=0    order by  r.Floor";
 
		   
			  
		   ResultSet rsArr=InsertBean.executeQuery(sqlArr);
		
		   int aryi=0;
		   while (rsArr.next()){
   	         list7.add(rsArr.getString("roomcode"));
		     list8.add(rsArr.getString("Room_code"));
			 list13.add(rsArr.getString("cq"));
			 list2.add(rsArr.getString("SaleState"));
			 String FloorS=rsArr.getString("Floor");
			 String RoomS=rsArr.getString("Room");	
			 floormess=getbyte(rsArr.getString("floormess"));	
			 list12.add(floormess);	
			 list3.add(FloorS);
			 list4.add(RoomS);
			 
			 if (Integer.parseInt(RoomS)>=10){
			  list1.add(Rinfo+FloorS+RoomS);
			
			 }else{
			  list1.add(Rinfo+FloorS+"0"+RoomS);
			    
			  }
			 
			 list5.add(rsArr.getString("customer"));
			 list6.add(rsArr.getString("code"));
			 floorshow=rsArr.getString("floorshow");
			 floortype=rsArr.getString("floortype");
			 list9.add(getbyte(rsArr.getString("song_jian_date")));
			 list10.add(getbyte(rsArr.getString("payment1")));
			 list11.add(getbyte(rsArr.getString("cq_date")));
			//list12.add(getbyte(rsArr.getString("ajmoney")));
		   } 
	      rsArr.close();
		int arrlen=0;
	 int hs=0;
	  for(int i=intBeginF;i<=intEndF;i++){
	   hs=0;
	 
	  if (room_type.indexOf("墅")<0&&room_type.indexOf("车")<0){
	%><td align="center" class=FloorC width="1%"><font color="#ffffff"><div id=A<%=String.valueOf(java.lang.Math.abs(i))+1 %>w1><%=i%></div></font></td>
		<%  }  
		String customer="";
		String contractno="";
		String loft="";
		for(int j=intBeginR;j<=intEndR;j++){
		if (!Lock.contains(String.valueOf(j))){
		hs++;
		String no="";
		String RoomNo="";
		String cq="";
		String sbcq="";
		String payment1="";
		String outdate="";
		//String ajbk="";
		//String ajmoney="";
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
		   cq=(String)list9.get(index);
		   payment1=(String)list10.get(index);
		   sbcq=(String)list13.get(index);
		   outdate=(String)list11.get(index);
		   floormess=(String)list12.get(index);
		 }else{state="";}  
		 String bg="";
		 
		 bg="BGCOLOR='#DDE8E8'";//默认背景色
		  if (state.equals("")){ bg="BGCOLOR='#DDE8E8'";RoomNo="";}
	 
		 if (!cq.equals("")&&!state.equals("")&&(payment1.indexOf("按揭")>=0||payment1.indexOf("分期")>=0)&&!outdate.equals("")){ bg="bgcolor='#00ffff'";	}
		 else if (!cq.equals("")&&!state.equals("")&&payment1.indexOf("按揭")>=0&&outdate.equals("")){ bg="bgcolor='#c0c0c0'";}
		 else if (!cq.equals("")&&!state.equals("")&&payment1.indexOf("一次")>=0&&!outdate.equals("")){ bg="bgcolor='#ff0000'";}
		 else if (!cq.equals("")&&!state.equals("")&&payment1.indexOf("一次")>=0&&outdate.equals("")){ bg="bgcolor='#ffff00'";}
         else if (cq.equals("")&&sbcq.equals("1")){ bg="bgcolor='#green'";}
        
		 else RoomNo="";
		
		  no=RoomNo;
		
		    if (state.equals("2")){ RoomNo=no;}
			else if (state.equals("3")){ RoomNo=no;}
			else if (state.equals("1")){ RoomNo=no;}
			else if (state.equals("5")){ RoomNo=no;}
			else if (state.equals("2")){ RoomNo=no;}
			else if (state.equals("4")){ RoomNo=no;}
			else if (state.equals("6")){ RoomNo=no;}
		  
		%>
	 <td align="center" width="1%"  <%=bg %>>  
	 <% if (state.equals("2")||state.equals("3")||state.equals("4")||state.equals("5")||state.equals("6")){ %>
	 <a href="#" ><font color="#000000"><%=RoomNo%></font></a><br> 
	 <%}else{ %>&nbsp;<%} %>
	 </td> 
	 <%}
	}%>
	 <% floormess="";  %>
	</tr>
	<% }
	%>
  </table>
 <%} %>
  	 </tr></table>
     <% iii++;
	  //if (iii==1){out.print("</tr>");iii=0;}
	 }rs3.close();%>
	 
	 <table width="90%"  style="top:150px" align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
	 <%SQL1="select yong_tu,count(*) num from order_contract where  state<>3 and section='"+strSection+"' "+FindStr+" group by  yong_tu";
     rs3=InsertBean1.executeQuery(SQL1);
	 int a1=0,a2=0,a3=0;
	 while (rs3.next()){
	      String  yong_tu=rs3.getString("yong_tu");
	      String sql1="select count(*) num from order_contract   where not song_jian_date is null and cq_date is null and  state<>3 and section='"+strSection+"' "+FindStr+" and yong_tu='"+yong_tu+"'";
	 
		 
		  ResultSet rs5=InsertBean.executeQuery(sql1);
		  out.print("<tr><td>");
		  int ad=rs3.getInt("num");
		  a1+=ad;
	      out.print(yong_tu+":"+ad+"套</td>");
		  
		   if (rs5.next()){
		    ad=rs5.getInt("num");
			a2+=ad;
		    out.print("<td>送件:"+ad+"套</td>");
		   }else{
		    out.print("<td>&nbsp;</td>");
		   
		   }
		   rs5.close();
		    sql1="select count(*) num from order_contract where   not song_jian_date is null and  not cq_date is null and  state<>3 and section='"+strSection+"' "+FindStr+" and yong_tu='"+yong_tu+"'";
	       rs5=InsertBean.executeQuery(sql1);
	 
		   if (rs5.next()){
		    ad=rs5.getInt("num");
			//out.print(sql1+"<br>");
			a3+=ad;
		    out.print("<td>出证:"+ad+"套</td>");
		   }else{
		    out.print("<td>&nbsp;</td></tr>");
		   
		   }
		   rs5.close();
	 }rs3.close();
	 
	  %>
	  <tr><td >合计:<%=a1 %></td><td ><%=a2 %></td><td ><%=a3 %></td></tr>
	  </table>
   </center>
   </div>
<%InsertBean.closeConn(); 
InsertBean1.closeConn(); 

%>
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
<input type="button" onclick="bringToExcel()" value="导出到Excel"><br>
导入前必须进行相应设置：<br>
　1.在IE工具栏中选择"internet选项"<br>
　2.选择"安全"->选择"本地intranet"后再点击"自定义级别"<br>
  3.把所有ActiveX启用都选中后点击确认退后。<br>

</form>  
 
 
</body>
</html>
