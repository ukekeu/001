<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<jsp:useBean id="FormtD3" scope="page" class="test.PieChart"/>  
<%	
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "意向需求" , 
                  "分析"
                ) ;
			
%>

<html>
<head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
	<title>诚意客户需求分析－－点击鼠标右键，选择打印输出</title>
</head>

<body>
 
<table width="100%">
<%
 
 String cus_type="";
 
 String state=getbyte1(request.getParameter("datastate"));
 if (state.equals("3"))state="";
 else  if (state.equals("2"))state=" and  zto=1  " ;
 else  if (state.equals("1"))state="  and zto=0  ";
 String section=getbyte2(request.getParameter("section"));
  if (!section.equals(""))section=" and section='"+section+"'";
int begin_year=0,begin_month=0;

 
 String Date1=getbyte1(request.getParameter("Date1"));
 String Date2=getbyte1(request.getParameter("Date2"));
 String dateWhere="";
 if (!Date1.equals("")&&Date2.equals(""))dateWhere="  and  convert(char(10),dengji_riqi,120) between >='"+Date1+"''"; 
 else  if (!Date2.equals("")&&!Date1.equals(""))dateWhere=" and  convert(char(10),dengji_riqi,120) between '"+Date1+"' and '"+Date2+"'"; 
 else    if (!Date2.equals("")&&Date1.equals(""))dateWhere=" and  convert(char(10),dengji_riqi,120)<='"+Date2+"'"; 
dateWhere+=state+section;
  

String[] codcenames=request.getParameterValues("codcename");
String codcename="";
if (codcenames!=null){
   for (int aa=0;aa<codcenames.length;aa++){
    if (codcename.equals(""))codcename=codcenames[aa];
	else codcename+=","+codcenames[aa];
  }
}
if (!codcename.equals("")){ 
String SecNo=getbyte1(request.getParameter("section")); 
 
try{
   String sql=""; 
   sql="select count(*),name,cus_name from View_Chenyi a,crm_project b where    a. Section='"+SecNo+"' "+dateWhere+"  and  a.section=b.SerialNo group by name ,cus_name";
   ResultSet rs=ViewBean.executeQuery(sql);
     int  num=0;
	 String projectname="";
	 String filename ="";
	while  (rs.next())
	
	{num++;
	projectname=rs.getString("name");
	}
	rs.close();
	 out.print("<p align=left><font size=5>楼盘名称："+projectname);
	out.print("&nbsp;&nbsp;&nbsp;&nbsp;调查人数:"+String.valueOf(num)+"");
     
	  String messtitle="客户来自区域分析";
 sql="select region nam,count(*) num from customer where section='"+SecNo+"' group by  region";
 
   String pic= FormtD3.drawToFile("D:/"+ request.getContextPath()+"/crmv9/jsp/picture/yxfxpic"+filename+".jpg",sql,messtitle);  
  if (!pic.equals(""))
    out.print("<img src='../picture/yxfxpic"+filename+".jpg'>");
	
	 
     sql="select  code,codename from CustomerDc  where code in ("+codcename+")";
     rs=ViewBean.executeQuery(sql);
	int jj=0;
	
   while (rs.next()){
        
          sql="select b.codevalue nam,count(*) num from customer_xq a ,CustomerDcValue b,View_Chenyi c where ";
	   
	     sql+=" a.xq_code=b.code and c.code=a.customer and b.dccode="+rs.getString("code")+dateWhere+" and c.Section='"+SecNo+"' group by b.codevalue  ";
       
	   if (jj==0)out.print("<tr>");
	   out.print("<td>");
	    Calendar calendar = Calendar.getInstance();
	     filename = String.valueOf(calendar.getTimeInMillis());	
	    messtitle=rs.getString("codename")+"市场调查分析";
	
        pic= FormtD3.drawToFile("D:/"+ request.getContextPath()+"/crmv9/jsp/picture/yxfxpic"+filename+".jpg",sql,messtitle);  
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