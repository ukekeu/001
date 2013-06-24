<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>虚拟定价管理</title>
</head>

<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="javascript" src="../public_js/public.js"></script>
<script>

 function submitForm(){
      }
function showit(n){
		for(i=1;i<6;i++){
		 
           document.all("div"+i).style.display="none";
		}		
       document.all("div"+n).style.display="block";
	  document.all.page.value=n;
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
	// if (thisvalue!=""&&thisvalue.indexOf("+")<0&&thisvalue.indexOf("-")<0){
	 //th.value="+"+thisvalue;
	 //}
  }
  function outdate1(){
var dd=new Date();
   document.forms[0].projectdate.value=String(dd.getYear())+"-"+String(dd.getMonth()+1)+"-"+String(dd.getDate());
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
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/asiic.jsp"%> 
<%
    List list1=new LinkedList();//存放房间编码
	List list2=new LinkedList();//存放房间状态
	List list3=new LinkedList();//存放所在FLoor
    List list4=new LinkedList();//存放房号
	List list5=new LinkedList();//存放建筑面积
    List list6=new LinkedList();//存放当前总价
	List list7=new LinkedList();//存放当前总价
	List list8=new LinkedList();//存放当前总价
	List list9=new LinkedList();//存放由floor+room
	List list10=new LinkedList();//存放楼层附加字
 page=request.getParameter("page");
  if(page==null){
     page="1";
  }
int tab=0; 
String SecName=getbyte2(request.getParameter("SecName"));
String strSection=getbyte2(request.getParameter("SecNo"));
String Region=getbyte2(request.getParameter("Loft"));
String floortype=China.getParameter(request,"floortype");
if (floortype.equals(""))floortype=" and floortype=0";
else floortype=" and floortype="+floortype;
String RegionStr="";
float AllSumArea=0;
int AllSumPrice=0;
int AllSumNum=0;
int loftnum=0;
String state="";
String fontColor="";

String strYN=request.getParameter("yn");
   String strBuilding="";//(String)session.getAttribute("sess_build");
   strBuilding=getbyte2(request.getParameter("Build"));

String sql1="select lockroom from lockroom where section ='"+strSection+"' and ";
sql1+=" loft='"+Region+"' and build='"+strBuilding+"'";
ResultSet rsLock=null;
String lock="";
String LockRoomS="";
String Rinfo="";
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
sql1="select name from CRM_Project  where serialno ='"+strSection+"'";
 rsLock=InsertBean.executeQuery(sql1);
  if (rsLock.next()){
    SecName=getbyte(rsLock.getString("name"));
  }rsLock.close();


String  sql="select floor from";
		sql=sql+" RoomNo where SectionNo='"+strSection+"'";
		sql=sql+" and Building='"+strBuilding+"' and Region='"+Region+"' and floor=0";
ResultSet rs=InsertBean.executeQuery(sql);
int FF=0;
if (rs.next())FF=1;rs.close();
    sql="select min(Floor) as BeginF,max(Floor) as EndF,";
		 sql=sql+"min(Room) as BeginR,max(Room) as EndR,max(cell) as Ecell ,min(cell) as Scell from";
		 sql=sql+" roomno where SectionNo='"+strSection+"'";
		 sql=sql+" and building='"+strBuilding+"' and region='"+Region+"'"+floortype;// and SaleState in (1,2,3,4)";
    rs=InsertBean.executeQuery(sql);
	 
  String Ecellname="";
String Scellname="";
String RinfoStr="";
 int intBeginF=0;
 int intEndF=0;
 int intBeginR=0;
 int intEndR=0;
if (rs.next()){
  intBeginF=rs.getInt("BeginF");
  intEndF=rs.getInt("EndF");
  intBeginR=rs.getInt("BeginR");
  intEndR=rs.getInt("EndR");
  
   Ecellname=getbyte(rs.getString("Ecell"));
  Scellname=getbyte(rs.getString("Scell"));
     if (Scellname.equals("")){Scellname=" ";}
   if (Ecellname.equals("")){ Ecellname=" ";}

}
rs.close();

try{
sql="select payment,convert(varchar(10),date,120) date,state,checkstate from  试算价目表 where paymenttype=0 and  sectionno='"+strSection+"' and loft='"+Region+"' group by convert(varchar(10),date,120),payment,state,checkstate order by date";
 
	 rs = InsertBean.executeQuery(sql) ;
	 out.print("<script>");
     out.print("var payment=new Array();");
     int pay_no=0;
     while (rs.next()) {
       out.print("payment["+String.valueOf(pay_no)+"]="+"\""+getbyte(rs.getString("payment"))+"\""+";");
	   pay_no++;
      }	 
     rs.close();
     out.print("</script>");
}catch(Exception s){  out.print(s.getMessage());out.close();}



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
function checkedPaymentNoExist(){
    if (document.frm.projectname.value=="")return false;
    for (var i=0;i<payment.length;i++){
	    if (document.frm.projectname.value==payment[i]){
		 alert("此方案名称已经使用");
		 document.frm.projectname.focus();
		 return false;
		}
	}
 }
 function Validate(aForm){

  if (document.frm.TJ[0].checked){
    if (parseInt(document.frm.price.value)<=0)
    {alert("请输入基价");
	document.frm.price.focus();
	document.frm.price.select();
    return false;
    }
    if (document.frm.jjb[0].checked){
	   var sca=document.frm.DJscale.value;
      if (sca.indexOf("-")>=0)	
	    {
		if  (parseFloat(sca.substring(sca.indexOf("-")+1))==0)
		   {
		   alert("请输入你调价或定价才递增比,因你选择了递增条件");
		   document.frm.DJscale.focus();
		   return false;
		   }
	  }else if (parseFloat(sca)>0&&sca.indexOf("+")<0){
		   document.frm.DJscale.value="+"+sca;
		  
	   }else if (parseFloat(sca)==0){
		   alert("请输入你调价或定价才递增比,因你选择了递增条件");
		   document.frm.DJscale.focus();
		   document.frm.DJscale.select();
		   return false;
		}   
		  	
     }
	else{
	   if (document.frm.GDmoney.value=="0"){
	       alert("请输入固定差价金额");
		   document.frm.GDmoney.focus();
		   return false;
	   }
	    if (document.frm.GDmoney.value.indexOf("-")<0&&document.frm.GDmoney.value.indexOf("+")<0)
	   {
	    document.frm.GDmoney.value="+"+document.frm.GDmoney.value;
	   
	   }
    }
  }

  if (document.frm.TJ[1].checked){
     if (document.frm.yj[0].checked){
	   var sca=document.frm.GDscale1.value;
       if (sca.indexOf("-")>=0)	
	    {
		 if  (parseFloat(sca.substring(sca.indexOf("-")+1))==0)
		   {
		    alert("请输入你调价递增比,因你选择了 '原价逐层调价'");
		    document.frm.GDscale1.focus();
		    return false;
		   }
		}else if (parseFloat(sca)>0&&sca.indexOf("+")<0){
		   document.frm.GDscale1.value="+"+sca;
		  
	    }else if (parseFloat(sca)==0){
		   alert("请输入你调价递增比,因你选择了 '1原价逐层调价'");
		   document.frm.GDscale1.focus();
		   document.frm.GDscale1.select();
		    return false;
	    }	
	 }else{
	   if (document.frm.GDmoney1.value=="0"){
	       alert("请输入固定差价金额");
		   document.frm.GDmoney1.focus();
		   return false;
	   }  
	   if (document.frm.GDmoney1.value.indexOf("-")<0&&document.frm.GDmoney1.value.indexOf("+")<0)
	   {
	       document.frm.GDmoney1.value="+"+ document.frm.GDmoney1.value;
		
	   }
    }

  }
  if (document.frm.roomtype.value==""&&document.frm.cx.value==""&&document.frm.minArea.value==""&&document.frm.minFloor.value==""){
	  if (!getseldocs1()||getseldocs1()==""){
	  alert("请选择需要定价或调价的房号");
	  return false;
	  }
  }
  return true;	
 
 }
 function checkFloorArea(aa){
   var a1=aa.value;
  
   if (isNaN(a1)){
      alert("只能用数字表达");
	  aa.value="";
	  aa.value=1;
	  aa.focus();
  	  aa.select();
	  return false;
	}
	if (parseFloat(a1)<=0) {
	 alert("楼层号或面积只能是正数");
	  aa.focus();
	  aa.select();
	  return false;
	}
	 return true; 
  }  
 function chec(){
   for(var i=0;i<document.frm.dj.dj.length;i++)
   {
    if (document.frm.dj.dj[i].checked){
	   if (document.frm.dj.dj[i].value=="ykj"){document.frm.ykjm.value="";document.frm.ykjm.focus();}
       if (document.frm.dj.dj[i].value=="tnjj"){document.frm.tnjjs.value="";document.frm.tnjjs.focus();}
	   if (document.frm.dj.dj[i].value=="jzjj"){document.frm.jzjjs.value="";document.frm.jzjjs.focus();}
   } 
   }
 
 }
 function drawprice(){
     var c=<%=intBeginF %>;
	
	 var sum1=parseInt(document.frm.GDmoney.value.substring(document.frm.GDmoney.value.indexOf("-")+1,document.frm.GDmoney.value.length));
	 var sum2=parseInt(document.frm.GDmoney.value.substring(document.frm.GDmoney.value.indexOf("+")+1,document.frm.GDmoney.value.length));
	 var sum3=parseInt(document.frm.GDmoney1.value.substring(document.frm.GDmoney1.value.indexOf("-")+1,document.frm.GDmoney1.value.length));
	 var sum4=parseInt(document.frm.GDmoney1.value.substring(document.frm.GDmoney1.value.indexOf("+")+1,document.frm.GDmoney1.value.length));
	 var allsum1=sum1;
	 var allsum2=sum2;
	 var allsum3=sum3;
	 var allsum4=sum4;
     for(var ii=<%=intBeginF %>;ii<=<%=intEndF %>;ii++){
	    var a=ii;		
		if(c!=ii){allsum1=allsum1+sum1;allsum2=allsum2+sum2;allsum3=allsum3+sum3;allsum4=allsum4+sum4;}
	    for(var j=<%=intBeginR %>;j<=<%=intEndR %>;j++)
		{
		  var b=j;
		var aa=eval("document.frm.P"+a+b);
		if (aa)
		 {
		 if (document.frm.TJ[0].checked)
		  {
		    if (document.frm.jjb[1].checked)
		     { 
               if (document.frm.GDmoney.value.indexOf("-")==0)aa.value="-"+allsum1;		
			   if (document.frm.GDmoney.value.indexOf("+")==0)aa.value="+"+allsum2;
			 }
		  }
		  if (document.frm.TJ[1].checked)
		  {
		    if (document.frm.yj[1].checked)
		     {
			   if (document.frm.GDmoney1.value.indexOf("-")==0)aa.value="-"+allsum3;		
			   if (document.frm.GDmoney1.value.indexOf("+")==0)aa.value="+"+allsum4;					
	         }    
          }
	   }
	    }
	  c=ii;}
 }
function unitprice(units){
	 
     for(var ii=<%=intBeginF %>;ii<=<%=intEndF %>;ii++){
                var a=ii;	
     for(var j=<%=intBeginR %>;j<=<%=intEndR %>;j++)    
		{var b=j;
                var bb=eval("document.frm.unit"+units);                 
		var aa=eval("document.frm.Pr"+a+b);
                var cc=eval("document.frm.P"+a+b);
		if (aa)
		 {
                  if(cc){
				 
                     if((aa.value.substring(aa.value.length-1,aa.value.length)).indexOf(units)==0)cc.value=bb.value;  
                  }
                 }
                }
     }	
 }
</script>

<div align="center">
<form method="post" action="" name=frm onsubmit="return Validate(this);" target="_blank">
 <input type="hidden" name="page" value="">
 <input type=hidden name=sum value="0">
 <input type="hidden" name="dj" value="ykjS">
 <input type="hidden" name="condition" value="">
 <input type="hidden" name="begin" value="">
 <input type="hidden" name="end" value="">
 <input type="hidden" name="price" value="">
<table width="100%" border="0"> 
   <tr class=roomright> 
    <td width="46%" >方案名称：
	<input type="Text" name="projectname" size="18" onblur="checkedPaymentNoExist();" >
	&nbsp;&nbsp;录入时间
	<input type="Text" name="projectdate" size="18" readonly>
	</td>
  </tr>
  </table>
<%@ include file="../public_js/CodeSele.jsp"%>
  
  <table width="100%" border="0">
  <tr class=roomright> 
    <input type="hidden" name="TJ" checked value="TJ1" >
    <td width="50%" valign="top"> 
      <table width="100%" border="0">
      <!--  <tr> 
          <td colspan="2"> 
              <input type="hidden" name="TJ" checked value="TJ1" onclick="document.frm.GDscale1.focus();" >
<!--             基价定价  
          </td>
          <td width="4%">&nbsp;</td>
        </tr>-->
		<tr> 
          <td width="8%">&nbsp; </td>
          <td width="88%">
            房号范围：  <input type="text" name="RF" value="" size="5">- <input type="text" name="REnd" value="" size="5">
			<!--基准房号： <input type="text" name="basicRoom" value="" size="5" onblur="getsum();">-->
			<br>楼层范围： 
            <input type="text" name="floorRoom" value="" size="5">- <input type="text" name="floorEnd" value="" size="5">
			<input type="checkbox" value="1" name=dz>按楼层递增 
			<br>
			基价：
			<input type="text" name="gdprice" value=0 size="5" onblur="checkNaN(this);"><input type="radio" name="ch" value="1" checked>建筑单价<input type="radio" name="ch" value="0" >总价&nbsp;<input type=radio name="choosetype"  value=1 title="选中表示在基点房号价上增加或降低多少元">固定金额<input type=radio checked name="choosetype" value=2 title="选中表示在基点房号价上增加或降低多少个百分点">百分比
         </td>
          <td width="4%">&nbsp;</td>
        </tr>
		 
      </table>
    </td>
  </tr>
</table>	
<script>
function FindData(para){

window.location="PriceProjectInput.jsp?floortype="+para+"&SecNo=<%=strSection %>&Loft=<%=Region %>";
}

</script>

<p align=center><!--input type="button"  name=ck value="确认定价" onclick="drawprice();">
	<input type=reset name=cancel value="取消选择"-->
	</p>
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
     <%=SecName %> <%=Region %><%=strBuilding %>
	 
	&nbsp;&nbsp;&nbsp;&nbsp;<input type="button"  name=Ok1 value="试  算" onclick="Validate();">

 
	  <input type="button"  name=delse1 value="退 出" onclick="Validate2();">
	
      </td>
	   
    </tr>
		
  </table>
   <table border="0" width="570">
  <tr>
   <td><input type="button" class="buttoninput"  value="房  间"  onclick="showit(1);">&nbsp;<input type="button" class="buttoninput"  value="户  型"  onclick="showit(2);">&nbsp;<input type="button" class="buttoninput"  value="朝  向" onclick="showit(3);">&nbsp;<input type="button" class="buttoninput"  value="面  积" onclick="showit(4);">&nbsp;<input type="button" class="buttoninput"  value="楼  层" onclick="showit(5);setroom('Ts');"></td>
   </tr>
  </table>
  
   <% int roomint=0;
   int maxID=0;
      int xxx=0;
      int iii=0;
   StringTokenizer st22 = new StringTokenizer(LockRoomS,",") ;
    int count22 = st22.countTokens() ;
		String locaPara="Loft="+Region+"&Build="+strBuilding+"&SecNo="+strSection+"&SecName="+SecName;
		String upp="ABCDEFGHIJKLMNOPQRSTUVWXYZ";
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
		 <%}else{
		 %> 
		  <div id="div1" <%if(!page.equals("1")){%>style="display:none"<%}%>>
	 
	<%
		 for(int j2=scell;j2<=ecell;j2++){
			if (scell>0){  
			  Rinfo=AsiicZH(j2,CellN1); 
			  RinfoStr=Rinfo;
			}
			 
		 %>
		  <table width="100%" border="0" cellspacing="1" cellpadding="1"  onMouseOver="MM_showHideLayers('ebusiness','','show');" onMouseOut="MM_showHideLayers('ebusiness','','hide')">
    <tr>
		<td  width="10%" bgcolor="#489A80" align="center"><font color="#FFFFFF"<b><%if (!Rinfo.equals("")) {out.print(Rinfo+"单元");}%><br>楼层\房间</b></font></td>
	
		 <%char BeF=RoomNoUp.charAt(0);
		RoomNoUp=RoomNoUp.substring(RoomNoUp.length()-1);
        char BeR=RoomNoUp.charAt(0);
		 for(int j=intBeginR;j<=intEndR;j++){
		      String NO="";
			   NO=AsiicZH(j,BeR);//调用asiic转换方法
			if (LockRoomS.indexOf(String.valueOf(j))>=0||upp.indexOf(LockRoomS)>=0){
        
			 if (upp.indexOf(LockRoomS)>=0){
			  
			 
			 
			 if (!Lock.contains(NO)){
			loftnum++;
			%>
		     <td align="center" class=listtitle  width="10%"><font color="#ffffff"><%=NO%><br><input type="text" name="unit<%=j%>"   onchange="checkedvalue(this);coun(this.name,this.value,'<%=j2 %>');" title="数字" value="0" size=4></font><!--onblur="checkedvalue(this);unitprice('<%=NO%>')" input type=checkbox name="Rcheck1" onclick="check('<%=j%>',this.checked);"--></td>
			 <%}
			 }else if (!Lock.contains(String.valueOf(j))){loftnum++;
			 %>
			 <td align="center" class=listtitle  width=10%"><font color="#ffffff"><%=NO%><br><input type="text" name="unit<%=j%>"   onchange="checkedvalue(this);coun(this.name,this.value,'<%=j2 %>');" title="数字" value="0" size=4></font><!--input type=checkbox name="Rcheck1" onclick="check('<%=j %>',this.checked);"--></td>
			 <%} %>	
			 <%}else{loftnum++;%>
			 <td align="center" class=listtitle  width="10%"><font color="#ffffff"><%=NO%><br><input type="text" name="unit<%=j%>"   onchange="checkedvalue(this);coun(this.name,this.value,'<%=j2 %>');" title="数字" value="0" size=4></font><!--input type=checkbox name="Rcheck1" onclick="check('<%=j %>',this.checked);"--></td>
			 
			 <%}
			 
			 }%>  <td align="center" class=listtitle  width=10%"><font color="#ffffff">楼层均价</font></td>	
	</tr>
    	<%
		//String upp="ABCDEFGHIJKOPQRST";
		

		//int nn=0;
try{
		
 
	String floormess="";//楼层附加字
    String StrUpper="ABCDEFGHIJKLOPQ"; 
	String sqlArr="select  distinct Room_code,saleState,Floor,Room,area1,Sumprice,roomtype,direction,floormess from roomstateview where seccode=";
		   sqlArr=sqlArr+"'"+strSection+"'";
		   sqlArr=sqlArr+" and  loft='"+Region+"' and cell='"+Rinfo+"'  and building='"+strBuilding+"'  and SaleState in (1,2,3,4,5,6) "+floortype+" order by  Floor";

		   ResultSet rsArr=InsertBean1.executeQuery(sqlArr);
		  list1.clear();
		   list2.clear();
		   list3.clear();
		   list4.clear();
		   list5.clear();
		   list6.clear();
		   list7.clear();
		   list8.clear();
		   list9.clear();
		   list10.clear();
		   int aryi=0;
		   while (rsArr.next()){
		    roomint++;
		        list1.add(getbyte(rsArr.getString("Room_code")));
			list2.add(getbyte(rsArr.getString("SaleState")));
			
			String fl=rsArr.getString("Floor");
			String ro=rsArr.getString("Room");
		//	out.print(getbyte(rsArr.getString("Room_code")));
			list3.add(getbyte(fl));
			list4.add(getbyte(ro));
			if (Integer.parseInt(ro)>9)
			  list9.add(getbyte(fl+ro));
			else
			  list9.add(getbyte(fl+"0"+ro));  
			  
			list5.add(getbyte(rsArr.getString("area1")));
			list6.add(getbyte(rsArr.getString("Sumprice")));
			list7.add(getbyte(rsArr.getString("roomtype")));
			list8.add(getbyte(rsArr.getString("direction")));
			 
			 list10.add(getbyte(rsArr.getString("floormess")));
		   } 
	      rsArr.close();
		int arrlen=0;
	 %>
	<%for(iii=intBeginF;iii<=intEndF;iii++){
	// if (FF==iii &&FF==0) {FF=1;  continue;}
	 
	    String Fn="";
		if (iii<0) Fn="_"+String.valueOf(java.lang.Math.abs(iii));
		else Fn=String.valueOf(iii);
	%>
	<tr>
     <td align="center" class=FloorC width="10%"><font color="#ffffff"><div id=A<%=java.lang.Math.abs(iii)+1 %>w1><%=iii%></div><input size=3 type=text name="F<%=Fn %>" onchange="coun(this.name,this.value,'<%=j2 %>');"  ><!--input type=checkbox name="pcheck<%=iii %>" onclick="check<%=iii %>();"--></font></td>
		<%
		int IntAvgSumPrice=0;;
		float FatAreaSum=0;
		for(int j=intBeginR;j<=intEndR;j++){
		//out.print(j);
		String RoomNo="";
		String no="";
		 	
		if (j>=10){
		  RoomNo=String.valueOf(iii)+String.valueOf(j);
		 
		}else
		  RoomNo=String.valueOf(iii)+"0"+String.valueOf(j);
		arrlen+=1;
		
	
		if (list9.contains(RoomNo)){
		   int index=list9.indexOf(RoomNo);
		   state=(String)list2.get(index);
		   no=(String)list4.get(index);
		   RoomNo=(String)list1.get(index);
		   floormess=(String)list10.get(index);
          try{              
              String l6=(String)list6.get(index);
              String l5=(String)list5.get(index);
              if (l6.equals(""))l6="0";
              if (l5.equals(""))l5="0";
		      IntAvgSumPrice+=Float.parseFloat(l6);
		      FatAreaSum+=Float.parseFloat(l5);
		      AllSumArea+=Float.parseFloat(l5);
		      AllSumPrice+=Float.parseFloat(l6);
          }catch(Exception s){out.print(s.getMessage()+"error");out.close();}
		   AllSumNum++;
		}else{state="";}  
		String fontcolor="";
    	if (!Lock.contains(String.valueOf(j))){ 
		%>
	     <td align="center"  class=listcontent  width="10%"> 
	     <% if (state.equals("0")){ 
	     %>
	       <%}else if (state.equals("1")){
	       fontcolor="<font color='red'>";
	     %>
 	       
	     <%}%>
	  
	    
	  <%if (!state.equals("")){ %>
	  <%=fontcolor %>
	    <%=RoomNo%></font>
		</a>

		<%if(state.equals("1")){%>
		<input type="text" size=4 name="P<%=Rinfo %><%=Fn%>A<%=j %>" tab=<%=++tab%>  onblur="checkedvalue(this);" title="数字" value="0"><input type=hidden name="Pr<%=Rinfo %><%=Fn%>A<%=j %>" value="<%=RoomNo%>">
		<%}else{%>
		<input type="hidden" size=4 name="P<%=Rinfo %><%=Fn%>A<%=j %>" tab=<%=++tab%>  onblur="checkedvalue(this);" title="数字" value="0"><input type=hidden name="Pr<%=Rinfo %><%=Fn%>A<%=j %>" value="<%=RoomNo%>">
		<%} %>
	   </td> 
		<%   
        }
		
		}
		}%>
		 <td  width="20%"><b><u><%=FormtD.getFloat(IntAvgSumPrice/FatAreaSum,2) %></u></b></td>	
	
  <script>A<%=java.lang.Math.abs(iii)+1 %>w1.innerHTML="<% if (!floormess.equals("")) out.print(floormess);else out.print(iii);%>";</script>
	
	</tr>
	
	 <script>
	
	    function check<%=Fn %>(){
		  for(var ii=1;ii<=<%=intEndF %>;ii++){
		  var aa=<%=String.valueOf(Fn)%>;
		  var chec="pcheck";
		     chec=chec+aa;
			 aa="P"+aa;
			 aa=aa+"A"+ii; 

		  if (eval("document.frm."+aa)){//判断对象是否存在
		    aa=eval("document.frm."+aa);
		    chec=eval("document.frm."+chec);
			//alert(chec.checked);
		    if (!aa.disabled)aa.checked=chec.checked;
			document.frm.Ok.disabled=!(chec.checked);
		   }
		  }
	    }
	  function butoncheck(){
	
	  // document.frm.Ok.disabled=getseldocs1();//!(frm.checked);
	  }
	  
	  function ChangePrice(frm){
	  if (frm.checked)document.frm.price.value=0;
	  
	  
	  }
	   </script>
	<% }

}catch(Exception s){out.println(s.getMessage()+"a");}%>
	
  </table>
  
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
   <%}%>
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
    
	<input type="hidden" name="AllSumNum_S" value="<%=AllSumNum_S%>">
<input type="hidden" name="AllSumArea_S" value="<%=FormtD.getFloat(AllSumArea_S,4) %>">
<input type="hidden" name="AllSumPrice_S" value="<%=AllSumPrice_S%>">
<input type="hidden" name="AllUnitArea_S" value="<%=FormtD.getFloat(AllSumPrice_S/AllSumArea_S,2) %>">
  </div>
  <div id="div2" <%if(!page.equals("2")){%>style="display:none"<%}%>>

	<%
		 for(int j2=scell;j2<=ecell;j2++){
			if (scell>0){  
			  Rinfo=AsiicZH(j2,CellN1); 
			}
			String	sqlArr="select  distinct Room_code,saleState,Floor,Room,area1,Sumprice,roomtype,direction,floormess from roomstateview where seccode=";
		   sqlArr=sqlArr+"'"+strSection+"'";
		   sqlArr=sqlArr+" and  loft='"+Region+"' and cell='"+Rinfo+"'  and building='"+strBuilding+"'  and SaleState in (1,2,3,4,5,6) "+floortype+" order by  Floor";
 
		   ResultSet rsArr=InsertBean1.executeQuery(sqlArr);
		  roomint=0;
		   int aryi=0;
		   list1.clear();
		   list2.clear();
		   list3.clear();
		   list4.clear();
		   list5.clear();
		   list6.clear();
		   list7.clear();
		   list8.clear();
		   list9.clear();
		   list10.clear();
		   while (rsArr.next()){
		    roomint++;
		    list1.add(getbyte(rsArr.getString("Room_code")));
			list2.add(getbyte(rsArr.getString("SaleState")));
			
			String fl=rsArr.getString("Floor");
			String ro=rsArr.getString("Room");
		//	out.print(getbyte(rsArr.getString("Room_code")));
			list3.add(getbyte(fl));
			list4.add(getbyte(ro));
			if (Integer.parseInt(ro)>9)
			  list9.add(getbyte(fl+ro));
			else
			  list9.add(getbyte(fl+"0"+ro));  
			  
			list5.add(getbyte(rsArr.getString("area1")));
			list6.add(getbyte(rsArr.getString("Sumprice")));
			list7.add(getbyte(rsArr.getString("roomtype")));
			 
			list8.add(getbyte(rsArr.getString("direction")));
			 
			 list10.add(getbyte(rsArr.getString("floormess")));
		   } 
	      rsArr.close();
		 %>

      <table width="100%" border="0" cellspacing="1" cellpadding="1"  onMouseOver="MM_showHideLayers('ebusiness','','show');" onMouseOut="MM_showHideLayers('ebusiness','','hide')">
    <tr>
     <td align="center" class=FloorC width="10%">
	 <font color="#ffffff">楼层</font></td> <td align="center" class=listtitle><font color="#ffffff">房间</font></td>
	 <td align="center" class=listtitle><font color="#ffffff">户型</font></td>
	 <td align="center" class=listtitle><font color="#ffffff">差价</font></td>
	  <td align="center" class=listtitle><font color="#ffffff">操作</font></td>
	 </tr>
	<%
	
	int aaa=0;
	for(iii=0;iii<roomint;iii++){
	 //  if (iii==0) continue;
	   String room2=(String)list1.get(iii);
	   String state2=(String)list2.get(iii);
	   String no2=(String)list4.get(iii);
	   String roomtype2=(String)list7.get(iii);
	   String dda=(String)list3.get(iii);
	   String Fn=(String)list3.get(iii);

	   if (Fn.indexOf("-")>=0) Fn="_"+Fn.substring(Fn.indexOf("-")+1);
	
	   if(state2.equals("1")){%>
	<tr>
	<td align="center"  class=listcontent ><%= dda%></td>
     <td align="center" class=FloorC width="10%"><font color="#ffffff"><a href="#" onclick="javascript:openwin('../basic/crm_RoomEdit.jsp?loft=<%=Region %>&seccode=<%=strSection%>&building=<%=strBuilding%>&Floor=<%=dda%>&Room_code=<%=room2%>&MaxFloor=<%=intEndF%>&BengR=<%=no2 %>&EndR=<%=no2 %>&RoomNoType=<%=room2 %>',400,500,150,10);" title="已输入"> <%=room2%></font></td>

	 <td align="center"  class=listcontent ><%= roomtype2%><input type="hidden" name="Qs<%=Rinfo %><%=iii %>" value="<%=roomtype2%>"></td>
	 <td align="center"  class=listcontent ><input type="text" size=4 name="Q<%=Rinfo %><%=iii%>"  onblur="checkedvalue(this);" title="数字" value="0"><input type=hidden name="Qr<%=iii%>" value="<%=room2%>">
	 <td align="center"  class=listcontent >&nbsp;
	   <%if(aaa==0){ %><input type="Button" name="room2add" value="快速" onclick="javascript:openwin2('FastSet.jsp?Rinfo=<%=Rinfo %>&page=<%=page %>&itemname=户型',400,300,150,10);setroom('Qs<%=Rinfo %>',<%=roomint %>);"><%} %></td>
	
	 <%aaa++;}else{%>
	 <input type="hidden" name="Qs<%=Rinfo %><%=iii %>">
	 <input type="hidden" size=4 name="Q<%=Rinfo %><%=iii%>"  onblur="checkedvalue(this);" title="数字" value="0">
	 <input type=hidden name="Qr<%=Rinfo %><%=iii%>" value="<%=room2%>">
	 <%} %>
 
       <%} %>
  </table>
  <%} %>
  </div>
   <div id="div3" <%if(!page.equals("3")){%>style="display:none"<%}%>>
   <%
		 for(int j2=scell;j2<=ecell;j2++){
			if (scell>0){  
			  Rinfo=AsiicZH(j2,CellN1); 
			}
			String	sqlArr="select  distinct Room_code,saleState,Floor,Room,area1,Sumprice,roomtype,direction,floormess from roomstateview where seccode=";
		   sqlArr=sqlArr+"'"+strSection+"'";
		   sqlArr=sqlArr+" and  loft='"+Region+"' and cell='"+Rinfo+"'  and building='"+strBuilding+"'  and SaleState in (1,2,3,4,5,6) "+floortype+" order by  Floor";
 
		   ResultSet rsArr=InsertBean1.executeQuery(sqlArr);
		  roomint=0;
		   int aryi=0;
		   list1.clear();
		   list2.clear();
		   list3.clear();
		   list4.clear();
		   list5.clear();
		   list6.clear();
		   list7.clear();
		   list8.clear();
		   list9.clear();
		   list10.clear();
		   while (rsArr.next()){
		    roomint++;
		    list1.add(getbyte(rsArr.getString("Room_code")));
			list2.add(getbyte(rsArr.getString("SaleState")));
			
			String fl=rsArr.getString("Floor");
			String ro=rsArr.getString("Room");
		//	out.print(getbyte(rsArr.getString("Room_code")));
			list3.add(getbyte(fl));
			list4.add(getbyte(ro));
			if (Integer.parseInt(ro)>9)
			  list9.add(getbyte(fl+ro));
			else
			  list9.add(getbyte(fl+"0"+ro));  
			  
			list5.add(getbyte(rsArr.getString("area1")));
			list6.add(getbyte(rsArr.getString("Sumprice")));
			list7.add(getbyte(rsArr.getString("roomtype")));
			 
			list8.add(getbyte(rsArr.getString("direction")));
			 
			 list10.add(getbyte(rsArr.getString("floormess")));
		   } 
	      rsArr.close();
		 %>
    <table width="100%" border="0" cellspacing="1" cellpadding="1"  onMouseOver="MM_showHideLayers('ebusiness','','show');" onMouseOut="MM_showHideLayers('ebusiness','','hide')">
    <tr>
	  <td align="center" class=FloorC width="10%">
	 <font color="#ffffff">楼层</font></td> 
     <td align="center" class=FloorC width="10%"><font color="#ffffff">房间</font></td>
	 <td align="center" class=listtitle><font color="#ffffff">朝向</font></td>
	 <td align="center" class=listtitle><font color="#ffffff">差价</font></td>
	  <td align="center" class=listtitle><font color="#ffffff">操作</font></td>
	 </tr>
	<%
	int aaa=0;
	for(iii=0;iii<roomint;iii++){
	   String room3=(String)list1.get(iii);
	   String state3=(String)list2.get(iii);
	   String no3=(String)list4.get(iii);
	   String direction3=(String)list8.get(iii);
	   String dda=(String)list3.get(iii);
	   String Fn=(String)list3.get(iii);
	    if (Fn.indexOf("-")>=0) Fn="_"+Fn.substring(Fn.indexOf("-")+1);
	   if(state3.equals("1")){%>
	<tr>
	 <td align="center"  class=listcontent ><%= dda%> </td>
     <td align="center" class=FloorC width="10%"><font color="#ffffff"><a href="#" onclick="javascript:openwin('../basic/RoomEdit.jsp?loft=<%=Region %>&seccode=<%=strSection%>&building=<%=strBuilding%>&Floor=<%=dda%>&Room_code=<%=room3%>&MaxFloor=<%=intEndF%>&BengR=<%=no3 %>&EndR=<%=no3 %>&RoomNoType=<%=room3 %>',400,500,150,10);" title="已输入"> <%=room3%></font></td>
	 <td align="center"  class=listcontent ><%= direction3%><input type="hidden" name="Rs<%=Rinfo %><%=iii %>" value="<%=direction3%>"></td>
	 <td align="center"  class=listcontent ><input type="text" size=4 name="R<%=Rinfo %><%=iii%>"  onblur="checkedvalue(this);" title="数字" value="0"><input type=hidden name="Rr<%=Rinfo %><%=iii%>" value="<%=room3%>">
	 <td align="center"  class=listcontent >&nbsp;
	     <%if(aaa==0){ %><input type="Button" name="room3add" value="快速" onclick="javascript:openwin2('FastSet.jsp?Rinfo=<%=Rinfo %>&page=<%=page %>&itemname=朝向',400,300,150,10);setroom('Rs<%=Rinfo %>',<%=roomint %>);"><%} %></td>

	  <%aaa++;}else{%>
	 <input type="hidden" name="Rs<%=Rinfo %><%=iii %>">
	 <input type="hidden" size=4 name="R<%=Rinfo %><%=iii%>"  onblur="checkedvalue(this);" title="数字" value="0">
	 <input type=hidden name="Rr<%=Rinfo %><%=iii%>" value="<%=room3%>">
	 <%} %>
      	<%} %>
  </table>
  <%} %>
   </div>
    <div id="div4" <%if(!page.equals("4")){%>style="display:none"<%}%>>
	<%
		 for(int j2=scell;j2<=ecell;j2++){
			if (scell>0){  
			  Rinfo=AsiicZH(j2,CellN1); 
			}
			String	sqlArr="select  distinct Room_code,saleState,Floor,Room,area1,Sumprice,roomtype,direction,floormess from roomstateview where seccode=";
		   sqlArr=sqlArr+"'"+strSection+"'";
		   sqlArr=sqlArr+" and  loft='"+Region+"' and cell='"+Rinfo+"'  and building='"+strBuilding+"'  and SaleState in (1,2,3,4,5,6) "+floortype+" order by  Floor";
 
		   ResultSet rsArr=InsertBean1.executeQuery(sqlArr);
		  roomint=0;
		   int aryi=0;
		   list1.clear();
		   list2.clear();
		   list3.clear();
		   list4.clear();
		   list5.clear();
		   list6.clear();
		   list7.clear();
		   list8.clear();
		   list9.clear();
		   list10.clear();
		   while (rsArr.next()){
		    roomint++;
		    list1.add(getbyte(rsArr.getString("Room_code")));
			list2.add(getbyte(rsArr.getString("SaleState")));
			
			String fl=rsArr.getString("Floor");
			String ro=rsArr.getString("Room");
		//	out.print(getbyte(rsArr.getString("Room_code")));
			list3.add(getbyte(fl));
			list4.add(getbyte(ro));
			if (Integer.parseInt(ro)>9)
			  list9.add(getbyte(fl+ro));
			else
			  list9.add(getbyte(fl+"0"+ro));  
			  
			list5.add(getbyte(rsArr.getString("area1")));
			list6.add(getbyte(rsArr.getString("Sumprice")));
			list7.add(getbyte(rsArr.getString("roomtype")));
			 
			list8.add(getbyte(rsArr.getString("direction")));
			 
			 list10.add(getbyte(rsArr.getString("floormess")));
		   } 
	      rsArr.close();
		 %>
	<table width="100%" border="0" cellspacing="1" cellpadding="1"  onMouseOver="MM_showHideLayers('ebusiness','','show');" onMouseOut="MM_showHideLayers('ebusiness','','hide')">
    <tr>
	  <td align="center" class=FloorC width="10%">
	 <font color="#ffffff">楼层</font></td> 
     <td align="center" class=FloorC width="10%"><font color="#ffffff">房间</font></td>
	 <td align="center" class=listtitle><font color="#ffffff">面积</font></td>
	 <td align="center" class=listtitle><font color="#ffffff">差价</font></td>
	  <td align="center" class=listtitle><font color="#ffffff">操作</font></td>
	 </tr>
	<%
	int aaa=0;
	for(iii=0;iii<roomint;iii++){
	   String room4=(String)list1.get(iii);
	   String state4=(String)list2.get(iii);
	   String no4=(String)list4.get(iii);
	   String area4=(String)list5.get(iii);
	   String Floor=(String)list3.get(iii);
	   String dda=(String)list3.get(iii);
	   String Fn=(String)list3.get(iii);
	    if (Fn.indexOf("-")>=0) Fn="_"+Fn.substring(Fn.indexOf("-")+1);
	   if(state4.equals("1")){%>
	<tr>
	 <td align="center"  class=listcontent ><%= dda%></td>
     <td align="center" class=FloorC width="10%"><font color="#ffffff"><a href="#" onclick="javascript:openwin('../basic/RoomEdit.jsp?loft=<%=Region %>&seccode=<%=strSection%>&building=<%=strBuilding%>&Floor=<%=dda%>&Room_code=<%=room4%>&MaxFloor=<%=intEndF%>&BengR=<%=no4 %>&EndR=<%=no4 %>&RoomNoType=<%=room4 %>',400,500,150,10);" title="已输入"> <%=room4%></font></td>
	 <td align="center"  class=listcontent ><%= area4%><input type="hidden" name="Ss<%=Rinfo %><%=iii %>" value="<%=area4%>"><input type="hidden" name="F<%=iii %>" value="<%=Floor%>"></td>
	 <td align="center"  class=listcontent ><input type="text" size=4 name="S<%=Rinfo %><%=iii%>"  onblur="checkedvalue(this);" title="数字" value="0"><input type=hidden name="Sr<%=Rinfo %><%=iii%>" value="<%=room4%>">
	 <td align="center"  class=listcontent >&nbsp;
	   <%if(aaa==0){ %>差价：<input type=text name=a1" size=5 onblur="counR(this.value,'<%=Rinfo %>',<%=roomint %>);"><input type="Button" name="room4add" value="快速" onclick="javascript:openwin2('FastSet1.jsp?Rinfo=<%=Rinfo %>&page=<%=page %>&itemname=面积',400,300,150,10);setroom('Ss<%=Rinfo %>',<%=roomint %>);"><%} %></td>
	
	  <%aaa++;}else{%>
	 <input type="hidden" name="Ss<%=Rinfo %><%=iii %>">
	 <input type="hidden" size=4 name="S<%=Rinfo %><%=iii%>"  onblur="checkedvalue(this);" title="数字" value="0">
	 <input type=hidden name="Sr<%=Rinfo %><%=iii%>" value="<%=room4%>">
	 <%} %>
      <%} %>
  </table>
  <%} %>
   </div>
    <div id="div5" <%if(!page.equals("5")){%>style="display:none"<%}%>>
	<%
		 for(int j2=scell;j2<=ecell;j2++){
			if (scell>0){  
			  Rinfo=AsiicZH(j2,CellN1); 
			}
			String	sqlArr="select  distinct Room_code,saleState,Floor,Room,area1,Sumprice,roomtype,direction,floormess from roomstateview where seccode=";
		   sqlArr=sqlArr+"'"+strSection+"'";
		   sqlArr=sqlArr+" and  loft='"+Region+"' and cell='"+Rinfo+"'  and building='"+strBuilding+"'  and SaleState in (1,2,3,4,5,6) "+floortype+" order by  Floor";
 
		   ResultSet rsArr=InsertBean1.executeQuery(sqlArr);
		  roomint=0;
		   int aryi=0;
		   list1.clear();
		   list2.clear();
		   list3.clear();
		   list4.clear();
		   list5.clear();
		   list6.clear();
		   list7.clear();
		   list8.clear();
		   list9.clear();
		   list10.clear();
		   while (rsArr.next()){
		    roomint++;
		    list1.add(getbyte(rsArr.getString("Room_code")));
			list2.add(getbyte(rsArr.getString("SaleState")));
			
			String fl=rsArr.getString("Floor");
			String ro=rsArr.getString("Room");
		//	out.print(getbyte(rsArr.getString("Room_code")));
			list3.add(getbyte(fl));
			list4.add(getbyte(ro));
			if (Integer.parseInt(ro)>9)
			  list9.add(getbyte(fl+ro));
			else
			  list9.add(getbyte(fl+"0"+ro));  
			  
			list5.add(getbyte(rsArr.getString("area1")));
			list6.add(getbyte(rsArr.getString("Sumprice")));
			list7.add(getbyte(rsArr.getString("roomtype")));
			 
			list8.add(getbyte(rsArr.getString("direction")));
			 
			 list10.add(getbyte(rsArr.getString("floormess")));
		   } 
	      rsArr.close();
		 
		 %>
	<table width="100%" border="0" cellspacing="1" cellpadding="1"  onMouseOver="MM_showHideLayers('ebusiness','','show');" onMouseOut="MM_showHideLayers('ebusiness','','hide')">
    <tr>
     <td align="center" class=FloorC width="10%"><font color="#ffffff">房间</font></td>
	 <td align="center" class=listtitle><font color="#ffffff">楼层</font></td>
	 <td align="center" class=listtitle><font color="#ffffff">差价</font></td>
	  <td align="center" class=listtitle><font color="#ffffff">操作</font></td>
	 </tr>
	<%int aaa=0; 
	   for(iii=0;iii<roomint;iii++){
	   String room5=(String)list1.get(iii);
	   String state5=(String)list2.get(iii);
	   String no5=(String)list4.get(iii);
	   String floor5=(String)list3.get(iii);
	   String Fn=(String)list3.get(iii);
	    if (Fn.indexOf("-")>=0) Fn="_"+Fn.substring(Fn.indexOf("-")+1);
	   if(state5.equals("1")){%>
	<tr>
     <td align="center" class=FloorC width="10%"><font color="#ffffff"><%=room5%></font></td>
	 <td align="center"  class=listcontent ><%= floor5%><input type="hidden" name="Ts<%=Rinfo %><%=iii %>" value="<%=floor5%>"></td>
	 <td align="center"  class=listcontent ><input type="text" size=4 name="T<%=Rinfo %><%=iii%>"  title="数字" value="0" onchange="ddd('<%=floor5 %>','<%=iii%>')"><input type=hidden name="Tr<%=Rinfo %><%=iii%>" value="<%=room5%>">
	 <td align="center"  class=listcontent >&nbsp;
	   <%if(aaa==0){ maxID=roomint;%> 差价：<input type=text name=a" size=5 onblur="counF(this.value,'<%=Rinfo %>',<%=roomint %>);"><!----><input type="button" name="room5add" value="快速" onclick="javascript:openwin2('FastSet1.jsp?Rinfo=<%=Rinfo %>&page=<%=page %>&itemname=楼层',400,300,150,10);setroom('Ts<%=Rinfo %>',<%=roomint %>);"><%} %></td>
	
	  <%aaa++;}else{%>
	 <input type="hidden" name="Ts<%=Rinfo %><%=iii %>" value="<%=floor5%>">
	 <input type="hidden" size=4 name="T<%=Rinfo %><%=iii%>"  title="数字" value="0" onchange="ddd('<%=floor5 %>','<%=iii%>')">
	 <input type=hidden name="Tr<%=Rinfo %><%=iii%>" value="<%=room5%>">
	 <%} %>
       <%} %>
  </table>
  <%} %>
   </div>
  

  <%}roomint=maxID;
  if (ecell==0)ecell=1;
  %>
  
  <p align=center><input type="button"  name=Ok value="试  算" onclick="Validate();">
 	  <input type="button"  name=delse value="退 出" onclick="Validate2();">
	</p>
  <script>
  function Validate2(){
 // opener.window.location.reload();
     var arr=new Array(1);
	 arr[0]=1;
	 returnValue=arr;
	 
     window.close();
  //  document.frm.action="PriceList3.jsp?allint=<%=roomint %>&loftnum=<%=loftnum %>";
	//document.frm.submit();
  }
  function Validate(){
   if (document.frm.projectname.value=="")
    {alert("请输入方案名称");
	document.frm.projectname.focus();
    return false;
    }
    document.frm.action="xy_PriceList2.jsp?Ecellname=<%=Ecellname %>&Scellname=<%=Scellname %>&allint=<%=roomint %>&loftnum=<%=loftnum/ecell %>";
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
    document.frm.action="PriceListSave.jsp?Ecellname=<%=Ecellname %>&Scellname=<%=Scellname %>&allint=<%=roomint %>";
	document.frm.submit();
  }
  var getall = new Array();		
  function setroom(room,para){
        // var basicRoom=document.frm.basicRoom.value;
	     getall= new Array();
		 for(i=0;i<para;i++){
		  getall[i]=room+i;	
	 
		  var jj=eval("document.frm.Tr"+i);
		  if (jj){
		  //  if(jj.value==basicRoom)document.frm.sum.value=i;
			}
		 }
  }
  function getsum(){
       // var basicRoom=document.frm.basicRoom.value;
		 for(i=0;i<getall.length;i++){
		  var jj=eval("document.frm.Tr"+i);
		  if (jj){
		  //  if(jj.value==basicRoom)document.frm.sum.value=i;
			}
		 }
  
  }
  function ddd(x,y){
		if(getall.length>0){
		 for(i=0;i<getall.length;i++){
		  var jj=eval("document.frm.T"+i);
		  var tt=eval("document.frm.T"+y);
		  if(jj){
		  if ((document.all(getall[i])).value==x){
	
		    jj.value=tt.value;
		
			}
			}
		 }
     }
  }
  function getpage(para){
        var frm1=document.frm.condition.value;
		var begin=document.frm.begin.value;
		var end=document.frm.end.value;
		var floorRoom=document.frm.floorRoom.value;
		var frm2=document.frm.price.value;
		var cc="";
		 
		for (i=0;i<getall.length;i++) {
		   
           if ((document.all(getall[i]).value==frm1)&&(frm.page.value==2))
		     {  
			
       		   cc=getall[i];
			   if (para=="")
			   cc=cc.substring(cc.indexOf("s") + 1);
			   else
			    cc=cc.substring(cc.indexOf("s") + 2);
			 
			   var aa=eval("document.frm.Q"+para+cc);
			   if (aa)aa.value=frm2;
		     }
		  if ((document.all(getall[i]).value==frm1)&&(frm.page.value==3))
		     {
       		   cc=getall[i];
			   
			  if (para=="")
			   cc=cc.substring(cc.indexOf("s") + 1);
			   else
			    cc=cc.substring(cc.indexOf("s") + 2);
			   var aa=eval("document.frm.R"+para+cc);
			   
			   if (aa)aa.value=frm2;
		     }
			  
		   if ((parseFloat(document.all(getall[i]).value)>=parseFloat(begin))&& (parseFloat(document.all(getall[i]).value)<=parseFloat(end))&&(frm.page.value==4))
		     {
       		   cc=getall[i];
			   if (para=="")
			   cc=cc.substring(cc.indexOf("s") + 1);
			   else
			    cc=cc.substring(cc.indexOf("s") + 2);
			   var aa=eval("document.frm.S"+para+cc);
			  
			   if (aa)aa.value=frm2;
		     }
			if ((parseInt(document.all(getall[i]).value)>=begin)&& (parseInt(document.all(getall[i]).value)<=end)&&(frm.page.value==5))
		     {
       		   cc=getall[i];
			  
			    if (para=="")
			   cc=cc.substring(cc.indexOf("s") + 1);
			   else
			    cc=cc.substring(cc.indexOf("s") + 2);
				   
			   var aa=eval("document.frm.T"+para+cc);
			 
			 if (aa)aa.value=frm2;
			   if (aa){
			   if(parseInt(document.all(getall[i]).value)==parseInt(floorRoom))aa.value="0";
			   if(parseInt(document.all(getall[i]).value)<parseInt(floorRoom)){
			     if(frm2.indexOf("+")==0)
				   aa.value="-"+frm2.substring(frm2.indexOf("+")+1);
				 else 
				   aa.value="+"+frm2.substring(frm2.indexOf("-")+1);  
			   }
			   if(parseInt(document.all(getall[i]).value)>parseInt(floorRoom))aa.value=frm2;
			  }
		     }
	     }
  }
  function check(frm1,frm2){
     /* for(var ii=1;ii<=<%=intEndF %>;ii++){
	    var a=ii+frm1;
		var aa=eval("document.frm.P"+a);
		if (aa){
		    if (!aa.disabled){aa.checked=frm2;
		   document.frm.Ok.disabled=aa.disabled;
		  }
        }
	  }*/
  }
 
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
  var roomtype=new Array();
  var direct=new Array();
  var area=new Array();
  var fl=new Array();
   var roomno=new Array();
  <%
  for (int ii=0;ii<list1.size();ii++) {
    out.print("roomtype["+ii+"]='"+list7.get(ii)+"';");
	out.print("direct["+ii+"]='"+list8.get(ii)+"';");
	out.print("area["+ii+"]='"+list5.get(ii)+"';");
	out.print("fl["+ii+"]='"+list4.get(ii)+"';");
	out.print("roomno["+ii+"]='"+list3.get(ii)+"';");
   }
   %>
  function chooseRoom(){
      var roomtypeSele=frm.roomtype.value;
      var jj=0;
	  for (i=0;i<frm.elements.length;i++) {
       if (frm.elements[i].type=="checkbox"&&frm.elements[i].name.substring(0,1)=="P")
		  { 
		  if (frm.elements[i].tab>0){
		   if (roomtype[frm.elements[i].tab-1]==roomtypeSele)
       		frm.elements[frm.elements[i].tab].checked=true;
			
		}	
   		 }
	  }	
  }
   var sd=<%=intBeginF %>;
   var ed=<%=intEndF %>;
   var sd1=<%=intBeginR %>;
   var ed1=<%=intEndR %>;

   function coun(para,para1,para2){ 
   var para3=para2;
   if (para3=="")para3="1";
   if (para1!="") {

    var money=parseFloat(para1);
     if (document.frm.floorRoom.value!==""&&document.frm.floorEnd.value!==""){
	     sd=parseInt(document.frm.floorRoom.value);
		 ed=parseInt(document.frm.floorEnd.value);
	 }
	
    if (para.indexOf("unit")==0){ 
	
	for (var ce=parseInt(para3);ce<=<%=ecell %>;ce++){
	
    for (var dd=sd;dd<=ed;dd++){
	var abc="";
		  
	//if (dd!=0) continue;
	if(dd<0)abc="_"+(-dd);
	else abc=dd;
	var eee
	if (isNaN("<%=RinfoStr %>")){	 
	var cellstr="ABCDEFGHIJKLMNOPQRSTUVWXYZ ";
	  eee=cellstr.substring(ce-1,ce);
	 }else{
	  eee=ce;
	 }
	 
 
	 var ddd
	 if (para2==""||"<%=RinfoStr %>"=="")
	   ddd=eval("document.all.P"+abc+"A"+para.substring(para.indexOf("unit")+4));
	 else
	    ddd=eval("document.all.P"+eee+abc+"A"+para.substring(para.indexOf("unit")+4)); 
	   if (document.frm.floorRoom.value!==""&&document.frm.floorEnd.value!==""){
	   
   	    if (dd>=parseInt(document.frm.floorRoom.value)&&dd<=parseInt(document.frm.floorEnd.value)){
		
	     if (ddd){
	      if (document.all.dz.checked&&dd>1)money=dd*parseFloat(para1);
	      if (ddd.value=="")ddd.value="0";
	      ddd.value=money;//+parseFloat(ddd.value);
	    }
		
		}else{
		 
		 break;
		
		 }
		}else{
		   if (ddd){
		   
	         if (document.all.dz.checked&&dd>1)money=dd*parseFloat(para1);
	         if (ddd.value=="")ddd.value="0";
	         ddd.value=money;//+parseFloat(ddd.value);
	       } 
		}
     }}
   }else if (para.indexOf("F")==0){ 

      if (document.frm.RF.value!=="")sd1=document.frm.RF.value;
	  if (document.frm.REnd.value!=="")ed1=document.frm.REnd.value;
	 
	  for (var ce=parseInt(para3);ce<=<%=ecell %>;ce++){
	
      for (var dd=sd1;dd<=ed1;dd++){
	   var eee
	if (isNaN("<%=RinfoStr %>")){	 
	var cellstr="ABCDEFGHIJKLMNOPQRSTUVWXYZ ";
	  eee=cellstr.substring(ce-1,ce);
	 }else{
	  eee=ce;
	 }
	 var ddd
	  
	  if (para2==""||"<%=RinfoStr %>"=="")
        ddd=eval("document.all.P"+para.substring(para.indexOf("F")+1)+"A"+dd);
	  else
	     ddd=eval("document.all.P"+eee+para.substring(para.indexOf("F")+1)+"A"+dd);
 	  if (ddd){
	 
	   if (ddd.value=="")ddd.value="0";
	   ddd.value=parseFloat(para1);//+parseFloat(ddd.value); 
	   }
	  }
     }
   }
   }
  }
  function counF(para1,para2,para3){ 
   if (para1!="") {
    var money=parseFloat(para1);
	var abc="";
   // if (para.indexOf("unit")==0){
    for (var dd=0;dd<=para3;dd++){
      var ddd=eval("document.frm.T"+para2+dd);
	  var fff=eval("document.frm.Ts"+para2+dd);

	  if (document.frm.floorRoom.value!==""&&document.frm.floorEnd.value!==""){
   	    if (parseInt(fff.value)>=parseInt(document.frm.floorRoom.value)&&parseInt(fff.value)<=parseInt(document.frm.floorEnd.value)){
		  if (ddd){
	        if (document.all.dz.checked&&dd>1)money=fff.value*parseFloat(para1);
	        if (ddd.value=="")ddd.value="0";
	        ddd.value=parseFloat(ddd.value)+money;
	      }
		}else{
   		  break;
		}
	  }else{
	    if (ddd){
	      if (document.all.dz.checked&&dd>1)money=fff.value*parseFloat(para1);
	      if (ddd.value=="")ddd.value="0";
	      ddd.value=parseFloat(ddd.value)+money;
	    }
	  
	  
	  }	
     }
  }
 }
 
 
 function counR(para1,para2,para3){ 
 
   if (para1!="") {
    var money=parseFloat(para1);
	
   // if (para.indexOf("unit")==0){
    for (var dd=0;dd<=para3;dd++){
	  var ddd=eval("document.frm.S"+para2+dd);
	  
	  var fff=eval("document.frm.F"+para2+dd);
	  if (ddd){
	  if (document.all.dz.checked&&dd>1)money=fff.value*parseFloat(para1);
	   if (ddd.value=="")ddd.value="0";
	 
	   ddd.value=parseFloat(ddd.value)+money;
	   
	   }
     }
  }
 }
  </script>
 
 
</form>  
</div>
</body>
</html>
