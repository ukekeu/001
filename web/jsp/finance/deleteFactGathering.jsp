<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%> 
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="tBean" scope="page" class="ConnDatabase.SDatabase"/> 
  <jsp:useBean id="fat" scope="page" class="FormatData.FormatData"/>
  <%@ include file="../public_js/getByteOut.jsp"%>
  <%@ include file="../public_js/logrecord.jsp" %>

<html>
<head>
	<title>delete</title>
</head>
<%try{
  String id=request.getParameter("id");
  String FactCurry=getbyte2(request.getParameter("FactCurry"));
  String CurryRate=getbyte2(request.getParameter("FactCurryRate"));
   String rate=request.getParameter("rate");
   String deletemoney=getbyte2(request.getParameter("deletemoney"));
   if (deletemoney.indexOf("-")>=0)deletemoney=deletemoney.substring(1);
   String contractno=request.getParameter("contractno");
   String strCusNo=getbyte2(request.getParameter("cusno")); 
   String room=getbyte2(request.getParameter("room")); 
//把当前删除的款转换为合同款的币别金额

   String deleteMoney="";
   if (Float.parseFloat(CurryRate)<Float.parseFloat(rate)){
     deleteMoney=fat.getFloat1(Float.parseFloat(deletemoney)/Float.parseFloat(rate),2);
   }else if (Float.parseFloat(CurryRate)>Float.parseFloat(rate)){
     deleteMoney=fat.getFloat1(Float.parseFloat(deletemoney)*Float.parseFloat(CurryRate),2);
   }else{
     deleteMoney=deletemoney;
   }
  String upSQL="";
  String deletechecked="true";
  
	     String sqG =" select id ,shouldMoney-yijiao as shouldMoney,yijiao as shouldMoney1  from GatheringRecord where    "
             + " cusno = '" + strCusNo + "' "
             + "  and contactno = '" + contractno + "' and  state<>0  order by shouldQS  desc ";
        ResultSet rsG = tBean.executeQuery( sqG ) ;
		//out.print(sqG+"<br>");
      int counter=0;
	   double strFactMoney1=0;
	    if (getbyte2(request.getParameter("deletemoney")).indexOf("-")>=0){
	    strFactMoney1=-Double.parseDouble(deleteMoney);
		}else{
		  strFactMoney1=Double.parseDouble(deleteMoney);
		}
       
		 
		String idid=""; 
      while( rsG.next() ) {
	      idid=rsG.getString( "id" );
	      double shouldMoney1=rsG.getDouble("shouldMoney1");
		   //out.print(shouldMoney1+"aaaa"+strFactMoney1);
		    //  out.print(shouldMoney1>strFactMoney1);
			 // out.print("<br>");
		  if (strFactMoney1==shouldMoney1){
		     upSQL="update GatheringRecord set state=0,yijiao=0 where "
		     + " cusno = '" + strCusNo + "' "
	         + "  and contactno = '" + contractno + "' and id="+rsG.getString( "id" );
		     fBean.executeUpdate( upSQL ) ; 
			// out.print(upSQL+"<br>");
			 strFactMoney1=0;
			break;
		  }else if (strFactMoney1>shouldMoney1){
		     upSQL="update GatheringRecord set state=0,yijiao=0 where "
		     + " cusno = '" + strCusNo + "' "
	         + "  and contactno = '" + contractno + "' and id="+rsG.getString( "id" );
		 
		  fBean.executeUpdate( upSQL ) ;
			// out.print(upSQL+"<br>");
		    strFactMoney1=strFactMoney1-shouldMoney1;
			deleteMoney=String.valueOf(strFactMoney1);
			// out.print(deleteMoney+"<br>");
		  }else if (strFactMoney1<shouldMoney1){
		      if (getbyte2(request.getParameter("deletemoney")).indexOf("-")>=0){deleteMoney="(-"+deleteMoney+")";}
		     upSQL="update GatheringRecord set state=1,yijiao=yijiao-"+String.valueOf(deleteMoney)+" where "
		     + " cusno = '" + strCusNo + "' "
	         + "  and contactno = '" + contractno + "' and id="+rsG.getString( "id" );
		    
			  fBean.executeUpdate( upSQL ) ;
			strFactMoney1=0;
			// out.print(upSQL+"<br>");
			 
			 break;
		  }
	    //  out.print(strFactMoney1+"<br>");
	  
      }
      rsG.close() ;
	    if (strFactMoney1!=0){
		
		  upSQL="update GatheringRecord set state=1,yijiao=yijiao+"+String.valueOf(deleteMoney)+" where "
		     + " cusno = '" + strCusNo + "' "
	         + "  and contactno = '" + contractno + "' and id="+idid;
		   //   fBean.executeUpdate( upSQL ) ;
       }
	
  //删除当前实收款
  if (deletechecked.equals("true")){
   int dd2 = fBean.executeUpdate( "delete FactGatheringRecord where id="+id ) ;
    upSQL="update GatheringRecord  set state=2 where yijiao>=shouldMoney and contactno='"+contractno+"'";
	fBean.executeUpdate( upSQL ) ;
  	upSQL="update GatheringRecord  set state=1 where yijiao<shouldMoney and contactno='"+contractno+"'";
	fBean.executeUpdate( upSQL ) ;
	upSQL="update GatheringRecord  set state=0 where yijiao=0 and  contactno='"+contractno+"'";
	fBean.executeUpdate( upSQL ) ;
    upSQL="delete  factGatheringRecord where tk=0 and  factmoney<=0";
	fBean.executeUpdate( upSQL ) ;
	
	setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "删除收款记录" , 
                  "删除"+room
                ) ;	
  }	
 %>
<body>
<script>
alert("系统已删除数据,同时更改应收款");
opener.document.f1.submit(); 
   window.close();
</script>
<% }catch(Exception s){out.print(s);out.close();} %>

</body>
</html>
