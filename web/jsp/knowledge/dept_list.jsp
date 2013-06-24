<%@ page import = "java.sql.*" contentType="text/html;charset=GBK" %>
 
 <%@ include file="../public_js/checktime.jsp"%>

<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase" />
 <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>	
	<LINK href="../class/news.css" rel=stylesheet>
	<title>
	   部门名称一览表
	</title>
 

</head>
<body>
<form name=form1 method=post>

 <p align=center class=FontColor>
  <font size=3>
   <b>
    部门名称一览表
   </b>
  </font>
 </p>
 
  <%String typeid=request.getParameter("id"); %>

<input type=button name=choose value="确 定" onclick="getseldocs2();">
 <table border=0 width=100% align=center  id=AutoNumber cellspacing=1 cellpadding=1 >
   
   
   <%  int id=0;
       String serialno="";
	   String name="";
	   String job="";
	   String dept="";
   ResultSet rs = aBean.executeQuery(" select dept from CortrolMan group by dept");
   int u = 0;
   while(rs.next()){
      dept= getbyte(rs.getString("dept"));
	 
   	%>   	
	<tr class='listcontent'>
	 <td colspan=2> <input type=checkbox name=ic<%= u%> value="<%=dept %>"  onclick="choosedata('<%=u %>',this.checked);"><a  href="#" onclick="show(<%=u %>);"><%=dept %></a></td>
	
	</tr>	
	 
 
 
	<%
	 u++;
   }
   rs.close();
   %>    
   <tr class='listcontent'>
    <td colspan=2>
     <input type=checkbox name=ca onclick="selectAll(this.checked)"> &nbsp; 全选/取消
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
	  
	 opener.window.document.cus.dept.value=seldocs;
	  window.close();
	  }else{
	  alert("请选择用户");
	  }
}
	function choosedata(para1,para2) {
     var x=0;
 
	 var seldocs = new Array();
	 var temp=form1.elements.length;
     for (i=0;i<form1.elements.length;i++) {
       if ((form1.elements[i].type=="checkbox")&&(form1.elements[i].name=="ic"+para1))
		 { 
	 		 form1.elements[i].checked=para2;
 
   		 }
		 
    }
}	
function selectAll(para1)
		{		
		   var x=0;
 
	 var seldocs = new Array();
	 var temp=form1.elements.length;
     for (i=0;i<form1.elements.length;i++) {
       if ((form1.elements[i].type=="checkbox"))
		 { 
	 		 form1.elements[i].checked=para1;
 
   		 }
		 
      }
 }
 
	function show(dd){
  var  tr=document.all.AutoNumber.rows;

  for( var i=0;i<tr.length;i++){
    if (tr[i].id=="tr"+dd) 
	 tr[i].style.display=(tr[i].style.display=="none")?"block":"none";
	 
   }
  }
 
	 </script>
	  
</body>
</html>

