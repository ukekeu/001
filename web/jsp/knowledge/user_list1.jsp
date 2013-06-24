<%@ page import = "java.sql.*" contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "组操作" , 
                  "浏览"
                ) ;
%>

<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase" />
 <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>	
	<LINK href="../class/news.css" rel=stylesheet>
	<title>
	   用户一览表
	</title>
 

</head>
<body>
<form name=form1 method=post>

 <p align=center class=FontColor>
  <font size=3>
   <b>
    用户一览表
   </b>
  </font>
 </p>
 
  <%String typeid=request.getParameter("id"); %>

<input type=button name=choose value="确 定" onclick="getseldocs2();">
 <table border=0 width=100% align=center  id=AutoNumber cellspacing=1 cellpadding=1 >
   <tr class=listtitle>
    <td width=5% align=center>
    <input type=checkbox name=ca1 onclick="selectAll(this.checked)" title="全选/取消"> &nbsp; 
	</td>	
	<td width=20% align=center>
	 <font color=white>
	  用户名
	 </font>
	</td>	
	<td width=20% align=center>
	 <font color=white>
	  中文名
	 </font>
	</td>
	
	 
   </tr>
   
   <%  int id=0;
       String serialno="";
	   String name="";
	   String job="";
	   String dept="";
   ResultSet rs = aBean.executeQuery(" select dept from CortrolMan group by dept");
   int u = 0;
   while(rs.next()){
      dept= getbyte(rs.getString("dept"));
	//  serialno=rs.getString("serialno");
	//  name=getbyte(rs.getString("name"));
	 // job=getbyte(rs.getString("job"));
   	%>   	
	<tr class='listcontent'>
	 <td colspan=3> <input type=checkbox name=ic<%= u%> value="<%=serialno %>"  onclick="choosedata('<%=u %>',this.checked);"><a  href="#" onclick="show(<%=u %>);"><%=dept %></a></td>
	
	</tr>	
	<%   ResultSet rs1 = aBean1.executeQuery(" select serialno,name from CortrolMan where dept='"+dept+"'");
    
   while(rs1.next()){ 
     serialno=rs1.getString("serialno");
	 name=getbyte(rs1.getString("name"));
   %>
   <div id="menu<%=u %>" style="display:none">
	<tr class='listcontent' id=tr<%=u %>>
	 <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=checkbox name=ic<%= u%> value="<%=serialno %>" ></td>
	 <td><%= serialno%></td>	
	 <td><%= name%></td>	  
   
	</tr>	
	<%}%>
	</div>
	<%
	rs1.close();
	u++;
   }
   rs.close();
   %>    
   <tr class='listcontent'>
    <td colspan=5>
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
	  
	  window.location="modi_knowlege_type_ac.jsp?id=<%=typeid %>&user="+seldocs;
	  
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

