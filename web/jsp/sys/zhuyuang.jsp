<%@ page import = "java.sql.*" contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "���Ա����" , 
                  "���"
                ) ;
%>

  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase" />
   <%@ include file="../public_js/getByteOut.jsp"%> 
<html>
<head>
    <LINK href="../class/news.css" rel=stylesheet>
	<title>
	   �����
	</title>
</head>
<body  oncontextmenu="return false">
<form name=f1 method=post>

<p align=center class=FontColor>
 <font size=3>
  <b>
   ���Ա����
  </b>
 </font>
</p>

<table width=100% border="0">
  <tr height="16" bgcolor="#EAEAEA">
   <td align="left">
    <input type=button value="   �������Ա   "  onclick="zy_add_i()">
    <input type=button value="   ɾ�����Ա   " onclick="zy_del_i()">		 
    <input type=button value="   �鿴���Ա  " onclick="zy_look()">
   </td>
  </tr>
 </table>
 
 <table border=0 width=100% align=center cellpadding=1 cellspacing=1 >
   <tr align=center class=listtitle>
    <td width=34% align=center>
	 <font color=white>ѡ��һ����</font>
	</td> 
		
	<td width=66% align=center>
	 <font color=white>����</font>
	</td>  
   </tr>
   
   <%

   ResultSet rs = aBean1.executeQuery("select tid , tname from team where towner = '" + "steven" + "'");
   int u = 0;
   while(rs.next()){
   	%>
	<tr class='listcontent'>
	 <td><input type=radio name=zhuradio value=<%= rs.getInt(1)%> ></td>
	 <td><%= getbyte ( rs.getString(2) )%></td>	 
	</tr>	
	<%
	u++;
   }
   rs.close();
   %> 
 </table>
 
 
</form>
<script lang=javascript>
function zy_add_i()
{
    <%
    if( u > 0 ) {
    %>
    	var isSelected = false;
    	var rb;
    	
    	var oneRadio = false ;    	
    	if( document.forms[0].zhuradio[0] == null ) {
    	    oneRadio = true ;
    	}
    	
    	if( oneRadio ) {
    		if ( document.forms[0].zhuradio.checked ) {
    			isSelected = true;
    		}    	    
    	}else{
        	for (var i = 0; i < document.forms[0].zhuradio.length; i++ ) {
          		rb = document.forms[0].zhuradio[i];
        		if (rb.checked) {
        			isSelected = true;
        		}
            }                	
    	}

    	if( isSelected ) {
    		document.f1.action="zy_add_i.jsp";
    		document.f1.submit();
    	}else{
    		alert("��ѡ��һ����!");
    	}
    <%
    }else{
    %>
        alert( "û�������!��������һ����" ) ;
    <%
    }
    %>
}

function zy_del_i(){
    <%
    if( u > 0 ) {
    %>
        var isSelected = false;
        var rb;

    	var oneRadio = false ;    	
    	if( document.forms[0].zhuradio[0] == null ) {
    	    oneRadio = true ;
    	}
    	
    	if( oneRadio ) {
    		if ( document.forms[0].zhuradio.checked ) {
    			isSelected = true;
    		}    	    
    	}else{
            for (var i = 0; i < document.forms[0].zhuradio.length; i++ ) {
            	rb = document.forms[0].zhuradio[i];
            	if (rb.checked) {
            		isSelected = true;
            	}
            }    	
    	}
    	
        if( isSelected ) {
        	document.f1.action="zy_del_i.jsp";
        	document.f1.submit();
        }else{
        	alert("��ѡ��һ����!");
        }	
    <%
    }else{
    %>
        alert( "û�������!��������һ����" ) ;
    <%
    }
    %>
}

function zy_look()
{
    <%
    if( u > 0 ) {
    %>
    	var isSelected = false;
    	var rb;
    	
    	var oneRadio = false ;    	
    	if( document.forms[0].zhuradio[0] == null ) {
    	    oneRadio = true ;
    	}
    	
    	if( oneRadio ) {
    		if ( document.forms[0].zhuradio.checked ) {
    			isSelected = true;
    		}    	    
    	}else{
        	for (var i = 0; i < document.forms[0].zhuradio.length; i++ ) {
          		rb = document.forms[0].zhuradio[i];
        		if (rb.checked) {
        			isSelected = true;
        		}
            }    	
    	}    	

    	if( isSelected ) {
    		document.f1.action="zy_look.jsp";
    		document.f1.submit();
    	}else{
    		alert("��ѡ��һ����!");
    	}	    
    <%
    }else{
    %>
        alert( "û�������!��������һ����" ) ;
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
alert("���Աɾ���ɹ�!");
</script>
<%
}else if( request.getParameter ("delete") != null && request.getParameter("delete").equalsIgnoreCase("false") ){
%>
<script lang=javascript>
alert("ɾ�����Աʱ�����˴���,����Լ���!");
</script>
<%
}else if( request.getParameter ("add") != null && request.getParameter("add").equalsIgnoreCase("true") ){
%> 
<script lang=javascript>
alert("��Ա��ӳɹ�!");
</script>
<%}else if( request.getParameter ("add") != null && request.getParameter("add").equalsIgnoreCase("false") ){
%>
<script lang=javascript>
alert("�����Աʱ�����˴���,����Լ���!");
</script>
<%
}
%>

