<%@ page contentType="text/html;charset=GBK" %>
 
 

<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<HEAD>
<TITLE>产权管理报表</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chrset=gb2312"> 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/line.css" >
<script language=javascript src="../sale/js/mad.js"> </script>
 
</head>
  <%@ page import="java.sql.*, common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
   
<%@ include file="../public_js/getByteOut.jsp"%>


<%String cusname=China.getParameter(request,"cusname");
     String secname=China.getParameter(request,"secname");
   cusname=cusname.trim();
 
	String section = "";
	section = China.getParameter(request, "SecNo");
	if (section == null)
		section = "";
	String loft = "" ;
	loft = China.getParameter(request, "Loft") ;
	if (loft == null)
		loft = "" ;	
	String building = "";
	building =China.getParameter(request, "Build");
	if (building == null)
		building = "";
	String secName = "" ;
	secName = China.getParameter(request, "SecName") ;
	if (secName == null)
		secName = "" ;	
	 
%> 
<script language="javascript" src="../public_js/public.js">

</script>

<body   topmargin="1"   >
  
<% String sel=(String)request.getParameter("sel");
   if(sel==null) sel="0"; %>
   <form name=cus action="">
  <input type=hidden name="sel" value="<%=sel %>">
  
	
	<input type=hidden name=Room value="">
<input type=hidden name=Type>
<input type=hidden name=status>
<input type=hidden name=cusname>
<input type=hidden name=secname value="<%=secname %>">
<input type=hidden name=secName value="<%=secName %>">
<input type=hidden name=SecNo value="<%=section %>">
<input type=hidden name=Loft value="<%=loft %>">
<input type=hidden name=build value="<%=building %>">
 <table width="620" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=0;findSub('PropertyWBList.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>待办产权</font></a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.cus.sel.value=1;findSub('RoomCodeShowQ.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>产权销控图</font></a>
	</td>
	  <td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=2;findSub('PropertyYBList.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>已送办产权</font></a>
	</td>
	 <td class="<%if(sel.equals("6")){out.print("paneselect6");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=3;findSub('PropertyZJList.jsp');"><font color='<%if(sel.equals("6")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>合同注记</font></a>
	</td>
	 <td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=3;findSub('PropertyAList.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>已办产权</font></a>
	</td>
	 <td class="<%if(sel.equals("5")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=5;findSub('PropertyWCList.jsp');"><font color='<%if(sel.equals("5")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>未审批合同</font></a>
	</td>
	 <td class="<%if(sel.equals("4")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=4;findSub('PropertyRpt.jsp');"><font color='<%if(sel.equals("4")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>报表管理</font></a>
	</td>
	</tr></table>
	<%out.close(); %>
	<P>&nbsp;</P><P>&nbsp;</P>
	<table border="0" align="center" width="60%">
 	 
	<tr height=40>
	<td><input type=button name="rpt1" value="按揭房地产权证移交表" onclick="cq_yj();"  style="width : 150"></td>
	<td><input type=button name="rpt5" value="产权总确权申请审批表" onclick="printReport('../sale/autoselect7.jsp?type=7');" style="width : 150"></td>
	
	</tr>
	<tr height=40>
	<td><input type=button name="rpt5" value="出  售  情  况1" onclick="printReport('../sale/autoselect7.jsp?type=8');" style="width : 150"></td>
	<td><input type=button name="rpt5" value="出  售  情  况2" onclick="printReport('../sale/autoselect7.jsp?type=9');" style="width : 150"></td>
	
	</tr>
	<tr height=40>
	<td><input type=button name="rpt5" value="纳税申报表(列表)" onclick="printReport('../sale/autoselect9.jsp?type=5');" style="width : 150"></td>
	<td><input type=button name="rpt4" value="出　　　证　　表"   onclick="cz_list();" style="width : 150"></td>
	
	</tr>
	<tr height=40>
	<td><input type=button name="rpt2" value="房地产权证明细表"  onclick="cqm();" style="width : 150"></td>
	<td><input type=button name="rpt5" value="办证情况月报表" onclick="bz();" style="width : 150"></td>
	
	</tr>
	 
	</table>
	 
 
</form>
	<script>
function findSub(para){
   document.cus.action=para;
   document.cus.submit();


}
function songjian(){
		 if (confirm("确认打印送件表吗？如果确认打印，系统将把打印日期作为送件日期处理"))
		   openwin1("../sale/auto_select.jsp?PARA_SQL=viewSaleList&url=17&reporttype=sale&tablename=",700,300,20,10);
		}
function cqm(){
		 if (confirm("确认打印吗？"))
		   openwin1("auto_select.jsp?PARA_SQL=viewSaleList&url=18&reporttype=sale&tablename=",700,300,20,10);
		}		
function cq_yj(){
		 if (confirm("确认打印吗？"))
		   openwin1("auto_select.jsp?PARA_SQL=viewSaleList&url=17&reporttype=sale&tablename=",700,300,20,10);
		}	
	function cz_list(){
		 if (confirm("确认打印吗？"))
		   openwin1("auto_select.jsp?PARA_SQL=viewSaleList&url=20&reporttype=sale&tablename=",700,300,20,10);
		}		
function jz_cz(){
		 if (confirm("确认打印吗？"))
		   openwin1("../sale/auto_select.jsp?PARA_SQL=viewSaleList&url=18&reporttype=sale&tablename=",700,300,20,10);
	}	
function bz(){
		 if (confirm("确认打印吗？"))
		   openwin1("../sale/autoselect4.jsp?type=9",700,300,20,10);
	}		
function printReport(urlValue){
  openwin(urlValue,700,300,50,100);

}	
</script>
 
  
</BODY>
</HTML>
