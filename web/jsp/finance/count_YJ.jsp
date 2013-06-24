<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>成交情况明细表</title>
 
</head>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
 

<body bgcolor="#FFFFFF" text="#000000">
<%
double yjRate=0;
double yjRate1=0;
double yjRate2=0;
double yjRate3=0;
  ResultSet   rs1 = ViewBean.executeQuery("select *  from commision_scale where  section_no='"+getbyte1(request.getParameter("section"))+"'") ; 
if (rs1.next()){
  yjRate=rs1.getDouble("scale")/1000;
  yjRate1=rs1.getDouble("deduct1")/100;
  yjRate2=rs1.getDouble("deduct2")/100;
  yjRate3=rs1.getDouble("deduct3")/100;
}
rs1.close(); 
 
%>
<%
 


String SQL="SELECT o.code,c.cus_name,o.loft+o.Room_no Room_no,o.jzarea,o.unitprice,o.RMBPrice/o.jzarea saleunitprice,o.RMBPrice,o.youhui,o.payment1,o.seller,o.introductive,o.SerialNo,o.date,o.subscription  from   Order_Contract o,customer c where o.section='"+getbyte1(request.getParameter("section"))+"' and c.serialno=o.customer and o.code not in(select contract_id from commisionCount)";
SQL+=" order by c.cus_name,o.payment1,o.seller,o.SerialNo ";
 double yjocunt=0;
try{
 ResultSet rs = ViewBean.executeQuery(SQL) ;
double yj1= 0;
double yj2=0;
double yj3=0; 
  int i=1;
  while (rs.next()){ 
    String code=getbyte(rs.getString("code").trim()) ;
	double salePrice=rs.getDouble("RMBPrice");
	String payment1=getbyte(rs.getString("payment1").trim()) ;
	String  seller=getbyte(rs.getString("seller").trim()) ;
	String introductive=getbyte(rs.getString("introductive").trim()) ;
yjocunt= salePrice*yjRate;
if (introductive.equals("0")){
   if (payment1.indexOf("揭")>=0){
  yj1= yjocunt*yjRate1 ;
 
  
  //y1+=salePrice*0.003*0.3;
  yj2=yjocunt*yjRate2 ;
  //y2+=salePrice*0.003*0.4;
  yj3=yjocunt*yjRate3;
  
 // y3+=salePrice*0.003*0.3;
  }else{
     yj1=yjocunt*yjRate1;
   //  y1+=salePrice*0.003*0.3;
     yj2=yjocunt*(yjRate2+yjRate3);
    // y2+=salePrice*0.003*0.7;

  

   }
}else{
  yj1=yjocunt*yjRate1*0.7;
  //y1+=salePrice*0.003*0.3*0.7;
  yj2= yjocunt*yjRate2*0.7;
   //y2+=salePrice*0.003*0.4*0.7;
  yj3=yjocunt*yjRate3*0.7;
   //y3+=salePrice*0.003*0.3*0.7;

}
	try{
	 
	}catch(Exception s){}
	SQL="INSERT INTO commisionCount(contract_id,seller,commision1,commision2,commision3,state) VALUES(";
	SQL+=code+",'"+seller+"',"+Format.getFloat3(yj1,0)+","+Format.getFloat3(yj2,0)+","+Format.getFloat3(yj3,0)+",0)";
	ViewBean1.executeUpdate(SQL) ;
  
   }
  rs.close(); 
  }catch(Exception s){out.print(s.getMessage()+SQL);}
  %>

</table>
<script>
alert("计算完成");
//close();
</script>
</body>
</html>
