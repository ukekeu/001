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
<script>
 
  
function outdate1(){
  var dd=new Date();
  //document.forms[0].projectdate.value=String(dd.getYear())+"-"+String(dd.getMonth()+1)+"-"+String(dd.getDate());
}

function confirmClose(){
  if (confirm("确认退出吗?"))window.close();

}
</script>
<style>
.buttoninput{
    border:1px ridge #BADCFF;
    background-color:#BADCFF;
    height:18px;
    font:normal 12px 宋体;
    color:#000000;
    cursor:hand;
 }
</style>
<body onload="outdate1();">
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 

<%!  String room4="";
     int loftnum=0;
	 public String ShowTax1(String sqlstr,String type5,String strSection,String Region,String room5) throws Exception  {
	  String SqlStr = sqlstr;
	  String  str="";
	  
	  String state="";
	  float modulus=0;
      String type4=type5;
	  String strSection4=strSection;
	  String Region4=Region;
	  room4=room5;
	  String floors="";
	 ConnDatabase.SDatabase ViewBean1=new ConnDatabase.SDatabase();
	 ConnDatabase.SDatabase ViewBean2=new ConnDatabase.SDatabase();
	 ResultSet Rs = null;
	 ResultSet TaxRs = ViewBean1.executeQuery(SqlStr);
	 FormatData.FormatData formatD1=new FormatData.FormatData();
		if (TaxRs.next()) {
		int id=TaxRs.getInt("id");
		String  TYPE = getbyte(TaxRs.getString("TYPE"));
		 modulus=TaxRs.getFloat("modulus");		
		 floors=""+modulus;
         
  str+="<td align='center' class='listcontent'><input type='text' name=X"+type4+room4+" size='3' value="+modulus+"  onblur='check(this);gettotal(\""+room4+"\")'></td>"; 

}else{  
  str+="<td align='center' class='listcontent'><input type='text' name=X"+type4+room4+" size='3' value='1.0' onblur='gettotal(\""+room4+"\")'></td>"; 
} TaxRs.close();
 return str;
}
%>
<%@ include file="../public_js/getByteOut.jsp"%>
<%
    List list1=new LinkedList();//
	List list2=new LinkedList();//
	List list3=new LinkedList();//
    List list4=new LinkedList();//
	List list5=new LinkedList();//
    List list6=new LinkedList();//
	List list7=new LinkedList();//
	List list8=new LinkedList();//
	List list9=new LinkedList();//
	List list10=new LinkedList();//
	List list11=new LinkedList();//
    List list12=new LinkedList();//
    List list13=new LinkedList();//
 page=request.getParameter("page");
  if(page==null){
     page="1";
  }
int tab=0;
String strMessage=request.getParameter("mess");
String SecName=China.getParameter(request,"SecName");
String strSection=request.getParameter("SecNo");
String Region=request.getParameter("Loft");
String RegionStr="";
float AllSumArea=0;
int AllSumPrice=0;
int AllSumNum=0;

String state="";
String fontColor="";
if (strMessage==null){strMessage="";}

String strYN=request.getParameter("yn");
   String strBuilding="";//(String)session.getAttribute("sess_build");
   strBuilding=request.getParameter("Build");

   

String sql1="select lockroom from lockroom where section ='"+strSection+"' and ";
sql1+=" loft='"+Region+"' and build='"+strBuilding+"'";
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
}catch(Exception s)  {out.print("err");}     

sql1="select name from CRM_Project  where serialno ='"+strSection+"'";
 rsLock=InsertBean.executeQuery(sql1);
  if (rsLock.next()){
    SecName=getbyte(rsLock.getString("name"));
  }rsLock.close();


String  sql="select min(Floor) as BeginF,max(Floor) as EndF,";
		sql=sql+"min(Room) as BeginR,max(Room) as EndR from";
		sql=sql+" roomno where SectionNo='"+strSection+"'";
		sql=sql+" and building='"+strBuilding+"' and region='"+Region+"'";// and SaleState in (1,2,3,4)";
ResultSet rs=InsertBean.executeQuery(sql);
 int intBeginF=0;
 int intEndF=0;
 int intBeginR=0;
 int intEndR=0;
if (rs.next()){
  intBeginF=rs.getInt("BeginF");
  intEndF=rs.getInt("EndF");
  intBeginR=rs.getInt("BeginR");
  intEndR=rs.getInt("EndR");

}
 
rs.close();
double loftModulus=1.0;
sql="select Modulus  from ModulesSet2 where  section ='"+strSection+"' and ";
sql+=" loft='"+Region+"'";
rs=InsertBean.executeQuery(sql);
if (rs.next()){
   loftModulus=rs.getDouble("Modulus");
}
rs.close();
double totalmodulus=1.0;
sql="select sum(Modulus) as total  from ModulesSet2 where  section ='"+strSection+"' ";
sql+="and loft<>'"+Region+"'";
rs=InsertBean.executeQuery(sql);
if (rs.next()){
   totalmodulus=rs.getDouble("total");
}
rs.close();

%> 

<div align="center">
<form method="post" action="" name=frm onsubmit="return Validate(this);" target="_blank">
 <input type="hidden" name="page" value="">
 <input type=hidden name=sum value="0">
 <input type="hidden" name="dj" value="ykjS">
 <input type="hidden" name="condition" value="">
 <input type="hidden" name="begin" value="">
 <input type="hidden" name="end" value="">
 <input type="hidden" name="price" value="">
 <input type="hidden" name="total" value="">
 <input type="hidden" name="totalmodulus2"  value="<%=totalmodulus%>">
 <input type="hidden" name="totalmodulus" value="<%out.print(totalmodulus+loftModulus);%>">
<input type="hidden" name="floor1" value="">
<input type="hidden" name="floor2" value="">
<input type="hidden" name="fixmodulus" value="">

<table width="100%" border="0"> 
 <!-- <tr class=roomright> 
    <td width="46%" >方案名称：
	<input type="Text" name="projectname" size="18">
	&nbsp;&nbsp;录入时间
	<input type="Text" name="projectdate" size="18" readonly>
	</td>
  </tr>

  <tr class=roomright> 
    <td width="46%" >制定人：
	<input type="Text" name="name" size="18">
	&nbsp;&nbsp;楼栋系数
	<input type="Text" name="loftmodulus" size="18" value="<%=loftModulus%>" onchange="if(document.frm.loftmodulus.value!='')document.frm.totalmodulus.value=parseFloat(document.frm.loftmodulus.value)+parseFloat(document.frm.totalmodulus2.value)">
	</td>
  </tr>
 
  <tr class=roomright> 
    <td width="46%" >基准楼层：
	<input type="text" name="basicfloor" size="18" value="1" onchange="getmodulus();">
	&nbsp;&nbsp;楼层浮动系数
	<input type="Text" name="floormodulus" size="18" value="0" onchange="getmodulus();">
	</td>
  </tr>-->
  <input type="hidden" name="basicfloor" size="18" value="1" onchange="getmodulus();">
  <input type="hidden" name="floormodulus" size="18" value="0" onchange="getmodulus();">
   <tr class=roomright> 
    <td width="46%" >均价：
	<input type="Text" name="basicprice" size="18" onblur="check(this);">
	<!--&nbsp;&nbsp;<%=SecName%><%=Region%>总价-->
	<input type="hidden" name="totalprice" size="18" onblur="check(this);" onchange="getprice();">

&nbsp;&nbsp;楼栋系数
	<input type="Text" name="loftmodulus" size="18" value="<%=loftModulus%>" onchange="if(document.frm.loftmodulus.value!='')document.frm.totalmodulus.value=parseFloat(document.frm.loftmodulus.value)+parseFloat(document.frm.totalmodulus2.value)">
	</td>
  </tr>
  <tr class=roomright>
  <td colspan="2">
   <input type="button" name="ss" size="18" value="楼层浮动系数" onclick="window.open('owner_find.jsp','','300','300');">
  </tr>
  </table>
<%@ include file="../public_js/CodeSele.jsp"%>

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
        栋号/座号:
      </td>
      <td>
       <%=Region %>
      </td>
    </tr>
<!--		<tr><td nowrap=6>禁用房号：<%=LockRoomS %></td></tr>-->
  </table>
 <p align=center><input type="button"  name=Ok value="试  算" onclick="getmodulus1();getprice();Validate();">&nbsp;&nbsp;<input type="button"  name=Ok value="退 出" onclick="confirmClose();">
  <!--input type="button"  name=delse value="详  情" onclick="Validate2();">
<input type="button" name=cancel value="保  存" onclick="Validate1();"-->
	
	</p>
  
   <% int roomint=0;
      int xxx=0;
      int iii=0;
   StringTokenizer st22 = new StringTokenizer(LockRoomS,",") ;
    int count22 = st22.countTokens() ;
		String locaPara="Loft="+Region+"&Build="+strBuilding+"&SecNo="+strSection+"&SecName="+SecName;
		String upp="ABCDEFGHIJKLOPQRST";
		upp=upp.trim();
		int nn=0;
        String RoomNoUp="";
		String  sqlU="select top 1 RoomNo,state from RoomNo where SectionNo=";
				sqlU=sqlU+"'"+strSection+"' and Building='";
				sqlU=sqlU+strBuilding+"' and Region='"+Region+"'";
		ResultSet rsU=InsertBean1.executeQuery(sqlU);
        if (rsU.next())RoomNoUp=getbyte(rsU.getString("RoomNo"));
		rsU.close();
		 
        if (RoomNoUp.equals("")){
		%>
		<script>
        alert("此栋还没有进行房间编号操作");
       </script>
		 <%}else{%>
 		<%
		//String upp="ABCDEFGHIJKOPQRST";
		RoomNoUp=RoomNoUp.substring(RoomNoUp.length()-1);
        char BeR=RoomNoUp.charAt(0);

		//int nn=0;
		 loftnum=intEndR;
try{
		for(int j=intBeginR;j<=intEndR;j++){
			
			
			if (LockRoomS.indexOf(String.valueOf(j))>=0||upp.indexOf(LockRoomS)>=0){
       
			 if ( Lock.contains(LockRoomS)){
			   String NO="";
			   if(!java.lang.Character.isDigit(BeR)){
		       switch(j){
			    case 1:
			       NO="A";
				   break;	
		        case 2:
			       NO="B";
				   break;	
		        case 3:
			       NO="C";
				   break;	
		        case 4:
			       NO="D";
				   break;		
		        case 5:
			       NO="E";
				   break;	
		        case 6:
			       NO="F";
				   break;	
		        case 7:
			       NO="G";
				   break;	
		        case 8:
			       NO="H";
				   break;	
				 case 9:
			       NO="I";
				   break;			  		   	   		   
			  case 10:
			       NO="J";
				   break;			  		   	   		   	   	   
			  case 11:
			       NO="K";
				   break;		   
			  case 12:
			       NO="L";
				   break;	   		  		   	   		   
		      }
			  }else{NO=String.valueOf(j);} 			
			//loftnum++;			
			 }
			}
			 
		 }
	
    String StrUpper="ABCDEFGHIJKLOPQRST"; 
	String sqlArr="select  distinct Room_code,saleState,Floor,Room,area,Room_Type,Scene,Fitment,Sumprice,roomtype,direction from room where seccode=";
		   sqlArr=sqlArr+"'"+strSection+"'";
		   sqlArr=sqlArr+" and  loft='"+Region+"' and building='"+strBuilding+"'  and SaleState in (1,2,3,4,5,6)  order by  Floor";
		   ResultSet rsArr=InsertBean1.executeQuery(sqlArr);
		   int aryi=0;
		   while (rsArr.next()){
		    roomint++;
		    list1.add(getbyte(rsArr.getString("Room_code")));
			list2.add(getbyte(rsArr.getString("SaleState")));
			String fl=rsArr.getString("Floor");
			String ro=rsArr.getString("Room");
			list3.add(getbyte(fl));
			list4.add(getbyte(ro));
			if (Integer.parseInt(ro)>9)
			  list12.add(getbyte(fl+ro+"<br>"));
			else
			  list12.add(getbyte(fl+"0"+ro)); 
			//因楼层数存在负数 ，但在html中的对象命名中不能存在"-",在下面的方法中就是转换负数楼层
			   if 	(fl.indexOf("-")>=0)list13.add("a"+"_"+fl.substring(fl.indexOf("-")+1)+"A"+ro);
else list13.add(fl.substring(fl.indexOf("-")+1)+"A"+ro);
			list5.add(getbyte(rsArr.getString("area")));
			list9.add(getbyte(rsArr.getString("Room_Type")));			
			list10.add(getbyte(rsArr.getString("Scene")));
			list11.add(getbyte(rsArr.getString("Fitment")));			
			list6.add(getbyte(rsArr.getString("Sumprice")));
			list7.add(getbyte(rsArr.getString("roomtype")));
			list8.add(getbyte(rsArr.getString("direction")));
		   } 
	      rsArr.close();
		int arrlen=0;
	 
	for(iii=intBeginF;iii<=intEndF;iii++){
		int IntAvgSumPrice=0;;
		float FatAreaSum=0;
		for(int j=intBeginR;j<=intEndR;j++){
		
		String RoomNo="";
		String no="";
		
		   if (j>=10)
		    RoomNo=String.valueOf(iii)+String.valueOf(j);
		   else
		    RoomNo=String.valueOf(iii)+"0"+String.valueOf(j);
		arrlen+=1;
		if (list12.contains(RoomNo)){
		   
		   int index=list12.indexOf(RoomNo);
		
			
		  RoomNo=(String)list1.get(index);
		  state=(String)list2.get(index);
		  no=(String)list4.get(index);


 try{              

       String l6=(String)list6.get(index);
       String l5=(String)list5.get(index);
       if (l6.equals(""))l6="0";
       if (l5.equals(""))l5="0";
       IntAvgSumPrice+=Float.parseFloat(l6);
	   FatAreaSum+=Float.parseFloat(l5);
	   AllSumArea+=Float.parseFloat(l5);
       AllSumPrice+=Float.parseFloat(l6);
   }catch(Exception s){out.close();}
	AllSumNum++;
}else{state="";}  
}}}catch(Exception s){out.println(s.getMessage());}%>

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
    <div id="div1" <%if(!page.equals("1")){%>style="display:none"<%}%>>
	<table width="100%" border="0" cellspacing="1" cellpadding="1"  onMouseOver="MM_showHideLayers('ebusiness','','show');" onMouseOut="MM_showHideLayers('ebusiness','','hide')">
    <tr>
	 <td align="center" class=listtitle><font color="#ffffff">楼层</font></td>
     <td align="center" class=FloorC width="10%"><font color="#ffffff">房间</font></td>
	 <%String sqlcode="SELECT type FROM ModulesSet GROUP BY type ORDER BY type";
	   String TYPENAME="";
	   int t=0;
       ResultSet rsArr=InsertBean1.executeQuery(sqlcode);
	   while (rsArr.next()){
         t++;
         String sqltype="SELECT typename FROM code where type='"+rsArr.getString("type")+"' ";
         ResultSet rstype=InsertBean.executeQuery(sqltype);
    		if(rstype.next()){
	    	  TYPENAME=getbyte(rstype.getString("typename"));
		    }
         %>
		  <td align="center" class=listtitle><font color="#ffffff"><%=TYPENAME%>系数</font></td>
		 <%}%>
		 <td align="center" class=listtitle><font color="#ffffff">楼层系数</font></td>
		 <td align="center" class=listtitle><font color="#ffffff">总系数</font></td>
	 </tr>
	<%try{
	   for(iii=0;iii<roomint;iii++){
	   String room5=(String)list1.get(iii);
	   String state5=(String)list2.get(iii);
	   String no5=(String)list4.get(iii);
	   String floor5=(String)list3.get(iii);
	   String area5=(String)list5.get(iii);
	   String room_type5=(String)list9.get(iii);
	   String scene5=(String)list10.get(iii);
       String fitment5=(String)list11.get(iii);
	   String roomtype5=(String)list7.get(iii);
	   String direction5=(String)list8.get(iii);
	    String ft=(String)list3.get(iii);
	   String paraRoom="";
	   if 	(floor5.indexOf("-")>=0)paraRoom="a"+"_"+floor5.substring(floor5.indexOf("-")+1)+"A"+no5;
else paraRoom=floor5.substring(floor5.indexOf("-")+1)+"A"+no5;
	   if(state5.equals("1")){
		  %>
	<tr> <td align='center' class='listcontent'><%=ft %></td>	
     <td align="center" class=FloorC width="10%"><font color="#ffffff"><a href="#" onclick="javascript:openwin('../basic/RoomEdit.jsp?loft=<%=Region %>&seccode=<%=strSection%>&building=<%=strBuilding%>&Floor=<%=iii%>&Room_code=<%=room5%>&MaxFloor=<%=intEndF%>&BengR=<%=no5 %>&EndR=<%=no5 %>&RoomNoType=<%=room5 %>',400,500,150,10);" title="已输入"> <%=room5%></font></td>
     <%sqlcode="SELECT type FROM ModulesSet GROUP BY type ORDER BY type";
       rsArr=InsertBean1.executeQuery(sqlcode);
	   String type5="";
	   while (rsArr.next()){
         type5=rsArr.getString("type");
		 if(type5.equals("A"))
           out.print(ShowTax1("select id,type,Modulus from ModulesSet where type='"+type5+"' and CODENAME ='"+roomtype5+"'",type5,strSection,Region,paraRoom)); 
         if(type5.equals("C"))
           out.print(ShowTax1("select id,type,Modulus from ModulesSet where type='"+type5+"' and CODENAME ='"+room_type5+"'",type5,strSection,Region,paraRoom));
		 if(type5.equals("D"))
           out.print(ShowTax1("select id,type,Modulus from ModulesSet where type='"+type5+"' and CODENAME ='"+direction5+"'",type5,strSection,Region,paraRoom));
		 if(type5.equals("O"))
           out.print(ShowTax1("select id,type,Modulus from ModulesSet where type='"+type5+"' and CAST(substring(CODENAME,1,PATINDEX('%-%', CODENAME)-1) as float) <='"+area5+"' and CAST(substring(CODENAME,PATINDEX('%-%', CODENAME)+1,len(CODENAME)) as float)>='"+area5+"'",type5,strSection,Region,paraRoom));
		 if(type5.equals("X"))
           out.print(ShowTax1("select id,type,Modulus from ModulesSet where type='"+type5+"' and CODENAME ='"+fitment5+"'",type5,strSection,Region,paraRoom));
		 
		 
           %>
		   
		   <%}%> 
	<%
	//floor5
	 %>
     <td align='center' class='listcontent'><input type=text name=XL<%=paraRoom%>  onblur="check(this);" size='3' onclick="gettotal('<%=paraRoom%>');" value="1.0"></td>	
     <td align='center' class='listcontent'> <input type=text name=total<%=paraRoom%> onblur="check(this);"  size='3' onclick="gettotal('<%=paraRoom%>');" readonly value="1.0"></td>	
	 <script>
	   gettotal('<%=paraRoom%>');
	   function gettotal(room){
	      var roomtype=new Array("A","C","D","L","O","X");
		  var temp="1";
		  var roomx=room;
		  var roomtemp="";	
          for(i=0;i<roomtype.length;i++){
		   roomtemp=roomtype[i]+roomx;

		   var jj=eval("document.frm.X"+roomtemp);
		   
		  if (jj){			
		    temp=temp*parseFloat(jj.value); 
		  	}
			
		  }
          var kk=eval("document.frm.total"+roomx);
			if(kk)kk.value=temp;
	   } 
	 </script>
	 <%} 
	%>
      
	<%}  }catch(Exception s){out.print(s.getMessage());}
	 
	%>
  </table>
   </div>
  

  <%} %>
  <p align=center><input type="button"  name=Ok value="试  算" onclick="getmodulus1();getprice();Validate();">
  <!--input type="button"  name=delse value="详  情" onclick="Validate2();">
	<input type="button" name=cancel value="保  存" onclick="Validate1();"-->
	</p>
  <script>
  function Validate2(){
   
    document.frm.action="PriceList3.jsp?allint=<%=roomint %>&loftnum=<%=loftnum %>";
	document.frm.submit();
  }
  function Validate(){
    if(document.frm.basicprice.value=='' )//&& document.frm.totalprice.value==''
	  {alert("请录入房均价");
	  document.frm.basicprice.focus();
	   return false;}
	
    document.frm.action="PriceList4.jsp?allint=<%=roomint %>&loftnum=<%=loftnum %>";
	document.frm.submit();
  }
   function Validate1(){
    if (document.frm.projectname.value=="")
    {alert("请输入方案名称");
	document.frm.projectname.focus();
    return false;
    }
	if (document.frm.projectdate.value=="")
    {alert("请重新刷新页面");
	document.frm.projectdate.focus();
    return false;
    }
    document.frm.action="PriceListSave.jsp?allint=<%=roomint %>";
	document.frm.submit();
  }
 
 
  var roomtype=new Array();
  var direct=new Array();
  var area=new Array();
  var fl=new Array();
  var roomno=new Array();
  var rooms=new Array();
  var modulus=new Array();
  <%
  for (int ii=0;ii<list1.size();ii++) {
    out.print("roomtype["+ii+"]='"+list7.get(ii)+"';");
	out.print("direct["+ii+"]='"+list8.get(ii)+"';");
	out.print("area["+ii+"]='"+list5.get(ii)+"';");
	out.print("fl["+ii+"]='"+list4.get(ii)+"';");
	out.print("roomno["+ii+"]='"+list3.get(ii)+"';");
	out.print("rooms["+ii+"]='"+list13.get(ii)+"';");	
   }
   %>
   for(i=0;i<rooms.length;i++){
		   var jj=eval("document.frm.XL"+rooms[i]);	
		   if (jj){
		    modulus[i]=jj.value;}			
		         
   
   }
   
     function getmodulus1(){	     	
		  var temp="1";
		  var temp2="0";
		  var temp3="";
		  var temp4="";
          for(i=0;i<rooms.length;i++){
		   temp="1";
		   var jj=eval("document.frm.XL"+rooms[i]);		   
		  if (jj){			           
		   temp=temp*parseFloat(jj.value);
		  	}
		  var dd=eval("document.frm.XA"+rooms[i]);		   
		  if (dd){			
           temp=temp*parseFloat(dd.value);
		  	}
		  var cc=eval("document.frm.XC"+rooms[i]);		   
		  if (cc){			
           temp=temp*parseFloat(cc.value);
		  	}
		   var ff=eval("document.frm.XD"+rooms[i]);		   
		  if (ff){			
           temp=temp*parseFloat(ff.value);
		  	}
		   var gg=eval("document.frm.XO"+rooms[i]);		   
		  if (gg){			
           temp=temp*parseFloat(gg.value);
		  	}
		   var hh=eval("document.frm.XX"+rooms[i]);		   
		  if (hh){			
           temp=temp*parseFloat(hh.value);
		  	}         
		  temp4=parseFloat(temp)*parseFloat(area[i])*parseFloat(document.frm.loftmodulus.value);
		  var kk=eval("document.frm.total"+rooms[i]);
			if(kk)kk.value=temp;
			temp2=parseFloat(temp2)+parseFloat(temp4);
			}
          document.frm.total.value=temp2;
	   } 
	     
  function getprice(){	
	   var temp7="";
	   if(document.frm.totalprice.value!='' && document.frm.basicprice.value==''){
             temp7=parseFloat(document.frm.totalprice.value)/parseFloat(document.frm.total.value);
			 document.frm.basicprice.value=subs1(temp7,2);}
	    var temp1="";
	   if(document.frm.basicprice.value!='' && document.frm.totalprice.value==''){
             temp1=parseFloat(document.frm.basicprice.value)*parseFloat(document.frm.total.value);
             document.frm.totalprice.value=subs1(temp1,2);}
	
	}

    function getmodulus(){	     	
		  var temp="1";
		  var temp2="0";
		  var temp3="";
		  var temp4="";
		  var temp5="";
          for(i=0;i<rooms.length;i++){
		   temp="1";
		   var jj=eval("document.frm.XL"+rooms[i]);		   
		  if (jj){			
             if(parseInt(roomno[i])>=parseInt(document.frm.floor1.value) && parseInt(roomno[i])<=parseInt(document.frm.floor2.value)){ 
			 jj.value=parseFloat(modulus[i])+(parseInt(roomno[i])-parseInt(document.frm.basicfloor.value))*parseFloat(document.frm.floormodulus.value);
		     temp=temp*parseFloat(jj.value);
			 }
		  	}
		  var dd=eval("document.frm.XA"+rooms[i]);		   
		  if (dd){			
           temp=temp*parseFloat(dd.value);
		  	}
		  var cc=eval("document.frm.XC"+rooms[i]);		   
		  if (cc){			
           temp=temp*parseFloat(cc.value);
		  	}
		   var ff=eval("document.frm.XD"+rooms[i]);		   
		  if (ff){			
           temp=temp*parseFloat(ff.value);
		  	}
		   var gg=eval("document.frm.XO"+rooms[i]);		   
		  if (gg){			
           temp=temp*parseFloat(gg.value);
		  	}
		   var hh=eval("document.frm.XX"+rooms[i]);		   
		  if (hh){			
           temp=temp*parseFloat(hh.value);
		  	}         
		  var jj=eval("document.frm.A"+rooms[i]);
			if(jj)temp3=jj.value;		  temp4=parseFloat(temp)*parseFloat(area[i])*parseFloat(document.frm.loftmodulus.value);
		  var kk=eval("document.frm.total"+rooms[i]);
			if(kk)kk.value=temp;
			temp2=parseFloat(temp2)+parseFloat(temp4);
			}
          document.frm.total.value=temp2;
	   } 

  
  </script>
  
  
</form>  
</div>
</body>
</html>
