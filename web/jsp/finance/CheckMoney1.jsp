<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>���ڼ��ʴ���..... </title>
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
//ȡ��FORM�������������
 String Aj=China.getParameter(request,"Aj");
 String para=China.getParameter(request,"para");
 String strCusNo=China.getParameter(request,"CusNo");
 String room=China.getParameter(request,"room");
 String rowID = request.getParameter( "rowID" ) ;
 String contractno=request.getParameter("contractno");
 String oldcurry=request.getParameter("oldcurry");//ԭʵ����ұ�
 String oldrate=request.getParameter("oldrate");
 String oldmoney=request.getParameter("oldmoney"); 
 String ht_rate=request.getParameter("ht_rate"); //Ӧ����ұ�
 String type=request.getParameter("type"); 

 String sqlS="";
    String strGatherDate=request.getParameter("Date1");//+"-"+request.getParameter("BeginMonth")+"-"+request.getParameter("BeginDay");
  String strFactMoney=request.getParameter("FactMoney");
  String strBillType=China.getParameter(request,"BillType");
  String strBillNum=China.getParameter(request,"BillNum");	
  String strReceiver=China.getParameter(request,"Receiver");
  String PayType=China.getParameter(request,"PayType");
  String PayTypeNo=China.getParameter(request,"PayTypeNo");
  String CurrName=China.getParameter(request,"curry");//�޸ĺ�ıұ�
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
if (CurrName.equals("��"))curryDX="�����";
if (CurrName.equals("HKD"))curryDX="�۱�";
if (CurrName.equals("USD"))curryDX="��Ԫ";
String strFact ="";
 if (strFactMoney.indexOf("-")>=0)strFact=strFactMoney.substring(strFactMoney.indexOf("-")+1);
else strFact=strFactMoney;

//���ĵ�ǰʵ�յǼ�
ResultSet execRs=null;
String upperMoney="";
execRs=InsertBean.executeQuery("exec dbo.L2U "+strFact+",1 ");//��д���ת���洢����
if (execRs.next())
upperMoney=getbyte(execRs.getString("dd"));
execRs.close();
  sqlS="update factGatheringRecord set Period="+type+",Gather_Date='"+strGatherDate+"',";
  sqlS+="factmoney="+strFactMoney+",Bill_Num='"+strBillNum+"',Receiver='"+strReceiver+"',";
  sqlS+="BillType='"+strBillType+"',CurrName='"+CurrName+"',CurrRate=";
  sqlS+=CurrRate+",PayType='"+PayType+"',tk=1,PayTypeNo='"+PayTypeNo+"',";

  sqlS+="UppMoney='"+curryDX+upperMoney+"',context='"+context+"' where id = " + rowID ;
 
  InsertBean.executeUpdate( sqlS ) ;
 
//���㵱ǰ����ıұ�����ԭ�����Ӧ�ıұ���֮��(����Ϊ��ǰ�ұ�)
   String huanshuanMoney="";
   if (Double.parseDouble(CurrRate)<Double.parseDouble(oldrate)){
     huanshuanMoney=String.valueOf(Double.parseDouble(strFactMoney)-Double.parseDouble(oldmoney)*Double.parseDouble(oldrate));
   }else if (Double.parseDouble(CurrRate)>Double.parseDouble(oldrate)){
     huanshuanMoney=String.valueOf(Double.parseDouble(strFactMoney)-Double.parseDouble(oldmoney)/Double.parseDouble(CurrRate));
   }else{
     huanshuanMoney=String.valueOf(Double.parseDouble(strFactMoney)-Double.parseDouble(oldmoney));
   }

   //�Ѳ���Ϊ��ͬ��Ӧ�ұ�Ľ��(����Ϊ��ͬ���Ӧ�ıұ�)
   String money1="";
 	  if (Double.parseDouble(CurrRate)<Double.parseDouble(ht_rate))
	     money1=  fat.getFloat3(Double.parseDouble(huanshuanMoney)/Double.parseDouble(ht_rate),2);
	  else if (Double.parseDouble(CurrRate)>Double.parseDouble(ht_rate))	
	     money1=  fat.getFloat3(Double.parseDouble(huanshuanMoney)*Double.parseDouble(CurrRate),2);
	  else 
	    money1=huanshuanMoney;
money1= fat.getFloat3(Double.parseDouble(money1),2);
//out.print(money1);
//out.print("<br>d");
String sqG ="";
    
	     sqG =" select id ,shouldMoney-yijiao as shouldMoney,yijiao as shouldMoney1  from GatheringRecord where    "
             + " cusno = '" + strCusNo + "' "
             + "  and contactno = '" + contractno + "' and  state<>0  order by shouldQS  desc ";
        ResultSet rsG = tBean.executeQuery( sqG ) ;
		//out.print(sqG+"<br>");
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
		 //  out.print("a"+strFactMoney1+"<br>");
		  if (strFactMoney1==shouldMoney1){
		     upSQL="update GatheringRecord set state=0,yijiao=0 where "
		     + " cusno = '" + strCusNo + "' "
	         + "  and contactno = '" + contractno + "' and id="+rsG.getString( "id" );
		     InsertBean.executeUpdate( upSQL ) ; 
			// out.print(upSQL+"<br>");
			 strFactMoney1=0;
			break;
		  }else if (strFactMoney1>shouldMoney1){
		     upSQL="update GatheringRecord set state=0,yijiao=0 where "
		     + " cusno = '" + strCusNo + "' "
	         + "  and contactno = '" + contractno + "' and id="+rsG.getString( "id" );
		 
		    InsertBean.executeUpdate( upSQL ) ;
			// out.print(upSQL+"<br>");
		    strFactMoney1=strFactMoney1-shouldMoney1;
			money1="-"+String.valueOf(strFactMoney1);
		  }else if (strFactMoney1<shouldMoney1){
		     upSQL="update GatheringRecord set state=1,yijiao=yijiao+"+String.valueOf(money1)+" where "
		     + " cusno = '" + strCusNo + "' "
	         + "  and contactno = '" + contractno + "' and id="+rsG.getString( "id" );
		    
			  InsertBean.executeUpdate( upSQL ) ;
			strFactMoney1=0;
			// out.print(upSQL+"<br>");
			 break;
		  }
	     // out.print(strFactMoney1+"<br>");
	  
      }
      rsG.close() ;
	    if (strFactMoney1!=0){
		
		  upSQL="update GatheringRecord set state=1,yijiao=yijiao+"+String.valueOf(money1)+" where "
		     + " cusno = '" + strCusNo + "' "
	         + "  and contactno = '" + contractno + "' and id="+idid;
		        InsertBean.executeUpdate( upSQL ) ;
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
                  "�޸��տ��¼" , 
                  "�޸�"+room
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
