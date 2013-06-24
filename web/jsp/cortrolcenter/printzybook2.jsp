<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>打印置业计划书</title>
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="fa" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
 <%!
	float TaxSum=0;
	int AjPrice=0;
	String code="";
	String SalePrice="0";
	String SaleArea="0";
	String unitprice="0";
	String tnunitprice="0";
	
	String roomtype="";
	String cx="";
	
	String sumprice="",sumprice1="";
	String name="";
	String roomno="";
	String yongtu="";
	String Room_Type="";
	
	String room_code="",buildtype="";
	String section="";
	String qtaxrate="0";
	String qtax="0";
	String aaaa="";
	String  money = "";
	String TaxName="";
	String yhtax="0"; 
	String sqlstr1="";
	String area="0";
	String jzarea="0";
 %> 
 
 
 <%!
	 public String  ShowTax(String sqlstr,String para) throws Exception  {
	  String SqlStr = sqlstr;
	  String  str="";
	  String state="";
    try{
	  int jjj=0;
	 ConnDatabase.SDatabase ViewBean1=new ConnDatabase.SDatabase();
	 ConnDatabase.SDatabase ViewBean2=new ConnDatabase.SDatabase();
	 ResultSet TaxRs1=null; 
	 ResultSet TaxRs = ViewBean1.executeQuery(SqlStr);
	 FormatData.FormatData formatD1=new FormatData.FormatData();
		
		  int id=0;
		while (TaxRs.next()) {
		    id = TaxRs.getInt("ID");
	     	money=formatD1.getFloat3(TaxRs.getDouble("money"),2);
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
				 }
				TaxRs1.close();
                if (!money.equals("")){
                   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
                   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
                   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
                    String Tsql="insert into  zy_count_Charges(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
					ViewBean2.executeUpdate(Tsql);
					if (TaxName.indexOf("契税")>=0){
						qtax=money;
					 }else  if (TaxName.indexOf("印花税")>=0){
					    yhtax=money;
					 }
                }
          }else   if (state.equals("2")){//按固定金额计算
                if (!money.equals("")){
				  str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
				   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
				   String Tsql="insert into  zy_count_Charges(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
				  ViewBean2.executeUpdate(Tsql);
				   }
   
         }else   if (state.equals("3")){//按购房面积计算
                  String sql1="select  money*"+SalePrice+"/1000.0 aa1 from TaxChages where state=3 and  "+SaleArea+""+term+ " termvalue  and "+SaleArea+""+term1+ "termvalue1 and id= "+id;
                  TaxRs1 = ViewBean2.executeQuery(sql1);
 				  double aa2=0;
				  money="";
				  if (TaxRs1.next()){
				     aa2=TaxRs1.getDouble("aa1");
				     money=formatD1.getFloat3(aa2,2);
				  }
				 TaxRs1.close();
                 if (!money.equals("")){
				   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
				   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
				   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
				   String Tsql="insert into  zy_count_Charges(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
				   ViewBean2.executeUpdate(Tsql);
				   if (TaxName.indexOf("契税")>=0){
					qtax=money;
				   }else  if (TaxName.indexOf("印花税")>=0){
				    yhtax=money;
				   }
				}
       }else   if (state.equals("6"))//按户数计算
            {
			    str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
			    str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
			    String Tsql="insert into  zy_count_Charges(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
			   ViewBean2.executeUpdate(Tsql);
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
			  }
			 TaxRs1.close();
			 if (!money.equals("")){
			   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
			   state=TaxName;
			   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
			   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
			   String Tsql="insert into  zy_count_Charges(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
			   ViewBean2.executeUpdate(Tsql);
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
		  TaxRs1.close();
		  if (!money.equals("")){
		   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
		   state=TaxName;
		   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
		   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
		   String Tsql="insert into  zy_count_Charges(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
		  sqlstr1=Tsql;
		   ViewBean2.executeUpdate(Tsql);
		   if (TaxName.indexOf("契税")>=0){
			qtax=money;
		   }else  if (TaxName.indexOf("印花税")>=0){
		    yhtax=money;
		   }
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
		  }
		 TaxRs1.close();
		 if (!money.equals("")){
		   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
		  state=TaxName;
		  str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
		  str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
		  String Tsql="insert into  zy_count_Charges(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
		ViewBean2.executeUpdate(Tsql);
		 if (TaxName.indexOf("契税")>=0){
			qtax=money;
		 }else  if (TaxName.indexOf("印花税")>=0){
		    yhtax=money;
		 }
		  }
   }else   if (state.equals("8"))//按单价计算
    {
       String sql1="select  money*1.0/1000*"+SalePrice+" aa1 from TaxChages where state=8 and  "+unitprice+" "+term+ " termvalue  and "+unitprice+""+term1+ "termvalue1 and id= "+id;
      sqlstr1=sql1;
	  TaxRs1 = ViewBean2.executeQuery(sql1);
	  money="";
      double aa2=0;
	  if (TaxRs1.next()){
	   aa2=TaxRs1.getDouble("aa1");
	   money=formatD1.getFloat3(aa2,2); 
	 }	
	  TaxRs1.close();
	 if (!money.equals("")){
	   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
	   state=TaxName;
	   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
	   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
	   String Tsql="insert into  zy_count_Charges(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
	    sqlstr1=Tsql;
	   ViewBean2.executeUpdate(Tsql);
	   if (TaxName.indexOf("契税")>=0){
		qtax=money;
	   }else  if (TaxName.indexOf("印花税")>=0){
	    yhtax=money;
	   }
	  }  
	  }else   if (state.equals("9"))//按单价计算
    {
    String sql1="select case when ("+area+term+termvalue+"  and "+String.valueOf(tnunitprice)+" "+term1+termvalue1+"   ) or ("+jzarea+term2+termvalue2+"  and   "+String.valueOf(unitprice)+""+term3+termvalue3+") then  "+money+"*1.0/100* "+String.valueOf(SalePrice)+" else  "+money1+"*1.0/100* "+String.valueOf(SalePrice)+" end  aa1 ";
  
       sqlstr1=sql1;
	  TaxRs1 = ViewBean2.executeQuery(sql1);
	  money="";
      double aa2=0;
	  if (TaxRs1.next()){
	   aa2=TaxRs1.getDouble("aa1");
	   money=formatD1.getFloat3(aa2,2);
	  }
	 TaxRs1.close();
	 if (!money.equals("")){
	   if (type1.equals("1")&&aa2<100)money=String.valueOf(100);
	   state=TaxName;
	   str+="<td align=left>&nbsp;&nbsp;"+TaxName+"&nbsp;</td>";
	   str+="<td align=left>&nbsp;&nbsp;"+money+"元&nbsp;</td>";
	   String Tsql="insert into  zy_count_Charges(ContactNo,TaxName,TaxMoney,taxname_type,taxtype)  values("+code+",'"+TaxName+"',"+money+","+tax_type+","+type+")"; 
	   ViewBean2.executeUpdate(Tsql);
	   if (TaxName.indexOf("契税")>=0){
		qtax=money;
	   }else  if (TaxName.indexOf("印花税")>=0){
	    yhtax=money;
	   }
	  }
     }
  str+="</tr>";
  
 }
 TaxRs.close();
}catch(Exception s)	{}
return sqlstr1;
}
 %>
 
 
 <% String code1=getbyte2(request.getParameter("code"));
    String ajyear=getbyte2(request.getParameter("dkyear"));
        String sql="select R.seccode,R.loft+R.room_code room_code,R.tnunitprice,R.loft,R.room_code,R.Room_Type,R.yong_tu,R.Area,R.RoomType,R.Direction,R.usedArea,R.Unitprice,R.Sumprice,S.Name from Room R inner join CRM_Project S on S.SerialNo=R.seccode where R.code="+code1;
	 
		
		ResultSet rs=aBean1.executeQuery(sql);
		if (rs.next()){
		   section=getbyte(rs.getString("seccode"));
		   buildtype=getbyte(rs.getString("room_type"));
		   room_code=getbyte(rs.getString("room_code"));
		   tnunitprice=rs.getString("tnunitprice");
	       Room_Type=getbyte(rs.getString("Room_Type"));
		   yongtu=getbyte(rs.getString("yong_tu"));
		   jzarea=rs.getString("Area");
		 
		   roomtype=getbyte(rs.getString("RoomType"));
		   cx=getbyte(rs.getString("Direction"));
		   roomno=getbyte(rs.getString("room_code"));
		    area=rs.getString("usedArea");
		 
		   unitprice=rs.getString("Unitprice");
           sumprice=fa.getFloat2(rs.getDouble("Sumprice"),2);
	 	   sumprice1=fa.getFloat3(rs.getDouble("Sumprice"),2);
		   name=getbyte(rs.getString("Name"));
		}rs.close(); 
		String menusel="0";
		
		%>	 
	  
<p align=center><font size=3 class=FontColor><b>置业计划书</b></font></p>

<table  width="90" border="0" cellspacing="0" cellpadding="0"   >
   <tr> 
     <td  class="<%if(menusel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.menusel.value=0;findSub('visitcusview.jsp');""><font color='<%if(menusel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>意向单位</a>
	</td>
 
</table>

 <center>
 <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
 <tr >
 <td >&nbsp;楼盘名称</td>
 <td   align="left">&nbsp;<%=name%><input type="hidden" value="<%=name%>" name="SECNAME" size="15" style="border-style: solid; border-width: 1">
 </td>
 <td >&nbsp;房号</td>
 <td   align="left">&nbsp;<%=room_code %><input type="hidden" value="<%=room_code%>" name="LOFT" size="15" style="border-style: solid; border-width: 1">
 </td>
 </tr>
 
 
 <tr >
 <td >&nbsp;建筑面积</td>
 <td   align="left">&nbsp;<%=jzarea%><input type="hidden" name="JZAREA" value="<%=jzarea%>" size="13" style="border-style: solid; border-width: 1">M<sup>2</sup>
 <td >&nbsp;套内建筑面积</td>
 <td   align="left">&nbsp;<%=area%><input type="hidden" name="USERAREA" value="<%=area%>" size="13" style="border-style: solid; border-width: 1">M<sup>2</sup> 
 </td>
 </tr>
<tr >
 <td >&nbsp;户型</td>
 <td   align="left">&nbsp;<%=roomtype%><input type="hidden" name="ROOMTYPE" value="<%=roomtype%>" size="13" style="border-style: solid; border-width: 1">&nbsp;&nbsp;
 <td >&nbsp;朝向</td>
 <td   align="left">&nbsp;<%=cx%><input type="hidden" name="CX" value="<%=cx%>" size="13" style="border-style: solid; border-width: 1">&nbsp;&nbsp;
 </td>
 </tr>
<tr >
 <td >&nbsp;用途</td>
 <td   align="left">&nbsp;<%=yongtu%><input type="hidden" name="yongt" value="<%=Room_Type%>" size="13" style="border-style: solid; border-width: 1">&nbsp;&nbsp;
 <td >&nbsp;房类</td>
 <td   align="left">&nbsp;<%=Room_Type%><input type="hidden" name="fl" value="<%=Room_Type%>" size="13" style="border-style: solid; border-width: 1">&nbsp;&nbsp;
 </td>
 </tr>
<tr>
 <td >&nbsp;建筑面积单价</td>
 <td   align="left">&nbsp;<%=unitprice%><input type="hidden" name="UNITPRICE"  value="<%=unitprice%>" size="9" style="border-style: solid; border-width: 1"> 元/M<sup>2</sup>
 <td >&nbsp;总价</td>
 <td   align="left">&nbsp;<%=sumprice%><input type="hidden" name="SUMPRICE" value="<%=sumprice%>" size="13" style="border-style: solid; border-width: 1">元
 </td>
 </tr>
</table>
</center>
	 <%String  PayId=request.getParameter("pay");
	 String StrPayNum="1",StrPayName="";
	 String ajcs="0",prepay="0";
	 double rmbprice=0;
	 double dic=0;
	 String Discont="";
	 int ajk=0;
	  sql="select * from PayMent  where    ID="+PayId;
	   rs=aBean1.executeQuery(sql);
		if (rs.next()){
		  StrPayName=getbyte(rs.getString("PayName"));
		  if (StrPayName.indexOf("揭")>=0){
          	ajcs=StrPayName.substring(StrPayName.indexOf("(")+1,StrPayName.indexOf("%"));
	      }
		  sql="select "+rs.getString("Discont")+"/100.0 dd";
		  Discont=rs.getString("Discont");
		  ResultSet rs1=aBean.executeQuery(sql);
		  if (rs1.next())
		  dic= rs1.getDouble("dd");
		  rs1.close();
		  
		  //dic=rs.getDouble("Discont");
		  StrPayNum=rs.getString("num");
		  prepay=rs.getString("prepay");
		}
		rs.close();
	 rmbprice=Double.parseDouble(fa.getFloat3(Double.parseDouble(sumprice1)*dic,0));
	 ajk=(int)(((int)rmbprice/10000)*Double.parseDouble(ajcs)/100);
	 
	 
	  sql = "select  MonthPay from ajllgkb  where type=3  and yong_tu=0 and year="+ajyear;//where id >=" + String.valueOf(firstPos);
	  rs = aBean1.executeQuery(sql);	
 
     double pjpay=0;
	if (rs.next()) { 
	  pjpay=rs.getDouble("MonthPay");
	  
	}
 
	 %> 
	 <table  width="90" border="0" cellspacing="0" cellpadding="0"   >
   <tr> 
     <td  class="<%if(menusel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.menusel.value=0;findSub('visitcusview.jsp');""><font color='<%if(menusel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>置业付款</a>
	</td>
 
</table>
	 <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
	 <tr><td>付款方式:</td><td><%= StrPayName%></td><td>付款折扣:</td><td><%= Discont%>折</td></tr>
	 <tr><td>折扣总价:</td><td><%= fa.getFloat2(Double.parseDouble(fa.getFloat3(Double.parseDouble(sumprice1)*dic/100.0,0)),2)%></td><td>认购定金:</td><td><%= prepay%></td></tr>
	 <% if (StrPayName.indexOf("揭")>=0){ %>
	 <tr><td>按揭款:</td><td><%=fa.getFloat2(ajk*10000,2) %></td><td>首期款:</td><td><%= fa.getFloat2(rmbprice-ajk*10000,2)%></td></tr>
	 <tr><td>按揭年限:</td><td><%=ajyear %></td><td>月供款:</td><td><%= fa.getFloat2(pjpay*ajk,2)%></td></tr>
	 
	 <%} %>
	 <tr><td colspan="4">
	 
	  <jsp:include page="../sale/PayListView3.jsp" flush="true">
     <jsp:param name="code" value="<%=PayId%>"/>
	  <jsp:param name="paynum" value="<%=StrPayNum%>"/>
     <jsp:param name="payname" value="<%=StrPayName%>"/>
	 <jsp:param name="count" value="list"/>
	 <jsp:param name="dj" value="<%=prepay %>"/>
	  <jsp:param name="ykc" value="<%=rmbprice*Double.parseDouble(ajcs)/100.0-ajk*10000.0 %>"/>
	 <jsp:param name="SaleSumPrice" value="<%=rmbprice %>"/>
	 
	 
  </jsp:include>
  </td></tr>
  </table>
	 <%
	  AjPrice=ajk;
	 String httype="0";
	 String custype="0";
	 SalePrice=String.valueOf(rmbprice);
	 unitprice=fa.getFloat3(rmbprice/Double.parseDouble(jzarea),2);
	 tnunitprice=fa.getFloat3(rmbprice/Double.parseDouble(area),2);
	 SaleArea=jzarea;
	 code="0";
	 aBean1.executeUpdate("delete zy_count_Charges where ContactNo="+code);
	if (AjPrice>0){
	//只读取按揭客户应交的费--按房类
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype); 
	     
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype);
		
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype); 
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype);
		
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype); 
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype);
		 
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype); 
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype); 
	     
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype); 
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype); 
	    
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype); 
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype); 
	    
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype); 
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype); 
	   
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype); 
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype); 
	 
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='9' and t.type="+custype+"  and t.code  in (select Code from tax where  type2=0 and type=1 and type3='所有' and section='"+section+"')",httype); 
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='9' and t.type="+custype+"  and t.code  in (select Code from tax where  type2=0 and type=1 and type3='"+buildtype+"' and section='"+section+"')",httype); 
	    
	 
	    //按揭客户所应付的费用　 ---按用途
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype); 
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype); 
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype); 
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype); 
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype); 
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype); 
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype); 
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype); 
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='9' and t.type="+custype+"  and t.code  in (select Code from tax where  type2=0 and type=1 and type1='"+yongtu+"' and section='"+section+"')",httype); 
	   
		
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype); 
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype); 
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype);
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype); 
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype);
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype);
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype);
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype);
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='9' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=1 and type1='所有' and section='"+section+"')",httype);		  
	     
	 // }
	}
	 
		 //结束
		 
		 //所有购买客户 按房类计费的
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",httype); 		 
	      
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",httype); 
		 
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",httype); 		 
	  
		  ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",httype); 
		 
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",httype);  
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",httype); 
		  
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",httype); 
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",httype); 
		   
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",httype); 
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",httype); 
		 
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",httype); 
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",httype);
		 
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",httype);		  
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",httype); 
		 		
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",httype); 	  
         ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",httype); 		
		  
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='9' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='"+buildtype+"' and section='"+section+"')",httype); 
         ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='9' and t.type="+custype+" and t.code  in (select Code from tax where  type2=0 and type=0 and type3='所有' and section='"+section+"')",httype); 
	 //结束
	  
	 //按房间用途计费 针对所有客户 
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype); 
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype); 
	 	 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype); 
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype);
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype);
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype);
         ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype);
         ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype);
         ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='9' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='"+yongtu+"' and section='"+section+"')",httype);
 
		 	
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='5' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",httype); 
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='1' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",httype); 
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='2' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",httype); 
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='3' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",httype);
		 ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='4' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",httype);
	     ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='6' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",httype);
         ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='7' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",httype);
         ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='8' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",httype);
         ShowTax("select t.id,t.code,t.money,t.termvalue,t.term,t.termvalue1,t.term1,t.termvalue2,t.term2,t.termvalue3,t.term3,t.money1,t.state,t1.tax_name,t1.tax_type,t1.type2,t.type1,t.type3,t.type from TaxChages t,tax t1 where t.code=t1.code and t.state='9' and t.type="+custype+" and t.code  in (select Code from tax where type2=0 and type=0 and  type1='所有' and section='"+section+"')",httype);
        //结束
		 
	 
	  %>
	 
	 
	 
 <table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
	    <tr    align="center">
	 <td >序号</td> <td >费用名称</td><td >费用类型</td><td>应收金额</td> 
    </tr>
	
  
    <%
 
	
 

   		sql="select id,TaxName,TaxMoney,state,TaxMoney-factmoney q,cancel,taxname_type,cancelbak from zy_count_Charges where contactno =0 order by taxname_type ,TaxName";//order by room_no desc";
 
  
 
   rs=aBean.executeQuery(sql);

 int i=0;
 while (rs.next()){

  try{
     i=i+1;
    String TaxName=getbyte(rs.getString("TaxName"));
    double TaxMoney=rs.getDouble("TaxMoney");
    int taxname_type=rs.getInt("taxname_type");
	String cancelbak=rs.getString("cancelbak");
    %> 
    <tr    align="center"   >
      <td   ><%=i%> </td>
	  <td  ><%=TaxName%></td>
	    <td  ><%if (taxname_type==0)out.println("配套费");else out.println("税费");%></td>
	  <td  ><%=TaxMoney%></td>
	    
   
    </tr>
    <%
  }catch(Exception ex){out.println(ex.getMessage());}

}

  rs.close();
 sql="select sum(TaxMoney) TaxMoney,taxname_type  from zy_count_Charges where cancel=0 and  contactno =0 group by taxname_type";//order by room_no desc";
   rs=aBean.executeQuery(sql);
   float taxprice=0,peitaoprice=0;
   while (rs.next()){
     if (rs.getBoolean("taxname_type"))taxprice=rs.getFloat("TaxMoney");
	 else peitaoprice=rs.getFloat("TaxMoney");
 }
 rs.close();
 %>
 <tr><td  colspan="9"> 税费合计：<%=fa.getFloat(taxprice,2) %>&nbsp;&nbsp;&nbsp;配套合计：<%=fa.getFloat(peitaoprice,2) %>&nbsp;&nbsp;&nbsp;&nbsp;合计：<%=fa.getFloat(peitaoprice+taxprice,2) %></td></tr>

</table> 


<table  width="90" border="0" cellspacing="0" cellpadding="0"   >
   <tr> 
     <td  class="<%if(menusel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.menusel.value=0;findSub('visitcusview.jsp');""><font color='<%if(menusel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>准备资料</a>
	</td>
 
</table>
  <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >
   <%    sql="SELECT * FROM  zy_tj_data WHERE   sectionno='"+section+"'";
	 
	    rs=aBean.executeQuery(sql) ;
	    i=0;
	   while (rs.next()){
	    if (i==0) out.print(" <tr  > ");
	     i++;
	   %>
   
	 
      <td > 
        <%=i %>、<%=rs.getString("dataname") %>
      </td>
    <%if (i==4){i=0;out.print("</tr>");} %>
 
	 
	   <%}rs.close(); %>
	   
	 
  </TABLE>
</body>
</html>

 