<%@ page contentType="text/html;charset=GBK" %>

 
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
 
<title>确认导出凭证</title>
 
</head>
 <%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/checktime.jsp"%>
 
<% 
 
 
  String  [] sendto=request.getParameterValues("v");
 
 
  String id="";
try{
  if (sendto!=null){
  
  for (int a=0;a<sendto.length;a++){
       if (id.equals(""))  id=getbyte1(sendto[a]);
	   else id+=","+getbyte1(sendto[a]);
   }
  }
   
}catch(Exception s){out.print(s);}	   
    String sql=""; 
   sql="select    c.id,a.sectionname+a.loft+a.room_no as room,b.cus_name,c.factmoney,c.factmoney*c.CurrRate as rmbmoney,c.CurrRate,c.CurrName,c.Gather_Date,month(c.Gather_Date) as s_month,c.Receiver,c.PayType from order_contract a,customer b,factgatheringrecord c  where c.checkstate=1 and c.v=0 and  c.contractno=a.code and a.customer=b.serialno and  a.state<>3 and c.ID in ("+id+")";
   
  ResultSet rs=null;
   int nn=0,i=1;
   double sump=0;
   double suma=0;
   double suml=0;
   double sum2=0;
   double sum3=0;
   double sum4=0;
   double sum5=0;
  try{
  	rs=ViewBean.executeQuery(sql);

	while (rs.next()){ 
       sql="insert into KDNormal(FDATE,FTRANSDATE,FPERIOD,FEXP,FACCTID,FCYID,FEXCHRATE,FDC,FFCYAMT,FQTY,FPRICE,FDEBIT,FCREDIT,FPREPARE) values(";
	  sql+="'"+rs.getDate("Gather_Date").toString()+"','"+rs.getDate("Gather_Date").toString()+"',"+rs.getString("s_month")+",'"+rs.getString("room")+rs.getString("cus_name");
	  String pay=getbyte(rs.getString("PayType"));
	  if (pay.equals("现金"))
	   sql+="现金','1001','";
	  else
	    sql+="银行存款','1002','";
		
		
	
	 sql+=getbyte(rs.getString("CurrName"))+"',"+getbyte(rs.getString("CurrRate"));
	 	 
	 sql+=",1,"+getbyte(rs.getString("factmoney"))+",1,"+getbyte(rs.getString("rmbmoney"));
	 double factm=0;
	 factm=rs.getDouble("factmoney");
	 if (factm>=0)
	  sql+=","+getbyte(rs.getString("factmoney"))+",0";
	else
	  sql+=",0,"+getbyte(rs.getString("factmoney"));
	  sql+=",'"+ getbyte(rs.getString("Receiver"))+"'";
	  sql+=")";
	  ViewBean1.executeUpdate(sql);
	   ViewBean1.executeUpdate("update factgatheringrecord set v=1 where id="+rs.getString("id"));
	}
	rs.close();
	
	
  }catch(Exception s){out.print(s);}	
  
 %>
<script>
window.location="v_view.jsp";
</script>
  
 
 
</body>
 
</html>
