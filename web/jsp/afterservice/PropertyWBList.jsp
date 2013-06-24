<%@ page contentType="text/html;charset=GBK" %>

 
<TITLE>未办产权一览</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chrset=gb2312"> 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<script language=javascript src="../sale/js/mad.js"> </script>
 
</head>
  <%@ page import="java.sql.*, common.*,java.util.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
    <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase" />
 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/countpagenum.jsp"%>

<%String cusname=China.getParameter(request,"cusname");
  String secname=China.getParameter(request,"secname");
  String Room=China.getParameter(request,"Room");
   cusname=cusname;
 
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
	 String sdateStr="";
	 String checkState1="checked";
	 String checkState2="";
	 String ajstate= China.getParameter(request, "state1") ;
	 if (ajstate.equals("1")){
			sdateStr = " and  s.CQ=1 " ;
			checkState2="checked";
			checkState1="";
		 
		}   else if (ajstate.equals("0")){
		    sdateStr = " and  s.CQ=0 " ;
			checkState1="checked";
			checkState2="";
		 
		}
%> 
<script language="javascript" src="../public_js/public.js">

</script>

<body  topmargin="1" oncontextmenu="return false"  >
  
<% String sel=(String)request.getParameter("sel");
   sel="0"; %>
   <form name=cus action="PropertyWBList.jsp">
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
  <p ALIGN="CENTER" class=FontColor><b><font size=3><%=secname+ loft%>未办理产权一览表</font></b></p>
  <table width=100% cellpadding="0" cellspacing="0"><tr ><td  align=right>
 <input type="radio" value="0"   name=state1 onclick="ch(this.value);" <%=checkState1 %>> 待申办&nbsp;<input type="radio" value="1"  <%=checkState2 %> name=state1 onclick="ch(this.value);">已申办&nbsp;</td> <td  align=right><input type=button name=sdd value="产权进度表" onclick="openwin1('cq_process_view.jsp?SecNo=<%=section %>&Loft=<%=loft %>');"><%if (ajstate.equals("0")){ %> <input type=button name=prs value="申办产权" onclick="customersq();"><%} %>&nbsp;<input type=button name=prs value="设置办产权需要提交的资料" onclick="tidata('<%=section %>');">&nbsp;<%if (ajstate.equals("1")){ %><input type=button name=prs value="送 件" onclick="songjian();"><%} %>&nbsp;<input type=button name=prs value="打印备注" onclick="openwin('autoselect7.jsp?type=10',300,250,100,100);">
</td></tr>
</table>
 
  <%
  
  
  
          List list1=new LinkedList();//存合同号
	      List list2=new LinkedList();//存放备注状态
		  List list3=new LinkedList();//存合同号
	      List list4=new LinkedList();//存放备注状态
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
	    String    SQL="SELECT * FROM  cq_bak WHERE contractno in (select code from order_contract s where s.state=2 "+search+")";
  	    ResultSet rs1 = aBean.executeQuery(SQL);
		while (rs1.next()){
		     list1.add(rs1.getString("state1"));
		     list2.add(rs1.getString("contractno"));
		  
		}
		rs1.close();
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
								" and   s.state =2 and s.song_jian_date is null "+sdateStr ;// and s.cq=1 
							 
	
   SQL = "select Top "+pageSize+"  S.cq_check,s.ajbk,s.cq,s.section,s.custype, s.visadate,s.code,s.loft,s.building,s.room_no, c.signatory cus_name," ;
				SQL += " c.phone,c.serialno cus_no, s.contractno htno,s.floors , s.payment1  " ;
				SQL +=",  s.section,s2.name   " + SQL1+roomStr + search +" and s.code  not in  (select top "+prenum +" s.code  "+  SQL1+roomStr + search +" order by s.section,s.loft,s.building,s.floors,s.room_no)";
		 sqlcount="select count(*) as num "+SQL1+roomStr + search;
  
 
	 ResultSet rs = aBean.executeQuery(SQL+" order by s.section,s.loft,s.building,s.floors,s.room_no") ;
  %>
 

<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1>
   <tr align="center"  class=txtcolor> 
    <TD width="8%" > 
      <DIV ALIGN="CENTER">序号&nbsp;<input type=checkbox name=sh onclick=" chooseCheckbox(this.checked);"></DIV>
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
      <DIV ALIGN="CENTER">付款方式</DIV>
    </TD>
	 <TD> 
      <DIV ALIGN="CENTER">按揭银行</DIV>
    </TD>
    <TD> 
      <DIV ALIGN="CENTER"> </DIV>
    </TD>
	   <TD> 
      <DIV ALIGN="CENTER"> </DIV>
    </TD>  <TD> 
      <DIV ALIGN="CENTER"> </DIV>
    </TD>
  </TR>
  <%
  
  

   	int id = 0, ajYear = 0, ajHtId = 0  ;
	String section2= "";
	String name="",custype="";
	String room = "", customer = "",phone="", cusNo = "", htno = "", ajHtNo = "", ajBk = "",
			ajDate = "", ajMoneyStr = "", salePriceStr = "", isRegister = "0" ;  	
	String ajSection = "", paymentType = "", gh = "", dj = "", tz = "", lq = "" ;
	float salePrice = 0, ajMoney = 0 ;		
	String floors="" ;
	int iK = 0, propId = 0 ;
	int iLost2 = 0 ;
	int sqcq=0;
	String sbbz="0";
	String visadate="";  
	while (rs.next()) {	
	     sqcq= rs.getInt("cq");
		 int cq_check= rs.getInt("cq_check");
	     section=getbyte(rs.getString("section"));
	     custype=getbyte(rs.getString("custype"));
		visadate=getbyte(rs.getString("visadate")); 
		if (!visadate.equals(""))visadate=visadate.substring(0,10);
		id = rs.getInt("code");
		loft= getbyte(rs.getString("loft"));
		building= getbyte(rs.getString("building"));
	 	room = rs.getString("room_no");
		customer = getbyte(rs.getString("cus_name"));
		phone= getbyte(rs.getString("phone"));
		cusNo = rs.getString("cus_no") ;
		htno = rs.getString("htno");
		floors= rs.getString("floors");
		paymentType = getbyte(rs.getString("payment1")) ;
	 
		iK++ ;
		iLost2 = iK % 2 ;	
		String sColor = "ffffff" ;
		if (iLost2 == 1)
			sColor = "f6f6f6" ;		
		section2= getbyte(rs.getString("section"));
		name= getbyte(rs.getString("name"));
		sbbz="";
		   
		
   %>
  <tr align="center" BGCOLOR="<%= sColor %>"  onclick="ChangeTrColor(this, '', '<%= id %>', '', 'A6D3A6', 'f6f6f6')"  > 
    <TD  height="16" align="center"> 
     <%=iK %><input name="aa" value="<%=id %>" type="checkbox" <%if (cq_check==0){out.print("disabled title='财务未核对款是否结清'");} %>>
    </TD>
    <TD  height="16"> 
      <DIV ALIGN="left"><a href="#" onclick="openwin('../sale/showContract.jsp?secno=<%=section2 %>&roomno=<%=room %>&build=&loft=<%=loft %>&Floor=<%=floors %>',600,280,100,100)"><%=loft+room %></DIV>
    </TD> 
    <TD  height="16"> 
      <DIV ALIGN="left"><%if (sqcq==1){ %><img src="../images/day2.gif"><%}else {%>&nbsp;<%} %><%= customer %></DIV>
    </TD>
	 <TD  height="16"> 
      <DIV ALIGN="left"><%=phone %></DIV>
    </TD>
    <TD  height="16"> 
      <DIV ALIGN="left"> <%= htno %> </DIV>
    </TD>
    <TD height="16"> 
      <DIV ALIGN="left"><%= paymentType %></DIV>
    </TD>
	
	 <TD height="16"> 
      <DIV ALIGN="left"><%= getbyte(rs.getString("ajbk")) %></DIV>
    </TD>
	
    <TD  height="16"> 
      <DIV ALIGN="center"> <a href="#<%=htno %>1" onclick="openwin1('PropertyPerson.jsp?code=<%=id %>&htno=<%=htno %>',700,500,100,100);">共有人</a> </DIV>
    </TD>
	 <%
	  String bakState="0";
	 
	  if (list2.contains(String.valueOf(id))){
		   int index=list2.indexOf(String.valueOf(id));
		   bakState=(String)list1.get(index);
		 
		}
 
		    %>
	 <TD  height="16"> 
      <DIV ALIGN="center"> <a href="#<%=htno %>2" onclick="openwin1('PropertyBakAdd.jsp?code=<%=id %>&section=<%=section %>&chho=1&htno=<%=htno %>&Loft=<%=loft %>&room=<%=room %>',600,280,100,100);"><%if (bakState.equals("1")) {  %><font color=red><%} %>备注<%if (bakState.equals("1")) {  %></font><%} %></a> </DIV>
    </TD>
    <TD  height="16"> 
      <DIV ALIGN="center"> <a href="#<%=htno %>3" onclick="openwin1('../sale/<%if (custype.equals("个人"))out.print("cqdj.jsp");else out.print("dwcqdj.jsp"); %>?chho=1&htno=<%=id %>&SecNo=<%=section2 %>&Loft=<%=loft %>&room=<%=room %>');">打印</a> </DIV>
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
<input type=hidden name=Loft value="<%=China.getParameter(request, "Loft") %>">
<input type=hidden name=Build value="<%=building %>">
<%@ include file="../public_js/changepage3.jsp"%>
</form>
  <script>
  	 	var itemNo = "" ;   // roomNo
		var isOut = 0 ;   //rent or sale out
		var lastObject ;
		var ajMoneyStr ;
		function songjian(){
		//   SqlStr="update "+TableNameStr+"  set out='1',song_jian_date=getdate()  where " +  WhereSQL;
      
		 if (confirm("确认送件吗？"))
		    checkcq(); 
		}
		function tidata(para){
		  if (para==""){alert("请选择左边项目");return false;}
		  openwin3("add_data.jsp?section="+para,650,500,100,100);
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
	 
		function chooseCheckbox(para) {//indexstring
     var x=0;
	// var seldocs = new Array();
	var aa="";
	if (cus.elements.length){
	 var temp=cus.elements.length;
     for (i=0;i<cus.elements.length;i++) {
       if ((cus.elements[i].type=="checkbox")&&(cus.elements[i].name=="aa"))
		 {
       		cus.elements[i].checked=para;
			
   		 }
	  }	
	  }
 
}   function customersq(){
	 
	 
	 if (getseldocs2()==""){alert("请选择申请办理产权的合同");return false;}
	   if (confirm("确认通过吗？"))
	   openwin("../sale/updateCheckState.jsp?codes="+getseldocs2(),7,5,10,10);
	 
	 }
	
	 function checkcq(){
	 
	 
	 if (getseldocs2()==""){alert("请选择可以办理产权的合同");return false;}
	 
	 
	 
	   if (confirm("确认通过吗？"))
	   openwin("sendCq.jsp?codes="+getseldocs2(),700,500,10,10);
	 
	 }
   	 function getseldocs2() {
     var x=0;
	 var seldocs = new Array();
	 var temp=cus.elements.length;
     for (i=0;i<cus.elements.length;i++) {
       if ((cus.elements[i].type=="checkbox")&&(cus.elements[i].name=="aa")&&(cus.elements[i].checked))
		 { 
		    seldocs[x]=cus.elements[i].value ;
			x++;
   		 }
	  }	

   return seldocs ;
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
 function ch(para){
		 
		    document.cus.submit();
		
		}
  </script>
</BODY>
</HTML>
