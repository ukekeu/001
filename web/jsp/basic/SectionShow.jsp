<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/mad.css" rel=stylesheet>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>楼盘资料</title>
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
<%@ include file="../public_js/getByteOut.jsp"%>
<%
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
String struseyear="";
String strcomnote="";
sql="select * from CRM_Project where code="+ID+" order by code DESC";
ResultSet rs=ViewBean.executeQuery(sql);
while (rs.next()){
    strRegion=getbyte(rs.getString("Region"));
	strSecName=getbyte(rs.getString("Name"));
	strSecArea=getbyte(rs.getString("AreaNo"));
	strSecNo=rs.getString("SerialNo");
	strArea=rs.getString("TotalArea");
	strUseArea=rs.getString("GroundArea");
	strSaleArea=rs.getString("SaleArea");
	strFitment=getbyte(rs.getString("Fitment"));
	strType=getbyte(rs.getString("Type"));
	strCubageRate=rs.getString("CubageRate");
	strGreenRate=rs.getString("GreenRate");
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
	strRealRate=rs.getString("RealRate");
	strManageFee=rs.getString("ManageFee");
	strdevelopcom=getbyte(rs.getString("developcom"));
	
	strinvestcom=getbyte(rs.getString("investcom"));
	struseyear=getbyte(rs.getString("useyear"));
	strcomnote=getbyte(rs.getString("comnote"));
	strIntro=getbyte(rs.getString("Intro"));
	strDH=getbyte(rs.getString("DH"));
	strLS=getbyte(rs.getString("LS"));
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
		    alert("奠基日期不能迟于封顶日期");
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
		    alert("奠基日期不能迟于实际交楼日期");
			aForm.Date4.focus();
			 return false;
		  }
		  }
		   if (aForm.Date2.value!=""&&aForm.Date4.value!=""){
		  if (aForm.Date1.value>=aForm.Date4.value){
		    alert("开盘日期不能迟于实际交楼日期");
			aForm.Date4.focus();
			 return false;
		  }
		  }
		   if (aForm.Date2.value!=""&&aForm.Date4.value!=""){
		  if (aForm.Date2.value>=aForm.Date4.value){
		    alert("开盘日期不能迟于实际交楼日期");
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
		    alert("封顶日期不能迟于竣工日期");
			aForm.Date6.focus();
			 return false;
		  }
		 }
		 
		 if (aForm.Date5.value!=""&&aForm.Date3.value!=""){
		  if (aForm.Date5.value>=aForm.Date3.value){
		    alert("封顶日期不能迟于交楼日期");
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
		  if (aForm.Date5.value>=aForm.Date4.value){
		    alert("封顶日期不能迟于实际交楼日期");
			aForm.Date4.focus();
			 return false;
		  }
		  }
		  if (aForm.Date6.value!=""&&aForm.Date4.value!=""){
		  if (aForm.Date6.value>=aForm.Date4.value){
		    alert("竣工日期不能迟于实际交楼日期");
			aForm.Date4.focus();
			 return false;
		  }
		  }
		
	    return (true);
   }
   
   function setfocus()
   {
   		 
		setSelectMad(cus.region,'<%=strRegion %>');
		setSelectMad(cus.Type,'<%=strType %>');
   }
//-->
</SCRIPT>

<body  class=formbg onload="setfocus();">
 
<form method="POST" name="cus" action="" onsubmit="return Validate(this);"  ENCTYPE="multipart/form-data">
<input type="hidden" name="ID" value="<%=ID%>">
    <p align="center"><b><font size="3" class=FontColor>楼盘资料</font></b></p>  
 <center>
<table width="100%" border="0" cellspacing="0" cellpadding="0" bordercolor="#ffffff" class="tablefill">
      <tr > 
        <td width="18%" class=roomleft   align="left" height="24"  >&nbsp;区域名称</td>
        <td width="18%" class=roomright  align="left" height="24"> 
          &nbsp;<select name="region" ><%
        for (int ii=0;ii<200;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("K"))
	       out.print("<option value='"+CodeName[ii]+"'>"+CodeName[ii]+"</option>");
		  }
       }
	%>
		  </select>
         </td>
    
        <td width="18%" class=roomleft   align="left" height="24"  >&nbsp;楼盘名称</td>
        <td width="18%" class=roomright  align="left" height="24"> 
          &nbsp;<input TYPE=TEXT  disabled name=SecName size="12"   value="<%=strSecName%>">
          <font color=red>*</font></td>
      </tr>
      <tr  > 
        <td width="18%" class=roomleft   align="left" height="24"  >&nbsp;楼盘地段</td>
        <td width="18%" class=roomright  align="left" height="24"> 
          &nbsp;<input TYPE=TEXT  disabled name=SecArea size="12"   value="<%=strSecArea%>">
          <font color=red>*</font></td>
     
        <td width="18%" class=roomleft align="left"   height="24"  >&nbsp;楼盘编码</td>
        <td width="18%" class=roomright align="left"   height="24"> 
          <p align="left"> 
            &nbsp;<input TYPE=TEXT  disabled name=SecNo size="12"   value="<%=strSecNo%>" readonly>
            <font color=red>*</font></p>
        </td>
      </tr>
      <tr align="left" > 
        <td width="18%" class=roomleft align="left"   height="24"  >&nbsp;建筑面积</td>
        <td width="18%" class=roomright align="left"   height="24"> 
          &nbsp;<input TYPE=TEXT  disabled name=Area size="12"   OnChange="check(document.cus.Area)" value="<%=strArea%>">(M2)
        </td>
      
        <td width="18%" class=roomleft   align="left" height="24"  >&nbsp;占地面积</td>
        <td width="18%" class=roomright  align="left" height="24"> 
          &nbsp;<input TYPE=TEXT  disabled name=UseArea size="12"   OnChange="check(document.cus.UseArea);cr();" value="<%=strUseArea%>">(M2)
        </td>
      </tr>
	  <tr> 
        <td width="18%" class=roomleft   align="left" height="24"  >&nbsp;销售面积</td>
        <td width="18%" class=roomright  align="left" height="24"> 
          &nbsp;<input TYPE=TEXT  disabled name=SaleArea size="12" value="<%=strSaleArea %>"  OnChange="check(document.cus.UseArea);cr();">(M2)
        </td>
     
        <td width="18%" class=roomleft   align="left" height="24"  >&nbsp;地&nbsp;&nbsp;&nbsp;号</td>
        <td width="18%" class=roomright  align="left" height="24"> 
          &nbsp;<input TYPE=TEXT  disabled name=DH size="12" value="<%=strDH %>" >
        </td>
      </tr>
	  <tr> 
        <td width="18%" class=roomleft   align="left" height="24"  >&nbsp;隶&nbsp;&nbsp;&nbsp;属</td>
        <td width="18%" class=roomright  align="left" height="24"> 
          &nbsp;<input TYPE=TEXT  disabled name=LS size="12"  value="<%=strLS %>" >
        </td>
      
        <td width="18%" class=roomleft   align="left" height="24"  >&nbsp;用&nbsp;&nbsp;&nbsp;途</td>
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
        <td width="18%" class=roomleft   align="left" height="24"  >&nbsp;装修标准</td>
        <td width="18%" class=roomright  align="left" height="24"> 
          &nbsp;<input TYPE=TEXT  disabled name=Fitment size="12" value="<%=strFitment %>"  >
        </td>
    <td width="18%" class=roomleft   align="left" height="24"  >&nbsp;容积率</td>
        <td width="18%" class=roomright  align="left" height="24"> 
          &nbsp;<input TYPE=TEXT  disabled name=CubageRate size="12"   OnChange="check(document.cus.CubageRate)" value="<%=strCubageRate%>"> 
        </td>    
      </tr>

      <tr>     
        <td width="18%" class=roomleft   align="left" height="23"  >&nbsp;绿化率</td>
        <td width="18%" class=roomright  align="left" height="23"> 
          &nbsp;<input TYPE=TEXT  disabled name=GreenRate size="12"    OnChange="check(document.cus.GreenRate)" value="<%=strGreenRate%>">(%) 
        </td>
       <td width="18%" class=roomleft   align="left" height="23"  >&nbsp;奠基日期</td>
        <td width="18%" class=roomright  align="left" height="23"> 
		 &nbsp;<INPUT TYPE=TEXT  disabled NAME=Date1 size=10 value=<%=strSetDate %>>	 
         </td>
      </tr>


	   <tr align="left" >      
        <td width="18%" class=roomleft align="left"   height="14"  >&nbsp;开盘日期</td>
        <td width="18%" class=roomright align="left"   height="14">
         &nbsp;<INPUT TYPE=TEXT  disabled NAME=Date2 size=10 value=<%=strOpendate %>></td>

        <td width="18%" class=roomleft align="left"   height="14"  >&nbsp;交楼日期</td>
        <td width="18%" class=roomright align="left"   height="14"> 
          &nbsp;<INPUT TYPE=TEXT  disabled NAME=Date3 size=10 value=<%=strOfferdate %>></td>

      </tr>
      <tr align="left" >      
        <td width="18%" class=roomleft align="left"   height="14"  >&nbsp;竣工日期</td>
        <td width="18%" class=roomright align="left"   height="14"> 
          &nbsp;<INPUT TYPE=TEXT  disabled NAME=Date6 size=10 value=<%=strJgDate %>></td>
        <td width="18%" class=roomleft align="left"   height="14"  >&nbsp;实交日期</td>
        <td width="18%" class=roomright align="left"   height="14"> 
          &nbsp;<INPUT TYPE=TEXT  disabled NAME=Date4 size=10 value=<%=strFactDate %>></td>

      </tr>
      <tr align="left" > 

         <td width="18%" class=roomleft align="left"   height="14"  >&nbsp;封顶日期</td>
        <td width="18%" class=roomright align="left"   height="14">
         &nbsp;<INPUT TYPE=TEXT  disabled NAME=Date5 size=10 value=<%=strFdDate %>></td>
     
           <td width="18%" class=roomleft align="left"   height="14"  >&nbsp;实用率</td>
        <td width="18%" class=roomright align="left"   height="14"> 
          &nbsp;<input TYPE=TEXT  disabled name=RealRate size="12"   OnChange="check(document.cus.RealRate)" value="<%=strRealRate%>">(%)
        </td>
      </tr>
      <tr align="left" > 
  
          <td width="18%" class=roomleft align="left"   height="14"  >&nbsp;总户数</td>
        <td width="18%" class=roomright align="left"   height="14"> 
          &nbsp;<input TYPE=TEXT  disabled name=FamilyCount size="12"   OnChange="check(document.cus.FamilyCount)" value="<%=strFamilyCount%>">(户)
        </td>
      
        <td width="18%" class=roomleft align="left"   height="24"  >&nbsp;管理费</td>
        <td width="18%" class=roomright align="left"   height="24"> 
          &nbsp;<input TYPE=TEXT  disabled name=ManageFee size="12"   OnChange="check(document.cus.ManageFee)" value="<%=strManageFee%>">(元/M2)
        </td>
      </tr>
	   <tr> 
	   <td width="25%"     height="14"  class=roomleft>&nbsp;发展商</td>
        <td width="25%" class=roomright     height="14" colspan="3"> 
          &nbsp;<input TYPE=TEXT  disabled name=developcom size="40"  onkeydown="key(document.cus.investcom)" value="<%=strdevelopcom%>">
        </td>
		</tr>
		<tr>
        <td width="25%"        class=roomleft>&nbsp;投资商</td>
        <td width="25%" class=roomright colspan="3"> 
          &nbsp;<input TYPE=TEXT  disabled name=investcom size="40" onkeydown="key(document.cus.Intro)" value="<%=strinvestcom%>">
		</td>
      </tr>
		<tr>
        <td width="25%"        class=roomleft>&nbsp;使用年限</td>
        <td width="25%" class=roomright colspan="3"> 
          &nbsp;<input TYPE=TEXT  disabled name=useyear size="20" value="<%=struseyear%>">
		</td>
      </tr>
	   <tr> 
	   <td width="25%"     height="14"  class=roomleft>&nbsp;备注</td>
        <td width="25%" class=roomright     height="14" colspan="3"> 
          &nbsp;<textarea rows="3" name="comnote" cols="30"  ><%=strcomnote%></textarea>
        </td>
		</tr>
      <tr> 
        <td width="18%" class=roomleft   align="left" height="23"  >&nbsp;楼盘介绍</td>
        <td width="18%" class=roomright  align="left" height="23" colspan=3> 
          &nbsp;<textarea rows="3" name="Intro" cols="40"  ><%=strIntro%></textarea>
        </td>
      <tr> 
	     </table> 
		<table width="58%" align=left border="0" cellspacing="0" bgcolor="#ffffff"  cellpadding="0" bordercolor="#dbdbdb" class="tablefill">
          <INPUT     TYPE=HIDDEN  name="SerialNo" >
		
       </table>     
         
 		 <p align="center"> <INPUT     type=button name=submit2 value="退 出" onclick="window.close();">


		<script>
		function loca(){
		   if (confirm("真的要修改楼盘信息吗？")){
		     if (Validate(document.cus)){
		     document.cus.action="SectionUpdate.jsp";
  		     document.cus.submit();
            }		
		  }
		 } 
		</script>
     
</form>      
       
</body>       
</html>       
