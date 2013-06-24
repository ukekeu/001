<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<title>费用支出月计划清单</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<LINK href="../class/mad.css" rel=stylesheet>
<script src="js/mad.js"> </script>
</head>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>

<%@ page contentType="text/html;charset=GBK" %>
<%@ page import = "java.sql.*,common.*,java.util.*" %>
<jsp:useBean id = "changePriceListBean" scope = "page" class = "ConnDatabase.SDatabase" />
<jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
<jsp:useBean id = "FormatD" scope = "page" class = "FormatData.FormatData" />
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/Repalce.jsp"%>
<%@ include file="../public_js/CheckSection.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
   <%@ include file="../public_js/qx_checke.jsp"%>
<script>
this.resizeTo(screen.availWidth,screen.availHeight)
this.moveTo(0,0)
this.focus()
</script>
  <%
      String yeahmonth=China.getParameter(request,"yearmonth");
      String section=China.getParameter(request,"section");
      String no=China.getParameter(request,"no");
      java.util.Date curDate=new java.util.Date();
      int CurYear=curDate.getYear()+1900;
      int CurMonth=curDate.getMonth()+1;
      int CurDay=curDate.getDate(); 
	  String sel=(String)request.getParameter("sel");
      if(sel==null) sel="1";	
    List list1=new LinkedList(); 
	List list2=new LinkedList(); 
	List list3=new LinkedList();
	List list4=new LinkedList();
	if (!section.equals("")&&!yeahmonth.equals("")){
	  String SQL="select a.charges_name+substring(convert(char(8),b.out_date,120),0,8) nn ,sum(b.fact_value) fact_value    from out_charges a,fact_out_charges b  where a.code=b.out_charges  and substring(convert(char(5),b.out_date,120),0,5)= substring('"+yeahmonth+"',0,5)  and a.section_no='"+section+"' group by a.charges_name+substring(convert(char(8),b.out_date,120),0,8) order by a.charges_name+substring(convert(char(8),b.out_date,120),0,8)";

	      ResultSet aRs  = ViewBean.executeQuery(SQL) ;
 
		while (aRs.next()) {	
		   list1.add(getbyte(aRs.getString("nn")));
		   list2.add(getbyte(aRs.getString("fact_value")));
		  //  list3.add(getbyte(aRs.getString("mm")));
		}
		aRs.close();
	}	
//权限审核
    String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"JC006");
	 Cortrol+=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"market3");
    if (Cortrol==null)Cortrol="";
	  if (!yeahmonth.equals("")&&CurYear!=Integer.parseInt(yeahmonth))
	 { CurMonth=12;
	 CurYear=Integer.parseInt(yeahmonth);
	 }
	
      String sql1 ="select SerialNo,Name from CRM_Project where SERIALNO='"+section+"'";
      ResultSet rs2=ViewBean.executeQuery(sql1);	
	  String sec="";
	  String no1="";
	  String cusno="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
       }
	  if (!no1.equals(""))defaultNo=no1;
	    rs2.close();
	
%>

<body  onload="bringToExcel();" topmargin="0">
<form name="frm" method="post" action="" onsubmit="return Validate(this);">
 
 
 
 
  <div align=left id=report1 ;height:100%px;overflow:auto;width:100%;z-index:2" contentEditable >
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<center><font size=4><b><%=sec %>项目营销费用支出与销售情况统计表</b></font></center>
<br>
<table  width="99%"><tr><td align="left"><%= CurYear%>年度</td><td align="right">单位:万元</td></tr></table>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="99%" id="AutoNumber1">
   <tr align="center"   > 
		<td > 费用名称 </td>
		<td>   用  途  </td>
		<td>  计划金额(万元)</td>
		<%for (int i=1;i<=CurMonth;i++){ %>
    <td  ><%=i %></td>
	<%} %>
	 
		<td>合计</td>
		 
    </tr><%
	 int i=0; double factsum=0;
	  double jh_sum=0,zc_sum=0;
	if (!section.equals("")&&!yeahmonth.equals("")){
	  String SQL="select a.code,a.charges_name,a.bak,a.purpose,a.charges_value  from out_charges a  where substring(a.out_yeahmonth,0,5)= "+yeahmonth+"  and a.section_no='"+section+"' order by a.charges_name";
 
	  ResultSet aRs = ViewBean.executeQuery(SQL) ;
	 	while (aRs.next()) {		
		factsum=0;	
		   String code=getbyte(aRs.getString("code"));
		   String charges_name=getbyte(aRs.getString("charges_name"));
		   String charges_value=getbyte(aRs.getString("charges_value"));
		    jh_sum+=Double.parseDouble(charges_value);
		   String purpose=getbyte(aRs.getString("purpose"));
		  String bak=getbyte(aRs.getString("bak"));
		 
	%>
    <tr   align="center">  
	 <td>&nbsp;<%=charges_name %></td>
    <td > <%=purpose %> </td> 
    <td > <%=charges_value %></td> 
	
	   <%for (int ii=1;ii<=CurMonth;ii++){ 
       String mm="";
	  if (ii<10) mm=String.valueOf(CurYear)+"-"+"0"+String.valueOf(ii);
	  else  mm=String.valueOf(CurYear)+"-"+String.valueOf(ii);
	  String mmm="0"; 
	  if (list1.contains(charges_name+mm)){
		   int index=list1.indexOf(charges_name+mm);
		   mmm=(String)list2.get(index);
		   factsum+=Double.parseDouble(mmm);
	  }
  %>
    <td  ><% if (Cortrol.indexOf("E")>=0&&Double.parseDouble(mmm)>0){ %><a href="#" onclick="openwin('modi_out_charges.jsp?code=<%=code %>&section=<%=section %>&yearmonth=<%=yeahmonth %>',600,300,100,100);" title="点击可以进行修改数据"><%=mmm %></a><%}else{ %><%=mmm %><%} %></td>
	<%} %>
  <td  ><b><%=FormatD.getFloat2(factsum,2) %></b></td>
    
    </tr>
	<%i++;zc_sum+=factsum;
		}
		aRs.close();
		factsum=0;
		list1.clear();
      list2.clear();
	  list3.clear();
	   SQL="select substring(convert(char(8),b.out_date,120),0,8) nn ,sum(b.fact_value) fact_value    from out_charges a,fact_out_charges b  where a.code=b.out_charges  and substring(convert(char(5),b.out_date,120),0,5)= substring('"+yeahmonth+"',0,5)  and a.section_no='"+section+"' group by substring(convert(char(8),b.out_date,120),0,8) order by substring(convert(char(8),b.out_date,120),0,8)";
 
	        aRs  = ViewBean.executeQuery(SQL) ;
 
		while (aRs.next()) {	
		   list1.add(getbyte(aRs.getString("nn")));
		   list2.add(getbyte(aRs.getString("fact_value")));
		  
		}
		aRs.close();
	 %>
	 
	  
	 <tr  align="center" height=25>
	 <td colspan="2">合计</td>
	 <td><b><%=FormatD.getFloat2(jh_sum,2) %></b></td>
	   <%for (int ii=1;ii<=CurMonth;ii++){ 
       String mm="";
	  if (ii<10) mm=String.valueOf(CurYear)+"-"+"0"+String.valueOf(ii);
	  else  mm=String.valueOf(CurYear)+"-"+String.valueOf(ii);
	  String mmm="0"; 
	  if (list1.contains(mm)){
		   int index=list1.indexOf(mm);
		   mmm=(String)list2.get(index);
		   factsum+=Double.parseDouble(mmm);
	  }
  %>
    <td  ><b><%=mmm %></b></td>
	<%} %>
	<td><b><%=FormatD.getFloat2(zc_sum ,2)%></b></td>
	 </tr>
	 
	 <%list1.clear();
      list2.clear();
	  list3.clear();
	  factsum=0;
	  SQL="SELECT sum(jzarea) jzarea,  convert(numeric(9,2),sum(rmbprice)/10000.0) rmbprice,  convert(char(7),date,120) RentMonth    FROM order_contract WHERE section='"+section+"' and year(date)="+China.getParameter(request,"yearmonth")+" group by  convert(char(7),date,120) ";
     
	   aRs = ViewBean.executeQuery(SQL) ;
 
		while (aRs.next()) {	
		   list1.add(getbyte(aRs.getString("jzarea")));
		   list2.add(getbyte(aRs.getString("RentMonth")));
		    list3.add(getbyte(aRs.getString("rmbprice")));
		}
		aRs.close(); 
		 %>
	 <tr  align="center">
	 <td colspan="3">销售面积</td>
	 
	 
	   <%for (int ii=1;ii<=CurMonth;ii++){ 
       String mm="";
	  if (ii<10) mm=String.valueOf(CurYear)+"-"+"0"+String.valueOf(ii);
	  else  mm=String.valueOf(CurYear)+"-"+String.valueOf(ii);
	  String mmm="0"; 
	     
	  if (list2.contains(mm)){
		   int index=list2.indexOf(mm);
		   mmm=(String)list1.get(index);
		
		   factsum+=Double.parseDouble(mmm);
	  }%>
	  <td  > <%=mmm %> </td>
	  <%} %>
	   <td  ><b><%=FormatD.getFloat2(factsum,2) %></b></td>
	 </tr>
	  <tr  align="center">
	 <td colspan="3">销售金额</td>
	  
	   <% 
	  
	  
	  factsum=0;
	  for (int ii=1;ii<=CurMonth;ii++){ 
       String mm="";
	  if (ii<10) mm=String.valueOf(CurYear)+"-"+"0"+String.valueOf(ii);
	  else  mm=String.valueOf(CurYear)+"-"+String.valueOf(ii);
	  String mmm="0"; 
	  if (list1.contains(mm)){
		   int index=list1.indexOf(mm);
		   mmm=(String)list3.get(index);
		   factsum+=Double.parseDouble(mmm);
	  }%>
	  <td  > <%=mmm %> </td>
	  <%} %>
	   <td  ><b><%=FormatD.getFloat2(factsum,2) %></b></td>  
	 </tr>
	 <%list1.clear();
      list2.clear();
	   list3.clear();
	 
      list4.clear();
       SQL="SELECT convert(numeric(9,2),sum(factmoney*CurrRate)/10000.0) nn,    convert(char(7),gather_date,120) RentMonth    FROM factGatheringRecord WHERE contractno in (select code   from order_contract where section='"+section+"') and year(gather_date)="+China.getParameter(request,"yearmonth")+" group by  convert(char(7),gather_date,120) ";
      
	 
	   aRs = ViewBean.executeQuery(SQL) ;
 
		while (aRs.next()) {	
		   list2.add(getbyte(aRs.getString("nn")));
		   list1.add(getbyte(aRs.getString("RentMonth")));
		    
		}
		aRs.close();
		
       SQL="SELECT convert(numeric(9,2),sum(factmonye)/10000) nn,    convert(char(7),factdate,120) RentMonth    FROM FactAjCharges WHERE contractno in (select code   from order_contract where section='"+section+"') and year(factdate)="+China.getParameter(request,"yearmonth")+" group by  convert(char(7),factdate,120) ";
   
	   aRs = ViewBean.executeQuery(SQL) ;

		while (aRs.next()) {	
		   list3.add(getbyte(aRs.getString("nn")));
		   list4.add(getbyte(aRs.getString("RentMonth")));
		    
		}
		aRs.close();
  
  %>
	  <tr align="center">
	 <td colspan="3">回款金额</td>
	 <%  factsum=0;
	  double aaaa=0;
	  for (int ii=1;ii<=CurMonth;ii++){ 
	  aaaa=0;
       String mm="";
	  if (ii<10) mm=String.valueOf(CurYear)+"-"+"0"+String.valueOf(ii);
	  else  mm=String.valueOf(CurYear)+"-"+String.valueOf(ii);
	  String mmm="0"; 
	  if (list1.contains(mm)){
		   int index=list1.indexOf(mm);
		   mmm=(String)list2.get(index);
		   factsum+=Double.parseDouble(mmm);
		   aaaa+=Double.parseDouble(mmm);
	  }
	   if (list3.contains(mm)){
		   int index=list3.indexOf(mm);
		   mmm=(String)list4.get(index);
		    factsum+=Double.parseDouble(mmm);
		    aaaa+=Double.parseDouble(mmm);
	  }
	  
	  %>
	  <td  > <%=FormatD.getFloat2(aaaa,2) %> </td>
	  <%} %>
	   <td  ><b><%=FormatD.getFloat2(factsum,2) %></b></td>
	   
	 </tr>
	 <%} %>
	   
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
        var selectArea=document.body.createTextRange(); //创建文本区域 
        selectArea.moveToElementText(report1);//将文本区域聚焦到printData 
        selectArea.select();//选中printData 
        selectArea.execCommand("Copy");//将printData复制到剪切板中 
         oSheet.Paste();//将剪切板中的数据复制到Excel中    
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
</script>
 
	 
  
  </center>
</form>
</body>
</html>

