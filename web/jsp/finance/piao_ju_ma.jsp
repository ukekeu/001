<%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
<HTML>
<HEAD>
<TITLE>票据管理</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chAjRset=gb2312"> 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language=javascript src="../sale/js/mad.js"> </script>
 
</head>
  <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
   <jsp:useBean id="setpro" scope="session" class="setProperty.setProperty"/>   
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
 <%
String Cortrol=checke_qx(aBean,(String)session.getAttribute("loginid"),"A002");


 %>
 

<body >
 

  		 
<form name="cus" action="AjListS.jsp" method="post">
   
 
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
  <TR> 
     <TD COLSPAN="2" class=FontColor>
      <DIV ALIGN="CENTER"><font size=4>发票管理</font></DIV>
    </TD>
  </TR>
  <TR> 
    <TD COLSPAN="2" height=10></TD>
  </TR>
  
  <TR >
    <TD  >
	<input type=hidden name=ajstate value="<%=ajstate %>">
     <input type="radio" value="0" checked name=state1 onclick="ch(this.value);" <%=checkState1 %>> 未办&nbsp;<input type="radio" value="3"  <%=checkState3 %> name=state1 onclick="ch(this.value);">待办&nbsp;<input type="radio" value="1"  <%=checkState2 %> name=state1 onclick="ch(this.value);">已办 </TD><td align="right">&nbsp;<br>&nbsp;房号:<input type=text size=5 name=room>&nbsp;客户姓名:<input type=text name=findcusname>&nbsp;<input type=button name=find value=" 查 找" onclick="SearchA();"></td>
	 
	
  </TR>
  <TR>
    <TD COLSPAN="2" height=10>
    
	<%if (checkState1.equals("checked")) {%>  <input type=button name=sd value="送办按揭" onclick="sendaj();"><%} %>&nbsp;<%if (checkState3.equals("checked")) {%> <input type=button name=sda value="按揭明细" onclick="aj1();"><%} %>&nbsp;<%if (checkState2.equals("checked")) {%> <input type=button name=sda value="送抵押" onclick="dyqd();">&nbsp;<input type=button name=sda value="打印抵押清单" onclick="dyqd1();"><%} %>
    </TD>
  </TR>
</TABLE>
  <%

		String sListName = "AjList" ;
		String floors="";
		String ajcs="";	
		session.setAttribute("S_CurrentPageCount" + sListName, "10000") ;
		String sConditionStr = " from Order_Contract s, customer c" + 
							" where not s.visadate is null and  c.serialNo = s.customer " + 
								
								"  and s.state=2 and s.payment like '%按揭%' " + roomStr + bankStr + flowStr + sdateStr + slouStr ;
		String Str = "select s.code saleId, s.section,s.floors,s.sectionname, s.loft, s.building, s.room_no, c.signatory cus_name," +
				"c.Phone, c.serialno cus_no, s.ContractNo htno, s.salerprice salePrice, s.ajMoney ajmoney, s.ajHtno," + 
				" s.ajyear,s.ajcs, s.MonthPayMoney,s.ajbk, s.ajdate,s.aj_send_date,s.visadate,s.bxstate,s.gzstate,s.gtsj_date,s.gtcz_date,s.fkdate,s.dyyj " + sConditionStr +search+ " order by s.sectionname, s.loft, s.building, s.floors,s.room_no ";
	 ResultSet AjRs = aBean.executeQuery(Str) ;
	 

 %>
 
<!--  <div align=center id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >-->
<table BORDER=0 width="130%" CELLSPACING=1 CELLPADDING=1 >
  <tr class=TXTColor ALIGN=center > 
      <TD > 序号<input type=checkbox name=sh onclick=" chooseCheckbox(this.checked);"> </TD><TD >房号 </TD>
      <TD > 客户</TD><TD  >  按揭合同</TD>
      <TD  >总价</TD><td>按揭款 </TD>
      <TD  > 年限 </TD> 
      <TD > 银行</TD>
	   <TD > 签约日期</TD>
       <TD > 
	   <%if (ajstate.equals("3")){ %>
     送办日期 
     <%}else if (ajstate.equals("1")){  %>
	  按揭日期
	  
 	  <%} %>
      </TD>
	   <TD > 
	   <%  if (ajstate.equals("1")){  %>
	  放款日期
	  
 	  <%} %>
      </TD>
	    <TD > 
	   <%  if (ajstate.equals("1")){  %>
	  国土送件日期
	  
 	  <%} %>
      </TD>
	    <TD > 
	   <%  if (ajstate.equals("1")){  %>
	  国土出证日期
	  
 	  <%} %>
      </TD>
     </TR>
    <%
   	int id = 0, ajYear = 0, ajHtId = 0 ,i=0 ;
	String room = "",sectionName2="", customer = "", cusNo = "", phone="",htno = "", ajHtNo = "", ajBk = "",
			ajDate = "", ajMoneyStr = "", salePriceStr = "", isRegister = "0", name = "" ,ajHtno="";  	
	String ajSection = "",aj_send_date="" ,visadate="";
	float salePrice = 0, ajMoney = 0;		
	float monthpay=0;
	int iK = 0, sequence = 0, flowId = 0 ;
	int iLost2 = 0, saleId = 0 ;
    int id2=0;
	String bxstate="",gzstate="",gtcz_date="",gtsj_date="";
 
	
	while (AjRs.next() ) {	
	 i++;
		saleId = AjRs.getInt("saleId") ;
		ajSection = AjRs.getString("section") ;
		floors = AjRs.getString("floors") ;
		sectionName2 = getbyte(AjRs.getString("sectionname"));
		loft=getbyte(AjRs.getString("loft").trim());
		building=getbyte(AjRs.getString("building").trim());
	 	room = AjRs.getString("room_no").trim();
		customer = getbyte(AjRs.getString("cus_name"));
		phone= getbyte(AjRs.getString("phone"));
		cusNo = AjRs.getString("cus_no") ;
		htno = getbyte(AjRs.getString("htno"));
		salePrice = AjRs.getFloat("saleprice");
		salePriceStr = getFloat(salePrice,1);
		ajMoney = AjRs.getFloat("ajmoney");
		ajMoneyStr = getFloat(ajMoney,1);
		ajHtno =getbyte(AjRs.getString("ajHtno"));
		ajYear=AjRs.getInt("ajyear");
		ajcs=AjRs.getString("ajcs");
		monthpay=0;
		 monthpay=AjRs.getFloat("MonthPayMoney");
		  
		ajBk = AjRs.getString("ajbk");
		ajDate= getbyte(AjRs.getString("ajDate"));
		 aj_send_date= getbyte(AjRs.getString("aj_send_date"));
		 visadate=AjRs.getDate("visadate").toString();
		 if (!aj_send_date.equals(""))aj_send_date=aj_send_date.substring(0,10);
		if (ajDate.indexOf(" ")>0)ajDate=ajDate.substring(0,ajDate.indexOf(" "));
if (ajDate.indexOf("1900")>=0)ajDate="";
		ajBk = getbyte(ajBk) ;
		bxstate=getbyte(AjRs.getString("bxstate"));
		gzstate=getbyte(AjRs.getString("gzstate")); 
		gtsj_date=getbyte(AjRs.getString("gtsj_date"));
		if (!gtsj_date.equals(""))gtsj_date=gtsj_date.substring(0,10);
		gtcz_date=getbyte(AjRs.getString("gtcz_date")); 
    	if (!gtcz_date.equals(""))gtcz_date=gtcz_date.substring(0,10);
		String fk_date=getbyte(AjRs.getString("fkdate"));
		if (!fk_date.equals(""))fk_date=fk_date.substring(0,10);
		boolean dyyj=AjRs.getBoolean("dyyj");
   %>
  
		<%if (Cortrol.indexOf("A")>=0){ %>
		      
    <tr align="center" title="双击可弹出窗口登记或修改" id=R<%=i %>  ondblclick="openwin('inputAj.jsp?saleid=<%=saleId %>&monthpay=<%=monthpay %>&ajyear=<%=ajYear %>&ajcs=<%=ajcs %>&ajbk=<%=ajBk %>&ajHt=<%=ajHtno %>&ajDate=<%=ajDate %>&bxstate=<%=bxstate %>&gzstate=<%=gzstate %>&gtcz_date=<%=gtcz_date %>&gtsj_date=<%=gtsj_date %>',350,320,100,100);"  class='listcontent' onclick="changeclass1(this,'clickbg','listcontent');ChangeTrColor(this, '<%= saleId %>', '<%= saleId %>', '<%= ajMoney %>', 'A6D3A6', 'f6f6f6')"  > 
    <%}else{ %>
	  <tr align="center"   id=R<%=i %>     class='listcontent' onclick="changeclass1(this,'clickbg','listcontent');ChangeTrColor(this, '<%= saleId %>', '<%= saleId %>', '<%= ajMoney %>', 'A6D3A6', 'f6f6f6')"  > 
  
  <%} %>
	  <TD> 
  <%= i %> <%if (!dyyj){ %><input name="aa" value="<%=saleId %>" type="checkbox"><%} %>
      </TD>
	  <TD> 
        <a href="#" onclick="openwin1('../sale/showContract.jsp?secname=&secno=<%=ajSection %>&roomno=<%=room %>&build=<%=building %>&loft=<%=loft%>&Floor=<%=floors %>&show=true',680,530,50,2);"><%=loft+ room %></a> 
      </TD>
      <TD> 
         <a href="javascript:SeeCustomer('<%= cusNo %>')"><%= customer %></a> 
      </TD>
	  
      <TD > 
         <a href="#" onclick="openwin1('../sale/showContract.jsp?secname=&secno=<%=ajSection %>&roomno=<%=room %>&build=<%=building %>&loft=<%=loft%>&Floor=<%=floors %>&show=true',680,530,50,2);"><%= ajHtno %></a> 
      </TD>
      <TD> 
        <%= salePriceStr %> 
      </TD>
      <TD > 
     <%= ajMoneyStr %> 
      </TD>
   
      <TD> 
  <%=ajYear %> 
      </TD>
	  
      <TD > 
        <%= ajBk %>
      </TD>
	  <td> <%= visadate %> </td>
      <TD > 
       <%if (ajstate.equals("3")){ %>
	     <%= aj_send_date %> 
	   <%}if (ajstate.equals("1")){  %>
	     <%= ajDate %>
		 
		 
		<%} %>
      </TD>
    <TD > 
       <% if (ajstate.equals("1")){  %>
	     <%= fk_date %>
		 
		 
		<%} %>
      </TD>
	   <TD > 
       <% if (ajstate.equals("1")){  %>
	     <%= gtsj_date %>
		 
		 
		<%} %>
      </TD>
	   <TD > 
       <% if (ajstate.equals("1")){  %>
	     <%= gtcz_date %>
		 
		 
		<%} %>
      </TD>
    </TR>
    <%
   	}
   %>
  </TABLE>
  
  
 
<script>
  function bringToExcel(){

   // get all the text
   var pasteText = document.all.report1.innerHTML;

   // copy all the text to clipboard
   window.clipboardData.setData ("Text", pasteText);

     // Start Excel and get Application object.     
     var oXL = new ActiveXObject("Excel.Application");     
     oXL.Visible = true;   
     // Get a new workbook.     
     var oWB = oXL.Workbooks.Add();     
     var oSheet = oWB.ActiveSheet;     
     oSheet.Paste();     
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
</script>
<!--
<input type="button" onclick="bringToExcel()" value="导出到Excel"><br>
导入前必须进行相应设置：<br>
　1.在IE工具栏中选择"internet选项"<br>
　2.选择"安全"->选择"本地intranet"后再点击"自定义级别"<br>
  3.把所有ActiveX启用都选中后点击确认退后。<br>-->
  </form>
  <script>
  	// set color and save value ;	
		var itemNo = "" ;   // roomNo
		var isOut = 0 ;   //rent or sale out
		var lastObject ;
		var ajMoneyStr ;
        function ch(para){
		  document.cus.ajstate.value=para;
		 document.cus.action="AjListS.jsp?SecNo=<%= section%>&Loft=<%=request.getParameter("Loft")  %>&Build=<%=building %>&ajstate="+para;
          document.cus.submit();
		
		}
		function ChangeTrColor(element2, isOut2, idNo, ajMoney2, inColor, outColor) {
			isOut = parseInt(isOut2) ;
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
		
		function SetFlow() {
			
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
		
		function SearchA() {
	 
		 document.cus.action="AjListS.jsp?SecNo=<%= section%>&Loft=<%=loft %>&Build=<%=building %>";
          document.cus.submit();
			}
		
		function SeeCustomer(cusno) {
			openwin("../customter/listcusdata.jsp?cusno="+cusno,500,520,100,5);
		}
		
		function SeeSale(roomNo) {
			// alert("a" + roomNo + "b") ;
			 openwin("../sale/saleinfo1.jsp?secno=<%= section %>&secname=<%= secName %>&roomno=" + roomNo + "&build=<%= building %>&loft=<%= loft %>&show=true",600,500,100,10) ;
		}
		
		function aj1(){
		 if (confirm("确认打印吗？"))
		   openwin1("../sale/autoselect4.jsp?type=8",700,300,20,10);
		}	
  </script>
</BODY>
</HTML>
