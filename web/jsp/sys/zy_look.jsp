<%@ page import = "java.sql.*" contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/getByteOut.jsp"%>

<%
String tid = request.getParameter("zhuradio");
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
	  组员查看
	</title>
	
<script lang=javascript>
function cancle()
{
	document.location.href="zhuyuang.jsp";
}
</script>

</head>
<body  oncontextmenu="return false">

<p align=center class=FontColor>
 <font size=3>
  <b>
   "<%= getbyte( tname )%>" 组成员如下
  </b>
 </font>
</p>

<form name=f1 method=post>
 <table width=100% border=0  cellpadding=1 cellspacing=1 class=roomright>   
   <tr>
    <td align=center>
	<%
	String sql = "select teaman.mid , cortrolman.serialno"
				 + " from teaman "
				 + " left join cortrolman "
				 + " on teaman.mid = cortrolman.id "
				 + " where tid = " + tid; 
	ResultSet rss = aBean.executeQuery(sql);
	%>
	 <select name=s1 multiple style="width:160;height=200" >
	 <%
	 while( rss.next() ) {
	 %>
	 	<option value=<%= rss.getInt(1) %> >
		 <%= rss.getString(2)%>
		</option>
	 <%
	 }
	 rss.close();
	 %>
	 </select>
	</td>
   </tr>
 </table>
 
 <p align=center>
   <input type=button value="    取消    " onclick="cancle()">
 </p>
 
 
</form>
</body>
</html>
