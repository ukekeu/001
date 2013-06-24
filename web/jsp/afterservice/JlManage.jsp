<%@ page contentType="text/html;charset=GBK" %>



<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<HEAD>
<TITLE>交楼管理</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chRset=gb2312"> 
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
   <jsp:useBean id="uBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />

<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
 <%
String Cortrol=checke_qx(bBean,(String)session.getAttribute("loginid"),"S009");


 %>
<%
	String section = "";
	section = getbyte1(request.getParameter("SecNo"));
	if (section == null)
		section = "";
	String loft = "" ;
	loft = getbyte1(request.getParameter("Loft")) ;
	if (loft == null)
		loft = "" ;	
	String building = "";
	building =getbyte1( request.getParameter("Build"));
	if (building == null)
		building = "";
	String secName = "" ;
	secName = getbyte1(request.getParameter("SecName")) ;
	if (secName == null)
		secName = "" ;	
	String cusname=China.getParameter(request,"cusname");
     String secname=China.getParameter(request,"secname");
   cusname=cusname.trim();
	String search="";
		 
		if(!section.equals(""))
		   search +="and s.section = '" + section + "'";
		if(!building.equals(""))
		   search +=" and s.building = '" +building + "'" ;
		if(!loft.equals(""))
		   search +=" and s.loft ='" + loft + "'";
	 
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
<script language="javascript" src="../public_js/public.js">

</script>

<body topmargin="1"  onload="loadForm();">
<form name=cus action="JlManage.jsp">
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
<% String sel=(String)request.getParameter("sel");
 
  
   if(sel==null) sel="0"; %>
    
  <input type=hidden name="sel" value="<%=sel %>">
  <table width="180" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=0;findSub('JlManage.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>入伙管理</font></a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.cus.sel.value=1;findSub('RoomCodeShowR.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>入伙销控图</font></a>
	</td>
	 
	</tr></table>
	<script>
function findSub(para){
   document.cus.action=para;
   document.cus.submit();


}
</script>
      <p ALIGN="CENTER" class=FontColor><b><font size=3>入伙客户一览表</font></b></p>
<table width=100%><tr bgcolor="#EAEAEA"><td  align=right>

</td></tr>
</table>


  <%  
  
  String choose=getbyte1(request.getParameter("choose"));
		if (choose.equals(""))choose="0";
		String whereSQL=" and jl_notie="+choose;
		
        if (building==null)building="";
  		String sListName = "Jl2002" ;
		String floors="";
		String sConditionStr = " from Order_Contract s,customer c" + 
							" where   s.state=2 and  c.serialNo = s.customer   " + 
								"   " +search ;
							// 	" and paymentType like '%按揭%' " ;
		String SQL = "select s.code, s.jf_date,s.loft,s.building,s.room_no,s.floors, c.signatory cus_name," +
				" c.serialno cus_no, c.phone, s.jldate,s.jq_date,datediff(d,s.jf_date,s.jldate) day " + 
				",s.section,s.sectionname name " + sConditionStr+whereSQL +" order by s.loft,s.building,s.floors,s.room_no";
	 
		String sCountStr = "select count(*) counts " + sConditionStr +whereSQL;
		ResultSet Rs = aBean.executeQuery(SQL) ;
		
  %>
  <input type=hidden name=cusname>
<input type=hidden name=secname value="<%=secname %>">
<input type=hidden name=secName value="<%=secName %>">
<input type=hidden name=SecNo value="<%=section %>">
<input type=hidden name=Loft value="<%=loft %>">
<input type=hidden name=Build value="<%=building %>">
<table width="100%"><tr><td><input name="choose" type="radio" <%if (choose.equals("1"))out.print("checked"); %> value=1 onclick="document.cus.submit();">已通知&nbsp;&nbsp;<input name="choose" type="radio" <%if (choose.equals("0"))out.print("checked"); %> value=0 onclick="document.cus.submit();">未通知</td>
<td align="right"><%if (choose.equals("1")){%><input type=button name=tz value="登记交楼日期" onclick="jlinfo();"><%}else{ %><input type=button name=tz value="确认已通知" onclick="tznfo();"><%} %></td>
</tr></table>

<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=3 ALIGN=center>
  <tr class=TXTColor> 
    <TD > 
      <DIV ALIGN="CENTER">序号</DIV>
    </TD>
	 <TD > 
      <DIV ALIGN="CENTER">房号</DIV>
    </TD>
    <TD > 
      <DIV ALIGN="CENTER">客户</DIV>
    </TD>
    <TD > 
      <DIV ALIGN="CENTER">电话</DIV>
    </TD>
    <TD> 
      <DIV ALIGN="CENTER">应交楼日期</DIV>
    </TD>
	<%if (choose.equals("1")){ %>
    <TD > 
      <DIV ALIGN="CENTER">交楼日期</DIV>
    </TD>
    <TD > 
      <DIV ALIGN="CENTER">差异天数</DIV>
    </TD>
	<td> <DIV ALIGN="CENTER"> <input name="choosenote1" type="checkbox" onclick="chooseCheckbox(this.checked);"></DIV></td>

  <%}else{ %>
  <td> <DIV ALIGN="CENTER"> <input name="choosenote1" type="checkbox" onclick="chooseCheckbox(this.checked);"></DIV></td>
    <%} %>
  </TR>
  <%
   	int  ajYear = 0, ajHtId = 0  ;
	String id="";
	String section2= "";
	String name="";
	String room = "", customer = "", cusNo = "", htno = "", ajHtNo = "", ajBk = "",
			ajDate = "", ajMoneyStr = "", salePriceStr = "", isRegister = "0" ;  	
	String ajSection = "", paymentType = "", gh = "", dj = "", tz = "", lq = "" ;
	String inDate = "", yjDate = "", phone = "", notifyStr = "", enrolStr = "" ;
	int afterDay = 0, penalty = 0 ;
	float salePrice = 0, ajMoney = 0 ;		
	int notifys = 0 ;
	int enrols = 0 ;
	String ghStr = "", djStr = "", tzStr = "", lqStr = "" ;
	int iK = 0, propId = 0 ;
	int iLost2 = 0 ;
	int i=0;
	String idS="";
	while (Rs.next()) {	
		i++;
		id = Rs.getString("code");
		loft= getbyte(Rs.getString("loft"));
		building= getbyte(Rs.getString("building"));
	 	room = Rs.getString("room_no");
		floors= Rs.getString("floors");
		customer = getbyte(Rs.getString("cus_name"));
		
		cusNo = Rs.getString("cus_no") ;
		phone = Rs.getString("phone");
		yjDate = Rs.getString("jldate");
		inDate=getbyte(Rs.getString("jf_date"));
		afterDay=Rs.getInt("day");
		if (!inDate.equals(""))inDate=inDate.substring(0,10);
		try {
			yjDate = yjDate.substring(0, 10) ;
		} catch(Exception e) {
			yjDate = "" ;
		}
		 
		 
			
		iK++ ;
		iLost2 = iK % 2 ;	
		String sColor = "ffffff" ;
		//if (iLost2 == 1)
			sColor = "f6f6f6" ;		
		section2= getbyte(Rs.getString("section").trim());
		name= getbyte(Rs.getString("name").trim());
   %>
  <tr  id=TR<%=i %>  align="center" BGCOLOR="<%= sColor %>"  onclick="ChangeTrColor(this, '', '<%= id %>', '', 'A6D3A6', 'f6f6f6');"> 
    <TD height="16"> 
           <DIV ALIGN="left"><%=i %></DIV>
    </TD>
	  <TD height="16"> 
           <DIV ALIGN="left">
		   <%if (Cortrol.indexOf("A")>=0){ %> <a href="#" onclick="opennewwin('../sale/showContract.jsp','?secname=<%=name %>&secno=<%=section2 %>&roomno=<%=room%>&build=<%=building%>&loft=<%=loft %>&Floor=<%=floors %>&show=true',680,530,120,2)"><%} %><%=loft+building+room %><%if (Cortrol.indexOf("A")>=0){ %></a><%} %>
		  </DIV>
    </TD>
    <TD  height="16"> 
      <DIV ALIGN="left"><%if (Cortrol.indexOf("A")>=0){ %><a href="javascript:SeeCustomer('<%= cusNo %>')"><%} %><%= customer %><%if (Cortrol.indexOf("A")>=0){ %></a><%} %></DIV>
    </TD>
    <TD  height="16"> 
      <DIV ALIGN="left"><%= phone %></a></DIV>
    </TD>
    <TD  height="16"> 
      <DIV ALIGN="CENTER"><%= yjDate %></DIV>
    </TD>
	<%if (choose.equals("1")){ %>
    <TD  height="16"> 
      <DIV ALIGN="CENTER"><%=inDate %></DIV>
    </TD>
    <TD  height="16"> 
      <DIV ALIGN="CENTER"><%=afterDay %></DIV>
    </TD>
      <TD  height="16"> 
      <DIV ALIGN="CENTER"> <%if (inDate.equals("")){ %><input name="choosenote" value=<%=id %> type="checkbox"><%} %></DIV>
    </TD>
  <%}else{ %>
  <TD  height="16"> 
      <DIV ALIGN="CENTER"> <input name="choosenote" value=<%=id %> type="checkbox"></DIV>
    </TD>
  <%} %>
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
		
		top2 = (screen.availHeight - 300) / 2 ;
		left2 = (screen.width - 440) / 2  ;
		height2 = 280 ;
		width2 = 440 ;
		
		function Register() {
			if (itemNo == "") 
				alert("请先选择客户") ;
			else 	
				window.open("AjDoc.jsp?AjId=" + itemNo + "&x=" + Math.random(), 'PopWindowAll', "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=" + top2 + ",left=" + left2 + ",width=" + width2 + ",height=" + height2) ;
		}
		
		function Flow() {
			
			if (itemNo == "") 
				alert("请先选择客户") ;
			else 	
				window.open("AjFlow.jsp?AjMoney=" + ajMoneyStr + "&AjId=" + isOut + "&x=" + Math.random(), 'PopWindowAll', "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=" + top2 + ",left=" + left2 + ",width=" + width2 + ",height=" + height2) ;
		}
		
		function AjHtAdd(idTemp) {
			window.open("AjHtAdd.jsp?Sid=" + idTemp + "&x=" + Math.random(), 'PopWindowAll', "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=" + top2 + ",left=" + left2 + ",width=" + width2 + ",height=" + height2) ;
		}
		
		function AjHtModify(AjHtId, AjHtNo) {
			window.open("AjHtModify.jsp?AjHtId=" + AjHtId + "&AjHtNo=" + AjHtNo + "&x=" + Math.random(), 'PopWindowAll', "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=" + top2 + ",left=" + left2 + ",width=" + width2 + ",height=" + height2) ;
		}
		
		function DoFlow(idtemp, idtemp2) {
			// alert(idtemp) ;
			window.open("AjDoAdd.jsp?Id=" + idtemp + "&AjId=" + idtemp2 + "&x=" + Math.random(), 'PopWindowAll', "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=" + top2 + ",left=" + left2 + ",width=" + width2 + ",height=" + height2) ;
		}
		
		function Search() {
			window.location = "AjDoSearch.jsp?Section=<%= section %>&Building=<%= building %>&Loft=<%= loft %>&x=" + Math.random() ;
		}
		
		function SeeCustomer(cusno) {
			openwin("../customter/editcustomer.jsp?cusno="+cusno,500,520,100,5);
		}
		
		function SeeSale(roomNo) {
			// alert("a" + roomNo + "b") ;
			 openwin("../sale/saleinfo1.jsp?secno=<%= section %>&secname=<%= secName %>&roomno=" + roomNo + "&build=<%= building %>&loft=<%= loft %>&show=true",600,500,100,10) ;
		}
		
		function JlOper(jsp, saleId,cusno) {
		
			window.open(jsp + "?SaleId=" + saleId + "&cusno="+cusno+"&x=" + Math.random(), 'PopWindowAll', "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=" + top2 + ",left=" + left2 + ",width=" + width2 + ",height=" + height2) ;
		}
		function resetURL(){
             window.location = "Jl2002List.jsp?SecNo=<%= section %>&Loft=<%= loft %>&SecName=<%= secName %>";
		}
		function jlinfo(){
		if (getseldocs2()==""){alert("请选择核实的项");return false;}
		 openwin("JlRegisterAdd.jsp?code="+getseldocs2(),500,320,100,5);  
	 
		}
		function tznfo(){
		if (getseldocs2()==""){alert("请选择核实的项");return false;}
		 openwin("JlTzAdd.jsp?code="+getseldocs2(),500,320,100,5);  
		
		}
			 function getseldocs2() {
     var x=0;
	 var seldocs = new Array();
	 var temp=cus.elements.length;
     for (i=0;i<cus.elements.length;i++) {
       if ((cus.elements[i].type=="checkbox")&&(cus.elements[i].checked)&&cus.elements[i].name=='choosenote')
		 { 
		    seldocs[x]=cus.elements[i].value ;
			x++;
   		 }
	  }	

   return seldocs ;
}
		 function chooseCheckbox(para) {//indexstring
     var x=0;
	// var seldocs = new Array();
	var aa="";
	if (cus.elements.length){
	 var temp=cus.elements.length;
     for (i=0;i<cus.elements.length;i++) {
       if ((cus.elements[i].type=="checkbox")&&(cus.elements[i].name=="choosenote"))
		 {
       		cus.elements[i].checked=para;
			
   		 }
	  }	
	  }
 
}
  </script>
</BODY>
</HTML>
