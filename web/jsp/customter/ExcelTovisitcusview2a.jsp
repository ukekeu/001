<%@ page contentType="text/html;charset=GBK" %>
　

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>成交客户档案</title>
</head>

  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/Repalce.jsp"%>
 
 
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
String Date1=request.getParameter("Date1");
String Date2=request.getParameter("Date2");
String Loft=China.getParameter(request,"Loft");
String SecNo1=request.getParameter("section");
String datetype=request.getParameter("datetype");
String payment1=China.getParameter(request,"payment");
String SQLWHERE="";
if (datetype.equals("1"))
  SQLWHERE=" Order_Contract.date between '"+Date1+"' and  '"+Date2+"' and  Order_Contract.section='"+SecNo1+"'";
else if (datetype.equals("2"))
    SQLWHERE=" customer.csdate between '"+Date1+"' and  '"+Date2+"'    and Order_Contract.section='"+SecNo1+"'";
else if (datetype.equals("3"))
 SQLWHERE=" Order_Contract.visadate between '"+Date1+"' and  '"+Date2+"'    and Order_Contract.section='"+SecNo1+"'";
if (!payment1.equals(""))SQLWHERE+=" and Order_Contract.payment1 like '%"+payment1+"%'";
if (!Loft.equals(""))SQLWHERE+=" and Order_Contract.loft='"+Loft+"'";




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
    String search_like=China.getParameter(request,"search_like");
	String fields=China.getParameter(request,"fields");
	String searchWhere="";
      if (!search_like.equals("")){
	 if (!fields.equals("date"))
	searchWhere="  and "+fields+" like '%"+search_like+"%' ";
	else
	searchWhere="  and "+fields+" = '"+search_like+"' ";
	}
	 strWhere+=searchWhere;

 //排序方式
	if (!orderbytype.equals("")&&!orderby.equals("")){
	  if (orderbytype.equals("0")&&orderby.equals("0")) orderby=" order by  Order_Contract.loft+room_no,customer.visit_date desc";
	  if (orderbytype.equals("0")&&orderby.equals("1")) orderby=" order by  Order_Contract.loft+room_no,customer.visit_date asc";
	  if (orderbytype.equals("1")&&orderby.equals("0")) {orderby=" order by  Order_Contract.loft+room_no,customer.cus_name desc";}
	  if (orderbytype.equals("1")&&orderby.equals("1")) orderby=" order by  Order_Contract.loft+room_no,customer.cus_name asc";
	} 
	 else if (!orderby.equals("")){
	  if ( orderby.equals("0")) orderby=" order by  Order_Contract.loft+room_no,customer.cus_name desc";
	  if ( orderby.equals("1")) orderby=" order by  Order_Contract.loft+room_no,customer.cus_name asc";
	
	}else if (!orderby.equals("")&&!orderbytype.equals("")){
	 if (orderbytype.equals("0")&&orderby.equals("0")) orderby=" order by   Order_Contract.loft+room_no,customer.visit_date desc";
	 if (orderbytype.equals("1")&&orderby.equals("0")) orderby=" order by    Order_Contract.loft+room_no,customer.cus_name desc";
	 if ( orderbytype.equals("1")&&orderby.equals("1")) orderby=" order by   Order_Contract.loft+room_no,customer.cus_name desc";
     if ( orderbytype.equals("0")&&orderby.equals("1")) orderby=" order by   Order_Contract.loft+room_no,customer.visit_date desc";
	}else{
	orderby=" order by  Order_Contract.loft+room_no,"+request.getParameter("px")+" ";
	
	
	}
	 
if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
List room=new LinkedList();//存放业主买单元
List cus=new LinkedList();//存放业主
String orderSQL="SELECT LOFT+ROOM_NO ROOM  ,CUSTOMER FROM ORDER_CONTRACT where state<>3 and section in("+SectionS+")"+strWhere;
 
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
	
	String PubPra=(String)session.getAttribute("Attribute");	
    String user=(String)session.getAttribute("loginname");	
	String job=(String)session.getAttribute("job");	
	 if (job.indexOf("销售员")>=0){
	   if (strWhere.equals(""))strWhere+=" and Order_Contract.seller like '%"+(String)session.getAttribute("loginname")+"%'";
	 }
	
 sql="select   customer.ID_Card,  customer.cus_name, customer.Code,customer.serialno,customer.cus_sex, customer.Phone,customer.sj,customer.Address,Order_Contract.ContractNo,customer.Zip_Code ,customer.sj,customer.Address,customer.Zip_Code ,Order_Contract.seller,Order_Contract.floors,convert(char(10),Order_Contract.visadate,120) as   visadate,customer.bbj,customer.sj,convert(char(10),Order_Contract.date,120) as Date,Order_Contract.jzarea,Order_Contract.rmbprice,Order_Contract.sectionname,Order_Contract.section,Order_Contract.loft,Order_Contract.room_no,Order_Contract.yong_tu from customer,Order_Contract where  "+SQLWHERE+" and Order_Contract.customer=customer.serialno   and Order_Contract.state<>3    and Order_Contract.section ='"+request.getParameter("section")+"'   " + strWhere;
 
 sqlcount="SELECT count(customer.code) code from customer,Order_Contract where  "+SQLWHERE+" and  Order_Contract.customer=customer.serialno and Order_Contract.state<>3 and customer.section=Order_Contract.section and Order_Contract.section in("+SectionS+")   "+strWhere;
 
ResultSet rs=null;
 
 
	//保存输入值的变量
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
   String ContractNo="";
   String attention="";
   String VisaDate="";
   String sectionName="";
   String ID_Card="";
   String loft="";
   String roomno="";
   String jzarea="0";
   String rmbprice="0";

%>


<body >  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
<form name=form1 method="post" >

 <div align=left id=report1  >
<div id=titlestr><p align=center class=FontColor><font size=3><b>成交客户档案</b></font></p></div>
<table width=99%><tr height="3"><td></td></tr></table>
<center>

<table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr >
      <td   align="center">序号</td>
	   <td  align="center">购买单元</td>
  <td  align="center">建筑面积</td>
  <td  align="center">成交价格</td>
  <td  align="center">客户姓名</td>
  <td  align="center">证件号</td>
  <td  align="center">联系电话</td>
 
  <td  align="center">联系地址</td>

  
  <td  align="center">认购日期</td>
  <td  align="center">签约日期</td>
  <td  align="center">合同号</td>
   <td  align="center">用途</td>
  <td  align="center">销售员</td>

  </tr>
 
 <%	
  try{
String floors="";
int tr=0;
    rs=ViewBean.executeQuery(sql + orderby);
	 
   while (rs.next()){
	 eof="true";
     i=i+1;
	  
   //按FIELDS顺序一GET　VALUE
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
	 
 	date=getbyte(rs.getString("Date"));
	VisaDate=getbyte(rs.getString("VisaDate"));
	 if (!VisaDate.equals(""))VisaDate=VisaDate.substring(0,10);
	  ContractNo=getbyte(rs.getString("ContractNo"));
	 sectionName=getbyte(rs.getString("sectionname"));
	 jzarea=getbyte(rs.getString("jzarea"));
	 rmbprice=getbyte(rs.getString("rmbprice"));
	 
	 section =getbyte(rs.getString("section"));
	 loft =getbyte(rs.getString("loft"));
	 roomno =getbyte(rs.getString("room_no"));
	  yong_tu=getbyte(rs.getString("yong_tu"));
	 

  %>

   <tr id=TR<%=i %>   trid=tr<%=tr %> align="center"   > 
	<td  align="center"> <%=i %></td>
	<td  align="left"><%=loft+roomno %></td>
		   <td  align="right"><%=jzarea %></td>
		   <td   align="right"><%=rmbprice %></td>
    <td  align="left"><%=name %></td>
	<td  align="left"><%=ID_Card %>&nbsp;</td>
    <td  align="left">&nbsp;
	<%String strt="";
	String strs="";
	if (tel.indexOf(" ")>0)strt=" ";
	if (tel.indexOf("/")>0)strt="/";
	if (sj.indexOf(" ")>0)strs=" ";
	if (sj.indexOf("/")>0)strs="/";
	 %>
	<%out.print(tel+" "+sj);  
	  %>&nbsp;</td>
	 
 
<td  align="left" title="<%=address %>">&nbsp;<%
	 
	 
	if (!address.trim().equals(""))address+="("+post+")" ;
	out.print(address);
	%></td>
	    
		   
    <td  align="center"><%=date %></td>
	   <td  align="center"><%=VisaDate %>&nbsp;</td>
	      <td  align="center"><%=ContractNo %>&nbsp;</td>
	    <td  align="center"><%=yong_tu %></td>
	<td  align="center"><%=sell%>&nbsp;</td>
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
</div>
<DIV align=center id="printdiv">
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
  <input type="button" onclick="bringToExcel()" value="导出到Excel"> 
<br>导入前必须进行相应设置：<br>
　1.在IE工具栏中选择"internet选项"<br>
　2.选择"安全"->选择"本地intranet"后再点击"自定义级别"<br>
  3.把所有ActiveX启用都选中后点击确认退后。<br>
 </div>
</form>
</center>
<script>
titlestr.innerHTML="<p align=center class=FontColor><font size=3><b><%=sectionName %>成交客户档案</b></font></p>";
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
