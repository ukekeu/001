<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>�����տ�Ǽ�</title>
</head>

<body>
 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>

<%
//ȡ��FORM�������������
String strCusNo=request.getParameter("CusNo");
    //������תΪ����
	if (strCusNo!=null){
	 strCusNo=new String(strCusNo.getBytes("ISO8859_1"),"GBK");
	}
String strShouldQS=request.getParameter("ShouldQS");
    //������תΪ����
	if (strShouldQS!=null){
	 strShouldQS=new String(strShouldQS.getBytes("ISO8859_1"),"GBK");
	}
String strGatherDate=request.getParameter("BeginYear")+"-"+request.getParameter("BeginMonth")+"-"+request.getParameter("BeginDay");
String strShouldMoney=request.getParameter("ShouldMoney");

//��������ӵ����ݿ�
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
	out.print("�ÿͻ��ĸ���Ӧ�����Ѵ���&nbsp;&nbsp;<a href='javascript:window.history.back(1)'>����</a>");
	rsQ.close();
}else{
	try{
		InsertBean.executeUpdate(sql);
		 
		out.print("ϵͳ����Ӵ����ϵ�����&nbsp;&nbsp;<a href='GatherView.jsp'>����</a>");
	 
	}
	catch(Exception se){
		 
		 out.print("ϵͳ����ԭ�����£�<br>");
	     out.print(se.getMessage());
		 out.print(sql);
	     out.close();
		  
	}
}

//--Add End
%>

</body>
</html>
