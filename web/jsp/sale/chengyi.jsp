<%@ page contentType="text/html;charset=GBK" import="java.sql.*" %>
<%@ include file="../public_js/checktime.jsp"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%!
public String formatDateTime( java.util.Date dt , int flag ) throws Exception {
    java.text.SimpleDateFormat f = new java.text.SimpleDateFormat( "yyyy-MM-dd" ) ;
    return f.format( dt ) ;
}
%>

<%

//生成币另汇率数组

String RateSql="select * from currrate";
ResultSet RateRs=null;

try{
  RateRs=ViewBean.executeQuery(RateSql);

  out.print("<script>");
  out.print("var RateName=new Array();");
  out.print("var RateValue=new Array();");
  int iii=0;

   while (RateRs.next()){
     out.print("RateName["+String.valueOf(iii)+"]="+"\""+getbyte(RateRs.getString("CurrName"))+"\""+";");
     out.print("RateValue["+String.valueOf(iii)+"]="+"\""+RateRs.getString("CurrRate")+"\""+";");
	 iii++;
      }	 
}catch(Exception s){  out.print(s.getMessage());out.close();}
RateRs.close();
out.print("</script>");


 
String StrSql="select type,codename from CODE where  child =0 order by type";
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

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>诚意登记</title>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script Language="JavaScript" src="../public_js/basal.js"></script>
</head>

<body>
<form name="cus" method="post">
 
  

<p align="center"><b><font class=FontColor size="3" ><b>诚意登记</font></b></p>
 
<input type=hidden name=cusSerial value="" >
<table border="0" cellspacing="1" width="100%" cellpadding="0" class="tablefill">
     <tr> 
<%@ include file="../public_js/CheckSection.jsp"%>
<%  String currSection=request.getParameter("section");
 
	if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
      String sql="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";
	  ResultSet rs2=ViewBean.executeQuery(sql);
	  String sec="";
	  String no="";
  %> <td class=roomleft width="25%"> &nbsp;楼&nbsp;&nbsp;&nbsp;&nbsp;盘</td><td  class=roomright width="25%"> 
 &nbsp;<select  style="width : 115" name="section" style="width:117" > <option></option>
<%
while (rs2.next()){
	   no=rs2.getString("SerialNo");
	   String choose="";
	   if (currSection.equals(no))choose=" selected ";
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no+"-"+sec+"' "+choose+" >"+sec+"</option>");
		 
	  }
	    rs2.close();
     %> </select></td>
	  <%
	 
  %> 
        <td width="25%" class=roomleft>&nbsp;所在区域</td>
        <td class=roomright> &nbsp;<select  style="width : 115" name="Region" style="width:117"> 
<% for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("K"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
     %> </select>
        </td>
      </tr>  
  <tr > <td width="25%" class=roomleft  align="left" height="24">&nbsp;客户姓名</td><td width="25%" class=roomright  align="left" height="24"> &nbsp;<input type=text    name=in1 size="15"  ><!--<input type=button name=cybf value="查找" onclick="findCus();" >--><font color=red>*</font></td> 
 <td width="25%" align="left"class=roomleft  height="24">&nbsp;性&nbsp;&nbsp;&nbsp;&nbsp;别</td><td class=roomright width="25%" align="left"   height="24"> 
&nbsp;<input type=text    name=in2 size="6"  onkeydown="key(document.cus.name2)"  ><select     name="sex1"  onkeydown="key(document.cus.sex2)"> 
<option selected value="男">男</option> <option value="女">女</option></select><input title="增加客户性别" type=button name=addsexs  onclick="addsex();" value=">>" >&nbsp;</td></tr>
</td></tr>
 <tr align="left" > 
 <td width="25%" align="left"class=roomleft  height="14">&nbsp;证&nbsp;件&nbsp;号</td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<input type="text"    name="in4" size="15"  onblur="countAge();" > 
</td>
<td width="15%"   class=roomleft  height="14">&nbsp;出生日期</td>
<td class=roomright width="15%"      height="14"> 
 &nbsp;<input type=text     name=csdate size="12"  value=""    ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(csdate);return false">
</td>
</tr>
<tr align="left" > 
<td width="25%" align="left"class=roomleft  height="14"> &nbsp;联系电话</td>
<td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<input type=text    name=in5 size="15" >
          
</td>
<td width="25%"class=roomleft  align="left" height="23">&nbsp;手&nbsp;&nbsp;&nbsp;&nbsp;机</td><td class=roomright width="25%"   align="left" height="23"> 
 &nbsp;<input type=text    name=in6 size="15" > </td>

</tr> 
<tr align="left" > <td width="25%" align="left"class=roomleft  height="14">&nbsp;QQ&nbsp;&nbsp; 号</td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<input type=text    name=bbj size="15"> 
</td>
<td width="25%" align="left"class=roomleft  height="24">&nbsp;单&nbsp;&nbsp;&nbsp;&nbsp;位</td><td class=roomright width="25%" align="left"   height="24">&nbsp;<input type=text    name=company size="15"> 
</td>
</tr>

<tr align="left" > <td width="25%" align="left"class=roomleft  height="14">&nbsp;EMAIL</td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<input type=text    name=mail size="15" > 
</td>
<td width="25%"class=roomleft  align="left" height="23"> &nbsp;邮&nbsp;&nbsp;&nbsp;&nbsp;编</td><td class=roomright width="25%"   align="left" height="23"> &nbsp;<input type=text    name=in8 size="15"></td>
</tr> 

<tr>
 <td width="25%"class=roomleft  align="left" height="23">&nbsp;联系地址</td><td class=roomright width="25%"   align="left" height="23" colspan=3> 
 &nbsp;<input type=text    name=in7 size="39"  > </td>
</tr>

<tr align="left" >
 <td width="25%" align="left"class=roomleft  height="14">&nbsp;来访日期</td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<input type=text value="<%= formatDateTime( new java.util.Date() , 0 ) %>"   NAME=Date1 size=12><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false"><font color=red>*</font>
</td><td width="25%" align="left"class=roomleft  height="24"> &nbsp;销&nbsp;售&nbsp;员</td><td class=roomright width="25%" align="left"   height="24"> 
 &nbsp;<select  style="width : 115" size="1" name="seller" style="width:117" > 
  <option value=""></option>
  <%
 
     sql="select seller from seller where section_no='"+request.getParameter("section")+"'";
   try{
     ResultSet  rs=ViewBean.executeQuery(sql);
	     while (rs.next()){
	   
	 	   String Name=getbyte(rs.getString("seller"));
       out.print("<option value='"+Name+"'>"+Name+"</option>") ;
	  }
	 
	  rs.close();
	}catch(Exception s)   {out.println(s.getMessage());}
	
  %>
</select> </td>
	  </tr>
	 
	  <tr>
      <td width="25%" align="left" class=roomleft>&nbsp;诚意金</td>
      <td width="25%" class=roomright colspan="3" >&nbsp;<input type=text name=cyj value="20000">
	  
       </td>
	   
    </tr>	
	  <tr>
      <td width="25%" align="left" class=roomleft>&nbsp;VIP卡号</td>
      <td width="25%" class=roomright colspan="3" >&nbsp;<input type=text name=vipno value="">
	  
       </td>
	   
    </tr>	 
    <tr>
   
	  <td width="25%" align="left" class=roomleft >&nbsp;意向单位</td>
      <td width="25%" class=roomright  colspan="3">1.<input type=text name=in17 size=16 >&nbsp;2.<input type=text name=in17a size=17 >
         
      </td>
    </tr>
    
 <tr>
      <td width="25%" align="left" class=roomleft >&nbsp;登记日期</td>
      <td width="25%" class=roomright >&nbsp;<input type=text name=in13 size=13 value="<%= formatDateTime( new java.util.Date() , 0 ) %>" readonly><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(in13);return false;" ></td>
     
	<td width="25%" class=roomleft >失效日期</td>&nbsp;
      <td width="25%" class=roomright ><input type=text name=in14 size=13 readonly ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(in14);return false;" ></td>
     </tr>
	 <input type=hidden name=in15 size=16 VALUE=0>
	  <input type=hidden name=in20 size=16 >
	    <input type=hidden name=curry size=16  VALUE="￥">
		<input type=hidden name=rate size=16  VALUE=1>
		
	  <tr>
   
	  <td width="25%" align="left" class=roomleft >&nbsp;备注</td>
      <td width="25%" class=roomright  colspan="3"> <textarea cols="60" rows="3" name=bak></textarea>
         
      </td>
    </tr> 
</table>  
 <table width="298" border="0" cellspacing="0" cellpadding="0" align="">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif">　<img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>调查反馈</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"><font color="#FF6600"> &nbsp;</font></td>
</tr>
</table>	
 <table BORDER=0 width="100%"  CELLSPACING=1 CELLPADDING=3 ALIGN=center>
	 
  <%
  String SQL="select * from CustomerDc where sectionno='"+request.getParameter("section")+"'";
 
  rs2=ViewBean.executeQuery(SQL);	
  int iii=0;
   while (rs2.next()){
     iii++;
   %>
 <tr align="center">
    <td width="5%"  class=roomleft ><%=iii %></td>
    <td width="15%" class=roomleft align="left">&nbsp;<%=rs2.getString("codeName") %></td>
	<td width="65%" align="left" class=roomright>
	<%
	 SQL="select  CodeValue,code from CustomerDcValue where dcCode="+rs2.getString("code");
	 
	 ResultSet rs1=ViewBean1.executeQuery(SQL);	
    while (rs1.next()){
	    String codcename=rs1.getString("CodeValue");
		String code=rs1.getString("code");
	     %>
		   <input name="codcename<%=code %>" type="checkbox" value="<%=code %>"  ><%=codcename %> 
		 <% 
       }
	rs1.close();
	 %>
	
	</td>
	 
  </tr>
  <%}
  rs2.close(); %>
 </table> 

<input type=hidden name="SaveCus" value="insert">
<p align="center"> 
           <input type=button name="submit1" value="保 存" onclick="dengji();">
           &nbsp;&nbsp;
		   <input type=button name=cancel value="退　出" onclick="window.close()">

          </P> 
</form>
    
    
<script lang=javascript>
function addsex(){
 var sexs=document.cus.in2.value;
 var arry1=sexs.split("/");//转换为arry;
 var cusname=document.cus.in1.value;
 var arry2=cusname.split("/");//转换为arry;
 if (sexs!="")
 if (arry1.length==arry2.length){alert("姓名数与性别数已相等,系统不接受多于的性别");return false;}
 if (sexs=="")
     document.cus.in2.value=document.cus.sex1.value;
else
  document.cus.in2.value+="/"+document.cus.sex1.value;
 

}

function countAge(){

  var cardidS=document.cus.in4.value;
  var cardidSS=cardidS;
  var currDat=new Date();  
  var year=currDat.getYear();
  document.cus.in3.value="";

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
			else{ alert("有些身份证号位数有误,系统只计算正确号码的年龄");document.cus.in4.focus(); } 
		   }
		  else
		    {
			if (arry[jj].length==18)
		       ages+="/"+String(parseInt(year)-parseInt(arry[jj].substring(6,10)));
		    else if (arry[jj].length==15)
		       ages+="/"+String(parseInt(year)-parseInt("19"+arry[jj].substring(6,8)));
			else{ alert("有些身份证号位数有误,系统只计算正确号码的年龄");document.cus.in4.focus(); }  
			}
			
		}else if (arry[jj].length==18) {
		   if (ages=="")
		       ages=String(parseInt(year)-parseInt(arry[jj].substring(6,10)));
		  else
		       ages+="/"+String(parseInt(year)-parseInt(arry[jj].substring(6,10)));
		 }
	 }
  }
  document.cus.in3.value=ages;
}
function checkValue()
{   

    if( document.forms[ 0 ].section.value == ""  ) {
		alert( "请楼盘 ! " ) ;
		document.forms[ 0 ].section.focus() ;
		return false ;
	}
	if( document.forms[ 0 ].in1.value == ""  ) {
		alert( "请输入诚意客户 ! " ) ;
		document.forms[ 0 ].in1.focus() ;
		return false ;
	}
	if( document.forms[ 0 ].in5.value == "" &&document.forms[ 0 ].in6.value=="" ) {
		alert( "至少需要登记一个联系电话! " ) ;
		document.forms[ 0 ].in5.focus() ;
		return false ;
	}
	if( document.forms[ 0 ].vipno.value == ""  ) {
		alert( "请输入诚意VIP号 ! " ) ;
		document.forms[ 0 ].vipno.focus() ;
		return false ;
	} 
	
	if( document.forms[ 0 ].cyj.value == ""  ) {
		alert( "请输入诚意金额 ! " ) ;
		document.forms[ 0 ].cyj.focus() ;
		return false ;
	}
	return true ;
}

function dengji()
{
	if( checkValue() ) {
		document.cus.action = "chengyi_add.jsp" ;
		document.cus.submit() ;
	}
}

function xuanzhe_dangwei()
{
    var spa = 60 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa / 2 ;
    var lef = spa / 2 ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=" + hei ;
    var posi = posi + ",width=" + wid ;
    
    var newwin2 = window.open( "chengyi_danwei.jsp","NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
    newwin2.focus();	
}

function qingkong_dangwei()
{
    document.forms[ 0 ].in17.value = "" ;
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

function findCus() {
    var spa = 60 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa / 2 ;
    var lef = spa / 2 ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=" + 500 ;
    var posi = posi + ",width=" + 550 ;
    
    var newwin2 = window.open( "chengyi_fc.jsp","NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
    newwin2.focus();    
}

function CurrRa(){
 //汇率转换
   var curryName=document.cus.curry.options[document.cus.curry.selectedIndex].value;
   for (var jj=0;jj<RateName.length;jj++)
    {
	  if (RateName[jj]==curryName)
	  {
	   document.cus.rate.value=RateValue[jj];
	   break;
	  }
	}
 
 } 
    
</script>
</form>
</body>
</html>
