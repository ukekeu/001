<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>显示预留信息</title>
</head>
 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/logrecord.jsp" %>

<%  
 
  String sql="";
  int id=0;
  String Payname="";
  String name=getbyte1(request.getParameter("secname"));
  String FindB1=getbyte1(request.getParameter("FindB1"));
  String rooms=getbyte1(request.getParameter("rooms"));
 
  String secno=getbyte1(request.getParameter("secno"));
  String build=getbyte1(request.getParameter("build"));
  String loft=getbyte1(request.getParameter("loft"));
  String cusname="",id_crad="",phone="",sj="",addr="",cusno="";
  String code1=getbyte1(request.getParameter("code"));
  if (!code1.equals("")){
   ViewBean.executeUpdate("delete YLroom where code="+code1);
  setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "预留操作" , 
                  "取消"
                ) ;
 
  
  }
%>
<body >
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
<SCRIPT language=javascript >
function FindOption(){

openwin("FindCustomer.jsp?section=<%=secno %>&FindCus=",400,380,300,100);  //+document.cus.cusname1.value
 }
 
function openwin(url,wh,hg,lf,tp) {
  var newwin=window.open(url,"newwin","toolbar=no,location=no,directories=yes,status=yes,menubar=yes,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
  newwin.focus();
  return false;
}
 

</SCRIPT>

 
<form name=cus method="post" action="add_yl_rooms.jsp">
  <input type="hidden" name="rooms" value="'<%=rooms%>'">
  <input type="hidden" name="secname" value="<%=name%>">
  <input type="hidden" name="secno" value="<%=secno%>">
  <input type="hidden" name="build" value="<%=build%>">  
  <input type="hidden" name="loft" value="<%=loft%>">  
   <input type="hidden" name="FindB1" value="ok">  

<div align="center">
<p><font color="#0000CC"><b><font size="3" class=FontColor><%=name+loft+rooms %>预留明细</font></b></font></p></div>
 
  <input type=radio name=choose onclick="checkrg();">认购
 <input type=radio name=qy onclick="checkqy();">直接签约
<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1  ALIGN=center  >
<tr  class=TXTColor> 
<td  align="right">序号</td>
<td  align="center">客户姓名</td>
<td  align="center">联系电话</td>
<td  align="center">预留日期</td>
<td  align="center">结束日期</td>
<td  align="center">批准人</td>
<td  align="center">销售员</td>
<td  align="center">取消</td>
</tr>
   <%
 String customer="select convert(char(10),room.serve_date,120) jldate ,room.floor,YLroom.code,customer.serialno,customer.cus_name,customer.id_card,";
 customer +="customer.sj,customer.phone,customer.address,YLroom.youxiao,";
 customer +=" YLroom.dengji,YLroom.checker,YLroom.person from customer, ";  
  customer +=" YLroom,room  where  room.seccode+room.loft+room.room_code=YLroom.section+YLroom.loft+YLroom.rooms    and YLroom.customer=customer.code and  YLroom.rooms = ";
customer+=" '"+rooms+"' and  YLroom.section ='"+secno+"' and YLroom.loft='"+loft+"'";
 

ResultSet rs=ViewBean.executeQuery(customer);

int ii=1;
String Floors="",jldate="";
while (rs.next()){
   cusno="";
   jldate=getbyte(rs.getString("jldate"));
   Floors=getbyte(rs.getString("Floor"));
   String code=getbyte(rs.getString("code"));
   cusno=getbyte(rs.getString("serialno"));
   cusname=getbyte(rs.getString("cus_name"));
   id_crad=getbyte(rs.getString("id_card"));
   sj=getbyte(rs.getString("sj"));
   phone=getbyte(rs.getString("phone"));
   addr=getbyte(rs.getString("address"));
   String youxiao=getbyte(rs.getDate("youxiao").toString());
   String s_date=getbyte(rs.getDate("dengji").toString());
   String checker=getbyte(rs.getString("checker"));
   String person=getbyte(rs.getString("person"));
  %>
  <tr  class=listcontent> 
<td  align="right"><%=ii %></td>

<td  align="center"><%=cusname %></td>
<td  align="center"><%=phone+sj %></td>
<td  align="center"><%=s_date %></td>
<td  align="center"><%=youxiao %></td>

<td  align="center"><%=checker %></td>
<td  align="center"><%=person %></td>
<td  align="center"><a href="#" onclick="document.cus.code.value='<%=code %>';document.cus.submit();">取消</a></td>
</tr>
<%ii++;}
rs.close();  
  if (cusno.equals("")&&!code1.equals("")){ ViewBean.executeUpdate("update room set salestate=1 where room_code in ("+rooms+") and  seccode ='"+secno+"' and loft='"+loft+"'");
 %>
 <SCRIPT language=javascript>
opener.window.document.frm.submit();
	 window.close();
 </script>
 
 <%
  }
%> 
<input type=hidden name=code value=aaa>
 

</form>
<SCRIPT language=javascript>
   function checkrg(){
     window.location="order.jsp?secname=<%=name %>&secno=<%=secno %>&roomno=<%=rooms%>&build=<%=build%>&loft=<%=loft %>&Floor=<%=Floors %>&jldate=<%=jldate %>";

 }
  function checkqy(){
 
	 window.location="orderok.jsp?secname=<%=name %>&secno=<%=secno %>&roomno=<%=rooms%>&build=<%=build%>&loft=<%=loft %>&Floor=<%=Floors %>&jldate=<%=jldate %>"; 

 }
   function Validate(aForm)
   {   if (aForm.yl.value==4){
       if (aForm.person.value.length<1)
	    	{
	    	alert("请输入经手人！");
	        aForm.person.focus();
	        return (false);
	    	}	
		 if (aForm.checker.value.length<1)
	    	{
	    	alert("请输入批准人");
	        aForm.comm.focus();
	        return (false);
	    	}			
			
      if (aForm.youxiao.value==""&&aForm.yl.value==4)
	    	{
	    	alert("请选择预留日期");
	        aForm.youxiao.focus();
	        return (false);
	    	}	
			}					
	  return (true);
	}
	function SaveCancel(){
      if (Validate(document.cus)){
	   <%if (!cusno.equals("")){ %>
	     if (confirm("确认预留吗？")){
		 <%} %>
	   document.cus.action="SaveRoomYL.jsp";
	   document.cus.submit();
	     <%if (!cusno.equals("")){ %>
		 }
		 <%} %>
     }
    }	
   </script>		
</body>

</html>
