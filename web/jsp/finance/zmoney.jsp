<html>
<head>
	<title>转为定金</title>
</head>
<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%> 
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="tBean" scope="page" class="ConnDatabase.SDatabase"/> 
<body>

<%            try{

			 //如果此房是被客户临定，则把临定定金转为实收定金
			   String ldroomcode=getbyte2(request.getParameter("roomcode"));
			   String cusno=getbyte2(request.getParameter("cusno"));
			   String MaxId=getbyte2(request.getParameter("contractno"));
			   String choose=getbyte2(request.getParameter("choose"));
			   String rate=getbyte2(request.getParameter("rate"));
			   String rg_date=request.getParameter("rg_date");
			   String room=getbyte2(request.getParameter("room"));
			   String customer=getbyte2(request.getParameter("customer"));
			   String curr="";
			   String sql=""; 
			   String ldmoney="";
			   String ldbillnum="";
			   String lddjperson="";
			   String ldrate="";
			   String PayType="";
			   String BillType="";
			   String ldDate="";
			
			   if (choose.equals("ld")){
			       sql ="select * from  SL_TemporarilyBuy where  roomcode="+ldroomcode +" and  Cusname='"+cusno+"'";
				   ResultSet ldRs=aBean.executeQuery(sql);
				    
				   if (ldRs.next()){
				             
						ldDate =getbyte(ldRs.getString("StartDate"));
					    ldmoney=getbyte(ldRs.getString("Subscription"));
						curr=getbyte(ldRs.getString("curr"));
						ldrate=getbyte(ldRs.getString("rate"));
						lddjperson=getbyte(ldRs.getString("person"));
						BillType=getbyte(ldRs.getString("BillType"));
						ldbillnum=getbyte(ldRs.getString("bill_num"));
						PayType=getbyte(ldRs.getString("PayType"));
					}
					ldRs.close();
			 if (ldrate.equals(""))ldrate="1";
			 String SQLfactmoney="";
			 
		 
			 if (!ldDate.equals("")){
			   SQLfactmoney="insert into FactGatheringRecord(contractno,cusno,period";
			   SQLfactmoney+=",gather_date,factmoney,bill_num,receiver,billtype,currname,currrate,paytype) values(";
			   SQLfactmoney+="'"+MaxId+"','"+cusno+"',0,'"+ldDate+"',"+ldmoney+",'"+ldbillnum+"','"+lddjperson+"','"+BillType;
			   SQLfactmoney+="','"+curr+"',"+ldrate+",'"+PayType+"')";
			  
			   aBean.executeUpdate(SQLfactmoney);	
			
			    if (Float.parseFloat(ldrate)<Float.parseFloat(rate))
	            ldmoney=String.valueOf(Float.parseFloat(ldmoney)/Float.parseFloat(rate));
	           else if (Float.parseFloat(ldrate)>Float.parseFloat(rate))	
	            ldmoney=String.valueOf(Float.parseFloat(ldmoney)*Float.parseFloat(ldrate));
			   String upSQL="UPDATE GatheringRecord set  state="
			          +"(select aa=case when shouldMoney>yijiao+"+ldmoney+" then 1 else 2  end "
					  +" from GatheringRecord where   cusno='"+cusno +"' and  "
					  +" ContactNo='"+MaxId+"' and  shouldQS=0),yijiao=yijiao+" +ldmoney
					  +" WHERE contactno='"+MaxId+"' and cusno='"+cusno+"' and shouldQS=0";
			   aBean.executeUpdate(upSQL);	//更改应收款状态
			   aBean.executeUpdate("update SL_TemporarilyBuy set zto=1 where   roomcode="+ldroomcode +" and  Cusname='"+cusno+"' ");	//更改临定状态
		 	 }
			 //已把临定定转为定金
			
			}
			 else{
			 //如果此客户是诚意客户，则把诚意金转为定金
				 
			   String cySQL="select * from tb_chengyi where serialNo='"+cusno+"'";
  			   ResultSet cyRs=aBean.executeQuery(cySQL);
			
			   String cyDate="";
               String dengjiren="";
			   String cycurry="";
			   String cyrate="";
			 
			   String cymoney="0";
			   if (cyRs.next()){
			    
				  cyDate=getbyte(cyRs.getString("dengji_riqi"));
				  if (cyDate.indexOf(" ")>=0)cyDate=cyDate.substring(0,cyDate.indexOf(" "));
				  cymoney=cyRs.getString("jinger");
				  dengjiren=getbyte(cyRs.getString("dengjiren"));  
			      BillType="0";//收据
			      cycurry=getbyte(cyRs.getString("curry"));
				  cyrate=getbyte(cyRs.getString("rate"));
				  PayType=getbyte(cyRs.getString("payment"));  
				  if (cyrate.equals(""))cyrate="1.0";
			    
			  
			  if (Float.parseFloat(cyrate)<Float.parseFloat(rate))
	            cymoney=String.valueOf(Float.parseFloat(cymoney)/Float.parseFloat(rate));
	          else if (Float.parseFloat(cyrate)>Float.parseFloat(rate))	
			    cymoney=String.valueOf(Float.parseFloat(cymoney)*Float.parseFloat(cyrate));
				
				
				
				  String upSQL=""
			          +"select  shouldQS  "
					  +" from GatheringRecord where state=0 and   cusno='"+cusno +"' and  "
					  +" ContactNo='"+MaxId+"' and  shouldQS=0";	
				 ResultSet rs1=bBean.executeQuery(upSQL);
				   String ddd="";
				  if (rs1.next()){
			         ddd="aa";
					 
					 
					 
					/* upSQL="UPDATE GatheringRecord set  state="
			          +"(select  top 1 aa=case when shouldMoney>yijiao+"+cymoney+" then 1 else 2  end "
					  +" from GatheringRecord where state=0 and   cusno='"+cusno +"' and  "
					  +" ContactNo='"+MaxId+"' and  shouldQS=0),yijiao=yijiao+" +cymoney
					  +" WHERE contactno='"+MaxId+"' and cusno='"+cusno+"' and shouldQS=0";	
					  aBean.executeUpdate(upSQL);	//更改应收款状态
					  */
			}	
			rs1.close();
			if (!ddd.equals("")){
			 sql="insert into FactGatheringRecord(contractno,cusno,period";
			   sql+=",gather_date,factmoney,receiver,billtype,currname,currrate,paytype) values(";
			   sql+="'"+MaxId+"','"+cusno+"',0,'"+cyDate+"',"+cymoney+",'"+dengjiren+"','"+BillType;
			   sql+="','"+cycurry+"',"+cyrate+",'"+PayType+"')";
			 }else{
			  sql="insert into FactGatheringRecord(contractno,cusno,period";
			   sql+=",gather_date,factmoney,receiver,billtype,currname,currrate,paytype) values(";
			   sql+="'"+MaxId+"','"+cusno+"',1,'"+cyDate+"',"+cymoney+",'"+dengjiren+"','"+BillType;
			   sql+="','"+cycurry+"',"+cyrate+",'"+PayType+"')";
			 
			 }  
			 out.print(sql);
				aBean.executeUpdate(sql);	//把诚意金转为定金
			
			String sqG="";	  
			//if (!ddd.equals("")){
			    sqG =" select id ,yijiao,shouldMoney-yijiao as shouldMoney,shouldMoney as shouldMoney1  from GatheringRecord where    "
             + " cusno = '" + cusno + "' "
             + "  and contactno = '" + MaxId + "' and  state<>2  order by shouldQS ";
 
      ResultSet rsG = tBean.executeQuery( sqG ) ;
      int counter=0;
	  String idid=""; 
	  double strFactMoney1=Double.parseDouble(cymoney);
	  
      while( rsG.next() ) {
	       double yijiao=rsG.getDouble("yijiao");
	       idid=rsG.getString( "id" );
	      double shouldMoney1=rsG.getDouble("shouldMoney1");
		  if (strFactMoney1+yijiao==shouldMoney1){
		     upSQL="update GatheringRecord set state=2,yijiao=shouldMoney where "
		     + " cusno = '" + cusno + "' "
	         + "  and contactno = '" + MaxId + "' and id="+rsG.getString( "id" );
		      bBean.executeUpdate( upSQL ) ; 
			 
			  strFactMoney1=strFactMoney1+yijiao-shouldMoney1;
			break;
		  }else if (strFactMoney1+yijiao>shouldMoney1){
		     upSQL="update GatheringRecord set state=2,yijiao=shouldMoney where "
		     + " cusno = '" + cusno + "' "
	         + "  and contactno = '" + MaxId + "' and id="+rsG.getString( "id" );
		    int aaa=bBean.executeUpdate(upSQL ) ;
			 
		    strFactMoney1=strFactMoney1+yijiao-shouldMoney1;
			cymoney=String.valueOf(strFactMoney1);
		  }else if (strFactMoney1+yijiao<shouldMoney1){
		     upSQL="update GatheringRecord set state=1,yijiao=yijiao+"+String.valueOf(cymoney)+" where "
		     + " cusno = '" + cusno + "' "
	         + "  and contactno = '" + MaxId + "' and id="+rsG.getString( "id" );
		      bBean.executeUpdate( upSQL ) ;
			 strFactMoney1=0;
			 break;
		  }
	  
	    
	    
      // qs[counter]=rsG.getString( "shouldQS" );
       //money[counter]=rsG.getString( "shouldmoney" ) ;
       //counter++;
      }
      rsG.close() ;
	  if (strFactMoney1!=0&&!idid.equals("")){
		
		  upSQL="update GatheringRecord set state=1,yijiao=yijiao+"+String.valueOf(cymoney)+" where "
		     + " cusno = '" + cusno + "' "
	         + "  and contactno = '" + MaxId + "' and id="+idid;
		      bBean.executeUpdate( upSQL ) ;
			  out.print(upSQL+"<br>");
       }
	  if (idid.equals("")){
	  
	  upSQL="update GatheringRecord set state=2,yijiao=yijiao+"+String.valueOf(cymoney)+" where "
		     + " cusno = '" + cusno + "' "
	         + "  and contactno = '" + MaxId + "' and id=( select max(id)  from GatheringRecord where    "
             + " cusno = '" + cusno + "' "
             + "  and contactno = '" + MaxId + "'   ) ";
 
		   bBean.executeUpdate( upSQL ) ;
	  
	  //out.print(upSQL);
	  }
			
			//}
			  //保留原诚意客户的认购时间、认购后的姓名及认购的具体单位
			   aBean.executeUpdate("update tb_chengyi set zto=1,new_name='"+customer+"',new_room='"+room+"',new_room_date='"+rg_date+"'  where     serialNo='"+cusno+"' ");	//更改诚意状态状态
		    
				}		
			   cyRs.close();	
			
			 }  
			 }catch(Exception s){out.print(s);out.close();}

 %>

 <script>
opener.window.location.reload();
 window.close();
 
 </script>

</body>
</html>
