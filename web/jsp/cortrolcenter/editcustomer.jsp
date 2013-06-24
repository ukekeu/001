<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>客户资料</title>
</head>
 <script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script Language="JavaScript" src="../public_js/basal.js"></script>
<%@ page language="java" import="java.sql.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
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
 String insj=request.getParameter("sj");
 String intel=request.getParameter("tel");
 String inaddr=request.getParameter("addr");
 String incardid=request.getParameter("cardid");
 String cusno=request.getParameter("cusno");
 String fiment="";
 String floor="";
 String Age_range="";	 
 String Chamberes_tabt="";	 
 String	 work="";	 
 String	 Car="";	 
 String	 in_chamber="";
 String	 evection="";
 String	 Likes="",zj="",marriage="";	
 String section="",visitstate="",hjsl="";;
 sql="select * from customer where SerialNo='"+cusno+"'";
 //execute sql

 ResultSet rs=ViewBean.executeQuery(sql);
 if (rs.next()){
 //按FIELDS顺序一GET　VALUE

     // no=rs.getString("SerialNo");
	  section=getbyte(rs.getString("section"));
     
      name=getbyte(rs.getString("Cus_Name"));
      sex=getbyte(rs.getString("Cus_Sex"));
      age=rs.getString("cus_age");
	  visitstate=rs.getString("visitstate");
	  custype=getbyte(rs.getString("Cus_Type"));
	  gmyt=getbyte(rs.getString("Purpose"));
	  tj=getbyte(rs.getString("Knowledge_From"));
      tel=rs.getString("Phone");
	  if (intel!=null)tel=intel;
      idcard=rs.getString("ID_Card");
	  if (incardid!=null)idcard=incardid;
	  addr=getbyte(rs.getString("address"));
	  if (inaddr!=null)addr=inaddr;
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
     if (insj!=null)sj=insj;
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
	 
}
rs.close(); %>
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
   var arry=cardidS.split("/");//转换为arry
	for (var jj=0;jj<arry.length;jj++){
	  if (!isNaN(arry[jj])){
		  if (ages=="")
		   { 
		    if (arry[jj].length==18)
		       ages=String(parseInt(year)-parseInt(arry[jj].substring(6,10)));
		    else if (arry[jj].length==15)
		       ages=String(parseInt(year)-parseInt("19"+arry[jj].substring(6,8)));
			else{ alert("有些身份证号位数有误,系统只计算正确号码的年龄");document.cus.cardid.focus(); }  
		   }
		  else
		    {
			if (arry[jj].length==18)
		       ages+="/"+String(parseInt(year)-parseInt(arry[jj].substring(6,10)));
		    else if (arry[jj].length==15)
		       ages+="/"+String(parseInt(year)-parseInt("19"+arry[jj].substring(6,8)));
			else{ alert("有些身份证号位数有误,系统只计算正确号码的年龄");document.cus.cardid.focus(); }    
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
 var arry1=sexs.split("/");//转换为arry;
 var cusname=document.cus.name.value;
 var arry2=cusname.split("/");//转换为arry;
 if (sexs!="")
 if (arry1.length==arry2.length){alert("姓名数与性别数已相等,系统不接受多于的性别");return false;}
 if (sexs=="")
     document.cus.sex.value=document.cus.sex1.value;
else
  document.cus.sex.value+="/"+document.cus.sex1.value;
 

}

     function Validate(aForm)
   {
        
		if (aForm.section.options[aForm.section.selectedIndex].text=="")
	    	{
	    	alert("请选择楼盘！");
	        aForm.section.focus();
	        return (false);
	    	}	
		
		if (aForm.name.value.length<1)
	    	{
	    	alert("请输入客户姓名！");
	        aForm.name.focus();
	        return (false);
	    	}	
			
		
       if (aForm.Date1.value.length=0)
		{
	        alert("请选择年月日！");
	        aForm.Date1.focus();
	        return false;
		}
            aForm.hs.value=aForm.hs1.value+"|"+aForm.hs2.value+"|"+aForm.hs3.value+"|"+aForm.hs4.value+"|"+aForm.hs5.value;
aForm.ah.value=aForm.ah1.value+"|"+aForm.ah2.value+"|"+aForm.ah3.value;
	    return (true);
   }
   
   function setfocus()
   {
   		document.cus.name.focus();
  if (document.cus.seller)
		setSelectMad(document.cus.seller,"<%=seller%>");
	
   }
   function full(){
   if (document.cus.jtsr)
      setSelectMad(document.cus.jtsr,'<%=jtsr%>');
  if (document.cus.tfnexus)
	  setSelectMad(document.cus.tfnexus,'<%=nexus%>');
	  
if (document.cus.wh)
      setSelectMad(document.cus.wh,'<%=wh%>');
if (document.cus.num)
	  setSelectMad(document.cus.num,'<%=visitnum%>');
if (document.cus.custype)
	  setSelectMad(document.cus.custype,'<%=custype%>');
	  
if (document.cus.yixiangmianji)
	  setSelectMad(document.cus.yixiangmianji,'<%=yixianmianji%>');
	     if (document.cus.Region)
  setSelectMad(document.cus.Region,'<%=region%>');  
     if (document.cus.homejg)
  setSelectMad(document.cus.homejg,'<%=homejg%>'); 
   if (document.cus.gmyt)
  setSelectMad(document.cus.gmyt,'<%=gmyt%>'); 
   if (document.cus.job)
  setSelectMad(document.cus.job,'<%=job%>'); 
  if (document.cus.fiment)
    setSelectMad(document.cus.fiment,'<%=fiment%>'); 
	 if (document.cus.section)
   setSelectMad(document.cus.section,'<%=section%>'); 
   setSelectMad(document.cus.visitstate,'<%=visitstate%>');  
   setSelectMad(document.cus.attention,'<%=attention%>');  
    setSelectMad(document.cus.tj,'<%=tj%>');  
   
 	  <%
	     String ah[]=new String[3];
	 StringTokenizer st22 = new StringTokenizer(Likes,"|") ;
                  int count24 = st22.countTokens() ;
				  int iii=0;
				  while (st22.hasMoreElements()) {
				     ah[iii] = (String)st22.nextElement() ;
					 iii++;
					 }
	  
	   %>
	     
   setSelectMad(document.cus.ah1,'<%=ah[0]%>'); 
   setSelectMad(document.cus.ah2,'<%=ah[1]%>'); 
   setSelectMad(document.cus.ah3,'<%=ah[2]%>'); 
   setSelectMad(document.cus.marriage,'<%=marriage%>'); 
   
   
   setSelectMad(document.cus.agefw,'<%=Age_range%>'); 
    <%
	    String hsa[]=new String[5];
	   st22 = new StringTokenizer(Chamberes_tabt,"|") ;
                    count24 = st22.countTokens() ;
				     iii=0;
				  while (st22.hasMoreElements()) {
				     hsa[iii] = (String)st22.nextElement() ;
					  iii++;
					 }
	  
	   %>
   setSelectMad(document.cus.hs1,'<%=hsa[0]%>');  	
   setSelectMad(document.cus.hs2,'<%=hsa[1]%>');  	
   setSelectMad(document.cus.hs3,'<%=hsa[2]%>');  	
   setSelectMad(document.cus.hs4,'<%=hsa[3]%>');  	
   setSelectMad(document.cus.hs5,'<%=hsa[4]%>');  	
   setSelectMad(document.cus.zy,'<%=work%>');  		
   
  setSelectMad(document.cus.rh,'<%=in_chamber%>');  		
  setSelectMad(document.cus.cc,'<%=evection%>');  
  setSelectMad(document.cus.hj,'<%=hjsl%>');  
  setSelectMad(document.cus.zj,'<%=zj%>');  
  setSelectMad(document.cus.nowjuarea,'<%=nowarea%>');  
  setSelectMad(document.cus.car,'<%=Car%>');  
	
  
  
 }

   
   
//-->

</script>
<script language="javascript" src="../public_js/public.js">
</script>
<body onload="setfocus();full();">
<p align=center><font size=3 color=#215CAA><b>修改客户资料</b></font></p>
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
  


<div id="xq" style="position:absolute; left:195px; top:270px; width:30px; height:52px; z-index:1; visibility: hidden"> 
<select  name="xq1" multiple size=10 onchange="sele(document.cus.demand,document.cus.xq1,'xq',sh3);choose1(document.cus.demand);" multiple size=10>
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
<div id="gz" style="position:absolute; left:300px; top:260px; width:30px; height:52px; z-index:1; visibility: hidden"> 
<select  name="gz1" multiple size=10 onchange="sele(document.cus.attention,document.cus.gz1,'gz',sh3);choose1(document.cus.attention);" multiple size=10>
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
 
<center>

<table width="100%" border="0" cellspacing="0"  cellpadding="0" bordercolor="#ffffff" class="tablefill">
<tr > 
<td colspan=4 align=center class=TITLE><b>基&nbsp;本&nbsp;资&nbsp;料</b></td></tr>
<tr> 
<%@ include file="../public_js/CheckSection.jsp"%>
<%
	if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
      String sql1="select SerialNo,Name FROM crm_project where SerialNo in("+SectionS+")";
	  ResultSet rs2=ViewBean.executeQuery(sql1);
	  String sec="";
	  String no1="";
  %> <td class=roomleft width="25%"> &nbsp;楼&nbsp;&nbsp;&nbsp;&nbsp;盘</td><td  class=roomright width="25%"    > 
 &nbsp;<select name="section" style="width:117"> 
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
  <td width="15%"   class=roomleft  height="14">&nbsp;来自区域</td><td class=roomright  width="15%"     height="14">&nbsp;<select name="Region"  > 
<% for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("K"))
	       out.print("<option value="+CodeName[ii]+">"+CodeName[ii]+"</option>");
		  }
       }
     %> </select>
</td>
  </tr>
 

  <tr > <td width="15%" class=roomleft    height="24">&nbsp;客户姓名</td><td  colspan=3  class=roomright width="15%"     height="24"> &nbsp;<input type=text     name=name size="30"  value="<%=name %>" onkeydown="key(document.cus.age)"  ><font color=red>*</font></td> 
 </td></tr>
<tr> 

  <tr > 
   <td width="15%"   class=roomleft  height="24">&nbsp;性　　别</td><td   colspan=3  class=roomright width="15%"     height="24"> 

&nbsp;<input type=text name="sex" VALUE="<%=sex %>" size="30"><select  name="sex1"  onkeydown="key(document.cus.sex2)"> 
<option selected value="男">男</option> <option value="女">女</option></select><input title="增加客户性别" type=button name=addsexs  onclick="addsex();" value=">>" > 
&nbsp;</td></tr>
 <tr   > 
<td width="15%"   class=roomleft  height="14">&nbsp;身份证号</td>
<td class=roomright width="15%"    colspan=3 height="14"> 
 &nbsp;<input type=text     name=cardid size="54"  value="<%=idcard %>"   onblur="countAge();" onkeydown="key(document.cus.bbj)"  >
</td>
</tr>
<tr   > 
<td width="25%" align="left"class=roomleft  height="24">&nbsp;年龄范围</td>
<td width="25%" class=roomright align="left"   height="24" >&nbsp;<select size="1"  style="width:117" name="agefw" onkeydown="key(document.cus.wh)">   
<option></option> 
    <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("AG"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %> 
  </td>
  <td width="25%" align="left"class=roomleft  height="24">&nbsp;参观方式</td>
<td width="25%" class=roomright align="left"   height="24" >&nbsp;
  <select name="visitstate"><option  value="0">来访</option><option  value="1">来电</option> 
</select>
</td>
</tr><input type=hidden    name=age size="18"  >
<tr   > <td width="15%"   class=roomleft  height="14"> &nbsp;联系电话</td><td class=roomright width="15%"      height="14"> 
 &nbsp;<input type=text     name=tel size="18"   value="<%=tel %>"  onkeydown="key(document.cus.cardid)"  >
</td>

<td width="15%" class=roomleft    height="23">&nbsp;手机</td><td class=roomright width="15%"      height="23"> 
 &nbsp;<input type=text     name=sj size="18" value="<%=sj %>" onkeydown="key(document.cus.mail)" > 
</td> 
 
</tr> 
<tr >  
 <td width="15%"   class=roomleft  height="14">&nbsp;EMAIL地址</td><td class=roomright  width="15%"     height="14"> 
 &nbsp;<input type=text     name=mail size="16"  value="<%=mail %>"  onkeydown="key(document.cus.ContactPerson)"  > 
</td>
<td width="15%"   class=roomleft  height="14">&nbsp;邮编</td><td class=roomright  width="15%"     height="14"> 
<input type=text     value="<%=pos %>" name=pos size="13" onkeydown="key(document.cus.chishu)">
</td>
</tr>

<tr   > 
<td width="15%"   class=roomleft  height="24">&nbsp;单　位</td><td class=roomright width="15%"  colspan=3   height="24">&nbsp;<input type=text     name=company size="55"  value="<%=company %>" onkeydown="key(document.cus.tel)"  >  </td>
</tr> 

<tr>
<td width="15%" class=roomleft    height="23">&nbsp;联系地址</td><td class=roomright width="15%"     height="23" colspan=3> 
 &nbsp;<input type=text     name=addr size="55" value="<%=addr %>" onkeydown="key(document.cus.visitname)" > </td>
</td>
</tr>
  <%if (request.getParameter("edit")==null){ %>
<tr   >
 <td width="15%"   class=roomleft  height="14">&nbsp;来访日期</td><td class=roomright width="15%"     height="14"> 
 &nbsp;<input type=text     NAME=Date1 size=10  value="<%=date %>"  onkeydown="key(document.cus.seller)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false">
</td><td width="15%"   class=roomleft  height="24"> &nbsp;销售员</td><td class=roomright class=roomrightwidth="15%"     height="24"> 
 &nbsp;<select size="1" name="seller" onkeydown="key(document.cus.tj)"  >
    <option value=""></option>
 
  <%String sell="select  seller from seller where section_no in ("+SectionS+")";
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
	
	  <tr> 
<td colspan=4 align=center class=TITLE><font color=white>基&nbsp;本&nbsp;需&nbsp;求</font></td></tr>
 <tr   > 
 <td width="15%"   class=roomleft  height="14"> &nbsp;意向户型</td><td class=roomright width="15%"     height="14"> 
  &nbsp;<input type=text     size=10 size="1" name="demand" value="<%=demand %>"onkeydown="key(document.cus.attention)" ondblclick="shList('xq');"><input type=button name=butt3 value=".." onclick="choose(document.cus.demand);shList('xq');">
        </td>
 <td width="15%"   class=roomleft  height="14"> &nbsp;意向付款</td><td  class=roomright width="15%"     height="14"> 
  &nbsp;<input type=text     size=12 size="1" name="payment" value="<%=payment %>" onkeydown="key(document.cus.demand)" ondblclick="shList('jt2');" ><input type=button name=butt2 value=".." onclick="shList('jt2');"> </td></tr> 
   <tr   > 
 <td width="15%"   class=roomleft  height="14"> &nbsp;会籍数量 </td><td class=roomright width="15%"     height="14" > 
  &nbsp;<select size="1"  style="width:100" name="hj" onkeydown="key(document.cus.wh)">   
<option></option> 
    <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("HJ"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %> 
      </select></td>
  <td width="25%" align="left"class=roomleft  height="14"> &nbsp;关注问题</td>
        <td class=roomright width="25%" align="left"   height="14">&nbsp;<select size="1"  style="width:100" name="attention" onkeydown="key(document.cus.wh)">   
<option></option> 
    <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("F"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %> 
      </select> 
</td> 
  </tr> 
  <tr align="left" > 
 <td width="25%" align="left"class=roomleft  height="14"> &nbsp;总价范围</td>
        <td class=roomright width="25%" align="left"   height="14">&nbsp;<select size="1"  style="width:100" name="zj" onkeydown="key(document.cus.wh)">   
<option></option> 
    <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("SP"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %> 
      </select>万元
</td> 
   <td width="25%" align="left"class=roomleft  height="24">&nbsp;意向面积</td>
<td class=roomright width="25%" align="left"   height="24">

&nbsp;<select size="1"  style="width:117" name="yixiangmianji" onkeydown="key(document.cus.wh)">   
<option></option> 
    <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("O"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %> 
      </select><font size=2>M<sup>2</sup></font>
</td>
  </tr> 
  <tr align="left" > 
<td width="25%" align="left"class=roomleft  height="14"> &nbsp;意向楼层</td>
<td class=roomright width="25%" align="left"   height="14"> 
  &nbsp;<input type="text"    size="12" name="floor" onkeydown="key(document.cus.attention)"   value="<%=floor %>" > 
        </td>
 <td width="25%" align="left"class=roomleft  height="14"> &nbsp;装修要求</td><td class=roomright width="25%" align="left"   height="14"> 
 &nbsp;<select  name="fiment" style="width:117" >  <option></option>
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("X"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select>  </td></tr> 
 <tr> 
<td colspan=4 align=center class=TITLE><font   color=white>&nbsp;其&nbsp;它&nbsp;资&nbsp;料</font></td></tr>
 <tr   > <td width="15%"   class=roomleft  height="24">&nbsp;家庭人数</td>
<td class=roomright width="15%"     height="24">&nbsp;<input type=text     name=personnum size="10" value="<%=personnum %>" onkeydown="key(document.cus.homejg)"  > 
</td>
<td width="25%" align="left"class=roomleft  height="24">&nbsp;家庭结构</td>
<td class=roomright width="25%" align="left"   height="24">
  &nbsp;<select  name="homejg" style="width:117">  <option></option>
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("J"))
	       out.print("<option value="+CodeName[ii]+">"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 
</td>
</tr>

<tr> 
 <td width="25%" align="left"class=roomleft  height="24">&nbsp;现居面积</td>
<td class=roomright width="25%" align="left"   height="24">

&nbsp;<select size="1" name="nowjuarea"  style="width:117" onkeydown="key(document.cus.wh)" >   
      <option><%=nowarea %></option>
      <option>50以下</option>
       <option>50-80</option>
      <option>80-100</option>
      <option>100-110</option>
      <option>110-150</option>
      <option>150以上</option>
      &nbsp;  
      </select><font size=2>M<sup>2</sup></font>
</td>
  <td width="15%"   class=roomleft  height="24">&nbsp;文化</td><td class=roomright width="15%"     height="24"> 
&nbsp;<select size="1" name="wh" style="width:117" onkeydown="key(document.cus.job)">  <option></option>
<%out.print("<option></option>");
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   
		   if (CodeType[ii].equals("M"))
		   
	       out.print("<option value="+CodeName[ii]+">"+CodeName[ii]+"</option>");
		  }
       }
  %> 
</select> </td> 
</tr>











 <tr   > <td width="15%"   class=roomleft  height="24"> &nbsp;行业</td><td class=roomright width="15%"     height="24"> 
&nbsp;<select  name="job" style="width:117" 　 >  <option></option>
  <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("G"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> </td>
<td width="15%"   class=roomleft  height="24">&nbsp;年收入</td><td class=roomright width="15%"     height="24"> 
&nbsp;<select size="1" name="jtsr" style="width:117"> <option></option><option value="5-10">5-10</option> <option value="10-15">10-15</option> <option  value="15-25">15-25</option> 
<option  value="25-45">25-45</option> <option  value="45-60">45-60</option> <option value="60-100">60-100</option> <option value="100以上">100以上</option> &nbsp; 
</select>万 </td></tr> <tr> <td width="15%" class=roomleft    height="24">&nbsp;客户类型</td><td class=roomright width="15%"     height="24"> 
&nbsp;<select size="1" style="width:117"  name="custype" onkeydown="key(document.cus.gmyt)">  <option></option>
<%out.print("<option></option>");
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("Y"))
	       out.print("<option value="+CodeName[ii]+">"+CodeName[ii]+"</option>");
		  }
       }
  %> 
</select></td> <td width="15%" class=roomleft    height="24"> &nbsp;购买用途</td><td class=roomright width="15%"     height="24"> 
  &nbsp;<select  name="gmyt" style="width:117" >  <option></option>
   <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("I"))
	       out.print("<option value="+CodeName[ii]+">"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select></td></tr> <tr   > <td width="15%"   class=roomleft  height="24"> &nbsp;来访人数</td><td  class=roomright width="15%"     height="24"> 
 &nbsp;<select size="1"  style="width:117"  name="num"  onkeydown="key(document.cus.addr)" > 
<option></option><option value=单人>单人</option> <option value=多人>多人</option> &nbsp; </select>&nbsp;</td>
<td width="15%"   class=roomleft  height="14"> &nbsp;联系人</td>
<td  class=roomright width="15%"     height="14"> &nbsp;<input type=text    NAME=ContactPerson SIZE="15"  value="<%=linkman %>"  onkeydown="key(document.cus.Date1)"   ></td> 
</tr>


<tr   > <td width="15%"   class=roomleft  height="14"> &nbsp;同访姓名</td><td class=roomright width="15%"     height="14"> 
 &nbsp;<input type=text     name=visitname value="<%=visitname %>"size="13" onkeydown="key(document.cus.tfnexus)"  > 
</td> <td width="15%"   class=roomleft  height="14"> &nbsp;同访关系</td><td class=roomright width="15%"     height="14"> 
 &nbsp;<select size="1"  style="width:117"  name="tfnexus"  onkeydown="key(document.cus.pos)" ><option></option> 
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("Z"))
	       out.print("<option value="+CodeName[ii]+">"+CodeName[ii]+"</option>");
		  }
       }
  %> 
</select> </td></tr>  
 

 <tr   > 
<td width="25%"class=roomleft  align="left" height="23"> &nbsp;婚姻状况</td><td class=roomright  width="25%"   align="left" height="23"> &nbsp;
<select  name="marriage" style="width:117" >
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("HY"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 

<input type=hidden    name=chishu  value="<%=chishu %>" size="6" value="1" onkeydown="key(document.cus.save)"   ></td>
<td width="15%"   class=roomleft  height="14"> &nbsp;信息来源</td><td class=roomright width="15%"     height="14"> 
  &nbsp;<select  name="tj" style="width:117" >  <option></option>
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("E"))
	       out.print("<option value="+CodeName[ii]+">"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 
        </td>
</tr>

<tr align="left" > 	  
 <td width="25%"class=roomleft  align="left" height="23"> &nbsp;出差情况</td><td class=roomright  width="25%"   align="left" height="23"> &nbsp;<select  name="cc" style="width:117" >  <option></option>
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("CC"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> </td>
 <td width="25%" align="left"class=roomleft  height="14"> &nbsp;车辆品牌</td><td class=roomright width="25%" align="left"   height="14"> 
  &nbsp;<select  name="car" style="width:117" >  <option></option>
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("CA"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 
        </td>
</tr>

<tr align="left" > 	  
 <td width="25%"class=roomleft  align="left" height="23"> &nbsp;会所设施</td><td class=roomright  width="25%"   align="left" height="23" colspan="3"> &nbsp;1.<select  name="hs1" style="width:117" >
  <option></option>
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("HS"))
	       out.print("<option  value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 2.<select  name="hs2" style="width:117" >
  <option></option>
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("HS"))
	       out.print("<option  value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 3.<select  name="hs3" style="width:117" >
  <option></option>
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("HS"))
	       out.print("<option  value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select><br>&nbsp;4.<select  name="hs4" style="width:117" >
  <option></option>
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("HS"))
	       out.print("<option  value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 5.<select  name="hs5" style="width:117" >
  <option></option>
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("HS"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 
<input type=hidden name="hs"></td>
</tr><tr>
 <td width="25%" align="left"class=roomleft  height="14"> &nbsp;爱好</td><td class=roomright width="25%" align="left"   height="14" colspan="3"> 
<input type=hidden name="ah">
  &nbsp;1.<select  name="ah1" style="width:117" >
  <option></option>
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("AH"))
	       out.print("<option  value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 2.<select  name="ah2" style="width:117" >
  <option></option>
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("AH"))
	       out.print("<option  value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 3.<select  name="ah3" style="width:117" >
  <option></option>
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("AH"))
	       out.print("<option  value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 
        </td>
</tr> 
<tr align="left" > 	  
 <td width="25%"class=roomleft  align="left" height="23"> &nbsp;入会标准</td><td class=roomright  width="25%"   align="left" height="23"> &nbsp;<select  name="rh" style="width:117" >  <option></option>
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("RH"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> </td>
 <td width="25%" align="left"class=roomleft  height="14"> &nbsp;职业</td><td class=roomright width="25%" align="left"   height="14"> 
  &nbsp;<select  name="zy" style="width:117" >
  <option></option>
 <%
   for (int ii=0;ii<300;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("ZY"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 
        </td>
</tr>
</table>  
<table>
<tr>
<td colspan="2">
<input type=hidden name="SaveCus" value="modi">
<%String Cortrol=(String)session.getAttribute("popedomStr"); 
   if (Cortrol==null){Cortrol="";}
    if (Cortrol.indexOf("E")>=0){ %>
<input type=button name=sub value="提　交" onclick="loca();">
 <%} %>
           &nbsp;&nbsp;
		   <input type=button name=cancel value="退　出" onclick="window.close()">
</td>
</tr><%} %>
<script>

function loca(){
if (Validate(document.cus)){
 if (confirm("真的要修改选择的客户信息吗？")){
  document.cus.action ="InsertCusData.jsp?cusno=<%=cusno%>&edit=<%=request.getParameter("edit") %>";
  document.cus.submit();
 }
}}
var atten="";
function choose(para){
   atten=para.value;
   
}
function choose1(para){
if (atten!=""){
   if (confirm("已经选择了一个，是否要多选？"))para.value=para.value+","+atten;
}

}
</script>
</center>
</table>  
</form>   
       
</body>       
</html>       
