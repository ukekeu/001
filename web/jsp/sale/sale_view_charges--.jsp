 <%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
  <%@ page import = "java.sql.*,common.*,java.util.*" %>
  <jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id = "ViewBean1" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id = "changeListBean" scope = "page" class = "ConnDatabase.SDatabase" />
    <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
   <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
   
  <%@ include file="../public_js/getByteOut.jsp"%>
   <%@ include file="../public_js/CheckSection.jsp"%>
<html>
<head>
	<title>���۷���</title>
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

</head>
 <script language="javascript" src="../public_js/public.js"></script>
<body onload="">
<form method="post" name="frm">

  <table width=100% border="0"><tr    ><td align="left">¥�̣�<select name="section" onchange="document.frm.submit();"> 
   <option></option>
<%  
    String section=getbyte1(request.getParameter("section"));
	 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql1="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";

	  ResultSet rs2=ViewBean1.executeQuery(sql1);	
	  String sec="";
	  String no1="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
		if (section.equals(""))section=no1;
		
	  }
	  if (!no1.equals(""))defaultNo=no1;
	    rs2.close();
	
     %> </select>
	 </td></tr></table>
</form>
<%
     java.util.Date curDate=new java.util.Date();
     int CurYear=curDate.getYear()+1900;
     int CurMonth=curDate.getMonth()+1;
     int CurDay=curDate.getDate(); 
	List list1=new LinkedList(); 
	List list2=new LinkedList(); 
	List list3=new LinkedList();
	List list4=new LinkedList();
	List list5=new LinkedList();
	List list6=new LinkedList();
   
    String  Date1=China.getParameter(request,"Date1");
	String  Loft=China.getParameter(request,"Loft");	
	String  Date2=China.getParameter(request,"Date2");
	if (SecNo.equals(""))SecNo=section;
	String  SQL="SELECT charges_name FROM out_charges WHERE section_no='"+SecNo+"' and substring(out_yeahmonth,1,4)="+String.valueOf(CurYear)+" group by charges_name";
     ResultSet aRs = ViewBean.executeQuery(SQL) ;
	   int rows=0;
		while (aRs.next()) {	
		    rows++;
		}
		aRs.close();
       SQL="SELECT charges_name+out_yeahmonth charges_name,sum(charges_value) charges_value,sum(fact_value) fact_value FROM out_charges WHERE section_no='"+SecNo+"' and substring(out_yeahmonth,1,4)="+String.valueOf(CurYear)+" group by charges_name+out_yeahmonth";
       aRs = ViewBean.executeQuery(SQL) ;
 
		while (aRs.next()) {	
		   list1.add(getbyte(aRs.getString("charges_name")));
		   list2.add(getbyte(aRs.getString("charges_value")));
		   list3.add(getbyte(aRs.getString("fact_value")));
		}
		aRs.close();
		 SQL="SELECT out_yeahmonth ,sum(charges_value) charges_value,sum(fact_value) fact_value FROM out_charges WHERE section_no='"+SecNo+"' and substring(out_yeahmonth,1,4)="+String.valueOf(CurYear)+" group by out_yeahmonth";
       aRs = ViewBean.executeQuery(SQL) ;
	  
		while (aRs.next()) {	
		    list6.add(getbyte(aRs.getString("out_yeahmonth")));
		   list4.add(getbyte(aRs.getString("charges_value")));
		   list5.add(getbyte(aRs.getString("fact_value")));
		}
		aRs.close();
        SQL="SELECT NAME FROM CRM_PROJECT WHERE SERIALNO='"+SecNo+"'";
         aRs = ViewBean.executeQuery(SQL) ;
	  String sectionname="";
		if (aRs.next()) {	
		  sectionname=getbyte(aRs.getString("NAME"));
		}
		aRs.close();
		
 %>  
 <div align=left id=report1 ;height:100%px;overflow:auto;width:100%;z-index:2" contentEditable >
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<center><font size=4><b><%=sectionname %>��ĿӪ������֧�����������ͳ�Ʊ�</b></font></center>
<br>
<table  width="99%"><tr><td align="left"><%= CurYear%>���</td><td align="right">��λ:��Ԫ</td></tr></table>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="99%" id="AutoNumber1">
  <tr align="center">
    <td width="2%"><img src="../images/newbg.jpg"></td>
    <td width="7%" colspan="2">��</td>
	<%for (int i=1;i<=CurMonth;i++){ %>
    <td width="7%"><%=i %></td>
	<%} %>
    
  </tr>
  <%
   SQL="SELECT charges_name FROM out_charges WHERE section_no='"+SecNo+"' and substring(out_yeahmonth,1,4)="+String.valueOf(CurYear) +" group by charges_name";
       aRs = ViewBean.executeQuery(SQL) ;
	   int j=0;
		 while (aRs.next()) {	
         String chanrgesname=getbyte(aRs.getString("charges_name"));
   %>
  <tr align="center">
  <%if (j==0){ %>
    <td width="2%" rowspan="<%=rows%>">��<br>��<br>ָ<br>��</td>
	<%}j++; %>
    <td width="7%" colspan="2"><%= chanrgesname%></td>
	 
	<%for (int i=1;i<=CurMonth;i++){  
	  String mm="";
	  if (i<10) mm=String.valueOf(CurYear)+"-"+"0"+String.valueOf(i);
	  else  mm=String.valueOf(CurYear)+"-"+String.valueOf(i);
	 String mmm=""; 
	if (list1.contains(chanrgesname+mm)){
		   int index=list1.indexOf(chanrgesname+mm);
		   mmm=(String)list2.get(index);
		    
	}
	 %>
    <td width="7%"><%=mmm %>��</td>
	<%} %> 
  </tr>
  <%}aRs.close(); %>
  
  <tr align="center"><td colspan="3"><b>�ϼƽ�</b></td>
  <%for (int i=1;i<=CurMonth;i++){ 
       String mm="";
	  if (i<10) mm=String.valueOf(CurYear)+"-"+"0"+String.valueOf(i);
	  else  mm=String.valueOf(CurYear)+"-"+String.valueOf(i);
	 String mmm=""; 
	if (list6.contains(mm)){
		   int index=list6.indexOf(mm);
		   mmm=(String)list4.get(index);
		    
	}
  %>
    <td width="7%"><b><%=mmm %></b></td>
	<%} %>
  </tr>
   <%
   SQL="SELECT charges_name FROM out_charges WHERE section_no='"+SecNo+"' and substring(out_yeahmonth,1,4)="+String.valueOf(CurYear)+" group by charges_name";
       aRs = ViewBean.executeQuery(SQL) ;
	   
	     j=0;
		 while (aRs.next()) {	
         String chanrgesname=getbyte(aRs.getString("charges_name"));
   %>
    <tr align="center" style="background-color:#F7F7F7">
  <%if (j==0){ %>
    <td width="2%" rowspan="<%=rows*2%>">ʵ<br>��<br>֧<br>��</td>
	<%}j++; %>
	<td width="7%" rowspan="2"><%= chanrgesname%></td>
	   <td width="7%" height="16">���</td>
	<%for (int i=1;i<=CurMonth;i++){  
	  String mm="";
	  if (i<10) mm=String.valueOf(CurYear)+"-"+"0"+String.valueOf(i);
	  else  mm=String.valueOf(CurYear)+"-"+String.valueOf(i);
	  String mmm=""; 
	  if (list1.contains(chanrgesname+mm)){
		   int index=list1.indexOf(chanrgesname+mm);
		   mmm=(String)list3.get(index);
	  }
	 %>
	
    <td width="7%"><%=mmm %>��</td>
	<%} %> 
  </tr>
  <tr align="center"  style="background-color:#F7F7F7">
    <td width="7%" height="16">����</td>
  <%for (int i=1;i<=CurMonth;i++){  
	  String mm="";
	  if (i<10) mm=String.valueOf(CurYear)+"-"+"0"+String.valueOf(i);
	  else  mm=String.valueOf(CurYear)+"-"+String.valueOf(i);
	  String mmm=""; 
	  String nnn=""; 
	  
	  if (list1.contains(chanrgesname+mm)){
		   int index=list1.indexOf(chanrgesname+mm);
		   mmm=(String)list3.get(index);
		   nnn=(String)list2.get(index);
		    
	  }
	 %>
    <td width="7%"><%if (!mmm.equals("")&&!nnn.equals("")){ %><%=FormtD.getFloat2(Double.parseDouble(mmm)/Double.parseDouble(nnn)*100.0,2) %>%<%} %></td>
	<%} %>  
  </tr> 
  
 <%}aRs.close(); %>
 <tr align="center"><td colspan="3"><b>�ϼƽ�</b></td>
  <%for (int i=1;i<=CurMonth;i++){  String mm="";
	  if (i<10) mm=String.valueOf(CurYear)+"-"+"0"+String.valueOf(i);
	  else  mm=String.valueOf(CurYear)+"-"+String.valueOf(i);
	 String mmm=""; 
	if (list6.contains(mm)){
		   int index=list6.indexOf(mm);
		   mmm=(String)list5.get(index);
	
	}
  %>
    <td width="7%"><b><%=mmm %></b></td>
	<%} %>
  </tr>
  
  
  <%  list1.clear();
      list2.clear();
	  list5.clear();
	  list6.clear();
       SQL="SELECT sum(perarea) perarea, sum(sale_money) sale_money,ltrim(rtrim(str(RentYear)))+'-'+ ltrim(rtrim(str(RentMonth)))  RentMonth    FROM SalerValue WHERE uptown='"+SecNo+"' AND TYPE=1 and RentYear="+String.valueOf(CurYear)+" group by  ltrim(rtrim(str(RentYear)))+'-'+ ltrim(rtrim(str(RentMonth)))";
       aRs = ViewBean.executeQuery(SQL) ;
 
		while (aRs.next()) {	
		   list2.add(getbyte(aRs.getString("perarea")));
		   list1.add(getbyte(aRs.getString("RentMonth")));
		   list5.add(getbyte(aRs.getString("sale_money")));
		    
		}
		aRs.close();
  
 
	     j=0;
		 
   %>
  <tr align="center">
     <td width="2%" rowspan="3">��<br>��<br>��<br>��</td>
 
    <td width="7%" colspan="2">�ƻ����</td>
	 
	<%for (int i=1;i<=CurMonth;i++){  
	  String mm="";
	   mm=String.valueOf(CurYear)+"-"+String.valueOf(i);
	 String mmm=""; 
	 
	if (list1.contains(mm)){
		   int index=list1.indexOf(mm);
		   mmm=(String)list2.get(index);
		   	   
	}
	 %>
    <td width="7%"><%=mmm %>��</td>
	<%} %> 
  </tr>
  
  
  <%  
       SQL="SELECT sum(jzarea) jzarea,  convert(numeric(9,2),sum(rmbprice)/10000.0) rmbprice,  convert(char(7),date,120) RentMonth    FROM order_contract WHERE section='"+SecNo+"' and year(date)="+String.valueOf(CurYear)+" group by  convert(char(7),date,120) ";
       aRs = ViewBean.executeQuery(SQL) ;
 
		while (aRs.next()) {	
		   list3.add(getbyte(aRs.getString("jzarea")));
		   list4.add(getbyte(aRs.getString("RentMonth")));
		    list6.add(getbyte(aRs.getString("rmbprice")));
		}
		aRs.close();
  
  
		 
   %>
     <tr align="center">
 
    <td width="7%" colspan="2">�ɽ����</td>
	 
	<%for (int i=1;i<=CurMonth;i++){  
	  String mm="";
	  if (i<10) mm=String.valueOf(CurYear)+"-"+"0"+String.valueOf(i);
	  else  mm=String.valueOf(CurYear)+"-"+String.valueOf(i);
	 String mmm=""; 
	 
	if (list4.contains(mm)){
		   int index=list4.indexOf(mm);
		   mmm=(String)list3.get(index);
		   	   
	}
	 %>
    <td width="7%"><%=mmm %>��</td>
	<%} %> 
  </tr>
   <tr align="center">
 
    <td width="7%" colspan="2">�����</td>
	 
	<%for (int i=1;i<=CurMonth;i++){  
	  String mm="";
	  if (i<10) mm=String.valueOf(CurYear)+"-"+"0"+String.valueOf(i);
	  else  mm=String.valueOf(CurYear)+"-"+String.valueOf(i);
	 String mmm="0"; 
	  String mmmm="0"; 
	if (list4.contains(mm)){
		   int index=list4.indexOf(mm);
		   mmm=(String)list3.get(index);
		   
		   	   
	}
	 mm=String.valueOf(CurYear)+"-"+String.valueOf(i);
	if (list1.contains(mm)){
		   int index=list1.indexOf(mm);
		   mmmm=(String)list2.get(index);
		   
		   	   
	}
	 %>
    <td width="7%"> <%if (Double.valueOf(mmmm)>0){out.print(FormtD.getFloat3(Double.valueOf(mmm)/Double.valueOf(mmmm)*100.00,2)+"%");}%>��</td>
	<%} %> 
  </tr>
  
  
  <%  list1.clear();
      list2.clear();
       SQL="SELECT SUM(SALE_NUM) nn, ltrim(rtrim(str(RentYear)))+'-'+ ltrim(rtrim(str(RentMonth)))  RentMonth    FROM SalerValue WHERE uptown='"+SecNo+"' AND TYPE=1 and RentYear="+String.valueOf(CurYear)+" group by  ltrim(rtrim(str(RentYear)))+'-'+ ltrim(rtrim(str(RentMonth)))";
       aRs = ViewBean.executeQuery(SQL) ;
 
		while (aRs.next()) {	
		   list2.add(getbyte(aRs.getString("nn")));
		   list1.add(getbyte(aRs.getString("RentMonth")));
		    
		}
		aRs.close();
  
 
	     j=0;
		 
   %>
  <tr align="center" style="background-color:#F7F7F7">
  
    <td width="3%" rowspan="3">��<br>��<br>��<br>��</td>
	 
    <td width="7%" colspan="2">�ƻ�����</td>
	 
	<%for (int i=1;i<=CurMonth;i++){  
	  String mm="";
	   mm=String.valueOf(CurYear)+"-"+String.valueOf(i);
	 String mmm=""; 
	 
	if (list1.contains(mm)){
		   int index=list1.indexOf(mm);
		   mmm=(String)list2.get(index);
		   	   
	}
	 %>
    <td width="7%"><%=mmm %>��</td>
	<%} %> 
  </tr>
  
  
  <%  list3.clear();
      list4.clear();
       SQL="SELECT count(*) nn,    convert(char(7),date,120) RentMonth    FROM order_contract WHERE section='"+SecNo+"' and year(date)="+String.valueOf(CurYear)+" group by  convert(char(7),date,120) ";
       aRs = ViewBean.executeQuery(SQL) ;
 
		while (aRs.next()) {	
		   list3.add(getbyte(aRs.getString("nn")));
		   list4.add(getbyte(aRs.getString("RentMonth")));
		    
		}
		aRs.close();
  
  
		 
   %>
     <tr align="center" style="background-color:#F7F7F7">
 
    <td width="7%" colspan="2">�ɽ�����</td>
	 
	<%for (int i=1;i<=CurMonth;i++){  
	  String mm="";
	  if (i<10) mm=String.valueOf(CurYear)+"-"+"0"+String.valueOf(i);
	  else  mm=String.valueOf(CurYear)+"-"+String.valueOf(i);
	 String mmm=""; 
	 
	if (list4.contains(mm)){
		   int index=list4.indexOf(mm);
		   mmm=(String)list3.get(index);
		   	   
	}
	 %>
    <td width="7%"><%=mmm %>��</td>
	<%} %> 
  </tr>
   <tr align="center" style="background-color:#F7F7F7">
 
    <td width="7%" colspan="2">�����</td>
	 
	<%for (int i=1;i<=CurMonth;i++){  
	  String mm="";
	  if (i<10) mm=String.valueOf(CurYear)+"-"+"0"+String.valueOf(i);
	  else  mm=String.valueOf(CurYear)+"-"+String.valueOf(i);
	 String mmm="0"; 
	  String mmmm="0"; 
	if (list4.contains(mm)){
		   int index=list4.indexOf(mm);
		   mmm=(String)list3.get(index);
		   
		   	   
	}
	 mm=String.valueOf(CurYear)+"-"+String.valueOf(i);
	if (list1.contains(mm)){
		   int index=list1.indexOf(mm);
		   mmmm=(String)list2.get(index);
		   
		   	   
	}
	 %>
    <td width="7%"> <%if (Double.valueOf(mmmm)>0){out.print(FormtD.getFloat3(Double.valueOf(mmm)/Double.valueOf(mmmm)*100.00,2)+"%");}%>��</td>
	<%} %> 
  </tr>
  <!--���-->
  
  <tr align="center">
  
    <td width="2%" rowspan="3">��<br>��<br>��<br>��</td>
	 
    <td width="7%" colspan="2">�ƻ����</td>
	 
	<%for (int i=1;i<=CurMonth;i++){  
	  String mm="";
	   mm=String.valueOf(CurYear)+"-"+String.valueOf(i);
	 String mmm=""; 
	 
	if (list1.contains(mm)){
		   int index=list1.indexOf(mm);
		   mmm=(String)list5.get(index);
		   	   
	}
	 %>
    <td width="7%"><%=mmm %>��</td>
	<%} %> 
  </tr>
  
  
  
     <tr align="center">
 
    <td width="7%" colspan="2">�ɽ����</td>
	 
	<%for (int i=1;i<=CurMonth;i++){  
	  String mm="";
	  if (i<10) mm=String.valueOf(CurYear)+"-"+"0"+String.valueOf(i);
	  else  mm=String.valueOf(CurYear)+"-"+String.valueOf(i);
	 String mmm=""; 
	 
	if (list4.contains(mm)){
		   int index=list4.indexOf(mm);
		   mmm=(String)list6.get(index);
		   	   
	}
	 %>
    <td width="7%"><%=mmm %>��</td>
	<%} %> 
  </tr>
   <tr align="center">
 
    <td width="7%" colspan="2">�����</td>
	 
	<%for (int i=1;i<=CurMonth;i++){  
	  String mm="";
	  if (i<10) mm=String.valueOf(CurYear)+"-"+"0"+String.valueOf(i);
	  else  mm=String.valueOf(CurYear)+"-"+String.valueOf(i);
	 String mmm="0"; 
	  String mmmm="0"; 
	if (list4.contains(mm)){
		   int index=list4.indexOf(mm);
		   mmm=(String)list6.get(index);
		   
		   	   
	}
	 mm=String.valueOf(CurYear)+"-"+String.valueOf(i);
	if (list1.contains(mm)){
		   int index=list1.indexOf(mm);
		   mmmm=(String)list5.get(index);
		   
		   	   
	}
	 %>
    <td width="7%"> <%if (Double.valueOf(mmmm)>0){out.print(FormtD.getFloat3(Double.valueOf(mmm)/Double.valueOf(mmmm)*100.00,2)+"%");}%>��</td>
	<%} %> 
  </tr>
  
  
  
  
  
  <%  list1.clear();
      list2.clear();
       SQL="SELECT convert(numeric(9,2),sum(factmoney*CurrRate)/10000.0) nn,    convert(char(7),gather_date,120) RentMonth    FROM factGatheringRecord WHERE contractno in (select code   from order_contract where section='"+SecNo+"') and year(gather_date)="+String.valueOf(CurYear)+" group by  convert(char(7),gather_date,120) ";
       aRs = ViewBean.executeQuery(SQL) ;
 
		while (aRs.next()) {	
		   list2.add(getbyte(aRs.getString("nn")));
		   list1.add(getbyte(aRs.getString("RentMonth")));
		    
		}
		aRs.close();
  
  
		 
   %>
  
  
  <tr align="center" style="background-color:#F7F7F7">
  
    <td width="2%" rowspan="3">��<br>��<br>��<br>��</td>
	 
    <td width="7%" colspan="2">�յ����ڿ�</td>
	 
	<%for (int i=1;i<=CurMonth;i++){  
	  String mm="";
	 if (i<10) mm=String.valueOf(CurYear)+"-"+"0"+String.valueOf(i);
	  else  mm=String.valueOf(CurYear)+"-"+String.valueOf(i);
	 String mmm=""; 
	 
	if (list1.contains(mm)){
		   int index=list1.indexOf(mm);
		   mmm=(String)list2.get(index);
		   	   
	}
	 %>
    <td width="7%"><%=mmm %>��</td>
	<%} %> 
  </tr>
  
  
  <%  list3.clear();
      list4.clear();
       SQL="SELECT convert(numeric(9,2),sum(factmonye)/10000) nn,    convert(char(7),factdate,120) RentMonth    FROM FactAjCharges WHERE contractno in (select code   from order_contract where section='"+SecNo+"') and year(factdate)="+String.valueOf(CurYear)+" group by  convert(char(7),factdate,120) ";
   
	   aRs = ViewBean.executeQuery(SQL) ;

		while (aRs.next()) {	
		   list3.add(getbyte(aRs.getString("nn")));
		   list4.add(getbyte(aRs.getString("RentMonth")));
		    
		}
		aRs.close();
  
  
  
		 
   %>
     <tr align="center" style="background-color:#F7F7F7">
 
    <td width="7%" colspan="2">���зſ�</td>
	 
	<%for (int i=1;i<=CurMonth;i++){  
	  String mm="";
	  if (i<10) mm=String.valueOf(CurYear)+"-"+"0"+String.valueOf(i);
	  else  mm=String.valueOf(CurYear)+"-"+String.valueOf(i);
	 String mmm="0"; 
	 
	if (list4.contains(mm)){
		   int index=list4.indexOf(mm);
		   mmm=(String)list3.get(index);
		   	   
	}
	 %>
    <td width="7%"><%=mmm %>��</td>
	<%} %> 
  </tr>
  
  <%
  list6.clear();
  list5.clear();
  
   SQL="SELECT sum(jzarea) jzarea,  convert(numeric(9,2),sum(rmbprice)/10000.0) rmbprice,  convert(char(7),date,120) RentMonth    FROM order_contract WHERE section='"+SecNo+"' and year(date)="+String.valueOf(CurYear)+" group by  convert(char(7),date,120) ";
       aRs = ViewBean.executeQuery(SQL) ;
 
		while (aRs.next()) {	
		   
		    list5.add(getbyte(aRs.getString("RentMonth")));
		    list6.add(getbyte(aRs.getString("rmbprice")));
		}
		aRs.close();
  
   %>
   <tr align="center" style="background-color:#F7F7F7">
 
    <td width="7%" colspan="2">�ؿ���</td>
	 
	<%for (int i=1;i<=CurMonth;i++){  
	  String mm="";
	  if (i<10) mm=String.valueOf(CurYear)+"-"+"0"+String.valueOf(i);
	  else  mm=String.valueOf(CurYear)+"-"+String.valueOf(i);
	 String mmm="0"; 
	  String mmmm="0"; 
	   String mmmmm="0"; 
	if (list4.contains(mm)){
		   int index=list4.indexOf(mm);
		   mmm=(String)list3.get(index);
	}
	if (list5.contains(mm)){
		   int index=list5.indexOf(mm);
		   mmmmm=(String)list6.get(index);
	}
	// mm=String.valueOf(CurYear)+"-"+String.valueOf(i);
	if (list1.contains(mm)){
		   int index=list1.indexOf(mm);
		   mmmm=(String)list2.get(index);
		   
		   	   
	}
	
	 %> 
    <td width="7%"><%if (Double.valueOf(mmmmm)>0){out.print(FormtD.getFloat3((Double.valueOf(mmm)+Double.valueOf(mmmm))/Double.valueOf(mmmmm)*100.0,2)+"%");}%>��</td>
	<%} %> 
  </tr>
  
</table>

 </div>
 
<script>
setSelectMad(document.frm.section,'<%=section%>');
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
        var selectArea=document.body.createTextRange(); //�����ı����� 
        selectArea.moveToElementText(report1);//���ı�����۽���printData 
        selectArea.select();//ѡ��printData 
        selectArea.execCommand("Copy");//��printData���Ƶ����а��� 
         oSheet.Paste();//�����а��е����ݸ��Ƶ�Excel��    
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
</script>
<p align="center"> <div   id="divprint" align="center"><input type="button" name="Button" value="��ӡԤ��"  title="��ӡǰ�����������¥����" onClick="window.divprint.style.display='none';javascript:document.frm.WebBrowser.ExecWB(7,1);window.divprint.style.display='block'"> <input type="button" onclick="bringToExcel()" value="������Excel"><br>
����ǰ���������Ӧ���ã�<br>
��1.��IE��������ѡ��"internetѡ��"<br>
��2.ѡ��"��ȫ"->ѡ��"����intranet"���ٵ��"�Զ��弶��"<br>
  3.������ActiveX���ö�ѡ�к���ȷ���˺�<br>

</body>
</html>
