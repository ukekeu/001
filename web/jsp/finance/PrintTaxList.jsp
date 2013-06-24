<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head><LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<link rel=stylesheet href="../class/mad.css" >
	<title>新增收款登记</title>
</head>
<body>
 <%@ page language="java" import="java.sql.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<%
//取得FORM传输过来的数据
String sql="";
String sql1="";

String SecNo=China.getParameter(request,"SecNo");
String Loft=China.getParameter(request,"Loft");
String Build=China.getParameter(request,"Build");
String Room=China.getParameter(request,"Room");
if (!Room.equals(""))Room=" and room_no='"+Room+"'";
String Rep=request.getParameter("rep");
String all=China.getParameter(request,"all");
if (all.equals("")){
  if (Rep.equals("1")){
   sql="update TaxViewList set out='0' ";
   sql1="update TaxViewList set out='1' where section='"+SecNo+"' and loft='"+Loft+"' and building='"+Build+"'"+Room;
  }else if (Rep.equals("2")){
   sql="update RepFactViewList set out='0' ";
   sql1="update RepFactViewList set out='1' where section='"+SecNo+"' and loft='"+Loft+"' and building='"+Build+"'"+Room;
  }
}else{
  sql="update RepFactViewList set out='0' ";
  sql1="update RepFactViewList set out='1' where section='"+SecNo+"'";
}    

try{
  ViewBean.executeUpdate(sql);
  ViewBean.executeUpdate(sql1);
}catch(Exception s){out.println(s.getMessage());}
if (Rep.equals("1"))
   response.sendRedirect(session.getAttribute("reportAddr")+"TaxYJChargesRep.rpt");
else
  response.sendRedirect(session.getAttribute("reportAddr")+"TaxDSChargesRep.rpt");
%> 
 

</body>
</html>
