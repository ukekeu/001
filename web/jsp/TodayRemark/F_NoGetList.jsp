<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/yonghuhuodong.jsp" %>
<%
setYongHuHuoDong( setYongHuHuoDongBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "催款明细" , 
                  "浏览"
                ) ;
%>

<HTML>
<HEAD>
<TITLE>Untitled Document</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chamisRset=gb2312"> 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language=javascript src="../sale/js/mad.js"> </script>
<script language="javascript" src="../public_js/public.js"></script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
</head>
  <%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
   <jsp:useBean id="setpro" scope="session" class="setProperty.setProperty"/>   
   <jsp:useBean id="fa" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%
	/*
      	String 	id2 = setpro.getId();
      	boolean service = setpro.getService();
      	if (id2 == null || id2.equals("")) {
      		out.print("请重新登录");
      		return ;
      	}
      	if (!service) {
      		out.print("你没有权限");
      		return ;
      	}
	*/	
  %>

<%  
String cbdate="";
String cedate="";
cedate = getbyte( request.getParameter("cedate" ) ) ;
cbdate = getbyte( request.getParameter("cbdate" ) ) ;

    float demurrage=0;
    String RoomS=China.getParameter(request,"Room");
	String section = "";
	section = request.getParameter("SecNo");
	if (section == null)
		section = "";
	String loft = "" ;
	loft = request.getParameter("Loft") ;
	
	if (loft == null)
		loft = "" ;	
	String building = "";
	building = request.getParameter("Build");
	if (building == null)
		building = "";
	String secName = "" ;
	secName = request.getParameter("SecName") ;
	if (secName == null)
		secName = "" ;	
	
	/*if (!section.equals(""))
		session.setAttribute("Aj-Section", section) ;
	if (!loft.equals(""))
		session.setAttribute("Aj-Loft", loft) ;
	if (!building.equals(""))
		session.setAttribute("Aj-Building", building) ;
	if (!secName.equals(""))
		session.setAttribute("Aj-SectionName", secName) ;	
	*///section = (String) session.getAttribute("Aj-Section") ;
	//building = (String) session.getAttribute("Aj-Building") ;
	//loft = (String) session.getAttribute("Aj-Loft") ;		
	//secName = (String) session.getAttribute("Aj-SectionName") ;		

	/*	
	String room = "";
	String customer = "";
	String htno = "";
	String ajBk = "";
	float salePrice ;
	int ajCs = 0;
	float ajMoney = 0;
	int ajYear = 0;
	*/
%><script>
	function submitv() {
		if (document.aform.Building.value == "") {
			alert("请输入栋号");
			return false;
		}	
	}
	
function loadForm() {
	
	
		// setSelectMad(document.aform.Section,'<%=section%>');
		// document.aform.Building.value ='<%=building%>';
	}

</script>


<body onload="document.cus.Room.focus();document.cus.Room.select();">
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
<%String reportAddrs=(String)session.getAttribute("reportAddr"); %>
<p ALIGN="CENTER" class=FontColor><font size=3><b>今日交款客户明细表</b></font></p>
<form name=cus action="">
   <p align="left">
显示 
		<select name="Display" onchange="AlertDate();">
			<OPTION VALUE="d0">今日</OPTION>
			<OPTION VALUE="d1">提前1天提醒</OPTION>
			<OPTION VALUE="d2">提前2天提醒</OPTION>
			<OPTION VALUE="d3">提前3天提醒</OPTION>
			<OPTION VALUE="d4">提前4天提醒</OPTION>
			<OPTION VALUE="d5">提前5天提醒</OPTION>
			<OPTION VALUE="d6">提前6天提醒</OPTION>
		</select>&nbsp;<input type=button name=Prin value="打印" onclick="window.open('<%=reportAddrs %>ArrearMxRep.rpt');">
		
  <% 
    String StrWhere = "" ;
   if (DisplayS.equals(""))DisplayS="d0";
   DisplayS=DisplayS.substring(1);
   if (DisplayS.equals("0")) {
  StrWhere =" and convert(char(24),shouldDate,111) = convert(char(24),getdate(),111)";
   }else{
  StrWhere= " and convert(char(24),dateadd(dd,-"+DisplayS+",shouldDate),111)<convert(char(24),getdate(),111) ";
   }
   
  String order_code="";
  if (building==null)building="";
  if (!RoomS.equals(""))RoomS=" and s.room_no='"+RoomS+"'";
  		String sListName = "F_NoGetList" ;
		String sConditionStr = " from  Order_Contract s, section s2, customer c, gatheringRecord g  " + 
							" where s.section = s2.serialNo and c.serialNo = s.customer and " + 
								" g.cusNo = s.customer and s.section = '" + section + "'";
								if (!building.equals(""))
								sConditionStr+=" and s.building = '"+building+"'" ;
								if (!loft.equals(""))
								sConditionStr+=" and s.loft ='" + loft + "'";
								sConditionStr+=" and g.state!= 2 and convert(char(24),g.shouldDate,111)<convert(char(24),getdate(),111)" ;
			
		String sAmisStr = "select s.loft, s.building,s.room_no, c.signatory cus_name, c.serialNo, c.phone,c.sj, " +
				"g.contactno,g.shouldQs, g.shouldDate, g.shouldMoney*g.rate -g.yijiao*g.rate AS qk_dMoney,g.yijiao*g.rate as yijiao ,s.demurrage " + 
				" " + sConditionStr+RoomS +" order by s.sectionname,s.loft,s.floors,s.room_no,g.shouldDate ";
   	    
     String upateSQL="update View_ArrearMXList set out=1 where section = '" + section + "' " ;
     if (!loft.equals("")) upateSQL+=" and loft ='" + loft +	"'";
		 int a= aBean.executeUpdate("update View_ArrearMXList set out=0");
	     int b=aBean.executeUpdate(upateSQL);				
		 
		out.print(sAmisStr) ;
		 out.close() ;
		String sCountStr = "select count(*) counts " + sConditionStr ;
  %>
  <%@ include file="../sale/S_PageListHead5.jsp" %>
<table bgcolor="#EAEAEA" width="100%">
 <tr>
  <td>
房号:  <input type=text size=10 name=Room >&nbsp;
应收日期: 从<input type=input name=cbdate size=10 readonly value="<%=cbdate %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(cbdate);return false;">到<input type=input name=cedate size=10 readonly value="<%=cedate %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(cedate);return false;"><input type=submit name=find value="查询">
  </td>
 </tr>
</table>

<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >
  <tr class=TXTColor> 
    <TD > 
      <DIV ALIGN="CENTER"> 
        序号
      </DIV>
    </TD>
	<TD  > 
      <DIV ALIGN="CENTER">房号</DIV>
    </TD>
    <TD > 
      <DIV ALIGN="CENTER">客户姓名</DIV>
    </TD>
    <TD  > 
      <DIV ALIGN="CENTER">联系电话</DIV>
    </TD>
    <TD  > 
      <DIV ALIGN="CENTER">期数</DIV>
    </TD>
    <TD > 
      <DIV ALIGN="CENTER">应收日期</DIV>
    </TD>
   
    <TD > 
      <div align="center">实收金额</div>
    </TD>
    <TD > 
      <DIV ALIGN="CENTER">欠款</DIV>
    </TD>
	 <TD > 
      <DIV ALIGN="CENTER">滞纳金</DIV>
    </TD>
  </tr>
  <%
   	int id = 0, ajYear = 0, ajHtId = 0  ;
	String room = "", customer = "", cusNo = "", htno = "", ajHtNo = "", ajBk = "",
			paymentType = "", contractNo = "", jzAreaStr = "", phone = "",
			ajDate = "", ajMoneyStr = "", salePriceStr = "", isRegister = "0",
			shouldMoneyStr = "", factMoneyStr = "", noMoneyStr = "" ;  	
	String ajSection = "", qs = "", shouldDate ;
	float salePrice = 0, ajMoney = 0, jzArea = 0, shouldMoney = 0 ;		
	int iK = 0, jj = 0 ;
	int iLost2 = 0 ;
	String sj="";
	double qk_dMoney=0;
	while (iSkip-- > 0 && amisRs.next()) ;  
	while (amisRs.next() && iPageCount-- > 0) {	
		loft=getbyte(amisRs.getString("loft")) ;
		building=getbyte(amisRs.getString("building")) ;
		room = amisRs.getString("room_no") ;
		customer = getbyte(amisRs.getString("cus_name"));
		cusNo = amisRs.getString("serialNo") ;
		phone = getbyte(amisRs.getString("phone"));
		sj= getbyte(amisRs.getString("sj"));
		if (phone.equals(""))phone=sj;
                order_code= amisRs.getString("contactno") ;
		qs = amisRs.getString("shouldqs") ;
		shouldDate = amisRs.getString("shouldDate").substring(2, 10) ;
		qk_dMoney = amisRs.getDouble("qk_dMoney") ;
		double yijiao= amisRs.getDouble("yijiao") ;
		demurrage= amisRs.getFloat("demurrage") ;
		/*		
		String selectStr2 = "select gather_date, factMoney,cusno,contractno from factGatheringRecord " + 
		 		" where cusNo = '" + cusNo + "' and period = '" + qs + "'" ;
		ResultSet rs2 = bBean.executeQuery(selectStr2) ;
		String gatherDate = "" ;
		float factMoney = 0 ;
		while (rs2.next()) {
			gatherDate = rs2.getString("gather_date").substring(2, 10) ;
			factMoney += rs2.getFloat("factMoney") ;
		}	
		// out.print(factMoney + ":" + shouldMoney + "<br>") ;
		
		if (factMoney >= shouldMoney) 	
			continue ;
		float noMoney = shouldMoney - factMoney ;	
		shouldMoneyStr = getFloat(shouldMoney, 1) ;
		factMoneyStr = getFloat(factMoney, 1) ;
		noMoneyStr = getFloat(noMoney, 1) ;
		*/
		jj++ ;
		
		iK++ ;
		iLost2 = iK % 2 ;	
		String sColor = "ffffff" ;
		if (iLost2 == 1)
			sColor = "f6f6f6" ;		
   %>
  <tr align="center" id=R<%=jj %> onmouseover="mout(this);"  class=listcontent BGCOLOR="<%= sColor %>" ondblclick="yingshi('<%= order_code%>','<%= cusNo %>');" onclick="changeclass1(this,'clickbg','listcontent');"> 
    <TD > 
      <DIV ALIGN="CENTER"> 
        <%= jj %>
      </DIV>
    </TD>
	   <TD> 
      <DIV ALIGN="CENTER"><%=loft+room %></DIV>
    </TD>
    <TD> 
      <DIV ALIGN="CENTER"><%= customer %></DIV>
    </TD>
    <TD> 
      <DIV ALIGN="CENTER"><%= phone %>&nbsp</DIV>
    </TD>
    <TD> 
      <DIV ALIGN="CENTER"><%if (qs.equals("0"))out.println("定金");else out.println("楼款"); %></DIV><%//Integer.parseInt(qs)+1 %>
    </TD>
 
   
    <TD > 
      <DIV ALIGN="CENTER"><%= shouldDate %></DIV>
    </TD>

   
    <TD > 
      <div align="center"><%= fa.getFloat2(yijiao,2) %></div>
    </TD>
    <TD> 
      <DIV ALIGN="CENTER"><%= fa.getFloat2(qk_dMoney,2) %></DIV>
    </TD>
	 <TD > 
      <DIV ALIGN="CENTER"><%= demurrage%></DIV>
    </TD>
  </TR>
  <%
   	}
		
   %>
</TABLE>
  <table width=100%>
  	<tr>
		<td height=10 colspan=3></td>
	</tr>
	<tr>
		<td width=40%>编制日期:  <%= new Timestamp(System.currentTimeMillis()).toString().substring(2, 10) %></td>
		<td width=30%>审核人</td>
		<td width=30%>制表人</td>
	</tr>
  </table>
<script>
 function yingshi( contractno , cusno ) {
    openwin("yingshi.jsp?contractno=" + contractno + "&cusno=" + cusno ,560,450,50,50);
  }    
</script>
  </form>
  </BODY>
</HTML>
