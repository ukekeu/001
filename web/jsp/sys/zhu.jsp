<%@ page import = "java.sql.*" contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "�����" , 
                  "���"
                ) ;
%>

<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
 <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>	
	<LINK href="../class/news.css" rel=stylesheet>
	<title>
	   �����
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
    �����
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
    <td width=5% align=center>&nbsp;
    </td>
   	<td width=20% align=center>
	 <font color=white>
	  ����
	 </font>
	</td>	
	<td width=55% align=center>
	 <font color=white>
	  ���Ա
	 </font>
	</td>	
	<td width=15% align=center>
	 <font color=white>
	 �������Ա
	 </font>
	</td>	
   </tr>
   
   <%  
   ResultSet rs = aBean.executeQuery("select tid , tname from team where towner = '" + "steven" + "'");
   int u = 0;
   while(rs.next()){
   	%>   	
	<tr class='listcontent'>
	 <td><input type=checkbox name=ic<%= u%> value=<%= rs.getInt(1)%> ></td>
	 <td align="center"><a href="#" onclick="javascript:window.open('zy_add_i.jsp?zhuradio=<%= rs.getInt(1)%> ','ss','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=500,height=500');"><%= getbyte ( rs.getString(2) )%></a></td>	
	 <td align="left">
   <%ResultSet rss = bBean.executeQuery("select Name from teaman A,CortrolMan B where A.mid=B.id and A.tid="+rs.getInt(1)+""); 
	 while(rss.next()){%>	   
	 <%= getbyte ( rss.getString(1) )%>
	 <%}%>&nbsp;
	 </td>	
	 <td align="center"><input type=button name=aa value="������Ա" onclick="openwin('zy_add_i.jsp?zhuradio=<%= rs.getInt(1)%>',500,350,100,100);"></td>
	</tr>	
	<%
	u++;
   }
   rs.close();
   %>    
   <tr class='listcontent'>
    <td colspan=3>
     <input type=checkbox name=ca onclick="selectAll()"> &nbsp; ȫѡ/ȡ��
	</td>	
   </tr>	
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
