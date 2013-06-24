<%@ page import = "java.sql.*" contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 

<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
 <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>	
	<LINK href="../class/news.css" rel=stylesheet>
	<title>
	   邮件接收对你设置
	</title>
	<script language="javascript" src="../public_js/public.js">
</script>
<script lang=javascript>
function addzhu_i()
{
    window.open('zhuadd_i.jsp','ss','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=500,height=500');
	//document.f1.action="zhuadd_i.jsp";
	//document.f1.submit();
}
</script>

</head>
<body  oncontextmenu="return false">
<form name=f1 method=post>

 <p align=center class=FontColor>
  <font size=3>
   <b>
    邮件接收对你设置
   </b>
  </font>
 </p>
 
 <table width=100% border="0">
  <tr height="16" bgcolor="#EAEAEA">
   <td align="left">
    
    <input type=button name=add value="增 加" onclick="addzhu_i();">
      <input type=button name=mo value="修 改" onclick="zhuEdit();">
	    <input type=button name=de value="删 除" onclick="zhu_de_a();">
 
   </td>
  </tr>
 </table>

 <table border=0 width=100% align=center  cellspacing=1 cellpadding=1 >
   <tr class=listtitle>
    <td width=5% align=center>序号
    </td>
   	<td width=20% align=center>
	 <font color=white>
	  用户名称
	 </font>
	</td>	
	<td width=55% align=center>
	 <font color=white>
	  接收对象
	 </font>
	</td>	
	<td width=15% align=center>
	 <font color=white>
	 设置对象
	 </font>
	</td>	
   </tr>
   
   <%  
   ResultSet rs = aBean.executeQuery("select id , name,job,mailtoobj from CortrolMan");
   int u = 1;
   while(rs.next()){
   	%>   	
	<tr class='listcontent'>
	 <td><%=u %></td>
	 <td align="center"><%= getbyte ( rs.getString(2) )%></td>	
	 <td align="left">
   <%
   	String mailtoobj=getbyte (rs.getString(4));
	String sql="select name from   CortrolMan ";
	if (!mailtoobj.equals("")){sql+=" where id in ("+mailtoobj+")";
	
   
   ResultSet rss = bBean.executeQuery(sql); 
	 while(rss.next()){%>	   
	 <%= getbyte ( rss.getString(1) )%>
	 <%}}else{%>所有对象<%} %>
	 
	 </td>	
	 <td align="center"><input type=button name=aa value="调整对象" onclick="openwin('mailobjadd_i.jsp?zhuradio=<%= rs.getInt(1)%>',500,350,100,100);"></td>
	</tr>	
	<%
	u++;
   }
   rs.close();
   %>    
 
 </table>
 
  <input type=hidden name=rows value=<%= u%> >
 
 	 <script lang=javascript>
	 	function zhu_de_a()
		{
		    var hasSelect = false;
			<% 
			if( u > 0 ) {
				for( int i=0 ; i < u ; i++ ){
			%>		
						
				if( document.forms[0].ic<%= i%>.checked ) {
					hasSelect = true;
				}
				<%
				}
				%>
				if( hasSelect ) {
					if( confirm( "你确认删除所选的记录吗?" ) ){				
						document.forms[0].action = "zhu_de_a.jsp";
						document.forms[0].submit();				
					}else{
						return;
					}
				}else{
					alert( "请选择要删除的记录!" );
					return;
			}
			<%}else{%>	
				alert("没有记录可以删除!");
			<%}%>
		}
		
		function selectAll()
		{		
		    if( document.forms[0].ca.checked ) {
				<% 
				if( u > 0 ) {
					for( int i=0 ; i < u ; i++ ){
				%>
					document.forms[0].ic<%= i%>.checked = true;
				<%  }
				}
				%>
			}else{
				<% 
				if( u > 0 ) {
					for( int i=0 ; i < u ; i++ ){
				%>
				document.forms[0].ic<%= i%>.checked = false;
				<%  }
				}
				%>		
			}
		}
		
		function zhuEdit()
		{	
		    var selectedNum = 0 ;
            <% 
    		for( int i=0 ; i < u ; i++ ) {
			%>						
    			if( document.forms[0].ic<%= i%>.checked ) {
    				selectedNum ++ ;    			  				
    			}
			<%
			}
			%>
    		if( selectedNum < 1 || selectedNum > 1 ) {
    		    alert( "请选择一个组!" ) ;
    		    return ;
    		}

           <% 
    		for( int i=0 ; i < u ; i++ ) {
			%>						
    			if( document.forms[0].ic<%= i%>.checked ) {
				    window.open('zhuedit_i.jsp?tid=' + document.forms[0].ic<%= i%>.value,'ss','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=500,height=500');
    				//document.location.href = "zhuedit_i.jsp?tid=" + document.forms[0].ic<%= i%>.value ;
    			}
			<%
			}
			%>
		}
	 </script>
	  
</body>
</html>

<% 
if( request.getParameter ("delete") != null && request.getParameter("delete").equalsIgnoreCase("true") ) {
%>
<script lang=javascript>
alert("删除成功!");
</script>
<%
}else if( request.getParameter ("delete") != null && request.getParameter("delete").equalsIgnoreCase("false") ){
%>
<script lang=javascript>
alert("删除记录时发生了错误,请多试几次!");
</script>
<%
}else if( request.getParameter ("add") != null && request.getParameter("add").equalsIgnoreCase("true") ){
%> 
<script lang=javascript>
alert("添加记录成功!");
</script>
<%}else if( request.getParameter ("add") != null && request.getParameter("add").equalsIgnoreCase("false") ){
%>
<script lang=javascript>
alert("删除记录时发生了错误,请多试几次!");
</script>
<%}else if( request.getParameter ("edit") != null && request.getParameter("edit").equalsIgnoreCase("true") ){
%>
<script lang=javascript>
alert("修改记录成功!");
</script>
<%}else if( request.getParameter ("edit") != null && request.getParameter("edit").equalsIgnoreCase("true") ){
%>
<script lang=javascript>
alert("修改记录时发生了错误,请多试几次!");
</script>
<%}
%>
