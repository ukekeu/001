<%@ page contentType="text/html;charset=GBK" %>
 

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>�ͻ���ϸ��</title>
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

String prin=request.getParameter("print");
String Find=request.getParameter("FindS");
String tmp=request.getParameter("pageno");

String FindCon=(String)request.getParameter("condtion");
if (Find!=null){
   
  //ȡ������ֵ

   CusName=request.getParameter("cusname");//�ͻ�����
   Condi=request.getParameter("condi");//����1
   section=request.getParameter("Findsection");//ȡ��¥��

   Condi1=request.getParameter("condi1");//����2
   CusAge=request.getParameter("age");//�ͻ�����
   year=request.getParameter("SDate");//�ͻ���������
   year1=request.getParameter("EDate2");//�ͻ���������
 
   custype=request.getParameter("cusche");//�ͻ�״̬

   if (section==null)section="";
   if (!section.equals(""))
   strWhere=" and customer.section ='"+section+"'" ;
   FindCondition="customer.section='"+section+"'";
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

/*if (custype.equals("0")){
   if (strWhere.equals("")){strWhere=" and FTSALE in ('3','4')";}
   else{strWhere=strWhere+" and  FTSALE in ('3','4')";}
   
}else if (custype.equals("1")){
   if (strWhere.equals("")){strWhere=" and FTSALE in ('1','2','5')";}
   else{strWhere=strWhere+" and FTSALE in ('1','2','5')";}

}*/
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
	searchWhere="  and "+fields+" like '%"+search_like+"%' ";
	}
	 strWhere+=searchWhere;

	String oldseller=China.getParameter(request,"oldseller") ;
	String newseller=China.getParameter(request,"newseller") ;
	String sel=China.getParameter(request,"sel") ;
	if (!newseller.equals("")&&!oldseller.equals("")){
	  String old_new="Update customer set seller='"+newseller+"' where seller='"+oldseller+"' and serialno in ("+sel+")";
	   ViewBean1.executeUpdate(old_new);
	   old_new="Update order_contract set seller='"+newseller+"' where seller='"+oldseller+"'  and customer in ("+sel+")";
	   ViewBean1.executeUpdate(old_new);
	   
	}
   
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
	 if (!China.getParameter(request,"oldseller").equals("")){
	   if (strWhere.equals(""))strWhere+=" and seller like '%"+China.getParameter(request,"oldseller")+"%'";
	 }
	
 sql="select Top "+pageSize+"   customer.Code,customer.serialno,customer.cus_name,customer.cus_sex, customer.Phone,customer.sj,customer.Address,customer.Zip_Code ,customer.sj,customer.Address,customer.Zip_Code ,customer.seller,convert(char(24),customer.visit_date,111) as   visit_date,bbj,sj from customer where   Section in("+SectionS+") and  Code not in (Select top "+prenum +" code from customer where Section in("+SectionS+") " +strWhere +orderby+")   " + strWhere+orderby;
 
 sqlcount="SELECT count(code) from customer  where  Section in("+SectionS+")   "+strWhere;

ResultSet rs=null;

try{
    
  
    ViewBean1.executeUpdate("update customer set out='0'");    
    ViewBean1.executeUpdate("update customer set out='1' where section='"+section+"'");
}catch(Exception s){out.print(s.getMessage()+sql);out.close();}
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

out.print("<p align=center class=FontColor><font size=3><b>�ͻ�ת��һ����</b></font></p>");
%>
<script>
function full(){
 
 setSelectMad(document.form1.oldseller,'<%=China.getParameter(request,"oldseller") %>');
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
String Cortrol=checke_qx(ViewBean1,(String)session.getAttribute("loginid"),"C007");
 %>
   <table width=100% border="0"><tr height="16" bgcolor="#EAEAEA"><td align="left"> 
	ѡ������Ա:
	 
	 <select name="oldseller"  onchange="ordersubmit();">
	 <option></option>
  
<%String strSQL="select  seller from seller where section_no in ("+SectionS+")";
ResultSet rs2=ViewBean.executeQuery(strSQL);
  while (rs2.next()){
	   String Name=getbyte(rs2.getString("seller"));
       out.print("<option value='  "+Name+"'>"+Name+"</option>") ;
	}
  rs2.close();
  %>
	 </select>
	 ---> <select name="newseller"  >
	 	 <option></option>
    <%
strSQL="select  seller from seller where section_no in ("+SectionS+")";
 rs2=ViewBean.executeQuery(strSQL);
  while (rs2.next()){
	   String Name=getbyte(rs2.getString("seller"));
       out.print("<option value='  "+Name+"'>"+Name+"</option>") ;
	}
  rs2.close();
  %>
  
	 </select>
	  <input type=button name=fin value=" ת �� "     onclick=" checkChoose();" ></td>  </tr></table>
   
<script>
			 
			function ordersubmit(){
			 if (document.form1.oldseller.value!="")
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

<table BORDER=0 width="100%"  id=AutoNumber  CELLSPACING=1 CELLPADDING=1 ALIGN=center >
  <tr  class=listtitle>
      <td height="25"  align="center"><font color=white>���</font></td>
  <td  align="center"><font color=white>�ͻ�����</font></td>
  <td  "  align="center"><font color=white>�Ա�</font></td>
 
  <td  align="center"><font color=white>��ϵ�绰</font></td>

  <td  align="center"><font color=white>��ϵ��ַ</font></td>

  <td  align="center"><font color=white>��������</font></td>
  <td  align="center"><font color=white>����Ա</font></td>
  <td  align="center"><font color=white>ѡ��
  <%if (!China.getParameter(request,"oldseller").equals("")){ %>
	<input type="checkbox" name="sel1" onclick="choosAll(this.checked);">
	<%} %>
  </font></td>
  </tr>
 
 <%	
  try{
 
int tr=0;
    rs=ViewBean.executeQuery(sql);
	
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
	 date=getbyte(rs.getString("visit_date"));
    
	 if (sale.equals("0")){
	   sale="�蹺";
	 }
	 else if (sale.equals("1")){
	  sale="����";
	 }
	 else if (sale.equals("3")){
     sale="�Ϲ�";
	 }
     else if (sale.equals("4")){
	  sale="����";
    }
	 else if (sale.equals("2")){
	  sale="̢��";
    }
	 else if (sale.equals("8")){
	  sale="���ⷿ";
    }
	 else if (sale.equals("9")){
	  sale="���ⷿ";
    }

  //linkman=rs.getString("ContactPerson");
  if (linkman==null){linkman="δ֪";}
//  area=rs.getString("nowjuarea");
  if (area==null){area="δ֪";}

  %>

   <tr id=TR<%=i %>   trid=tr<%=tr %> align="center" class=listcontent  onmouseover="mout(this);" onclick="savepara('<%=no%>');changeclass1(this,'clickbg','listcontent');"   ondblclick="Edit();" title="˫���ɼ�¼�ͻ��ٴ��������"> 
	<td  align="center"><%=i %>��</td>
    <td  align="left"><%=Repalce(name,"/") %>��&nbsp;</td>
    <td  align="left"><%=Repalce(sex,"/") %>&nbsp;</td>

    
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
    <td  align="center"><%=date %>&nbsp;</td>
	<td  align="center"><%=sell%></td>
	<td  align="center">
	<%if (!China.getParameter(request,"oldseller").equals("")){ %>
	<input type="checkbox" name="sel" value="'<%=no %>'">
	<%} %>
	</td>
	
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
		   else{window.location="deletecusdata.jsp?del=cus&cusno="+cusno;}
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
    document.form1.cusche.value=document.form1.stateValue.options[document.form1.stateValue.selectedIndex].value;
   document.form1.submit();
  
  }
  function checkChoose(){
   var ch="";
   if (document.form1.sel){
   if (document.form1.sel.length){
   for (i=0;i<document.form1.sel.length;i++){
     if (document.form1.sel[i].checked)ch="a";

    }
	}else{
	if (document.form1.sel.checked)ch="a";
	
	}
	if (ch==""){
	 alert("��ѡ���ת�Ŀͻ�");
	 return false;
	}
	if (document.form1.newseller.value==""){
	   alert("��ѡ����տͻ�������Ա");
	 return false;
	
	}
	document.form1.submit();
	}
  }
  function choosAll(para)
  {
   if (document.form1.sel.length){
  for (var i=0;i<document.form1.sel.length;i++){
    document.form1.sel[i].checked=para;
	  
  }
  }else{
   document.form1.sel.checked=para;
  }
  
  }
  </script>

</body>
</html>
