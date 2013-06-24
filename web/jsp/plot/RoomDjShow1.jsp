<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>房间编号列表</title>
</head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="javascript" src="../public_js/public.js"></script>
<body>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/asiic.jsp"%>
<%
String strMessage=request.getParameter("mess");
String SecName=China.getParameter(request,"SecName");
String strSection=request.getParameter("SecNo");
String Region=China.getParameter(request,"Loft");
String RegionStr="";
float AllSumArea=0;
int AllSumPrice=0;
int AllSumNum=0;
String state="";
String fontColor="";
int tab=0;
if (strMessage==null){strMessage="";}

String strYN=request.getParameter("yn");
   String strBuilding="";//(String)session.getAttribute("sess_build");
   strBuilding=China.getParameter(request,"Build");

   

String sql1="select lockroom from lockroom where section ='"+strSection+"' and ";
sql1+=" loft='"+Region+"' and build='"+strBuilding+"'";
ResultSet rsLock=null;
String LockRoomS="";
List Lock=new LinkedList();//存放禁用号
try{
  rsLock=InsertBean.executeQuery(sql1);
  
  while (rsLock.next()){
    String aaa=rsLock.getString("LockRoom");
	 Lock.add(aaa);
    if (LockRoomS.equals(""))
     LockRoomS=aaa;
	else
	 LockRoomS+=","+aaa;
     
 
  }
  rsLock.close();
}catch(Exception s)  {}



String  sql="select min(Floor) as BeginF,max(Floor) as EndF,";
		sql=sql+"min(Room) as BeginR,max(Room) as EndR from";
		sql=sql+" roomno where SectionNo='"+strSection+"'";
		sql=sql+" and building='"+strBuilding+"' and region='"+Region+"'";// and SaleState in (1,2,3,4)";
ResultSet rs=InsertBean.executeQuery(sql);
 int intBeginF=0;
 int intEndF=0;
 int intBeginR=0;
 int intEndR=0;
 int i=0;
if (rs.next()){
  intBeginF=rs.getInt("BeginF");
  intEndF=rs.getInt("EndF");
  intBeginR=rs.getInt("BeginR");
  intEndR=rs.getInt("EndR");

}
rs.close();
%> 
<script>

 function Validate(){
    if (document.frm.basicRoom.value=="")
    {alert("请输入基价房号");
	document.frm.basicRoom.focus();
    return false;
    }
    document.frm.action="ChangePriceList1.jsp";
	document.frm.submit();
  }
  function countAvg(para1,para2){
  openwin("countAvg.jsp?SecNo="+para1+"&Loft="+para2,300,230,300,300);
  
  }
</script>

<div align="center">
<form method="post" action="" name=frm >
<table width="100%" border="0">
  <tr class=roomright> 
    <td width="46%" >请选择调价对象：
	<select name="dj">
	<option value="tnjj">按套内面积</option>
	<option value="jzjj">按建筑面积</option>
	</select></td>
	<td>基价<input type=text size=5 name=basicRoom value=0><input type=button name=avg value="计算均价" onclick="countAvg('<%=strSection %>','<%=Region %>');">
	<input type=radio name="choosetype"  value=1 title="选中表示在基点房号价上增加或降低多少元">固定金额<input type=radio checked name="choosetype" value=2 title="选中表示在基点房号价上增加或降低多少个百分点">百分比
	<input type=button  name=Ok1  onclick="Validate();" value="提交" >
	<input type=hidden name=Ok value="ok">
 </td>
  </tr>
  </table>
 

	
	
	<!--<a href="" onMouseOut="MM_showHideLayers('ebusiness','','hide');"  onMouseOver="MM_showHideLayers('ebusiness','','show');"><img src="../picture/helpgif.gif" border="0" title="帮助"></a>-->
	<input type=hidden name=SecNo value="<%=strSection %>">
    <input type=hidden name=Loft value="<%=Region %>">
    <input type=hidden name=SecName value="<%=SecName %>">
    <input type=hidden name=Build value="<%=strBuilding %>">
    <input type=hidden name=choose>
    <input type=hidden name=RegionNA value="<%=RegionStr %>">
    <input type=hidden name=RegionNO value="<%=Region %>">
    <input type=hidden name=SectionNA value="<%=SecName %>">
    <input type=hidden name=SectionNO value="<%=strSection %>">
    <input type=hidden name=intEndR value="<%=intEndR %>">
    <input type=hidden name=intEndF value="<%=intEndF %>">
    <input type=hidden name=intBeginR value="<%=intBeginR %>">
    <input type=hidden name=intBeginF value="<%=intBeginF %>">
  <table width="100%" border="0">
    <tr class=roomright>
      <td>
        &nbsp;楼&nbsp;&nbsp;盘:
      </td>
      <td>
     <%=SecName %>
      </td>
	   <td>
      区号/阁名:
      </td>
      <td>
        <%=Region %>
      </td>
      <td>
        栋号/座号:
      </td>
      <td>
       <%=strBuilding %>
      </td>
    </tr>
		<tr><td nowrap=6>禁用房号：<%=LockRoomS %></td></tr>
  </table>
   <% StringTokenizer st22 = new StringTokenizer(LockRoomS,",") ;
    int count22 = st22.countTokens() ;
		String locaPara="Loft="+Region+"&Build="+strBuilding+"&SecNo="+strSection+"&SecName="+SecName;
		String upp="ABCDEFGHIJKOPQRST";
		upp=upp.trim();
		int nn=0;
        String RoomNoUp="";
		String  sqlU="select top 1 RoomNo,state from RoomNo where SectionNo=";
				sqlU=sqlU+"'"+strSection+"' and Building='";
				sqlU=sqlU+strBuilding+"' and Region='"+Region+"'";
		ResultSet rsU=InsertBean1.executeQuery(sqlU);
        if (rsU.next())RoomNoUp=rsU.getString("RoomNo");
		rsU.close();
        if (RoomNoUp.equals("")){
		%>
		<script>
       alert("此栋还没有进行房间编号操作"))
       // window.location="../basic/RoomCodeInput.jsp?<%=locaPara %>";
      // }
</script>
		 <%}else{%>
  <table width="100%" border="0" cellspacing="1" cellpadding="1"  onMouseOver="MM_showHideLayers('ebusiness','','show');" onMouseOut="MM_showHideLayers('ebusiness','','hide')">
    <tr>
		<td width="100" bgcolor="#489A80" align="center"><font color="#FFFFFF"<b>楼层\房间</b></font></td>
		<%
		RoomNoUp=RoomNoUp.substring(RoomNoUp.length()-1);
        char BeR=RoomNoUp.charAt(0);

		//int nn=0;
		for(int j=intBeginR;j<=intEndR;j++){
			if (LockRoomS.indexOf(String.valueOf(j))>=0||upp.indexOf(LockRoomS)>=0){
        
			 if (upp.indexOf(LockRoomS)>=0){
			   String NO="";
			     NO=AsiicZH(j,BeR);//调用asiic转换方法
				 
			 if (LockRoomS.indexOf(NO)<0){
			%>
		     <td align="center" class=listtitle><font color="#ffffff"><%=NO%></font></td>
			 <%}
			 }else if (!Lock.contains(String.valueOf(j))){
			 %>
			 <td align="center" class=listtitle><font color="#ffffff"><%=j%></font></td>
			 <%} %>	
			 <%}else{%>
			 <td align="center" class=listtitle><font color="#ffffff"><%=j%></font></td>
			 
			 <%}
			 
			 }%>  <td align="center" class=listtitle><font color="#ffffff">楼层均价</font></td>	
	</tr>
		  
	<%
	List list1=new LinkedList();//存放房间编码
	List list2=new LinkedList();//存放房间状态
	List list3=new LinkedList();//存放所在FLoor
    List list4=new LinkedList();//存放房号
	List list5=new LinkedList();//存放建筑面积
    List list6=new LinkedList();//存放当前总价
	List list9=new LinkedList();//
	int arryFloor[]=new int[1];//临时保存楼层号
    String StrUpper="ABCDEFGHIJKHOPQ"; 
	String sqlArr="select  distinct Room_code,saleState,Floor,Room,area,Sumprice from roomstateview where seccode=";
		   sqlArr=sqlArr+"'"+strSection+"'";
		   sqlArr=sqlArr+" and  loft='"+Region+"' and building='"+strBuilding+"'  and SaleState in (1,2,3,4,5,6,8)  order by  Floor";
		   ResultSet rsArr=InsertBean1.executeQuery(sqlArr);
		
		   int aryi=0;
		   while (rsArr.next()){
		    
		    list1.add(getbyte(rsArr.getString("Room_code")));
			list2.add(getbyte(rsArr.getString("SaleState")));
			String flo=getbyte(rsArr.getString("Floor"));
			list3.add(flo);
			String roo=getbyte(rsArr.getString("Room"));
			list4.add(roo);
			list9.add(flo+"|"+roo);
			list5.add(getbyte(rsArr.getString("area")));
			list6.add(getbyte(rsArr.getString("Sumprice")));
			//out.println(RoomArry[aryi]);
		   } 
	      rsArr.close();
		int arrlen=0;
	 %>
	<%for(int iii=intBeginF;iii<=intEndF;iii++){%>
	<tr >
		<%
		int IntAvgSumPrice=0;;
		float FatAreaSum=0;
		for(int j=intBeginR;j<=intEndR;j++){
		String RoomNo="";
		String no="";
		//if(!java.lang.Character.isDigit(BeR)){
		 // try{ RoomNo=String.valueOf(iii)+StrUpper.substring(j-1,j);}//如果房间编码是字母
		 // catch(Exception s){out.close();}
		 // }else{
		   //if (j>=10)
		    RoomNo=String.valueOf(iii)+"|"+String.valueOf(j);
		   //else
		   // RoomNo=String.valueOf(iii)+"0"+String.valueOf(j);
		// }
		arrlen+=1;
		if (list9.contains(RoomNo)){
		   int index=list9.indexOf(RoomNo);
		   RoomNo=(String)list1.get(index);//取出由楼层+房间号对应的房间编码
		 
		   state=(String)list2.get(index);
		   no=(String)list4.get(index);
                               String l6=(String)list6.get(index);

                               String l5=(String)list5.get(index);

                             if (l6.equals(""))l6="0";

                             if (l5.equals(""))l5="0";

		   IntAvgSumPrice+=Float.parseFloat(l6);

		   FatAreaSum+=Float.parseFloat(l5);
		   AllSumArea+=Float.parseFloat(l5);
		   AllSumPrice+=Float.parseFloat(l6);

		   AllSumNum++;
		 }else{state="";}  

	
		
		/* if (state.equals("2")){ state="bgcolor='#00CCFF'"; }
		 if (state.equals("3")){ state="bgcolor='#CCFFCC'";}
		 if (state.equals("4")){ state="bgcolor='#FFCC66'";}
		 if (state.equals("6")){ state="bgcolor='#AACC6F'";}
	*/
	      String FloorNo=RoomNo.substring(0,1);
		 char FloNo=FloorNo.charAt(0);//判断楼层是否以字母编号
		
		if (arryFloor[0]!=iii){
		 arryFloor[0]=iii;
		 %>
   		<td align="center" class=FloorC><font color="#ffffff"><%=AsiicZH(iii,FloNo)%></font></td>
		<%}  
		String fontcolor="";
		 if (!Lock.contains(String.valueOf(j))){ 
		%>
	     <td align="center"  class=listcontent >
	     <% if (state.equals("0")){ 
	     %>
	     <a href="#" onclick="javascript:openwin('../basic/RoomEdit.jsp?loft=<%=Region %>&seccode=<%=strSection%>&building=<%=strBuilding%>&Floor=<%=iii%>&Room_code=<%=RoomNo%>&MaxFloor=<%=intEndF%>&BengR=<%=no %>&EndR=<%=no %>&RoomNoType=<%=RoomNo %>',400,500,150,10);" title="显示房间资料"> 
 	    <%}else if (state.equals("1")){
	       fontcolor="<font color='red'>";
	     %>
 	       <a href="#" onclick="javascript:openwin('../basic/RoomEdit.jsp?loft=<%=Region %>&seccode=<%=strSection%>&building=<%=strBuilding%>&Floor=<%=iii%>&Room_code=<%=RoomNo%>&MaxFloor=<%=intEndF%>&BengR=<%=no %>&EndR=<%=no %>&RoomNoType=<%=RoomNo %>',400,500,150,10);" title="显示房间资料"> 
	     <%} %>
	  
	    
	  <%if (!state.equals("")){ %>
	  <%=fontcolor %>
	    <%=RoomNo%></font>
		</a>
   <% if (state.equals("1")){%>
	   <input type="text" size=4 name="P<%=iii%><%=j %>" tab=<%=++tab%>  onkeydown="key1(this);"  onblur="checkedvalue(this);" title="在数字前必须带'+'或'-'"><input type=hidden name="Pr<%=iii%><%=j %>" value="<%=RoomNo%>">
	   <%}else if (state.equals("8")){out.print("<br>已租");} 
	     else{ out.print("<br>已售");}
	   %>
	   </td> 
		<%   
        }
		}
		}%>
		 <td><b><u><%=FormtD.getFloat(IntAvgSumPrice/FatAreaSum,2) %></u></b></td>	
	

	</tr>
	
	 <script>
	  function butoncheck(){
	  // document.frm.Ok.disabled=getseldocs1();//!(frm.checked);
	  }
	  
	  function ChangePrice(frm){
	  if (frm.checked)document.frm.price.value=0;
	  
	  
	  }
	   </script>
	<% }%>
	 <%
   sql="select count(*) nn,sum(area) area,sum(Sumprice) Sumprice,SaleState from room where seccode='"+strSection+"' and SaleState='1' and loft='"+Region+"' and building='"+strBuilding+"'"+"group by SaleState ";
  try{
  rsLock=InsertBean.executeQuery(sql);
  if (rsLock.next()){
    AllSumNum=rsLock.getInt("nn");
	AllSumArea=rsLock.getFloat("area");
	AllSumPrice=rsLock.getInt("Sumprice");
  }
  rsLock.close();
 }catch(Exception s)  {out.print(s.getMessage());}     
   %>
    <%
	int AllSumNum_S=0;
	float AllSumArea_S=0;
	int AllSumPrice_S=0;
   sql="select count(*) nn,sum(jzarea) area,sum(salerprice*rate) Sumprice from order_contract where  section='"+strSection+"' and  loft='"+Region+"' and building='"+strBuilding+"'";
  try{
  rsLock=InsertBean.executeQuery(sql);
  if (rsLock.next()){
    AllSumNum_S=rsLock.getInt("nn");
	AllSumArea_S=rsLock.getFloat("area");
	AllSumPrice_S=rsLock.getInt("Sumprice");
  }
  rsLock.close();
 }catch(Exception s)  {out.print(s.getMessage());}     
   %>
 
  
  <table width="100%" border="1" cellspacing='0'  cellpadding='2' bgcolor=ffffff  >
  <tr align="center" class="TITLE"> 
    <td >&nbsp;序号</td>
    <td >未售套数</td>
    <td >已售套数</td>
    <td >未售建筑面积</td>
    <td >已售建筑面积</td>
    <td>未售均价</td>
    <td>已售均价</td>
  </tr>
  <tr align="center" > 
    <td >&nbsp;1</td>
    <td >&nbsp;<%=AllSumNum %></td>
    <td >&nbsp;<%=AllSumNum_S%></td>
    <td >&nbsp;<%=FormtD.getFloat(AllSumArea,4) %>M<sup>2</sup></td>
    <td >&nbsp;<%=FormtD.getFloat(AllSumArea_S,4) %>M<sup>2</sup></td>
    <td>&nbsp;<%=FormtD.getFloat(AllSumPrice/AllSumArea,2) %></td>
    <td>&nbsp;<%=FormtD.getFloat(AllSumPrice_S/AllSumArea_S,2) %></td>
  </tr>
  <tr align="center"> 
    <td >&nbsp;小计</td>
    <td colspan="2" >&nbsp;<%=AllSumNum+AllSumNum_S %></td>
    <td colspan="2" >&nbsp;<%=AllSumArea+AllSumArea_S %>M<sup>2</sup></td>
    <td colspan="2">&nbsp;<%=(AllSumPrice_S+AllSumPrice)/(AllSumArea+AllSumArea_S ) %></td>
  </tr>
</table>

 
  <%} %>
  <script>
  function getseldocs1() {//indexstring
     var x=0;
	// var seldocs = new Array();
	var aa="";
	 var temp=frm.elements.length;
     for (i=0;i<frm.elements.length;i++) {
       if ((frm.elements[i].type=="checkbox")&&(frm.elements[i].checked)&&(frm.elements[i].name.substring(0,1)=="P"))
		 {
       		aa=frm.elements[i].checked;
			
   		 }
	  }	
   return aa;
}
  function key1(para){
     var myform="";
	 var nexttab=0;
     if (event.keyCode==13){
	 tab=para.tab;
 	// check(para);
	 var StrValue=para.value;
	 /*if (StrValue!=""){
	 if (StrValue.indexOf("+")==-1&&StrValue.indexOf("-")==-1){
	   alert("请在数字前加'+'或'-'");
	   para.focus();
	   return false;
	 }
	 }*/
	 nexttab=parseInt(tab)+1;
     myform=para.form;

	}
	
	  for(i=0;i<frm.elements.length;i++){
	     if(frm.elements[i].tab==nexttab){
		    frm.elements[i].focus();
			 break;
		 }
  	}	 

  }	
  function checkedvalue(th){
    var thisvalue=th.value;
	if (thisvalue!=""){
	 if (isNaN(thisvalue)){
	   alert("请输出数字型数值");
	   th.focus();
	   th.select();
	   return false;
	  }
	 }
	 if (thisvalue!=""&&thisvalue.indexOf("+")<0&&thisvalue.indexOf("-")<0){
	 th.value="+"+thisvalue;
	 }
  }
  </script>
</form>  
</div>
</body>
</html>
