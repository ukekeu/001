<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page import = "java.sql.*" %>
<%@ include file="../public_js/qx_checke.jsp"%>
<jsp:useBean id = "ajListBean" scope = "page" class = "ConnDatabase.SDatabase" />

<%
 
				
 String sel=(String)request.getParameter("sel");
 String chhosetype=(String)request.getParameter("chhosetype");
  
   if(sel==null) sel="1";				
   if(chhosetype==null) chhosetype="1";	

%>

<html>
<head>
<title>�����趨</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>

<body bgcolor="#FFFFFF" text="#000000">

<script language="javascript" src="../public_js/public.js">
</script>
<script>
  function submitValidate() {

    if (document.ajform.MonthTax.value==""){
	  alert("������������");
	  document.ajform.MonthTax.focus();
	  return false;
	}
     if (document.ajform.endmonthpay.value==""){
	  alert("������β�¹���");
	   document.ajform.endmonthpay.focus();
	  return false;
	}
	/*if (document.ajform.OneInterestSum.value==""){
	  alert("�����뱾Ϣ�ܶ�");
	  document.ajform.OneInterestSum.focus();
	  return false;
	}
	if (document.ajform.SumInterest.value==""){
	  alert("��������Ϣ�ܶ�");
	  document.ajform.SumInterest.focus();
	  return false;
	}*/
	
	if (document.ajform.MonthPay.value==""){
	  alert("�������¹�����");
	   document.ajform.MonthPay.focus();
	  return false;
	}
   return true;
  }
function save1(){
 if (submitValidate()){

   document.ajform.action="Aj_save.jsp?SaveData="+document.ajform.SaveData1.value;

   document.ajform.submit();
 
 }
 }
</script>
<form name="ajform" method="post"> 
<input type=hidden name=sel value="<%=sel%>">
<input type=hidden name=Type value="2">
<input type=hidden name=chhosetype value="<%=chhosetype%>">
<center>
<p align=center><b><font size=3>�����趨</font></b></p>
<%
 
String Cortrol=checke_qx(ajListBean,(String)session.getAttribute("loginid"),"B010");
   if (Cortrol==null)Cortrol="";
    if (Cortrol.indexOf("A")>=0){ %>
<table width="75%" border="0" cellpadding="1" cellspacing="1"> 
<tr>  <td class=roomleft>&nbsp;��������</td>
	 <td class=roomright>
<select name="Year">
 <%for (int i=1;i<=30;i++){
		out.print("<option value="+String.valueOf(i)+">"+String.valueOf(i)+"</option>");
		} %>  

</select>

 </td>
  <td class=roomleft>&nbsp;��&nbsp;��&nbsp;��</td>
  <td class=roomright> 
 <input type="text" name="MonthTax" size="15" onkeydown="key(document.ajform.YearTax)"  >(��) 
 </td>
 </tr>
 <tr>
 
 <td class=roomleft>&nbsp;���¹���</td>
 <td class=roomright> 
<input type="text" name="MonthPay" size="15" onkeydown="key(document.ajform.SumInterest)"  >(Ԫ)
 </td>

  <td class=roomleft>&nbsp;β�¹���</td>
 <td class=roomright>
	<input type="text" name="endmonthpay" size="15" onkeydown="key(document.ajform.bj)" >(Ԫ)</td>
  </tr>
 <tr>
  <td class=roomleft>&nbsp;����</td>
 <td class=roomright>
	<input type="text" name="bj" size="15" value=0 >(Ԫ)</td>
 </tr></table>
 <P align=center>
    	 
 <input type=button name=SaveData1 value="�� ��"  onclick="save1();"> 

 <input type=Reset name=cancel value="�� ��" > 
 <%} %>
 </p>
 </center>
 
 </form>

      <p align="center"><b><font size=3>���һ������ʶ��ձ�(����ԪΪ׼)</font></b></p>
   
   <table width="360" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.ajform.sel.value=1;document.ajform.chhosetype.value=0;document.ajform.action='AjList.jsp';document.ajform.submit();"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>��ҵ�Դ���</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.ajform.sel.value=2;document.ajform.chhosetype.value=1;document.ajform.action='AjList.jsp';document.ajform.submit();"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>���������</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.ajform.sel.value=3;document.ajform.chhosetype.value=2;document.ajform.action='AjList1.jsp';document.ajform.submit();"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�ȱ��𻹿�</font></a>
	</td>
	<td class="<%if(sel.equals("4")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.ajform.sel.value=4;document.ajform.chhosetype.value=3;document.ajform.action='AjList2.jsp';document.ajform.submit();"><font color='<%if(sel.equals("4")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�ȱ�Ϣ����</font></a>
	</td>
   </tr>
 </table>
<table width="100%" border="0" cellpadding="1" cellspacing="1">
  <tr class=TXTColor> 
 
    <td > 
      <div align="center">��������</div>
    </td>
    <td > 
      <div align="center">������(��)</div>
    </td>
   <!-- <td > 
      <div align="center">������</div>
    </td>
    <td > 
      <div align="center">��Ϣ�ܶ�</div>
    </td>
    <td > 
      <div align="center">��Ϣ�ܶ�</div>
    </td>
    -->
	<td > 
      <div align="center">����</div>
    </td>
    <td > 
      <div align="center">���¹���</div>
    </td>
	  <td > 
      <div align="center">β�¹���</div>
    </td>
    <td > 
      <div align="center">����</div>
    </td>
  </tr>
  
  <%!
	
	ResultSet ajRS = null;
	//int hasRecord��
	int id;
	int seq;
%>
  <%
  	String pageno = request.getParameter("pageNo");
	if (pageno == null) 
		pageno = "1";
	int pageNo = Integer.parseInt(pageno);
	int pageSize = 10;
	String hasNext = "N";
	int firstPos = (pageNo - 1) * pageSize + 1;
	int i = 0;
	
	String ajStr = "select id,year,MonthTax,bj,MonthPay,monthmoney from ajllgkb  where type="+chhosetype+" order by type,year";//where id >=" + String.valueOf(firstPos);
	ResultSet ajRS = ajListBean.executeQuery(ajStr);	
		 
	while (ajRS.next()) {// && i < pageSize)
		id = ajRS.getInt("id");
	
 %>
   <tr align="center" class=listcontent  onmouseout="mOut(this,'#e6f9ff');" onmouseover="mOvr(this,'#EAECEC');"  > 

     
    <td  >
      <div align="center"><%= ajRS.getInt("year") %> </div>
    </td>
    <td  >
      <div align="center"><%= ajRS.getFloat("MonthTax") %> </div>
    </td>
   <td  >
      <div align="center"><%= ajRS.getFloat("bj") %> </div>
    </td>
   <!--  <td  >
      <div align="center"><%//= ajRS.getFloat("OneInterestSum") %> </div>
    </td>
	<td  >
      <div align="center"><%//= ajRS.getFloat("SumInterest") %> </div>
    </td>
    -->
    <td  > 
	
      <div align="center"><%= ajRS.getFloat("MonthPay")%></div>
    </td>
	<td  > 
	
      <div align="center"><%= ajRS.getFloat("monthmoney")%></div>
    </td>
    <td   > 
      <div align="center">
	  <%  if (Cortrol.indexOf("D")>=0){ %>
        <a href="javascript:delAj('<%= id %>')" >ɾ��</a>
		<%} %>
		 </div>
    </td>
    <script>
		function delAj(id) {
			if (confirm("ȷʵҪɾ���ü�¼?"))
				window.location = "SaveAj.jsp?sel=3&chhosetype=2&aj_oper=dele&id=" + id;
		}
		
	</script>
  </tr>
 <%} %>
</table>
  
</p>
</body>
</html>
