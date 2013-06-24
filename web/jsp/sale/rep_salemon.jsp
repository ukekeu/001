
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.Date,common.*,java.util.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
   <jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="fa" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
 
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>销售月报表</title>
</head>
<%String s_date=request.getParameter("yearmonth");
  String SecNo=getbyte1(request.getParameter("SecNo"));
  String SecNa=SecNo.substring(SecNo.indexOf("-")+1);
  SecNo=SecNo.substring(0,SecNo.indexOf("-"));
   %>
<body>
 <DIV align=center id="printdiv">
 <!--<input class="buttoninput" type="button" value="打印预览" onclick="window.printdiv.style.display='none';factory.printing.Preview();"> -->
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">&nbsp;<input type="button" onclick="bringToExcel()" value="导出到Excel">
 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
   <div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2" contentEditable >

 <center> 
 <p align="center"><font size=4><b><%=SecNa+s_date.substring(0,s_date.indexOf("-"))+"年"+s_date.substring(s_date.indexOf("-")+1)+"月" %>销售报表</b></font></p>
 <table width="100%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
 <tr align="center">
    <td  rowspan="2" >幢号</td>
    <td  rowspan="2" >营建<br>面积</td>
    <td   colspan="5">未售面积</td>
    <td colspan="5">本月销<br>售面积</td>
    <td colspan="5">累计销<br>售面积</td>
   
  </tr>
  <tr>
    <td  >住宅</td>
    <td  >铺面</td>
    <td  >办公</td>
    <td  >车库</td>
    <td  >花园<br>露台</td>
    <td  >住宅</td>
    <td >铺面</td>
    <td >办公</td>
    <td >车库</td>
    <td  >花园<br>露台</td>
    <td  >住宅</td>
    <td >铺面</td>
    <td >办公</td>
    <td >车库</td>
    <td  >花园<br>露台</td>
  </tr>
<%
  
 
 
  String sql1="select  loft,sum(area) area,count(*)num  from room where seccode='"+SecNo+"' group by loft";
  ResultSet rs1=null;
  ResultSet rs=null;
     int ws1=0;
     int ys1=0;
     int ls1=0;
	 int zj=0;
	
  rs1=ViewBean1.executeQuery(sql1);
  try{
 	while (rs1.next()){
	 int ws=0;
     int ys=0;
     int ls=0;
	 String loft=rs1.getString("loft");
	 String area=rs1.getString("area");
	 zj=rs1.getInt("num");
     String sql="select sum(area) area,sum(lu_tai_area) lu_tai_area,yong_tu,count(*) num from room where loft='"+loft+"' and salestate=1 and seccode='"+SecNo+"' group by yong_tu";
   
	 List list1=new LinkedList();//面积
	 List list3=new LinkedList();//花园/露台面积
     List list2=new LinkedList();//用途
 	 List list4=new LinkedList();//套数
	 
	double sumarea1=0,sumarea2=0,sumarea3=0;
	double lu_tai_area=0;
	rs=ViewBean.executeQuery(sql);
	while (rs.next()){
	   double dd = rs.getDouble("area");
	   double dd1 = rs.getDouble("lu_tai_area");
	   lu_tai_area+=dd1;
	 
	   sumarea1+=dd;
	   list1.add(String.valueOf(dd));
	   list2.add(getbyte(rs.getString("yong_tu")));
	   int a1=rs.getInt("num");
	   ws+=a1;
	   list4.add(String.valueOf(a1));
	   
	}
	rs.close();
 
 %>
 
  <tr>
    <td  rowspan="2" ><%=loft %></td>
    <td  rowspan="2" ><%=area %>(<%=zj %>)</td>
    <td  align="center" >
	<%
	String ddd="0";
	String dddd="0";
	String ts="0";
	String ts1="0";
	if (list2.contains("住宅")){
	   int index=list2.indexOf("住宅");
	  ddd=(String)list1.get(index);
	  ts=(String)list4.get(index);
	     
     }
	if (list2.contains("复式住宅")){
	   int index=list2.indexOf("复式住宅");
	  dddd=(String)list1.get(index);
	   ts1=(String)list4.get(index);
	 
     }
	 out.print(fa.getFloat2(java.lang.Double.parseDouble(dddd)+java.lang.Double.parseDouble(ddd),2));
	 out.print("(");
	 out.println(java.lang.Integer.parseInt(ts1)+java.lang.Integer.parseInt(ts));
	 out.print(")");
	 %>&nbsp;
 	 </td>
    <td  ><%
	if (list2.contains("商铺")){
	   int index=list2.indexOf("商铺");
	  out.print((String)list1.get(index));
	   ts=(String)list4.get(index);
	    out.print("("+java.lang.Integer.parseInt(ts)+")");
	
     }
	
	 %>&nbsp;</td>
    <td  ><%
	if (list2.contains("办公")){
	   int index=list2.indexOf("办公");
	  out.print((String)list1.get(index));
	   ts=(String)list4.get(index);
	    out.print("("+java.lang.Integer.parseInt(ts)+")");
     }
	
	 %>&nbsp;</td>
    <td  ><%
	if (list2.contains("车库")){
	   int index=list2.indexOf("车库");
	  out.print((String)list1.get(index));
	   ts=(String)list4.get(index);
	    out.print("("+java.lang.Integer.parseInt(ts)+")");
     }
	
	 %>&nbsp;</td>
    <td  >&nbsp;<%=lu_tai_area %></td>
	<%
	
	//计算本月销售的面积
	list1.clear();	
	list2.clear();	
	list3.clear();	
	list4.clear();	
	//sql="select sum(jzarea) area,sum(lutai_area) lu_tai_area,yong_tu from order_contract where loft='"+loft+"' and state<>3 and  section='"+SecNo+"' and  convert(varchar(7),date,120)='"+s_date+"' group by yong_tu";
   sql="select yongtu,sum(jzarea) area,sum(lutai_area) lu_tai_area,count(*) num  from order_contract_log where  loft='"+loft+"' and state1=0 and  sectionno='"+SecNo+"' and convert(varchar(7),log_date,120)='"+s_date+"' group by yongtu";
 
 
	 sumarea2=0;
	 lu_tai_area=0;
	rs=ViewBean.executeQuery(sql);
	while (rs.next()){
	
	     String yongtu1=getbyte(rs.getString("yongtu"));
	     list2.add(yongtu1);
	     int dd3 =rs.getInt("num");
		
	   //计算与往月差
 	    sql="select sum(jzarea) area,sum(lutai_area) lu_tai_area,count(*) num from order_contract_log where order_contract in (select order_contract from order_contract_log where   loft='"+loft+"' and state1=0 and  sectionno='"+SecNo+"'  and convert(varchar(7),log_date,120)='"+s_date+"') and convert(varchar(7), log_date,120)<'"+s_date+"' and yongtu='"+yongtu1+"' group by convert(varchar(7), log_date,120)  ORDER BY convert(varchar(7), log_date,120) DESC";
	 
		ResultSet rs3=ViewBean2.executeQuery(sql);
		
		float cc=0;
		float cc1=0;
	    if (rs3.next()){cc=rs3.getFloat("area");cc1=rs3.getFloat("lu_tai_area");dd3=dd3-rs3.getInt("num");}
	    rs3.close();
		 ys+=dd3;
	   double dd = rs.getDouble("area")-cc;
	   double dd1 = rs.getDouble("lu_tai_area")-cc1;
	   lu_tai_area+=dd1;
	 
		   sumarea2+=dd;
	   list1.add(String.valueOf(dd));
	   list4.add(String.valueOf(dd3));
	}
	rs.close();
  

   
	 %>
	 <td>
  <%
	  ddd="0";
	  dddd="0";
	  ts1="0";
	  ts="0";
	if (list2.contains("住宅")){
	   int index=list2.indexOf("住宅");
	  ddd=(String)list1.get(index);
	   ts1=(String)list4.get(index);
	  
     }
	if (list2.contains("复式住宅")){
	   int index=list2.indexOf("复式住宅");
	  dddd=(String)list1.get(index);
	   ts=(String)list4.get(index);
	  
     }
	 out.print(fa.getFloat2(java.lang.Double.parseDouble(dddd)+java.lang.Double.parseDouble(ddd),2));
	 
	 out.print("("+String.valueOf(java.lang.Integer.parseInt(ts)+java.lang.Integer.parseInt(ts1))+")");
	 
	 %>&nbsp;</td>
    <td  ><%
	  ts1="";
	  ts="";
	if (list2.contains("商铺")){
	   int index=list2.indexOf("商铺");
	  out.print((String)list1.get(index));
	   ts=(String)list4.get(index);
	 
	    out.print("("+java.lang.Integer.parseInt(ts)+")");
     }
	
	 %>&nbsp;</td>
    <td  ><%
	if (list2.contains("办公")){
	   int index=list2.indexOf("办公");
	  out.print((String)list1.get(index));
	    ts=(String)list4.get(index);
	    out.print("("+java.lang.Integer.parseInt(ts)+")");
     }
	
	 %>&nbsp;</td>
    <td  ><%
	if (list2.contains("车库")){
	   int index=list2.indexOf("车库");
	  out.print((String)list1.get(index));
	    ts=(String)list4.get(index);
	    out.print("("+java.lang.Integer.parseInt(ts)+")");
     }
	
	 %>&nbsp;</td>
    <td  >&nbsp;<%=lu_tai_area %></td>
    <%
	
	//计算累计销售面积
	list1.clear();	
	list2.clear();	
	list3.clear();	
	list4.clear();	
	sql="select sum(jzarea) area,sum(lu_tai_area) lu_tai_area,yong_tu,count(*) num from order_contract where loft='"+loft+"' and state<>3 and  section='"+SecNo+"'  group by yong_tu";
 
 	
	 sumarea3=0;
	 lu_tai_area=0;
	rs=ViewBean.executeQuery(sql);
	while (rs.next()){
	   double dd = rs.getDouble("area");
	   double dd1 = rs.getDouble("lu_tai_area");
	   
	   lu_tai_area+=dd1;
	 
	   sumarea3+=dd;
	   list1.add(String.valueOf(dd));
	   list2.add(rs.getString("yong_tu"));
	   int pp0=rs.getInt("num");
	   ls+=pp0;
	   list4.add(String.valueOf(pp0));
	}
	rs.close();
 
	 %>
	   <td  >
	<%
	  ddd="0";
	  dddd="0";
	  ts1="0";
	  ts="0";
	if (list2.contains("住宅")){
	   int index=list2.indexOf("住宅");
	  ddd=(String)list1.get(index);
	   ts1=(String)list4.get(index);
	    
     }
	if (list2.contains("复式住宅")){
	   int index=list2.indexOf("复式住宅");
	  dddd=(String)list1.get(index);
	   ts=(String)list4.get(index);
	   
     }
	 out.print(fa.getFloat2(java.lang.Double.parseDouble(dddd)+java.lang.Double.parseDouble(ddd),2));
	 
	  out.print("("+String.valueOf(java.lang.Integer.parseInt(ts1)+java.lang.Integer.parseInt(ts1))+")");
	 
	 %>&nbsp;</td>
    <td  ><%
	if (list2.contains("商铺")){
	   int index=list2.indexOf("商铺");
	  out.print((String)list1.get(index));
	   ts=(String)list4.get(index);
	    out.print("("+java.lang.Integer.parseInt(ts)+")");
     }
	
	 %>&nbsp;</td>
    <td  ><%
	if (list2.contains("办公")){
	   int index=list2.indexOf("办公");
	  out.print((String)list1.get(index));
	   ts=(String)list4.get(index);
	   out.print("("+java.lang.Integer.parseInt(ts)+")");
     }
	
	 %>&nbsp;</td>
    <td  ><%
	if (list2.contains("车库")){
	   int index=list2.indexOf("车库");
	  out.print((String)list1.get(index));
	   ts=(String)list4.get(index);
	     out.print("("+java.lang.Integer.parseInt(ts)+")");
     }
	
	
	 %>&nbsp;</td>
    <td  >&nbsp;<%=lu_tai_area %></td>
 
  </tr>
  <tr align="center">
    <td colspan="5"  >&nbsp;<%=fa.getFloat2(sumarea1,2) %>(<%=ws %>)</td>
     <td colspan="5"  >&nbsp;<%=fa.getFloat2(sumarea2,2) %>(<%=ys %>)</td>
     <td colspan="5"  >&nbsp;<%=fa.getFloat2(sumarea3,2) %>(<%=ls %>)</td>
  </tr>
  <%
      ws1+=ws;
      ys1+=ys;
      ls1+=ls;
  }
  rs1.close(); 
  }catch(Exception s){out.print(s);}
  %>
  <%
  //营建面积
    double s1=0;
    String  ssql="select sum(area) lu_tai_area from room where seccode='"+SecNo+"' ";
   ResultSet rs2=ViewBean.executeQuery(ssql);
   if (rs2.next()){
   
	s1+=rs2.getDouble("lu_tai_area");
	}
	rs2.close();
   //未售面积
     double s2=0;
      ssql="select sum(area) lu_tai_area from room where salestate=1 and seccode='"+SecNo+"' ";
    rs2=ViewBean.executeQuery(ssql);
   if (rs2.next()){
   
	s2+=rs2.getDouble("lu_tai_area");
	}
	rs2.close();
   
   //本月已售面积
   
   
   
   //计算本月销售的面积
	 
	//sql="select sum(jzarea) area,sum(lutai_area) lu_tai_area,yong_tu from order_contract where loft='"+loft+"' and state<>3 and  section='"+SecNo+"' and  convert(varchar(7),date,120)='"+s_date+"' group by yong_tu";
   String sqla="select sum(jzarea) area,sum(lutai_area) lu_tai_area  from order_contract_log where   state1=0 and  sectionno='"+SecNo+"'  and convert(varchar(7),log_date,120)='"+s_date+"'";

 	
	double s3=0,cc=0;
	rs=ViewBean.executeQuery(sqla);
	while (rs.next()){
	     s3+=rs.getDouble("area");
	    
	  
	   //计算与往月差
 	    sqla="select sum(jzarea) area, convert(varchar(7), log_date,120) from order_contract_log where order_contract in (select order_contract from order_contract_log where   state1=0 and  sectionno='"+SecNo+"' and convert(varchar(7),change_date,120)='"+s_date+"') and convert(varchar(7), change_date,120)<'"+s_date+"'  group by convert(varchar(7), log_date,120)  ORDER BY convert(varchar(7), log_date,120) DESC";
	
		ResultSet rs3=ViewBean2.executeQuery(sqla);
		
		 
	    if (rs3.next()){cc=rs3.getDouble("area");}
	    rs3.close();
	   s3=s3-cc;
	}
	rs.close();
  
   
   
   
   
   
   //累计已售面积
     double s4=0;
      ssql="select sum(jzarea) lu_tai_area from   order_contract where  section='"+SecNo+"'";
    rs2=ViewBean.executeQuery(ssql);
   if (rs2.next()){
   
	s4+=rs2.getDouble("lu_tai_area");
	}
	rs2.close();
   %>
  <tr align="center"><td>合计：</td><td><b><%=fa.getFloat2(s1,2) %>(<%=ws1+ls1 %>)</td>
  <td colspan="5"><b><%=fa.getFloat2(s2,2) %>(<%=ws1 %>)</td>
  <td colspan="5"><b><%=fa.getFloat2(s3,2) %>(<%=ys1 %>)</td>
    <td colspan="5"><b><%=fa.getFloat2(s4,2) %>(<%=ls1 %>)</td>
  </tr>
</table>
<br>

 <table width="100%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
 <tr align="center">
   <td   >幢号</td>
 <td   >本月销售额</td>
    <td  >本月回笼款</td>
    <td   >本月代收款</td>
    <td  >累计总销售额</td>
    <td   >累计回笼款</td>
    <td   >累计代收款</td>
 
</tr>
<%
   sql1="select  loft,sum(area) area  from room where seccode='"+SecNo+"' group by loft";

  rs1=ViewBean1.executeQuery(sql1);
 	while (rs1.next()){
	float rmbprice=0;
	float youhui=0;
	float youhui1=0;
	float td=0;
	String loft=rs1.getString("loft");
	//算本月销售金额
	 String sql="select sum(rmbprice) rmbprice  from order_contract_log where  loft='"+loft+"' and state1=0 and  sectionno='"+SecNo+"' and convert(varchar(7),log_date,120)='"+s_date+"'";

 //  String sql="select sum(rmbprice) rmbprice  from order_contract where loft='"+loft+"' and state<>3 and  section='"+SecNo+"' and convert(varchar(7),date,120)='"+s_date+"'";
     rs=ViewBean.executeQuery(sql);
	
    if (rs.next()){ rmbprice=rs.getFloat("rmbprice");}
	
	rs.close();
	//计算在本月发生改变的合同在前一个月的金额，计算差额
	sql="select sum(rmbprice) rmbprice  from order_contract_log where order_contract in (select order_contract from order_contract_log where   loft='"+loft+"' and state1=0 and  sectionno='"+SecNo+"' and convert(varchar(7),change_date,120)='"+s_date+"') and convert(varchar(7), change_date,120)<'"+s_date+"' group by convert(varchar(7), log_date,120)  ORDER BY convert(varchar(7), log_date,120) DESC";

	 rs=ViewBean.executeQuery(sql);
	if (rs.next())rmbprice=rmbprice-rs.getFloat("rmbprice");
	rs.close();
 
	
	    //计算本月退订
	  sql="select sum(rmbprice) rmbprice  from order_contract where loft='"+loft+"' and state=3 and  section='"+SecNo+"' and convert(varchar(7),td_date,120)='"+s_date+"'";
   rs=ViewBean.executeQuery(sql);
   if (rs.next()){ td=rs.getFloat("rmbprice");}
    //本月实际的销售金额
	rmbprice=rmbprice-td;
	//本月回笼金额
	double hlk=0;
    //本月实收款
	sql="select  sum(factmoney*CurrRate) rmbprice  from FactGatheringRecord where checkstate=1 and  contractno in (select  code from order_contract where loft='"+loft+"' and  section='"+SecNo+"') and convert(varchar(7),Gather_Date,120)='"+s_date+"'";
	rs=ViewBean.executeQuery(sql);
   if (rs.next()){ hlk=rs.getDouble("rmbprice");}
   rs.close();
   //本月放款
	sql="select  sum(FactMonye) rmbprice  from FactAjCharges where  checkstate=1 and  contractno in (select  code from order_contract where loft='"+loft+"' and  section='"+SecNo+"') and convert(varchar(7),FactDate,120)='"+s_date+"'";
	rs=ViewBean.executeQuery(sql);
   if (rs.next()){ hlk+=rs.getDouble("rmbprice");}
	rs.close();
	
	  //本月代收
	  double ds=0;
 	
	sql="select  sum(money) rmbprice  from FactGatheringTaxRecord where  checkstate=1 and  contractno in (select  code from order_contract where loft='"+loft+"' and  section='"+SecNo+"') and convert(varchar(7),date,120)='"+s_date+"'";
	rs=ViewBean.executeQuery(sql);
   if (rs.next()){ ds=rs.getDouble("rmbprice");}
	rs.close();
	
	
	
	
 %>
<tr>
    <td   >&nbsp;<%=loft %></td>
    <td   >&nbsp;<%=fa.getFloat2(rmbprice,2) %></td>
    <td   >&nbsp;<%=fa.getFloat2(hlk,2) %></td>
    <td   >&nbsp;<%=fa.getFloat2(ds,2) %></td>
	
	
	<%
	
	  rmbprice=0;
	 youhui=0;
	 youhui1=0;
	 td=0;

	//算累计销售金额
    sql="select sum(rmbprice) rmbprice  from order_contract where loft='"+loft+"' and state<>3 and  section='"+SecNo+"' ";
     rs=ViewBean.executeQuery(sql);
    if (rs.next()){ rmbprice=rs.getFloat("rmbprice");}
	rs.close();
	  
	//累计回笼金额
	 hlk=0;
    //累计实收款
	sql="select  sum(factmoney*CurrRate) rmbprice  from FactGatheringRecord where checkstate=1 and  contractno in (select  code from order_contract where loft='"+loft+"' and  section='"+SecNo+"')";
	rs=ViewBean.executeQuery(sql);
   if (rs.next()){ hlk=rs.getDouble("rmbprice");}
   rs.close();
   //累计放款
	sql="select  sum(FactMonye) rmbprice  from FactAjCharges where  checkstate=1 and  contractno in (select  code from order_contract where loft='"+loft+"' and  section='"+SecNo+"') ";
	rs=ViewBean.executeQuery(sql);
   if (rs.next()){ hlk+=rs.getDouble("rmbprice");}
	rs.close();
	
	  //累计代收
	   ds=0;
 	
	sql="select  sum(money) rmbprice  from FactGatheringTaxRecord where  checkstate=1 and  contractno in (select  code from order_contract where loft='"+loft+"' and  section='"+SecNo+"')";
	rs=ViewBean.executeQuery(sql);
   if (rs.next()){ ds=rs.getDouble("rmbprice");}
	rs.close();
	
	 %>
   <td   >&nbsp;<%=fa.getFloat2(rmbprice,2) %></td>
    <td   >&nbsp;<%=fa.getFloat2(hlk,2) %></td>
    <td   >&nbsp;<%=fa.getFloat2(ds,2) %></td>
	 
</tr>
<%}
rs1.close() ;%>

<%
	
	float  rmbprice=0;
	 
//本月项目累计
	  //算本月销售金额
	String  sql="select sum(rmbprice) rmbprice  from order_contract_log where    state1=0 and  sectionno='"+SecNo+"' and convert(varchar(7),log_date,120)='"+s_date+"'";

 //  String sql="select sum(rmbprice) rmbprice  from order_contract where loft='"+loft+"' and state<>3 and  section='"+SecNo+"' and convert(varchar(7),date,120)='"+s_date+"'";
     rs=ViewBean.executeQuery(sql);
	
    if (rs.next()){ rmbprice=rs.getFloat("rmbprice");}
		 
	rs.close();
	//计算在本月发生改变的合同在前一个月的金额，计算差额
	sql="select sum(rmbprice) rmbprice  from order_contract_log where order_contract in (select order_contract from order_contract_log where   state1=0 and  sectionno='"+SecNo+"'  and convert(varchar(7),change_date,120)='"+s_date+"') and convert(varchar(7), change_date,120)<'"+s_date+"' group by convert(varchar(7), log_date,120)  ORDER BY convert(varchar(7), log_date,120) DESC";

	 rs=ViewBean.executeQuery(sql);
	if (rs.next())rmbprice=rmbprice-rs.getFloat("rmbprice");
	rs.close();
 float td=0;

	    //计算本月退订
	  sql="select sum(rmbprice) rmbprice  from order_contract where  state=3 and  section='"+SecNo+"' and convert(varchar(7),td_date,120)='"+s_date+"'";
   rs=ViewBean.executeQuery(sql);
   if (rs.next()){ td=rs.getFloat("rmbprice");}
    //本月实际的销售金额
	//rmbprice=rmbprice-td;
	 
	
	  
	  
	//累计回笼金额
	double hlk=0;
    //累计实收款
	sql="select  sum(factmoney*CurrRate) rmbprice  from FactGatheringRecord where checkstate=1 and  contractno in (select  code from order_contract where    section='"+SecNo+"')  and convert(varchar(7),Gather_Date,120)='"+s_date+"'";
	rs=ViewBean.executeQuery(sql);
   if (rs.next()){ hlk=rs.getDouble("rmbprice");}
   rs.close();
   //累计放款
	sql="select  sum(FactMonye) rmbprice  from FactAjCharges where  checkstate=1 and  contractno in (select  code from order_contract where    section='"+SecNo+"') and convert(varchar(7),FactDate,120)='"+s_date+"'";
	rs=ViewBean.executeQuery(sql);
   if (rs.next()){ hlk+=rs.getDouble("rmbprice");}
	rs.close();
	
	  //累计代收
	 double  ds=0;
 	
	sql="select  sum(money) rmbprice  from FactGatheringTaxRecord where  checkstate=1 and  contractno in (select  code from order_contract where  section='"+SecNo+"') and convert(varchar(7),date,120)='"+s_date+"'";
	rs=ViewBean.executeQuery(sql);
   if (rs.next()){ ds=rs.getDouble("rmbprice");}
	rs.close();
	
	 %>
<tr><td><b>总计:</td>
   <td   >&nbsp;<b><%=fa.getFloat2(rmbprice,2) %></td>
    <td   >&nbsp;<b><%=fa.getFloat2(hlk,2) %></td>
    <td   >&nbsp;<b><%=fa.getFloat2(ds,2) %></td>
	<%
	
	  rmbprice=0;
	 

	//算累计销售金额
     sql="select sum(rmbprice) rmbprice  from order_contract where  state<>3 and  section='"+SecNo+"' ";
     rs=ViewBean.executeQuery(sql);
    if (rs.next()){ rmbprice=rs.getFloat("rmbprice");}
	rs.close();
	  
	//累计回笼金额
	 hlk=0;
    //累计实收款
	sql="select  sum(factmoney*CurrRate) rmbprice  from FactGatheringRecord where checkstate=1 and  contractno in (select  code from order_contract where    section='"+SecNo+"')";
	rs=ViewBean.executeQuery(sql);
   if (rs.next()){ hlk=rs.getDouble("rmbprice");}
   rs.close();
   //累计放款
	sql="select  sum(FactMonye) rmbprice  from FactAjCharges where  checkstate=1 and  contractno in (select  code from order_contract where    section='"+SecNo+"') ";
	rs=ViewBean.executeQuery(sql);
   if (rs.next()){ hlk+=rs.getDouble("rmbprice");}
	rs.close();
	
	  //累计代收
	   ds=0;
 	
	sql="select  sum(money) rmbprice  from FactGatheringTaxRecord where  checkstate=1 and  contractno in (select  code from order_contract where  section='"+SecNo+"')";
	rs=ViewBean.executeQuery(sql);
   if (rs.next()){ ds=rs.getDouble("rmbprice");}
	rs.close();
	 %>
	  <td   >&nbsp;<b><%=fa.getFloat2(rmbprice,2) %></td>
    <td   >&nbsp;<b><%=fa.getFloat2(hlk,2) %></td>
    <td   >&nbsp;<b><%=fa.getFloat2(ds,2) %></td>
</tr>

</table>

</div>
 
<script>
  function bringToExcel(){

   // get all the text
   var pasteText = document.all.report1.innerHTML;

   // copy all the text to clipboard
   window.clipboardData.setData ("Text", pasteText);

     // Start Excel and get Application object.     
     var oXL = new ActiveXObject("Excel.Application");     
     oXL.Visible = true;   
     // Get a new workbook.     
     var oWB = oXL.Workbooks.Add();     
     var oSheet = oWB.ActiveSheet;     
     oSheet.Paste();     
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
</script>

</body>

</html>
