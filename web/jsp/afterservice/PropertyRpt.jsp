<%@ page contentType="text/html;charset=GBK" %>
 
 

<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<HEAD>
<TITLE>��Ȩ������</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chrset=gb2312"> 
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
	  <a href="#" onclick="document.cus.sel.value=0;findSub('PropertyWBList.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�����Ȩ</font></a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.cus.sel.value=1;findSub('RoomCodeShowQ.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>��Ȩ����ͼ</font></a>
	</td>
	  <td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=2;findSub('PropertyYBList.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>���Ͱ��Ȩ</font></a>
	</td>
	 <td class="<%if(sel.equals("6")){out.print("paneselect6");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=3;findSub('PropertyZJList.jsp');"><font color='<%if(sel.equals("6")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>��ͬע��</font></a>
	</td>
	 <td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=3;findSub('PropertyAList.jsp');"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�Ѱ��Ȩ</font></a>
	</td>
	 <td class="<%if(sel.equals("5")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=5;findSub('PropertyWCList.jsp');"><font color='<%if(sel.equals("5")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>δ������ͬ</font></a>
	</td>
	 <td class="<%if(sel.equals("4")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=4;findSub('PropertyRpt.jsp');"><font color='<%if(sel.equals("4")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�������</font></a>
	</td>
	</tr></table>
	<%out.close(); %>
	<P>&nbsp;</P><P>&nbsp;</P>
	<table border="0" align="center" width="60%">
 	 
	<tr height=40>
	<td><input type=button name="rpt1" value="���ҷ��ز�Ȩ֤�ƽ���" onclick="cq_yj();"  style="width : 150"></td>
	<td><input type=button name="rpt5" value="��Ȩ��ȷȨ����������" onclick="printReport('../sale/autoselect7.jsp?type=7');" style="width : 150"></td>
	
	</tr>
	<tr height=40>
	<td><input type=button name="rpt5" value="��  ��  ��  ��1" onclick="printReport('../sale/autoselect7.jsp?type=8');" style="width : 150"></td>
	<td><input type=button name="rpt5" value="��  ��  ��  ��2" onclick="printReport('../sale/autoselect7.jsp?type=9');" style="width : 150"></td>
	
	</tr>
	<tr height=40>
	<td><input type=button name="rpt5" value="��˰�걨��(�б�)" onclick="printReport('../sale/autoselect9.jsp?type=5');" style="width : 150"></td>
	<td><input type=button name="rpt4" value="��������֤������"   onclick="cz_list();" style="width : 150"></td>
	
	</tr>
	<tr height=40>
	<td><input type=button name="rpt2" value="���ز�Ȩ֤��ϸ��"  onclick="cqm();" style="width : 150"></td>
	<td><input type=button name="rpt5" value="��֤����±���" onclick="bz();" style="width : 150"></td>
	
	</tr>
	 
	</table>
	 
 
</form>
	<script>
function findSub(para){
   document.cus.action=para;
   document.cus.submit();


}
function songjian(){
		 if (confirm("ȷ�ϴ�ӡ�ͼ��������ȷ�ϴ�ӡ��ϵͳ���Ѵ�ӡ������Ϊ�ͼ����ڴ���"))
		   openwin1("../sale/auto_select.jsp?PARA_SQL=viewSaleList&url=17&reporttype=sale&tablename=",700,300,20,10);
		}
function cqm(){
		 if (confirm("ȷ�ϴ�ӡ��"))
		   openwin1("auto_select.jsp?PARA_SQL=viewSaleList&url=18&reporttype=sale&tablename=",700,300,20,10);
		}		
function cq_yj(){
		 if (confirm("ȷ�ϴ�ӡ��"))
		   openwin1("auto_select.jsp?PARA_SQL=viewSaleList&url=17&reporttype=sale&tablename=",700,300,20,10);
		}	
	function cz_list(){
		 if (confirm("ȷ�ϴ�ӡ��"))
		   openwin1("auto_select.jsp?PARA_SQL=viewSaleList&url=20&reporttype=sale&tablename=",700,300,20,10);
		}		
function jz_cz(){
		 if (confirm("ȷ�ϴ�ӡ��"))
		   openwin1("../sale/auto_select.jsp?PARA_SQL=viewSaleList&url=18&reporttype=sale&tablename=",700,300,20,10);
	}	
function bz(){
		 if (confirm("ȷ�ϴ�ӡ��"))
		   openwin1("../sale/autoselect4.jsp?type=9",700,300,20,10);
	}		
function printReport(urlValue){
  openwin(urlValue,700,300,50,100);

}	
</script>
 
  
</BODY>
</HTML>
