<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<title>���ø����</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel=stylesheet href="../class/mad.css" >
<link rel=stylesheet href="../class/news.css" >
</head>
<script src="js/mad.js"> </script>
<script>
	function deletePayment() {
	  	document.cus.payment_oper.value = "dele";
		
		return false;
	  }
	function fulldate(){
	 var dateValue=new Date();
	 var year="";
	 var month="";
	 var day="";
	 if (dateValue.getMonth()+1>=10)month=dateValue.getMonth()+1;
	 else month="0"+(dateValue.getMonth()+1);
	 if (dateValue.getDate()+1>=10)day=dateValue.getDate();
	 else day="0"+(dateValue.getDate());
	 
	   document.cus.Date1.value=dateValue.getYear()+"-"+month+"-"+day;
	}
	
	
  function Validate()
   {
      if (parseFloat(document.cus.Discont.value)<=0) {alert("��¼���ۿ�");document.cus.Discont.focus();return false;}
        var dic_arr=document.cus.Discont.value.split("*");
	  
	   var disn=1;
	   for (var dd=0;dd<dic_arr.length;dd++){
	         disn=disn*100;
			 if (isNaN(dic_arr[dd])){alert("�ۿ�������");document.cus.Discont.focus();return false;}
			 if (parseFloat(dic_arr[dd])<=0){alert("�ۿ�������");document.cus.Discont.focus();return false;}
	   	   }
	  if (eval(document.cus.Discont.value)/disn*100>100) {alert("��¼����ȷ�ۿۣ��ۿ������ܴ���100");document.cus.Discont.focus();return false;}
       if (eval(document.cus.Discont.value)/disn*100<90) {if (!confirm("��Ķ����ۿ�Ϊ��"+document.cus.Discont.value+"����������ȷ��"))return false;}
    
	   return true;
   }
	  
</script>




<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
<%@ page import="java.sql.*;" %>   
<jsp:useBean id="paymentDetailBean" scope="page" class="ConnDatabase.SDatabase" /> 
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <%@ include file="../public_js/CheckSection.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
<%!
     //int id;
   	 String payName;
	 String discont;
	 int  prePay;
	 String paynum="";
	 String CurryType="";
  %> <%
  		String paymentStatus = request.getParameter("payment_status");
		if (paymentStatus == null) 
			paymentStatus = "insert";
		session.setAttribute("payment_o_status",paymentStatus);
 %> <script>	  
	  function submitValidate() {
	  	var paymentStatus = "<%= paymentStatus %>";
	
	  	payName = document.cus.PayName.value;
		PayNum = document.cus.PayNum.value;
		discont = document.cus.Discont.value;
		var cs= document.cus.cs.value;
		//prePay = document.cus.PrePay.value;
        Date2 = document.cus.Date2.value;
		Date1 = document.cus.Date1.value;
		 
		if (payName.indexOf(".")>=0||payName.indexOf("%")>=0||payName.indexOf("-")>=0||payName.indexOf("*")>=0||payName.indexOf("(")>=0||payName.indexOf("g")>=0||payName.indexOf("z")>=0||payName.indexOf("#")>=0){
		 alert("������������зǷ��ַ�");
		 return false;
		}
		if (payName.indexOf("����")>=0&&cs==""){
		 alert("�����밴�ҳ���");
		 return false;
		}
		if (PayNum.length == 0) {
			alert("�����븶������");
			document.cus.PayNum.focus();
			return false;
		}
		if (isNaN(PayNum)) {
			alert("������������Ϊ����");
			document.cus.PayNum.focus();
			return false;
			
		}		
		if (Date2.length == 0) {
			alert("����������");
			document.cus.Date2.focus();
			return false;
	    }
		
		if (Date1.length == 0) {
			alert("����������");
			document.cus.Date1.focus();
			return false;
	    }
		
		if (discont.length == 0) {
			alert("�������ۿ�");
			document.cus.Discont.focus();
			return false;
		}
		/*
		if (isNaN(discont)) {
			alert("�ۿ��������");
			document.cus.Discont.focus();
			return false;
			
		}else{
		   if (parseInt(discont)>100)
		   {alert("�ۿ�������ܴ���,ӦС�ڻ����100");
		 //  document.cus.Discont.focus();
		   //return false;
		   }
		   
		}
       */		
		if (paymentStatus == "modi")
	  			if (!confirm("ȷʵҪ���ĸü�¼?"))
					return false;	
		if (paymentStatus == "insert")
	  		if (!confirm("ȷʵҪ��Ӹü�¼?"))
				return false;		
	  
	  	  	return true;
	  }
	   function ChoosePay(){
	  var pay=document.cus.PayName.value;
	  if (pay.indexOf("��")>=0){
		 document.cus.AJdate.value=10;
		 document.cus.cs.disabled=false;
	  }else{
	     document.cus.AJdate.value=0;
		 document.cus.cs.disabled=true;
	  }
	 }
	 
function checkedOrderNoExist(){
    if (document.cus.PayName.value=="")return false;
    for (var i=0;i<OrderNo.length;i++){
	    if (document.cus.PayName.value==OrderNo[i]){
		 alert("�˸���������Ѿ�ʹ��");
		 document.cus.PayName.focus();
		 return false;
		}
	
	}
 
 
 }
</script> 

   <%

 		
		String id = request.getParameter("id");
		String exDate=""; ;
		String enDate="" ;
		String bank="";
		String year="";
        String cs="";
		String Qdate="";
		String AJDate="";
		String datetype="";
		String datetype1="";
		String gddate="";
		String section="";
		String youhui="";
		String bak="";
		if (paymentStatus != null && paymentStatus.equals("modi")) {
			String paymentStr = "select * from payment where id =" + id;
			ResultSet paymentRS = paymentDetailBean.executeQuery(paymentStr);
			paymentRS.next();
			//section= getbyte(paymentRS.getString("seccoe"));
		    payName = getbyte(paymentRS.getString("payName"));
			if (payName.indexOf("��")>=0){

			//bank=payName.substring(payName.indexOf("(")+1,payName.indexOf("."));
			//year=payName.substring(payName.indexOf("��")+1,payName.indexOf("��"));
			
			cs=payName.substring(payName.indexOf("(")+1,payName.indexOf("%"));
			
			payName=payName.substring(0,payName.indexOf("("));
			}
			
			paynum= paymentRS.getString("num");
			exDate = paymentRS.getString("ExDate");
			if (exDate.indexOf(" ")>0)exDate=exDate.substring(0,exDate.indexOf(" "));
			enDate  = paymentRS.getString("EnDate");
			if (enDate.indexOf(" ")>0)enDate=enDate.substring(0,enDate.indexOf(" "));
			discont = paymentRS.getString("Discont");
		 	prePay   = paymentRS.getInt("PrePay");
			Qdate = paymentRS.getString("Qdate");
			AJDate = paymentRS.getString("Ajdate");
			gddate=getbyte(paymentRS.getString("gddate"));
			youhui=getbyte(paymentRS.getString("youhui"));
			bak=getbyte(paymentRS.getString("bak"));
			paymentRS.close();
		}	
		String SQL="SELECT payment1 FROM ORDER_CONTRACT WHERE  section='"+request.getParameter("no")+"' and payment1 LIKE '%"+payName+"%'";
		ResultSet RS = paymentDetailBean.executeQuery(SQL);
		String exist="";
		if (RS.next()){
		exist="readonly title='�˷����ѱ�����,�����޸�����'";
		
		}
		RS.close();
		if (gddate.equals(""))datetype="checked";
		else datetype1="checked";
  %> <Script>
  		function loadPayment() {
			paymentStatus = "<%= paymentStatus %>";
			//alert("load");
			if (paymentStatus == "modi") {
				document.cus.Date1.value="<%=exDate %>";
				document.cus.Date2.value="<%=enDate %>";
				//setSelectMad(document.cus.bank,"<%=bank %>")
				//setSelectMad(document.cus.year,"<%=year %>")
				//setSelectMad(document.cus.cs,"<%=cs %>")
				<%if (!cs.equals("")) {%>
				//document.cus.bank.disabled=false;
				//document.cus.year.disabled=false;
				document.cus.cs.disabled=false;
				<%} %>
			}
			document.cus.PayName.focus();
		}
		function SavePayment(){
		
        if (submitValidate())
			{
		      document.cus.action="SavePayment.jsp"
			 document.cus.submit();

			}

		}
	 
  </script>
  <body   onload="fulldate();loadPayment();setSelectMad(document.cus.section,'<%=request.getParameter("no")%>');">
<p align=center class=FontColor><font size=3 ><b>�����</b></font></p>
<center>
<form name="cus" method="post" action="" > 

<input  type=hidden name="payment_oper" value=<%= session.getAttribute("payment_o_status") %>> 
<input  type=hidden name="id" value=<%= id %>>
 <table width="100%"  CELLSPACING=1 CELLPADDING=1 ALIGN=center >
 <tr> <td width="35%" class=roomleft>&nbsp;&nbsp;¥�����ƣ�</td><td width="65%" class=roomright>&nbsp;<select name="section" > 
   <option></option>
   
<%  

	  if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql1="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";

	  ResultSet rs2=paymentDetailBean.executeQuery(sql1);	
	  String sec="";
	  String no1="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
	 //// if (!no1.equals(""))defaultNo=no1;
	    rs2.close();
	
     %> </select>


		 </td></tr> 
<tr> <td width="35%" class=roomleft>&nbsp;&nbsp;�������ƣ�</td><td width="65%" class=roomright> <% 
		if (paymentStatus.equals("modi")) {
	%>&nbsp;<input type=text name="PayName" onchange="ChoosePay();" <%=exist %> value=<%=payName %> onBlur="checkedOrderNoExist();"  >(��:���а���)
<%
		}
		else {
	%>&nbsp;<input type=text name="PayName" onchange="ChoosePay();" onBlur="checkedOrderNoExist();" >(��:���а���)

	 <%
		}
	%> </td></tr> 
	<tr> <td width="35%" class=roomleft>&nbsp;&nbsp;���ҳ�����</td>
	<td width="65%" class=roomright title="ֻΪ����������а���'����'������������">
		<%if (paymentStatus.equals("modi")) {
	%>&nbsp;<input type=text name=cs size=15 disabled maxlength="3" <%=exist %> value="<%=cs %>" title="ֻΪ����������а���'����'������������">%(ΪС�ڵ���100������)
		 <%
		}
		else {
	%> &nbsp;<input type=text name="cs"  size=15  maxlength="3" title="ֻΪ����������а���'����'������������">%(ΪС�ڵ���100������)
 

	 <%
		}
	%>
    </td></tr>
	<!--<tr> <td width="35%" class=roomleft>&nbsp;&nbsp;�������У�</td><td width="65%" class=roomright>
	&nbsp;<select name=bank disabled>
	 <option></option>
	 <option value="����">����</option>
	 <option value="����">����</option>
	 <option value="����">����</option>
	 <option value="ũ��">ũ��</option>
	 <option value="����">����</option>
     </select>
	 <select name=year disabled>
	 <option></option>
	 <%for (int i=1;i<=30;i++){ %>
	 <option value=<%=i %>><%=i %>��</option>
	 <%} %>
	 </select>
	 	 <select name=cs disabled>
		 <option></option>
	 <%for (int i=1;i<=10;i++){ %>
	 <option value=<%=i %>><%=i %>��</option>
	 <%} %>
	 </select>
    </td></tr>	 
	-->
	<tr> <td width="35%" class=roomleft>&nbsp;&nbsp;����������</td><td width="65%" class=roomright> <% 
		if (paymentStatus.equals("modi")) {
	%> &nbsp;<input type="text" name="PayNum" size="15" maxlength="2" value="<%=paynum %>" onkeydown="key(document.cus.cale)"> (ΪС�ڵ���10������)
<%
		}
		else {
	%> &nbsp;<input type="text" name="PayNum" size="15" maxlength="2" onkeydown="key(document.cus.cale)"> (ΪС�ڵ���10������)<%
		}
	%> </td></tr> <tr> <td width="35%" class=roomleft>&nbsp;&nbsp;ִ�����ڣ�</td><td width="65%" class=roomright><% 
		if (paymentStatus.equals("modi")) {
	%>      &nbsp;<INPUT TYPE=TEXT NAME=Date1 size=12><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;"></td>
    <%
		}
		else {
	%>     &nbsp;<INPUT TYPE=TEXT NAME=Date1 size=12><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;"></td>
    <%
		}
	%> </td></tr> <tr> <td width="35%" class=roomleft>&nbsp;&nbsp;�������ڣ�</td><td width="65%" class=roomright>
	<% 
		if (paymentStatus.equals("modi")) {
	%>      &nbsp;<INPUT TYPE=TEXT NAME=Date2 size=12><input type=button name=cale2 value=".." onclick="fPopUpCalendarDlg(Date2);return false;"></td>
    <%
		}
		else {
	%>     &nbsp;<INPUT TYPE=TEXT NAME=Date2 size=12><input type=button name=cale2 value=".." onclick="fPopUpCalendarDlg(Date2);return false;"></td>
    <%
		}
	%> 
	 </td></tr> 
	  <tr> <td width="35%" class=roomleft>&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��</td><td width="65%" class=roomright> <% 
		if (paymentStatus.equals("modi")) {
	%> &nbsp;<input type="text" size=15 name="PrePay" maxlength="10" value="<%= prePay %>" onkeydown="key(document.cus.Discont)">Ԫ(��д0��ʾ���������) 
<%
		}
		else {
	%> &nbsp;<input type="text" size=15 name="PrePay" maxlength="10" onkeydown="key(document.cus.Qdate)" value="20000">Ԫ(��д0��ʾ���������) <%
		}
	%> </td></tr> 
	 <tr> <td width="35%" class=roomleft>&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;�ۣ�</td><td width="65%" class=roomright> <% 
		if (paymentStatus.equals("modi")) {
	%> &nbsp;<input type="text" size=15 name="Discont"  onblur="Validate();" maxlength="10"  value="<%= discont %>" onkeydown="key(document.cus.youhui)">% 
<%
		}
		else {
	%> &nbsp;<input type="text" size=15 name="Discont" onblur="Validate();" maxlength="10" onkeydown="key(document.cus.youhui)" value="100">% <%
		}
	%> (����10������������99)</td></tr> 
	  <tr> <td width="35%" class=roomleft>&nbsp;&nbsp;չ���Żݣ�</td><td width="65%" class=roomright> <% 
		if (paymentStatus.equals("modi")) {
	%> &nbsp;<input type="text" size=15 name="youhui" maxlength="10" value="<%= youhui %>" onkeydown="key(document.cus.Discont)">Ԫ 
<%
		}
		else {
	%> &nbsp;<input type="text" size=15 name="youhui" maxlength="10" onkeydown="key(document.cus.Qdate)" value="0">Ԫ <%
		}
	%> </td></tr> 
	
	<tr> <td width="35%" class=roomleft>&nbsp;&nbsp;ǩԼ���ڣ�</td><td width="65%" class=roomright> <% 
		if (paymentStatus.equals("modi")) {
	%><input type="radio" name="datetype" value="0" <%=datetype %> onclick="document.cus.gddate.value=''" >�Ϲ���<input type="text" size=8 name="Qdate" maxlength="5" value="<%=Qdate %>" >��<br>
<input type="radio" name="datetype" value="1" onclick="document.cus.Qdate.value=0" <%=datetype1 %> >�̶�����<input type=text size=10 name=gddate value="<%=gddate %>"><input type=button name=cale1 value=".." onClick="fPopUpCalendarDlg(gddate);return false;" title="��ѡ���Ϲ�����">   
<%
		}
		else {
	%> &nbsp;<input type="radio" name="datetype" value="0" onclick="document.cus.gddate.value=''" checked> �Ϲ���<input type="text" size=8 name="Qdate" maxlength="2"  value="7">��<br>
	&nbsp;<input type="radio" name="datetype" value="1" onclick="document.cus.Qdate.value=0" > �̶����ڣ�<input type=text size=10 name=gddate><input type=button name=cale1 value=".." onClick="fPopUpCalendarDlg(gddate);return false;" title="��ѡ���Ϲ�����">  <%
		}
	%> </td></tr> 
	<tr> <td width="35%" class=roomleft>&nbsp;&nbsp;�������ڣ�</td><td width="65%" class=roomright> <% 
		if (paymentStatus.equals("modi")) {
	%> &nbsp;ǩԼ��<input type="text" size=8 name="AJdate" maxlength="5" value="<%=AJDate %>">�� 
<%
		}
		else {
	%> &nbsp;ǩԼ��<input type="text" size=8 name="AJdate" maxlength="5" onkeydown="key(document.cus.PrePay)" value="0">�� <%
		}
	%> </td></tr> 
	<tr> <td width="35%" class=roomleft>&nbsp;&nbsp;������ע��</td><td width="65%" class=roomright> <% 
		if (paymentStatus.equals("modi")) {
	%> &nbsp;<input type="text" size=40  name="bak"  value="<%=bak %>">
<%
		}
		else {
	%> &nbsp;<input type="text" size=40 name="bak"  onkeydown="SavePayment();" value=""><%
		}
	%> </td></tr> 
	</table>
	<p align=center>
<INPUT TYPE="button" NAME="Submit2" VALUE="��  ��" ONCLICK="SavePayment()">&nbsp;<!--<INPUT TYPE="button" NAME="Submit2" VALUE="��  ϸ" ONCLICK="javascript:detail()">-->&nbsp;<INPUT TYPE="button" NAME="Submit3" VALUE="��  ��" onclick="window.close();"></form>
</center>
<script>
 function detail(){
   window.location="PayList.jsp?paycode=<%=id%>&payname=<%=payName%>&paynum=<%=paynum%>&cs=<%=cs%>&prePay=<%=prePay%>";
 
 }
</script>
<%
 String paymentSQL="";
 if (paymentStatus.equals("modi")) {
 paymentSQL="select PayName from payment where payName<>'"+payName+"' and seccoe='"+request.getParameter("no")+"'";
}else{
 paymentSQL="select PayName from payment where seccoe='"+request.getParameter("no")+"'";


}
try{
 ResultSet RateRs=paymentDetailBean.executeQuery(paymentSQL);
 
  out.print("<script>");
  out.print("var OrderNo=new Array();");
  int iii=0;
   while (RateRs.next()){
     out.print("OrderNo["+String.valueOf(iii)+"]="+"\""+getbyte(RateRs.getString("PayName"))+"\""+";");
	 iii++;
      }	 
	  RateRs.close();
}catch(Exception s){  out.print(s.getMessage());out.close();}

out.print("</script>"); %>
<script>
 //setSelectMad(document.cus.section,'<%=request.getParameter("no")%>');

</script>
</body>
</html>
