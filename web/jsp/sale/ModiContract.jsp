    <%@ page contentType="text/html;charset=GBK" %>
	<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<title>�����ͬ����</title>
</head>
<body>
 <%@ page language="java" import="java.sql.*,common.*,java.util.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="InsertBean2" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/Repalce.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%!
 
 
	  public String cnDate(String date) {
		String errstr="";
		int l=0; 
		char c1[]={'0','һ','��','��','��','��','��','��','��','��'}; 
		String DX=""; 
		String DX1=""; 
		String DX2=""; 
		if(date!=null){ 
				String year=date.substring(0,4);
				String month=date.substring(4,6);
				String day=date.substring(6,8);
				for(int i=0;i<year.length();i++){ 
					l=year.length()-i; 
				    char i_char=year.charAt(i); 
					int i_int=Integer.parseInt(String.valueOf(i_char)); 
					DX=DX+c1[i_int];
				}
				 String FT="true";
				for(int i=0;i<month.length();i++){ 
					if (!month.substring(i,i+1).equals("0")){
					 int i_int=Integer.parseInt(month.substring(i,i+1)); 
					String aa="";
					if (i==1&&FT.equals("true"))aa="ʮ";
					DX1=DX1+aa+c1[i_int];
					}else{
					 FT="false";
					}
				}
				FT="true";
				for(int i=0;i<day.length();i++){ 
					if (!day.substring(i,i+1).equals("0")){
					 int i_int=Integer.parseInt(day.substring(i,i+1)); 
					String aa="";
					if (i==1&&FT.equals("true"))aa="ʮ";
					DX2=DX2+aa+c1[i_int];
					}else{
					 FT="false";
					}
				}
				
				DX+="��"; 
				DX1+="��";
				DX2+="��";
				DX+=DX1+DX2;
			} 

		return (DX.equals(""))?errstr:DX;
	 } 
	 
  %>
<% try{%>			
<%@ include file="../public_js/getByteOut.jsp"%>
 
 <%
   
     String br=China.getParameter(request,"br");
	 if (br.equals(""))br="0";
	  String fsfc=China.getParameter(request,"fsfc");
	String rg_sumprice  =China.getParameter(request,"rg_sumprice");
	String sydk =China.getParameter(request,"sydk");
	 if (sydk.equals(""))sydk="0";
	String modijh =China.getParameter(request,"modijh");
	   String modip=China.getParameter(request,"modip");
	String moditax =China.getParameter(request,"moditax");
	 String discSQL=China.getParameter(request,"discSQL");
	String gjj =China.getParameter(request,"gjj");
	 if (gjj.equals(""))gjj="0";
	String gjjy  =China.getParameter(request,"gjjy");
	 if (gjjy.equals(""))gjjy="0";
	String fsfcmoney=China.getParameter(request,"fsfcmoney");
	 if (fsfcmoney.equals(""))fsfcmoney="0";
   String rg=China.getParameter(request,"saveorder");
   String change=China.getParameter(request,"change");
   String context=China.getParameter(request,"context");
   String oldRoom=China.getParameter(request,"oldRoom");
   String Checker=China.getParameter(request,"checker");
   String oldloft=China.getParameter(request,"oldloft");
   String oldbuild=China.getParameter(request,"oldbuild");
   String oldFloor=China.getParameter(request,"oldFloor");
   String oldarea=China.getParameter(request,"hiarea");
   String rhn=China.getParameter(request,"rhn");
   String rh=China.getParameter(request,"rh");
   String bz=China.getParameter(request,"bz");
   if (bz.equals(""))bz="0";
    String jldate=China.getParameter(request,"jldate");
   String jlbak=China.getParameter(request,"jlbak");
   String oldjldate=China.getParameter(request,"oldjldate");
      String code=request.getParameter("code");
	
   if (!oldjldate.equals(jldate)){
      String jl_bak="insert into jl_bak(con_no,old_jl,new_jl,bak) values("+code+",'";
      jl_bak+=oldjldate+"','"+jldate+"','"+jlbak+"')";
       InsertBean.executeUpdate(jl_bak);
   }
  
   String Message="";
 
   String rgsno=China.getParameter(request,"rgsno");
   String youhuibeizhu=China.getParameter(request,"youhuibeizhu");
   String youhui=China.getParameter(request,"youhui");
   String secno=request.getParameter("section");
    String secname=China.getParameter(request,"sectio");
   String oldsecno=request.getParameter("oldsection");
   String oldsecname=China.getParameter(request,"oldsectio");
   String loft=China.getParameter(request,"loft");
   String ajbk=China.getParameter(request,"ajbk");
   String note=China.getParameter(request,"note");
   String build=China.getParameter(request,"build");
   String custype=China.getParameter(request,"custype");
   String roomno=China.getParameter(request,"roomno");
   String floor=China.getParameter(request,"floor");
   String gddate=China.getParameter(request,"gddate");
   String date1=China.getParameter(request,"Date1");
   String olddate=China.getParameter(request,"olddate");//ԭ�Ϲ�����
   String constractno=China.getParameter(request,"constractno");
   String VisaDate=request.getParameter("QYDate").trim();//ǩԼ����
  
   String qydate=China.getParameter(request,"qydate");//ǩԼ��������
   String httype=China.getParameter(request,"httype");
   String StrJzdate=China.getParameter(request,"baDate");
   String tnunitprice=China.getParameter(request,"cjtnprice");
   if (tnunitprice.equals("")) tnunitprice="0.0";
   String jzunitprice=China.getParameter(request,"cjjzprice");
   String StrAjDate=China.getParameter(request,"ajDate").trim(); 
   
   String saveorder=China.getParameter(request,"saveorder"); 
   String QYDate=China.getParameter(request,"QYDate").trim();
   String kkrate=China.getParameter(request,"kkrate");
   String counttype=China.getParameter(request,"counttype");
   String StrEwDisc=China.getParameter(request,"abcd");//�����ۿ�
   if (StrEwDisc.equals(""))StrEwDisc="0";
   String StrYhMoney=China.getParameter(request,"ewyh");
 
   String StrYhMoney1=China.getParameter(request,"ewyh1");//�ϴ��Ż�
   String youhui_date=China.getParameter(request,"youhui_date");
   String disc=China.getParameter(request,"dis");
   if (disc.equals(""))disc="0";
   if (StrYhMoney.equals(""))StrYhMoney="0";
   if (StrYhMoney1.equals(""))StrYhMoney1="0";
   //��������Żݲ�һ����˵���п�������������������ϵͳ����¼�Żݼ�¼
   if (!StrYhMoney.equals(StrYhMoney1)&&StrYhMoney.equals("0")){
      String youhuiSQL="INSERT INTO DiscRecord(contractno,youhui,youhui_date,youhui_bak)";
             youhuiSQL+=" VALUES("+code+","+StrYhMoney+",'"+youhui_date+"','"+youhuibeizhu+"')";
             InsertBean.executeUpdate(youhuiSQL);
			 //���Żݱ仯ʱ�����������
			 InsertBean.executeUpdate("update Order_Contract set yh_check=0 where code="+code);
   
   }
   String Aprice=China.getParameter(request,"Adicprice");
   String yang_tai_area=China.getParameter(request,"yang_tai_area");
   if (yang_tai_area.equals(""))yang_tai_area="0";
   String lu_tai_area_price=China.getParameter(request,"lutai_area_price");
   String fx=China.getParameter(request,"fx");
   String fl=China.getParameter(request,"fl");
   String zx=China.getParameter(request,"zx");
   String lu_tai_area=China.getParameter(request,"lutai_area"); 
   String ty_area=China.getParameter(request,"ty_area"); 
   String ty_area_price=China.getParameter(request,"ty_area_price"); 
   String wd_area=China.getParameter(request,"wd_area"); 
   String wd_area_price=China.getParameter(request,"wd_area_price"); 
   String wd_area_sumprice=China.getParameter(request,"wd_area_sumprice"); 
   if (wd_area_price.equals(""))wd_area_price="0";
   if (wd_area.equals(""))wd_area="0";
   if (ty_area.equals(""))ty_area="0";
   if (ty_area_price.equals(""))ty_area_price="0";
   if (lu_tai_area.equals(""))lu_tai_area="0";
   if (lu_tai_area_price.equals(""))lu_tai_area_price="0";
   String yong_tu=China.getParameter(request,"yong_tu");  
   String tai_area_sumprice=China.getParameter(request,"tai_area_sumprice");  
      String ty_area_sumprice=China.getParameter(request,"ty_area_sumprice");  
   String G_jzarea=China.getParameter(request,"G_jzarea");  
   String G_unitprice=China.getParameter(request,"G_unitprice"); 
   String G_sumprice=China.getParameter(request,"G_sumprice");
   if (G_sumprice.equals("0"))G_jzarea="0";
   String StrAjState=China.getParameter(request,"ajtxdate");
   String StrFirstState=China.getParameter(request,"firstFT");//�����Ƿ����
   String StrAjBk=China.getParameter(request,"ajbk");
   String StrFkDate=China.getParameter(request,"fkDate").trim();
   String StrJzDate=China.getParameter(request,"baDate");
   String StrCaDate=China.getParameter(request,"caDate");
   String StrBxState=China.getParameter(request,"bx");
   String StrBxMoney=China.getParameter(request,"bxmoney");
   String StrGzState=China.getParameter(request,"gz");
     String age=China.getParameter(request,"age");
 
 
   String  [] sells=request.getParameterValues("seller");
   String seller="";
   if (sells!=null){
   for (int a=0;a<sells.length;a++){
       if (seller.equals(""))  seller=getbyte1(sells[a]);
	   else seller+="/"+getbyte1(sells[a]);
   }
   }
   String pay=China.getParameter(request,"pay");
   String oldpay=China.getParameter(request,"oldpay");
              
   String paynum="";
   String zk="";
   String payn="";
   String payname="";
  if (pay.indexOf("-")>0){	
 		 paynum=pay.substring(pay.indexOf("|")+1,pay.indexOf("#"));
		 zk=pay.substring(pay.indexOf("-")+1,pay.lastIndexOf("-"));
                 pay=pay.substring(0,pay.indexOf("-"));
				 
		 if (pay.lastIndexOf("(")>=0)
                 payname=pay.substring(0,pay.lastIndexOf("("));
		  
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
   if (ajtype.equals(""))ajtype="0";
   double ajcs=0;
   if (!China.getParameter(request,"ajcs").equals("")){
      ajcs=java.lang.Double.parseDouble(China.getParameter(request,"ajcs")); 
  }
   String ysumprice=China.getParameter(request,"sumprice");
   String yukuan=China.getParameter(request,"yukuan");
   String ajkmoney=China.getParameter(request,"ajmoney");
   String oldajkmoney=China.getParameter(request,"oldajmoney");
   if (ajkmoney.equals(""))ajkmoney="0";
  String price=China.getParameter(request,"dicprice");
  String oldsalprice =China.getParameter(request,"oldsalprice");
   String firstMoney=China.getParameter(request,"firstMoney");
   if (firstMoney.equals("")) firstMoney="0";
   if (price.equals("")) price="0.0";
   String memberNO=China.getParameter(request,"memberNO");
   String memberT=China.getParameter(request,"memberT");
   if( memberT.equals("") ) {
        memberT = "0" ;
   }	
  
  String gxr=getbyte1(request.getParameter("gxr"));

   String curry=China.getParameter(request,"curry");
   String rate=China.getParameter(request,"rate");
   String area=China.getParameter(request,"area");
   if (area.equals(""))area="0";
   String jzarea=China.getParameter(request,"jzarea");
   if (jzarea.equals(""))jzarea="0";
//*****�ͻ�����
  
   String editnow=China.getParameter(request,"editnow");
   String cusname=China.getParameter(request,"cusname");
   String Cus_Name=China.getParameter(request,"cusname1");
   String Phone=China.getParameter(request,"tel");
   String ID_Card=China.getParameter(request,"carid");
   String Address=China.getParameter(request,"Address");
   String Zip_Code=China.getParameter(request,"zip");
   String bbj=China.getParameter(request,"bbj");
   String sj=China.getParameter(request,"sj");
   String firstmoney=request.getParameter("firstmoney");//�����ڿ�
   String orderstate=China.getParameter(request,"orderstate");
   String sql="";
 String paydate="7";
   String eof="false";
   
   sql="select max(code)+1 code from customer ";//����ͻ����ID
   ResultSet cusRs=InsertBean.executeQuery(sql);  
   String cus_code="";
   String sql1="";
   String cusno1="";
        if (cusRs.next()){
            cus_code=cusRs.getString("code");
		}
		cusRs.close();
		if (cus_code.equals(""))cus_code="1";
		if (editnow.equals("2")){//�������Ϊ�¿ͻ��������ӿͻ�����
		  cusno1=secno+"-"+cus_code;
		  cusname=cusno1;
		  sql="insert into customer(Section,SerialNo,Cus_Name,signatory,Phone, ";
		  sql+="ID_Card, Address,sj)";
          sql+="values('"+secno+"','"+cusno1+"','"+Cus_Name+"','"+Cus_Name+"','"+Phone+"','";
		  sql+=ID_Card+"','"+Address+"','"+sj+"')";
		  InsertBean.executeUpdate(sql);
		  String oldname=getbyte1(request.getParameter("cusname2"));
		  String zmyy=getbyte1(request.getParameter("zmyy"));
		  sql="insert into zm_bak(htno,oldname,newname,context,zmdate) values(";
		  sql+=code+",'"+oldname+"','"+Cus_Name+"','"+zmyy+"','"+getbyte1(request.getParameter("zmdate"))+"')";
		  
		  InsertBean.executeUpdate(sql);
		  
		}else	 if(editnow.equals("1")){//�޸Ŀͻ�����
		   sql1="update customer set Cus_Name='"+Cus_Name+"',bbj='"+bbj+"',sj='"+sj+"',";
           sql1+="signatory='"+Cus_Name+"',Phone='"+Phone+"',ID_Card='"+ID_Card+"',";
           sql1+="Address='"+Address+"',Zip_Code='"+Zip_Code+"',cus_age='"+age+"' where SerialNo='"+cusname+"'";
           InsertBean.executeUpdate(sql1);
        }

   
   //��¼�������

    if (!change.equals("")){
 sql="insert into ChangRoomR(secno,oldsecno,customer,Section,oldname,Loft,Build,oldRoom,floor,NowRoom,newloft,newfloor,jzarea,ChangeDate,Checker,Note,sumprice,oldprice,oldarea,olddate,newbuild)";
 sql+="values('"+secno+"','"+oldsecno+"','"+cusname+"','"+secname+"','"+oldsecname+"','"+oldloft+"','"+oldbuild+"','"+oldRoom+"',"+oldFloor+",'"+roomno+"','"+loft+"',"+floor+","+jzarea+",convert(char(24),getdate(),111),'"+Checker+"','"+context+"',"+price+","+oldsalprice+","+oldarea+",'"+date1+"','"+build+"')";
 InsertBean.executeUpdate(sql); 
 //����ԭ����Ϊδ��
 sql="update room set SaleState='1' where seccode='"+oldsecno+"' and Loft='"+oldloft+"' and building='"+oldbuild+"' and room_code='"+oldRoom+"' and floor="+oldFloor ;
 
     InsertBean.executeUpdate(sql);
	//�����ۿۼ�¼ 
 sql="update contract_disc set order_no='"+secno+loft+roomno+"' where  order_no='"+oldsecno+oldloft+oldRoom+"'";
   InsertBean.executeUpdate(sql);
 sql="update room set SaleState='2' where seccode='"+secno+"' and Loft='"+loft+"' and building='"+build+"' and room_code='"+roomno+"' and floor="+floor ;
     int c= InsertBean.executeUpdate(sql);
     sql="insert into MessageHF(order_contract,type) values("+code+",1)";
	 c= InsertBean.executeUpdate(sql);
}

 String curryDX="",upperMoney="";
 if (curry.equals("��"))curryDX="�����";
 if (curry.equals("HKD"))curryDX="�۱�";
 if (curry.equals("USD"))curryDX="��Ԫ";
  ResultSet execRs=InsertBean1.executeQuery("exec dbo.L2U "+Aprice+",0 ");//��д���ת���洢����
             if (execRs.next())
				upperMoney=getbyte(execRs.getString("dd"));
				execRs.close();
				 
			String state="1";
			 if (!QYDate.equals("")){state="2";}
			 
			 sql= bz+",'"+rgsno+"','"+constractno+"','"+secno+"','"+loft+"','";
			 sql+=build+"','"+roomno+"',"+floor+",'"+fl+"',"+"'"+fx+"',"+area+",'"+cusname+"','"+disc+"',";
			 sql+=MonthMoney+",'"+curry+"',"+rate+",'"+seller+"','"+payn+"'";
			 sql+=","+Aprice+","+earnest+",'"+date1+"','";
			 sql+=note+"','"+ajbk+"',"+ajyr+","+ajkmoney+","+ajcs+","+ajtype+","+jzarea+",";
			 sql+=rh+","+rhn+","+counttype+",'";
			 sql+=VisaDate+"','";
			 sql+=jldate+"','"+custype+"',";
			 sql+=price+",0,"+state+",";     //kkrate
			 sql+=StrFirstState;
			 sql+=",'"+StrEwDisc + "' , " + StrYhMoney ;
  		     sql+=",'"+youhui_date+"'";
		     sql+=",'"+youhuibeizhu+"','"+gxr+"','"+payname+"'"; 
		     sql+=",'"+curryDX+upperMoney+"','"+cnDate(Repalce2(jldate,"-"))+"','"+secname+"',"+httype+",";
             sql+="'"+qydate+"'"; 
			 
             sql+=","+firstmoney+","+yang_tai_area+","+lu_tai_area_price;
			 sql+=","+lu_tai_area+","+price+",'"+yong_tu+"',"+rg_sumprice+","+Aprice+","+tnunitprice+","+jzunitprice+","+ty_area_price+","+ty_area+","+wd_area_price+","+wd_area+",'"+gddate+"',"+code+",'"+memberNO+"',"+memberT+","+gjj+","+sydk+","+gjjy+",'"+StrFkDate+"','"+StrAjDate+"'";
		 
  try{ 
   if (!discSQL.equals("")){
	 //�����ۿ�
	 InsertBean.executeUpdate(discSQL); 
	 //���Ͷ����ۿ�����
	 discSQL="insert into check_Data(type,person,id,sendperson) select 1,checker,code,'"+(String)session.getAttribute("loginname")+"'  from contract_disc where order_no='"+secno+loft+roomno+"'";
	  InsertBean.executeUpdate(discSQL); 
	 }
     int a=InsertBean.executeUpdate("exec modi_order_contract "+sql);
 //����Ǽ�ʱ��ͬ�ţ���Ѻ�ͬ�ű��Ϊռ��״̬,�����ظ�����
    sql="update ContractNo set state=2 where TYPE=1 AND ContractNo='"+constractno+"' and section='"+secno+"'";
 if (!constractno.equals("")) InsertBean.executeUpdate(sql);
 //����Ǽ��Ϲ��ţ�����Ϲ��ű��Ϊռ��״̬,�����ظ�����
 sql="update ContractNo set state=2 where TYPE=0 AND ContractNo='"+rgsno+"' and section='"+secno+"'";
 if (!rgsno.equals("")) InsertBean.executeUpdate(sql);
 
    //���·���״̬Ϊ��ǩԼ.
     sql="update room set SaleState=3 where seccode='"+secno+"' and loft='"+loft+"' and building='"+build+"' and room_code='"+roomno+"' and floor="+floor ;
    if (!QYDate.equals(""))
	{  InsertBean.executeUpdate(sql);
	}else
	{
	 sql="update room set SaleState=2 where seccode='"+secno+"' and loft='"+loft+"' and building='"+build+"' and room_code='"+roomno+"' and floor="+floor ;
     InsertBean.executeUpdate(sql);
	}
	 
          //���¿ͻ�״̬Ϊ��ǩԼ.
    sql="update customer set FTSALE=4 where SerialNo='"+cusname+"'" ;
    if (!QYDate.equals(""))  InsertBean.executeUpdate(sql);
//����ı��˸���ԣ������¼���ÿ�ڿ�
cusno1="as";
String maxPAYid="";//���һ�ʸ����¼ID

if (!modijh.equals("")){
if  (!cusno1.equals("")||!oldpay.equals(payn+"a")||!olddate.equals(date1)||(Double.parseDouble(oldsalprice)!=Double.parseDouble(price)&&Integer.parseInt(oldajkmoney)+10!=Integer.parseInt(ajkmoney))){
 /*****����ͻ���Ӧ���������****/ 
      InsertBean.executeUpdate("delete GatheringRecord where ContactNo='"+code+"'");
      if (pay.indexOf("(")>0)pay=pay.substring(0,pay.indexOf(")")+1); 
      //�����һ�ν�����ʱ��
	
	String firstSQL="select paydate from PayDetail where num=1 and  PayCode =(select ID from PayMent where     PayName='"+pay+"' and num="+paynum.substring(paynum.indexOf("|")+1)+"  and seccoe='"+secno+"')";
	cusRs=InsertBean.executeQuery(firstSQL);  
	
	 if (cusRs.next())paydate=cusRs.getString("paydate");
	   cusRs.close();
	   sql="'"+cusname+"',"+code+",'"+date1+"',"+paynum+",'"+pay+"',"+price+",'";
	   sql+=curry+"',"+rate+",'"+secno+"',"+earnest+","+ajkmoney+","+paydate;
	   sql+=","+ty_area_sumprice+","+tai_area_sumprice+","+wd_area_sumprice;
	   InsertBean.executeUpdate("exec countPayList "+sql);
	  
	  
 //���ѽ��Ŀ����Ӧ����״̬
//���ѽ��Ŀ��Ϊ RMB
	String alMoney="0";
	InsertBean.executeUpdate("update factGatheringRecord set cusno='"+cusname+"' where  contractno ='"+code+"'"); 
	
	sql="select sum(factmoney*CurrRate) as factmoney  from factGatheringRecord where contractno ='"+code+"' group by contractno ";
	ResultSet FactRs=InsertBean.executeQuery(sql); 
	if (FactRs.next())alMoney=FactRs.getString("factmoney");
	FactRs.close();
    if (Double.parseDouble(alMoney)>0){
 //��RMBת��Ϊ��ͬ���Ӧ�ұ�Ľ��
      String money1="";
  String upSQL="";
  if (Double.parseDouble(rate)>1)
     money1=String.valueOf( Double.parseDouble(alMoney)/Double.parseDouble(rate));
  else money1=alMoney;
  String qs[]=new String[6];//���δ��������(����ֻ����һ���ֿ��)
      String money[]=new String[6];//���δ��������
      String sqG = " select id as shouldQS,shouldMoney-yijiao as shouldMoney  from GatheringRecord where   state<>2 and  "
             + " cusno = '" + cusname + "' "
             + "  and contactno = '" + code + "' order by id ";// order by shouldQS
            
      ResultSet rsG =  InsertBean2.executeQuery( sqG ) ;
      int counter=0;
	  
      while( rsG.next() ) {
	  maxPAYid=rsG.getString( "shouldQS" );
       qs[counter]=maxPAYid;
       money[counter]=rsG.getString( "shouldmoney" ) ;
	 
       counter++;
      }
      rsG.close() ;

 if (counter>1){
  for (int ii=0;ii<counter;ii++){//�ѵ�ǰ���Ŀ�ͻ�Ӧ�����ʱ�����θ���
        String valueStr=qs[ii];
    String valueStr1=money[ii];
    if (valueStr==null)break;
       if (Double.parseDouble(valueStr1)<=Double.parseDouble(money1)){
  upSQL="update GatheringRecord set state=2,yijiao=shouldMoney where "
  + " cusno = '" + cusname + "' "
      + "  and contactno = '" + code + "' and id="+valueStr;
   InsertBean2.executeUpdate( upSQL ) ; 
  //out.print(upSQL+"<br>");
     money1=String.valueOf(Double.parseDouble(money1)-Double.parseDouble(valueStr1));
   }else  if (Double.parseDouble(valueStr1)>Double.parseDouble(money1)){
      upSQL="update GatheringRecord set state=1,yijiao=yijiao+"+money1+" where "
      + " cusno = '" + cusname + "' "
          + "  and contactno = '" + code + "' and id="+valueStr;// shouldQS="+valueStr;
      InsertBean2.executeUpdate( upSQL ) ; 
	  // out.print(upSQL+"<br>");
break;
       } 
	  
  } 
}else  if (counter==1){
    String valueStr=qs[0];
    String valueStr1=money[0];
        upSQL="update GatheringRecord set state=2,yijiao=yijiao+"+money1+ " where "
 + " cusno = '" + cusname + "' "
     + "  and contactno = '" + code + "' and id="+valueStr;
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
}else if  (Integer.parseInt(oldajkmoney)!=Integer.parseInt(ajkmoney)&&Double.parseDouble(oldsalprice)==Double.parseDouble(price)&&oldpay.equals(payn)&&olddate.equals(date1)){ 
   //����ǰ��Ҹ����Ѱ��ҵ����ת�����һ�θ�������
 sql="update GatheringRecord set shouldMoney=shouldMoney+"+String.valueOf(Integer.parseInt(oldajkmoney)-Integer.parseInt(ajkmoney));
 sql+=" where ContactNo='"+code+"' and  id="+maxPAYid;//(select num from PayDetail where PayCode =(select ID from PayMent where PayName='"+pay+"' and num="+paynum+") and num="+paynum+")";
 int i1=InsertBean.executeUpdate(sql); 

 
}else if  (Double.parseDouble(oldsalprice)!=Double.parseDouble(price)&&oldpay.equals(payn)&&Double.parseDouble(oldajkmoney)==Double.parseDouble(ajkmoney)&&olddate.equals(date1)){ 
    
 sql="update GatheringRecord set shouldMoney=shouldMoney+"+String.valueOf(Double.parseDouble(price)-Double.parseDouble(oldsalprice));
 sql+=" where ContactNo='"+code+"' and  id="+maxPAYid;//(select num from PayDetail where PayCode =(select ID from PayMent where PayName='"+pay+"' and num="+paynum+") and num="+paynum+")";
 int i1=InsertBean.executeUpdate(sql); 
 
}
 
 
 
ResultSet FactRs=null;
 double factSk=0;
sql="select sum(factmoney*CurrRate) as factmoney  from factGatheringRecord where (period>0 and period<5) and  contractno ='"+code+"' group by contractno ";
	 FactRs=InsertBean.executeQuery(sql); 
	if (FactRs.next())factSk=FactRs.getDouble("factmoney");
	FactRs.close();
  double factSkA=0;
    sql="select sum(yijiao*rate) as factmoney  from GatheringRecord where (shouldQS>0 and shouldQS<5) and  ContactNo ='"+code+"' group by ContactNo ";
	 FactRs=InsertBean.executeQuery(sql); 
	if (FactRs.next())factSkA=FactRs.getDouble("factmoney");
	FactRs.close();
	factSkA=factSk-factSkA;
	 sql="update GatheringRecord set yijiao=yijiao+"+String.valueOf(factSkA);
 sql+=" where ContactNo='"+code+"' and  shouldQS="+paynum;//(select num from PayDetail where PayCode =(select ID from PayMent where PayName='"+pay+"' and num="+paynum+") and num="+paynum+")";
 
  int i90=InsertBean.executeUpdate(sql); 
   sql="select sum(factmoney*CurrRate) as factmoney  from factGatheringRecord where   period=5  and  contractno ='"+code+"' group by contractno ";
	 FactRs=InsertBean.executeQuery(sql); 
	if (FactRs.next())factSk=FactRs.getDouble("factmoney");
	FactRs.close();
 
  sql="select sum(yijiao*rate) as factmoney  from GatheringRecord where shouldQS=5  and  ContactNo ='"+code+"' group by ContactNo ";
	 FactRs=InsertBean.executeQuery(sql); 
	if (FactRs.next())factSkA=FactRs.getDouble("factmoney");
	FactRs.close();
	factSkA=factSk-factSkA;
	 sql="update GatheringRecord set yijiao=yijiao+"+String.valueOf(factSkA);
     sql+=" where ContactNo='"+code+"' and  shouldQS=5";//(select num from PayDetail where PayCode =(select ID from PayMent where PayName='"+pay+"' and num="+paynum+") and num="+paynum+")";

 
 int i99=InsertBean.executeUpdate(sql); 
 }
  //����ѷſ��Ѱ��ҿ�浽�ſ��¼��
                     if (!StrFkDate.equals("")){
                      sql="select * from FactAjCharges where contractno="+code;
                 ResultSet ajR=  InsertBean2.executeQuery( sql) ;

                      if (!ajR.next()){
                       sql="insert into FactAjCharges select code as contractno,customer,";
                       sql+="ajmoney as FactMonye,fkdate as FactDate,'' as Chekcer,0 as out,";
                       sql+=" 1 as send,'','','',0,ajbk,1,''  from Order_Contract  where code="+code;
                         InsertBean.executeUpdate(sql); 
                     }
                      ajR.close();
                   }
 
 String checkefsfcmoney=getbyte(request.getParameter("checkefsfcmoney"));
 //���¶����ۿ�״̬
InsertBean.executeUpdate("update order_contract set ysumprice="+ysumprice+",yh_zs='"+youhui+"' where code="+code);

 InsertBean.executeUpdate("update contract_disc set ok=1 where order_no='"+secno+loft+roomno+"'");
   if (!fsfc.equals("")&&checkefsfcmoney.equals("")){
			      if (br.equals("0")){
				  //����������
				  sql="insert into GatheringRecord select '"+cusname+"' as cusno,'"+code+"',15 as shouldQS,dateadd(dd,"+paydate+",'"+date1+"') as shouldDate,"+fsfcmoney+" as shouldMoney,0 as yijiao,0 as state,0 as out,0 as demurrage,1 as send,'"+curry+"',"+rate+"  ";
  		          InsertBean.executeUpdate(sql);
				 }
			   StringTokenizer st22 = new StringTokenizer(fsfc,",") ;
                int count2 = st22.countTokens() ;
				 while (st22.hasMoreElements()) {
				   fsfc= (String)st22.nextElement(); 
				    InsertBean.executeUpdate("insert into fsfc(roomcode,order_contract,br,money) values("+fsfc+","+code+","+br+","+fsfcmoney+")");
			        InsertBean.executeUpdate("update room set salestate=2 where code="+fsfc);
			        fsfcmoney="0";
				  }
			 }
 setlog(setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "�Ϲ�����" , 
                  "�޸�/���Ӻ�ͬ����("+secname+build+loft+roomno+")"
                ) ;
%>	
  <script>
  <%if (!change.equals("")){ %>
  opener.window.document.frm.submit();
  <%} %>
  <%if (VisaDate.equals("")){ %>
 if (confirm("ϵͳ�ѱ������ݣ��Ƿ��״��Ϲ��飿"))   window.open("printRG.jsp?code=<%=code %>");     
 <%} %>  
  window.location="../finance/TaxCount1.jsp?modip=<%=modip %>&moditax=<%=moditax %>&contractno=<%=code %>&cusno=<%=cusname %>&pay=<%=pay %>&custype=<%=custype %>&ldroomcode=<%=China.getParameter(request,"code") %>";
   </script>
<%
  }
      catch(SQLException ex)
        {out.print(ex.getMessage()+sql);
          }
   }catch(Exception s){out.print("ϵͳ�����쳣���󣬴���ԭ��"+s);}
   
  %>
</body>
</html>
 
