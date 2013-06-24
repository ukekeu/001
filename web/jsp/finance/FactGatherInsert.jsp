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
                  "实收登记" , 
                  "增加"+China.getParameter(request,"loft")
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
	if (CurrName.equals("RMB"))curryDX="人民币";
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

		

	    tBean.executeUpdate( upSQL ) ;//实际交款

//out.println(huanshuanMoney);
String qs[]=new String[6];//存放未交款期数
String money[]=new String[6];//存放未交款进金额
String whereTYPE="";
/*
if (type.equals("0"))whereTYPE=" and shouldQS=0";
else if (type.equals("1"))whereTYPE=" and shouldQS in (1,2,3,4)";
else if (type.equals("5"))whereTYPE=" and shouldQS =5";
else if (type.equals("6"))whereTYPE=" and shouldQS =6";
else if (type.equals("7"))whereTYPE=" and shouldQS =7";
else if (type.equals("8"))whereTYPE=" and shouldQS =8";
else if (type.equals("9"))whereTYPE=" and shouldQS =6";
else if (type.equals("10"))whereTYPE=" and shouldQS =10";
else if (type.equals("11"))whereTYPE=" and shouldQS =11";
*/

String sqG = " select id as shouldQS,shouldMoney -yijiao as shouldMoney  from GatheringRecord where   state<>2 and  "
             + " cusno = '" + strCusNo + "' "
             + "  and contactno = '" + StrFactNo +"' "+ whereTYPE+ "order by shouldDate";
  //out.print(sqG);
ResultSet rsG = tBean.executeQuery( sqG ) ;
int counter=0;
while( rsG.next() ) {
   qs[counter]=rsG.getString( "shouldQS" );
   money[counter]=rsG.getString( "shouldmoney" ) ;
   counter++;
   
}
rsG.close() ;
  
String sql="";
String sqlS="";
String sql1="";
String sjcontext="";
String payment=PayType;
String context="";
if (counter>1){
for (int ii=0;ii<counter;ii++){//把当前交的款按客户应交款的时间依次更新
     String valueStr=qs[ii];
	 String valueStr1=money[ii];
	 if (valueStr==null)break;
	 //out.print(Double.parseDouble(CurrRate)<Double.parseDouble(yrate));
	 

	 if (Double.parseDouble(valueStr1)<=Double.parseDouble(huanshuanMoney)){
	     String aa="";
		 out.print(counter);
		  if (ii==counter-1){
		    upSQL="update GatheringRecord set state=2,yijiao="+huanshuanMoney+" where "
		    + " cusno = '" + strCusNo + "' "
	        + "  and contactno = '" + StrFactNo + "' and yijiao=0 and id="+valueStr;
		  }else{
		    upSQL="update GatheringRecord set state=2,yijiao=shouldMoney where "
		    + " cusno = '" + strCusNo + "' "
	        + "  and contactno = '" + StrFactNo + "'  and id="+valueStr;
		  }
		 tBean.executeUpdate( upSQL ) ;

	    if (Double.parseDouble(huanshuanMoney)-Double.parseDouble(valueStr1)==0)break;
		else
         huanshuanMoney=String.valueOf(Double.parseDouble(huanshuanMoney)-Double.parseDouble(valueStr1));
		
	 }else  if (Double.parseDouble(valueStr1)>Double.parseDouble(huanshuanMoney)){
	  //欠款额大于实交款，原已交款+当前实交款等于累计交款
	//  out.print("<br>"+valueStr1);
	//out.print("<br>"+huanshuanMoney);
	  upSQL="update GatheringRecord set state=1,yijiao=yijiao+"+huanshuanMoney+" where "
	  + " cusno = '" + strCusNo + "' "
             + "  and contactno = '" + StrFactNo + "' and id="+valueStr;
	 tBean.executeUpdate( upSQL ) ;

	 break;
	}
 }
}else if (counter==1){

        String valueStr=qs[0];
	    String valueStr1=money[0];
		if (Double.parseDouble(valueStr1)-Double.parseDouble(huanshuanMoney)==0){
		  //刚好交完
          upSQL="update GatheringRecord set state=2,yijiao=shouldMoney where "
		  + " cusno = '" + strCusNo + "' "
	      + "  and contactno = '" + StrFactNo + "'  and id="+valueStr;
		}else if (Double.parseDouble(valueStr1)-Double.parseDouble(huanshuanMoney)<0){
		 //有余额
          upSQL="update GatheringRecord set state=2,yijiao=yijiao+"+huanshuanMoney+" where "
		  + " cusno = '" + strCusNo + "' "
	      + "  and contactno = '" + StrFactNo + "' and id="+valueStr;  
		  
		}else{//还欠
		  upSQL="update GatheringRecord set state=1,yijiao=yijiao+"+huanshuanMoney+" where "
		  + " cusno = '" + strCusNo + "' "
	      + "  and contactno = '" + StrFactNo + "' and id="+valueStr;  
		 
		 } 
		// out.print(upSQL);
		tBean.executeUpdate( upSQL ) ;
	
}else{

upSQL="delete factGatheringRecord    where "
		  + " cusno = '" + strCusNo + "' "
	      + "  and contractno = '" + StrFactNo + "' and id=(select max(id) from factGatheringRecord  where  contractno = '" + StrFactNo + "')";  
		  tBean.executeUpdate( upSQL ) ;
		
		 
  %>
    <script>
	alert('系统检测到应收款已交完,拒绝更新应收款状态') ;
	  opener.document.f1.submit();  
	window.close();
	<%
	   upSQL="update GatheringRecord set state=2,yijiao=yijiao+"+huanshuanMoney+" where "
		  + " cusno = '" + strCusNo + "' "
	      + "  and contactno = '" + StrFactNo + "' and shouldQS=(select max(shouldQS) from GatheringRecord  where  contactno = '" + StrFactNo + "')";  
		//tBean.executeUpdate( upSQL ) ;
	%>
	 
	</script>
<%
return ;
 }
   //out.close();

	
	ResultSet execRs=null;
	String upperMoney="";
	execRs=tBean.executeQuery("exec dbo.L2U "+strFactMoney2+",0 ");//大写金额转换存储过程
	if (execRs.next())
	upperMoney=getbyte(execRs.getString("dd"));
	execRs.close();
	    
	
	
	if (strPeriod.equals("0"))context="定金";
	else context="楼款";
	
    sjcontext="insert into printsksj(customer,payment,context,money1"
	+",money2,rate,checker,txt) values('"+signatory+"','"+payment+"','"+context+"("+loft+")"
	+"','"+curryDX+upperMoney+"',"+request.getParameter("FactMoney")+","+CurrRate+","
	+"'"+strReceiver+"','"+txt+"')";
	
	tBean.executeUpdate( "delete  printsksj" ) ;
	tBean.executeUpdate( sjcontext) ;
	upSQL="update GatheringRecord  set state=2 where yijiao>=shouldMoney and contactno='"+StrFactNo+"'";

	tBean.executeUpdate( upSQL ) ;
  	upSQL="update GatheringRecord  set state=1 where yijiao<shouldMoney and contactno='"+StrFactNo+"'";
		
	tBean.executeUpdate( upSQL ) ;
	upSQL="update GatheringRecord  set state=0 where yijiao=0 and  contactno='"+StrFactNo+"'";
	tBean.executeUpdate( upSQL ) ;
    upSQL="delete  factGatheringRecord where tk=0 and  factmoney<=0";
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
