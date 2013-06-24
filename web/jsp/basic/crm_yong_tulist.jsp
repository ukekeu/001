<%@ page import = "java.sql.*" contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%> 

<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase" />
 <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>	
	<LINK href="../class/news.css" rel=stylesheet>
	<title>
	  用途览表
	</title>
 

</head>
<body>
<form name=form1 method=post>

 <p align=center class=FontColor>
  <font size=3>
   <b>
    用途览表
   </b>
  </font>
 </p>
 
 

<input type=button name=choose value="确 定" onclick="getseldocs2();">
 <table border=0 width=100% align=center  id=AutoNumber cellspacing=1 cellpadding=1 >
   <tr class=listtitle>
    
	<td width=20% align=center>
	 <font color=white>
	  用途
	 </font>
	</td>	
	 
	
	 
   </tr>
  <%
 String StrSql="select type,codename,bak from CODE where child=0  and type='YT' order by type";
   ResultSet codeRS=null;
  
    codeRS=aBean1.executeQuery(StrSql);
   int i=0;
   while (codeRS.next()){
    
	 i++;
   
 %>	
	<tr class='listcontent'>
	 <td colspan=3> <input type=radio name=ic<%= i%> value="<%=getbyte(codeRS.getString("codename")) %>" ><%=getbyte(codeRS.getString("codename")) %></td>
	
	</tr>	
	
	<%
	}
   codeRS.close();
   %>    
  
 </table>
 
  <input type=hidden name=rows value=<%= i%> >
 
 	 <script lang=javascript>
	 	  function getseldocs2() {
		 
     var x=0;
	 var seldocs = new Array();
	 var temp=form1.elements.length;
	
     for (i=0;i<form1.elements.length;i++) {
       if ((form1.elements[i].type=="radio")&&(form1.elements[i].checked))
		 { 
	 		  seldocs[x]=form1.elements[i].value;
			 
			x++;
   		 }
	  }	
	  if (x>0){opener.document.frm.yong_tu.value=seldocs;window.close();}
     
}
	 </script>
	  
</body>
</html>

