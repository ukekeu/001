
<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
 
<html>
<head>
	<title>导入价格</title>
</head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<body>
<%
String OK=getbyte1(request.getParameter("OK"));
String SecNo=getbyte1(request.getParameter("SecNo"));
String Loft=getbyte1(request.getParameter("Loft"));
try{
if (!OK.equals("")){
String payment=getbyte1(request.getParameter("payment"));
 
String ss="insert into 试算价目表 select '开盘虚拟价格',sectionno,loft,roomno,room,floors,price,";
ss+="price1,area,area1,sumprice,date,yong_tu,0,building,cell,0,1,0 from 试算价目表 where paymenttype=0  and sectionno='"+SecNo+"' and loft='"+Loft+"'  and  payment='"+payment+"'";
			 

		ViewBean1.executeUpdate(ss);
		
 

  %>
<script>
opener.window.location="PriceProjectList_xy.jsp?sel=1&SecNo=<%=SecNo %>&Loft=<%=Loft %>";
window.close();
</script>
<%
}
}catch(Exception e){out.print(e.getMessage());out.close();} %> 
<form name="frm" action="In_xy_Price.jsp">
<input type=hidden name="OK" value="00">
<input type=hidden name="payment" value="">
 <input type=hidden name=SecNo value="<%=SecNo %>">
<input type=hidden name=Loft  value="<%=Loft %>">
   <p align="center"><b><font size="3" color="#000080">销售虚拟价格方案一览</font></b></p>

   <table BORDER=0 width="100%"  CELLSPACING=1 CELLPADDING=3 ALIGN=center>
  <tr  class=TXTColor>
     
      <TD WIDTH="30%"> 
        <DIV ALIGN="CENTER">方案名称</DIV>
      </TD>
      <TD WIDTH="20%"  > 
        <DIV ALIGN="CENTER">试算时间</DIV>
      </TD>
       <TD WIDTH="30%" > 
        <DIV ALIGN="CENTER"> </DIV>
      </TD>
	    <TD WIDTH="20%" > 
        <DIV ALIGN="CENTER">操作</DIV>
      </TD>
    </TR>
	<% String str="select payment,convert(varchar(10),date,120) date,state,checkstate from  试算价目表 where paymenttype=0 and sectionno='"+SecNo+"' and loft='"+Loft+"' group by payment,convert(varchar(10),date,120),state,checkstate order by date";
        ResultSet rs = null;
		 rs = ViewBean1.executeQuery(str) ;
		 int i=0;
		while (rs.next()) {	
		i++;
		String name = getbyte(rs.getString("payment"));
		String name1 = getbyte(rs.getDate("date").toString());		
		int states=rs.getInt("state");		
		int checkstate=rs.getInt("checkstate");
   %>
    <tr  class='listcontent'id=TR<%=i %>  align="center"    onmouseover="mout(this);"  > 
    
	  <TD WIDTH="30%" >
        <DIV ALIGN="CENTER"><%= name %></DIV>
      </TD>
      <TD WIDTH="20%"  > 
        <DIV ALIGN="CENTER"><%= name1 %></DIV>
      </TD>
      <TD WIDTH="30%"  > 
        <DIV ALIGN="CENTER">
		<%if (states==1)out.print("<font color=red>目前销售价格</font>");
		 
		 %>
		 	 <a href="#" onclick="openwin('PriceListView.jsp?SecNo=<%=SecNo %>&Loft=<%=Loft %>&payment=<%=name  %>&state=<%=states %>')">预览</a>
		</DIV>
		
		 </TD>
	     <TD WIDTH="30%"  ><a href="#" onclick="document.frm.payment.value='<%=name %>';document.frm.submit();" >引用</a>  </td>
    </TR>
    <%
 }
		
   %>
   </table>
</form>
</body>
</html>
