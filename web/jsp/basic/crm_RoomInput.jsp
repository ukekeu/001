<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>��������</title>
<%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<%
String strSection=getbyte2(request.getParameter("seccode"));
String strLoft=getbyte2(request.getParameter("loft"));  
String cell=getbyte2(request.getParameter("cell")); 
	String strBuilding=getbyte2(request.getParameter("building"));
	String floortype=getbyte2(request.getParameter("floortype"));
	String floormess=getbyte2(request.getParameter("floormess"));
	String strFloor=request.getParameter("Floor");
	String strRoom=request.getParameter("Room");
	String strRoomcode=getbyte2(request.getParameter("Room_code"));
	
	int MaxFloor=java.lang.Integer.parseInt(request.getParameter("MaxFloor"));
	String BengR=request.getParameter("BengR");
	String EndR=request.getParameter("EndR");
	String RoomNoType=getbyte2(request.getParameter("RoomNoType"));
    RoomNoType=RoomNoType.substring(RoomNoType.length()-1,RoomNoType.length());
	
	String SQL1="select PRICE_TYPE,ysunitlen,yssumlen  from SALE_PRICE_TYPE WHERE secno='"+strSection+"'";
String price_type="1";
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

	char RNT=RoomNoType.charAt(0);
	int intBengR=0;
	int intEndR=0;
	intBengR=java.lang.Integer.parseInt(BengR);
	intEndR=java.lang.Integer.parseInt(EndR);

String Sql="select convert(char(24),Offerdate,111) as date,Type FROM crm_project where serialno='"+strSection+"'";
String jldate="";
String Type="";
try{
ResultSet rs1=ViewBean.executeQuery(Sql);
 if (rs1.next()){
   jldate=getbyte(rs1.getString("date"));
   Type=rs1.getString("Type");
 
 }
 rs1.close();
}catch(Exception s){}
%>
</head>
<script language="javascript" src="../public_js/public.js">
</script>

<script language="javascript" src="../public_js/basal.js">
</script>

<SCRIPT language=javascript>
function checkFloor(aa){
   var a1=aa.value;
   if (a1!=""){
   if (isNaN(a1)){
      alert("ֻ�������ֱ��");
	  aa.value=0;
	 // aa.focus();
	  return false;
	} 
	 return true; 
    }
  }  
  function Validate(aForm)
   {
     checkFloor(document.cus.SumPrice);
	    checkFloor(document.cus.ASumPrice);
 
    if (parseFloat(aForm.Area.value)==0){
    alert("��¼�뷿��Ľ������");
	aForm.Area.focus();
	return false;
   
   }
   if (parseFloat(aForm.UsedArea.value)==0){
    alert("��¼�뷿���ʹ�����");
	aForm.UsedArea.focus();
	return false;
   
   }
 
   if (aForm.FirstRoom.value==""||aForm.EndRoom.value==""){
     alert("��ѡ����ʼ����");
	 return false;
   
   }
	if (aForm.FirstFloor.value=="")
		{
	        alert("��ѡ����ʼ¥��ֵ��");
	        aForm.FirstFloor.focus();
	        return false;
		}
		if (parseInt(aForm.EndFloor.value)<parseInt(aForm.FirstFloor.value))
		{
	        alert("��ѡ�����¥��ֵ��");
	        aForm.EndFloor.focus();
	        return false;
		}
		
	    return (true);
   }
function charges(){
   
        if( parseInt( document.forms[0].JZAreaUnitPrice.value ) < 0 ) {
            alert("��������Ч����!");
            document.forms[0].JZAreaUnitPrice.focus();
            return false;
        }
        if (document.cus.JZAreaUnitPrice.value=="0"||document.cus.Area.value=="0")return false;
	document.forms[0].SumPrice.value=subs1(parseFloat(document.cus.Area.value)*parseFloat(document.cus.JZAreaUnitPrice.value),<%=sumlen %>);	
   if (parseFloat(document.forms[0].UsedArea.value)>0)	
    document.cus.TNAreaUnitPrice.value=parseFloat(document.forms[0].SumPrice.value)/parseFloat(document.forms[0].UsedArea.value);
	document.cus.TNAreaUnitPrice.value=subs1(document.cus.TNAreaUnitPrice.value,<%=unitlen %>);
	 
   }
   
 function charges2(){
<%if (price_type.equals("0")) { %>
   if (parseInt(document.forms[0].SumPrice.value)<=0)return false; 
   if (parseFloat(document.forms[0].Area.value)<=0)return false; document.cus.JZAreaUnitPrice.value=subs1(parseFloat(document.forms[0].SumPrice.value)/parseFloat(document.forms[0].Area.value),2);
	document.cus.JZAreaUnitPrice.value=subs1(document.cus.JZAreaUnitPrice.value,<%=unitlen %>);
 <%} %>	 
 <%if (price_type.equals("1")) { %>
 document.forms[0].SumPrice.value=subs1(parseFloat(document.cus.JZAreaUnitPrice.value)*parseFloat(document.forms[0].Area.value),<%=sumlen %>);
 <%} %>
 <%if (price_type.equals("2")) { %>
 document.forms[0].SumPrice.value=subs1(parseFloat(document.cus.TNAreaUnitPrice.value)*parseFloat(document.forms[0].UsedArea.value),<%=sumlen %>);
 <%} %>
   }
   
   
 function blur_TNAreaUnitPrice() 
 {  
 
        if( parseInt( document.forms[0].UsedArea.value ) < 0 ) {
            alert("��������Ч�������!");
            document.forms[0].UsedArea.focus();
            return false;
        }
        if (document.cus.UsedArea.value=="0")return false;
		<%if (price_type.equals("2")) { %>
	  document.cus.SumPrice.value=subs1(parseFloat(document.forms[0].TNAreaUnitPrice.value)*parseFloat(document.forms[0].UsedArea.value),<%=sumlen %>);
	  document.cus.JZAreaUnitPrice.value=subs1(parseFloat(document.forms[0].SumPrice.value)/parseFloat(document.forms[0].Area.value),<%=sumlen %>);
	  
	
    <%}else if (price_type.equals("1")) { %>
	
	 document.cus.TNAreaUnitPrice.value=parseFloat( document.cus.SumPrice.value)/parseFloat(document.forms[0].UsedArea.value);
	 document.cus.TNAreaUnitPrice.value=subs1(document.cus.TNAreaUnitPrice.value,<%=unitlen %>);
	 <%} %>
	 
	 
 }
   
  function charges1(){

   if (document.cus.SumPrice.value=="0"||document.cus.UsedArea.value=="0"){
    // alert("������������������ܼ�");
    // cus.Area.focus();
     return (false);
     }
  
   
   var char=parseFloat(document.cus.SumPrice.value)/parseFloat(document.cus.UsedArea.value);
     
    document.cus.TNAreaUnitPrice.value=subs1(char,2);
   }
 function FTAREA(){
    if (document.cus.UsedArea.value==""||document.cus.Area.value==""){
     alert("�������뽨���������̯���");
     cus.UsedArea.focus();
     return (false);
     } 

 var area=parseFloat(document.cus.Area.value)-parseFloat(document.cus.UsedArea.value)+parseFloat(document.cus.gl_Area.value)-parseFloat(document.cus.gl_tnarea.value);
     
    document.cus.Apportion.value=subs1(area,2);
     
<%if (price_type.equals("1")) { %>
	if (parseFloat( document.cus.SumPrice.value)>0)
	 document.cus.TNAreaUnitPrice.value=Math.round((parseFloat( document.cus.SumPrice.value)/parseFloat(document.forms[0].UsedArea.value))*<%=unitlen1 %>)/<%=unitlen1 %>;
	 <%} %> 
 }
  function toUpper(aa){
    var a=aa.value;
    aa.value=a.toUpperCase();
  }
   function setfocus()
   {
   		cus.Area.focus();
   }
  function show(para){
    openwin1("show_fiment.jsp?zx="+para,390,500,150,150);
  }
  var varSumPrice=0;
 
  function sumpricre(){
  if (varSumPrice==0) {
   varSumPrice=parseFloat(document.cus.SumPrice.value) ;
     document.cus.SumPrice.value=varSumPrice+parseFloat( document.cus.gl_unitprice.value)*parseFloat( document.cus.gl_Area.value);
  }
  else 
   document.cus.SumPrice.value=varSumPrice+parseFloat( document.cus.gl_unitprice.value)*parseFloat( document.cus.gl_Area.value);
  
  }
  
</SCRIPT>
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

<body oncontextmenu="return false"    onload="setfocus(); setSelectMad(document.cus.Ecellname,'<%=cell %>'); setSelectMad(document.cus.Scellname,'<%=cell %>');  setSelectMad(document.cus.EndRoom,'<%=NO %>');setSelectMad(document.cus.FirstRoom,'<%=NO %>'); setSelectMad(document.cus.yong_tu,'סլ');" >
<%@ include file="../public_js/CodeSele.jsp"%>
<form method="POST" name="cus" action=""  ENCTYPE="multipart/form-data">
<p align=center><font size=3 class=FontColor><B>��������</b></font></p>
<table width="100%" border="0" cellspacing="1"   cellpadding="1" >
      <input type=hidden name=code size="10" >
	  <input type=hidden name=SecCode size="15"   readonly value="<%=strSection%>">
      <input type=hidden name=Building size="15"   readonly value="<%=strBuilding%>">
      <input type=hidden name=Floor size="15"   readonly value="<%=strFloor%>">
      <input type=hidden name=Loft size="15"   readonly value="<%=strLoft%>">
	  <input type=hidden name=floortype size="15"   readonly value="<%=floortype%>">
	  <input type=hidden name=oldroom size="10">
	   <input type=hidden name=floormess size="15"   readonly value="<%=floormess%>">
      <input type=hidden name=cell size="15"   readonly value="<%=cell%>">
      
      <tr> 
        <td width="30%"  class=roomleft  align="left" height="24" bgcolor="#CFE6EB">&nbsp;��ǰ���</td>
        <td  width="30%" class=roomright   align="left" height="24"> 
         &nbsp;<input type=text name=RoomCode size="15"    value="<%=strRoomcode%>">
        </td>
     
	  <input type=hidden name=ASumPrice size="15" value=0  onkeydown="key(document.cus.Area)" Onblur="checkNaN(this);charges1();charges2();"  <%if (!price_type.equals("0")) {out.print("readonly");}%>>
	  <!--
	    <tr align="left" > 
		
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;�ܿ�</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<input type=text name=ASumPrice size="15" value=0  onkeydown="key(document.cus.Area)" Onblur="checkNaN(this);charges1();charges2();"  <%if (!price_type.equals("0")) {out.print("readonly");}%>>(Ԫ)
        </td>
      </tr>-->
      
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<input type=text name=SumPrice size="15" value=0  onkeydown="key(document.cus.Area)" Onblur="checkNaN(this);charges1();charges2();"  <%if (!price_type.equals("0")) {out.print("readonly");}%>>(Ԫ)
        </td>
      </tr>
	  <tr> 
        <td  width="30%" class=roomleft  align="left" height="24" bgcolor="#CFE6EB">&nbsp;�������</td>
        <td  width="30%" class=roomright   align="left" height="24"> 
          &nbsp;<input type=text name=Area size="15" value=0 onkeydown="key(document.cus.JZAreaUnitPrice);"   Onblur="checkNaN(this);charges2();FTAREA();" >(M<sup>2</sup>)<font color=red>*</font>
        </td>
       <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;��������</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<input type=text name="JZAreaUnitPrice" value=0 size="15" onkeydown="key(document.cus.UsedArea);" Onblur="checkNaN(this);charges();"   <%if (!price_type.equals("1")) {out.print("readonly");}%>>(Ԫ/M<sup>2</sup>)
        </td>
       
      </tr>
      
      <tr align="left" > 
       
      
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;�������</td>
        <td  width="30%" class=roomright align="left"   height="14">
          &nbsp;<input type="text" name="UsedArea" size="15" value=0 onkeydown="key(document.cus.gl_Area)"  value=1 OnChange="checkNaN(this);charges1();FTAREA();<%if (price_type.equals("2")){ %>blur_TNAreaUnitPrice();<%} %>">(M<sup>2</sup>)<font color=red>*</font>
        </td>
		  <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;���ڽ���<br>&nbsp;����</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<input type=text name=TNAreaUnitPrice size="15" value=0  onkeydown="key(document.cus.RoomType)" onblur="checkNaN(this);blur_TNAreaUnitPrice();"     <%if (!price_type.equals("2")) {out.print("readonly");}%> >(Ԫ/M<sup>2</sup>)
        </td>
		
      </tr>
      <tr align="left" > 
	   <td  width="30%" class=roomleft  align="left" height="24" bgcolor="#CFE6EB">&nbsp;��¥����<br>&nbsp;���</td>
        <td  width="30%" class=roomright   align="left" height="24"> 
          &nbsp;<input type=text  name=gl_Area size="15" value=0 onkeydown="key(document.cus.gl_unitprice);"  value=0 onblur="checkNaN(this);FTAREA();">(M<sup>2</sup>)
        </td>
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;��¥����<br>&nbsp;����</td>
        <td  width="30%" class=roomright align="left"   height="14" OnClick="FTAREA();charges1();"> 
          &nbsp;<input type=text name=gl_unitprice size="15" value=0  onkeydown="key(document.cus.gl_tnarea)" onblur="checkNaN(this);" >(Ԫ/M<sup>2</sup>)
        </td>      
      </tr>
	  <tr align="left" > 
	   <td  width="30%" class=roomleft  align="left" height="24" bgcolor="#CFE6EB">&nbsp;��¥����<br>&nbsp;���</td>
        <td  width="30%" class=roomright   align="left" height="24"> 
          &nbsp;<input type=text  name=gl_tnarea size="15" value=0 onkeydown="key(document.cus.gl_tnprice);"  value=0 onblur="checkNaN(this);FTAREA();">(M<sup>2</sup>)
        </td>
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;��¥����<br>&nbsp;����</td>
        <td  width="30%" class=roomright align="left"   height="14" OnClick="FTAREA();charges1();"> 
          &nbsp;<input type=text name=gl_tnprice size="15" value=0  onkeydown="key(document.cus.dxs_area)" onblur="checkNaN(this);" >(Ԫ/M<sup>2</sup>)
        </td>      
      </tr>
	    
	       &nbsp;<input type=hidden name=ftjd_area size="15" value=0  onkeydown="key(document.cus.ftyd_area)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   > 
       
	      &nbsp;<input type=hidden name=ftyd_area size="15" value=0  onkeydown="key(document.cus.ftyd_area)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   > 
         
	  &nbsp;<input type=hidden name=ytz_area size="15" value=0  onkeydown="key(document.cus.ytz_area_price)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   > 
       
	      &nbsp;<input type=hidden name=ytz_area_price size="15" value=0  onkeydown="key(document.cus.RoomType)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   > 
     
	    &nbsp;<input type=hidden name=dt_area size="15" value=0  onkeydown="key(document.cus.dt_area_price)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   > 
     
	  <input type=hidden name=dt_area_price size="15" value=0  onkeydown="key(document.cus.RoomType)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >
     
	  <input type=hidden name=wd_unitprice size="15" value=0  onkeydown="key(document.cus.RoomType)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >
     <input type=hidden name=wd_area size="15" value=0  onkeydown="key(document.cus.RoomType)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >
     
	   <input type=hidden name=ty_area size="15" value=0  onkeydown="key(document.cus.RoomType)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >
     
	   <input type=hidden name=ty_area_price size="15" value=0  onkeydown="key(document.cus.RoomType)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >
     
      <input type=hidden name=lutai_area size="15" value=0  onkeydown="key(document.cus.RoomType)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >
     
	   <input type=hidden name=lutai_unitprice size="15" value=0  onkeydown="key(document.cus.RoomType)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >
     
	 
	    
	  <!--
	    <tr align="left" > 
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;��̨���</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<input type=text name=yangtai_area size="15" value=0  onkeydown="key(document.cus.wd_unitprice)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >(M<sup>2</sup>)
        </td>
      
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;�������<br>&nbsp;����</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<input type=text name=wd_unitprice size="15" value=0  onkeydown="key(document.cus.wd_area)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >(Ԫ/M<sup>2</sup>)
        </td>
      </tr>
	 
	    <tr align="left" > 
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;�������</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<input type=text name=wd_area size="15" value=0  onkeydown="key(document.cus.ftjd_area)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >(M<sup>2</sup>)
        </td>
      
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;��̯����<br>&nbsp;���</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<input type=text name=ftjd_area size="15" value=0  onkeydown="key(document.cus.ftyd_area)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >(M<sup>2</sup>)
        </td>
      </tr>
	     <tr align="left" > 
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;��̯�õ�<br>&nbsp;���</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<input type=text name=ftyd_area size="15" value=0  onkeydown="key(document.cus.ty_area)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >(M<sup>2</sup>)
        </td>
     
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;ͥԺ���</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<input type=text name=ty_area size="15" value=0  onkeydown="key(document.cus.ytz_area)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >(M<sup>2</sup>)
        </td>
      </tr>
	   <tr align="left" > 
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;ͥԺ����</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;
		  <input type=text name=ty_area_price   value=0 size="10" onkeydown="key(document.cus.ytz_area)" onblur="checkNaN(this);"  >(M<sup>2</sup>)
        </td>
      
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;
		         </td>
      </tr>
	   <tr align="left" > 
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;�������<br>&nbsp;���</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<input type=text name=ytz_area size="15" value=0  onkeydown="key(document.cus.ytz_area_price)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >(M<sup>2</sup>)
        </td>
     
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;�������<br>&nbsp;�������</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<input type=text name=ytz_area_price size="15" value=0  onkeydown="key(document.cus.RoomType)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >Ԫ/(M<sup>2</sup>)
        </td>
      </tr>
	  
	   <tr align="left" > 
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;�������</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<input type=text name=dt_area size="15" value=0  onkeydown="key(document.cus.dt_area_price)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >(M<sup>2</sup>)
        </td>
      
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;�������<br>&nbsp;����</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<input type=text name=dt_area_price size="15" value=0  onkeydown="key(document.cus.RoomType)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >Ԫ/(M<sup>2</sup>)
        </td>
      </tr>
	  -->
	    <tr> 
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;��̯���</td>
        <td  width="30%" class=roomright align="left"   height="14" OnClick="FTAREA();charges1();"> 
          &nbsp;<input type=text name=Apportion size="15" value=0  onkeydown="key(document.cus.TNAreaUnitPrice)" onblur="checkNaN(this);" readonly>(M<sup>2</sup>)
        </td>
        <td  width="30%" class=roomleft  align="left" height="24" bgcolor="#CFE6EB"> &nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
        <td  width="30%" class=roomright   align="left" height="24">
		&nbsp;<SELECT NAME="RoomType"   style="width : 120" onkeydown="key(document.cus.Direction)">
		<option value=""></option>
		  <%
   for (int ii=0;ii<500;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("A"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
          %>
		  </SELECT>     
		     </td>
     
      
      </tr>
      <tr  > 
        <td  width="30%" class=roomleft  align="left" height="23" bgcolor="#CFE6EB">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
        <td  width="30%" class=roomright   align="left" height="23">&nbsp;<input type="text"   name="Scene" value="" maxlength="20" size="15" onkeydown="key(document.cus.yong_tu)"  >
     </td>
      
        <td  width="30%" class=roomleft  align="left" height="23" bgcolor="#CFE6EB">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;;</td>
        <td  width="30%" class=roomright   align="left" height="23"> 
         &nbsp;<SELECT NAME="yong_tu" onkeydown="key(document.cus.cg)" style="width : 120">
		 
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
        <td  width="30%" class=roomleft  align="left" height="23" bgcolor="#CFE6EB">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
        <td  width="30%" class=roomright   align="left" height="23"> 
       &nbsp;<input type=text name=cg value=3 size="15" onkeydown="key(document.cus.Fitment)" onblur="checkNaN(this);" >

        </td>
    
        <td  width="30%" class=roomleft align="left"   height="23" bgcolor="#CFE6EB">&nbsp;װ�ޱ�׼</td>
        <td  width="30%" class=roomright align="left"   height="23">
		&nbsp;<SELECT NAME="Fitment" onkeydown="key(document.cus.Date1)" style="width : 120">
		<option value=""></option>
		<%
   for (int ii=0;ii<500;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("X"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
     <!-- </SELECT><input type=button name=xq value="����" onclick="show(document.cus.Fitment.value);">-->
	 
        </td>
      </tr>
	  
	  <tr align="left" > 
        &nbsp;  <td  width="30%" class=roomleft  align="left" height="23" bgcolor="#CFE6EB">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
        <td  width="30%" class=roomright   align="left" height="23"> 
          &nbsp;<SELECT NAME="Direction" style="width : 120" onkeydown="key(document.cus.Scene)">
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
        </td>
    <input name="SaleState" type="hidden" value="1">
        <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;��¥����</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<INPUT TYPE=text NAME=Date1 value="<%=jldate %>" size=15 onkeydown="key(document.cus.useryear)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;"></td>
      </tr>
	   <tr> 
        <td  width="30%" class=roomleft  align="left" height="24"  > &nbsp;��Ȩ����</td>
        <td  width="50%" class=roomright   align="left" height="24">
		&nbsp;<input type=text  size=15 name="useryear" value="70"  onkeydown="key(document.cus.sd)"> 
        </td>
      
        <td  width="30%" class=roomleft  align="left" height="24"  > &nbsp;���޷�Χ</td>
        <td  width="50%" class=roomright   align="left" height="24">
		 &nbsp;<INPUT TYPE=TEXT NAME=sd  onkeydown="key(document.cus.ed)" size=10><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(sd);return false;">��
		  <br> &nbsp;<INPUT TYPE=TEXT NAME=ed  onkeydown="key(document.cus.HouseType)" size=10><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(ed);return false;">
      </td>
      </tr>
	  
      <tr align="left" > 
        <td  width="30%" class=roomleft align="left"   height="24" bgcolor="#CFE6EB">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
        <td  width="30%" class=roomright align="left"   height="24">
		&nbsp;<SELECT NAME="HouseType"  style="width : 120"  onkeydown="key(document.cus.FirstRoom)">
		<%
   for (int ii=0;ii<500;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("C"))
	       out.print("<option value="+CodeName[ii]+">"+CodeName[ii]+"</option>");
		  }
       }
  %>
     </SELECT></td>
    
        <td  width="30%" class=roomleft  align="left" height="31" bgcolor="#CFE6EB">&nbsp;ƽ&nbsp;��&nbsp;ͼ</td>
        <td  width="30%" class=roomright   align="left" height="31"> 
          &nbsp;<input type="file" name="Map" size="10" >
        </td>
	  </tr><input type="hidden"  name="YN"  value="T"  >
 
      
        <tr> 
        <td  width="30%" class=roomleft  align="left" height="31" bgcolor="#CFE6EB">&nbsp;���䷶Χ</td>
        <td  width="30%" class=roomright   align="left" height="31"> 
        &nbsp;<select name=FirstRoom  onkeydown="key(document.cus.EndRoom)" >
		<option></option>
		<%String StrUpper="ABCDEFGHIJKLMNOPQRSTUVWXYZ"; %>
		<%for (int i7=intBengR;i7<=intEndR;i7++){ 
		  	if(java.lang.Character.isDigit(RNT)){
		     out.print("<option value="+String.valueOf(i7)+">"+String.valueOf(i7)+"</option>");
			}else{
			  out.print("<option value="+StrUpper.substring(i7-1,i7)+">"+StrUpper.substring(i7-1,i7)+"</option>");
			} 
		}
		%>
			</select>-->><select name=EndRoom onkeydown="key(document.cus.FirstFloor)"  style="width : 35">
			<option></option>
			<%for (int i8=intBengR;i8<=intEndR;i8++){ 
		  	if(java.lang.Character.isDigit(RNT)){
		     out.print("<option value="+String.valueOf(i8)+">"+String.valueOf(i8)+"</option>");
			}else{
			  out.print("<option value="+StrUpper.substring(i8-1,i8)+">"+StrUpper.substring(i8-1,i8)+"</option>");
			} 
		
		}
		%>
			</select><select name=roomsd style="width : 50"><option value="0">����</option><option value="1">ż��</option><option value="2">����</option></select>
				  
        </td>
	 
        <td  width="30%" class=roomleft  align="left" height="31" bgcolor="#CFE6EB">&nbsp;¥�㷶Χ</td>
        <td  width="30%" class=roomright   align="left" height="31">&nbsp;<select name=FirstFloor onkeydown="key(document.cus.EndFloor)" >
		<%for (int i5=Integer.parseInt(strFloor);i5<=MaxFloor;i5++){ 
		  out.print("<option value="+String.valueOf(i5)+">"+String.valueOf(i5)+"</option>");
		}
		%>
		   
			</select>--><select name=EndFloor onkeydown="key(document.cus.Scellname)">
			<%for (int i6=Integer.parseInt(strFloor);i6<=MaxFloor;i6++){ 
		  out.print("<option value="+String.valueOf(i6)+">"+String.valueOf(i6)+"</option>");
		}
		%>
			</select><select name=floorstype  style="width : 50"><option value="0">����</option><option value="1">ż��</option><option value="2">����</option></select>
        </td>
	  </tr>	
	   <tr><td    class=roomleft  >��ʼ��Ԫ</td><td class=roomright  >&nbsp;<select name=Scellname onkeydown="key(document.cus.Ecellname)">
		           <option value=" "></option>
				    <option value="1">1��Ԫ</option>
					<option value="2">2��Ԫ</option>
					 <option value="3">3��Ԫ</option>
					 <option value="4">4��Ԫ</option>
					 <option value="5">5��Ԫ</option>
					 <option value="6">6��Ԫ</option>
					 <option value="7">7��Ԫ</option>
					 <option value="8">8��Ԫ</option>
					 <option value="9">9��Ԫ</option>
					 <option value="10">10��Ԫ</option>
					 <option value="11">11��Ԫ</option>
					  <option value="A">A��Ԫ</option>
					  <option value="B">B��Ԫ</option>
					  <option value="C">C��Ԫ</option>
					  <option value="D">D��Ԫ</option>
					  <option value="E">E��Ԫ</option>
					  <option value="F">F��Ԫ</option>
					  <option value="G">G��Ԫ</option>
					  <option value="H">H��Ԫ</option>
					    <option value="I">I��Ԫ</option>
						<option value="J">J��Ԫ</option>
				      <option value="K">K��Ԫ</option>
				 
		  		 
		  </select>��<select name=Ecellname onkeydown="key(document.cus.yangtai_area)">
		           <option value=" "></option>
				    <option value="1">1��Ԫ</option>
				     <option value="2">2��Ԫ</option>
					 <option value="3">3��Ԫ</option>
					 <option value="4">4��Ԫ</option>
					 <option value="5">5��Ԫ</option>
					 <option value="6">6��Ԫ</option>
					 <option value="7">7��Ԫ</option>
					 <option value="8">8��Ԫ</option>
					 <option value="9">9��Ԫ</option>
					 <option value="10">10��Ԫ</option>
					 <option value="11">11��Ԫ</option>
					  <option value="A">A��Ԫ</option>
					  <option value="B">B��Ԫ</option>
					  <option value="C">C��Ԫ</option>
					  <option value="D">D��Ԫ</option>
					  <option value="E">E��Ԫ</option>
					  <option value="F">F��Ԫ</option>
					  <option value="G">G��Ԫ</option>
					  <option value="H">H��Ԫ</option>
					    <option value="I">I��Ԫ</option>
						<option value="J">J��Ԫ</option>
				  <option value="K">K��Ԫ</option>
		  		
		  </select></td>
		   <td  width="30%" class=roomleft align="left"   height="14" bgcolor="#CFE6EB">&nbsp;��̨���</td>
        <td  width="30%" class=roomright align="left"   height="14"> 
          &nbsp;<input type=text name=yangtai_area size="15" value=0  onkeydown="key(document.cus.saveRoom)" onblur="checkNaN(this);" onchange="blur_TNAreaUnitPrice();"   >(M<sup>2</sup>)
        </td></tr>
		 <tr><td class=roomleft>��ע</td><td colspan="3"> <textarea name="roombak" cols="60" rows="4"></textarea></td></tr>
	   
	  </table>
	  ˵��:�����еķ��������¥��
	  <input type=hidden name=map1>
     <input type=hidden name=MaxFloor value=<%=MaxFloor%>>
     <input type=hidden name=para value="">
    <p align="center"> 
	  
           	 <%

String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"B005");
Cortrol+=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"B004");
   if (Cortrol==null)Cortrol="";
 
    if (Cortrol.indexOf("A")>=0){ %>
  
			<input type="Button" name="saveRoom" value="�� ��" onclick="loca();">
		   <%} %>
		
           &nbsp;&nbsp;
		   <input type="Button" name="saveRoom1" value="�� ��" onclick="window.close();"> &nbsp;&nbsp;
		   <input type="Button" name="saveRoom2" value="�� ӡ" onclick="window.print();">

          </P>
   <script>
		function loca(){
		  if (  document.cus.Date1.value==""){alert("��¥���ڲ���Ϊ��");return false;}
		  document.cus.ASumPrice.value=document.cus.SumPrice.value;//+Float.parseFloat(document.cus.lutai_unitprice.value)*Float.parseFloat(document.cus.lutai_area.value);
		  if (confirm("ȷ�ϵ�ǰ�����������")){
		  if (Validate(document.cus)){
		    document.cus.saveRoom.disabled=true;
		    document.cus.action="RoomInsert.jsp";
		    document.cus.submit();
          }		
		  }
		}
		</script>
</form>     
      <%ViewBean.closeConn();
        %> 
       
       
</body>       
</html>       
