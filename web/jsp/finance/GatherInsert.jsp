<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>新增收款登记</title>
</head>

<body>
 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>

<%
//取得FORM传输过来的数据
String strCusNo=request.getParameter("CusNo");
    //将数据转为中文
	if (strCusNo!=null){
	 strCusNo=new String(strCusNo.getBytes("ISO8859_1"),"GBK");
	}
String strShouldQS=request.getParameter("ShouldQS");
    //将数据转为中文
	if (strShouldQS!=null){
	 strShouldQS=new String(strShouldQS.getBytes("ISO8859_1"),"GBK");
	}
String strGatherDate=request.getParameter("BeginYear")+"-"+request.getParameter("BeginMonth")+"-"+request.getParameter("BeginDay");
String strShouldMoney=request.getParameter("ShouldMoney");

//将数据添加到数据库
String sql="";
    sql="insert into GatheringRecord (cusno,shouldQS,"; 
    sql=sql+"shouldDate,shouldMoney) values ";
	sql=sql+"('"+strCusNo+"','"+strShouldQS+"',";
	sql=sql+"'"+strGatherDate+"',"+strShouldMoney+")";
 
String sqlQ="";
	sqlQ="select * from GatheringRecord where cusno='"+strCusNo;
	sqlQ=sqlQ+"' and shouldQS='"+strShouldQS+"'";

ResultSet rsQ=InsertBean.executeQuery(sqlQ);

 
if(rsQ.next()){
	out.print("该客户的该期应交款已存在&nbsp;&nbsp;<a href='javascript:window.history.back(1)'>返回</a>");
	rsQ.close();
}else{
	try{
		InsertBean.executeUpdate(sql);
		 
		out.print("系统已添加此资料的数据&nbsp;&nbsp;<a href='GatherView.jsp'>返回</a>");
	 
	}
	catch(Exception se){
		 
		 out.print("系统出错，原因如下：<br>");
	     out.print(se.getMessage());
		 out.print(sql);
	     out.close();
		  
	}
}

//--Add End
%>

</body>
</html>
