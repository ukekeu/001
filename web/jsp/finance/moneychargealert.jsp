<%@ page contentType="text/html;charset=GBK" %>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
   <%@ include file="../public_js/checktime.jsp"%>
  <jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id = "changeListBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
  <%@ include file="../public_js/getByteOut.jsp"%>
  <%@ include file="../public_js/CheckSection.jsp"%>
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
 <body   topmargin="0"   >
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
    openwin1("yingshi.jsp?contractno=" + contractno + "&cusno=" + cusno ,660,450,50,50);
  } 
</script>
 
<p align="center" class=FontColor><font size=3><b> 最新优惠合同</font></b></p>
 

<table width="100%" border="0" CELLPADDING="1" CELLSPACING="1"> 
<tr class=TXTColor  align="center">
  <td     > 序号</td>
 <td>房间</td>
 <td>预售价格</td>
   <td>认购日期</td>
   
  <td>客户姓名</td>
 <td>客户电话</td>
     <td>成交价格</td>
 
 <td>优惠描述</td>
	 </tr>
 
<%
ResultSet rs = null;
 
	  
	  
	  List list1=new LinkedList();//存放优惠
	   List list2=new LinkedList();//存放优惠单元
   String changeStr="SELECT order_no,disc,youhui,discObj from order_disc_view  where section in("+SectionS+")";
	     
	
			  rs=ViewBean.executeQuery(changeStr);
			 String yy="";	 
			 String order_no="";
			  while (rs.next()){
			    if (!order_no.equals("")&&!order_no.equals(rs.getString("order_no"))){
				  list1.add(yy); 
			      list2.add(order_no); 
				  yy="";
				 }				
			    String dis=rs.getString("disc");
				float yh=rs.getFloat("youhui");
			    String obj=rs.getString("discObj");
				if (!dis.equals(""))yy+=" 按"+obj+rs.getString("disc")+"折";
				if (yh>0) yy+=" 按"+obj+"优惠"+rs.getString("youhui")+"元";			
				order_no=rs.getString("order_no");				
				}rs.close();
			   if (!yy.equals("")){
			   list1.add(yy);list2.add(order_no); 
			   }
	 

 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
  
	  changeStr = " select Distinct ordercode,cus_name,sectionname,loft,room_no,ysumprice,payment1,phone+' '+sj phone,rmbprice,rgdate,Customer,ordercode,section from order_disc_view  where     dateadd(dd,5,disc_date)<getdate() and section in("+SectionS+")";
	 
    String secno="";
	String customer="";
	String cusname="";
	String order_code="";
	String section="",checker="",Note="",person="";
	String Loft="",building ="",OldRoom ="",NowRoom ="",ChangeDate ="",rgDate="";
	String newloft="",newbuild="";
      
	try{
	rs = changeListBean.executeQuery(changeStr);	
	 
	int i=0;
	while (rs.next()) {		 
		 i++;
		 secno=getbyte(rs.getString("section")); 
     String Customer=getbyte(rs.getString("cus_name"));
	  String sectionname=getbyte(rs.getString("sectionname"));
	 String loft=getbyte(rs.getString("loft"));
     String Room_no=rs.getString("Room_no");
  String ysumprice=rs.getString("ysumprice");	 
	 String payment=getbyte(rs.getString("payment1"));
	 if (payment.indexOf("揭")>0)payment=payment.substring(0,payment.indexOf("揭")+1);
	  String phone= getbyte(rs.getString("phone")) ;	  
	 String salerprice= rs.getString("rmbprice");
 	String date=getbyte(rs.getString("rgdate"));   	 
	 order_code=getbyte(rs.getString("ordercode")); 
    customer=getbyte(rs.getString("Customer")); 
	 		
 %>  
  <tr id=TR<%=i %>  align="center"  class='listcontent'   ondblclick="yingshi('<%= order_code%>','<%= customer %>');"   onmouseover="mout(this) ;changeclass1(this,'clickbg','listcontent');"  title="双击可以弹出交款明细" >
  <td    ><%=i %></td>
<td > <%= sectionname+Loft+Room_no%></td>
 <td > <%=ysumprice%></td>
  <td><%= date %></td>
  <td > <%=Customer%></td>
   <td > <%=phone%></td>

  <td><%= salerprice %></td>
<!--<td><a href="#" onclick="openwin('../customter/editcustomer.jsp?cusno=<%=customer %>',500,600,10,30)"><%=cusname %></td>-->
 
 <td align="left" ><% 
if (list2.contains(secno+loft+Room_no)){
		   int index=list2.indexOf(secno+loft+Room_no);
		   
		    out.print((String)list1.get(index));
}
%>　</td>
  
</tr>
 
<%
  	}
	rs.close();
	}catch(Exception e){out.print(e);}
  %>

</form> 
</body>
</html>
