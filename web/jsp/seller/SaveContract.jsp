<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title></title>
</head>
<body>
 <%@ page language="java" import="java.sql.*,common.*,java.util.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="InsertBean2" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/Repalce.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
<%!
	 public void ShowTax(String sqlstr,String cusno1,float pri,String orderno) throws Exception  {
	  String SqlStr = sqlstr;
	  String  str="";
	  String state="";

      float taxchage=0;
	  int jjj=0;
	 ConnDatabase.SDatabase ViewBean1=new ConnDatabase.SDatabase();
     ConnDatabase.SDatabase ViewBean2=new ConnDatabase.SDatabase();
	 ResultSet TaxRs = ViewBean1.executeQuery(SqlStr);
		
		while (TaxRs.next()) {
		int     id = TaxRs.getInt("ID");
		String  TaxName = getbyte(TaxRs.getString("TaxName"));
	    float  money = TaxRs.getFloat("money");
		String  TermArea=TaxRs.getString("TermArea");
		state=TaxRs.getString("state");
	    jjj++;
 		
  		
  if (state.equals("1"))//���ۼ۰ٷֱȼ���
    taxchage=money*pri/100;
  else   if (state.equals("2"))//���̶�������
    taxchage=money;
  /*else   if (state.equals("3"))//�������������
    {
     if (String.valueOf(SaleArea)+TermArea)
	 SalePrice+=SaleArea*money;
	}*/
  else   if (state.equals("4"))//����������
  taxchage=1*money;
  String SQL="insert into GatheringTaxRecord(cusno,ContactNo,TaxName,TaxMoney) values('"+cusno1+"',"+orderno+",'"+TaxName+"',"+taxchage+")";
  ViewBean2.executeUpdate(SQL);
  }
 
 TaxRs.close();

}
%>
 <%
   String rg=China.getParameter(request,"saveorder");
   String change=China.getParameter(request,"change");
   String context=China.getParameter(request,"context");
   String oldRoom=China.getParameter(request,"oldRoom");
   String Checker=China.getParameter(request,"checker");
   String oldloft=China.getParameter(request,"oldloft");
   String oldarea=China.getParameter(request,"hiarea");
   String roomtype=China.getParameter(request,"fx");
 
   String Message="";
   String code=request.getParameter("code");
   String rgsno=request.getParameter("rgsno");
   String youhuibeizhu=China.getParameter(request,"youhuibeizhu");
   String youhui=China.getParameter(request,"youhui");
   String secno=request.getParameter("section");
   String secname=China.getParameter(request,"sectio");
   String loft=China.getParameter(request,"loft");
   String ajbk=China.getParameter(request,"ajbk");
   String note=China.getParameter(request,"note");
   String build=China.getParameter(request,"build");
   String custype=China.getParameter(request,"custype");
   String roomno=request.getParameter("roomno");
   String floor=request.getParameter("floor");
   String date1=request.getParameter("Date1");
   String olddate=request.getParameter("olddate");//ԭ�Ϲ�����
   String constractno=request.getParameter("constractno");
   String VisaDate=China.getParameter(request,"QYDate");//ǩԼ����
   
   String qydate=China.getParameter(request,"qydate");//ǩԼ��������
    String httype=China.getParameter(request,"httype");
   String StrJzdate=China.getParameter(request,"baDate");
   String StrAjDate=China.getParameter(request,"ajDate");	
   String saveorder=request.getParameter("saveorder");	
   String QYDate=China.getParameter(request,"QYDate");
   String kkrate=China.getParameter(request,"kkrate");
   String StrEwDisc=China.getParameter(request,"abcd");//�����ۿ�
   String StrYhMoney=China.getParameter(request,"ewyh");
   if (StrYhMoney.equals(""))StrYhMoney="0";
   String StrAjState=China.getParameter(request,"aj");
   String StrFirstState=China.getParameter(request,"firstFT");//�����Ƿ����
   String StrAjBk=China.getParameter(request,"ajbk");
   String StrFkDate=China.getParameter(request,"fkDate");
   String StrJzDate=China.getParameter(request,"baDate");
   String StrCaDate=China.getParameter(request,"caDate");
   String StrBxState=China.getParameter(request,"bx");
   String StrBxMoney=China.getParameter(request,"bxmoney");
   String StrGzState=China.getParameter(request,"gz");
   String[] seller=request.getParameterValues("seller");
   String sell="";
   for(int i=0;i<seller.length;i++){
   if (seller.length==1){
     sell=new String(seller[0].trim().getBytes("ISO8859_1"),"GBK");
	 }else {
	  if(sell.equals(""))
	     sell=new String(seller[i].trim().getBytes("ISO8859_1"),"GBK");
	  else
	     sell=sell+"/"+new String(seller[i].trim().getBytes("ISO8859_1"),"GBK");
     }
   }
   
   String pay=China.getParameter(request,"pay");
   String oldpay=China.getParameter(request,"oldpay");
   String paynum="";
   String zk="";
   String payn="";
   String payname="";
  // if (pay.indexOf("g")>=0) pay= pay.substring(0, pay.indexOf("g"));
 
  if (pay.indexOf("-")>0){	
 		 paynum=pay.substring(pay.indexOf("*")+1,pay.indexOf("#"));
		 zk=pay.substring(pay.indexOf("-")+1,pay.lastIndexOf("-"));
                 pay=pay.substring(0,pay.indexOf("-"));
		 if (pay.indexOf("(")>=0)
                 payname=pay.substring(0,pay.indexOf("("));
                 else{
                  if (pay.indexOf(".")>0) payname=pay.substring(0,pay.indexOf("."));
                  else
                     payname=pay;
                   }

              
		 payn=pay+"."+paynum;
	} 
     String newPay="";
	
    String ajyr=China.getParameter(request,"ajyr");
   String MonthMoney=China.getParameter(request,"MonthMoney");
   if (MonthMoney.equals(""))MonthMoney="0";
   String earnest=China.getParameter(request,"earnest");
   if (ajyr.equals(""))ajyr="0";
   String ajtype=China.getParameter(request,"ajtype");
   float ajcs=0;
   if (!China.getParameter(request,"ajcs").equals("")){
      ajcs=java.lang.Float.parseFloat(China.getParameter(request,"ajcs"));	
  }
   String yukuan=China.getParameter(request,"yukuan");
   String ajkmoney=China.getParameter(request,"ajmoney");
   String oldajkmoney=China.getParameter(request,"oldajmoney");
   if (ajkmoney.equals(""))ajkmoney="0";
  String price=China.getParameter(request,"dicprice");
  String oldsalprice =China.getParameter(request,"oldsalprice");
   String firstMoney=China.getParameter(request,"firstMoney");
   if (firstMoney.equals("")) firstMoney="0";
   if (price.equals("")) price="0.0";
  
	
   String curry=China.getParameter(request,"curry");
   String rate=China.getParameter(request,"rate");
   String tnunitprice=China.getParameter(request,"tnunitprice");
   if (tnunitprice.equals("")) tnunitprice="0.0";
   String jzunitprice=China.getParameter(request,"jzunitprice");
   if (jzunitprice.equals(""))jzunitprice="0.0";
   String area=China.getParameter(request,"area");
   if (area.equals(""))area="0";
   String jzarea=China.getParameter(request,"jzarea");
   if (jzarea.equals(""))jzarea="0";
   float perarea=0;
   perarea=Float.parseFloat(jzarea)/seller.length;

//*****�ͻ�����
   
   String cusname=China.getParameter(request,"cusname");
   String Cus_Name=China.getParameter(request,"cusname1");
   String Phone=China.getParameter(request,"tel");
   String ID_Card=China.getParameter(request,"carid");
   String Address=China.getParameter(request,"Address");
   String Zip_Code=China.getParameter(request,"post");
   String bbj=China.getParameter(request,"bbj");
   String sj=China.getParameter(request,"sj");
   
   String orderstate=China.getParameter(request,"orderstate");
   String sql="";
 
   String eof="false";
   //��¼�������
    if (!change.equals("")){
			 sql="insert into ChangRoomR(secno,customer,Section,Loft,Build,OldRoom,NowRoom,jzarea,ChangeDate,Checker,Note,nowloft,nowjzarea)";
			 sql+="values('"+secno+"','"+cusname+"','"+secname+"','"+oldloft+"','"+build+"','"+oldRoom+"','"+roomno+"',"+oldarea;
			 sql+=",convert(char(24),getdate(),111),'"+Checker+"','"+context+"','"+loft+"',"+jzarea+")";
			 InsertBean.executeUpdate(sql);	
			 //����ԭ����Ϊδ��
			 sql="update room set SaleState='1' where seccode='"+secno+"' and Loft='"+oldloft+"' and building='"+build+"' and room_code='"+oldRoom+"'" ;
		     InsertBean.executeUpdate(sql);
			 sql="update room set SaleState='2' where seccode='"+secno+"' and Loft='"+loft+"' and building='"+build+"' and room_code='"+roomno+"'" ;
		     int c= InsertBean.executeUpdate(sql);
			  
	}
       String cusno1="";
    /*   sql="select * from customer where cus_name like '%"+Cus_Name+"%' and ID_Card like '%"+ID_Card+"%'";
		ResultSet cusRs=InsertBean.executeQuery(sql);	 
        if (!cusRs.next()){
		
             //���㵱ǰ�ͻ��ı��
		     sql="select max(serialno) as cusno from customer where section='"+secno+"'";
	         ResultSet MaxCusNo=InsertBean1.executeQuery(sql);
             if (MaxCusNo.next()){
	           cusno1=MaxCusNo.getString("cusno");
	           int abc=0;
	           String def="";
               if (cusno1==null)  cusno1="";
			
  	           if (!cusno1.substring(cusno1.lastIndexOf("-")+1).equals("")){
			 abc=Integer.parseInt(cusno1.substring(cusno1.lastIndexOf("-")+1))+1;
			 if (abc<10){
		          def="000"+String.valueOf(abc);
				  }
		         else if (abc>=10&&abc<100){
 		          def="00"+String.valueOf(abc);}
		         else if (abc>=100&&abc<1000){
 		          def="0"+String.valueOf(abc);} 
		         else if (abc>=1000&&abc<10000){
 		         def=String.valueOf(abc);} 
	            cusno1=secno+"-"+def;	   
	           }else{cusno1=secno+"-"+"0001";}  	  
                }else{cusno1=secno+"-"+"0001";} 
	  	    MaxCusNo.close();
		  sql="insert into customer(Section,SerialNo,Cus_Name,signatory,Phone, ";
		  sql+="ID_Card, Address,sj)";
		  sql+=" values('"+secno+"','"+cusno1+"','"+Cus_Name+"','"+Cus_Name+"','"+Phone+"','";
		  sql+=ID_Card+"','"+Address+"','"+sj+"')";
            
	 
 int h= InsertBean.executeUpdate(sql);
          }
          if (!cusno1.equals("")) cusname=cusno1;
		
          cusRs.close();
		  */
	 // if (saveorder.equals("insert")){
        
 	
	     //����������֤�ѣ����Һ�ͬ��֤�ѣ����ұ��շѣ���Ѻ��
		  String chargesSQL="SELECT state,TaxName,money FROM TaxChages where TaxName LIKE '%������ͬ��֤��%'"
		         +" or TaxName LIKE '%���Һ�ͬ��֤��%'  or TaxName LIKE '%��Ѻ%'";
		 
		  ResultSet chargesRs=InsertBean.executeQuery(chargesSQL);
		  String ajgzcharges="0";
		  String htgzcharges="0";
		  String dycharges="0";
		  String bxcharges="0";
		  while (chargesRs.next()){
		      String counttype=chargesRs.getString("state");
			  String chargesname=getbyte(chargesRs.getString("TaxName"));
			  float countmoney=chargesRs.getFloat("money");    
			  
			  if (counttype.equals("1")&&Integer.parseInt(ajkmoney)>10000){//�������Ҳ��д˷���
			    if (chargesname.indexOf("���Һ�ͬ��֤��")>=0&&pay.indexOf("��")>=0)
				   
				   ajgzcharges=String.valueOf(Float.parseFloat(ajkmoney)*countmoney/100);
				
			    if (chargesname.indexOf("������ͬ��֤��")>=0 && counttype.equals("1"))//�������д˷���
				   htgzcharges=String.valueOf(Float.parseFloat(price)*countmoney/100);
				   
			    if (chargesname.indexOf("��Ѻ")>=0&&pay.indexOf("��")>=0){
				   if (Integer.parseInt(ajkmoney)>10000)
				   dycharges=String.valueOf(Float.parseFloat(ajkmoney)*countmoney/100);
				   
				   }else{
				   dycharges="100";
				   }
			  }else  if (counttype.equals("2")){//���̶�������
			    if (chargesname.indexOf("���Һ�ͬ��֤��")>=0&&pay.indexOf("��")>=0)
				   ajgzcharges=String.valueOf(countmoney);
			    if (chargesname.indexOf("���ұ��շ�")>=0&&pay.indexOf("��")>=0)
				   bxcharges=String.valueOf(countmoney);
			    if (chargesname.indexOf("������ͬ��֤��")>=0)
				   htgzcharges=String.valueOf(countmoney);   
			    if (chargesname.indexOf("��Ѻ")>=0&&pay.indexOf("��")>=0)
				   dycharges=String.valueOf(countmoney);
			  }
		  }
		
		 chargesRs.close();
	   
	         String curryDX="";
			 if (curry.equals("��"))curryDX="�����";
			 if (curry.equals("HKD"))curryDX="�۱�";
			 if (curry.equals("USD"))curryDX="��Ԫ";
		 
		   sql="update Order_Contract set ContractNo='"+constractno+"',seller='"+sell+"',customer='"+cusname+"'";
		   sql+=",serialno='"+rgsno+"',GzState="+StrGzState+",youhuibeizhu='"+youhuibeizhu+"'";
		   sql+=",loft='"+loft+"',area="+area+",jzarea="+jzarea+",unitPrice="+tnunitprice+",tnunitprice="+jzunitprice+",Room_no='"+roomno+"',payment='"+payn+"',custype='"+custype+"',date='"+date1+"'";
		   sql+=",currency='"+curry+"',rate="+rate+",salerprice="+price+",RMBPrice="+price+"*"+rate;
		   sql+=",AjMoney="+ajkmoney+",AJcs="+ajcs+",MonthPayMoney="+MonthMoney+",AjYear="+ajyr;
		   sql+=",subscription="+earnest+",bxcharges="+StrBxMoney+",roomtype='"+roomtype+"',floors="+floor;
		   sql+=",uppercaseMoney='"+curryDX+cnMoney(price)+"',ajgzcharges="+ajgzcharges;
		      sql+=",gzcharges="+htgzcharges+",dycharges="+dycharges+",payment1='"+payname+"'";
              if (!qydate.equals(""))
		   sql+=",qytxdate=dateadd(dd,"+qydate+","+date1+")";
		   
		   if (!StrAjDate.equals(""))
		   sql+=",ajDate='"+StrAjDate+"',ajbk='"+StrAjBk+"'";
		   sql+=",note='"+note+"',bxState="+StrBxState+",BxMoney="+StrBxMoney+",youhui='"+youhui+"'";
		   sql+=",firstState="+StrFirstState;
		   if (!QYDate.equals(""))
		   sql+=",VisaDate='"+QYDate+"',state='2'";
		  
		   if (!StrFkDate.equals(""))
		   sql+=",fkDate='"+StrFkDate+"'";
		   if (!StrCaDate.equals(""))
		   sql+=",OutDate='"+StrCaDate+"',perarea="+perarea+"";
		   sql+="  where code="+code;

		  try{
		
		//   InsertBean.startTransaction();
			int a=InsertBean.executeUpdate(sql);
			//���·����ܼ�.
          //  sql="update room set Sumprice="+price+" where seccode='"+secno+"' and loft='"+loft+"' and building='"+build+"' and room_code='"+roomno+"'" ;
			// InsertBean.executeUpdate(sql);
           //���·���״̬Ϊ���Ϲ�.
            sql="update room set SaleState=3  where seccode='"+secno+"' and loft='"+loft+"' and building='"+build+"' and room_code='"+roomno+"'" ;
			
		    if (!QYDate.equals(""))   InsertBean.executeUpdate(sql);
          //���¿ͻ�״̬Ϊ���Ϲ�.
		  
            sql="update customer set FTSALE=4 where SerialNo='"+cusname+"'" ;
          
		    if (!QYDate.equals(""))  InsertBean.executeUpdate(sql);
			
             
             String sql1="update customer set Cus_Name='"+Cus_Name+"',bbj='"+bbj+"',sj='"+sj+"',";
		    sql1+="signatory='"+Cus_Name+"',Phone='"+Phone+"',ID_Card='"+ID_Card+"',";
		    sql1+="Address='"+Address+"',Zip_Code='"+Zip_Code+"',payment='"+payname+"' where SerialNo='"+cusname+"'";
         //  if (cusno1.equals(""))
           InsertBean.executeUpdate(sql1);
		
		sql="update GatheringRecord set cusno='"+cusname+"' where ContactNo='"+code+"'" ;

 int xd=InsertBean.executeUpdate(sql); 
 
 sql="update FactGatheringRecord set cusno='"+cusname+"' where ContractNo='"+code+"'" ;

 int xc=InsertBean.executeUpdate(sql); 

sql=" update FactAjCharges set customer='"+cusname+"', factmonye="+ajkmoney+" where ContractNo='"+code+"'" ;

 int xr=InsertBean.executeUpdate(sql); 
	
		//����ı��˸���ԣ������¼���ÿ�ڿ�
		if  (!cusno1.equals("")||!oldpay.equals(payn)||!olddate.equals(date1)||(Float.parseFloat(oldsalprice)!=Float.parseFloat(price)&&Integer.parseInt(oldajkmoney)!=Integer.parseInt(ajkmoney))){
			 /*****����ͻ���Ӧ���������****/	
            InsertBean.executeUpdate("delete GatheringRecord where ContactNo='"+code+"'");
	   if (pay.indexOf("(")>0)pay=pay.substring(0,pay.indexOf(")")+1);		
			 
           //  if (pay.indexOf("��")>=0)price=firstMoney; 
			 //���������ٱȼ��㣬���ڰ�������������������
			 sql="insert into GatheringRecord select '"+cusname+"' as cusno,'"+code+"',num as shouldQS,convert(char(24),dateadd(dd,paydate,'"+date1+"'),111) as shouldDate,scale/100*("+price+") as shouldMoney,0 as yijiao,0 as state,0 as out,0 as demurrage,1 as send,'"+curry+"',"+rate+" from PayDetail where PayCode =(select ID from PayMent where PayName='"+pay+"' and num="+paynum+") and state1='0' and state2='0'";
			 int e=InsertBean.executeUpdate(sql);	
                   
			 //���������ٱȼ��㣬���ڰ�ָ�����ڼ����������
			 sql="insert into GatheringRecord select '"+cusname+"' as cusno,'"+code+"',num as shouldQS,convert(char(24),Date,111) as shouldDate,scale/100*("+price+") as shouldMoney,0 as yijiao,0 as state,0 as out,0 as demurrage,1 as send,'"+curry+"',"+rate+" from PayDetail where PayCode =(select ID from PayMent where PayName='"+pay+"' and num="+paynum+") and state1='0' and state2='1' ";
  		     int f=InsertBean.executeUpdate(sql);	
			  //���������̶����㣬���ڰ�������ڼ����������
			 sql="insert into GatheringRecord select '"+cusname+"' as cusno,'"+code+"',num as shouldQS,convert(char(24),dateadd(dd,paydate,'"+date1+"'),111) as shouldDate,money as shouldMoney,0 as yijiao,0 as state,0 as out,0 as demurrage,1 as send,'"+curry+"',"+rate+" from PayDetail where PayCode =(select ID from PayMent where PayName='"+pay+"' and num="+paynum+") and state1='1' and state2='0' ";
			 int g=InsertBean.executeUpdate(sql);	
			// out.println(sql+"<br>");
			 //��������ָ�����ڰ�ָ�����ڼ����������
			 sql="insert into GatheringRecord select '"+cusname+"' as cusno,'"+code+"',num as shouldQS,convert(char(24),Date,111) as shouldDate,money as shouldMoney,0 as yijiao,0 as state,0 as out,0 as demurrage,1 as send,'"+curry+"',"+rate+" from PayDetail where PayCode =(select ID from PayMent where PayName='"+pay+"' and num="+paynum+") and state1='1' and state2='1' ";
  		     int h=InsertBean.executeUpdate(sql);	
			// out.println(sql);
			  	
			 //�ڰ�������ĸ������м�ȥ�Ϲ�ʱ���Ķ��𣬵õ�ʵ��Ӧ�Ľ��
			 sql="update GatheringRecord set shouldMoney=shouldMoney-"+earnest;
			 sql+=" where ContactNo='"+code+"' and shouldQS=(select num from PayDetail where PayCode =(select ID from PayMent where PayName='"+pay+"' and num="+paynum+") and state3=1)";
			 int i=InsertBean.executeUpdate(sql);	
			//���һ�ڵ�������-ǰ����
			
			 sql="update GatheringRecord set shouldMoney=(select "+price+"-"+ajkmoney+"-case when SUM(shouldMoney) is null then 0 else  SUM(shouldMoney) end from GatheringRecord where  ContactNo='"+code+"' and shouldQS<"+paynum+")";
			 sql+=" where ContactNo='"+code+"' and  shouldQS="+paynum;//(select num from PayDetail where PayCode =(select ID from PayMent where PayName='"+pay+"' and num="+paynum+") and num="+paynum+")";
		
			 int i1=InsertBean.executeUpdate(sql);	
            //���ѽ��Ŀ����Ӧ����״̬
			//���ѽ��Ŀ��Ϊ RMB
			String alMoney="0";
			sql="select sum(factmoney*CurrRate) as factmoney  from factGatheringRecord where contractno ='"+code+"' group by contractno ";
			ResultSet FactRs=InsertBean.executeQuery(sql);	
			if (FactRs.next())alMoney=FactRs.getString("factmoney");
			FactRs.close();
			
			
	       if (Float.parseFloat(alMoney)>0){
			 //��RMBת��Ϊ��ͬ���Ӧ�ұ�Ľ��
			      String money1="";
				  String upSQL="";
				  if (Float.parseFloat(rate)>1)
				     money1=String.valueOf( Float.parseFloat(alMoney)/Float.parseFloat(rate));
				  else money1=alMoney;
					
				  String qs[]=new String[6];//���δ��������(����ֻ����һ���ֿ��)
			      String money[]=new String[6];//���δ��������
			      String sqG = " select shouldQS,shouldMoney-yijiao as shouldMoney  from GatheringRecord where   state<>2 and  "
			             + " cusno = '" + cusname + "' "
			             + "  and contactno = '" + code + "' order by shouldQS ";
			            
			      ResultSet rsG =  InsertBean2.executeQuery( sqG ) ;
			      int counter=0;
			      while( rsG.next() ) {
			       qs[counter]=rsG.getString( "shouldQS" );
			       money[counter]=rsG.getString( "shouldmoney" ) ;
			       counter++;
			      }
			      rsG.close() ;
				
				 if (counter>1){
				  for (int ii=0;ii<counter;ii++){//�ѵ�ǰ���Ŀ�ͻ�Ӧ�����ʱ�����θ���
			        String valueStr=qs[ii];
				    String valueStr1=money[ii];
				    if (valueStr==null)break;
			  	    if (Float.parseFloat(valueStr1)<=Float.parseFloat(money1)){
					  upSQL="update GatheringRecord set state=2,yijiao=shouldMoney where "
					  + " cusno = '" + cusname + "' "
				      + "  and contactno = '" + code + "' and shouldQS="+valueStr;
					  InsertBean2.executeUpdate( upSQL ) ; 
					// out.print(upSQL+"<br>");
				     money1=String.valueOf(Float.parseFloat(money1)-Float.parseFloat(valueStr1));
				   }else  if (Float.parseFloat(valueStr1)>Float.parseFloat(money1)){
				      upSQL="update GatheringRecord set state=1,yijiao=yijiao+"+money1+" where "
				      + " cusno = '" + cusname + "' "
			          + "  and contactno = '" + code + "' and shouldQS="+valueStr;
				     InsertBean2.executeUpdate( upSQL ) ; 
					break;
			       }	
				  } 
				}else  if (counter==1){
				    String valueStr=qs[0];
				    String valueStr1=money[0];
			        upSQL="update GatheringRecord set state=2,yijiao=yijiao+"+money1+ " where "
					 + " cusno = '" + cusname + "' "
				     + "  and contactno = '" + code + "' and shouldQS="+valueStr;
					InsertBean2.executeUpdate( upSQL ) ;
				}else if (counter==0){
				  upSQL="update GatheringRecord set state=2,yijiao=yijiao+"+money1+ " where "
					 + " cusno = '" + cusname + "' "
				     + "  and contactno = '" + code + "' and shouldQS=(select max(shouldQS) from GatheringRecord where  "
					 + " cusno = '" + cusname + "' "
				     + "  and contactno = '" + code + "')";
					InsertBean2.executeUpdate( upSQL ) ;
					//out.print(upSQL);
				
				}
			}
		}else if  (Integer.parseInt(oldajkmoney)!=Integer.parseInt(ajkmoney)&&Float.parseFloat(oldsalprice)==Float.parseFloat(price)&&oldpay.equals(payn)&&olddate.equals(date1)){	
		//������ҿ�ȣ���δ�ı丶�ʽ�����Ϲ�����δ��,������ӵ����һ��
		
		   //����ǰ��Ҹ����Ѱ��ҵ����ת�����һ�θ�������
			 sql="update GatheringRecord set shouldMoney=shouldMoney+"+String.valueOf(Integer.parseInt(oldajkmoney)-Integer.parseInt(ajkmoney));
			 sql+=" where ContactNo='"+code+"' and  shouldQS="+paynum;//(select num from PayDetail where PayCode =(select ID from PayMent where PayName='"+pay+"' and num="+paynum+") and num="+paynum+")";
			 int i1=InsertBean.executeUpdate(sql);	
		
		 
		}else if  (Float.parseFloat(oldsalprice)!=Float.parseFloat(price)&&oldpay.equals(payn)&&Float.parseFloat(oldajkmoney)==Float.parseFloat(ajkmoney)&&olddate.equals(date1)){	
		    
			 sql="update GatheringRecord set shouldMoney=shouldMoney+"+String.valueOf(Float.parseFloat(price)-Float.parseFloat(oldsalprice));
			 sql+=" where ContactNo='"+code+"' and  shouldQS="+paynum;//(select num from PayDetail where PayCode =(select ID from PayMent where PayName='"+pay+"' and num="+paynum+") and num="+paynum+")";
			 int i1=InsertBean.executeUpdate(sql);	
			 
		}
			 
			  // out.println(sql);out.close();
			  //����ͻ�Ӧ������˰��
			   InsertBean2.executeUpdate("delete GatheringTaxRecord where ContactNo='"+code+"'");
             ShowTax("select id,TaxName,money,TermArea,state from TaxChages",cusname,Float.parseFloat(price),code);
			
        
		 //  InserInsertBean2.commit();
		 //  InsertBean.endTransaction();
		  //����ѷſ��Ѱ��ҿ�浽�ſ��¼��
                     if (!StrFkDate.equals("")){
                      sql="select * from FactAjCharges where contractno="+code;
  	              ResultSet ajR=  InsertBean2.executeQuery( sql) ;

                      if (!ajR.next()){
                       sql="insert into FactAjCharges select code as contractno,customer,";
                       sql+="ajmoney as FactMonye,fkdate as FactDate,'' as Chekcer,0 as out,";
                       sql+=" 1 as send  from Order_Contract  where code="+code;
                         InsertBean.executeUpdate(sql);	
                     }
                      ajR.close();
                   }
                              
		 %>
		  <script>
		   alert("ϵͳ�ѱ�������");
		 
		   opener.window.location.reload();
			  window.location="../finance/yingshi.jsp?contractno=<%=code %>&cusno=<%=cusname %>&pay=<%=pay %>&custype=<%=custype %>&ldroomcode=<%=China.getParameter(request,"code") %>";

		   </script>
		<%
		  }
	      catch(SQLException ex)
 	      {out.print(ex.getMessage()+sql);
          }
     
  %>
</body>
</html>
