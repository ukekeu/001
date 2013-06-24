<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>计算费用...请不要关掉窗口</title>
</head>

<body>
<%@ page language="java" import="java.sql.*,java.util.*"%>
 <jsp:useBean id="ViewBean3" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%!float TaxSum=0;
   int AjPrice=0;
   String code="";
   double SalePrice=0;
   float SaleArea=0;
   float unitprice=0;
   String section="";
   String qtaxrate="0";
   String qtax="0";
   String aaaa="";
     String  money = "";
    String TaxName="";
      String yhtax="0"; 
	  String sqlstr1="";
 %>
<%!
	 public String  ShowTax(String sqlstr,String para) throws Exception  {
	  String SqlStr = sqlstr;
	  String  str="";
	  String state="";
   
	  int jjj=0;
	 ConnDatabase.SDatabase ViewBean1=new ConnDatabase.SDatabase();
	 ConnDatabase.SDatabase ViewBean2=new ConnDatabase.SDatabase();
	 ResultSet TaxRs1=null; 
	 ResultSet TaxRs = ViewBean1.executeQuery(SqlStr);
	 FormatData.FormatData formatD1=new FormatData.FormatData();
		
		  int id=0;
		 
		while (TaxRs.next()) {
		    id = TaxRs.getInt("ID");
	     	money=formatD1.getFloat3(TaxRs.getDouble("money"),2);
	        String  termvalue=TaxRs.getString("termvalue");
		    String term=TaxRs.getString("term");
		    String  termvalue1=TaxRs.getString("termvalue1");
		    String term1=TaxRs.getString("term1");
		    TaxName = getbyte(TaxRs.getString("Tax_Name"));
			String tax_type= getbyte(TaxRs.getString("tax_type"));
		    state=TaxRs.getString("state").trim();
			String type1=TaxRs.getString("type1");
			String type3=getbyte(TaxRs.getString("type3"));	
			String type=getbyte(TaxRs.getString("type"));	
			String type2=getbyte(TaxRs.getString("type2"));	
			if (para.trim().equals("0")&&type3.equals("1"))break;		 
			  if (TaxName.indexOf("契税")>=0){
			 qtaxrate=money;
			}
			
	        jjj++;
            str+="<tr  align='center' class=listcontent>";
            if (state.equals("1")){//按售价百分比计算
                String sql1="select  money*"+SalePrice+"/1000.0 aa1 from TaxChages where state=1 and  "+SalePrice+"/10000 "+term+ " termvalue  and "+SalePrice+"/10000"+term1+ "termvalue1  and id= "+id;
				money="";
				TaxRs1 = ViewBean2.executeQuery(sql1);
                double aa2=0;
			    if (TaxRs1.next()){
				   aa2=TaxRs1.getDouble("aa1");
				   money=formatD1.getFloat3(aa2,2);
				 }
				TaxRs1.close();
                if (!money.equals("")){
                   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
                   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
                   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
                    String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
					ViewBean2.executeUpdate(Tsql);
					if (TaxName.indexOf("契税")>=0){
						qtax=money;
					 }else  if (TaxName.indexOf("印花税")>=0){
					    yhtax=money;
					 }
                }
          }else   if (state.equals("2")){//按固定金额计算
                if (!money.equals("")){
				  str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
				   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
				   String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
				  ViewBean2.executeUpdate(Tsql);
				   }
   
         }else   if (state.equals("3")){//按购房面积计算
                  String sql1="select  money*"+SalePrice+"/1000.0 aa1 from TaxChages where state=3 and  "+SaleArea+""+term+ " termvalue  and "+SaleArea+""+term1+ "termvalue1 and id= "+id;
                  TaxRs1 = ViewBean2.executeQuery(sql1);
 				  double aa2=0;
				  money="";
				  if (TaxRs1.next()){
				     aa2=TaxRs1.getDouble("aa1");
				     money=formatD1.getFloat3(aa2,2);
				  }
				 TaxRs1.close();
                 if (!money.equals("")){
				   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
				   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
				   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
				   String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
				   ViewBean2.executeUpdate(Tsql);
				   if (TaxName.indexOf("契税")>=0){
					qtax=money;
				   }else  if (TaxName.indexOf("印花税")>=0){
				    yhtax=money;
				   }
				}
       }else   if (state.equals("6"))//按户数计算
            {
			    str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
			    str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
			    String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
			   ViewBean2.executeUpdate(Tsql);
			}
           else   if (state.equals("7"))//按按揭款计算
            {
              String sql1="select  money*"+AjPrice+"0000/1000.0 aa1 from TaxChages where state=5 and  "+AjPrice+" "+term+ " termvalue  and "+AjPrice+""+term1+ "termvalue1 and id= "+id;
             TaxRs1 = ViewBean2.executeQuery(sql1);
             money="";
             double aa2=0;
			 if (TaxRs1.next()){
			   aa2=TaxRs1.getDouble("aa1");
			   money=formatD1.getFloat3(aa2,2);
			  }
			 TaxRs1.close();
			 if (!money.equals("")){
			   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
			   state=TaxName;
			   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
			   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
			   String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
			   ViewBean2.executeUpdate(Tsql);
			  }
      }else   if (state.equals("4"))//按面积计算
          {
            String sql1="select  money  aa1 from TaxChages where state=4 and  "+SaleArea+" "+term+ " termvalue  and "+SaleArea+""+term1+ "termvalue1 and id= "+id;
            sqlstr1=sql1;
		    TaxRs1 = ViewBean2.executeQuery(sql1);
		    money="";
			double aa2=0;
		   if (TaxRs1.next()){
		     aa2=TaxRs1.getDouble("aa1");
		     money=formatD1.getFloat3(aa2,2);
		   }
		  TaxRs1.close();
		  if (!money.equals("")){
		   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
		   state=TaxName;
		   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
		   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
		   String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
		   ViewBean2.executeUpdate(Tsql);
		   if (TaxName.indexOf("契税")>=0){
			qtax=money;
		   }else  if (TaxName.indexOf("印花税")>=0){
		    yhtax=money;
		   }
		}
    }else   if (state.equals("5"))//按面积计算
       {
         String sql1="select  money*"+SaleArea+"  aa1 from TaxChages where state=5 and  "+SaleArea+" "+term+ " termvalue  and "+SaleArea+""+term1+ "termvalue1 and id= "+id;
    	 TaxRs1 = ViewBean2.executeQuery(sql1);
		 money="";
	 	 double aa2=0;
		 if (TaxRs1.next()){
		   aa2=TaxRs1.getDouble("aa1");
		   money=formatD1.getFloat3(aa2,2);
		  }
		 TaxRs1.close();
		 if (!money.equals("")){
		   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
		  state=TaxName;
		  str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
		  str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
		  String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
		ViewBean2.executeUpdate(Tsql);
		 if (TaxName.indexOf("契税")>=0){
			qtax=money;
		 }else  if (TaxName.indexOf("印花税")>=0){
		    yhtax=money;
		 }
		  }
   }else   if (state.equals("8"))//按单价计算
    {
       String sql1="select  money*1.0/1000*"+SalePrice+" aa1 from TaxChages where state=8 and  "+unitprice+" "+term+ " termvalue  and "+unitprice+""+term1+ "termvalue1 and id= "+id;
      sqlstr1=sql1;
	  TaxRs1 = ViewBean2.executeQuery(sql1);
	  money="";
      double aa2=0;
	  if (TaxRs1.next()){
	   aa2=TaxRs1.getDouble("aa1");
	   money=formatD1.getFloat3(aa2,2);
	  }
	 TaxRs1.close();
	 if (!money.equals("")){
	   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
	   state=TaxName;
	   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
	   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
	   String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
	   ViewBean2.executeUpdate(Tsql);
	   if (TaxName.indexOf("契税")>=0){
		qtax=money;
	   }else  if (TaxName.indexOf("印花税")>=0){
	    yhtax=money;
	   }
	  }
     }
  str+="</tr>";
  
 }
 TaxRs.close();
 
return "ok!";
}
 %>
 
 
<%!
	 public String  ShowTaxjw(String sqlstr,String para) throws Exception  {
	  String SqlStr = sqlstr;
	  String  str="";
	  String state="";
   
	  int jjj=0;
	 ConnDatabase.SDatabase ViewBean1=new ConnDatabase.SDatabase();
	 ConnDatabase.SDatabase ViewBean2=new ConnDatabase.SDatabase();
	 ResultSet TaxRs1=null; 
	 ResultSet TaxRs = ViewBean1.executeQuery(SqlStr);
	 FormatData.FormatData formatD1=new FormatData.FormatData();
		
		  int id=0;
		while (TaxRs.next()) {
		    id = TaxRs.getInt("ID");
	     	money=formatD1.getFloat3(TaxRs.getDouble("money"),2);
	        String  termvalue=TaxRs.getString("termvalue");
		    String term=TaxRs.getString("term");
		    String  termvalue1=TaxRs.getString("termvalue1");
		    String term1=TaxRs.getString("term1");
		    TaxName = getbyte(TaxRs.getString("Tax_Name"));
			String tax_type= getbyte(TaxRs.getString("tax_type"));
		    state=TaxRs.getString("state").trim();
			String type1=TaxRs.getString("type1");
			String type3=getbyte(TaxRs.getString("type3"));	
			String type=getbyte(TaxRs.getString("type"));	
			String type2=getbyte(TaxRs.getString("type2"));	
			if (para.trim().equals("0")&&type3.equals("1"))break;		 
			  if (TaxName.indexOf("契税")>=0){
			 qtaxrate=money;
			}
	        jjj++;
            str+="<tr  align='center' class=listcontent>";
            if (state.equals("1")){//按售价百分比计算
                String sql1="select  money*"+SalePrice+"/1000.0 aa1 from TaxChages where state=1 and  "+SalePrice+"/10000 "+term+ " termvalue  and "+SalePrice+"/10000"+term1+ "termvalue1  and id= "+id;
				money="";
				TaxRs1 = ViewBean2.executeQuery(sql1);
                double aa2=0;
			    if (TaxRs1.next()){
				   aa2=TaxRs1.getDouble("aa1");
				   money=formatD1.getFloat3(aa2,2);
				 }
				TaxRs1.close();
                if (!money.equals("")){
                   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
                   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
                   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
                    String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
					ViewBean2.executeUpdate(Tsql);
					if (TaxName.indexOf("契税")>=0){
						qtax=money;
					 }else  if (TaxName.indexOf("印花税")>=0){
					    yhtax=money;
					 }
                }
          }else   if (state.equals("2")){//按固定金额计算
                if (!money.equals("")){
				  str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
				   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
				   String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
				  ViewBean2.executeUpdate(Tsql);
				   }
   
         }else   if (state.equals("3")){//按购房面积计算
                  String sql1="select  money*"+SalePrice+"/1000.0 aa1 from TaxChages where state=3 and  "+SaleArea+""+term+ " termvalue  and "+SaleArea+""+term1+ "termvalue1 and id= "+id;
                  TaxRs1 = ViewBean2.executeQuery(sql1);
 				  double aa2=0;
				  money="";
				  if (TaxRs1.next()){
				     aa2=TaxRs1.getDouble("aa1");
				     money=formatD1.getFloat3(aa2,3);
				  }
				 TaxRs1.close();
                 if (!money.equals("")){
				   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
				   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
				   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
				   String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
				   ViewBean2.executeUpdate(Tsql);
				   if (TaxName.indexOf("契税")>=0){
					qtax=money;
				   }else  if (TaxName.indexOf("印花税")>=0){
				    yhtax=money;
				   }
				}
       }else   if (state.equals("6"))//按户数计算
            {
			    str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
			    str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
			    String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
			   ViewBean2.executeUpdate(Tsql);
			}
           else   if (state.equals("7"))//按按揭款计算
            {
              String sql1="select  money*"+AjPrice+"0000/1000.0 aa1 from TaxChages where state=5 and  "+AjPrice+" "+term+ " termvalue  and "+AjPrice+""+term1+ "termvalue1 and id= "+id;
             TaxRs1 = ViewBean2.executeQuery(sql1);
             money="";
             double aa2=0;
			 if (TaxRs1.next()){
			   aa2=TaxRs1.getDouble("aa1");
			   money=formatD1.getFloat3(aa2,2);
			  }
			 TaxRs1.close();
			 if (!money.equals("")){
			   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
			   state=TaxName;
			   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
			   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
			   String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
			   ViewBean2.executeUpdate(Tsql);
			  }
      }else   if (state.equals("4"))//按面积计算
          {
            String sql1="select  money  aa1 from TaxChages where state=4 and  "+SaleArea+" "+term+ " termvalue  and "+SaleArea+""+term1+ "termvalue1 and id= "+id;
            sqlstr1=sql1;
		    TaxRs1 = ViewBean2.executeQuery(sql1);
		    money="";
			double aa2=0;
		   if (TaxRs1.next()){
		     aa2=TaxRs1.getDouble("aa1");
		     money=formatD1.getFloat3(aa2,2);
		   }
		  TaxRs1.close();
		  if (!money.equals("")){
		   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
		   state=TaxName;
		   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
		   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
		   String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
		   ViewBean2.executeUpdate(Tsql);
		   if (TaxName.indexOf("契税")>=0){
			qtax=money;
		   }else  if (TaxName.indexOf("印花税")>=0){
		    yhtax=money;
		   }
		}
    }else   if (state.equals("5"))//按面积计算
       {
         String sql1="select  money*"+SaleArea+"  aa1 from TaxChages where state=5 and  "+SaleArea+" "+term+ " termvalue  and "+SaleArea+""+term1+ "termvalue1 and id= "+id;
    	 TaxRs1 = ViewBean2.executeQuery(sql1);
		 money="";
	 	 double aa2=0;
		 if (TaxRs1.next()){
		   aa2=TaxRs1.getDouble("aa1");
		   money=formatD1.getFloat3(aa2,2);
		  }
		 TaxRs1.close();
		 if (!money.equals("")){
		   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
		  state=TaxName;
		  str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
		  str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
		  String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
		ViewBean2.executeUpdate(Tsql);
		 if (TaxName.indexOf("契税")>=0){
			qtax=money;
		 }else  if (TaxName.indexOf("印花税")>=0){
		    yhtax=money;
		 }
		  }
   }else   if (state.equals("8"))//按单价计算
    {
       String sql1="select  money*1.0/1000*"+SalePrice+" aa1 from TaxChages where state=8 and  "+unitprice+" "+term+ " termvalue  and "+unitprice+""+term1+ "termvalue1 and id= "+id;
      sqlstr1=sql1;
	  TaxRs1 = ViewBean2.executeQuery(sql1);
	  money="";
      double aa2=0;
	  if (TaxRs1.next()){
	   aa2=TaxRs1.getDouble("aa1");
	   money=formatD1.getFloat3(aa2,2);
	  }
	 TaxRs1.close();
	 if (!money.equals("")){
	   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
	   state=TaxName;
	   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
	   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
	   String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
	   ViewBean2.executeUpdate(Tsql);
	   if (TaxName.indexOf("契税")>=0){
		qtax=money;
	   }else  if (TaxName.indexOf("印花税")>=0){
	    yhtax=money;
	   }
	  }
     }
  str+="</tr>";
  
 }
 TaxRs.close();

return SqlStr;
}
 %>
 <%   
 String moditax=request.getParameter("moditax");
 if (!moditax.equals("")){
 String maap_state="0"; 
 String custype="",buildtype="";
 String loft="",roomno="";
 String  SQL="select section+loft+room_no roomno,code,room_sumprice,ajmoney,room_sumprice/JZAREA unitprice,section,custype,httype,rh,jzarea,yong_tu,lu_tai_area,buildtype from  order_contract where state<>3  and code='"+request.getParameter("contractno")+"'";
  ResultSet countRs=ViewBean.executeQuery(SQL);
// out.print(SQL);
 while (countRs.next()){
   loft=countRs.getString("roomno");
    code=countRs.getString("code");
	ViewBean3.executeUpdate("delete GatheringTaxRecord where ContactNo="+code);
	SalePrice=countRs.getDouble("room_sumprice");
	AjPrice=countRs.getInt("ajmoney")/10000;
	unitprice=countRs.getFloat("unitprice");
    String section=countRs.getString("section");
    custype=countRs.getString("custype");
	String httype=countRs.getString("httype");
	boolean rh=countRs.getBoolean("rh");
	SaleArea=countRs.getFloat("jzarea");
	String yongtu=getbyte(countRs.getString("yong_tu"));
	float lu_tai_area =countRs.getFloat("lu_tai_area");
	buildtype=countRs.getString("buildtype");
	if (custype.equals("个人"))custype="0";
	else custype="1";
	String types="";
	
    ResultSet sss=ViewBean3.executeQuery("select maap_state from room where seccode+loft+room_code='"+roomno+"'");
	if (sss.next())maap_state=sss.getString("maap_state");
	sss.close();
	  
	if (httype.equals("1")){
	  out.print(ShowTaxjw("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t1.type=3 and t.code  in (select Code from tax where  type2=0 and type=3 and    section='"+section+"')",httype));
	 // out.close();
	  }
	if (AjPrice>0){//只读取按揭客户应交的费
	//   if (custype.equals("0")){
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype));
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype));
		  
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype));
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype));
		  
		   out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype));
		  
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype)); 
	     
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype)); 
	    
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype)); 
	     
		   out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype)); 
	     
		   out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype)); 
	       out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype)); 
	   
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype)); 
	    
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype)); 
	    
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype)); 		 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype)); 
		 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype)); 
	     
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype)); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype)); 
		 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype));
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype));
		  
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype)); 
	    
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype)); 
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype)); 
	 
	  // } else{
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype)); 
	    
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype)); 
	    
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype)); 
	    
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype)); 
	    
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype)); 
	     
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype)); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype)); 

	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype)); 
	     
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype)); 
	
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype)); 
         
		   out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype)); 
	 // }
	}
	
	
	
	if (rh){//只读取需要入户客户应交的费
	 //  if (custype.equals("0")){
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='"+yongtu+"' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='"+yongtu+"' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='"+yongtu+"' and section='"+section+"')",httype)); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='"+yongtu+"' and section='"+section+"')",httype));
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='"+yongtu+"' and section='"+section+"')",httype));
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='"+yongtu+"' and section='"+section+"')",httype));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='"+yongtu+"' and section='"+section+"')",httype));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='"+yongtu+"' and section='"+section+"')",httype));
        //  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='"+yongtu+"' and section='"+section+"')",httype)); 
	     
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='所有' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='所有' and section='"+section+"')",httype)); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='所有' and section='"+section+"')",httype));
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='所有' and section='"+section+"')",httype));
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='所有' and section='"+section+"')",httype));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='所有' and section='"+section+"')",httype));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='所有' and section='"+section+"')",httype));
 
		
		//}else{
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='"+yongtu+"' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='"+yongtu+"' and section='"+section+"')",httype)); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='"+yongtu+"' and  section='"+section+"')",httype)); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='"+yongtu+"' and section='"+section+"')",httype));
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='"+yongtu+"' and section='"+section+"')",httype));
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='"+yongtu+"' and section='"+section+"')",httype));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='"+yongtu+"' and section='"+section+"')",httype));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='"+yongtu+"' and section='"+section+"')",httype));
         
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='所有' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='所有' and section='"+section+"')",httype)); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='所有' and  section='"+section+"')",httype)); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='所有' and section='"+section+"')",httype));
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='所有' and section='"+section+"')",httype));
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='所有' and section='"+section+"')",httype));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='所有' and section='"+section+"')",httype));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,type3 from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=2 and  type1='所有' and section='"+section+"')",httype));

	
	//}
	}
	

	 //if (custype.equals("0")){
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype)); 
		// out.print("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')");
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype)); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype));
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype));
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype));
        
		   out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='"+buildtype+"' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='"+buildtype+"' and section='"+section+"')",httype)); 
		// out.print("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')");
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='"+buildtype+"' and section='"+section+"')",httype)); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='"+buildtype+"' and section='"+section+"')",httype));
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='"+buildtype+"' and section='"+section+"')",httype));
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='"+buildtype+"' and section='"+section+"')",httype));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='"+buildtype+"' and section='"+section+"')",httype));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='"+buildtype+"' and section='"+section+"')",httype));
 
 
		 	
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",httype)); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",httype)); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",httype));
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",httype));
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",httype));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",httype));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",httype));
        
		
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='所有' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='所有' and section='"+section+"')",httype)); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='所有' and section='"+section+"')",httype)); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='所有' and section='"+section+"')",httype));
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='所有' and section='"+section+"')",httype));
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='所有' and section='"+section+"')",httype));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='所有' and section='"+section+"')",httype));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='所有' and section='"+section+"')",httype));
	// out.print("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')");
	
		//}else{
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype)); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype)); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype));
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype));
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype));

		   out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='"+buildtype+"' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='"+buildtype+"' and section='"+section+"')",httype)); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='"+buildtype+"' and section='"+section+"')",httype)); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='"+buildtype+"' and section='"+section+"')",httype));
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='"+buildtype+"' and section='"+section+"')",httype));
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='"+buildtype+"' and section='"+section+"')",httype));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='"+buildtype+"' and section='"+section+"')",httype));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='"+buildtype+"' and section='"+section+"')",httype));
		 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有'  and section='"+section+"')",httype)); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有'  and section='"+section+"')",httype)); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有'  and section='"+section+"')",httype));
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有'  and section='"+section+"')",httype));
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有'  and section='"+section+"')",httype));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有'  and section='"+section+"')",httype));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有'  and section='"+section+"')",httype));
		 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='所有' and section='"+section+"')",httype)); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='所有'  and section='"+section+"')",httype)); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='所有'  and section='"+section+"')",httype)); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='所有'  and section='"+section+"')",httype));
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='所有'  and section='"+section+"')",httype));
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='所有'  and section='"+section+"')",httype));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='所有'  and section='"+section+"')",httype));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type3='所有'  and section='"+section+"')",httype));
   	//}
	if (lu_tai_area>0&&maap_state.equals("0")){
	SaleArea=lu_tai_area;
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=0 and t.code  in (select Code from tax where type2=1 and type=0 and  type1='所有' and section='"+section+"')",httype));
   
   
	}
	
	////读取所有客户应交的费
 }

countRs.close();
 String upperMoney="";

 ResultSet rs=null;
//String qsSQL="delete GatheringTaxRecord where TaxName in (select TaxName from GatheringTaxRecord where ContactNo="+code+" group by TaxName having count(TaxName)>1) and ContactNo="+code;//+" and taxtype<>"+custype;
String qsSQL="select TaxName from GatheringTaxRecord where ContactNo="+code+" group by TaxName having count(TaxName)>1 ";//+" and taxtype<>"+custype;
    rs=ViewBean.executeQuery(qsSQL);
	while (rs.next()){
	    qsSQL="select top 1  id from GatheringTaxRecord where ContactNo="+code+"  and TaxName='"+rs.getString("TaxName")+"' ";//+" and taxtype<>"+custype;
        countRs=ViewBean3.executeQuery(qsSQL);
		String ddid="";
		if (countRs.next()){
		  ddid=countRs.getString("id");
		}
		countRs.close();
		qsSQL="delete  GatheringTaxRecord where id <>"+ddid+" and  ContactNo="+code+"  and TaxName='"+rs.getString("TaxName")+"' ";//+" and taxtype<>"+custype;
      
		 ViewBean3.executeUpdate(qsSQL);
	 
	}
	
 
 rs.close();
 rs=ViewBean.executeQuery("select TaxMoney, TaxMoney/"+FormatD.getFloat3(SalePrice,2)+" qtaxrate from GatheringTaxRecord  where ContactNo="+code +" and TaxName like'%契税%'");
 if (rs.next()){
   qtax=rs.getString("TaxMoney");
   qtaxrate=FormatD.getFloat3(rs.getDouble("qtaxrate"),3);
    
   qtax=FormatD.getFloat3(Double.parseDouble(qtaxrate)*Double.parseDouble(FormatD.getFloat3(SalePrice,2)),2);

 }
 rs.close();
 
 if (!qtax.equals("")&&!qtax.equals("0")){
 ResultSet execRs=ViewBean3.executeQuery("exec dbo.L2U "+qtax+",0 ");//大写金额转换存储过程
 
   if (execRs.next())
	upperMoney=getbyte(execRs.getString("dd"));
  execRs.close();

ViewBean3.executeUpdate("update order_contract set q_tax="+FormatD.getFloat3(Double.parseDouble(qtaxrate)*SalePrice,2)+", q_tax_rate="+qtaxrate+",q_tax_up='"+upperMoney+"',yh_tax="+yhtax+" where code="+code);
}

 
 String sql="select sum(money) TaxMoney,TaxName from factGatheringTaxRecord where contractno ='"+code+"' group by TaxName";//order by room_no desc";
    rs=ViewBean.executeQuery(sql);
   
   while (rs.next()){
     String modiTaxstate="update  GatheringTaxRecord  set state=case when TaxMoney>"+rs.getString("TaxMoney")+" then 0 else 1 end,factMoney="+rs.getString("TaxMoney")+" where taxname='"+rs.getString("TaxName")+"' and ContactNo="+code;
	 ViewBean3.executeUpdate(modiTaxstate);
 }
 rs.close();
   sql="select yxz_area_price*yxz_area yxzp,dt_area_price*dt_area+yang_tai_zhao_sarea*yang_tai_zhao_price ytzp from room where maap_state=1 and seccode+loft+room_code='"+loft+"'";//order by room_no desc";
    rs=ViewBean.executeQuery(sql);
    double yxzprice=0,ytzprice=0;
	if (rs.next()){
	   yxzprice=rs.getDouble("yxzp");
	   ytzprice=rs.getDouble("ytzp");
	}
	rs.close();

   if (yxzprice>0) 
    {
	  String modiTaxstate="update  GatheringTaxRecord  set  TaxMoney="+yxzprice+"  where  taxname like '%安全网%' and  ContactNo="+code;
	 ViewBean3.executeUpdate(modiTaxstate);
	
	}
	 if (ytzprice>0) 
    {
	  String modiTaxstate="update  GatheringTaxRecord  set  TaxMoney="+ytzprice+"  where  taxname like '%罩%' and  ContactNo="+code;
	 ViewBean3.executeUpdate(modiTaxstate);
	
	}
	if (maap_state.equals("1")){
	//如果实测后，删除露台罩费.
	 ViewBean3.executeUpdate("delete GatheringTaxRecord where TaxName like '%露台罩%' where  ContactNo="+code);
	}
	
	 	
	}
	
 %>
<script>
 window.location="../finance/yingshi_s.jsp?contractno=<%=request.getParameter("contractno") %>&cusno=<%=request.getParameter("cusno") %>&pay=<%=request.getParameter("pay ")%>&custype=<%=request.getParameter("custype ") %>&ldroomcode=<%=request.getParameter("ldroomcode ")%>";

</script>
</body>
</html>
