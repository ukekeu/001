<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
<%
  String No=request.getParameter("no");
  String CusNo=getbyte2(request.getParameter("CusNo"));
  String contractno=request.getParameter("contractno");
  String rowID = request.getParameter( "rowID" ) ;
  String oldcurry=getbyte2(request.getParameter("oldcurry"));//ԭʵ����ұ�
  String oldrate=request.getParameter("oldrate");
  String oldmoney=request.getParameter("oldmoney"); 
  String ht_rate=request.getParameter("ht_rate"); //Ӧ����ұ�
  if (No==null){No="";}
  if (CusNo==null){CusNo="";}

%>
<%
//���ɱ����������

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
String SQL="select *  from FactGatheringRecord where id = " + rowID ;

ResultSet Rs=null;
String FactDate="";
String FactMoney="";
String FactCurr="";
String FactRate="";
String FactPay="";
String FactNo="";
String FactBill="";
String FactBillNo="";
String Person="";
String CONTEXT="";
String Period="";
try{
  Rs=ViewBean.executeQuery(SQL);
  if (Rs.next()){
    Period=Rs.getString("Period");
    FactDate=Rs.getString("Gather_Date");
	if (!FactDate.equals(""))FactDate=FactDate.substring(0,10);
	FactMoney=Rs.getString("factmoney");
	FactBillNo=getbyte(Rs.getString("Bill_Num"));
	Person=getbyte(Rs.getString("Receiver"));
	FactBill=getbyte(Rs.getString("BillType"));
	FactCurr=getbyte(Rs.getString("CurrName"));
	FactRate=Rs.getString("CurrRate");
	FactPay=getbyte(Rs.getString("PayType"));
	FactNo=getbyte(Rs.getString("PayTypeNo"));
        CONTEXT =getbyte(Rs.getString("CONTEXT"));
   }
   Rs.close();
  }catch(Exception s){}

 %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/news.css" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>�޸��տ�</title>

</head>

<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>

<SCRIPT language=javascript>
function modidata( ) {
    if ( Validate( document.cus1 ) ){
	    if (parseFloat(document.cus1.FactMoney.value)>0)
         document.cus1.action="CheckMoney.jsp?para=modi";
		else
		  document.cus1.action="CheckMoney1.jsp?para=modi";
        document.cus1.submit();
    }
}
     function Validate(aForm)
   {

		
	    if (aForm.Date1.value.length<1)
	    	{
	    	alert("���������ڣ�");
	        aForm.Date1.focus();
	        return (false);
	    	}		
		if(isNaN(aForm.FactMoney.value)){
			alert("ʵ�ս����������֣�");
	        aForm.FactMoney.focus();
	        return (false);
		}
		
				
		 
		//--Add End	
	    return (true);
   }
      
    function CurrRa(){
 //����ת��
   var curryName=document.cus1.curry.options[document.cus1.curry.selectedIndex].value;
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
 
}
// onload="FullD();"

function Full(){
  setSelectMad(document.cus1.BillType,"<%=FactBill %>");
  setSelectMad(document.cus1.PayType,"<%=FactPay %>");
  document.cus1.Receiver.value="<%=Person %>";

  setSelectMad(document.cus1.curry,"<%=FactCurr %>");
  <%if (Period.equals("1")||Period.equals("2")||Period.equals("3")||Period.equals("4"))Period="1"; %>
  setSelectMad(document.cus1.type,"<%=Period %>");
  
  document.cus1.Date1.focus();

}

</SCRIPT>


<body onload="Full();">

<form method="POST" name="cus1" action="">
 <input type=hidden name=contractno value="<%= contractno %>" >
 <input type=hidden name=rowID value="<%= rowID%>" >
 <input type=hidden name=CusNo value="<%=CusNo %>">
 <input type=hidden name=oldcurry value="<%=oldcurry %>">
 <input type=hidden name=oldrate value="<%=oldrate %>"> 
 <input type=hidden name=oldmoney value="<%=oldmoney %>"> 
 <input type=hidden name=ht_rate value="<%=ht_rate %>"> 
  <input type=hidden name=room value="<%=getbyte2(request.getParameter("room")) %>"> 
 
	<p align="center"><b><font size="3" color="#000080">�޸��տ�</font></b></p>
	
   <table width="98%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
      <tr align="left" > 
        <td width="15%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;��������</td>
        <td width="25%" align="left"  height="14"  >&nbsp;<select name=type>
 <option></option>
<option value=1>����</option>

 <option value=0>����</option>
  <option value=15>����������</option>
  <option value=5>��԰/¶̨��</option>
 <option value=6>��װ��</option>
   <option value=7>���ɽ�</option>
<option value=8>������</option>
 <option value=9>��װ����</option>
  <option value=10>��԰/¶̨����</option>
 

</select> 

          
        </td>
      
      <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;ʵ������</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=Date1 size=12 value="<%=FactDate%>"  onkeydown="key(document.cus1.FactMoney)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;">
		  </td>
      </tr>
	  <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;ʵ�ս��</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="FactMoney" value="<%=FactMoney %>" onkeydown="key(document.cus1.curry)" size="20" style="border-style: solid; border-width: 1">
        </td>
      </tr>
	  <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;ʵ�ձ���</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<select name="curry"  OnChange="CurrRa();" onkeydown="key(document.cus1.PayType)">
          <option value="RMB">�����</option>
          <option value="HKD">��Ԫ</option>
          <option value="USD">��Ԫ</option>

 </select>����:<input type=text name="rate"  value="<%=FactRate%>"  size="5"  >
		  </td>
      </tr>
      
      <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;�������� </td>
        <td width="25%"  align="left" height="23" > 
         &nbsp;<select size="1" name="PayType"  onkeydown="key(document.cus1.PayTypeNo)" style="border-style: solid; border-width: 1">
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
		
      </tr>
	<input type=hidden name="PayTypeNo" value="<%=FactNo %>"  onkeydown="key(document.cus1.BillType)" style="border-style: solid; border-width: 1">
<!--	  <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;֧Ʊ���</td>
        <td width="25%"  align="left" height="23" > 
         &nbsp;
        </td>
      </tr>-->
	  <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;Ʊ�����</td>
        <td width="25%"  align="left" height="23" > 
         &nbsp;<select size="1" name="BillType" onkeydown="key(document.cus1.BillNum)" style="border-style: solid; border-width: 1">
            <option value="0">�վ�</option>
            <option value="1">��Ʊ</option>
          </select>
        </td>
      </tr>
	     <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;Ʊ�ݺ���</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name=BillNum size="20" value="<%=FactBillNo %>" onkeydown="key(document.cus1.Receiver)" value="" style="border-style: solid; border-width: 1">
        </td>
      </tr>
 
	  <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;�տ�Ա</td>
        <td width="25%" align="left"  height="14"  > 
        &nbsp;<input type=text name="Receiver" value="<%=(String)session.getAttribute("loginname") %>">
		 	 
		  
		  </select> 
        </td>
      </tr>
	   <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;�տע</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<textarea rows="3" name="context" cols="30"  ><%=CONTEXT%></textarea> 
        </td>
      </tr>
    </table> 
	 <div align="center"> 
	        
            <input type="button" value="�ᡡ��" name="Save" onclick="modidata();">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="button" value="��  ��" name="guang" onclick="javascript:window.close()" >
          </div> 
</form>     
 
   
       
       
</body>       
</html>       
