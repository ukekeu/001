<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<HTML>
<HEAD>
<TITLE>����۸񷽰�����</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chrset=gb2312"> 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language=javascript src="../sale/js/mad.js"> </script>

</head>
  <%@ page import="java.sql.*, common.*,java.util.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
   <jsp:useBean id="setpro" scope="session" class="setProperty.setProperty"/>   
    <jsp:useBean id="FormtD1" scope="page" class="test.BarChartDemo"/>  
 
<%@ include file="../public_js/getByteOut.jsp"%>
<%  String SecName=China.getParameter(request,"SecName");
    String SecNo=request.getParameter("SecNo");
    String Loft=China.getParameter(request,"Loft");
	String Build=China.getParameter(request,"Build");
	String section = China.getParameter(request, "Section") ;
	// out.print(section) ;
	if (!section.equals(""))
		session.setAttribute("Advertise-Section", section) ;
	
	section = (String) session.getAttribute("Advertise-Section") ;
	if (section == null)
		section = "" ;
	
%><script>
	function submitv() {
		if (document.aform.Building.value == "") {
			alert("�����붰��");
			return false;
		}	
	}
	


</script>
<script language="javascript" src="../public_js/public.js">

</script>

<body>

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
<form name=frm action="PriceProjectList_xy.jsp" >
<input type=hidden name=SecNo value="<%=SecNo %>">
<input type=hidden name=Loft  value="<%=Loft %>">
<input type=hidden name=SecName  value="<%=SecName %>">
<input type=hidden name=Build  value="<%=Build %>">
<input type=hidden name=choose>

<% String sel=(String)request.getParameter("sel");
   if(sel==null) sel="0"; %>
   <body topmargin="1"  >
 
  <input type=hidden name="sel" value="<%=sel %>">
   <table width="180" border="0" cellspacing="0" cellpadding="0" class="L2">
   <tr>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=0;findSub('RoomSelect.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>��������</font> </a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=1;findSub('PriceProjectList_xy.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>����۸�</font></a>
	</td>	 
	</tr></table>
	<script>
function findSub(para){
   document.frm.action=para+"?Loft=<%=getbyte2(request.getParameter("Loft"))%>&SecNo=<%=getbyte2(request.getParameter("SecNo"))%>";
   document.frm.submit();
}
</script>
   <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
  
  <TR> 
    <TD COLSPAN="2" height=10></TD>
  </TR>
  <TR > 
      <TD width="42%">
       
    </TD>
    </TR>
</TABLE>
  <%@ include file="../public_js/qx_checke.jsp"%>
   
   <%!
   String Cortrol="";
   %>
   
   	 <%String SQL="select top 1 room_code from  room where seccode='"+SecNo+"' ";
	 if (!Loft.equals(""))SQL+="and loft='"+Loft+"'";
	 
 ResultSet rs = null;
 String room="A";
		 rs = bBean.executeQuery(SQL) ;
		if  (!rs.next()) {	
		room="";
		 
		}rs.close();
  String str="select payment from  �����Ŀ�� where paymenttype=1 and sectionno='"+SecNo+"' and loft='"+Loft+"' and payment='��������۸�'";
     int aaa=0;
		 rs = bBean.executeQuery(str) ;
		if  (rs.next()) {	aaa++;
		}
		rs.close();
Cortrol=checke_qx(aBean,(String)session.getAttribute("loginid"),"JC003");
   if (Cortrol==null)Cortrol="";
  if (!room.equals("")) { 
    %>
  
	    <table width=100%><tr height="16"  ><td align="right"> 
		  
		 <%if (Cortrol.indexOf("A")>=0){ %>
		 <input type=button name=pri value="��ԭ��ʵ�۸񷽰�����"  <%if (aaa>0)out.print("disabled"); %> onclick="AddP();" >
		<input type=button name=pri value="���ⶨ��"   onclick="Add();">
		<%} %>
	 
		</td></tr></table>

  <%  
  }else{out.print("�ڶ���ǰ����¼�뷿������");}
    int i = 0 ;
  		String sListName = "AdvertiseList" ;
		String sectionStr = "" ;
		if (!section.equals("") && !section.equals("All"))
			sectionStr = " and a.section = '" + section + "' " ;
		if (!Loft.equals(""))
			sectionStr += " and a.Loft = '" + Loft + "' " ;
		
	
		
  %>

  
    <%
   
	int id = 0,  unitPrice = 0, times = 0, totalPrice = 0 ;
	String type = "", name = "",time = "", spec = "", beginDate = "", finishDate = "" ;	
	int iK = 0 ,state=0;
	i=0;
	int iLost2 = 0 ;
	
	 %>
   <p align="center"><b><font size="3" color="#000080">��������۸񷽰�һ��</font></b></p>

   <table BORDER=0 width="100%"  CELLSPACING=1 CELLPADDING=3 ALIGN=center>
  <tr  class=TXTColor>
     
      <TD WIDTH="30%"> 
        <DIV ALIGN="CENTER">��������</DIV>
      </TD>
      <TD WIDTH="20%"  > 
        <DIV ALIGN="CENTER">����ʱ��</DIV>
      </TD>
       <TD WIDTH="30%" > 
        <DIV ALIGN="CENTER"> </DIV>
      </TD>
	    <TD WIDTH="20%" > 
        <DIV ALIGN="CENTER">����</DIV>
      </TD>
    </TR>
	<%  str="select payment,convert(varchar(10),date,120) date,state,checkstate,userstate from  �����Ŀ�� where paymenttype=1 and sectionno='"+SecNo+"' and loft='"+Loft+"' group by convert(varchar(10),date,120),payment,state,checkstate,userstate order by date";
 
		 rs = bBean.executeQuery(str) ;
		while (rs.next()) {	
		i++;
		 name = getbyte(rs.getString("payment"));
		String name1 = getbyte(rs.getDate("date").toString());		
		int states=rs.getInt("state");		
		int checkstate=rs.getInt("checkstate");
		int userstate=rs.getInt("userstate");
		 
   %>
    <tr  class='listcontent'id=TR<%=i %>  align="center"    onmouseover="mout(this);" onclick="ChangeTrColor(this, '<%= id %>', '<%= id %>', '<%= id %>', 'A6D3A6', 'f6f6f6');changeclass1(this,'clickbg','listcontent');"   > 
    
	  <TD WIDTH="30%" >
        <DIV ALIGN="CENTER"><%= name %></DIV>
      </TD>
      <TD WIDTH="20%"  > 
        <DIV ALIGN="CENTER"><%= name1 %></DIV>
      </TD>
      <TD WIDTH="30%"  > 
        <DIV ALIGN="CENTER">
		<%if (states==1)out.print("<font color=red>Ŀǰ���ü۸�</font>");
		 if (Cortrol.indexOf("C")>=0){  
		 %>
		<a href="#" onclick="openwin('print_Price_xy.jsp?SecNo=<%=SecNo %>&Loft=<%=Loft %>&Build=<%=Build %>&payment=<%=name  %>&state=<%=states %>')">����</a>
		<%} %>
		 <a href="#" onclick="openwin('xy_PriceListView.jsp?SecName=<%=SecName %>&SecNo=<%=SecNo %>&Loft=<%=Loft %>&Build=<%=Build %>&payment=<%=name  %>&state=<%=states %>')">Ԥ��</a>
		</DIV>
		 </TD>
	    <TD WIDTH="20%" > 
		<%if (checkstate==0&&states==0) {%>
			<a  href="#" onclick="ChangeTrColor(this, '<%= id %>', '<%= id %>', '<%= id %>', 'A6D3A6', 'f6f6f6');Modify();">��������</a>
    
		<%} %>
		 <%if (Cortrol.indexOf("E")>=0){ %>
		<a  href="#" onclick="ChangeTrColor(this, '<%= id %>', '<%= id %>', '<%= id %>', 'A6D3A6', 'f6f6f6');Modify();">�� ��</a>
      	 <%} %>
		 <%if (Cortrol.indexOf("D")>=0&&userstate==0){ %>
		<a href="#" onclick="openwin('delete_Price.jsp?SecNo=<%=SecNo %>&Loft=<%=Loft %>&Build=<%=Build %>&payment=<%=name  %>',10,10)">ɾ��</a>
	   <%} %>
      </TD>
    </TR>
    <%
 }
		
   %>
   </table>
   <%
     try{
     String pic="";
	   String picurl=SecNo;
	 
	Calendar calendar = Calendar.getInstance();
	String filename = String.valueOf(calendar.getTimeInMillis());	    
      str="select  payment,convert(numeric(9,0),str(avg(price1))) price,convert(varchar(10),date,120) date,state from  �����Ŀ�� where paymenttype=1 and sectionno='"+SecNo+"'  and ( building='"+Build+"'or building is null) ";
	 if (!Loft.equals("")){str+="and loft='"+Loft+"'";
	 str+="group by convert(varchar(10),date,120),payment,state order by date ";
	 pic=FormtD1.main1("D:/"+ request.getContextPath()+"/crmv9/jsp/picture/adjricefx"+filename+".jpg","����۸񷽰����۱仯����","����(Ԫ)","�۸񷽰����۱仯����",str,1,"Ԥ�۾���","","","");
     
	 }
	 else{
	  str="select  loft,convert(numeric(9,0),str(avg(xy_sumprice/area))) price  from  room where seccode='"+SecNo+"'  and ( building='"+Build+"'or building is null) group by loft order by loft ";
	pic=FormtD1.main1("D:/"+ request.getContextPath()+"/crmv9/jsp/picture/bdjricefx"+filename+".jpg","��¥�����ۼ۸�Աȷ���","����(Ԫ)","��¥�����ۼ۸�Աȷ���",str,1,"Ԥ�۾���","","","");

	 }
	 
	  
   %>
 
	<table width="100%" border="0"><tr><td align="center">
    <%if (!pic.equals("")){%>
	<img src="../picture/<%=pic%>">
	<%}%>
	
	</td></tr></table>
	<% }catch(Exception e){out.print(e.getMessage()+"����������¥�������а����˷�[¥]��[��]��");out.close();} %>
  </form>
  <script>
  	// set color and save value ;	
		var itemNo = "" ;   // roomNo
		var isOut = 0 ;   //rent or sale out
		var lastObject ;
		var ajMoneyStr ;
		function fxp(){
		openwin1('priceFX1.jsp?SecNo=<%=SecNo %>&Loft=<%=Loft %>&Build=<%=Build %>',500,400,100,100);
		
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
				alert("����ѡ��ͻ�") ;
			else 	
				window.open("AjDoc.jsp?AjId=" + itemNo + "&x=" + Math.random(), 'PopWindowAll', "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=" + top2 + ",left=" + left2 + ",width=" + width2 + ",height=" + height2) ;
		}
		
		function Flow() {
			top2 = (screen.availHeight - 500) / 2 ;
			left2 = (screen.width - 620) / 2  ;
			height2 = 480 ;
			width2 = 620 ;
			if (itemNo == "") 
				alert("����ѡ��ͻ�") ;
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
			window.location = "AdvertiseSearch.jsp?x=" + Math.random() ;
		}
		
		function SeeCustomer(cusno) {
			openwin("../customter/listcusdata.jsp?cusno="+cusno,500,520,100,5);
		}
		
		function SeeSale(roomNo) {
			// alert("a" + roomNo + "b") ;
			 openwin("../sale/saleinfo1.jsp?secno=<%= section %>&show=true",600,500,100,10) ;
		}
		
		function ChangeSection() {
			document.forms[0].submit() ;
		}
		function Add(strurl){
		  showx =800;//// screen.availWidth-100;  // + deltaX;
		  showy =500;// screen.availHeight-100; // + deltaY;
		  var arr=new Array(1);
		 	  
		  arr = window.showModalDialog("xy_PriceProjectInput.jsp?SecNo=<%=SecNo %>&Build=<%=Build %>&Loft=<%=Loft %>","","status:0;dialogWidth:"+showx+"px; dialogHeight:"+showy+"; dialogLeft:50px; dialogTop:10px; status:yes; directories:yes;scrollbars:yes;Resizable=yes; "  );
		  if(arr[0]!=0)document.frm.submit();
      }
		function Add2() {
			top2 = (screen.availHeight - 420) / 2 ;
			left2 = (screen.width - 500) / 2  ;
			height2 = 500 ;
			width2 = 600 ;
			openwin1("xy_PriceProjectInput.jsp?SecNo=<%=SecNo %>&Build=<%=Build %>&Loft=<%=Loft %>&x=" + Math.random(), width2,height2, top2 ,left2 ) ;
		}
		function AddP() {
			top2 = (screen.availHeight - 420) / 2 ;
			left2 = (screen.width - 500) / 2  ;
			height2 = 200 ;
			width2 =450 ;
			
			openwin1("In_xy_Price.jsp?SecNo=<%=SecNo %>&Loft=<%=Loft %>", width2,height2, top2 ,left2 ) ;
		}
		function Modify() {
			top2 = (screen.availHeight - 420) / 2 ;
			left2 = (screen.width - 500) / 2  ;
			height2 = 500 ;
			width2 = 600 ;
			if (itemNo == "") 
				alert("����ѡ�񷽰�") ;
			else 	
				window.open("xy_Tj.jsp?SecNo=<%=SecNo %>&Build=<%=Build %>&Loft=<%=Loft %>&AdvertiseId=" + itemNo + "&x=" + Math.random(), 'PopWindowAll', "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,top=" + top2 + ",left=" + left2 + ",width=" + width2 + ",height=" + height2) ;
		}
		function Delete() {
			top2 = (screen.availHeight - 420) / 2 ;
			left2 = (screen.width - 500) / 2  ;
			height2 = 400 ;
			width2 = 500 ;
			if (confirm("ȷ�Ϸ�����?")){
			if (itemNo == "") 
				alert("����ѡ�񷽰�") ;
			else
				window.open("PriceDelete.jsp?AdvertiseId=" + itemNo + "&Operation=Delete&x=" + Math.random(), 'PopWindowAll', "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=" + top2 + ",left=" + left2 + ",width=" + width2 + ",height=" + height2) ;
		    }		
		}
		
		function Finish() {
			top2 = (screen.availHeight - 420) / 2 ;
			left2 = (screen.width - 500) / 2  ;
			height2 = 400 ;
			width2 = 500 ;
			if (itemNo == "") 
				alert("����ѡ����") ;
			else
				window.open("AdvertiseFinish.jsp?AdvertiseId=" + itemNo + "&Operation=Insert&x=" + Math.random(), 'PopWindowAll', "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=" + top2 + ",left=" + left2 + ",width=" + width2 + ",height=" + height2) ;
		}
		
		function TongJi() {
			window.location = "AdvertiseTjSearch.jsp?section="+document.AdvList.Section.value+"&x=" + Math.random() ;
		}
		function PrintPrice(){
		 openwin("currPriceList.jsp?SecNo=<%=SecNo %>&Loft=<%=Loft %>&secname=<%=SecName %>",780,500,10,10);
		
		}
  </script>
</BODY>
</HTML>
