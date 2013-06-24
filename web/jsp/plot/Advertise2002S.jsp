<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<HTML>
<HEAD>
<TITLE>Untitled Document</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chamisRset=gb2312"> 
<link rel="stylesheet" href="../class/news.css" >
<script language=javascript src="../sale/js/mad.js"> </script>

</head>
  <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
   <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
 
<%@ include file="../public_js/CheckSection.jsp"%>
<script>
	function submitv() {
		if (document.aform.Building.value == "") {
			alert("请输入栋号");
			return false;
		}	
	}
	


</script>
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

%><script>
	function submitv() {
		if (document.aform.Building.value == "") {
			alert("请输入栋号");
			return false;
		}	
	}
	


</script>
<script language="javascript" src="../public_js/public.js">

</script>

<body onload="loadForm();">
<%
	//String saleStr = "select id,name,secno,building,room,cus_name,cus_no,htno,saleprice,ajbk,ajcs,ajmoney,ajyear from ajlistv2 ";
	 //      saleStr += " where  secno='" + section + "' and building like '%" + building  + "%' and section is null";
	//  out.print(saleStr);
		
%>
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
<form>
  <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
    <TR> 
    <TD COLSPAN="2"> 
      <DIV ALIGN="CENTER">广告一览表(查询)</DIV>
    </TD>
  </TR>
  <!--TR> 
    <TD COLSPAN="2" height=10></TD>
  </TR>
  <TR > 
      <TD width="42%">搂盘 
        <select name="Section" onchange="ChangeSection()">
		<%
			String firstNo = "" ;
			String getStr = "select serialNo, name from section" ;
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
					 
				}		
		%>
			<option value="<%= no %>"><%= name %>
		<%
			}
			getRs.close() ;
		%>	
		<option value="All">
      </select>
    </TD>
	
      <TD width="58%">
<div align="right">
		<a href="javascript:Add()">登记</a>&nbsp 
		<a href="javascript:Modify()">修改</a>&nbsp 
		<a href="javascript:Delete()">删除</a>&nbsp 
		<a href="javascript:Finish()">完成</a>&nbsp 
		<a href="javascript:Search()">查询</a>&nbsp 
		<a href="javascript:TongJi()">统计</a>&nbsp&nbsp
		</div></TD>
  </TR-->
  <TR> 
    <TD COLSPAN="2" height=10> </TD>
  </TR>
</TABLE>
<script>
	function loadForm() {
		
	}
</script>
  <%
  		String sListName = "AdvertiseListSearch" ;
		String sectionStr = "", typeStr = "", nameStr = "", specStr = "", phaseStr = "",
				beginDateStr = "", finishDateStr = "" ;
		if (!section.equals("") && !section.equals("All"))
			sectionStr = " and a.section = '" + section + "' " ;
		String typeP = China.getParameter(request, "Type") ;
		String nameP = China.getParameter(request, "Name") ;
		String specP = China.getParameter(request, "Spec") ;
		String phaseP = China.getParameter(request, "Phase") ;
		String beginDateP = China.getParameter(request, "BeginDate") ;
		String finishDateP = China.getParameter(request, "FinishDate") ;		
		if (!typeP.equals(""))
			typeStr = " and a.type = '" + typeP + "' " ;
		if (!nameP.equals(""))
			nameStr = " and a.name like '%" + nameP + "%' " ;
		if (!specP.equals(""))
			specStr = " and a.spec like '%" + specP + "%' " ;
		if (!phaseP.equals(""))
			phaseStr = " and a.phase like '%" + phaseP + "%' " ;
		if (!beginDateP.equals(""))
			beginDateStr = " and a.beginDate = '" + beginDateP + "' " ;
		if (!finishDateP.equals(""))
			finishDateStr = " and a.finishDate = '" + finishDateP + "' " ;
														
		String sConditionStr = " from advertise a, section s " + 
							" where a.section = s.serialNo " +
								sectionStr + typeStr + nameStr + phaseStr +
								specStr + beginDateStr + finishDateStr  ;
		String sAmisStr = "select a.id id, a.type, a.name," +
				" a.spec, a.time, a.unitPrice, a.times, a.totalPrice, a.beginDate," + 
				" a.finishDate  " + sConditionStr ;
				
		// out.print(sAmisStr) ;
		String sCountStr = "select count(*) counts " + sConditionStr ;
  %>
  <%@ include file="P_PageListHead5.jsp" %>
  
  <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
    <tr bgcolor="#CFE6EB"> 
      <TD WIDTH="7%"> 
        <DIV ALIGN="CENTER">类别</DIV>
      </TD>
      <TD WIDTH="15%"> 
        <DIV ALIGN="CENTER">媒体名称</DIV>
      </TD>
      <TD WIDTH="18%"> 
        <DIV ALIGN="CENTER">规格</DIV>
      </TD>
      <TD WIDTH="11%"> 
        <DIV ALIGN="CENTER">时长</DIV>
      </TD>
      <TD WIDTH="8%"> 
        <DIV ALIGN="CENTER">单价</DIV>
      </TD>
      <TD WIDTH="8%"> 
        <DIV ALIGN="CENTER">次数</DIV>
      </TD>
      <TD WIDTH="9%"> 
        <DIV ALIGN="CENTER">总价</DIV>
      </TD>
      <TD WIDTH="11%"> 
        <div align="center">开始日期</div>
      </TD>
      <TD WIDTH="13%"> 
        <DIV ALIGN="CENTER">结束日期</DIV>
      </TD>
    </TR>
    <%
   
	int id = 0, time = 0, unitPrice = 0, times = 0, totalPrice = 0 ;
	String type = "", name = "", spec = "", beginDate = "", finishDate = "" ;	
	int iK = 0 ;
	int iLost2 = 0 ;
	while (iSkip-- > 0 && amisRs.next()) ;  
	while (amisRs.next() && iPageCount-- > 0) {	
		id = amisRs.getInt("id") ;
		type = getbyte(amisRs.getString("type"));
		name = getbyte(amisRs.getString("name"));
		spec = getbyte(amisRs.getString("spec"));
		time = amisRs.getInt("time") ;
		unitPrice = amisRs.getInt("unitPrice") ;
		times = amisRs.getInt("times") ;
		totalPrice = amisRs.getInt("totalPrice") ;
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
    <tr align="center" BGCOLOR="<%= sColor %>"  onclick="ChangeTrColor(this, '<%= id %>', '<%= id %>', '<%= id %>', 'A6D3A6', 'f6f6f6')"  > 
      <TD WIDTH="7%"> 
        <DIV ALIGN="CENTER"><%= type %></DIV>
      </TD>
      <TD WIDTH="15%"> 
        <DIV ALIGN="CENTER"><%= name %></DIV>
      </TD>
      <TD WIDTH="18%"> 
        <DIV ALIGN="CENTER"><%= spec %></DIV>
      </TD>
      <TD WIDTH="11%"> 
        <DIV ALIGN="CENTER"><%= time %></DIV>
      </TD>
      <TD WIDTH="8%"> 
        <DIV ALIGN="CENTER"><%= unitPrice %></DIV>
      </TD>
      <TD WIDTH="8%"> 
        <DIV ALIGN="CENTER"><%= times %> </DIV>
      </TD>
      <TD WIDTH="9%"> 
        <DIV ALIGN="CENTER"><%= totalPrice %></DIV>
      </TD>
      <TD WIDTH="11%"> 
        <div align="center"><%= beginDate %></div>
      </TD>
      <TD WIDTH="13%"> 
        <DIV ALIGN="CENTER"><%= finishDate %></DIV>
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
			window.location = "AjDoSearch.jsp?Section=<%= section %>&x=" + Math.random() ;
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
			width2 = 500 ;
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
			if (itemNo == "") 
				alert("请先选择广告") ;
			else
				window.open("AdvertiseUpdate.jsp?AdvertiseId=" + itemNo + "&Operation=Delete&x=" + Math.random(), 'PopWindowAll', "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=" + top2 + ",left=" + left2 + ",width=" + width2 + ",height=" + height2) ;
		}
  </script>
</BODY>
</HTML>
