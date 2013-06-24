    <%@ page contentType="text/html;charset=GBK" %>
<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
<title>收款保存</title>
</head>
<body>
 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
 <%@ include file="../public_js/logrecord.jsp" %>
<%

//取得FORM传输过来的数据

String strCusNo=China.getParameter(request,"cusno");
String para   =China.getParameter(request,"para");
String code   =China.getParameter(request,"code");
String room   =China.getParameter(request,"room");
String strGatherDate=request.getParameter("Date1");//+"-"+request.getParameter("BeginMonth")+"-"+request.getParameter("BeginDay");
String strFactMoney=request.getParameter("FactMoney");
String strReceiver=China.getParameter(request,"Receiver");
String contractno=China.getParameter(request,"contractno");
String ajbk=China.getParameter(request,"ajbk");
String ajtype=China.getParameter(request,"ajtype");
String pjno=China.getParameter(request,"pjno");
String FactMoneyType =China.getParameter(request,"FactMoneyType");
String sql="";
String sqlS="";
String sql1="";
String logmess="";
if (para.equals("")){

sql="insert into FactAjCharges (Customer,"; 
sql=sql+"FactDate,FactMonye,Chekcer,contractno,ajbk,aj_type,pjno,FactMoneyType)values ";
    sql=sql+"('"+strCusNo+"','"+strGatherDate+"',";
    sql=sql+strFactMoney+",'"+strReceiver+"',"+contractno+",'"+ajbk+"',"+ajtype+",'"+pjno+"',"+FactMoneyType+")";
	logmess="放款登记";
}else{
    sql="update FactAjCharges set FactDate='"+strGatherDate+"'";
sql+=",FactMonye="+strFactMoney+",pjno='"+pjno+"',Chekcer='"+strReceiver+"',ajbk='"+ajbk+"',aj_type= "+ajtype+",FactMoneyType="+FactMoneyType ;
sql+=" where id="+code;
if (contractno==null)contractno="";
if (contractno.equals(""))contractno=code;
logmess="修改放款登记";
} 
try{           
  
InsertBean.executeUpdate(sql);
sql="update order_contract set fkdate='"+strGatherDate+"',ajbk='"+ajbk+"'";
if (ajtype.equals("0")){
sql+=",sydk="+strFactMoney;
sql+=",gjj=0";
}else if (ajtype.equals("1")){
sql+=",sydk=0";
sql+=",gjj="+strFactMoney;
}else if (ajtype.equals("2")&&FactMoneyType.equals("1")){ 
sql+=",gjj="+strFactMoney;
}else if (ajtype.equals("2")&&FactMoneyType.equals("0")){
sql+=",sydk="+strFactMoney;
}
sql+=" where code="+contractno;
 
InsertBean.executeUpdate(sql);
 setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                 logmess, 
                  "放款"+room
                ) ;	
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
   alert("已保存放款数据");
   opener.document.f1.submit(); 
  
 
 }
 check();
 window.close();
</script>
</body>
</html>
 
