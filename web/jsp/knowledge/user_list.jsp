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

 <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>	
	<LINK href="../class/news.css" rel=stylesheet>
	<title>
	   �û�һ����
	</title>
 

</head>
<body>
<form name=form1 method=post>

 <p align=center class=FontColor>
  <font size=3>
   <b>
    �û�һ����
   </b>
  </font>
 </p>
 
  
<input type=button name=choose value="ȷ ��" onclick="getseldocs2();">
 <table border=0 width=100% align=center  cellspacing=1 cellpadding=1 >
   <tr class=listtitle>
    <td width=5% align=center>
    <input type=checkbox name=ca1 onclick="selectAll()" title="ȫѡ/ȡ��"> &nbsp; 
	</td>	
	<td width=20% align=center>
	 <font color=white>
	  �û���
	 </font>
	</td>	
	<td width=20% align=center>
	 <font color=white>
	  ������
	 </font>
	</td>
	<td width=20% align=center>
	 <font color=white>
	  ְλ
	 </font>
	</td>
	 
   </tr>
   
   <%  int id=0;
       String serialno="";
	   String name="";
	   String job="";
   ResultSet rs = aBean.executeQuery(" select * from CortrolMan ");
   int u = 0;
   while(rs.next()){
      id= rs.getInt("id");
	  serialno=rs.getString("serialno");
	  name=getbyte(rs.getString("name"));
	  job=getbyte(rs.getString("job"));
   	%>   	
	<tr class='listcontent'>
	 <td><input type=checkbox name=ic<%= u%> value="<%=serialno %>" ></td>
	 <td><%= serialno%></td>	
	 <td><%= name%></td>	  
	 <td><%= job%></td>
	 
	</tr>	
	<%
	u++;
   }
   rs.close();
   %>    
   <tr class='listcontent'>
    <td colspan=5>
     <input type=checkbox name=ca onclick="selectAll()"> &nbsp; ȫѡ/ȡ��
	</td>	
   </tr>	
 </table>
 
  <input type=hidden name=rows value=<%= u%> >
 
 	 <script lang=javascript>
	 	 function getseldocs2() {
     var x=0;
	 var seldocs = new Array();
	 var temp=form1.elements.length;
     for (i=0;i<form1.elements.length;i++) {
       if ((form1.elements[i].type=="checkbox")&&(form1.elements[i].checked))
		 { 
	 		  seldocs[x]=form1.elements[i].value;
			 
			x++;
   		 }
	  }	
      if (x>0){
	  
	  opener.window.document.form1.handler.value=seldocs;
	  window.close();
	  }else{
	  alert("��ѡ���û�");
	  }
}
		
		function selectAll()
		{		
		    if( document.forms[0].ca.checked ||document.forms[0].ca1.checked) {
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
		
	 </script>
	  
</body>
</html>

