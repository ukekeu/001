<%@ page contentType="text/html;charset=GBK" %>

<%@ include file="../public_js/logrecord.jsp" %>
<%	
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "客户一览" , 
                  "浏览"
                ) ;
			
%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>客户明细表</title>
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
String FindCondition="";//传递参数变量
String orderbytype=China.getParameter(request,"orderbytype");
String orderby=China.getParameter(request,"orderby");
String gradetype=China.getParameter(request,"gradetype");

String prin=request.getParameter("print");
String Find=request.getParameter("FindS");
String tmp=request.getParameter("pageno");

String FindCon=(String)request.getParameter("condtion");
if (Find!=null){
   
  //取出条件值

   CusName=request.getParameter("cusname");//客户姓名
   Condi=request.getParameter("condi");//条件1
   section=request.getParameter("section");//取出楼盘

   Condi1=request.getParameter("condi1");//条件2
   CusAge=request.getParameter("age");//客户年龄
   year=request.getParameter("SDate");//客户来访日期
   year1=request.getParameter("EDate2");//客户来访日期
 
   custype=request.getParameter("cusche");//客户状态

   if (section==null)section="";
   if (!section.equals(""))
   strWhere=" and Order_Contract.section ='"+section+"'" ;
   FindCondition=" Order_Contract.section='"+section+"'";
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
	 if (!fields.equals("VisaDate"))
	searchWhere="  and "+fields+" like '%"+search_like+"%' ";
	else
	searchWhere="  and "+fields+" = '"+search_like+"' ";
	}
	 strWhere+=searchWhere;

	 
	if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
List room=new LinkedList();//存放业主买单元
List cus=new LinkedList();//存放业主
String orderSQL="SELECT LOFT+ROOM_NO ROOM  ,CUSTOMER FROM ORDER_CONTRACT where state=2 and section in("+SectionS+")"+strWhere;
  
  ResultSet C=ViewBean.executeQuery(orderSQL);
 
  while (C.next()){
 
	 room.add(getbyte(C.getString("ROOM")));
     cus.add(getbyte(C.getString("CUSTOMER")));
  }C.close();
	 
	 
 //排序方式
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
	

 //get session value
    //String seller=setpro.getId();
	String sql="";
	int totalnum=0;
    //读取查询条件
	
	String con=FindCon;
	if (FindCon!=null){
    	FindCon=" = "+FindCon;
    	}
    else{
	   FindCon="='0' ";
	 }  
	String condtion=FindCon;		
    String eof="false";
	String floors="";
	String PubPra=(String)session.getAttribute("Attribute");	
    String user=(String)session.getAttribute("loginname");	
	String job=(String)session.getAttribute("job");	
	 if (job.indexOf("销售员")>=0){
	   if (strWhere.equals(""))strWhere+=" and seller like '%"+(String)session.getAttribute("loginname")+"%'";
	 }
	
 sql="select Top "+pageSize+"   customer.Code,customer.serialno,customer.cus_name,customer.cus_sex, customer.Phone,customer.sj,customer.Address,customer.Zip_Code ,customer.sj,customer.Address,customer.Zip_Code ,Order_Contract.seller,Order_Contract.floors,convert(char(24),customer.visit_date,111) as   visit_date,customer.bbj,customer.sj,Order_Contract.VisaDate,Order_Contract.sectionname,Order_Contract.section,Order_Contract.loft,Order_Contract.room_no from customer,Order_Contract where  Order_Contract.customer=customer.serialno and  Order_Contract.Section in("+SectionS+") and  customer.Code not in (Select top "+prenum +" customer.code from customer,Order_Contract where  Order_Contract.customer=customer.serialno and Order_Contract.Section in("+SectionS+") and Order_Contract.state=2" +strWhere +orderby+")  and  Order_Contract.state=2 " + strWhere;
 
 sqlcount="SELECT count(customer.code) code from customer,Order_Contract where  Order_Contract.customer=customer.serialno and  Order_Contract.Section in("+SectionS+")  and  Order_Contract.state=2 "+strWhere;
 
ResultSet rs=null;
 
try{
    
  
    ViewBean1.executeUpdate("update customer set out='0'");    
     ViewBean1.executeUpdate("update customer set out='1' where  serialno in (select Order_Contract.customer from  customer,Order_Contract where  Order_Contract.customer=customer.serialno and  Order_Contract.Section in("+SectionS+")  and  Order_Contract.state=2 "+strWhere+")");
}catch(Exception s){out.print(s.getMessage()+sql);out.close();}
	//保存输入值的变量
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
   
   String loft="";
   String roomno="";
out.print("<p align=center class=FontColor><font size=3><b>签约客户一览表</b></font></p>");
%>
<script>
function full(){
setSelectMad(document.form1.section,'<%=section%>');
 }

</script>

<body onload="full()">

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
//权限审核
String Cortrol=checke_qx(ViewBean1,(String)session.getAttribute("loginid"),"C005");
 %>
   <table width=100% border="0"><tr height="16" bgcolor="#EAEAEA"><td align="left">

   楼盘：<select name="section" onchange="document.form1.submit();"> 
   <option></option>
<%  

	 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql1="select SerialNo,Name FROM crm_project where SerialNo in("+SectionS+")";

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
	<script>
	function changesub(para){
			document.form1.Findsection.value=para;
			
			document.form1.Find.value="o";
			//document.form1.cusche.value=document.form1.stateValue.options[document.form1.stateValue.selectedIndex].value;
			document.form1.submit();
			
			}
	</script>
<%if (Cortrol.indexOf("E")>=0){ %>
	<input type=button name=mail value="邮 件" disabled title="选择客户后,给客户发送邮件"><input type=button name=sms value="短 信" disabled title="选择客户后,发送短信给客户">
<%} %>
    <%if (Cortrol.indexOf("F")>=0){ %><input type=button name=prin title="打印" value="打 印" onclick="window.open('<%=reportAddrs %>CusListReprot.rpt')">
    
   <%} %>
    
   <select name=fields onchange="ch(this.value);">
   <option value=cus_name>客户姓名</option>
    <option value=room_no>购买单位</option>
   <option value=phone>联系电话</option>
   <option value=address>联系地址</option>
   <option value=VisaDate>签约日期</option>
   <input type=text name=search_like size=30 title="模糊查询，可查询姓名、电话、地址，双击可弹出日期" ondblclick="fPopUpCalendarDlg(search_like);return false;" value="<%=search_like %>"><input type=button name=fin value="查 询"  onclick="document.form1.submit();" ></td>  </tr></table>
  
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
      <td height="25"  align="center"><font color=white>序号</font></td>
  <td  align="center"><font color=white>客户姓名</font></td>
 
  <td  align="center"><font color=white>联系电话</font></td>

  <td  align="center"><font color=white>联系地址</font></td>
    <td  align="center"><font color=white>购买单位</font></td>
  <td  align="center"><font color=white>签约日期</font></td>
  <td  align="center"><font color=white>销售员</font></td>

  </tr>
 
 <%	
  try{

int tr=0;
    rs=ViewBean.executeQuery(sql + orderby);
	
   while (rs.next()){
	 eof="true";
     i=i+1;
   //按FIELDS顺序一GET　VALUE
   
     no=rs.getString("SerialNo").trim();
	
     name=getbyte(rs.getString("Cus_Name"));
     sex=getbyte(rs.getString("Cus_Sex"));
     //age=rs.getString("cus_age");
     tel=getbyte(rs.getString("Phone"));
	 sj=getbyte(rs.getString("sj"));
     address=getbyte(rs.getString("address"));
	 post=getbyte(rs.getString("Zip_Code"));
    // idcard=rs.getString("ID_Card");
	 //if (idcard.length()<=1){idcard="不知";}
     //Fomrat date
	 sell=getbyte(rs.getString("seller"));
	 floors=getbyte(rs.getString("floors"));
	 date=getbyte(rs.getString("visit_date"));
    VisaDate=rs.getDate("VisaDate").toString();
	 sectionName=getbyte(rs.getString("sectionname"));
	 section =getbyte(rs.getString("section"));
	 loft =getbyte(rs.getString("loft"));
	 roomno =getbyte(rs.getString("room_no"));
	 if (sale.equals("0")){
	   sale="需购";
	 }
	 else if (sale.equals("1")){
	  sale="换房";
	 }
	 else if (sale.equals("3")){
     sale="认购";
	 }
     else if (sale.equals("4")){
	  sale="购买";
    }
	 else if (sale.equals("2")){
	  sale="挞订";
    }
	 else if (sale.equals("8")){
	  sale="需租房";
    }
	 else if (sale.equals("9")){
	  sale="已租房";
    }

  //linkman=rs.getString("ContactPerson");
  if (linkman==null){linkman="未知";}
//  area=rs.getString("nowjuarea");
  if (area==null){area="未知";}

  %>

   <tr id=TR<%=i %>   trid=tr<%=tr %> align="center" class=listcontent  onmouseover="mout(this);"  onclick="savepara('<%=no%>'); changeclass1(this,'clickbg','listcontent');" ondblclick="openwin1('../sale/ContractInput.jsp?secname=<%=sectionName %>&secno=<%=section %>&roomno=<%=roomno %>&build=&loft=<%=loft %>&Floor=<%=floors %>&show=true',680,530,50,2);" title="双击可看合同资料"> 
	<td  align="center"><input type="checkbox" value="<%=no%>"><%=i %>　</td>
    <td  align="left"><%=Repalce(name,"/") %>　&nbsp;</td>
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
 /*
	if (cus.contains(no)){
	  int index=cus.indexOf(no);
	  roomno=(String)room.get(index);
	}  
	*/
	 %>
	
	    <td  align="left"><%=roomno %>&nbsp;</td>
    <td  align="center"><%=VisaDate %>&nbsp;</td>
	<td  align="center"><%=sell%></td>
   </tr>

<%

  }
   
   
}catch(Exception s){out.println(s.getMessage());}
 
rs.close();
if (eof.equals("false")){
   out.print("没有找到客户记录"); 
  
   }

 

 %> 
  <%@ include file="../public_js/changepage.jsp"%>
</table>
</form>
</center>

<script>
 
   var cusno="";
    function Edit(){
    	
   	         if (cusno==""){alert("请选择客户(只需单击列表中某行一次)");}
		     else{ openwin("CusFeedBack.jsp?cusno="+cusno,560,560,100,5);}
	
	}

	function Dele(){
	 if (confirm("真的要删除选择的客户信息吗？")){
   	      if (cusno==""){alert("请选择客户(只需单击列表中某行一次)");}
		else{openwin("deletecusdata.jsp?del=cus&cusno="+cusno,10,10,10,10);}
	  }
	}
	
	function view(){
	  if (cusno==""){alert("请选择客户(只需单击列表中某行一次)");}
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
  //if (document.form1.section.value==""){alert("请选择楼盘");return false;}
   openwin('customerin.jsp',560,560,100,5)
   }
  function FindCusState(){
	document.form1.Find.value="o";
    document.form1.Findsection.value=document.form1.section.value;
    document.form1.cusche.value=document.form1.stateValue.options[document.form1.stateValue.selectedIndex].value;
   document.form1.submit();
  
  }
    function ch(para){
   if (para=="VisaDate"){
  fPopUpCalendarDlg(document.form1.search_like);return false;

  }
  else
  document.form1.search_like.value="";
  }
  </script>

</body>
</html>
