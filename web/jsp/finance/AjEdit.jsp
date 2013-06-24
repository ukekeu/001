<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>

<%@ include file="../public_js/getByteOut.jsp"%>
<%
  String code=request.getParameter("code");
  String ajdate="";
  String ajMoney="";
  String ajbk="";
  String ajtype="0";
  String pjno="";
  String FactMoneyType="";
  String contractno="";
  String sql="select  * from FactAjCharges where id="+code;
  ResultSet rs=null;
  try{
     rs=ViewBean.executeQuery(sql);
	 if (rs.next()){
	     ajMoney=rs.getString("FactMonye");
		 ajdate=getbyte(rs.getString("FactDate"));
		 if (!ajdate.equals(""))ajdate=ajdate.substring(0,10);
		 ajbk=getbyte(rs.getString("ajbk"));
	     ajtype=getbyte(rs.getString("aj_type"));
		 pjno=getbyte(rs.getString("pjno"));
		 FactMoneyType=getbyte(rs.getString("FactMoneyType"));
		 contractno=getbyte(rs.getString("contractno"));
	 }
	 rs.close();
 
  }catch(Exception s){}
 %>
<HTML>
 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/news.css" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>按揭款登记</title>

</head>

 
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>

<SCRIPT language=javascript>
  function steven(){
  if (Validate(document.cus1)){
   
     document.cus1.action="AjInsert.jsp?para=modi&code=<%=code %>";
	 document.cus1.submit();
   }
 }
     function Validate(aForm)
   {

		
	    if (aForm.Date1.value.length<1)
	    	{
	    	alert("请输入日期！");
	        aForm.Date1.focus();
	        return (false);
	    	}		
			 if (aForm.ajtype.value.length<1)
	    	{
	    	alert("请选择按揭类型！");
	        aForm.ajtype.focus();
	        return (false);
	    	}		
			 if (aForm.ajbk.value.length<1)
	    	{
	    	alert("请选择按揭银行！");
	        aForm.ajbk.focus();
	        return (false);
	    	}	
			
			 if (aForm.FactMoneyType.value.length<1)
	    	{
	    	alert("请选择款项属性！");
	        aForm.FactMoneyType.focus();
	        return (false);
	    	}	
		if(isNaN(aForm.FactMoney.value)){
			alert("实收金额必须是数字！");
	        aForm.FactMoney.focus();
	        return (false);
		}
		if (aForm.ajtype.value==0&&aForm.FactMoneyType.value==1){
	     alert("款项属性可能有误");
	     return false;
	
	   }if (aForm.ajtype.value==1&&aForm.FactMoneyType.value==0){
	      alert("款项属性可能有误");
	      return false;
	    }
		if (aForm.cusno.value.length<1){
	    	alert("请先单击应收记录");
	        //aForm.BillNum.focus();
	        return (false);
	    }	
		
		
		if (aForm.Receiver.value.length<1){
	    	alert("请输入收款员！");
	        aForm.Receiver.focus();
	        return (false);
	    }	
	  if (parseInt(document.cus1.FactMoney.value)>parseInt(document.cus1.ajmoney.value)){
	     alert("银行放款不能大于客户的按揭款");
	     document.cus1.FactMoney.focus();
	    return false;
	}
		if (confirm("确认数据正确？"))
	    return (true);
   }
      
    function CurrRa(){
 //汇率转换
   var curryName=document.cus1.curry.options[document.cus1.curry.selectedIndex].text;
   for (var jj=0;jj<RateName.length;jj++)
    {
	  if (RateName[jj]==curryName)
	  {
	   document.cus1.rate.value=RateValue[jj];
	   break;
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
 //setSelectMad(frm.BeginYear,CurrDate.getYear());
 //setSelectMad(frm.BeginMonth,CurrDate.getMonth()+1);
 //setSelectMad(frm.BeginDay,CurrDate.getDate()+1);
 
 

}
// onload="FullD();"
function loadFull(){
  document.cus1.cusno.value=parent.strpara1;
  //document.cus1.Date1.focus();
 setSelectMad(cus1.ajbk,'<%= ajbk%>');
  setSelectMad(cus1.ajtype,'<%= ajtype%>');
  setSelectMad(cus1.FactMoneyType,'<%= FactMoneyType%>');
 
 
}
</SCRIPT>


<body onload="loadFull();" bgcolor="#EBEBEB">

<form method="POST" name="cus1" action="">
<input type=hidden name=room value="<%=getbyte2(request.getParameter("room")) %>">
	
	<p align="center"><b><font size="3" color="#000080">按揭款登记</font></b></p>
	
   <table width="98%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
      <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;到帐日期</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=Date1 size=12 value="<%=ajdate %>"  onkeydown="key(document.cus1.TAXNAME)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;">
		  </td>
      </tr>
           <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;贷款类别</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<select name=ajtype style="width : 115"><option value=0>商业贷款</option><option value=1>公积金</option><option value=2>商业+公积金</option></select>
        </td>
      </tr>
	  <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;按揭款金额</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="FactMoney" size=15 onkeydown="key(document.cus1.BillType)" size="20" style="border-style: solid; border-width: 1" value="<%=ajMoney %>">
        </td>
      </tr>
	  <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;款项属性</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<select name=FactMoneyType style="width : 115"><option></option><option value=0>商业贷款</option><option value=1>公积金</option></select>
        </td>
      </tr>
	    <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;票据号码</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="pjno"   value="<%=pjno %>" onkeydown="key(document.cus1.BillType)" size="15" style="border-style: solid; border-width: 1">
        </td>
      </tr>
	   <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;按揭银行</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<select name=ajbk   style="width : 115">
         <option></option>
		  <%
	 String    StrSql="select type,codename from CODE where type='T' order by type";
    ResultSet codeRS=null;
    
    codeRS=ViewBean.executeQuery(StrSql);
   %>
				  <%
		   while (codeRS.next()){
		   
		     String codename=getbyte(codeRS.getString("codename"));
			 String choose="";
			 if (ajbk.equals(codename))choose=" selected ";
			 out.print("<option value='"+codename+"' "+choose+">"+codename+"</option>");
		   }
		   codeRS.close();
				%>
        </select>
		  
        </td>
      </tr>
      <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;收款员</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name=Receiver size=15  onkeydown="key(document.cus1.Save)" value=<%=(String)session.getAttribute("loginname") %> size="20" style="border-style: solid; border-width: 1">
        </td>
      </tr>
    </table> 
	 <p align="center"> 

             <input type=hidden name=cusno>
			  <input type=hidden name=contractno value="<%=contractno %>">
			  <input type=hidden name=ajmoney>
            <input type="button" value="提　交" name="Save" onclick="steven();">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                      <input type="button" value="取  消" name="close" onclick="window.close();">
          </p> 
</form>     
 
   
       
       
</body>       
</html>       
