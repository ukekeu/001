<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>正在记帐处理..... </title>
</head>

<body>
 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
 <jsp:useBean id="tBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
   <jsp:useBean id="fat" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/Repalce.jsp"%>
 
  <%@ include file="../public_js/logrecord.jsp" %>
<%String upSQL = "";
try{
//取得FORM传输过来的数据
 String Aj=China.getParameter(request,"Aj");
 String para=China.getParameter(request,"para");
 String strCusNo=China.getParameter(request,"CusNo");
 String room=China.getParameter(request,"room");
 String rowID = request.getParameter( "rowID" ) ;
 String contractno=request.getParameter("contractno");
 String oldcurry=request.getParameter("oldcurry");//原实交款币别
 String oldrate=request.getParameter("oldrate");
 String oldmoney=request.getParameter("oldmoney"); 
 String ht_rate=request.getParameter("ht_rate"); //应交款币别
 String type=request.getParameter("type"); 

 String sqlS="";
    String strGatherDate=request.getParameter("Date1");//+"-"+request.getParameter("BeginMonth")+"-"+request.getParameter("BeginDay");
  String strFactMoney=request.getParameter("FactMoney");
  String strBillType=China.getParameter(request,"BillType");
  String strBillNum=China.getParameter(request,"BillNum");	
  String strReceiver=China.getParameter(request,"Receiver");
  String PayType=China.getParameter(request,"PayType");
  String PayTypeNo=China.getParameter(request,"PayTypeNo");
  String CurrName=China.getParameter(request,"curry");//修改后的币别
  String CurrRate=China.getParameter(request,"rate");
  String Print=China.getParameter(request,"Print");
  String context=China.getParameter(request,"context");//bak
  //String contractno = request.getParameter( "contractno" ) ;


String sqT = "";
String whereTYPE="";
if (type.equals("0"))whereTYPE=" and shouldQS=0";
else if (type.equals("1"))whereTYPE=" and shouldQS in (1,2,3,4)";
else if (type.equals("5"))whereTYPE=" and shouldQS =5";
else if (type.equals("6"))whereTYPE=" and shouldQS =6";
else if (type.equals("7"))whereTYPE=" and shouldQS =7";
else if (type.equals("8"))whereTYPE=" and shouldQS =8";
else if (type.equals("9"))whereTYPE=" and shouldQS =6";
else if (type.equals("10"))whereTYPE=" and shouldQS =10";
else if (type.equals("11"))whereTYPE=" and shouldQS =11";
String curryDX="";
if (CurrName.equals("￥"))curryDX="人民币";
if (CurrName.equals("HKD"))curryDX="港币";
if (CurrName.equals("USD"))curryDX="美元";
String strFact ="";
 if (strFactMoney.indexOf("-")>=0)strFact=strFactMoney.substring(strFactMoney.indexOf("-")+1);
else strFact=strFactMoney;

//更改当前实收登记
ResultSet execRs=null;
String upperMoney="";
execRs=InsertBean.executeQuery("exec dbo.L2U "+strFact+",1 ");//大写金额转换存储过程
if (execRs.next())
upperMoney=getbyte(execRs.getString("dd"));
execRs.close();
  sqlS="update factGatheringRecord set Period="+type+",Gather_Date='"+strGatherDate+"',";
  sqlS+="factmoney="+strFactMoney+",Bill_Num='"+strBillNum+"',Receiver='"+strReceiver+"',";
  sqlS+="BillType='"+strBillType+"',CurrName='"+CurrName+"',CurrRate=";
  sqlS+=CurrRate+",PayType='"+PayType+"',PayTypeNo='"+PayTypeNo+"',";

  sqlS+="UppMoney='"+curryDX+upperMoney+"',context='"+context+"' where id = " + rowID ;
 
 InsertBean.executeUpdate( sqlS ) ;
 
//计算当前付款的币别金额与原交款对应的币别金额之差(换算为当前币别)
   String huanshuanMoney="";
   if (Double.parseDouble(CurrRate)<Double.parseDouble(oldrate)){
     huanshuanMoney=String.valueOf(Double.parseDouble(strFactMoney)-Double.parseDouble(oldmoney)*Double.parseDouble(oldrate));
   }else if (Double.parseDouble(CurrRate)>Double.parseDouble(oldrate)){
     huanshuanMoney=String.valueOf(Double.parseDouble(strFactMoney)-Double.parseDouble(oldmoney)/Double.parseDouble(CurrRate));
   }else{
     huanshuanMoney=String.valueOf(Double.parseDouble(strFactMoney)-Double.parseDouble(oldmoney));
   }

   //把差额换算为合同对应币别的金额(换算为合同款对应的币别)
   String money1="";
 	  if (Double.parseDouble(CurrRate)<Double.parseDouble(ht_rate))
	     money1=  fat.getFloat3(Double.parseDouble(huanshuanMoney)/Double.parseDouble(ht_rate),2);
	  else if (Double.parseDouble(CurrRate)>Double.parseDouble(ht_rate))	
	     money1=  fat.getFloat3(Double.parseDouble(huanshuanMoney)*Double.parseDouble(CurrRate),2);
	  else 
	    money1=huanshuanMoney;
money1= fat.getFloat3(Double.parseDouble(money1),2);
String sqG ="";
   if (Double.parseDouble(money1)>0){
       sqG =" select id ,yijiao,shouldMoney-yijiao as shouldMoney,shouldMoney as shouldMoney1  from GatheringRecord where    "
             + " cusno = '" + strCusNo + "' "
             + "  and contactno = '" + contractno + "' and  state<>2  order by shouldQS ";
 out.print(sqG+"<br>");
      ResultSet rsG = tBean.executeQuery( sqG ) ;
      int counter=0;
	  String idid=""; 
	  double strFactMoney1=Double.parseDouble(money1);
	  
      while( rsG.next() ) {
	       double yijiao=rsG.getDouble("yijiao");
	       idid=rsG.getString( "id" );
	      double shouldMoney1=rsG.getDouble("shouldMoney1");
		  if (strFactMoney1+yijiao==shouldMoney1){
		     upSQL="update GatheringRecord set state=2,yijiao=shouldMoney where "
		     + " cusno = '" + strCusNo + "' "
	         + "  and contactno = '" + contractno + "' and id="+rsG.getString( "id" );
		     InsertBean.executeUpdate( upSQL ) ; 
			 out.print(upSQL+"<br>");
			  strFactMoney1=strFactMoney1+yijiao-shouldMoney1;
			break;
		  }else if (strFactMoney1+yijiao>shouldMoney1){
		     upSQL="update GatheringRecord set state=2,yijiao=shouldMoney where "
		     + " cusno = '" + strCusNo + "' "
	         + "  and contactno = '" + contractno + "' and id="+rsG.getString( "id" );
		    int aaa=InsertBean.executeUpdate(upSQL ) ;
			 out.print(upSQL+"00<br>");
			 out.print(aaa);
			  out.print("<br>");
		    strFactMoney1=strFactMoney1+yijiao-shouldMoney1;
			money1=String.valueOf(strFactMoney1);
		  }else if (strFactMoney1+yijiao<shouldMoney1){
		     upSQL="update GatheringRecord set state=1,yijiao=yijiao+"+String.valueOf(money1)+" where "
		     + " cusno = '" + strCusNo + "' "
	         + "  and contactno = '" + contractno + "' and id="+rsG.getString( "id" );
		     InsertBean.executeUpdate( upSQL ) ;
			 strFactMoney1=0;
			 out.print(upSQL+"<br>");break;
		  }
	  
	      out.print(strFactMoney1+"<br>");
	    
      // qs[counter]=rsG.getString( "shouldQS" );
       //money[counter]=rsG.getString( "shouldmoney" ) ;
       //counter++;
      }
      rsG.close() ;
	  if (strFactMoney1!=0&&!idid.equals("")){
		
		  upSQL="update GatheringRecord set state=1,yijiao=yijiao+"+String.valueOf(money1)+" where "
		     + " cusno = '" + strCusNo + "' "
	         + "  and contactno = '" + contractno + "' and id="+idid;
		      InsertBean.executeUpdate( upSQL ) ;
			  out.print(upSQL+"<br>");
       }
	  if (idid.equals("")){
	  
	  upSQL="update GatheringRecord set state=2,yijiao=yijiao+"+String.valueOf(money1)+" where "
		     + " cusno = '" + strCusNo + "' "
	         + "  and contactno = '" + contractno + "' and id=( select max(id)  from GatheringRecord where    "
             + " cusno = '" + strCusNo + "' "
             + "  and contactno = '" + contractno + "'   ) ";
 
		 //  InsertBean.executeUpdate( upSQL ) ;
	  
	  //out.print(upSQL);
	  }
	 // }
	 }else   if (Double.parseDouble(money1)<0){
	     sqG =" select id ,shouldMoney-yijiao as shouldMoney,yijiao as shouldMoney1  from GatheringRecord where    "
             + " cusno = '" + strCusNo + "' "
             + "  and contactno = '" + contractno + "' and  state<>0  order by shouldQS  desc ";
        ResultSet rsG = tBean.executeQuery( sqG ) ;
		out.print(sqG+"<br>");
      int counter=0;
	   double strFactMoney1=0;
	  if (money1.indexOf("-")>=0)
	    strFactMoney1=-Double.parseDouble(money1);
      else
	     strFactMoney1=Double.parseDouble(money1);
		 
		String idid=""; 
      while( rsG.next() ) {
	      idid=rsG.getString( "id" );
	      double shouldMoney1=rsG.getDouble("shouldMoney1");
		   out.print("a"+strFactMoney1+"<br>");
		  if (strFactMoney1==shouldMoney1){
		     upSQL="update GatheringRecord set state=0,yijiao=0 where "
		     + " cusno = '" + strCusNo + "' "
	         + "  and contactno = '" + contractno + "' and id="+rsG.getString( "id" );
		     InsertBean.executeUpdate( upSQL ) ; 
			 out.print(upSQL+"<br>");
			 strFactMoney1=0;
			break;
		  }else if (strFactMoney1>shouldMoney1){
		     upSQL="update GatheringRecord set state=0,yijiao=0 where "
		     + " cusno = '" + strCusNo + "' "
	         + "  and contactno = '" + contractno + "' and id="+rsG.getString( "id" );
		 
		   InsertBean.executeUpdate( upSQL ) ;
			 out.print(upSQL+"<br>");
		    strFactMoney1=strFactMoney1-shouldMoney1;
			money1="-"+String.valueOf(strFactMoney1);
		  }else if (strFactMoney1<shouldMoney1){
		     upSQL="update GatheringRecord set state=1,yijiao=yijiao+"+String.valueOf(money1)+" where "
		     + " cusno = '" + strCusNo + "' "
	         + "  and contactno = '" + contractno + "' and id="+rsG.getString( "id" );
		    
			  InsertBean.executeUpdate( upSQL ) ;
			strFactMoney1=0;
			 out.print(upSQL+"<br>");break;
		  }
	      out.print(strFactMoney1+"<br>");
	  
      }
      rsG.close() ;
	    if (strFactMoney1!=0){
		
		  upSQL="update GatheringRecord set state=1,yijiao=yijiao+"+String.valueOf(money1)+" where "
		     + " cusno = '" + strCusNo + "' "
	         + "  and contactno = '" + contractno + "' and id="+idid;
		       InsertBean.executeUpdate( upSQL ) ;
       }
	} 
	 
 
    upSQL="update GatheringRecord  set state=2 where yijiao>=shouldMoney and contactno='"+contractno+"'";
	tBean.executeUpdate( upSQL ) ;
  	upSQL="update GatheringRecord  set state=1 where yijiao<shouldMoney and contactno='"+contractno+"'";
	tBean.executeUpdate( upSQL ) ;
	upSQL="update GatheringRecord  set state=0 where yijiao=0 and  contactno='"+contractno+"'";
	tBean.executeUpdate( upSQL ) ;
    upSQL="delete  factGatheringRecord where tk=0 and  factmoney<=0";
	tBean.executeUpdate( upSQL ) ;
	
	setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "修改收款记录" , 
                  "修改"+room
                ) ;	
	}catch(Exception s){out.print(upSQL+s);out.close();}
%> 
<script>
 function check(){
     opener.document.f1.submit(); 
    close();
 }
check();
</script>
</body>
</html>
