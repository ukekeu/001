<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
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
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>

<%!
public String conv( String str1 ) throws Exception{
	if( str1 == null ){
		return "";
	}
	return new String ( str1.getBytes("ISO8859_1") );
}
%>

<SCRIPT language=javascript>
<!--
   
 function Validate(aForm)
{    
  	
    
    if (aForm.name.value.length<1)
    	{
    	alert("������ͻ�������");
        aForm.name.focus();
        return (false);
    	}	

       if (aForm.yy.value.length<1||aForm.mm.value.length<1||aForm.dd.value.length<1)
    	{
    	alert("�������Ա�������£�");
        aForm.yy.focus();
        return (false);
    	}	
      return (true);
}

function addsex(){
 var sexs=document.cus.sex.value;
 var arry1=sexs.split("/");//ת��Ϊarry;
 var cusname=document.cus.name.value;
 var arry2=cusname.split("/");//ת��Ϊarry;
 if (sexs!="")
 if (arry1.length==arry2.length){alert("���������Ա��������,ϵͳ�����ܶ��ڵ��Ա�");return false;}
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
String cusSql = "select cus_name , phone from customer where section='" 
                + sectionPara + "'";
ResultSet cusRs=null;
try {
    cusRs=ViewBean.executeQuery(cusSql);
}catch(Exception s)
{
}
java.util.Vector vctName = new java.util.Vector() ;
java.util.Vector vctPhone = new java.util.Vector() ;
while ( cusRs.next()){
    String cus_name = cusRs.getString( 1 ) ;
    String cus_phone = cusRs.getString( 2 ) ;
    vctName.addElement( cus_name ) ;
    vctPhone.addElement( cus_phone ) ;
    
}
cusRs.close(); 
%>

<script lang=javascript>
    nameArr = new Array() ;
    phoneArr = new Array() ;
</script>

<%
for( int p = 0 ; p < vctName.size() ; p ++ ) {
    %>
    <script lang=javascript>
        nameArr[ <%= p%> ] = "<%= conv( vctName.get( p ).toString() ) %>"
    </script>
    <%
}
%>

<%
for( int p = 0 ; p < vctPhone.size() ; p ++ ) {
    %>
    <script lang=javascript>
        phoneArr[ <%= p%> ] = "<%= conv( vctPhone.get( p ).toString() ) %>"
    </script>
    <%
}
%>

<% //String sql="select * from VIPCUSTOMER where  code="+request.getParameter("cusno");
 //out.print(sql);

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
   
   
   String sql="select *,year(cs_date) yy,month(cs_date) mm,day(cs_date) dd  from VIPCUSTOMER where  code="+request.getParameter("cusno");
     codeRS=ViewBean.executeQuery(sql);
	 String cusname="",sex="",yy="",mm="",dd="",sr="";
	 String carid="",hy="",wh="",dw="",zy="",rs="",mail="";
	 String ah="",tc="",jl="",of_tel="",ho_tel="",zipcode="";
	 String company="",fax="",sj="",no="",wy_addr="",ho_addr="";
	 if (codeRS.next()){
	   cusname=getbyte(codeRS.getString("cus_name"));
	   sex=getbyte(codeRS.getString("sex"));
	   carid=getbyte(codeRS.getString("sfzh"));
	   hy=getbyte(codeRS.getString("hy"));
	   of_tel=getbyte(codeRS.getString("of_tel"));
	   ho_tel=getbyte(codeRS.getString("ho_tel"));
	   sj=getbyte(codeRS.getString("sj"));
	   fax=getbyte(codeRS.getString("fax"));
	   wh=getbyte(codeRS.getString("wenhua"));
	   ah=getbyte(codeRS.getString("ah"));
	   tc=getbyte(codeRS.getString("tc"));
	   
	   jl=getbyte(codeRS.getString("jl"));
	   company=getbyte(codeRS.getString("company"));
	   
	   zy=getbyte(codeRS.getString("job"));
	   sr=getbyte(codeRS.getString("sr"));
	   rs=getbyte(codeRS.getString("ho_ren"));
	   
	   mail=getbyte(codeRS.getString("mail"));
	   ho_addr=getbyte(codeRS.getString("ho_addr"));
	   no=getbyte(codeRS.getString("con_no"));
	   
	   
	     wy_addr=getbyte(codeRS.getString("wy_addr"));
	   zipcode=getbyte(codeRS.getString("zipcode"));
	   
	   
	   yy=getbyte(codeRS.getString("yy"));
	   mm=getbyte(codeRS.getString("mm"));
	   dd=getbyte(codeRS.getString("dd"));
	   
	   
	 }
	    codeRS.close();
 %>
<script>
function full(){
 setSelectMad(document.cus.sex,'<%=sex %>');
 setSelectMad(document.cus.wh,'<%=wh %>');
 setSelectMad(document.cus.marriage,'<%=hy %>');
  setSelectMad(document.cus.sr,'<%=sr %>');
  setSelectMad(document.cus.zy,'<%=zy %>');
 
}

</script>
<body onload="setfocus(); full();" topmargin="1" >

<form method="POST" name="cus" action=""> 
 
<table BORDER=0 width="100%"> ��
  <tr  align="center"> <td  height="24">&nbsp;"�����"��������</td>
   </tr>
</table>
 <table BORDER=0 width="100%"  CELLSPACING=1 CELLPADDING=3 ALIGN=center>
 ��
  <tr > <td width="25%" class=roomleft  align="left" height="24">&nbsp;����</td>
  <td width="25%" colspan=3  class=roomright  align="left" height="24">&nbsp;<input type=text    name=name size="30"  value="<%=cusname %>" onkeydown="key(document.cus.name2)"  ><font color=red>*</font></td> 
</tr>
  <tr > 
 <td width="25%" align="left"class=roomleft  height="24">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
 <td class=roomright colspan=3  width="25%" align="left"   height="24"> 

&nbsp;<select  name="sex"  onkeydown="key(document.cus.sex2)"> 
<option selected value="��">��</option> <option value="Ů">Ů</option></select>&nbsp;</td></tr>

 <tr align="left" > 
 <td width="25%" align="left"class=roomleft  height="14">&nbsp;���֤��</td>
 <td class=roomright  colspan=3 width="25%" align="left"   height="14"> 
 &nbsp;<input type="text"    name="cardid" size="30"  onblur="countAge();" value="<%=carid %>" onkeydown="key(document.cus.tel)"  >
</td>

</td>

</tr>

<tr align="left" > 

<td width="25%" align="left"class=roomleft  height="24">&nbsp;��������</td>
<td width="25%" class=roomright align="left"   height="24">&nbsp;<input type=text size=5  value="<%=yy %>"   name=yy size="18"  maxlength=4 > ��<input type=text size=5  value="<%=mm %>"   maxlength=2 name=mm size="18"  >��<input type=text maxlength=2 size=5 value="<%=dd %>"     name=dd size="18"  >��
<input type=hidden    name=age size="18"  > 
<input type=hidden    name=code size="18"  value="<%=request.getParameter("cusno") %>" > 
</td>
</tr>

<tr align="left" > 
 <td width="25%"class=roomleft  align="left" height="23"> &nbsp;����״��</td><td class=roomright  width="25%"   align="left" height="23"> &nbsp;<select  name="marriage" style="width:117" >
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("HY"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 

</tr>

<tr align="left" >
  <td width="25%" align="left"class=roomleft  height="24">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td><td class=roomright width="25%" align="left"   height="24"> 
&nbsp;<select size="1" name="wh" style="width:117" onkeydown="key(document.cus.job)"><option></option> 
<%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("M"))
	       out.print("<option value='"+CodeName[ii]+"'> "+CodeName[ii]+"</option>");
		  }
       }
  %> 
</select> </td></tr>


<tr align="left" > 
<td width="25%" align="left"class=roomleft  height="24" > &nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;λ</td><td class=roomright width="50%" align="left"   height="24" colspan="3">&nbsp;<input type=text    name=company size="30" onkeydown="key(document.cus.mail)"  value="<%=company %>"> 
 
</td>
</tr>
<tr align="left" > 
<td width="25%" align="left"class=roomleft  height="24" > &nbsp;ְ&nbsp;&nbsp;&nbsp;&nbsp;λ</td><td class=roomright width="50%" align="left"   height="24" colspan="3">&nbsp;<select  name="zy" style="width:117" >
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("B"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 
</td>
</tr>
 <tr align="left" > <td width="25%" align="left"class=roomleft  height="24">&nbsp;��ͥ����</td>
<td class=roomright width="25%" align="left"   height="24">&nbsp;<input type=text    name=personnum size="10" value=3 onkeydown="key(document.cus.homejg)"  > 
</td>
��
</tr>
<tr align="left" > 
<td width="25%" align="left"class=roomleft  height="24">&nbsp;��&nbsp;��&nbsp;��</td><td class=roomright width="25%" align="left"   height="24"> 
&nbsp;<select size="1" name="sr" style="width:117">
 <option value=""></option>
 <option value="1000~2000">1000~2000</option> 
 <option value="2001~3000">2001~3000</option>
  <option value="3001~5000">3001~5000</option>
  <option value="5001~8000">5001~8000</option>
   <option value="8001~12000">8001~12000</option>
    <option value="20001~����">20001~����</option>
 </td></tr>

 <tr align="left" > <td width="25%" align="left"class=roomleft  height="24">&nbsp;���˰���</td>
<td class=roomright width="25%" align="left"   height="24" colspan="3">&nbsp;<% int xh=0;
  for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("AH")){
	     %><input type=checkbox name=ah  value="<%=CodeName[ii] %>" <%if (ah.indexOf(CodeName[ii])>=0)out.print("checked"); %>><%=CodeName[ii] %>
		 <%xh++;}
		  }
       }
 %>
</td>
</tr>

 <tr align="left" >
<td width="25%" align="left"class=roomleft  height="24" >&nbsp;�����س�</td><td class=roomright width="25%" align="left" colspan="3"  height="24"><%   xh=0;
  for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("TC")){
	     %>
		  <input type=checkbox name=tc   value="<%=CodeName[ii] %>" <%if (tc.indexOf(CodeName[ii])>=0)out.print("checked"); %>><%=CodeName[ii] %>
		 <%xh++;}
		  }
       }
 %></td></tr>

 <tr align="left" > <td width="25%" align="left"class=roomleft  height="24">&nbsp;ר������</td>
<td class=roomright width="25%" align="left"   height="24" colspan="3">&nbsp;<textarea cols="30" rows="3" name=jl><%=jl %></textarea>
 
</td>
 </tr>
 <tr align="left" > 
<td width="25%" align="left"class=roomleft  height="14"> &nbsp;��ͥ�绰</td>
<td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<input type=text    name=ho_tel size="18" title="����绰�������/�ָ�" value="<%=ho_tel %>" onkeydown="key(document.cus.sj)"  >
</td>
</tr>
<tr align="left" > 
<td width="25%"class=roomleft  align="left" height="23">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td><td class=roomright width="25%"   align="left" height="23"> 
 &nbsp;<input type=text    name=sj size="18" value="<%=sj %>"  onblur="checkSJ()" onkeydown="key(document.cus.company)" > </td>

</tr> 

<tr align="left" > 
<td width="25%" align="left"class=roomleft  height="14"> &nbsp;�칫�绰</td>
<td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<input type=text    name=of_tel size="18" title="����绰�������/�ָ�" value="<%=of_tel %>" onkeydown="key(document.cus.sj)"  >
</td>
</tr>
<tr align="left" > 
<td width="25%"class=roomleft  align="left" height="23">&nbsp;�������</td><td class=roomright width="25%"   align="left" height="23"> 
 &nbsp;<input type=text    name=fax size="18" value="<%=fax %>"  onblur="checkSJ()" onkeydown="key(document.cus.company)" > </td>

</tr> 
<tr align="left" > <td width="25%" align="left"class=roomleft  height="14">&nbsp;EMAIL</td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<input type=text    name=mail size="18" onkeydown="key(document.cus.pos)"  value="<%=mail %>" > 
</td>
</tr>
<tr align="left" > 
<td width="25%"class=roomleft  align="left" height="23"> &nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td><td class=roomright width="25%"   align="left" height="23"> &nbsp;<input type=text    name=pos size="18" onkeydown="key(document.cus.addr)" value="<%=zipcode %>"></td>
</tr> 

<tr>
 <td width="25%"class=roomleft  align="left" height="23">&nbsp;��ϵ��ַ</td><td class=roomright width="25%"   align="left" height="23" colspan=3> 
 &nbsp;<input type=text    name=ho_addr size="33"  onkeydown="key(document.cus.visitname)"  value="<%=ho_addr %>"> </td>
</tr> 
<tr>
 <td width="25%"class=roomleft  align="left" height="23">&nbsp;������ͬ���</td><td class=roomright width="25%"   align="left" height="23" colspan=3> 
 &nbsp;<input type=text    name=con_no size="33"  onkeydown="key(document.cus.visitname)"  value="<%=no %>"> </td>
</tr> 
<tr>
 <td width="25%"class=roomleft  align="left" height="23">&nbsp;��ҵ��ַ</td><td class=roomright width="25%"   align="left" height="23" colspan=3> 
 &nbsp;<input type=text    name=wyaddr size="33"  onkeydown="key(document.cus.visitname)"  value="<%=wy_addr %>"> </td>
</tr> 
	</table>
	     

 
</table>  
<input type=hidden name="SaveCus" value="insert">
<p align="center"> 
<%@ include file="../public_js/qx_checke.jsp"%>
<%
//Ȩ�����
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"C005");
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
	
    
    for( var p = 0 ; p < nameArr.length ; p ++ ) {
        if( c_name == nameArr[ p ] && c_phone == phoneArr[ p ] ) {
            hasNamePhone = true ;
            break ;
        }
    }
    return hasNamePhone ;
}
 

function loca() {
    if ( Validate( document.cus ) ) {  
        document.cus.action ="modiCUS.jsp";
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
