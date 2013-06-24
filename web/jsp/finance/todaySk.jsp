<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%> 
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="fa" scope="page" class="FormatData.FormatData"/> 
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<%@ include file="../public_js/CheckSection.jsp"%>

<%!
public String formatDateTime( java.sql.Timestamp dt ) throws Exception {
    if( dt == null ) {
        return "" ;
    }
    java.text.SimpleDateFormat f = new java.text.SimpleDateFormat( "yyyy-MM-dd" ) ;
    return f.format( dt ) ;
}
%>

 <%//String Cortrol=(String)session.getAttribute("popedomStr"); 
String Cortrol=checke_qx(aBean,(String)session.getAttribute("loginid"),"F002");

 %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>收款明细表</title>
<%
   ResultSet rs1 = fBean.executeQuery("SELECT substring(convert(char(24),getdate(),110),0,11) dd " ) ;
   String today="";
   if (rs1.next())today=rs1.getString("dd");
   rs1.close();
 
 %>
 <script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<form>
 <p align=center>
  <b> <font size=3>收款日报表</font></b>
 </p>
  
<table width="100%" border=0 cellspacing='0'  cellpadding='0' >
<tr><td width=80%>收款日期：<input type=input name=Date1 size=10 readonly value="" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date1);return false;">到<input type=input name=Date2 size=10 readonly value="" ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(Date2);return false;"><input type=submit name=dda value="查 找">
</td><td width=20% align=right> 打印日期:<%=today %> </td></tr></table>
<table width="100%" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000 >
    <tr  class=listtitle  align="center">
        <td> 序号 </td>
        <td> 房间代码 </td>
        <td> 客户姓名 </td>
	<td> 成交总价 </td>
	<td> 订金 </td>
         <td>首期款1 </td>
         <td>首期款2 </td>
         <td>首期款3 </td> 
           <td>首期款4 </td> 
    </tr>

    <%
     String FindDate=" ";
     String FindDate1=" ";
     String Date1=getbyte1(request.getParameter("Date1"));
     String Date2=getbyte1(request.getParameter("Date2"));
     if (Date1.equals("")&&Date2.equals("")){
        FindDate=" substring(convert(char(24),gather_date,120),1,10) =substring(convert(char(24),getdate(),120),1,10) ";
         FindDate1=" substring(convert(char(24),f.gather_date,120),1,10) =substring(convert(char(24),getdate(),120),1,10) )";
      }else{
      FindDate=" substring(convert(char(24),gather_date,120),1,10) >='"+Date1+"'  and substring(convert(char(24),gather_date,120),1,10) <=  '"+Date2+"' ";
      FindDate1=" substring(convert(char(24),f.gather_date,120),1,10) >= '"+Date1+"'  and substring(convert(char(24),f.gather_date,120),1,10) <= '"+Date2+"'";

      }
	 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql="select code from  order_contract where  section in ("+SectionS+") and state<>3 and code in (select contractno from factGatheringRecord where "+ FindDate;

      
    int i2 = 0 ;    
	 String gather_date ="";
	 int rowID=0;
    String FactCurry="";
	double sumfactmoney=0;
	 String FactCurryRate="";
   int num=0;
  List list1=new LinkedList();//存放编码
  List list2=new LinkedList();//存放状态
  List list3=new LinkedList();//存放状态
String sqn="-1";
         int n=0;

	
	
        String sq = " select o.code,o.loft+o.room_no roomno,c.cus_name,o.rmbprice   from customer c,order_contract o where o.state<>3 and o.customer=c.serialno and  o.section in ("+SectionS+") and o.code in (select contractno  from factGatheringRecord  where "+FindDate+")   order by o.code,o.loft+o.room_no";

 ResultSet rs = aBean.executeQuery( sq ) ;
        while( rs.next() ) {
	num++;
         String code= getbyte( rs.getString("code")) ;
 	 String roomno= getbyte( rs.getString( "roomno" ) ) ;
         String cus_name= getbyte( rs.getString( "cus_name" ) ) ;
	 String  sumrpice=fa.getFloat(rs.getFloat( "rmbprice" ),0) ;
		 
		
		 
    %>
        <tr  align=center  class=listcontent >
 
          <td><%= num%></td>
	  <td align=left><%= roomno %></td>
	  <td  align=left><%= cus_name %></td>
          <td  align=left><%= sumrpice %></td>
          <%
		  int aa=0;
		   String qs1="";
	       String qs2="";
           String qs3="";
	       String qs4="";
           String qs5="";
   
     
  
      String moneys[]=new String[5];
       rs1 = fBean.executeQuery("select contractno,period,sum(factmoney) factmoney  from factGatheringRecord  where "+FindDate +"  and contractno ="+code+" group by contractno,period order by   contractno,period") ;
     String exist="";
	 int dd=0;
	 while( rs1.next() ) {
	     exist="as";
          int nn=rs1.getInt("Period");
		  String mm=rs1.getString("factmoney");
		  moneys[nn]=mm;
		  dd++;
	  }	 
	    rs1.close();
	 for (int aaa=0;aaa<moneys.length;aaa++) {
	     if (moneys[aaa]==null)out.print("<td>&nbsp;</td>");
		 else  out.print("<td>"+moneys[aaa]+"</td>");
	  }
     		 
	 
   
 %> 
        </tr>
	
    <%}
       
 
 rs1 = fBean.executeQuery("select Period,sum(factmoney) factmoney from factGatheringRecord  where contractno in (select code from order_contract where state<>3  and section in ("+SectionS+") ) and  "+FindDate +" group by Period order by Period") ;
 String moneys1[]=new String[5];
String q1="",q2="",q3="",q4="",q5="";
	   
	 while( rs1.next() ) {
	 
          int nn=rs1.getInt("Period");
		  String mm=rs1.getString("factmoney");
		  moneys1[nn]=mm;
		  
	  }	 
	    rs1.close();
		
	
 
    %>
		 <tr bgcolor="#EBEBEB" align="center">
     <td colspan=2>
    <b>实收合计:</td><td >&nbsp;</td> <td >&nbsp; </td> 
	<%
	 for (int aaa=0;aaa<moneys1.length;aaa++) {
	     if (moneys1[aaa]==null)out.print("<td>&nbsp;</td>");
		 else  out.print("<td>"+moneys1[aaa]+"</td>");
	  }
	%>
	
    </tr>
    </table>
 

 </form>
 
</body>
</html>

