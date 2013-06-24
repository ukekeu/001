<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/mad.css" rel=stylesheet>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>修改楼盘资料</title>
<script>
  function cr(){
    var char=document.cus.Area.value/document.cus.UseArea.value;
 var  varst=String(char);
  if (varst.indexOf(".")>0){
  varst=varst.substring(varst.indexOf(".")+2,varst.indexOf(".")+3);
  if (parseInt(varst)>4){char=parseInt(String(char).substring(0,String(char).indexOf(".")+2))+1;}else{char=String(char).substring(0,String(char).indexOf(".")+2);}
 }   
	  document.cus.CubageRate.value=char;

  }
</script>
<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%  try{
 String StrSql="select type,codename from CODE order by type";
   ResultSet codeRS=null;
   String CodeName[]=new String[500];
   String CodeType[]=new String[500];
    codeRS=ViewBean.executeQuery(StrSql);
   int i=0;
 
    while (codeRS.next()){
     CodeType[i]=codeRS.getString("type");
     CodeName[i]=getbyte(codeRS.getString("codename"));
	 i++;
   }
   codeRS.close();
 %>
<%

int ID=java.lang.Integer.parseInt(request.getParameter("ID"));
String sql="";
String strSecName="";
String strSecArea="";
String strSecNo="";
String strArea="";
String strUseArea="";
String strCubageRate="";
String strGreenRate="";
String strFamilyCount="";
String strRealRate="";
String strManageFee="";
String strIntro="";
String strSetDate="";
String strOpendate="";
String strOfferdate="";
String strFactDate="";
String strFdDate="";
String strRegion="";
String strJgDate="";
String strType="";
String strFitment="";
String strSaleArea="";
String strDH="";
String strLS="";
String strdevelopcom="";
String strinvestcom="";
String struseyear="",tdsyqcrpzno ="";
String strcomnote="",company="";
String guihua_no="",shigong_no="";
String yushou_no="",tudishiyong_no="";
String wuyei_com="",jiegou="",gytzno="";
String chenggao="",cq_sd="",cq_ed="",qddkfs="";
String fr="";
String	phone="";
String dlr="";
String	phone1="";
String	dlrdz="";
String	zipcode="";
String	yyzzh="";
String	zzzsh=""; 
String frdz="";
String fryb="";
String tdqyxz="";
String tdqsly="";
String zcadd="";
sql="select * from CRM_Project where code="+ID+" order by code DESC";
ResultSet rs=ViewBean.executeQuery(sql);
while (rs.next()){
    strRegion=getbyte(rs.getString("Region"));
	strSecName=getbyte(rs.getString("Name"));
	strSecArea=getbyte(rs.getString("AreaNo"));
	strSecNo=rs.getString("SerialNo");
	strArea=FormatD.getFloat1(rs.getFloat("TotalArea"),2);
	strUseArea=FormatD.getFloat1(rs.getFloat("GroundArea"),2);
	strSaleArea=FormatD.getFloat1(rs.getFloat("SaleArea"),2);
	strFitment=getbyte(rs.getString("Fitment"));
	strType=getbyte(rs.getString("Type"));
	strCubageRate=FormatD.getFloat1(rs.getFloat("CubageRate"),2);
	strGreenRate=FormatD.getFloat1(rs.getFloat("GreenRate"),2);
	strSetDate=rs.getString("SetDate");
	if (strSetDate==null) strSetDate=" ";
	strSetDate=strSetDate.substring(0,strSetDate.indexOf(" "));
	strOpendate=rs.getString("Opendate");
	if (strOpendate==null) strOpendate=" ";
	strOpendate=strOpendate.substring(0,strOpendate.indexOf(" "));
	strOfferdate=rs.getString("Offerdate");
	if (strOfferdate==null) strOfferdate=" ";
	strOfferdate=strOfferdate.substring(0,strOfferdate.indexOf(" "));
	strFactDate=rs.getString("FactDate");
	if (strFactDate==null) strFactDate=" ";
	strFactDate=strFactDate.substring(0,strFactDate.indexOf(" "));
	strFdDate=rs.getString("FdDate");
	if (strFdDate==null) strFdDate=" ";
	strFdDate=strFdDate.substring(0,strFdDate.indexOf(" "));
	strJgDate=rs.getString("JgDate");
	if (strJgDate==null) strJgDate=" ";
	strJgDate=strJgDate.substring(0,strJgDate.indexOf(" "));
	strFamilyCount=rs.getString("FamilyCount");
	strRealRate=FormatD.getFloat1(rs.getFloat("RealRate"),2);
	strManageFee=FormatD.getFloat1(rs.getFloat("ManageFee"),2);
	strdevelopcom=getbyte(rs.getString("developcom"));
	
	strinvestcom=getbyte(rs.getString("investcom"));
	struseyear=getbyte(rs.getString("useyear"));
	if (struseyear.equals(""))struseyear="3";
	strcomnote=getbyte(rs.getString("comnote"));
	strIntro=getbyte(rs.getString("Intro"));
	strDH=getbyte(rs.getString("DH"));
	strLS=getbyte(rs.getString("LS"));
	company=getbyte(rs.getString("company"));
	guihua_no=getbyte(rs.getString("guihua_no"));
	shigong_no=getbyte(rs.getString("shigong_no"));
	yushou_no=getbyte(rs.getString("yushou_no"));
	tudishiyong_no=getbyte(rs.getString("tudishiyong_no"));
	wuyei_com=getbyte(rs.getString("wuyei_com"));
	jiegou=getbyte(rs.getString("jiegou"));
	chenggao=getbyte(rs.getString("chenggao"));
	if (chenggao.equals(""))chenggao="3";
	cq_sd=getbyte(rs.getString("cq_sd"));
	cq_ed=getbyte(rs.getString("cq_ed"));
	qddkfs=getbyte(rs.getString("qddkfs"));
	gytzno=getbyte(rs.getString("gytzno"));	
	tdsyqcrpzno=getbyte(rs.getString("tdsyqcrpzno"));
	fr=getbyte(rs.getString("fr"));
	phone=getbyte(rs.getString("frdh"));
	dlr=getbyte(rs.getString("dlr"));
	phone1=getbyte(rs.getString("dlrzh"));
	dlrdz=getbyte(rs.getString("dlrdz"));
	zipcode=getbyte(rs.getString("dlryb"));
	yyzzh=getbyte(rs.getString("yyzzh"));
	zzzsh=getbyte(rs.getString("zzzsh")); 
	frdz=getbyte(rs.getString("frdz"));
	fryb=getbyte(rs.getString("fryb")); 
	tdqsly=getbyte(rs.getString("tdqsly")); 
	tdqyxz=getbyte(rs.getString("tdqyxz")); 
	zcadd=getbyte(rs.getString("zc_addr")); 
}
rs.close();
%>
</head>
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<SCRIPT language=javascript>
<!--
     function Validate(aForm)
   {

		if (aForm.SecName.value.length<1)
	    	{
	    	alert("请输入楼盘名称！");
	        aForm.SecName.focus();
	        return (false);
	    	}	
		if (aForm.SecArea.value.length<3)
		{
	        alert("请输入楼盘地段！");
	        aForm.SecArea.focus();
	        return false;
		}
		if (aForm.SecNo.value<1)
		{
	        alert("请输入楼盘编码！");
	        aForm.SecNo.focus();
	        return false;
		}
		if (aForm.developcom.value<1)
		{
	        alert("请录入发展名称");
	        aForm.developcom.focus();
	        return false;
		}
		
		if (aForm.company.value<1)
		{
	        alert("请楼盘所属的公司");
	        aForm.company.focus();
	        return false;
		}
		if (aForm.Date1.value!=""&&aForm.Date2.value!=""){
		  if (aForm.Date1.value>=aForm.Date2.value){
		    alert("奠基日期不能迟于开盘日期");
			aForm.Date2.focus();
			 return false;
		  }
		 }
		if (aForm.Date1.value!=""&&aForm.Date2.value!=""){
		  if (aForm.Date1.value>=aForm.Date2.value){
		    alert("奠基日期不能迟于开盘日期");
			aForm.Date2.focus();
			 return false;
		  }
		 }
		if (aForm.Date1.value!=""&&aForm.Date5.value!=""){
		  if (aForm.Date1.value>=aForm.Date5.value){
		    alert("奠基日期不能迟于开发日期");
			aForm.Date5.focus();
			 return false;
		  }
		 }
		if (aForm.Date1.value!=""&&aForm.Date6.value!=""){
		  if (aForm.Date1.value>=aForm.Date6.value){
		    alert("奠基日期不能迟于竣工日期");
			aForm.Date6.focus();
			 return false;
		  }
		 }
		 if (aForm.Date1.value!=""&&aForm.Date3.value!=""){
		  if (aForm.Date1.value>=aForm.Date3.value){
		    alert("奠基日期不能迟于交楼日期");
			aForm.Date3.focus();
			 return false;
		  }
		  }
		  if (aForm.Date1.value!=""&&aForm.Date4.value!=""){
		  if (aForm.Date1.value>=aForm.Date4.value){
		    alert("奠基日期不能迟于交楼日期");
			aForm.Date4.focus();
			 return false;
		  }
		  }
		   if (aForm.Date2.value!=""&&aForm.Date4.value!=""){
		  if (aForm.Date1.value>=aForm.Date4.value){
		    alert("开盘日期不能迟于交楼日期");
			aForm.Date4.focus();
			 return false;
		  }
		  }
		   if (aForm.Date2.value!=""&&aForm.Date4.value!=""){
		  if (aForm.Date2.value>=aForm.Date4.value){
		    alert("开盘日期不能迟于交楼日期");
			aForm.Date4.focus();
			 return false;
		  }
		  }
		 if (aForm.Date2.value!=""&&aForm.Date3.value!=""){
		  if (aForm.Date2.value>=aForm.Date3.value){
		    alert("开盘日期不能迟于交楼日期");
			aForm.Date3.focus();
			 return false;
		  }
		  }
		  if (aForm.Date5.value!=""&&aForm.Date6.value!=""){
		  if (aForm.Date5.value>=aForm.Date6.value){
		    alert("开发日期不能迟于竣工日期");
			aForm.Date6.focus();
			 return false;
		  }
		 }
		 
		 if (aForm.Date5.value!=""&&aForm.Date3.value!=""){
		  if (aForm.Date5.value>=aForm.Date3.value){
		    alert("开发日期不能迟于交楼日期");
			aForm.Date3.focus();
			 return false;
		  }
		  }
		  if (aForm.Date6.value!=""&&aForm.Date3.value!=""){
		  if (aForm.Date6.value>=aForm.Date3.value){
		    alert("竣工日期不能迟于交楼日期");
			aForm.Date3.focus();
			 return false;
		  }
		  }
		  
		   if (aForm.Date5.value!=""&&aForm.Date4.value!=""){
		  if (aForm.Date4.value<=aForm.Date5.value){
		    alert("开发日期早于预售日期");
			aForm.Date4.focus();
			 return false;
		  }
		  }
		  
		  if (aForm.Date3.value!=""&&aForm.Date4.value!=""){
		  if (aForm.Date4.value>=aForm.Date3.value){
		    alert("预售日期早于交楼日期");
			aForm.Date4.focus();
			 return false;
		  }
		  }
		  if (aForm.Date6.value!=""&&aForm.Date4.value!=""){
		  if (aForm.Date6.value>=aForm.Date4.value){
		    alert("竣工日期不能迟于交楼日期");
			aForm.Date4.focus();
			 return false;
		  }
		  }
		
	    return (true);
   }
   
   function setfocus()
   {
   		cus.SecName.focus();
		setSelectMad(cus.region,'<%=strRegion %>');
		setSelectMad(cus.Type,'<%=strType %>');
        setSelectMad(cus.company,'<%=company %>');
		
   }
//-->
</SCRIPT>

<body onload="setfocus()" class=formbg oncontextmenu="return false"   >

<form method="POST" name="cus" action="" onsubmit="return Validate(this);" >
<input type="hidden" name="ID" value="<%=ID%>">
    <p align="center"><b><font size="3" class=FontColor>修改项目资料</font></b></p>  
 <center>
<table width="100%" border="0" cellspacing="0" cellpadding="0" bordercolor="#ffffff" class="tablefill">
      <tr > 
        <td width="18%" class=roomleft   align="left" height="24"  >&nbsp;区域名称</td>
        <td width="18%" class=roomright  align="left" height="24"> 
          &nbsp;<select name="region" ><%
        for (int ii=0;ii<500;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("K"))
	       out.print("<option value="+CodeName[ii]+">"+CodeName[ii]+"</option>");
		  }
       }
	%>
		  </select>
         </td>
    
        <td width="18%" class=roomleft   align="left" height="24"  >&nbsp;项目名称</td>
        <td width="18%" class=roomright  align="left" height="24"> 
          &nbsp;<input type=text name=SecName size="12"   value="<%=strSecName%>">
          <font color=red>*</font></td>
      </tr>
      <tr  > 
        <td width="18%" class=roomleft   align="left" height="24"  >&nbsp;项目地址</td>
        <td width="18%" class=roomright  align="left" height="24"> 
          &nbsp;<input type=text name=SecArea size="12"   value="<%=strSecArea%>">
          <font color=red>*</font></td>
     
        <td width="18%" class=roomleft align="left"   height="24"  >&nbsp;项目编码</td>
        <td width="18%" class=roomright align="left"   height="24"> 
          <p align="left"> 
            &nbsp;<input type=text name=SecNo size="12"   value="<%=strSecNo%>" readonly>
            <font color=red>*</font></p>
        </td>
      </tr>
      <tr align="left" > 
        <td width="18%" class=roomleft align="left"   height="24"  >&nbsp;建筑面积</td>
        <td width="18%" class=roomright align="left"   height="24"> 
          &nbsp;<input type=text name=Area size="12"   OnChange="check(document.cus.Area)" value="<%=strArea%>">(M2)
        </td>
      
        <td width="18%" class=roomleft   align="left" height="24"  >&nbsp;占地面积</td>
        <td width="18%" class=roomright  align="left" height="24"> 
          &nbsp;<input type=text name=UseArea size="12"   OnChange="check(document.cus.UseArea);cr();" value="<%=strUseArea%>">(M2)
        </td>
      </tr>
	  <tr> 
        <td width="18%" class=roomleft   align="left" height="24"  >&nbsp;销售面积</td>
        <td width="18%" class=roomright  align="left" height="24"> 
          &nbsp;<input type=text name=SaleArea size="12" value="<%=strSaleArea %>"  OnChange="check(document.cus.UseArea);cr();">(M2)
        </td>
      
	   <td width="25%" class=roomleft>&nbsp;改造批准文号</td>
        <td width="25%"   class=roomright      > 
          &nbsp;<input type=text name=DH size="15"   value="<%=tudishiyong_no %>" onkeydown="key(document.cus.tdqyxz)"  >
        </td>
      </tr>
	   <tr> 
        <td width="25%"class=roomleft>&nbsp;国有土地使用证号</td>
        <td width="25%"  class=roomright      > 
          &nbsp;<input type=text name=gytzno size="15"  value="<%=gytzno %>" onkeydown="key(document.cus.tdsyqcrpzno)">
        </td>
     
        <td width="25%" class=roomleft>&nbsp;土地使用权出让合同号</td>
        <td width="25%"   class=roomright      > 
          &nbsp;<input type=text name=tdsyqcrpzno size="15" value="<%=tdsyqcrpzno %>" onkeydown="key(document.cus.tdqyxz)"  >
        </td>
      </tr>
	   <tr> 
        <td width="25%"class=roomleft>&nbsp;营业执照注册号</td>
        <td width="25%"  class=roomright      > 
          &nbsp;<input type=text name=yyzzh size="15"   value="<%=yyzzh %>"    onkeydown="key(document.cus.zzzsh)">
        </td>
     
        <td width="25%" class=roomleft>&nbsp;资质证书号</td>
        <td width="25%"   class=roomright      > 
          &nbsp;<input type=text name=zzzsh size="15" value="<%=zzzsh %>"  onkeydown="key(document.cus.fr)"  >
        </td>
      </tr>
	    <tr> 
        <td width="25%"class=roomleft>&nbsp;法定代表人</td>
        <td width="25%"  class=roomright      > 
          &nbsp;<input type=text name=fr size="15"   value="<%=fr %>"  onkeydown="key(document.cus.phone)">
        </td>
     
        <td width="25%" class=roomleft>&nbsp;联系电话</td>
        <td width="25%"   class=roomright      > 
          &nbsp;<input type=text name=phone size="15" value="<%=phone %>"  onkeydown="key(document.cus.frdz)"  >
        </td>
      </tr>
	   <tr> 
        <td width="25%"class=roomleft>&nbsp;法人地址</td>
        <td width="25%"  class=roomright      > 
          &nbsp;<input type=text name=frdz size="15"  value="<%=frdz %>"  onkeydown="key(document.cus.zipcode1)">
        </td>
     
        <td width="25%" class=roomleft>&nbsp;邮编</td>
        <td width="25%"   class=roomright      > 
          &nbsp;<input type=text name=zipcode1 size="15" value="<%=fryb %>"onkeydown="key(document.cus.zcadd)"  >
        </td>
      </tr>
	   <tr> 
        <td width="25%"class=roomleft>&nbsp;注册地址</td>
        <td width="25%"  class=roomright  colspan="3"     > 
          &nbsp;<input type=text name=zcadd size="52" value="<%=zcadd %>"   onkeydown="key(document.cus.tdsyqcrpzno)">
        </td>
     
        
      </tr>
	   <tr> 
        <td width="25%"class=roomleft>&nbsp;委托代理人</td>
        <td width="25%"  class=roomright      > 
          &nbsp;<input type=text name=dlr size="15"  value="<%=dlr %>"   onkeydown="key(document.cus.tdsyqcrpzno)">
        </td>
     
        <td width="25%" class=roomleft>&nbsp;联系电话</td>
        <td width="25%"   class=roomright      > 
          &nbsp;<input type=text name=phone1 size="15" value="<%=phone1 %>" onkeydown="key(document.cus.tdqyxz)"  >
        </td>
      </tr>
	  <tr> 
        <td width="25%"class=roomleft>&nbsp;代理人地址</td>
        <td width="25%"  class=roomright      > 
          &nbsp;<input type=text name=dlrdz size="15"  value="<%=dlrdz %>"   onkeydown="key(document.cus.tdsyqcrpzno)">
        </td>
     
        <td width="25%" class=roomleft>&nbsp;邮编</td>
        <td width="25%"   class=roomright      > 
          &nbsp;<input type=text name=zipcode size="15" value="<%=zipcode %>" onkeydown="key(document.cus.tdqyxz)"  >
        </td>
      </tr>
	  
	  	 
	     <tr> 
        <td width="25%"class=roomleft>&nbsp;土地权源性质</td>
        <td width="25%"  class=roomright      > 
          &nbsp;<input type=text name=tdqyxz size="15"   value="<%=tdqyxz %>"    onkeydown="key(document.cus.tdqsly)"> 
        </td>
     
        <td width="25%" class=roomleft>&nbsp;土地权属来源</td>
        <td width="25%"   class=roomright      > 
          &nbsp;<input type=text name=tdqsly size="15" value="<%=tdqsly %>"onkeydown="key(document.cus.ysxkzh)"  >
        </td>
      </tr>
	   <tr> 
        <td width="25%"class=roomleft>&nbsp;规划许可证号</td>
        <td width="25%"  class=roomright      > 
          &nbsp;<input type=text name=ghh size="15"   value="<%=guihua_no %>"       onkeydown="key(document.cus.sgxkh)"> 
        </td>
     
        <td width="25%" class=roomleft>&nbsp;施工许可证号</td>
        <td width="25%"   class=roomright      > 
          &nbsp;<input type=text name=sgxkh size="15"   value="<%=shigong_no %>"  onkeydown="key(document.cus.ysxkzh)"  >
        </td>
      </tr>
	   <tr> 
        <td width="25%"class=roomleft>&nbsp;预售许可证号</td>
        <td width="25%"  class=roomright      > 
          &nbsp;<input type=text name=ysxkzh size="15"   value="<%=yushou_no %>"  onkeydown="key(document.cus.wggs)">
        </td>
     
        <td width="25%" class=roomleft>&nbsp;物管公司</td>
        <td width="25%"   class=roomright      > 
          &nbsp;<input type=text name=wggs size="15" value="<%=wuyei_com %>"   onkeydown="key(document.cus.jg)"  >
        </td>
      </tr>
	   <tr> 
        <td width="25%"        class=roomleft>&nbsp;结&nbsp;&nbsp;&nbsp;构</td>
        <td width="25%" class=roomright      > 
          &nbsp;<input type=text name=jg  value="<%=jiegou %>" size="15" onkeydown="key(document.cus.Type)"  >
        </td>
      
        <td width="18%" class=roomleft   align="left" height="24"  >&nbsp;房&nbsp;&nbsp;&nbsp;类</td>
        <td width="18%" class=roomright  align="left" height="24"> 
          &nbsp;<select name=Type>
		    <%
        for (int ii=0;ii<500;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("C"))
	       out.print("<option value="+CodeName[ii]+">"+CodeName[ii]+"</option>");
		  }
        }
  %>
		  </select>
        </td>
      </tr>
	 <tr> 
        <td width="25%"        class=roomleft>&nbsp;取得地块方式</td>
        <td width="25%" class=roomright      > 
          &nbsp;<input type=text name=qddkfs size="12" value="<%=qddkfs %>" onkeydown="key(document.cus.CubageRate)"  > 
        </td>
     
        <td width="25%"        class=roomleft>&nbsp;容积率</td>
        <td width="25%" class=roomright      > 
          &nbsp;<input type=text name=CubageRate size="12" value=0 onkeydown="key(document.cus.GreenRate)"  OnChange="check(document.cus.CubageRate)"> <font color=red>*</font>
        </td>
      </tr>

      <tr>     
        <td width="18%" class=roomleft   align="left" height="23"  >&nbsp;绿化率</td>
        <td width="18%" class=roomright  align="left" height="23"> 
          &nbsp;<input type=text name=GreenRate size="12"    OnChange="check(document.cus.GreenRate)" value="<%=strGreenRate%>">(%) 
        </td>
       <td width="18%" class=roomleft   align="left" height="23"  >&nbsp;奠基日期</td>
        <td width="18%" class=roomright  align="left" height="23"> 
		 &nbsp;<INPUT TYPE=TEXT NAME=Date1 size=10 value="<%=strSetDate %>"> <input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;">		 
         </td>
      </tr>


	   <tr align="left" >      
        <td width="18%" class=roomleft align="left"   height="14"  >&nbsp;开盘日期</td>
        <td width="18%" class=roomright align="left"   height="14">
         &nbsp;<INPUT TYPE=TEXT NAME=Date2 size=10 value=<%=strOpendate %>><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date2);return false;"></td>

        </td>

     
        <td width="18%" class=roomleft align="left"   height="14"  >&nbsp;竣工日期</td>
        <td width="18%" class=roomright align="left"   height="14"> 
          &nbsp;<INPUT TYPE=TEXT NAME=Date6 size=10 value="<%=strJgDate %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date6);return false;"></td>

          </td>

      </tr>
	  
	  
	   <tr align="left" >      
        <td width="18%" class=roomleft align="left"   height="14"  >&nbsp;开发日期</td>
        <td width="18%" class=roomright align="left"   height="14">
         &nbsp;<INPUT TYPE=TEXT NAME=Date5 size=10 value=<%=strFdDate %>><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date5);return false;"></td>

     </td>

     
        <td width="18%" class=roomleft align="left"   height="14"  >&nbsp;预售日期</td>
        <td width="18%" class=roomright align="left"   height="14"> 
          &nbsp;<INPUT TYPE=TEXT NAME=Date4 size=10 value="<%=strFactDate %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date4);return false;"></td>
 </td>

      </tr>
	  
      <tr align="left" > 
         <td width="18%" class=roomleft align="left"   height="14"  >&nbsp;交楼日期</td>
        <td width="18%" class=roomright align="left"   height="14">
         &nbsp;<INPUT TYPE=TEXT NAME=Date3 size=10 value=<%=strOfferdate %>><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date3);return false;"></td>
                <td width="18%" class=roomleft align="left"   height="14"  >&nbsp;实用率</td>
        <td width="18%" class=roomright align="left"   height="14"> 
          &nbsp;<input type=text name=RealRate size="12"   OnChange="check(document.cus.RealRate)" value="<%=strRealRate%>">(%)
        </td>
      </tr>
      <tr align="left" > 
  
          <td width="18%" class=roomleft align="left"   height="14"  >&nbsp;总户数</td>
        <td width="18%" class=roomright align="left"   height="14"> 
          &nbsp;<input type=text name=FamilyCount size="12"   OnChange="check(document.cus.FamilyCount)" value="<%=strFamilyCount%>">(户)
        </td>
      
        <td width="18%" class=roomleft align="left"   height="24"  >&nbsp;管理费</td>
        <td width="18%" class=roomright align="left"   height="24"> 
          &nbsp;<input type=text name=ManageFee size="12"   OnChange="check(document.cus.ManageFee)" value="<%=strManageFee%>">(元/M2)
        </td>
      </tr>
	   <tr> 
	   <td width="25%"     height="14"  class=roomleft>&nbsp;发展商</td>
        <td width="25%" class=roomright     height="14" colspan="3"> 
          &nbsp;<input type=text name=developcom size="40"  onkeydown="key(document.cus.investcom)" value="<%=strdevelopcom%>">
        </td>
		</tr>
		 <input type=hidden name=cg size="10" value=3>
	  <input type=hidden name=useyear size="10" value=70>
	  <INPUT TYPE=hidden NAME=ed  onkeydown="key(document.cus.ed)" size=10>
	  <INPUT TYPE=hidden NAME=sd  onkeydown="key(document.cus.sd)" size=10>
		
		<tr>
        <td width="25%"        class=roomleft>&nbsp;投资商</td>
        <td width="25%" class=roomright colspan="3"> 
          &nbsp;<input type=text name=investcom size="40" onkeydown="key(document.cus.Intro)" value="<%=strinvestcom%>">
		</td>
      </tr><tr>
       
		<td width="25%"        class=roomleft>&nbsp;所属公司</td>
        <td width="25%" class=roomright > 
          &nbsp;<select name="company"><option></option>
		  <%
             StrSql="select CompanyName  from company  ";
             codeRS=null;
		   codeRS=ViewBean.executeQuery(StrSql);
		   String CompanyName="";
		   while (codeRS.next()){
		     CompanyName=getbyte(codeRS.getString("CompanyName"));
			  out.print("<option value='"+CompanyName+"'>"+CompanyName+"</option>");
		   }
		   codeRS.close();
		   %>
		  </select> 
		</td>
      </tr>
	   <tr> 
	   <td width="25%"     height="14"  class=roomleft>&nbsp;备注</td>
        <td width="25%" class=roomright     height="14" colspan="3"> 
          &nbsp;<textarea rows="3" name="comnote" cols="60"  ><%=strcomnote%></textarea>
        </td>
		</tr>
      <tr> 
        <td width="18%" class=roomleft   align="left" height="23"  >&nbsp;楼盘介绍</td>
        <td width="18%" class=roomright  align="left" height="23" colspan=3> 
          &nbsp;<textarea rows="3" name="Intro" cols="60"  ><%=strIntro%></textarea>
        </td>
      <tr> 
	     </table> 
		     
         <p align="center"> <input type=button name=submit1 value="提 交" onclick="loca();"></p>
 		 <p align="center"> <input type=button name=submit2 value="退 出" onclick="window.close();">


		<script>
		function loca(){
		   if (confirm("真的要修改楼盘信息吗？")){
		     if (Validate(document.cus)){
		     document.cus.action="crm_project_modi_Update.jsp";
  		     document.cus.submit();
            }		
		  }
		 } 
		</script>
     
</form>      
       <%    }catch(Exception s){out.print("异常错误:"+s);} %>   
</body>       
</html>       
