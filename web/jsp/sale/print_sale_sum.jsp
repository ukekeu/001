 
 <%@ page contentType="text/html;charset=GBK" %>
 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/CheckSection.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>����</title>
</head>
<body>
<% 
String secName="";
String Date1=request.getParameter("Date1");
String Date2=request.getParameter("Date2");
String sectionNo=getbyte1(request.getParameter("SecNo"));
 secName=sectionNo.substring(sectionNo.indexOf("|")+1);
sectionNo=sectionNo.substring(0,sectionNo.indexOf("|"));
	 
 %>
 
<table width="99%" cellspacing="0" cellpadding="0">
 <tr align="center" ><td  ><b><font size=4><%=secName  %>���ۻ��ܱ�</font></b> </td></tr>
</table>
<br>
 
 <table width="99%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF">
  
  <tr bgcolor='#EAECEC' align="center">  
    <td>&nbsp; </td>
    <td>��������</td>
    <td>�������M<sup>2</sup></td>
    <td>���۽��(�Ϲ���)</td>
  
    <td>���۾���</td>
    <td>ʵ�������ܼ�<br>(�������Żݲ���)</td>
    <td>ʵ�ʾ���(Ԫ/M<sup>2</sup>)</td>
    <td>������</td>
    <td>ÿ������<br>����֧��</td>
    <td>���۷�ռʵ��<br>���۵ı���</td>
    
  </tr>
  <%
  
  
   int s_sale_num=0;
   double s_sale_area=0;
   int s_sale_price=0;
   double s_sale_av_price=0;
   double s_fact_sale_av_price=0;
   int s_fact_sale_price=0;
   double s_sale_rate=0;
  
  
   int sale_num=0;
   double sale_area=0;
   int sale_price=0;
   double sale_av_price=0;
   double fact_sale_av_price=0;
   int fact_sale_price=0;
   double sale_rate=0;
   int ks_num=0;
   double ks_area=0;
   String SQL="";
   String year_month="";
   String orderSQL="";
   List charges=new LinkedList();//���ÿ�����۷���
   List yearmonth=new LinkedList();//�������
 try{
  
  String  Sql="select count(*) num,sum(area) area  FROM room where seccode='"+sectionNo+"'";
  //��������
 
 
  ResultSet rs2=ViewBean1.executeQuery(Sql);
  
  if (rs2.next()){ks_num=rs2.getInt("num");ks_area=rs2.getDouble("area");
   }
   rs2.close();
   
   
   
   //�������۷���
 

 orderSQL="select sum(charges_value) ch,substring(convert(char(24),out_date,120),0,8) as yearmonth from out_charges where  section_no='"+sectionNo+"' and out_date between '"+Date1+"' and '"+Date2+"' group by substring(convert(char(24),out_date,120),0,8)";
  ResultSet C=ViewBean.executeQuery(orderSQL);
  
  while (C.next()){
 
	 charges.add(getbyte(C.getString("ch")));
     yearmonth.add(getbyte(C.getString("yearmonth")));
  }C.close();
   
   //��������
   
   SQL="select  count(*)  num,sum(jzarea) jzarea,sum(rmbprice) price,sum(rmbprice)/sum(jzarea) avgprice,sum(rmbprice)-sum(zs_first_money) factprice,(sum(rmbprice)-sum(zs_first_money))/sum(jzarea) factavgprice,count(*)*1.0/"+String.valueOf(ks_num)+"*100 salerate from order_contract where state<>3 and date between '"+Date1+"' and '"+Date2+"' and section ='"+sectionNo+"'"; 
 
	  ResultSet rs=ViewBean2.executeQuery(SQL);
	  if (rs.next()){
	    // year_month=rs.getString("yearmonth");
	     sale_num=rs.getInt("num");
		 sale_area=rs.getDouble("jzarea");
	     sale_price=rs.getInt("price");
		 sale_av_price=rs.getDouble("avgprice");
    	 fact_sale_price=rs.getInt("factprice");
		 fact_sale_av_price=rs.getDouble("factavgprice");
		 sale_rate=rs.getDouble("salerate");
		 
	  }
	    rs.close();
	  }catch(Exception s){}
	 %>
 <tr align="right">
 <td align="center">��ʱ�κϼ�<br>(<%=Date1.substring(Date1.indexOf("-")+1) %>��<%=Date2.substring(Date2.indexOf("-")+1) %>)</td>
  <td ><%= sale_num%></td> <td><%=sale_area%></td>
  <td><%=  Format.getFloat(sale_price,0)%></td> <td><%=Format.getFloat2(sale_av_price,2)%></td>
  <td><%= Format.getFloat(fact_sale_price,0)%></td> <td><%=Format.getFloat2(fact_sale_av_price,2)%></td>
  <td><%=Format.getFloat2(sale_rate,2)%>%</td>
   <td>
   <%
   float charge=0;
   if (yearmonth.contains(year_month)){
	  int index=yearmonth.indexOf(year_month);
	  out.print((String)charges.get(index));
	  charge=Float.parseFloat((String)charges.get(index));
	}  
   
   
   %>&nbsp;</td>
   <td>&nbsp;<%if (fact_sale_price>0)out.println(Format.getFloat2(charge/fact_sale_price*100,2));else out.println("0"); %>%</td>
</tr>

<%


   //�������۷���
   

 orderSQL="select sum(charges_value) ch,substring(convert(char(24),out_date,120),0,8) as yearmonth from out_charges where section_no='"+sectionNo+"'   group by substring(convert(char(24),out_date,120),0,8)";
  ResultSet C=ViewBean.executeQuery(orderSQL);
  charges.clear();
  yearmonth.clear();
  while (C.next()){
 
	 charges.add(getbyte(C.getString("ch")));
     yearmonth.add(getbyte(C.getString("yearmonth")));
  }C.close();
   
   //��������
   
    SQL="select substring(convert(char(24),date,120),0,8) as yearmonth ,count(*) num,sum(jzarea) jzarea,sum(rmbprice) price,sum(rmbprice)/sum(jzarea) avgprice,sum(rmbprice)-sum(zs_first_money) factprice,(sum(rmbprice)-sum(zs_first_money))/sum(jzarea) factavgprice,count(*)*1.0/"+String.valueOf(ks_num)+"*100 salerate from order_contract where state<>3  and section ='"+sectionNo+"' group by substring(convert(char(24),date,120),0,8)"; 
 
	  ResultSet rs=ViewBean2.executeQuery(SQL);
	  while (rs.next()){
	     year_month=rs.getString("yearmonth");
	     sale_num=rs.getInt("num");
		 sale_area=rs.getDouble("jzarea");
	     sale_price=rs.getInt("price");
		 sale_av_price=rs.getDouble("avgprice");
    	 fact_sale_price=rs.getInt("factprice");
		 fact_sale_av_price=rs.getDouble("factavgprice");
		 sale_rate=rs.getDouble("salerate");
		 %>
		 
 <tr align="right">
 
 <td align="center"><%=year_month %> �ϼ�</td>
  <td><%= sale_num%></td> <td><%=Format.getFloat2(sale_area,2)%></td>
   <td><%=  Format.getFloat(sale_price,0)%></td> <td><%=Format.getFloat2(sale_av_price,2)%></td>
  <td><%=  Format.getFloat(fact_sale_price,0)%></td> <td><%=Format.getFloat2(fact_sale_av_price,2)%></td>
  <td><%=Format.getFloat2(sale_rate,2)%>%</td>
   <td>
   <%
     charge=0;
   if (yearmonth.contains(year_month)){
	  int index=yearmonth.indexOf(year_month);
	  out.print((String)charges.get(index));
	  charge=Float.parseFloat((String)charges.get(index));
	}  
   
   
   %>&nbsp;</td>
   <td>&nbsp;<%if (fact_sale_price>0)out.println(Format.getFloat2(charge/fact_sale_price*100,2));else out.println("0"); %>%</td>
</tr>
		 <%
		 
	  }
	    rs.close();
	  
 %>
 
 
 
<%


   //�����۷���
   

 orderSQL="select sum(charges_value) ch,substring(convert(char(24),out_date,120),0,5) as yearmonth from out_charges where section_no='"+sectionNo+"'   group by substring(convert(char(24),out_date,120),0,5)";
   C=ViewBean.executeQuery(orderSQL);
  charges.clear();
  yearmonth.clear();
  while (C.next()){
 
	 charges.add(getbyte(C.getString("ch")));
     yearmonth.add(getbyte(C.getString("yearmonth")));
  }C.close();
   
   //������
   
    SQL="select substring(convert(char(24),date,120),0,5) as yearmonth ,count(*) num,sum(jzarea) jzarea,sum(rmbprice) price,sum(rmbprice)/sum(jzarea) avgprice,sum(rmbprice)-sum(zs_first_money) factprice,(sum(rmbprice)-sum(zs_first_money))/sum(jzarea) factavgprice,count(*)*1.0/"+String.valueOf(ks_num)+"*100 salerate from order_contract where state<>3  and section ='"+sectionNo+"' group by substring(convert(char(24),date,120),0,5)"; 
 
	   rs=ViewBean2.executeQuery(SQL);
	  while (rs.next()){
	     year_month=rs.getString("yearmonth");
		 
		 
		  sale_num=rs.getInt("num");
		 s_sale_num+=sale_num;
		 sale_area=rs.getDouble("jzarea");
		 s_sale_area+=sale_area;
	     sale_price=rs.getInt("price");
		 s_sale_price+=sale_price;
		 sale_av_price=rs.getDouble("avgprice");
    	 fact_sale_price=rs.getInt("factprice");
		 s_fact_sale_price+=fact_sale_price;
		 fact_sale_av_price=rs.getDouble("factavgprice");
		 sale_rate=rs.getDouble("salerate");
		 %>
		 
 <tr align="right">
 
 <td align="center"><%=year_month %>�� �ϼ�</td>
  <td><%= sale_num%></td> <td><%=Format.getFloat2(sale_area,2)%></td>
   <td><%=  Format.getFloat(sale_price,0)%></td> <td><%=Format.getFloat2(sale_av_price,2)%></td>
  <td><%=  Format.getFloat(fact_sale_price,0)%></td> <td><%=Format.getFloat2(fact_sale_av_price,2)%></td>
  <td><%=Format.getFloat2(sale_rate,2)%>%</td>
   <td>
   <%
     charge=0;
   if (yearmonth.contains(year_month)){
	  int index=yearmonth.indexOf(year_month);
	  out.print((String)charges.get(index));
	  charge=Float.parseFloat((String)charges.get(index));
	}  
   
   
   %>&nbsp;</td>
   <td>&nbsp;<%if (fact_sale_price>0)out.println(Format.getFloat2(charge/fact_sale_price*100,2));else out.println("0"); %>%</td>
</tr>
		 <%
		 
	  }
	    rs.close();
	  
 %>
 
 
 
<%


   //�ۼ����۷���
   

 orderSQL="select sum(charges_value) ch from out_charges where section_no='"+sectionNo+"' ";
   C=ViewBean.executeQuery(orderSQL);
 int lj_charges=0;
  while (C.next()){
 
	 lj_charges=C.getInt("ch");
  }C.close();
   
   
		 %>
		 
 
 	 
  <tr align="right">
 
 <td align="center">ȫ���ۼ�</td>
  <td ><%= s_sale_num%></td> <td  ><%=Format.getFloat2(s_sale_area,2)%></td>
   <td><%=  Format.getFloat(s_sale_price,0)%></td> <td><%=Format.getFloat2(s_sale_price/s_sale_area,2)%></td>
  <td><%=  Format.getFloat(s_fact_sale_price,0)%></td> <td><%=Format.getFloat2(s_fact_sale_price/s_sale_area,2)%></td>
  <td><%=Format.getFloat2(s_sale_num*1.0/ks_num*100,2)%>%</td>
   <td>
   <%=lj_charges   %>&nbsp;</td>
   <td>&nbsp;<%if (fact_sale_price>0)out.println(Format.getFloat2(lj_charges*1.0/s_fact_sale_price*100,2));else out.println("0"); %>%</td>
</tr>
		 <%
		 
	   
	  
 %>
 </table>
 ����һ��
<table  border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF">
 <tr><td><%=secName %>�ܿ��������(M<SUP>2</SUP>)</td><td align="right">&nbsp;<%=Format.getFloat2(ks_area,2)%></td></tr>
 <tr><td>���������(M<SUP>2</SUP>)</td><td align="right">&nbsp;<%=Format.getFloat2(s_sale_area,2)%></td></tr>
 <tr><td>���������(M<SUP>2</SUP>)</td><td align="right">&nbsp;<%=Format.getFloat2(ks_area-s_sale_area,2)%></td></tr>
<tr><td colspan="2">���ƣ�<%=ks_num %>��</td></tr>
</table>
<p></p>

 <table width="99%" border="0" cellspacing="0" cellpadding="0"    >
  
  <tr bgcolor='#EAECEC' align="center">  
<td>&nbsp;</td> <td>���۾���ǩ�֣�</td><td>&nbsp;</td><td>&nbsp;</td><td>��������ǩ�֣�</td><td>&nbsp;</td>
 </tr></table>
</body>

</html>
