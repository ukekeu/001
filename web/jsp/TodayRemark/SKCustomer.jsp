<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<HTML>
<HEAD>
<TITLE>应收款</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chrset=gb2312"> 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language=javascript src="../sale/js/mad.js"> </script>
<script language="javascript" src="../public_js/public.js"></script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
</head>
  <%@ page import="java.sql.*,common.*,java.util.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
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
	
	 
%><script>
	function submitv() {
		if (document.aform.Building.value == "") {
			alert("请输入栋号");
			return false;
		}	
	}
	
 
</script>
<script>
function AlertDate(){
  document.form1.action="SKCustomer.jsp";
  document.form1.submit();

}
function paulsel(){
		document.form1.submit();
	}

</script>
<%String DisplayS=China.getParameter(request,"Display"); %>
<%
 
String section1=request.getParameter("section");
String paulurl="";
if(section1==null || section1.equals(""))
{
	paulurl="";
}else{
	paulurl=" and  section='"+section1+"'";
}
%>
<%@ include file="../public_js/countpagenum.jsp"%>
<%@ include file="../public_js/CheckSection.jsp"%>
<body  topmargin="1"   onload="setSelectMad(document.form1.Display,'<%= DisplayS %>');setSelectMad(document.form1.section,'<%= section1 %>');"> 
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

<% String sel=(String)request.getParameter("sel");
 
  
   if(sel==null) sel="1"; %>
  <form method="POST" name="form1" action="">
  <input type=hidden name="sel" value="<%=sel %>">
 
  
</center>
<script>
function findSub(para){
   document.form1.action=para;
   document.form1.submit();


}

 
var sendmess="";
var sendto="";
function chhoseData(dd){
   for (var i=0;i<document.form1.choos.length;i++){
 	  document.form1.choos[i].checked=dd;
	 
    }

}
function chhoseData1(){
sendmess="";
sendto="";
   for (var i=0;i<document.form1.choos.length;i++){
 	 
	  if (document.form1.choos[i].checked){
	    var aa=document.form1.choos[i].value;
		
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
 if (sendmess==""){alert("选择的客户可能没有记录手机号");return false;}
openwin1("../../sendmessage/SendMessage.jsp?messtype=0&sendmess="+sendmess+"&sendto="+sendto,400,300,100,100);
}

function printTx(){
 
 if (document.form1.section.value==""){alert("请选择楼盘名称");return false;}
openwin1("SKCustomerPrt.jsp?SecNo="+document.form1.section.value+"&Display="+document.form1.Display.value,750,600,10,10);
}
</script>
<p ALIGN="CENTER" class=FontColor><font size=3><b>欠款客户明细表</b></font></p>
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
		</select>&nbsp;<input type=button name=Prin value="打印" onclick="printTx();">
		按楼盘显示：<select name="section" onchange="paulsel();"> 
   <option value=""></option>
   <%	
      String sql1="select SerialNo,Name from crm_project "+FindWhere+" group by  Name,SerialNo order by name";

	  ResultSet rs2=aBean.executeQuery(sql1);
	  String sec="";
	  String no1="";
	  String daa="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
	   if(no1.equalsIgnoreCase(section)){
		   daa=" selected";
		   }else{
			   daa="";
		   }
       out.print("<option value='"+no1+"'"+daa+">"+sec+"</option>");
	  }
	  rs2.close();
     %> </select>
</p>  



  <% 
    String sql="";
    String StrWhere = "" ;
   if (DisplayS.equals(""))DisplayS="d0";
   DisplayS=DisplayS.substring(1);
   if (DisplayS.equals("0")) {
  StrWhere =" where convert(char(10),shouldDate,120) <= convert(char(10),getdate(),120)";
   StrWhere+=" and section in  "+FindWhere.substring(FindWhere.indexOf("("));
   }else{
  StrWhere= " where  convert(char(10),dateadd(dd,-"+DisplayS+",shouldDate),120)<=convert(char(10),getdate(),120) ";
   StrWhere+=" and section in  "+FindWhere.substring(FindWhere.indexOf("("));
   }

	 sql="select Top "+pageSize+"  *  from   view_qkTx"+	StrWhere+paulurl ;
	 sql+=" and code not in (Select top "+prenum +" code from view_qkTx "+StrWhere+paulurl +" order by  sectionname, loft , room_no, shouldDate) order by sectionname, loft , room_no, shouldDate";


 sqlcount="select count(code) code from view_qkTx "+StrWhere+paulurl ;
 


 ResultSet rs=ViewBean.executeQuery(sql);
	  
  %>
  <input type=button name=sendmess value="发送短信" onclick="sendmessage();">
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
	 <TD > 
      <DIV ALIGN="CENTER">销售员</DIV>
    </TD>
  </tr>
  <%
   	int id = 0, ajYear = 0, ajHtId = 0  ;
	String room = "", sectionname="",customer = "", cusNo = "", htno = "", ajHtNo = "", ajBk = "",
			paymentType = "", contractNo = "", jzAreaStr = "", phone = "",
			ajDate = "", ajMoneyStr = "", salePriceStr = "", isRegister = "0",
			shouldMoneyStr = "", factMoneyStr = "", noMoneyStr = "",allname="" ;  	
	String ajSection = "", qs = "",order_code="", shouldDate ;
	float salePrice = 0, ajMoney = 0, jzArea = 0, shouldMoney = 0 ;		
	int iK = 0, jj = 0 ;
	int iLost2 = 0 ;
	String sj="";
	double qk_dMoney=0;
 
	while (rs.next()  ) {	
	    sectionname=getbyte(rs.getString("sectionname")) ;
		loft=getbyte(rs.getString("loft")) ;
		building=getbyte(rs.getString("building")) ;
		room = rs.getString("room_no") ;
		allname=sectionname+loft+building+room;
		
		customer = getbyte(rs.getString("cus_name"));
		cusNo = rs.getString("serialNo") ;
		phone = getbyte(rs.getString("phone"));
		sj= getbyte(rs.getString("sj"));
	 phone+=" "+sj;
                order_code= rs.getString("contactno") ;
		qs = rs.getString("shouldqs") ;
		shouldDate = rs.getString("shouldDate").substring(0, 10) ;
		qk_dMoney = rs.getDouble("qk_dMoney") ;
		double yijiao= rs.getDouble("yijiao") ;
		double factQK= rs.getDouble("factQK") ;
		 demurrage= rs.getFloat("demurrage") ;
		 
		jj++ ;
		
		iK++ ;
		iLost2 = iK % 2 ;	
		String sColor = "ffffff" ;
		if (iLost2 == 1)
			sColor = "f6f6f6" ;		
   %>
  <tr align="center" id=R<%=jj %> onmouseover="mout(this);"  title="双击相关财务信息"  class=listcontent BGCOLOR="<%= sColor %>" ondblclick="yingshi('<%= order_code%>','<%= cusNo %>');" onclick="changeclass1(this,'clickbg','listcontent');"> 
    <TD > 
      <DIV ALIGN="CENTER"> 
        <input type=checkbox name=choos value="<%=sj %>|<%=sectionname+loft+room%>"><%= jj %>
      </DIV>
    </TD>
	   <TD> 
      <DIV ALIGN="CENTER"><%=loft+room %></DIV>
    </TD>
    <TD> 
     <DIV ALIGN="CENTER"><%=  customer  %></DIV>
    </TD>
    <TD> 
      <DIV ALIGN="CENTER"><%= phone  %>&nbsp</DIV>
    </TD>
    <TD> 
      <DIV ALIGN="CENTER"><%if (qs.equals("0"))out.println("定金");else out.println("楼款"); %></DIV><%//Integer.parseInt(qs)+1 %>
    </TD>
 
   
    <TD > 
      <DIV ALIGN="CENTER"><%= shouldDate %></DIV>
    </TD>

   
    <TD > 
      <div align="right"><%= fa.getFloat2(yijiao,2) %></div>
    </TD>
    <TD> 
      <DIV  align="right"><%= fa.getFloat2(qk_dMoney,2) %></DIV>
    </TD>
	
	 <TD > 
      <DIV ALIGN="right"><%= demurrage%></DIV>
    </TD>
	 <TD > 
      <DIV ALIGN="CENTER"><%= getbyte(rs.getString("seller"))%></DIV>
    </TD>
  </TR>
  <%
   	}
		
   %>
</TABLE>
  <%@ include file="../public_js/changepage.jsp"%>
  
<script>
 function yingshi( contractno , cusno ) {
    openwin("../finance/yingshi.jsp?contractno=" + contractno + "&cusno=" + cusno ,560,450,50,50);
  }    
</script>
  </form>
  </BODY>
</HTML>
