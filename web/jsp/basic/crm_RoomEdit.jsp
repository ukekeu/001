<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>修改资料...</title>
<%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<%@ include file="../public_js/asiic.jsp"%> 

<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

<%!
public int toInt( String str ) throws Exception {
    return Math.round( new Float( str ).floatValue() ) ;    
}
%>
<%try{
String strSection=getbyte2(request.getParameter("seccode"));
String strLoft=getbyte2(request.getParameter("loft"));  
String strBuilding=getbyte2(request.getParameter("building"));
String currNo=getbyte2(request.getParameter("currNo"));
String strFloor=getbyte2(request.getParameter("Floor"));
String cell=getbyte2(request.getParameter("cell"));
String strRoom=getbyte2(request.getParameter("Room"));
String strRoomcode=getbyte2(request.getParameter("Room_code"));
if (strRoomcode.indexOf("、")>=0)strRoomcode=strRoomcode.substring(0,strRoomcode.indexOf("、"));
	
 if (strFloor.indexOf("-")>=0){
currNo=strRoomcode.substring(strFloor.substring(2).length());
}else{currNo=strRoomcode.substring(strFloor.length());}
 String SQL1="select PRICE_TYPE,ysunitlen,yssumlen  from SALE_PRICE_TYPE WHERE secno='"+strSection+"'";
String price_type="1";
 int loke_time=0;
 
String unitlen="0";
String unitlen1="1";
String sumlen="0";
ResultSet rs=ViewBean.executeQuery(SQL1);	
if (rs.next()){
  price_type=rs.getString("PRICE_TYPE");
  unitlen=rs.getString("ysunitlen");
  if (unitlen.equals("2"))unitlen1="100";
  sumlen=rs.getString("yssumlen");
}
rs.close();

int MaxFloor=java.lang.Integer.parseInt(request.getParameter("MaxFloor"));
String BengR=getbyte2(request.getParameter("BengR"));
String EndR=getbyte2(request.getParameter("EndR"));
	String RoomNoType=getbyte2(request.getParameter("Room_code"));
	if( RoomNoType != null )
        RoomNoType=RoomNoType.substring(RoomNoType.length()-1,RoomNoType.length());
	if( RoomNoType == null ) {
	    RoomNoType = "-1" ;
	}

	char RNT=RoomNoType.charAt(0);
	
	int intBengR=0;
	int intEndR=0;
	try{
if (MaxFloor>0)	{
if(java.lang.Character.isDigit(RNT)){
  if(Integer.parseInt(currNo)<10)
    currNo=strRoomcode.substring(strFloor.length()+1);
}
}
    if(!BengR.equals(""))
		intBengR=java.lang.Integer.parseInt(BengR);
	if(!EndR.equals(""))
	    intEndR=java.lang.Integer.parseInt(EndR);
    }catch(Exception s){intBengR=1;intEndR=100;}
	
String SQL="select dxs_area,dxs_unitprice,bak,gl_tnarea,gl_tnprice,gl_unitprice,code,useryear,room,Sumprice,Area as JzArea,gl_area,UsedArea as TnArea,TNunitprice as TnPrice,Unitprice as JzPrice,";
SQL+=" Roomtype,yong_tu,Fitment,Direction,Scene,Room_Type,ApportionArea,SaleState,serve_date,Map,loke,datediff(mi,lokedate,getdate()) as nn ";
SQL+=",lu_tai_area,lu_tai_area_price, yang_tai_area,yang_tai_price,room_price ";
SQL+=",Y_Area,Y_UsedArea, Y_Unitprice,Y_Sumprice,Y_TNunitprice,lu_tai_mapp_area,yang_tai_mapp_area,yang_tai_zhao_sarea,yang_tai_zhao_price,ty_area,ty_area_price,dt_area_price,dt_area  ";
SQL+=",e_year,s_year,cg,wd_area,wd_area_price,floormess from room where seccode='"+strSection+"' and loft='"+strLoft+"'";
SQL+=" and building='"+strBuilding+"' and room_code='"+getbyte2(request.getParameter("Room_code"))+"'";
 
 String roombak="";
String floormess=""; 
String Sumprice="";
String JzArea="";
String TnArea="";
String TnPrice="";
String JzPrice="";
String Roomtype="";
String Fitment="";
String Direction="";
String Scene="";
String Room_Type="";//房类
String ApportionArea="";
String SaleState="";
String Map="";
ResultSet RsRoom=null;
String jldate="";
String glArea="";
String currroom="",gl_unitprice="0";
String loke="",yong_tu="",dxs_area="",dxs_unitprice="";
String e_year="",s_year="",cg="",code="",gl_tnprice="0",gl_tnarea="0";;
int nn=0;
String ty_area="",ytz_area="",ytz_area_price="";
String Y_Area="",Y_UsedArea="", Y_Unitprice="",Y_Sumprice="",room_price="";
String Y_TNunitprice="",lu_tai_mapp_area="",yang_tai_mapp_area="",useryear="70";
String dt_area_price="",dt_area="",wd_area="",wd_area_price="",ty_area_price="";
String lu_tai_area="",lu_tai_area_price="",hua_yuan_area="",hua_yuan_area_price="",yang_tai_area="",yang_tai_price ="";
try{


  RsRoom=ViewBean.executeQuery(SQL);
  while (RsRoom.next()){
    dxs_area=getbyte(RsRoom.getString("dxs_area"));
	dxs_unitprice=getbyte(RsRoom.getString("dxs_unitprice"));
  roombak=getbyte(RsRoom.getString("bak"));
    gl_tnarea=RsRoom.getString("gl_tnarea");
   gl_tnprice=RsRoom.getString("gl_tnprice");
    gl_unitprice=RsRoom.getString("gl_unitprice");
    code=RsRoom.getString("code");
    useryear=RsRoom.getString("useryear");
    currroom=RsRoom.getString("room");
    Sumprice=RsRoom.getString("Sumprice");
    JzArea= RsRoom.getString("JzArea");
	glArea= RsRoom.getString("gl_Area");
 
	TnArea= RsRoom.getString("TnArea");
	TnPrice= RsRoom.getString("TnPrice") ;
	JzPrice=RsRoom.getString("JzPrice");
	Roomtype=getbyte(RsRoom.getString("Roomtype"));
	yong_tu=getbyte(RsRoom.getString("yong_tu"));
	Fitment=getbyte(RsRoom.getString("Fitment"));
	Direction=getbyte(RsRoom.getString("Direction"));
	Scene=getbyte(RsRoom.getString("Scene"));
	Room_Type=getbyte(RsRoom.getString("Room_Type"));
	ApportionArea=RsRoom.getString("ApportionArea");
	SaleState=RsRoom.getString("SaleState");
	jldate=getbyte(RsRoom.getString("Serve_date"));
	if (!jldate.equals(""))jldate=jldate.substring(0,10);
	Map=RsRoom.getString("Map");
	loke=getbyte(RsRoom.getString("loke"));
	if (loke.equals(""))loke="0";
	nn=RsRoom.getInt("nn");
	 lu_tai_area= RsRoom.getString("lu_tai_area");
	 lu_tai_area_price=RsRoom.getString("lu_tai_area_price");
 
	 yang_tai_area= RsRoom.getString("yang_tai_area");
	 yang_tai_price = RsRoom.getString("yang_tai_price");
	 room_price=FormtD.getFloat1(RsRoom.getFloat("room_price"),0);
     Y_Area= RsRoom.getString("Y_Area");
	 Y_UsedArea= RsRoom.getString("Y_UsedArea");
	 Y_Unitprice= RsRoom.getString("Y_Unitprice");
	 Y_Sumprice=FormtD.getFloat1(RsRoom.getFloat("Y_Sumprice"),0);
     Y_TNunitprice=FormtD.getFloat1(RsRoom.getFloat("Y_TNunitprice"),2);
	 lu_tai_mapp_area=RsRoom.getString("lu_tai_mapp_area");
	 yang_tai_mapp_area=FormtD.getFloat1(RsRoom.getFloat("yang_tai_mapp_area"),3);
     if (lu_tai_mapp_area.equals(""))lu_tai_mapp_area="0";
      if (yang_tai_mapp_area.equals(""))yang_tai_mapp_area="0";
	  ytz_area=FormtD.getFloat1(RsRoom.getFloat("yang_tai_zhao_sarea"),2);
	  ytz_area_price=FormtD.getFloat1(RsRoom.getFloat("yang_tai_zhao_price"),2);
	  ty_area= RsRoom.getString("ty_area");
	  ty_area_price=RsRoom.getString("ty_area_price");
	  dt_area_price=FormtD.getFloat1(RsRoom.getFloat("dt_area_price"),2);
	  dt_area=FormtD.getFloat1(RsRoom.getFloat("dt_area"),3);
	  e_year=getbyte(RsRoom.getString("e_year"));
	  s_year=getbyte(RsRoom.getString("s_year"));
	  cg=getbyte(RsRoom.getString("cg"));
	  wd_area=getbyte(RsRoom.getString("wd_area"));
	  wd_area_price=getbyte(RsRoom.getString("wd_area_price"));
	  floormess=getbyte(RsRoom.getString("floormess"));
	  if (cg.equals(""))cg="3";
	  if (!s_year.equals(""))s_year=s_year.substring(0,10);
 	  	  if (!e_year.equals(""))e_year=e_year.substring(0,10);
  } 
  //如果已出售仍要修改面积，则单价不变。采用计算方式2(详见系统管理费用计算)
  if(!SaleState.equals("1"))price_type="1";
  RsRoom.close();
  //判断是否有事务设置
 SQL="select  loke_time from DataTransSet WHERE section_no='"+strSection+"'";

ResultSet LRs=ViewBean.executeQuery(SQL);	
if (!LRs.next()){
  loke="0";
}else{
  loke_time=LRs.getInt("loke_time");
}
LRs.close();
  
  SQL="UPDATE room SET LOKE=1,LOKEDATE=getdate() where seccode='"+strSection+"' and loft='"+strLoft+"'";
SQL+=" and building='"+strBuilding+"' and room_code='"+strRoomcode+"'";
 
if (loke.equals("0")||nn>loke_time)
  ViewBean.executeUpdate(SQL);
}catch(Exception s){out.print(s.getMessage()+SQL);out.close();}


String FT="";
if (!SaleState.equals("1"))FT="disabled";
%> 
</head>
<script language="javascript" src="../public_js/public.js">
</script>
<script language="javascript" src="../public_js/basal.js">
</script>
<SCRIPT language=javascript>   
   function charges(){
   
        if( parseInt( document.forms[0].JZAreaUnitPrice.value ) < 0 ) {
            alert("请输入有效单价!");
            document.forms[0].JZAreaUnitPrice.focus();
            return false;
        }
  //      if (document.cus.JZAreaUnitPrice.value=="0"||document.cus.Area.value=="0")return false;
	document.forms[0].SumPrice.value=subs1(parseFloat(document.cus.Area.value)*parseFloat(document.cus.JZAreaUnitPrice.value),<%=sumlen %>);	
	document.forms[0].ASumPrice.value=subs1(document.forms[0].SumPrice.value,2);
	if ( parseFloat(document.forms[0].UsedArea.value)>0) document.cus.TNAreaUnitPrice.value=subs1(parseFloat(document.forms[0].SumPrice.value)/parseFloat(document.forms[0].UsedArea.value),<%=unitlen %>);
	var dd=document.cus.TNAreaUnitPrice.value;
	 
	   }
   
function numValid( num ) {
    if( ! isNaN( num ) ) {
        if( parseInt( num ) != 0 ){
            return true ;
        }
    }
    return false ;
}   

function isNum( num ) {
    if( ! isNaN( num ) ) {
        return true ;
    }
    return false ;
}   
function checkNaN(aa){
   var a1=aa.value;

 if (isNaN(a1)){
      alert("只能用数字表达");
	  aa.value="";
	  aa.value=0;
	  aa.focus();
	  return false;
	}else{
	 if (parseFloat(a1)<0){
	     alert("只能用正数表达");
	       
	  	  return false;
	 }
	 }
	 return true; 
  }    
   
function charges1(){
    if( isNum( document.forms[0].SumPrice.value ) && numValid( document.forms[0].UsedArea.value ) ) {
        document.cus.TNAreaUnitPrice.value =  subs1(document.forms[0].SumPrice.value / document.forms[0].UsedArea.value,<%=unitlen %>) ;
    }
}
 
   
  function isPositive( num ) {
    if( !isNaN ( num ) ) {
        if( num > 0 ) {
            return true;
        }
    }
    return false;
  }   
 
  function jinWei( num ) {
         var  var0 = String( num ) ;
                  
         if ( var0.indexOf( "." ) > 0 ) {
             var0 = var0.substring( var0.indexOf( "." ) + 1 , var0.indexOf( "." ) + 2 );
             if   ( parseInt( var0 ) > 4 ) {
                num = parseInt( String( num ).substring( 0 , String( num ).indexOf( "." ) ) ) + 1;
             }else{
                num = String( num ).substring( 0, String( num ).indexOf(".") ) ;
             }
         }
         return num ;
  }
 
 function blur_TNAreaUnitPrice() 
 {  
 
        if( parseInt( document.forms[0].UsedArea.value ) < 0 ) {
            alert("请输入有效套内面积!");
            document.forms[0].UsedArea.focus();
            return false;
        }
		
        if (document.cus.UsedArea.value=="0")return false;
	  document.cus.SumPrice.value=subs1(parseFloat(document.forms[0].TNAreaUnitPrice.value)*parseFloat(document.forms[0].UsedArea.value),<%=sumlen %>);
	var  dd=document.cus.SumPrice.value;
	   document.cus.ASumPrice.valu=document.cus.SumPrice.value;
 
	   document.cus.SumPrice.value=subs1(parseFloat(document.cus.SumPrice.value),<%=sumlen %>);
	 
 
	 document.cus.JZAreaUnitPrice.value=subs1(parseFloat(document.forms[0].SumPrice.value)/parseFloat(document.forms[0].Area.value),<%=unitlen %>);
	var  dd=document.cus.JZAreaUnitPrice.value;
	 if (dd.indexOf(".")>=0){
	   var aa=dd.substring(dd.indexOf(".")+1);
	 
	  if (parseInt(aa.substring(0,1))>4)
document.cus.JZAreaUnitPrice.value=subs1(parseFloat(dd.substring(0,dd.indexOf(".")))+1,<%=unitlen %>);
	  else
	   document.cus.JZAreaUnitPrice.value=subs1(parseFloat(dd.substring(0,dd.indexOf("."))),<%=unitlen %>);
	 }
	 
 }
   
 function charges2(){
<%if (price_type.equals("0")) { %>
   if (parseInt(document.forms[0].SumPrice.value)<=0)return false; 
   if (parseFloat(document.forms[0].Area.value)<=0)return false; document.cus.JZAreaUnitPrice.value=subs1(parseFloat(document.forms[0].SumPrice.value)/parseFloat(document.forms[0].Area.value),<%=unitlen %>);
	document.cus.JZAreaUnitPrice.value=subs1(document.cus.JZAreaUnitPrice.value,2);
 <%} %>	 
 <%if (price_type.equals("1")) { %>
 document.forms[0].SumPrice.value=subs1(parseFloat(document.cus.JZAreaUnitPrice.value)*parseFloat(document.forms[0].Area.value),<%=sumlen %>);
 <%} %>
 <%if (price_type.equals("2")) { %>
 document.forms[0].SumPrice.value=subs1(parseFloat(document.cus.TNAreaUnitPrice.value)*parseFloat(document.forms[0].UsedArea.value),<%=sumlen %>);
 <%} %>
   }
 function FTAREA(){
    if (document.cus.UsedArea.value==""||document.cus.Area.value==""){
     alert("请先输入建筑面积及分摊面积");
     cus.UsedArea.focus();
     return (false);
     }else{
     var area=parseFloat(document.cus.Area.value)-parseFloat(document.cus.UsedArea.value)+parseFloat(document.cus.gl_Area.value)-parseFloat(document.cus.gl_tnarea.value);
     var  varst=String(area);
      if (varst.indexOf(".")>0){
      varst=varst.substring(varst.indexOf(".")+4,varst.indexOf(".")+5);
      if   (parseInt(varst)>4){area=parseFloat(String(area).substring(0,String(area).indexOf(".")+5))+0.0001;}else{area=String(area).substring(0,String(area).indexOf(".")+5);}
     }   

   
<%if (price_type.equals("1")) { %>
	if (parseFloat( document.cus.SumPrice.value)>0)
	 document.cus.TNAreaUnitPrice.value=Math.round((parseFloat( document.cus.SumPrice.value)/parseFloat(document.forms[0].UsedArea.value))*<%=unitlen1 %>)/<%=unitlen1 %>;
	 <%} %> 

    document.cus.Apportion.value=subs1(area,2);
    }

 }

  function toUpper(aa){
    var a=aa.value;
    aa.value=a.toUpperCase();
  }
   function setfocus()
   {   
   		cus.Area.focus();
   }

   function full(){
  // setSelectMad(document.cus.SaleState,'<%=SaleState %>');
   setSelectMad(document.cus.Fitment,'<%=Fitment %>');
   
   //setSelectMad(document.cus.FirstFloor,'<%=strFloor %>');
   //setSelectMad(document.cus.EndFloor,'<%=strFloor %>');
  
<%     

String NO=strRoomcode.substring(strRoomcode.length()-1);
char BeR=NO.charAt(0);

if(java.lang.Character.isDigit(BeR)){
if (java.lang.Integer.parseInt(strRoom)>9)
  NO=strRoomcode.substring(strRoomcode.length()-2);
else
  NO=strRoomcode.substring(strRoomcode.length()-1);
 }else{
 NO=strRoomcode.substring(strRoomcode.length()-1);
 
 }
    %>

   setSelectMad(document.cus.EndRoom,'<%=NO %>');
    setSelectMad(document.cus.FirstRoom,'<%=NO %>');
	 setSelectMad(document.cus.Ecellname,'<%=cell %>');
	  setSelectMad(document.cus.Scellname,'<%=cell %>');
	 setSelectMad(document.cus.yong_tu,'<%=yong_tu %>');
	  setSelectMad(document.cus.Direction,'<%=Direction %>');
	   setSelectMad(document.cus.RoomType,'<%=Roomtype %>');
	   setSelectMad(document.cus.HouseType,'<%=Room_Type %>');
   }
    function show(para){
       openwin1("show_fiment.jsp?zx="+para,390,500,150,150);
	   //
  }
</SCRIPT> 
<body onload="setfocus();full();" oncontextmenu="return false"   >
<%@ include file="../public_js/CodeSele.jsp"%>
<form method="POST" name="cus" action=""  ENCTYPE="multipart/form-data"> 
<%
String title="修改房间资料";
if (!SaleState.equals("1")) title="房间资料";%>
<p align=center><font size=3 class=FontColor><B><%=title %></b></font></p>
<table width="100%" border="0" cellspacing="1"   cellpadding="1" >
<input type=hidden name=code size="10"   readonly value="<%=code%>">
      <input type=hidden name=SecCode size="10"   readonly value="<%=strSection%>">
      <input type=hidden name=Building size="10"   readonly value="<%=strBuilding%>">
      <input type=hidden name=Floor size="10"   readonly value="<%=strFloor%>">
      <input type=hidden name=Loft size="10"   readonly value="<%=strLoft%>">
	    <input type=hidden name=oldroom size="10"   readonly value="<%=getbyte2(request.getParameter("Room_code"))%>">
       <input type=hidden name=floormess size="15"   readonly value="<%=floormess%>">
      
	  <tr> 
        <td width="30%"  class=roomleft  align="left" height="24"  >&nbsp;当前房号</td>
        <td  width="50%" class=roomright   align="left" height="24"> 
         &nbsp;
         <input type=text   name=RoomCode size="10"    value="<%=getbyte2(request.getParameter("Room_code"))%>">
        </td>
       
         <input type=hidden <%=FT%> name=ASumPrice size="10" value="<%=Sumprice %>"  onkeydown="key(document.cus.Area)" onchange="checkNaN(this);charges1();charges2();"  <%if (!price_type.equals("0")) {out.print("readonly");}%> > 
  
        <td  width="30%" class=roomleft align="left"   height="14"  >&nbsp;房&nbsp;&nbsp;&nbsp;&nbsp;款</td>
        <td  width="50%" class=roomright align="left"   height="14"> 
          &nbsp;
          <input type=text <%=FT%> name=SumPrice size="10" value="<%=room_price %>"  onkeydown="key(document.cus.Area)" onchange="checkNaN(this);charges1();charges2();"  <%if (!price_type.equals("0")) {out.print("readonly");}%> >(元)
        </td>
      </tr>
	  <tr> 
        <td  width="30%" class=roomleft  align="left" height="24"  >&nbsp;建筑面积</td>
        <td  width="50%" class=roomright   align="left" height="24"> 
 &nbsp;
          <input type=text   name=Area size="10" value="<%=JzArea %>"  onkeydown="key(document.cus.JZAreaUnitPrice)"  onchange="checkNaN(this);charges2();FTAREA();"  >(M<sup>2</sup>)
        </td>
       <td  width="30%" class=roomleft align="left"   height="14"  >&nbsp;建筑单价</td>
        <td  width="50%" class=roomright align="left"   height="14"> 
          &nbsp;
          <input type=text <%=FT%> name=JZAreaUnitPrice value="<%=JzPrice %>" size="10" onkeydown="key(document.cus.UsedArea);" onchange="checkNaN(this);charges();"  <%if (!price_type.equals("1")) {out.print("readonly");}%>>(元/M<sup>2</sup>)
        </td>
       
      </tr>
      <tr align="left" > 
       
      
        <td  width="30%" class=roomleft align="left"   height="14"  >&nbsp;套内建筑<br>&nbsp;面积</td>
        <td  width="50%" class=roomright align="left"   height="14">
          &nbsp;
          <input type="text"  name="UsedArea" value="<%=TnArea %>" size="10" value=0 onkeydown="key(document.cus.gl_Area)"  value=1 OnChange="checkNaN(this);FTAREA();charges1();<%if (price_type.equals("2")){ %>blur_TNAreaUnitPrice();<%} %>">(M<sup>2</sup>)
        </td>
		
        <td  width="30%" class=roomleft align="left"   height="14"  >&nbsp;套内建筑<br>&nbsp;单价</td>
        <td  width="50%" class=roomright align="left"   height="14"> 
          &nbsp;
          <input type=text <%=FT%> name=TNAreaUnitPrice size="10" value="<%=  TnPrice%>"   onkeydown="key(document.cus.RoomType)"  onchange="checkNaN(this);blur_TNAreaUnitPrice();"  <%if (!price_type.equals("2")) {out.print("readonly");}%>>(元/M<sup>2</sup>)
        </td>
      </tr>
      <tr align="left" > 
	   <td  width="30%" class=roomleft  align="left" height="24" bgcolor="#CFE6EB">&nbsp;阁楼建筑<br>&nbsp;面积</td>
        <td  width="50%" class=roomright   align="left" height="24"> 
          &nbsp;&nbsp;<input type=text   name=gl_Area size="10" onkeydown="key(document.cus.gl_unitprice);"  value="<%=glArea %>"  onchange="checkNaN(this);FTAREA();">(M<sup>2</sup>)
        </td>
        <td  width="30%" class=roomleft align="left"   height="14"  >&nbsp;阁楼建筑<br>&nbsp;单价</td>
        <td  width="50%" class=roomright align="left"   height="14" OnClick="FTAREA();charges1();"> 
          &nbsp;
          <input type=text <%=FT%> name=gl_unitprice size="10"   value="<%=gl_unitprice %>"  onkeydown="key(document.cus.gl_tnarea)" onchange="checkNaN(this);">(元/M<sup>2</sup>)
        </td>
         </tr>
		  <tr align="left" > 
	   <td  width="30%" class=roomleft  align="left" height="24" bgcolor="#CFE6EB">&nbsp;阁楼套内<br>&nbsp;面积</td>
        <td  width="50%" class=roomright   align="left" height="24"> 
          &nbsp;&nbsp;<input type=text   name=gl_tnarea size="10" onkeydown="key(document.cus.gl_tnprice);"  value="<%=gl_tnarea %>"  onchange="checkNaN(this);FTAREA();">(M<sup>2</sup>)
        </td>
        <td  width="30%" class=roomleft align="left"   height="14"  >&nbsp;阁楼套内<br>&nbsp;单价</td>
        <td  width="50%" class=roomright align="left"   height="14" OnClick="FTAREA();charges1();"> 
          &nbsp;
          <input type=text <%=FT%> name=gl_tnprice size="10"   value="<%=gl_tnprice %>"  onkeydown="key(document.cus.dxs_area)" onchange="checkNaN(this);">(元/M<sup>2</sup>)
        </td>
         </tr>
		 
       <input type=hidden name=wd_unitprice size="15" value=0  onkeydown="key(document.cus.RoomType)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >
     <input type=hidden name=wd_area size="15" value=0  onkeydown="key(document.cus.RoomType)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >
     
	   <input type=hidden name=ty_area size="15" value=0  onkeydown="key(document.cus.RoomType)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >
     
	   <input type=hidden name=ty_area_price size="15" value=0  onkeydown="key(document.cus.RoomType)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >
     
      <input type=hidden name=lutai_area size="15" value=0  onkeydown="key(document.cus.RoomType)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >
     
	   <input type=hidden name=lutai_unitprice size="15" value=0  onkeydown="key(document.cus.RoomType)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >
     
	  <!--
	 
	    <tr align="left" > 
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;阳台面积</td>
        <td  width="50%" class=roomright align="left"   height="14"> 
          &nbsp;
		  <input type=text name=yangtai_area size="10"   value="<%=yang_tai_area %>" onkeydown="key(document.cus.ftjd_area)" onblur="checkNaN(this);"   >(M<sup>2</sup>)
        </td>
      
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;屋面面积<br>&nbsp;单价</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;
		  <input type=text name=wd_unitprice size="10" value="<%=wd_area_price %>"  onkeydown="key(document.cus.wd_area)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >(元/M<sup>2</sup>)
        </td>
      </tr>
	 
	    <tr align="left" > 
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;屋面面积</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;
		  <input type=text name=wd_area size="10" value="<%=wd_area %>"   onkeydown="key(document.cus.ftjd_area)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >(M<sup>2</sup>)
        </td>
      
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;分摊基地<br>&nbsp;面积</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;
		  <input type=text name=ftjd_area      value=0 size="10"  onkeydown="key(document.cus.ftyd_area)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >(M<sup>2</sup>)
        </td>
      </tr>
	     <tr align="left" > 
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;分摊用地<br>&nbsp;面积</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;
		  <input type=text name=ftyd_area   value=0 size="10" onkeydown="key(document.cus.ty_area)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >(M<sup>2</sup>)
        </td>
      
        
      
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;
		         </td>
      </tr>
	   <tr align="left" > 
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;不锈钢罩<br>&nbsp;面积</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;
		  <input type=text name=ytz_area size="10" value="<%=ytz_area %>"  onkeydown="key(document.cus.ytz_area_price)" onblur="checkNaN(this);"   >(M<sup>2</sup>)
        </td>
      
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;不锈钢罩<br>&nbsp;面积单价</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;
      <input type=text name=ytz_area_price size="10" value="<%=ytz_area_price %>"  onkeydown="key(document.cus.dt_area)" onblur="checkNaN(this);"  >元/(M<sup>2</sup>)
        </td>
      </tr>
	   <tr align="left" > 
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;锻铁面积</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;
		  <input type=text name=dt_area size="10" value="<%=dt_area %>"    onkeydown="key(document.cus.dt_area_price)" onblur="checkNaN(this);"  >(M<sup>2</sup>)
        </td>
      
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;锻铁面积<br>&nbsp;单价</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;
		  <input type=text name=dt_area_price size="10" value="<%=dt_area_price %>"  onkeydown="key(document.cus.RoomType)" onblur="checkNaN(this);"   >元/(M<sup>2</sup>)
        </td>
      </tr>
	  -->
	      &nbsp;<input type=hidden name=ftjd_area size="15" value=0  onkeydown="key(document.cus.ftyd_area)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   > 
       
	      &nbsp;<input type=hidden name=ftyd_area size="15" value=0  onkeydown="key(document.cus.ftyd_area)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   > 
   	  &nbsp;<input type=hidden name=ytz_area size="15" value=0  onkeydown="key(document.cus.ytz_area_price)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   > 
	      &nbsp;<input type=hidden name=ytz_area_price size="15" value=0  onkeydown="key(document.cus.RoomType)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   > 
	    &nbsp;<input type=hidden name=dt_area size="15" value=0  onkeydown="key(document.cus.dt_area_price)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   > 
	  <input type=hidden name=dt_area_price size="15" value=0  onkeydown="key(document.cus.RoomType)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >
       <tr> 
	   <td  width="30%" class=roomleft align="left"   height="14"  >&nbsp;分摊面积</td>
        <td  width="50%" class=roomright align="left"   height="14" OnClick="FTAREA();charges1();"> 
          &nbsp;
          <input type=text <%=FT%> name=Apportion size="10" readonly value="<%=ApportionArea %>"  onkeydown="key(document.cus.TNAreaUnitPrice)" onchange="checkNaN(this);">(M<sup>2</sup>)
        </td>
        <td  width="30%" class=roomleft  align="left" height="24"  > &nbsp;户&nbsp;&nbsp;&nbsp;&nbsp;型</td>
        <td  width="50%" class=roomright   align="left" height="24">
		&nbsp;
		<SELECT NAME="RoomType" onkeydown="key(document.cus.sd)">
		<option value=""></option>
		  <%
   for (int ii=0;ii<500;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("A"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
          %>
		  </SELECT>          </td>
     		<input type=hidden <%=FT%> size=10 name="useryear" value="<%=useryear %>"  onkeydown="key(document.cus.sd)"> 
              </tr>
	    <tr> 
        <td  width="30%" class=roomleft  align="left" height="24"  > &nbsp;年限范围</td>
        <td  width="50%" class=roomright   align="left" height="24">
		 &nbsp;
		 <INPUT TYPE=TEXT NAME=sd value="<%=s_year %>" onkeydown="key(document.cus.ed)" size=10><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(sd);return false;">到
		  <br> &nbsp;
		  <INPUT TYPE=TEXT NAME=ed  value="<%=e_year %>" onkeydown="key(document.cus.Direction)" size=10><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(ed);return false;">
      </td>
      
        <td  width="30%" class=roomleft  align="left" height="23"  >&nbsp;朝&nbsp;&nbsp;&nbsp;&nbsp;向</td>
        <td  width="50%" class=roomright   align="left" height="23"> 
          &nbsp;
        <SELECT NAME="Direction" onkeydown="key(document.cus.Scene)" style="width : 80">
		<option value=""></option>
		  <%
   for (int ii=0;ii<500;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("D"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
          %>
		  </SELECT>          
        </td>
      </tr>
      <tr  > 
        <td  width="30%" class=roomleft  align="left" height="23"  >&nbsp;景&nbsp;&nbsp;&nbsp;&nbsp;观</td>
        <td  width="50%" class=roomright   align="left" height="23"> 
          &nbsp;
          <input type="text" <%=FT%>  name="Scene" value="<%=Scene %>" maxlength="20" size="10" onkeydown="key(document.cus.yong_tu)"  >
        </td>
      
        <td  width="30%" class=roomleft  align="left" height="23" bgcolor="#CFE6EB">&nbsp;用&nbsp;&nbsp;&nbsp;&nbsp;途</td>
        <td  width="30%" class=roomright   align="left" height="23"> 
   &nbsp;
   <SELECT NAME="yong_tu" onkeydown="key(document.cus.cg)">
  
   <option value=""></option>
		<%
   for (int ii=0;ii<500;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("YT"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
     </SELECT>
        </td>
      </tr>
	    <tr  > 
        <td  width="30%" class=roomleft  align="left" height="23" bgcolor="#CFE6EB">&nbsp;层&nbsp;&nbsp;&nbsp;&nbsp;高</td>
        <td  width="30%" class=roomright   align="left" height="23"> 
       &nbsp;
	   <input type=text name=cg  size="10"  onkeydown="key(document.cus.Fitment)" value="<%=cg %>">米

        </td>
    
        <td  width="30%" class=roomleft align="left"   height="14"  >&nbsp;装修标准</td>
        <td  width="50%" class=roomright align="left"   height="14">
		&nbsp;
		<SELECT NAME="Fitment" <%=FT%>  onkeydown="key(document.cus.HouseType)" style="width : 80">
		<option value=""></option>
		<%
   for (int ii=0;ii<500;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("X"))
	       out.print("<option value="+CodeName[ii]+">"+CodeName[ii]+"</option>");
		  }
       }
  %>
     </SELECT>
	<!-- <input type=button name=xq value="详情" onclick="show(document.cus.Fitment.value);">-->
	  
        </td>
      </tr>
      <tr align="left" > 
        <td  width="30%" class=roomleft align="left"   height="24"  >&nbsp;销售状态</td>
        <td  width="50%" class=roomright align="left"   height="24"> 
		 &nbsp;<%if(SaleState.equals("1"))out.print("未订");
		        if(SaleState.equals("2"))out.print("已认购");
				if(SaleState.equals("3"))out.print("已售");
				if(SaleState.equals("4"))out.print("预留"); %>
				
			<!--<select  name="SaleState" >
            <option value="1">未订</option>
			<option value="2">已认购</option>
			<option value="3">已售</option>
			<option value="4">预留</option>
          </select>-->
        </td>
		<input name="SaleState" type="hidden" value="<%=SaleState %>">
    
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;交楼日期</td>
        <td  width="50%" class=roomright align="left"   height="14"> &nbsp;&nbsp;<INPUT type=text <%=FT%> NAME=Date1 value="<%=jldate %>" size=10 onkeydown="key(document.cus.HouseType)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;"></td>
      </tr>

      <tr align="left" > 
        <td  width="30%" class=roomleft align="left"   height="24"  >&nbsp;房&nbsp;&nbsp;&nbsp;&nbsp;类</td>
        <td  width="50%" class=roomright align="left"   height="24">
		&nbsp;
		<SELECT NAME="HouseType" <%=FT%>  onkeydown="key(document.cus.FirstRoom)" style="width : 80">
		<%
   for (int ii=0;ii<500;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("C"))
	       out.print("<option value="+CodeName[ii]+">"+CodeName[ii]+"</option>");
		  }
       }
  %>
     </SELECT>
		       </td>
     
        <td  width="20%" class=roomleft  align="left" height="31" bgcolor="#CFE6EB">&nbsp;房间范围</td>
       <td  width="50%" class=roomright   align="left" height="31"> 
        &nbsp;&nbsp;<select name=FirstRoom <%=FT%>  onkeydown="key(document.cus.EndRoom)" style="width : 35">
		<%String StrUpper="ABCDEFGHIJKLMNOPQRSTUVWXYZ"; %>
		<%try{
		  for (int i7=intBengR;i7<=intEndR;i7++){ 
		  	if(java.lang.Character.isDigit(RNT)){
		     out.print("<option value="+String.valueOf(i7)+">"+String.valueOf(i7)+"</option>");
			}else{
			  out.print("<option value="+StrUpper.substring(i7-1,i7)+">"+StrUpper.substring(i7-1,i7)+"</option>");
			} 
		 }
		}catch(Exception s){out.println(s.getMessage());}
		%>
			</select>-->><select name=EndRoom <%=FT%>  onkeydown="key(document.cus.FirstFloor)" style="width : 35">
			<%try{for (int i8=intBengR;i8<=intEndR;i8++){ 
		  	if(java.lang.Character.isDigit(RNT)){
		     out.print("<option value="+String.valueOf(i8)+">"+String.valueOf(i8)+"</option>");
			}else{
			  out.print("<option value="+StrUpper.substring(i8-1,i8)+">"+StrUpper.substring(i8-1,i8)+"</option>");
			} 
		
		}}catch(Exception s){}
		%>
			</select><select name=roomsd style="width : 50"><option value="0">连续</option><option value="1">偶数</option><option value="2">奇数</option></select>
				  
        </td>
	  </tr>	
	  
        <tr> 
        <td  width="30%" class=roomleft  align="left" height="31"  >&nbsp;楼层范围</td>
        <td  width="50%" class=roomright   align="left" height="31"> 

        &nbsp;
        <select name=FirstFloor <%=FT%>  onkeydown="key(document.cus.EndFloor)" >
		<%try{for (int i5=Integer.parseInt(strFloor);i5<=MaxFloor;i5++){ 
		  out.print("<option value="+String.valueOf(i5)+">"+String.valueOf(i5)+"</option>");
		}
		}catch(Exception s){}
		%>
		   
			</select>--><select name=EndFloor <%=FT%>  onkeydown="key(document.cus.Scellname)">
			<%try{for (int i6=Integer.parseInt(strFloor);i6<=MaxFloor;i6++){ 
		  out.print("<option value="+String.valueOf(i6)+">"+String.valueOf(i6)+"</option>");
		}}catch(Exception s){}
		%>
			</select><select name=floorstype><option value="0">连续</option><option value="1">偶数</option><option value="2">奇数</option></select>
				  
        </td>
	   
        <td  width="30%" class=roomleft  align="left" height="31"  >&nbsp;平&nbsp;面&nbsp;图</td>
        <td  width="50%" class=roomright   align="left" height="31"> 
          &nbsp;
          <input type="file" name="Map" size=10  >
        </td>
	  </tr>
	 
	  <tr><td    class=roomleft  >起始单元</td><td class=roomright  >&nbsp;
		  <select name=Scellname onkeydown="key(document.cus.Ecellname)">
		           <option value=" "></option>
				    <option value="1">1单元</option>
					<option value="2">2单元</option>
					 <option value="3">3单元</option>
					 <option value="4">4单元</option>
					 <option value="5">5单元</option>
					 <option value="6">6单元</option>
					 <option value="7">7单元</option>
					 <option value="8">8单元</option>
					 <option value="9">9单元</option>
					 <option value="10">10单元</option>
					 <option value="11">11单元</option>
					  <option value="A">A单元</option>
					  <option value="B">B单元</option>
					  <option value="C">C单元</option>
					  <option value="D">D单元</option>
					  <option value="E">E单元</option>
					  <option value="F">F单元</option>
					  <option value="G">G单元</option>
					  <option value="H">H单元</option>
					    <option value="I">I单元</option>
						<option value="J">J单元</option>
				      <option value="K">K单元</option>
				 
		  		 
		  </select>到 <select name=Ecellname onkeydown="key(document.cus.yangtai_area)">
		           <option value=" "></option>
				    <option value="1">1单元</option>
				     <option value="2">2单元</option>
					 <option value="3">3单元</option>
					 <option value="4">4单元</option>
					 <option value="5">5单元</option>
					 <option value="6">6单元</option>
					 <option value="7">7单元</option>
					 <option value="8">8单元</option>
					 <option value="9">9单元</option>
					 <option value="10">10单元</option>
					 <option value="11">11单元</option>
					  <option value="A">A单元</option>
					  <option value="B">B单元</option>
					  <option value="C">C单元</option>
					  <option value="D">D单元</option>
					  <option value="E">E单元</option>
					  <option value="F">F单元</option>
					  <option value="G">G单元</option>
					  <option value="H">H单元</option>
					    <option value="I">I单元</option>
						<option value="J">J单元</option>
				  <option value="K">K单元</option>
		  		
		  </select></td>
		  <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;阳台面积</td>
        <td  width="50%" class=roomright align="left"   height="14"> 
          &nbsp;
		  <input type=text name=yangtai_area size="10"   value="<%=yang_tai_area %>" onkeydown="key(document.cus.saveRoom)" onblur="checkNaN(this);"   >(M<sup>2</sup>)
        </td>
		  </tr>
		  <tr><td class=roomleft>备注</td><td colspan="3"> <textarea name="roombak" cols="60" rows="4"><%=roombak %></textarea>  </td></tr>
	   <input type=hidden name=para value="edit">
	 
	   <input type=hidden name=YN value="">
	   <input type=hidden name=MaxFloor value="">
      </table>
	  说明:上述中的房款不包括阁楼款<br>
<%
	if (Map==null)Map="";
	if (!Map.equals("")){ %>
	<img border="0"   src="<%=Map%>" width="100%" height=500 ><br>
	<%}else{out.print("无图片!");} %>
		
		 <input type=hidden name=map1 value=<%=Map %>>
 <%if ((loke.equals("1")&&nn>loke_time)||loke.equals("0")||loke_time==0){ %>
    <%}else{ out.print("<script>alert('数据被人占用，"+loke_time+"分钟后请刷新，自动解锁');</script>");out.close();}%>
    <p align="center"> 
            &nbsp;&nbsp; 
			 <%
 
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"B005");
   if (Cortrol==null)Cortrol="";
    if (Cortrol.indexOf("E")>=0){ %>
  
			<input type="Button" name="saveRoom" value="提 交" onclick="loca();">
		   <%} %>
           &nbsp;&nbsp;
		   <input type="Button" name="saveRoom1" value="退 出" onclick="window.close();">
   &nbsp;&nbsp;
		   <input type="Button" name="saveRoom2" value="打 印" onclick="window.print();">
          </P>
<script>
		function loca(){
		    if (confirm("确认修改数据吗?<%if(!SaleState.equals("1")){out.print(",此房已出售，系统将自动更新出售的总价");} %>"))
		   { document.cus.saveRoom.disabled=true;
		   document.cus.ASumPrice.value=document.cus.SumPrice.value;
		   document.cus.action="<%if(SaleState.equals("1")){out.print("RoomInsert.jsp");}else{out.print("modiSaleRoom.jsp");}%>";
		    document.cus.submit();
      		}
			}
		</script>
</form>     
       
       <% }catch(Exception s){out.print(s);} %>   
	    <%ViewBean.closeConn();
        %>
       
</body>       
</html>       

