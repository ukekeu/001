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
<title>���ҿ�Ǽ�</title>

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
	    	alert("���������ڣ�");
	        aForm.Date1.focus();
	        return (false);
	    	}		
			 if (aForm.ajtype.value.length<1)
	    	{
	    	alert("��ѡ�񰴽����ͣ�");
	        aForm.ajtype.focus();
	        return (false);
	    	}		
			 if (aForm.ajbk.value.length<1)
	    	{
	    	alert("��ѡ�񰴽����У�");
	        aForm.ajbk.focus();
	        return (false);
	    	}	
			
			 if (aForm.FactMoneyType.value.length<1)
	    	{
	    	alert("��ѡ��������ԣ�");
	        aForm.FactMoneyType.focus();
	        return (false);
	    	}	
		if(isNaN(aForm.FactMoney.value)){
			alert("ʵ�ս����������֣�");
	        aForm.FactMoney.focus();
	        return (false);
		}
		if (aForm.ajtype.value==0&&aForm.FactMoneyType.value==1){
	     alert("�������Կ�������");
	     return false;
	
	   }if (aForm.ajtype.value==1&&aForm.FactMoneyType.value==0){
	      alert("�������Կ�������");
	      return false;
	    }
		if (aForm.cusno.value.length<1){
	    	alert("���ȵ���Ӧ�ռ�¼");
	        //aForm.BillNum.focus();
	        return (false);
	    }	
		
		
		if (aForm.Receiver.value.length<1){
	    	alert("�������տ�Ա��");
	        aForm.Receiver.focus();
	        return (false);
	    }	
	  if (parseInt(document.cus1.FactMoney.value)>parseInt(document.cus1.ajmoney.value)){
	     alert("���зſ�ܴ��ڿͻ��İ��ҿ�");
	     document.cus1.FactMoney.focus();
	    return false;
	}
		if (confirm("ȷ��������ȷ��"))
	    return (true);
   }
      
    function CurrRa(){
 //����ת��
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
	
	<p align="center"><b><font size="3" color="#000080">���ҿ�Ǽ�</font></b></p>
	
   <table width="98%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
      <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;��������</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=Date1 size=12 value="<%=ajdate %>"  onkeydown="key(document.cus1.TAXNAME)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;">
		  </td>
      </tr>
           <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;�������</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<select name=ajtype style="width : 115"><option value=0>��ҵ����</option><option value=1>������</option><option value=2>��ҵ+������</option></select>
        </td>
      </tr>
	  <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;���ҿ���</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="FactMoney" size=15 onkeydown="key(document.cus1.BillType)" size="20" style="border-style: solid; border-width: 1" value="<%=ajMoney %>">
        </td>
      </tr>
	  <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;��������</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<select name=FactMoneyType style="width : 115"><option></option><option value=0>��ҵ����</option><option value=1>������</option></select>
        </td>
      </tr>
	    <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;Ʊ�ݺ���</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name="pjno"   value="<%=pjno %>" onkeydown="key(document.cus1.BillType)" size="15" style="border-style: solid; border-width: 1">
        </td>
      </tr>
	   <tr align="left" > 
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;��������</td>
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
        <td width="25%" align="left"  height="14" bgcolor="#EBEBEB">&nbsp;�տ�Ա</td>
        <td width="25%" align="left"  height="14"  > 
          &nbsp;<input type=text name=Receiver size=15  onkeydown="key(document.cus1.Save)" value=<%=(String)session.getAttribute("loginname") %> size="20" style="border-style: solid; border-width: 1">
        </td>
      </tr>
    </table> 
	 <p align="center"> 

             <input type=hidden name=cusno>
			  <input type=hidden name=contractno value="<%=contractno %>">
			  <input type=hidden name=ajmoney>
            <input type="button" value="�ᡡ��" name="Save" onclick="steven();">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                      <input type="button" value="ȡ  ��" name="close" onclick="window.close();">
          </p> 
</form>     
 
   
       
       
</body>       
</html>       
