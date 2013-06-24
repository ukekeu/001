   <%@ page contentType="text/html;charset=GBK" %>
   <%@ include file="../public_js/checktime.jsp"%>
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

<body>

<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id = "PayBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <%@ include file="../public_js/getByteOut.jsp"%>
<p align=center><font size=3><b>付款明细</b></font></p>
<center>
 <% String sql="";
  String payname=request.getParameter("payname");
  String id=request.getParameter("id");
 %>
  <%
	 String modiStr = "";
	 String de="";//是否为具体日期
 	 String mo="";//是否为具体金额
 	 String para="";
	 String paycode ="";
	 String paynum ="";
	 int scale =0;
	 String month ="";
	 int day = 0;
	 int paydate=0;
	 String StrDate="";
	 boolean disc=false;
	 boolean state1=false;
     boolean state2=false;
	  boolean state3=false;
	 String StrDisc="";
     String StrState10="";//check 是否为固定金额
	 String StrState11="";
     
     String StrState20="";//check 是否为固定日期
	 String StrState21="";
	 int money=0;
        
	 String note="";
	  sql="select paycode,num,PayDate,scale,money,state1,state2,state3,convert(char(24),Date,111) as Date,money,note from PayDetail where ID="+id;

	  try{
	   ResultSet rs=PayBean.executeQuery(sql);
	   
	  if (rs.next()){
	 
         paycode=rs.getString("paycode");
         paynum=rs.getString("num");
         paydate=rs.getInt("paydate");
         day=paydate-paydate/30*30;
		 paydate=paydate/30;
         scale=rs.getInt("scale");
         money=rs.getInt("money");
		 state1=rs.getBoolean("state1");
         state2=rs.getBoolean("state2");
		 state3=rs.getBoolean("state3");
		 StrDate=rs.getString("Date");
		 note=getbyte(rs.getString("note"));
	  }
	  rs.close();
      }catch(Exception s ){}
 
	  if (state3) StrDisc="checked";
	  if (state1) StrState10="checked";
	  else  StrState11="checked";
	  if (state1) scale=money;
	  if (state2) StrState20="checked";
	  else  StrState21="checked";
  %>	
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
<form method="POST" name=cus  action="">
<table width="100%" border =0 CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#dfdfdf" class="tablefill">
 <!--<tr>
       <td   width="10%" class=roomleft>&nbsp;方案名称 </td>
    <td  width="90%" class=roomright>
	&nbsp;<input type="text" name="payname" value="<%=payname %>" size="12" style="border-style: solid; border-width: 1">

   </td>
  </tr>
  --> 
  <tr>
    <td       width="10%" class=roomleft>&nbsp;款项</td>
    <td  width="90%" class=roomright>&nbsp;<%if (paynum.equals("0")){out.print("定金");}else{out.print("首期款");} %><input type="hidden" name="paynum" value="<%=paynum %>" readonly size="12" style="border-style: solid; border-width: 1">
  
  &nbsp;<input type=checkbox name=djcheck value="1" <%if (paynum.equals("0")) out.print("disabled");%> title="在首期款中可以含订金" <%=StrDisc%>>含定金</td>
  </tr>
 
  <tr>
    <td       width="10%" class=roomleft>&nbsp;付款金额</td>
    <td  width="90%" class=roomright>&nbsp;固定金额<input type=checkbox name=mo value="0" <%=StrState10%>  onclick="document.cus.mo[1].checked=false;document.cus.money.focus();">&nbsp;房款百分比<input type=checkbox name=mo value="1" <%=StrState11%> onclick="document.cus.mo[0].checked=false;document.cus.money.focus();"><br>&nbsp;<input type="text" name="money" size="12" style="border-style: solid; border-width: 1" value="<%=scale%>" onkeydown="key(document.cus.month)">&nbsp;</td>
  </tr>
  <tr>
    <td       width="10%" class=roomleft>&nbsp;付款日期</td>
    <td  width="90%" class=roomright>&nbsp;变动日期<input type=checkbox name=de value="0" <%=StrState21%> onclick="document.cus.de[1].checked=false;document.cus.Date1.disabled=true;document.cus.choose.disabled=true;" >&nbsp;&nbsp;<select name=dateTj><option value=0>认购日期</option><option value=1>签约日期</option></select>后，<input type="text" name="month" size="4" style="border-style: solid; border-width: 1" value="<%=paydate%>"  onkeydown="key(document.cus.day)">月,	<input type="text" name="day" size="4" value="<%=day%>" style="border-style: solid; border-width: 1">天内付清
	<br>&nbsp;固定日期<input type=checkbox name=de value="1" <%=StrState20%> onclick="chooseD(this);document.cus.choose.focus();" >&nbsp;<input type="text" name="Date1" size="12" value="<%=StrDate%>" style="border-style: solid; border-width: 1"><input type=button name=choose value=".." onclick="fPopUpCalendarDlg(Date1);return false;" <%=StrState20%>>
	
    	
	
	</td>
  </tr>
   <tr>
    <td       width="10%" class=roomleft>&nbsp;备&nbsp;&nbsp;&nbsp;&nbsp;注</td>
    <td  width="90%" class=roomright>&nbsp;<textarea rows="3" style="border-style: solid; border-width: 1" name="note" cols="35"></textarea></td>
  </tr>
</table>
<p><input type="button" value="提  交" name="B1" onclick="chekcedInput();">&nbsp;&nbsp;<input type="button" value=" 关 闭 " onclick="window.close();" name="B2"></p>
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
  if (document.cus.money.value==""){ alert("请输入完整数据");document.cus.money.focus();return (false);}
  if (document.cus.de[0].checked){if (document.cus.day.value==""){alert("请输入完整数据");document.cus.day.focus();return (false);}}
  if (document.cus.de[1].checked){if (document.cus.Date1.value==""){alert("请输入完整数据");document.cus.Date1.focus();return (false);}}
   document.cus.action="SaveList.jsp?para=modi&id=<%=id %>&paycode=<%=request.getParameter("code") %>";
   document.cus.submit();
}
</script>
</body>

</html>
