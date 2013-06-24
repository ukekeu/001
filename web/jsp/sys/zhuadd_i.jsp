<%@ page import = "java.sql.*" contentType="text/html;charset=GBK" %>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
    <LINK href="../class/news.css" rel=stylesheet>
	<title>
	   添加一个组
	</title>
	
<script lang=javascript>
function addzhu_a()
{
	document.f1.action="zhuadd_a.jsp";
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
    增加一个新组
   </b>
  </font>
 </p>

 <table border=0 width=100% align=center cellpadding=1 cellspacing=1  >	
  <tr> 
   <td align=center class=TITLE colspan=2>
    <b>
     添加一个新组
    </b>
   </td>
  </tr>	
    
   <tr>
    <td class=roomleft width=34%>
	 新组名:
    </td>
    <td class=roomright width=66%>
     <input type=input name=in1> 
	</td class=roomright>
   </tr> 
 </table>
 
 <p align=center>
    <input type=button value="    添加    "  onclick="addzhu_a()">	
    <input type=button value="    取消    " onclick="window.close()">	  
 </p>
 
 
</form>
</body>
</html>
