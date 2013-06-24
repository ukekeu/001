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
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
<%@ include file="../public_js/getByteOut.jsp"%>

<%
	
	
	String section = (String) session.getAttribute("Advertise-Section") ;
	if (section == null)
		section = "" ;
	
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
<p    align="center"  class=FontColor><b><font size="3">广告统计表</font></b></p>
 
<script>
	function loadForm() {
		
	}
</script>
  <%
  		String sListName = "AdvertiseTjSearch" ;
		String sectionStr = "", typeStr = "", nameStr = "", specStr = "", phaseStr = "",
				beginDateStr = "", finishDateStr = "" ;
		if (!section.equals("") && !section.equals("All"))
			sectionStr = " and a.section = '" + section + "' " ;
		
		String phaseP = China.getParameter(request, "Phase") ;
		String BeginDate= China.getParameter(request, "BeginDate") ;	
		String FinishDate= China.getParameter(request, "FinishDate") ;	
		if (!phaseP.equals(""))
			phaseStr = " and a.phase like '%" + phaseP + "%' " ;
		if (!FinishDate.equals("")&&!BeginDate.equals(""))
			phaseStr = " and substring(convert(char(24),BeginDate,120),1,10)>='" + BeginDate + "' and substring(convert(char(24),FinishDate,120),1,10)<='"+FinishDate +"'";											
		String sConditionStr = " from advertise a, section s " + 
							" where a.section = s.serialNo " +
								phaseStr  ;
		String sAmisStr = "select  a.name," +
				" a.totalPrice, a.actualTotal, a.comeTimes, a.cusCount, a.saleCount, a.saleArea," + 
				" a.saleMoney  " + sConditionStr ;
				
		
		String sCountStr = "select count(*) counts " + sConditionStr ;
  %>
  <%@ include file="P_PageListHead5.jsp" %>
  
  <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >
    <tr class=TXTColor align="center"> 
      
      <TD> 
         媒体名称
      </TD>
      <TD > 
         计划总价
      </TD>
      <TD > 
         实际总价
      </TD>
      
      <TD > 
         来电次数
      </TD>
      <TD > 
         接待人数</DIV>
      </TD>
      <TD > 
         落定单元
      </TD>
      <TD > 
         落定面积
      </TD>
	  <TD > 
         落定金额
      </TD>
    </TR>
    <%
   
	int id = 0, totalPrice = 0, comeTimes = 0, cusCount = 0, saleCount = 0 ;
	float actualTotal = 0, saleArea = 0, saleMoney = 0;
	String name = "" ;	
	int iK = 0 ;
	int iLost2 = 0 ;
	while (iSkip-- > 0 && amisRs.next()) ;  
	while (amisRs.next() && iPageCount-- > 0) {	
		
		name = getbyte(amisRs.getString("name"));
		totalPrice = amisRs.getInt("totalPrice");
		actualTotal = amisRs.getFloat("actualTotal") ;
		comeTimes = amisRs.getInt("comeTimes") ;
		
		cusCount = amisRs.getInt("cusCount") ;
		saleCount = amisRs.getInt("saleCount") ;
		saleArea = amisRs.getFloat("saleArea") ;
		saleMoney = amisRs.getFloat("saleMoney") ;
		
		
		iK++ ;
		iLost2 = iK % 2 ;	
		String sColor = "ffffff" ;
		if (iLost2 == 1)
			sColor = "f6f6f6" ;		
		
   %>
    <tr align="center" class=listcontent BGCOLOR="<%= sColor %>"  onclick="ChangeTrColor(this, '<%= id %>', '<%= id %>', '<%= id %>', 'A6D3A6', 'f6f6f6');changeclass1(this,'clickbg','listcontent');"  > 
      <TD> 
         <%= name %>
      </TD>
      <TD > 
         <%= totalPrice %>
      </TD>
      <TD WIDTH="18%"> 
         <%= actualTotal %>
      </TD>
      <TD > 
         <%= comeTimes %>
      </TD>
      <TD > 
         <%= cusCount %>
      </TD>
      <TD  
         <%= saleCount %> 
      </TD>
      <TD> 
         <%= saleArea %>
      </TD>
      <TD > 
         <%= saleMoney %>
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
