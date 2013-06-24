<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>新增收款登记</title>
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
                  "退款登记" , 
                  "增加"
                ) ;
//取得FORM传输过来的数据

String strCusNo=China.getParameter(request,"CusNo");
String type=China.getParameter(request,"type");
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
String tk=China.getParameter(request,"tk");
if (tk.equals(""))tk="0";

//当前付款的币别
String CurrName=China.getParameter(request,"curry");
String CurrRate=China.getParameter(request,"rate");
//合同中的币别
String ycurry=request.getParameter("ycurry");
String yrate=request.getParameter("yrate");

String Print=China.getParameter(request,"Print");
String loft=China.getParameter(request,"loft");
String txt=China.getParameter(request,"context");//bak
String signatory=China.getParameter(request,"signatory");
//判断是定金还是楼款
//if (Double.parseDouble(strFactMoney)<=Double.parseDouble(strysmoney)){
//    strPeriod="0";
//}else strPeriod="1";
String huanshuanMoney="";//把当前付款的币别换算为合同款对应的币别金额
 
	if (Double.parseDouble(CurrRate)<Double.parseDouble(yrate)){
	  huanshuanMoney=String.valueOf(fat.getFloat3(Double.parseDouble(strFactMoney)/Double.parseDouble(yrate),2));
	}else if (Double.parseDouble(CurrRate)>Double.parseDouble(yrate)){
	  huanshuanMoney=String.valueOf(fat.getFloat3(Double.parseDouble(strFactMoney)*Double.parseDouble(CurrRate),2));
	}else{
	  huanshuanMoney=strFactMoney;
	}
huanshuanMoney= fat.getFloat3(Double.parseDouble(huanshuanMoney),2);
	String curryDX="";
	if (CurrName.equals("￥"))curryDX="人民币";
	if (CurrName.equals("HKD"))curryDX="港币";
	if (CurrName.equals("USD"))curryDX="美元";
	String upSQL="";
//实际交款

ResultSet execRs1=null;
String upperMoney1="";
String strFactMoney2=strFactMoney;
	

if (strFactMoney.indexOf("-")>=0){
strFactMoney2=strFactMoney.substring(strFactMoney.indexOf("-")+1);
tk="1";
}

execRs1=tBean.executeQuery("exec dbo.L2U "+strFactMoney2+",0 ");//大写金额转换存储过程
if (execRs1.next())
upperMoney1=getbyte(execRs1.getString("dd"));
execRs1.close();
        upSQL="insert into FactGatheringRecord (cusno,Period,"; 
        upSQL+="Gather_Date,factmoney,Bill_Num,Receiver,BillType,CurrName";
        upSQL+=",CurrRate,PayType,PayTypeNo,UppMoney,contractno,context,tk)values ";
        upSQL+="('"+strCusNo+"',"+type+",'"+strGatherDate+"',";
    	upSQL+=strFactMoney+",'"+strBillNum+"','"+strReceiver+"',"+strBillType+",'";
        upSQL+=CurrName+"',"+CurrRate+",'"+PayType+"','"+PayTypeNo+"','"+curryDX+upperMoney1+"','";
	    upSQL+= StrFactNo + "','"+txt+"',"+tk+")";
		tBean.executeUpdate( upSQL ) ;//实际退款
		upSQL="update GatheringRecord set  yijiao=yijiao+"+strFactMoney+",state=1    where "
		  + " cusno = '" + strCusNo + "' "
	      + "  and contactno = '" + StrFactNo + "' and id=(select max(id) from GatheringRecord  where  contactno = '" + StrFactNo + "' and state<>0 and shouldQS="+type+") and state<>0  ";  
		tBean.executeUpdate( upSQL ) ;
		
 %>
	
	 

<script>
  opener.document.f1.submit(); 
 window.close();
</script>
<center>
 </center>
</body>
</html>
