<%@ page contentType="text/html;charset=GBK" %>
  <%@ page import = "java.sql.*,common.*" %>
  <jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id = "changeListBean" scope = "page" class = "ConnDatabase.SDatabase" />
 <%@ include file="../public_js/checktime.jsp"%>
  <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<title>��������-�����ۺ�ͬ</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<script language="javascript" src="../public_js/public.js"></script>
 
 <body topmargin="0">
<form name="frm" method="post" action="alert.jsp"> 
 <%String sel=(String)request.getParameter("sel");
    if(sel==null) sel="0";	   %>
<table width="420" border="0" cellspacing="0" cellpadding="0" class="L2" >
  
<tr  valign="top">
 <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=0;findSub('new_alert.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>���³ɽ�</font></a>
	</td>
    <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('alert.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>��������</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;findSub('alertmess.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�˷�����</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=3;findSub('moneychargealert.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�����Ż�</font></a>
	</td>
	 <td class="<%if(sel.equals("4")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=4;findSub('SKCustomer.jsp');"><font color='<%if(sel.equals("4")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�߿�����</font></a>
	</td>
<input type=hidden name=sel value="<%=sel%>">
</table>
<script>
function findSub(para){   
   document.frm.action=para;
   document.frm.submit();
}
 function yingshi( contractno , cusno ,roomcode) {
    openwin("yingshi.jsp?contractno=" + contractno + "&cusno=" + cusno+"&ldroomcode="+roomcode ,700,450,50,50);
  } 
</script>
 
<p align="center" class=FontColor><font size=3><b> ���³ɽ���ϸ</font></b></p>
 

<table width="100%" border="0" CELLPADDING="1" CELLSPACING="1"> 
<tr class=TXTColor  align="center">
  <td   align="center"   >���</td>
 <td><DIV ALIGN="CENTER">�����</DIV></td>
 <td><DIV ALIGN="CENTER">�������</DIV></td>
 <td><DIV ALIGN="CENTER">�ɽ��ܼ�</DIV></td>
  <td><DIV ALIGN="CENTER">�ͻ�����</DIV></td>
   <td><DIV ALIGN="CENTER">��ϵ�绰</DIV></td>
   <td><DIV ALIGN="CENTER">�Ϲ�����</DIV></td>
  <td><DIV ALIGN="CENTER">���ʽ</DIV></td>
  <td><DIV ALIGN="CENTER">����Ա</DIV></td>
<%
	String changeStr = "select    a.code roomcode,b.payment1,b.customer,b.code,d.cus_name,b.rmbprice ,b.jzarea,b.sectionname+b.loft+b.room_no room,d.phone+' '+d.sj phone,b.seller,convert(char(10),b.date,120) date from room a ,order_contract b,customer d where a.seccode+a.loft+a.room_code=b.section+b.loft+b.room_no and  b.state<>3 and datediff(d,b.date,getdate()) <=5 and b.customer=d.SerialNo      "
                     
                      + " order by b.date desc";
				 
    String secno="";
 
	String order_code="";
	 
    ResultSet changeRS1 = null;
	try{
	changeRS1 = changeListBean.executeQuery(changeStr);	
	 
	int i=0;
	while (changeRS1.next()) {
		 
		 i++;
		 String ldroomcode=changeRS1.getString("roomcode");
		 String payment1=changeRS1.getString("payment1");
		 String customer=changeRS1.getString("customer");
		 
		 
		 
		 String   cusname=getbyte(changeRS1.getString("cus_name"));
		 order_code=getbyte(changeRS1.getString("code"));
		 
		 String room = changeRS1.getString("room"); 
		 String sumprice = changeRS1.getString("rmbprice"); 
		 String jzarea= changeRS1.getString("jzarea"); 
		 String phone= changeRS1.getString("phone"); 
         String seller = changeRS1.getString("seller");
		 String date=getbyte(changeRS1.getString("date")); 

 %> <b>
  <tr id=TR<%=i %>  align="center"  class='listcontent'   ondblclick="yingshi('<%= order_code%>','<%= customer %>','<%=ldroomcode %>');"   onmouseover="mout(this) ;changeclass1(this,'clickbg','listcontent');"  title="˫�����Ե���������ϸ" >
  <td  ><%=i %></td><td><%= room%></td>
<td><%=jzarea %></td>
<td><%=sumprice %></td>
<td><%= cusname %></td>
<td><%= phone %></td>
<td><%= date %></td>

 <td><%=payment1 %></td>
 <td><%= seller %></td>
</tr>
</b> 
<%
  	}
	changeRS1.close();
	}catch(Exception e){}
  %>

</form> 
</body>
</html>
