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
	<title>���տ�ͳ��</title>
</head>

<body>
<%      String dates=China.getParameter(request,"Date1");
		String dates1=China.getParameter(request,"Date2");
		String SecNo1=request.getParameter("SecNo");
		String name=SecNo1.substring(SecNo1.indexOf("-")+1);
		SecNo1=SecNo1.substring(0,SecNo1.indexOf("-"));
		String Loft=request.getParameter("Loft");
		String roomno=request.getParameter("room");
		 %>
		 <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >
 <p align="center"><font size=4><%=name %>ʵ�տ���ϸ��</font></p><br>
�տ�ʱ��:<%=dates %>---<%=dates1 %>
<table width="135%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<%       List list1=new LinkedList();//�������
	    List list2=new LinkedList();//���ʵ�ʵ�����
		List list3=new LinkedList();//ʵ��������Ӧ������
		 //and  convert(char(10),o.date,120)>='"+dates+"' and  convert(char(10),o.date,120)<='"+dates1+"'	
		  int taxnum=0;
		try{   int countnum=0;
		
		  String SQL="SELECT ";
          SQL+=" case when fkdate is null then 0 else o.ajmoney end ajfk,o.code,o.section,o.sectionname+o.loft+o.building+o.room_no room,c.cus_name,o.jzarea from order_contract o,customer c";
          SQL+=" where o.state<>3 and c.serialno=o.customer ";/*and  o.code in(";
		  
		  SQL+="select ContractNo from factGatheringRecord f";
		 SQL+=" where convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"' group by ContractNo)";
		 SQL+=" or o.code in (";
		  SQL+="select contractno from FactGatheringTaxRecord f";
		 SQL+=" where convert(char(10),f.Date,120)>='"+dates+"' and  convert(char(10),f.Date,120)<='"+dates1+"' group by contractno)";
		
		 */
		  SQL+=" and o.section='"+SecNo1+"'";
		  if (!Loft.equals(""))
		  SQL+=" and o.Loft='"+Loft+"' " ;
		 //   if (!roomno.equals(""))
		//  SQL+=" and o.room_no='"+roomno+"' " ;
		  SQL+="  order by o.sectionname,o.loft,o.building,o.floors,o.room,o.room_no asc";//group by o.sectionname+o.loft
		  ResultSet rs=ViewBean.executeQuery(SQL);
	      String cusname="",cusid="",room="",ContractNo="";
		  String phone="",jzarea="",tnarea="",m_jzarea="",m_tnarea="";
		  String counttype="",jzunitprice="",tnunitprice="";
		  String factmoney=""; 
		  double zhongji=0;   
		  int sumajfk=0;
		
		  
		  String sumprice="",mapp_sumprice="",code="",y_jzarea="",y_usedarea="";
		  while (rs.next()){
		        code=rs.getString("code");
		       String sql="";
			   ResultSet rs1=null;
			    double xiaoji=0;
		       if (room.equals("")){
			   room=rs.getString("room");
		         out.print("<tr align='center'><td>��Ʒ������</td><td>�������</td><td>�ͻ�</td><td>����</><td>�Ľ���</td><td>��̨<br>�ֿ�</td><td>���׿�</td>") ;
			     sql="select taxname from GatheringTaxRecord where TaxName_type=1 and taxmoney>0 and contactno in (select code from order_contract where section='"+SecNo1+"') group by taxname order by taxname";

				 rs1=ViewBean1.executeQuery(sql);
			     while (rs1.next()){
				 taxnum++;
				  String title=getbyte(rs1.getString("taxname"));
				 list1.add(title);
			      out.print("<td>"+title+"&nbsp;</td>");
			     }
				  out.print("<td>С��&nbsp;</td>");
			   out.print("</tr>");
			   rs1.close();
			   }
			
		       room=getbyte(rs.getString("room"));
			   
			   
			    sql="select sum(f.FactMonye) fact from FactAjCharges f";
				sql+=" where   f.contractno ="+code;
				sql+=" and  convert(char(10),f.FactDate,120)>='"+dates+"' and  convert(char(10),f.FactDate,120)<='"+dates1+"'";
				
				
				 rs1=ViewBean1.executeQuery(sql);//��ȡ�����ҿ�
				
				int ajk=0;
				 while (rs1.next())
			   ajk+=rs1.getInt("fact");
			   
			   rs1.close();
			   sumajfk+=ajk;
			    out.print("<tr  align='center' ><td>"+room+"</td>");
				 out.print("<td>"+getbyte(rs.getString("jzarea"))+"</td>");
				 out.print("<td>"+getbyte(rs.getString("cus_name"))+"</td>");
				sql="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
				sql+=" where f.Period in(0,1,2,3,4,8) and f.ContractNo ="+code;
				sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				 
				 rs1=ViewBean1.executeQuery(sql);//��ȡ����
//			   if (room.equals("������԰���� 1��701")){out.print(sql);out.close();}
			     while (rs1.next()){
				 double fk=rs1.getDouble("fact");
				 xiaoji+=fk+ajk;
			      out.print("<td>&nbsp;"+getbyte(FormatD.getFloat2(fk+ajk,2))+"</td>");
			     }
				 rs1.close();
				  
				 sql="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
				sql+=" where f.Period in (5,6,9,10) and f.ContractNo ="+code;
				sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				
				 rs1=ViewBean1.executeQuery(sql);//��ȡ��װ��
			     while (rs1.next()){
				  float fk=rs1.getFloat("fact");
				 xiaoji+=fk;
			      out.print("<td>"+getbyte(FormatD.getFloat(fk,2))+"&nbsp;</td>");
			     }
				 rs1.close();
			    sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=0 and taxname  like '%��%'";
		        sql+=" and  contractno  ="+code;
				sql+=" and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";
				
				 rs1=ViewBean1.executeQuery(sql);//��ȡ��̨�ֿ�
			     while (rs1.next()){
				   float fk=rs1.getFloat("money");
				   xiaoji+=fk;
			      out.print("<td>"+getbyte(FormatD.getFloat(fk,2))+"&nbsp;</td>");
			     }
				 rs1.close();
				 sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=0 and not taxname  like '%��%'";
		         sql+=" and  contractno ="+code;
				 sql+=" and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";
				
				 rs1=ViewBean1.executeQuery(sql);//��ȡ���׿�
			     while (rs1.next()){
				   float fk=rs1.getFloat("money");
				   xiaoji+=fk;
			       String aa=getbyte(FormatD.getFloat(fk,2));
				   if (!aa.equals(""))
			       out.print("<td>"+aa+"&nbsp;</td>");
			     }
				 rs1.close();
				 sql="select SUM(money) money,taxname  from FactGatheringTaxRecord where TaxName_type=1 ";
		         sql+=" and  contractno = "+code;
				 sql+=" and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"' group by taxname order by taxname";
				 int nnn=0;
		 
				 rs1=ViewBean1.executeQuery(sql);//��ȡ˰��
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
				     out.print("<td>"+(String)list2.get(index)+"&nbsp;</td>");
				   }else 
				     out.print("<td>&nbsp;</td>");  	 
				
				}
				  list2.clear();
				 list3.clear();

				 
				 zhongji+=xiaoji;
				  out.print("<td>"+FormatD.getFloat2(xiaoji,2)+"&nbsp;</td>");
				  out.print("</tr>");
				 
			  }
		  rs.close();
		  
		  
		        out.print("<tr align='center'><td colspan=2>�ϼ�</td>");
				
				
				String  sql="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
				sql+=" where f.Period in(0,1,2,3,4,8) and f.ContractNo in (";
				   sql+="SELECT ";
          sql+="o.code  from order_contract o ";
          sql+=" where o.state<>3 ";
		  sql+=" and o.section='"+SecNo1+"'";
		  if (!Loft.equals(""))
		  sql+=" and o.Loft='"+Loft+"' " ;
		  
		   
				sql+=") and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				 ResultSet rs1=ViewBean1.executeQuery(sql);//��ȡ����
			   
			     while (rs1.next()){
			      out.print("<td>"+getbyte(FormatD.getFloat2(rs1.getDouble("fact")+sumajfk,2))+"</td>");
			     }
				 rs1.close();
				  
				 sql="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
				sql+=" where f.Period in (5,6,9,10) and f.ContractNo in (";
				 sql+="SELECT ";
          sql+="o.code  from order_contract o ";
          sql+=" where o.state<>3 ";
		  sql+=" and o.section='"+SecNo1+"'";
		  if (!Loft.equals(""))
		  sql+=" and o.Loft='"+Loft+"' " ;
		  
		   
		   
				sql+=") and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				
				 rs1=ViewBean1.executeQuery(sql);//��ȡ��װ��
			     while (rs1.next()){
			      out.print("<td>"+getbyte(FormatD.getFloat(rs1.getFloat("fact"),2))+"&nbsp;</td>");
			     }
				 rs1.close();
			    sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=0 and taxname  like '%��%'";
		        sql+=" and  contractno in (";
				 sql+="SELECT ";
          sql+="o.code  from order_contract o ";
          sql+=" where  o.state<>3 ";
		  sql+=" and o.section='"+SecNo1+"'";
		  if (!Loft.equals(""))
		  sql+=" and o.Loft='"+Loft+"' " ;
		  
		   
		    
				sql+=") and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"' ";
		
		
				 
				 rs1=ViewBean1.executeQuery(sql);//��ȡ��̨�ֿ�
			     while (rs1.next()){
			      out.print("<td>"+getbyte(FormatD.getFloat(rs1.getFloat("money"),2))+"&nbsp;</td>");
			     }
				 rs1.close();
				 sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=0 and not taxname  like '%��%'";
		         sql+=" and  contractno in (";
				  sql+="SELECT ";
          sql+="o.code  from order_contract o,customer c";
          sql+=" where  o.state<>3 ";
		  sql+=" and o.section='"+SecNo1+"'";
		  if (!Loft.equals(""))
		  sql+=" and o.Loft='"+Loft+"' " ;
		  
		   
		     
				sql+=") and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";

				 rs1=ViewBean1.executeQuery(sql);//��ȡ���׿�
			     while (rs1.next()){
			       String aa=getbyte(FormatD.getFloat(rs1.getFloat("money"),2));
				 
                   if (!aa.equals(""))
			       out.print("<td>"+aa+"&nbsp;</td>");
			     }
				 rs1.close();
				 sql="select SUM(money) money,taxname  from FactGatheringTaxRecord where TaxName_type=1 ";
		         sql+=" and  contractno in (";
				 
				   sql+="SELECT ";
          sql+="o.code  from order_contract o ";
          sql+=" where  o.state<>3 ";
		   sql+=" and o.section='"+SecNo1+"'";
		  if (!Loft.equals(""))
		  sql+=" and o.Loft='"+Loft+"' " ;
		  
				 sql+=") and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"' group by taxname order by taxname";
		        list2.clear();
				list3.clear();
		 
				 rs1=ViewBean1.executeQuery(sql);//��ȡ˰��
			     while (rs1.next()){
				  String aa=getbyte(FormatD.getFloat(rs1.getFloat("money"),2));
				    list2.add(aa);
				    list3.add(rs1.getString("taxname"));
			     }
				 rs1.close();
				  for (int i=0;i<taxnum;i++){
				 
			       String strtax=(String)list1.get(i);
				   if (list3.contains(strtax))
				    {    int index=list3.indexOf(strtax);
				     out.print("<td>"+(String)list2.get(index)+"&nbsp;</td>");
				   }else 
				     out.print("<td>&nbsp;</td>");  	 
				
				}
				  out.print("<td>"+FormatD.getFloat2(zhongji,2)+"&nbsp;</td>");
				 
				  out.print("</tr>");
				  
	
				  
				   out.print("<tr align='center'><td colspan=2>�ϼ�</td>");
				
				  sql="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
				sql+=" where f.Period in(0,1,2,3,4,5,6,8,9,10) and f.ContractNo in (";
				   sql+="SELECT ";
          sql+="o.code  from order_contract o ";
          sql+=" where  o.state<>3 ";
		   sql+=" and o.section='"+SecNo1+"'";
		  if (!Loft.equals(""))
		  sql+=" and o.Loft='"+Loft+"' " ;
		  
		   
				sql+=") and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				  rs1=ViewBean1.executeQuery(sql);//��ȡ����
			     double fkaa=0;
			     while (rs1.next()){
			     fkaa+=rs1.getDouble("fact");
			     }
				 rs1.close();
				  
				 
				   out.print("<td colspan='2'>"+FormatD.getFloat2(fkaa+sumajfk,2)+"&nbsp;</td>");
			   fkaa=0;
			   sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=0 ";
		         sql+=" and  contractno in (";
				  sql+="SELECT ";
          sql+="o.code  from order_contract o,customer c";
          sql+=" where  o.state<>3 ";
		  sql+=" and o.section='"+SecNo1+"'";
		  if (!Loft.equals(""))
		  sql+=" and o.Loft='"+Loft+"' " ;
		  
		   
		     
				sql+=") and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";

				 
				 rs1=ViewBean1.executeQuery(sql);//��ȡ��̨�ֿ�
			     while (rs1.next()){
			       fkaa+=rs1.getFloat("money");
			     }
				 rs1.close();
				
				    out.print("<td colspan='2'>"+FormatD.getFloat2(fkaa,2)+"&nbsp;</td>");
				sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=1 ";
		         sql+=" and  contractno in (";
				 
				 
				   sql+="SELECT ";
          sql+="o.code  from order_contract o ";
          sql+=" where  o.state<>3 ";
		   sql+=" and o.section='"+SecNo1+"'";
		  if (!Loft.equals(""))
		  sql+=" and o.Loft='"+Loft+"' " ;
		  
		   
		     
				sql+=") and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";

				 
				 rs1=ViewBean1.executeQuery(sql);//��ȡ˰��
			    fkaa=0;

				 while (rs1.next()){
				 
				 fkaa+=rs1.getFloat("money");
				 
			     }
				 rs1.close();
				  out.print("<td colspan='"+taxnum+"'>"+FormatD.getFloat2(fkaa,2)+"&nbsp;</td>");
				 
				  out.print("<td>"+FormatD.getFloat2(zhongji,2)+"&nbsp;</td>");
				 
				  out.print("</tr>");
				  
		}catch(Exception s){out.print(s);}
 %>
  <tr><td colspan="<%=taxnum+7 %>"  align=center>���˷����տ��¼</td></tr>
  <%     
		 //and  convert(char(10),o.date,120)>='"+dates+"' and  convert(char(10),o.date,120)<='"+dates1+"'	
		 
		try{   int countnum=0;
		 
		  String SQL="SELECT ";
          SQL+=" case when fkdate is null then 0 else o.ajmoney end ajfk,o.code,o.section,o.sectionname+o.loft+o.building+o.room_no room,c.cus_name from order_contract o,customer c";
          SQL+=" where o.state=3 and c.serialno=o.customer ";/*and  o.code in(";
		  
		  SQL+="select ContractNo from factGatheringRecord f";
		 SQL+=" where convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"' group by ContractNo)";
		 SQL+=" or o.code in (";
		  SQL+="select contractno from FactGatheringTaxRecord f";
		 SQL+=" where convert(char(10),f.Date,120)>='"+dates+"' and  convert(char(10),f.Date,120)<='"+dates1+"' group by contractno)";
		
		 */
		  SQL+=" and o.section='"+SecNo1+"'";
		  if (!Loft.equals(""))
		  SQL+=" and o.Loft='"+Loft+"' " ;
		 //   if (!roomno.equals(""))
		//  SQL+=" and o.room_no='"+roomno+"' " ;
		  SQL+="  order by o.sectionname,o.loft,o.building,o.floors,o.room,o.room_no asc";//group by o.sectionname+o.loft
		  ResultSet rs=ViewBean.executeQuery(SQL);
	      String cusname="",cusid="",room="",ContractNo="";
		  String phone="",jzarea="",tnarea="",m_jzarea="",m_tnarea="";
		  String counttype="",jzunitprice="",tnunitprice="";
		  String factmoney=""; 
		  double zhongji=0;   
		  int sumajfk=0;
		
		  
		  String sumprice="",mapp_sumprice="",code="",y_jzarea="",y_usedarea="";
		  while (rs.next()){
		        code=rs.getString("code");
		       String sql="";
			   ResultSet rs1=null;
			    double xiaoji=0;
		        room=getbyte(rs.getString("room"));
			   
			   
			    sql="select sum(f.FactMonye) fact from FactAjCharges f";
				sql+=" where   f.contractno ="+code;
				sql+=" and  convert(char(10),f.FactDate,120)>='"+dates+"' and  convert(char(10),f.FactDate,120)<='"+dates1+"'";
				
				
				 rs1=ViewBean1.executeQuery(sql);//��ȡ�����ҿ�
				
				int ajk=0;
				 while (rs1.next())
			   ajk+=rs1.getInt("fact");
			   
			   rs1.close();
			   sumajfk+=ajk;
			    out.print("<tr  align='center' ><td>"+room+"</td>");
				 out.print("<td>"+getbyte(rs.getString("cus_name"))+"</td>");
				sql="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
				sql+=" where f.Period in(0,1,2,3,4,8) and f.ContractNo ="+code;
				sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				 
				 rs1=ViewBean1.executeQuery(sql);//��ȡ����
//			   if (room.equals("������԰���� 1��701")){out.print(sql);out.close();}
			     while (rs1.next()){
				 double fk=rs1.getDouble("fact");
				 xiaoji+=fk+ajk;
			      out.print("<td>&nbsp;"+getbyte(FormatD.getFloat2(fk+ajk,2))+"</td>");
			     }
				 rs1.close();
				  
				 sql="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
				sql+=" where f.Period in (5,6,9,10) and f.ContractNo ="+code;
				sql+=" and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				
				 rs1=ViewBean1.executeQuery(sql);//��ȡ��װ��
			     while (rs1.next()){
				  float fk=rs1.getFloat("fact");
				 xiaoji+=fk;
			      out.print("<td>"+getbyte(FormatD.getFloat(fk,2))+"&nbsp;</td>");
			     }
				 rs1.close();
			    sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=0 and taxname  like '%��%'";
		        sql+=" and  contractno  ="+code;
				sql+=" and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";
				
				 rs1=ViewBean1.executeQuery(sql);//��ȡ��̨�ֿ�
			     while (rs1.next()){
				   float fk=rs1.getFloat("money");
				   xiaoji+=fk;
			      out.print("<td>"+getbyte(FormatD.getFloat(fk,2))+"&nbsp;</td>");
			     }
				 rs1.close();
				 sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=0 and not taxname  like '%��%'";
		         sql+=" and  contractno ="+code;
				 sql+=" and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";
				
				 rs1=ViewBean1.executeQuery(sql);//��ȡ���׿�
			     while (rs1.next()){
				   float fk=rs1.getFloat("money");
				   xiaoji+=fk;
			       String aa=getbyte(FormatD.getFloat(fk,2));
				   if (!aa.equals(""))
			       out.print("<td>"+aa+"&nbsp;</td>");
			     }
				 rs1.close();
				 sql="select SUM(money) money,taxname  from FactGatheringTaxRecord where TaxName_type=1 ";
		         sql+=" and  contractno = "+code;
				 sql+=" and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"' group by taxname order by taxname";
				 int nnn=0;
		 list2.clear();
		 list3.clear();
		 
				 rs1=ViewBean1.executeQuery(sql);//��ȡ˰��
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
				     out.print("<td>"+(String)list2.get(index)+"&nbsp;</td>");
				   }else 
				     out.print("<td>&nbsp;</td>");  	 
				
				}
				  list2.clear();
				 list3.clear();

				 
				 zhongji+=xiaoji;
				  out.print("<td>"+FormatD.getFloat2(xiaoji,2)+"&nbsp;</td>");
				  out.print("</tr>");
				 
			  }
		  rs.close();
		  
		  
		        out.print("<tr align='center'><td colspan=2>�ϼ�</td>");
				
				
				String  sql="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
				sql+=" where f.Period in(0,1,2,3,4,8) and f.ContractNo in (";
				   sql+="SELECT ";
          sql+="o.code  from order_contract o ";
          sql+=" where o.state=3  ";
		  sql+=" and o.section='"+SecNo1+"'";
		  if (!Loft.equals(""))
		  sql+=" and o.Loft='"+Loft+"' " ;
		  
		   
				sql+=") and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				 ResultSet rs1=ViewBean1.executeQuery(sql);//��ȡ����
			   
			     while (rs1.next()){
			      out.print("<td>"+getbyte(FormatD.getFloat2(rs1.getDouble("fact")+sumajfk,2))+"</td>");
			     }
				 rs1.close();
				  
				 sql="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
				sql+=" where f.Period in (5,6,9,10) and f.ContractNo in (";
				 sql+="SELECT ";
          sql+="o.code  from order_contract o";
          sql+=" where o.state=3  ";
		  sql+=" and o.section='"+SecNo1+"'";
		  if (!Loft.equals(""))
		  sql+=" and o.Loft='"+Loft+"' " ;
		  
		   
		   
				sql+=") and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				
				 rs1=ViewBean1.executeQuery(sql);//��ȡ��װ��
			     while (rs1.next()){
			      out.print("<td>"+getbyte(FormatD.getFloat(rs1.getFloat("fact"),2))+"&nbsp;</td>");
			     }
				 rs1.close();
			    sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=0 and taxname  like '%��%'";
		        sql+=" and  contractno in (";
				 sql+="SELECT ";
          sql+="o.code  from order_contract o";//customer c
          sql+=" where  o.state=3 ";
		  //and c.serialno=o.customer and o.code in(";
		  
		 // sql+="select ContractNo from factGatheringRecord f";
		  //sql+=" where convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"' group by ContractNo)
		  sql+=" and o.section='"+SecNo1+"'";
		  if (!Loft.equals(""))
		  sql+=" and o.Loft='"+Loft+"' " ;
		  
		   
		    
				sql+=") and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"' ";
		
		
				 
				 rs1=ViewBean1.executeQuery(sql);//��ȡ��̨�ֿ�
			     while (rs1.next()){
			      out.print("<td>"+getbyte(FormatD.getFloat(rs1.getFloat("money"),2))+"&nbsp;</td>");
			     }
				 rs1.close();
				 sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=0 and not taxname  like '%��%'";
		         sql+=" and  contractno in (";
				  sql+="SELECT ";
          sql+="o.code  from order_contract o ";
          sql+=" where  o.state=3  ";
		  sql+=" and o.section='"+SecNo1+"'";
		  if (!Loft.equals(""))
		  sql+=" and o.Loft='"+Loft+"' " ;
		  
		   
		     
				sql+=") and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";

				 rs1=ViewBean1.executeQuery(sql);//��ȡ���׿�
			     while (rs1.next()){
			       String aa=getbyte(FormatD.getFloat(rs1.getFloat("money"),2));
				 
                   if (!aa.equals(""))
			       out.print("<td>"+aa+"&nbsp;</td>");
			     }
				 rs1.close();
				 sql="select SUM(money) money,taxname  from FactGatheringTaxRecord where TaxName_type=1 ";
		         sql+=" and  contractno in (";
				 
				   sql+="SELECT ";
          sql+="o.code  from order_contract o ";
          sql+=" where  o.state=3 ";
		   sql+=" and o.section='"+SecNo1+"'";
		  if (!Loft.equals(""))
		  sql+=" and o.Loft='"+Loft+"' " ;
		  
				 sql+=") and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"' group by taxname order by taxname";
		        list2.clear();
				list3.clear();
		 
				 rs1=ViewBean1.executeQuery(sql);//��ȡ˰��
			     while (rs1.next()){
				  String aa=getbyte(FormatD.getFloat(rs1.getFloat("money"),2));
				    list2.add(aa);
				    list3.add(rs1.getString("taxname"));
			     }
				 rs1.close();
				  for (int i=0;i<taxnum;i++){
				 
			       String strtax=(String)list1.get(i);
				   if (list3.contains(strtax))
				    {    int index=list3.indexOf(strtax);
				     out.print("<td>"+(String)list2.get(index)+"&nbsp;</td>");
				   }else 
				     out.print("<td>&nbsp;</td>");  	 
				
				}
				  out.print("<td>"+FormatD.getFloat2(zhongji,2)+"&nbsp;</td>");
				 
				  out.print("</tr>");
				  
	
				  
				   out.print("<tr align='center'><td colspan=2>�ϼ�</td>");
				
				  sql="select sum(f.factmoney*f.currrate) fact from factGatheringRecord f";
				sql+=" where f.Period in(0,1,2,3,4,5,6,8,9,10) and f.ContractNo in (";
				   sql+="SELECT ";
          sql+="o.code  from order_contract o,customer c";
          sql+=" where  o.state=3  ";
		  sql+=" and o.section='"+SecNo1+"'";
		  if (!Loft.equals(""))
		  sql+=" and o.Loft='"+Loft+"' " ;
		  
		   
				sql+=") and  convert(char(10),f.Gather_Date,120)>='"+dates+"' and  convert(char(10),f.Gather_Date,120)<='"+dates1+"'";
				
				  rs1=ViewBean1.executeQuery(sql);//��ȡ����
			     double fkaa=0;
			     while (rs1.next()){
			     fkaa+=rs1.getDouble("fact");
			     }
				 rs1.close();
				  
				 
				   out.print("<td colspan='2'>"+FormatD.getFloat2(fkaa+sumajfk,2)+"&nbsp;</td>");
			   fkaa=0;
			   sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=0 ";
		         sql+=" and  contractno in (";
				  sql+="SELECT ";
          sql+="o.code  from order_contract o,customer c";
          sql+=" where  o.state=3 ";
		  sql+=" and o.section='"+SecNo1+"'";
		  if (!Loft.equals(""))
		  sql+=" and o.Loft='"+Loft+"' " ;
		  
		   
		     
				sql+=") and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";

				 
				 rs1=ViewBean1.executeQuery(sql);//��ȡ��̨�ֿ�
			     while (rs1.next()){
			       fkaa+=rs1.getFloat("money");
			     }
				 rs1.close();
				
				    out.print("<td colspan='2'>"+FormatD.getFloat2(fkaa,2)+"&nbsp;</td>");
				sql="select SUM(money) money from FactGatheringTaxRecord where TaxName_type=1 ";
		         sql+=" and  contractno in (";
				 
				 
				   sql+="SELECT ";
          sql+="o.code  from order_contract o ";
          sql+=" where  o.state=3 ";
		   sql+=" and o.section='"+SecNo1+"'";
		  if (!Loft.equals(""))
		  sql+=" and o.Loft='"+Loft+"' " ;
		  
		   
		     
				sql+=") and  convert(char(10),Date,120)>='"+dates+"' and  convert(char(10),Date,120)<='"+dates1+"'";

				 
				 rs1=ViewBean1.executeQuery(sql);//��ȡ˰��
			    fkaa=0;

				 while (rs1.next()){
				 
				 fkaa+=rs1.getFloat("money");
				 
			     }
				 rs1.close();
				  out.print("<td colspan='"+taxnum+"'>"+FormatD.getFloat2(fkaa,2)+"&nbsp;</td>");
				 
				  out.print("<td>"+FormatD.getFloat2(zhongji,2)+"&nbsp;</td>");
				 
				  out.print("</tr>");
				  
		}catch(Exception s){out.print(s);}
 %>
</TABLE>
 
</div>

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