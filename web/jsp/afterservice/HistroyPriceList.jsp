
 
<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
<title>实测面积录入</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script src="js/mad.js"> </script>
</head>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>

<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id = "changePriceListBean" scope = "page" class = "ConnDatabase.SDatabase" />
<jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
<jsp:useBean id = "FormatD" scope = "page" class = "FormatData.FormatData" />

<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
 <%
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"S007");


 %>
  <%
    String section = null;
	String building = null;
	String Floor="";
	String RoomNo="";
	String state="";
	String color="";
	String AreaStr="";
	String change2Str = "";
	ResultSet change2RS = null;
	String Loft="";
     String SectionS="";
    String SecName=China.getParameter(request,"SecName");
    SectionS=China.getParameter(request,"SecNo");
    Loft=China.getParameter(request,"Loft");	 
	building=China.getParameter(request,"Build");
	Floor= China.getParameter(request,"Floor");
	RoomNo=China.getParameter(request,"Room");
	state=China.getParameter(request,"state");					
	int hasRecord = 0;
   String floors=China.getParameter(request,"floors");		
   String rooms=China.getParameter(request,"rooms");		
%>
<script>
  function findSub(para){
    document.frm.action=para;
 
   document.frm.submit();
}

</script>
	<script>
function full(){
setSelectMad(document.frm.floors,'<%=floors%>');
 
 }

</script>
 
<body topmargin="1"  onload="full();" oncontextmenu="return false"  >
 <form name="frm" method=post action="MapUpdate.jsp">
<% String sel=(String)request.getParameter("sel");
   if(sel==null) sel="0"; %>
 <input type=hidden name="OK" >
  <input type=hidden name="sel" value="<%=sel %>">
 <table width="360" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=0;findSub('AreaMappingA.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>实测登记</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=2;findSub('AreaMappingAS.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>快速登记</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=3;findSub('AreaMapPingB.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>基建面积</font></a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('HistroyPriceList.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>实测面积</font></a>
	</td>
	</tr></table>
<input type=hidden name=SecNo value="<%=SectionS %>">
<input type=hidden name=Loft value="<%=Loft %>">
<input type=hidden name=SecName value="<%=SecName %>">
<input type=hidden name=Build value="<%=building %>">
<input type=hidden name=choose>
 
  <p align=center><font size=3 class=FontColor><b><%=SecName+Loft %>测绘面积</b></font></p>

<input type=hidden name="Section" value="<%= SectionS %>" >

&nbsp;<input type=button name=outdata value="导出到EXCEL" onclick="outexcel();">
 <%if (Cortrol.indexOf("C")>=0){ %>
<input type=button name=modi value="审核通过"  onclick="if (confirm('确认吗?'))document.frm.submit();">&nbsp;<input type=checkbox value=1 name=ch checked>计算差额&nbsp;&nbsp;&nbsp;&nbsp;
<input type=button name=cancelmodi value="取消审核"  onclick="if (confirm('确认吗?')) cancelcheck() ;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%} %>
<select name=floors onchange="document.frm.action='HistroyPriceList.jsp';document.frm.submit();">
<option value="">选择楼层</option>
<%for (int aa=-3;aa<30;aa++){ %>
<option value="<%=aa %>"><%=aa %>层</option>
 <%} %>
 </select>房号:
 <input type=text name=rooms ><input type=button name=ok value="查找" onclick="document.frm.action='HistroyPriceList.jsp';document.frm.submit();">&nbsp;&nbsp;系统按建筑测绘面积计算差价
 
<table width="100%" border="0" cellpadding="1" cellspacing="1">
  <tr align="center"  class=listtitle> 
 
    
    <td  > 
      <font color=white>房号<input name="cccall" type="checkbox" onclick="getseldocs2(this.checked);"></font>
    </td>
	<!--
	<td  > 
    <font color=white>预售建筑<br>面积M<sup>2</sup></font>
    </td>
	 <td  > 
    <font color=white>预售建筑套内<br>面积M<sup>2</sup></font>
    </td>
	 <td  > 
    <font color=white>露台<br>面积M<sup>2</sup></font>
    </td>
	 <td  > 
    <font color=white>花园<br>面积M<sup>2</sup></font>
    </td>
	 <td  > 
    <font color=white>阳台<br>面积M<sup>2</sup></font>
    </td>-->
	  <td  > 
    <font color=white>测绘建筑<br>面积(M<sup>2</sup>)</font>
    </td>
	<td  > 
    <font color=white>测绘套内<br>面积(M<sup>2</sup>)</font>
    </td>
	 <td  > 
    <font color=white>实测露台<br>面积M<sup>2</sup></font>
    </td>
	<td  > 
    <font color=white>实测花园<br>面积M<sup>2</sup></font>
    </td>
	<td  > 
    <font color=white>实测阳台<br>面积M<sup>2</sup></font>
    </td>
	<!--
	 <td  > 
    <font color=white>不锈钢罩<br>面积M<sup>2</sup></font>
    </td>
	 <td  > 
    <font color=white>锻铁罩<br>面积M<sup>2</sup></font>
    </td>
	
	<td  > 
    <font color=white>防盗安全网<br>面积M<sup>2</sup></font>
    </td>
	-->
  
   
	
	
	<td  > 
    <font color=white>差额露台<br>单价</font>
    </td>
	<td  > 
    <font color=white>差额花园<br>单价</font>
    </td>
	<!--
	<td  > 
    <font color=white>不锈钢罩<br>单价</font>
    </td>
	<td  > 
    <font color=white>锻铁罩<br>单价</font>
    </td>
	<td  > 
    <font color=white>防盗安全网<br>单价</font>
    </td>-->
	<td  > 
    <font color=white>套内面积<br>差异比</font>
    </td>
	<td  > 
    <font color=white>花园/露台面积<br>差异比</font>
    </td>
	 <td>删除</td>
  </tr>

      <%
		int floor=0;	
		String code="";
		String room="";
		String SaleArea="";
		int salestate=0;
		String  unitprice="";
		String usedarea="";
		String af_unitprice="";
		String af_sumprice="";
		String contractno="",yang_tai_area="";
		String Sql="",yang_tai_zhao_yarea="";
		String customer="",lu_tai_area="";
	%> 
  <%	
	
	String strDisabled="";
	String strWhere="";
	int i=0;

	change2Str="select * from MapArea where Section='"+SectionS+"'";
	if (!Loft.equals(""))
	change2Str+=" and loft='"+Loft+"'";
	if (!floors.equals(""))
	change2Str+=" and floors="+floors+"";
	if (!rooms.equals(""))
	change2Str+=" and room='"+rooms+"'";
	// out.print(change2Str);
		change2RS = changePriceListBean.executeQuery(change2Str);
try{
    String vv="";
		while (change2RS.next()) {
		i=i+1;
			hasRecord = 1;
			String id=getbyte(change2RS.getString("id"));
			Loft = getbyte(change2RS.getString("loft"));
			building = getbyte(change2RS.getString("building"));
			room = getbyte(change2RS.getString("Room"));
		    SaleArea = getbyte(change2RS.getString("area"));
			 boolean checked=change2RS.getBoolean("checked");
			String chk="";
			if (checked)chk="disabled";
		
 %>
  
  <tr align="center"  class=listcontent> 
 
  <input type=hidden name="Room<%=i%>" value="<%= room %>" >

    <input type=hidden name="area<%=i%>" value="<%= building %>" >
  <input type=hidden name="usedarea<%=i%>" value="<%= building %>" >
  <input type=hidden name="lutai<%=i%>" value="<%= building %>" >
  <input type=hidden name="yangtaiz<%=i%>" value="<%= building %>" >
  <input type=hidden name="yangtai<%=i%>" value="<%= building %>" >
 
   <td > <%if (chk.equals("disabled")){ %><input name="ccc" type="checkbox" value="<%=id %>"><%} %><%=Loft+room.trim() %></td> 
   <td ><input type=text <%=chk %> name="c_Area<%=i %>" size="5" value="<%=getbyte(change2RS.getString("Y_Area")) %>"></td> 
   <td ><input type=text <%=chk %> name="c_usedArea<%=i %>" size="5" value="<%=getbyte(change2RS.getString("y_UserArea"))%>"></td> 
   <td ><input type=text <%=chk %> name="c_ltArea<%=i %>" size="5" value="<%=getbyte(change2RS.getString("y_lutai_area")) %>"></td> 
   <td ><input type=text <%=chk %> name="c_tyArea<%=i %>" size="5" value="<%=getbyte(change2RS.getString("y_ty_area")) %>"></td> 
   <td><input type=text <%=chk %> name="c_ytArea<%=i %>" size="5" value="<%=getbyte(change2RS.getString("y_yangtai_area")) %>"></td>
    <input type=hidden <%=chk %> name="c_ytzArea<%=i %>" size="5" value="<%=getbyte(change2RS.getString("y_yangtai_zhao_area")) %>"> 
  <input type=hidden <%=chk %> name="c_dtArea<%=i %>" size="5" value="<%=getbyte(change2RS.getString("dt_area"))  %>"> 
    <input type=hidden <%=chk %>  name="c_yxzarea<%=i %>" size="5" value="<%=getbyte(change2RS.getString("yxz_area")) %>"> 
   <td ><input type=text <%=chk %> name="ltp<%=i %>" size="5" value=" <%=getbyte(change2RS.getString("lutai_price")) %>"></td> 
   <td ><input type=text <%=chk %> name="typ<%=i %>" size="5" value=" <%=getbyte(change2RS.getString("ty_price")) %>"></td> 
    <input type=hidden <%=chk %> name="bxgp<%=i %>" size="5" value="<%=getbyte(change2RS.getString("y_yangtai_zao_price"))%>"> 
    <input type=hidden <%=chk %> name="dtp<%=i %>" size="5" value="<%=getbyte(change2RS.getString("dt_price"))%>"> 
   <input type=hidden <%=chk %> name="yxzp<%=i %>" size="5" value="<%=getbyte(change2RS.getString("yxz_price")) %>"> 

   <td><input type=text <%=chk %> name="area_rate<%=i %>" size="5" value="<%=getbyte(change2RS.getString("area_rate")) %>"></td>
   <td><input type=text <%=chk %> name="area_rateA<%=i %>" size="5" value="<%=getbyte(change2RS.getString("area_rate1")) %>"></td>
     <input type=hidden <%=chk %> name="customer<%=i %>" value="<%=customer %>">
	 <td><%if (!chk.equals("disabled")){ if (Cortrol.indexOf("D")>=0){%><a href="#" onclick="if (confirm('确认吗?'))openwin('deleteMapArea.jsp?id=<%=id %>',10,10,10,10);">删除</a><%}} %></td>
  </tr>
  
  <%
   }
   }catch(Exception s){out.print(s.getMessage());}
 
  // change2RS.close();
   %>
  <input type=hidden name="state" value="2"> 
<input type=hidden name=MaxRoomNo value="<%=i%>">
</table>

  <table width="100%" border="0">
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
	</table>
    
</form>
 <script>
 function cancelcheck(){
  document.frm.action="cancelCheck.jsp";
 document.frm.submit()
 }
   function outexcel(){
  
	  window.open("HistroyPriceListExcel.jsp?section=<%=SectionS %>&Loft=<%=Loft %>");
  
  }
  
  
function getseldocs2(para) {
    
     for (i=0;i<frm.ccc.length;i++) {
	 document.frm.ccc[i].checked=para;
     }	

 
}
  
  
  </script>
 
</center>

</body>
 
</html>
