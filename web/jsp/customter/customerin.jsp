<%@ page contentType="text/html;charset=GBK" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<!--<link rel=stylesheet href="../class/mad.css" >-->
<title>�Ǽǿͻ�����</title>
</head>
 <script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script Language="JavaScript" src="../public_js/basal.js"></script>
<%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
  <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>

 
<%
  String cusname=request.getParameter("cusname");
  String carid=request.getParameter("carid");
  String tel=request.getParameter("tel");
  String sj=request.getParameter("sj");
  String inaddr=request.getParameter("addr");
  String CusType=request.getParameter("CusType");

  if (cusname==null)cusname="";
  if (tel==null)tel="";
  if (carid==null)carid="";
   if (sj==null)sj="";
    if (inaddr==null)inaddr="";
 %>
<SCRIPT language=javascript>
<!--
   
 function Validate(aForm)
{    
    if (aForm.section.options[aForm.section.selectedIndex].text=="")
    	{
    	alert("��ѡ��¥�̣�");
        aForm.section.focus();
        return (false);
    	}	
    
    if (aForm.name.value.length<1)
    	{
    	alert("������ͻ�������");
        aForm.name.focus();
        return (false);
    	}	

      
     if (aForm.Date1){
    if (aForm.Date1.value.length==0)
    {
        alert("��ѡ����������");
        aForm.Date1.focus();
        return false;
    } 
   } 
   
  
    if (aForm.pos.value.length>0&aForm.pos.value.length!=6)
    {
        alert("������������");
        aForm.pos.focus();
        return false;
    }
    return (true);
}

function addsex(){
 var sexs=document.cus.sex.value;
 var arry1=sexs.split("/");//ת��Ϊarry;
 var cusname=document.cus.name.value;
 var arry2=cusname.split("/");//ת��Ϊarry;
 if (sexs!="")
 if (arry1.length==arry2.length){alert("���������Ա��������,ϵͳ�����ܶ�����Ա�");return false;}
 if (sexs=="")
     document.cus.sex.value=document.cus.sex1.value;
else
  document.cus.sex.value+="/"+document.cus.sex1.value;
 

}
var arry=new Array(); 
 var num1=0;
 var num=0;
function checkSJ(){
  var aa=document.cus.sj.value;
  var arry=aa.split("/");//ת��Ϊarry
	if (aa!=""){
	  for (var jj=0;jj<arry.length;jj++){
	     if (!isNaN(arry[jj])){
		    if (arry[jj].length!=11&&arry[jj].length!=12){
			  alert( "�������ͻ��ֻ�������! ") ;
		      document.forms[ 0 ].sj.focus() ;
		      return false ;
			}
			 if (arry[jj].length==12&&arry[jj].substring(0,1)!="0"){
			   alert( "�������ͻ��ֻ�������! " ) ;
		       document.forms[ 0 ].sj.focus() ;
		       return false ;
			 }
		}else{
		      alert( "�������ͻ��ֻ�������! " ) ;
		       document.forms[ 0 ].sj.focus() ;
		       return false ;
		}
		}	
	
	}

}
 
function countAge(){

  var cardidS=document.cus.cardid.value;
  var cardidSS=cardidS;
  var currDat=new Date();  
  var year=currDat.getYear();
  document.cus.age.value="";

  var ages="";
  if (cardidS!=""){	
   var arry=cardidS.split("/");//ת��Ϊarry
	for (var jj=0;jj<arry.length;jj++){
	  if (!isNaN(arry[jj])){
		  if (ages=="")
		   { 
		    if (arry[jj].length==18)
		       ages=String(parseInt(year)-parseInt(arry[jj].substring(6,10)));
		    else if (arry[jj].length==15)
		       ages=String(parseInt(year)-parseInt("19"+arry[jj].substring(6,8)));
			else{ alert("��Щ���֤��λ������,ϵͳֻ������ȷ���������");document.cus.cardid.focus(); } 
		   }
		  else
		    {
			if (arry[jj].length==18)
		       ages+="/"+String(parseInt(year)-parseInt(arry[jj].substring(6,10)));
		    else if (arry[jj].length==15)
		       ages+="/"+String(parseInt(year)-parseInt("19"+arry[jj].substring(6,8)));
			else {alert("��Щ���֤��λ������,ϵͳֻ������ȷ���������");     document.cus.cardid.focus();}
			}
			
		}else if (arry[jj].length==18) {
		   if (ages=="")
		       ages=String(parseInt(year)-parseInt(arry[jj].substring(6,10)));
		  else
		       ages+="/"+String(parseInt(year)-parseInt(arry[jj].substring(6,10)));
		 }
	 }
  }
  document.cus.age.value=ages;
}
function setfocus()
{
	document.cus.name.focus();
}
//-->
  

</script>
<script language="javascript" src="../public_js/public.js">
</script>
<%
String sectionPara = request.getParameter("section");
String cusSql = "select cus_name , phone,sj from customer where section='" 
                + sectionPara + "'";
ResultSet cusRs=null;
 


try {
    cusRs=ViewBean.executeQuery(cusSql);
}catch(Exception s)
{
}
java.util.Vector vctName = new java.util.Vector() ;
java.util.Vector vctPhone = new java.util.Vector() ;
java.util.Vector vctSj = new java.util.Vector() ;
while ( cusRs.next()){
    String cus_name = getbyte(cusRs.getString( 1 ) ) ;
	 
    String cus_phone =getbyte(cusRs.getString( 2 ) ) ;
	  String cus_sj = getbyte(cusRs.getString( 3 ) );
     vctName.addElement( cus_name ) ;
    vctPhone.addElement( cus_phone ) ;
    vctSj.addElement( cus_sj ) ;
}
cusRs.close(); 
%>

<script lang=javascript>
    nameArr = new Array() ;
    phoneArr = new Array() ;
	   sjArr = new Array() ;
</script>

<%
for( int p = 0 ; p < vctName.size() ; p ++ ) {
    %>
    <script lang=javascript>
	
        nameArr[ <%= p%> ] = "<%= vctName.get( p ).toString() %>";
    </script>
    <%
}
%>

<%
for( int p = 0 ; p < vctPhone.size() ; p ++ ) {
    %>
    <script lang=javascript>
        phoneArr[ <%= p%> ] = "<%=  vctPhone.get( p ).toString() %>"
    </script>
    <%
}
%>

<%
for( int p = 0 ; p < vctSj.size() ; p ++ ) {
    %>
    <script lang=javascript>
        sjArr[ <%= p%> ] = "<%=  vctSj.get( p ).toString() %>"
    </script>
    <%
}
%>
<body onload="setfocus();" oncontextmenu="return false"  >
<p align=center><font size=3 color=#215CAA><b>�Ǽǿͻ�����</b></font></p>
<%

 String StrSql="select type,codename from CODE WHERE CHILD=0 order by type";
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
   
    String job=(String)session.getAttribute("job");	
	String user=(String)session.getAttribute("loginname");	
 %>
<form method="POST" name="cus" action="">  
   <input type=hidden name=CusType value="<%=CusType %>">
 <table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif">��<img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>��������</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"><font color="#FF6600">&nbsp; </font></td>
</tr>
</table>	
 <table BORDER=0 width="100%"  CELLSPACING=1 CELLPADDING=3 ALIGN=center>
 
<tr> 
<%@ include file="../public_js/CheckSection.jsp"%>
<%
	if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
      String sql="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";
	  ResultSet rs2=ViewBean.executeQuery(sql);
	  String sec="";
	  String no="";
  %> <td class=roomleft width="25%"> &nbsp;¥&nbsp;&nbsp;&nbsp;&nbsp;��</td><td  class=roomright width="25%"> 
 &nbsp;<select name="section" style="width:117"> 
<%
while (rs2.next()){
	   no=rs2.getString("SerialNo");
	  
	   sec=getbyte(rs2.getString("Name"));
	    if (sectionPara.equals(no))
     	  out.print("<option value='"+no+"' selected>"+sec+"</option>");
		else
		   out.print("<option value='"+no+"'>"+sec+"</option>");
		
	  }
	    rs2.close();
     %> </select><font color=red>*</font> </td>
	  <%
	 
  %> <td class=roomleft width="34%">&nbsp;��������</td><td class=roomright width="66%"> 
&nbsp;<select name="Region" style="width:140"> 
<% for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("K"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
     %> </select> </td></tr>  
  <tr > <td width="25%" class=roomleft  align="left" height="24">&nbsp;�ͻ�����</td>
  <td width="25%"   class=roomright  align="left" height="24">&nbsp;<input type=text    name=name size="15"  value="<%=cusname %>" onchange="checkName();" onkeydown="key(document.cus.grade)"  ><font color=red>*</font>
   <td width="25%" class=roomleft  align="left" height="24">
  &nbsp;���ἶ��</td>
  <td width="25%"   class=roomright  align="left" height="24">&nbsp;<select size="1"  style="width:140"  name="grade" onkeydown="key(document.cus.sex)"  >   
<option></option> 
    <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("grade"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %> 
      </select></td> 
</tr>
  <tr > 
 <td width="25%" align="left"class=roomleft  height="24">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
 <td class=roomright   width="25%" align="left"   height="24"> 

&nbsp;<input type=text    name=sex size="6"  onkeydown="key(document.cus.cardid)"  ><select  name="sex1"  onkeydown="key(document.cus.sex2)"> 
<option selected value="��">��</option> <option value="Ů">Ů</option></select><input title="���ӿͻ��Ա�" type=button name=addsexs  onclick="addsex();" value=">>" >&nbsp;</td>
<td width="25%" align="left"class=roomleft  height="24">&nbsp;�ι۷�ʽ</td>
<td width="25%" class=roomright align="left"   height="24">&nbsp;<select name="visitstate" style="width:140" onkeydown="key(document.cus.tel)"><option  value="0">����</option><option  value="1">����</option> 
</td> 

</tr>

 <tr align="left" > 
 <td width="25%" align="left"class=roomleft  height="14">&nbsp;֤&nbsp;��&nbsp;��</td>
 <td class=roomright  colspan=3 width="25%" align="left"   height="14"> 
 &nbsp;<input type="text"    name="cardid" size="58"  onblur="countAge();" value="<%=carid %>" onkeydown="key(document.cus.agefw)"  >
</td>

</td>

</tr>

 
 
<input type=hidden    name=age size="18"  > 


 
<tr align="left" > 
<td width="25%" align="left"class=roomleft  height="14"> &nbsp;��ϵ�绰</td>
<td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<input type=text    name=tel size="18" title="����绰�������/�ָ�" value="<%=tel %>" onblur="checkphone();" onkeydown="key(document.cus.sj)"  >
</td>
<td width="25%"class=roomleft  align="left" height="23">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td><td class=roomright width="25%"   align="left" height="23"> 
 &nbsp;<input type=text    name=sj size="18" value="<%=sj %>"  onblur="checkSj();checkSJ();" onkeydown="key(document.cus.company)" > </td>

</tr> 
<tr align="left" > 
<td width="25%" align="left"class=roomleft  height="24" > &nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;λ</td><td class=roomright width="50%" align="left"   height="24" colspan="3">&nbsp;<input type=text    name=company size="58" onkeydown="key(document.cus.mail)"  > 
</td>
</tr>
<tr align="left" > <td width="25%" align="left"class=roomleft  height="14">&nbsp;EMAIL</td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<input type=text    name=mail size="18" onkeydown="key(document.cus.pos)"  > 
</td>
<td width="25%"class=roomleft  align="left" height="23"> &nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td><td class=roomright width="25%"   align="left" height="23"> &nbsp;<input type=text    name=pos size="18" onkeydown="key(document.cus.addr)"></td>
</tr> 

<tr>
 <td width="25%"class=roomleft  align="left" height="23">&nbsp;��ϵ��ַ</td><td class=roomright width="25%"   align="left" height="23" colspan=3> 
 &nbsp;<input type=text    name=addr size="58"  onkeydown="key(document.cus.Date1)"  value="<%=inaddr %>"> </td>
</tr>
  <%if (request.getParameter("addnew")==null){ %>
<tr align="left" >
<%  java.util.Date curDate=new java.util.Date();
	int CurYear=curDate.getYear()+1900;
	int CurMonth=curDate.getMonth()+1;
	int CurDay=curDate.getDate();
	String CDate=CurYear+"-"+CurMonth+"-"+CurDay;
%>
 <td width="25%" align="left" class=roomleft  height="14">&nbsp;��������</td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<input type=text  value="<%=CDate %>"   name=Date1 size=12 onkeydown="key(document.cus.seller)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false">
</td><td width="25%" align="left"class=roomleft  height="24"> &nbsp;��&nbsp;��&nbsp;Ա</td><td class=roomright width="25%" align="left"   height="24"> 
 &nbsp;<select size="1" name="seller" onkeydown="key(document.cus.demand)"  style="width:135" >
   <option value=""></option>
<%String sell="select  seller from seller where section_no ='"+sectionPara+"'";
rs2=ViewBean.executeQuery(sell);
  while (rs2.next()){
	   String Name=getbyte(rs2.getString("seller"));
	   String choosename="";
	   if (job.indexOf("����Ա")>=0){if (user.equals(Name)){choosename="selected";}}
       out.print("<option value='  "+Name+"' "+choosename+" >"+Name+"</option>") ;
	}
  rs2.close();
  %>
	  
</select> </td>
	  </tr> 
	  <tr><td class=roomleft>�� ע</td><td colspan="3" class=roomright><textarea cols="57"  name=info_fk rows="4"></textarea></td></tr>
	</table>
	   
 <table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif">��<img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>���鷴��</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"><font color="#FF6600"> &nbsp;</font></td>
</tr>
</table>	
 <table BORDER=0 width="100%"  CELLSPACING=1 CELLPADDING=3 ALIGN=center>
	 
  <%
  String SQL="select * from CustomerDc where TYPE=0 AND sectionno='"+sectionPara+"'";
  rs2=ViewBean.executeQuery(SQL);	
  int iii=0;
   while (rs2.next()){
     iii++;
   %>
 <tr align="center">
    <td width="5%"  class=roomleft ><%=iii %></td>
    <td width="15%" class=roomleft align="left">&nbsp;<%=rs2.getString("codeName") %></td>
	<td width="65%" align="left" class=roomright>
	<%
	 SQL="select  CodeValue,code from CustomerDcValue where dcCode="+rs2.getString("code");
	 
	 ResultSet rs1=ViewBean1.executeQuery(SQL);	
    while (rs1.next()){
	    String codcename=rs1.getString("CodeValue");
		String code=rs1.getString("code");
	     %> 
		   <input name="codcename<%=code %>" type="checkbox" value="<%=code %>"  ><%=codcename %> 
		 <% 
       }
	rs1.close();
	 %>
	
	</td>
	 
  </tr>
  <%}
  rs2.close(); %>
 </table> 

<%} %>

<input type=hidden name="SaveCus" value="insert">
<p align="center"> 
<%@ include file="../public_js/qx_checke.jsp"%>
<%
//Ȩ�����
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"C002");
    if (Cortrol==null){Cortrol="";}
    if (Cortrol.indexOf("A")>=0){ %>
   
           <input type=button name="submit1" value="�ᡡ��" onclick="loca();">
           &nbsp;&nbsp;
		   <%} %>
		   <input type=button name=cancel value="�ˡ���" onclick="window.close()">

          </P>
	</center>	  
</form>
<script>

function has_name_phone()
{
    var hasNamePhone = false ;
    var c_name = document.forms[ 0 ].name.value ;
    var c_phone = document.forms[ 0 ].tel.value ;
	var c_sj = document.forms[ 0 ].sj.value ;
    
    for( var p = 0 ; p < nameArr.length ; p ++ ) {
        if( (c_name == nameArr[ p ] && c_phone == phoneArr[ p ] )||(c_name == nameArr[ p ] && c_sj == sjArr[ p ])) {
            hasNamePhone = true ;
            break ;
        }
    }
    return hasNamePhone ;
}

function checkName()
{


    var hasNamePhone = false ;
    var c_name = document.forms[ 0 ].name.value ;
    if (c_name!=""){
    for( var p = 0 ; p < nameArr.length ; p ++ ) {
        if( c_name == nameArr[ p ] ) {
           // hasNamePhone = true ;
			alert("�����ظ�����ȷ���Ƿ���¼��˿ͻ��ļ�¼");
			document.forms[0].name.focus();
            break ;
        }
    }
	}
	 
    return hasNamePhone ;
}	

function checkSj()
{


    var hasNamePhone = false ;
    var c_name = document.forms[ 0 ].sj.value ;
    if (c_name!=""){
    for( var p = 0 ; p < sjArr.length ; p ++ ) {
        if( c_name == sjArr[ p ] ) {
           // hasNamePhone = true ;
			alert("�ֻ����ظ�����ȷ���Ƿ���¼��˿ͻ��ļ�¼");
			document.forms[0].sj.focus();
            break ;
        }
    }
	 }
    return hasNamePhone ;
}	

function checkphone()
{


    var hasNamePhone = false ;
    var c_name = document.forms[ 0 ].tel.value ;
     if (c_name!=""){
    for( var p = 0 ; p < phoneArr.length ; p ++ ) {
        if( c_name == phoneArr[ p ] ) {
           // hasNamePhone = true ;
			alert("�绰���ظ�����ȷ���Ƿ���¼��˿ͻ��ļ�¼");
			document.forms[0].tel.focus();
            break ;
        }
    }
	}
	 
    return hasNamePhone ;
}	
function loca() {
    if ( Validate( document.cus ) ) {  
      
        
        document.cus.action ="InsertCusData.jsp<%if (request.getParameter("addnew")!=null){ %>?addnew=addnew<%} %>";
        document.cus.submit();
    }
}
var atten="";
function choose(para){
   atten=para.value;
   
}
function choose1(para){
if (atten!=""){
   if (confirm("�Ѿ�ѡ����һ�����Ƿ�Ҫ��ѡ��"))para.value=para.value+","+atten;
}

}
 <%
    if (!carid.equals("")) out.print("countAge("+carid+")");
   %>
</script>


</body>       
</html>       
