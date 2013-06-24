<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/>  
<%@ include file="../public_js/getByteOut.jsp"%>
    <jsp:useBean id="FormtD1" scope="page" class="test.BarChartDemo"/>  
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<LINK href="../class/line.css" rel=stylesheet>
	<title>竞争分析</title>
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
<%String photo="2";//request.getParameter("photo");
  if(photo==null){
     photo="3";
  }
  String fxtype=request.getParameter("fxtype");
  String charges_type=request.getParameter("charges_type");
  if(charges_type==null){
      charges_type="0";
  }
  if(charges_type.equals("")){
      charges_type="0";
  }
  if(photo.equals("1")){
      charges_type="0";
  }
  String pre=request.getParameter("pre");
%>
<input type="hidden" name="photo" value="<%=photo%>">
 
<%
 String aa[]=request.getParameterValues("fxzb");
 
 
 String section=request.getParameter("section");
int begin_year=0,begin_month=0;
ResultSet rs=null;


%>
<input type="hidden" name="show" value="<%=request.getParameter("show")%>">
 
  <%
 
	int iii=0;
    String  SQL="SELECT Jz_section, sum(Jz_section_avg) avg  FROM JZFX where Section_NO ='"+section+"'     group by Jz_section";
 
	String pic=FormtD1.main1("D:/zlcrm/crmv9/jsp/picture/jzadjricefx"+section+".jpg","周边楼盘销售价格","均价(元)","周边楼盘销售价格",SQL,1,"预售均价","","","");
  
  %>
  
<table width="100%" border="0"><tr><td align="center">
    <%if (!pic.equals("")){%>
	<img src="../picture/<%=pic%>">
	<%}%>
	
	</td></tr></table>
<table>
<tr><td>备注说明：</td></tr><tr><td>
&nbsp;&nbsp;&nbsp;&nbsp;<input type=text  name=aa   class=unnamed1 size=100  >
</td></tr>
<tr><td>
<input type=text  name=aa   class=unnamed1 size=104  >
</td></tr>
</table>
</body>
</html>