<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<jsp:useBean id="FormtD3" scope="page" class="test.PieChart"/>  
 

<html>
<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
	<title>�г��������</title>
</head>

<body>
<script language="JavaScript">
<!--
 function ok(x){
	 document.all.photo.value=x;
	 form1.action="list_charges_plan.jsp?type=5&ch_type=3";
	 form1.submit();
 }
//-->
</script>
 
<%
String SecNo=getbyte1(request.getParameter("SecNo")); 
 
try{
  String sql="select count(*),name,cus_name from customer a,crm_project b where a.serialno not in (select customer from order_contract where  Section='"+SecNo+"' and state<>3)  and  a. Section='"+SecNo+"' and  a.section=b.SerialNo group by name ,cus_name";
   ResultSet rs=ViewBean.executeQuery(sql);
     int  num=0;
	 String projectname="";
	while  (rs.next())
	
	{num++;
	projectname=rs.getString("name");
	}
	rs.close();
	out.print("<p align=left><font size=5>¥�����ƣ�"+projectname);
	out.print("&nbsp;&nbsp;&nbsp;&nbsp;��������:"+String.valueOf(num)+"</font></p>");
	
	  Calendar calendar1 = Calendar.getInstance();
 
  String filename = String.valueOf(calendar1.getTimeInMillis());	
  String messtitle="�ͻ������������";
 sql="select region nam,count(*) num from customer where section='"+SecNo+"' and  serialno not in (select customer from order_contract where  Section='"+SecNo+"' and state<>3) group by  region";
 
   String pic= FormtD3.drawToFile("D:/"+ request.getContextPath()+"/crmv9/jsp/picture/yxfxpic"+filename+".jpg",sql,messtitle);  
  if (!pic.equals(""))
    out.print("<img src='../picture/yxfxpic"+filename+".jpg'>");
	
	
     sql="select  code,codename from CustomerDc where type=0 and sectionno='"+SecNo+"'";
	 
	 
     rs=ViewBean.executeQuery(sql);
   while (rs.next()){
       sql="select b.codevalue nam,count(*) num from customer_xq a ,CustomerDcValue b,customer c where ";
	   sql+="a.xq_code=b.code and c.code=a.customer and b.dccode="+rs.getString("code")+" and c.Section='"+SecNo+"' and  c.serialno not in (select customer from order_contract where  Section='"+SecNo+"' and state<>3)  group by b.codevalue  ";
  Calendar calendar = Calendar.getInstance();
 
    filename = String.valueOf(calendar.getTimeInMillis());	
    messtitle=rs.getString("codename")+"�г��������";
 
     pic= FormtD3.drawToFile("D:/"+ request.getContextPath()+"/crmv9/jsp/picture/yxfxpic"+filename+".jpg",sql,messtitle);  
  if (!pic.equals(""))
    out.print("<img src='../picture/yxfxpic"+filename+".jpg'>");
 
 }
 rs.close();
 }catch(Exception s){out.print(s);}

 %>
</body>
</html>