<html>

 
<head>
<title>合同号管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script src="../sale/js/mad.js"> </script>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<script language="javascript" src="../public_js/public.js"></script>
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
 
 
	
 
%>
<body >
 　
<form name=frm method=post action="ContractNoM.jsp">
 

<DIV align=center id="printdiv">
<input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 </div>

 

  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
  <center>
   <table width="50%" cellpadding="0" cellspacing="0" border="0"> 
<tr align="center"> <td  ><font size=3><b><%=SecName %>作废合同号一览表</b></font></td></tr> 
</table>
<br>
 <table width="50%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
     <tr   > 
		<td  align="center">序号</td>
		<td  align="center">合同号</td>
	 
	 
   </tr>
  <%
   int num=0;
   int num2=0;
   String code="";
    String sql="SELECT count(*) num FROM ContractNo WHERE section='"+SecNo+"' and state=3";

   ResultSet rs = aBean.executeQuery(sql);
   if (rs.next())num=rs.getInt("num");
   
   rs.close();
   num2=num/2;
   num2=num-num2;
   num=num-num2;
   sql="SELECT *  FROM ContractNo WHERE section='"+SecNo+"' and state=3";
 rs = aBean.executeQuery(sql);
  int ii=1;
  int j=1;
 while (rs.next()){
     code=rs.getString("code");
    String ContractNo=rs.getString("ContractNo");
 
	 
   %>
     <tr  > 
     <td  align="center"><%=ii %></td>
	<td  align="center"><%=ContractNo %></td>
 
     </tr  > 
   <% 
  
   ii++;
   
 }
rs.close();
%> 
	  </table> 
	  
	  
	  
</body>
</html>
