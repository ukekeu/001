<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%> 
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase"/> 
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/CheckSection.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>

<html>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<head>
	<title>临定定金管理1d</title>
</head>
<script language="javascript" src="../public_js/public.js">
</script>

<%
String SQLwhere="";
SQLwhere=getbyte1(request.getParameter("section"));
if (!SQLwhere.equals("")) SQLwhere=" and r.seccode='"+SQLwhere+"'";
String cusname=getbyte1(request.getParameter("cusname"));
String roomno=getbyte1(request.getParameter("roomno"));
String orderbytype=China.getParameter(request,"orderbytype");
String orderby=China.getParameter(request,"orderby");

//排序方式
	if (!orderbytype.equals("")&&!orderby.equals("")){
	  if (orderbytype.equals("0")&&orderby.equals("0")) orderby=" order by startdate desc";
	  if (orderbytype.equals("0")&&orderby.equals("1")) orderby=" order by startdate asc";
	  if (orderbytype.equals("1")&&orderby.equals("0")) {orderby=" order by cus_name desc";}
	  if (orderbytype.equals("1")&&orderby.equals("1")) orderby=" order by cus_name asc";
	    if (orderbytype.equals("2")&&orderby.equals("0")) {orderby=" order by room_code desc";}
	  if (orderbytype.equals("2")&&orderby.equals("1")) orderby=" order by room_code asc";
	}else{
	orderby=" order by  startdate desc";
	
	}
String choos =    getbyte( request.getParameter( "choos" ) ) ;
if (choos.equals(""))choos="0";
String findStr="";
//if (choos.equals("0"))findStr+=" and Subscription=0 ";
//else findStr+=" and Subscription>0 ";

String state= getbyte( request.getParameter( "stateshow" ) ) ;
if (state.equals(""))state="0";
 %>
 
<body >
 <form name=frm method=post >
  <div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >

    <p align="center"> 临定定一览表</p>
	 
<table width="99%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
    <tr  align="center" > 
      <td  >序号</td>
	  <td  >客户名称</td>
      <TD  >临定单位</td>
	  <td >临定日期</td>
	  <td  >应收定金</td>
	   <td  >实收定金</td>
	     <td  >实收日期</td>
	  <td  >票据</td>
	  <td  >票据编号</td>
	  <td >付款方式</td>
	  <td >是否结转</td>
   </tr>  
 <%
 String vv=getbyte1(request.getParameter("section"));
 if (!vv.equals(""))SectionS="'"+request.getParameter("section")+"'";
String SQL="SELECT  s.roomcode,c.cus_name,l.name+r.loft+r.building+r.Room_code Room_code,s.StartDate,s.Subscription,s.fact_dj,s.fact_date,s.billtype,s.bill_num,s.paytype,s.zto,s.tk  from  SL_TemporarilyBuy s,room r,customer c,CRM_Project l where s.state=0 and  s.Cusname=c.serialno and s.RoomCode=r.code and r.seccode=l.serialno and r.seccode in ("+SectionS+")";
 if (!cusname.equals(""))
	 SQL+=" and c.cus_name like '%"+cusname+"%'";
 if (!roomno.equals(""))
	 SQL+=" and r.room_code like '%"+roomno+"%'";

 
ResultSet rs=aBean.executeQuery(SQL+ findStr+" and zto=" + state+ orderby);
 int i=0;
 while (rs.next()){ 
 i++;
  String sate=getbyte(rs.getString("zto")) ;
 %>
    <tr <% if (sate.equals("0")){ %> ondblclick="openwin('InputDj.jsp?code='+room_code,550,480,100,10);" <%} %>id=TR<%=i %>  class=listcontent  align="center"  onmouseover="mout(this);"  onclick="savepara('<%=getbyte(rs.getString("roomcode"))%>');changeclass1(this,'clickbg','listcontent');" title="双击可收取登记">
      <td  > <%=i %></td>
	  <td  align="left" > <%=getbyte(rs.getString("cus_name")) %> </td>
      <TD align="left" > <%=getbyte(rs.getString("room_code")) %> </td>
	  <td > <%=getbyte(rs.getDate("StartDate").toString()) %> </td>
	  <td  ><%=getbyte(rs.getString("Subscription")) %> </td>
	    <td  ><%=getbyte(rs.getString("fact_dj")) %> </td>
	    <td  ><%
		
		String factdate=getbyte(rs.getString("fact_date"));
		if (!factdate.equals(""))out.print(factdate.substring(0,10));
		 %> </td>
	  <td  > <%
	   String BillType=getbyte(rs.getString("billtype"));
	   if (BillType.equals("0"))BillType="收据";
	   if (BillType.equals("1"))BillType="发票";
	   out.print(BillType);
	  %> </td>
	  <td  >NO:<%=getbyte(rs.getString("bill_num")) %> </td>
	  <td > <%=getbyte(rs.getString("paytype")) %></td>
	  <td > <%
	 
	  float tk=rs.getFloat("tk");
	  if (tk==0){
	   if (sate.equals("0"))sate="未结转";
	   if (sate.equals("1"))sate="已结转";
	      out.print(sate);
	}else{out.print("退定");}	  
	   %> </td>
   </tr>  
 
 <%}rs.close(); %>  
 </form>
 </table>
 </div>
 <script>
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
 bringToExcel();
 window.close();
 </script> 
</body>
</html>
