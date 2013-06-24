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
String ref_id = request.getParameter( "ref_id" ) ;
String sq =  " select a.* , b.* "
		   + " from tb_chengyi a left join customer b"
		   + " on a.serialNo = b.serialNo "
           + " where a.code = '" + ref_id + "' "
	       + " order by dengji_riqi desc" ;
	 
 
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
String tk1="0",tk_date1="",sk_date="";
String yxlxs="",yxlx1="",yxlx2="",yxlx3="",yxlx4="",yxlx5="";
String yxlcs="",yxlc1="",yxlc2="",yxlc3="",yxlc4="",yxlc5="";
String yxfxs="",yxfx1="",yxfx2="",yxfx3="",yxfx4="",yxfx5="";
String Room1="",customerno="",vipno="",cyj="5000",sjh="";
ResultSet rs = fBean.executeQuery( sq ) ;
	String tk="0";
	String tk_date="0";
	String cus_code="";
if( rs.next() ) {
   cus_code=getbyte( rs.getString( "code" ) ) ;
    seri = rs.getString( 1 ) ;
	customerno=  getbyte( rs.getString( "SERIALNO" ) ) ;
	in1 = getbyte( rs.getString( "Cus_Name" ) ) ;
    in2 = getbyte( rs.getString( "Cus_Sex" ) ) ;
    in3 = getbyte( rs.getString( "cus_age" ) ) ;
	custype=getbyte(rs.getString("Cus_Type"));
	if (in3.equals(""))in3="0";
	gmyt=getbyte(rs.getString("Purpose"));
	tj=getbyte(rs.getString("Knowledge_From"));
    
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
     in10=getbyte(rs.getString("yixianmianji"));
	 Room=getbyte(rs.getString("room"));
    in13 = formatDateTime( rs.getTimestamp( "dengji_riqi" ) , 0 ) ;
	if(rs.getTimestamp( "shixiao_riqi" )==null)
	   {in14="";}else{
    in14 = formatDateTime( rs.getTimestamp( "shixiao_riqi" ) , 0 ) ;}
    in15 = rs.getInt( "jinger" ) ;
	
    in16 = getbyte( rs.getString( "context" ) ) ;
    in18 = getbyte( rs.getString( "dengjiren" ) ) ;
    in19 = getbyte( rs.getString( "beizhu" ) ) ;
	in20 = getbyte( rs.getString( "sendmoney" ) ) ;
	curry= getbyte( rs.getString( "curry" ) ) ;
	rate= getbyte( rs.getString( "rate" ) ) ;
	yxfxs= getbyte( rs.getString( "yxfxs" ) ) ;
	yxlcs= getbyte( rs.getString( "yxlcs" ) ) ;
	yxlxs= getbyte( rs.getString( "yxlxs" ) ) ;
	Room1= getbyte( rs.getString( "yxdw1" ) ) ;
	Section= getbyte( rs.getString( "Section" ) ) ;
		tk=getbyte(rs.getString("tk"));
		if (tk.equals(""))tk="0";
		tk_date=getbyte(rs.getString("tk_date"));
		if (!tk_date.equals(""))tk_date=tk_date.substring(0,10);
		tk1=getbyte(rs.getString("tk1"));
				if (tk1.equals(""))tk1="0";
		tk_date1=getbyte(rs.getString("tk_date1"));
		if (!tk_date1.equals(""))tk_date1=tk_date1.substring(0,10);
		vipno= getbyte( rs.getString( "vipno" ) ) ;
	cyj= getbyte( rs.getString( "yscyj" ) ) ;
	if (in15==0)in15=rs.getInt( "yscyj" );
	sk_date=getbyte(rs.getString("sk_date"));
	if (!sk_date.equals(""))sk_date=sk_date.substring(0,10);
        else sk_date=formatDateTime( new java.util.Date() , 0 );
	if (cyj.equals(""))cyj="5000";
	sjh= getbyte( rs.getString( "sjh" ) ) ;
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
String sq2 = "";
int k=0;
 %>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>诚意修改</title>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script Language="JavaScript" src="../public_js/basal.js"></script>
<script language="javascript" src="../public_js/public.js">
</script>
</head>
<script>
function full(){
      
 
	   setSelectMad(document.cus.curry,'<%=curry%>');  
	  
   }
</script>

<body onload="full();">
<form name="cus" method="post">
<input type=hidden name=cusno value="<%= customerno%>" >
<input type=hidden name=cusSerial value="<%= ref_id%>" >
 
 
<%
String sectionPara = request.getParameter("section");
String cusSql = "select sjh  from tb_chengyi where SERIALNO like '%" 
                + Section + "%' and code <>"+ref_id;
ResultSet cusRs=null;
 


try {
    cusRs=ViewBean.executeQuery(cusSql);
}catch(Exception s)
{
}
java.util.Vector vctPJH = new java.util.Vector() ;
 
while ( cusRs.next()){
    String cus_name = getbyte(cusRs.getString( 1 ) ) ;
	 
     vctPJH.addElement( cus_name ) ;
  
}
cusRs.close(); 
%>

<script lang=javascript>
    nameArr = new Array() ;
   function checkSJH()
{


    var hasNamePhone = false ;
    var c_name = document.forms[ 0 ].sjh.value ;
     if (c_name!=""){
    for( var p = 0 ; p < nameArr.length ; p ++ ) {
        if( c_name == nameArr[ p ] ) {
           // hasNamePhone = true ;
			alert("票据号重复！");
			document.forms[0].BillNum.focus();
            break ;
        }
    }
	}
	 
    return hasNamePhone ;
}	
</script>

<%
for( int p = 0 ; p < vctPJH.size() ; p ++ ) {
    %>
    <script lang=javascript>
	
        nameArr[ <%= p%> ] = "<%= vctPJH.get( p ).toString() %>";
    </script>
    <%
}
%>
 
<p align="center"><b><font class=FontColor size="3" ><b>诚意修改</font></b></p>
 
<table border="0" cellspacing="1" width="100%" cellpadding="0" class="tablefill">
<tr>
      <td class=roomleft width="25%"> &nbsp;楼&nbsp;&nbsp;&nbsp;&nbsp;盘</td>
	  <td  class=roomright width="25%">&nbsp;<%
	  String sqls="select SerialNo,Name from CRM_Project where serialno='"+Section+"'" ;
	  ResultSet rss2=ViewBean.executeQuery(sqls);
	  String sec="";
	  String no="";
  while (rss2.next()){
	   no=rss2.getString("SerialNo");
	   
	   sec=getbyte(rss2.getString("Name"));
     	out.print(sec);
	  }
	    rss2.close();
     %>  </td>
	  <td class=roomleft width="34%">&nbsp;来自区域</td><td class=roomright width="66%"> 
&nbsp;<%=region%>  </td>
    </tr>
    <tr>
      <td width="25%" align="left" class=roomleft>&nbsp;客户姓名</td>
      <td width="25%" class=roomright>&nbsp;<%= in1 %></td>
      <td width="25%" align="left"class=roomleft  height="24">&nbsp;性&nbsp;&nbsp;&nbsp;&nbsp;别</td><td class=roomright width="25%" align="left"   height="24"> 
&nbsp; <%=in2 %>  
 &nbsp;</td></tr>
</td></tr>
    </tr>

    <tr>
	  <td width="25%" class=roomleft>&nbsp;证件号</td>
      <td width="25%" class=roomright >&nbsp;<%= in4 %></td>
 
      <td width="25%" align="left" class=roomleft>&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;龄</td>
      <td width="25%" class=roomright >&nbsp;<%= in3 %></td>
       </tr>
    <tr>
      <td width="25%" align="left" class=roomleft>&nbsp;联系电话</td>
      <td width="25%" class=roomright >&nbsp;<%= in5 %></td>
      <td width="25%" class=roomleft>&nbsp;手&nbsp;&nbsp;&nbsp;&nbsp;机</td>
      <td width="25%" class=roomright >&nbsp;<%= in6 %></td>
    </tr>
	<tr align="left" > 
	 
<td width="25%" align="left"class=roomleft  height="24">&nbsp;单&nbsp;&nbsp;&nbsp;&nbsp;位</td>
<td class=roomright width="25%" align="left"   height="24">&nbsp;<%=company %> 
</td>
<td width="25%"class=roomleft  align="left" height="23"> &nbsp;邮&nbsp;&nbsp;&nbsp;&nbsp;编</td><td class=roomright width="25%"   align="left" height="23">
&nbsp;<%=in8 %> </td>
</tr>
 
    <tr>
      <td width="25%" align="left" class=roomleft>&nbsp;联系地址</td>
      <td width="25%" class=roomright colspan="3">&nbsp;<%= in7 %> </td>
      
    </tr>
<tr align="left" >
 <td width="25%" align="left"class=roomleft  height="14">&nbsp;来访日期</td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<%=date %> 
</td> <td width="25%" class=roomleft >&nbsp;销&nbsp;售&nbsp;员</td>
      <td width="75%" class=roomright >&nbsp;
   <%=in18  %> 
      </td>
	  </tr>
	  <tr> 
<td colspan=4 align=center class=TITLE><b>收&nbsp;诚&nbsp;意&nbsp;金</b></td></tr>
  <tr>
      <td width="25%" align="left" class=roomleft>&nbsp;应收金额</td>
      <td width="25%" class=roomright colspan="3" >&nbsp; <%=cyj %> 
	  
       </td>
	   
    </tr>	
  <tr>
      <td width="25%" align="left" class=roomleft>&nbsp;VIP卡号</td>
      <td width="25%" class=roomright colspan="3" >
	  &nbsp;<%=vipno %> 
	  
       </td>
	   
    </tr> 
    
    <tr>
      <td width="25%" align="left" class=roomleft >&nbsp;实收金额</td>
      <td width="25%" class=roomright ><input type=text name=in15 size=16 value="<%= in15 %>" ><font color=red>*</font></td>
	  <td width="25%" align="left" class=roomleft>&nbsp;交款方式</td>
      <td width="25%" class=roomright >
	  
	   <select name="in20"   >
		  <option <%if (in20.equals("pos机")){out.print("selected");} %> >pos机</option>
         <option  <%if (in20.equals("现金")){out.print("selected");} %>>现金</option>
        <option  <%if (in20.equals("支票")){out.print("selected");} %>>支票</option>
	</select>	 
	 </td>
	   </tr>   
	    <tr>
      <td width="25%" align="left" class=roomleft >&nbsp;收款日期</td>
      <td width="25%" class=roomright >
	  <input type=text name="skDate2" value="<%=sk_date %>" size=15  onKeyDown="key(document.cus.in16)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(skDate2);return false;">
	  
	</td>
      <td width="25%" align="left" class=roomleft>&nbsp;币别</td>
      <td width="25%" class=roomright >


 <select name="curry"  OnChange="CurrRa();" onkeydown="key(document.cus1.PayType)">
		  <option value="￥">人民币</option>
		  <option value="HKD">港元</option>
		  <option value="USD">美元</option>
	</select>	  
	 <input type=text name="rate"  value= "<%=rate %>" size="5"  >
	  </td>
	  </tr>
	  <tr>
      <td width="25%" class=roomleft >&nbsp;收据号</td>
      <td width="25%" class=roomright colspan="3"><input type=text name=sjh size=50 value="<%= sjh %>" onblur="checkSJH();"></td>
   
     
	</tr>
	<tr>
      <td width="25%" class=roomleft >&nbsp;备注</td>
      <td width="25%" class=roomright colspan="3"><input type=text name=in16 size=50 value="<%= in16 %>" ></td>
   
     
	</tr>
	<%if (!sk_date.equals("")){ %>
 <tr> 
 <td width="25%" class=roomleft>&nbsp;退款</td>
      <td width="25%" class=roomright  ><input type=text name="tk"  size=15 value="<%=tk %>" onKeyDown="key(document.cus.save)">
 </td>
 <td width="25%" class=roomleft>&nbsp;退款日期</td>
      <td width="25%" class=roomright  ><input type=text name="tkDate1" value="<%=tk_date %>" size=15  onKeyDown="key(document.cus.save)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(tkDate1);return false;">
 </td>
</tr>	
<tr> 
 <td width="25%" class=roomleft>&nbsp;退款</td>
      <td width="25%" class=roomright  ><input type=text name="tk1"  size=15 value="<%=tk1 %>" onKeyDown="key(document.cus.save)">
 </td>
 <td width="25%" class=roomleft>&nbsp;退款日期</td>
      <td width="25%" class=roomright  ><input type=text name="tkDate2" value="<%=tk_date1 %>" size=15  onKeyDown="key(document.cus.save)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(tkDate2);return false;">
 </td>
</tr>	
<%} %>
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

 String  sql="SELECT COUNT(*) NUM FROM customer_xq where customer="+cus_code;
 rs=ViewBean.executeQuery(sql);	
 if (rs.next()){
   arrInt=rs.getInt("NUM");
 }
 rs.close();   
 String CodeValue[]=new String[arrInt];
 
 sql="SELECT xq_code FROM customer_xq where customer="+cus_code;
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
		   <input name="codcename<%=code %>" disabled type="checkbox" value="<%=code %>" <%=sele %>   ><%=codcename %> 
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
 <input type=button name=b1 value=" 提 交 " onclick="dengji()">
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
	/*if( document.forms[ 0 ].in1.value == ""  ) {
		alert( "请输入诚意客户 ! " ) ;
		document.forms[ 0 ].in1.focus() ;
		return false ;
	}
	if( document.forms[ 0 ].in4.value == ""  ) {
		alert( "请输入诚意客户身份证号 ! " ) ;
		document.forms[ 0 ].in4.focus() ;
		return false ;
	}
	
	if( document.forms[ 0 ].in5.value == ""  ) {
		alert( "请输入诚意客户联系电话 ! " ) ;
		document.forms[ 0 ].in5.focus() ;
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
	if( document.forms[ 0 ].in15.value == "" || isNaN( document.forms[ 0 ].in15.value ) ) {
		alert( "请输入诚意金额 ! " ) ;
		document.forms[ 0 ].in15.focus() ;
		return false ;
	}
	
	if( document.forms[ 0 ].in14.value!= "" && document.forms[ 0 ].in13.value != "" ) {
		if( document.forms[ 0 ].in14.value<=document.forms[ 0 ].in13.value ) 
		{alert( "失效日期不能小于诚意日期! " ) ;
		document.forms[ 0 ].in14.focus() ;
		return false ;
		}
	}
	
	
	return true ;
	*/
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
	//if( checkValue() ) {
		document.cus.action = "chengyi_edit_action.jsp" ;
		document.cus.submit() ;    
	//}
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
