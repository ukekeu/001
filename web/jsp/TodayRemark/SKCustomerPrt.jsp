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
 
	if (section == null)
		section = "";
	String loft = "" ;
	
	loft = request.getParameter("Loft") ;
	if (!FindD.equals(""))loft=getbyte1(loft);
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
	
%> 


<body  >

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
   <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
  <div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >

<p ALIGN="CENTER" class=FontColor><font size=3><b>催交房款一览表(客户欠款明细表)</b></font></p>
<form name=frm action="F_NoGetList.jsp">
  
<TABLE WIDTH="98%" BORDER="0" CELLSPACING="0" CELLPADDING="0" bgcolor="#EAEAEA">
  
  
  <TR>
    <TD width=50% >
     <div id=sectionname></div>
    </TD>
	 <%
   String StrWhere = "" ;
   String showDate=" convert(char(10),shouldDate,120) ";
   String DisplayS=China.getParameter(request,"Display");
   

    if( !cbdate.equals("") ) {
        StrWhere = StrWhere + " and substring(convert(char(24),shouldDate,120),1,10) >= '" + cbdate + "' " ;
    }
 
    if( !cedate.equals("") ) {
        StrWhere = StrWhere + " and  substring(convert(char(24),shouldDate,120),1,10) <= '" + cedate + "' " ;
    }
   if (DisplayS.equals(""))DisplayS="d0";
   DisplayS=DisplayS.substring(1);
   if (!DisplayS.equals("0")) {
     showDate=" convert(char(10),dateadd(dd,-"+DisplayS+",g.shouldDate),120) ";
    }	
	 
	  String SQL="SELECT convert(char(10),dateadd(dd,+"+DisplayS+",getdate()),120) dd";
 
	String ts="";
	ResultSet Rs = aBean.executeQuery(SQL) ;
	if (Rs.next())ts=Rs.getString("dd");
	Rs.close();
		//Timestamp ts = new Timestamp(System.currentTimeMillis()) ;
		String year = ts.substring(0, 4) ;
		String month = ts.substring(5, 7) ;
		String day = ts.substring(8, 10) ;
	%>
	<td width=50%  align="right">
		截止日期:    <%= year %>  年　<%= month %>　月　<%= day %>　日
	</td>
 
  </TR>
</TABLE>
  <% 
    
	 
  String order_code="";
  if (building==null)building="";
  if (!RoomS.equals(""))RoomS=" and  s.room_no like '%"+RoomS+"%'";
  		
		String sListName = "F_NoGetList" ;
		String sConditionStr = " from  Order_Contract s, customer c, gatheringRecord g  " + 
							" where g.shouldMoney*g.rate -g.yijiao*g.rate>0 and  s.state<>3 and s.code= g.contactno   and c.serialNo = s.customer and " + 
								" g.cusNo = s.customer ";
								if (!section.equals(""))
								sConditionStr +=" and s.section = '" + section + "'";
								if (!building.equals(""))
								sConditionStr+=" and s.building = '"+building+"'" ;
								if (!loft.equals(""))
								sConditionStr+=" and s.loft ='" + loft + "'";
								sConditionStr+="  and "+showDate+"<=convert(char(10),getdate(),120)" ;
			
		String sStr = "select s.seller,s.sectionname,s.loft, s.building,s.room_no, c.signatory cus_name, c.serialNo, c.phone,c.sj, " +
				"g.contactno,g.shouldQs, g.shouldDate, g.shouldMoney*g.rate -g.yijiao*g.rate AS qk_dMoney,case when   "+showDate+"<convert(char(10),getdate(),120) then g.shouldMoney*g.rate else 0 end as factQK, g.yijiao*g.rate as yijiao ,s.demurrage,datediff(d,"+showDate+",getdate()) as day " + 
				" " + sConditionStr+StrWhere+RoomS +" order by s.sectionname,s.loft,s.floors,s.room_no,g.shouldDate ";
  		 
		  Rs = aBean.executeQuery(sStr) ;
  %>
 
 

<table width="98%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
 
  <tr align="center" > 
    <TD > 
       
        序号
      
    </TD>
	<TD  > 
      房号
    </TD>
    <TD > 
      客户姓名
    </TD>
    <TD  > 
      联系电话
    </TD>
	  <TD  > 
      联系手机
    </TD>
    <TD  > 
      款项
    </TD>
    <TD > 
      应收日期
    </TD>
   
    <TD > 
      实收金额
    </TD>
  
	    <TD > 
      欠款
    </TD>

	 
	 <TD > 
      销售员
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
	String sj="",sectionname="",seller="";
	double qk_dMoney=0;
	while (Rs.next()  ) {	
	    seller=getbyte(Rs.getString("seller")) ;
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
		shouldDate = Rs.getString("shouldDate").substring(0, 10) ;
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
  <tr align="center" id=R<%=jj %> onmouseover="mout(this);"   BGCOLOR="<%= sColor %>" ondblclick="yingshi('<%= order_code%>','<%= cusNo %>');" onclick="changeclass1(this,'clickbg','listcontent');"> 
    <TD > 
       
	    <%if (da>=15) {%><font color=red><%} %>
        <%= jj %>
		  <%if (da>=15) {%></font><%} %>
      
    </TD>
	   <TD> 
      <%=loft+building+room %>
    </TD>
    <TD> 
      <%= Repalce(customer,"/") %>
    </TD>
    <TD> 
      <%=Repalce(phone,"/")   %>
    </TD>
	  <TD> 
      <%=Repalce(sj,"/")   %>
    </TD>
    <TD> 
      <%if (qs.equals("0"))out.println("定金");else out.println("楼款"); %><%//Integer.parseInt(qs)+1 %>
    </TD>
 
   
    <TD > 
      <%= shouldDate %>
    </TD>

   
    <TD > 
      <%= fa.getFloat2(yijiao,2) %>
    </TD>
	
	
 
	 <TD bgcolor='#EAECEC' > 
      <font color=red><%= fa.getFloat2(qk_dMoney,2) %></font>
    </TD>
	 
	 <TD > 
      <%= seller%>
    </TD>
  </TR>
  <%
   	}
   %>
</TABLE>
 </div>
    <DIV align=center id="printdiv">
<input type="button" onclick="bringToExcel()" value="导出到Excel">&nbsp;<input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">

</form> 
<script>
sectionname.innerHTML ="楼盘名称:<%=sectionname %>";
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
          var selectArea=document.body.createTextRange(); //创建文本区域 
        selectArea.moveToElementText(report1);//将文本区域聚焦到printData 
        selectArea.select();//选中printData 
        selectArea.execCommand("Copy");//将printData复制到剪切板中 
         oSheet.Paste();//将剪切板中的数据复制到Excel中    
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
 
</script>
  </BODY>
</HTML>
