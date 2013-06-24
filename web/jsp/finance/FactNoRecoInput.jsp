<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="mBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%
  String billNumber = "" ;
	
  String ysmoney=request.getParameter("ysmoney");
 
  String SecNo=request.getParameter("SecNo");
  String CusNo=request.getParameter("CusNo");
  String FactNo=request.getParameter("FactNo");
  String period=request.getParameter("period");
  String ycurry=request.getParameter("ycurry");
  String yrate=request.getParameter("yrate");
  String signatory=getbyte2(request.getParameter("signatory"));
  String loft=getbyte2(request.getParameter("loft"));
  String FindName=request.getParameter("FindName");

  if (SecNo==null){SecNo="";}
  if (period==null){period="0";}
  if (CusNo==null){CusNo="";}
  if (FindName==null){FindName="";}
try{ 
		ResultSet rsb = mBean.executeQuery( " select max( substring(Bill_Num,"+SecNo.length()+"+1,6) )+1 maxbill from FactGatheringRecord where Bill_Num like '%"+SecNo+"%'" ) ;

		String temp = "1" ;
		
		if( rsb.next() ) {
			temp = getbyte(rsb.getString("maxbill" )) ;
		}
		rsb.close();
		if (temp.equals(""))temp = "1";
		billNumber = temp;
		String aa="";
		for (int ii=1;ii<=(6-billNumber.length());ii++){
		 aa+="0";
		}
		billNumber=aa+billNumber;
		 
	}catch( SQLException exp ) {
		;
	}
%>
<%
 
    String developcom="";//发展商名称
	ResultSet rsb = mBean.executeQuery( " select developcom from CRM_Project where SerialNo='"+SecNo+"'" ) ;
    if( rsb.next() ) {developcom=rsb.getString("developcom");}
	rsb.close();
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
java.text.SimpleDateFormat date =null;
date=new java.text.SimpleDateFormat("yyyy-MM-dd");
String TodayDate=date.format(new java.util.Date()).toString();
int curyear=Integer.parseInt(TodayDate.substring(0,4));
int curmonth=Integer.parseInt(TodayDate.substring(5,7));
int curday=Integer.parseInt(TodayDate.substring(8,10));
 %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/news.css" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>无销售记录收款登记</title>

</head>
 
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>

<SCRIPT language=javascript>
function insertFact(){
    
    if ( Validate(document.cus1) ){
	     document.cus1.action="FactNoRecoInsert.jsp";
	  
        document.cus1.submit();
    }
}
     function Validate(aForm)
   {

		if (aForm.type.value.length<1)
	    	{
	    	alert("请选择款项！");
	        aForm.type.focus();
	        return (false);
	    	}
		
	    if (aForm.Date1.value.length<1)
	    	{
	    	alert("请输入日期！");
	        aForm.Date1.focus();
	        return (false);
	    	}		
		if (aForm.FactMoney.value.length<1)
	    	{
	    	alert("请输入实收金额！");
	        aForm.FactMoney.focus();
	        return (false);
	    	}		
		if(isNaN(aForm.FactMoney.value)){
			alert("实收金额必须是数字！");
	        aForm.FactMoney.focus();
	        return (false);
		}
		if(isNaN(aForm.zj.value)){
			alert("成交金额必须是数字！");
	        aForm.zj.focus();
	        return (false);
		}
	  if (parseFloat(document.cus1.zj.value)<10000){
	  alert("请输入正确的成交金额！");
	        aForm.zj.focus();
	        return (false);
	  
	  }
		
      if (aForm.cus_name.value==""){alert("请输入客户名称");aForm.cus_name.focus();return false;}
		 
		document.cus1.Save.disabled=true;
		//--Add End	
	    return (true);
   }
      
    function CurrRa(){
 //汇率转换
   var curryName=document.cus1.curry.options[document.cus1.curry.selectedIndex].value;
   for (var jj=0;jj<RateName.length;jj++)
    {
	  if (RateName[jj]==curryName)
	  {
	   document.cus1.rate.value=RateValue[jj];
	 
	  }
	}
 
 } 
    function FindOption(){
     var str="";
	 var findroom=document.cus1.FindName.value;
	 
   	 for (var i=0;i<document.cus1.CusNo.length;i++){
       str=document.cus1.CusNo.options[i].text;   
	
       str=str.substring(str.lastIndexOf("*")+1);
    	if (str.indexOf(findroom)>=0){
         setSelectMad(document.cus1.CusNo,document.cus1.CusNo.options[i].value);
   	     break;
       }
	}
  }
function aa(){
var cusno="";
var secno=document.cus1.SecNo.value;
	for (var i=1;i<document.cus1.CusNo.options.length;i++){
      cusno=document.cus1.CusNo.options[i].value;
	  if(secno!=cusno.substring(0,cusno.indexOf("-"))){
	  document.cus1.CusNo.options[i]=null; 
	  aa();
	}
  }
}
 
   
   function charges(){
   	var str="";
	var Period="";
	var FactMoney="";
	for (var i=0;i<document.cus.ShouldPay.length;i++){
	    if(document.cus.ShouldPay.options[i].selected){
			str=document.cus.ShouldPay.options[i].text;
			Period=str.substring(0,str.indexOf("*"));
			FactMoney=str.substring(str.indexOf("*")+1,str.indexOf("**"));
			document.cus.Period.value=Period;
			document.cus.FactMoney.value=FactMoney;
		//	document.frm.UrgeMoney.value=FactMoney;
		}
	}

   }
   
function FullD(){
 CurrDate =new Date();
 
}
 
function loadFull(){
 
  <%    
    if( FactNo != null && ! FactNo.equals( "" ) ) {
  %>
    document.cus1.Period.value = opener.period ;
    document.cus1.FactMoney.value = opener.qianKuan ;
  <%
    }else{
  %>    
    document.cus1.Period.value = parent.period ;
    document.cus1.FactMoney.value = parent.qianKuan ;
  <%
    }
  %>
 
}
function bj(){
 if (parseFloat(document.cus1.FactMoney1.value)<parseFloat(document.cus1.FactMoney.value))
 {
 if (!confirm("实收金额,确认吗?"))
 document.cus1.FactMoney.focus(); 
 }
}//setSelectMad(document.cus1.type,<%=request.getParameter("period") %>);
var kh="<%=signatory %>";
function check1(aa){
   var a1=aa.value;
   if (a1!=""){
   if (isNaN(a1)){
      alert("只能用数字表达");
	  aa.value=0;
	 // aa.focus();
	  return false;
	}
	if (parseFloat(a1)<0){
	 alert("请录入的金额有误，请录入大于0的数据");
	 aa.focus();
	
	} 


	}
	  }  
  
</SCRIPT>

<%
String sectionPara = request.getParameter("section");
String cusSql = "select Bill_Num  from FactGatheringRecord where contractno='" 
                + FactNo + "'";
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
    var c_name = document.forms[ 0 ].BillNum.value ;
     if (c_name!=""){
    for( var p = 0 ; p < nameArr.length ; p ++ ) {
        if( c_name == nameArr[ p ] ) {
           // hasNamePhone = true ;
			alert("票据号重复！请注意检查是否真的错了");
			//document.forms[0].BillNum.focus();
          //  break ;
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

<body onload="document.cus1.FactMoney.focus();  setSelectMad(cus1.type,'<%= period%>');" bgcolor="#EBEBEB">

<form method="POST" name="cus1" action="">
<input type=hidden name=FactMoney1>
<input type=hidden name=FactNo value="<%=FactNo %>">
<input type=hidden name=ysmoney value="<%=ysmoney %>">
<input type=hidden name=CusNo value="<%=CusNo %>">
<input type=hidden name=area value="<%=getbyte2(request.getParameter("area")) %>" >
<input type=hidden name=SecNo value="<%=SecNo %>" >
<input type=hidden name=loft value="<%=loft %>" >
<input type=hidden name=RoomNo value="<%=getbyte2(request.getParameter("RoomNo")) %>" >
<input type=hidden name="period"  value="<%=period%>">
<input type=hidden name=ycurry value="<%=ycurry %>" >
<input type=hidden name=yrate value="<%=yrate %>" >
	<p align="center"><b><font size="3" color="#000080">收款登记</font></b></p>
	
   <table width="100%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
    
	<tr align="left" > 
        <td width="15%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;收款房号</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<%=loft+getbyte2(request.getParameter("RoomNo")) %>
        </td>
      <td width="15%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;建筑面积</td>
        <td width="25%" align="left"  height="14"  > 
         &nbsp;<%=getbyte2(request.getParameter("area")) %> 
 </td>
        
      </tr>
	<tr align="left" >
	<td width="15%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;客户姓名</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<input type=text name="cus_name" size="16" value=""  size="10" style="border-style: solid; border-width: 1" > 

  	  </td> 
        <td width="15%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;联系电话</td>
        <td width="25%" align="left"  height="14"  > 
         &nbsp;<input type=text name="phone" size="16" value=""  size="10" style="border-style: solid; border-width: 1" > 
 </td>
    
       
      </tr>
	<tr align="left" > 
      
     <td width="15%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;证件号</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<input type=text name="zjh" size="16" value=""  size="10" style="border-style: solid; border-width: 1" > 

  	  </td>
        <td width="15%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;成交总价</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<input type=text name="zj" size="16" value="0"  size="10" style="border-style: solid; border-width: 1" > 

  	  </td>
      </tr>
      <tr align="left" > 
        <td width="15%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;款项名称</td>
        <td width="25%" align="left"  height="14"  >&nbsp;<select name=type>
 <option></option>
<option value=1>房款</option>
 <option value=0>定金</option>
 <option value=15>附属房产款</option>
 
<option value=5>花园/露台款</option>

 <option value=6>改装款</option>
  <option value=7>滞纳金</option>
<option value=8>房款差额</option>
 <option value=9>改装款差额</option>
  <option value=10>花园/露台款差额</option>
  
</select> 

          
        </td>
      
        <td width="15%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;实收日期</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=Date1 size=12 value="<%=curyear+"-"+curmonth+"-"+curday  %>"  onkeydown="key(document.cus1.FactMoney)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;">
		  </td>
      </tr>
	  <tr align="left" > 
        <td width="15%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;实收金额</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="FactMoney" size="16" value="0" onblur="check1(document.cus1.FactMoney)" onkeydown="key(document.cus1.curry)" size="10" style="border-style: solid; border-width: 1" ><input type=hidden name=tk value=1 disabled>
        </td>
    
        <td width="15%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;实收币种</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<select name="curry"  OnChange="CurrRa();" onkeydown="key(document.cus1.PayType)">
          <option value="RMB">人民币</option>
          <option value="HKD">港元</option>
          <option value="USD">美元</option>

 </select>&nbsp;汇率:<input type=text name="rate"  value=1.0  size="3"  >
		  </td>
      </tr>
      
      <tr style="border-style: solid; border-width: 1"> 
        <td width="15%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;付款类型 </td>
        <td width="25%"  align="left" height="23" > 
         &nbsp;<select size="1" name="PayType"  onkeydown="key(document.cus1.PayTypeNo)" style="border-style: solid; border-width: 1" style="width : 122">
              <%
	 String    StrSql="select type,codename from CODE where type='U' order by type";
     ResultSet    codeRS=null;
    
    codeRS=ViewBean.executeQuery(StrSql);
   %>
				  <%
		   while (codeRS.next()){
		     String codena=getbyte(codeRS.getString("codename"));
			 out.print("<option value='"+codena+"'>"+codena+"</option>");
		   }
		   codeRS.close();
				%>
          </select>
        </td>
   
	 <input type=hidden name="PayTypeNo"  onkeydown="key(document.cus1.BillType)" style="border-style: solid; border-width: 1">
<!--	  <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;支票编号</td>
        <td width="25%"  align="left" height="23" > 
         &nbsp;
        </td>
      </tr>
-->	  
	 
        <td width="15%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;票据类别</td>
        <td width="25%"  align="left" height="23" > 
         &nbsp;<select size="1" name="BillType" onkeydown="key(document.cus1.BillNum)" style="border-style: solid; border-width: 1">
            <option value="0">收据</option>
            <option value="1">发票</option>
		  </select>&nbsp;单据数:<input type=text name=Num size="3" value=1>
        </td>
      </tr>

    <tr align="left" > 
        <td width="15%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;票据号码</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name=BillNum size="16" onkeydown="key(document.cus1.Receiver)" onblur="checkSJH();" style="border-style: solid; border-width: 1" value="<%=SecNo+billNumber %>">
        </td>
     
        <td width="15%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;收款员</td>
        <td width="25%" align="left"  height="14"  >
		 
          &nbsp;<input type=text name="Receiver" size="14" value="<%=(String)session.getAttribute("loginname") %>">
		  
		 
        </td>
      </tr>
	    
	  
	
	  <tr align="left" > 
        <td width="15%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;备&nbsp;注</td>
        <td width="25%" align="left"  height="14"  colspan="3" > 
          &nbsp;<textarea rows="2" name="context" cols="50"  ></textarea> 
        </td>
      </tr> 
    </table> 
	<!--
		<p align="center"><b><font size="3" color="#000080">凭证登记</font></b></p>
 <table width="100%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
    
      <tr align="left" > 
        <td width="15%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;凭证号:</td>
        <td width="25%" align="left"  height="14"  >&nbsp;<INPUT TYPE=TEXT NAME="voucher_id" size=12 ><font color=red>*</font>
          
        </td>
      
        <td width="15%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;帐套号:</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=company size=12 ><font color=red>*</font>	  </td>
      </tr>
	    <tr align="left" > 
		
        <td width="15%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;借方科目:</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=debit size=12 ><font color=red>*</font></td>
        <td width="15%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;贷方科目:</td>
        <td width="25%" align="left"  height="14"  >&nbsp;<INPUT TYPE=TEXT NAME=credit size=12 ><font color=red>*</font>	
          
        </td>
      
      </tr>
	  </table>
	  <b>说明:此处登记的凭证是以用友U8财务软件为接口</b>
	  -->
	 <p align="center"> 
	        
             <input type=hidden name=cusno >
            <input type="button" value="提　交" name="Save" onclick="insertFact();">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="reset" value="取  消" name="button" onclick="window.close();">
          </p> 
</form>     
 
   
       
       
</body>       
</html>       
