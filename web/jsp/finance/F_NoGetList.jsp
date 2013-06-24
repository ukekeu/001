<%@ page contentType="text/html;charset=GBK" %>

 <%@ include file="../public_js/checktime.jsp"%>
<HTML>
<HEAD>
<TITLE> 欠款明细表</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chRset=gb2312"> 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language=javascript src="../sale/js/mad.js"> </script>
<script language="javascript" src="../public_js/public.js"></script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
</head>
  <%@ page import="java.sql.*,common.*,java.util.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
 
   <jsp:useBean id="setpro" scope="session" class="setProperty.setProperty"/>   
   <jsp:useBean id="fa" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>

<%  
String cbdate="";
String cedate="";
cedate = getbyte( request.getParameter("cedate" ) ) ;
cbdate = getbyte( request.getParameter("cbdate" ) ) ;

    float demurrage=0;
    String RoomS=China.getParameter(request,"Room");
	String section = "";
	section = request.getParameter("SecNo");
	 
	String FindD= getbyte1(request.getParameter("FindD"));
    String cusname= getbyte1(request.getParameter("cusname"));
 
	if (section == null)
		section = "";
	String loft = "" ;
	
	loft = request.getParameter("Loft") ;
	if (!FindD.equals(""))loft=getbyte1(loft);
	else loft = getbyte2(loft);
	if (loft == null)
		loft = "" ;	
	String building = "";
	building = request.getParameter("Build");
	if (building == null)
		building = "";
	String secName = "" ;
	secName = request.getParameter("SecName");
	if (secName == null)
		secName = "" ;	
    else secName = getbyte2(secName);
	
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


<body onload="document.frm.Room.focus();document.frm.Room.select();">

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
<p ALIGN="CENTER" class=FontColor><font size=3><b>催交房款一览表(客户欠款明细表)</b></font></p>
<form name=frm action="F_NoGetList.jsp">
 <input type=hidden name=SecNo value="<%=section %>">
 <input type=hidden name=Loft value="<%=loft %>">
 <input type=hidden name=FindD value="Find">
 <input type=hidden name=cusname value="">
<input type=hidden name=secname value="">
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0" bgcolor="#EAEAEA">
  
  
  <TR>
    <TD width=50% >
      &nbsp;楼盘:<%=secName %>
    </TD>
	<%
		Timestamp ts = new Timestamp(System.currentTimeMillis()) ;
		String year = ts.toString().substring(0, 4) ;
		String month = ts.toString().substring(5, 7) ;
		String day = ts.toString().substring(8, 10) ;
	%>
	<td width=50%  align="right">
		截止日期:    <%= year %>  年　<%= month %>　月　<%= day %>　日
	</td>
	<td  align="right"> &nbsp;<!--<input type=button name=print value="催款通知单" onclick="window.open('<%=reportAddrs %>PrintNotify.j.rpt','blank','toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes')">&nbsp;<input type=button name=print value="催款明细表" onclick="window.open('<%=reportAddrs %>ArrearMxRep.rpt','blank','toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes')">--></td>
  </TR>
</TABLE>
  <% 
    String StrWhere = "" ;

    if( !cbdate.equals("") ) {
        StrWhere = StrWhere + " and substring(convert(char(24),shouldDate,120),1,10) >= '" + cbdate + "' " ;
    }
 
    if( !cedate.equals("") ) {
        StrWhere = StrWhere + " and  substring(convert(char(24),shouldDate,120),1,10) <= '" + cedate + "' " ;
    }
  String order_code="";
  if (building==null)building="";
  if (!RoomS.equals(""))RoomS=" and  s.room_no like '%"+RoomS+"%'";
  if (!cusname.equals(""))		RoomS=" and  c.cus_name like '%"+cusname+"%'";
		String sListName = "F_NoGetList" ;
		String sConditionStr = " from  Order_Contract s, customer c, gatheringRecord g  " + 
							" where g.shouldMoney*g.rate -g.yijiao*g.rate>0 and  s.state<>3 and s.code= g.contactno   and c.serialNo = s.customer and " + 
								" g.cusNo = s.customer and s.section = '" + section + "'";
								if (!building.equals(""))
								sConditionStr+=" and s.building = '"+building+"'" ;
								if (!loft.equals(""))
								sConditionStr+=" and s.loft ='" + loft + "'";
								sConditionStr+="  and convert(char(10),g.shouldDate,120)<=convert(char(10),getdate(),120)" ;
			
		String sStr = "select s.sectionname,s.loft, s.building,s.room_no, c.cus_name , c.serialNo, c.phone,c.sj, " +
				"g.contactno,g.shouldQs, g.shouldDate, g.shouldMoney*g.rate -g.yijiao*g.rate AS qk_dMoney,case when   convert(char(10),g.shouldDate,120)<convert(char(10),getdate(),120) then g.shouldMoney*g.rate else 0 end as factQK, g.yijiao*g.rate as yijiao ,s.demurrage,datediff(d,g.shouldDate,getdate()) as day " + 
				" " + sConditionStr+StrWhere+RoomS +" order by s.sectionname,s.loft,s.floors,s.room_no,g.shouldDate ";
 
     String upateSQL="update View_ArrearMXList set out=1 where section = '" + section + "' " ;
     if (!loft.equals("")) upateSQL+=" and loft ='" + loft +	"'";
		 int a= aBean.executeUpdate("update View_ArrearMXList set out=0");
	     int b=aBean.executeUpdate(upateSQL);				
		ResultSet Rs = aBean.executeQuery(sStr) ;
  %>
 
<table bgcolor="#EAEAEA" width="100%">
 <tr>
  <td>
房号:  <input type=text size=10 name=Room >&nbsp;
应收日期: 从<input type=input name=cbdate size=10 readonly value="<%=cbdate %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(cbdate);return false;">到<input type=input name=cedate size=10 readonly value="<%=cedate %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(cedate);return false;"><input type=submit name=find value="查询">&nbsp;<input type=button name=outexcel value="导出到EXCEL " onclick="window.open('F_NoGetListExcel.jsp?SecNo=<%=section %>&Loft=<%=loft %>')">
&nbsp; <input type=button name=sendmess value="发送短信" onclick="sendmessage();">
  </td>
 </tr>
</table>

<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >
  <tr class=TXTColor> 
    <TD > 
      <DIV ALIGN="CENTER"> 
        <input type=checkbox name=ch onclick="chhoseData(this.checked);">序号
      </DIV>
    </TD>
	<TD  > 
      <DIV ALIGN="CENTER">房间代码</DIV>
    </TD>
    <TD > 
      <DIV ALIGN="CENTER">客户姓名</DIV>
    </TD>
    <TD  > 
      <DIV ALIGN="CENTER">联系电话</DIV>
    </TD>
	 <TD  > 
      <DIV ALIGN="CENTER">联系手机</DIV>
    </TD>
    <TD  > 
      <DIV ALIGN="CENTER">款项</DIV>
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
	String sj="",sectionname="";
	double qk_dMoney=0;
 
	while (Rs.next()  ) {	
	    sectionname=getbyte(Rs.getString("sectionname")) ;
		loft=getbyte(Rs.getString("loft")) ;
		building=getbyte(Rs.getString("building")) ;
		room = Rs.getString("room_no") ;
		customer = getbyte(Rs.getString("cus_name"));
		cusNo = Rs.getString("serialNo") ;
		phone = getbyte(Rs.getString("phone"));
		sj= getbyte(Rs.getString("sj"));
		    if (sj.length()<6)sj="";
		 
                order_code= Rs.getString("contactno") ;
		qs = Rs.getString("shouldqs") ;
		shouldDate = Rs.getString("shouldDate").substring(2, 10) ;
		qk_dMoney = Rs.getDouble("qk_dMoney") ;
		double yijiao= Rs.getDouble("yijiao") ;
		double factQK= Rs.getDouble("factQK") ;
		
		demurrage= Rs.getFloat("demurrage") ;
		int da=Rs.getInt("day") ;
		 
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
	  <input type=checkbox name=choos value="<%=sj %>|<%=sectionname+loft+building+room%>"> 
		
	    <%if (da>=15) {%><font color=red><%} %>
        <%= jj %>
		  <%if (da>=15) {%></font><%} %>
      </DIV>
    </TD>
	   <TD> 
      <DIV ALIGN="CENTER"><%=loft+building+room %></DIV>
    </TD>
    <TD> 
      <DIV ALIGN="CENTER"><%= Repalce(customer,"/") %></DIV>
    </TD>
    <TD> 
      <DIV ALIGN="CENTER"><%=Repalce(phone,"/")   %>&nbsp</DIV>
    </TD>
	 <TD> 
      <DIV ALIGN="CENTER"><%=Repalce(sj,"/")   %>&nbsp</DIV>
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
	
	
 
	 <TD bgcolor='#EAECEC' > 
      <DIV ALIGN="CENTER"><font color=red><%= fa.getFloat2(qk_dMoney,2) %></font></DIV>
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
  <b>说明: <font color="#FF0000">红色序号表示欠款已超过15天.</font></b> 
  <script>
 function yingshi( contractno , cusno ) {
    openwin("yingshi.jsp?contractno=" + contractno + "&cusno=" + cusno ,690,450,50,50);
  }    
</script>

<script> 
function chhoseData(dd){
   for (var i=0;i<document.form1.choos.length;i++){
 	  document.form1.choos[i].checked=dd;
    }

}
var sendmess="";
var sendto="";
function chhoseData(dd){
   for (var i=0;i<document.frm.choos.length;i++){
 	  document.frm.choos[i].checked=dd;
	 
    }

}
function chhoseData1(){
sendmess="";
sendto="";
   for (var i=0;i<document.frm.choos.length;i++){
 	 
	  if (document.frm.choos[i].checked){
	    var aa=document.frm.choos[i].value;
		
	    if (sendmess=="")
		 sendmess=aa.substring(0,aa.indexOf("|"));
		else
		 sendmess+=","+aa.substring(0,aa.indexOf("|"));
	  
	 
	    if (sendto=="")
		 sendto=aa.substring(aa.indexOf("|")+1);
		else
		 sendto+=","+aa.substring(aa.indexOf("|")+1);
	  
	  }
    }

}
function sendmessage()
{
chhoseData1();
 if (sendmess==""){alert("选择的客户没有登记手机号");return false;}
openwin1("../../sendmessage/SendMessage.jsp?messtype=2&sendmess="+sendmess+"&sendto="+sendto,400,300,100,100);
}
  </script>
  </form>
  </BODY>
</HTML>
