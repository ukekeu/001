<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>

 <%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "临订换房" , 
                  "换房"
                ) ;
%>

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
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/asiic.jsp"%> 
<%
      String SecName=request.getParameter("SecName");
	  String Loft =China.getParameter(request,"loft");
	  String Build =China.getParameter(request,"Build");
	  String strBuilding =Build;
	  String strSection ="";
	  String secno=request.getParameter("secno");
	  strSection=secno;
 %>
<script>
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
</script >	
<body oncontextmenu="return false"  onload="setSelectMad(document.frm.loft,'<%=Loft %>');" >
<div align="center">

<form name=frm method="post" action="">
<input type=hidden name=Section value="<%=strSection%>">
<input type=hidden name=SecName value="<%=SecName%>">
<input type=hidden name=Loft value="<%=Loft %>">
 
<p align="center"><b>换房登记</b></p>
 <table width="90%" class=roomright border="0" CELLSPACING=1 CELLPADDING=3>
   
	 <tr>
	 <td  align="center">批 准 人：</td>
	 <td   align="left"><input type=text size=15 name="checker" ></td>
	 <td  align="center">换房日期：</td>
	 <td   align="left"><input type=text size=12  name="date" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(date);" title="请选择换房日期"></td>
	</tr>
	 <tr>
	 <td  align="center">换房原因:</td>
	 <td  align="left" colspan="4"><input type=text size=40 name="context" ></td>
	</tr>
	</table>
	
	请选择楼栋：
	<select name=loft onchange="document.frm.submit();" >
	<option></option>
	<%
	
	
      String  LoftSql="select Loft FROM sectiontree where SerialNo='"+secno+"' group by Loft";
	  
	  String Building="";

   ResultSet rsbuilding=InsertBean1.executeQuery(LoftSql);
  while(rsbuilding.next()){
      String loft=getbyte(rsbuilding.getString("Loft"));
	  out.print("<option value='"+loft+"'>"+loft+"</option>");
	}  
	 %>
	</select>&nbsp;
录入单元号:&nbsp; 
					 <input name="Build" value="<%= Build%>" size=12 onchange="document.frm.submit();" >
					      
				 
<%

if (Loft.equals("")){out.close();}
String state="";

String sql1="select lockroom from lockroom where section ='"+strSection+"' and ";
sql1+=" loft='"+Loft+"'";
if (!Build.equals(""))sql1+=" and Build='"+Build+"'";
ResultSet rsLock=null;

String LockRoomS="";
try{
  rsLock=InsertBean.executeQuery(sql1);
  while (rsLock.next()){
    LockRoomS=rsLock.getString("LockRoom");
  }
  rsLock.close();
}catch(Exception s)  {}

 
 String  sql="select floor from";
		sql=sql+" RoomNo where SectionNo='"+strSection+"'";
		sql=sql+" and Building='"+strBuilding+"' and Region='"+Loft+"' and floor=0";
ResultSet rs=InsertBean.executeQuery(sql);
int FF=1;
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
   if (intBeginF<0)intBeginF=FF;
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
  <%    
       int nosalenum=0;
	   int rgnum=0;
	   int salenum=0;
	   int yl=0;
	   int ld=0;
  
        String BuildPa=request.getParameter("Build");
        if (BuildPa==null)BuildPa="";
		String locaPara="Loft="+request.getParameter("Loft")+"&Build="+BuildPa+"&SecNo="+request.getParameter("SecNo")+"&SecName="+request.getParameter("SecName");
		String upp="ABCDEFGHIJKOPQRST";
		upp=upp.trim();
		int nn=0;
        String RoomNoUp="";
		String  sqlU="select top 1 Room_code from Room where seccode=";
				sqlU=sqlU+"'"+strSection+"' and Building='";
				sqlU=sqlU+strBuilding+"' and loft='"+Loft+"'";
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
   <tr> 
		<td width="100" class=listtitle align="center"><font color="#FFFFFF"<b><%if (!Rinfo.equals("")) {out.print(Rinfo+"单元");}%>楼层\房号</b></font></td>
		<%
		
		RoomNoUp=RoomNoUp.substring(RoomNoUp.length()-1);
        char BeR=RoomNoUp.charAt(0);
		for(int j=intBeginR;j<=intEndR;j++){
		if (LockRoomS.indexOf(String.valueOf(j))>=0||upp.indexOf(LockRoomS)>=0){
        	 if (upp.indexOf(LockRoomS)>=0){
			 
			   String NO="";
			     NO=AsiicZH(j,BeR);//调用asiic转换方法
			  
			 if (LockRoomS.indexOf(NO)<0){
			%>
		     <td align="center" class=listtitle><font color="#ffffff"><%=NO%></font></td>
			 <%}
			 }else if (LockRoomS.indexOf(String.valueOf(j))<0){
			 %>
			 <td align="center" class=listtitle><font color="#ffffff"><%=j%></font></td>
			 <%} %>	
			 <%}else{%>
			 <td align="center" class=listtitle><font color="#ffffff"><%=j%></font></td>
			 
			 <%}
			 
			 }%>
			  <td align="center" class=listtitle><font color="#ffffff">楼层均价</font></td>	
	</tr>
	<%
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
	List list14=new LinkedList();//存放当前房间代号
	String floors="";
	String jzarea="";
	String tnarea="";
	String code="";
	String unitprice="";
	String tnunitprice="";
	String sumprice="";
	String roomtype="";
	String buildingtype="";
	String Fitment="";
    String StrUpper="ABCDEFGHIJKHOPQ"; 
	String sqlArr="select  distinct Room_code,saleState,Floor,Room,area1,UsedArea,tnunitprice,unitprice,Sumprice,Room_Type,roomtype,Fitment,code from roomstateview where seccode=";
		   sqlArr=sqlArr+"'"+strSection+"' and loft='"+Loft+"'";
		   if (!Build.equals(""))sqlArr+=" and Building='"+Build+"'";
		   sqlArr=sqlArr+"  and  cell='"+Rinfo+"'  and SaleState in (1,2,3,4,5,6)  order by  Floor";
		   ResultSet rsArr=InsertBean1.executeQuery(sqlArr);
		   int aryi=0;
		
		   while (rsArr.next()){
		    
		    list7.add(rsArr.getString("Room_code"));
			list2.add(rsArr.getString("SaleState"));
			String FloorS=rsArr.getString("Floor");
			String RoomS=rsArr.getString("Room");
			 
			list3.add(FloorS);
			list4.add(RoomS);
			if (Integer.parseInt(RoomS)>=10)
			 list1.add(Rinfo+FloorS+RoomS);
			else
			  list1.add(Rinfo+FloorS+"0"+RoomS);
			
			list5.add(FormtD.getFloat1(rsArr.getFloat("area1"),4));
			list8.add(FormtD.getFloat1(rsArr.getFloat("UsedArea"),4));
			list6.add(FormtD.getFloat1(rsArr.getFloat("Sumprice"),0));
			list9.add(FormtD.getFloat1(rsArr.getFloat("tnunitprice"),2));
			list10.add(FormtD.getFloat1(rsArr.getFloat("unitprice"),2));
			list11.add(getbyte(rsArr.getString("Room_Type")));
			list12.add(getbyte(rsArr.getString("roomtype")));
			
			list13.add(getbyte(rsArr.getString("Fitment")));
			list14.add(getbyte(rsArr.getString("code")));
			//list7.add(rsArr.getString("Sumprice"));
		   } 
	      rsArr.close();
		int arrlen=0;
	 %>
	<%for(int i=intBeginF;i<=intEndF;i++){
	
	%>
	<tr>
     <td align="center"  class=FloorC><font color="#ffffff"><%=i%></font></td>
		<%
		int IntAvgSumPrice=0;;
		float FatAreaSum=0;
		for(int j=intBeginR;j<=intEndR;j++){
		if (LockRoomS.indexOf(String.valueOf(j))<0){
		String no="";
		String RoomNo="";
		
		no="";
	 if (j>=10)
		    RoomNo=Rinfo+String.valueOf(i)+String.valueOf(j);
		else
		    RoomNo=Rinfo+String.valueOf(i)+"0"+String.valueOf(j);
		arrlen+=1;
		
		if (list1.contains(RoomNo)){
		   int index=list1.indexOf(RoomNo);
		   RoomNo=(String)list7.get(index);
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
		   code=(String)list14.get(index);
		   IntAvgSumPrice+=Integer.parseInt((String)list6.get(index));
		   FatAreaSum+=Float.parseFloat((String)list5.get(index));
		 }else{state="";}  
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
	<a href="#" onclick="aa('<%=strSection %>','<%=no%>','<%=Loft %>','<%=floors %>','<%=tnarea %>','<%=jzarea %>','<%=tnunitprice %>','<%=unitprice %>','<%=sumprice %>','<%=buildingtype %>','<%=roomtype %>','<%=Fitment %>','<%=code %>','<%=Build %>')"><%=RoomNo%></a>
	 <%}%>
	 </td> 
		<%}%>
	
		<%}%>
	 <td><b><u><%=FormtD.getFloat(IntAvgSumPrice/FatAreaSum,2) %></u></b></td>	
	</tr>
	<% }
	}%>
  </table>
  <%} %>
  <%InsertBean.closeConn();
    InsertBean1.closeConn();
 
   %>
  <script>
  function opennewwin(url,para,wh,hg,lf,tp) {
    var mess="是否认购登录还是查看房间资料？(如果是认购请单击‘确认’)";
	 var newwin=window.open(url+para,"newwin1","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
	
  }
  function opennewwin1(para,wh,hg,lf,tp) {
    
	
	var newwin=window.open("rgList.jsp?"+para,"newwin1","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,width=480,height=500,left=150,top=10");
	
  }
  
  function aa(a,b,c,d,e,f,g,h,i,j,k,o,p,p1){

   window.opener.document.cus.RoomNo.value=b;
      window.opener.document.cus.Loft.value=c;
  window.opener.idroomno.innerHTML=c+p1+b;
   
  //window.opener.document.cus.zx.value=o;
  //window.opener.document.cus.fx.value=k;
  window.opener.document.cus.jzarea.value=f;
  window.opener.idjzarea.innerHTML=f;
  //window.opener.document.cus.fl.value=j;
  window.opener.document.cus.tnarea.value=e;
  window.opener.idusearea.innerHTML=e;
 // window.opener.document.cus.floor.value=d; 
 // window.opener.document.cus.tnunitprice.value=g;
  window.opener.idunitprice.innerHTML=g;
  window.opener.idsumprice.innerHTML=i;
  window.opener.document.cus.code.value=p;
  //window.opener.document.cus.sumprice.value=i;
  window.opener.idsaleunitprice.innerHTML=h;
  //window.opener.document.cus.jzunitprice.value=h;
  window.opener.document.cus.change.value="change";
  window.opener.document.cus.Build.value=p1;
  //window.opener.document.cus.context.value=document.frm.context.value;
  //window.opener.document.cus.checker.value=document.frm.checker.value;
   window.opener.charges1(window.opener.idsumprice.innerHTML);
  
  close();
}
</script>
</form>  
</div>
</body>
</html>
