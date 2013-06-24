
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
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>销售月报表</title>
</head>
<%String s_date=request.getParameter("yearmonth");
  String SecNo=getbyte1(request.getParameter("SecNo"));
  String SecNa=SecNo.substring(SecNo.indexOf("-")+1);
  SecNo=SecNo.substring(0,SecNo.indexOf("-"));
   %>
<body>
<DIV align=center id="printdiv">
<input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'"><input type="button" onclick="bringToExcel()" value="导出到Excel"><br>
</div>
 <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
 <div align=left id=report1 style="background-color:#F7F7F7;overflow:auto;width:100%;z-index:2" contentEditable >
 <center> 
 <p align="center"><font size=4><b><%=SecNa+s_date.substring(0,s_date.indexOf("-"))+"年"+s_date.substring(s_date.indexOf("-")+1)+"月" %>销售报表</b></font></p>

<table width="99%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

<%
  String sql1="select  loft,sum(area) area,count(*) num  from room where   seccode='"+SecNo+"'  group by loft order by loft";
  ResultSet rs1=null;
  ResultSet rs=null;
     List list1=new LinkedList();//面积
	 List list3=new LinkedList();//花园/露台面积
     List list2=new LinkedList();//用途
 	 List list4=new LinkedList();//套数	
	 int num=0;
	 
	 List list5=new LinkedList();//面积
	 List list6=new LinkedList();//花园/露台面积
     List list7=new LinkedList();//用途
 	 List list8=new LinkedList();//套数	
	 
	 List list9=new LinkedList();//被换面积
	 List list10=new LinkedList();//被换花园/露台面积
     List list11=new LinkedList();//被换用途
 	 List list12=new LinkedList();//被换套数	
	 
	 List list13=new LinkedList();//被退面积
	 List list14=new LinkedList();//被退花园/露台面积
     List list15=new LinkedList();//被退用途
 	 List list16=new LinkedList();//被退套数	
	
  rs1=ViewBean.executeQuery(sql1);
      double hf_area=0;
		  int hf_num=0;
  double z_area=0;
  int z_num=0;
    double sw_area=0;
	 double sy_area=0;
	  int sw_num=0;
	  int sy_num=0;
	 double c_area=0;
	 double t_area=0;  
	 double l_area=0;
	  int l_num=0;
	    int t_num=0;
		  int c_num=0;
 	while (rs1.next()){
	 double w_area=0;
	 double y_area=0;
	  int w_num=0;
	   int y_num=0;
	  String loft=rs1.getString("loft");
	  String area=rs1.getString("area");
	  z_area+=java.lang.Double.parseDouble(area);
	   int nn=rs1.getInt("num");
	   z_num+=nn;
%>
  <tr align="center" >
    <td   ><%=loft %></td>
    <td    ><%=area %>(<%=nn %>)</td>
    <td ><%
	 String sql="select yong_tu,sum(area) area,count(*) num,sum(ty_area+lu_tai_area) lt_area from room where seccode='"+SecNo+"' and loft='"+loft+"' group by yong_tu";
	   rs=ViewBean1.executeQuery(sql);
	  list1.clear();
	   list2.clear();
	   list4.clear();
	   double wlt_area=0;
	   double ylt_area=0;
	   int i=0;
 	   while (rs.next()){
	      list2.add(getbyte(rs.getString("yong_tu")));
	      list1.add(getbyte(rs.getString("area")));
	      list4.add(getbyte(rs.getString("num")));
		  wlt_area+=rs.getDouble("lt_area");
		  i++;
	   }
	   rs.close();
		  
	 String sqlA="select yong_tu,sum(jzarea) area,count(*) num,sum(ty_area+lu_tai_area) lt_area from order_contract  where state<>3 and section='"+SecNo+"' and loft='"+loft+"' and convert(varchar(7),date,120)<='"+s_date+"' group by yong_tu";
	rs=ViewBean1.executeQuery(sqlA);
	   int ii=0;
	    list7.clear();
	   list5.clear();
	   list8.clear();
	     
 	   while (rs.next()){
	      list7.add(getbyte(rs.getString("yong_tu")));
	      list5.add(getbyte(rs.getString("area")));
	      list8.add(getbyte(rs.getString("num")));
		   ylt_area+=rs.getDouble("lt_area");
		  ii++;
	   }
	   rs.close();
	   
	   
	   sqlA="select yong_tu,sum(jzarea) area,count(*) num,sum(ty_area+lu_tai_area) lt_area from order_contract  where state=3 and section='"+SecNo+"' and loft='"+loft+"' and convert(varchar(7),date,120)< convert(varchar(7),TD_date,120) AND  convert(varchar(7),date,120)='"+s_date+"' group by yong_tu";
	rs=ViewBean1.executeQuery(sqlA);
	     ii=0;
	    list13.clear();
	   list14.clear();
	   list15.clear();
	   list16.clear();
 	   while (rs.next()){
	    //out.print(sqlA);
	      list13.add(getbyte(rs.getString("yong_tu")));
	      list14.add(getbyte(rs.getString("area")));
	      list15.add(getbyte(rs.getString("num")));
		  // ylt_area+=rs.getDouble("lt_area");
		  ii++;
	   }
	   rs.close();
	   
	   ii=0;
	  sqlA="select sum(r.jzarea) area,count(*) num,sum(r.sumprice) price,o.yong_tu from ChangRoomR r,order_contract o  where  r.secno=o.section and r.newloft=o.loft and o.room_no=r.nowroom and r.secno='"+SecNo+"' and r.newloft='"+loft+"' and convert(varchar(7),r.ChangeDate,120)<> convert(varchar(7),r.olddate,120) and  convert(varchar(7),r.olddate,120)='"+s_date+"'  group by o.yong_tu ";
	  rs=ViewBean1.executeQuery(sqlA);
	// out.print(sqlA);
	   int aa=0;//被换套数
	   int hii=0;
	   double aaa=0;//被换面积
	  double a1=0;
	  int a2=0;
	   list9.clear();
	   list10.clear();
	   list11.clear();
	   list12.clear();
	     while (rs.next()){
	       list9.add(getbyte(rs.getString("yong_tu")));
	      list10.add(getbyte(rs.getString("area")));
	       list11.add(getbyte(rs.getString("num")));
		  //aa=rs.getInt("num");
		  //aaa=rs.getDouble("area");
		  hii++;
	   }
	    
	   rs.close();
	 %>
	 
	 
	<table width="99%"  align="center" border=0 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>

	<%if (num==0) {%>
	 <tr align="center"><td >用途　</td><td>未售情况</td><td >本月售情况</td><td>本月变化情况</td><td >本月被换</td><td >本月退房</td><td >累计销售情况</td></tr>
	 
  
	<%}num++; %>
	 <tr valign="top">
	 <td  width="12%"> 
	 <%
	 for (int j3=0;j3<i;j3++){
	 if (j3>1) out.print("<br>");%>
	<%=(String)list2.get(j3) %>   
		 
		<%} %>
		  <br>小计 
			 
	</td>
	  
	 <td  width="12%"> 
	 <%
	    aaa=0;
	  aa=0;
	 a1=0;
	  a2=0;
	 for (int j=0;j<i;j++){
	  %>
	  <%
	   double warea1=java.lang.Double.parseDouble((String)list1.get(j));
	   w_area+=warea1;
	   int wnum1=java.lang.Integer.parseInt((String)list4.get(j));
	      w_num+=wnum1;
	  double warea2=0;
	  int wnum2=0;
	  if (list7.contains((String)list2.get(j))){
	     int index=list7.indexOf((String)list2.get(j));
		 warea2=java.lang.Double.parseDouble((String)list5.get(index));
		 y_area+=warea2;
		 wnum2=java.lang.Integer.parseInt((String)list8.get(index));
		  y_num+=wnum2;
	  }
	 
	  if (list9.contains((String)list2.get(j))){
	     int index=list9.indexOf((String)list2.get(j));
		 aaa=java.lang.Double.parseDouble((String)list10.get(index));
		// aaa=warea2;
		 aa=java.lang.Integer.parseInt((String)list11.get(index));
		  //aa=wnum2;
	  }
	 
	    if (list13.contains((String)list2.get(j))){
	     int index=list13.indexOf((String)list2.get(j));
		 a1=java.lang.Double.parseDouble((String)list14.get(index));
		 
		 a2=java.lang.Integer.parseInt((String)list15.get(index));
		   
	  }  if (j>1) out.print("<br>");%>
	   
		
		<%=fa.getFloat3(warea1-warea2+aaa-a1,2) %>(<%=wnum1-wnum2+aa-a2 %>)
		 
		<%} 
		sw_area+=w_area-y_area+aaa-a1;
		sw_num+=w_num-y_num+aa-a2;
		%>
		<br><%=fa.getFloat3(w_area-y_area+aaa-a1,2) %>(<%=w_num-y_num+aa-a2 %>) 
	</td>
  
    <td  width="12%">
	
	<%
	  sqlA="select yong_tu,sum(jzarea) area,count(*) num ,sum(ty_area+lu_tai_area) lt_area from order_contract  where state<>3 and section='"+SecNo+"' and loft='"+loft+"' and convert(varchar(7),date,120)='"+s_date+"' group by yong_tu";
	rs=ViewBean1.executeQuery(sqlA);
	 //  out.print(sqlA);
	   list7.clear();
	   list5.clear();
	   list8.clear();
	   ylt_area=0;
 	   while (rs.next()){
	     
	      list7.add(getbyte(rs.getString("yong_tu")));
	      list5.add(getbyte(rs.getString("area")));
	      list8.add(getbyte(rs.getString("num")));
		   ylt_area+=rs.getDouble("lt_area");
	   }
	   rs.close();
	
	 %>
	 
	 	 
	  <% y_area=0;
	   y_num=0;
	    a1=0;
	  a2=0;
	 for (int j1=0;j1<i;j1++){
	  if (j1>1) out.print("<br>"); %>
	 <%
	    
	   double warea2=0;
	   int wnum2=0;
	 
	  if (list7.contains((String)list2.get(j1))){
	     int index=list7.indexOf((String)list2.get(j1));
		 warea2=java.lang.Double.parseDouble((String)list5.get(index));
		 y_area+=warea2;
		  
		 wnum2=java.lang.Integer.parseInt((String)list8.get(index));
		  y_num+=wnum2;
	  }
	    if (list13.contains((String)list2.get(j1))){
	     int index=list13.indexOf((String)list2.get(j1));
		 a1=java.lang.Double.parseDouble((String)list14.get(index));
		 
		 a2=java.lang.Integer.parseInt((String)list15.get(index));
		   
	  }
	  
	  
	   if (list9.contains((String)list2.get(j1))){
	     int index=list9.indexOf((String)list2.get(j1));
		 aaa=java.lang.Double.parseDouble((String)list10.get(index));
		// aaa=warea2;
		 aa=java.lang.Integer.parseInt((String)list11.get(index));
		  //aa=wnum2;
	  }
	    %>
		<%=fa.getFloat3(warea2 -aaa+a1,2)%>(<%=wnum2-aa+a2 %>)
		 
		<%} 
		sy_area+=y_area+a1-aaa;
		sy_num+=y_num+a2-aa;
		%>
		<br><%=fa.getFloat3(y_area-aaa+a1,2) %>(<%=y_num-aa+a2 %>) 
	　</td>
	 <td width="12%">
	<%
	 
	  sqlA="select yongtu,sum(jzarea-yjzarea) area,count(*) num,sum(yty_area+ylutai_area-ty_area-lutai_area) lt_area from order_contract_log  where state1=0 and sectionno='"+SecNo+"' and loft='"+loft+"' and convert(varchar(7),change_date,120)<>convert(varchar(7),log_date,120) and convert(varchar(7),change_date,120)='"+s_date+"' group by yongtu";
	rs=ViewBean1.executeQuery(sqlA);
	   ylt_area=0;
	   list7.clear();
	   list5.clear();
	   list8.clear();
 	   while (rs.next()){
	      list7.add(getbyte(rs.getString("yongtu")));
	      list5.add(getbyte(rs.getString("area")));
	      list8.add(getbyte(rs.getString("num")));
		     ylt_area+=rs.getDouble("lt_area");
		   
	   }
	   rs.close();
	
	 %>
	 
	 	 
	  <% y_area=0;
	   y_num=0;
	 for (int j2=0;j2<i;j2++){
	  if (j2>1) %><br>
	 <%
	    
		 
	   double warea2=0;
	   int wnum2=0;
	  if (list7.contains((String)list2.get(j2))){
	     int index=list7.indexOf((String)list2.get(j2));
		 warea2=java.lang.Double.parseDouble((String)list5.get(index));
		  y_area+=warea2;
		 wnum2=java.lang.Integer.parseInt((String)list8.get(index));
		   y_num+=wnum2;
	  }
	  
	    %>
		<%=warea2 %>(<%=wnum2 %>)
		 
		<%}
		
		c_area+=y_area;
		c_num+=y_num;
		
		
		
		 %>
		<br><%=fa.getFloat3(y_area,2) %>(<%=y_num %>) 
	 
	　</td>
     <td  width="12%">  
	 <%
	   sqlA="select sum(-oldarea) area,count(*) num,sum(oldprice) price from ChangRoomR  where  oldsecno='"+SecNo+"' and loft='"+loft+"' and convert(varchar(7),ChangeDate,120)<> convert(varchar(7),olddate,120) and  convert(varchar(7),ChangeDate,120)='"+s_date+"' ";
	 
	rs=ViewBean1.executeQuery(sqlA);
	double oldarea=0;
	int oldnum=0;
	if (rs.next()){
	oldarea=rs.getDouble("area");
	hf_area+=oldarea;
	oldnum=rs.getInt("num");
	hf_num+=oldnum;
	  %>
	  
	  <%=oldarea %>(<%=oldnum %>)
	  <%}rs.close(); %>
	 
    <td width="12%" >
	
	<%
	  sqlA="select yong_tu,sum(jzarea) area,count(*) num,sum(ty_area+lu_tai_area) lt_area from order_contract  where state=3 and section='"+SecNo+"' and loft='"+loft+"' and convert(varchar(7),td_date,120)='"+s_date+"' group by yong_tu";
	rs=ViewBean1.executeQuery(sqlA);
	   ylt_area=0;
	   list7.clear();
	   list5.clear();
	   list8.clear();
 	   while (rs.next()){
	      list7.add(getbyte(rs.getString("yong_tu")));
	      list5.add(getbyte(rs.getString("area")));
	      list8.add(getbyte(rs.getString("num")));
		   ylt_area+=rs.getDouble("lt_area");
	   }
	   rs.close();
	
	 %>
	 
	  <% 
	   y_area=0;
	   y_num=0;
	 for (int j1=0;j1<i;j1++){
	  if (j1>1) %><br>
	   <%
	 
	   double warea2=0;
	   int wnum2=0;
	  
	  if (list7.contains((String)list2.get(j1))){
	     int index=list7.indexOf((String)list2.get(j1));
		 warea2=java.lang.Double.parseDouble((String)list5.get(index));
		  y_area+=warea2;
		 wnum2=java.lang.Integer.parseInt((String)list8.get(index));
		 y_num+=wnum2;
	  }
	  
	    %>
		<%=warea2 %>(<%=wnum2 %>)
		 
		<%} 
		t_area+=y_area;
		t_num+=y_num;
		%>
		<br><%=fa.getFloat3(y_area,2) %>(<%=y_num %>) 
	 
	　</td>
    <td width="12%">
	
	<%
	  sqlA="select yong_tu,sum(jzarea) area,count(*) num,sum(ty_area+lu_tai_area) lt_area from order_contract  where state<>3 and section='"+SecNo+"' and loft='"+loft+"'  and convert(varchar(7),date,120)<='"+s_date+"' group by yong_tu";
	rs=ViewBean1.executeQuery(sqlA);
	   ylt_area=0;
	   list7.clear();
	   list5.clear();
	   list8.clear();
 	   while (rs.next()){
	      list7.add(getbyte(rs.getString("yong_tu")));
	      list5.add(getbyte(rs.getString("area")));
	      list8.add(getbyte(rs.getString("num")));
		    ylt_area+=rs.getDouble("lt_area");
	   }
	   rs.close();
	
	 %>
	 
	 	 
	  <% y_area=0;  y_num=0;
	 for (int j2=0;j2<i;j2++){
	  if (j2>1)%><br>
	  <%
	   
	   double warea2=0;
	   int wnum2=0;
	 
	  if (list7.contains((String)list2.get(j2))){
	     int index=list7.indexOf((String)list2.get(j2));
		 warea2=java.lang.Double.parseDouble((String)list5.get(index));
		   y_area+=warea2;
		 
		 wnum2=java.lang.Integer.parseInt((String)list8.get(index));
		 y_num+=wnum2;
	  }
	   %>
		<%=fa.getFloat3(warea2-aaa+a1,2) %>(<%=wnum2-aa+a2 %>)
		 
		<%} 
		l_area+=y_area-aaa+a1;
		l_num+=y_num-aa+a2;
		%>
		<br><%=fa.getFloat3(y_area-aaa+a1,2) %>(<%=y_num-aa+a2 %>) 
	</td>
 	</table>
	</td>
 
  </tr>
  <%} rs1.close(); %>
  <tr align="center"><td    >合计:</td><td    ><%=fa.getFloat3(z_area,2) %>(<%=z_num %>)</td><td> 
  <table width="99%"  align="center"  cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
 
	 <tr  ><td width="12%"></td><td width="12%"><%=fa.getFloat3(sw_area,2) %>(<%=sw_num %>)</td><td width="12%"><%=fa.getFloat3(sy_area,2) %>(<%=sy_num %>)</td><td width="12%"><%=fa.getFloat3(c_area,2) %>(<%=c_num %>)</td><td width="12%"><%=hf_area %>(<%=hf_num %>)</td><td width="12%"><%=fa.getFloat3(t_area,2) %>(<%=t_num %>)</td><td width="12%"><%=fa.getFloat3(l_area,2) %>(<%=l_num %>)</td></tr>
	 
  
</table>
</td>
</tr>
</table>
 <table width="99%"  align="center" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
 <tr align="center">
   <td   >幢号</td>
 <td   >本月销售额</td>
  <td   >本月变化差额</td>
  <td   >本月退房额</td>
<!--<td>本月换房金额</td>-->
    <td  >本月回笼款</td>
    <td   >本月代收款</td>
    <td  >累计总销售额</td>
    <td   >累计回笼款</td>
    <td   >累计代收款</td>
 
</tr>
<%
   sql1="select  loft,sum(area) area  from room where seccode='"+SecNo+"' group by loft order by loft";

  rs1=ViewBean1.executeQuery(sql1);
 	while (rs1.next()){
	double rmbprice=0;
	double c_rmbprice=0;
	float youhui=0;
	float youhui1=0;
	double td=0;
	String loft=rs1.getString("loft");
	//算本月销售金额
	 String sql="select sum(rmbprice) rmbprice  from order_contract where  loft='"+loft+"' and state<>3 and  section='"+SecNo+"' and convert(varchar(7),date,120)='"+s_date+"'";

      rs=ViewBean.executeQuery(sql);
	
    if (rs.next()){ rmbprice=rs.getDouble("rmbprice");}
	
	rs.close();
	//计算在本月发生改变
	sql="select sum(yrmbprice-rmbprice) rmbprice  from order_contract_log where    loft='"+loft+"' and state1=0 and  sectionno='"+SecNo+"' and convert(varchar(7),change_date,120)<>  convert(varchar(7),log_date,120) and convert(varchar(7),change_date,120)='"+s_date+"'";
     
	 rs=ViewBean.executeQuery(sql);
	if (rs.next())c_rmbprice=rs.getDouble("rmbprice");
	rs.close();
 
	
	    //计算本月退订
	  sql="select sum(rmbprice) rmbprice  from order_contract where loft='"+loft+"' and state=3 and  section='"+SecNo+"' and convert(varchar(7),td_date,120)='"+s_date+"'";
   rs=ViewBean.executeQuery(sql);
   if (rs.next()){ td=rs.getDouble("rmbprice");}
    //本月实际的销售金额
 //本月换房金额
	 	String  sqlA="select sum(oldarea) area,count(*) num,sum(oldprice) price from ChangRoomR  where  oldsecno='"+SecNo+"' and loft='"+loft+"' and convert(varchar(7),ChangeDate,120)<> convert(varchar(7),olddate,120) and   convert(varchar(7),ChangeDate,120)='"+s_date+"' ";
	 rs.close();
	rs=ViewBean.executeQuery(sqlA);
	double oldprice=0;
	String oldnum="";
	if (rs.next()) 
	oldprice=rs.getDouble("price");
	 rs.close();
	  

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
    <td   >&nbsp;<%=fa.getFloat3(rmbprice,2) %></td>
	<td   >&nbsp;<%=fa.getFloat3(c_rmbprice,2) %></td>
	<td   >&nbsp;<%=fa.getFloat3(td,2) %></td>
	<!--<td   >&nbsp;<%=fa.getFloat3(oldprice,2) %></td>-->
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
    if (rs.next()){ rmbprice=rs.getDouble("rmbprice");}
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
	
	double  rmbprice=0;
	 double  c_rmbprice=0;
//本月项目累计
	  //算本月销售金额
	String  sql="select sum(rmbprice) rmbprice  from order_contract where    state<>3 and  section='"+SecNo+"' and convert(varchar(7),date,120)='"+s_date+"'";

 //  String sql="select sum(rmbprice) rmbprice  from order_contract where loft='"+loft+"' and state<>3 and  section='"+SecNo+"' and convert(varchar(7),date,120)='"+s_date+"'";
     rs=ViewBean.executeQuery(sql);
	
    if (rs.next()){ rmbprice=rs.getDouble("rmbprice");}
		 
	rs.close();
	//计算在本月变化
	sql="select sum(rmbprice-yrmbprice) rmbprice  from order_contract_log where      state1=0 and  sectionno='"+SecNo+"' and convert(varchar(7),change_date,120)<>  convert(varchar(7),log_date,120) and convert(varchar(7),change_date,120)='"+s_date+"'";
     
	 rs=ViewBean.executeQuery(sql);
	if (rs.next())c_rmbprice=rs.getDouble("rmbprice");
	rs.close();
 double td=0;

	    //计算本月退订
	  sql="select sum(rmbprice) rmbprice  from order_contract where  state=3 and  section='"+SecNo+"' and convert(varchar(7),td_date,120)='"+s_date+"'";
   rs=ViewBean.executeQuery(sql);
   if (rs.next()){ td=rs.getDouble("rmbprice");}
    //本月实际的销售金额
	//rmbprice=rmbprice-td;
	 
	
	  
	  
	//本月回笼金额
	double hlk=0;
    //本月实收款
	sql="select  sum(factmoney*CurrRate) rmbprice  from FactGatheringRecord where checkstate=1 and  contractno in (select  code from order_contract where    section='"+SecNo+"')  and convert(varchar(7),Gather_Date,120)='"+s_date+"'";
	rs=ViewBean.executeQuery(sql);
   if (rs.next()){ hlk=rs.getDouble("rmbprice");}
   rs.close();
   //本月放款
	sql="select  sum(FactMonye) rmbprice  from FactAjCharges where  checkstate=1 and  contractno in (select  code from order_contract where    section='"+SecNo+"') and convert(varchar(7),FactDate,120)='"+s_date+"'";
	rs=ViewBean.executeQuery(sql);
   if (rs.next()){ hlk+=rs.getDouble("rmbprice");}
	rs.close();
	
	  //本月代收
	 double  ds=0;
 	
	sql="select  sum(money) rmbprice  from FactGatheringTaxRecord where  checkstate=1 and  contractno in (select  code from order_contract where  section='"+SecNo+"') and convert(varchar(7),date,120)='"+s_date+"'";
	rs=ViewBean.executeQuery(sql);
   if (rs.next()){ ds=rs.getDouble("rmbprice");}
	rs.close();
	//本月换房金额
	 	String  sqlA="select sum(oldarea) area,count(*) num,sum(oldprice) price from ChangRoomR  where  oldsecno='"+SecNo+"'   and convert(varchar(7),ChangeDate,120)<> convert(varchar(7),olddate,120) and   convert(varchar(7),ChangeDate,120)='"+s_date+"' ";
	 
	rs=ViewBean.executeQuery(sqlA);
	double oldprice=0;
	String oldnum="";
	if (rs.next()) 
	oldprice=rs.getDouble("price");
	 rs.close();
	 %>
<tr><td><b>总计:</td>
   <td   >&nbsp;<b><%=fa.getFloat3(rmbprice,2) %></td>
   <td   >&nbsp;<b><%=fa.getFloat3(c_rmbprice,2) %></td>
   <td   >&nbsp;<b><%=fa.getFloat3(td,2) %></td>
   <!-- <td   >&nbsp;<b><%=fa.getFloat3(oldprice,2) %></td>--> 
    <td   >&nbsp;<b><%=fa.getFloat2(hlk,2) %></td>
    <td   >&nbsp;<b><%=fa.getFloat2(ds,2) %></td>
	<%
	
	  rmbprice=0;
	 

	//算累计销售金额
     sql="select sum(rmbprice) rmbprice  from order_contract where  state<>3 and  section='"+SecNo+"'  and convert(varchar(7),Date,120)<='"+s_date+"'";
     rs=ViewBean.executeQuery(sql);
    if (rs.next()){ rmbprice=rs.getFloat("rmbprice");}
	rs.close();
	  
	//累计回笼金额
	 hlk=0;
    //累计实收款
	sql="select  sum(factmoney*CurrRate) rmbprice  from FactGatheringRecord where checkstate=1 and  contractno in (select  code from order_contract where    section='"+SecNo+"')  and convert(varchar(7),Gather_Date,120)<='"+s_date+"'";
	rs=ViewBean.executeQuery(sql);
   if (rs.next()){ hlk=rs.getDouble("rmbprice");}
   rs.close();
   //累计放款
	sql="select  sum(FactMonye) rmbprice  from FactAjCharges where  checkstate=1 and  contractno in (select  code from order_contract where    section='"+SecNo+"')  and convert(varchar(7),FactDate,120)<='"+s_date+"'";
	rs=ViewBean.executeQuery(sql);
   if (rs.next()){ hlk+=rs.getDouble("rmbprice");}
	rs.close();
	
	  //累计代收
	   ds=0;
 	
	sql="select  sum(money) rmbprice  from FactGatheringTaxRecord where  checkstate=1 and  contractno in (select  code from order_contract where  section='"+SecNo+"')  and convert(varchar(7),Date,120)<='"+s_date+"'";
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
