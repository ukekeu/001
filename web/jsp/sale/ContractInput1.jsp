<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>��ͬ������</title>

</head>
<script language="javascript" src="../public_js/public.js">
</script>


<%@ page language="java" import="java.sql.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

 <%

  String  sqlrg="";
//��ȡ�ò������ݵķ�������
  String secno=request.getParameter("secno");
  String loft=request.getParameter("loft");
  String build=request.getParameter("build");
  String room=request.getParameter("roomno");
/*  String roomtype=request.getParameter("roomtype");
  String jzarea=request.getParameter("jzarea");
  String area=request.getParameter("area");
  String sumprice=request.getParameter("sumprice");
  String fitment=request.getParameter("fitment");
  String unitprice=request.getParameter("unitprice");
  String tnunitprice=request.getParameter("tnunitprice");
  String UserUnitPrice=request.getParameter("tnunitprice"); 
 */
   %>      
   
<body >
<%
String SQLLL="select * from ajllgkb order by type,year";
ResultSet Rs=null;
java.text.DecimalFormat df2 = new java.text.DecimalFormat("#######.####"); 
try{
  Rs=ViewBean.executeQuery(SQLLL);
  out.print("<script>");
  
   out.print("var type2=new Array();");
   out.print("var monthtax=new Array();");
   out.print("var yeartax=new Array();");
   out.print("var bxsum=new Array();");
   out.print("var lxsum=new Array();");
   out.print("var dkll=new Array();");
   out.print("var monthout=new Array();");
   out.print("var year1=new Array();");
  int i=0;
   while (Rs.next()){
     out.print("type2["+String.valueOf(i)+"]="+"\""+Rs.getString("type")+"\""+";");
     out.print("year1["+String.valueOf(i)+"]="+"\""+Rs.getString("year")+"\""+";");
	 out.print("monthtax["+String.valueOf(i)+"]="+"\""+df2.format(Rs.getFloat("monthtax"))+"\""+";");
	 out.print("yeartax["+String.valueOf(i)+"]="+"\""+df2.format(Rs.getFloat("yeartax"))+"\""+";");
	 out.print("bxsum["+String.valueOf(i)+"]="+"\""+df2.format(Rs.getFloat("oneinterestsum"))+"\""+";");
	 out.print("lxsum["+String.valueOf(i)+"]="+"\""+df2.format(Rs.getFloat("suminterest"))+"\""+";");
	 out.print("dkll["+String.valueOf(i)+"]="+"\""+df2.format(Rs.getFloat("monthmoney"))+"\""+";");
	 out.print("monthout["+String.valueOf(i)+"]="+"\""+df2.format(Rs.getFloat("monthpay"))+"\""+";");
	i=i+1;
  }	 
}catch(Exception s){}
Rs.close();
out.print("</script>");

 
String ContractSql="select * from order_contract where section='"+request.getParameter("secno")+"'";

try{
  Rs=ViewBean.executeQuery(ContractSql);

  out.print("<script>");
  out.print("var OrderNo=new Array();");
  out.print("var ContractNo=new Array();");
  int iii=0;
   while (Rs.next()){
     out.print("OrderNo["+String.valueOf(iii)+"]="+"\""+getbyte(Rs.getString("SerialNo")).trim()+"\""+";");
	 out.print("ContractNo["+String.valueOf(iii)+"]="+"\""+getbyte(Rs.getString("ContractNo")).trim()+"\""+";");
	 iii++;
      }	 
}catch(Exception s){  out.print(s.getMessage());out.close();}
Rs.close();
out.print("</script>");
 %>
 <script>
 function checkedOrderNoExist(para){
    for (var i=0;i<OrderNo.length;i++){
	    if (para==OrderNo[i]){
		 alert("���Ϲ�/��ͬ����Ѿ�ʹ��");
		 document.cus.rgsno.focus();
		 return false;
		}
	    if (para==ContractNo[i]){
		 alert("���Ϲ�/��ͬ����Ѿ�ʹ��");
		 document.cus.constractno.focus();
		 return false;
		}
	
	}
 
 
 }
 
 </script>
 <script>
 function count(){
   var type1=document.cus.ajtype.options[document.cus.ajtype.selectedIndex].value;
   var year2=document.cus.ajyr.options[document.cus.ajyr.selectedIndex].value;
   if (type1==""||year2==""){alert("��ѡ��������༰����");return;}
  
   for (var j=0;j<type2.length;j++){
      if (type2[j]==type1&&year1[j]==year2){
	   //document.cus.monthtax.value=monthtax[j];
	   //document.cus.yeartax.value=yeartax[j]
	   //document.cus.summoney.value=bxsum[j];
 	  // document.cus.sumtax.value=lxsum[j];
	  // document.cus.tax.value=dkll[j];
	  document.cus.MonthMoney.value=subs1(parseFloat(monthout[j])*parseFloat(document.cus.ajmoney.value)/1000,2);
	  
	   break;
	  }else{
	  // document.cus.monthtax.value="";
	  // document.cus.yeartax.value="";
	   //document.cus.summoney.value="";
 	  // document.cus.sumtax.value="";
	  // document.cus.tax.value="";
	   document.cus.MonthMoney.value="0";
	  }
     
   }
 }
 function count1(){
  document.cus.ajmoney.value=parseInt(parseInt(document.cus.dicprice.value,10)*parseInt(document.cus.ajcs.value,10)/10/1000)*1000;
  document.cus.firstMoney.value=parseInt(document.cus.dicprice.value)-parseInt(document.cus.ajmoney.value);
   count();//document.cus.MonthMoney.value=parseInt(document.cus.MonthMoney.value)*parseInt(document.cus.ajmoney.value)/10000
 }
 </script>

<SCRIPT language=javascript>
   function Validate(aForm)
   {
      if (aForm.constractno.value.length<1)
	    	{
	    	alert("�������ͬ��ţ�");
	        aForm.constractno.focus();
	        return (false);
	    	}	
	  if (aForm.QYDate.value.length<1)
	    	{
	    	alert("������ǩԼ���ڣ�");
	        aForm.QYDate.focus();
	        return (false);
	    	}			
      if (aForm.rgsno.value.length<1)
	    	{
	    	alert("�������Ϲ����ţ�");
	        aForm.rgsno.focus();
	        return (false);
	    	}	
        if (aForm.Date1.value.length<1)
	    	{
	    	alert("�������Ϲ����ڣ�����ͻ�ֱ��ǩԼ���Ϲ����ھ���ǩԼ���ڣ�");
	        aForm.Date1.focus();
	        return (false);
	    	}		 
		
		if (aForm.QYDate.value<aForm.Date1.value)
		{
		    alert("ǩԼ���ڲ���С�����Ϲ�����");
	        aForm.QYDate.focus();
	        return false;
		}
		 if (parseInt(aForm.jzDate.value)<parseInt(aForm.ajDate.value)){
	    alert("����ͻ��ǰ��Ҹ���򰴽����ڲ���С�ڼ�֤����");
	 
	 }	
		if (aForm.roomno.value.length<1)
		{
	            alert("�����뷿��!");
	            aForm.roomno.focus();
	            return false;
		}
		
		if (aForm.area.value.length<1)
		{
	        alert("���������!");
	        aForm.area.focus();
	        return false;
		}
		if (aForm.jzunitprice.value.length<1)
		{
	        alert("�����뵥��!");
	        aForm.jzunitprice.focus();
	        return false;
		}
		if (aForm.pay.value.length<1)
		{
	        alert("��ѡ��ͻ��ĸ��ʽ!");
	        aForm.pay.focus();
	        return false;
		}
		if (aForm.pay.value.length>1){
		   if (aForm.pay.value.indexOf("��")>=0){
		    if (aForm.ajtype.value.length<1){
		      alert("��ѡ��ͻ��Ĵ�������");
			  aForm.ajtype.focus();
			  return false;
			  }
		    if (aForm.MonthMoney.value=="0"){
		      alert("�˺�ͬ�ĸ��ʽ�����а��ң������¹����������δ���ð�������");
			  aForm.MonthMoney.focus();
			  return false;
			  } 
		   }
	   }
	   if (aForm.cusname1.value==""){
	     alert("��ѡ��ͻ�������ͻ�����");
	     aForm.cusname1.focus();
		 return false;
	   }
	    if (aForm.seller.value==""){
	     alert("��ѡ������Ա");
	     aForm.seller.focus();
		 return false;
	   }
	    return (true);
   }
   
   function setfocus()
   {
   		cus.rgsno.focus();
   }
   function charges(){
   check();
   var st=""
   if (document.cus.area.value==""||document.cus.jzunitprice.value==""){
     alert("�����������������");
    cus.area.focus();
	return false;
   }
   else{
      st=document.cus.pay.value;
	  document.cus.dis.value=st.substring(st.indexOf("-")+1,st.lastIndexOf("-"));
	  var char=parseFloat(document.cus.sumprice.value)*parseFloat(st.substring(st.indexOf("-")+1,st.lastIndexOf("-"))/10);
      var  varst=String(char);
	  document.cus.dicprice.value=char;
      document.cus.earnest.value=st.substring(st.lastIndexOf("-")+1,st.indexOf("*"));  
   }
   if (st!=""){document.cus.patylist.disabled=false;}
   else{document.cus.patylist.disabled=true;}
   if (st.indexOf("��")>=0){
   var type1=document.cus.ajtype.options[document.cus.ajtype.selectedIndex].value;
   var year2=document.cus.ajyr.options[document.cus.ajyr.selectedIndex].value;
   if (type1!=""&&year2!=""){
     count();//������˸��ʽ�������¼����¹�
     count1();
    }
   }
   }
   function subs(){
      //���ۼ۽���С��λȡ��
	  var varst=document.cus.dicprice.value;
	  var len=document.cus.xsw.options[document.cus.xsw.selectedIndex].value;
	  var lenstr="0";
	  if (varst.indexOf(".")>0){
         for (var i=1;i<parseInt(len)-1;i++){
		  lenstr+="0";
		 }
		 if (parseInt(len)>1){lenstr="0."+lenstr+"1";}//�����1��С��λ��
		 else{lenstr="0."+"1";}
	     var vars=varst.substring(varst.indexOf(".")+parseInt(len)+1,varst.indexOf(".")+(parseInt(len)+2));//����ʱȡ�����
	     var xsucd=varst.substring(varst.indexOf(".")+1,varst.indexOf(".")+parseInt(len)+1);//��С��λ�󵽱���С��λ������
		 var xsuq=varst.substring(0,varst.indexOf("."));//��С��λǰ������
		 var xsucd1=xsucd;//����ת��
		 var xsulen=varst.substring(0,varst.indexOf(".")+parseInt(len)+1);//�����󳤶�
		 if (parseInt(vars)>4){
		     xsucd=String(parseInt(xsucd)+1);
			 if (xsucd.length>xsucd1.length){
			    xsuq=String(parseInt(xsuq)+1);
				varst=xsuq+"."+xsucd.substring(1,xsucd.length);
				}
              else{varst=xsuq+"."+xsucd;}
         }else{
		    varst=xsulen;
		 }
	 }	 
	 document.cus.dicprice.value=varst;
   }
  function disc(){
   if (document.cus.abcd.value==""){alert("������������ۿ�");cus.abcd.focus();return false;}
      var disnum=document.cus.abcd.value;
	  var discnum="";
	  var num=0;
	  var num1=0;
	  if (document.cus.dis.value!="")
	  {document.cus.dis.value=document.cus.dis.value+"*"+disnum;}
	  else{
	  document.cus.dis.value=disnum;
	  }
	  var arry=new Array(); //
	  if (disnum.indexOf("*")>=0){
	  for (var n=0;n<disnum.length;n++)//�����ۿ۴���
	  {
		    if (disnum.substring(n,n+1).indexOf("*")>=0){
		 arry[num]=disnum.substring(num1,n);
		 num1=n+1;
		 num++;
		}   
		 if (disnum.substring(n+1).indexOf("*")<0)
		 {arry[num]=disnum.substring(n+1);break;}
	  }
	  }else{
	  arry[0]=disnum;
	  }
	  var dicprice=document.cus.dicprice.value;
	 	
	  for (var n1=0;n1<=num;n1++)
	  {

	  dicprice=parseFloat(dicprice,10)*arry[n1]/10;
	  
	  }
	  
	document.cus.dicprice.value=dicprice;
	 
  }
  function check(){
  var pay=document.cus.pay.value;
  var varstr=pay.substring(0,pay.indexOf("-"));
  if (varstr.indexOf("��")>=0){
     document.cus.ajyr.disabled=false;
	 document.cus.ajbk.disabled=false;
	 document.cus.ajtype.disabled=false;
	 document.cus.ajcs.disabled=false;
	 document.cus.firstMoney.disabled=false;
	 document.cus.MonthMoney.disabled=false;
	 varstr=varstr.substring(varstr.indexOf(".")+1,varstr.indexOf("��"));
	 setSelectMad(document.cus.ajcs,varstr.substring(0,varstr.indexOf("��")));
	 setSelectMad(document.cus.ajyr,varstr.substring(varstr.indexOf("��")+1));
     var pay1=pay.substring(pay.indexOf("(")+1,pay.indexOf("."));
	 setSelectMad2(document.cus.ajbk,pay1.substring(0,1));
	 document.cus.ajtype.focus();
	 }
	else{ 
	  document.cus.ajmoney.value="0";
      document.cus.ajyr.disabled=true;
 	  document.cus.ajbk.disabled=true;
	  document.cus.ajtype.disabled=true;
	  document.cus.ajcs.disabled=true;
	  document.cus.firstMoney.disabled=true;
	  document.cus.MonthMoney.disabled=true;
      document.cus.ajyr.value="";
 	  document.cus.ajbk.value="";
	  document.cus.ajtype.value="";
	  document.cus.ajcs.value="";
	  document.cus.firstMoney.value="0"
	  document.cus.MonthMoney.value="0"
	  
   }
}
function FindOption(){

openwin("FindCustomer.jsp?section="+document.cus.section.value+"&FindCus=",400,380,300,100);  //+document.cus.cusname1.value
 }
 
 function show(){
   
  var pay=document.cus.pay.value;
  var dicprice=document.cus.dicprice.value;
  var year1=document.cus.Date1.value;//.options[0].text;
  if (year1==""){alert("��ѡ�����Ϲ�����");return;}
  var ajyr=document.cus.ajyr.options[document.cus.ajyr.selectedIndex].text;
  var ajcs=document.cus.ajcs.options[document.cus.ajcs.selectedIndex].text;
  var ajmoney=document.cus.ajmoney.value;
   if (pay.indexOf("��")>=0){
    if (ajyr==""&&ajcs==""){alert("����ǰ��Ҹ����ѡ�񰴽����ޡ��������С����Ҳ���");return false;}
   }
       openwin("ShowPaytView.jsp?pay="+pay+"&dicprice="+dicprice+"&date1="+year1+"&ajyr="+ajyr+"&ajcs="+ajcs+"&ajmoney="+ajmoney,400,200,200,50);  
  }
 function list(){
    openwin("largess.jsp?list=list",300,300,200,50);  
 }
 function list1(){
    openwin("seleview.jsp?list=list",300,300,200,50);  
 }
 function remo(){
  document.cus.seller.options[document.cus.seller.selectedIndex]=null;
 for (var j=0;j<document.cus.seller.length;j++){
	 if (document.cus.seller.options[j].text!="")
	 document.cus.seller.options[j].selected=true;
	}
}
 function SelectedSeller(){
 for (var j=0;j<document.cus.seller.length;j++){
	 if (document.cus.seller.options[j].text!="")
	 document.cus.seller.options[j].selected=true;
	}
}
 function UnitDepreciate(){
  //����ƽ���׽��ۺ���ܼ�
   var changes= document.cus.oneprice.value;
   var area=document.cus.area.value;
   var sumpri=document.cus.sumprice.value
   if (changes==""){alert("������ƽ���׽��۽����");return false;}
   document.cus.hisumprice.value=parseFloat(document.cus.hisumprice.value)-parseFloat(document.cus.area.value)*parseInt(document.cus.oneprice.value);
 
 }
 function UnitManageChanges(){
   //������һ�����Ѻ���ܼ�
   var para1=document.cus.manageChages.value;
   if (para1==""){alert("������ƽ���׹����");return false;}
   document.cus.hisumprice.value=parseFloat(document.cus.hisumprice.value)-parseFloat(para1)*parseInt(document.cus.area.value)*12;
 }
 
 function ajm(){
   var price="";
   var ajm="";
   var ajcs="";
   if (document.cus.ajcs.options[document.cus.ajcs.selectedIndex].text!=""){
   price=document.cus.dicprice.value;
   price=parseInt(parseFloat(price)/1000*(10-parseInt(document.cus.ajcs.options[document.cus.ajcs.selectedIndex].text))/10)*1000;
   document.cus.ajmoney.value=price;
  }else{ document.cus.ajmoney.value="0";} 
 }
 function chang(){
   var note1=document.cus.note.value;
   
   if (note1=="")
      note1=document.cus.largees.options[document.cus.largees.selectedIndex].text;
   else  	  
    note1=note1+"��"+document.cus.largees.options[document.cus.largees.selectedIndex].text;
    document.cus.note.value=note1;
 }
 function SaveContract(){
   if (Validate(document.cus)){
    // if (document.cus.choose[1].checked){
       document.cus.action="insertdata.jsp";
	   document.cus.submit();
	// }
   }
  }
  function loadForm() {
		
		document.cus.constractno.focus();
	}
</SCRIPT>

<body onload="loadForm();">
<%
String SecNo=request.getParameter("secno");
String Loft=request.getParameter("loft");
String Build=request.getParameter("build");
String RoomNo=request.getParameter("roomno");
String UseArea="";
String SaleArea="";
String SaleUnitPrice="";
String UserUnitPrice="";
String SaleSumPrice="";
String Fitment="";
String RoomType="";
String Room_Type="";

String RoomSql="select UsedArea,Area,Unitprice,TNunitprice,Sumprice,Fitment,RoomType,Room_Type from room";
RoomSql+=" where seccode='"+SecNo+"' and loft='"+Loft+"' and building='";
RoomSql+=Build+"' and room_code='"+RoomNo+"'";
ResultSet rs=null;

try{
  rs=ViewBean.executeQuery(RoomSql);
  if (rs.next())  {
    UseArea=Format.getFloat1(rs.getFloat("UsedArea"),3);
    SaleArea=Format.getFloat1(rs.getFloat("Area"),3);
    SaleUnitPrice=Format.getFloat1(rs.getFloat("Unitprice"),2);
	UserUnitPrice=Format.getFloat1(rs.getFloat("TNunitprice"),2);
	SaleSumPrice=Format.getFloat1(rs.getFloat("Sumprice"),1);
	Fitment=getbyte(rs.getString("Fitment"));
	RoomType=getbyte(rs.getString("RoomType"));
	Room_Type=getbyte(rs.getString("Room_Type"));
  }
  rs.close();

}
catch(Exception s){out.print(s.getMessage());}

 %>
<form method="POST" name="cus" action=""> 
<p align=center><font size=3><b>��ͬ����</b></font></p>
<center>
<!-- &nbsp;<input type=radio name=choose checked ><font class=FontColor>�鿴<input type=radio name=choose title="ѡ�в�ѯ���ۼ�¼" >�޸�</font>-->
<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >        
		<tr>
		  <td width="10%" class=roomright>&nbsp;��ͬ���</td>
          <td width="28%" class=roomright>&nbsp;<input type="text" name="constractno"  size="12"    onblur="checkedOrderNoExist(this.value);" OnChange="if (document.cus.rgsno.value=='')document.cus.rgsno.value=document.cus.constractno.value;toUpper(document.cus.constractno)" onkeydown="key(document.cus.QYDate)" title="ֻ����Ӣ����ĸ�����ּ�"-"���"><font color=red>*</font>��</td>
          <td width="10%" class=roomright>&nbsp;ǩԼ����</td>
          <td width="28%" class=roomright>&nbsp;<INPUT TYPE="text"  NAME=QYDate size=10 readonly title="��ѡ��ǩԼ����"  OnChange="document.cus.Date1.value=document.cus.QYDate.value;" onkeydown="key(document.cus.kkrate)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(QYDate);document.cus.Date1.value=document.cus.QYDate.value;return false;" title="��ѡ���Ϲ�����"><font color=red>*</font></td>
           </tr>
		   <tr>
		    <td width="10%" class=roomright>&nbsp;�˷��ۿ��</td>
          <td width="28%" class=roomright>&nbsp;<input type="text" name="kkrate"  size="10"  value=0.01 Onblur="check(document.cus.kkrate);" onkeydown="key(document.cus.jzDate)" >%<font color=red>*</font>��</td>
          <td width="10%" class=roomright>&nbsp;��֤����</td>
          <td width="28%" class=roomright>&nbsp;<INPUT TYPE="text"  NAME=jzDate size=4 value=30 Onblur="check(document.cus.jzDate);"  onkeydown="key(document.cus.ajDate)">(�������)<font color=red>*</font></td>
           </tr>
		   <tr>
		    <td width="19%" class=roomright>&nbsp;�찴������</td>
          <td width="19%" class=roomright>&nbsp;<input type="text" value="1" name="ajDate" Onblur="check(document.cus.ajDate);"   onkeydown="key(document.cus.rgsno)" size="4"   OnChange="check(document.cus.dicprice)">(�������)��</td>
       
          <td width="10%" class=roomright>&nbsp;�Ϲ����</td>
          <td width="28%" class=roomright>&nbsp;<input type="text" name="rgsno"   size="12"   onblur="checkedOrderNoExist(this.value);" OnChange="toUpper(document.cus.rgsno)" onkeydown="key(document.cus.Date1)" title="ֻ����Ӣ����ĸ�����ּ�"-"���"><font color=red>*</font>��</td>
         </tr><tr>
		  <td width="10%" class=roomright>&nbsp;�Ϲ�����</td>
          <td width="28%" class=roomright>&nbsp;<INPUT TYPE=TEXT NAME=Date1 size=8 readonly title="��ѡ���Ϲ�����" onkeydown="key(document.cus.Date2)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;" title="��ѡ���Ϲ�����">��<font color=red>*</font></td>
 
		    <td width="19%" class=roomright>&nbsp;��¥����</td>
          <td width="19%" class=roomright>&nbsp;<INPUT TYPE=TEXT  NAME=Date2 size=10   readonly value="<%=request.getParameter("jldate") %>" title="��ѡ���Ϲ�����" onkeydown="key(document.cus.pay)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date2);return false;" title="��ѡ���Ϲ�����"><font color=red>*</font></td>
        </tr>
      </table>
<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center>

  <tr>
    <td width="2%" colspan="6" align="center"  bgcolor="#CFE6EB">�� �� �� ��
	  </tr><tr>
    <td width="19%" align=left class=roomright>&nbsp;¥������</td>
    <td width="19%" colspan="2" align=left class=roomright>&nbsp;<input type=text name="sectio" readonly  value="<%=request.getParameter("secname") %>" size="14"  > 
<input type=hidden name="section"  value="<%=request.getParameter("secno") %>" size="25"  > 
��</td>
    <td width="19%" colspan="2" align=left class=roomright>&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
    <td width="19%" class=roomright align=left>&nbsp;<input type=text name="loft" readonly value="<%=request.getParameter("loft") %>"  size="15"  >��</td>
  </tr>
  <tr>
    <td width="19%" align=left class=roomright>&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
    <td width="19%" colspan="2" align=left class=roomright>&nbsp;<input type=text name="build" readonly value="<%=request.getParameter("build") %>"   size="14"   OnChange="toUpper(document.cus.build)"></td>
    <td width="19%" colspan="2" align=left class=roomright>&nbsp;��&nbsp;��&nbsp;��</td>
    <td width="19%" class=roomright align=left>&nbsp;<input type=text name="roomno" readonly value="<%=request.getParameter("roomno") %>"size="15"   OnChange="toUpper(document.cus.roomno)">��</td>
  </tr>
  <tr>
    <td width="19%" align=left class=roomright>&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
    <td width="19%" colspan="2" align=left class=roomright>&nbsp;<input type=text name="fx" readonly value="<%=RoomType %>"  size="14"   OnChange="toUpper(document.cus.roomno)">��</td>
    <td width="19%" colspan="2" align=left class=roomright>&nbsp;�������</td>
    <td width="19%" class=roomright align=left>&nbsp;<input type=text name="jzarea" readonly  value="<%=SaleArea %>"  size="15"  >��</td>
  </tr>
   <tr>
    <td width="19%" align=left class=roomright>&nbsp;�������</td>
    <td width="19%" colspan="2" align=left  class=roomright>&nbsp;<input type=text name="area" readonly value="<%=UseArea%>"  size="14"  >��</td>
    <td width="19%" colspan="2" align=left class=roomright>&nbsp;���ڵ���</td>
    <td width="18%" class=roomright align=left>&nbsp;<input type=text name="tnunitprice" readonly value="<%=UserUnitPrice%>"  size="15"  >��</td>
  </tr>
  <tr>
    <td width="19%" align=left class=roomright>&nbsp;���۵���</td>
    <td width="19%" colspan="2" align=left class=roomright>&nbsp;<input type=text name="jzunitprice"  readonly value="<%=SaleUnitPrice%>"  size="14"  >��</td>
    <td width="19%" colspan="2" align=left class=roomright >&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
    <td width="19%" class=roomright align=left>&nbsp;<input type=text name="sumprice" readonly  value="<%=SaleSumPrice %>"  size="14"  >��</td>
  </tr>
  <tr>
    <td width="19%" align=left class=roomright>&nbsp;װ�ޱ�׼</td>
    <td width="19%" align=left colspan="2"  class=roomright>&nbsp;<input type=text name="zx" readonly value="<%=Fitment %>"  size="14"   >��</td>
    <td width="19%" align=left colspan="2" class=roomright>&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
    <td width="19%" align=left class=roomright>&nbsp;<input type=text name="fl" readonly value="<%=Room_Type%>" size="14"  ></td>
  </tr>
  </table>
  <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >        

 <tr>
    <td width="2%" colspan="6" align="center"  bgcolor="#CFE6EB">��  ��</td>
	  </tr>
	  <tr>
	  <%
      String sql="select * from PayMent";
      ResultSet rs2=ViewBean.executeQuery(sql);
	  String pay="";
	  float dic;
	  float dj1;
	  String num="";
  %>
    <td width="19%" class=roomright>&nbsp;���ʽ</td>
    <td width="19%" colspan="6"  class=roomright>&nbsp;<select name="pay"    OnChange="charges();" style="width : 160" onkeydown="key(document.cus.VisaDate)"> 
<option></option> <%while (rs2.next()){
	    pay=getbyte(rs2.getString("PayName"));
		num=rs2.getString("num");
	    dic=rs2.getFloat("Discont");
		
		String dic1=String.valueOf(dic);
	    out.print("<option value='"+pay+"-"+dic1+"-10000*"+num+"'>"+pay+"*"+num+"*��</option>");
	  }
	  
	    rs2.close();
     %> </select><font color=red>*</font>
	 �ۿ�:<input type=text name=dis size=6  readonly>
	
	 <input type=button name=patylist value="����" onclick="show();" disabled>��</td>
    
  </tr>
  <tr>
    <td width="19%" class=roomright>&nbsp;�����ۿ�</td>
    <td width="19%" colspan="2"  class=roomright>&nbsp;<input type=text name=abcd  size=11 title="�����ʽ��9.8*9.5*9.5"><input type=button name=abc12 value="ȷ��" onclick="disc();" >��</td>
    <td width="19%" class=roomright>&nbsp;��������</td>
    <td width="19%" class=roomright colspan="2"  class=roomright>&nbsp;<select name=ajtype disabled OnChange="count();count1();document.cus.cusname1.focus();"> 
<option></option> 
<option value=0>��ҵ����</option>
<option value=1>����ҵ����</option> </select> ��</td>
  </tr>
  <tr>
    <td width="20%" class=roomright >&nbsp;��������</td>
    <td width="24%" colspan="2"  class=roomright>&nbsp;<select name=ajbk disabled style="width : 100"> 
	  <option value="�й�����">�й�����</option>
	  <option value="��������">��������</option>
	  <option value="��������">��������</option> 
      <option value="ũҵ����">ũҵ����</option> 
    </select>��</td>
    <td width="19%" class=roomright >&nbsp;��������</td>
    <td width="19%" colspan="2"  class=roomright>&nbsp;<select name=ajcs disabled onblur="count1();">
   <option></option>
      <%for (int i=1;i<=10;i++){
		out.print("<option value="+String.valueOf(i)+">"+String.valueOf(i)+"��</option>");
		} %> 
 </select><select name=ajyr disabled OnChange="count();" onblur="count1();"> 
   <option></option>
      <%for (int i=1;i<=30;i++){
		out.print("<option value="+String.valueOf(i)+">"+String.valueOf(i)+"��</option>");
		} %> 
 </select>&nbsp;��</td>
     </tr>
  <tr>
    <td width="19%" class=roomright>&nbsp;��&nbsp;��&nbsp;��</td>

    <td width="19%" class=roomright colspan="2">&nbsp;<input readonly  type=text size=10 value ="0" name=firstMoney  >(Ԫ)��</td>
    <td width="19%" class=roomright>&nbsp;���ҿ�</td>
    <td width="18%" class=roomright colspan="2">&nbsp;<input readonly  type=text size=10 value ="0" name=ajmoney  >(Ԫ)��</td>
   </tr><tr>
    <td width="19%" class=roomright >&nbsp;��&nbsp;��&nbsp;��</td>
    <td width="19%" colspan="2"  class=roomright>&nbsp;<input type=text  value=0 readonly name="MonthMoney"     size="10"  >Ԫ��</td>
    <td width="19%" class=roomright>&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
    <td width="19%" class=roomright colspan="2">&nbsp;<select name="curry" style="width : 40">
  <option value="�����">�����</option>
  <option value="��Ԫ">��Ԫ</option>
  <option value="��Ԫ">��Ԫ</option>
 </select>����:<input type=text name="rate"   value="1"  size="2" value=1.0 >
 
 ����</td>
  </tr>
 
  <tr>
    <td width="20%" class=roomright >&nbsp;��&nbsp;��&nbsp;��</td>
    <td width="24%" colspan="2"  class=roomright>&nbsp;<input type=text readonly name="dicprice" size="8" ><select name="xsw" onchange="subs();" alt="����С��λ" style="width : 32">
<option ></option>
<option value=1>1λ</option>
<option value=2>2λ</option>
<option value=3>3λ</option>
<option value=4>4λ</option>
<option value=5>5λ</option>
</select>
	</td>
    <td width="19%" class=roomright>&nbsp;�Ϲ�����</td>
    <td width="18%" class=roomright colspan="2">&nbsp;<input type=text readonly name="earnest"     size="10"  >��</td>
  </tr>
 
  </table>
  <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >

   <tr>
    <td width="2%"  colspan=8 align="center" bgcolor="#CFE6EB">��   ��    ��     ��</td>
	</tr>
	<tr><input type=hidden name="cusname" >
    <td width="20%" class=roomright >&nbsp;�ͻ�����</td>
    <td width="80%"colspan="6"  class=roomright>&nbsp;<input type=text name="cusname1"   readonly size=30   onkeydown="key(document.cus.carid)"><font color=red>*</font>
<input type=button name=FindB value="����" onclick="FindOption();">
��</td>
</tr> 
	   
  <tr>
    <td width="20%" class=roomright>&nbsp;���֤��</td>
    <td width="80%" class=roomright colspan="6">&nbsp;<input type=text " name="carid"  size=30  readonly onkeydown="key(document.cus.tel)">��</td>
  </tr>
  <tr>
    <td width="20%" class=roomright>&nbsp;��ϵ�绰</td>
    <td width="80%" class=roomright colspan="6" >&nbsp;<input type=text  name="tel"  size=30 readonly  onkeydown="key(document.cus.addr)">��</td>
  </tr>
  <tr>
    <td width="20%" class=roomright >&nbsp;��ϵ��ַ</td>
    <td width="80%" colspan="6"  class=roomright>&nbsp;<input type=text  name="addr"  size=30 readonly onkeydown="key(document.cus.post)">�ʱ�:<input type=text size=6 Onblur="check(document.cus.post);"  maxlength="6" name=post >��</td>
  </tr>
  <tr>
    <td width="20%" class=roomright >&nbsp;�ͻ�����</td>
    <td width="80%" colspan="6"  class=roomright>&nbsp;
	<select name=custype><option value=����>����</option><option value=��ҵ>��ҵ</option></select>
	&nbsp;��¥Ա:&nbsp;<select name="seller"  multiple size=1.5  onblur="SelectedSeller();"> 
 <option selected </option>
 <option ></option>
 <option ></option>
  <option ></option>
 </select><input type=button name=listlar value="<<" onclick="list1();" title="��������Ա"><input type=button name=rem value=">>" onclick="remo();"  title="ɾ������Ա"><font color=red>*</font>

	</td>
  </tr>
<tr>
    <td width="2%" rowspan="1" align="center"  bgcolor="#CFE6EB">��ע</td>
    <td width="26%" colspan="6"  class=roomright>
	 <textarea rows="3" name="note" cols="50"  ></textarea>
	   <%
	    String StrSql="select type,codename from CODE where type='S' order by type";
     ResultSet codeRS=null;
    
    codeRS=ViewBean.executeQuery(StrSql);
   %>   
    <select name=largees OnChange="chang();">
   <%out.print("<option>��ѡ����Ʒ</option>");
   while (codeRS.next()){
     out.print("<option>"+getbyte(codeRS.getString("codename"))+"</option>");
   }
   codeRS.close();
	    %>
	   </select>
	 ���ɽ��:<input type=text size=4 name=demurrage value=0.01>%
	</td>
  
  </tr>
</table>
<p align="center"> 
            <input type=hidden name=saveorder value="insert">
            <input type="button" value="�ᡡ��" name="submit1" onclick="SaveContract();">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="button" value="�� ��" name="reset" onclick="window.close();">
          </P>
     
</center>
</form>
</body>

</html>
