<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/line.css" >
	<title>已收款统计</title>
</head>

<body>
<%      String dates=China.getParameter(request,"Date1");
		String dates1=China.getParameter(request,"Date2");
		String SecNo1=request.getParameter("SecNo");
		String name=SecNo1.substring(SecNo1.indexOf("-")+1);
		SecNo1=SecNo1.substring(0,SecNo1.indexOf("-"));
		String Loft=request.getParameter("Loft"); %>
<div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >
<p align="center"><font size=4><%=name %>实收款情况表</font></p><br>
收款时段:<%=dates %>---<%=dates1 %>
 <table width="135%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<%       List list1=new LinkedList();//存放栏名
	    List list2=new LinkedList();//存放实际的栏名
		List list3=new LinkedList();//实际栏名对应的数据
		 //and  convert(char(10),o.date,120)>='"+dates+"' and  convert(char(10),o.date,120)<='"+dates1+"'	
		   int countnum=0;
		  int taxnum=0;
		 try {
		  String SQL="SELECT ";
          SQL+="   sum(case when o.fkdate is null then 0 else o.ajmoney end) ajfk,o.sectionname+o.loft  room from order_contract o,customer c";
          SQL+=" where o.state<>3 and c.serialno=o.customer ";//and o.code in(";
		  
		  //SQL+="select ContractNo from factGatheringRecord f";
		 // SQL+=" where convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"' group by ContractNo)";
		  SQL+=" and o.section='"+SecNo1+"'";
		  if (!Loft.equals(""))
		  SQL+=" and o.Loft='"+Loft+"' " ;
		  SQL+=" group by o.sectionname+o.loft  order by o.sectionname+o.loft asc";//
		  ResultSet rs=ViewBean.executeQuery(SQL);
	 
          String cusname="",cusid="",room="",ContractNo="";
		  String phone="",jzarea="",tnarea="",m_jzarea="",m_tnarea="";
		  String counttype="",jzunitprice="",tnunitprice="";
		  String factmoney=""; 
		  double zhongji=0;   
		  String aaaa="";
		    int sumajfk=0;
		  String sumprice="",mapp_sumprice="",code="",y_jzarea="",y_usedarea="";
		  while (rs.next()){
		        
		       String sql="";
			   ResultSet rs1=null;
			    double xiaoji=0;
		       if (room.equals("")){
			   room=rs.getString("room");
		         out.print("<tr align='center'><td>商品房名称</td><td>房款</><td>改建款</td><td>阳台<br>罩款</td><td>配套款</td>") ;
			     sql="select taxname from GatheringTaxRecord where TaxName_type=1 and taxmoney>0 and contactno in (select code from order_contract where state<>3 and  section='"+SecNo1+"') group by taxname order by taxname";

				 rs1=ViewBean1.executeQuery(sql);
			     while (rs1.next()){
				 taxnum++;
				  String title=getbyte(rs1.getString("taxname"));
				 list1.add(title);
			      out.print("<td>"+title+"</td>");
			     }
				  out.print("<td>小计</td>");
			   out.print("</tr>");
			   rs1.close();
			   }
			  
		       room=getbyte(rs.getString("room"));
			      sql="select sum(f.FactMonye) fact from FactAjCharges f";
				sql+=" where   f.contractno in (select code from order_contract where convert(char(10),fkDate,120)>='"+dates+"' and  convert(char(10),fkDate,120)<='"+dates1+"' and state<>3 and sectionname+loft='"+room+"') ";
				sql+=" and ( convert(char(10),f.FactDate,120)>='"+dates+"' and  convert(char(10),f.FactDate,120)<='"+dates1+"')";
				
				
				 rs1=ViewBean1.executeQuery(sql);//读取按按揭款
				 
				int ajk=0;
				 while (rs1.next())
			   ajk+=rs1.getInt("fact");
			   rs1.close();
			 
				 sumajfk+=ajk;
			   if (aaaa.equals(""))aaaa="'"+room+"'";
			   else aaaa+=",'"+room+"'";
			    out.print("<tr  align='center' ><td>"+room+"</td>");
				sql="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
				sql+=" where f.Period in(0,1,2,3,4,8) and f.ContractNo in (select code from order_contract where state<>3 and sectionname+loft='"+room+"')";
				sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				 
				 rs1=ViewBean1.executeQuery(sql);//读取房款
			 
			     while (rs1.next()){
				 double fk=rs1.getDouble("fact");
				 xiaoji+=fk+ajk;
			      out.print("<td>"+getbyte(FormatD.getFloat2(fk+ajk,2))+"</td>");
			     }
				 rs1.close();
				  
				 sql="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
				sql+=" where f.Period in (5,6,9,10) and f.ContractNo in (select code from order_contract where state<>3 and sectionname+loft='"+room+"')";
				sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				
				 rs1=ViewBean1.executeQuery(sql);//读取改装款
			     while (rs1.next()){
				  double fk=rs1.getDouble("fact");
				 xiaoji+=fk;
			      out.print("<td>"+getbyte(FormatD.getFloat3(fk,2))+"</td>");
			     }
				 rs1.close();
			    sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=0 and taxname  like '%罩%'";
		        sql+=" and  contractno  in (select code from order_contract where state<>3 and sectionname+loft='"+room+"')";
				sql+=" and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";
				 
				 rs1=ViewBean1.executeQuery(sql);//读取阳台罩款
			     while (rs1.next()){
				   double fk=rs1.getDouble("money");
				   xiaoji+=fk;
			      out.print("<td>"+getbyte(FormatD.getFloat3(fk,2))+"</td>");
			     }
				 rs1.close();
				 sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=0 and not taxname  like '%罩%'";
		         sql+=" and  contractno in (select code from order_contract where state<>3 and sectionname+loft='"+room+"')";
				 sql+=" and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";
			 
				 rs1=ViewBean1.executeQuery(sql);//读取配套款
			     while (rs1.next()){
				   double fk=rs1.getDouble("money");
				   xiaoji+=fk;
			       String aa=getbyte(FormatD.getFloat3(fk,2));
				   if (!aa.equals(""))
			       out.print("<td>"+aa+"</td>");
			     }
				 rs1.close();
				 sql="select SUM(money) money,taxname  from FactGatheringTaxRecord where TaxName_type=1  ";
		         sql+=" and  contractno in (select code from order_contract where state<>3 and sectionname+loft='"+room+"')";
				 sql+=" and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"' group by taxname order by taxname";
				 int nnn=0;
		 
				 rs1=ViewBean1.executeQuery(sql);//读取税费
			     while (rs1.next()){
				 nnn++;
				  double fk=rs1.getDouble("money");
				   xiaoji+=fk;
				  String aa=getbyte(FormatD.getFloat2(fk,2));
				    list2.add(aa);
				    list3.add(rs1.getString("taxname"));
				 
			     }
				 rs1.close();
				 
				 for (int i=0;i<taxnum;i++){
				 
			       String strtax=(String)list1.get(i);
				   if (list3.contains(strtax))
				    {    int index=list3.indexOf(strtax);
				     out.print("<td>"+(String)list2.get(index)+"</td>");
				   }else 
				     out.print("<td></td>");  	 
				
				}
				  list2.clear();
				 list3.clear();

				 
				 zhongji+=xiaoji;
				  out.print("<td>"+FormatD.getFloat2(xiaoji,2)+"</td>");
				  out.print("</tr>");
				 
			  }
		  rs.close();
		  
		  
		        out.print("<tr align='center'><td>合计</td>");
				
				
				String  sql="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
				sql+=" where f.Period in(0,1,2,3,4,8) and f.ContractNo in (";
				   sql+="SELECT ";
          sql+=" code  from order_contract ";
          sql+=" where state<>3 and sectionname+loft in ("+aaaa+")";
		   
		  
		   
				sql+=") and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				 ResultSet rs1=ViewBean1.executeQuery(sql);//读取房款
			   
			     while (rs1.next()){
			      out.print("<td>"+getbyte(FormatD.getFloat2(rs1.getDouble("fact")+sumajfk,2))+"</td>");
			     }
				 rs1.close();
				  
				 sql="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
				sql+=" where f.Period in (5,6,9,10) and f.ContractNo in (";
				 sql+="SELECT ";
          sql+=" code  from order_contract ";
          sql+=" where  state<>3 and sectionname+loft in ("+aaaa+")";
		   
		   
				sql+=") and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				
				 rs1=ViewBean1.executeQuery(sql);//读取改装款
			     while (rs1.next()){
			      out.print("<td>"+getbyte(FormatD.getFloat2(rs1.getDouble("fact"),2))+"</td>");
			     }
				 rs1.close();
			    sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=0 and taxname  like '%罩%'";
		        sql+=" and  contractno in (";
				 sql+="SELECT ";
         
          sql+=" code  from order_contract ";
          sql+=" where state<>3 and  sectionname+loft in ("+aaaa+")";
		   
		    
				sql+=") and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"' ";
		
		
				 
				 rs1=ViewBean1.executeQuery(sql);//读取阳台罩款
			     while (rs1.next()){
			      out.print("<td>"+getbyte(FormatD.getFloat(rs1.getFloat("money"),2))+"</td>");
			     }
				 rs1.close();
				 sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=0 and not taxname  like '%罩%'";
		         sql+=" and  contractno in (";
				 sql+="SELECT ";
          sql+=" code  from order_contract ";
          sql+=" where state<>3 and sectionname+loft in ("+aaaa+")"; ;
		  
		   
		     
				sql+=") and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";
 
				 rs1=ViewBean1.executeQuery(sql);//读取配套款
			     while (rs1.next()){
			       String aa=getbyte(FormatD.getFloat2(rs1.getDouble("money"),2));
				 
                   if (!aa.equals(""))
			       out.print("<td>"+aa+"</td>");
			     }
				 rs1.close();
				 sql="select SUM(money) money,taxname  from FactGatheringTaxRecord where TaxName_type=1 ";
		         sql+=" and  contractno in (";
				 
			 sql+="SELECT ";
          sql+=" code  from order_contract ";
          sql+=" where state<>3 and sectionname+loft in ("+aaaa+")";
		  
				 sql+=") and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"' group by taxname order by taxname";
		        list2.clear();
				list3.clear();
		 
				 rs1=ViewBean1.executeQuery(sql);//读取税费
			     while (rs1.next()){
				  String aa=getbyte(FormatD.getFloat2(rs1.getDouble("money"),2));
				    list2.add(aa);
				    list3.add(rs1.getString("taxname"));
			     }
				 rs1.close();
				  for (int i=0;i<taxnum;i++){
				 
			       String strtax=(String)list1.get(i);
				   if (list3.contains(strtax))
				    {    int index=list3.indexOf(strtax);
				     out.print("<td>"+(String)list2.get(index)+"</td>");
				   }else 
				     out.print("<td></td>");  	 
				
				}
				  out.print("<td>"+FormatD.getFloat2(zhongji,2)+"</td>");
				 
				  out.print("</tr>");
				  
	 
				  
				   out.print("<tr align='center'><td>合计</td>");
				
				  sql="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
				sql+=" where f.Period in(0,1,2,3,4,5,6,8,9,10) and f.Period<>5 and f.ContractNo in (";
				  sql+="SELECT ";
          sql+=" code  from order_contract ";
          sql+=" where  state<>3 and sectionname+loft in ("+aaaa+")";
		  
		   
				sql+=") and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				  rs1=ViewBean1.executeQuery(sql);//读取房款
			     double fkaa=0;
			     while (rs1.next()){
			     fkaa+=rs1.getDouble("fact");
			     }
				 rs1.close();
				  
				 
				   out.print("<td colspan='2'>"+FormatD.getFloat2(fkaa+sumajfk,2)+"</td>");
			   fkaa=0;
			   sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=0 ";
		         sql+=" and  contractno in (";
				  sql+="SELECT ";
          sql+=" code  from order_contract ";
          sql+=" where state<>3 and sectionname+loft in ("+aaaa+")";
		   
		     
				sql+=") and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";

				 
				 rs1=ViewBean1.executeQuery(sql);//读取阳台罩款
			    fkaa=0;
				 while (rs1.next()){
			       fkaa+=rs1.getDouble("money");
			     }
				 rs1.close();
				
				 out.print("<td colspan='2'>"+FormatD.getFloat2(fkaa,2)+"</td>");
				 sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=1 ";
		         sql+=" and  contractno in (";
				 sql+="SELECT ";
          sql+=" code  from order_contract ";
          sql+=" where state<>3 and sectionname+loft in ("+aaaa+")";
		   
		     
				sql+=") and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";
				 rs1=ViewBean1.executeQuery(sql);//读取税费
			    fkaa=0;
 
				 while (rs1.next()){
				 
				 fkaa+=rs1.getDouble("money");
				 
			     }
				 rs1.close();
				  out.print("<td colspan='"+taxnum+"'>"+FormatD.getFloat2(fkaa,2)+"</td>");
				 
				  out.print("<td>"+FormatD.getFloat2(zhongji,2)+"</td>");
				 
				  out.print("</tr>");
				  
 }catch(Exception s){out.print(s);}
 %>
   <tr><td colspan="<%=taxnum+7 %>"  align=center>已退房的收款记录</td></tr>
 <%       
		 //and  convert(char(10),o.date,120)>='"+dates+"' and  convert(char(10),o.date,120)<='"+dates1+"'	
		  countnum=0;
		 list2.clear();
		 list3.clear();
		 
		  try{
		  String SQL="SELECT ";
          SQL+="   sum(case when o.fkdate is null then 0 else o.ajmoney end) ajfk,o.sectionname+o.loft  room from order_contract o,customer c";
          SQL+=" where o.state=3 and c.serialno=o.customer ";//and o.code in(";
		  
		  //SQL+="select ContractNo from factGatheringRecord f";
		 // SQL+=" where convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"' group by ContractNo)";
		  SQL+=" and o.section='"+SecNo1+"'";
		  if (!Loft.equals(""))
		  SQL+=" and o.Loft='"+Loft+"' " ;
		  SQL+=" group by o.sectionname+o.loft  order by o.sectionname+o.loft asc";//
		  ResultSet rs=ViewBean.executeQuery(SQL);
	 
          String cusname="",cusid="",room="",ContractNo="";
		  String phone="",jzarea="",tnarea="",m_jzarea="",m_tnarea="";
		  String counttype="",jzunitprice="",tnunitprice="";
		  String factmoney=""; 
		  double zhongji=0;   
		  String aaaa="";
		  int sumajfk=0;
		  String sumprice="",mapp_sumprice="",code="",y_jzarea="",y_usedarea="";
		  while (rs.next()){
		        
		       String sql="";
			   ResultSet rs1=null;
			    double xiaoji=0;
		       
			  
		       room=getbyte(rs.getString("room"));
			      sql="select sum(f.FactMonye) fact from FactAjCharges f";
				sql+=" where   f.contractno in (select code from order_contract where convert(char(10),fkDate,120)>='"+dates+"' and  convert(char(10),fkDate,120)<='"+dates1+"' and state=3 and sectionname+loft='"+room+"') ";
				sql+=" and ( convert(char(10),f.FactDate,120)>='"+dates+"' and  convert(char(10),f.FactDate,120)<='"+dates1+"')";
				
				
				 rs1=ViewBean1.executeQuery(sql);//读取按按揭款
				 
				int ajk=0;
				 while (rs1.next())
			   ajk+=rs1.getInt("fact");
			   rs1.close();
			 
				 sumajfk+=ajk;
			   if (aaaa.equals(""))aaaa="'"+room+"'";
			   else aaaa+=",'"+room+"'";
			    out.print("<tr  align='center' ><td>"+room+"</td>");
				sql="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
				sql+=" where f.Period in(0,1,2,3,4,8) and f.ContractNo in (select code from order_contract where state=3 and sectionname+loft='"+room+"')";
				sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				 
				 rs1=ViewBean1.executeQuery(sql);//读取房款
			 
			     while (rs1.next()){
				 double fk=rs1.getDouble("fact");
				 xiaoji+=fk+ajk;
			      out.print("<td>"+getbyte(FormatD.getFloat2(fk+ajk,2))+"</td>");
			     }
				 rs1.close();
				  
				 sql="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
				sql+=" where f.Period in (5,6,9,10) and f.ContractNo in (select code from order_contract where state=3 and sectionname+loft='"+room+"')";
				sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				
				 rs1=ViewBean1.executeQuery(sql);//读取改装款
			     while (rs1.next()){
				  double fk=rs1.getDouble("fact");
				 xiaoji+=fk;
			      out.print("<td>"+getbyte(FormatD.getFloat3(fk,2))+"</td>");
			     }
				 rs1.close();
			    sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=0 and taxname  like '%罩%'";
		        sql+=" and  contractno  in (select code from order_contract where state=3 and sectionname+loft='"+room+"')";
				sql+=" and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";
				 
				 rs1=ViewBean1.executeQuery(sql);//读取阳台罩款
			     while (rs1.next()){
				   double fk=rs1.getDouble("money");
				   xiaoji+=fk;
			      out.print("<td>"+getbyte(FormatD.getFloat3(fk,2))+"</td>");
			     }
				 rs1.close();
				 sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=0 and not taxname  like '%罩%'";
		         sql+=" and  contractno in (select code from order_contract where state=3 and sectionname+loft='"+room+"')";
				 sql+=" and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";
			 
				 rs1=ViewBean1.executeQuery(sql);//读取配套款
			     while (rs1.next()){
				   double fk=rs1.getDouble("money");
				   xiaoji+=fk;
			       String aa=getbyte(FormatD.getFloat3(fk,2));
				   if (!aa.equals(""))
			       out.print("<td>"+aa+"</td>");
			     }
				 rs1.close();
				 sql="select SUM(money) money,taxname  from FactGatheringTaxRecord where TaxName_type=1  ";
		         sql+=" and  contractno in (select code from order_contract where state=3 and sectionname+loft='"+room+"')";
				 sql+=" and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"' group by taxname order by taxname";
				 int nnn=0;
		 
				 rs1=ViewBean1.executeQuery(sql);//读取税费
			     while (rs1.next()){
				 nnn++;
				  double fk=rs1.getDouble("money");
				   xiaoji+=fk;
				  String aa=getbyte(FormatD.getFloat2(fk,2));
				    list2.add(aa);
				    list3.add(rs1.getString("taxname"));
				 
			     }
				 rs1.close();
				 
				 for (int i=0;i<taxnum;i++){
				 
			       String strtax=(String)list1.get(i);
				   if (list3.contains(strtax))
				    {    int index=list3.indexOf(strtax);
				     out.print("<td>"+(String)list2.get(index)+"</td>");
				   }else 
				     out.print("<td></td>");  	 
				
				}
				  list2.clear();
				 list3.clear();

				 
				 zhongji+=xiaoji;
				  out.print("<td>"+FormatD.getFloat2(xiaoji,2)+"</td>");
				  out.print("</tr>");
				 
			  }
		  rs.close();
		  
		  
		        out.print("<tr align='center'><td>合计</td>");
				
				
				String  sql="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
				sql+=" where f.Period in(0,1,2,3,4,8) and f.ContractNo in (";
				   sql+="SELECT ";
          sql+=" code  from order_contract ";
          sql+=" where state=3 and sectionname+loft in ("+aaaa+")";
		   
		  
		   
				sql+=") and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				 ResultSet rs1=ViewBean1.executeQuery(sql);//读取房款
			   
			     while (rs1.next()){
			      out.print("<td>"+getbyte(FormatD.getFloat2(rs1.getDouble("fact")+sumajfk,2))+"</td>");
			     }
				 rs1.close();
				  
				 sql="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
				sql+=" where f.Period in (5,6,9,10) and f.ContractNo in (";
				 sql+="SELECT ";
          sql+=" code  from order_contract ";
          sql+=" where  state=3 and sectionname+loft in ("+aaaa+")";
		   
		   
				sql+=") and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				
				 rs1=ViewBean1.executeQuery(sql);//读取改装款
			     while (rs1.next()){
			      out.print("<td>"+getbyte(FormatD.getFloat2(rs1.getDouble("fact"),2))+"</td>");
			     }
				 rs1.close();
			    sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=0 and taxname  like '%罩%'";
		        sql+=" and  contractno in (";
				 sql+="SELECT ";
         
          sql+=" code  from order_contract ";
          sql+=" where state=3 and  sectionname+loft in ("+aaaa+")";
		   
		    
				sql+=") and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"' ";
		
		
				 
				 rs1=ViewBean1.executeQuery(sql);//读取阳台罩款
			     while (rs1.next()){
			      out.print("<td>"+getbyte(FormatD.getFloat(rs1.getFloat("money"),2))+"</td>");
			     }
				 rs1.close();
				 sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=0 and not taxname  like '%罩%'";
		         sql+=" and  contractno in (";
				 sql+="SELECT ";
          sql+=" code  from order_contract ";
          sql+=" where state=3 and sectionname+loft in ("+aaaa+")"; ;
		  
		   
		     
				sql+=") and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";
 
				 rs1=ViewBean1.executeQuery(sql);//读取配套款
			     while (rs1.next()){
			       String aa=getbyte(FormatD.getFloat2(rs1.getDouble("money"),2));
				 
                   if (!aa.equals(""))
			       out.print("<td>"+aa+"</td>");
			     }
				 rs1.close();
				 sql="select SUM(money) money,taxname  from FactGatheringTaxRecord where TaxName_type=1 ";
		         sql+=" and  contractno in (";
				 
			 sql+="SELECT ";
          sql+=" code  from order_contract ";
          sql+=" where state=3 and sectionname+loft in ("+aaaa+")";
		  
				 sql+=") and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"' group by taxname order by taxname";
		        list2.clear();
				list3.clear();
		 
				 rs1=ViewBean1.executeQuery(sql);//读取税费
			     while (rs1.next()){
				  String aa=getbyte(FormatD.getFloat2(rs1.getDouble("money"),2));
				    list2.add(aa);
				    list3.add(rs1.getString("taxname"));
			     }
				 rs1.close();
				  for (int i=0;i<taxnum;i++){
				 
			       String strtax=(String)list1.get(i);
				   if (list3.contains(strtax))
				    {    int index=list3.indexOf(strtax);
				     out.print("<td>"+(String)list2.get(index)+"</td>");
				   }else 
				     out.print("<td></td>");  	 
				
				}
				  out.print("<td>"+FormatD.getFloat2(zhongji,2)+"</td>");
				 
				  out.print("</tr>");
				  
	 
				  
				   out.print("<tr align='center'><td>合计</td>");
				
				  sql="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
				sql+=" where f.Period in(0,1,2,3,4,5,6,8,9,10) and f.Period<>5 and f.ContractNo in (";
				  sql+="SELECT ";
          sql+=" code  from order_contract ";
          sql+=" where  state=3 and sectionname+loft in ("+aaaa+")";
		  
		   
				sql+=") and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				  rs1=ViewBean1.executeQuery(sql);//读取房款
			     double fkaa=0;
			     while (rs1.next()){
			     fkaa+=rs1.getDouble("fact");
			     }
				 rs1.close();
				  
				 
				   out.print("<td colspan='2'>"+FormatD.getFloat2(fkaa+sumajfk,2)+"</td>");
			   fkaa=0;
			   sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=0 ";
		         sql+=" and  contractno in (";
				  sql+="SELECT ";
          sql+=" code  from order_contract ";
          sql+=" where state=3 and sectionname+loft in ("+aaaa+")";
		   
		     
				sql+=") and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";

				 
				 rs1=ViewBean1.executeQuery(sql);//读取阳台罩款
			    fkaa=0;
				 while (rs1.next()){
			       fkaa+=rs1.getDouble("money");
			     }
				 rs1.close();
				
				 out.print("<td colspan='2'>"+FormatD.getFloat2(fkaa,2)+"</td>");
				 sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=1 ";
		         sql+=" and  contractno in (";
				 sql+="SELECT ";
          sql+=" code  from order_contract ";
          sql+=" where state=3 and sectionname+loft in ("+aaaa+")";
		   
		     
				sql+=") and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";
				 rs1=ViewBean1.executeQuery(sql);//读取税费
			    fkaa=0;
 
				 while (rs1.next()){
				 
				 fkaa+=rs1.getDouble("money");
				 
			     }
				 rs1.close();
				  out.print("<td colspan='"+taxnum+"'>"+FormatD.getFloat2(fkaa,2)+"</td>");
				 
				  out.print("<td>"+FormatD.getFloat2(zhongji,2)+"</td>");
				 
				  out.print("</tr>");
		}catch(Exception s){out.print(s);}		  
 
 %>
  
</TABLE></div>

<script>
  function bringToExcel(){

   // get all the text
   var pasteText = document.all.report1.innerHTML;

   // copy all the text to clipboard
   window.clipboardData.setData ("Text", pasteText);

     // Start Excel and get Application object.     
     var oXL = new ActiveXObject("Excel.Application");     
     oXL.Visible = true;   
     // Get a new workbook.     
     var oWB = oXL.Workbooks.Add();     
     var oSheet = oWB.ActiveSheet;     
     oSheet.Paste();     
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
  bringToExcel();
  window.close();
</script>
</body>
</html>
