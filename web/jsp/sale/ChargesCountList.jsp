<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta  http-equiv="Expires" content="-1">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>选房计价</title>
</head>
<%@ page language="java" import="java.sql.*,java.util.*"%>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginname" ) ,
                  "选房计价" , 
                  "试算"
                ) ;
%>
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
String buildtype="";
 String tnarea="";
 String tnunitprice="";
 String jzunitprice="";
 double dssumprice=0;
 %>
<%!
	 public String  ShowTax(String sqlstr,String para) throws Exception  {
	  String SqlStr = sqlstr;
	  String  str="";
	  String state="";
      String aaaa="";
	  int jjj=0;
	 ConnDatabase.SDatabase ViewBean1=new ConnDatabase.SDatabase();
	 ConnDatabase.SDatabase ViewBean2=new ConnDatabase.SDatabase();
	 ResultSet TaxRs1=null; 
	 ResultSet TaxRs = ViewBean1.executeQuery(SqlStr);
	 FormatData.FormatData formatD1=new FormatData.FormatData();
		
		  int id=0;
		while (TaxRs.next()) {
		    id = TaxRs.getInt("ID");
	     	money=formatD1.getFloat3(TaxRs.getDouble("money"),3);
	        String  termvalue=TaxRs.getString("termvalue");
		    String term=TaxRs.getString("term");
		    String  termvalue1=TaxRs.getString("termvalue1");
		    String term1=TaxRs.getString("term1");
			String money1=formatD1.getFloat3(TaxRs.getDouble("money1"),2);
	        String  termvalue2=TaxRs.getString("termvalue2");
		    String term2=TaxRs.getString("term2");
		    String  termvalue3=TaxRs.getString("termvalue3");
		    String term3=TaxRs.getString("term3");
			
		    TaxName = getbyte(TaxRs.getString("Tax_Name"));
			String tax_type= getbyte(TaxRs.getString("tax_type"));
		    state=TaxRs.getString("state").trim();
			  aaaa=state;
			String type1=TaxRs.getString("type1");
			String type3=getbyte(TaxRs.getString("type3"));	
			String type=getbyte(TaxRs.getString("type"));	
			String type2=getbyte(TaxRs.getString("type2"));	
			if (para.trim().equals("0")&&type3.equals("1"))break;		 
			  if (TaxName.indexOf("契税")>=0){
			 qtaxrate=money;
			}
	        jjj++;
            str+="<tr  align='center' class=listcontent>";
            if (state.equals("1")){//按售价百分比计算
                String sql1="select  money*"+SalePrice+"/1000.0 aa1 from TaxChages where state=1 and  "+SalePrice+"/10000 "+term+ " termvalue  and "+SalePrice+"/10000"+term1+ "termvalue1  and id= "+id;
				money="";
				TaxRs1 = ViewBean2.executeQuery(sql1);
                double aa2=0;
			    if (TaxRs1.next()){
				   aa2=TaxRs1.getDouble("aa1");
				   money=formatD1.getFloat3(aa2,2);
				 }dssumprice+=Double.parseDouble(money);
				TaxRs1.close();
                if (!money.equals("")){
                   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
                   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
                   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
                    String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
				 
                }
          }else   if (state.equals("2")){//按固定金额计算
                if (!money.equals("")){
				 dssumprice+=Double.parseDouble(money);
				  str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
				   str+="<td align=left>&nbsp;&nbsp;"+formatD1.getFloat3(Double.parseDouble(money),2)+"元&nbsp;</td>";
				   String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
			 
				   }
   
         }else   if (state.equals("3")){//按购房面积计算
                  String sql1="select  money*"+SalePrice+"/1000.0 aa1 from TaxChages where state=3 and  "+SaleArea+""+term+ " termvalue  and "+SaleArea+""+term1+ "termvalue1 and id= "+id;
                  TaxRs1 = ViewBean2.executeQuery(sql1);
 				  double aa2=0;
				  money="";
				  if (TaxRs1.next()){
				     aa2=TaxRs1.getDouble("aa1");
				     money=formatD1.getFloat3(aa2,2);
				  } dssumprice+=Double.parseDouble(money);
				 TaxRs1.close();
                 if (!money.equals("")){
				   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
				   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
				   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
				   String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
			 
				}
       }else   if (state.equals("6"))//按户数计算
            {
			    str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
			    str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
			    String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
			  
			}
           else   if (state.equals("7"))//按按揭款计算
            {
              String sql1="select  money*"+AjPrice+"0000/1000.0 aa1 from TaxChages where state=5 and  "+AjPrice+" "+term+ " termvalue  and "+AjPrice+""+term1+ "termvalue1 and id= "+id;
             TaxRs1 = ViewBean2.executeQuery(sql1);
             money="";
             double aa2=0;
			 if (TaxRs1.next()){
			   aa2=TaxRs1.getDouble("aa1");
			   money=formatD1.getFloat3(aa2,2);
			  } dssumprice+=Double.parseDouble(money);
			 TaxRs1.close();
			 if (!money.equals("")){
			   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
			   state=TaxName;
			   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
			   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
			   String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
			  
			  }
      }else   if (state.equals("4"))//按面积计算
          {
            String sql1="select  money  aa1 from TaxChages where state=4 and  "+SaleArea+" "+term+ " termvalue  and "+SaleArea+""+term1+ "termvalue1 and id= "+id;
            sqlstr1=sql1;
		    TaxRs1 = ViewBean2.executeQuery(sql1);
		    money="";
			double aa2=0;
		   if (TaxRs1.next()){
		     aa2=TaxRs1.getDouble("aa1");
		     money=formatD1.getFloat3(aa2,2);
		   }
		   dssumprice+=Double.parseDouble(money);
		  TaxRs1.close();
		  if (!money.equals("")){
		   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
		   state=TaxName;
		   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
		   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
		   String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
		 
		}
    }else   if (state.equals("5"))//按面积计算
       {
         String sql1="select  money*"+SaleArea+"  aa1 from TaxChages where state=5 and  "+SaleArea+" "+term+ " termvalue  and "+SaleArea+""+term1+ "termvalue1 and id= "+id;
    	 TaxRs1 = ViewBean2.executeQuery(sql1);
		 money="";
	 	 double aa2=0;
		 if (TaxRs1.next()){
		   aa2=TaxRs1.getDouble("aa1");
		   money=formatD1.getFloat3(aa2,2);
		  } dssumprice+=Double.parseDouble(money);
		 TaxRs1.close();
		 if (!money.equals("")){
		   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
		  state=TaxName;
		  str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
		  str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
		  String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
	 
		  }
   }else   if (state.equals("8"))//按单价计算
    {
       String sql1="select money, money*1.0/1000*"+SalePrice+" aa1 from TaxChages where state=8 and  "+unitprice+" "+term+ " termvalue  and "+unitprice+""+term1+ "termvalue1 and id= "+id;
        sqlstr1=sql1;
	  TaxRs1 = ViewBean2.executeQuery(sql1);
	  money="";
      double aa2=0;
	  if (TaxRs1.next()){
	   aa2=TaxRs1.getDouble("aa1");
	   sqlstr1=TaxRs1.getString("money");
	   money=formatD1.getFloat3(aa2,2);
	   //sqlstr1=String.valueOf(state);
	}   dssumprice+=Double.parseDouble(money);
	 TaxRs1.close();
	 if (!money.equals("")){
	   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
	   state=TaxName;
	   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
	   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
	   String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
	    sqlstr1=Tsql;
	 
	  }
	  }else   if (state.equals("9"))//按单价计算
    {
       String sql1="select case when ("+tnarea+term+termvalue+"  and  "+tnunitprice+term1+termvalue1+"   ) or ("+SaleArea+term2+termvalue2+"  and   "+jzunitprice+term3+termvalue3+") then  "+money+"*1.0/100* "+SalePrice+" else  "+money1+"*1.0/100* "+SalePrice+" end  aa1 ";
      sqlstr1=sql1;
	  TaxRs1 = ViewBean2.executeQuery(sql1);
	  money="";
      double aa2=0;
	  if (TaxRs1.next()){
	   aa2=TaxRs1.getDouble("aa1");
	   money=formatD1.getFloat3(aa2,2);
	  } dssumprice+=Double.parseDouble(money);
	 TaxRs1.close();  
	 if (!money.equals("")){
	   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
	   state=TaxName;
	   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
	   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
	   String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
	 
	  }
     }
  str+="</tr>";
 }
 TaxRs.close();
 
return str;
}
 %>
<script>
  function checkChoose(){
   //var len=document.cus.print1.length;
   var valueFT=false;
   for (i=0;i<document.cus.elements.length;i++) {
       if ((document.cus.elements[i].type=="radio")&&(document.cus.elements[i].checked)&&(document.cus.elements[i].name=='print1'))
		 {  
			valueFT=true;
   		 }
	  }	
   
   if (valueFT) document.cus.submit();
   else alert("请选择一种付款方式");
  }
  function full(){
  
   v1.innerHTML=opener.document.cus.SECNAME.value;
   document.cus.SECNAME.value=opener.document.cus.SECNAME.value;
   document.cus.LOFT.value=opener.document.cus.LOFT.value;
   v2.innerHTML=opener.document.cus.LOFT.value;

   document.cus.JZAREA.value=opener.document.cus.JZAREA.value;
   v5.innerHTML=opener.document.cus.JZAREA.value+"M2";
   document.cus.USERAREA.value=opener.document.cus.USERAREA.value;
   v6.innerHTML=opener.document.cus.USERAREA.value+"M2";
     
   document.cus.ROOMTYPE.value=opener.document.cus.ROOMTYPE.value;
   v7.innerHTML=opener.document.cus.ROOMTYPE.value;
   document.cus.CX.value=opener.document.cus.CX.value;
   v8.innerHTML=opener.document.cus.CX.value;
   document.cus.UNITPRICE.value=opener.document.cus.UNITPRICE.value;
   v9.innerHTML=opener.document.cus.UNITPRICE.value;
   document.cus.SUMPRICE.value=opener.document.cus.SUMPRICE.value;
   v10.innerHTML=opener.document.cus.SUMPRICE.value;
  
   document.cus.Floor.value=opener.document.cus.Floor.value;
 
  }
  function pr_plan(para1,para2){
	openwin("print_dk_plan.jsp?year="+para1+"&dkmoney="+para2);
	
	
	}
</script>
<body ONLOAD="full();">
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>

<form name=cus method=POST ACTION="BuyPlanBook12.jsp?section=<%=request.getParameter("section") %>">
<p align=center><font size=3 class=FontColor><b>房间基本资料</b></p>
<center>
 <table  width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF"> 

 <tr align="center">
 <td   >&nbsp;楼盘名称</td>
 <td  align="left"><div id=v1></div><input type="hidden"  name="SECNAME" size="15" style="border-style: solid; border-width: 1">
 </td>
 <td  >&nbsp;房&nbsp;&nbsp;&nbsp;&nbsp;号</td>
 <td  align="left"><div id=v2></div><input type="hidden"  name="LOFT" size="15" style="border-style: solid; border-width: 1">
 </td>
 </tr>
 <input type=hidden name=StrPayName  >
 <tr align="center">
 <td  >&nbsp;建筑面积</td>
 <td  align="left"><div id=v5></div><input type="hidden" name="JZAREA"  size="13" style="border-style: solid; border-width: 1">
 <td  >&nbsp;套内面积</td>
 <td  align="left"><div id=v6></div><input type="hidden" name="USERAREA"  size="13" style="border-style: solid; border-width: 1"> 
 </td>
 </tr>
<tr align="center">
 <td  >&nbsp;户&nbsp;&nbsp;&nbsp;&nbsp;型</td>
 <td  align="left"><div id=v7></div><input type="hidden" name="ROOMTYPE" size="13" style="border-style: solid; border-width: 1">
 <td  >&nbsp;朝&nbsp;&nbsp;&nbsp;&nbsp;向</td>
 <td  align="left"><div id=v8></div><input type="hidden" name="CX"  size="13" style="border-style: solid; border-width: 1">
 </td>
 </tr>

<tr align="center">
 <td  >&nbsp;单&nbsp;&nbsp;&nbsp;&nbsp;价</td>
 <td  align="left"><div id=v9></div><input type="hidden" name="UNITPRICE"  size="9" style="border-style: solid; border-width: 1"> 
 <td  >&nbsp;总&nbsp;&nbsp;&nbsp;&nbsp;价</td>
 <td  align="left"><div id=v10></div><input type="hidden" name="SUMPRICE" size="13" style="border-style: solid; border-width: 1">
 </td>
 </tr>
</table>

<input type=hidden name=dktype value="<%=request.getParameter("dktype") %>">
<input type=hidden name=Floor>
<input type=hidden name=section value="<%=request.getParameter("section") %>">
<input type=hidden name=yongtu  value="<%=getbyte2(request.getParameter("yongtu")) %>">
<input type=hidden name=paylist value="<%=getbyte2(request.getParameter("paylist")) %>">
<input type=hidden name=tax value="<%=request.getParameter("tax") %>">
<input type=hidden name=ajtype value="<%=request.getParameter("ajtype") %>">
<input type=hidden name=year value="<%=request.getParameter("year") %>">
<input type=hidden name=saletype value="<%=request.getParameter("saletype") %>">
<input type=hidden name=custype value="<%=request.getParameter("custype") %>">
<p align=center><font size=3 class=FontColor>价格试算结果<b></p>

<%
String yongtu=getbyte2(request.getParameter("yongtu"));
section=request.getParameter("section");
String  paylist=getbyte2(request.getParameter("paylist"));
String SumPrice=request.getParameter("sumprice");
String CheckTax=request.getParameter("tax");
String Type=request.getParameter("ajtype");
String year=request.getParameter("year");
  custype=request.getParameter("custype");
String dktype =request.getParameter("dktype");
SaleArea =request.getParameter("SaleArea");
tnarea =request.getParameter("tnarea");
tnunitprice=request.getParameter("tnunitprice");
jzunitprice=request.getParameter("unitprice");
String StrList="";
String StrPayName="";
String StrPayNum="";
String StrDisc="";
String PayId="";

StringTokenizer st22 = new StringTokenizer(paylist,"/") ;
int count22 = st22.countTokens() ;
String[] sellers22 = new String[count22] ;
int j22 = 0 ;
String pay="";
int NUM=0;
String prepay="";
String youhui="0";
try{
while (st22.hasMoreElements()) {
   NUM++;
    pay=(String)st22.nextElement();
    StrList=pay;
	youhui=StrList.substring(StrList.lastIndexOf("*")+1,StrList.indexOf("|"));
	
	PayId=StrList.substring(StrList.lastIndexOf("|")+1);
    StrPayName=StrList.substring(StrList.lastIndexOf("A")+1,StrList.indexOf("-"));
	StrDisc=StrList.substring(StrList.indexOf("-")+1,StrList.lastIndexOf("-"));
	StrPayNum=StrList.substring(StrList.lastIndexOf("-")+1,StrList.indexOf("*"));
    prepay=StrList.substring(0,StrList.lastIndexOf("A"))+"A"+StrPayName;

SalePrice=(Float.parseFloat(SumPrice)-Float.parseFloat(youhui))*Float.parseFloat(StrDisc)/100;

if (!CheckTax.equals(""))
{
  String A1="select id,code,money,termvalue,term,state from TaxChages where code  in (select Code from tax where  section='"+section+"')";
//out.print(ShowTax(A1));
//   TaxSum=Float.parseFloat(ShowTax(A1,out));
}

	if (StrList.indexOf("揭")<0){
	AjPrice=0;
 %>
 
  <table  width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF"> 
    <tr><td  colspan="6"><%=StrPayName %></td></tr>
  <tr>
  <td align=left  >&nbsp;&nbsp;折扣/优惠:</td>
  <td align=center ><%=StrDisc %>/<%=youhui %></td>
  <TD align=left  >&nbsp;&nbsp;折后价:</td>
  <td align=center ><%=FormatD.getFloat(SalePrice,2)%></td>
  <td  >&nbsp;</td>
  <td  ></td>
  </tr>
    </table>
    <table  width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF"> 
	<tr><td colspan="2" align="center">代收税费及配套费明细表</td></tr>
	<% 
         	 
		 //所有购买客户 按房类计费的
	      out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype"))); 		 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 
		 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype"))); 		 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 
		 
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype")));  
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 
		 
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 
		 
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 
		 
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",request.getParameter("saletype")));
		 
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype")));		  
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 
		 		
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype"))); 	  
         out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 		
		  
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='9' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype"))); 
         out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='9' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	 //结束
	 
	 //按房间用途计费 针对所有客户 
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	 	 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
         out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
         out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
         out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='9' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
 
		 	
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype")));
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype")));
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype")));
         out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype")));
         out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype")));
         out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='9' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype")));
     
	    //结束
	
	 %>
	 <tr><td>合计:</td> <td>&nbsp;&nbsp;<%=FormatD.getFloat3(dssumprice,2)  %></td></tr>
	 <%dssumprice=0; %>
	</table>
    <jsp:include page="PayListViewp.jsp" flush="true">
     <jsp:param name="code" value="<%=PayId%>"/>
	  <jsp:param name="paynum" value="<%=StrPayNum%>"/>
     <jsp:param name="payname" value="<%=StrPayName%>"/>
	 <jsp:param name="count" value="list"/>
	  <jsp:param name="SaleSumPrice" value="<%=Float.parseFloat(SumPrice)*Float.parseFloat(StrDisc)/10000%>"/>
  </jsp:include>

<%@ include file="../public_js/Repalce.jsp"%>
<%

}else{%>
 <%

  int row=0;
  String cs=StrPayName.substring(StrPayName.indexOf("(")+1,StrPayName.indexOf("成"));//贷款成数
  try{
  row= Integer.parseInt(StrPayNum)+3;
  }catch(Exception s){out.print(s.getMessage());out.close();}
   %>
   <%String SQL="";
   String dk="";
   String yongtu1=request.getParameter("yongtu");
   String se=getbyte1(request.getParameter("se"));
  
   if (dktype.equals("0")){
    SQL="SELECT MonthPay,monthmoney FROM  AjLlGkB WHERE TYPE=0 AND year="+year;
	dk="等额还款";
   }else if (dktype.equals("1")){
    SQL="SELECT MonthPay,monthmoney FROM  AjLlGkB WHERE TYPE=2 AND year="+year;
	dk="等本金还款";
    }else if (dktype.equals("2")){
    SQL="SELECT MonthPay,monthmoney FROM  AjLlGkB WHERE TYPE=1 AND year="+year;
	dk="公积金还款";
    }else if (dktype.equals("3")&&(yongtu.indexOf("住宅")>=0||yongtu.indexOf("车")>=0)&&!se.equals("1")){
    SQL="SELECT MonthPay,monthmoney FROM  AjLlGkB WHERE yong_tu=0  and TYPE=3  AND year="+year;
	dk="等本息还款";
   }else if (dktype.equals("3")&&(yongtu1.indexOf("商")>=0||yongtu1.indexOf("写")>=0)){
    SQL="SELECT MonthPay,monthmoney FROM  AjLlGkB WHERE yong_tu=1  and TYPE=3  AND year="+year;
	dk="等本息还款";
 }else if (dktype.equals("3")&&(yongtu.indexOf("住宅")>=0||yongtu.indexOf("车")>=0)&&se.equals("1")){
     SQL="SELECT MonthPay,monthmoney FROM  AjLlGkB WHERE yong_tu=0  and TYPE=3  AND year="+year;
	dk="等本息还款";
   }
 
 
 float ajprice=SalePrice*Float.parseFloat(cs)/100;
 
  dkprice=(int)ajprice/10000;
 AjPrice=(int)ajprice/10000;
 String StrPrice=String.valueOf(ajprice/10000);
 float firstprice=SalePrice-(int)(SalePrice*Float.parseFloat(cs)/100/10000)*10000;
 
 ResultSet rs=null;
 float MonthPay=0;
 float firstMonth=0;
 try{
  rs=ViewBean.executeQuery(SQL);
  if (rs.next()){
    MonthPay=rs.getFloat("MonthPay");
	firstMonth=rs.getFloat("monthmoney");
  }
   rs.close();
  }catch(Exception s){}
  %>
 <input type=hidden name=yongtu1 value="<%=yongtu1 %>">

  <table  width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF"> 
  <tr><td colspan="5">     <%
    out.print(StrPayName.substring(0,StrPayName.indexOf("成"))+"%)"); %>
 <input type=hidden name="<%=NUM %><%=cs+"b"+year+"b"+StrPayNum %>" value="<%=String.valueOf(dkprice)+"|"+String.valueOf(MonthPay*dkprice) %>">
 </td></tr>
  <tr  > 
  <td align=left  >&nbsp;&nbsp;折扣/优惠:</td><td align=center  ><%=StrDisc %>/<%=youhui %></td><TD align=left  >&nbsp;&nbsp;折后价:</td>
  <td align=center   ><%=FormatD.getFloat(SalePrice,0) %></td>
  </tr>
 <input type=hidden name=dkprice value="<%=dkprice %>">
 <tr >
 
  <td align=left  >&nbsp;&nbsp;贷款金额:</td><td align=center  ><%=dkprice %>万元</td>
<%  if (!dktype.equals("1")){ %>
<TD align=left  >&nbsp;&nbsp;月供:</td><td align=center  ><%=FormatD.getFloat(MonthPay*dkprice,2) %>元</td>
<%}else{ %>
<TD align=left  >&nbsp;&nbsp;首月供款:<%=FormatD.getFloat(MonthPay*dkprice,2) %>元</td><td align=center  >尾月供款<%=FormatD.getFloat(firstMonth*dkprice,2) %>元</td>


<%} %>
   </tr><tr >
    <td align=left  >&nbsp;&nbsp;按揭年限:</td><td><%=year %>年
  <td align=left  >&nbsp;&nbsp;首期款:</td><td align=center ><%=(int)firstprice %>元</td> 
  
  </tr>
  </table>
    <table  width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF"> 
	<tr><td colspan="2" align="center">代收税费及配套费明细表</td></tr>
	<%
	 
	//只读取按揭客户应交的费--按房类
	    out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype")));
		
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype")));
		
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype")));
		 
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype"))); 
	     
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype"))); 
	    
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype"))); 
	    
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype"))); 
	   
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype"))); 
	 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='9' and t.type="+custype+"  and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='9' and t.type="+custype+"  and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype"))); 
	    
	 
	    //按揭客户所应付的费用　 ---按用途
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='9' and t.type="+custype+"  and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	   
		
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
 
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype")));
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype")));
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype")));
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype")));
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype")));
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='9' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",request.getParameter("saletype")));		  
	 
		 //结束
		 
		 //所有购买客户 按房类计费的
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype"))); 		 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 
		 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype"))); 		 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 
		 
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype")));  
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 
		 
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 
		 
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 
		 
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",request.getParameter("saletype")));
		 
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype")));		  
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 
		 		
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype"))); 	  
         out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 		
		  
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='9' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",request.getParameter("saletype"))); 
         out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='9' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	 //结束
	 
	 //按房间用途计费 针对所有客户 
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
	 	 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype"))); 
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
         out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
         out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
         out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='9' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",request.getParameter("saletype")));
 
		 	
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype"))); 
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype")));
		 out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype")));
	     out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype")));
         out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype")));
         out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype")));
         out.print(ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='9' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",request.getParameter("saletype")));
        //结束
	 
	
	 %> 	<tr><td>合计:</td> <td>&nbsp;&nbsp;<%=FormatD.getFloat3(dssumprice,2)  %></td></tr>
	 <%dssumprice=0; %>
	</table>
	 
<%   String cSQL="select  "+SalePrice+"*"+cs+"/100-"+dkprice*10000+" ccc";
     // sqlstr1=sql1;
	 String cccc="0";
	  ResultSet rrrr = ViewBean.executeQuery(cSQL);
	  if (rrrr.next())cccc=FormatD.getFloat3(rrrr.getDouble("ccc"),0);
	  rrrr.close();
	   %>
    <jsp:include page="PayListViewp.jsp" flush="true">
      <jsp:param name="code" value="<%=PayId%>"/>
	  <jsp:param name="paynum" value="<%=StrPayNum%>"/>
	   <jsp:param name="ykc" value="<%=cccc %>"/>
      <jsp:param name="payname" value="<%=StrPayName%>"/>
	  <jsp:param name="count" value="list"/>
	  <jsp:param name="SaleSumPrice" value="<%=FormatD.getFloat3(SalePrice,0)%>"/>
  </jsp:include>
 
 <table  width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#000000" bordercolordark="#FFFFFF"> 
  <tr > 
  <td>按揭余款</td><td><%=cccc %>元</td><td>备注：与首期款一起付清</td></tr>
  </table>
 <input type=hidden name=ykc value="<%=cccc %>"> 
 
<%
 }
}
 }catch(Exception s){out.print(s.getMessage()+sqlstr1);out.close();}
 %> 
 <div id=printdiv><input type=button name=print value="打印置业计划书"  onclick="window.printdiv.style.display='none';window.print();"></div>
</center>
 
</FORM>
</body>

</html>
