<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="FormtD3" scope="page" class="test.PieChart"/>  
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%	
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "业主构成分析" , 
                  "分析"
                ) ;
			
%>

<html>
<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
	<title>销售分析--点击鼠标右健，选择打印</title>
</head>

<body>
<script language="JavaScript">
<!--
 function ok(x){
	 document.all.photo.value=x;
	 form1.action="list_charges_plan.jsp?type=5&ch_type=3";
	 form1.submit();
 }
//-->
</script>
<%String photo=request.getParameter("photo");
  if(photo==null){
     photo="3";
  }
  String section=getbyte2(request.getParameter("section"));
  if (!section.equals(""))section="  section='"+section+"'";
  String custype=getbyte2(request.getParameter("custype"));
  String pre=request.getParameter("pre");
%>
  <table><tr>
<%
 String messtitle="按户型分析",pic="";

String  SQL="SELECT roomtype,count(*) num  FROM order_contract where "+section+"   group by roomtype" ;
 
   pic= FormtD3.drawToFile("D:/zlcrm/crmv9/jsp/picture/picrgfx1"+getbyte2(request.getParameter("section")).trim()+".jpg",SQL,messtitle);  
 
 if (!pic.equals(""))
 out.print("<td><img src='../picture/picrgfx1"+getbyte2(request.getParameter("section")).trim()+".jpg'></td>");
 
  SQL="SELECT payment1,count(*) num  FROM order_contract where "+section+"   group by payment1" ;
 messtitle="按付款方式";
   pic= FormtD3.drawToFile("D:/zlcrm/crmv9/jsp/picture/picrgfx"+getbyte2(request.getParameter("section")).trim()+".jpg",SQL,messtitle);  
 
 if (!pic.equals(""))
 out.print("<td><img src='../picture/picrgfx"+getbyte2(request.getParameter("section")).trim()+".jpg'></td>");
 %>
 </tr>
 <tr>
<%
   messtitle="按销售面积";pic="";

   SQL="SELECT case when salestate=1 then '未售' when salestate=2 then '已认购'  when salestate=3 then '已签约' when salestate=4 then '预留' end  ,sum(area) num  FROM room where seccode='"+getbyte2(request.getParameter("section")).trim()+"'   group by case when salestate=1 then '未售' when salestate=2 then '已认购'  when salestate=3 then '已签约' when salestate=4 then '预留' end " ;
 
   pic= FormtD3.drawToFile("D:/zlcrm/crmv9/jsp/picture/picrgfx2"+getbyte2(request.getParameter("section")).trim()+".jpg",SQL,messtitle);  
 
 if (!pic.equals(""))
 out.print("<td><img src='../picture/picrgfx2"+getbyte2(request.getParameter("section")).trim()+".jpg'></td>");
 
   %>
 </tr>
 </table> 
</body>
</html>