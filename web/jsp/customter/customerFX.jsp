<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="FormtD3" scope="page" class="test.PieChart"/>  
<%@ include file="../public_js/getByteOut.jsp"%>
 
<html>
<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
	<title>客户分析</title>
</head>

<body> 
<table width="100%">
<%
String photo=request.getParameter("cus_state");
String Date1 =request.getParameter("Date1");
String Date2 =request.getParameter("Date2");
String cus_type =request.getParameter("cus_type");
String dateWHERE="";
 if (photo.equals("2")){
if (!Date1.equals("")&&!Date2.equals(""))
  dateWHERE=" and convert(char(10),date,120) >='"+Date1+"' and convert(char(10),date,120)<='"+Date2+"'";
else if (!Date1.equals("")&&Date2.equals(""))  
  dateWHERE=" and  convert(char(10),date,120) >='"+Date1+"'";
else if (Date1.equals("")&&!Date2.equals(""))  	
   dateWHERE=" and  convert(char(10),date,120) <='"+Date2+"'";
 }else{
 if (!Date1.equals("")&&!Date2.equals(""))
  dateWHERE=" and convert(char(10),visit_date,120) >='"+Date1+"' and convert(char(10),visit_date,120)<='"+Date2+"'";
else if (!Date1.equals("")&&Date2.equals(""))  
  dateWHERE=" and  convert(char(10),visit_date,120) >='"+Date1+"'";
else if (Date1.equals("")&&!Date2.equals(""))  	
   dateWHERE=" and  convert(char(10),visit_date,120) <='"+Date2+"'";
 
 }  
if (!cus_type.equals("4"))dateWHERE+=" and a.visitstate="+cus_type;
String[] codcenames=request.getParameterValues("codcename");
String codcename="";
if (codcenames!=null){
   for (int aa=0;aa<codcenames.length;aa++){
    if (codcename.equals(""))codcename=codcenames[aa];
	else codcename+=","+codcenames[aa];
  }
}
String SecNo=getbyte1(request.getParameter("section")); 
String qy=China.getParameter(request,"qy");
if (!qy.equals("")){
		 out.print("<td>");
	String   messtitle="客户来自区域分析";
 String sql="";
   if (photo.equals("3")){
   sql="select region nam,count(*) num from customer a where section='"+SecNo+"' "+dateWHERE+" group by  region";
   }else    if (photo.equals("2")){ 
   sql="select region nam,count(*) num from customer where serialno in (select customer from order_contract where state<>3 and section='"+SecNo+"'  "+dateWHERE+" ) and  section='"+SecNo+"' group by  region";
   
 }else    if (photo.equals("1")){  
   sql="select region nam,count(*) num from customer where serialno not in (select customer from order_contract where state<>3 and section='"+SecNo+"'  "+dateWHERE+" )  and section='"+SecNo+"' group by  region";
   
   }
   Calendar calendar = Calendar.getInstance();
	  String filename = String.valueOf(calendar.getTimeInMillis());	
      String pic= FormtD3.drawToFile("D:/"+ request.getContextPath()+"/crmv9/jsp/picture/yxfxpic"+filename+".jpg",sql,messtitle);  
      if (!pic.equals(""))
	    out.print("<img src='../picture/yxfxpic"+filename+".jpg'>");
	   out.print("</td>");
	    
    }
 if (!codcename.equals("")){ 

 
try{
   String sql="";
   if (photo.equals("2"))
      sql="select count(*) num,cus_name from customer a where a.serialno  in (select customer from order_contract where state<>3 and   Section='"+SecNo+"' "+dateWHERE+")  and  a. Section='"+SecNo+"'   group by cus_name";
   else  if (photo.equals("3"))
      sql="select count(*) num,cus_name from customer a where    a. Section='"+SecNo+"' "+dateWHERE+" group by cus_name";
    else  if (photo.equals("1"))
	  sql="select count(*) num,cus_name from customer a where a.serialno not in (select customer from order_contract where  state<>3 and  Section='"+SecNo+"' "+dateWHERE+")  "+dateWHERE+" and  a. Section='"+SecNo+"'  group by cus_name";
 
   ResultSet rs=ViewBean.executeQuery(sql);
   
     int  num=0;
	 String projectname="";
	while  (rs.next())
	
	{num+=rs.getInt("num");
	 
	}
	rs.close();
	out.print("<p align=left><font size=5>");
	out.print("&nbsp;&nbsp;&nbsp;&nbsp;调查人数:"+String.valueOf(num)+"");
	if (photo.equals("3"))
	out.print("&nbsp;&nbsp;&nbsp;&nbsp;客户范围:所有客户");
	else if (photo.equals("2"))
	out.print("&nbsp;&nbsp;&nbsp;&nbsp;客户范围:成交客户");
	else if (photo.equals("1"))
	out.print("&nbsp;&nbsp;&nbsp;&nbsp;客户范围:未成交客户");
	out.print("</font></p>");
	
 	
     sql="select  code,codename from CustomerDc  where sectionno='"+SecNo+"' and code in ("+codcename+")";

     rs=ViewBean.executeQuery(sql);
	int jj=0;
   while (rs.next()){
         if (!cus_type.equals("4")) 
           sql="select b.codevalue nam,count(*) num from customer_xq c ,CustomerDcValue b,customer a where a.visitstate="+cus_type+" and ";
		 else
		    sql="select b.codevalue nam,count(*) num from customer_xq c ,CustomerDcValue b,customer a where ";
		
	     if (photo.equals("2"))//成交客户
	       sql+="a.serialno   in (select customer from order_contract where  Section='"+SecNo+"'"+dateWHERE+" ) and ";
		  else  if (photo.equals("1"))//未成交客户
		   sql+="a.serialno not  in (select customer from order_contract where  Section='"+SecNo+"') "+dateWHERE+" and ";
	     sql+=" c.xq_code=b.code and a.code=c.customer and b.dccode="+rs.getString("code")+" and a.Section='"+SecNo+"' group by b.codevalue  ";
 
	   if (jj==0)out.print("<tr>");
	  
	   out.print("<td>");
	  Calendar calendar = Calendar.getInstance();
	  String filename = String.valueOf(calendar.getTimeInMillis());	
	  String messtitle=rs.getString("codename")+"市场调查分析";
      String pic= FormtD3.drawToFile("D:/"+ request.getContextPath()+"/crmv9/jsp/picture/yxfxpic"+filename+".jpg",sql,messtitle);  
	  if (!pic.equals(""))
	    out.print("<img src='../picture/yxfxpic"+filename+".jpg'>");
	   out.print("</td>");
	  jj++;
	 if (jj==2){out.print("</tr>");jj=0;}
 }
 rs.close();
 }catch(Exception s){out.print(s);}
}else{out.print("请选择分析数据项!");}
 %>
 </table>
</body>
</html>