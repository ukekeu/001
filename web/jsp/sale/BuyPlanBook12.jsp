<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<link rel=stylesheet href="../class/line.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>置业计划</title>
</head>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%!float TaxSum=0;
   int AjPrice=0;
   String code="";
   float SalePrice=0;
   String SaleArea="";
   float unitprice=0;
   String section="";
   String qtaxrate="0";
   String qtax="0";
   String aaaa="";
     String  money = "";
    String TaxName="";
      String yhtax="0"; 
	  String sqlstr1="";
	 int dkprice=0;
String custype="";
 double dssumprice=0;
 String prepay="";
 String ajcharges="";
 
 %>
<%!
	 public String  ShowTax(String sqlstr,String para) throws Exception  {
	  String SqlStr = sqlstr;
	  String  str="";
	  String state="";
   
	  int jjj=0;
	 ConnDatabase.SDatabase ViewBean1=new ConnDatabase.SDatabase();
	 ConnDatabase.SDatabase ViewBean2=new ConnDatabase.SDatabase();
	 ResultSet TaxRs1=null; 
	 ResultSet TaxRs = ViewBean1.executeQuery(SqlStr);
	 FormatData.FormatData formatD1=new FormatData.FormatData();
		
		  int id=0;
		while (TaxRs.next()) {
		    id = TaxRs.getInt("ID");
	     	money=formatD1.getFloat1(TaxRs.getFloat("money"),2);
	        String  termvalue=TaxRs.getString("termvalue");
		    String term=TaxRs.getString("term");
		    String  termvalue1=TaxRs.getString("termvalue1");
		    String term1=TaxRs.getString("term1");
		    TaxName = getbyte(TaxRs.getString("Tax_Name"));
			String tax_type= getbyte(TaxRs.getString("tax_type"));
		    state=TaxRs.getString("state").trim();
			String type1=TaxRs.getString("type1");
			String type3=getbyte(TaxRs.getString("type3"));	
			String type=getbyte(TaxRs.getString("type"));	
			if (para.trim().equals("0")&&type3.equals("1"))break;		 
			  
	        jjj++;
            str+="<tr  align='center' >";
            if (state.equals("1")){//按售价百分比计算
                String sql1="select  money*"+SalePrice+"/1000.0 aa1 from TaxChages where state=1 and  "+SalePrice+"/10000 "+term+ " termvalue  and "+SalePrice+"/10000"+term1+ "termvalue1  and id= "+id;
				money="";
				//sqlstr1=sql1;
				TaxRs1 = ViewBean2.executeQuery(sql1);
                double aa2=0;
			    if (TaxRs1.next()){
				   aa2=TaxRs1.getDouble("aa1");
				   dssumprice+=aa2;
				   money=formatD1.getFloat2(aa2,2);
				 }
				TaxRs1.close();
                if (!money.equals("")){
                   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
                   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
                   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
                    String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
					
					//ViewBean2.executeUpdate(Tsql);
					 
                }
          }else   if (state.equals("2")){//按固定金额计算
                if (!money.equals("")){
				  dssumprice+=Double.parseDouble(money);
				  str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
				   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
				   String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
				 sqlstr1=Tsql;
				  //ViewBean2.executeUpdate(Tsql);
				   }
   
         }else   if (state.equals("3")){//按购房面积计算
                  String sql1="select  money*"+SalePrice+"/1000.0 aa1 from TaxChages where state=3 and  "+SaleArea+""+term+ " termvalue  and "+SaleArea+""+term1+ "termvalue1 and id= "+id;
               //   sqlstr1=sql1;
				  TaxRs1 = ViewBean2.executeQuery(sql1);
 				  double aa2=0;
				  money="";
				  if (TaxRs1.next()){
				     aa2=TaxRs1.getDouble("aa1");
					 dssumprice+=aa2;
				     money=formatD1.getFloat2(aa2,2);
				  }
				 TaxRs1.close();
                 if (!money.equals("")){
				   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
				   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
				   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
				   String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
				   //ViewBean2.executeUpdate(Tsql);
				   
				}
       }else   if (state.equals("6"))//按户数计算
            {  if (!money.equals(""))dssumprice+=Double.parseDouble(money);
			    str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
			    str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
			    String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
			   sqlstr1=Tsql;
			  // ViewBean2.executeUpdate(Tsql);
			}
           else   if (state.equals("7"))//按按揭款计算
            {
              String sql1="select  money*"+AjPrice+"0000/1000.0 aa1 from TaxChages where state=5 and  "+AjPrice+" "+term+ " termvalue  and "+AjPrice+""+term1+ "termvalue1 and id= "+id;
            //  sqlstr1=sql1;
			 TaxRs1 = ViewBean2.executeQuery(sql1);
             money="";
             double aa2=0;
			 if (TaxRs1.next()){
			   aa2=TaxRs1.getFloat("aa1");
			   dssumprice+=aa2;
			   money=formatD1.getFloat2(aa2,2);
			  }
			 TaxRs1.close();
			 if (!money.equals("")){
			   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
			   state=TaxName;
			  
			   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
			   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
			   String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
			  // ViewBean2.executeUpdate(Tsql);
			  }
      }else   if (state.equals("4"))//按面积计算
          {
            String sql1="select  money  aa1 from TaxChages where state=4 and  "+SaleArea+" "+term+ " termvalue  and "+SaleArea+""+term1+ "termvalue1 and id= "+id;
          //  sqlstr1=sql1;
		    TaxRs1 = ViewBean2.executeQuery(sql1);
		    money="";
			double aa2=0;
		   if (TaxRs1.next()){
		     aa2=TaxRs1.getDouble("aa1");
			 dssumprice+=aa2;
		     money=formatD1.getFloat2(aa2,2);
		   }
		  TaxRs1.close();
		  if (!money.equals("")){
		   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
		   state=TaxName;
		   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
		   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
		   String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
		  // ViewBean2.executeUpdate(Tsql);
		  
		}
    }else   if (state.equals("5"))//按面积计算
       {
         String sql1="select  money*"+SaleArea+"  aa1 from TaxChages where state=5 and  "+SaleArea+" "+term+ " termvalue  and "+SaleArea+""+term1+ "termvalue1 and id= "+id;
    	
		 TaxRs1 = ViewBean2.executeQuery(sql1);
		 money="";
	 	 double aa2=0;
		 if (TaxRs1.next()){
		   aa2=TaxRs1.getDouble("aa1");
		    dssumprice+=aa2;
		   money=formatD1.getFloat2(aa2,2);
		  }
		 TaxRs1.close();
		 if (!money.equals("")){
		   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
		  state=TaxName;
		  str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
		  str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
		  String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
		 sqlstr1="<br>"+Tsql+"<br><br>";
		//ViewBean2.executeUpdate(Tsql);
		 
		  }
   }else   if (state.equals("8"))//按单价计算
    {
       String sql1="select  money*"+SalePrice+"0000/1000.0 aa1 from TaxChages where state=8 and  "+unitprice+" "+term+ " termvalue  and "+unitprice+""+term1+ "termvalue1 and id= "+id;
     // sqlstr1=sql1;
	  TaxRs1 = ViewBean2.executeQuery(sql1);
	  money="";
      double aa2=0;
	  if (TaxRs1.next()){
	   aa2=TaxRs1.getDouble("aa1");
	   dssumprice+=aa2;
	   money=formatD1.getFloat2(aa2,2);
	  }
	 TaxRs1.close();
	 
	 if (!money.equals("")){
	 
	   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
	   state=TaxName;
	   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
	   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
	   String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
	   //ViewBean2.executeUpdate(Tsql);
	   
	  }
     }
	
  str+="</tr>";
  
 }
 TaxRs.close();

return str;
}

%>
<body>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>

<form name=cus method=POST ACTION="">
  <script>
  function countzk(para){
 
   if (para=="")document.cus.zhj.value=parseInt(document.cus.zj.value)*parseFloat(document.cus.yzk.value)/100 ;
else document.cus.zhj.value=parseInt(document.cus.zj.value)*parseFloat(para)/100;
  
  }
  
  </script>
 
<center>
<input type=hidden name=Floor value="<%=request.getParameter("Floor") %>">
<p align="center"><b><font size=7><%=China.getParameter(request,"SECNAME") %>置业计划</font></b></p>
<p align="center">&nbsp;</p>
 <table border="0" width="98%">

  <tr>
    <td width="98%">姓名：<u>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; </u> 先生/小姐</td> 
  </tr>
    <tr>
    <td width="98%">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;</td> 
  </tr>
  <tr>
    <td width="98%">
	 单位:&nbsp;<U>&nbsp;&nbsp;&nbsp;<%=China.getParameter(request,"LOFT") %>&nbsp;<%=China.getParameter(request,"build") %>
    </td>
 </tr>
 <tr>
    <td width="98%">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;</td> 
  </tr>
 <tr><td align="center"> 
  建筑面积：<U>&nbsp;&nbsp;&nbsp;<%=request.getParameter("JZAREA")%>&nbsp;&nbsp;&nbsp;</u>平方米,套内建筑面积:<U>&nbsp;&nbsp;&nbsp;<%=request.getParameter("USERAREA")%>&nbsp;&nbsp;&nbsp;</u>平方米
      </td>
 </tr>
<tr>
    <td width="98%" align="center">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;</td> 
</tr> 
	  <tr><td align="center">定价：RMB:<U>&nbsp;&nbsp;&nbsp; <%=request.getParameter("UNITPRICE")%>&nbsp;&nbsp;&nbsp; </u> 元/M<sup>2</sup>&nbsp;, 总楼价：RMB:<input type=text name=zj class=unnamed1  size=15   value=<%=request.getParameter("SUMPRICE")%>>元</td>
  </tr>
</table>
<br> 
 
<%
 
String  paylist=China.getParameter(request,"print1");
prepay=paylist;

SaleArea=request.getParameter("JZAREA");
String SumPrice=request.getParameter("SUMPRICE");
String CheckTax=request.getParameter("tax");
String Type=request.getParameter("ajtype");
String year=request.getParameter("year");
String yongtu=getbyte1(request.getParameter("yongtu"));
String section=request.getParameter("section");
String ykc=getbyte1(request.getParameter("ykc"));
if (ykc.equals(""))ykc="0";

String StrList="";
String StrPayName="";
String StrPayNum="";
String StrDisc="";
String PayId="";

paylist=paylist.substring(paylist.indexOf(prepay.substring(prepay.lastIndexOf("A")+1)));
if (paylist.indexOf("/")>=0){
paylist=paylist.substring(0,paylist.indexOf("/"));
}
StringTokenizer st22 = new StringTokenizer(paylist,"/") ;

 
int count22 = st22.countTokens() ;

String[] sellers22 = new String[count22] ;
int j22 = 0 ;
String pay="";
String DisPrice="";

try{
while (st22.hasMoreElements()) {
   
    pay=(String)st22.nextElement();
    StrList=pay;
	//if (StrList.indexOf("揭")>=0)out.print(StrList)

	PayId=StrList.substring(StrList.lastIndexOf("*")+1);
    StrPayName=StrList.substring(0,StrList.indexOf("-"));
	StrDisc=StrList.substring(StrList.indexOf("-")+1,StrList.lastIndexOf("-"));
	StrPayNum=StrList.substring(StrList.lastIndexOf("-")+1,StrList.indexOf("*"));
 
SalePrice=Float.parseFloat(SumPrice)*Float.parseFloat(StrDisc)/100;
out.print("<input type=hidden name=yzk value="+StrDisc+">");

	if (prepay.indexOf("揭")<0){
 %>

  <table BORDER=0 width="98%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >
  <tr ><td colspan=3>付款方式：<u>&nbsp;&nbsp;&nbsp;&nbsp;<% out.print(prepay.substring(prepay.lastIndexOf("A")+1,prepay.indexOf("-")));%>&nbsp;&nbsp;&nbsp;&nbsp;</u>额外折扣:<input type=text name=zk class=unnamed1  onblur="countzk(this.value);" size=15 >%</td>
  </tr>
  <tr><td colspan=3>&nbsp;</td></tr>
  <tr>
  <td align=left>折后总价:<input type=text name=zhj class=unnamed1  size=15 value=<%=SalePrice%>>元</td><td align=left></td>
  </tr>
  <tr><td colspan=3>&nbsp;</td></tr>
  <tr>

  <td align=left>定金:<U>&nbsp;&nbsp;&nbsp;&nbsp; <%=prepay.substring(prepay.indexOf("A")+1,prepay.lastIndexOf("A"))%>&nbsp;&nbsp;&nbsp;&nbsp;</u></td><td align=left></td>
  </tr>
  <tr>
  <td colspan=6> 
    <jsp:include page="PayListView.jsp" flush="true">
     <jsp:param name="code" value="<%=PayId%>"/>
	  <jsp:param name="paynum" value="<%=StrPayNum%>"/>
     <jsp:param name="payname" value="<%=StrPayName%>"/>
	 <jsp:param name="count" value="list"/>
	  <jsp:param name="SaleSumPrice" value="<%=SalePrice %>"/>
  </jsp:include> 
  </td>
  </tr>
  </table>
   
<br>
<%@ include file="../public_js/Repalce.jsp"%>
<%

}else{%>
  <table BORDER=0 width="98%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >
  <tr ><td colspan=3>付款方式:<u>&nbsp;&nbsp;&nbsp;
  <%
 
  String cs=StrPayName.substring(StrPayName.indexOf("(")+1,StrPayName.indexOf("成"));//贷款成数
   StrPayName=StrPayName.substring(StrPayName.lastIndexOf("A")+1);
   out.print(StrPayName.substring(0,StrPayName.indexOf("揭")+1));
    %>&nbsp;&nbsp;&nbsp;</u>额外折扣:<input type=text name=zk class=unnamed1  onblur="countzk(this.value);" >%</td>
  </tr>  <%
 
  float sumprice=0;
 
  try{
  sumprice= Float.parseFloat(SumPrice)*Float.parseFloat(StrDisc)/10;

  }catch(Exception s){out.println(s.getMessage());out.close();}
   %>
  

  <%
  int row=0;
  try{
  row= Integer.parseInt(StrPayNum)+2;
  }catch(Exception s){out.println(s.getMessage());}
   %>
 <tr>
 <%String SQL="SELECT MonthPay FROM  AjLlGkB WHERE yong_tu=0  and TYPE='"+request.getParameter("dktype")+"' AND year="+year;
 
 float ajprice=SalePrice*Float.parseFloat(cs)/100;
 String StrPay=China.getParameter(request,"StrPayName");
 
 ajcharges=China.getParameter(request,StrPay+cs+"b"+year+"b"+StrPayNum);
  int dkprice=(int)ajprice/10000;
 AjPrice=dkprice; 
 String StrPrice=String.valueOf(ajprice/10000);
 float firstprice=SalePrice-dkprice*10000;
 ResultSet rs=null;
 float MonthPay=0;
 try{
  rs=ViewBean.executeQuery(SQL);
  if (rs.next()){
    MonthPay=rs.getFloat("MonthPay");
  }
   rs.close();
  }catch(Exception s){out.println(s.getMessage());}
 
  %>
 <tr><td colspan=3>&nbsp;</td></tr>
  <tr>
  <td align=left>折后总价: <input type=text name=zhj class=unnamed1   value=<%=SalePrice%>>元</td><td align=left></td>
  </tr>
  <tr><td colspan=3>&nbsp;</td></tr>
  <tr>
  <%prepay=prepay.substring(prepay.indexOf("A")+1,prepay.lastIndexOf("A")); %>
  <td align=left>定金:<U>&nbsp;&nbsp;&nbsp;&nbsp; <%=prepay%>&nbsp;&nbsp;&nbsp;&nbsp;</u>元</td><td align=left></td>
  </tr>
  <tr><td colspan=3>&nbsp;</td></tr>
  <tr><td colspan=3>&nbsp;</td></tr>
   <tr><td colspan=3>&nbsp;</td></tr>
  
    <jsp:include page="PayListView2.jsp" flush="true">
     <jsp:param name="code" value="<%=PayId%>"/>
	  <jsp:param name="paynum" value="<%=StrPayNum%>"/>
     <jsp:param name="payname" value="<%=StrPayName%>"/>
	 <jsp:param name="count" value="list"/>
	  <jsp:param name="ykc" value="<%=ykc %>"/>
	 <jsp:param name="SaleSumPrice" value="<%=SalePrice %>"/>
	 
	 
  </jsp:include>

  <%
  //if (prepay.indexOf("揭")>=0){
   %>
   
   <%//} %>
  </table>
  <%
  String bxStr = "select * from insurance_rate where insurance_year="+year;//where id >=" + String.valueOf(firstPos);
	float bxrate=0;
	float bxcharges=0;
	String bxyear="";
	int bxyear1=0;
	
	ResultSet bxRS =ViewBean.executeQuery(bxStr);	
	
	while (bxRS.next()) {// && i < pageSize)
         bxyear=getbyte(bxRS.getString("insurance_year"));
		 bxcharges=bxRS.getFloat("insurance_rate")*SalePrice/(100*Float.parseFloat(bxyear));
	 }
	 bxRS.close();
   %>
 <table width="98%" border="0" cellpadding="1" cellspacing="1">
   <tr>
       <td align=left width="49%">按揭款:<u>&nbsp;<%=FormatD.getFloat(dkprice*10000,0) %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u>元</td>
       <td align=left width="49%">按揭年限:<u>&nbsp;<%=year %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u>年</td>
   </tr>
    <tr><td>&nbsp;</td></tr>
   
   <tr>
    
       <td align=left width="49%">月供款:<u>&nbsp;<%=FormatD.getFloat(Float.parseFloat(ajcharges.substring(ajcharges.indexOf("|")+1)),2) %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u>元 </td>
   <td align=left width="49%"></td>
   </tr>
</table>
 

<%
 }
}
 }catch(Exception s){out.println(s.getMessage());}
 %> 
     
<table  width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF"> 
	<tr><td colspan="2" align="center">代收税费及配套费明细表</td></tr>

<%if (StrPayName.indexOf("按揭")>=0){

  
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	       out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	  
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 

	
	  // } else{
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
		
	 //if (custype.equals("0")){
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
		// out.print("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')");
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
 
		 	
   	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype")));
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype")));
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype")));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype")));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype")));
    // out.print("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')");
	

		//}else{
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
	      out.print( ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));

		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有'  and section='"+section+"')",request.getParameter("saletype"))); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有'  and section='"+section+"')",request.getParameter("saletype"))); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有'  and section='"+section+"')",request.getParameter("saletype")));
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有'  and section='"+section+"')",request.getParameter("saletype")));
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有'  and section='"+section+"')",request.getParameter("saletype")));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有'  and section='"+section+"')",request.getParameter("saletype")));
         out.print( ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有'  and section='"+section+"')",request.getParameter("saletype")));
    

   
}else{

  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	   
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	     
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=0 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 

	 
	  // } else{
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=1 and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 

	 
	 //if (custype.equals("0")){
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
		// out.print("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')");
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
 
		 	
   	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype")));
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype")));
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype")));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype")));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype")));
    // out.print("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=0 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')");
	
		//}else{
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
	      out.print( ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));

		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有'  and section='"+section+"')",request.getParameter("saletype"))); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有'  and section='"+section+"')",request.getParameter("saletype"))); 
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有'  and section='"+section+"')",request.getParameter("saletype")));
		  out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有'  and section='"+section+"')",request.getParameter("saletype")));
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有'  and section='"+section+"')",request.getParameter("saletype")));
          out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有'  and section='"+section+"')",request.getParameter("saletype")));
         out.print( ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type=1 and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有'  and section='"+section+"')",request.getParameter("saletype")));
   
	
	 %>
	  <%} %>
	 <tr><td>合计:</td> <td><%=FormatD.getFloat3(dssumprice,2) %></td></tr>
	 <%dssumprice=0; %>
 
 </table>	
业主应付按揭贷款的有关费用： 
	<%String SQLBX="select insurance_rate, insurance_year from insurance_rate where insurance_year="+year; 
	  ResultSet bx= ViewBean.executeQuery(SQLBX);
	  float bxrate=0;
	  if (bx.next())bxrate=bx.getFloat("insurance_rate");
	  bx.close();
	
	
	 %>
	 <table  width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF"> 
  <tr > 
  <td>保险费</td><td>公证费</td><td>抵押登记费</td><td>开户费</td></tr>
   <tr > 
  <td><%=FormatD.getFloat3(SalePrice*bxrate/1000,2) %></td><td><%=AjPrice*10000*2.0/1000 %></td><td>60</td><td>10</td></tr>
  </table>
 <br><br>
 <table BORDER=0 width="98%" CELLSPACING=1 CELLPADDING=1 align=left>
   <tr>
       <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td >&nbsp;</td>
       <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
   </tr>
    <tr>
       <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td >&nbsp;</td>
       <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>置业顾问:<input type=text name=gw class=unnamed1 ></td>
   </tr>
   <tr>
       <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td >&nbsp;</td>
       <td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>联系电话:<input type=text name=tel class=unnamed1 ></td>
   </tr>
</table>
 
</center>

</FORM>
 <br><br> <br>
  <br><br>
  <p align="center"><b><font size=3><%=China.getParameter(request,"SECNAME") %>现场售楼处电话：<input type=text name=lx class=unnamed1 ></font></b>

<div id=printdiv align="center">


<input type=button name=print value="打印置业计划书" onclick="printall();">
</div>
   
<script>
			function printall() {
			   	printdiv.innerText ="";
                 print(); 
			}
</script>
</body>

</html>
