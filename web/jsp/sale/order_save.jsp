<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/logrecord.jsp" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>保存认购数据</title>
</head>
 
 
<body>
 <%@ page language="java" import="java.sql.*,common.*,java.util.*" %>
 <jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
 <%!
 
 
	  public String cnDate(String date) {
		String errstr="";
		int l=0; 
		char c1[]={'0','一','二','三','四','五','六','七','八','九'}; 
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
					if (i==1&&FT.equals("true"))aa="十";
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
					if (i==1&&FT.equals("true"))aa="十";
					DX2=DX2+aa+c1[i_int];
					}else{
					 FT="false";
					}
				}
				
				DX+="年"; 
				DX1+="月";
				DX2+="日";
				DX+=DX1+DX2;
			} 

		return (DX.equals(""))?errstr:DX;
	 }
  %>
  
 <%
    java.text.DecimalFormat df = new java.text.DecimalFormat("########.##");	
try{
   String Message="";
   String eof="false";
   String constractno=China.getParameter(request,"constractno");
   String state="";
     String br=China.getParameter(request,"br");
	 if (br.equals(""))br="0";
	  String fsfc=China.getParameter(request,"fsfc");
	String sydk =China.getParameter(request,"sydk");
	 if (sydk.equals(""))sydk="0";
	 String discSQL=China.getParameter(request,"discSQL");
	String gjj =China.getParameter(request,"gjj");
	 if (gjj.equals(""))gjj="0";
	String gjjy  =China.getParameter(request,"gjjy");
	 if (gjjy.equals(""))gjjy="0";
	String fsfcmoney=China.getParameter(request,"fsfcmoney");
	 if (fsfcmoney.equals(""))fsfcmoney="0";
    String countType=China.getParameter(request,"bz");
	if (countType.equals(""))countType="0";
   String kkrate=China.getParameter(request,"kkrate");
   String StrEwDisc=China.getParameter(request,"abcd");//额外折扣
      if (StrEwDisc.equals(""))StrEwDisc="0";
   String StrYhMoney=China.getParameter(request,"ewyh");
   if (StrYhMoney.equals(""))StrYhMoney="0";
   String youhui_date=China.getParameter(request,"youhui_date");
   String gxr=China.getParameter(request,"gxr");
   String StrAjDate=China.getParameter(request,"ajDate");
  
   String StrFirstState=China.getParameter(request,"firstFT");//首期是否完成

   String StrFkDate=China.getParameter(request,"fkDate");
   String StrJzDate=China.getParameter(request,"baDate");
   String gddate=China.getParameter(request,"gddate");

   String StrCaDate=China.getParameter(request,"caDate");
   String StrBxState=China.getParameter(request,"bx");
   String StrBxMoney=China.getParameter(request,"bxmoney");
   String StrGzState=China.getParameter(request,"gz");
   String demurrage=China.getParameter(request,"demurrage");
   if( demurrage.equals("") ) {
        demurrage = "0" ;
   }	
   String memberNO=China.getParameter(request,"memberNO");
     String memberT=China.getParameter(request,"memberT");
   if( memberT.equals("") ) {
        memberT = "0" ;
   }	
   String hisumprice=China.getParameter(request,"hisumprice");	
   String hiarea=China.getParameter(request,"hiarea");	
   String rgsno=China.getParameter(request,"rgsno");
   String secnA=China.getParameter(request,"sectio");
   String secno=China.getParameter(request,"section");
   String loft=China.getParameter(request,"loft");
   String build=China.getParameter(request,"build");
   String roomno=China.getParameter(request,"roomno");
 String floor=China.getParameter(request,"floor");
   String disc=China.getParameter(request,"dis");
   String fx=China.getParameter(request,"fx");
   String fl=China.getParameter(request,"fl");
   String zx=China.getParameter(request,"zx");
   String rhn=China.getParameter(request,"rhn");
   String rh=China.getParameter(request,"rh");
 
   String VisaDate=China.getParameter(request,"QYDate");//签约日期
   String QYDate =VisaDate;
   if (!VisaDate.equals(""))state="2";
   else state="1";
   String qydate=China.getParameter(request,"qydate");//签约提醒日期
   String counttype=China.getParameter(request,"counttype");
   if (counttype.equals(""))counttype="0";
   String ajbk=China.getParameter(request,"ajbk");
   String ajyr=China.getParameter(request,"ajyr");
   String MonthMoney=China.getParameter(request,"MonthMoney");
   if (MonthMoney.equals(""))MonthMoney="0";
   String earnest=China.getParameter(request,"earnest");
   if (ajyr.equals(""))ajyr="0";
   String ajtype=China.getParameter(request,"ajtype");

 if (ajtype.equals(""))ajtype="0";
   float ajcs=0;
   if (!China.getParameter(request,"ajcs").equals("")){
      ajcs=java.lang.Float.parseFloat(China.getParameter(request,"ajcs"));	
  }
   String oldajcs=China.getParameter(request,"oldajcs");
   String yukuan=China.getParameter(request,"yukuan");
   String ajkmoney=China.getParameter(request,"ajmoney");
   if (ajkmoney.equals(""))ajkmoney="0";
   String pay=China.getParameter(request,"pay");
   String firstmoney=request.getParameter("firstmoney");//送首期款

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
   String curry=China.getParameter(request,"curry");
   String rate=China.getParameter(request,"rate");
   String area=China.getParameter(request,"area");
   if (area.equals(""))area="0";
   String jzarea=China.getParameter(request,"jzarea");
   if (jzarea.equals(""))jzarea="0";
   String  date1=China.getParameter(request,"Date1");//认购日期+"/"+request.getParameter("month")+"/"+request.getParameter("day");
   String  date=China.getParameter(request,"Date2");//交楼日期+"/"+request.getParameter("month1")+"/"+request.getParameter("day1");
   String ysumprice=China.getParameter(request,"sumprice");
   if (ysumprice.equals(""))  ysumprice="0.0";
    if (date1.equals(""))  date1=QYDate;
   String price=China.getParameter(request,"dicprice");
   String Aprice=China.getParameter(request,"Adicprice");
   String Y_yang_tai_area=China.getParameter(request,"Y_yang_tai_area");
   String yang_tai_area=China.getParameter(request,"yang_tai_area");
 if (yang_tai_area.equals("")) yang_tai_area="0.0";

   String lu_tai_area=China.getParameter(request,"lutai_area");
   String lu_tai_area_price=China.getParameter(request,"lutai_area_price");
   String ty_area=China.getParameter(request,"ty_area"); 
   String ty_area_price=China.getParameter(request,"ty_area_price"); 
   String wd_area=China.getParameter(request,"wd_area"); 
   String wd_area_price=China.getParameter(request,"wd_area_price"); 
      String wd_area_sumprice=China.getParameter(request,"wd_area_sumprice"); 
   String yong_tu=China.getParameter(request,"yong_tu");  
   String tai_area_sumprice=China.getParameter(request,"tai_area_sumprice");  
   String ty_area_sumprice=China.getParameter(request,"ty_area_sumprice");  
   String firstMoney=China.getParameter(request,"firstMoney");
   if (firstMoney.equals("")) firstMoney="0";
   if (price.equals("")) price="0.0";
   String TaxPrice=price;//用于计算税费
   String tnunitprice=China.getParameter(request,"cjtnprice");
   if (tnunitprice.equals("")) tnunitprice="0.0";
   String jzunitprice=China.getParameter(request,"cjjzprice");
   if (jzunitprice.equals(""))jzunitprice="0.0";
   String httype=China.getParameter(request,"httype");
   String ajtxdate=China.getParameter(request,"ajtxdate");
if (ajtxdate.equals(""))ajtxdate="0";
 //*****客户资料
   String cusno="";
   String editnow=China.getParameter(request,"editnow");
   String cusname=China.getParameter(request,"cusname");
   String Cus_Name=China.getParameter(request,"cusname1");
   String Phone=China.getParameter(request,"tel");
   String bbj=China.getParameter(request,"bbj");
   String sj=China.getParameter(request,"sj");
   String ID_Card=China.getParameter(request,"carid");
   String Address=China.getParameter(request,"Address");
   String Zip_Code=China.getParameter(request,"zip");
   String age=China.getParameter(request,"age");
   String  [] sells=request.getParameterValues("seller");
   String sell="";
   String sell2="";
   if (sells!=null){
   for (int a=0;a<sells.length;a++){
       if (sell.equals(""))  sell=getbyte1(sells[a]);
	   else sell+="/"+getbyte1(sells[a]);
   }
  }
 String note=China.getParameter(request,"note");
 String custype=China.getParameter(request,"custype");
   String fzsAdd="",fzs="";
  String findSQL="select frdz,developcom from CRM_Project where serialno='"+secno+"'";
 
%>


	<script>
	top2 = (screen.availHeight - 500) / 2 ;
	left2 = (screen.width - 620) / 2  ;
	height2 = 480 ;
	width2 = 620 ;
	<%
		String otherDiscount = China.getParameter(request, "abcd") ;
	%>
	function PrintOrder() {
		window.open("PrintOrderContract.jsp?RgsNo=<%= rgsno %>&CusName=<%=Cus_Name %>&Phone=<%= Phone %>&IdCard=<%= ID_Card %>&Address=<%= Address %>&ZipCode=<%= Zip_Code %>&Loft=<%= loft %>&Building=<%= build %>&Room=<%= roomno %>&JzArea=<%= jzarea %>&Area=<%= area %>&SumPrice=<%= ysumprice %>&OtherDiscount=<%= otherDiscount %>&OrderPrice=<%= price %>&CusNo=<%= cusno %>&AjMoney=<%= ajkmoney %>&OrderDate=<%= date1 %>&VisaDate=<%= VisaDate %>&constractno=<%=constractno %>&QYDate=<%=QYDate %>" + "&x=" + Math.random(), 'PopWindowAll', "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=no,top=" + top2 + ",left=" + left2 + ",width=" + width2 + ",height=" + height2) ;
	}
</script>
<%
   //String date1="getdate()";	
   String sql="";
   String sql1="";
   String rg=China.getParameter(request,"saveorder");
   String change=China.getParameter(request,"change");
   String context=China.getParameter(request,"context");
   String oldRoom=China.getParameter(request,"oldRoom");
   String Checker=China.getParameter(request,"checker");
   
   String Ai="select * from order_contract where state<>3 and loft='"+loft+"' and section='"+secno+"' and room_no='"+roomno+"' and floors="+floor;
 
   ResultSet exist=InsertBean.executeQuery(Ai);
   if (exist.next()){
   exist.close();
   %>
   <script>
   alert("此单位已被认购,不能保存");
   window.close();
   </script>
   <%out.close();
   }else{
   exist.close();
    exist=InsertBean.executeQuery(findSQL);
   
   if (exist.next()){fzsAdd=exist.getString("frdz");fzs=exist.getString("developcom");}
      exist.close();
  
   if (rg.equals("modi")){
         String   hisecno=request.getParameter("hisecno");
         String   hibuild=request.getParameter("hibuild");
         String   hiroom=request.getParameter("hiroom");
			//还原状态
			sql="update room set SaleState=1 where seccode='"+hisecno+"' and building='"+hibuild+"' and room_code='"+hiroom+"'" ;
			InsertBean.executeUpdate(sql);
			//删除原认购记录
			sql="delete Order_Contract where serialNo='"+rgsno+"'";
			InsertBean.executeUpdate(sql);
			//删除原应收款记录
			sql="delete GatheringRecord where cusno='"+cusno+"'";
			InsertBean.executeUpdate(sql);
			//删除应交税
			InsertBean.executeUpdate("delete GatheringTaxRecord where cusno='"+cusno+"'");
			
			rg="insert";
         }
      //判断当前的房间是否已认购
	   sql="select * from order_contract where section='"+secno+"'"
	   +" and loft='"+loft+"' and building='"+build+"' and "
	   +" room_no='"+roomno+"' and state<>3 and floors="+floor;
	    ResultSet stateRs=InsertBean.executeQuery(sql);
		if (stateRs.next()){
		out.print("<script>");
		out.print("alert('此房已售，请不要再次刷新页面!');");
		out.print("close();");
		out.print("</script>");
		return;
		}
	 if (!discSQL.equals("")){
	 //额外折扣
	 InsertBean.executeUpdate(discSQL); 
	 //发送额外折扣审批
	 discSQL="insert into check_Data(type,person,id,sendperson) select 1,checker,code,'"+(String)session.getAttribute("loginname")+"'  from contract_disc where order_no='"+secno+loft+roomno+"'";
	  InsertBean.executeUpdate(discSQL); 
	 } 
    sql="select max(code)+1 code from customer ";//计算客户最大ID
    ResultSet cusRs=InsertBean.executeQuery(sql);  
    String cus_code="";
 
    String cusno1="";
        if (cusRs.next()){
            cus_code=getbyte(cusRs.getString("code"));
		}
		cusRs.close();  
		if (cus_code.equals(""))cus_code="1";
		if (editnow.equals("2")){//如果是作为新客户，则增加客户资料
		  cusno1=secno+"-"+cus_code;
		  cusname=cusno1;
		  cusno=cusno1;
		  sql="insert into customer(Section,SerialNo,Cus_Name,signatory,Phone, ";
		  sql+="ID_Card, Address,sj,cus_age,Zip_Code)";
sql+="values('"+secno+"','"+cusno1+"','"+Cus_Name+"','"+Cus_Name+"','"+Phone+"','";
		  sql+=ID_Card+"','"+Address+"','"+sj+"','"+age+"','"+Zip_Code+"')";
		  InsertBean.executeUpdate(sql);
		}else	 if(editnow.equals("1")){//修改客户资料
		sql1="update customer set Cus_Name='"+Cus_Name+"',bbj='"+bbj+"',sj='"+sj+"',";
        sql1+="signatory='"+Cus_Name+"',Phone='"+Phone+"',ID_Card='"+ID_Card+"',";
        sql1+="Address='"+Address+"',Zip_Code='"+Zip_Code+"',cus_age='"+age+"' where SerialNo='"+cusname+"'";
        cusno=cusname;
        InsertBean.executeUpdate(sql1);
        }
 
      if (rg.equals("insert")){
	     
		  
		 //计算买卖公证费，按揭合同公证费，按揭保险费，抵押费
		  String ajgzcharges="0";
		  String htgzcharges="0";
		  String dycharges="0";
		  String bxcharges="0";
		 
		  if (eof.equals("false")){
		  	
 	        try
     		 {
			 String curryDX="";
			 String upperMoney="";
			 if (curry.equals("￥"))curryDX="人民币";
			 if (curry.equals("HKD"))curryDX="港币";
			 if (curry.equals("USD"))curryDX="美元";
			 ResultSet execRs=InsertBean1.executeQuery("exec dbo.L2U "+price+",0 ");//大写金额转换存储过程
             if (execRs.next())
				upperMoney=getbyte(execRs.getString("dd"));
				execRs.close();
 		     String youhui=China.getParameter(request,"youhui");
			 if (youhui.equals(""))youhui="0";
			 String youhuibeizhu=China.getParameter(request,"youhuibeizhu");
            
			
			 sql= countType+",'"+rgsno+"','"+constractno+"','"+secno+"','"+loft+"','";
			 sql+=build+"','"+roomno+"',"+floor+",'"+fl+"','"+fx+"',"+area+",'"+cusno+"','"+disc+"',";
			 sql+=MonthMoney+",'"+curry+"',"+rate+",'"+sell+"','"+payn+"','"+zx+"',"+ysumprice;
			 sql+=","+Aprice+","+earnest+",'"+date1+"','";
			 sql+=note+"','"+ajbk+"',"+ajyr+","+ajkmoney+","+ajcs+","+ajtype+","+jzarea+",";
			 sql+=rh+","+rhn+","+counttype+",'";
			 sql+=VisaDate+"','";
			 sql+=date+"','"+custype+"',";
			 sql+=price+",0,"+state+",";     //kkrate
			 sql+=StrFirstState;
			 sql+=",'"+StrEwDisc + "' , " + StrYhMoney ;
  		     sql+=",'"+youhui_date+"'";
		     sql+=",'"+youhuibeizhu+"','"+gxr+"','"+payname+"'";
		     sql+=",'"+curryDX+upperMoney+"','"+cnDate(Repalce2(date,"-"))+"','"+secnA+"',"+httype+",";
             sql+="'"+qydate+"'"; 
			 sql+=","+ajtxdate+"";
             sql+=","+firstmoney+","+yang_tai_area+","+lu_tai_area_price;
			 sql+=","+lu_tai_area+","+price+",'"+yong_tu+"',"+Aprice+","+Aprice+","+tnunitprice+","+jzunitprice+","+ty_area_price+","+ty_area+","+wd_area_price+","+wd_area+",'"+gddate+"','"+memberNO+"',"+memberT+",'"+fzs+"','"+fzsAdd+"',"+gjj+","+sydk+","+gjjy;
			  InsertBean.startTransaction();
 	 		 int a=InsertBean.executeUpdate("exec set_order_contract "+sql);
 		 
            //更新房间状态为已认购.
			String stateValue1="2";
			String stateValue2="3";
			if (!QYDate.equals("")){//客户直接签约
			  stateValue1="3";
			  stateValue2="4";
			}
             sql="update room set SaleState='"+stateValue1+"'";//,unitprice="+jzunitprice+",tnunitprice="+tnunitprice+",sumprice="+Aprice+",room_price="+price;
			 sql+=",lu_tai_area="+lu_tai_area+",lu_tai_area_price="+lu_tai_area_price;
			 sql+=" where seccode='"+secno+"' and Loft='"+loft+"' and building='"+build+"' and room_code='"+roomno+"' and floor="+floor ;
 
		     int c= InsertBean.executeUpdate(sql);
            //更新客户状态为已认购.
             sql="update customer set FTSALE='"+stateValue1+"' where SerialNo='"+cusno+"'" ;
             int d= InsertBean.executeUpdate(sql);
            //记录换房情况
			 if (!change.equals("")){
			 sql="insert into ChangRoomR(Section,Loft,Build,OldRoom,NowRoom,jzarea,sumprice,ChangeDate,Checker,Note)";
			 sql+="values('"+secnA+"','"+loft+"','"+build+"','"+oldRoom+"','"+roomno+"',"+hiarea+","+hisumprice;
			 sql+=",convert(char(24),getdate(),111),'"+Checker+"','"+context+"')";

			 InsertBean.executeUpdate(sql);	
			 //更改原房间为未售
			 sql="update room set SaleState='"+state+"' where seccode='"+secno+"' and Loft='"+loft+"' and building='"+build+"' and room_code='"+oldRoom+"' and floor="+floor ;
		     InsertBean.executeUpdate(sql);
			 //更改客户状态
			 sql="update customer set FTSALE='7' where serialno='"+cusno+"'" ;
		     InsertBean.executeUpdate(sql);
			 }
			//如果登记认购号，则把认购号标记为占用状态,以免重复引用
 sql="update ContractNo set state=2 where TYPE=0 AND ContractNo='"+rgsno+"' and section='"+secno+"'";
 if (!rgsno.equals("")) InsertBean.executeUpdate(sql);
 
		     sql="select max(code) maxid from Order_Contract";
			 ResultSet maxID=InsertBean.executeQuery(sql);
			 String MaxId="";
			 try{
			  if (maxID.next())
			   MaxId=maxID.getString("maxid");
			 }catch(Exception s){}
			 maxID.close();
			 //计算展销优惠金额
			
			 InsertBean.executeUpdate("update Order_Contract set yh_zs='"+youhui+"',zhangxiaoyouhui=(select youhui from PayMent where PayName='"+pay+"' and num="+paynum+"  and seccoe='"+secno+"')");	
			 
			 
			 /*****计算客户的应付款金额及日期****/	
			 //计算第一次交房款时间
	
	String firstSQL="select paydate from PayDetail where num=1 and  PayCode =(select ID from PayMent where     PayName='"+pay+"' and num="+paynum+"  and seccoe='"+secno+"')";
	 cusRs=InsertBean.executeQuery(firstSQL);  
	 String paydate="7";
	 if (cusRs.next())paydate=cusRs.getString("paydate");
	 cusRs.close();
			 
			 sql="'"+cusno+"',"+MaxId+",'"+date1+"',"+paynum+",'"+pay+"',"+price+",'";
			 sql+=curry+"',"+rate+",'"+secno+"',"+earnest+","+ajkmoney+","+paydate;
			 sql+=","+ty_area_sumprice+","+tai_area_sumprice+","+wd_area_sumprice;
			   
				 InsertBean.executeUpdate("exec countPayList "+sql);
			 
			  if (!fsfc.equals("")){
			     if (br.equals("0")){
				  //附属房产款
				  sql="insert into GatheringRecord select '"+cusno+"' as cusno,'"+MaxId+"',15 as shouldQS,dateadd(dd,"+paydate+",'"+date1+"') as shouldDate,"+fsfcmoney+" as shouldMoney,0 as yijiao,0 as state,0 as out,0 as demurrage,1 as send,'"+curry+"',"+rate+"  ";
  		          InsertBean.executeUpdate(sql);
				 
				 }
			    StringTokenizer st22 = new StringTokenizer(fsfc,",") ;
				
                int count2 = st22.countTokens() ;
				 while (st22.hasMoreElements()) {
				  fsfc= (String)st22.nextElement(); 
			     InsertBean.executeUpdate("insert into fsfc(roomcode,order_contract,br,money) values("+fsfc+","+MaxId+","+br+","+fsfcmoney+")");
			     InsertBean.executeUpdate("update room set salestate=2 where code="+fsfc);
			     fsfcmoney="0";
				 }
				
			 }
			 sql="Insert into contract_disc(state,order_no,discobj,discPrice,discUnit,disc_type,disc,disc_date,checker,disc_bak,gxr,person) values(";
             sql+="1,'"+secno+loft+roomno+"','总价',"+ysumprice+","+ysumprice+"/"+jzarea+",'正常折扣','"+disc+"','"+date1+"','公司','付款方式折扣','公司','"+(String )session.getAttribute( "loginname" )+"')";
	 
	        InsertBean.executeUpdate(sql);
	        InsertBean.executeUpdate("update contract_disc set ok=1 where order_no='"+secno+loft+roomno+"'");
			 
			 InsertBean.commit();
		     InsertBean.endTransaction();
		 
			 %>
			 <%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "销售资料登记" , 
                  "增加("+ secnA+loft+build+roomno+")"
                ) ;
				%>
				<%InsertBean.closeConn();
                  InsertBean1.closeConn();
 
                 %>
			 <script>
			   
			 
			opener.window.document.frm.submit();
			 window.location="../finance/TaxCount2.jsp?contractno=<%=MaxId %>&cusno=<%=cusno %>&pay=<%=pay %>&custype=<%=custype %>&ldroomcode=<%=China.getParameter(request,"code") %>";
			if (confirm("系统已保存数据，是否套打认购书？"))   window.open("printRG.jsp?code=<%=MaxId %>");         
			
			 
			 </script>
	
			
			 <%
		     out.close();
 		    }
	    catch(SQLException ex)
		    {
			out.print(ex.getMessage());
			InsertBean.rollback();
			 out.println(sql);
			out.print("执行数据库操作出错,请仔细检查输入的数据<br>");
			out.print("<a href='javascript:window.history.back(1)'>返回</a>");
			out.close();
			}		
	   }  
	
   if (eof.equals("false")){
      out.print(Message);
	  out.print("<input type=button name=back value='返回' onclick='javascript:window.history.back(1)'>");
	  out.print("&nbsp;&nbsp;<input type=button name=show value='查询详情' title='查看此认购书详细资料' onclick='show();'>");
	
	}
  }
}
  %>

<script>
 function show(){
   openwin("showrg.jsp?rgsno='<%=rgsno%>'",450,500,200,50);  
 }

</script>
<% }catch(Exception s){out.print("系统出现异常错误，错误原因："+s);}
 %>

</body>
</html>
