
 
<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
<title>ʵ�����¼��</title>
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
	  <a href="#" onclick="document.frm.sel.value=0;findSub('AreaMappingA.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>ʵ��Ǽ�</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=2;findSub('AreaMappingAS.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>���ٵǼ�</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=3;findSub('AreaMapPingB.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�������</font></a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('HistroyPriceList.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>ʵ�����</font></a>
	</td>
	</tr></table>
<input type=hidden name=SecNo value="<%=SectionS %>">
<input type=hidden name=Loft value="<%=Loft %>">
<input type=hidden name=SecName value="<%=SecName %>">
<input type=hidden name=Build value="<%=building %>">
<input type=hidden name=choose>
 
  <p align=center><font size=3 class=FontColor><b><%=SecName+Loft %>������</b></font></p>

<input type=hidden name="Section" value="<%= SectionS %>" >

&nbsp;<input type=button name=outdata value="������EXCEL" onclick="outexcel();">
 <%if (Cortrol.indexOf("C")>=0){ %>
<input type=button name=modi value="���ͨ��"  onclick="if (confirm('ȷ����?'))document.frm.submit();">&nbsp;<input type=checkbox value=1 name=ch checked>������&nbsp;&nbsp;&nbsp;&nbsp;
<input type=button name=cancelmodi value="ȡ�����"  onclick="if (confirm('ȷ����?')) cancelcheck() ;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%} %>
<select name=floors onchange="document.frm.action='HistroyPriceList.jsp';document.frm.submit();">
<option value="">ѡ��¥��</option>
<%for (int aa=-3;aa<30;aa++){ %>
<option value="<%=aa %>"><%=aa %>��</option>
 <%} %>
 </select>����:
 <input type=text name=rooms ><input type=button name=ok value="����" onclick="document.frm.action='HistroyPriceList.jsp';document.frm.submit();">&nbsp;&nbsp;ϵͳ������������������
 
<table width="100%" border="0" cellpadding="1" cellspacing="1">
  <tr align="center"  class=listtitle> 
 
    
    <td  > 
      <font color=white>����<input name="cccall" type="checkbox" onclick="getseldocs2(this.checked);"></font>
    </td>
	<!--
	<td  > 
    <font color=white>Ԥ�۽���<br>���M<sup>2</sup></font>
    </td>
	 <td  > 
    <font color=white>Ԥ�۽�������<br>���M<sup>2</sup></font>
    </td>
	 <td  > 
    <font color=white>¶̨<br>���M<sup>2</sup></font>
    </td>
	 <td  > 
    <font color=white>��԰<br>���M<sup>2</sup></font>
    </td>
	 <td  > 
    <font color=white>��̨<br>���M<sup>2</sup></font>
    </td>-->
	  <td  > 
    <font color=white>��潨��<br>���(M<sup>2</sup>)</font>
    </td>
	<td  > 
    <font color=white>�������<br>���(M<sup>2</sup>)</font>
    </td>
	 <td  > 
    <font color=white>ʵ��¶̨<br>���M<sup>2</sup></font>
    </td>
	<td  > 
    <font color=white>ʵ�⻨԰<br>���M<sup>2</sup></font>
    </td>
	<td  > 
    <font color=white>ʵ����̨<br>���M<sup>2</sup></font>
    </td>
	<!--
	 <td  > 
    <font color=white>�������<br>���M<sup>2</sup></font>
    </td>
	 <td  > 
    <font color=white>������<br>���M<sup>2</sup></font>
    </td>
	
	<td  > 
    <font color=white>������ȫ��<br>���M<sup>2</sup></font>
    </td>
	-->
  
   
	
	
	<td  > 
    <font color=white>���¶̨<br>����</font>
    </td>
	<td  > 
    <font color=white>��԰<br>����</font>
    </td>
	<!--
	<td  > 
    <font color=white>�������<br>����</font>
    </td>
	<td  > 
    <font color=white>������<br>����</font>
    </td>
	<td  > 
    <font color=white>������ȫ��<br>����</font>
    </td>-->
	<td  > 
    <font color=white>�������<br>�����</font>
    </td>
	<td  > 
    <font color=white>��԰/¶̨���<br>�����</font>
    </td>
	 <td>ɾ��</td>
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
	 <td><%if (!chk.equals("disabled")){ if (Cortrol.indexOf("D")>=0){%><a href="#" onclick="if (confirm('ȷ����?'))openwin('deleteMapArea.jsp?id=<%=id %>',10,10,10,10);">ɾ��</a><%}} %></td>
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
