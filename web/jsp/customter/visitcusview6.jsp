<%@ page contentType="text/html;charset=GBK" %>

<%@ include file="../public_js/logrecord.jsp" %>
 
 
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>Ԥ���ͻ���ϸ��</title>
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

String prin=China.getParameter(request,"print");
String Find=China.getParameter(request,"FindS");
String tmp=China.getParameter(request,"pageno");

String FindCon=(String)China.getParameter(request,"condtion");
if (Find!=null){
   
  //ȡ������ֵ

   CusName=China.getParameter(request,"cusname");//�ͻ�����
   Condi=China.getParameter(request,"condi");//����1
   section=China.getParameter(request,"section");//ȡ��¥��

   Condi1=China.getParameter(request,"condi1");//����2
   CusAge=China.getParameter(request,"age");//�ͻ�����
   year=China.getParameter(request,"SDate");//�ͻ���������
   year1=China.getParameter(request,"EDate2");//�ͻ���������
 
   custype=China.getParameter(request,"cusche");//�ͻ�״̬

   if (section==null)section="";
   if (!section.equals(""))
   strWhere=" and ylroom.section ='"+section+"'" ;
   FindCondition="customer.section='"+section+"'";
   FindCondition=FindCondition+"&Find="+Find;
   FindCondition=FindCondition+"&cusche="+custype;

}

%>

<%@ include file="../public_js/CheckSection.jsp"%>

<%@ include file="../public_js/qx_checke.jsp"%>
<%@ include file="../public_js/countpagenum.jsp"%>
<%
    String search_like=China.getParameter(request,"search_like");
	String fields=China.getParameter(request,"fields");
	String searchWhere="";
      if (!search_like.equals("")){
	 if (!fields.equals("dengji"))
	searchWhere="  and "+fields+" like '%"+search_like+"%' ";
	else
	searchWhere="  and  substring(convert(varchar(24),dengji,120),0,11) = '"+search_like+"' ";
	}
	 strWhere+=searchWhere;

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
String orderSQL="SELECT ylroom.LOFT+ylroom.rooms ROOM  ,CUSTOMER FROM ylroom ,customer where customer.code=ylroom.customer and ylroom.section in("+SectionS+")";
 
  ResultSet C=ViewBean.executeQuery(orderSQL);

  while (C.next()){
 
	 room.add(getbyte(C.getString("ROOM")));
     cus.add(getbyte(C.getString("CUSTOMER")));
  }C.close();
	 
	

 //get session value
    //String seller=setpro.getId();
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
	 strWhere+=" and seller like '%"+(String)session.getAttribute("loginname")+"%'";
	 }
	
 sql="select Top "+pageSize+"   customer.Code,customer.serialno,customer.cus_name,customer.cus_sex, customer.Phone,customer.sj,customer.Address,customer.Zip_Code ,customer.sj,customer.Address,customer.Zip_Code ,ylroom.person seller,convert(char(24),customer.visit_date,111) as   visit_date,customer.bbj,customer.sj,ylroom.dengji Date,CRM_Project.name,ylroom.youxiao,ylroom.section,ylroom.loft loft,ylroom.building,ylroom.rooms room_no from customer,ylroom,CRM_Project where  ylroom.customer=customer.code and CRM_Project.serialno=ylroom.section and   ylroom.Section in("+SectionS+") and  customer.Code not in (Select top "+prenum +" customer.code from customer,ylroom,CRM_Project where    CRM_Project.serialno=ylroom.section and ylroom.customer=customer.serialno and ylroom.Section in("+SectionS+") " +strWhere +orderby+")  " + strWhere;
 
 sqlcount="SELECT count(customer.code) code from customer,ylroom where  ylroom.customer=customer.code and  ylroom.Section in("+SectionS+")   "+strWhere;
 
ResultSet rs=null;
  
	//��������ֵ�ı���
    String no="";
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
   String yl_date="";
   String loft="";
   String building="";
   String roomno="";
out.print("<p align=center class=FontColor><font size=3><b>Ԥ���ͻ�һ����</b></p>");
%>
<script>
function full(){
setSelectMad(document.form1.section,'<%=China.getParameter(request,"section") %>');
 setSelectMad(document.form1.fields,'<%=China.getParameter(request,"fields") %>');
 }

</script>

<body onload="full()" oncontextmenu="return false" >

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
//Ȩ�����
String Cortrol=checke_qx(ViewBean1,(String)session.getAttribute("loginid"),"C005");
 %>
   <table width=100% border="0"><tr height="16" bgcolor="#EAEAEA"><td align="left">¥�̣�<select name="section" onchange="document.form1.submit();"> 
   <option></option>
<%  

	 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql1="select SerialNo,Name from CRM_Project where SerialNo in("+SectionS+")";

	  ResultSet rs2=ViewBean1.executeQuery(sql1);	
	  String sec="";
	  String no1="";
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
	 <input type=button name=sms value="�� ��"  onclick="sendmessage();" title="ѡ��ͻ���,���Ͷ��Ÿ��ͻ�">
<%} %>
<%if (Cortrol.indexOf("F")>=0){ %>
<input type=button name=prin title="��ӡ" value="�� ӡ" onclick="">
 <%} %>
   <select name=fields onchange="ch(this.value);">
   <option value=cus_name>�ͻ�����</option>
   <option value=rooms>Ԥ����λ</option>
   <option value=phone>��ϵ�绰</option>
   <option value=address>��ϵ��ַ</option>
   <option value=dengji>Ԥ������</option>
   <input type=text name=search_like size=30 title="ģ����ѯ���ɲ�ѯ�������绰����ַ��˫���ɵ�������" ondblclick="fPopUpCalendarDlg(search_like);return false;" value="<%=search_like %>"><input type=button name=fin value="�� ѯ"  onclick="document.form1.submit();" ></td>  </tr></table>
   
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
      <td height="25"  align="center"><input type="checkbox" name="choosall" onclick="chhoseData(this.checked);">���</td>
  <td  align="center">�ͻ�����</td>
 
  <td  align="center">��ϵ�绰</td>
  <td  align="center">��ϵ��ַ</td>
 <td  align="center">Ԥ����Ԫ</td>
  <td  align="center">Ԥ������</td>
  <td  align="center">����Ա</td>

  </tr>
 
 <%	
  try{
String floors="";
int tr=0;
 
 
    rs=ViewBean.executeQuery(sql + orderby);
	 
   while (rs.next()){
	 eof="true";
     i=i+1;
   //��FIELDS˳��һGET��VALUE
   
     no=rs.getString("SerialNo").trim();
	
     name=getbyte(rs.getString("Cus_Name"));
     sex=getbyte(rs.getString("Cus_Sex"));
     //age=rs.getString("cus_age");
     tel=getbyte(rs.getString("Phone"));
	 sj=getbyte(rs.getString("sj"));
     address=getbyte(rs.getString("address"));
	 post=getbyte(rs.getString("Zip_Code"));
    // idcard=rs.getString("ID_Card");
	 //if (idcard.length()<=1){idcard="��֪";}
     //Fomrat date
	 sell=getbyte(rs.getString("seller"));
	// floors=getbyte(rs.getString("floors"));
	 date=getbyte(rs.getString("visit_date"));
    yl_date=rs.getDate("Date").toString();
	 sectionName=getbyte(rs.getString("name"));
 
	 section =getbyte(rs.getString("section"));
	 loft =getbyte(rs.getString("loft"));
	 building=getbyte(rs.getString("building"));
	 roomno =getbyte(rs.getString("room_no"));
	   

  //linkman=rs.getString("ContactPerson");
  if (linkman==null){linkman="δ֪";}
//  area=rs.getString("nowjuarea");
  if (area==null){area="δ֪";}

  %>

   <tr id=TR<%=i %>   trid=tr<%=tr %> align="center"  onmouseover="mout(this);"  ondblclick="window.open('editcustomer.jsp?cusno=<%=no %>','edit_i','height=550,width=510,left=150,top=10,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no');" onclick="savepara('<%=no%>');changeclass1(this,'clickbg','');" > 
	<td  align="left"><input type="checkbox" name="choos" value="<%=sj+"|"+name%>"><%=i %>��</td>
    <td  align="left"><a href="#" onclick="window.open('editcustomer.jsp?cusno=<%=no %>','edit_i','height=550,width=510,left=150,top=10,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no');"><%= name %></a> ��&nbsp;</td>
  

    
    <td  align="left">
	<%String strt="";
	String strs="";
	if (tel.indexOf(" ")>0)strt=" ";
	if (tel.indexOf("/")>0)strt="/";
	if (sj.indexOf(" ")>0)strs=" ";
	if (sj.indexOf("/")>0)strs="/";
	 %>
	<%out.print(Repalce(tel,strt));  
	  %>&nbsp;<br><%=Repalce(sj,strs)%></td>
	 
 
<td  align="left" title="<%=address %>"> <%
	 
	if (address.length()>14)address=address.substring(1,14)+"...";
	if (!post.trim().equals(""))address+="("+post+")" ;
	out.print(address);
	%>&nbsp;</td>
	 
	<%
 
	if (cus.contains(no)){
	  int index=cus.indexOf(no);
	  roomno=(String)room.get(index);
	}  
	 %>
	
	    <td  align="left"><%=loft+roomno %>&nbsp;</td>
    <td  align="center"><%=yl_date %>&nbsp;</td>
	<td  align="center"><%=sell%></td>
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
		     else{ openwin("CusFeedBack.jsp?cusno="+cusno,560,560,100,5);}
	
	}

	function Dele(){
	 if (confirm("���Ҫɾ��ѡ��Ŀͻ���Ϣ��")){
   	      if (cusno==""){alert("��ѡ��ͻ�(ֻ�赥���б���ĳ��һ��)");}
		   else{openwin("deletecusdata.jsp?del=cus&cusno="+cusno,10,10,10,10);}
	  }
	}
	
	function view(){
	  if (cusno==""){alert("��ѡ��ͻ�(ֻ�赥���б���ĳ��һ��)");}
		   else{openwin("editcustomer.jsp?cusno="+cusno,560,560,100,5);}
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
  //  document.form1.cusche.value=document.form1.stateValue.options[document.form1.stateValue.selectedIndex].value;
   document.form1.submit();
  
  }
    function ch(para){
   if (para=="dengji"){
  fPopUpCalendarDlg(document.form1.search_like);return false;

  }
  else
  document.form1.search_like.value="";
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
  </script>

</body>
</html>
