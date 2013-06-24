<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ taglib uri="common-taglib" prefix="common" %>
<%@ page import="common.*,java.sql.*" %>
<jsp:useBean id="conn" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<html>
<head>
<title>定价/调价管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%
 String strMessage=request.getParameter("mess");
 String SecName=China.getParameter(request,"SecName");
 String strSection=request.getParameter("SecNo");
 String Region=China.getParameter(request,"Loft");
 String strBuilding=China.getParameter(request,"Build");
 %>
<form name=frm method="post"  >
<input type=hidden name=SecNo value="<%=strSection %>">
    <input type=hidden name=Loft value="<%=Region %>">
    <input type=hidden name=SecName value="<%=SecName %>">
    <input type=hidden name=Build value="<%=strBuilding %>">
    <input type=hidden name=choose>
    <input type=hidden name=RegionNA value="<%=Region %>">
    <input type=hidden name=RegionNO value="<%=Region %>">
    <input type=hidden name=SectionNA value="<%=SecName %>">
    <input type=hidden name=SectionNO value="<%=strSection %>">
 
<table width="100%" border="1">
   <tr align="center"> 
    <td width="9%">编号</td>
    <td width="10%">使用面积</td>
    <td width="10%">建筑面积</td>
    <td width="12%">分数总和</td>
    <td width="12%">评估单价</td>
    <td width="10%">上浮单价</td>
    
    <td width="24%">总价</td>
  </tr>
  <tr align="center"> 
    <td colspan="3">权重分值</td>
    <td width="12%">100</td>
    <td width="12%"><input type=text size=10 name="pg_price" value=0></td>
    <td width="10%">&nbsp; </td>
    <td width="13%">&nbsp;<input type=button name=sum value="试算" onclick="ok();"></td>
 
  </tr>
  <%
  String SQL="select Room_code,UsedArea,Area  from room where seccode='"+strSection+"' and Loft='"+Region+"'";
ResultSet rs=conn.executeQuery(SQL);
 
int tab=0;
while (rs.next()){
   String room_code=rs.getString("Room_code");
      String Area=rs.getString("Area");
   String UsedArea=rs.getString("UsedArea");
  %>
  <tr> 
    <td width="20%">&nbsp;<%=Region %>-<%=room_code%></td>
    <td width="10%">&nbsp;<input type=hidden size=10 name="<%=room_code %>UsedArea" value="<%=UsedArea %>"><%=FormtD.getFloat(Float.parseFloat(UsedArea),3) %></td>
    <td width="10%">&nbsp;<input type=hidden size=10 name="<%=room_code %>Area" value="<%=Area %>"><%=FormtD.getFloat(Float.parseFloat(Area),3) %></td>
<%tab++; %>
    <td width="12%" align="center"><input type=text size=10  tab=<%=tab %> name="<%=room_code %>fszh" onkeydown="key1(<%=tab++ %>,this);" value=1  onblur="checkedvalue(this);"></td>
  
    <td width="12%">&nbsp;<input type=text size=10 tab=<%=tab %> name="<%=room_code %>djxs"  onkeydown="key1(<%=tab++ %>,this);" value=1  onblur="checkedvalue(this);"></td>
 
    <td width="10%"><input type=text size=10 name="<%=room_code %>sf_xs" tab=<%=tab %>  onkeydown="key1(<%=tab++%>,this);" value=1  onblur="checkedvalue(this);"></td>
  
    <td width="24%"><input type=text size=10 tab=<%=tab %> onkeydown="key1(<%=tab %>,this);" name="<%=room_code %>zks" value=1  onblur="checkedvalue(this);"></td>
  </tr>
  <%}
  rs.close(); %>
</table>
</form>
<script>
function key1(tab,para){
    var myform="";
	 var nexttab=0;
     if (event.keyCode==13){
	 tab=para.tab;
     var StrValue=para.value;
	 nexttab=parseInt(tab)+1;
     myform=para.form;
	
	  for(i=tab;i<frm.elements.length;i++){
	  
	     if(frm.elements[i].tab==nexttab){
		    frm.elements[i].focus();
			frm.elements[i].select();
			 break;
		 }
  	}	 
   }
  }	
  function checkedvalue(th){
    var thisvalue=th.value;
	if (thisvalue!=""){
	 if (isNaN(thisvalue)){
	   alert("请输出数字型数值");
	   th.focus();
	   th.select();
	   return false;
	  }
	 }
	 }
	 function ok(){
	   if (parseInt(document.frm.pg_price.value)==0){
		alert("请输入基价");
		document.frm.pg_price.focus();	
		return false;
	   }
	   document.frm.action="SS_show.jsp";
	  document.frm.submit();
	 }
</script>
</body>
</html>
