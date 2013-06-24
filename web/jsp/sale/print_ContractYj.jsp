<html>

 
<head>
<title>打印移交表</title>
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
    String SecName=getbyte1(request.getParameter("SecName"));
    String code= request.getParameter("code") ;
 
	//更新合同为移交状态
 
	aBean.executeUpdate("update order_contract set yj=1 where code in ("+code+")");
	
 
%>
<body > 
<form name=frm method=post action="ContractNoM.jsp">
  
 <%
 
  String sql="SELECT count(*) num FROM PrintReportContract  WHERE yj=1 and code in ("+code+")";

 %> 
  
 <DIV align=center id="printdiv">
 <!--<input class="buttoninput" type="button" value="打印预览" onclick="window.printdiv.style.display='none';factory.printing.Preview();"> -->
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
 <center> 
<table width="100%" cellpadding="0" cellspacing="0" border="0"> 
<tr> <td width="100%"> <div align="center"><font size=3><b><%=SecName %>移交表</b></font></div></td><td width="38%">&nbsp;</td></tr> 
</table><br>

  <%
   int num=0;
   int num2=0;
   int sumnum=1;
   ResultSet rs = aBean.executeQuery(sql);
   if (rs.next())num=rs.getInt("num");
   
   rs.close();
   num2=num/2;
   num2=num-num2;
   num=num-num2;
   sql="SELECT signatory,loft+Room_no room,ContractNo FROM PrintReportContract WHERE yj=1 and code in ("+code+")";

 rs = aBean.executeQuery(sql);
  int ii=1;
  int j=1;
 while (rs.next()){
     String cusname=getbyte(rs.getString("signatory"));
     String room=rs.getString("room");
    String ContractNo=rs.getString("ContractNo");
	 
   if (ii==1)%>
    <table width="100%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

       <tr> 
		<td  align="center">序号</td>
		<td  align="center">姓名</td>
		<td  align="center">房号</td>
		<td  align="center">合同号</td>
		<td  align="center">备注</td>
		<td  align="center">序号</td>
		<td  align="center">姓名</td>
		<td  align="center">房号</td>
		<td  align="center">合同号</td>
		<td  align="center">备注</td>
   </tr>
   
   <% 
   if (j==1){ %>
    
     <tr  > 
   <%}
  //  if (j==2){ out.print("<td  align='center'>&nbsp;</td>");}
    %>	 
	    <td  align="center"><%=sumnum %></td>
		<td  align="center"><%=cusname %></td>
		<td  align="center"><%=room %></td>
     	<td  align="center"><%=ContractNo %>&nbsp;</td>
        <td  align="center">&nbsp;</td>
		 	
	<%
	  j++;
	 if (j==3){ %>
     </tr  > 
   <%}  if (j==3){j=1;}
  
   ii++;
   sumnum++;
   if (ii==113){;ii=1;out.print("</table><br><br>");}
   
 }
rs.close();
 if (ii<113){ii=1;out.print("</table><br><br>");}
   
%> 
  <table width="100%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  
       <tr> 
		<td  align="center" colspan="2">合共<%=sumnum-1 %>本合同</td>
	 </tr>
	 <tr><td>移交人:</td><td>接收人:</td></tr>
	  <tr><td>日期:</td><td>日期:</td></tr> 
	</table>  
	  <br>
	  <script>
	  opener.window.location.reload();
	  
	  </script>
</body>
</html>
