   <%@ page contentType="text/html;charset=GBK" %>
 <%@ page import = "java.sql.*" %>
 <%@ include file="../public_js/checktime.jsp"%>
  <jsp:useBean id = "PayBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>付款方案明细</title>
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
 <%
	  String payname=getbyte1(request.getParameter("payname"));
	 
	  String paycode=request.getParameter("paycode");
      String cs=getbyte2(request.getParameter("cs"));     
	  String prePay=getbyte2(request.getParameter("prePay"));     
	  if (cs.equals(""))cs="100";
     %>	
<script>
function UpdateData(){

if (document.cus.paytype[1].checked){document.cus.money.value=parseFloat(document.cus.money1.value);}
if (document.cus.paytype[1].checked){
  if (parseInt(document.cus.bfb.value)+parseInt(document.cus.money.value)><%=cs %>){
   alert("付款比例和超过了<%=cs %>%");
   return false;
  }
  var num=document.cus.paynum1.length;

  if (parseInt(document.cus.bfb.value)+parseInt(document.cus.money.value)==<%=cs %>&&parseInt(num)>1){
   alert("至少还有两期未设置，付款比例和将超过<%=cs %>%");
   return false;
  }

} 
  document.cus.bfb.value=parseInt(document.cus.bfb.value)+parseInt(document.cus.money.value);

document.cus.paynum1.options[document.cus.paynum1.selectedIndex]=null;


var para1="&payname="+document.cus.payname.value;
var para2="&paycode="+document.cus.paycode.value;
var para3="&paynum="+document.cus.paynum.value;
var para4="&paynum1="+document.cus.paynum1.value;
var para5="";
var para6=""; 
 if (document.cus.paytype[1].checked){
    para6="&paytype="+document.cus.paytype[1].value;
} else{para6="&paytype="+document.cus.paytype[0].value;}
if (document.cus.mo[1].checked){
    para6="&mo="+document.cus.mo[1].value;
} else{para6="&mo="+document.cus.mo[0].value;}
var para7="";

if (document.cus.de[1].checked){
    para7="&de="+document.cus.de[1].value;
} else{para7="&de="+document.cus.de[0].value;}
 
var para8="&note="+document.cus.note.value;
var para9="&month="+document.cus.month.value;
var para10="&day="+document.cus.day.value;
var para11="&section="+document.cus.section.value;
var para12="&money="+document.cus.money.value;
var para13="&money1="+document.cus.money1.value;
var para15="Date1="+document.cus.Date1.value;
var para14="";
if (document.cus.djcheck.checked) 
 para14="&djcheck=1";
else
para14="&djcheck=0";
para1+=para2+para3+para4+para5+para6+para7+para8+para9+para10+para11+para12+para13+para14+"&dateTj="+document.cus.dateTj.value;
 
var para9="&money="+document.cus.money.value;
openwin1("SaveList.jsp?para=insert"+para1,1,1,1,1);
document.cus.mo[1].checked=true;
document.cus.mo[0].checked=false;
if (document.cus.djcheck.checked)document.cus.djcheck.checked=false;
if (parseInt(document.cus.paynum1.length)==0){opener.window.location.reload();window.close();}
   }	   
</script>
<body class=formbg>


<p align=center class=FontColor><font size=3 ><b>付款明细</b></font></p>
<center>
<script>
function checkdj(){

  if (document.cus.paytype[0].checked&&document.cus.paynum1.value=="0"){
     if (parseFloat(document.cus.money1.value)!=parseFloat(document.cus.prePay.value))
	 {alert("定金金额与付款方案中的定金金额不一");document.cus.money1.focus();document.cus.money1.select();return false;}
  }

}

</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
<form name=cus method="POST" action="" target="_blank" onsubmit="UpdateData();">
<input type=hidden name=prePay value="<%=prePay %>">
 <input type="hidden"  name="paycode" value="<%=paycode%>">
	   <input type="hidden"  name="section" value="<%=request.getParameter("section")%>">
  &nbsp;<input type="hidden" name="payname" value="<%=payname %>" size="20" style="border-style: solid; border-width: 1">

<table width="100%" border =0 CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#dfdfdf" class="tablefill">
  
  <tr>
    <td       width="10%" class=roomleft>&nbsp;付款期数</td>
    <td  width="90%" class=roomright>&nbsp;
	<input type=hidden name="paynum">
	<select size="1" name="paynum1" onchange="paynumcheck();">
	   <%
	   int qs=0;
	   for (int a=0;a<=Integer.parseInt(request.getParameter("paynum"));a++){ 
	    
	   %>
          <option value="<%=a %>"><%=a %></option>
      <%} %>
	    </select>&nbsp;<input type=radio value=0 name=paytype checked >定金&nbsp<input type=radio value=1 name=paytype >楼款<input type=checkbox name=djcheck value="1" disabled title="在首期款中可以>含订金">含定金&nbsp;(0期表示定金)</td>
  </tr>
 
  <tr>
    <td       width="10%" class=roomleft>&nbsp;付款金额</td>
    <td  width="90%" class=roomright>&nbsp;固定金额<input type=checkbox name=mo value="0" checked onclick="document.cus.mo[1].checked=false;document.cus.money1.focus();">&nbsp;房款百分比<input type=checkbox name=mo value="1"  onclick="document.cus.mo[0].checked=false;document.cus.money1.focus();"><br>&nbsp;<input type="text" name="money1" value=<%=prePay %> size="12" style="border-style: solid; border-width: 1" onkeydown="key(document.cus.month);" onblur="checkdj();" >&nbsp;</td>
	<input type=hidden name=money value=0>
  </tr>
  <tr>
    <td       width="10%" class=roomleft>&nbsp;付款日期</td>
    <td  width="90%" class=roomright>&nbsp;变动日期<input type=checkbox name=de value="0" checked  onclick="document.cus.de[1].checked=false;document.cus.Date1.disabled=true;document.cus.choose.disabled=true;" >&nbsp;&nbsp;<select name=dateTj><option value=0>认购日期</option><option value=1>签约日期</option></select>后，<input type="text" name="month" size="4" value=0  style="border-style: solid; border-width: 1" onkeydown="key(document.cus.day)">月,	<input type="text" name="day" value=0 size="4" style="border-style: solid; border-width: 1">天内付清
	<br>&nbsp;固定日期<input type=checkbox name=de value="1" onclick="chooseD(this);document.cus.choose.focus();" >&nbsp;<input type="text" name="Date1" size="12" style="border-style: solid; border-width: 1"><input type=button name=choose value=".." onclick="fPopUpCalendarDlg(Date1);return false;" disabled>
	</td>
  </tr>
   <tr>
    <td       width="10%" class=roomleft>&nbsp;备&nbsp;&nbsp;&nbsp;&nbsp;注</td>
    <td  width="90%" class=roomright>&nbsp;<textarea rows="3" style="border-style: solid; border-width: 1" name="note" cols="35"></textarea></td>
  </tr>
</table>
<input type=hidden name="bfb" value=0>
<p><input type="button" value="提  交" name="B1" onclick="chekcedInput();">&nbsp;&nbsp;<input type="button" value=" 关 闭 " name="B2" onclick="window.close()"></p>
      </form>
</center>	  
<script>
function seleD(){
 if (document.cus.de.checked){DID('1');
 MM_showHideLayers('ebusiness','','show');
 ;}
 else{
 MM_showHideLayers('ebusiness','','hide');
 document.cus.Date1.value="";

 }
}
function chooseD(para){
   document.cus.de[0].checked=false;
   
   if (para.checked) {
	   document.cus.choose.disabled=false;
       document.cus.Date1.disabled=false;
   }
   else {
	   document.cus.choose.disabled=true;
       document.cus.Date1.disabled=true;
   }
}
function  chekcedInput(){
  if (document.cus.money1.value==""){ alert("请输入完整数据");document.cus.money1.focus();return (false);}
  if (document.cus.de[0].checked){if (document.cus.day.value==""){alert("请输入完整数据");document.cus.day.focus();return (false);}}
  if (document.cus.de[1].checked){if (document.cus.Date1.value==""){alert("请输入完整数据");document.cus.Date1.focus();return (false);}}
 
  if (document.cus.de[0].checked){if (parseInt(document.cus.day.value)>=30){alert("如果天数大于或等于30天，请转为月数");document.cus.day.focus();return (false);}}
   paynumcheck();
  UpdateData();

}
function paynumcheck(){
    document.cus.paytype[0].disabled=true;
    var num=document.cus.paynum1.options[document.cus.paynum1.selectedIndex].value;
	  document.cus.paynum.value=num;

	if (num=="0"){
		document.cus.paytype[0].checked=true;
        document.cus.djcheck.disabled=false;
 	}
	else{
	 document.cus.paytype[1].checked=true;
     document.cus.djcheck.disabled=false;
	 
	}
	

}
</script>
</body>

</html>
