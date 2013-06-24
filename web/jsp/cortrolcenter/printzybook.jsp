<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>打印置业计划书</title>
</head>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="fa" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
 
	<%  
	String year=getbyte1(request.getParameter("year"));
	String paycode=getbyte1(request.getParameter("paylist"));
	String sumprice=getbyte1(request.getParameter("sumprice")); 
	String loft=getbyte1(request.getParameter("loft"));
	String roomno=getbyte1(request.getParameter("roomno"));
	String ajtype=getbyte1(request.getParameter("ajtype"));
	String saletype=getbyte1(request.getParameter("saletype"));
	String dktype=getbyte1(request.getParameter("dktype"));
    String discprice=getbyte1(request.getParameter("discprice"));
	String tnunitprice=getbyte1(request.getParameter("tnunitprice"));
	String unitprice=getbyte1(request.getParameter("jzunprice"));
	String jzarea=getbyte1(request.getParameter("jzarea"));
	String tnarea=getbyte1(request.getParameter("tnarea"));
	String ajk=getbyte1(request.getParameter("ajk"));
	String name=getbyte1(request.getParameter("name"));
	String custype=getbyte1(request.getParameter("custype"));
	String sqk=getbyte1(request.getParameter("sqk"));
	String ajcs=getbyte1(request.getParameter("cs"));
	double qsk=Double.parseDouble(discprice)*1.5/100;
	double thk=Double.parseDouble(discprice)*0.5/1000+5;
	if (custype.equals("1"))thk=80.00;
	double ajyhs=Double.parseDouble(ajk)*0.05/1000;
	double gff=ajyhs+thk+qsk;
	double yjk=Double.parseDouble(sqk)+gff-20000;
	 double djpay=0,djpay2=0,ce=0;
	   String pjpay="";
	if (year.equals(""))year="0";
	 String ajStr = "select id,year,MonthTax,yearTax,yong_tu,MonthPay,lx from ajllgkb  where type=3  and yong_tu=0 and year="+year;//where id >=" + String.valueOf(firstPos);
	ResultSet ajRS = aBean1.executeQuery(ajStr);	
 //平均法
	while (ajRS.next()) {// && i < pageSize)
	  pjpay=fa.getFloat3(Double.parseDouble(ajk)/10000*ajRS.getDouble("MonthPay"),0);
	  
	}
	ajRS.close();
	
	ajStr = "select id,year,MonthTax,yearTax,yong_tu,MonthPay,lx from ajllgkb  where type=2    and year="+year;//where id >=" + String.valueOf(firstPos);
	  ajRS = aBean1.executeQuery(ajStr);	
  //递减法
	while (ajRS.next()) {
	  djpay=Double.parseDouble(ajk)/10000*ajRS.getDouble("MonthPay");
	}
	ajRS.close();
	ajStr = "select id,year,MonthTax,yearTax,yong_tu,MonthPay,lx from ajllgkb  where type=2    and year=1+"+year;//where id >=" + String.valueOf(firstPos);
	  ajRS = aBean1.executeQuery(ajStr);	
  
	while (ajRS.next()) {
	  djpay2=Double.parseDouble(ajk)/10000*ajRS.getDouble("MonthPay");
	}
	ajRS.close();
	ce=djpay-djpay2;
	 
String tmpDoc = "zy.doc";
String url = "http://"+request.getServerName()+":"+request.getServerPort()+"/zlcrm/jsp/cortrolcenter/"+tmpDoc;
 
 StringBuffer sb = new StringBuffer();
sb.append("<document>");
sb.append("<doc url=\""+url+"\"/>");
sb.append("<bookmark name=\"TT\" value=\""+name+"\"/>");
sb.append("<bookmark name=\"A1\" value=\""+loft+roomno+"\"/>");
sb.append("<bookmark name=\"A2\" value=\""+fa.getFloat2(Double.parseDouble(sumprice),0)+"元\"/>");
sb.append("<bookmark name=\"A3\" value=\""+fa.getFloat2(Double.parseDouble(discprice),0)+"元\"/>");
sb.append("<bookmark name=\"A4\" value=\""+fa.getFloat2(Double.parseDouble(jzarea),2)+"\"/>");
sb.append("<bookmark name=\"A5\" value=\""+fa.getFloat2(Double.parseDouble(unitprice),2)+"元\"/>");
sb.append("<bookmark name=\"A6\" value=\""+fa.getFloat2(Double.parseDouble(tnarea),2)+"\"/>");
sb.append("<bookmark name=\"A7\" value=\""+fa.getFloat2(Double.parseDouble(tnunitprice),2)+"元\"/>");
sb.append("<bookmark name=\"A8\" value=\""+fa.getFloat2(Double.parseDouble(ajk),0)+"\"/>");
sb.append("<bookmark name=\"A9\" value=\""+fa.getFloat2(Double.parseDouble(sqk),2)+"\"/>");
sb.append("<bookmark name=\"A10\" value=\""+fa.getFloat2(gff,0)+"\"/>") ;
sb.append("<bookmark name=\"A11\" value=\""+fa.getFloat2(yjk,0)+"\"/>") ;
sb.append("<bookmark name=\"A12\" value=\"每月的供款数一样\"/>") ;
sb.append("<bookmark name=\"A13\" value=\" \"/>") ;//"+fa.getFloat3(djpay,0)+"元/首月
sb.append("<bookmark name=\"A14\" value=\" \"/>") ;//每月平均约递减
 sb.append("<bookmark name=\"A15\" value=\""+pjpay+"元/每月\"/>") ;
 sb.append("<bookmark name=\"A16\" value=\""+ajcs+"成"+year+"年\"/>") ;
sb.append("<bookmark name=\"B1\" value=\""+fa.getFloat2(qsk,0)+"\"/>") ;
sb.append("<bookmark name=\"B2\" value=\""+fa.getFloat2(thk,0)+" \"/>") ;
sb.append("<bookmark name=\"B3\" value=\""+fa.getFloat2(ajyhs,0)+" \"/>") ;
sb.append("<bookmark name=\"B4\" value=\""+fa.getFloat2(gff,0)+" \"/>") ;
sb.append("</document>");
out.println(sb.toString());
	   %>
	   <OBJECT ID="BookmarkRplr" CLASSID="CLSID:D5D79C43-201A-4064-93A5-8FA6F768DF9E"
CODEBASE="liwbr32.CAB#version=1,1,0,3"></OBJECT>

 
<div id="renderMessage">正在下载...</div>
<script event="onload" for="window">
	execute();
	window.close();
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

 