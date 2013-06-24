<html>

 
<head>
<title>合同号管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script src="../sale/js/mad.js"> </script>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<script language="javascript" src="../public_js/public.js"></script>
  <%@ page contentType="text/html;charset=GBK" %>
  <%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <%@ include file="../public_js/getByteOut.jsp"%>     
  <%@ include file="../public_js/qx_checke.jsp"%>
  <%@ include file="../public_js/checktime.jsp"%>
  
 

<body>
<% 
    String Cortrol=checke_qx(aBean,(String)session.getAttribute("loginid"),"A002");
    String SecName=China.getParameter(request,"SecName");
    String SecNo=China.getParameter(request,"Section");
	String Loft= China.getParameter(request, "Loft") ;
	String Build=China.getParameter(request,"Build");
 
%>
<body >
 <script>
	function findSub(para){
	   document.frm.action=para;
	   document.frm.submit();
	}
	function findSub1(para){
	   document.frm.action=para+"?SecNo=<%=SecNo %>&Loft=<%=Loft %>&SecName=<%=SecName %>";
	   document.frm.submit();
	}
	function addcom(){
	openwin("ContractNoInput.jsp?type=0&SecNo=<%=SecNo %>&SecName=<%=SecName %>",400,200,350,250);
	// retval = window.showModalDialog("ContractNoInput.jsp?SecNo=<%=SecNo %>","","dialogWidth:300px; dialogHeight:450px; dialogLeft:400px; dialogTop:250px; status:no; directories:yes;scrollbars:no;Resizable=no; "  );
	}
</script>
<form name=frm method=post action="RgNoM.jsp">
 <input type=hidden name="cusname" value="">
 <input type=hidden name="SecName" value="<%=SecName %>">
 <input type=hidden name=Section value="<%= SecNo %>" >
 <input type=hidden name=Build value="<%= Build %>" >
 <input type=hidden name=Loft value="<%= Loft %>" >
 <%

 String checkedStr="";
 String checkedStr1="";
 String checkedStr2="";
 String jzstate="";
 String cedate ="";
 String cbdate ="";
 cbdate = China.getParameter(request, "cbdate" ) ;
 cedate = China.getParameter( request,"cedate" ) ;
 String state=request.getParameter("state");
 if (state==null)state="1"; 

 if (state.equals("2")){jzstate="2";checkedStr="checked";checkedStr1="";checkedStr2="";}
 else if (state.equals("1")){jzstate="1";checkedStr1="checked";checkedStr="";checkedStr2="";}
 else if (state.equals("3")){jzstate="";checkedStr2="checked";checkedStr="";checkedStr1="";}
 String sel=(String)request.getParameter("sel");
 if(sel==null) sel="1";	  
  String sql="SELECT count(*) num FROM ContractNo WHERE type=0 and section='"+SecNo+"' and state="+state;
 
 %> 

<table width="180" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=0;findSub1('RoomCodeShow.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>认购登记</font> </a>
	</td>
	  <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;findSub('RgNoM.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>认购号管理</font></a>
	</td>
	 
   </tr>
<input type=hidden name=sel value="<%=sel%>">
 </table>
   <br>
 <table width="100%" cellpadding="0" cellspacing="0" border="0"> 
<tr> <td width="100%"> <div align="center"><font size=3><b><%=SecName %>认购号一览表</b></font></div></td><td width="38%">&nbsp;</td></tr> 
</table>
<br>
  <input <%=checkedStr1 %> type=radio name=state value="1" onclick="document.frm.submit();">未使用 <input type=radio name=state value="2" <%=checkedStr %> onclick="document.frm.submit();">已使用号
  <input <%=checkedStr2 %> type=radio name=state value="3" onclick="document.frm.submit();">作废号
 
    <%if (!state.equals("3")){ %>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
 <%} %>
   <input type=button name=addc value="增加认购号" onclick="addcom();">&nbsp; <%if (state.equals("3")){ %><input type=button name=addc value="打印作废认购号" onclick="openwin1('printZFNO.jsp?SecName=<%=SecName %>&Loft=<%=Loft %>&SecNo=<%=SecNo %>');"><%} %>
   <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
     <tr  class=TXTColor> 
		<td  align="center">序号</td>
		<td  align="center">合同号</td>
		<td  align="center">使用状态</td>
		<td  align="center">作废</td>
		<td  align="center">&nbsp;</td>
		<td  align="center">序号</td>
		<td  align="center">合同号</td>
		<td  align="center">使用状态</td>
		<td  align="center">作废</td>
   </tr>
  <%
   int num=0;
   int num2=0;
   String code="";
   ResultSet rs = aBean.executeQuery(sql);
   if (rs.next())num=rs.getInt("num");
   
   rs.close();
   num2=num/2;
   num2=num-num2;
   num=num-num2;
   sql="SELECT *  FROM ContractNo WHERE type=0 and section='"+SecNo+"' and state="+state;
 rs = aBean.executeQuery(sql);
  int ii=1;
  int j=1;
 while (rs.next()){
     code=rs.getString("code");
    String ContractNo=rs.getString("ContractNo");
	state=rs.getString("state");
	if (state.equals("1"))state="未使用";
	else if (state.equals("2"))state="已使用";
	else if (state.equals("3"))state="作废";
 
   if (j==1){ %>
     <tr  > 
   <%}
    if (j==2){ out.print("<td  align='center'>&nbsp;</td>");}
    %>	 
	    <td  align="center"><%=ii %></td>
		<td  align="center"><%=ContractNo %></td>
		<td  align="center"><%=state %></td>
		<%if (state.equals("作废")){ %>
		<td  align="center"><a href="#" onclick="if (confirm('确认恢复吗？'))openwin('modiContractNo.jsp?yy=1&code=<%=code %>',10,10,10,10);">恢复</a></td>
	    <%}else if (state.equals("未使用")) {  %>
		<td  align="center"><a href="#" onclick="if (confirm('确认作废吗？'))openwin('modiContractNo.jsp?yy=3&code=<%=code %>',10,10,10,10);">作废</a></td>
	    <%}else if (state.equals("已使用")) {  %><td  align="center"><a href="#" onclick="if (confirm('确认作废吗？'))openwin('modiContractNo.jsp?yy=3&code=<%=code %>',10,10,10,10);">作废</a></td><%} %>
		
	<%
	  j++;
	 if (j==3){ %>
     </tr  > 
   <%}  if (j==3){j=1;}
  
   ii++;
   
 }
rs.close();
%> 
	  </table> 
	  
	  
	  
</body>
</html>
