<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "�����ձ�" , 
                  "���"
                ) ;
%>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<title>�����ձ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/line.css" >
</head>
<%
String Date2=request.getParameter("Date2");
String SecNo=request.getParameter("SecNo");
 
%>
<body bgcolor="#FFFFFF" text="#000000">
<p align="center"><font size="5"><b>�����ձ���</font></b></p>
 
<%
String year=Date2.substring(0,Date2.indexOf("-"));
String month=Date2.substring(Date2.indexOf("-")+1,Date2.lastIndexOf("-"));
String day=Date2.substring(Date2.lastIndexOf("-")+1);

java.util.Date curDate=new java.util.Date(Integer.parseInt(year)-1900,Integer.parseInt(month)-1,Integer.parseInt(day));


  int CurYear=curDate.getYear()+1900;
      int CurMonth=curDate.getMonth()+1;
      int CurDay=curDate.getDate(); 
		  
	  %>
	  <table><tr><td align="center">
 <%=CurYear %>��<%=CurMonth %>��<%=CurDay %>��&nbsp;&nbsp;
<%if (curDate.getDay()==0) out.print("������"); 
 else if (curDate.getDay()==1)out.print("����һ");
 else if (curDate.getDay()==2)out.print("���ڶ�");
 else if (curDate.getDay()==3)out.print("������");
 else if (curDate.getDay()==4)out.print("������");
 else if (curDate.getDay()==5)out.print("������");
 else if (curDate.getDay()==6)out.print("������");

%>&nbsp;&nbsp;</td><td>����:<input type=text name=aa   class=unnamed1></td><td>�Ƿ�����:<select name=dd><option >��</option><option >��</option></select></td></tr></table>
<b>һ��ҵ��ͳ��</b>
 
 <table width="100%"  border=0 cellspacing='0'  cellpadding='0' >
  <tr align="left"> <td>&nbsp;1.��ѯ�绰������<u></u>��
 </td>
 </tr>
 </table>
 <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr align="center"> 
    <td width="15%">��ѯ����</td>
     <%
	 List att=new LinkedList();//��Ź�ע����(����)
	 List att_curr=new LinkedList();//��Ź�ע����(����)
     List att_num=new LinkedList();//�������
	 int j=0;
	  String SQL="SELECT ATTENTION,count(*) num FROM CUSTOMER   WHERE   ATTENTION<>'' group by ATTENTION";
      ResultSet rs=InsertBean.executeQuery(SQL);
	 while (rs.next()){
	   String attention=getbyte(rs.getString("ATTENTION"));
	   att.add(attention);
	   out.print("<td>"+attention+"</td>");
	   j++;
	  }
	 rs.close();
	  %>
  </tr>
  <%
    SQL="SELECT ATTENTION,count(*) num FROM CUSTOMER   WHERE   ATTENTION<>'' and year(visit_date)="+year+" and month(visit_date)="+month+" and day(visit_date)="+day+" group by ATTENTION";
       rs=InsertBean.executeQuery(SQL);
	 while (rs.next()){
	   String attention=getbyte(rs.getString("ATTENTION"));
	   att_curr.add(attention);
	   att_num.add(rs.getString("num"));
	  }
	 rs.close();
   %>
   <tr align="center"> <td>����</td>
  <%for (int i=0;i<j;i++){ 
    String att1=(String)att.get(i);
	if (att_curr.contains(att1)){
	     int index=att_curr.indexOf(att1);
	  out.print("<td>"+att_num.get(index)+"</td>");
	}else out.print("<td>&nbsp;</td>");

 } %>
  </tr>
  </table>
  <br>
  <table width="100%"  border=0 cellspacing='0'  cellpadding='0' >
  <tr align="left"> <td>&nbsp;2.�绰�ͻ���Ϣ��Դ
 </td>
 </tr>
 </table>
 <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr align="center"> 
    <td width="15%">��Ϣ��Դ</td>
	
   <%
   att.clear();
   att_curr.clear();
   att_num.clear();
   j=0;
   SQL="SELECT knowledge_from,count(*) num FROM CUSTOMER   WHERE   knowledge_from<>''  group by knowledge_from";
        rs=InsertBean.executeQuery(SQL);
	 while (rs.next()){
	   String knowledge_from=getbyte(rs.getString("knowledge_from"));
	   att.add(knowledge_from);
	   out.print("<td>"+knowledge_from+"</td>");
	   j++;
	  }
	 rs.close();
  
    SQL="SELECT knowledge_from,count(*) num FROM CUSTOMER   WHERE   ATTENTION<>'' and year(visit_date)="+year+" and month(visit_date)="+month+" and day(visit_date)="+day+" and visitstate=0 group by knowledge_from";
       rs=InsertBean.executeQuery(SQL);
	 while (rs.next()){
	   String knowledge_from=getbyte(rs.getString("knowledge_from"));
	   att_curr.add(knowledge_from);
	   att_num.add(rs.getString("num"));
	  }
	 rs.close();
   %>
   <tr align="center"> <td>����</td>
  <%for (int i=0;i<j;i++){ 
    String att1=(String)att.get(i);
	if (att_curr.contains(att1)){
	     int index=att_curr.indexOf(att1);
	  out.print("<td>"+att_num.get(index)+"</td>");
	}else out.print("<td>&nbsp;</td>");

 } %>
  </tr>
  </table>
    <br>
  <table width="100%"  border=0 cellspacing='0'  cellpadding='0' >
  <tr align="left"> <td>&nbsp;3.���ſͻ�����<u>&nbsp;&nbsp;&nbsp;</u>��:
 </td>
 </tr>
 </table>
 <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr align="center"> 
    <td width="15%">��Ϣ��Դ</td>
	
   <%
   att.clear();
   att_curr.clear();
   att_num.clear();
   j=0;
   SQL="SELECT knowledge_from,count(*) num FROM CUSTOMER   WHERE   knowledge_from<>'' group by knowledge_from";
        rs=InsertBean.executeQuery(SQL);
	 while (rs.next()){
	   String knowledge_from=getbyte(rs.getString("knowledge_from"));
	   att.add(knowledge_from);
	   out.print("<td>"+knowledge_from+"</td>");
	   j++;
	  }
	 rs.close();
  
    SQL="SELECT knowledge_from,count(*) num FROM CUSTOMER   WHERE   ATTENTION<>'' and year(visit_date)="+year+" and month(visit_date)="+month+" and day(visit_date)="+day+" and visitstate=1 group by knowledge_from";
       rs=InsertBean.executeQuery(SQL);
	 while (rs.next()){
	   String knowledge_from=getbyte(rs.getString("knowledge_from"));
	   att_curr.add(knowledge_from);
	   att_num.add(rs.getString("num"));
	  }
	 rs.close();
   %>
   <tr align="center"> <td>����</td>
  <%for (int i=0;i<j;i++){ 
    String att1=(String)att.get(i);
	if (att_curr.contains(att1)){
	     int index=att_curr.indexOf(att1);
	  out.print("<td>"+att_num.get(index)+"</td>");
	}else out.print("<td>&nbsp;</td>");

 } %>
  </tr>
  </table>
  
    <br>
  <table width="100%"  border=0 cellspacing='0'  cellpadding='0' >
  <tr align="left"> <td>&nbsp;4.���ſͻ�����
 </td>
 </tr>
 </table>
   <br>
 <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr align="center"> 
    <td width="15%">����</td>
	
   <%
   att.clear();
   att_curr.clear();
   att_num.clear();
   j=0;
   SQL="SELECT region,count(*) num FROM CUSTOMER   WHERE   region<>''  group by region";
        rs=InsertBean.executeQuery(SQL);
	 while (rs.next()){
	   String region=getbyte(rs.getString("region"));
	   att.add(region);
	   out.print("<td>"+region+"</td>");
	   j++;
	  }
	 rs.close();
  
    SQL="SELECT region,count(*) num FROM CUSTOMER   WHERE   region<>'' and year(visit_date)="+year+" and month(visit_date)="+month+" and day(visit_date)="+day+" and visitstate=0 group by region";
       rs=InsertBean.executeQuery(SQL);
	 while (rs.next()){
	   String region=getbyte(rs.getString("region"));
	   att_curr.add(region);
	   att_num.add(rs.getString("num"));
	  }
	 rs.close();
   %>
   <tr align="center"> <td>����</td>
  <%for (int i=0;i<j;i++){ 
    String att1=(String)att.get(i);
	if (att_curr.contains(att1)){
	     int index=att_curr.indexOf(att1);
	  out.print("<td>"+att_num.get(index)+"</td>");
	}else out.print("<td>&nbsp;</td>");

 } %>
  </tr>
  </table>  <br>
  <table width="100%"  border=0 cellspacing='0'  cellpadding='0' >
  <tr align="left"> <td>&nbsp;3.���ſͻ������ͣ�
 </td>
 </tr>
 </table>
 <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr align="center"> 
    <td width="15%">����</td>
	
   <%
   att.clear();
   att_curr.clear();
   att_num.clear();
   j=0;
   SQL="SELECT demand,count(*) num FROM CUSTOMER   WHERE   demand<>'' group by demand";
        rs=InsertBean.executeQuery(SQL);
	 while (rs.next()){
	   String demand=getbyte(rs.getString("demand"));
	   att.add(demand);
	   out.print("<td>"+demand+"</td>");
	   j++;
	  }
	 rs.close();
  
    SQL="SELECT demand,count(*) num FROM CUSTOMER   WHERE   demand<>'' and year(visit_date)="+year+" and month(visit_date)="+month+" and day(visit_date)="+day+" and visitstate=1 group by demand";
       rs=InsertBean.executeQuery(SQL);
	 while (rs.next()){
	   String demand=getbyte(rs.getString("demand"));
	   att_curr.add(demand);
	   att_num.add(rs.getString("num"));
	  }
	 rs.close();
   %>
   <tr align="center"> <td>����</td>
  <%for (int i=0;i<j;i++){ 
    String att1=(String)att.get(i);
	if (att_curr.contains(att1)){
	     int index=att_curr.indexOf(att1);
	  out.print("<td>"+att_num.get(index)+"</td>");
	}else out.print("<td>&nbsp;</td>");

 } %>
  </tr>
  </table>
    <br>
<b>  �����ɽ����</b>
<br>


   <%
   String subscription="0";
   SQL="SELECT SUBSCRIPTION FROM order_contract WHERE section='"+SecNo+"' and  state<>3 ";
   rs=InsertBean.executeQuery(SQL);
   if (rs.next())subscription=rs.getString("SUBSCRIPTION");
   rs.close();
   
   //��������
  SQL="SELECT  count(*) num FROM order_contract o,customer c WHERE o.customer=c.serialno and   year(o.date)=year('"+Date2+"') and month(o.date)=month('"+Date2+"') and  day(o.date)=day('"+Date2+"') and o.code in (select contractno from factgatheringrecord where period=0 and factmoney>="+subscription+" ) and o.section='"+SecNo+"'";

    rs=InsertBean.executeQuery(SQL);
	 
	String num="";
 if (rs.next())num=rs.getString("num");
   rs.close();
   if (num.equals("0"))num="";
   
    //���ղ���
  SQL="SELECT  count(*) num FROM order_contract o,customer c WHERE o.customer=c.serialno   and   year(o.date)=year('"+Date2+"') and month(o.date)=month('"+Date2+"') and  day(o.date)=day('"+Date2+"') and o.code in (select contractno from factgatheringrecord where period=0 and factmoney<"+subscription+" ) and o.section='"+SecNo+"'";

    rs=InsertBean.executeQuery(SQL);
	
	String num1="";
 if (rs.next())num1=rs.getString("num");
   rs.close();
      if (num1.equals("0"))num1="";
   //�����ٶ�
  SQL="SELECT  count(*) num FROM SL_TemporarilyBuy s ,room r WHERE s.roomcode=r.code   and   year(s.startdate)=year('"+Date2+"') and month(s.startdate)=month('"+Date2+"') and  day(s.startdate)=day('"+Date2+"') and r.seccode='"+SecNo+"'";
 
    rs=InsertBean.executeQuery(SQL);
	
	String num2="";
 if (rs.next())num2=rs.getString("num");
   rs.close();
   if (num2.equals("0"))num2="";
   
   //�ۼ�̢��
  
  SQL="SELECT count(*) num FROM order_contract o where  o.STATE=3 and o.state<>3  and o.customer in (select customer  from  tfrecord  where secno='"+SecNo+"') ";
String num4="";
    rs=InsertBean.executeQuery(SQL);
	  
	if (rs.next())num4=rs.getString("num");
	 if (num.equals("0"))num4="";
  rs.close();
   
   
   //�ۼ��ٶ�:
 
  SQL="SELECT  count(*) num FROM SL_TemporarilyBuy s ,room r WHERE s.roomcode=r.code   and   s.state=0  and r.seccode='"+SecNo+"'";
 
    rs=InsertBean.executeQuery(SQL);
	
	String num3="";
 if (rs.next())num3=rs.getString("num");
   rs.close();
   if (num3.equals("0"))num3="";
  //�ۼƳɽ�
   SQL="SELECT SUM(JZAREA) AREA,SUM(RMBPRICE) PRICE,COUNT(*) NUM FROM order_contract where  section='"+SecNo+"' and  state<>3 ";//WHERE STATE<>3
 double ss_area=0;
 int ss_num=0,ss_price=0;
    rs=InsertBean.executeQuery(SQL);
	if (rs.next()){ 
	   ss_area=rs.getDouble("area");
	   ss_price=rs.getInt("PRICE");
       ss_num=rs.getInt("NUM");
     }
  rs.close();
// �ɽ���ϸ
%>
<!--
<table width="100%"   cellspacing='0'  cellpadding='0' >
  <tr align="center"> 
    <td>���ճɽ��㶨<u><%=num %>&nbsp;</u>��,</td> 
	  <td>�ٶ�<U><%=num2 %>&nbsp;</u>��;</td>
	  <td>���в���<U><%=num1 %>&nbsp;��</u></td>
  </tr>	  
</table>-->
<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr align="center"> 
    <td>���</td>  <td>����</td>  <td>���</td>  <td>����</td>
    <td>���ʽ</td>  <td>����</td>  <td>�ܼ�</td>  <td>��Դ����</td>
	<td>ҵ��Ա</td>  <td>��ע</td>
  </tr>	  
<%
   SQL="SELECT o.loft+o.building+o.room_no room,o.jzarea,c.cus_name,o.payment1,o.rmbprice/o.jzarea unitprice,o.rmbprice,c.region,o.seller,o.note FROM order_contract o,customer c where o.section='"+SecNo+"'  and year(o.date)=year('"+Date2+"') and month(o.date)=month('"+Date2+"') and  day(o.date)=day('"+Date2+"') and c.serialno=o.customer and o.state<>3  ";
 
    rs=InsertBean.executeQuery(SQL);
	j=0;
	while (rs.next()){ j++;
	%>
	<tr>
	<td><%=j %>
	<td><%=getbyte(rs.getString("room")) %></td>
	<td><%=FormtD.getFloat(rs.getFloat("jzarea"),4) %></td>
	<td><%=getbyte(rs.getString("cus_name")) %></td>
	<td><%=getbyte(rs.getString("payment1")) %></td>
	<td><%=FormtD.getFloat(rs.getFloat("unitprice"),0) %>%</td>
	<td><%=FormtD.getFloat(rs.getFloat("rmbprice"),0) %></td>			
	<td><%=getbyte(rs.getString("region")) %>&nbsp;</td>
    <td><%=getbyte(rs.getString("seller")) %>&nbsp;</td>
    <td><%=getbyte(rs.getString("note")) %>&nbsp;</td>	
	<%
     }
  rs.close();
   %>
  </tr>
  </table>
  <br>
  <table width="100%"   cellspacing='0'  cellpadding='0' >
  <tr align="center"> 
    <td>Ŀǰ�ۼƣ�</td>  <td>�ɽ�<U><%=ss_num %></u>��</td>  <td>̢��<U><%=num4 %></u>��</td>  <td>�ٶ�<U><%=num3 %></u>��</td>
     
  </tr>
   <tr align="center"> 
    <td colspan="2">�ۼ������<u><%=FormtD.getFloat2(ss_area,3) %>M<sup>2</sup></u></td>  <td colspan="2">�ۼƽ��:<U><%=FormtD.getFloat(ss_price,0) %>Ԫ</u></td>  
     
  </tr>
   </table>
  
</body>
</html>
