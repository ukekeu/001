<%@ page contentType="text/html;charset=gb2312" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<!--<link rel=stylesheet href="../class/mad.css" >-->
<title>登记客户资料</title>
</head>
 <script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script Language="JavaScript" src="../public_js/basal.js"></script>

<%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>

<%!
public String conv( String str1 ) throws Exception{
	if( str1 == null ){
		return "";
	}
	return new String ( str1.getBytes("ISO8859_1") );
}
%>
<%
  String cusname=request.getParameter("cusname");
  String carid=request.getParameter("carid");
  String tel=request.getParameter("tel");
  String sj=request.getParameter("sj");
  String inaddr=request.getParameter("addr");

  if (cusname==null)cusname="";
  if (tel==null)tel="";
  if (carid==null)carid="";
   if (sj==null)sj="";
    if (inaddr==null)inaddr="";
 %>
<SCRIPT language=javascript>
<!--
   
 function Validate(aForm)
{    
    if (aForm.section.options[aForm.section.selectedIndex].text=="")
    	{
    	alert("请选择楼盘！");
        aForm.section.focus();
        return (false);
    	}	
    
    if (aForm.name.value.length<1)
    	{
    	alert("请输入客户姓名！");
        aForm.name.focus();
        return (false);
    	}	

      
     if (aForm.Date1){
    if (aForm.Date1.value.length==0)
    {
        alert("请选择来访日期");
        aForm.Date1.focus();
        return false;
    } 
   } 
     aForm.hs.value=aForm.hs1.value+"|"+aForm.hs2.value+"|"+aForm.hs3.value+"|"+aForm.hs4.value+"|"+aForm.hs5.value;
aForm.ah.value=aForm.ah1.value+"|"+aForm.ah2.value+"|"+aForm.ah3.value;

     /* if ( trim( aForm.tel.value ).length < 1 )
    	{
        	alert("请输入电话号码！");
            aForm.tel.focus();
            return (false);
    	}
    if (aForm.tj){
    if ( trim( aForm.tj.value ).length < 1 )
    {
    	alert("请输入或选择信息来源！");
        aForm.tj.focus();
        return (false);
    }    	    	    	 
   }
    if (aForm.demand){
    if ( trim( aForm.demand.value ).length < 1 )
    {
    	alert("请输入或选择意向/需求！");
        aForm.demand.focus();
        return (false);
    } 
    }
     if (aForm.attention){
    if ( trim( aForm.attention.value ).length < 1 )
    {
    	alert("请输入或选择关注问题项！");
        aForm.attention.focus();
        return (false);
    }}    
   */
    if (aForm.pos.value.length>0&aForm.pos.value.length!=6)
    {
        alert("邮政编码有误！");
        aForm.pos.focus();
        return false;
    }
    return (true);
}

function addsex(){
 var sexs=document.cus.sex.value;
 var arry1=sexs.split("/");//转换为arry;
 var cusname=document.cus.name.value;
 var arry2=cusname.split("/");//转换为arry;
 if (sexs!="")
 if (arry1.length==arry2.length){alert("姓名数与性别数已相等,系统不接受多于的性别");return false;}
 if (sexs=="")
     document.cus.sex.value=document.cus.sex1.value;
else
  document.cus.sex.value+="/"+document.cus.sex1.value;
 

}
var arry=new Array(); 
 var num1=0;
 var num=0;
function checkSJ(){
  var aa=document.cus.sj.value;
  var arry=aa.split("/");//转换为arry
	if (aa!=""){
	  for (var jj=0;jj<arry.length;jj++){
	     if (!isNaN(arry[jj])){
		    if (arry[jj].length!=11&&arry[jj].length!=12){
			  alert( "输入诚意客户手机号有误! ") ;
		      document.forms[ 0 ].sj.focus() ;
		      return false ;
			}
			 if (arry[jj].length==12&&arry[jj].substring(0,1)!="0"){
			   alert( "输入诚意客户手机号有误! " ) ;
		       document.forms[ 0 ].sj.focus() ;
		       return false ;
			 }
		}else{
		      alert( "输入诚意客户手机号有误! " ) ;
		       document.forms[ 0 ].sj.focus() ;
		       return false ;
		}
		}	
	
	}

}
 
function countAge(){

  var cardidS=document.cus.cardid.value;
  var cardidSS=cardidS;
  var currDat=new Date();  
  var year=currDat.getYear();
  document.cus.age.value="";

  var ages="";
  if (cardidS!=""){	
   var arry=cardidS.split("/");//转换为arry
	for (var jj=0;jj<arry.length;jj++){
	  if (!isNaN(arry[jj])){
		  if (ages=="")
		   { 
		    if (arry[jj].length==18)
		       ages=String(parseInt(year)-parseInt(arry[jj].substring(6,10)));
		    else if (arry[jj].length==15)
		       ages=String(parseInt(year)-parseInt("19"+arry[jj].substring(6,8)));
			else{ alert("有些身份证号位数有误,系统只计算正确号码的年龄");document.cus.cardid.focus(); } 
		   }
		  else
		    {
			if (arry[jj].length==18)
		       ages+="/"+String(parseInt(year)-parseInt(arry[jj].substring(6,10)));
		    else if (arry[jj].length==15)
		       ages+="/"+String(parseInt(year)-parseInt("19"+arry[jj].substring(6,8)));
			else {alert("有些身份证号位数有误,系统只计算正确号码的年龄");     document.cus.cardid.focus();}
			}
			
		}else if (arry[jj].length==18) {
		   if (ages=="")
		       ages=String(parseInt(year)-parseInt(arry[jj].substring(6,10)));
		  else
		       ages+="/"+String(parseInt(year)-parseInt(arry[jj].substring(6,10)));
		 }
	 }
  }
  document.cus.age.value=ages;
}
function setfocus()
{
	document.cus.name.focus();
}
//-->
  

</script>
<script language="javascript" src="../public_js/public.js">
</script>
<%
String sectionPara = request.getParameter("section");
String cusSql = "select cus_name , phone from customer where section='" 
                + sectionPara + "'";
ResultSet cusRs=null;
try {
    cusRs=ViewBean.executeQuery(cusSql);
}catch(Exception s)
{
}
java.util.Vector vctName = new java.util.Vector() ;
java.util.Vector vctPhone = new java.util.Vector() ;
while ( cusRs.next()){
    String cus_name = cusRs.getString( 1 ) ;
    String cus_phone = cusRs.getString( 2 ) ;
    vctName.addElement( cus_name ) ;
    vctPhone.addElement( cus_phone ) ;
    
}
cusRs.close(); 
%>

<script lang=javascript>
    nameArr = new Array() ;
    phoneArr = new Array() ;
</script>

<%
for( int p = 0 ; p < vctName.size() ; p ++ ) {
    %>
    <script lang=javascript>
        nameArr[ <%= p%> ] = "<%= conv( vctName.get( p ).toString() ) %>"
    </script>
    <%
}
%>

<%
for( int p = 0 ; p < vctPhone.size() ; p ++ ) {
    %>
    <script lang=javascript>
        phoneArr[ <%= p%> ] = "<%= conv( vctPhone.get( p ).toString() ) %>"
    </script>
    <%
}
%>

<body onload="setfocus();" >
<p align=center><font size=3 color=#215CAA><b>登记客户资料</b></font></p>
<%

 String StrSql="select type,codename from CODE WHERE CHILD=0 order by type";
   ResultSet codeRS=null;
   String CodeName[]=new String[300];
   String CodeType[]=new String[300];
   codeRS=ViewBean.executeQuery(StrSql);
   int i=0;
   while (codeRS.next()){
     CodeType[i]=getbyte(codeRS.getString("type"));
     CodeName[i]=getbyte(codeRS.getString("codename"));
	 i++;
   }
   codeRS.close();
 %>
<form method="POST" name="cus" action=""> 
 <div id="tj2" style="position:absolute; left:195px; top:340px; width:30px; height:30px; z-index:1; visibility: hidden"> 

</div>
 <div id="xq" style="position:absolute; left:195px; top:270px; width:30px; height:30px; z-index:1; visibility: hidden"> 
<select  name="xq1" multiple size=10 onchange="sele(document.cus.demand,document.cus.xq1,'xq',sh3);choose1(document.cus.demand);"  onblur="closeD();">
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("A"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 
</div>
<div id="gz" style="position:absolute; left:380px; top:350px; width:30px; height:30px; z-index:1; visibility: hidden"> 
<select  name="gz1" multiple size=10 onchange="sele(document.cus.attention,document.cus.gz1,'gz',sh3);choose1(document.cus.attention);" onblur="choose(document.cus.attention);shList('gz');">
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("F"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 
</div>
 <div id="jt2" style="position:absolute; left:380px; top:320px; width:30px; height:30px; z-index:1; visibility: hidden"> 
<select  name="jt1" multiple size=10 onchange="sele(document.cus.payment,document.cus.jt1,'jt2',sh3);">
  <option >按揭付款</option>
   <option >分期付款</option>
   <option >一次性付款</option>
 </select> 
</div>
<div id="job2" style="position:absolute; left:195px; top:330px; width:30px; height:30px; z-index:1; visibility: hidden"> 

</div>
<div id="gmyt2" style="position:absolute; left:380px; top:390px; width:30px; height:30px; z-index:1; visibility: hidden"> 

</div>
<div id="homejg2" style="position:absolute; left:380px; top:350px; width:30px; height:30px; z-index:1; visibility: hidden"> 

</div>
<center>

 <table BORDER=0 width="100%"  CELLSPACING=1 CELLPADDING=3 ALIGN=center>
<tr > 
<td colspan=4 align=center class=TITLE><b>基&nbsp;本&nbsp;资&nbsp;料</b></td></tr>
<tr> 
<%@ include file="../public_js/CheckSection.jsp"%>
<%
	if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
      String sql="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";
	  ResultSet rs2=ViewBean.executeQuery(sql);
	  String sec="";
	  String no="";
  %> <td class=roomleft width="25%"> &nbsp;楼&nbsp;&nbsp;&nbsp;&nbsp;盘</td><td  class=roomright width="25%"> 
 &nbsp;<select name="section" style="width:117"> 
<%
while (rs2.next()){
	   no=rs2.getString("SerialNo");
	   
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no+"'>"+sec+"</option>");
	  }
	    rs2.close();
     %> </select><font color=red>*</font> </td>
	  <%
	 
  %> <td class=roomleft width="34%">&nbsp;来自区域</td><td class=roomright width="66%"> 
&nbsp;<select name="Region" style="width:117"> 
<% for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("K"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
     %> </select> </td></tr>  
  <tr > <td width="25%" class=roomleft  align="left" height="24">&nbsp;客户姓名</td>
  <td width="25%" colspan=3  class=roomright  align="left" height="24">&nbsp;<input type=text    name=name size="50"  value="<%=cusname %>" onkeydown="key(document.cus.name2)"  ><font color=red>*</font></td> 
</tr>
  <tr > 
 <td width="25%" align="left"class=roomleft  height="24">&nbsp;性&nbsp;&nbsp;&nbsp;&nbsp;别</td>
 <td class=roomright colspan=3  width="25%" align="left"   height="24"> 

&nbsp;<input type=text    name=sex size="40"  onkeydown="key(document.cus.name2)"  ><select  name="sex1"  onkeydown="key(document.cus.sex2)"> 
<option selected value="男">男</option> <option value="女">女</option></select><input title="增加客户性别" type=button name=addsexs  onclick="addsex();" value=">>" >&nbsp;</td></tr>

 <tr align="left" > 
 <td width="25%" align="left"class=roomleft  height="14">&nbsp;身份证号</td>
 <td class=roomright  colspan=3 width="25%" align="left"   height="14"> 
 &nbsp;<input type="text"    name="cardid" size="50"  onblur="countAge();" value="<%=carid %>" onkeydown="key(document.cus.tel)"  >
</td>

</td>

</tr>

<tr align="left" > 

<td width="25%" align="left"class=roomleft  height="24">&nbsp;年龄范围</td>
<td width="25%" class=roomright align="left"   height="24">&nbsp;
<select size="1"  style="width:117" name="agefw" onkeydown="key(document.cus.wh)">   
<option></option> 
    <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("AG"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %> 
      </select>
<input type=hidden    name=age size="18"  > 
<td width="25%" align="left"class=roomleft  height="24">&nbsp;参观方式</td>
<td width="25%" class=roomright align="left"   height="24">&nbsp;<select name="visitstate"><option  value="1">来电</option> <option  value="0">来访</option>
</td>

</tr>
<tr align="left" > 
<td width="25%" align="left"class=roomleft  height="14"> &nbsp;联系电话</td>
<td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<input type=text    name=tel size="18" title="多个电话号码间用/分隔" value="<%=tel %>" onkeydown="key(document.cus.sj)"  >
</td>
<td width="25%"class=roomleft  align="left" height="23">&nbsp;手&nbsp;&nbsp;&nbsp;&nbsp;机</td><td class=roomright width="25%"   align="left" height="23"> 
 &nbsp;<input type=text    name=sj size="18" value="<%=sj %>"  onblur="checkSJ()" onkeydown="key(document.cus.company)" > </td>

</tr> 
<tr align="left" > 
<td width="25%" align="left"class=roomleft  height="24" > &nbsp;单&nbsp;&nbsp;&nbsp;&nbsp;位</td><td class=roomright width="50%" align="left"   height="24" colspan="3">&nbsp;<input type=text    name=company size="54" onkeydown="key(document.cus.mail)"  > 
</td>
</tr>
<tr align="left" > <td width="25%" align="left"class=roomleft  height="14">&nbsp;EMAIL</td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<input type=text    name=mail size="18" onkeydown="key(document.cus.pos)"  > 
</td>
<td width="25%"class=roomleft  align="left" height="23"> &nbsp;邮&nbsp;&nbsp;&nbsp;&nbsp;编</td><td class=roomright width="25%"   align="left" height="23"> &nbsp;<input type=text    name=pos size="18" onkeydown="key(document.cus.addr)"></td>
</tr> 

<tr>
 <td width="25%"class=roomleft  align="left" height="23">&nbsp;联系地址</td><td class=roomright width="25%"   align="left" height="23" colspan=3> 
 &nbsp;<input type=text    name=addr size="33"  onkeydown="key(document.cus.visitname)"  value="<%=inaddr %>"> </td>
</tr>
  <%if (request.getParameter("addnew")==null){ %>
<tr align="left" >
<%  java.util.Date curDate=new java.util.Date();
	int CurYear=curDate.getYear()+1900;
	int CurMonth=curDate.getMonth()+1;
	int CurDay=curDate.getDate();
	String CDate=CurYear+"-"+CurMonth+"-"+CurDay;
%>
 <td width="25%" align="left" class=roomleft  height="14">&nbsp;来访日期</td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<input type=text  value="<%=CDate %>"   name=Date1 size=12 onkeydown="key(document.cus.seller)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false">
</td><td width="25%" align="left"class=roomleft  height="24"> &nbsp;销&nbsp;售&nbsp;员</td><td class=roomright width="25%" align="left"   height="24"> 
 &nbsp;<select size="1" name="seller" onkeydown="key(document.cus.tj)"  style="width:117" >
   <option value=""></option>
<%String sell="select  seller from seller where section_no in ("+SectionS+")";
rs2=ViewBean.executeQuery(sell);
  while (rs2.next()){
	   String Name=getbyte(rs2.getString("seller"));
       out.print("<option value='  "+Name+"'>"+Name+"</option>") ;
	}
  rs2.close();
  %>
	  
</select> </td>
	  </tr>
	
	  <tr> 
<td colspan=4 align=center class=TITLE><b>基&nbsp;本&nbsp;需&nbsp;求</b></td></tr>
 <tr align="left" > 
<td width="25%" align="left"class=roomleft  height="14"> &nbsp;意向户型</td>
<td class=roomright width="25%" align="left"   height="14"> 
  &nbsp;<input type="text"    size="12" name="demand" onkeydown="key(document.cus.attention)"  ondblclick="choose(document.cus.demand);shList('xq');"><input type=button name=butt3 value=".." onclick="choose(document.cus.demand);shList('xq');">
        </td>
 <td width="25%" align="left"class=roomleft  height="14"> &nbsp;意向付款</td><td class=roomright width="25%" align="left"   height="14"> 
  &nbsp;<select  name="payment" style="width:117" >
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("PY"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 
</td></tr> 
  <tr   > 
 <td width="15%"   class=roomleft  height="14"> &nbsp;会籍数量 </td><td class=roomright width="15%"     height="14" > 
  &nbsp;<select size="1"  style="width:100" name="hj" onkeydown="key(document.cus.wh)">   
<option></option> 
    <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("HJ"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %> 
      </select></td>
  <td width="25%" align="left"class=roomleft  height="14"> &nbsp;关注问题</td>
        <td class=roomright width="25%" align="left"   height="14">&nbsp;<select size="1"  style="width:117" name="attention" onkeydown="key(document.cus.wh)">   
<option></option> 
    <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("F"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %> 
      </select> 
</td> 
  </tr> 
 <tr align="left" > 
 <td width="25%" align="left"class=roomleft  height="14"> &nbsp;总价范围</td>
        <td class=roomright width="25%" align="left"   height="14">&nbsp;<select size="1"  style="width:100" name="zj" onkeydown="key(document.cus.wh)">   
<option></option> 
    <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("SP"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %> 
      </select>万元
</td></td>
   <td width="25%" align="left"class=roomleft  height="24">&nbsp;意向面积</td>
<td class=roomright width="25%" align="left"   height="24">

&nbsp;<select size="1"  style="width:117" name="yixiangmianji" onkeydown="key(document.cus.wh)">   
<option></option> 
    <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("O"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %> 
      </select><font size=2>M<sup>2</sup></font>
</td>
  </tr> 
<tr align="left" > 
<td width="25%" align="left"class=roomleft  height="14"> &nbsp;意向楼层</td>
<td class=roomright width="25%" align="left"   height="14"> 
  &nbsp;<input type="text"    size="12" name="floor" onkeydown="key(document.cus.attention)"   > 
        </td>
 <td width="25%" align="left"class=roomleft  height="14"> &nbsp;装修要求</td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<select  name="fiment" style="width:117" >
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("X"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select>  </td></tr> 

 <tr> 
<td colspan=4 align=center class=TITLE>&nbsp;<b>其&nbsp;它&nbsp;资&nbsp;料</b></td></tr>
 <tr align="left" > <td width="25%" align="left"class=roomleft  height="24">&nbsp;家庭人数</td>
<td class=roomright width="25%" align="left"   height="24">&nbsp;<input type=text    name=personnum size="10" value=3 onkeydown="key(document.cus.homejg)"  > 
</td>
 <td width="25%" align="left"class=roomleft  height="24">&nbsp;家庭结构</td>
<td class=roomright width="25%" align="left"   height="24">
  &nbsp;<select  name="homejg" style="width:117">
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("J"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 

</td></tr>

<tr align="left" >
 <td width="25%" align="left"class=roomleft  height="24">&nbsp;现居面积</td>
<td class=roomright width="25%" align="left"   height="24">

&nbsp;<select size="1"  style="width:117" name="nowjuarea" onkeydown="key(document.cus.wh)">   
      <option></option>
      <option>50以下</option>
       <option>50-80</option>
      <option>80-100</option>
      <option>100-110</option>

      <option>110-150</option>
      <option>150以上</option>
      </select><font size=2>M<sup>2</sup></font>
</td> <td width="25%" align="left"class=roomleft  height="24">&nbsp;文&nbsp;&nbsp;&nbsp;&nbsp;化</td><td class=roomright width="25%" align="left"   height="24"> 
&nbsp;<select size="1" name="wh" style="width:117" onkeydown="key(document.cus.job)"><option></option> 
<%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("M"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %> 
</select> </td></tr> <tr align="left" > <td width="25%" align="left"class=roomleft  height="24"> &nbsp;行&nbsp;&nbsp;&nbsp;&nbsp;业</td><td class=roomright width="25%" align="left"   height="24"> 
&nbsp;<select  name="job" style="width:117"  >
  <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("G"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> </td>
<td width="25%" align="left"class=roomleft  height="24">&nbsp;年&nbsp;收&nbsp;入</td><td class=roomright width="25%" align="left"   height="24"> 
&nbsp;<select size="1" name="jtsr" style="width:117"> <option></option><option>5-10</option> <option>10-15</option> <option>15-25</option> 
<option>25-45</option> <option>45-60</option> <option>60-100</option> <option>100以上</option> 
</select>万 </td></tr> <tr> <td width="25%"class=roomleft  align="left" height="24">&nbsp;客户类型</td><td class=roomright width="25%"   align="left" height="24"> 
&nbsp;<select size="1" name="custype"  style="width:117" onkeydown="key(document.cus.gmyt)"><option></option> 
<%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("Y"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %> 
</select></td> <td width="25%"class=roomleft  align="left" height="24"> &nbsp;购买用途</td><td class=roomright width="25%"   align="left" height="24"> 
  &nbsp;<select  name="gmyt" style="width:117">
   <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("I"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> </td></tr> <tr align="left" > <td width="25%" align="left"class=roomleft  height="24"> &nbsp;来访人数</td><td class=roomright width="25%" align="left"   height="24"> 
 &nbsp;<select size="1" name="num"  style="width:117"  onkeydown="key(document.cus.addr)" > 
<option></option><option value=单人>单人</option> <option value=多人>多人</option></select>&nbsp;</td>
<td width="25%" align="left"class=roomleft  height="14"> &nbsp;联&nbsp;系&nbsp;人</td>
<td class=roomright width="25%" align="left"   height="14"> &nbsp;<input type=text    NAME=ContactPerson size="15" onkeydown="key(document.cus.Date1)"   ></td> 

</tr>
<tr align="left" > <td width="25%" align="left"class=roomleft  height="14"> &nbsp;同访姓名</td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<input type=text    name=visitname size="13" onkeydown="key(document.cus.tfnexus)"  > 
</td> <td width="25%" align="left"class=roomleft  height="14"> &nbsp;同访关系</td><td  class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<select size="1" style="width:117" name="tfnexus" onkeydown="key(document.cus.pos)" ><option></option> 
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("Z"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %> 
</select> </td>

</tr>  
 

 <tr align="left" > 	  
 <td width="25%"class=roomleft  align="left" height="23"> &nbsp;婚姻状况</td><td class=roomright  width="25%"   align="left" height="23"> &nbsp;<select  name="marriage" style="width:117" >
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("HY"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 

<input type=hidden    name=chishu size="6" value="1" onkeydown="key(document.cus.save)"   ></td>
 <td width="25%" align="left"class=roomleft  height="14"> &nbsp;信息来源</td><td class=roomright width="25%" align="left"   height="14"> 
  &nbsp;<select  name="tj" style="width:117" >
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("E"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 
        </td>
</tr>
<tr align="left" > 	  
 <td width="25%"class=roomleft  align="left" height="23"> &nbsp;出差情况</td><td class=roomright  width="25%"   align="left" height="23"> &nbsp;<select  name="cc" style="width:117" >
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("CC"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> </td>
 <td width="25%" align="left"class=roomleft  height="14"> &nbsp;车辆品牌</td><td class=roomright width="25%" align="left"   height="14"> 
  &nbsp;<select  name="car" style="width:117" >
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("CA"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 
        </td>
</tr>

<tr align="left" > 	  
 <td width="25%"class=roomleft  align="left" height="23"> &nbsp;会所设施</td><td class=roomright  width="25%"   align="left" height="23" colspan="3"> &nbsp;1.<select  name="hs1" style="width:117" >
  <option></option>
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("HS"))
	       out.print("<option  value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 2.<select  name="hs2" style="width:117" >
  <option></option>
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("HS"))
	       out.print("<option  value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 3.<select  name="hs3" style="width:117" >
  <option></option>
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("HS"))
	       out.print("<option  value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select><br>&nbsp;4.<select  name="hs4" style="width:117" >
  <option></option>
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("HS"))
	       out.print("<option  value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 5.<select  name="hs5" style="width:117" >
  <option></option>
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("HS"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 
<input type=hidden name="hs"></td>
</tr><tr>
 <td width="25%" align="left"class=roomleft  height="14"> &nbsp;爱好</td><td class=roomright width="25%" align="left"   height="14" colspan="3"> 
<input type=hidden name="ah">
  &nbsp;1.<select  name="ah1" style="width:117" >
  <option></option>
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("AH"))
	       out.print("<option  value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 2.<select  name="ah2" style="width:117" >
  <option></option>
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("AH"))
	       out.print("<option  value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 3.<select  name="ah3" style="width:117" >
  <option></option>
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("AH"))
	       out.print("<option  value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 
        </td>
</tr> 

<tr align="left" > 	  
 <td width="25%"class=roomleft  align="left" height="23"> &nbsp;入会标准</td><td class=roomright  width="25%"   align="left" height="23"> &nbsp;<select  name="rh" style="width:117" >
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("RH"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> </td>
 <td width="25%" align="left"class=roomleft  height="14"> &nbsp;职业</td><td class=roomright width="25%" align="left"   height="14"> 
  &nbsp;<select  name="zy" style="width:117" >
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("ZY"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 
        </td>
</tr>

<%} %>
</table>  
<input type=hidden name="SaveCus" value="insert">
<p align="center"> 
<%String Cortrol=(String)session.getAttribute("popedomStr"); 
   if (Cortrol==null){Cortrol="";}
    if (Cortrol.indexOf("A")>=0){ %>
   
           <input type=button name="submit1" value="提　交" onclick="loca();">
           &nbsp;&nbsp;
		   <%} %>
		   <input type=button name=cancel value="退　出" onclick="window.close()">

          </P>
	</center>	  
</form>
<script>

function has_name_phone()
{
    var hasNamePhone = false ;
    var c_name = document.forms[ 0 ].name.value ;
    var c_phone = document.forms[ 0 ].tel.value ;
	
    
    for( var p = 0 ; p < nameArr.length ; p ++ ) {
        if( c_name == nameArr[ p ] && c_phone == phoneArr[ p ] ) {
            hasNamePhone = true ;
            break ;
        }
    }
    return hasNamePhone ;
}

function loca() {
    if ( Validate( document.cus ) ) {  
      
        if( has_name_phone() ) {
            alert( "该客户已存在!" )
            return ;
        }    
		
        document.cus.action ="InsertCusData.jsp<%if (request.getParameter("addnew")!=null){ %>?addnew=addnew<%} %>";
        document.cus.submit();
    }
}
var atten="";
function choose(para){
   atten=para.value;
   
}
function choose1(para){
if (atten!=""){
   if (confirm("已经选择了一个，是否要多选？"))para.value=para.value+","+atten;
}

}
 <%
    if (!carid.equals("")) out.print("countAge("+carid+")");
   %>
</script>


</body>       
</html>       
