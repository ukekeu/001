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
 
    String developcom="";//��չ������
	ResultSet rsb = mBean.executeQuery( " select developcom from CRM_Project where SerialNo='"+SecNo+"'" ) ;
    if( rsb.next() ) {developcom=rsb.getString("developcom");}
	rsb.close();
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
<title>�˿�Ǽ�</title>

</head>
 
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>

<SCRIPT language=javascript>
function insertFact(){
    
    if ( Validate(document.cus1) ){
	  if (parseFloat(document.cus1.FactMoney.value)>0)
        document.cus1.action="FactGatherInsert.jsp";
	  else 
	      document.cus1.action="tk.jsp";
		  document.cus1.Save.disabled=true;
        document.cus1.submit();
    }
}
     function Validate(aForm)
   {

		if (aForm.type.value.length<1)
	    	{
	    	alert("��ѡ����");
	        aForm.type.focus();
	        return (false);
	    	}
		
	    if (aForm.Date1.value.length<1)
	    	{
	    	alert("���������ڣ�");
	        aForm.Date1.focus();
	        return (false);
	    	}		
		if (aForm.FactMoney.value.length<1)
	    	{
	    	alert("������ʵ�ս�");
	        aForm.FactMoney.focus();
	        return (false);
	    	}		
		if(isNaN(aForm.FactMoney.value)){
			alert("ʵ�ս����������֣�");
	        aForm.FactMoney.focus();
	        return (false);
		}
		
      if (aForm.signatory.value==""){alert("������ͻ�����");return false;}
		 
		
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
 if (!confirm("ʵ�ս��,ȷ����?"))
 document.cus1.FactMoney.focus(); 
 }
}//setSelectMad(document.cus1.type,<%=request.getParameter("period") %>);
var kh="<%=signatory %>";
function check1(aa){
   var a1=aa.value;
   if (a1!=""){
   if (isNaN(a1)){
      alert("ֻ�������ֱ��");
	  aa.value=0;
	 // aa.focus();
	  return false;
	}
	if (parseFloat(a1)<0){
	   document.cus1.signatory.value="<%=developcom %>";

	  
	
	}else{
	alert("��¼�븺�Ľ��");
	aa.focus();
	}
	}
	}  
  
</SCRIPT>


<body onload="document.cus1.type.focus();setSelectMad(cus1.type,'<%= period%>');" bgcolor="#EBEBEB">

<form method="POST" name="cus1" action="">
<input type=hidden name=FactMoney1>
<input type=hidden name=FactNo value="<%=FactNo %>">
<input type=hidden name=ysmoney value="<%=ysmoney %>">
<input type=hidden name=CusNo value="<%=CusNo %>">

<input type=hidden name=loft value="<%=loft %>" >
<input type=hidden name="period"  value="<%=period%>">
<input type=hidden name=ycurry value="<%=ycurry %>" >
<input type=hidden name=yrate value="<%=yrate %>" >
	<p align="center"><b><font size="3" color="#000080">�˿�Ǽ�</font></b></p>
	
   <table width="100%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
    
      <tr align="left" > 
        <td width="15%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;��������</td>
        <td width="25%" align="left"  height="14"  >&nbsp;<select name=type>
 <option>��ѡ���˿����</option>
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
      
        <td width="15%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;�˿�����</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=Date1 size=12 value="<%=curyear+"-"+curmonth+"-"+curday  %>"  onkeydown="key(document.cus1.FactMoney)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;">
		  </td>
      </tr>
	  <tr align="left" > 
        <td width="15%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;�˿���</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="FactMoney" size=16 value="-<%=ysmoney %>" onblur="check1(document.cus1.FactMoney)" onkeydown="key(document.cus1.curry)" size="10" style="border-style: solid; border-width: 1" ><input type=hidden name=tk value=1 checked >
        </td>
    
        <td width="15%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;�˿����</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<select name="curry"  OnChange="CurrRa();" onkeydown="key(document.cus1.PayType)">
          <option value="RMB">�����</option>
          <option value="HKD">��Ԫ</option>
          <option value="USD">��Ԫ</option>

 </select>&nbsp;����:<input type=text name="rate"  value=1.0  size="3"  >
		  </td>
      </tr>
      
      <tr style="border-style: solid; border-width: 1"> 
        <td width="15%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;�˿ʽ</td>
        <td width="25%"  align="left" height="23" > 
         &nbsp;<select size="1" name="PayType"  onkeydown="key(document.cus1.PayTypeNo)" style="width : 122" style="border-style: solid; border-width: 1">
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
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;֧Ʊ���</td>
        <td width="25%"  align="left" height="23" > 
         &nbsp;
        </td>
      </tr>
-->	  
	 
        <td width="15%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;Ʊ�����</td>
        <td width="25%"  align="left" height="23" > 
         &nbsp;<select size="1" name="BillType" onkeydown="key(document.cus1.BillNum)" style="border-style: solid; border-width: 1">
            <option value="0">�վ�</option>
            <option value="1">��Ʊ</option>
		  </select>&nbsp;������:<input type=text name=Num size="3" value=1>
        </td>
      </tr>

    <tr align="left" > 
        <td width="15%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;Ʊ�ݺ���</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name=BillNum size="16" onkeydown="key(document.cus1.Receiver)"  style="border-style: solid; border-width: 1" value="<%=SecNo+billNumber %>">
        </td>
     
        <td width="15%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;����Ա</td>
        <td width="25%" align="left"  height="14"  >
		 
          &nbsp;<input type=text size="14" name="Receiver" value="<%=(String)session.getAttribute("loginname") %>">
		  
		 
        </td>
      </tr>
	   <tr align="left" > 
        <td width="15%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;�˿����</td>
        <td width="25%" align="left"  colspan="3" height="14"  > 
          &nbsp;<input type=text name=signatory  size=51 value="<%=developcom %>" readonly>
		  </td>
     
     
      </tr>
	  
	
	  <tr align="left" > 
        <td width="15%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;��&nbsp;ע</td>
        <td width="25%" align="left"  height="14"  colspan="3" > 
          &nbsp;<textarea rows="2" name="context" cols="50"  ></textarea> 
        </td>
      </tr> 
    </table> 
	<!--
		<p align="center"><b><font size="3" color="#000080">ƾ֤�Ǽ�</font></b></p>
 <table width="100%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
    
      <tr align="left" > 
        <td width="15%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;ƾ֤��:</td>
        <td width="25%" align="left"  height="14"  >&nbsp;<INPUT TYPE=TEXT NAME="voucher_id" size=12 ><font color=red>*</font>
          
        </td>
      
        <td width="15%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;���׺�:</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=company size=12 ><font color=red>*</font>	  </td>
      </tr>
	    <tr align="left" > 
		
        <td width="15%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;�跽��Ŀ:</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=debit size=12 ><font color=red>*</font></td>
        <td width="15%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;������Ŀ:</td>
        <td width="25%" align="left"  height="14"  >&nbsp;<INPUT TYPE=TEXT NAME=credit size=12 ><font color=red>*</font>	
          
        </td>
      
      </tr>
	  </table>
	  <b>˵��:�˴��Ǽǵ�ƾ֤��������U8�������Ϊ�ӿ�</b>
	  -->
	 <p align="center"> 
	        
             <input type=hidden name=cusno >
            <input type="button" value="�ᡡ��" name="Save" onclick="insertFact();">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="reset" value="ȡ  ��" name="button" onclick="window.close();">
          </p> 
</form>     
 
   
       
       
</body>       
</html>       
