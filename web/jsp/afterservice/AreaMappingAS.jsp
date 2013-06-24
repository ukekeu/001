
 
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
   
%>

	 
<script>
     function Validate(aForm)
   {
      if (aForm.SecNo.value.length<1)
	    	{
	    	alert("请楼盘！");
	        aForm.SecNo.fofrm();
	        return (false);
	    	}	
       if (aForm.build.value.length<1)
		{
	        alert("请输入栋号!");
	        aForm.build.fofrm();
	        return false;
		}
	}	


	var secValue = "<%= section %>";
	var buildValue = "<%= building %>";
	var Floor="<%=Floor%>";
	var Loft1="<%=Loft %>";
	var RoomNo="<%=RoomNo%>";
	var state="<%=state%>";

	function loadSelect() {
		setSelectMad(document.frm.SecNo,secValue);
		document.frm.build.options[document.frm.build.length]=new Option(buildValue,buildValue);
        document.frm.Loft.options[document.frm.Loft.length]=new Option(Loft1,Loft1);

		document.frm.Floor.value = Floor;
		document.frm.Room.value = RoomNo;
		
	}	
	
	 
	function subs(p1,p2)
	{
	
	 var varst=p1;
	  var len=p2;
	  var lenstr="0";
	  if (varst.indexOf(".")>0){
	 
         for (var i=1;i<parseInt(len)-1;i++){
		  lenstr+="0";
		 }
		 if (parseInt(len)>1){lenstr="0."+lenstr+"1";}//求出加1的小数位。
		 else{lenstr="0."+"1";}
	     var vars=varst.substring(varst.indexOf(".")+parseInt(len)+1,varst.indexOf(".")+(parseInt(len)+2));//保留时取舍的数
	     var xsucd=varst.substring(varst.indexOf(".")+1,varst.indexOf(".")+parseInt(len)+1);//求小数位后到保留小数位的数。
		 var xsuq=varst.substring(0,varst.indexOf("."));//求小数位前的数。
		 var xsucd1=xsucd;//把数转移
		 var xsulen=varst.substring(0,varst.indexOf(".")+parseInt(len)+1);//保留后长度
		 if (parseInt(vars)>4){
		     xsucd=String(parseInt(xsucd)+1);
			 if (xsucd.length>xsucd1.length){
			    xsuq=String(parseInt(xsuq)+1);
				varst=xsuq+"."+xsucd.substring(1,xsucd.length);
				}
              else{varst=xsuq+"."+xsucd;}
         }else{
		    varst=xsulen;
		 }
	 }	 
	 return varst;
	
	}
 
  
  function findSub(para){
    document.frm.action=para;
 
   document.frm.submit();


}
</script>
<body  oncontextmenu="return false"   topmargin="1"    bgcolor="#FFFFFF" text="#000000" >
   <form name=frm action="AreaMappingAS.jsp" method="post">
<input type=hidden name=SecNo value="<%=SectionS %>">
<input type=hidden name=Loft value="<%=Loft %>">
<input type=hidden name=SecName value="<%=SecName %>">
<input type=hidden name=Build value="<%=building %>">
<input type=hidden name=choose>
  
<% String sel=(String)request.getParameter("sel");
   if(sel==null) sel="0"; %>

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
  <p align=center><font size=3 class=FontColor><b><%=SecName+Loft %>测绘面积录入</b></font></p>
 <form name="frm" method=post action="UpdateRoomPrice.jsp?Section=<%=section%>&Building=<%=building%>">
<input type=hidden name="Section" value="<%= SectionS %>" >
<input type=hidden name="OK" >
测绘单位: <input type=text size=15 name=mappingunit onkeydown="key(document.frm.mappingdate)"> &nbsp;测绘日期:<input type=text size=8 name=mappingdate onkeydown="key(document.frm.percent)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(mappingdate);return false;" title="请选择日期">
<br>&nbsp;房款补偿比：±<input type=text size=3 name=percent value=0.6 onkeydown="key(document.frm.MappingArea1)">%&nbsp;庭院/露台补偿比：±<input type=text size=3 name=percent1 value=0.5 onkeydown="key(document.frm.MappingArea1)">%&nbsp;<input type=checkbox name=jstype value=1 checked>按差额结算&nbsp;&nbsp;系统按建筑测绘面积计算差价
<table width="120%" border="0" cellpadding="1" cellspacing="1">
  <tr align="center"  class=listtitle> 
 
    
    <td  > 
    <font color=white>测绘建筑<br>面积(M<sup>2</sup>)</font>
    </td>
	<td  > 
    <font color=white>测绘套内<br>面积(M<sup>2</sup>)</font>
    </td>
	 <td  > 
    <font color=white>实测阳台<br>面积M<sup>2</sup></font>
    </td>
    <td  > 
    <font color=white>实测露台<br>面积M<sup>2</sup><br><input type=text size=2 name=ltp value=0></font>
    </td>
	 <td  > 
    <font color=white>实测庭院<br>面积M<sup>2</sup><br><input type=text size=2 name=typ value=0></font>
    </td>
	 <td  > 
    <font color=white>实测不锈<br>钢面积M<sup>2</sup><br><input type=text size=2 name=bxg value=0></font>
    </td>
	 <td  > 
    <font color=white>实测锻铁<br>面积M<sup>2</sup><br><input type=text size=2 name=dt value=0></font>
    </td>
	 <td  > 
    <font color=white>实测安全网<br>面积M<sup>2</sup><br><input type=text size=2 name=aqw value=0></font>
    </td>
	<td  > 
    <font color=white>实测分摊<br>基地面积M<sup>2</sup></font>
    </td>
	<td  > 
    <font color=white>实测分摊<br>用地面积M<sup>2</sup></font>
    </td>
  </tr>

  
  <tr align="center"  class=listcontent> 
<%int i=1; %>

   <td > <input type=text name="MappingArea<%=i %>" size="5" value=0 OnChange="check(document.frm.MappingArea<%=i%>);" onkeydown="key(document.frm.MappingUserArea<%=i %>)" ></td>
   <td > <input type=text name="MappingUserArea<%=i %>" size="5" value=0 OnChange="check(document.frm.MappingUserArea<%=i%>);" onkeydown="key(document.frm.MappingyArea<%=i %>)" ></td>
   <td > <input type=text name="MappingyArea<%=i %>" size="5" value=0 OnChange="check(document.frm.MappingUserArea<%=i%>);" onkeydown="key(document.frm.MappinglArea<%=i %>)" ></td>
 
   <td > <input type=text name="MappinglArea<%=i %>" size="5" value=0 OnChange="check(document.frm.MappingArea<%=i%>);" onkeydown="key(document.frm.MappingtArea<%=i %>)" ></td>
   <td > <input type=text name="MappingtArea<%=i %>" size="5" value=0 OnChange="check(document.frm.MappingArea<%=i%>);" onkeydown="key(document.frm.MappingytArea<%=i %>)" ></td>
   <td > <input type=text name="MappingytArea<%=i %>" size="5" value=0 OnChange="check(document.frm.MappingUserArea<%=i%>);" onkeydown="key(document.frm.MappingdArea<%=i %>)" ></td>
   
    <td ><input type=text name="MappingdArea<%=i %>" size="5" value=0 OnChange="check(document.frm.MappingUserArea<%=i%>);" onkeydown="key(document.frm.MappingytArea<%=i %>)" ></td>
  
      <td > <input type=text name="MappingywArea<%=i %>" size="5" value=0 OnChange="check(document.frm.MappingUserArea<%=i%>);" onkeydown="key(document.frm.MappingyftjdArea<%=i %>)" ></td>
  <td > <input type=text name="MappingyftjdArea<%=i %>" size="5" value=0 OnChange="check(document.frm.MappingUserArea<%=i%>);" onkeydown="key(document.frm.MappingyftydArea<%=i %>)" ></td>
  <td > <input type=text name="MappingyftydArea<%=i %>" size="5" value=0 OnChange="check(document.frm.MappingUserArea<%=i%>);" onkeydown="key(document.frm.MappingArea<%=i+1 %>)" ></td>
 

  </tr>
  <tr><td colspan="3">房号范围:<input type=text size=5 name=sroom>到<input type=text size=5 name=eroom></td><td colspan="3">楼层范围:<input type=text size=5 name=sfloors>到<input type=text size=5 name=efloors></td></tr>
  
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
 
	<p align=center>
	<%if (Cortrol.indexOf("A")>=0){ %>
        <input type="button" name="Button" value="提   交" onclick="InsertMap()"><%} %>
  <!-- <img  src="../picture/button_tj.gif" onclick="InsertMap();">-->      
</p>
 
</form>
 
</center>

</body>
<script>
	function InsertMap() {
	 if (confirm("确认数据正确？")){
	    if (document.frm.mappingunit.value==""){
		  alert("请录入测绘单位");
		  document.frm.mappingunit.focus();
		  return false;
		}
		if (document.frm.mappingdate.value==""){
		  alert("请测绘日期");
		  document.frm.mappingdate.focus();
		  return false;
		}
		if (document.frm.sroom.value==""||document.frm.eroom.value==""){
		  alert("请录入房号范围");
		  document.frm.sroom.focus();
		  return false;
		}
		if (document.frm.sfloors.value==""||document.frm.efloors.value==""){
		  alert("请录入楼层范围");
		  document.frm.sfloors.focus();
		  return false;
		}
		document.frm.OK.value="OK";
		document.forms[0].action = "MapAreaUpdateS.jsp?Operation=Insert&x=" + Math.random() ;
		document.forms[0].submit() ;
		}
	}
</script>
</html>
