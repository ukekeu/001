
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
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"A005");


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
  List list1=new LinkedList();//存放铺位编码
	List list2=new LinkedList();//存放铺位状态

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

	 <%
   String TaxSql="select * from taxchages where  (TaxName like '%产权综合费%' or TaxName like '%测绘费%' or TaxName like '%契税%')";
   
   ResultSet TaxRS=null;
   try{
   TaxRS = changePriceListBean.executeQuery(TaxSql);
		out.print("<script>");
        out.print("var TaxRate=new Array();");
		out.print("var TaxName=new Array();");
       // out.print("var monthtax=new Array();");
       // out.print("var yeartax=new Array();");
        int i=0;
		while (TaxRS.next()) {
		
     out.print("TaxName["+String.valueOf(i)+"]="+"\""+getbyte(TaxRS.getString("TaxName"))+"\""+";");
	 out.print("TaxRate["+String.valueOf(i)+"]="+"\""+FormatD.getFloat1(TaxRS.getFloat("money"),3)+"\""+";");
	 
	i=i+1;
  }	 
  out.print("</script>");
  
 
  
  TaxRS.close();
 }catch(Exception s)	{}
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
 
  function ch_ac(para){
     if (para=="1")
	   document.frm.action="AreaMapping.jsp";
	 else  if (para=="2")
	   document.frm.action="AreaMappingNo.jsp";    
	 else  if (para=="3")
	   document.frm.action="AreaMappingA.jsp";    
      document.frm.submit();
  }
</script>
<body bgcolor="#FFFFFF" text="#000000" onload="document.frm.mappingunit.focus();" >
<form name="frm" method="post" action="HistroyPriceList.jsp" onsubmit="return Validate(this);">
<input type=hidden name=SecNo value="<%=SectionS %>">
<input type=hidden name=Loft value="<%=Loft %>">
<input type=hidden name=SecName value="<%=SecName %>">
<input type=hidden name=Build value="<%=building %>">
<input type=hidden name=choose>
<%
  
	String sqlArr="select  loft+room_no as room ,rmbprice from ";
		   sqlArr=sqlArr+" order_contract where section='"+SectionS+"' and loft='"+Loft+"' and building='"+building+"'";
		   	  
			   ResultSet rsArr=ViewBean.executeQuery(sqlArr);

		   int aryi=0;
		   while (rsArr.next()){
		    list1.add(getbyte(rsArr.getString("room")));
			
			list2.add(getbyte(rsArr.getString("rmbprice")));
		   } 
	      rsArr.close();
 %>
  <p align=center><font size=3 class=FontColor><b>测绘面积录入</b></font></p>
 <form name="frm" method=post action="UpdateRoomPrice.jsp?Section=<%=section%>&Building=<%=building%>">
<input type=hidden name="Section" value="<%= SectionS %>" >

测绘单位: <input type=text name=mappingunit onkeydown="key(document.frm.mappingdate)"> &nbsp;测绘日期:<input type=text size=12 name=mappingdate onkeydown="key(document.frm.percent)"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(mappingdate);return false;" title="请选择日期">&nbsp;补偿比：><input type=text size=6 name=percent value=0.6 onkeydown="key(document.frm.MappingArea1)">%
<input type="radio" value="1"  onclick="ch_ac(this.value);">已售房间&nbsp;<input type="radio" value="2" onclick="ch_ac(this.value);">未售房间&nbsp;<input type="radio" value="3" checked onclick="ch_ac(this.value);">所有
<table width="100%" border="0" cellpadding="1" cellspacing="1">
  <tr align="center"  class=listtitle> 
 
    
    <td  > 
      <font color=white>房号</font>
    </td>
	<td  > 
    <font color=white>销售面积M<sup>2</sup></font>
    </td>
	<td  > 
     <font color=white>总价(元)</font>
    </td>
    <td  > 
    <font color=white>测绘建筑面积(M<sup>2</sup>)</font>
    </td>
	<td  > 
    <font color=white>测绘套内面积(M<sup>2</sup>)</font>
    </td>
    <td  > 
    <font color=white>面积差异(M<sup>2</sup>)</font>
    </td>
	<td  > 
    <font color=white>差异比(%)</font>
    </td>
	<td  > 
    <font color=white>差价(元)</font>
    </td>
	<td  > 
    <font color=white>房价(元)</font>
    </td>
	<td  > 
    <font color=white>测绘单价(元)</font>
    </td>
	<!--<td  > 
  <font color=white>产权综合费(元)</font>
    </td>
	<td  > 
  <font color=white>测绘费(元)</font>
    </td>
	<td  > 
  <font color=white>契税(元)</font>
    </td>
	<td  > 
  <font color=white>总税费(元)</font>
    </td>
	-->
  </tr>

      <%
		int floor=0;	
		String code="";
		String room="";
		String SaleArea="";
		int salestate=0;
		String  unitprice="";
		String sumprice="";
		String af_unitprice="";
		String af_sumprice="";
		String contractno="";
		String Sql="";
		String customer="";
	%> 
  <%	
	
	String strDisabled="";
	String strWhere="";
	int i=0;
	if (!Floor.equals("")){
	    strWhere=" and Floor="+Floor;
	}
	if (!RoomNo.equals("")){
	   if (!strWhere.equals("")){strWhere=strWhere+" and Room_code like'%"+RoomNo+"%'";}
	   else{strWhere=" and Room_code like'%"+RoomNo+"%'";}
	}
	if (!state.equals("")){

	   if (!strWhere.equals("")){strWhere=strWhere+" and SaleState="+state;}
	   else{strWhere=" and SaleState="+state;}
   }
	    change2Str = "SELECT   dbo.Room.Code," +" dbo.Room.seccode, dbo.Room.Loft, "
   +"   dbo.Room.building, dbo.Room.Room_code,dbo.Room.room, dbo.Room.area," +"dbo.Room.Floor,Room.sumprice  "
+"FROM dbo.room  where dbo.room.[maap_state]=0 and dbo.room.[seccode] ='"+SectionS+"' and " +" dbo.room.loft='"+Loft+"' and upper(" +"dbo.room.building)='"+building+"' ORDER BY dbo.Room.Floor, dbo.Room.room, dbo.Room.Room_code" ;//+ building.toUpperCase() + "'";
 
		change2RS = changePriceListBean.executeQuery(change2Str);
try{
    String vv="";
		while (change2RS.next()) {
		i=i+1;
			hasRecord = 1;
			code = getbyte(change2RS.getString("Code"));
			if (!vv.equals("")&&vv.equals(code))continue;
			else vv=code;
			//unitprice=  getbyte(change2RS.getString("unitprice"));
			//if (unitprice.equals(""))unitprice="0";
			Loft = getbyte(change2RS.getString("loft"));
			building = getbyte(change2RS.getString("building"));
			room = getbyte(change2RS.getString("room_code"));
		    SaleArea = getbyte(change2RS.getString("area"));
			if (SaleArea.equals(""))SaleArea="0";
			sumprice = getbyte(change2RS.getString("sumprice"));
			//if (sumprice.equals(""))sumprice="0";
		   // contractno = getbyte(change2RS.getString("contractno"));
			//customer=getbyte(change2RS.getString("customer"));

		
 %>
  
  <tr align="center"  class=listcontent> 
  <input type=hidden name=UnitPrice<%=i%> value="<%=FormatD.getFloat1(Float.parseFloat(sumprice)/Float.parseFloat(SaleArea),2) %>">

  <input type=hidden name="Loft2<%=i%>" value="<%= Loft %>" >
  <input type=hidden name="Building<%=i%>" value="<%= building %>" >
   <td > <input type=text name="Room<%=i %>"   readonly    size="4"   value="<%=room.trim() %>"></td> 
   <td > <input type=text name="SaleArea<%=i%>"   readonly  size="8"   value=<%=SaleArea.trim() %>></td>
   <td > <input type=text name="sumprice<%=i%>"  readonly    size="8"   value=<%if (list1.contains(Loft+room)){
		   int index=list1.indexOf(Loft+room);
		  out.print(list2.get(index));
		   }
		 else{out.print("0");}  
		  %> ></td>
   <td > <input type=text name="MappingArea<%=i %>" size="10" value=0 OnChange="check(document.frm.MappingArea<%=i%>);" onkeydown="key(document.frm.MappingUserArea<%=i %>)" onblur="aa<%=i%>();"></td>
 <td > <input type=text name="MappingUserArea<%=i %>" size="10" value=0 OnChange="check(document.frm.MappingUserArea<%=i%>);" onkeydown="key(document.frm.MappingArea<%=i+1 %>)" onblur="aa<%=i%>();"></td>
   <td > <input type=text name="Difference<%=i %>" readonly size="10" value=0></td>
    <td > <input type=text name="DifferencePercent<%=i %>" readonly size="6" value=0></td>
   <td > <input type=text name="priceDifference<%=i %>" readonly size="8" value=0 ></td>
    <td > <input type=text name="mappingprice<%=i %>"  readonly size="8" value=0></td>
<td > <input type=text name="mappingUnitPrice<%=i %>"  readonly size="8" value=0></td>
  <!-- <td > <input type=text name="cq<%=i %>"  size="6" readonly value=0></td>
   
   <td > <input type=text name="ch<%=i %>" readonly size="8" value=0 ></td>
    <td > <input type=text name="qs<%=i %>"  readonly size="8" value=0></td>
   <td > <input type=text name="tax<%=i %>"  size="6" readonly value=0></td>
-->
    <input type=hidden name="customer<%=i %>" value="<%=customer %>">
  </tr>
 
 
    <script>
     function aa<%=i%>(){
     document.frm.Difference<%=i%>.value="0";
	 document.frm.DifferencePercent<%=i%>.value="0";
	 document.frm.mappingprice<%=i%>.value="0";
	 document.frm.priceDifference<%=i%>.value="0";
	//  document.frm.tax<%=i%>.value="0";
	 if (parseInt(document.frm.MappingArea<%=i%>.value)>0){
	 if (document.frm.MappingArea<%=i%>.value!=""&&document.frm.SaleArea<%=i%>.value!=""){
 if (parseFloat(document.frm.sumprice<%=i %>.value)>0){
document.frm.mappingUnitPrice<%=i%>.value=parseFloat(document.frm.sumprice<%=i %>.value)/parseFloat(document.frm.MappingArea<%=i%>.value);	
 document.frm.mappingUnitPrice<%=i%>.value=subs(document.frm.mappingUnitPrice<%=i%>.value,2);
}
 document.frm.Difference<%=i%>.value=parseFloat(document.frm.MappingArea<%=i%>.value)-parseFloat(document.frm.SaleArea<%=i%>.value);
      document.frm.Difference<%=i%>.value=subs(document.frm.Difference<%=i%>.value,3);
	  var percent=document.frm.percent.value;
	  var per=parseFloat(document.frm.Difference<%=i%>.value)/parseFloat(document.frm.SaleArea<%=i%>.value)*100;
	  document.frm.DifferencePercent<%=i %>.value=per;
	  document.frm.DifferencePercent<%=i %>.value=subs(document.frm.DifferencePercent<%=i %>.value,3);
	  var diff=document.frm.DifferencePercent<%=i %>.value;
	  
	  if (parseFloat(diff.substring(diff.indexOf("-")+1))>parseFloat(percent)&&parseFloat(document.frm.sumprice<%=i %>.value)>0){
	      document.frm.priceDifference<%=i %>.value=parseFloat(document.frm.Difference<%=i%>.value)*parseFloat(document.frm.UnitPrice<%=i%>.value);
		  document.frm.priceDifference<%=i %>.value=subs(document.frm.priceDifference<%=i %>.value,2);
		  var diffprice=document.frm.priceDifference<%=i %>.value;
		  document.frm.mappingprice<%=i %>.value=parseFloat(diffprice)+parseFloat(document.frm.sumprice<%=i%>.value);
		  document.frm.mappingprice<%=i %>.value=subs(document.frm.mappingprice<%=i %>.value,2);
		//计税
		}else{
		 document.frm.mappingprice<%=i %>.value=subs(document.frm.sumprice<%=i %>.value,2);
		 }
		//var TaxChage=0;
		//for (var jj=0;jj<TaxRate.length;jj++){
		  // TaxChage+=TaxRate[jj]*parseFloat(document.frm.priceDifference<%=i %>.value);
		  // if (TaxName[jj].indexOf("契税")>=0)document.frm.qs<%=i %>.value=TaxRate[jj]*parseFloat(document.frm.mappingprice<%=i%>.value)/100;
		 //  if (TaxName[jj].indexOf("产权综合费")>=0)document.frm.cq<%=i %>.value=TaxRate[jj]*parseFloat(document.frm.mappingprice<%=i%>.value)/100;
		 //  if (TaxName[jj].indexOf("测绘费")>=0)document.frm.ch<%=i %>.value=TaxRate[jj];
		}
		//document.frm.tax<%=i %>.value=parseFloat(document.frm.qs<%=i %>.value)+parseFloat(document.frm.ch<%=i %>.value)+parseFloat(document.frm.cq<%=i %>.value);
		
		 
	// }
	 }
   }
	</script>
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
    <%if (i>0){ %>
	<p align=center>
	<%if (Cortrol.indexOf("A")>=0){ %>
        <input type="button" name="Button" value="提   交" onclick="InsertMap()"><%} %>
  <!-- <img  src="../picture/button_tj.gif" onclick="InsertMap();">-->      
</p>
<%}else{ %>
     <input type="button" name="Button" value="没查询到已售出的房间">

<%} %>
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
		document.forms[0].action = "MapAreaUpdate.jsp?Operation=Insert&x=" + Math.random() ;
		document.forms[0].submit() ;
		}
	}
</script>
</html>
