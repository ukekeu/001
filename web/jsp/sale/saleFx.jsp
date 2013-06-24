<%@ page contentType="text/html;charset=GBK" %>

 

 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>

  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>

<html>
<head> 
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>销售分析</title>

</head>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>


 <script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<SCRIPT language=javascript>
function changebuild(obj){
   var objvalue=obj.value;
   var html="";
   var i=0;
   var arr=new Array();
   <%String sqlx= "select SerialNo,Name from crm_project " ;
 ResultSet Rsx = ViewBean.executeQuery(sqlx) ;
 while (Rsx.next()) {
String tmpid = Rsx.getString("SerialNo") ;%>
    if(objvalue=="<%=tmpid%>"){
html="";
i=0;
<%  int j=1;
    int x=0;
	String sqlUser = "select loft from Sectiontree where  SerialNo='"+tmpid+"'";
ResultSet userRs = ViewBean1.executeQuery(sqlUser) ;
while (userRs.next()) {
String housename = userRs.getString("loft") ;
if (housename == null)
  housename = "" ;
  housename = getbyte(housename) ;
%>
arr[i]="<option value='<%=housename%>'><%=housename%></option>";
++i;
    <%}userRs.close();%>
html="&nbsp;<select name='Loft' style='width=100;'><option value=''></option>"+arr.join();
html=html+"</select>";
document.all("sub").innerHTML=html;

}
  <%}Rsx.close();%>
}
function fxType(para){
document.cus.ty.value=para;
 
}
function fx(){
 var choose=document.cus.photo.value;
 if (document.cus.Date1.value==""){alert("请选择起始日期");return false;}
 if (document.cus.Date2.value==""){alert("请选择结束日期");return false;}
 if (document.cus.fxzb.value=="cus_age"){
   if (document.cus.age1.value==""||document.cus.age2.value==""){alert("请录入你分析的年龄段");document.cus.age1.focus();return false;}
   document.cus.action="cusFx4.jsp";
 
  }else{
 if (choose=="3")
  document.cus.action="saleFX1.jsp";
 else if (choose=="2")
    document.cus.action="saleFX1.jsp";
 else if (choose=="1")	
    document.cus.action="saleFx3.jsp";
 }	
  if (document.cus.fxzb.value=="o.rmbprice"){
   if (document.cus.money2.value==""||document.cus.money1.value==""){alert("请录入你分析的销售额范围");document.cus.money1.focus();return false;}
    document.cus.action="saleFx3.jsp";
   }
 document.cus.submit();
}
</script>
<body>

<!--DemandAnalysepic.jsp-->
<form name=cus method="post" action="" target="_blank"> 
 
<p align=center><font size=4 class=FontColor><b>选择分析条件</b></font><p>

<table BORDER=0 width="100%" class=parent id=KB3Parent CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
  <tr > 
 <%@ include file="../public_js/CheckSection.jsp"%>
<%
	if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
	 String sql="";
      sql="select SerialNo,Name from crm_project where SerialNo in("+SectionS+")";
      ResultSet rs2=ViewBean.executeQuery(sql);
	  String sec="";
	  String no="";
  %>
    <td width="25%" class=roomleft>&nbsp;楼&nbsp;&nbsp;&nbsp;&nbsp;盘</td><td  class=roomright>
	&nbsp;<select name="section" onclick="changebuild(this);" style="width : 104">

	 <%while (rs2.next()){
	   no=rs2.getString("SerialNo");
	   
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no+"'>"+sec+"</option>");
	  }
	    rs2.close();
     %>	
	</select>
	</td>
	</tr><tr>
	<tr>
                      <td width="25%" class=roomleft align="center">&nbsp;选择栋号:</td>
					  <td  class=roomright id="sub">&nbsp;<select name="Loft"  style="width=100;">
					      <option value=""></option>
						 
							</select>
					</tr>
					<tr>
   <td width="25%" class=roomleft >&nbsp;起始日期:</td><td  class=roomright>
	
	 &nbsp;<INPUT TYPE=TEXT NAME=Date1 size=10><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;"><font color=red>*</font></td></td>  
		</td>
			</tr><tr>
			<td class=roomleft>
&nbsp;结束日期:</td><td  class=roomright>
	
	 &nbsp;<INPUT TYPE=TEXT NAME=Date2 size=10><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date2);return false;"><font color=red>*</font></td></td>  
		</td></tr>
		<tr>
   <td width="25%" class=roomleft >&nbsp;年龄段落:</td><td  class=roomright>从<INPUT TYPE=TEXT NAME=age1 size=10>到<INPUT TYPE=TEXT NAME=age2 size=10></td></td>  
		</td>
			</tr><tr>
			<td class=roomleft>
&nbsp;销售金额范围:</td><td  class=roomright>
	从<INPUT TYPE=TEXT NAME=money1 size=10>到<INPUT TYPE=TEXT NAME=money2 size=10>万元
	 &nbsp;</td></td>  
		</td></tr>
		<tr><td class=roomleft  width="25%">
     		&nbsp;分析指标：
		</td><td  class=roomright>
		<%
 String StrSql="select distinct type,typename from CODE group by type,typename order by type";
   ResultSet codeRS=null;
   String CodeName[]=new String[100];
   String CodeType[]=new String[100];
   codeRS=ViewBean.executeQuery(StrSql);
   int i=0;
   while (codeRS.next()){
     CodeType[i]=codeRS.getString("type");
     CodeName[i]=getbyte(codeRS.getString("typename"));
	 i++;
   }
   codeRS.close();
 %>
		&nbsp;<select  multiple size=8  name="fxzb" style="width : 104" onchange="fxType(this.text)" >
		<option value=o.roomtype selected>户型</option>
	    <option value=o.loft>楼栋 </option>
		 <option  value=r.room>房号</option>   
         <option value=o.jzarea>建筑面积</option> 
        <option value=o.floors>楼层</option> 
		<option value=o.zx>装修标准</option>
	    <option value=o.yong_tu>用途</option>
        <option value=o.payment1>付款方式  </option> 
  	      <option value=cus_age>客户年龄  </option> 
        <option value=o.ajbk>按揭银行 </option>   
		<option value=o.rmbprice>销售额 </option>   
		
	    <option  value=o.ajyear>按揭年限</option>           
        <option  value=c.region>客户所在区域</option>           
 
      </select></td>  

</tr>
<tr><td class=roomleft>图表类型</td><td class=roomright>&nbsp;<select name="photo"><option value=3>饼图</option> </select></td></tr>
 
  </table>
 <input type=hidden name=ty >
  <p align=center>	<input type=button name="Count" value="提 交" onclick="fx();">
<input type=button name="Count" value="退  出" onclick="window.close();">

	</p>  
  </form>


</body>

</html>
