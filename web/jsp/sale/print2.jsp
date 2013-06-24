<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
	<title>打印条件</title>
</head>

<body>
<%
String Date1=China.getParameter(request,"Date1");
String Date2=China.getParameter(request,"Date2");
if (Date2.equals(""))Date2="";
String SecNo=China.getParameter(request,"SecNo");
String Loft=China.getParameter(request,"Loft");
int i=0;
int t=0;
 List list1=new LinkedList();//存放本月销售面积
 List list2=new LinkedList();//存放本月销售金额
 List list3=new LinkedList();//存放本年销售面积
 List list4=new LinkedList();//存放本年销售金额
 List list5=new LinkedList();//存放楼盘名称
String SQLFindStr="";
String SQLFindStr1="";
String sectionname="";
SQLFindStr="select sectionname,sum(jzarea) as sumarea,sum(salerprice*rate)/10000 as summoney from Order_Contract where ";
if (!Date1.equals("")){
   SQLFindStr+="substring(convert(char(28),date,120),1,10)>='"+Date1+"' and ";
  } 
if (!Date2.equals("")){  
  SQLFindStr+=" substring(convert(char(28),date,120),1,10)<='"+Date2+"'";
 }
//if (!Date1.equals("")&&!Date2.equals("")){
 //  SQLFindStr+="month(date)=month(getdate())";
// }
 
 
if (!SecNo.equals(""))
  SQLFindStr+=" and section='"+SecNo+"'";
if (!Loft.equals(""))
  SQLFindStr+=" and Loft='"+Loft+"'";
ResultSet rs2=null;

try{
 rs2=ViewBean.executeQuery(SQLFindStr+"  group by sectionname");
 while (rs2.next()){
    t++;
    list1.add(rs2.getString("sumarea"));
    list2.add(rs2.getString("summoney"));
	list5.add(getbyte(rs2.getString("sectionname")));
	
 }
 rs2.close();
}catch(Exception s){out.print(s.getMessage()+SQLFindStr+"  group by sectionname");out.close();}
SQLFindStr1="select sectionname, sum(jzarea) as sumarea,sum(salerprice*rate)/10000 as summoney from Order_Contract where ";
if (!Date1.equals("")){
  SQLFindStr1 +="year(date)="+Date1.substring(0,Date1.indexOf("-"));
}else{
  SQLFindStr1 +="year(date)=year(getdate())";

}
if (!SecNo.equals(""))
  SQLFindStr1+=" and section='"+SecNo+"'";
if (!Loft.equals(""))
  SQLFindStr1+=" and Loft='"+Loft+"'";
try{
 rs2=ViewBean.executeQuery(SQLFindStr1+"  group by sectionname");
 while (rs2.next()){
    i++;
    list3.add(rs2.getString("sumarea"));

    list4.add(rs2.getString("summoney"));
 }
 rs2.close();
}catch(Exception s){out.print(s.getMessage());out.close();}
String SQL="";
 
try{
ViewBean.executeUpdate("DELETE salecount");
if(t>0){
  for (int j=0;j<i;j++){ 
	 SQL="INSERT INTO salecount(sectionname,montharea,monthmoney,countarea,countmoney,date_s_e)";
     SQL+=" VALUES('"+(String)list5.get(j)+"',"+(String)list1.get(j)+","+(String)list2.get(j);
	 SQL+=","+(String)list3.get(j)+","+(String)list4.get(j)+",'统计时段:"+Date1+" 到  "+Date2+"')";
	ViewBean.executeUpdate(SQL);
  }
}
}catch(Exception s){out.print(s.getMessage());out.close();}
String reportAddrs=(String)session.getAttribute("reportAddr");
response.sendRedirect(reportAddrs+"salecount1.rpt");
 %>


</body>
</html>
