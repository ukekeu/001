<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>折扣记录明细</title>
<%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<%
String code=getbyte2(request.getParameter("code"));
String deletecode=getbyte2(request.getParameter("deletecode"));
 
  %>
</head> 

<body >
 
<form method="POST" name="cus" action=""  > 
		    <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
	  <tr bgcolor="#c0c0c0" align="center"><td>折扣类型</td><td>日期</td><td>计算方法</td><td>优惠</td><td>折扣</td><td>计算对象</td><td>总价</td><td>关系人</td><td>审核人</td><td>记录人</td><td>删除</td></tr>
	 
	  <%
	   String discSQL="SELECT * FROM  contract_disc  WHERE order_no='"+code+"' order by state desc";
	      
		   ResultSet      rs=ViewBean.executeQuery(discSQL);
				 int aaa12=0;
			  while (rs.next()){ 		aaa12++;	   
	  %>
	   <tr id=A<%=aaa12 %> align="center"  onmouseover="mout(this) ;changeclass1(this,'clickbg','#ffffff');" title="折扣备注:<%=rs.getString("disc_bak") %>"><td><%if (rs.getInt("state")==0){out.print("额外");}else{out.print("正常折扣");} %></td><td><%=rs.getDate("disc_date").toString() %></td>
	   <td><%=rs.getString("disc_type") %></td>
	   <td><%=rs.getString("youhui") %></td><td><%=rs.getString("disc") %></td><td><%=rs.getString("discObj") %></td>
	   <td><%=rs.getString("discPrice") %></td><td><%=rs.getString("discUnit") %></td><td><%=rs.getString("gxr") %></td><td><%=rs.getString("checker") %></td>
	    <td><%if (rs.getInt("ok")==0) {%><a href="disc.jsp?discPrice=<%=discPrice %>&code=<%=code %>&deletecode=<%=rs.getInt("code") %>&discUnit=<%=discUnit %>">删除</a><%} %></td>
	   
		 </tr>
	   <%}rs.close(); %>
	  </table>
   <script>
		function loca(){
		  
		    if (confirm("确认当前输入的数据吗？")){
		  if (Validate(document.cus)){
		    document.cus.action="disc.jsp";
		    document.cus.submit();
          }		
		  }
		}
		</script>
</form>     
       
       
       
</body>       
</html>       
