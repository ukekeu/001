<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>�ͻ�����</title>
</head>
 <script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script Language="JavaScript" src="../public_js/basal.js"></script>
<%@ page language="java" import="java.sql.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
 <%
 String sql="";
 String region="";
 String no="";
 String sale="";
 String name="";
 String sex="";
 String age="";
 String custype="";
 String gmyt="";
 String tj="";
 String tel="";
 String idcard="";
 String addr="";
 String pos="";
 String date="";
 String  seller="";
 String company="";
 String visitnum="";
 String visitname="";
 String visitsex="";
 String nexus="";
 String visittj="";
 String mail="";
 String bbj = "" ;
 String sj = "" ;
 String visitage="";
 String job="";
 String jtsr="";
 String wh="";
 String personnum="";
 String linkman="";
 String homejg="";
 String chishu="";
 String signatory="";
 String demand="";
 String attention="";
 String nowarea="";
 String payment="";
 String yixianmianji="";
 String insj=getbyte2(request.getParameter("sj"));
 String intel=getbyte2(request.getParameter("tel"));
 String inaddr=getbyte2(request.getParameter("addr"));
 String incardid=getbyte2(request.getParameter("cardid"));
 String cusno=getbyte2(request.getParameter("cusno"));
 String fiment="";
 String floor="";
 String Age_range="";	 
 String Chamberes_tabt="";	 
 String	 work="";	 
 String	 Car="",bak="";	 
 String	 in_chamber="";
 String	 evection="",grade="",info_fk="";
 String	 Likes="",zj="",marriage="",csdate="";	
 String section="",visitstate="",hjsl="";;
 sql="select * from customer where SerialNo='"+cusno+"'";
 //execute sql
 
 ResultSet rs=ViewBean.executeQuery(sql);
 if (rs.next()){
 //��FIELDS˳��һGET��VALUE

       no=rs.getString("code");
	  section=getbyte(rs.getString("section"));
     
      name=getbyte(rs.getString("Cus_Name"));
      sex=getbyte(rs.getString("Cus_Sex"));
      age=rs.getString("cus_age");
	  visitstate=rs.getString("visitstate");
	  custype=getbyte(rs.getString("Cus_Type"));
	  gmyt=getbyte(rs.getString("Purpose"));
	  tj=getbyte(rs.getString("Knowledge_From"));
      tel=rs.getString("Phone");
	 
      idcard=rs.getString("ID_Card");
	   
	  addr=getbyte(rs.getString("address"));
	  
      pos=getbyte(rs.getString("Zip_Code")); 
	 
       //Fomrat date 
   
	  date=getbyte(rs.getString("visit_date"));
     java.text.SimpleDateFormat needdate =null;
	 	
     needdate=new java.text.SimpleDateFormat("yyyy-MM-dd");
	 if (!date.equals(""))
	 date=needdate.format(needdate.parse(date));

     seller=getbyte(rs.getString("seller"));
	 company=getbyte(rs.getString("company"));
	 visitnum=getbyte(rs.getString("visitnum"));
	 visitname=getbyte(rs.getString("visitname"));
	 visitsex=getbyte(rs.getString("visitsex"));
	 visitage=rs.getString("visitage");
	 nexus=getbyte(rs.getString("nexus"));

     visittj=getbyte(rs.getString("visittj"));
     
     bbj=getbyte(rs.getString("bbj"));
     sj=getbyte(rs.getString("sj"));
 
	 mail=getbyte(rs.getString("mail"));
	 region=getbyte(rs.getString("region"));
     sale=rs.getString("FTSALE");
	 job=getbyte(rs.getString("job"));
	 wh=getbyte(rs.getString("Wh"));
	 jtsr=getbyte(rs.getString("jtsr"));
	 personnum=getbyte(rs.getString("personnum"));
	 signatory=getbyte(rs.getString("signatory"));
	 linkman=getbyte(rs.getString("contactperson"));
     chishu=getbyte(rs.getString("chishu"));
     homejg=getbyte(rs.getString("homejg"));
	  nowarea=getbyte(rs.getString("nowjuarea"));
     demand=getbyte(rs.getString("demand"));
     attention=getbyte(rs.getString("attention"));
     payment=getbyte(rs.getString("payment"));
     yixianmianji=getbyte(rs.getString("yixianmianji"));
	 floor=getbyte(rs.getString("floor"));
	 fiment=getbyte(rs.getString("fiment"));
	 Age_range=getbyte(rs.getString("Age_range"));	 
	 Chamberes_tabt=getbyte(rs.getString("Chamberes_tabt"));	 
	 work=getbyte(rs.getString("work"));	 
	 Car=getbyte(rs.getString("Car"));	 
	 in_chamber=getbyte(rs.getString("in_chamber"));
	 evection=getbyte(rs.getString("evection"));
	 Likes=getbyte(rs.getString("Likes"));	 
	 hjsl=getbyte(rs.getString("hjsl"));	
     zj=getbyte(rs.getString("zj"));	
	 marriage=getbyte(rs.getString("marriage"));	
	 grade=getbyte(rs.getString("grade"));	
	 bak=getbyte(rs.getString("bak"));	
	 csdate=getbyte(rs.getString("csdate"));	
	 if (!csdate.equals(""))csdate=csdate.substring(0,10);
}
rs.close();


 int arrInt=0;
 sql="SELECT COUNT(*) NUM FROM customer_xq where customer="+no;
 rs=ViewBean.executeQuery(sql);	
 if (rs.next()){
   arrInt=rs.getInt("NUM");
 }
 rs.close();
 String CodeValue[]=new String[arrInt];
 sql="SELECT xq_code FROM customer_xq where customer="+no;
 rs=ViewBean.executeQuery(sql);	
 int j=0;
 while (rs.next()){
   CodeValue[j]=rs.getString("xq_code");
   j++;
 }
 rs.close();
 %>
<SCRIPT language=javascript>
<!--

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
			else{ alert("��Щ���֤��λ������,ϵͳֻ������ȷ���������");document.cus.cardid.focus(); }    
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
			
		
       if (aForm.Date1.value.length=0)
		{
	        alert("��ѡ�������գ�");
	        aForm.Date1.focus();
	        return false;
		}
           
	    return (true);
   }
   
   function setfocus()
   {
   		document.cus.name.focus();
  if (document.cus.seller)
		setSelectMad(document.cus.seller,"<%=seller%>");
	
   }
   function full(){
 
 
	     if (document.cus.Region)
  setSelectMad(document.cus.Region,'<%=region%>');  
   
 
	 if (document.cus.section)
   setSelectMad(document.cus.section,'<%=section%>'); 
    if (document.cus.visitstate)
   setSelectMad(document.cus.visitstate,'<%=visitstate%>');  
 
    
	  setSelectMad(document.cus.grade,'<%=grade%>');  
	
  
  
 }

   
   
//-->

</script>
<script language="javascript" src="../public_js/public.js">
</script>
<body onload="setfocus();full();" oncontextmenu="return false" >
<p align=center><font size=3 color=#215CAA><b>�޸Ŀͻ�����</b></font></p>
<%
 String StrSql="select type,codename from CODE WHERE CHILD=0 order by type";
   ResultSet codeRS=null;
   String CodeName[]=new String[300];
   String CodeType[]=new String[3000];
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
  

 
 
 <table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif">��<img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>��������</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"><font color="#FF6600">&nbsp; </font></td>
</tr>
</table>	
<table width="100%" border="0" cellspacing="0"  cellpadding="0" bordercolor="#ffffff" class="tablefill">
 
<tr> 
<%@ include file="../public_js/CheckSection.jsp"%>
<%
	if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
      String sql1="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";
	  ResultSet rs2=ViewBean.executeQuery(sql1);
	  String sec="";
	  String no1="";
  %> <td class=roomleft width="25%"> &nbsp;¥&nbsp;&nbsp;&nbsp;&nbsp;��</td><td  class=roomright width="25%"    > 
 &nbsp;<select name="section" style="width:137"> 
 <option></option>
<%
while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
	    rs2.close();
     %> </select><font color=red>*</font> </td>
	  <%
	 
  %>
  </td>
  <td width="15%"   class=roomleft  height="14">&nbsp;��������</td><td class=roomright  width="15%"     height="14">&nbsp;<select name="Region"   style="width:117"  > 
<% for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("K"))
	       out.print("<option value="+CodeName[ii]+">"+CodeName[ii]+"</option>");
		  }
       }
     %> </select>
</td>
  </tr>
 

  <tr > <td width="15%" class=roomleft    height="24">&nbsp;�ͻ�����</td><td    class=roomright width="15%"     height="24"> &nbsp;<input type=text     name=name size="18"  value="<%=name %>" onkeydown="key(document.cus.sex)"  ><font color=red>*</font><td class=roomleft >��&nbsp;&nbsp;&nbsp;&nbsp;��</td><td   class=roomright >&nbsp;<select size="1"   style="width:115" name="grade"  >   
<option></option> 
    <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("grade"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %> 
      </select></td> 
 </td></tr>
<tr> 

  <tr > 
   <td width="15%"   class=roomleft  height="24">&nbsp;�ԡ�����</td><td     class=roomright width="15%"     height="24"> 

&nbsp;<input type=text name="sex" VALUE="<%=sex %>" size="6"  onkeydown="key(document.cus.cardid)" ><select  name="sex1"  onkeydown="key(document.cus.sex2)"> 
<option selected value="��">��</option> <option value="Ů">Ů</option></select><input title="���ӿͻ��Ա�" type=button name=addsexs  onclick="addsex();" value=">>" > 
&nbsp;</td>
  <td width="25%" align="left"class=roomleft  height="24">&nbsp;�ι۷�ʽ</td>
<td width="25%" class=roomright align="left"   height="24" >&nbsp;<select name="visitstate" onkeydown="key(document.cus.tel)"  style="width:115"><option  value="0">����</option><option  value="1">����</option> 
</select>
</td>

</tr>
 <tr   > 
<td width="15%"   class=roomleft  height="14">&nbsp;֤&nbsp;��&nbsp;��</td>
<td class=roomright width="15%"   height="14"> 
 &nbsp;<input type=text     name=cardid size="18"  value="<%=idcard %>"     onkeydown="key(document.cus.agefw)"  ><input type=hidden     name=age size="4">
</td>
<td width="15%"   class=roomleft  height="14">&nbsp;��������</td>
<td class=roomright width="15%"      height="14"> 
 &nbsp;<input type=text     name=csdate size="12"  value="<%=csdate %>"    ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(csdate);return false">
</td>
</tr>
</tr> 
<tr   > <td width="15%"   class=roomleft  height="14"> &nbsp;��ϵ�绰</td><td class=roomright width="15%"      height="14"> 
 &nbsp;<input type=text     name=tel size="18"   value="<%=tel %>"  onkeydown="key(document.cus.sj)"  >
</td>
<td width="15%" class=roomleft    height="23">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td><td class=roomright width="15%"      height="23"> 
 &nbsp;<input type=text     name=sj size="15" value="<%=sj %>" onkeydown="key(document.cus.mail)" > 
</td> 
 
</tr> 
<tr >  
 <td width="15%"   class=roomleft  height="14">&nbsp;EMAIL��ַ</td><td class=roomright  width="15%"     height="14"> 
 &nbsp;<input type=text     name=mail size="18"  value="<%=mail %>"  onkeydown="key(document.cus.pos)"  > 
</td>
<td width="15%"   class=roomleft  height="14">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td><td class=roomright  width="15%"     height="14"> 
&nbsp;<input type=text     value="<%=pos %>" name=pos size="15" onkeydown="key(document.cus.company)">
</td>
</tr>

<tr   > 
<td width="15%"   class=roomleft  height="24">&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;λ</td><td class=roomright width="15%"  colspan=3   height="24">&nbsp;<input type=text     name=company size="39"  value="<%=company %>" onkeydown="key(document.cus.addr)"  >  </td>
</tr> 

<tr>
<td width="15%" class=roomleft    height="23">&nbsp;��ϵ��ַ</td><td class=roomright width="15%"     height="23" colspan=3> 
 &nbsp;<input type=text     name=addr size="39" value="<%=addr %>" onkeydown="key(document.cus.Date1)" > </td>
</td>
</tr>


<tr   >
 <td width="15%"   class=roomleft  height="14">&nbsp;��������</td><td class=roomright width="15%"     height="14"> 
 &nbsp;<input type=text     NAME=Date1 size=10  value="<%=date %>"  onkeydown="key(document.cus.seller)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false">
</td><td width="15%"   class=roomleft  height="24"> &nbsp;��&nbsp;��&nbsp;Ա</td><td class=roomright class=roomrightwidth="15%"     height="24"> 
 &nbsp;<select size="1" style="width:120" name="seller" onkeydown="key(document.cus.demand)"  >
    <option value=""></option>
 
  <%String sell="select  seller from seller where section_no='"+section+"'";
rs2=ViewBean.executeQuery(sell);
  while (rs2.next()){
	   String Name=getbyte(rs2.getString("seller"));
       out.print("<option value='  "+Name+"'>"+Name+"</option>") ;
	}
  rs2.close();
  %>
    </select>
</td>
	  </tr>
	  	  <tr><td class=roomleft>��&nbsp;&nbsp;&nbsp;&nbsp;ע</td><td colspan="3" class=roomright><textarea cols="57"  name=info_fk rows="4"><%=bak %></textarea></td></tr>

	</table> 
 <table width="298" border="0" cellspacing="0" cellpadding="0">
<tr> 
          <td width="130" height="23" background="../images/head_7.gif">��<img src="../images/day2.gif" width="16" height="13" vspace="2" align="absmiddle"><strong>���鷴��</strong></td>
          <td align="right" valign="top" background="../images/head_dd1.gif"><font color="#FF6600"> &nbsp;</font></td>
</tr>
</table>	
 <table BORDER=0 width="100%"  CELLSPACING=1 CELLPADDING=3 ALIGN=center>
	 
  <%
  String SQL="select * from CustomerDc where TYPE=0 AND  sectionno='"+section+"'";
  rs2=ViewBean.executeQuery(SQL);	
  int iii=0;
   while (rs2.next()){
     iii++;
   %>
 <tr align="center">
    <td width="5%"  class=roomleft ><%=iii %></td>
    <td width="15%" class=roomleft  align="left">&nbsp;<%=rs2.getString("codeName") %></td>
	<td width="65%" align="left" class=roomright>
	<%
	 SQL="select  CodeValue,code from CustomerDcValue where dcCode="+rs2.getString("code");
	 
	 ResultSet rs1=ViewBean1.executeQuery(SQL);	
    while (rs1.next()){
	    String sele="";
	    String codcename=rs1.getString("CodeValue");
		String code=rs1.getString("code");
		 for (int ii=0;ii<arrInt;ii++){
		  if (CodeValue[ii]!=null){
		   if (CodeValue[ii].equals(code))
	        sele="checked";
		  }
       }
	     %>
		   <input name="codcename<%=code %>" type="checkbox" value="<%=code %>" <%=sele %>   ><%=codcename %> 
		 <% 
       }
	rs1.close();
	 %>
	
	</td>
	 
  </tr>
  <%}
  rs2.close(); %>
 </table> 

 
<%@ include file="../public_js/qx_checke.jsp"%>
<p align="center">
<input type=hidden name="SaveCus" value="modi">
<%
//Ȩ�����
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"C002");
  
   if (Cortrol==null){Cortrol="";}
    if (Cortrol.indexOf("E")>=0){ %>
<input type=button name=sub value="�ᡡ��" onclick="loca();">
 <%} %>
           &nbsp;&nbsp;
		   <input type=button name=cancel value="�ˡ���" onclick="window.close()">
		   </p>
 
<script>

function loca(){
if (Validate(document.cus)){
 if (confirm("���Ҫ�޸�ѡ��Ŀͻ���Ϣ��")){
  document.cus.action ="InsertCusData.jsp?cusno=<%=cusno%>&edit=<%=request.getParameter("edit") %>";
  document.cus.submit();
 }
}}
var atten="";
function choose(para){
   atten=para.value;
   
} 
</script>
 
</form>   
       
</body>       
</html>       
