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

      
    
    if (aForm.Date1.value.length==0)
    {
        alert("��ѡ����������");
        aForm.Date1.focus();
        return false;
    }    
   
    if (aForm.pos.value.length>0&aForm.pos.value.length!=6)
    {
        alert("������������");
        aForm.pos.focus();
        return false;
    }
    return (true);
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

<body onload="setfocus();" >
<p align=center><font size=3 color=#215CAA><b>�Ǽǿͻ�����</b></font></p>
<%

 String StrSql="select type,codename from CODE order by type";
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
 %>
<form method="POST" name="cus" action=""> 
 <div id="tj2" style="position:absolute; left:195px; top:340px; width:30px; height:30px; z-index:1; visibility: hidden"> 
<select  name="tj1" multiple size=10 onchange="sele(document.cus.tj,document.cus.tj1,'tj2',sh3);">
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("E"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 
</div>
 <div id="xq" style="position:absolute; left:195px; top:270px; width:30px; height:30px; z-index:1; visibility: hidden"> 
<select  name="xq1" multiple size=10 onchange="sele(document.cus.demand,document.cus.xq1,'xq',sh3);choose1(document.cus.demand);" >
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("A"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 
</div>
<div id="gz" style="position:absolute; left:380px; top:350px; width:30px; height:30px; z-index:1; visibility: hidden"> 
<select  name="gz1" multiple size=10 onchange="sele(document.cus.attention,document.cus.gz1,'gz',sh3);choose1(document.cus.attention);">
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("F"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 
</div>
 <div id="jt2" style="position:absolute; left:380px; top:320px; width:30px; height:30px; z-index:1; visibility: hidden"> 
<select  name="jt1" multiple size=10 onchange="sele(document.cus.payment,document.cus.jt1,'jt2',sh3);">
  <option >���Ҹ���</option>
   <option >���ڸ���</option>
   <option >һ���Ը���</option>
 </select> 
</div>
<div id="job2" style="position:absolute; left:195px; top:330px; width:30px; height:30px; z-index:1; visibility: hidden"> 
<select  name="job1" multiple size=10 onchange="sele(document.cus.job,document.cus.job1,'job2',sh3);" >
  <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("G"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 
</div>
<div id="gmyt2" style="position:absolute; left:380px; top:390px; width:30px; height:30px; z-index:1; visibility: hidden"> 
<select  name="gmyt1" multiple size=10 onchange="sele(document.cus.gmyt,document.cus.gmyt1,'gmyt2',sh3);" >
   <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("I"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 
</div>
<div id="homejg2" style="position:absolute; left:380px; top:350px; width:30px; height:30px; z-index:1; visibility: hidden"> 
<select  name="homejg1" multiple size=10 onchange="sele(document.cus.homejg,document.cus.homejg1,'homejg2',sh3);">
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("J"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 
</div>
<center>

 <table BORDER=0 width="100%"  CELLSPACING=1 CELLPADDING=3 ALIGN=center>
<tr > 
<td colspan=4 align=center class=TITLE><b>��&nbsp;��&nbsp;��&nbsp;��</b></td></tr>
<tr> 
<%@ include file="../public_js/CheckSection.jsp"%>
<%
	if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
      String sql="select SerialNo,Name FROM crm_project where SerialNo in("+SectionS+")";
	  ResultSet rs2=ViewBean.executeQuery(sql);
	  String sec="";
	  String no="";
  %> <td class=roomleft width="25%"> &nbsp;¥&nbsp;&nbsp;&nbsp;&nbsp;��</td><td  class=roomright width="25%"> 
 &nbsp;<select name="section" style="width:117"> 
<%
while (rs2.next()){
	   no=rs2.getString("SerialNo");
	   
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no+"'>"+sec+"</option>");
	  }
	    rs2.close();
     %> </select><font color=red>*</font> </td>
	  <%
	 
  %> <td class=roomleft width="34%">&nbsp;��������</td><td class=roomright width="66%"> 
&nbsp;<select name="Region" style="width:117"> 
<% for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("K"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
     %> </select> </td></tr>  
  <tr > <td width="25%" class=roomleft  align="left" height="24">&nbsp;�ͻ�����</td><td width="25%" class=roomright  align="left" height="24"> &nbsp;<input type=text    name=name size="15"  onkeydown="key(document.cus.age)"  ><font color=red>*</font></td> 
 <td width="25%" align="left"class=roomleft  height="24">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td><td class=roomright width="25%" align="left"   height="24"> 

&nbsp;<input type=text    name=in2 size="10"  onkeydown="key(document.cus.name2)"  ><select  name="sex1"  onkeydown="key(document.cus.sex2)"> 
<option selected value="��">��</option> <option value="Ů">Ů</option></select><input title="���ӿͻ��Ա�" type=button name=addsexs  onclick="addsex();" value=">>" >&nbsp;</td></tr>
</td></tr>
 <tr align="left" > 
<td width="25%" align="left"class=roomleft  height="24">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td><td width="25%" class=roomright align="left"   height="24">&nbsp;<input type=text    name=age size="15" onkeydown="key(document.cus.company)"  > 
</td>
<td width="25%" align="left"class=roomleft  height="14">&nbsp;���֤��</td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<input type="text"    name="cardid" size="15" onkeydown="key(document.cus.bbj)"  > 
</td>
</tr>
<tr align="left" > 
<td width="25%" align="left"class=roomleft  height="14"> &nbsp;��ϵ�绰</td>
<td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<input type=text    name=tel size="15"  onkeydown="key(document.cus.cardid)"  >
</td>
<td width="25%"class=roomleft  align="left" height="23">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td><td class=roomright width="25%"   align="left" height="23"> 
 &nbsp;<input type=text    name=sj size="15"  onkeydown="key(document.cus.mail)" > </td>

</tr> 
<tr align="left" > <td width="25%" align="left"class=roomleft  height="14">&nbsp;BB&nbsp;&nbsp;&nbsp; ��</td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<input type=text    name=bbj size="15" onkeydown="key(document.cus.sj)"  > 
</td>
<td width="25%" align="left"class=roomleft  height="24">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;λ</td><td class=roomright width="25%" align="left"   height="24">&nbsp;<input type=text    name=company size="15" onkeydown="key(document.cus.tel)"  > 
</td>
</tr>

<tr align="left" > <td width="25%" align="left"class=roomleft  height="14">&nbsp;EMAIL</td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<input type=text    name=mail size="15" onkeydown="key(document.cus.ContactPerson)"  > 
</td>
<td width="25%"class=roomleft  align="left" height="23"> &nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td><td class=roomright width="25%"   align="left" height="23"> &nbsp;<input type=text    name=pos size="15" onkeydown="key(document.cus.chishu)"></td>
</tr> 

<tr>
 <td width="25%"class=roomleft  align="left" height="23">&nbsp;��ϵ��ַ</td><td class=roomright width="25%"   align="left" height="23" colspan=3> 
 &nbsp;<input type=text    name=addr size="33"  onkeydown="key(document.cus.visitname)" > </td>
</tr>

<tr align="left" >
 <td width="25%" align="left"class=roomleft  height="14">&nbsp;��������</td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<input type=text    NAME=Date1 size=12 onkeydown="key(document.cus.seller)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false"><font color=red>*</font>
</td><td width="25%" align="left"class=roomleft  height="24"> &nbsp;��&nbsp;��&nbsp;Ա</td><td class=roomright width="25%" align="left"   height="24"> 
 &nbsp;<select size="1" name="seller" onkeydown="key(document.cus.tj)"  style="width:117" > <%
	  sql="select * from CortrolMan";
	  ResultSet rs=ViewBean.executeQuery(sql);

	  while(rs.next()){        
	  String seller=getbyte(rs.getString("name"));
	  %> <option  value="<%=seller%>"><%=seller%></option> <%}        
	  rs.close(); %></select> </td>
	  </tr>
	  <tr> 
<td colspan=4 align=center class=TITLE><b>��&nbsp;��&nbsp;��&nbsp;��</b></td></tr>
 <tr align="left" > 
<td width="25%" align="left"class=roomleft  height="14"> &nbsp;������</td>
<td class=roomright width="25%" align="left"   height="14"> 
  &nbsp;<input type="text"    size="12" name="demand" onkeydown="key(document.cus.attention)" ><input type=button name=butt3 value=".." onclick="choose(document.cus.demand);shList('xq');">
        </td>
 <td width="25%" align="left"class=roomleft  height="14"> &nbsp;���򸶿�</td><td class=roomright width="25%" align="left"   height="14"> 
  &nbsp;<input type=text     size="10" name="payment"  onkeydown="key(document.cus.demand)" ><input type=button name=butt2 value=".." onclick="shList('jt2');"> </td></tr> 
   <tr align="left" > 
 <td width="25%" align="left"class=roomleft  height="14"> &nbsp;��ע����</td>
        <td class=roomright width="25%" align="left"   height="14"> 
  &nbsp;<input type=text     size="10" name="attention"  onkeydown="key(document.cus.personnum)" ><input type=button name=butt4 value=".." onclick="choose(document.cus.attention);shList('gz');"></td>
   <td width="25%" align="left"class=roomleft  height="24">&nbsp;�������</td>
<td class=roomright width="25%" align="left"   height="24">

&nbsp;<select size="1" name="yixiangmianji" onkeydown="key(document.cus.wh)">   
<option></option> 
    <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("O"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %> 
      </select><font size=2>ƽ����</font>
</td>
  </tr> 



 <tr> 
<td colspan=4 align=center class=TITLE>&nbsp;<b>��&nbsp;��&nbsp;��&nbsp;��</b></td></tr>
 <tr align="left" > <td width="25%" align="left"class=roomleft  height="24">&nbsp;��ͥ����</td>
<td class=roomright width="25%" align="left"   height="24">&nbsp;<input type=text    name=personnum size="10" onkeydown="key(document.cus.homejg)"  > 
</td>
 <td width="25%" align="left"class=roomleft  height="24">&nbsp;��ͥ�ṹ</td>
<td class=roomright width="25%" align="left"   height="24">
  &nbsp;<input type=text   size="10" name="homejg" onkeydown="key(document.cus.nowjuarea)" ><input type=button name=butt5 value=".." onclick="shList('homejg2');">

</td></tr>

<tr align="left" >
 <td width="25%" align="left"class=roomleft  height="24">&nbsp;�־����</td>
<td class=roomright width="25%" align="left"   height="24">

&nbsp;<select size="1" name="nowjuarea" onkeydown="key(document.cus.wh)">   
      <option></option>
      <option>50����</option>
       <option>50-80</option>
      <option>80-100</option>
      <option>100-110</option>

      <option>110-150</option>
      <option>150����</option>
      </select><font size=2>ƽ����</font>
</td> <td width="25%" align="left"class=roomleft  height="24">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td><td class=roomright width="25%" align="left"   height="24"> 
&nbsp;<select size="1" name="wh" onkeydown="key(document.cus.job)"><option></option> 
<%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("M"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %> 
</select> </td></tr> <tr align="left" > <td width="25%" align="left"class=roomleft  height="24"> &nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;ҵ</td><td class=roomright width="25%" align="left"   height="24"> 
&nbsp;<input type=text    size="10" name="job" onkeydown="key(document.cus.custype)" ><input type=button name=butt6 value=".." onclick="shList('job2');"></td>
<td width="25%" align="left"class=roomleft  height="24">&nbsp;��&nbsp;��&nbsp;��</td><td class=roomright width="25%" align="left"   height="24"> 
&nbsp;<select size="1" name="jtsr"> <option></option><option>5-10</option> <option>10-15</option> <option>15-25</option> 
<option>25-45</option> <option>45-60</option> <option>60-100</option> <option>100����</option> 
</select>�� </td></tr> <tr> <td width="25%"class=roomleft  align="left" height="24">&nbsp;�ͻ�����</td><td class=roomright width="25%"   align="left" height="24"> 
&nbsp;<select size="1" name="custype" onkeydown="key(document.cus.gmyt)"><option></option> 
<%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("Y"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %> 
</select></td> <td width="25%"class=roomleft  align="left" height="24"> &nbsp;������;</td><td class=roomright width="25%"   align="left" height="24"> 
  &nbsp;<input type=text    size="10" name="gmyt"  onkeydown="key(document.cus.num)"><input type="button" name="butt7" value=".." onclick="shList('gmyt2');"></td></tr> <tr align="left" > <td width="25%" align="left"class=roomleft  height="24"> &nbsp;��������</td><td class=roomright width="25%" align="left"   height="24"> 
 &nbsp;<select size="1" name="num"  onkeydown="key(document.cus.addr)" > 
<option></option><option value=����>����</option> <option value=����>����</option></select>&nbsp;</td>
<td width="25%" align="left"class=roomleft  height="14"> &nbsp;��&nbsp;ϵ&nbsp;��</td>
<td class=roomright width="25%" align="left"   height="14"> &nbsp;<input type=text    NAME=ContactPerson size="15" onkeydown="key(document.cus.Date1)"   ></td> 

</tr>
<tr align="left" > <td width="25%" align="left"class=roomleft  height="14"> &nbsp;ͬ������</td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<input type=text    name=visitname size="13" onkeydown="key(document.cus.tfnexus)"  > 
</td> <td width="25%" align="left"class=roomleft  height="14"> &nbsp;ͬ�ù�ϵ</td><td  class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<select size="1" name="tfnexus" onkeydown="key(document.cus.pos)" ><option></option> 
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("Z"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %> 
</select> </td>

</tr>  
 

 <tr align="left" > 	  
 <td width="25%"class=roomleft  align="left" height="23"> &nbsp;���ô���</td><td class=roomright  width="25%"   align="left" height="23"> &nbsp;<input type=text    name=chishu size="6" value="1" onkeydown="key(document.cus.save)"   ></td>
 <td width="25%" align="left"class=roomleft  height="14"> &nbsp;��Ϣ��Դ</td><td class=roomright width="25%" align="left"   height="14"> 
  &nbsp;<input type=text     size="10" name="tj" onkeydown="key(document.cus.payment)" ><input type=button name=butt1 value=".." onclick="shList('tj2');">
        </td>
</tr>
</table>  
<input type=hidden name="SaveCus" value="insert">
<p align="center"> 
           <input type=button name="submit1" value="�ᡡ��" onclick="loca();">
           &nbsp;&nbsp;
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
        if( has_name_phone() ) {
            alert( "�ÿͻ��Ѵ���!" )
            return ;
        }    
        document.cus.action ="InsertCusData.jsp";
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
</script>


</body>       
</html>       
