<%@ page import = "java.sql.*" contentType="text/html;charset=GBK" %>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>

<%
String tid = request.getParameter("tid");
ResultSet rs = aBean.executeQuery( "select tname from team where tid =" + tid);
String tname = "";
if( rs.next() ) {
	tname = rs.getString(1);
}
rs.close();

%>


<html>
<head>
    <LINK href="../class/news.css" rel=stylesheet>
	<title>
	  �޸�һ����
	</title>
	
<script lang=javascript>
function zhuedit_a()
{
	document.f1.action="zhuedit_a.jsp?tid=" + <%= tid%>;
	document.f1.submit();
}

function cancle()
{
	document.location.href="zhu.jsp";
}
</script>

</head>
<body  oncontextmenu="return false">
<form name=f1 method=post>

 <p align=center class=FontColor>
  <font size=3>
   <b>
    �޸�����
   </b>
  </font>
 </p>

 <table border=0 width=100% cellpadding=1 cellspacing=1>
   <tr>
    <td  align=left colspan=2 class=roomleft>
	 ԭ������ "<%= getbyte( tname )%>"
	</td>
   </tr>
     
   <tr>
    <td class=roomleft>
	 ������:
    </td>
    <td class=roomright>
     <input type=input name=in1> 
	</td>
   </tr>  
 </table>
 
 <p align=center>
  <input type=button value="    ȷ��    "  onclick="zhuedit_a()">   
  <input type=button value="    ȡ��    " onclick="window.close()">
 </p>
 
</form>
</body>
</html>
