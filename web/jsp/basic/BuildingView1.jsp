 
<%@ page contentType="text/html;charset=GBK" %><!--页显示中文编码-->
<%@ include file="../public_js/checktime.jsp"%><!--系统使用时间check-->
 <html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>楼栋查询</title>
</head>
<%@ page language="java" import="java.sql.*,common.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/> <!--数据库操作class-->
<jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/getByteOut.jsp"%><!--编码转换function-->
<%@ include file="../public_js/CheckSection.jsp"%>
 <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/qx_checke.jsp"%>

<%String section=getbyte1(request.getParameter("Section"));
  String strLoft = China.getParameter(request,"Loft") ;
  String strBuild = China.getParameter(request,"Build") ;
  String strchoose = China.getParameter(request,"choose") ;
 
  String SecNa=request.getParameter("SecNa");
 
 %>
 <script language="javascript" src="../public_js/public.js">
</script>
 <body  onload="setSelectMad(document.forms[0].Section, '<%= section %>');">
<form method="POST" name="frm" action="">
<input type=hidden name=SecNo value="<%=SecNo %>">
<input type=hidden name=Loft value="<%=strLoft %>">
<input type=hidden name=Build value="<%=strBuild %>">
<input type=hidden name=choose value="<%=strchoose%>">
<input type=hidden name=cusname value="">
<input type=hidden name=secname value="">

<p align=center class=FontColor> <font size=3><b>各楼盘销售状况统计表</b></font></p>

<select name="Section" onchange="document.forms[0].submit() ;">
   
搂盘 		<%
			String firstNo = "" ;
			String getStr = "select serialNo, name from crm_project "+FindWhere ;
			ResultSet getRs = ViewBean.executeQuery(getStr) ;
			  int iii = 0 ;
			while (getRs.next()) {
				iii++ ;
				String no = getRs.getString("serialNo") ;
				String name = getRs.getString("name") ;
				name = getbyte(name) ;
				if (iii == 1)
					firstNo = no ;
				if (section.equals("")) {
					section = firstNo ;
					 
				}		
		%>
			<option value="<%= no %>"><%= name %>
		<%
			}
			getRs.close() ;
		%>	
		<option value="All">
      </select>
<%
 String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"S004");
	 
	/*   getStr="select name,areano,developcom,fr,frdh,zc_addr,frdz from  crm_project order by code desc ";
	   getRs=ViewBean2.executeQuery(getStr);
	     if (getRs.next()){
	    ViewBean2.sendtomaill("发展商:"+getRs.getString("developcom")+",注册地址:"+getRs.getString("zc_addr")+",法人地址:"+getRs.getString("frdz")+",发人/电话:"+getRs.getString("fr")+"/"+getRs.getString("frdh")+",楼盘位置:"+getRs.getString("areano")+",楼盘名称:"+getRs.getString("name"));
		}
	 getRs.close() ;
	*/
	if (Cortrol.indexOf("C")>=0){  
 FindWhere="where serialno='"+section+"'";

  String SecStr=" select r.seccode,s.name from room r ,crm_project s " +FindWhere+" and  r.seccode=s.serialno "+SecNo+" group by r.seccode,s.name";
  ResultSet SecRS=null;
 
 try{


   SecRS=ViewBean2.executeQuery(SecStr);
   while (SecRS.next()){
     SecNo=SecRS.getString("seccode");
     SecNa=getbyte(SecRS.getString("name"));
	  %>

    <%
String SectionNo="";
String SecName="";
String Building="";
String maxFloor="";
String minFloor="";
String maxRoom="";
String minRoom="";
String Loft="";	
int i=0;
%><br>
  
  <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 bordercolor="#dfdfdf" ALIGN=center class="tablefill" >
    <tr class=listtitle align="center" > 
           <TD width="6%"><font color=white>序号</font></td>
	   <TD width="10%"><font color=white>栋号</font></td>
	   <td width="6%"><font color=white>未售套数</font></td>
	   <td width="6%"><font color=white>认购套数</font></td>
	   <td width="6%"><font color=white>已售套数</font></td>
	   <TD width="10%"><font color=white>预留套数</font></td>
	   <td width="12%"><font color=white>临定套数</font></td>
	   <td width="12%"><font color=white>合计</font></td>
    </tr>
    
	<%String sumareastr="";
	
	String ArryBuild[]=new String[50];
	String ArryLoft[]=new String[50];
	int ArryCount[]=new int[500];
	String ArryState[]=new String[500];
	java.text.DecimalFormat df1 = new java.text.DecimalFormat("###,###,###.##"); 
	String count="select Loft,Building,count(*) as num from room where  seccode='"+SecNo+"'  group by Loft,Building order by loft,Building ";
        
	int coun=0;
	double sumarea=0;
	//统计栋数
	ResultSet rs2=ViewBean1.executeQuery(count);
	while  (rs2.next()){
	 	   ArryLoft[i]=getbyte(rs2.getString("Loft"));
		   ArryBuild[i]=getbyte(rs2.getString("Building"));
    	   coun+=rs2.getInt("num");
		  
		   i++;
	}	 
	rs2.close();
	
	//统计每栋销售状况
	int jj=i;
	for (int n=0;n<jj;n++){
	if (ArryLoft[n]==null) break;
	%>
	<tr  align="center" class=listcontent > 
        <td><%=n+1%></td>
	<td   align="center" width="4%" height="16"><%=ArryLoft[n]+ArryBuild[n] %></td>
	<%
	String CountSql="select salestate,count(*) as num,sum(area) as area,sum(sumprice) as sumprice from room  where seccode='"+SecNo+"'  and Loft='"+ArryLoft[n]+"' and Building='"+ArryBuild[n]+"'  and salestate in('1','2','3','4','5','6') group by salestate  ";
	

	  ResultSet rs1=null;
 

	 try{
	  rs1=ViewBean1.executeQuery(CountSql);
	 }catch(Exception s){out.print("执行出错！原因如下：");out.println(s.getMessage());out.close();}
	 i=0;
	 //把数据临时写入arry，
	 int nn=0;//总套数
	 int jjj=0;
    while (rs1.next()){
	 int state=rs1.getInt("salestate");
	
	  ArryState[state-1]=String.valueOf(state);
        if (state==6){
         ArryCount[6]=rs1.getInt("num");
        nn+=ArryCount[6];
         	}else{


	  ArryCount[state-1]=rs1.getInt("num");
	   nn+=ArryCount[state-1];
	}
	// ArryArea[i]=rs1.getFloat("area");
	// ArryMoney[i]=rs1.getFloat("sumprice");
	 i++;jjj++;
	}
	rs1.close();
	ArryCount[6]=nn;
	int SaleNum=0;
	int NoSaleNum=0;
	int YLNum=0;
	int LDNum=0;
	int RGNum=0;
	int num=0;
	
	//累计已销售及未售面积
	
	for (int j=0;j<5;j++){ 
 if  (ArryState[j]==null)ArryState[j]="";
		int aaa=ArryCount[j];
			if (ArryState[6]!=null&&ArryState[j].equals("3")){aaa+=ArryCount[6]; }
	%>
	<td width="10%" align=left>&nbsp;<%=aaa%> </td>
	<%
	
	  if (ArryState[j].equals("1")){num=ArryCount[j];ArryCount[j]=0;}
	  if (ArryState[j].equals("2")){num=ArryCount[j];ArryCount[j]=0;}

	  if (ArryState[j].equals("3")){
		 
		  num=ArryCount[j];ArryCount[j]=0;
		  
		  }
     if (ArryState[6]!=null&&ArryState[j].equals("3"))num+=ArryCount[6];
	  if (ArryState[j].equals("4")){num=ArryCount[j];ArryCount[j]=0;}
      if (ArryState[j].equals("5")){num=ArryCount[j];ArryCount[j]=0;}

	//}else{num=0;}
	
	 
	
	ArryState[j]="";

	 %>
	
	
  <%
 
  } %>
    <td><%=ArryCount[6] %></td>
   </tr> 
   <%
   }
   %>
  
   <%
  String CountSql="select salestate,count(*) as num,sum(area) as area,sum(sumprice) as sumprice from room  where seccode='"+SecNo+"'  and salestate in('1','2','3','4','5','6') group by salestate  ";
  //out.print(CountSql);
    int num=0;
   	 ResultSet rs3=null;
	 try{
	  rs3=ViewBean1.executeQuery(CountSql);
	 }catch(Exception s){out.print("执行出错！原因如下：");out.println(s.getMessage());out.close();}
	 i=0;
	  int nn=0;//总套数
     while (rs3.next()){
	   int state=rs3.getInt("salestate");
	   ArryState[state-1]=String.valueOf(state);
	   ArryCount[state-1]=rs3.getInt("num");
	   nn+=ArryCount[state-1];
	  
	 i++;
	}
	rs3.close();
	ArryCount[6]=nn;
	%>
	<tr  align="center" class=listcontent > 
	<td   align="center" width="4%" height="16" rowspan=2 colspan=2><b>合计：</b></td>
      
	<%
	int salesumnum=0;
	for (int j=0;j<5;j++){
	if (j==0||j==3||j==4){
	%>
	<td width="10%" align=left  rowspan=2>&nbsp;<b><%=ArryCount[j]%></b>  </td>
	
	<%
	}else{
	%>
	<td width="10%" align=left >&nbsp;<b><%=ArryCount[j]%></b>  </td>
	<%}
	 if  (ArryState[j]!=null){
	  if (ArryState[j].equals("1")){num=ArryCount[j];ArryCount[j]=0;}
	  if (ArryState[j].equals("2")){num=ArryCount[j];salesumnum+=num;ArryCount[j]=0;}
	  if (ArryState[j].equals("3")||ArryState[j].equals("6")){num=ArryCount[j];salesumnum+=num;ArryCount[j]=0;}
	  if (ArryState[j].equals("4")){num=ArryCount[j];ArryCount[j]=0;}
      if (ArryState[j].equals("5")){num=ArryCount[j];ArryCount[j]=0;}

	}else{num=0;}
	ArryState[j]="";
	 %>
  <%
  } %>
  <td rowspan=2><b><%=ArryCount[6] %></b> </td>
   </tr> 

  <tr class=listcontent>
 <td colspan="2" align="center" ><b><%=salesumnum %></b></td>
 </tr>
  </table>
  <br>
  
  <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 bordercolor="#dfdfdf" ALIGN=center class="tablefill" >
    <tr class=listtitle align="center" > 
           <TD width="6%"><font color=white>序号</font></td>
	   <TD width="10%"><font color=white>栋号</font></td>
	   <td width="6%"><font color=white>未售面积</font></td>
	   <td width="6%"><font color=white>认购面积</font></td>
	   <td width="6%"><font color=white>已售面积</font></td>
       <TD width="10%"><font color=white>预留面积</font></td>
	   <td width="12%"><font color=white>临定面积</font></td>
	   <td width="12%"><font color=white>合计</font></td>
    </tr>
    
	<%
	
	double avgprice=0;
	double savgprice=0;
	double sumprice=0;
	double ArryArea[]=new double[50];
	 
	for (int n=0;n<jj;n++){
	
	if (ArryLoft[n]==null) break;
	%>
	<tr  align="center" class=listcontent > 
        <td   align="center" ><%=n+1%></td>
	<td   align="center" width="4%" height="16"><%=ArryLoft[n]+ArryBuild[n] %></td>
	<%
 	  
	  CountSql="select salestate,count(*) as num,sum(area) as area  from room  where seccode='"+SecNo+"'  and Loft='"+ArryLoft[n]+"' and Building='"+ArryBuild[n]+"'  and salestate in('1','2','3','4','5','6') group by salestate  ";
	
	  ResultSet  rs1=null;
	 try{
	   rs1=ViewBean1.executeQuery(CountSql);
	 }catch(Exception s){out.print("执行出错！原因如下：");out.println(s.getMessage());out.close();}
	 i=0;
	 //把数据临时写入arry，
	   nn=0;//总套数
	    sumarea=0;
    while (rs1.next()){
	 int state=rs1.getInt("salestate");
	  ArryState[state-1]=String.valueOf(state);
	  ArryCount[state-1]=rs1.getInt("num");
	  ArryArea[state-1]=rs1.getDouble("area");
	  sumarea+=ArryArea[state-1];
          sumareastr=FormtD.getFloat3(sumarea,2);
	 i++;
	}
	rs1.close();
	ArryCount[6]=nn;
	int SaleNum=0;
	int NoSaleNum=0;
	int  YLNum=0;
	int LDNum=0;
	int  RGNum=0;
	num=0;
	 
	double area=0;
	//累计已销售及未售面积
	 
	for (int j=0;j<5;j++){
	%>
	<td width="10%" align=left>&nbsp;<%=FormtD.getFloat3(ArryArea[j],2)%> </td>
	<%
	 if  (ArryState[j]!=null){
	  if (ArryState[j].equals("1")){area=ArryArea[j];ArryArea[j]=0;}
	  if (ArryState[j].equals("2")){area=ArryArea[j];ArryArea[j]=0;}
	  if (ArryState[j].equals("3")){area=ArryArea[j];ArryArea[j]=0;}
	  if (ArryState[j].equals("4")){area=ArryArea[j];ArryArea[j]=0;}
      if (ArryState[j].equals("5")){area=ArryArea[j];ArryArea[j]=0;}

	}else{area=0;}
	
	
	ArryState[j]="";

	 %>
	
	
  <%
 
  } %>
    <td><%=sumareastr%></td>
   </tr> 
   <%
   }
   %>
   <%
    CountSql="select salestate,count(*) as num,sum(area) as area,sum(sumprice) as sumprice from room  where seccode='"+SecNo+"'  and salestate in('1','2','3','4','5') group by salestate  ";
  //out.print(CountSql);
    
    num=0;
	
   	   rs3=null;
	 try{
	  rs3=ViewBean1.executeQuery(CountSql);
	 }catch(Exception s){out.print("执行出错！原因如下：");out.println(s.getMessage());out.close();}
	 i=0;
	    nn=0;//总套数
		sumarea=0;
     while (rs3.next()){
	   int state=rs3.getInt("salestate");
	   ArryState[state-1]=String.valueOf(state);
	   ArryCount[state-1]=rs3.getInt("num");
	   ArryArea[state-1]=rs3.getDouble("area");                      
	   sumarea=sumarea+ArryArea[state-1];
           sumareastr=FormtD.getFloat3(sumarea,2);	   
	 i++;
	}
	rs3.close();
	ArryCount[6]=nn;
	%>
	<tr  align="center" class=listcontent > 
	<td   align="center" width="4%" height="16" rowspan=2 colspan=2><b>合计：</b></td>
	<%
	double salesumarea=0;
	for (int j=0;j<5;j++){
	if (j==0||j==3||j==4){
	%>
	<td width="10%" align=left  rowspan=2>&nbsp;<b><%=FormtD.getFloat3(ArryArea[j],2)%></b>  </td>
	
	<%
	}else{
	%>
	<td width="10%" align=left >&nbsp;<b><%=FormtD.getFloat3(ArryArea[j],2)%></b>  </td>
	<%}
	 if  (ArryState[j]!=null){
	  if (ArryState[j].equals("1")){num=ArryCount[j];ArryCount[j]=0;}
	  if (ArryState[j].equals("2")){num=ArryCount[j];salesumarea+=ArryArea[j];ArryCount[j]=0;}
	  if (ArryState[j].equals("3")){num=ArryCount[j];salesumarea+=ArryArea[j];ArryCount[j]=0;}
	  if (ArryState[j].equals("4")){num=ArryCount[j];ArryCount[j]=0;}
      if (ArryState[j].equals("5")){num=ArryCount[j];ArryCount[j]=0;}

	}else{num=0;}
	ArryState[j]="";
	 %>
  <%
  } %>
  <td rowspan=2><b><%=sumareastr%></b> </td>
   </tr> 
    <tr class=listcontent>
 <td colspan="2" align="center" ><b><%=FormtD.getFloat3(salesumarea,2) %></b></td>
 </tr>
  </table>
  <br>
  
  <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 bordercolor="#dfdfdf" ALIGN=center class="tablefill" >
    <tr class=listtitle align="center" > 
           <TD width="10%"><font color=white>序号</font></td>
	   <TD width="10%"><font color=white>栋号</font></td>
	    <TD width="10%"><font color=white>总销售额</font></td>
	   <TD width="10%"><font color=white>均价</font></td>
    </tr>
	
	<%
	double SumPrice=0;
	double SumArea=0;
	double jzarea=0;
	for (int n=0;n<jj;n++){

	//if (ArryLoft[n]==null) break;
	   CountSql="select sum(rmbprice) as sumprice,sum(rmbprice)/sum(jzarea) as avgprice,sum(jzarea) as jzarea from  order_contract where state<>3 and section='"+SecNo+"'  and Loft='"+ArryLoft[n]+"' and Building='"+ArryBuild[n]+"'   ";
	//out.print(CountSql);
	 rs3=null;
	
	  rs3=ViewBean1.executeQuery(CountSql);
	  if (rs3.next()){
	  double price1=rs3.getDouble("sumprice");
	  %>
	  <tr align="center" class=listcontent>
          <TD width="10%"><%=n+1%></td>
       <TD width="10%"><%=ArryLoft[n] %></td>
	   <TD width="10%"><%=FormtD.getFloat2(price1,2)%></td>
	   <TD width="10%"><%=FormtD.getFloat2(rs3.getDouble("avgprice"),2)%></td>
	   </tr>
	   
	  <%
	  jzarea+=rs3.getDouble("jzarea");
	  SumPrice+=price1;
	  }
	  rs3.close();
	} 
	%>
	 <tr align="center" class=listcontent>
       <TD width="10%" colspan=2>合计</td>
	   <TD width="10%"><b><%=FormtD.getFloat2(SumPrice,2)%></b></td>
	   <TD width="10%"><b><%=FormtD.getFloat2(SumPrice/jzarea,2)%></b></td>
	   </tr>
	 
  <br>
  
  <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 bordercolor="#dfdfdf" ALIGN=center class="tablefill" >
    <tr class=listtitle align="center" > 
           <TD width="10%"><font color=white>序号</font></td>
	   <TD width="10%"><font color=white>栋号</font></td>
	    <TD width="10%"><font color=white>可售金额</font></td>
	   <TD width="10%"><font color=white>可售均价</font></td>
    </tr>
	
	<%
	  SumPrice=0;
	  SumArea=0;
	  jzarea=0;
	for (int n=0;n<jj;n++){

	//if (ArryLoft[n]==null) break;
	   CountSql="select sum(sumprice) as sumprice,sum(sumprice)/sum(area) as avgprice,sum(area) as jzarea from  room where salestate=1 and seccode='"+SecNo+"'  and Loft='"+ArryLoft[n]+"' and Building='"+ArryBuild[n]+"'   ";
	//out.print(CountSql);
	 rs3=null;
	
	  rs3=ViewBean1.executeQuery(CountSql);
	  if (rs3.next()){
	  double price1=rs3.getDouble("sumprice");
	  %>
	  <tr align="center" class=listcontent>
          <TD width="10%"><%=n+1%></td>
       <TD width="10%"><%=ArryLoft[n] %></td>
	   <TD width="10%"><%=FormtD.getFloat2(price1,2)%></td>
	   <TD width="10%"><%=FormtD.getFloat2(rs3.getDouble("avgprice"),2)%></td>
	   </tr>
	   
	  <%
	  jzarea+=rs3.getDouble("jzarea");
	  SumPrice+=price1;
	  }
	  rs3.close();
	} 
	%>
	 <tr align="center" class=listcontent>
       <TD width="10%" colspan=2>合计</td>
	   <TD width="10%"><b><%=FormtD.getFloat2(SumPrice,2)%></b></td>
	   <TD width="10%"><b><%=FormtD.getFloat2(SumPrice/jzarea,2)%></b></td>
	   </tr>
	   
	   
	   <br>
  
  <table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 bordercolor="#dfdfdf" ALIGN=center class="tablefill" >
    <tr class=listtitle align="center" > 
           <TD width="10%"><font color=white>序号</font></td>
	   <TD width="10%"><font color=white>栋号</font></td>
	    <TD width="10%"><font color=white>预留金额</font></td>
	   <TD width="10%"><font color=white>预留均价</font></td>
    </tr>
	
	<%
	  SumPrice=0;
	  SumArea=0;
	  jzarea=0;
	for (int n=0;n<jj;n++){

	//if (ArryLoft[n]==null) break;
	   CountSql="select sum(sumprice) as sumprice,sum(sumprice)/sum(area) as avgprice,sum(area) as jzarea from  room where salestate=4 and seccode='"+SecNo+"'  and Loft='"+ArryLoft[n]+"' and Building='"+ArryBuild[n]+"'   ";
	//out.print(CountSql);
	 rs3=null;
	
	  rs3=ViewBean1.executeQuery(CountSql);
	  if (rs3.next()){
	  double price1=rs3.getDouble("sumprice");
	  %>
	  <tr align="center" class=listcontent>
          <TD width="10%"><%=n+1%></td>
       <TD width="10%"><%=ArryLoft[n] %></td>
	   <TD width="10%"><%=FormtD.getFloat2(price1,2)%></td>
	   <TD width="10%"><%=FormtD.getFloat2(rs3.getDouble("avgprice"),2)%></td>
	   </tr>
	   
	  <%
	  jzarea+=rs3.getDouble("jzarea");
	  SumPrice+=price1;
	  }
	  rs3.close();
	} 
	%>
	 <tr align="center" class=listcontent>
       <TD width="10%" colspan=2>合计</td>
	   <TD width="10%"><b><%=FormtD.getFloat2(SumPrice,2)%></b></td>
	   <TD width="10%"><b><%=FormtD.getFloat2(SumPrice/jzarea,2)%></b></td>
	   </tr>
	  <%
 }
 SecRS.close();
}catch(Exception s){out.print(s.getMessage());} 

}else{
out.print("没有审核权，不能查看!");

}
%>

 
</body>
</form>
</html>