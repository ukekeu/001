<html>

 
<head>
<title>增加编号</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script src="../sale/js/mad.js"> </script>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/line.css" >
</head>
<script language="javascript" src="../public_js/public.js"></script>
<script language=javascript src="../public_js/basal.js"> </script>
  <%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
  <%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <%@ include file="../public_js/getByteOut.jsp"%>     
  <%@ include file="../public_js/qx_checke.jsp"%>
  
  
 

<body>
<% 
    String SecName=request.getParameter("SecName");
    String SecNo=request.getParameter("SecNo");
	String Loft= request.getParameter("Loft") ;
    String num=request.getParameter("num");
	String type=request.getParameter("type");
	if (num==null){
     SecName=request.getParameter("SecName");
     SecNo=request.getParameter("SecNo");
	 Loft= request.getParameter("Loft") ;
    }else{
	 SecName=China.getParameter(request,"SecName");
     SecNo=China.getParameter(request,"SecNo");
	 Loft= China.getParameter(request, "Loft") ;
	 String no1 = China.getParameter(request, "no1") ;
	 String no2 = China.getParameter(request, "no2") ;
	    if (!no1.equals("")){
	  for (int ii = java.lang.Integer.parseInt(request.getParameter("no1")); ii <=java.lang.Integer.parseInt(request.getParameter("no2")); ii++) {//依次增加合同号
	     
		   String AA="select * from ContractNo where ContractNo='"+ii+"' and section='"+SecNo+"'";
			  ResultSet rs=aBean.executeQuery(AA);
			  if (!rs.next()){
		     String SQL="insert into ContractNo(section,ContractNo,type) values(";
			        SQL+="'"+SecNo+"','"+ii+"',"+type+")";
					 
		           try{
				  aBean.executeUpdate(SQL);
					}catch(Exception s){out.print(s);}
					
					}rs.close();
		 
		   }
	   }
	   %>
	   <script>alert("已保存编号");opener.window.location.reload();window.close();</script>
	   <%
	}
	
 
%>
<body >
 
<form name=frm method=post action="ContractNoInput.jsp">
 <input type=hidden name="cusname" value="">
 <input type=hidden name="SecName" value="<%=SecName %>">
 <input type=hidden name=SecNo value="<%= SecNo %>" >
 <input type=hidden name=Loft value="<%= Loft %>" >
 <input type=hidden name=type value="<%= type %>" >
    <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1  >
		<!--<tr  class=TXTColor align="center"> 
			<td  >序号</td>
			<td  >合同号</td>
	    </tr>-->
		 <tr  class=listcontent align="center">
		 <td >起始编号</td><td><input type=text name=no1    onkeydown=" key(document.frm.no2);"  Onblur="check(this);"></td>
		 </tr>
		  <tr  class=listcontent align="center">
		 <td >终止编号</td><td><input type=text name=no2    Onblur="check(this);" ></td>
		 </tr>
		<!--<%
		//int jj=0;
		//for (int i=1 ;i<15;i++){ %>
	   <tr  class=listcontent align="center">
			<td ><%//=i %></td>
			<td  ><input type=text name=no<%//=i %>     onkeydown=" key(document.frm.no<%//=i+1 %>);"></td>
	    </tr>
		<%//jj=i;} %>
		-->
	</table>
	<input type=hidden name=num value="<%//=jj %>">
	<p align="center"><input type=button name=tj value="提 交" onclick="document.frm.submit();">	&nbsp;<input type=button name=cl value="退 出" onclick="if (confirm('确认吗?'))window.close();">	
    </p>
  </body>
</html>
