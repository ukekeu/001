<%@ page contentType="text/html;charset=GBK" %>

<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "销售管理-->销售分析" , 
                  "浏览"
                ) ;
%> 

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
<title>投诉分析</title>

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
   <%String sqlx= "select SerialNo,Name from CRM_Project " ;
 ResultSet Rsx = ViewBean.executeQuery(sqlx) ;
 while (Rsx.next()) {
String tmpid = Rsx.getString("SerialNo") ;%>
    if(objvalue=="<%=tmpid%>"){
html="";
i=0;
<%  int j=1;
    int x=0;
	String sqlUser = "select loft from Sectiontree where  SerialNo='"+tmpid+"' group by loft";
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
 if (choose=="3")
  document.cus.action="tsFX1.jsp";
 else if (choose=="2")
    document.cus.action="tsFX1.jsp";
 else if (choose=="1")	
    document.cus.action="saleFx3.jsp";
	
 document.cus.submit();
}
</script>
<body>

<!--DemandAnalysepic.jsp-->
<form name=cus method="post" action="" target="_blank"> 
 
<p align=center><font size=4 class=FontColor><b>选择分析条件</b></font><p>

<table BORDER=0 width="50%" class=parent id=KB3Parent CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
  <tr > 
 <%@ include file="../public_js/CheckSection.jsp"%>
<%
	if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
	 String sql="";
      sql="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";
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
	<tr><td width="25%" class=roomleft align="left">&nbsp;选择栋号: </td>
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
		
<tr><td class=roomleft> &nbsp;图表类型</td><td class=roomright>&nbsp;<select name="photo"><option value=3>饼图</option><option value=2>直方柱状图</option> </select></td></tr>
   </table>
 <input type=hidden name=ty >
  <p align=center>	<input type=button name="Count" value="提 交" onclick="fx();">
<input type=button name="Count" value="重 填">

	</p>  
  </form>


</body>

</html>
