<html>
<head>
<title>��������</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<script language="javascript" src="../public_js/public.js"></script>
<script language=javascript src="js/mad.js"> </script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
 
  <%@ page contentType="text/html;charset=GBK" %>
   <%@ include file="../public_js/checktime.jsp"%>
  <%@ page import = "java.sql.*,common.*" %>
  <jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id = "changeListBean" scope = "page" class = "ConnDatabase.SDatabase" />

  <%@ include file="../public_js/getByteOut.jsp"%>
<bod   topmargin="1"   >
<form name="frm" method="post" action="alert.jsp"> 
 <%
	
 
	 
%>
<%String sel=(String)request.getParameter("sel");
    if(sel==null) sel="1";	   %>
<table width="270" border="0" cellspacing="0" cellpadding="0" class="L2" >
  
<tr  valign="top">
    <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('alert.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>��������</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;findSub('alertmess.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�˷�����</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=3;findSub('moneychargealert.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�ܼ۱仯</font></a>
	</td>
	 
<input type=hidden name=sel value="<%=sel%>">
</table>
<script>
function findSub(para){   
   document.frm.action=para;
   document.frm.submit();
}
 function yingshi( contractno , cusno ) {
    openwin("yingshi.jsp?contractno=" + contractno + "&cusno=" + cusno ,660,450,50,50);
  } 
  
</script>
 
<p align="center" class=FontColor><font size=3><b> �����˷���ϸ</font></b></p>
 

<table width="100%" border="0" CELLPADDING="1" CELLSPACING="1"> 
<tr class=listtitle align="center">
  <td >���</td>
  <td> �Ϲ�����</td>
 <td> �˶��������</td>
 <td> �ͻ����� </td>
 <td> ������� </td>
  <td> �˷���� </td>
 <td> �˶����� </td>
 <td> �˶�ԭ�� </td>
  <td> ������ </td>
 <td> ������ </td></tr> <%
	String changeStr = "select  a.* ,c.cus_name,b.date,b.code from TFRecord a ,order_contract b,customer c,MessageHF d"
	                  +" where datediff(d,a.tf_date,getdate())<=5 and b.code=d.order_contract and a.secno+a.loft+a.room =b.section+b.loft+b.room_no and a.customer=c.SerialNo and b.state=3  and b.customer=c.SerialNo  "
					 
					
                      + " order by a.tf_date desc";
		   
    float jzarea=0;
	String secno="";
	String customer="";
	String cusname="";
	String order_code="";
    String sumprice="",Note="",person="",checker="";
    String section="",Loft="",building ="",Room_code="",CancelDate ="";
       ResultSet changeRS1 = null;
	try{
	changeRS1 = changeListBean.executeQuery(changeStr);	
	 
	int i=0;
	while (changeRS1.next()) {
		 
		 i++;
		 secno=changeRS1.getString("secno");
		 
		 cusname=getbyte(changeRS1.getString("cus_name"));
		 
		 section = getbyte(changeRS1.getString("section"));
		 Loft =getbyte(changeRS1.getString("Loft"));
		 building = getbyte(changeRS1.getString("Building"));
		 Room_code = changeRS1.getString("room"); 
		 jzarea = changeRS1.getFloat("jzarea");
		 sumprice = changeRS1.getString("sumprice");
	     CancelDate = changeRS1.getString("tf_date");
		 Note = getbyte(changeRS1.getString("context"));
		 person=getbyte(changeRS1.getString("person"));
		 checker=getbyte(changeRS1.getString("checker"));
		 String date=changeRS1.getDate("date").toString();
		 order_code=getbyte(changeRS1.getString("code"));

 %> <b>
 <tr id=TR<%=i %>  align="center"  class='listcontent' onclick="changeclass1(this,'clickbg','listcontent');" ondblclick="yingshi('<%= order_code%>','<%= customer %>');"   onmouseover="mout(this) ;changeclass1(this,'clickbg','listcontent');"  title="˫�����Ե���������ϸ" >
   <td    ><%=i %></td>
    <td    ><%=date%></td>
<td ><a href="#" onclick="openwin('../sale/td_hf_list.jsp?secno=<%=secno %>&roomno=<%=Room_code%>&loft=<%=Loft %>&build=<%=building%>&show=true&ftyy=<%=Note %>&checker=<%=checker %>&customer=<%=customer %>&order_code=<%=order_code %>',500,600,10,30)"><%=Loft+building+Room_code%></td>
<td><a href="#" onclick="openwin('../customter/editcustomer.jsp?cusno=<%=customer %>','')"><%=cusname %></td>
<td ><%=jzarea%></td>
<td><%= sumprice%></td>
<td><%= CancelDate.substring(0,10) %></td>
<td><%= Note %></td>
<td><%= person %></td>
<td><%= checker %></td>
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
