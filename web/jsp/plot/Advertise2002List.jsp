<%@ page contentType="text/html;charset=GBK" %>
 
<%@ include file="../public_js/checktime.jsp"%>
<HTML>
<HEAD>
<TITLE>广告管理</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chamisRset=gb2312"> 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language=javascript src="../sale/js/mad.js"> </script>

</head>
  <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
 
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
  <%@ include file="../public_js/getByteOut.jsp"%>
 
<%@ include file="../public_js/CheckSection.jsp"%>
 
<script language="javascript" src="../public_js/public.js">

</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<body onload="loadForm();">
 
 
<% 
String section=getbyte1(request.getParameter("Section")); 
String order=getbyte1(request.getParameter("order"));
String orderby=getbyte1(request.getParameter("orderby"));
if (orderby.equals(""))orderby="desc";
 
if (!order.equals(""))order=" order by "+order+" "+orderby;
String BeginDate=getbyte1(request.getParameter("time1"));
String FinishDate=getbyte1(request.getParameter("time2"));
if (!BeginDate.equals("")) BeginDate=" and  a.BeginDate>='"+BeginDate+"'";
if (!FinishDate.equals("")) FinishDate=" and  a.FinishDate<='"+FinishDate+"'";


 
try{
    defaultNo=(String)session.getAttribute("defaultNo");
}catch(Exception s){
}
if ( defaultNo == null ) {
    defaultNo="";//如何用户未设置默认楼盘，则显示用户选中或所有楼盘的楼栋
}
if (!defaultNo.equals(""))
{
    SectionS=defaultNo;
    SecNo=defaultNo;
}
 
if ( !SecNo.equals("") ) { 
    FindWhere=" where SerialNo='"+SecNo+"'";
}else{
    FindWhere=" where SerialNo in("+SectionS+")";
}

%> 
<script language="javascript" src="../public_js/public.js">

</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<body onload="loadForm();">
 

<%!
	public String getFloat(float temp,int lens) {
		java.text.DecimalFormat df = null;
		if (lens == 4)
			df = new java.text.DecimalFormat("###.#####");
		if (lens == 2)
			df = new java.text.DecimalFormat("###,###,###.##");
		if (lens == 1)
			df = new java.text.DecimalFormat("###,###,###");	
		return df.format(temp).toString();
	}

%>
<form name="AdvList">
   <p align="center"><b><font size="3" color="#000080">广告一览表</font></b></p>
  <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
  
  <TR> 
    <TD COLSPAN="2" height=10></TD>
  </TR>
  <TR > 
      <TD width="42%">
       
    </TD>
    </TR>
</TABLE>
	    <table width=100%><tr height="16" bgcolor="#EAEAEA">
		<td> 时间段: 从<input type=input name=time1 size=10 readonly value="" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(time1);return false;">到<input type=input name=time2 size=10 readonly value="" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(time2);return false;"> <input type=submit name=aa value="查找"></td>
		<td align="right">
		<select name="Section" onchange="ChangeSection()">
   
搂盘 		<%
			String firstNo = "" ;
			String getStr = "select serialNo, name from CRM_Project where SerialNo in("+SectionS+")" ;
			ResultSet getRs = bBean.executeQuery(getStr) ;
			int i = 0 ;
			while (getRs.next()) {
				i++ ;
				String no = getRs.getString("serialNo") ;
				String name = getRs.getString("name") ;
				name = getbyte(name) ;
				if (i == 1)
					firstNo = no ;
				if (section.equals("")) {
					section = firstNo ;
					session.setAttribute("Advertise-Section", section) ;
				}		
		%>
			<option value="<%= no %>"><%= name %>
		<%
			}
			getRs.close() ;
		%>	
		<option value="All">
      </select>
	    <%@ include file="../public_js/qx_checke.jsp"%>
	    	 <%String
Cortrol=checke_qx(aBean,(String)session.getAttribute("loginid"),"market4");
   if (Cortrol==null)Cortrol="";
    %>
	
		  
    <%if (Cortrol.indexOf("A")>=0){ %>
	  <input type=button name=pri value="增 加" onclick="Add();">
	<%}if (Cortrol.indexOf("E")>=0){ %>
	    <input type=button name=mo value="修 改" onclick="Modify();">
	<%}if (Cortrol.indexOf("D")>=0){ %>
	   <input type=button name=de value="删 除" onclick="Delete();">
	  <%} %>
	 
		</td></tr></table>

<script>
	function loadForm() {
		setSelectMad(document.forms[0].Section, "<%= section %>") ;
	}
</script>
  <%
  		String sListName = "AdvertiseList" ;
		String sectionStr = "" ;
		if (!section.equals("") && !section.equals("All"))
			sectionStr = " and a.section = '" + section + "' " ;
					
		String sConditionStr = " from advertise a, CRM_Project s " + 
							" where a.section = s.serialNo  and s.serialNo in("+SectionS+")" +
								sectionStr ;
		String sAmisStr = "select a.section,a.id id, a.type, a.name," +
				"  a.format, a.time,  a.times,a.location, a.totalPrice, a.beginDate,a.region," + 
				" a.finishDate  " + sConditionStr +BeginDate + FinishDate+ order;
				
	 if (orderby.trim().equals("desc"))orderby="asc";
	 else orderby="desc";
	 // out.print(sAmisStr) ;
	// out.close();
		String sCountStr = "select count(*) counts " + sConditionStr ;
  %>
  <%@ include file="P_PageListHead5.jsp" %>
  
  <table BORDER=0 width="100%"  CELLSPACING=1 CELLPADDING=3 ALIGN=center>
  <tr class=TXTColor align="center">
      <TD> 
         <a href="Advertise2002List.jsp?order=a.TYPE&orderby=<%=orderby %>" class="TXTColor">类别</a> 
      </TD>
      <TD> 
        <a href="Advertise2002List.jsp?order=a.name&orderby=<%=orderby %>" class="TXTColor">媒体名称</a> 
      </TD>
	   <TD> 
        <a href="Advertise2002List.jsp?order=a.region&orderby=<%=orderby %>" class="TXTColor">区域</a> 
      </TD>
      <TD> 
         <a href="Advertise2002List.jsp?order=a.format&orderby=<%=orderby %>" class="TXTColor">版式</a>
      </TD>
      <TD> 
         <a href="Advertise2002List.jsp?order=a.location&orderby=<%=orderby %>" class="TXTColor">版位</a>
      </TD>
    
      <TD> 
        <a href="Advertise2002List.jsp?order=a.times&orderby=<%=orderby %>" class="TXTColor">频次</a> 
      </TD>
      <TD> 
        <DIV ALIGN="CENTER"><a href="Advertise2002List.jsp?order=a.TotalPrice&orderby=<%=orderby %>" class="TXTColor">总价(万)</a></DIV>
      </TD>
      <TD> 
        <div align="center">开始日期</div>
      </TD>
      <TD> 
        <DIV ALIGN="CENTER">结束日期</DIV>
      </TD>
	   <TD> 
        <DIV ALIGN="CENTER">销售情况</DIV>
      </TD>
    </TR>
    <%
   
	int id = 0,  unitPrice = 0, times = 0, totalPrice = 0 ;
	String type = "",location="", region="",time = "",name = "", spec = "", beginDate = "", finishDate = "" ;	
	int iK = 0 ;
	i=0;
	int iLost2 = 0 ;
	while (iSkip-- > 0 && amisRs.next()) ;  
	while (amisRs.next() && iPageCount-- > 0) {	
		i++;
		section= getbyte(amisRs.getString("section"));
		id = amisRs.getInt("id") ;
		type = getbyte(amisRs.getString("type"));
		name = getbyte(amisRs.getString("name"));
		spec = getbyte(amisRs.getString("format"));
		time = getbyte(amisRs.getString("time")) ;
		location = amisRs.getString("location") ;
		times = amisRs.getInt("times") ;
		totalPrice = amisRs.getInt("totalPrice") ;
		region=getbyte(amisRs.getString("region")) ;
		beginDate = amisRs.getString("beginDate") ;
		finishDate = amisRs.getString("finishDate") ;
		try {
			beginDate = beginDate.substring(2, 10) ;
		} catch (Exception e) {
			beginDate = "" ;
		}	
		try {
			finishDate = finishDate.substring(2, 10) ;
		} catch (Exception e) {
			finishDate = "" ;
		}	
		
		iK++ ;
		iLost2 = iK % 2 ;	
		String sColor = "ffffff" ;
		if (iLost2 == 1)
			sColor = "f6f6f6" ;		
			
		
		
		
   %>
    <tr  id=TR<%=i %>  align="center" BGCOLOR="<%= sColor %>" ondblclick="openwin('../sale/saleFx2.jsp?section=<%=section %>&date1=<%=beginDate %>&date2=<%=finishDate %>',550,450,50,50);" class='listcontent' onmouseover="mout(this);" onclick="ChangeTrColor(this, '<%= id %>', '<%= id %>', '<%= id %>', 'A6D3A6', 'f6f6f6');changeclass1(this,'clickbg','listcontent');"   > 
      <TD> 
        <DIV ALIGN="CENTER"><%= type %></DIV>
      </TD>
      <TD> 
        <DIV ALIGN="CENTER"><%= name %></DIV>
      </TD>
	    <TD> 
        <DIV ALIGN="CENTER"><%= region %></DIV>
      </TD>
      <TD> 
        <DIV ALIGN="CENTER"><%= spec %></DIV>
      </TD>
      
      <TD> 
        <DIV ALIGN="CENTER"><%= location %></DIV>
      </TD>
      <TD> 
        <DIV ALIGN="CENTER"><%= times %> </DIV>
      </TD>
      <TD> 
        <DIV ALIGN="CENTER"><%= totalPrice %></DIV>
      </TD>
      <TD> 
        <div align="center"><%= beginDate %></div>
      </TD>
      <TD> 
        <DIV ALIGN="CENTER"><%= finishDate %></DIV>
      </TD>
	  <TD> 
        <DIV ALIGN="CENTER"><a href="#" onclick="openwin2('../sale/saleFx2.jsp?section=<%=section %>&date1=<%=beginDate %>&date2=<%=finishDate %>',550,450,50,50);">销售情况</a></DIV>
      </TD>
	   
    </TR>
    <%
   	}
		
   %>
  </TABLE>
  </form>
  <script>
  	// set color and save value ;	
		var itemNo = "" ;   // roomNo
		var isOut = 0 ;   //rent or sale out
		var lastObject ;
		var ajMoneyStr ;
		
		function ChangeTrColor(element2, isOut2, idNo, ajMoney2, inColor, outColor) {
			// isOut = parseInt(isOut2) ;
			if (itemNo == "") 
				element2.bgColor = inColor ;
			else {
					
				lastObject.bgColor = outColor ;
				element2.bgColor = inColor ;
			}	
			itemNo = idNo ;
			lastObject = element2 ;
			ajMoneyStr = ajMoney2 ;
			isOut = isOut2 ;
		}	
		
		top2 = (screen.availHeight - 500) / 2 ;
		left2 = (screen.width - 620) / 2  ;
		height2 = 480 ;
		width2 = 620 ;
		
		function Register() {
			top2 = (screen.availHeight - 260) / 2 ;
			left2 = (screen.width - 520) / 2  ;
			height2 = 240 ;
			width2 = 500 ;
			if (itemNo == "") 
				alert("请先选择客户") ;
			else 	
				window.open("AjDoc.jsp?AjId=" + itemNo + "&x=" + Math.random(), 'PopWindowAll', "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=" + top2 + ",left=" + left2 + ",width=" + width2 + ",height=" + height2) ;
		}
		
		function Flow() {
			top2 = (screen.availHeight - 500) / 2 ;
			left2 = (screen.width - 620) / 2  ;
			height2 = 480 ;
			width2 = 620 ;
			if (itemNo == "") 
				alert("请先选择客户") ;
			else 	
				window.open("AjFlow.jsp?AjMoney=" + ajMoneyStr + "&SaleId=" + itemNo + "&x=" + Math.random(), 'PopWindowAll', "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=" + top2 + ",left=" + left2 + ",width=" + width2 + ",height=" + height2) ;
		}
		
		function AjHtAdd(saleId2) {
			top2 = (screen.availHeight - 320) / 2 ;
			left2 = (screen.width - 500) / 2  ;
			height2 = 300 ;
			width2 = 500 ;
			window.open("AjHtAdd.jsp?SaleId=" + saleId2 + "&x=" + Math.random(), 'PopWindowAll', "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=" + top2 + ",left=" + left2 + ",width=" + width2 + ",height=" + height2) ;
		}
		
		function AjHtModify(saleId2, AjHtNo) {
			top2 = (screen.availHeight - 320) / 2 ;
			left2 = (screen.width - 500) / 2  ;
			height2 = 300 ;
			width2 = 500 ;
			window.open("AjHtModify.jsp?SaleId=" + saleId2 + "&AjHtNo=" + AjHtNo + "&x=" + Math.random(), 'PopWindowAll', "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=" + top2 + ",left=" + left2 + ",width=" + width2 + ",height=" + height2) ;
		}
		
		function DoFlow(flowId2, saleId2) {
			// alert(idtemp) ;
			top2 = (screen.availHeight - 260) / 2 ;
			left2 = (screen.width - 450) / 2  ;
			height2 = 240 ;
			width2 = 450 ;
			window.open("AjDoAdd.jsp?FlowId=" + flowId2 + "&SaleId=" + saleId2 + "&x=" + Math.random(), 'PopWindowAll', "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=" + top2 + ",left=" + left2 + ",width=" + width2 + ",height=" + height2) ;
		}
		
		function Search() {
			window.location = "AdvertiseSearch.jsp?x=" + Math.random() ;
		}
		
		function SeeCustomer(cusno) {
			openwin("../customter/listcusdata.jsp?cusno="+cusno,500,520,100,5);
		}
		
		function SeeSale(roomNo) {
			// alert("a" + roomNo + "b") ;
			 openwin("../sale/saleinfo1.jsp?secno=<%= section %>&show=true",600,500,100,10) ;
		}
		
		function ChangeSection() {
			document.forms[0].submit() ;
		}
		
		function Add() {
			top2 = (screen.availHeight - 420) / 2 ;
			left2 = (screen.width - 500) / 2  ;
			height2 = 400 ;
			width2 = 550 ;
			window.open("AdvertiseAdd.jsp?&x=" + Math.random(), 'PopWindowAll', "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=" + top2 + ",left=" + left2 + ",width=" + width2 + ",height=" + height2) ;
		}
		function Modify() {
			top2 = (screen.availHeight - 420) / 2 ;
			left2 = (screen.width - 500) / 2  ;
			height2 = 400 ;
			width2 = 500 ;
			if (itemNo == "") 
				alert("请先选择广告") ;
			else 	
				window.open("AdvertiseModify.jsp?AdvertiseId=" + itemNo + "&x=" + Math.random(), 'PopWindowAll', "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=" + top2 + ",left=" + left2 + ",width=" + width2 + ",height=" + height2) ;
		}
		function Delete() {
			top2 = (screen.availHeight - 420) / 2 ;
			left2 = (screen.width - 500) / 2  ;
			height2 = 400 ;
			width2 = 500 ;
			if (confirm("确认删除广告吗?")){
			if (itemNo == "") 
				alert("请先选择广告") ;
			else
				window.open("AdvertiseUpdate.jsp?AdvertiseId=" + itemNo + "&Operation=Delete&x=" + Math.random(), 'PopWindowAll', "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=" + top2 + ",left=" + left2 + ",width=" + width2 + ",height=" + height2) ;
		    }		
		}
		
		function Finish() {
			top2 = (screen.availHeight - 420) / 2 ;
			left2 = (screen.width - 500) / 2  ;
			height2 = 400 ;
			width2 = 500 ;
			if (itemNo == "") 
				alert("请先选择广告") ;
			else
				window.open("AdvertiseFinish.jsp?AdvertiseId=" + itemNo + "&Operation=Insert&x=" + Math.random(), 'PopWindowAll', "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=" + top2 + ",left=" + left2 + ",width=" + width2 + ",height=" + height2) ;
		}
		
		function TongJi() {
			window.location = "AdvertiseTjSearch.jsp?section="+document.AdvList.Section.value+"&x=" + Math.random() ;
		}
  </script>
</BODY>
</HTML>
