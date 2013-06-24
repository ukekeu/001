<%@ page contentType="text/html;charset=GBK" %>

 
<TITLE>按揭合同注记一览</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chrset=gb2312"> 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<script language=javascript src="../sale/js/mad.js"> </script>
 
</head>
  <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
   
<%@ include file="../public_js/getByteOut.jsp"%>


<%String cusname=China.getParameter(request,"cusname");
     String secname=China.getParameter(request,"secname");
   cusname=cusname.trim();
  String Room=China.getParameter(request,"Room");
	String section = "";
	section = China.getParameter(request, "SecNo");
	if (section == null)
		section = "";
	String loft = "" ;
	loft = China.getParameter(request, "Loft") ;
	if (loft == null)
		loft = "" ;	
	String building = "";
	building =China.getParameter(request, "Build");
	if (building == null)
		building = "";
	String secName = "" ;
	secName = China.getParameter(request, "SecName") ;
	if (secName == null)
		secName = "" ;	
	String sh=China.getParameter(request, "sh") ;
	String shs="";
	if (sh.equals("1"))shs="checked";

	 
%> 
<script language="javascript" src="../public_js/public.js">

</script>

<body   topmargin="1"  oncontextmenu="return false"   >
  
<% String sel=(String)request.getParameter("sel");
   if(sel==null) sel="0"; %>
   <form name=cus action="PropertyZJList.jsp">
  <input type=hidden name="sel" value="<%=sel %>">
  <table width="620" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=0;findSub('PropertyWBList.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>待办产权</font></a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.cus.sel.value=1;findSub('RoomCodeShowQ.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>产权销控图</font></a>
	</td>
	  <td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=2;findSub('PropertyYBList.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>已送办产权</font></a>
	</td>
	 <td class="<%if(sel.equals("6")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=6;findSub('PropertyZJList.jsp');"><font color='<%if(sel.equals("6")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>合同注记</font></a>
	</td>
	 <td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=3;findSub('PropertyAList.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>已领产权</font></a>
	</td>
	 <td class="<%if(sel.equals("5")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=5;findSub('PropertyWCList.jsp');"><font color='<%if(sel.equals("5")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>未审批合同</font></a>
	</td>
	 <td class="<%if(sel.equals("4")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=4;findSub('PropertyRpt.jsp');"><font color='<%if(sel.equals("4")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>报表管理</font></a>
	</td>
	</tr></table>
	<script>
function findSub(para){
   document.cus.action=para;
   document.cus.submit();


}
</script>
  <p ALIGN="CENTER" class=FontColor><b><font size=3><%=secname+ loft%>注记一览表</font></b></p>
  <table width=100%><tr bgcolor="#EAEAEA"><td  align=right><input name="sh" type="checkbox" value="1" <%=shs %> onclick="document.cus.sel.value=6;findSub('PropertyZJList.jsp');">只显示已注记&nbsp;&nbsp;
 <input type=button name=zj value="银行注记" onclick="checkzj();"> &nbsp; <input type=button name=zj value="打印银行注记" onclick="openwin1('autoselect7.jsp?type=8',300,250,100,100);"> 
</td></tr>
</table>
  <%
  		String sListName = "Property2002" ;
		String roomP = China.getParameter(request, "Room") ;
 	String typeStatus = "",roomStr = "" ;
		String type = China.getParameter(request, "Type") ;
		String status = China.getParameter(request, "Status") ;
		String listDisp = "" ;
		String search="";
		
		if(!Room.equals(""))
	       search +=" and room_no like '%" +Room + "%'";
		if(!cusname.equals(""))
	       search +=" and cus_name like '%" +cusname + "%'";
 		if(!section.equals(""))
		   search +="and s.section = '" + section + "'";
		if(!building.equals(""))
		   search +=" and s.building = '" +building + "'" ;
		if(!loft.equals(""))
		   search +=" and s.loft ='" + loft + "'";
		String wheresql="";
	
		if (building==null)building="";
		if (!type.equals("") && !status.equals("")) 
			if (status.equals("0"))
				typeStatus = " and " +wheresql;
			else 	
				typeStatus = " and " + type + " = '" + status + "' " ;
		if (!roomP.equals(""))
			roomStr = " and s.room_no like '%" + roomP + "%' " ;		
		String SQL1 = " from Order_Contract s, customer c " + 
							" where s.payment1 like '%按揭%' and c.serialNo = s.customer    " + 
								"  " +
								" and    s.state =2 and s.cq=1 " ;
		if (!sh.equals("")) SQL1+="  and   s.yhzj =1 ";//已登记产权
			else  SQL1+="  and  s.yhzj =0 	and not s.song_jian_date is null ";//未登记产权　							 
		String SQL = "select  s.yhzj_date,s.code,s.loft,s.building,s.room_no, c.signatory cus_name," +
				" c.phone,c.serialno cus_no, s.contractno htno,s.floors , s.payment1 " + 
				",  s.section,s.sectionname name,s.ajyear,s.ajmoney,s.ajdate,s.yhzj,s.yhzj_date  " + SQL1+roomStr + search;
	 
	 ResultSet rs = aBean.executeQuery(SQL) ;
  %>
<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1>
   <tr align="center"  class=txtcolor> 
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
    <TD > 
      <DIV ALIGN="CENTER">合同号</DIV>
    </TD>
    <TD> 
      <DIV ALIGN="CENTER">按揭年限</DIV>
    </TD>
   <TD> 
      <DIV ALIGN="CENTER">按揭金额</DIV>
    </TD>
	 <TD> 
      <DIV ALIGN="CENTER">按揭日期</DIV>
    </TD>
	 <TD> 
      <DIV ALIGN="CENTER">注记日期</DIV>
    </TD>
  </TR>
  <%
   	int id = 0, ajYear = 0, ajHtId = 0  ;
	String section2= "";
	String name="",yhzj_date="";
	String room = "", customer = "",phone="", cusNo = "", htno = "", ajHtNo = "", ajBk = "",
			ajDate = "", ajMoneyStr = "", salePriceStr = "", isRegister = "0" ;  	
	String ajSection = "", paymentType = "", gh = "", dj = "", tz = "", lq = "" ;
	float salePrice = 0, ajMoney = 0 ;		
	String floors="", ajdate="",ajyear="",ajmoney="";
	int iK = 0, propId = 0 ;
	int iLost2 = 0 ;
	int yhzj=0;  
	String zjdate="";
	 
	while (rs.next()) {	
		 yhzj_date = getbyte(rs.getString("yhzj_date"));
		
		 if (!yhzj_date.equals(""))yhzj_date=yhzj_date.substring(0,10);
		id = rs.getInt("code");
		String loft1= getbyte(rs.getString("loft"));
		building= getbyte(rs.getString("building").trim());
	 	room = rs.getString("room_no").trim();
		customer = getbyte(rs.getString("cus_name"));
		phone= getbyte(rs.getString("phone"));
		cusNo = rs.getString("cus_no") ;
		htno = rs.getString("htno");
		floors= rs.getString("floors");
		paymentType = getbyte(rs.getString("payment1")) ;
	    ajyear = getbyte(rs.getString("ajyear")) ;
		ajmoney = getbyte(rs.getString("ajmoney")) ;
		ajdate = getbyte(rs.getString("ajdate")) ;
		if (!ajdate.equals(""))ajdate=ajdate.substring(0,10);
		iK++ ;
		iLost2 = iK % 2 ;	
		String sColor = "ffffff" ;
		if (iLost2 == 1)
			sColor = "f6f6f6" ;		
		section2= getbyte(rs.getString("section").trim());
		name= getbyte(rs.getString("name").trim());
		 yhzj=rs.getInt("yhzj");
		 zjdate= getbyte(rs.getString("yhzj_date"));
		if (!zjdate.equals(""))zjdate=zjdate.substring(0,10);
   %>
  <tr align="center" BGCOLOR="<%= sColor %>"  onclick="ChangeTrColor(this, '', '<%= id %>', '', 'A6D3A6', 'f6f6f6')"  > 
    <TD  height="16"> 
      <DIV ALIGN="left"><%=iK %>
	  <%if (yhzj==0){ %><input name="aa" value="<%=id %>" type="checkbox"><%} %>
	  </DIV>
    </TD>
    <TD  height="16"> 
      <DIV ALIGN="left"><a href="#" onclick="openwin1('../sale/showContract.jsp?secno=<%=section2 %>&roomno=<%=room %>&build=&loft=<%=loft1 %>&Floor=<%=floors %>')"><%=loft1+building+room %></DIV>
    </TD> 
    <TD  height="16"> 
      <DIV ALIGN="left"><a href="javascript:SeeCustomer('<%= cusNo %>')"><%= customer %></a></DIV>
    </TD>
	 <TD  height="16"> 
      <DIV ALIGN="left"><%=phone %></DIV>
    </TD>
    <TD  height="16"> 
      <DIV ALIGN="left"> <%= htno %> </DIV>
    </TD>
    <TD height="16"> 
      <DIV ALIGN="left"><%= ajyear %></DIV>
    </TD>
     <TD height="16"> 
      <DIV ALIGN="left"><%= ajmoney %></DIV>
    </TD>
	 <TD height="16"> 
      <DIV ALIGN="left"><%= ajdate %></DIV>
    </TD>
	 <TD height="16"> 
      <DIV ALIGN="left"><%= yhzj_date %></DIV>
    </TD>
  </TR>
  <%
  	}
  %>
</TABLE>
<input type=hidden name=Room value="">
<input type=hidden name=Type>
<input type=hidden name=status>
<input type=hidden name=cusname>
<input type=hidden name=secname value="<%=secname %>">
<input type=hidden name=secName value="<%=secname %>">
<input type=hidden name=SecNo value="<%=section %>">
<input type=hidden name=Loft value="<%=loft %>">
<input type=hidden name=Build value="<%=building %>">
</form>
  <script>
  	 	var itemNo = "" ;   // roomNo
		var isOut = 0 ;   //rent or sale out
		var lastObject ;
		var ajMoneyStr ;
		function songjian(){
		 if (confirm("确认打印送件表吗？如果确认打印，系统将把打印日期作为送件日期处理"))
		   openwin1("../sale/auto_select.jsp?PARA_SQL=viewSaleList&url=17&reporttype=sale&tablename=",700,300,20,10);
		}
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
 	 function checkzj(){
	 
	 
	 if (getseldocs2()==""){alert("请选择可以注记的资料");return false;}
	 
	 
	 
	   if (confirm("确认通过吗？"))
	   openwin1("updateCheckState.jsp?codes="+getseldocs2(),10,10,10,10);
	 
	 } 
	function getseldocs2() {
     var x=0;
	 var seldocs = new Array();
	 var temp=cus.elements.length;
     for (i=0;i<cus.elements.length;i++) {
       if ((cus.elements[i].type=="checkbox")&&(cus.elements[i].checked))
		 { 
		    seldocs[x]=cus.elements[i].value ;
			x++;
   		 }
	  }	

   return seldocs ;
} 
  </script>
</BODY>
</HTML>
