<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>tax count...</title>
</head>

<body>
<%@ page language="java" import="java.sql.*,java.util.*"%>
 <jsp:useBean id="ViewBean3" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="FormatD" scope="page" class="FormatData.FormatData"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%!float TaxSum=0;
   int AjPrice=0;
   String code="";
   float SalePrice=0;
   float SaleArea=0;
   String section="";
 %>
<%!
	 public void  ShowTax(String sqlstr,String para) throws Exception  {
	  String SqlStr = sqlstr;
	  String  str="";
	  String state="";
   
	  int jjj=0;
	 ConnDatabase.SDatabase ViewBean1=new ConnDatabase.SDatabase();
	 ConnDatabase.SDatabase ViewBean2=new ConnDatabase.SDatabase();
	 ResultSet TaxRs1=null; 
	 ResultSet TaxRs = ViewBean1.executeQuery(SqlStr);
	 FormatData.FormatData formatD1=new FormatData.FormatData();
		  String  money = "",TaxName="";
		  int id=0;
		while (TaxRs.next()) {
		    id = TaxRs.getInt("ID");
	     	money=formatD1.getFloat1(TaxRs.getFloat("money"),1);
	        String  termvalue=TaxRs.getString("termvalue");
		    String term=TaxRs.getString("term");
		    String  termvalue1=TaxRs.getString("termvalue1");
		    String term1=TaxRs.getString("term1");
		    TaxName = getbyte(TaxRs.getString("Tax_Name"));
			String tax_type= getbyte(TaxRs.getString("tax_type"));
		    state=TaxRs.getString("state").trim();
			String type1=TaxRs.getString("type1");
			String type3=TaxRs.getString("type3");	
			if (para.trim().equals("0")&&type3.equals("1"))break;		 
			 
	    jjj++;
   str+="<tr  align='center' class=listcontent>";
   
  if (state.equals("1")){//按售价百分比计算
      String sql1="select  money*"+SalePrice+"/1000.0 aa1 from TaxChages where state=1 and  "+SalePrice+"/10000 "+term+ " termvalue  and "+SalePrice+"/10000"+term1+ "termvalue1  and id= "+id;
 money="";
 TaxRs1 = ViewBean2.executeQuery(sql1);
  
float aa2=0;
  if (TaxRs1.next()){
   aa2=TaxRs1.getFloat("aa1");
  money=formatD1.getFloat1(aa2,2);
  
  }
 TaxRs1.close();
 if (!money.equals("")){
   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
  str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
     String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney)  values("+code+",'"+TaxName+"',"+money+")"; 
ViewBean2.executeUpdate(Tsql);
   }
//  if (!money.equals("")) break;
  }else   if (state.equals("2")){//按固定金额计算
   if (!money.equals("")){
  str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
   String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney)  values("+code+",'"+TaxName+"',"+money+")"; 
ViewBean2.executeUpdate(Tsql);
   }
   
  }else   if (state.equals("3")){//按购房面积计算
  String sql1="select  money*"+SalePrice+"/1000.0 aa1 from TaxChages where state=3 and  "+SalePrice+"/10000 "+term+ " termvalue  and "+SalePrice+"/10000"+term1+ "termvalue1 and id= "+id;
 TaxRs1 = ViewBean2.executeQuery(sql1);
 
float aa2=0;
  if (TaxRs1.next()){
   aa2=TaxRs1.getFloat("aa1");
  money=formatD1.getFloat1(aa2,2);
  
  }
 TaxRs1.close();
 if (!money.equals("")){
   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
   String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney)  values("+code+",'"+TaxName+"',"+money+")"; 
ViewBean2.executeUpdate(Tsql);
   }
  }else   if (state.equals("4"))//按户数计算
{
 str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
   String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney)  values("+code+",'"+TaxName+"',"+money+")"; 
ViewBean2.executeUpdate(Tsql);
}
 else   if (state.equals("5"))//按按揭款计算
  {
   String sql1="select  money*"+AjPrice+"0000/1000.0 aa1 from TaxChages where state=5 and  "+AjPrice+" "+term+ " termvalue  and "+AjPrice+""+term1+ "termvalue1 and id= "+id;
  
 TaxRs1 = ViewBean2.executeQuery(sql1);
 money="";
 
float aa2=0;
  if (TaxRs1.next()){
   aa2=TaxRs1.getFloat("aa1");
  money=formatD1.getFloat1(aa2,2);
  
  }
 TaxRs1.close();
 if (!money.equals("")){
   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
  state=TaxName;
  str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
  str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
  String Tsql="insert into  GatheringTaxRecord(ContactNo,TaxName,TaxMoney)  values("+code+",'"+TaxName+"',"+money+")"; 
ViewBean2.executeUpdate(Tsql);

  }
   
  }
  str+="</tr>";
 }
 
 TaxRs.close();

//return str;
}
%> 

 <%
 String  SQL="select code,rmbprice,ajmoney,section,custype,httype from  order_contract where state<>3  and section='"+request.getParameter("section")+"'";
  ResultSet countRs=ViewBean.executeQuery(SQL);
 
 while (countRs.next()){
   
    code=countRs.getString("code");
	ViewBean3.executeUpdate("delete GatheringTaxRecord where ContactNo="+code);
	SalePrice=countRs.getInt("rmbprice");
	AjPrice=countRs.getInt("ajmoney")/10000;
    String section=countRs.getString("section");
	String custype=countRs.getString("custype");
	String httype=countRs.getString("httype");
	if (custype.equals("个人"))custype="0";
	else custype="1";
 	out.print("<table>");
 if (AjPrice>0){//只读取按揭客户应交的费
	    ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,type1,type3 from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.code  in (select Code from tax where type=1 and  section='"+section+"')",httype); 
	    ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,type1,type3 from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.code  in (select Code from tax where type=1 and section='"+section+"')",httype); 
		if (custype.equals("0"))
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,type1,type3 from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=0 and t.code  in (select Code from tax where  type=1 and section='"+section+"')",httype); 
	    else
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,type1,type3 from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and  t.type=1 and t.code  in (select Code from tax where type=1 and  section='"+section+"')",httype); 
		ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,type1,type3 from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.code  in (select Code from tax where type=1 and  section='"+section+"')",httype);
		ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,type1,type3 from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.code  in (select Code from tax where type=1 and section='"+section+"')",httype);
	}
	////读取所有客户应交的费
	    ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,type1,type3 from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.code  in (select Code from tax where type=0 and section='"+section+"')",httype); 
	    ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,type1,type3 from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.code  in (select Code from tax where type=0 and section='"+section+"')",httype); 
		if (custype.equals("0"))
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,type1,type3 from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type=0 and t.code  in (select Code from tax where  type=0 and  section='"+section+"')",httype); 
	    else
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,type1,type3 from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and  t.type=1 and t.code  in (select Code from tax where  type=0 and section='"+section+"')",httype); 
		ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,type1,type3 from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.code  in (select Code from tax where  type=0 and section='"+section+"')",httype);
		ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.state,t1.tax_name,t1.tax_type,type1,type3 from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.code  in (select Code from tax where  type=0 and section='"+section+"')",httype);
	out.print("</table>");
}
countRs.close();
 %>
<script>
alert("系统已计算完成！");
opener.window.location.reload();
window.close();
</script>
</body>
</html>
