<%@ page contentType="text/html;charset=GBK" %>
 
<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<HEAD>
<TITLE>按揭一览表</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chAjRset=gb2312"> 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language=javascript src="../sale/js/mad.js"> </script>
 
</head>
 <%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
   <jsp:useBean id="setpro" scope="session" class="setProperty.setProperty"/>   
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
 <%@ include file="../public_js/logrecord.jsp" %>

 <%
String Cortrol=checke_qx(aBean,(String)session.getAttribute("loginid"),"S006");
   String cusname=China.getParameter(request,"cusname");
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
	else loft=getbyte2(loft);
	
    
	String building = "";
	
	building = request.getParameter("Build") ;
	if (building == null)
		building = "";
		else building=getbyte2(building);
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

<body topmargin="1" >
<%

  		String ajstate=getbyte1(request.getParameter("ajstate"));
		String banktj=getbyte1(request.getParameter("banktj"));
		String cancelsb=getbyte1(request.getParameter("cancelsb"));
		if (!cancelsb.equals("")){
		bBean.executeUpdate("update order_contract set aj_send_date=null,AjBk='' where code="+cancelsb);

		setlog( bBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "待办按揭" , 
                  "取消"+getbyte1(request.getParameter("cancelroom"))
                ) ;	
		}
		if (!banktj.equals("")){
		bBean.executeUpdate("update order_contract set ajdate=null,dyyj=0 ,ajhtno='',bank_person='' where code="+banktj);

		setlog( bBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "按揭" , 
                  "退件"+getbyte1(request.getParameter("cancelroom"))
                ) ;	
		}
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
			sdateStr = " and   not s.ajdate is null" ;
			checkState2="checked";
			checkState1="";
			checkState3="";
			}
	    else if (ajstate.equals("0")){
		    sdateStr = " and (s.ajhtno ='' or s.ajhtno is null) and  (  s.aj_send_date is null)" ;
			checkState1="checked";
			checkState2="";
			checkState3="";
		} else if (ajstate.equals("3")){
			sdateStr = " and (s.aj_send_date<>'' and      s.ajdate is null) " ;
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
<form name="cus" action="AjListS.jsp" method="post">
<% String sel=(String)request.getParameter("sel");
 
  
   if(sel==null) sel="0"; %>
 
  <input type=hidden name="sel" value="<%=sel %>">
  <table width="180" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=0;findSub('AjListS.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>按揭客户</font></a>
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
		 
		 checkcq();
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
 
}
	
	 function checkcq(){
	 	 if (getseldocs2()==""){alert("请选择可以办理按揭的合同");return false;}
	    if (confirm("确认通过吗？"))
	   openwin1("sendAj.jsp?codes="+getseldocs2(),600,200,10,10);
	 }
	  function checkAj(){
	 	 if (getseldocs2()==""){alert("请选择已办理按揭的合同");return false;}
	    if (confirm("确认通过吗？"))
	   openwin1("inputAjs.jsp?codes="+getseldocs2(),400,200,100,100);
	 }
	 
	  function dyqd(){
	 
	 
	 if (getseldocs2()==""){alert("请选择移交的合同");return false;}
	 
	   if (confirm("确认通过吗？"))
	   openwin1("AjDyList.jsp?codes="+getseldocs2(),700,500,10,10);
	 
	 }
	  function dyqd1(){
	   openwin1("rep_AjDyList.jsp?section=<%=section %>",700,500,10,10);
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
</script>
<input type=hidden name=slou>
<input type=hidden name=SecNo value=<%=section %>>
<input type=hidden name=Loft value="<%=loft %>">
<input type=hidden name=Loft value="<%=loft %>">
<input type=hidden name=sdate>
<input type=hidden name=Room>
<input type=hidden name=Flow>
<input type=hidden name=IsFinish>
<input type=hidden name=cusname>
<input type=hidden name=secname value="">
<input type=hidden name=SecName  >
<input type=hidden name=Bank>
<input type=hidden name=banktj>
 <input type=hidden name=cancelroom>

 <input type=hidden name=cancelsb>
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
  <TR> 
     <TD COLSPAN="2" class=FontColor>
      <DIV ALIGN="CENTER"><font size=4><%=loft+building %>按揭客户一览表</font></DIV>
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
   <input type=button name=sdd value="按揭进度表" onclick="openwin1('aj_process_view.jsp?SecNo=<%=section %>&Loft=<%=loft %>');"><%if (checkState1.equals("checked")) {%>  <input type=button name=sd value="送办按揭" onclick="sendaj();"><%} %>&nbsp;<%if (checkState3.equals("checked")) {%> <input type=button name=sda value="批量登记" onclick="checkAj();">&nbsp;<input type=button name=sda value="按揭明细" onclick="aj();"><input type=button name=sda value="按揭统计" onclick="aj1();"><%} %>&nbsp;<%if (checkState2.equals("checked")) {%> <input type=button name=sda value="按揭明细" onclick="aj();"><input type=button name=sda value="按揭统计" onclick="aj1();">&nbsp;<input type=button name=sda value="送抵押" onclick="dyqd();">&nbsp;<input type=button name=sda value="打印抵押清单" onclick="dyqd1();"><%} %><input type=button name=prs value="设置办按揭需要提交的资料" onclick="tidata('<%=section %>');">&nbsp;
    </TD>
  </TR>
</TABLE>
  <%
  String ajbakSQL="SELECT contractno,state1 FROM aj_bak WHERE contractno in (select  code from order_contract s where s.state<>3 "+search+" ) and state1=1";
    List list1=new LinkedList();//存放铺位编码
	List list2=new LinkedList();//存放铺位状态
	 ResultSet Ajbak = aBean.executeQuery(ajbakSQL) ;
	  while (Ajbak.next()){
   	        list1.add(Ajbak.getString("contractno"));
		    list2.add(Ajbak.getString("state1"));
			 
     }
	 Ajbak.close();
		String sListName = "AjList" ;
		String floors="";
		String ajcs="";	
		session.setAttribute("S_CurrentPageCount" + sListName, "10000") ;
		String sConditionStr = " from Order_Contract s, customer c" + 
							" where not s.visadate is null and  c.serialNo = s.customer " + 
								
								"  and s.state=2 and s.payment like '%揭%' " + roomStr + bankStr + flowStr + sdateStr + slouStr ;
		String Str = "select s.code saleId, s.section,s.floors,s.sectionname,s.bank_person, s.loft, s.building, s.room_no, c.signatory cus_name," +
				"c.Phone, c.serialno cus_no, s.ContractNo htno, s.salerprice salePrice, s.ajMoney ajmoney, s.ajHtno," + 
				" s.ajyear,s.ajcs, s.MonthPayMoney,s.ajbk, s.ajdate,s.aj_send_date,s.visadate,s.bxstate,s.gzstate,s.gtsj_date,s.gtcz_date,s.fkdate,s.dyyj " + sConditionStr +search+ " order by s.sectionname, s.loft, s.building, s.floors,s.room_no ";
	 ResultSet AjRs = aBean.executeQuery(Str) ;
 
 %>
 
<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 >
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
	  <td>备注</td>
	  <td>按揭登记</td>
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
	String bxstate="",gzstate="",gtcz_date="",gtsj_date="",bank_person="";
 
	
	while (AjRs.next() ) {	
	 i++;
		saleId = AjRs.getInt("saleId") ;
		ajSection = AjRs.getString("section") ;
		floors = AjRs.getString("floors") ;
		sectionName2 = getbyte(AjRs.getString("sectionname"));
		loft=getbyte(AjRs.getString("loft"));
		bank_person=getbyte(AjRs.getString("bank_person"));
		building=getbyte(AjRs.getString("building"));
	 	room = AjRs.getString("room_no");
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
		      
    <tr align="center" title="双击可弹出窗口登记或修改" id=R<%=i %>  ondblclick="openwin1('inputAj.jsp?saleid=<%=saleId %>&monthpay=<%=monthpay %>&ajyear=<%=ajYear %>&ajcs=<%=ajcs %>&ajbk=<%=ajBk %>&ajHt=<%=ajHtno %>&ajDate=<%=ajDate %>&bxstate=<%=bxstate %>&gzstate=<%=gzstate %>&gtcz_date=<%=gtcz_date %>&gtsj_date=<%=gtsj_date %>',350,320,100,100);"  class='listcontent' onclick="changeclass1(this,'clickbg','listcontent');ChangeTrColor(this, '<%= saleId %>', '<%= saleId %>', '<%= ajMoney %>', 'A6D3A6', 'f6f6f6')"  > 
    <%}else{ %>
	  <tr align="center"   id=R<%=i %>     class='listcontent' onclick="changeclass1(this,'clickbg','listcontent');ChangeTrColor(this, '<%= saleId %>', '<%= saleId %>', '<%= ajMoney %>', 'A6D3A6', 'f6f6f6')"  > 
  
  <%} %>
	  <TD> 
  <%= i %> <%if (!dyyj){ %><input name="aa" value="<%=saleId %>" type="checkbox"><%} %>
      </TD>
	  <TD> 
        <a href="#" onclick="openwin1('../sale/showContract.jsp?secname=&secno=<%=ajSection %>&roomno=<%=room %>&build=<%=building %>&loft=<%=loft%>&Floor=<%=floors %>&show=true',680,530,50,2);"><%=loft+building+ room %></a> 
      </TD>
      <TD> 
        <%= customer %> 
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
	    <%
	  String bakState="0";
	 
	  if (list1.contains(String.valueOf(saleId))){
		   int index=list1.indexOf(String.valueOf(saleId));
		   bakState=(String)list2.get(index);
		  
		}
 
		    %>
	  <td>   <DIV ALIGN="center"> <a href="#<%=htno %>2" onclick="openwin1('AjBakAdd.jsp?code=<%=saleId %>&section=<%=section %>&chho=1&htno=<%=htno %>&Loft=<%=loft %>&room=<%=room %>',600,280,100,100);"><%if (bakState.equals("1")) {  %><font color=red><%} %>备注<%if (bakState.equals("1")) {  %></font><%} %></a>
	  
	
	   </DIV>
  </td>
  <td><%if (!checkState3.equals("")){ %><a href="#" onclick="openwin1('inputAj.jsp?saleid=<%=saleId %>&monthpay=<%=monthpay %>&ajyear=<%=ajYear %>&ajcs=<%=ajcs %>&ajbk=<%=ajBk %>&ajHt=<%=ajHtno %>&ajDate=<%=ajDate %>&bxstate=<%=bxstate %>&gzstate=<%=gzstate %>&gtcz_date=<%=gtcz_date %>&gtsj_date=<%=gtsj_date %>&bank_person=<%=bank_person %>',350,320,100,100);" >登记</a><%} %>
  <%if (!checkState3.equals("")) {%>
  
  <a href="#" title="取消送办" onclick="if (confirm('确认取消吗？')){document.cus.cancelsb.value='<%=saleId %>';document.cus.cancelroom.value='<%=loft+room %>';document.cus.submit();}">取消</a>
  
  <%}
  if (ajstate.equals("1")){%>
  <a href="#" onclick="openwin1('inputAj.jsp?saleid=<%=saleId %>&monthpay=<%=monthpay %>&ajyear=<%=ajYear %>&ajcs=<%=ajcs %>&ajbk=<%=ajBk %>&ajHt=<%=ajHtno %>&ajDate=<%=ajDate %>&bxstate=<%=bxstate %>&gzstate=<%=gzstate %>&gtcz_date=<%=gtcz_date %>&gtsj_date=<%=gtsj_date %>&bank_person=<%=bank_person %>',350,320,100,100);" >修改</a>
   &nbsp;<a href="#" title="退件" onclick="if (confirm('确认退件吗？')){document.cus.banktj.value='<%=saleId %>';document.cus.cancelroom.value='<%=loft+room %>';document.cus.submit();}">退件</a>
  <%} %>
  </td>
    </TR>
    <%
   	}
   %>
  </TABLE>
  
  
 
<script>
function tidata(para){
		  if (para==""){alert("请选择左边项目");return false;}
		  openwin3("add_aj_data.jsp?section="+para,650,500,100,100);
		}
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
		 document.cus.action="AjListS.jsp?SecNo=<%= section%>&Loft=<%=loft  %>&Build=<%=building %>&ajstate="+para;
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
			openwin1("../customter/listcusdata.jsp?cusno="+cusno,500,520,100,5);
		}
		
		function SeeSale(roomNo) {
			// alert("a" + roomNo + "b") ;
			 openwin1("../sale/saleinfo1.jsp?secno=<%= section %>&secname=<%= secName %>&roomno=" + roomNo + "&build=<%= building %>&loft=<%= loft %>&show=true",600,500,100,10) ;
		}
		
		function aj1(){
		 if (confirm("确认打印吗？"))
		   openwin1("../sale/autoselect4.jsp?type=8",700,300,20,10);
		}
		function aj(){
		 if (confirm("确认打印吗？"))
		   openwin1("../sale/autoselect4.jsp?type=11",700,300,20,10);
		}	
  </script>
</BODY>
</HTML>
