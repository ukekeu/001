<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
  <%@ page import = "java.sql.*,common.*" %>
  <jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id = "changeListBean" scope = "page" class = "ConnDatabase.SDatabase" />

  <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<title>财务提醒</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<script language="javascript" src="../public_js/public.js"></script>
<script language=javascript src="js/mad.js"> </script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
 <bod   topmargin="1"   >
<form name="frm" method="post" action="alert.jsp"> 
 <%String sel=(String)request.getParameter("sel");
    if(sel==null) sel="1";	   %>
<table width="270" border="0" cellspacing="0" cellpadding="0" class="L2" >
  
<tr  valign="top">
    <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('alert.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>换房提醒</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;findSub('alertmess.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>退房提醒</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=3;findSub('moneychargealert.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>总价变化</font></a>
	</td>
	 
<input type=hidden name=sel value="<%=sel%>">
</table>
<script>
function findSub(para){   
   document.frm.action=para;
   document.frm.submit();
}
 function yingshi( contractno , cusno ) {
    openwin1("yingshi.jsp?contractno=" + contractno + "&cusno=" + cusno ,660,450,50,50);
  } 
</script>
 
<p align="center" class=FontColor><font size=3><b> 最新优惠合同</font></b></p>
 

<table width="100%" border="0" CELLPADDING="1" CELLSPACING="1"> 
<tr class=TXTColor  align="center">
  <td     > 序号</td>
 <td>房间</td>
 <td>认购价格</td>
   <td>认购日期</td>
   
  <td>客户姓名</td>
 
   
 <td>优惠日期</td>
  <td>优惠后价格</td>
 
     <td>优惠金额</td>
	 </tr>
 
<%
	String changeStr = "select b.date,b.sectionname,b.section,b.customer,b.loft,b.building,b.room_no,b.code,d.cus_name,c.yrmbprice,c.rmbprice ,c.yrmbprice-c.rmbprice c_price,c.change_date from order_contract b,order_contract_log c ,customer d where c.yrmbprice>0 and b.code=c.order_contract and datediff(d,c.change_date,getdate()) <=5 and b.customer=d.SerialNo and b.code=c.order_contract order by c.change_date desc  ";
	 
    String secno="";
	String customer="";
	String cusname="";
	String order_code="";
	String section="",checker="",Note="",person="";
	String Loft="",building ="",OldRoom ="",NowRoom ="",ChangeDate ="",rgDate="";
	String newloft="",newbuild="";
      ResultSet changeRS1 = null;
	try{
	changeRS1 = changeListBean.executeQuery(changeStr);	
	 
	int i=0;
	while (changeRS1.next()) {		 
		 i++;
		 String sectionname=changeRS1.getString("sectionname");
		 customer=changeRS1.getString("customer");
		 cusname=getbyte(changeRS1.getString("cus_name"));
		 order_code=getbyte(changeRS1.getString("code"));		 
		 section = getbyte(changeRS1.getString("Section"));
		 Loft =getbyte(changeRS1.getString("Loft"));
		  NowRoom =getbyte(changeRS1.getString("room_no"));
		 building = getbyte(changeRS1.getString("building"));	 
         ChangeDate = changeRS1.getString("change_date");		
		  rgDate = changeRS1.getString("date");	 
		String c_price=getbyte(changeRS1.getString("c_price"));
		String yrmbprice=getbyte(changeRS1.getString("yrmbprice"));
		String rmbprice=getbyte(changeRS1.getString("rmbprice"));
		
 %>  
  <tr id=TR<%=i %>  align="center"  class='listcontent'   ondblclick="yingshi('<%= order_code%>','<%= customer %>');"   onmouseover="mout(this) ;changeclass1(this,'clickbg','listcontent');"  title="双击可以弹出交款明细" >
  <td    ><%=i %></td>
<td > <%=sectionname+ Loft+NowRoom%></td>
 <td > <%=yrmbprice%></td>
 <td><%= rgDate.substring(0,rgDate.indexOf(" ")) %></td>
 
<td><a href="#" onclick="openwin('../customter/editcustomer.jsp?cusno=<%=customer %>',500,600,10,30)"><%=cusname %></td>
<td><%= ChangeDate.substring(0,ChangeDate.indexOf(" ")) %></td>
 <td><%= rmbprice %></td>
<td><%= c_price %></td>
 
</tr>
 
<%
  	}
	changeRS1.close();
	}catch(Exception e){}
  %>

</form> 
</body>
</html>
