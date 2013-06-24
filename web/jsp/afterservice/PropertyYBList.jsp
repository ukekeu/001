<%@ page contentType="text/html;charset=GBK" %>

<%@ include file="../public_js/qx_checke.jsp"%>
<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<HEAD>
<TITLE>已办产权一览</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chrset=gb2312"> 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/line.css" >
<script language=javascript src="../sale/js/mad.js"> </script>
 <script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
</head>
  <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/countpagenum.jsp"%>
<%String cusname=China.getParameter(request,"cusname");
  String secname=China.getParameter(request,"secname");
  cusname=cusname.trim();
  String Room=China.getParameter(request,"Room");
	String section = "";
	section = China.getParameter(request, "SecNo");
	if (section == null)
		section = "";
	String loft = "" ;
	loft = getbyte1(request.getParameter("Loft") );
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
	String nnn=China.getParameter(request, "nn") ;
	if (!nnn.equals("")){
	    int max=Integer.parseInt(nnn) ;
	    for (int ii = 0; ii <max; ii++) {//依次更新产权数据
	       String cq_newroom = China.getParameter(request, "cq_newroom" + ii) ;
		   String cq_date = China.getParameter(request, "cq_date" + ii) ;
		   String cq_no = China.getParameter(request, "cq_no" + ii) ;
		   String order=China.getParameter(request, "ordercode" + ii) ;
	       if (!cq_date.equals("")&&!cq_no.equals("")){
		     String SQLMODI="UPDATE ORDER_CONTRACT SET cq_date='"+cq_date+"'";
		            SQLMODI+=",cq_NO='"+cq_no+"', cq_newroom='"+cq_newroom+"'";
					SQLMODI+=",cq=1 WHERE CODE="+order;
		           try{
				    bBean.executeUpdate(SQLMODI); 
					}catch(Exception s){out.print(s);}
		   }
	   }
	}
%> 
<script language="javascript" src="../public_js/public.js">

</script>

<body  topmargin="1" oncontextmenu="return false"  >
  
<% String sel=(String)request.getParameter("sel");
    sel="2"; %>
   <form name=cus action="PropertyYBList.jsp">
   
     <input type=hidden name="cusname">
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

function cqm(){
		 if (confirm("确认打印吗？"))
		   openwin1("auto_select.jsp?PARA_SQL=viewSaleList&url=18&reporttype=sale&tablename=",700,300,20,10);
		}	
</script>
  <p ALIGN="CENTER" class=FontColor><b><font size=3><%=secname+ loft%>已办理产权一览表</font></b></p>
 
 

  <table width=100%><tr bgcolor="#EAEAEA"><td  align=right><input type=button name=sdd value="产权进度表" onclick="openwin1('cq_process_view.jsp?SecNo=<%=section %>&Loft=<%=loft %>');"> <input type=button name=pp value="打印产权证明细表" onclick="cqm();">
   <input type=button name=app value="送件表" onclick="openwin('autoselect7.jsp?type=9');"><input name="sh" type="checkbox" value="1" <%=shs %> onclick="document.cus.sel.value=2;findSub('PropertyYBList.jsp');">只显示已登记产权的数据&nbsp;&nbsp;
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
		String SQL1 = " from Order_Contract s, CRM_Project s2, customer c " + 
							" where s.section = s2.serialNo and c.serialNo = s.customer    " + 
								"  " +
								" and    s.state =2 and s.cq=1 and not s.song_jian_date is null and cq_lingquDate is null" ;
			if (sh.equals("")) SQL1+="  and   s.cq_no  is  null   ";//已登记产权
			else  SQL1+="  and  not  s.cq_no  is  null 	";//未登记产权　		
		 	 
		String SQL = "select Top "+pageSize+"  s.custype,s.contractno htno,s.song_jian_date,s.code,s.loft,s.building,s.room_no, c.signatory cus_name," ;
				SQL += " c.phone,c.serialno cus_no, s.contractno htno,s.floors , s.payment1 " ;
				SQL +=",  s.section,s2.name ,s.cq_date,s.cq_check,s.cq_no,s.cq_newroom ,s.sb_cq_date" + SQL1+roomStr + search +" and s.code  not in  (select top "+prenum +" s.code  "+  SQL1+roomStr + search +" order by s.section+s.loft+s.room_no)";
		 sqlcount="select count(*) as num "+SQL1+roomStr + search;
 
	 ResultSet rs = aBean.executeQuery(SQL+" order by s.section+s.loft+s.room_no ") ;
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
	<!--  <TD > 
      <DIV ALIGN="CENTER">电话</DIV>
    </TD>-->
    <TD > 
      <DIV ALIGN="CENTER">合同号</DIV>
    </TD>
    <TD> 
      <DIV ALIGN="CENTER">付款方式</DIV>
    </TD>
	 <TD> 
      <DIV ALIGN="CENTER">申办日期</DIV>
    </TD>
	 <TD> 
      <DIV ALIGN="CENTER">送件日期</DIV>
    </TD>
     <TD> 
      <DIV ALIGN="CENTER">产权新编号</DIV>
    </TD>
	  <TD> 
      <DIV ALIGN="CENTER">产权证号</DIV>
    </TD>
	  <TD> 
      <DIV ALIGN="CENTER">出证日期</DIV>
    </TD>
	 <TD> 
      <DIV ALIGN="CENTER">取消送件</DIV>
    </TD>
  </TR>
  <%
    int nn=0;
   	int id = 0, ajYear = 0, ajHtId = 0  ;
	String section2= "";
	String name="",custype="";
	String song_jian_date="";
	String room = "", customer = "",phone="", cusNo = "", htno = "", ajHtNo = "", ajBk = "",
			ajDate = "", ajMoneyStr = "", salePriceStr = "", isRegister = "0" ;  	
	String ajSection = "", paymentType = "", gh = "", dj = "", tz = "", lq = "" ;
	float salePrice = 0, ajMoney = 0 ;		
	String floors="" ,cq_date="",cq_no="",cq_newroom="",cq_sb_date="";
	int iK = 0, propId = 0 ;
	int iLost2 = 0 ;
	  boolean cq_check=false;
	while (rs.next()) {	
	    custype=getbyte(rs.getString("custype").trim());
	    htno =getbyte(rs.getString("htno").trim());
		song_jian_date=rs.getDate("song_jian_date").toString(); 
		id = rs.getInt("code");
		loft= getbyte(rs.getString("loft"));
		building= getbyte(rs.getString("building").trim());
	 	room = rs.getString("room_no").trim();
		customer = getbyte(rs.getString("cus_name"));
		phone= getbyte(rs.getString("phone"));
		cusNo = rs.getString("cus_no") ;
		htno = rs.getString("htno");
		floors= rs.getString("floors");
		paymentType = getbyte(rs.getString("payment1")) ;
	    cq_date= getbyte(rs.getString("cq_date")) ;
		if (!cq_date.equals(""))cq_date=cq_date.substring(0,10);
		cq_no= getbyte(rs.getString("cq_no")) ;
		cq_newroom= getbyte(rs.getString("cq_newroom")) ;
		cq_sb_date= getbyte(rs.getString("sb_cq_date"));
		if (!cq_sb_date.equals(""))cq_sb_date=cq_sb_date.substring(0,10);
		
		iK++ ;
		iLost2 = iK % 2 ;	
		String sColor = "ffffff" ;
		if (iLost2 == 1)
			sColor = "f6f6f6" ;		
		section2= getbyte(rs.getString("section").trim());
		name= getbyte(rs.getString("name").trim()); 
		cq_check=rs.getBoolean("cq_check");
   %>
  <tr align="center" BGCOLOR="<%= sColor %>"       > 
    <TD  height="16"> 
      <DIV ALIGN="left"><%=iK %></DIV>
    </TD>
    <TD  height="16"> 
      <DIV ALIGN="left"><a href="#" onclick="openwin('../sale/showContract.jsp?secno=<%=section2 %>&roomno=<%=room %>&build=&loft=<%=loft %>&Floor=<%=floors %>')"><%=loft+room %></DIV>
    </TD> 
    <TD  height="16"> 
      <DIV ALIGN="left"><a href="#" onclick="SeeCustomer('<%= cusNo %>')"><%= customer %></a></DIV>
    </TD>
	<!--
	 <TD  height="16"> 
      <DIV ALIGN="left"><%=phone %></DIV>
    </TD>-->
    <TD  height="16"> 
      <DIV ALIGN="left"> <%= htno %> </DIV>
    </TD>
    <TD height="16"> 
      <DIV ALIGN="left"><%= paymentType %></DIV>
    </TD>
	<TD height="16"> 
      <DIV ALIGN="left"><%= cq_sb_date %></DIV>
    </TD>
    <TD height="16"> 
      <DIV ALIGN="left"><%= song_jian_date %></DIV>
    </TD>
	
    <%if (cq_date.equals("")){%>
	  <TD  height="16"> 
      <DIV ALIGN="left"><input type=text name=cq_newroom<%=nn %> class="unnamed1"  size=10   onkeydown=" key(document.cus.cq_no<%=nn %>);"></DIV>
    </TD>
    <TD  height="16"> 
      <DIV ALIGN="left"><input type=text name=cq_no<%=nn %>  class=unnamed1 size=10   onkeydown="key(document.cus.cq_date<%=nn %>);"></DIV>
    </TD>
    <TD height="16"> 
      <DIV ALIGN="left"><input type=text name=cq_date<%=nn %>   readonly class=unnamed1 size=10 onkeydown="key(document.cus.cq_newroom<%=nn+1 %>);" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(cq_date<%=nn %>);return false;"></DIV>
    </TD> 
	<TD height="16"> 
      <DIV ALIGN="left"><a href="#" onclick=" if (confirm('确认吗？'))openwin('Cancelsj.jsp?code=<%=id %>',10,10,10,10);">取消</a></DIV>
	</td>
   <%}else{ %>
    <TD  height="16"> 
      <DIV ALIGN="left"><%=cq_newroom %></DIV>
    </TD>
    <TD  height="16"> 
      <DIV ALIGN="left"> <%= cq_no %> </DIV>
    </TD>
    <TD height="16"> 
      <DIV ALIGN="left"><%= cq_date %></DIV>
	</td>  
	   
	
	 <TD height="16"> 
	 <%if (cq_check){ %>
      <DIV ALIGN="left"><a href="#" onclick="openwin('PropertyLqAdd.jsp?code=<%=id %>&cq_date=<%=cq_date %>',580,400,50,50);">领取产权</a></DIV>
	  <%}else{out.print("财务未核对");} %>
	</td>
	  <%} %>
	  <TD  height="16"> 
      <DIV ALIGN="center"> <a href="#" onclick="openwin1('PropertyPerson.jsp?code=<%=id %>&htno=<%=htno %>');">共有人</a> </DIV>
    </TD>
	   <TD  height="16"> 
      <DIV ALIGN="center"> <a href="#" onclick="openwin1('PropertyBakAdd.jsp?code=<%=id %>&section=<%=section %>&chho=1&htno=<%=htno %>&Loft=<%=loft %>&room=<%=room %>',600,280,100,100);">备注</a> </DIV>
    </TD>
     <TD  height="16"> 
      <DIV ALIGN="center"> <a href="#" onclick="openwin1('../sale/<%if (custype.equals("个人"))out.print("cqdj.jsp");else out.print("dwcqdj.jsp"); %>?code=<%=id %>&chho=1&htno=<%=id %>&SecNo=<%=section2 %>&Loft=<%=loft %>&room=<%=room %>');">打印</a> </DIV>
    </TD>
  </TR>
  <input type=hidden name=ordercode<%=nn %> value="<%=id %>">
  <%nn++;
  	} 
  %>
</TABLE>
<input type=button name=modis value="更新登记"  onclick="modi();" >
<input type=hidden name=nn value="<%=nn %>">
<input type=hidden name=Room value="">
<input type=hidden name=Type>
<input type=hidden name=status>
 
<input type=hidden name=secname value="<%=secname %>">
<input type=hidden name=secName value="<%=secname %>">
<input type=hidden name=SecNo value="<%=section %>">
<input type=hidden name=Loft value="<%=getbyte1(request.getParameter("Loft") ) %>">
<input type=hidden name=Build value="<%=building %>">
   <%@ include file="../public_js/changepage3.jsp"%>
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
		function modi(){
		   if (confirm("确认登记的数据吗？"))
		  　document.cus.submit();
	     	
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
 		function Search() {
			openwin("PropertySearch.jsp?Section=<%= section %>&Building=<%= building %>&Loft=<%= loft %>&secname=<%= secname %>&x=" + Math.random(),300,250,100,100) ;
		}
	 
		 
function SeeCustomer(para) {
	
    var spa = 400 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa/3 ;
    var lef = spa / 2 ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=400"  ;
    var posi = posi + ",width=550";
    var newwin1=window.open("../customter/editcustomer.jsp?edit=editcus&cusno="+para,"NewsW1","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
 
}

function findSub(para){
   document.cus.action=para;
   document.cus.submit();
}
  </script>
</BODY>
</HTML>
