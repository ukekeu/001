<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<title>无销售记录新增收款登记</title>
</head>
<body>
 <%@ page language="java" import="java.sql.*,java.util.Date,java.lang.*,java.util.*,common.*"%>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="tBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="fat" scope="page" class="FormatData.FormatData"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
 <%
 setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "无销售记录实收登记" , 
                  "增加"+China.getParameter(request,"loft")
                ) ;
//取得FORM传输过来的数据

String strCusNo=China.getParameter(request,"cus_name");
String type=China.getParameter(request,"type");
String SecNo=China.getParameter(request,"SecNo");
String loft=China.getParameter(request,"loft");
String RoomNo=China.getParameter(request,"RoomNo");
String StrFactNo=China.getParameter(request,"FactNo");
String strPeriod=type;//China.getParameter(request,"Period");
String strysmoney=request.getParameter("ysmoney");
String strGatherDate=request.getParameter("Date1");//+"-"+request.getParameter("BeginMonth")+"-"+request.getParameter("BeginDay");
String strFactMoney=request.getParameter("FactMoney");
String strBillType=China.getParameter(request,"BillType");
String strBillNum=China.getParameter(request,"BillNum");	
String strReceiver=China.getParameter(request,"Receiver");
String PayType=China.getParameter(request,"PayType");
String PayTypeNo=China.getParameter(request,"PayTypeNo");
String phone=China.getParameter(request,"phone");
String zjh=China.getParameter(request,"zjh");
 String jzarea=China.getParameter(request,"area");
  String zj=China.getParameter(request,"zj");

//当前付款的币别
String CurrName=China.getParameter(request,"curry");
String CurrRate=China.getParameter(request,"rate");
//合同中的币别
String ycurry=request.getParameter("ycurry");
String yrate=request.getParameter("yrate");

String Print=China.getParameter(request,"Print");
 
String txt=China.getParameter(request,"context");//bak
 
 String huanshuanMoney="";//把当前付款的币别换算为合同款对应的币别金额
 
	 
	String curryDX="";
	if (CurrName.equals("RMB"))curryDX="人民币";
	if (CurrName.equals("HKD"))curryDX="港币";
	if (CurrName.equals("USD"))curryDX="美元";
	String upSQL="";
//实际交款

ResultSet execRs1=null;
String upperMoney1="";
String strFactMoney2=strFactMoney;
	

 

 
        upSQL="insert into linshi_sk (sectionno,loft,room_code,cus_name,"; 
        upSQL+="phone,cus_no,sk_type,sk_date,sk_money,pay_type,sk_no,sk_person,CurrRate,CurrName,bak,jzarea,rmbprice) ";
        upSQL+=" values ";
        upSQL+="('"+SecNo+"','"+loft+"','"+RoomNo+"','"+strCusNo+"'";
     	upSQL+=",'"+phone+"','"+zjh+"',"+type+",'"+strGatherDate+"',"+strFactMoney+",'"+PayType+"'";

        upSQL+=",'"+strBillNum+"','"+strReceiver+"',"+CurrRate+",'"+curryDX+"','"+txt+"',"+jzarea+","+zj;
	    upSQL+=")";

		 
	    tBean.executeUpdate( upSQL ) ;//实际交款
 
  %>
    
<script>
  window.close();
</script>
<center>
 </center>
</body>
</html>
