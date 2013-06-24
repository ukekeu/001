 
<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
	<title>保存投诉登记</title>
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/>  
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/>  
 <%@ include file="../public_js/getByteOut.jsp"%>
<body>
<script language="javascript" src="../public_js/public.js">
</script>
<%
String section=getbyte1(request.getParameter("section"));
String customertype=getbyte1(request.getParameter("customertype"));
String customer=getbyte1(request.getParameter("customer"));
String tel=getbyte1(request.getParameter("tel"));
String room=getbyte1(request.getParameter("room"));
String addr=getbyte1(request.getParameter("addr"));
String tstype=getbyte1(request.getParameter("tstype"));
String tsdate=getbyte1(request.getParameter("tsdate"));
String title=getbyte1(request.getParameter("title"));
String context=getbyte1(request.getParameter("context"));
String options=getbyte1(request.getParameter("options"));
String TS_CODE=getbyte1(request.getParameter("TS_CODE"));
String dept=getbyte1(request.getParameter("dept"));
String sdate=getbyte1(request.getParameter("sdate"));
String edate=getbyte1(request.getParameter("edate"));
String comm_person=getbyte1(request.getParameter("comm_person"));
String clr=getbyte1(request.getParameter("clr"));
String tx=getbyte1(request.getParameter("tx"));
String wcdate=getbyte1(request.getParameter("wcdate"));
if (tx.equals(""))tx="0";
String num=getbyte1(request.getParameter("num"));
if (num.equals(""))num="0";
String SQL="";
String handler=(String)session.getAttribute("loginname");
if (options.equals("add")){
 SQL="INSERT INTO TS_SERVICER(TS_SECTION,TS_CUSTOMER,TS_ROOM,TS_TEL,TS_ADDR";
 SQL+=",TS_CUSTOMER_TYPE,TS_TYPE,TS_TITLE,TS_CONTEXT,TS_DATE,TS_HANDER) VALUES(";
 SQL+="'"+section+"','"+customer+"','"+room+"','"+tel+"','"+addr+"','"+customertype+"',";
 SQL+="'"+tstype+"','"+title+"','"+context+"','"+tsdate+"','"+handler+"')";


}else if (options.equals("PD")){ 
 SQL="update   TS_SERVICER set TS_COMM_DEPT='"+dept+"',TS_COMM_PERSON='"+comm_person;
 SQL+="',TS_COMM_DATE='"+sdate+"',TS_COMM_endDATE='"+edate+"',TS_FT="+tx;
 SQL+=",TS_TXTS="+num+" ,TS_STATE=1,TS_APDATE=getdate() WHERE ";
 SQL+=" TS_CODE="+request.getParameter("ts_code");
  
  

}else if (options.equals("edit")){ 
 SQL="update   TS_SERVICER set TS_SECTION='"+section+"',TS_CUSTOMER='"+customer;
 SQL+="',TS_ROOM='"+room+"',TS_TEL='"+tel+"',TS_ADDR='"+addr+"'";
 SQL+=",TS_CUSTOMER_TYPE='"+customertype+"',TS_TYPE='"+tstype+"'";
 SQL=",TS_TITLE='"+title+"',TS_CONTEXT='"+context+"',TS_DATE='"+tsdate+"' WHERE ";
 SQL+=" TS_CODE="+TS_CODE;
  
  
}else if (options.equals("wc")){ 
 SQL="update   TS_SERVICER set TS_END_CONTEXT='"+context+"',ts_clperson='"+clr;
 SQL+="',TS_END_DATE='"+wcdate+"', TS_STATE=2  WHERE ";
 SQL+=" TS_CODE="+request.getParameter("ts_code");
}
try{
  ViewBean.executeUpdate(SQL);
 }catch (Exception se){out.print("系统保存数据有误,原因如：");out.print(SQL+se);out.close();}
 %>
<script>
	alert("操作成功");
	opener.window.location.reload();
	close();
	
	</script>

</body>
</html>
