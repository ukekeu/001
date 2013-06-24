<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>打印收据</title>
</head>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 

<%@ include file="../public_js/getByteOut.jsp"%>
 
<%  
  String contractno=getbyte1(request.getParameter("contractno"));
  String Date1=request.getParameter("Date1");
  String Date2=request.getParameter("Date2");
  String SecNo=request.getParameter("SecNo");
  String  sql="select sum(FactMonye) fact from FactAjCharges  ";
	sql+=" where   contractno in (select code from order_contract where section='"+SecNo+"')";
	sql+="  and   convert(char(10), FactDate,120)>='"+Date1+"' and  convert(char(10), FactDate,120)<='"+Date2+"'";
 double money=0;

		 ResultSet rs=null;
	    rs=aBean.executeQuery(sql);	
		if (rs.next()){
		  money=rs.getDouble("fact");
		}
		rs.close();	
	sql="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
	sql+=" where  f.ContractNo  in (select code from order_contract where section='"+SecNo+"')";
	sql+=" and  convert(char(10),f.Gather_Date,120)>='"+Date1+"' and  convert(char(10),f.Gather_Date,120)<='"+Date2+"'";
		  rs=aBean.executeQuery(sql);	
		if (rs.next()){
		  money+=rs.getDouble("fact");
		}
		rs.close();	
  
	   
	  
String tmpDoc = "";
String type=request.getParameter("type");
if (type.equals("1"))tmpDoc ="tdzzns.doc";
else tmpDoc ="tdzzqs.doc";

 
String url = "http://"+request.getServerName()+":"+request.getServerPort()+"/crm/jsp/finance/"+tmpDoc;
/*     
 ResultSet execRs=null;
String upperMoney="";
execRs=aBean1.executeQuery("exec dbo.L2U "+rs.getString("rmbprice")+",1 ");//大写金额转换存储过程
if (execRs.next())
upperMoney=getbyte(execRs.getString("dd"));
execRs.close();
if (upperMoney.substring(0,1).equals("元"))
 upperMoney="零"+upperMoney;
 */
 StringBuffer sb = new StringBuffer();
sb.append("<document>");
sb.append("<doc url=\""+url+"\"/>");
sb.append("<bookmark name=\"A1\" value=\""+FormatD.getFloat2(money,2)+"\"/>");
 
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
 
	 
</body>
</html>

 