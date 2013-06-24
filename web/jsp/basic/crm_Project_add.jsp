<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 <html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>楼盘资料</title>
 <%@ page language="java" import="java.sql.*" %>
  <jsp:useBean id="VBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <%@ include file="../public_js/getByteOut.jsp"%>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>

  
<%

//使用
  try{
 String StrSql="select type,codename from CODE order by type";
   ResultSet codeRS=null;
   String CodeName[]=new String[500];
   String CodeType[]=new String[500];
    codeRS=VBean.executeQuery(StrSql);
   int i=0;
   while (codeRS.next()){
     CodeType[i]=codeRS.getString("type");
     CodeName[i]=getbyte(codeRS.getString("codename"));
	 i++;
   }
   codeRS.close();
 %>

<%
			     String Sql="select  Name from CRM_Project group by Name";
                 ResultSet Rs=ViewBean.executeQuery(Sql);
                 out.print("<script>");
                 out.print("var SecionAr=new Array();");
                 int i1=0;
                 while (Rs.next()){
                 out.print("SecionAr["+String.valueOf(i1)+"]="+"\""+getbyte(Rs.getString("Name"))+"\""+";");
              	 i1++;
                }	 
				 
		       out.print("</script>");	
            %> 
<script>
 
function FindName(para){
 
	if (para=="")return;
    for (var j=0;j<SecionAr.length;j++){
	  if (para==SecionAr[j]){
		alert("楼盘："+para+"已经输入") ;
		}
		else{
		 return;
		}
	 }	 
	 
  }		
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

</head>
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script Language="JavaScript" src="../public_js/basal.js"></script>
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
		if (aForm.SecNo.value.length<1)
		{
	        alert("请输入楼盘编码！");
	        aForm.SecNo.focus();
	        return false;
		}
		
		 
		if (aForm.SecNo.value.length>0)
		{
	        onlychinese(aForm.SecNo.value); 
	      
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
		    alert("奠基日期不能迟于封顶日期");
			aForm.Date5.focus();
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
		if (aForm.Date1.value!=""&&aForm.Date6.value!=""){
		  if (aForm.Date1.value>=aForm.Date6.value){
		    alert("奠基日期不能迟于竣工日期");
			aForm.Date6.focus();
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
		
		
		  if (aForm.Date5.value!=""&&aForm.Date6.value!=""){
		  if (aForm.Date5.value>=aForm.Date6.value){
		    alert("预售日期不能迟于竣工日期");
			aForm.Date6.focus();
			 return false;
		  }
		 }
		 if (aForm.Date3.value=="")
		{
	        alert("请选择交楼日期");
	        aForm.Date3.focus();
	        return false;
		}
		    return (true);
   }
   
   
    function onlychinese(para)  {
	 var upp="ABCDEFGHIJKLMNOPQRSTUVWXYZ ";
	 
	 var aap=para.toUpperCase();
	
	  for (var aa=0;aa<aap.length;aa++){
	 
	  if (upp.indexOf(aap.substring(aa,aa+1))<0)
	  {
	     alert("楼盘编码只能用字母");
	     aForm.SecNo.focus();
	        return false;
	  }
	 
	 }
} 

//-->
</SCRIPT>
<body oncontextmenu="return false"   >

<form method="POST" name="cus" action="">
 
 
    <p align="center"><b><font class=FontColor size="3" ><b>录入项目资料</font></b></p>  

<table width="100%" border="0" cellspacing="0"   cellpadding="0" bordercolor="#FFFFFF" class="tablefill">
       <tr > 
        <td width="25%" class=roomleft>&nbsp;区域名称</td>
        <td width="25%" class=roomright> 
          &nbsp;<select name="region" >
			<%
        for (int ii=0;ii<500;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("K"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
	%>
		  </select>
         </td>
      
        <td width="25%"        class=roomleft>&nbsp;楼盘名称</td>
        <td width="25%" class=roomright      > 
          &nbsp;<input type=text name=SecName size="12" onblur="FindName(this.value);" onkeydown="key(document.cus.SecArea);" >
          <font color=red>*</font></td>
      </tr>
      <tr  > 
        <td width="25%"        class=roomleft>&nbsp;项目地址</td>
        <td width="25%" class=roomright      > 
          &nbsp;<input type=text name=SecArea size="12" onkeydown="key(document.cus.SecNo)" >
          <font color=red>*</font></td>
      
        <td width="25%"        class=roomleft>&nbsp;项目编码</td>
        <td width="25%" class=roomright      > 
          <p  > 
            &nbsp;<input type=text name=SecNo size="12"   OnChange="onlychinese(this.value);"  onkeydown="key(document.cus.Area)" title="(只能由英文字母、数字及-组成)">
            <font color=red>*</font></p>
        </td>
      </tr>
      <tr   > 
        <td width="25%"        class=roomleft>&nbsp;建筑面积</td>
        <td width="25%" class=roomright      > 
          &nbsp;<input type=text name=Area size="10" value=0     OnChange="check(document.cus.Area)" onkeydown="key(document.cus.UseArea)">(M2)<font color=red>*</font>
        </td>
      
        <td width="25%"class=roomleft>&nbsp;占地面积</td>
        <td width="25%"  class=roomright      > 
          &nbsp;<input type=text name=UseArea size="10" value=0     OnChange="check(document.cus.UseArea);cr();" onkeydown="key(document.cus.SaleArea)">(M2)<font color=red>*</font>
        </td>
      </tr>
	  <tr> 
        <td width="25%"class=roomleft>&nbsp;销售面积</td>
        <td width="25%"  class=roomright      > 
          &nbsp;<input type=text name=SaleArea size="12"   value=0     OnChange="check(document.cus.UseArea);cr();" onkeydown="key(document.cus.DH)">(M2)
        </td>
     
        <td width="25%" class=roomleft>&nbsp;改造批准文号</td>
        <td width="25%"   class=roomright      > 
          &nbsp;<input type=text name=DH size="15" onkeydown="key(document.cus.yyzzh)"  >
        </td>
      </tr>
	   <tr> 
        <td width="25%"class=roomleft>&nbsp;国有土地使用证号</td>
        <td width="25%"  class=roomright      > 
          &nbsp;<input type=text name=gytzno size="15"    onkeydown="key(document.cus.tdsyqcrpzno)">
        </td>
     
        <td width="25%" class=roomleft>&nbsp;土地使用权出让合同号</td>
        <td width="25%"   class=roomright      > 
          &nbsp;<input type=text name=tdsyqcrpzno size="15" onkeydown="key(document.cus.tdqyxz)"  >
        </td>
      </tr>
	   <tr> 
        <td width="25%"class=roomleft>&nbsp;营业执照注册号</td>
        <td width="25%"  class=roomright      > 
          &nbsp;<input type=text name=yyzzh size="15"    onkeydown="key(document.cus.zzzsh)">
        </td>
     
        <td width="25%" class=roomleft>&nbsp;资质证书号</td>
        <td width="25%"   class=roomright      > 
          &nbsp;<input type=text name=zzzsh size="15" onkeydown="key(document.cus.fr)"  >
        </td>
      </tr>
	    <tr> 
        <td width="25%"class=roomleft>&nbsp;法定代表人</td>
        <td width="25%"  class=roomright      > 
          &nbsp;<input type=text name=fr size="15"    onkeydown="key(document.cus.phone)">
        </td>
     
        <td width="25%" class=roomleft>&nbsp;联系电话</td>
        <td width="25%"   class=roomright      > 
          &nbsp;<input type=text name=phone size="15" onkeydown="key(document.cus.frdz)"  >
        </td>
      </tr>
	   <tr> 
        <td width="25%"class=roomleft>&nbsp;法人地址</td>
        <td width="25%"  class=roomright      > 
          &nbsp;<input type=text name=frdz size="15"    onkeydown="key(document.cus.zipcode1)">
        </td>
     
        <td width="25%" class=roomleft>&nbsp;邮编</td>
        <td width="25%"   class=roomright      > 
          &nbsp;<input type=text name=zipcode1 size="15" onkeydown="key(document.cus.zcadd)"  >
        </td>
      </tr>
	  <tr> 
        <td width="25%"class=roomleft>&nbsp;注册地址</td>
        <td width="25%"  class=roomright  colspan="3"     > 
          &nbsp;<input type=text name=zcadd size="52"    onkeydown="key(document.cus.tdsyqcrpzno)">
        </td>
     
        
      </tr>
	   <tr> 
        <td width="25%"class=roomleft>&nbsp;委托代理人</td>
        <td width="25%"  class=roomright      > 
          &nbsp;<input type=text name=dlr size="15"    onkeydown="key(document.cus.tdsyqcrpzno)">
        </td>
     
        <td width="25%" class=roomleft>&nbsp;联系电话</td>
        <td width="25%"   class=roomright      > 
          &nbsp;<input type=text name=phone1 size="15" onkeydown="key(document.cus.tdqyxz)"  >
        </td>
      </tr>
	  <tr> 
        <td width="25%"class=roomleft>&nbsp;代理人地址</td>
        <td width="25%"  class=roomright      > 
          &nbsp;<input type=text name=dlrdz size="15"    onkeydown="key(document.cus.tdsyqcrpzno)">
        </td>
     
        <td width="25%" class=roomleft>&nbsp;邮编</td>
        <td width="25%"   class=roomright      > 
          &nbsp;<input type=text name=zipcode size="15" onkeydown="key(document.cus.tdqyxz)"  >
        </td>
      </tr>
	 
	   <tr> 
        <td width="25%"class=roomleft>&nbsp;土地权源性质</td>
        <td width="25%"  class=roomright      > 
          &nbsp;<input type=text name=tdqyxz size="15"   value=0    onkeydown="key(document.cus.tdqsly)"> 
        </td>
     
        <td width="25%" class=roomleft>&nbsp;土地权属来源</td>
        <td width="25%"   class=roomright      > 
          &nbsp;<input type=text name=tdqsly size="15" onkeydown="key(document.cus.ysxkzh)"  >
        </td>
      </tr>
	   <tr> 
        <td width="25%"class=roomleft>&nbsp;规划许可证号</td>
        <td width="25%"  class=roomright      > 
          &nbsp;<input type=text name=ghh size="15"   value=0    onkeydown="key(document.cus.sgxkh)"> 
        </td>
     
        <td width="25%" class=roomleft>&nbsp;施工许可证号</td>
        <td width="25%"   class=roomright      > 
          &nbsp;<input type=text name=sgxkh size="15" onkeydown="key(document.cus.ysxkzh)"  >
        </td>
      </tr>
	   <tr> 
        <td width="25%"class=roomleft>&nbsp;预售许可证号</td>
        <td width="25%"  class=roomright      > 
          &nbsp;<input type=text name=ysxkzh size="15"   value=0     onkeydown="key(document.cus.wggs)">
        </td>
     
        <td width="25%" class=roomleft>&nbsp;物管公司</td>
        <td width="25%"   class=roomright      > 
          &nbsp;<input type=text name=wggs size="15" onkeydown="key(document.cus.jg)"  >
        </td>
      </tr>
	  <tr> 
        <td width="25%"        class=roomleft>&nbsp;结&nbsp;&nbsp;&nbsp;构</td>
        <td width="25%" class=roomright      > 
          &nbsp;<input type=text name=jg size="15" onkeydown="key(document.cus.Type)"  >
        </td>
     
        <td width="25%"        class=roomleft>&nbsp;房&nbsp;&nbsp;&nbsp;类</td>
        <td width="25%" class=roomright      > 
          &nbsp;<select name=Type onkeydown="key(document.cus.qddkfs)">
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
          &nbsp;<input type=text name=qddkfs size="12" onkeydown="key(document.cus.CubageRate)"  > 
        </td>
     
        <td width="25%"        class=roomleft>&nbsp;容积率</td>
        <td width="25%" class=roomright      > 
          &nbsp;<input type=text name=CubageRate size="12" value=0 onkeydown="key(document.cus.GreenRate)"  OnChange="check(document.cus.CubageRate)"> <font color=red>*</font>
        </td>
      </tr>
      <tr  > 
        <td width="25%"        class=roomleft>&nbsp;绿化率</td>
        <td width="25%" class=roomright      > 
          &nbsp;<input type=text name=GreenRate size="10" value=0  onkeydown="key(document.cus.Date1)"   OnChange="check(document.cus.GreenRate)">(%) <font color=red>*</font>
        </td>
      
        <td width="25%"        class=roomleft>&nbsp;奠基日期</td>
        <td width="25%" class=roomright      > 
		 &nbsp;<INPUT TYPE=TEXT NAME=Date1  onkeydown="key(document.cus.Date5)" size=10><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;">
		 
         </td>
     
        </tr>
      <tr   > 
        <td width="25%"     height="14"  class=roomleft>&nbsp;开盘日期</td>
        <td width="25%" class=roomright     height="14">
         &nbsp;<INPUT TYPE=TEXT NAME=Date2  onkeydown="key(document.cus.Date3)" size=10><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date2);return false;"></td>
     
        </td>
    
        <td width="25%"     height="14"  class=roomleft>&nbsp;竣工日期</td>
        <td width="25%" class=roomright     height="14"> 
          &nbsp;<INPUT TYPE=TEXT NAME=Date6  onkeydown="key(document.cus.Date4)" size=10><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date6);return false;"></td>
      </td>
      </tr>
	  
	  
	  <tr   > 
        <td width="25%"     height="14"  class=roomleft>&nbsp;开发日期</td>
        <td width="25%" class=roomright     height="14">
         &nbsp;<INPUT TYPE=TEXT NAME=Date5  onkeydown="key(document.cus.Date4)" size=10><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date5);return false;"></td>
      </td>
    
        <td width="25%"     height="14"  class=roomleft>&nbsp;预售日期</td>
        <td width="25%" class=roomright     height="14"> 
          &nbsp;<INPUT TYPE=TEXT NAME=Date4  onkeydown="key(document.cus.Date3)" size=10><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date4);return false;"></td>
  
              </tr>
	  
      <tr   > 
	    <td width="25%"     height="14"  class=roomleft>&nbsp;交楼日期</td>
        <td width="25%" class=roomright     height="14">
         &nbsp;<INPUT TYPE=TEXT NAME=Date3  onkeydown="key(document.cus.Date2)" size=10><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date3);return false;"><font color=red>*</font></td>
    
       
      
        <td width="25%"     height="14"  class=roomleft>&nbsp;实用率</td>
        <td width="25%" class=roomright     height="14"> 
          &nbsp;<input type=text name=RealRate size="10" value=0  onkeydown="key(document.cus.ManageFee)"  OnChange="check(document.cus.RealRate)">(%)<font color=red>*</font>
        </td>
      </tr>
      <tr> 
	   <td width="25%"     height="14"  class=roomleft>&nbsp;总户数</td>
        <td width="25%" class=roomright     height="14"> 
          &nbsp;<input type=text name=FamilyCount size="10" value=0  onkeydown="key(document.cus.RealRate)"  OnChange="check(document.cus.FamilyCount)">(户)<font color=red>*</font>
        </td>
        <td width="25%"        class=roomleft>&nbsp;管理费</td>
        <td width="25%" class=roomright       > 
          &nbsp;<input type=text name=ManageFee size="8"   value=0  onkeydown="key(document.cus.developcom)" OnChange="check(document.cus.ManageFee)" >(元/M2)<font color=red>*</font>
        </td>
      </tr>
	   <tr> 
	   <td width="25%"     height="14"  class=roomleft>&nbsp;发展商</td>
        <td width="25%" class=roomright     height="14" colspan="3"> 
          &nbsp;<input type=text name=developcom size="40"  onkeydown="key(document.cus.investcom)"><font color=red>*</font>
        </td>
		</tr>
		<tr>
        <td width="25%"        class=roomleft>&nbsp;投资商</td>
        <td width="25%" class=roomright colspan="3"> 
          &nbsp;<input type=text name=investcom size="40" onkeydown="key(document.cus.Intro)"><font color=red>*</font>
		</td>
      </tr>
	  <input type=hidden name=cg size="10" value=3>
	  <input type=hidden name=useyear size="10" value=70>
	  <INPUT TYPE=hidden NAME=ed  onkeydown="key(document.cus.ed)" size=10>
	  <INPUT TYPE=hidden NAME=sd  onkeydown="key(document.cus.sd)" size=10>
		 
	  <tr>
        
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
          &nbsp;<textarea rows="3" name="comnote" cols="60"  ></textarea>
        </td>
		</tr>		
      <tr> 
        <td width="25%"        class=roomleft>&nbsp;楼盘介绍</td>
        <td width="25%" class=roomright       colspan=3> 
          &nbsp;<textarea rows="3" name="Intro" cols="60"  ></textarea>
        </td>
	  </tr>
	</TABLE>
	    
    
         <p align="center"> <input type=button name=submit1 value="提 交" onclick="loca();"></p>
 		 <p align="center"> <input type=button name=submit2 value="退 出" onclick="window.close();">

          </P>

		<script>
		function loca(){
		 if (confirm("真的要提交楼盘信息吗？")){
    		if (Validate(document.cus)){
	     	 document.cus.action="crm_project_add_Update.jsp";
		     document.cus.submit();
            }		
	     }
		}
		</script>
     
     
</form>     
 <%    }catch(Exception s){out.print("异常错误:"+s);} %>   
   
       
</body>       
</html>       
