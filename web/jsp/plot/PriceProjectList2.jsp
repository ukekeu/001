<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "价格管理" , 
                  "浏览"
                ) ;
%>

<HTML>
<HEAD>
<TITLE>Untitled Document</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chamisRset=gb2312"> 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script language=javascript src="../sale/js/mad.js"> </script>

</head>
  <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
   <jsp:useBean id="setpro" scope="session" class="setProperty.setProperty"/>   
<%@ include file="../public_js/getByteOut.jsp"%>
<%  String SecName=China.getParameter(request,"SecName");
    String SecNo=request.getParameter("SecNo");
    String Loft=China.getParameter(request,"Loft");
	String section = China.getParameter(request, "Section") ;
	String Build=China.getParameter(request,"Build");
	// out.print(section) ;
	if (!section.equals(""))
		session.setAttribute("Advertise-Section", section) ;
	
	section = (String) session.getAttribute("Advertise-Section") ;
	if (section == null)
		section = "" ;
	
%><script>
	function submitv() {
		if (document.aform.Building.value == "") {
			alert("请输入栋号");
			return false;
		}	
	}
	


</script>
<script language="javascript" src="../public_js/public.js">

</script>

<body>
<%!
	public String getFloat(float temp,int lens) {
		java.text.DecimalFormat df = null;
		if (lens == 4)
			df = new java.text.DecimalFormat("###.#####");
		if (lens == 2)
			df = new java.text.DecimalFormat("###,###,###.##");
		if (lens == 1)
			df = new java.text.DecimalFormat("###,###,###");	
		return df.format(temp).toString();
	}
%>
<form name=frm>
<input type=hidden name=SecNo>
<input type=hidden name=Loft>
<input type=hidden name=SecName>
<input type=hidden name=Build>
<input type=hidden name=choose>
 
<br><br><br><br><br>
<table width=100%>
 
<tr height="16" bgcolor="#EAEAEA"><td align="center"> <a href="#" onclick="openwin('SetElement.jsp',500,400,100,100);"><font size="2" color="#0000ff">代码系数</font></a>&nbsp;&nbsp;<a href="#" onclick="openwin('SetElement1.jsp?SecNo=<%=SecNo%>&SecName=<%=SecName%>',500,400,100,100);"><font size="2" color="#0000ff">楼栋系数</font></a>&nbsp;&nbsp;
<a href="#" onclick="PrintPrice();" alt="打印当前价格表">打印当前价格</a>&nbsp;&nbsp;<a href="#" onclick="Add();">定(调)价</a>
</td></tr>
</table>

  </form>
  <script>
  	function PrintPrice(){
		 openwin("currPriceList.jsp?SecNo=<%=SecNo %>&Loft=<%=Loft %>&secname=<%=SecName %>",780,500,10,10);
		
		}
		function Add() {
			top2 = (screen.availHeight - 420) / 2 ;
			left2 = (screen.width - 500) / 2  ;
			height2 = 500 ;
			width2 = 600 ;
			window.open('PriceProjectInput2.jsp?SecNo=<%=SecNo %>&Build=<%=Build %>&Loft=<%=Loft %>&x=' + Math.random(), '34', 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=0,left=0,width=800,height=550') ;
		}
  </script>
</BODY>
</HTML>
