<%@ page contentType="text/html;charset=GBK" %>
 

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
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
String orderSQL="SELECT LOFT+building+ROOM_NO ROOM  ,CUSTOMER FROM ORDER_CONTRACT where state=2 and section in("+SectionS+")"+strWhere;
   
	 
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
	orderby=" order by customer.cus_name desc";
	
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
	String yong_tu="";
	String PubPra=(String)session.getAttribute("Attribute");	
    String user=(String)session.getAttribute("loginname");	
	String job=(String)session.getAttribute("job");	
	 if (job.indexOf("销售员")>=0){
	   if (strWhere.equals(""))strWhere+=" and seller like '%"+(String)session.getAttribute("loginname")+"%'";
	 }
	
 sql="select    customer.Code,customer.serialno,  customer.ID_Card, customer.cus_name,customer.cus_sex, customer.Phone,customer.sj,customer.Address,customer.Zip_Code ,customer.sj,customer.Address,customer.Zip_Code ,Order_Contract.seller,Order_Contract.floors,convert(char(24),customer.visit_date,111) as   visit_date,customer.bbj,customer.sj,Order_Contract.VisaDate,Order_Contract.sectionname,Order_Contract.section,Order_Contract.loft,Order_Contract.building,Order_Contract.room_no,Order_Contract.ContractNo,Order_Contract.yong_tu from customer,Order_Contract where  Order_Contract.customer=customer.serialno and  Order_Contract.Section ='"+request.getParameter("section")+"'  and  Order_Contract.state=2 " + strWhere;

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
   String ContractNo="";
   String loft="";
   String building="";
   String roomno="";
   String ID_Card="";

%>
<script>
function full(){
setSelectMad(document.form1.section,'<%=section%>');
setSelectMad(document.form1.fields,'<%=fields%>');

 }

</script>

<body >

<form name=form1 method="post" >
 <div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >
<p align=center class=FontColor><font size=3><b>签约客户一览表</b></font></p>
<table width=99%><tr height="3"><td></td></tr></table>
<center>

<table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  >
      <td    align="center">序号</td>
  <td  align="center">客户姓名</td>
  <td  align="center">身份证号</td>
  <td  align="center">联系电话</td>
<td  align="center">联系手机</td>
  <td  align="center">联系地址</td>
    <td  align="center">购买单位</td>
	  <td  align="center">合同号</td>
  <td  align="center">签约日期</td>
    <td  align="center">用途</td>
  <td  align="center">销售员</td>

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
	ID_Card=getbyte(rs.getString("ID_Card"));
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
	 building =getbyte(rs.getString("building"));
	 roomno =getbyte(rs.getString("room_no"));
	 ContractNo=getbyte(rs.getString("ContractNo"));
	 yong_tu=getbyte(rs.getString("yong_tu"));
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

   <tr id=TR<%=i %>   trid=tr<%=tr %> align="center"> 
	<td  align="center"><%=i %>　</td>
    <td  align="left"><%=Repalce(name,"/") %>　&nbsp;</td>
	<td  align="left"><%=Repalce(ID_Card,"/") %>　&nbsp;</td>
	
    <td  align="left">
	<%String strt="";
	String strs="";
	if (tel.indexOf(" ")>0)strt=" ";
	if (tel.indexOf("/")>0)strt="/";
	if (sj.indexOf(" ")>0)strs=" ";
	if (sj.indexOf("/")>0)strs="/";
	 %>
	<%out.print(tel);  
	  %></td>
	 <td  align="left"><%=sj %></td>
     
    <td  align="left" title="<%=address %>"> <%
	 
	//if (address.length()>14)address=address.substring(1,14)+"...";
	if (!post.trim().equals(""))address+="("+post+")" ;
	out.print(address);
	%>&nbsp;</td>

	
	 <td  align="left"><%=sectionName+loft+building+roomno %>&nbsp;</td>
	 <td  align="left"><%=ContractNo %>&nbsp;</td>
    <td  align="center"><%=VisaDate %>&nbsp;</td>
	<td align="center"><%=yong_tu %></td>
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
  
</table>
</div><DIV align=center id="printdiv">
<input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
  <input type="button" onclick="bringToExcel()" value="导出到Excel"> 
   </div>
</form>
</center>

 
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

</body>
</html>
