<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "代收登记" , 
                  "增加"
                ) ;
%>

<html>
<head>
	<title>新增收款登记</title>
</head>
<body>
 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<%

//取得FORM传输过来的数据

String strCusNo=China.getParameter(request,"cusno");
String strNo=China.getParameter(request,"no");//合同号
String strGatherDate=request.getParameter("Date1");//+"-"+request.getParameter("BeginMonth")+"-"+request.getParameter("BeginDay");
String TAXNAME=China.getParameter(request,"TAXNAME");
String strFactMoney=request.getParameter("FactMoney");
String strBillType=China.getParameter(request,"BillType");
String strBillNum=China.getParameter(request,"BillNum");	
String strReceiver=China.getParameter(request,"Receiver");


String sql="";
String sqlS="";
String sql1="";
	sql="insert into RepGatheringRecord (cusno,type,"; 
	sql=sql+"InDate,InMoney,BillName,BillNo,Receiver,ContactNo) values ";
    sql=sql+"('"+strCusNo+"','"+TAXNAME+"','"+strGatherDate+"',";
   	sql=sql+strFactMoney+",'"+strBillType+"','"+strBillNum+"','"+strReceiver+"',"+strNo+")";
	
try{
		InsertBean.executeUpdate(sql);
}
	catch(Exception se){
	
	 //Print Error Message
	 out.print("系统出错，原因如下：<br>");
     out.print(se.getMessage()+sql);
     out.close();
	 //--Add End
	}

%> 

<script>
 function check(){
   parent.shList('FactInput');
   parent.location.reload();
 
 }
 check();
</script>
</body>
</html>
