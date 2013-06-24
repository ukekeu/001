<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
  <%@ page import="java.sql.*, common.*,java.util.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
   <jsp:useBean id="setpro" scope="session" class="setProperty.setProperty"/>   
    <jsp:useBean id="FormtD1" scope="page" class="test.BarChartDemo"/>  
 
<%@ include file="../public_js/getByteOut.jsp"%>

<html>
<head>
	<title>发送待批信息</title>
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>

<body>
<form name="frm" action="sendCheckMessage.jsp">
<%
    String SecNo=getbyte1(request.getParameter("SecNo"));
	String Loft= getbyte1(request.getParameter("Loft")) ;
	String Build= getbyte1(request.getParameter("Build")) ;
	String payment=getbyte1(request.getParameter("payment")) ;
	String checker=getbyte1(request.getParameter("checker")) ;
	if (!checker.equals("")){
	  String sql="insert into checkData(type,person,payemnt,sendperson,secno,loft) values(";
	         sql+="1,'"+checker+"','"+payment+"'";
			  sql+=",'"+(String)session.getAttribute("loginname")+"','"+SecNo+"','"+Loft+"')";
	           aBean.executeUpdate(sql);
			 
			  sql="update 试算价目表 set checkstate=2 where paymenttype=0 and  sectionno='"+SecNo+"' and loft='"+Loft+"' and payment='"+payment+"'";
	          aBean.executeUpdate(sql);
			   
            %> <script>
			  opener.window.location="PriceProjectList.jsp?SecNo=<%=SecNo %>&Loft=<%=Loft %>";
			  window.close();
              </script>
               <% 
             
	}
    String SQL="SELECT * FROM CortrolMan WHERE job like'%经理%' or job like'%总经理%' or job like'%副总经理%' or job like'%总监%'";
    ResultSet rs = aBean.executeQuery(SQL);
   

 %>
     <input type=hidden name=SecNo value="<%=SecNo %>">
    <input type=hidden name=Loft value="<%=Loft %>">
    <input type=hidden name=payment value="<%=payment %>">
    <input type=hidden name=Build value="<%=Build %>">
 <table width="80%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
     <tr   > 
		<td  align="center">请选择审批人:</td>
		 <td  align="center">
		 <select name=checker>
		 <% while (rs.next()){ %>
		 <option value="<%=rs.getString("serialno") %>"><%=rs.getString("name") %></option>
		 <%}rs.close(); %>
		 </select></td>
		</tr>
</table>
<input type=submit name=check value="发送审批">&nbsp;<input type=button name=cancel value="退出" onclick="window.close();">
</form>


</body>
</html>
