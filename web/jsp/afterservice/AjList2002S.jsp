<%@ page contentType="text/html;charset=GBK" %>

<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "按揭管理" , 
                  "浏览"
                ) ;
%>
<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<HEAD>
<TITLE>按揭一览表</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chAjRset=gb2312"> 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language=javascript src="../sale/js/mad.js"> </script>
<script>
 function opennewwin(url,para,wh,hg,lf,tp) {
    var mess="是否认购登录还是查看房间资料？(如果是认购请单击‘确认’)";
	//alert(url+para)
	 var newwin=window.open(url+para,"newwin1","toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
	
  }
</script>
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

<%   String cusname=China.getParameter(request,"cusname");
     String secname=China.getParameter(request,"secname");
   cusname=cusname.trim();
	String roomStr = "", bankStr = "", flowStr = "" ;
	String slouStr = "" ;
	String sdateStr = "" ;
	String roomP = China.getParameter(request, "Room") ;
	String bankP = China.getParameter(request, "Bank") ;
	String flowP = China.getParameter(request, "Flow") ;
	String sdate = China.getParameter(request, "sdate") ;
	String slou = China.getParameter(request, "slou") ;

	//out.println(bankP);
	String isFinishP = China.getParameter(request, "IsFinish") ;
	
		
	String section = "";
	section = request.getParameter("SecNo") ;
 
	if (section == null)
		section = "";
	String loft = "" ;
	loft = request.getParameter("Loft") ;
	if (loft == null)
		loft = "" ;	
    if (!cusname.equals(""))
	   loft= China.getParameter(request, "loft") ;
	String building = "";
	
	building = request.getParameter("Build") ;
	if (building == null)
		building = "";
	String secName = "" ;
	secName = request.getParameter("SecName") ;
	if (secName == null)
		secName = "" ;	
	
	String search="";
	if(!section.equals(""))
	   search +=" and s.section = '" + section + "'";
	
	if(!loft.equals(""))
	   search +="  and s.loft ='" + loft + "'";
	if(!building.equals(""))
	   search +=" and s.building = '" +	building + "'";
	if(!cusname.equals(""))
	   search +=" and cus_name like '%" +cusname + "%'";
	
	
%><script>
	function submitv() {
		if (document.aform.Building.value == "") {
			alert("请输入栋号");
			return false;
		}	
	}
	
function loadForm() {
	}

</script>
<script language="javascript" src="../public_js/public.js">

</script>

<body onload="loadForm();">
<%

  		String ajstate=getbyte1(request.getParameter("ajstate"));
		if (ajstate.equals(""))ajstate="0";
		String checkState1="checked";
		String checkState2="";
		String checkState3="";
		if (!roomP.equals(""))
			roomStr = " and s.room_no like '%" + roomP + "%' " ;
		if (!bankP.equals(""))
			bankStr = " and s.ajBk like '%" + bankP + "%' " ;	
		 
		if (!slou.equals(""))
			slouStr = " and s.room_no like '" +  slou+ "%' " ;
		if (ajstate.equals("1")){
			sdateStr = " and s.ajhtno  <>''" ;
			checkState2="checked";
			checkState1="";
			checkState3="";
			}
	    else if (ajstate.equals("2")){
		    sdateStr = " and (s.ajhtno ='' or s.ajhtno is null)" ;
			checkState1="checked";
			checkState2="";
			checkState3="";
		} else if (ajstate.equals("3")){
			sdateStr = " and (s.aj_send_date<>'')" ;
			checkState3="checked";
			checkState2="";
			checkState1="";
			
			}
		String room1=getbyte1(request.getParameter("room"));
		String cusname1=getbyte1(request.getParameter("findcusname"));
		if (!room1.equals(""))
		  sdateStr+=" and s.room_no ='"+room1.trim()+"'";
		if (!cusname1.equals(""))
		  sdateStr+=" and c.cus_name like '%"+cusname1.trim()+"%'";  
		
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
<form name="cus" action="" method="post">
<% String sel=(String)request.getParameter("sel");
 
  
   if(sel==null) sel="0"; %>
 
  <input type=hidden name="sel" value="<%=sel %>">
  <table width="190" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=0;findSub('AjList2002S.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>按揭客户</font></a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.cus.sel.value=1;findSub('RoomCodeShowC.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>按揭情况</font></a>
	</td>
	 
	</tr></table>
	<script>
function findSub(para){
   document.cus.action=para+"?SecNo=<%= section%>&Loft=<%=loft %>&Build=<%=building %>";
   document.cus.submit();


}
function sendaj(){
		 if (confirm("确认送办吗？"))
		   openwin1("sendAJ_select.jsp?PARA_SQL=viewSaleList&url=17&reporttype=sale&tablename=",700,300,20,10);
		}	
</script>
<input type=hidden name=slou>
<input type=hidden name=sdate>
<input type=hidden name=Room>
<input type=hidden name=Flow>
<input type=hidden name=IsFinish>
<input type=hidden name=cusname>
<input type=hidden name=secname value="">
<input type=hidden name=SecName  >
<input type=hidden name=Bank>
<input type=hidden name=SecNo value="<%= section %>" >
<input type=hidden name=Build value="<%= building %>" >
<input type=hidden name=Loft value="<%= loft %>" >
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
  <TR> 
     <TD COLSPAN="2" class=FontColor>
      <DIV ALIGN="CENTER"><font size=4>按揭客户一览表</font></DIV>
    </TD>
  </TR>
  <TR> 
    <TD COLSPAN="2" height=10></TD>
  </TR>
  
  <TR >
    <TD  bgcolor="#EAEAEA">
	<input type=hidden name=ajstate>
     <input type="radio" value="0" checked name=state1 onclick="ch(this.value);" <%=checkState1 %>> 未办按揭&nbsp;<input type="radio" value="3"  <%=checkState3 %> name=state1 onclick="ch(this.value);">待办按揭 &nbsp;<input type="radio" value="1"  <%=checkState2 %> name=state1 onclick="ch(this.value);">已办按揭 </TD><td align="right">&nbsp;<input type=button name=sd value="送办按揭" onclick="sendaj();">&nbsp;房号:<input type=text size=5 name=room>&nbsp;客户姓名:<input type=text name=findcusname>&nbsp;<input type=button name=find value=" 查 找" onclick="document.cus.submit();"></td>
	
  </TR>
  <TR>
    <TD COLSPAN="2" height=10>
      
    </TD>
  </TR>
</TABLE>
  <%

		String sListName = "AjList" ;
		String floors="";
		String ajcs="";	
		session.setAttribute("S_CurrentPageCount" + sListName, "10000") ;
		String sConditionStr = " from Order_Contract s, customer c" + 
							" where c.serialNo = s.customer " + 
								
								" and s.payment like '%按揭%' " + roomStr + bankStr + flowStr + sdateStr + slouStr ;
		String sAmisStr = "select s.code saleId, s.section,s.floors,s.sectionname, s.loft, s.building, s.room_no, c.signatory cus_name," +
				"c.Phone, c.serialno cus_no, s.ContractNo htno, s.salerprice salePrice, s.ajMoney ajmoney, s.ajHtno," + 
				" s.ajyear,s.ajcs, s.MonthPayMoney,s.ajbk, s.ajdate" + sConditionStr +search;
	//out.print(sAmisStr);
 bBean.executeUpdate("update Order_Contract set out=0");
 bBean.executeUpdate("update Order_Contract set out=1 where DATEDIFF(day, AjDate, GETDATE())>0 and section = '" + section + "' and building = '" +
								building + "' and loft ='" + loft+"'" );
		String sCountStr = "select count(*) counts " + sConditionStr+search ;
%>
  <%@ include file="P_PageListHead5.jsp" %>
  
<table BORDER=0 width="130%" CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
  <tr class=TXTColor> 
      <TD WIDTH="4%"> 
      <DIV ALIGN="CENTER">序号</DIV>
      </TD> 
    <TD WIDTH="15%"> 
      <DIV ALIGN="CENTER">房号</DIV>
      </TD>
      
    <TD WIDTH="8%"> 
      <DIV ALIGN="CENTER">客户</DIV>
      </TD>
        <!--TD WIDTH="8%"> 
      <DIV ALIGN="CENTER">联系电话</DIV>
      </TD-->
    <TD WIDTH="7%"> 
      <DIV ALIGN="CENTER">按揭合同</DIV>
      </TD>
      
    <TD WIDTH="8%"> 
      <DIV ALIGN="CENTER">总价</DIV>
      </TD>
      
    <TD WIDTH="8%"> 
      <DIV ALIGN="CENTER">按揭款</DIV>
      </TD>
      
    <!--TD WIDTH="11%"> 
      <DIV ALIGN="CENTER">按揭合同</DIV>
      </TD-->
      
    <TD WIDTH="4%"> 
      <DIV ALIGN="CENTER">年限</DIV>
      </TD>
     <TD WIDTH="5%"> 
      <DIV ALIGN="CENTER">月供</DIV>
      </TD> 
    <TD WIDTH="9%"> 
      <div align="center">银行</div>
      </TD>
       <TD WIDTH="7%"> 
      <div align="center">按揭日期</div>
      </TD>
  
      
    <TD WIDTH="8%"> 
      <DIV ALIGN="CENTER">按揭登记</DIV>
      </TD>
    </TR>
    <%
   	int id = 0, ajYear = 0, ajHtId = 0 ,i=0 ;
	String room = "",sectionName2="", customer = "", cusNo = "", phone="",htno = "", ajHtNo = "", ajBk = "",
			ajDate = "", ajMoneyStr = "", salePriceStr = "", isRegister = "0", name = "" ,ajHtno="";  	
	String ajSection = "" ;
	float salePrice = 0, ajMoney = 0;		
	float monthpay=0;
	int iK = 0, sequence = 0, flowId = 0 ;
	int iLost2 = 0, saleId = 0 ;
    int id2=0;
	
	while (iSkip-- > 0 && AjRs.next()) ;  
	
	while (AjRs.next() && iPageCount-- > 0) {	
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
		 
		if (ajDate.indexOf(" ")>0)ajDate=ajDate.substring(0,ajDate.indexOf(" "));
if (ajDate.indexOf("1900")>=0)ajDate="";
		ajBk = getbyte(ajBk) ;
		 
		
   %>

    <tr align="center" alt="双击可弹出窗口登记或修改" id=R<%=i %>  ondblclick="openwin('inputAj.jsp?saleid=<%=saleId %>&monthpay=<%=monthpay %>&ajyear=<%=ajYear %>&ajcs=<%=ajcs %>&ajbk=<%=ajBk %>&ajHt=<%=ajHtno %>&ajDate=<%=ajDate %>',300,250,100,100);"  class='listcontent' onclick="changeclass1(this,'clickbg','listcontent');ChangeTrColor(this, '<%= saleId %>', '<%= saleId %>', '<%= ajMoney %>', 'A6D3A6', 'f6f6f6')"  > 
      <TD WIDTH="6%"> 
  <DIV ALIGN="CENTER"><%= i %></DIV>
      </TD>
	  <TD WIDTH="6%"> 
        <DIV ALIGN="CENTER"><a href="#" onclick="openwin1('../sale/showContract.jsp?secname=&secno=<%=ajSection %>&roomno=<%=room %>&build=<%=building %>&loft=<%=loft%>&Floor=<%=floors %>&show=true',680,530,50,2);"><%=loft+ room %></a></DIV>
      </TD>
      <TD WIDTH="10%"> 
        <DIV ALIGN="CENTER"><a href="javascript:SeeCustomer('<%= cusNo %>')"><%= customer %></a></DIV>
      </TD>
	   <!--TD WIDTH="10%"> 
        <DIV ALIGN="CENTER"><%= phone %></DIV>
      </TD-->
      <TD WIDTH="12%"> 
        <DIV ALIGN="CENTER"><a href="#" onclick="openwin1('../sale/showContract.jsp?secname=&secno=<%=ajSection %>&roomno=<%=room %>&build=<%=building %>&loft=<%=loft%>&Floor=<%=floors %>&show=true',680,530,50,2);"><%= ajHtno %></a></DIV>
      </TD>
      <TD WIDTH="10%"> 
        <DIV ALIGN="CENTER"><%= salePriceStr %></DIV>
      </TD>
      <TD WIDTH="12%"> 
        <DIV ALIGN="CENTER"><%= ajMoneyStr %></DIV>
      </TD>
      <!--TD WIDTH="11%"> 
        <DIV ALIGN="CENTER">
		
		<%
			if (ajHtNo == null) {
				
		%>
			<a href="javascript:AjHtAdd('<%= saleId %>')">签订合同</a>
		<%
			} else {
		%>	
			<a href="javascript:AjHtModify('<%= saleId %>', '<%= ajHtNo %>')"><%= ajHtNo %></a>
		<%
			}
		%>
		</DIV>
      </TD-->
      <TD WIDTH="7%"> 
        <DIV ALIGN="CENTER"><%=ajYear %></DIV>
      </TD>
	  <TD WIDTH="8%"> 
        <DIV ALIGN="CENTER"><%=monthpay %></DIV>
      </TD>
      <TD WIDTH="7%"> 
        <div align="center"><%= ajBk %></div>
      </TD>
      <TD WIDTH="9%"> 
        <DIV ALIGN="CENTER"><%= ajDate %></DIV>
      </TD>
      <TD WIDTH="16%"> 
        <DIV ALIGN="CENTER">
		<%if (Cortrol.indexOf("A")>=0){ %>
		<a href="#" onclick="openwin('inputAj.jsp?saleid=<%=saleId %>&monthpay=<%=monthpay %>&ajyear=<%=ajYear %>&ajcs=<%=ajcs %>&ajbk=<%=ajBk %>&ajHt=<%=ajHtno %>&ajDate=<%=ajDate %>',300,250,100,100);"><%} %><%if (ajHtno.equals("")){ %>登记<%}else{if (Cortrol.indexOf("A")>=0){out.print("修改");}} %></a> </DIV>
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
        function ch(para){
		  document.cus.ajstate.value=para;
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
		
		function Search() {
			openwin("AjDoSearch.jsp?Section=<%= section %>&Building=<%= building %>&Loft=<%= loft %>&x=" + Math.random(),300,250,100,100) ;
		}
		
		function SeeCustomer(cusno) {
			openwin("../customter/listcusdata.jsp?cusno="+cusno,500,520,100,5);
		}
		
		function SeeSale(roomNo) {
			// alert("a" + roomNo + "b") ;
			 openwin("../sale/saleinfo1.jsp?secno=<%= section %>&secname=<%= secName %>&roomno=" + roomNo + "&build=<%= building %>&loft=<%= loft %>&show=true",600,500,100,10) ;
		}
  </script>
</BODY>
</HTML>
