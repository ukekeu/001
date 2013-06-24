<%@ page contentType="text/html;charset=GBK" %>
  <%@ page import = "java.sql.*,common.*" %>
  <jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id = "changeListBean" scope = "page" class = "ConnDatabase.SDatabase" />
 <%@ include file="../public_js/checktime.jsp"%>
  <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<title>财务提醒</title>
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
	  <a href="#" onclick="document.frm.sel.value=0;findSub('new_alert.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>最新成交</font></a>
	</td>
    <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('alert.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>换房提醒</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;findSub('alertmess.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>退房提醒</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=3;findSub('moneychargealert.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>额外优惠</font></a>
	</td>
	 <td class="<%if(sel.equals("4")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=94 height=21>
	 <a href="#" onclick="document.frm.sel.value=4;findSub('SKCustomer.jsp');"><font color='<%if(sel.equals("4")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>催款提醒</font></a>
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
 
<p align="center" class=FontColor><font size=3><b> 最新换房明细</font></b></p>
 

<table width="100%" border="0" CELLPADDING="1" CELLSPACING="1"> 
<tr class=TXTColor  align="center">
  <td   align="center"   ><font color=white>序号</font></td>
 <td><DIV ALIGN="CENTER">现房间代码</DIV></td>
  <td><DIV ALIGN="CENTER">原房间代码</DIV></td>
  <td><DIV ALIGN="CENTER">客户姓名</DIV></td>
   <td><DIV ALIGN="CENTER">认购日期</DIV></td>
 <td><DIV ALIGN="CENTER">换房日期</DIV></td>
 <td><DIV ALIGN="CENTER">换房原因</DIV></td>
  <td><DIV ALIGN="CENTER">换房面积差</DIV></td>
    <td><DIV ALIGN="CENTER">换房总价差</DIV></td>
  <td><DIV ALIGN="CENTER">经办人</DIV></td>
 <td><DIV ALIGN="CENTER">审批人</DIV></td></tr> 
<%//MessageHF c ,
	String changeStr = "select   a.*,b.code,d.cus_name,a.sumprice-a.oldprice c_price,a.jzarea-a.oldarea c_area from ChangRoomR a ,order_contract b,customer d where datediff(d,a.ChangeDate,getdate()) <=5 and b.customer=d.SerialNo  and b.sectionname=a.section and b.loft=a.newloft and b.room_no =a.nowroom and b.floors =a.newfloor    "
                     
                      + " order by a.ChangeDate desc";
					 
    String secno="";
	String customer="";
	String cusname="";
	String order_code="";
	String section="",checker="",Note="",person="";
	String Loft="",building ="",OldRoom ="",NowRoom ="",ChangeDate ="";
	String newloft="",newbuild="";
   // out.print( changeStr + "<br>" ) ;
    ResultSet changeRS1 = null;
	try{
	changeRS1 = changeListBean.executeQuery(changeStr);	
	 
	int i=0;
	while (changeRS1.next()) {
		 
		 i++;
		 secno=changeRS1.getString("secno");
		 customer=changeRS1.getString("customer");
		 
		 
		 
		    cusname=getbyte(changeRS1.getString("cus_name"));
			order_code=getbyte(changeRS1.getString("code"));
		 
		 
		 section = getbyte(changeRS1.getString("Section"));
		 Loft =getbyte(changeRS1.getString("Loft"));
		 building = getbyte(changeRS1.getString("Build"));
		 OldRoom = changeRS1.getString("OldRoom"); 
		 NowRoom = changeRS1.getString("NowRoom"); 
		 newloft= changeRS1.getString("newloft"); 
		 newbuild= changeRS1.getString("newbuild"); 
         ChangeDate = changeRS1.getString("ChangeDate");
		 checker=getbyte(changeRS1.getString("Checker"));
		 Note=getbyte(changeRS1.getString("Note"));
	    person=getbyte(changeRS1.getString("person"));
		String c_price=getbyte(changeRS1.getString("c_price"));
		String c_area=getbyte(changeRS1.getString("c_area"));
		String oldname=getbyte(changeRS1.getString("oldname"));
		String olddate=getbyte(changeRS1.getString("olddate"));

 %> <b>
  <tr id=TR<%=i %>  align="center"  class='listcontent'   ondblclick="yingshi('<%= order_code%>','<%= customer %>');"   onmouseover="mout(this) ;changeclass1(this,'clickbg','listcontent');"  title="双击可以弹出交款明细" >
  <td    ><%=i %></td>
<td ><a href="#" onclick="openwin('../sale/td_hf_list.jsp?secno=<%=secno %>&roomno=<%=NowRoom%>&loft=<%=Loft %>&build=<%=building%>&show=true&ftyy=<%=Note %>&checker=<%=checker %>&customer=<%=customer %>&order_code=<%=order_code %>',500,600,10,30)"><%= newloft+newbuild+NowRoom%></td>
<td><a href="#" onclick="openwin('../basic/showroomdate.jsp?secno=<%=secno %>&roomno=<%=OldRoom%>&loft=<%=Loft %>&build=<%=building%>&floor=<%=getbyte(changeRS1.getString("floor")) %>&show=true',500,600,10,30)"><%= oldname+ Loft+building+OldRoom %></td>
<td><a href="#" onclick="openwin('../customter/editcustomer.jsp?cusno=<%=customer %>',500,600,10,30)"><%=cusname %></td>
<td><%= olddate.substring(0,olddate.indexOf(" ")) %></td>
<td><%= ChangeDate.substring(0,ChangeDate.indexOf(" ")) %></td>
<td><%= Note %></td>
<td><%= c_area %></td>
<td><%= c_price %></td>

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
