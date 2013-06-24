<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>打印发票</title>
</head>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase"/>

<%@ include file="../public_js/getByteOut.jsp"%>
 
<%  
  String contractno=getbyte1(request.getParameter("contractno"));
 
     String ldSQL="SELECT P.AreaNo,O.jzarea,O.SECTIONNAME+O.LOFT+O.ROOM_NO ROOM,O.unitprice,O.rmbprice,year(F.invoice_date) year,month(F.invoice_date) month,day(F.invoice_date) day,O.ContractNo,C.cus_name ,F.invoice_money  FROM F_invoice  F,customer C,order_contract O,CRM_PROJECT P  "
		 +"WHERE C.serialno=O.customer and o.state<>3 and  F.order_contract = O.code and P.SerialNo=O.SECTION AND F.code ="+contractno;
 
	    ResultSet rs=null;

	    rs=aBean.executeQuery(ldSQL);
	  
String tmpDoc = "printword1.doc";
String url = "http://"+request.getServerName()+":"+request.getServerPort()+"/crm/jsp/finance/"+tmpDoc;
 if (rs.next()){
     
	 ResultSet execRs=null;
String upperMoney="";
execRs=aBean1.executeQuery("exec dbo.L2U "+rs.getString("rmbprice")+",0 ");//大写金额转换存储过程
if (execRs.next())
upperMoney=getbyte(execRs.getString("dd"));
execRs.close();
if (upperMoney.substring(0,1).equals("元"))
 upperMoney="零"+upperMoney;
 StringBuffer sb = new StringBuffer();
sb.append("<document>");
sb.append("<doc url=\""+url+"\"/>");
sb.append("<bookmark name=\"A1\" value=\""+rs.getString("cus_name")+"\"/>");
sb.append("<bookmark name=\"A2\" value=\""+rs.getString("year")+"\"/>");
sb.append("<bookmark name=\"A3\" value=\""+rs.getString("month")+"\"/>");
sb.append("<bookmark name=\"A4\" value=\""+rs.getString("DAY")+"\"/>");
sb.append("<bookmark name=\"A5\" value=\""+rs.getString("AreaNo")+"\"/>");
sb.append("<bookmark name=\"A6\" value=\""+rs.getString("ContractNo")+"\"/>");
sb.append("<bookmark name=\"A7\" value=\""+rs.getString("ROOM").trim()+"\"/>");
sb.append("<bookmark name=\"A8\" value=\""+rs.getString("jzarea")+"\"/>");
sb.append("<bookmark name=\"A9\" value=\""+rs.getString("unitprice")+"\"/>");
sb.append("<bookmark name=\"A10\" value=\""+rs.getString("rmbprice")+"\"/>") ;
sb.append("<bookmark name=\"A11\" value=\""+upperMoney+"\"/>") ;
sb.append("<bookmark name=\"A12\" value=\""+rs.getString("rmbprice")+"\"/>") ;
sb.append("<bookmark name=\"A13\" value=\""+(String)session.getAttribute("loginname")+"\"/>") ;
sb.append("</document>");
out.println(sb.toString());
	   %>
	   <OBJECT ID="BookmarkRplr" CLASSID="CLSID:D5D79C43-201A-4064-93A5-8FA6F768DF9E"
CODEBASE="liwbr32.CAB#version=1,1,0,3"></OBJECT>

 
<div id="renderMessage">正在下载...</div>
<script event="onload" for="window">
	execute();
</script>
<script language="javascript">
function execute(){
    BookmarkRplr.XMLString='<%=sb.toString()%>';
	BookmarkRplr.execute();
	while (BookmarkRplr.Busy){
		document.all.renderMessage.innerHTML = BookmarkRplr.Message;
	}
	document.all.renderMessage.innerHTML = BookmarkRplr.Message;
	//location.href="?"
}
</script>
<input type="submit" value="如果下载数据不成功或者长时间停顿，请重新点击这个按钮尝试..." onclick="execute();">
 
	<%
	rs.close();
	} 
	%>
</body>
</html>

 