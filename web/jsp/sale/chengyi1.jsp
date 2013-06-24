<%@ page contentType="text/html;charset=GBK" import="java.sql.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="f2Bean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>

<%!
public String formatDateTime( java.sql.Timestamp dt , int flag ) throws Exception {
    java.text.SimpleDateFormat f = new java.text.SimpleDateFormat( "yyyy-MM-dd" ) ;
    return f.format( dt ) ;
}
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
%>
<%
String cusno = request.getParameter( "cusno" ) ;
String sq =  " select * from customer b"
		   + " where  b.serialNo='"+cusno+"'";
 
 
String seri = "" ;
String name="";
 String sex="";
 String age="";
 String custype="";
 String gmyt="";
 String tj="";
 String tel="";
 String idcard="";
 String addr="";
 String pos="";
 String date="";
 String company="";
 String visitnum="";
 String visitname="";
 String visitsex="";
 String nexus="";
 String visittj="";
 String mail="";
 String bbj = "" ;
 String sj = "" ;
 String visitage="";
 String job="";
 String jtsr="";
 String wh="";
 String region="";
 String sale="";
 String personnum="";
 String linkman="";
 String homejg="";
 String chishu="";
 String signatory="";
 String demand="";
 String attention="";
 String nowarea="";
 String payment="";
 String yixianmianji="";
String in1 = "" ;
String Section="";
String in2 = "" ;
String in3 = "" ;
String in4 = "" ;
String in5 = "" ;
String in6 = "" ;
String in7 = "" ;
String in8 = "" ;
String in9 = "" ;
String in10 = "" ;
String in11 = "" ;
String in12 = "" ;
String in13 = "" ;
String in14 = "" ;
int in15 = 0 ;
String in16 = "" ;
String in17 = "" ;
String in18 = "" ;
String in19 = "" ;
String in20 = "" ;
String curry="";
String rate="";
String Room="";
String csdate=""; 
String outstate="";
String yxlxs="",yxlx1="",yxlx2="",yxlx3="",yxlx4="",yxlx5="";
String yxlcs="",yxlc1="",yxlc2="",yxlc3="",yxlc4="",yxlc5="";
String yxfxs="",yxfx1="",yxfx2="",yxfx3="",yxfx4="",yxfx5="";
String Room1="",customerno="",vipno="",cyj="5000",bak="";
ResultSet rs = fBean.executeQuery( sq ) ;

if( rs.next() ) {
    seri = rs.getString( 1 ) ;
	Section=  getbyte( rs.getString( "Section" ) ) ;
	customerno=  getbyte( rs.getString( "SERIALNO" ) ) ;
	cusno=  getbyte( rs.getString( "code" ) ) ;
	in1 = getbyte( rs.getString( "Cus_Name" ) ) ;
    in2 = getbyte( rs.getString( "Cus_Sex" ) ) ;
    in3 = getbyte( rs.getString( "cus_age" ) ) ;
	custype=getbyte(rs.getString("Cus_Type"));
	if (in3.equals(""))in3="0";
 
    
    in5 = getbyte( rs.getString( "Phone" ) ) ;
	in4 = getbyte( rs.getString( "ID_Card" ) ) ;
    in7 = getbyte( rs.getString( "address" ) ) ;
    in8 = getbyte( rs.getString( "Zip_Code" ) ) ;
	  
       //Fomrat date 
   
	  date=getbyte(rs.getString("visit_date"));
     java.text.SimpleDateFormat needdate =null;
	 	
     needdate=new java.text.SimpleDateFormat("yyyy-MM-dd");
	 if (!date.equals(""))
	 date=needdate.format(needdate.parse(date));
	
     in18=getbyte(rs.getString("seller"));
	 company=getbyte(rs.getString("company"));
	 visitnum=getbyte(rs.getString("visitnum"));
	 visitname=getbyte(rs.getString("visitname"));
	 visitsex=getbyte(rs.getString("visitsex"));
	 visitage=rs.getString("visitage");
	 nexus=getbyte(rs.getString("nexus"));
 
     visittj=getbyte(rs.getString("visittj"));
     mail=getbyte(rs.getString("mail"));
	 region=getbyte(rs.getString("region")).trim();
     sale=rs.getString("FTSALE");
	 job=getbyte(rs.getString("job"));
	 wh=getbyte(rs.getString("Wh"));
	 jtsr=getbyte(rs.getString("jtsr"));
	 personnum=getbyte(rs.getString("personnum"));
	 signatory=getbyte(rs.getString("signatory"));   
	 linkman=getbyte(rs.getString("contactperson"));
     chishu=getbyte(rs.getString("chishu"));
     homejg=getbyte(rs.getString("homejg"));
	  nowarea=getbyte(rs.getString("nowjuarea"));
     in9=getbyte(rs.getString("demand"));
     attention=getbyte(rs.getString("attention"));
     in12=getbyte(rs.getString("payment"));
     bbj=getbyte(rs.getString("bbj"));

     in6=getbyte(rs.getString("sj"));	
	 csdate =getbyte(rs.getString("csdate"));	
 
 
}
rs.close() ;

StringTokenizer st22 = new StringTokenizer(yxfxs,",") ;
   
int count2 = st22.countTokens() ;
try{
 while (st22.hasMoreElements()) {
   String no=(String)st22.nextElement() ;
   if (no.equals("0"))yxfx1="checked";
   else if (no.equals("1"))yxfx2="checked";
   else if (no.equals("2"))yxfx3="checked";
   else if (no.equals("3"))yxfx4="checked";
   else if (no.equals("4"))yxfx5="checked";
}
 }catch(Exception s){}
 
   st22 = new StringTokenizer(yxlcs,",") ;
   
  count2 = st22.countTokens() ;
try{
 while (st22.hasMoreElements()) {
   String no=(String)st22.nextElement() ;
   if (no.equals("0"))yxlc1="checked";
   else if (no.equals("1"))yxlc2="checked";
   else if (no.equals("2"))yxlc3="checked";
   else if (no.equals("3"))yxlc4="checked";
   else if (no.equals("4"))yxlc5="checked";
}
 }catch(Exception s){}
 
  st22 = new StringTokenizer(yxlxs,",") ;
   
  count2 = st22.countTokens() ;
try{
 while (st22.hasMoreElements()) {
   String no=(String)st22.nextElement() ;
   if (no.equals("0"))yxlx1="checked";
   else if (no.equals("1"))yxlx2="checked";
   else if (no.equals("2"))yxlx3="checked";
   else if (no.equals("3"))yxlx4="checked";
   else if (no.equals("4"))yxlx5="checked";
}
 }catch(Exception s){}
 
 
String yixiang = "" ;
String section1="";
String sectionName1="";
String loft1="";
String building1="";
String room1="";
 
int k=0;
ResultSet rsy = null;
 
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
java.text.SimpleDateFormat date1 =null;
        date1=new java.text.SimpleDateFormat("yyyy-MM-dd");
        String TodayDate=date1.format(new java.util.Date()).toString();
		
        String curyear=TodayDate.substring(0,4);
        String curmonth=TodayDate.substring(5,7);
		 
        String curday=TodayDate.substring(8,10);
 %>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>编辑诚意资料</title>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
 
<script language="javascript" src="../public_js/public.js">
</script>
</head>
<script>
function full(){
      setSelectMad2(document.cus.section,'<%=Section%>');
	  setSelectMad(document.cus.Region,'<%=region%>');
	   
	    setSelectMad2(document.cus.seller,'<%=in18%>');   
	  
	
	   
   }
</script>

<body onload="full();">
<form name="cus" method="post">
<input type=hidden name=cusno value="<%= customerno%>" >
 
    
<p align="center"><b><font class=FontColor size="3" ><b>诚意修改</font></b></p>
 
<table border="0" cellspacing="1" width="100%" cellpadding="0" class="tablefill">
<tr>
      <td class=roomleft width="25%"> &nbsp;楼&nbsp;&nbsp;&nbsp;&nbsp;盘</td>
	  <td  class=roomright width="25%"> 
 <select style="width : 138" name="section" style="width:117"><option></option>
 <%
	  String sqls="select SerialNo,Name from CRM_Project";
	  ResultSet rss2=ViewBean.executeQuery(sqls);
	  String sec="";
	  String no="";
  while (rss2.next()){
	   no=rss2.getString("SerialNo");
	   
	   sec=getbyte(rss2.getString("Name"));
     	out.print("<option value='"+no+"-"+sec+"'>"+sec+"</option>");
	  }
	    rss2.close();
     %> </select><font color=red>*</font> </td>
	  <td class=roomleft width="34%">&nbsp;所在区域</td><td class=roomright width="66%"> 
 <select style="width : 130" name="Region" style="width:117"> 
<% for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("K"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
     %> </select> </td>
    </tr>
    <tr>
      <td width="25%" align="left" class=roomleft>&nbsp;客户姓名</td>
      <td width="25%" class=roomright><input type=text name=in1 size=18 value="<%= in1 %>" ><font color=red>*</font></td>
      <td width="25%" align="left"class=roomleft  height="24">&nbsp;性&nbsp;&nbsp;&nbsp;&nbsp;别</td><td class=roomright width="25%" align="left"   height="24"> 
 <input type=text    name=in2 size="5"  onkeydown="key(document.cus.name2)"  value="<%=in2 %>"  > <select style="width : 40"  name="sex1"  onkeydown="key(document.cus.sex2)"> 
<option selected value="男">男</option> <option value="女">女</option></select><input title="增加客户性别" type=button name=addsexs  onclick="addsex();" value=">>" >&nbsp;</td></tr>
</td></tr>
    </tr>

     <tr align="left" > 
 <td width="25%" align="left"class=roomleft  height="14">&nbsp;证&nbsp;件&nbsp;号</td><td class=roomright width="25%" align="left"   height="14"> 
 <input type="text"    name="in4" size="18"  value="<%= in4 %>"   > 
</td>
<td width="15%"   class=roomleft  height="14">&nbsp;出生日期</td>
<td class=roomright width="15%"      height="14"> 
<input type=text     name=csdate size="14"  value="<%=csdate %>"    ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(csdate);return false">
</td>
</tr>
    <tr>
      <td width="25%" align="left" class=roomleft>&nbsp;联系电话</td>
      <td width="25%" class=roomright ><input type=text name=in5 size=18 value="<%= in5 %>"></td>
      <td width="25%" class=roomleft>&nbsp;手&nbsp;&nbsp;&nbsp;&nbsp;机</td>
      <td width="25%" class=roomright ><input type=text name=in6 size=16 value="<%= in6 %>"></td>
    </tr>
	<tr align="left" > 
	 
<td width="25%" align="left"class=roomleft  height="24">&nbsp;单&nbsp;&nbsp;&nbsp;&nbsp;位</td>
<td class=roomright width="25%" align="left"   height="24"><input type=text    name=company size="33" value="<%=company %>"> 
</td>
<td width="25%"class=roomleft  align="left" height="23"> &nbsp;邮&nbsp;&nbsp;&nbsp;&nbsp;编</td><td class=roomright width="25%"   align="left" height="23">
 <input type=text    name=in8 size="16" value="<%=in8 %>"></td>
</tr> 
 

    <tr>
      <td width="25%" align="left" class=roomleft>&nbsp;联系地址</td>
      <td width="25%" class=roomright colspan="3"><input type=text name=in7 size=33 value="<%= in7 %>"></td>
      
    </tr>
<tr align="left" >
 <td width="25%" align="left"class=roomleft  height="14">&nbsp;来访日期</td><td class=roomright width="25%" align="left"   height="14"> 
 <input type=text    NAME=Date1 size=12 value="<%=date %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false"><font color=red>*</font>
</td> <td width="25%" class=roomleft >&nbsp;销&nbsp;售&nbsp;员</td>
      <td width="75%"   class=roomright > <select style="width : 130" size="1" name="seller" style="width:125" >
      <option value=""></option>
    
    <%
 
   String  sql="select seller from seller where section_no='"+Section+"'";
   try{
        rs=ViewBean.executeQuery(sql);
	     while (rs.next()){
	   
	 	   String Name=getbyte(rs.getString("seller"));
       out.print("<option value='"+Name+"'>"+Name+"</option>") ;
	  }
	 
	  rs.close();
	}catch(Exception s)   {out.println(s.getMessage());}
	
 
  %></select>
      </td>
	  </tr>
	  <tr> 
<td colspan=4 align=center class=TITLE><b>意&nbsp;向&nbsp;登&nbsp;记</b></td></tr>
 <tr>
      <td width="25%" align="left" class=roomleft>&nbsp;诚意金</td>
      <td width="25%" class=roomright colspan="3" >
	  <input type=text name=cyj value="<%=cyj %>">
	  
       </td>
	   
    </tr>	
  <tr>
      <td width="25%" align="left" class=roomleft>&nbsp;VIP卡号</td>
      <td width="25%" class=roomright colspan="3" >
	  <input type=text name=vipno value="<%=vipno %>">
	  
       </td>
	   
    </tr>	 
    <tr>
   
	  <td width="25%" align="left" class=roomleft >&nbsp;意向单位</td>
      <td width="25%" class=roomright  colspan="3">1.<input type=text name=in17 value="<%= Room %>"size=16 >&nbsp;2.<input type=text name=in17a  value="<%=Room1 %>" size=16 >
         
      </td>
    </tr>
    <tr> 
      <td width="25%" align="left" class=roomleft >&nbsp;登记日期</td>
      <td width="25%" class=roomright ><input type=text name=in13 size=13 value="<%=curyear+"-"+curmonth+"-"+curday %>" readonly><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(in13);return false;" ><font color=red>*</font></td>
     
	<td width="25%" class=roomleft >&nbsp;失效日期</td>
      <td width="25%" class=roomright ><input type=text name=in14 size=13 readonly value="<%if (!in14.equals("")){if (in14.substring(0,1)!="1"){out.print(in14);}}  %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(in14);return false;" ></td>
     </tr>
 
     <tr>
      <td width="25%" align="left" class=roomleft >&nbsp;备注</td>
      <td width="25%" class=roomright  colspan="3"> <textarea cols="50" rows="3" name=bak><%=bak %></textarea>
      </td>
    </tr>  
	 <tr>
      <td width="25%" align="left" class=roomleft >&nbsp;是否失效</td>
      <td width="25%" class=roomright  colspan="3"> <input name="outstate" value=0 <%=outstate %> type="checkbox">
      </td>
    </tr>  
   </table>
   

 <table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif">　<img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>调查反馈</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"><font color="#FF6600"> &nbsp;</font></td>
</tr>
</table>	
 <table BORDER=0 width="100%"  CELLSPACING=1 CELLPADDING=3 ALIGN=center>
	 
  <%
  
 int arrInt=0;  

 sql="SELECT COUNT(*) NUM FROM customer_xq where customer="+cusno;
 rs=ViewBean.executeQuery(sql);	
 if (rs.next()){
   arrInt=rs.getInt("NUM");
 }
 rs.close();   
 String CodeValue[]=new String[arrInt];
 
 sql="SELECT xq_code FROM customer_xq where customer="+cusno;
 rs=ViewBean.executeQuery(sql);	
 int j=0;
 while (rs.next()){
   CodeValue[j]=rs.getString("xq_code");
   j++;
 }
 rs.close();
 
  String SQL="select * from CustomerDc  where sectionno='"+Section+"'";
  rs=ViewBean.executeQuery(SQL);	
  int iii=0;
   while (rs.next()){
     iii++;
   %>
 <tr align="center">
    <td width="5%"  class=roomleft ><%=iii %></td>
    <td width="15%" class=roomleft  align="left">&nbsp;<%=rs.getString("codeName") %></td>
	<td width="65%" align="left" class=roomright>
	<%
	 SQL="select  CodeValue,code from CustomerDcValue where dcCode="+rs.getString("code");
	 
	 ResultSet rs1=fBean.executeQuery(SQL);	
    while (rs1.next()){
	    String sele="";
	    String codcename=rs1.getString("CodeValue");
		String code=rs1.getString("code");
		 for (int ii=0;ii<arrInt;ii++){
		  if (CodeValue[ii]!=null){
		   if (CodeValue[ii].equals(code))
	        sele="checked";
		  }
       }
	     %>
		   <input name="codcename<%=code %>" type="checkbox" value="<%=code %>" <%=sele %>   ><%=codcename %> 
		 <% 
       }
	rs1.close();
	 %>
	
	</td>
	 
  </tr>
  <%}
  rs.close(); %>
 </table> 

<p align="center">
 <input type=button name=b1 value=" 保 存 " onclick="dengji()">
 <input type=button name=b2 value=" 关 闭 " onclick="javascript:window.close()">    
</p>

<script lang=javascript>


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
			else alert("有些身份证号位数有误,系统只计算正确号码的年龄");   
		   }
		  else
		    {
			if (arry[jj].length==18)
		       ages+="/"+String(parseInt(year)-parseInt(arry[jj].substring(6,10)));
		    else if (arry[jj].length==15)
		       ages+="/"+String(parseInt(year)-parseInt("19"+arry[jj].substring(6,8)));
			else alert("有些身份证号位数有误,系统只计算正确号码的年龄");     
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
	if( document.forms[ 0 ].in1.value == ""  ) {
		alert( "请输入诚意客户 ! " ) ;
		document.forms[ 0 ].in1.focus() ;
		return false ;
	}
	 

	aa=document.forms[ 0 ].in6.value;
	if (aa!=""){
	if (!(aa.length==11||aa.length==12  )) {
		alert( "请输入诚意客户手机号有误! " ) ;
		document.forms[ 0 ].in6.focus() ;
		return false ;
	}
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
	 
	
	if( document.forms[ 0 ].in14.value!= "" && document.forms[ 0 ].in13.value != "" ) {
		if( document.forms[ 0 ].in14.value<=document.forms[ 0 ].in13.value ) 
		{alert( "失效日期不能小于诚意日期! " ) ;
		alert(document.forms[ 0 ].in13.value);
		document.forms[ 0 ].in14.focus() ;
		return false ;
		}
	}
	
	
	return true ;
}

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

function dengji()
{
	if( checkValue() ) {
		document.cus.action = "chengyi_edit_action1.jsp" ;
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
function findCus() {
    var spa = 60 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa / 2 ;
    var lef = spa / 2 ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=" + 400 ;
    var posi = posi + ",width=" + 350 ;
    
    var newwin2 = window.open( "chengyi_fc.jsp","NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
    newwin2.focus();    
}
function choose1(para){
    if (atten!=""){
       if (confirm("已经选择了一个，是否要多选？"))para.value=para.value+","+atten;
    }
}


function CurrRa(){
 //汇率转换
   var curryName=document.forms[ 0 ].curry.options[document.forms[ 0 ].curry.selectedIndex].value;
   for (var jj=0;jj<RateName.length;jj++)
    {
	  if (RateName[jj]==curryName)
	  {
	   document.forms[ 0 ].rate.value=RateValue[jj];
	   break;
	  }
	}
 
 } 
</script>
</form>
</body>
</html>
