<%@ page contentType="text/html;charset=GBK" %>

<%@ include file="../public_js/logrecord.jsp" %>
<%	
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "临订客户一览表" , 
                  "导出"
                ) ;
			
%>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>临定客户明细表</title>
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
String chooseSection=China.getParameter(request,"section");
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
   strWhere=" and  r.seccode ='"+section+"'" ;
   FindCondition=" r.seccode='"+section+"'";
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
	   if (!fields.equals("visit_date"))
    	searchWhere="  and "+fields+" like '%"+search_like+"%' ";
	   else
	    searchWhere="  and "+fields+" = '"+search_like+"' ";
	}
	 strWhere+=searchWhere;

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

if (!SecNo.equals(""))SectionS="'"+SectionS+"'";
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
	
	String PubPra=(String)session.getAttribute("Attribute");	
    String user=(String)session.getAttribute("loginname");	
	String job=(String)session.getAttribute("job");	
	
	if (!chooseSection.equals(""))strWhere+=" and  r.seccode='"+chooseSection+"'";
	 if (job.indexOf("销售员")>=0){
	   if (strWhere.equals(""))strWhere+=" and seller like '%"+(String)session.getAttribute("loginname")+"%'";
	 }
		
 sql="select customer.ID_Card, customer.cus_name, customer.Code,customer.serialno,customer.cus_sex, customer.Phone,customer.sj,customer.Address,customer.Zip_Code ,customer.sj,customer.Address,customer.Zip_Code ,SL_TemporarilyBuy.receiver seller,convert(char(24),customer.visit_date,111) as   visit_date,customer.bbj,customer.sj,SL_TemporarilyBuy.startdate date,r.loft+r.building+r.room_code a from customer,SL_TemporarilyBuy ,room r where r.code=SL_TemporarilyBuy.roomcode and SL_TemporarilyBuy.state=0    and SL_TemporarilyBuy.zto=0 and SL_TemporarilyBuy.cusname=customer.serialno and  r.seccode ='"+request.getParameter("section")+"'    " + strWhere;
sqlcount="SELECT  name FROM crm_project where serialno='"+request.getParameter("section")+"'";
 
ResultSet rs=null;
String sectionname="";
 rs=ViewBean.executeQuery(sqlcount);
 if (rs.next())sectionname=rs.getString("name");
 rs.close();
 
try{
    


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
out.print("<p align=center class=FontColor><font size=3><b 临订客户一览表</b></p>");
%>
<script>
function full(){
  setSelectMad(document.form1.section,'<%=request.getParameter("section") %>');
 

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
 <div align=left id=report1 style="background-color:#F7F7F7;height:100%;overflow:auto;width:100%;z-index:2" contentEditable >
 <%
//权限审核
String Cortrol=checke_qx(ViewBean1,(String)session.getAttribute("loginid"),"C003");
 
 
out.print("<p align=center class=FontColor><font size=3><b>临订客户 一览表</b></p>");
%>
 
 

<table width="99%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr   >
      <td height="25"  align="center">序号</td>
  <td  align="center">客户姓名</td>
  <td  "  align="center">性别</td>
   <td  "  align="center">身份证号</td>
  <td  align="center">联系电话</td>
   <td  align="center">联系手机</td>
  <td  align="center">联系地址</td>
  <td  align="center">临订单位</td>
  <td  align="center">临订日期</td>
  <td  align="center">销售员</td>

  </tr>
 
 <%	
  try{
    String roomno="";
    int tr=0;
	 String cusno="";
    rs=ViewBean.executeQuery(sql + orderby);
	 cusno="";
 
   while (rs.next()){
	 eof="true";
     i=i+1;
   //按FIELDS顺序一GET　VALUE
     String IDCard=getbyte(rs.getString("ID_Card"));
     name=getbyte(rs.getString("Cus_Name"));
     no=rs.getString("SerialNo").trim();
	 if (cusno.equals(""))cusno="('"+no+"'";
	 else cusno+=",'"+no+"'";
     
     sex=getbyte(rs.getString("Cus_Sex"));
     tel=getbyte(rs.getString("Phone"));
	 sj=getbyte(rs.getString("sj"));
     address=getbyte(rs.getString("address"));
	 post=getbyte(rs.getString("Zip_Code"));
    // idcard=rs.getString("ID_Card");
	 //if (idcard.length()<=1){idcard="不知";}
     //Fomrat date
	 sell=getbyte(rs.getString("seller"));
	 date=getbyte(rs.getString("visit_date"));
    VisaDate=rs.getDate("date").toString();
	roomno=getbyte(rs.getString("a"));
	 

  %>

   <tr id=TR<%=i %>   trid=tr<%=tr %> align="center"  onmouseover="mout(this);"  onclick="savepara('<%=no%>');changeclass1(this,'clickbg','listcontent');" ondblclick="Edit();" title="双击可记录客户再次来访情况"> 
	<td  align="center"><%=i %>　</td>
    <td  align="left"><%=Repalce(name,"/") %>　&nbsp;</td>
    <td  align="left"><%=Repalce(sex,"/") %>&nbsp;</td>
   <td  align="left"><%=Repalce(IDCard,"/") %>&nbsp;</td>
    
    <td  align="left">
	<%String strt="";
	String strs="";
	if (tel.indexOf(" ")>0)strt=" ";
	if (tel.indexOf("/")>0)strt="/";
	if (sj.indexOf(" ")>0)strs=" ";
	if (sj.indexOf("/")>0)strs="/";
	 %>
	<%out.print(Repalce(tel,strt));  
	  %></td>
	 
   <td  align="left"><%=Repalce(sj,strs) %></td>
    <td  align="left" title="<%=address %>"> <%
	 
	if (address.length()>14)address=address.substring(1,10)+"...";
	//if (!post.trim().equals(""))address+="("+post+")" ;
	out.print(address);
	%>&nbsp;</td>
	 <td  align="left"><%=sectionname+roomno %>&nbsp;</td>
    <td  align="center"><%=VisaDate %>&nbsp;</td>
	<td  align="center"><%=sell%></td>
   </tr>

<%

  }
    ViewBean1.executeUpdate("update customer set out='0'");    
    ViewBean1.executeUpdate("update customer set out='1' where  serialno in (SELECT customer.serialno from customer,SL_TemporarilyBuy,room r where  r.code=SL_TemporarilyBuy.roomcode and  SL_TemporarilyBuy.cusname=customer.serialno  and  customer.Section in("+SectionS+")   "+strWhere+")");
 
}catch(Exception s){out.println(s.getMessage());}
 
rs.close();
if (eof.equals("false")){
   out.print("没有找到客户记录"); 
  
   }

 

 %> 
 </table>
</form>
</div>
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
     oSheet.Paste();     
     oXL.Visible = true;     
     oXL.UserControl = true;
  } 
 bringToExcel();
  window.close();
  </script>

</body>
</html>
