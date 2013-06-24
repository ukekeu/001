<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*"%> 
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="fBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
	<title>打印付清楼款证明书</title>
</head>
 
<body>
<%
String strPara=request.getParameter("contractno");
String strSQL="update rgsview set out=0";
fBean.executeUpdate( strSQL ) ;
strSQL="update rgsview set out=1 where code="+strPara;
fBean.executeUpdate( strSQL ) ;
strSQL="update order_contract set zms=1 where code="+strPara;
fBean.executeUpdate( strSQL ) ;

 
 
     String ldSQL="SELECT  O.jzarea,O.area,O.LOFT,O.floors,O.ROOM_NO ROOM,O.rmbprice,O.rmbprice-O.AJMONEY FIR,O.AJMONEY, C.cus_name   FROM customer C,order_contract O  "
		 +"WHERE C.serialno=O.customer and O.code ="+strPara;

	    ResultSet rs=null;
	    rs=fBean1.executeQuery(ldSQL);
	  
String tmpDoc = "zms1.doc";
String url = "http://"+request.getServerName()+":"+request.getServerPort()+"/crm/jsp/finance/"+tmpDoc;
 if (rs.next()){
     
	 ResultSet execRs=null;
String upperMoney="";
execRs=fBean.executeQuery("exec dbo.L2U "+rs.getString("rmbprice")+",1 ");//大写金额转换存储过程
if (execRs.next())
upperMoney=getbyte(execRs.getString("dd"));
execRs.close();
 upperMoney=upperMoney.substring(0,upperMoney.indexOf("元")+1);
//if (upperMoney.substring(0,1).equals("元"))
 //upperMoney="零"+upperMoney;
 StringBuffer sb = new StringBuffer();
 String zz="";
String lofts=rs.getString("LOFT");
if (lofts.indexOf("楼")>=0)
zz=lofts.substring(lofts.indexOf("楼")+1);
if (zz.equals(""))zz=" ";
sb.append("<document>");
sb.append("<doc url=\""+url+"\"/>");
sb.append("<bookmark name=\"A1\" value=\""+rs.getString("cus_name")+"\"/>");
sb.append("<bookmark name=\"A2\" value=\""+lofts+"\"/>");
sb.append("<bookmark name=\"A3\" value=\""+zz+"\"/>");
sb.append("<bookmark name=\"A4\" value=\""+rs.getString("floors")+"\"/>");
 sb.append("<bookmark name=\"A5\" value=\""+rs.getString("ROOM")+"\"/>");
sb.append("<bookmark name=\"A6\" value=\""+upperMoney+"\"/>") ;
 
sb.append("<bookmark name=\"A7\" value=\""+rs.getString("rmbprice")+"\"/>") ;
sb.append("<bookmark name=\"A8\" value=\""+rs.getString("FIR")+"\"/>") ;
sb.append("<bookmark name=\"A9\" value=\""+rs.getString("AJMONEY")+"\"/>") ;
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
