<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>

 
 <%@ include file="../public_js/qx_checke.jsp"%>
 
<html>
<head>
	<title>附属房产销控表</title>
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
String ref_id = request.getParameter( "ref_id" ) ;
if( ref_id == null ) {
    session.setAttribute( "xiaoKongFrom" , "" ) ;
}else{
    session.setAttribute( "xiaoKongFrom" , "chengyi" ) ;
    session.setAttribute( "ref_id" , ref_id ) ;
}
 

 
String condi=China.getParameter(request,"condi");
 
String SecName="";
String state="";
String fontColor="";
String strYN=request.getParameter("yn");
String strSection="";
 
String Loft="";
String strBuilding="";
 
if (condi.equals(""))
  {
  SecName=getbyte2(request.getParameter("SecName"));
  strSection=getbyte2(request.getParameter("SecNo"));
  Loft=getbyte2(request.getParameter("Loft"));		
  strBuilding=getbyte2(request.getParameter("Build"));
  }
else
  {
  SecName=China.getParameter(request,"SecName");
  strSection=China.getParameter(request,"Section");
  Loft=China.getParameter(request,"Loft");	
  strBuilding=China.getParameter(request,"Build");
}
   
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
		sql=sql+" and Building='"+strBuilding+"' and Region='"+Loft+"' and floor=0";
ResultSet rs=InsertBean.executeQuery(sql);
int FF=1;
if (rs.next())FF=rs.getInt("floor");rs.close();
       sql="select min(Floor) as BeginF,max(Floor) as EndF,";
		sql=sql+"min(Room) as BeginR,max(Room) as EndR,max(cell) as Ecell ,min(cell) as Scell from";
		sql=sql+" RoomNo where SectionNo='"+strSection+"'";
		sql=sql+" and Building='"+strBuilding+"' and Region='"+Loft+"'";
       rs=InsertBean.executeQuery(sql);
		  out.println(sql);
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
//读取预售许可证号
String yushou_no="";
sql="select yushou_no from CRM_Project where SerialNo='"+strSection+"'";
  rs=InsertBean.executeQuery(sql);
   if (rs.next())  yushou_no=getbyte(rs.getString("yushou_no"));
   rs.close();

 
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
</script >	 
<body oncontextmenu="return false"  topmargin="1" onload="setSelectMad(document.frm.condi,'<%= condi %>');setSelectMad(document.frm.aa,'<%=getbyte1(request.getParameter("orderby"))%>');"">
 

<%
String sel=(String)request.getParameter("sel");
    if(sel==null) sel="0";	  
 %>
 <form name=frm method="post" action="RoomCodeShow.jsp">
<table width="180" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=0;findSub('RoomCodeShow.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>认购登记</font></a>
	</td>
	  <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('RgNoM.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>认购号管理</font></a>
	</td>
	
   </tr>
<input type=hidden name=sel value="<%=sel%>">
 </table>
<script>
function findSub(para){
   document.frm.action=para;
   document.frm.submit();


}
</script>
<p CLASS=FontColor align="center"><b><font size="3" ><%if (!SecName.equals(Loft)){out.print(SecName);} %><%=Loft+strBuilding %>销控表</font></b></p>

<input type=hidden name=Section value="<%=strSection%>">
<input type=hidden name=SecName value="<%=SecName%>">
<input type=hidden name=Loft value="<%=Loft %>">
<input type=hidden name=Build value="<%=strBuilding %>">
<input type=hidden name=cusname value="">
<input type=hidden name=secname value="">
<div align="center">
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
String Cortrol=checke_qx(InsertBean,(String)session.getAttribute("loginid"),"S002");
    if (Cortrol==null)Cortrol="";
 %>
 <table width="80%" border="0" CELLSPACING=1 CELLPADDING=3>
    <tr><td bgcolor='<%=ws1 %>' align="center">未售</td>
	<td bgcolor='<%=rg1 %>'  align="center">认购</td>
	<td bgcolor='<%=qy1 %>'  align="center">签约</td>
	<td bgcolor='<%=yl1 %>'  align="center"><%  if (Cortrol.indexOf("Y")>=0){  %><a href="#" onclick="ylroom();return false;" ><input type=button name=yl value="预  留"  ></a><%}else{ %>预留<%} %></td>
	
	<td bgcolor="<%=ld1 %>"  align="center">临定</td>
	<!--<td bgcolor="<%=cz1 %>"  align="center">出租</td>-->
 
	<td   align="center">
	<select name=condi onchange="submitC();">
	<option value="color">按色块</option>
	<option value="wen">按文字</option>
	<option value="pic">按图标</option>
	
	</select>&nbsp;</td>

	</tr>
	 <tr><td bgcolor='<%=ws1 %>' align="center"><div id=w></div></td>
	<td bgcolor='<%=rg1 %>'  align="center"><div id=r></div></td>
	<td bgcolor='<%=qy1 %>'  align="center"><div id=s></div></td>
	<td bgcolor='<%=yl1 %>'  align="center"><div id=y></div></td>
	<td bgcolor="<%=ld1 %>"  align="center"><div id=l></div></td>
	<!--<td bgcolor='<%=cz1 %>'  align="center"><div id=re></div></td>-->
   <td   align="center"><div id=sum><select name=aa onchange="px(this.value);">
	<option value="asc">楼层升序</option>
	<option value="desc">楼层降序</option>
	</select>&nbsp;</div>
	</td>
	
	</tr>
	 <tr><td bgcolor='<%=ws1 %>' align="center"><div id=w1></div></td>
	<td bgcolor='<%=rg1 %>'  align="center"><div id=r1></div></td>
	<td bgcolor='<%=qy1 %>'  align="center"><div id=s1></div></td>
	<td bgcolor='<%=yl1 %>'  align="center"><div id=y1></div></td>
	<td bgcolor="<%=ld1 %>"  align="center"><div id=l1></div></td>
	<!--<td bgcolor='<%=cz1 %>'  align="center"> <div id=re1></div>-->
	</td>
   <td   align="center"><div id=sum><div id=pri><input type=button name=print value="打 印" title="打印销控表" onclick="printT()"></div></div>
	</td>
	</tr>
	</table>
<br>
  <%// try{   
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
        alert("此栋还没有进行房间资料录入操作");
        //window.location="../basic/RoomCodeShow1.jsp?<%=locaPara %>&notbg=y";
       //}
</script>
		 <%}else{
		 String orderby=getbyte1(request.getParameter("orderby"));
if (orderby.equals(""))orderby="desc";
if (orderby.trim().equals("asc"))orderby="desc";
else orderby="asc";

%> 
<script>
  function px(para){
    if (para=="asc")window.location="RoomCodeShow.jsp?orderby="+para+"&Loft=<%=Loft %>&SecNo=<%=strSection %>&SecName=<%=SecName %>&condi=";
	else window.location="RoomCodeShowD.jsp?orderby="+para+"&Loft=<%=Loft %>&SecNo=<%=strSection %>&SecName=<%=SecName %>&condi=";
   //  document.frm.submit();
  
  }
	
	</script>
	<script>
	function printrgs(para,para1){
    if (para=="")return false;
	 
	 
	  if (para==1)
	    openwin("rgbook.jsp?"+para1,480,500,150,10);
	 
	}
	</script>
	 <%for(int j2=scell;j2<=ecell;j2++){
			if (scell>0){  
			  Rinfo=AsiicZH(j2,CellN1); 
			} %>
  <table width="90%" border="0" CELLSPACING=1 CELLPADDING=3>
   <tr> 
		<td width="100" class=listtitle align="center"><font color="#FFFFFF"<b><%if (!Rinfo.equals("")) {out.print(Rinfo+"单元");}%>楼层\房号</b></font></td>
		<%
		char BeF=RoomNoUp.charAt(0);
		RoomNoUp=RoomNoUp.substring(RoomNoUp.length()-1);
 
        char BeR=RoomNoUp.charAt(0);
		for(int j=intBeginR;j<=intEndR;j++){
	        String NO="";
		   NO=AsiicZH(j,BeR);//调用asiic转换方法
		 
			if (LockRoomS.indexOf(String.valueOf(j))>=0||upp.indexOf(LockRoomS)>=0){
			 if (upp.indexOf(LockRoomS)>=0){
			  
		  
			
			 if (LockRoomS.indexOf(String.valueOf(j))<0){
			%>
		     <td align="center" class=listtitle><font color="#ffffff"><%=NO%></font><!--<input type=checkbox name="Check<%=j%>" value="<%=j%>" checked onclick="LokeRoomNo('<%=strSection%>','<%=Loft %>','<%=j %>',this);">--></td>
			 <%}
			 }else if (!Lock.contains(String.valueOf(j))){//LockRoomS.indexOf(String.valueOf(j))<0
			 %>
			 <td align="center" class=listtitle><font color="#ffffff"><%=NO%></font></td>
			 <%} %>	
			 <%}
			 else{
			 
			 %>
			 <td align="center" class=listtitle><font color="#ffffff"><%=NO%></font><!--<input type=checkbox name="Check<%=j%>" value="<%=j%>" checked onclick="LokeRoomNo('<%=strSection%>','<%=Loft %>','<%=j %>',this);">--></td>
			 
			 <%}
			 
			 }%>
			 
			  <td align="center" class=listtitle><font color="#ffffff">楼层销售均价</font></td>	
	</tr>
	<%
    List list1=new LinkedList();//存放编码
	List list2=new LinkedList();//存放状态
	List list3=new LinkedList();//存放所在FLoor
    List list4=new LinkedList();//存放房号
    List list5=new LinkedList();//存放建筑面积
    List list6=new LinkedList();//存放当前总价
    List list7=new LinkedList();//存放房号
	List list8=new LinkedList();//存放楼层附加字
	List list9=new LinkedList();//存放楼层附加字
		List list10=new LinkedList();//存放是否退过房，而锁定
	List list11=new LinkedList();//存放是否退日期
    String floorshow="",showfloors="";
	String floortype="";
	String floormess="";
    String StrUpper="ABCDEFGHIJKLOPQRST"; 
String sqlArr="select   a.dis, a.tddate,a.Room_code,a.saleState,a.Floor,a.Room,a.area,a.sumprice,a.floorshow,a.floortype,a.floormess,b.showfloors from roomstateview a,roomno b where a.seccode+a.loft+a.room_code= b.SectionNo+b.region+b.roomno and a.seccode=";
		   sqlArr=sqlArr+"'"+strSection+"'";
		   sqlArr=sqlArr+FindStr+" and  a.cell='"+Rinfo+"'  and a.floortype=0   order by a.Floor";
		   ResultSet rsArr=InsertBean1.executeQuery(sqlArr);
 
		   int aryi=0;
		   while (rsArr.next()){
		   list10.add(rsArr.getString("dis"));
			 list11.add(getbyte(rsArr.getString("tddate")));
		    list7.add(rsArr.getString("Room_code"));
			list2.add(rsArr.getString("SaleState"));
			String FloorS=rsArr.getString("Floor");
			String RoomS=rsArr.getString("Room");
			floorshow=rsArr.getString("floorshow");
			floortype=rsArr.getString("floortype");
			list8.add(getbyte(rsArr.getString("floormess")));
			list9.add(getbyte(rsArr.getString("showfloors")));
			list3.add(FloorS);
			list4.add(RoomS);
			if (Integer.parseInt(RoomS)>=10)
			 list1.add(Rinfo+FloorS+RoomS);
			else
			  list1.add(Rinfo+FloorS+"0"+RoomS);
			
			list5.add(rsArr.getString("area"));
			list6.add(rsArr.getString("sumprice"));
			
		   } 
	      rsArr.close();
		int arrlen=0;
	 %>
	<%
	
	
	for(int i=intBeginF;i<=intEndF;i++){
 
	%>
	<tr> 
     <td align="center"  class=FloorC><font color="#ffffff"><div id=w1<%=i %>><%=i%></div</font></td>
		<%
		float IntAvgSumPrice=0;;
		float FatAreaSum=0;
		for(int j=intBeginR;j<=intEndR;j++){
		if (!Lock.contains(String.valueOf(j))){
		String no="";
		String RoomNo="";
		String dis="0",tddate="";
		no="";
	    if (j>=10)
		    RoomNo=Rinfo+String.valueOf(i)+String.valueOf(j);
		else
		    RoomNo=Rinfo+String.valueOf(i)+"0"+String.valueOf(j);
		arrlen+=1;
		
		if (list1.contains(RoomNo)){
		   int index=list1.indexOf(RoomNo);
		   state=(String)list2.get(index);
		   tddate=(String)list11.get(index);
		    dis=(String)list10.get(index);
		    RoomNo=(String)list7.get(index);
			floormess=(String)list8.get(index);
			 	showfloors=(String)list9.get(index); 
		   if(!state.equals("1")){
                      try{
                      String l6=(String)list6.get(index);
                      String l5=(String)list5.get(index);
                     
                      if (l6.equals("")||l6==null)l6="0";
                      if (l5.equals("")||l5==null)l5="0";    
                      IntAvgSumPrice+=Float.parseFloat(l6);
		      FatAreaSum+=Float.parseFloat(l5);
                      }catch(Exception s){}
		   }
		 }else{state="";}  
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
            if (state.equals("3")){ RoomNo="已售"+no;}
            else if (state.equals("2")){ RoomNo="已认购"+no;}
            else if (state.equals("4")){ RoomNo="已预留"+no;}
          //  else if (state.equals("6")){ RoomNo="已鉴证"+no;}
			else if (state.equals("1")){ RoomNo="未售"+no;}
			else if (state.equals("5")){ RoomNo="临定"+no;} 
			else if (state.equals("7")){ RoomNo="出租"+no;} 
		 }else if (condi.equals("pic")){
		    if (state.equals("2")){ RoomNo="<img src='../picture/rg.gif' border='0' title='已认购房号："+no+"'>";}
			else if (state.equals("3")){ RoomNo="<img src='../picture/sale.gif' border='0' title='已售房号："+no+"' >";}
			else if (state.equals("1")){ RoomNo=no;}
			else if (state.equals("5")){ RoomNo="<img src='../picture/ld.gif' border='0' title='已临定房号："+no+"'>";}
			else if (state.equals("2")){ RoomNo=no;}
			else if (state.equals("4")){ RoomNo="<img src='../picture/yl.gif' border='0' title='已预留房号："+no+"'>";}
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
	  <td align="center"  <%=bg %> <%if (dis.equals("1")){out.print("title='客户在"+tddate+"退过房，在30天之内不能再认购'");} %>>
	
	 <% if (state.equals("1")&&dis.equals("0")){nosalenum++; %>
	<%  if (Cortrol.indexOf("A")>=0){  %> <input type=checkbox name=yl value="<%=RoomNo %>"><a href="#<%=RoomNo %>" onclick="opennewwin('roomdata.jsp','?secname=<%=SecName %>&secno=<%=strSection%>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&state=1',680,530,120,5)"><%} %><%=RoomNo.substring(RoomNo.indexOf("-")+1)%><%  if (Cortrol.indexOf("A")>=0){  %></a><%} %>
	   <% }else if (state.equals("1")&&dis.equals("1")){  %>
	   <a href="#"> <%=RoomNo.substring(RoomNo.indexOf("-")+1)%>[锁定] </a>
	
	  <%}else if (state.equals("3")){ salenum++;%>
       <%=RoomNo.substring(RoomNo.indexOf("-")+1)%> 
	 <%}else if (state.equals("2")){rgnum++;%>
	   <a href="#<%=RoomNo %>" title="如果未打印认购书,可修改认购书" onclick="opennewwin('modiorder.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&show=false',690,500,100,10)"><%=RoomNo%></a> 
	
	
	 <SELECT NAME=PR title="请选择打印类型" onchange="printrgs(this.value,'secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>');"><option >选择</option><option value=1>打印认购书</option></select>
	  
	 <%}else if (state.equals("4")){yl++;%>
	<%  if (Cortrol.indexOf("Y")>=0){  %>   <input type=checkbox name=yl value="<%=RoomNo %>"><a href="#<%=RoomNo %>" onclick="choose('<%=RoomNo%>');ylroom();"><%} %><%=RoomNo.substring(RoomNo.indexOf("-")+1)%><%  if (Cortrol.indexOf("A")>=0){  %></a><%} %>
	 <%}else if (state.equals("6")){ %>
	  <a href="#<%=RoomNo %>" onclick="opennewwin('ContractList.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&show=false',480,500,150,10)"><%=RoomNo%></a> 
	  <%}else if (state.equals("5")){ ld++;%>
	  <a href="#<%=RoomNo %>" onclick="opennewwin('roomdata1.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&state=5',680,530,120,5)"><%=RoomNo.substring(RoomNo.indexOf("-")+1)%></a>
	 <%} else if (state.equals("7") ){%>
	 <a href="#<%=RoomNo %>" onclick="opennewwin('show_rent_contract.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&state=5',680,530,120,5)"> <%=RoomNo.substring(RoomNo.indexOf("-")+1)%></a>
	 <%}else{ %>&nbsp;<%} %>
	 </td> 
		<%}%>
	
		<%}

%>
	 <td><%if (IntAvgSumPrice>0){out.println(FormtD.getFloat(IntAvgSumPrice/FatAreaSum,2));} %></td>	
	 <script>w1<%=i %>.innerHTML="<% if (!floormess.equals("")&&!showfloors.equals("")) out.print(String.valueOf(i)+floormess);else if (!floormess.equals("")&&showfloors.equals(""))  out.print(floormess);else  out.print(i);%>";</script>
	
	</tr>
	
	
	<%
	}
	for(int i=mxinF;i<=-1;i++){
	%>
	<tr> 
     <td align="center"  class=FloorC><font color="#ffffff"><div id="A<%=String.valueOf(java.lang.Math.abs(i)) %>w1"><%=i%></div></font></td>
		<%
		float IntAvgSumPrice=0;;
		float FatAreaSum=0;
		for(int j=intBeginR;j<=intEndR;j++){
		if (!Lock.contains(String.valueOf(j))){
		String no="";
		String RoomNo="";
		String dis="0",tddate="";
		no="";
	    if (j>=10)
		    RoomNo=String.valueOf(i)+String.valueOf(j);
		else
		    RoomNo=String.valueOf(i)+"0"+String.valueOf(j);
		arrlen+=1;
		
		if (list1.contains(RoomNo)){
		   int index=list1.indexOf(RoomNo);
		    state=(String)list2.get(index);
			tddate=(String)list11.get(index);
		   state=(String)list2.get(index);
		    RoomNo=(String)list7.get(index);
			floormess=(String)list8.get(index);
			showfloors=(String)list9.get(index); 
			  if(!state.equals("1")){
                      try{
                      String l6=(String)list6.get(index);
                      String l5=(String)list5.get(index);
                     
                      if (l6.equals("")||l6==null)l6="0";
                      if (l5.equals("")||l5==null)l5="0";    
                      IntAvgSumPrice+=Float.parseFloat(l6);
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
            if (state.equals("3")){ RoomNo="已售"+no;}
            else if (state.equals("2")){ RoomNo="已认购"+no;}
            else if (state.equals("4")){ RoomNo="已预留"+no;}
            else if (state.equals("6")){ RoomNo="已鉴证"+no;}
			else if (state.equals("1")){ RoomNo="未售"+no;}
			else if (state.equals("5")){ RoomNo="临定"+no;} 
			else if (state.equals("7")){ RoomNo="出租"+no;} 
		 }else if (condi.equals("pic")){
		    if (state.equals("2")){ RoomNo="<img src='../picture/rg.gif' border='0' title='已认购房号："+no+"'>";}
			else if (state.equals("3")){ RoomNo="<img src='../picture/sale.gif' border='0' title='已售房号："+no+"' >";}
			else if (state.equals("1")){ RoomNo=no;}
			else if (state.equals("5")){ RoomNo="<img src='../picture/ld.gif' border='0' title='已临定房号："+no+"'>";}
			else if (state.equals("2")){ RoomNo=no;}
			else if (state.equals("4")){ RoomNo="<img src='../picture/yl.gif' border='0' title='已预留房号："+no+"'>";}
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
	 <td align="center"  <%=bg %> <%if (dis.equals("1")){out.print("title='客户在"+tddate+"退过房，在30天之内不能再认购'");} %>>
	
	 <% if (state.equals("1")&&dis.equals("0")){nosalenum++; %>
	<%  if (Cortrol.indexOf("A")>=0){  %> <input type=checkbox name=yl value="<%=RoomNo %>"><a href="#<%=RoomNo %>" onclick="opennewwin('roomdata.jsp','?secname=<%=SecName %>&secno=<%=strSection%>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&state=1',680,530,120,5)"><%} %><%=RoomNo.substring(RoomNo.indexOf("-")+1)%><%  if (Cortrol.indexOf("A")>=0){  %></a><%} %>
	  <% }else if (state.equals("1")&&dis.equals("1")){  %>
	   <a href="#"> <%=RoomNo.substring(RoomNo.indexOf("-")+1)%>[锁定] </a>
	
	 <%}else if (state.equals("2")){rgnum++; %>
       <a href="#<%=RoomNo %>" onclick="opennewwin('modiorder.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&show=false',690,500,100,10)"><%=RoomNo.substring(RoomNo.indexOf("-")+1)%></a> 
	 <SELECT NAME=PR title="请选择打印类型" onchange="printrgs(this.value,'secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>');"><option >选择</option><option value=1>打印认购书</option></select>
	
	 <%}else if (state.equals("3")){salenum++;%>
	  <%=RoomNo.substring(RoomNo.indexOf("-")+1)%> 
	 <%}else if (state.equals("4")){yl++;%>
	<%  if (Cortrol.indexOf("Y")>=0){  %>   <input type=checkbox name=yl value="<%=RoomNo %>"><a href="#<%=RoomNo %>" onclick="choose('<%=RoomNo%>');ylroom();"><%} %><%=RoomNo.substring(RoomNo.indexOf("-")+1)%><%  if (Cortrol.indexOf("A")>=0){  %></a><%} %>
	 <%}else if (state.equals("6")){ %>
	  <a href="#<%=RoomNo %>" onclick="opennewwin('ContractList.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&show=false',480,500,150,10)"><%=RoomNo%></a> 
	  <%}else if (state.equals("5")){ ld++;%>
	  <a href="#<%=RoomNo %>" onclick="opennewwin('roomdata1.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&state=5',680,530,120,5)"><%=RoomNo.substring(RoomNo.indexOf("-")+1)%></a>
	 <%} else if (state.equals("7") ){%>
	 <a href="#<%=RoomNo %>" onclick="opennewwin('show_rent_contract.jsp','?secname=<%=SecName %>&secno=<%=strSection %>&roomno=<%=no%>&build=<%=strBuilding%>&loft=<%=Loft %>&Floor=<%=i %>&state=5',680,530,120,5)"> <%=RoomNo.substring(RoomNo.indexOf("-")+1)%></a>
	 <%}else{ %>&nbsp;<%} %>
	 </td>
		<%}%>
	
		<%}

%>
	 <td><%if (IntAvgSumPrice>0){out.println(FormtD.getFloat(IntAvgSumPrice/FatAreaSum,2));} %></td>	
	  <script>A<%=String.valueOf(java.lang.Math.abs(i))%>w1.innerHTML="<%if (!floormess.equals("")&&!showfloors.equals("")) out.print(String.valueOf(i)+floormess);else if (!floormess.equals("")&&showfloors.equals(""))  out.print(floormess);else  out.print(i);%>";</script>
	
	</tr>
	
	
	<%}
	}%>
  </table>
  <%} %>
  <script>
  function opennewwin(url,para,wh,hg,lf,tp) {
    var mess="是否认购登录还是查看资料？(如果是认购请单击‘确认’)";
	 var newwin=window.open(url+para,"newwin1","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
	
  }
  function printT(){
  pri.innerHTML="";
  print();
  
  }
  function opennewwin1(para,wh,hg,lf,tp) {
    
	
	var newwin=window.open("rgList.jsp?"+para,"newwin1","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,width=480,height=500,left=150,top=10");
	
  }
  
  w.innerHTML = "<%=nosalenum %>";
  w1.innerHTML = "<%=FormtD.getFloat(Float.parseFloat(String.valueOf(nosalenum))/(ld+nosalenum+yl+salenum+rgnum)*100,2) %>%";
  r.innerHTML = "<%=rgnum %>";
  r1.innerHTML = "<%=FormtD.getFloat(Float.parseFloat(String.valueOf(rgnum))/(ld+nosalenum+yl+salenum+rgnum)*100,2) %>%";
  s.innerHTML = "<%=salenum %>";
  s1.innerHTML = "<%=FormtD.getFloat(Float.parseFloat(String.valueOf(salenum))/(ld+nosalenum+yl+salenum+rgnum)*100,2) %>%";
  y.innerHTML = "<%=yl %>";
  y1.innerHTML = "<%=FormtD.getFloat(Float.parseFloat(String.valueOf(yl))/(ld+nosalenum+yl+salenum+rgnum)*100,2) %>%";
  l.innerHTML = "<%=ld %>";
  l1.innerHTML = "<%=FormtD.getFloat(Float.parseFloat(String.valueOf(ld))/(ld+nosalenum+yl+salenum+rgnum)*100,2) %>%";
 // re.innerHTML = "<%=rentnum %>";
  //re1.innerHTML = "<%=FormtD.getFloat(Float.parseFloat(String.valueOf(rentnum))/(ld+nosalenum+yl+salenum+rgnum)*100,2) %>%";

  sum.innerHTML = "合计：<%=ld+nosalenum+yl+salenum+rgnum+rentnum %>";
   
  </script>
<%//}catch(Exception s){}%>
<%InsertBean.closeConn();
    InsertBean1.closeConn();
 
   %>
</form>  
</div>
</body>
</html>
