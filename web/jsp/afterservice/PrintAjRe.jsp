<%@ page contentType="text/html;charset=GBK" %>
 
 

<HTML>
<HEAD>
<TITLE>��Ȩ������</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chrset=gb2312"> 
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/line.css" >
<script language=javascript src="../sale/js/mad.js"> </script>
 
</head>

<%@ include file="../public_js/getByteOut.jsp"%>


<% 
 
	String section = "";
	section =request.getParameter("SecNo");
	 
	if (section == null)
		section = "";
	String loft = "" ;
	loft =request.getParameter("Loft") ;
	if (loft == null)
		loft = "" ;	
	String building = "";
	building =request.getParameter("Build");
	if (building == null)
		building = "";
	String secName = "" ;
	secName =request.getParameter("SecName") ;
	if (secName == null)
		secName = "" ;	
	 
%> 
<script language="javascript" src="../public_js/public.js">

</script>

<body >
  
<% String sel=(String)request.getParameter("sel");
   if(sel==null) sel="0"; %>
   <form name=cus action="PrintAjRe.jsp" method="post">
  <input type=hidden name="sel" value="<%=sel %>">
 <table width="270" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.cus.sel.value=0;findSub('AjListS.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>���ҿͻ�</font></a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.cus.sel.value=1;findSub('RoomCodeShowC.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�������</font></a>
	</td>
	 <td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.cus.sel.value=2;findSub('PrintAjRe.jsp');"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�������</font></a>
	</td>
	</tr></table>
	<br><br><br><br>
<!--	<p align="center"><input type=button name="rpt1" value="������ϸ��1" onclick="sendaj();"></p>
	<br>
	<p align="center"><input type=button name="rpt2" value="�Ѱ�����ϸ��" onclick="aj1();"></p>
	--> 
 
 
</form>
	<script>
function findSub(para){
    document.cus.action=para+"?SecNo=<%= section%>&Loft=<%=loft %>&Build=<%=building %>";
 
   document.cus.submit();


}
function sendaj(){
		 
		   openwin1("sendAJ_select.jsp?PARA_SQL=viewSaleList&url=18&reporttype=sale&tablename=",700,300,20,10);
	 }
 
function cz(){
		 if (confirm("ȷ�ϴ�ӡ��"))
		   openwin1("auto_select.jsp?PARA_SQL=viewSaleList&url=18&reporttype=sale&tablename=",700,300,20,10);
		}		
function aj1(){
		 if (confirm("ȷ�ϴ�ӡ��"))
		   openwin1("../sale/autoselect4.jsp?type=8",700,300,20,10);
		}		
</script>
 
  
</BODY>
</HTML>
