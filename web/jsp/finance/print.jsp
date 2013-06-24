<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*"%> 
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="fBean1" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
 
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
	<title>打印付清楼款证明书</title>
</head>
 
<body>
<%
String strPara=request.getParameter("contractno");

String strSQL="update order_contract set zms=1 where code="+strPara;
fBean.executeUpdate( strSQL ) ;
String yfk=" ";
   ResultSet rs=null;
  rs=fBean1.executeQuery("select sum(CurrRate*factmoney) ff from  factGatheringRecord where   contractno = " +strPara);
  if (rs.next()){
  yfk=FormtD.getFloat3(rs.getDouble("ff"),2);
}
rs.close();
     String ldSQL="SELECT  O.jzarea,O.area,O.SECTIONNAME,O.LOFT+' '+O.ROOM_NO ROOM,O.ContractNo,O.rmbprice,C.cus_name,"+yfk+"/O.rmbprice*100 bl  FROM customer C,order_contract O  "
		 +"WHERE C.serialno=O.customer and O.code ="+strPara;
//out.print(ldSQL);
	    rs=fBean1.executeQuery(ldSQL);  
String tmpDoc = "zms.doc";
String url = "http://"+request.getServerName()+":"+request.getServerPort()+"/crm/jsp/finance/"+tmpDoc;
 if (rs.next()){
	/* ResultSet execRs=null;
String upperMoney="";
execRs=fBean.executeQuery("exec dbo.L2U "+rs.getString("rmbprice")+",1 ");//大写金额转换存储过程
if (execRs.next())
upperMoney=getbyte(execRs.getString("dd"));
execRs.close();
if (upperMoney.substring(0,1).equals("元"))
 upperMoney="零"+upperMoney;
*/
 StringBuffer sb = new StringBuffer();
sb.append("<document>");
sb.append("<doc url=\""+url+"\"/>");
sb.append("<bookmark name=\"A1\" value=\""+rs.getString("cus_name")+"\"/>");
sb.append("<bookmark name=\"A2\" value=\""+rs.getString("sectionname")+"\"/>");
sb.append("<bookmark name=\"A3\" value=\""+rs.getString("ROOM")+"\"/>");
sb.append("<bookmark name=\"A4\" value=\""+rs.getString("ContractNo")+"\"/>");
sb.append("<bookmark name=\"A5\" value=\""+rs.getString("jzarea")+"\"/>");
sb.append("<bookmark name=\"A6\" value=\""+rs.getString("rmbprice")+"\"/>") ;
sb.append("<bookmark name=\"A7\" value=\""+yfk+"\"/>") ;
sb.append("<bookmark name=\"A8\" value=\""+FormtD.getFloat2(rs.getDouble("bl"),2)+"\"/>") ;


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
