<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>�ɽ��ͻ�����</title>
</head>

  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>

<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<%
String menu= (String)session.getAttribute("menu");
 
if (menu==null)menu="1";
 if (menu.equals("1")){
 %>
<script>
this.resizeTo(screen.availWidth,screen.availHeight)
this.moveTo(0,0)
this.focus()
</script>
<%} %>
<%@ include file="../public_js/getByteOut.jsp"%>
<%
String CusName="";
String Condi="";
String Condi1="";
String CusAge="";
String year="";
String year1="";
String month="";
String day="";
String CusType="";
String BuyType="";
String CusVisitDate="";
String strWhere="";
String section="";
String custype="";
String cusche="";
String FindCondition="";//���ݲ�������
String orderbytype=China.getParameter(request,"orderbytype");
String orderby=China.getParameter(request,"orderby");
String gradetype=China.getParameter(request,"gradetype");

String prin=request.getParameter("print");
String Find=request.getParameter("FindS");
String tmp=request.getParameter("pageno");

String FindCon=(String)request.getParameter("condtion");
if (Find!=null){
   
  //ȡ������ֵ

   CusName=request.getParameter("cusname");//�ͻ�����
   Condi=request.getParameter("condi");//����1
   section=request.getParameter("section");//ȡ��¥��

   Condi1=request.getParameter("condi1");//����2
   CusAge=request.getParameter("age");//�ͻ�����
   year=request.getParameter("SDate");//�ͻ���������
   year1=request.getParameter("EDate2");//�ͻ���������
 
   custype=request.getParameter("cusche");//�ͻ�״̬

   if (section==null)section="";
   if (!section.equals(""))
   strWhere=" and Order_Contract.section ='"+section+"'" ;
   FindCondition="Order_Contract.section='"+section+"'";
   FindCondition=FindCondition+"&Find="+Find;
   FindCondition=FindCondition+"&cusche="+custype;

   if (year!=null&&year1==null){
	   if (year.length()>0){
		 if (strWhere.equals("")){strWhere=" and customer.visit_date='"+year+"'";}
		 else {strWhere+=" and customer.visit_date='"+year+"'";}
		 FindCondition=FindCondition+"&year="+year;
		}
    }
   if (year1!=null&&year==null){
	   if (year1.length()>0){
	   	 if (strWhere.equals("")){strWhere=" and customer.visit_date='"+year1+"'";}
		 else {strWhere+=" and customer.visit_date='"+year1+"'";}
		 FindCondition=FindCondition+"&year1="+year1;
	     }
    }
 
   if (year1!=null&&year!=null){
	   if (year1.length()>0){
	   	 if (strWhere.equals("")){strWhere=" and customer.visit_date between '"+year+"' and '"+year1+"'";}
	     else strWhere+=" and customer.visit_date between '"+year+"' and '"+year1+"'";
		 FindCondition=FindCondition+"&year1="+year1+"&year="+year;
	     }
    }


   CusType=request.getParameter("custype");
   BuyType=request.getParameter("gmyt");

 if ((CusName!=null)&&(CusName.length()>0)){
   if (tmp==null){
   CusName= new String(CusName.getBytes("ISO8859_1"),"GBK");
   }
    if (strWhere.equals("")){ strWhere=" and  customer.Cus_Name like '%"+CusName+"%'";
	}else{ strWhere+=" and customer.Cus_Name like '%"+CusName+"%'";}
   FindCondition=FindCondition+"&cusname="+CusName;
   }

 if ((CusAge!=null)&&(CusAge.length()>0)){
   if (strWhere.equals("")){strWhere=" and customer.cus_age "+Condi+CusAge;}
   else{strWhere=strWhere+" and customer.cus_age "+Condi+CusAge;}
   FindCondition=FindCondition+"&age="+CusAge;
 }

 if (CusType!=null){
   if (CusType.length()>0){
	   if (tmp==null){
	     CusType= new String(CusType.getBytes("ISO8859_1"),"GBK");
	   }
       if (strWhere.equals("")){strWhere=" and customer.Cus_Type='"+CusType+"'";}
       else{strWhere=strWhere+" and customer.Cus_Type='"+CusType+"'";}
   FindCondition=FindCondition+"&custype="+CusType;
   }  
 }  

 if (BuyType!=null){
  if (BuyType.length()>0){
    if (tmp==null){
    BuyType= new String(BuyType.getBytes("ISO8859_1"),"GBK");
    }
    if (strWhere.equals("")){strWhere=" and customer.Purpose='"+BuyType+"'";}
    else{strWhere=strWhere+" and customer.Purpose='"+BuyType+"'";}
    FindCondition=FindCondition+"&gmyt="+BuyType;
   }  
 }
 
}

%>

<%@ include file="../public_js/CheckSection.jsp"%>

<%@ include file="../public_js/qx_checke.jsp"%>
<%@ include file="../public_js/countpagenum.jsp"%>
<%
    String search_like=China.getParameter(request,"search_like").trim();
	String fields=China.getParameter(request,"fields").trim();
	String cus_type=China.getParameter(request,"cust_ype").trim();
	String searchWhere="";
      if (!search_like.equals("")){
	 if (!fields.equals("date"))
	searchWhere="  and "+fields+" like '%"+search_like+"%' ";
	else
	searchWhere="  and "+fields+" = '"+search_like+"' ";
	}
	 strWhere+=searchWhere;
//��ʾ�ͻ����


 //����ʽ
	if (!orderbytype.equals("")&&!orderby.equals("")){
	  if (orderbytype.equals("0")&&orderby.equals("0")) orderby=" order by customer.visit_date desc";
	  if (orderbytype.equals("0")&&orderby.equals("1")) orderby=" order by customer.visit_date asc";
	  if (orderbytype.equals("1")&&orderby.equals("0")) {orderby=" order by customer.cus_name desc";}
	  if (orderbytype.equals("1")&&orderby.equals("1")) orderby=" order by customer.cus_name asc";
	} 
	 else if (!orderby.equals("")){
	  if ( orderby.equals("0")) orderby=" order by customer.cus_name desc";
	  if ( orderby.equals("1")) orderby=" order by customer.cus_name asc";
	
	}else if (!orderby.equals("")&&!orderbytype.equals("")){
	 if (orderbytype.equals("0")&&orderby.equals("0")) orderby=" order by  customer.visit_date desc";
	 if (orderbytype.equals("1")&&orderby.equals("0")) orderby=" order by  customer.cus_name desc";
	 if ( orderbytype.equals("1")&&orderby.equals("1")) orderby=" order by  customer.cus_name desc";
     if ( orderbytype.equals("0")&&orderby.equals("1")) orderby=" order by       customer.visit_date desc";
	}else{
	orderby=" order by customer.visit_date desc";
	
	}
	
if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
List room=new LinkedList();//���ҵ����Ԫ
List cus=new LinkedList();//���ҵ��
String orderSQL="SELECT LOFT+ROOM_NO ROOM  ,CUSTOMER FROM ORDER_CONTRACT where state=1 and section in("+SectionS+")"+strWhere;
  
	String sql="";
	int totalnum=0;
    //��ȡ��ѯ����
	
	String con=FindCon;
	if (FindCon!=null){
    	FindCon=" = "+FindCon;
    	}
    else{
	   FindCon="='0' ";
	 }  
	String condtion=FindCon;		
    String eof="false";
	
	String PubPra=(String)session.getAttribute("Attribute");	
    String user=(String)session.getAttribute("loginname");	
	String job=(String)session.getAttribute("job");	
	
	 if (job.indexOf("����Ա")>=0){
	  strWhere+=" and Order_Contract.seller like '%"+(String)session.getAttribute("loginname")+"%'";
	 }
	if (cus_type.equals("1"))strWhere+=" and Order_Contract.state=1";
	else 	if (cus_type.equals("2"))strWhere+=" and Order_Contract.state=2";
ResultSet rs=null;
 
	//��������ֵ�ı���
    String no="";
	String yong_tu="";
    String name="";
    String sex="";
    String age="";
    String sale="";
    String date="";
    String tel="";
    String idcard="";
    String sell="";
	int i=0;
    String roomtype="";
    String area="";
    String tj="";
    String region="";
    String linkman="";
   String address="";
   String bbj="";
   String sj="";
     String post="";
	String attention="";
   String VisaDate="";
   String sectionName="";
   String ID_Card="";
   String loft="";
   String building="";
   String roomno="";

%>
<script>
function full(){
setSelectMad(document.form1.section,'<%=request.getParameter("section") %>');
 setSelectMad(document.form1.fields,'<%=fields%>');
  setSelectMad(document.form1.cust_ype,'<%=cus_type%>');
 }

</script>

<body onload="full()" topmargin="0" oncontextmenu="return false" >
<form name=form1 method="post" >

<input type=hidden name="SDate">
<input type=hidden name="EDate2">
<input type=hidden name="custype">
<input type=hidden name="gmyt">
<input type=hidden name="tel">
<input type=hidden name="age">
<input type=hidden name=cusname>
<input type=hidden name=FindS>
<input type=hidden name=Findsection>
<input type=hidden name=condi>
<%
   String showGrade=getbyte1(request.getParameter("bir"));
    String sel=(String)request.getParameter("sel");
   if(sel==null) sel="3";
   else if (sel.equals("4"))sel="3";
   int colnum=0;
   int iiii=0;
   
     ResultSet rs3=null;
    %>
	  <input type=hidden name="bir" value="<%=showGrade %>">
  <input type=hidden name="sel" value="<%=sel %>">
   <table width="450" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr> 
<td class="<%if(sel.equals("4")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.sel.value=4;document.form1.bir.value='5';findSub('sale_customer_alert.jsp');"> <font color='<%if(sel.equals("4")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�������� 
	</td>
<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.sel.value=3;document.form1.bir.value='4';findSub('visitcusview2.jsp');"> <font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>���пͻ� 
	</td>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.sel.value=0;document.form1.bir.value='1';findSub('visitcusview2.jsp');"> <font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>�������� 
	</td>
	 
	 <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.sel.value=1;document.form1.bir.value='2';findSub('visitcusview2.jsp');"> <font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>���²������� 
	</td>
	 <td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.sel.value=2;document.form1.bir.value='3';findSub('visitcusview2.jsp');"> <font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>δ�Ǽ����� 
	</td>
	</tr></table>
	<%out.print("<p align=center class=FontColor><font size=3><b>�ɽ��ͻ�����</b></p>"); %>
	<script>
function findSub(para){
   document.form1.action=para+"?Search=b&Find=b";
   document.form1.submit();
}
</script>
 <%
//Ȩ�����
String Cortrol=checke_qx(ViewBean1,(String)session.getAttribute("loginid"),"C004");
 %>
   <table width=100% border="0"><tr height="16" bgcolor="#EAEAEA"><td align="left">¥�̣�<select name="section" onchange="document.form1.submit();"> 
   <option></option>
<%  

	 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql1="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";

	  ResultSet rs2=ViewBean1.executeQuery(sql1);	
	  String sec="";
	  String no1="";
	  int aa=0;
      while (rs2.next()){
	
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
	  if (!no1.equals(""))defaultNo=no1;
	    rs2.close();
	
     %> </select>

 
	 <%
	if (Cortrol==null)Cortrol="";
	String reportAddrs=(String)session.getAttribute("reportAddr");
	%>
	<%if (Cortrol.indexOf("E")>=0){ %>
	<input type=button name=sms value="�� ��"  onclick="sendmessage();" title="ѡ��ͻ���,���Ͷ��Ÿ��ͻ�">&nbsp;<input type=button name=fx value="���۷���"  onclick="gcfx();" title="ͼ�η�ʽ��ʾ���͵��������">&nbsp;<input type=button name=fx value="��������"  onclick="if (document.form1.section.value==''){alert('��ѡ��¥��');}else{openwin('saleCustomerFX.jsp?SecNo='+document.form1.section.options[document.form1.section.selectedIndex].value,450,280,200,50);}" title="ͼ�η�ʽ��ʾ�ͻ�������Ϣ">
<%} %>
<%if (Cortrol.indexOf("F")>=0){ %>
<input type=button name=prin title="��������ѡ���ӡ����" value="�ͻ�����" onclick="openwin('auto_select3.jsp?para=1',400,300);">&nbsp;<input type=button name=prin title="��������ѡ���ӡ����" value="�ͻ�̨��" onclick="openwin('auto_select3.jsp?para=3',400,300);">
 <%} %>
  <select name=cust_ype onchange="document.form1.submit();">
   <option value="">����</option>
   <option value="1">�Ϲ��ͻ�</option>
   <option value="2">ǩԼ�ͻ�</option>
 
	 </select>
   <select name=fields onchange="ch(this.value);">
   <option value=cus_name>�ͻ�����</option>
   <option value=loft+building+room_no>�Ϲ���Ԫ</option>
   <option value=yong_tu>��;</option>
    <option value=loft>����</option>
   <option value=phone>��ϵ�绰</option>
     <option value=customer.sj>�ֻ���</option>
   <option value=address>��ϵ��ַ</option>
   <option value=date>�Ϲ�����</option>
     <option value=Order_Contract.SerialNo>�Ϲ���</option>
	 </select>
   <input type=text name=search_like size=15 title="ģ����ѯ���ɲ�ѯ�������绰����ַ��˫���ɵ�������" ondblclick="fPopUpCalendarDlg(search_like);return false;" value="<%=search_like %>"><input type=button name=fin value="�� ѯ"  onclick="document.form1.submit();" ><!--&nbsp;<input type=button name=outdata  title="������ǰҳ����" value="����EXCEL" onclick="outexcel();">--></td>  </tr></table>
   
<script>
function changesub(para){
			document.form1.Findsection.value=para;
			
			document.form1.Find.value="o";
			document.form1.cusche.value=document.form1.stateValue.options[document.form1.stateValue.selectedIndex].value;
			document.form1.submit();
			
			}
			function printall() {
			   	printdiv.innerText ="";
                 print(); 
			}
			function ordersubmit(){
			 if (document.form1.section.value!="")
			     changesub(document.form1.section.value);
			 document.form1.submit();	 
			}
			function changesub(para){
			document.form1.Findsection.value=para;
			
			document.form1.Find.value="o";
			document.form1.cusche.value=document.form1.stateValue.options[document.form1.stateValue.selectedIndex].value;
			document.form1.submit();
			
			}
</script>
<input type=hidden name="Find">
<input type=hidden name="Findsection">
<input type=hidden name="cusname">
<input type=hidden name="condi">
<input type=hidden name="age">
<input type=hidden name="tel">
<input type=hidden name="condi1">
<input type=hidden name="SDate1">
<input type=hidden name="Date2">
<input type=hidden name="custype">
<input type=hidden name="gmyt">
<input type=hidden name="cusche">
<table width=100%><tr height="3"><td></td></tr></table>
<center>

<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  bgcolor="efefef" >
      <td  width="6%"   align="center"><input type="checkbox" name="choosall" onclick="chhoseData(this.checked);">���</td>
  <td  align="center">�ͻ�����</td>
  <td  align="center">���֤��</td>
  <td  align="center">��ϵ�绰</td>
 
  <td  align="center">��ϵ��ַ</td>
 <td  align="center">����Ԫ</td>
 <td  align="center">�Ϲ����</td>
 <td  align="center">�ɽ����</td>
 <td  align="center">�Ϲ�����</td>
  <td  align="center">ǩԼ����</td>
 <td  align="center">��;</td>
   
  <td  align="center">����Ա</td>
<td  align="center">����</td>
  </tr>
 
 <%	
  if (showGrade.equals("")||showGrade.equals("4"))showGrade=" ";
 else if (showGrade.equals("1"))showGrade=" and month(csdate)=month(getdate())";
 else if (showGrade.equals("2"))showGrade=" and month(csdate)<>month(getdate()) and not csdate  is null";
 else  if (showGrade.equals("3"))showGrade=" and csdate is null";
 
  strWhere+=showGrade ;
  
 sql="select Top "+pageSize+"   customer.gzState,Order_Contract.jzarea,Order_Contract.rmbprice,customer.ID_Card,  customer.cus_name, customer.Code,customer.serialno,customer.cus_sex, customer.Phone,customer.sj,customer.Address,customer.Zip_Code ,customer.sj,customer.Address,customer.Zip_Code ,Order_Contract.seller,Order_Contract.floors,convert(char(10),Order_Contract.visadate,120) as   visadate,customer.bbj,customer.sj,convert(char(10),Order_Contract.date,120) as    Date,Order_Contract.sectionname,Order_Contract.section,Order_Contract.loft,Order_Contract.building,Order_Contract.room_no,Order_Contract.yong_tu from customer,Order_Contract where   Order_Contract.state<>3 and  Order_Contract.customer=customer.serialno   and Order_Contract.section in("+SectionS+") and  customer.Code not in (Select top "+prenum +" customer.code from customer,Order_Contract where   Order_Contract.state<>3 and  Order_Contract.customer=customer.serialno and Order_Contract.section in("+SectionS+")  " +strWhere +orderby+")   " + strWhere;
 
 sqlcount="SELECT count(customer.code) code from customer,Order_Contract where  Order_Contract.customer=customer.serialno and Order_Contract.state<>3 and   Order_Contract.section in("+SectionS+")    "+strWhere;
 
  try{
String floors="";

int tr=0;
    rs=ViewBean.executeQuery(sql + orderby);
	 
   while (rs.next()){
	 eof="true";
     i=i+1;
	  
   //��FIELDS˳��һGET��VALUE
   String jzarea=getbyte(rs.getString("jzarea"));
   String rmbprice=getbyte(rs.getString("rmbprice"));
      ID_Card=getbyte(rs.getString("ID_Card"));
      name=getbyte(rs.getString("Cus_Name"));
     no=rs.getString("SerialNo").trim();
	
    
     sex=getbyte(rs.getString("Cus_Sex"));
         tel=getbyte(rs.getString("Phone"));
	 sj=getbyte(rs.getString("sj"));
	
     address=getbyte(rs.getString("address"));
	 post=getbyte(rs.getString("Zip_Code"));
     
	 sell=getbyte(rs.getString("seller"));
	 floors=getbyte(rs.getString("floors"));
	 VisaDate=getbyte(rs.getString("VisaDate"));
    date=rs.getDate("Date").toString();
	 sectionName=getbyte(rs.getString("sectionname")).trim();
	 section =getbyte(rs.getString("section"));
	 loft =getbyte(rs.getString("loft"));
	 building=getbyte(rs.getString("building"));
	 roomno =getbyte(rs.getString("room_no"));
	  yong_tu=getbyte(rs.getString("yong_tu"));
	  boolean gzState=rs.getBoolean("gzState");

  %>

   <tr  align="center" id=TR<%=i %>   trid=tr<%=tr %> align="center"  onmouseover="mout(this);"  onclick="savepara('<%=no%>');changeclass1(this,'clickbg','');" ondblclick="openwin1('../sale/showCustomerContract.jsp?secname=<%=sectionName %>&secno=<%=section %>&roomno=<%=roomno %>&build=<%=building %>&loft=<%=loft %>&Floor=<%=floors %>&show=true',680,530,50,2);" title="˫���ɿ���ͬ����"> 
	<td  align="left"  ><input type="checkbox" name="choos" value="<%=sj+"|"+name%>"><%=i %></td>
    <td  title="������Խ��еǼǿͻ�������Ϣ"  ><%if (Cortrol.indexOf("E")>=0){ %><a href="#" onclick="view('<%=no %>');"><%=name %></a><%} %>��&nbsp;</td>
	<td   ><%=ID_Card %>��&nbsp;</td> 
    <td  align="left">
	<%String strt="";
	String strs="";
	 
	if (tel.indexOf("/")>0)strt="/";
 
	if (sj.indexOf("/")>0)strs="/";
	 %>
	<%out.print(Repalce(tel,strt));  
	  %>&nbsp;<br><%=sj%></td> 
<td   title="<%=address %>">
 <%
	if (address.length()>14)address=address.substring(0,14)+"...";
	if (!post.trim().equals(""))address+="("+post+")" ;
	out.print(address);
	%>&nbsp;</td>
	    <td  ><%=loft+building+roomno %>&nbsp;</td>
		  <td   ><%=jzarea %>&nbsp;</td>
		    <td  ><%=rmbprice %>&nbsp;</td>
			  <td  align="center"><%=date %>&nbsp;</td>
    <td  align="center"><%=VisaDate %>&nbsp;</td>
	    <td  align="center"><%=yong_tu %>&nbsp;</td>
	<td  align="center"><%=sell%>&nbsp;</td>
	 <td  align="center"><a href="#"  onclick="savepara('<%=no%>');Edit('<%=no%>');"><%if (gzState){ %><font color=red>��¼</font><%}else{ %>��¼<%} %></a> </td>

   </tr>
<%
  }
   
}catch(Exception s){out.println(s.getMessage());}
 
rs.close();
if (eof.equals("false")){
   out.print("û���ҵ��ͻ���¼"); 
  
   }
 %> 
  <%@ include file="../public_js/changepage.jsp"%>
</table>
</form>
</center>
<script>
    var cusno="";
    function Edit(){
    	
   	         if (cusno==""){alert("��ѡ��ͻ�(ֻ�赥���б���ĳ��һ��)");}
		     else{ openwin("CusFeedBack_sale.jsp?cusno="+cusno,560,560,100,5);}
	
	}
	function Dele(){
	 if (confirm("���Ҫɾ��ѡ��Ŀͻ���Ϣ��")){
   	      if (cusno==""){alert("��ѡ��ͻ�(ֻ�赥���б���ĳ��һ��)");}
		   else{openwin("deletecusdata.jsp?del=cus&cusno="+cusno,10,10,10,10);}
	  }
	}
	function view(cusno){
	 
	  if (cusno==""){alert("��ѡ��ͻ�(ֻ�赥���б���ĳ��һ��)");}
		   else{openwin("editcustomerok.jsp?cusno="+cusno,560,560,100,5);}
	  }

    function savepara(para){
			  cusno=para;
			  }
  function show(dd,obj){
  var  tr=document.all.AutoNumber.rows;

  for( var i=0;i<tr.length;i++){
    if (tr[i].trid=="tr"+dd)  
	 tr[i].style.display=(tr[i].style.display=="none")?"block":"none";
   }
   
  var img1="jia.gif";
  var img2="jian.gif";
  
  s=obj.src;
  no=parseInt(obj.no);
  if(s.indexOf("jian.gif")>-1){
     obj.src=s.replace("jian.gif","jia.gif");
  }else{
     obj.src=s.replace("jia.gif","jian.gif");
  }
  }
  function addCus(){
  //if (document.form1.section.value==""){alert("��ѡ��¥��");return false;}
   openwin('customerin.jsp',560,560,100,5)
   }
  function FindCusState(){
	document.form1.Find.value="o";
    document.form1.Findsection.value=document.form1.section.value;
    document.form1.submit();
   }
    function ch(para){
   if (para=="date"){
  fPopUpCalendarDlg(document.form1.search_like);return false;
  }
  else
  document.form1.search_like.value="";
  }
   function outexcel(){
    if (document.form1.section.value==""){alert("��ѡ����Ŀ");return false;}
	  window.open("ExcelTovisitcusview2.jsp?section="+document.form1.section.value)
  
  }
  
var sendmess="";
var sendto="";
 
function chhoseData1(){
sendmess="";
sendto="";
if (document.form1.choos.length){
   for (var i=0;i<document.form1.choos.length;i++){
 	
	  if (document.form1.choos[i].checked){
	    var aa=document.form1.choos[i].value;
		
	    if (sendmess=="")
		 sendmess=aa.substring(0,aa.indexOf("|"));
		else
		 sendmess+=","+aa.substring(0,aa.indexOf("|"));
	  
	    if (sendto=="")
		 sendto=aa.substring(aa.indexOf("|")+1);
		else
		 sendto+=","+aa.substring(aa.indexOf("|")+1);
	  
	  }
    }
	}else if (document.form1.choos.checked){
	 var aa=document.form1.choos.value;
	 sendmess=aa.substring(0,aa.indexOf("|"));
	 sendto=aa.substring(aa.indexOf("|")+1);
	}
}

function chhoseData(dd){
   for (var i=0;i<document.form1.choos.length;i++){
 	  document.form1.choos[i].checked=dd;
	 
    }

}
function sendmessage()
{
chhoseData1();
 
 if (sendmess==""){alert("��ѡ��Ŀͻ�����û���ֻ���");return false;}
openwin1("../../sendmessage/SendMessage.jsp?messtype=4&sendmess="+sendmess+"&sendto="+sendto,400,300,100,100);
}
 function gcfx(){
  if (document.form1.section.value==""){alert("��ѡ����Ŀ");return false;}
  else {
      openwin("customerRate.jsp?custype=1&section="+document.form1.section.value,800,450,100,100);
	  }
  }
  </script>
</body>
</html>
