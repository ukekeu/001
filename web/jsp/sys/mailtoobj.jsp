<%@ page import = "java.sql.*" contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 

<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
 <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>	
	<LINK href="../class/news.css" rel=stylesheet>
	<title>
	   �ʼ����ն�������
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
    �ʼ����ն�������
   </b>
  </font>
 </p>
 
 <table width=100% border="0">
  <tr height="16" bgcolor="#EAEAEA">
   <td align="left">
    
    <input type=button name=add value="�� ��" onclick="addzhu_i();">
      <input type=button name=mo value="�� ��" onclick="zhuEdit();">
	    <input type=button name=de value="ɾ ��" onclick="zhu_de_a();">
 
   </td>
  </tr>
 </table>

 <table border=0 width=100% align=center  cellspacing=1 cellpadding=1 >
   <tr class=listtitle>
    <td width=5% align=center>���
    </td>
   	<td width=20% align=center>
	 <font color=white>
	  �û�����
	 </font>
	</td>	
	<td width=55% align=center>
	 <font color=white>
	  ���ն���
	 </font>
	</td>	
	<td width=15% align=center>
	 <font color=white>
	 ���ö���
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
	 <%}}else{%>���ж���<%} %>
	 
	 </td>	
	 <td align="center"><input type=button name=aa value="��������" onclick="openwin('mailobjadd_i.jsp?zhuradio=<%= rs.getInt(1)%>',500,350,100,100);"></td>
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
					if( confirm( "��ȷ��ɾ����ѡ�ļ�¼��?" ) ){				
						document.forms[0].action = "zhu_de_a.jsp";
						document.forms[0].submit();				
					}else{
						return;
					}
				}else{
					alert( "��ѡ��Ҫɾ���ļ�¼!" );
					return;
			}
			<%}else{%>	
				alert("û�м�¼����ɾ��!");
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
    		    alert( "��ѡ��һ����!" ) ;
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
alert("ɾ���ɹ�!");
</script>
<%
}else if( request.getParameter ("delete") != null && request.getParameter("delete").equalsIgnoreCase("false") ){
%>
<script lang=javascript>
alert("ɾ����¼ʱ�����˴���,����Լ���!");
</script>
<%
}else if( request.getParameter ("add") != null && request.getParameter("add").equalsIgnoreCase("true") ){
%> 
<script lang=javascript>
alert("��Ӽ�¼�ɹ�!");
</script>
<%}else if( request.getParameter ("add") != null && request.getParameter("add").equalsIgnoreCase("false") ){
%>
<script lang=javascript>
alert("ɾ����¼ʱ�����˴���,����Լ���!");
</script>
<%}else if( request.getParameter ("edit") != null && request.getParameter("edit").equalsIgnoreCase("true") ){
%>
<script lang=javascript>
alert("�޸ļ�¼�ɹ�!");
</script>
<%}else if( request.getParameter ("edit") != null && request.getParameter("edit").equalsIgnoreCase("true") ){
%>
<script lang=javascript>
alert("�޸ļ�¼ʱ�����˴���,����Լ���!");
</script>
<%}
%>
