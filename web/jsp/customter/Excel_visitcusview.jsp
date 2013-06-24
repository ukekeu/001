<%@ page contentType="text/html;charset=GBK" %>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel="stylesheet" type="text/css" href="UltraGrid.css">	
<title>客户明细表</title>
</head>

  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 
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
 
String custype="";
String cusche="";
 
 
 

%>

 
 
<%
String chooseseller=China.getParameter(request,"seller");
 String section=China.getParameter(request,"section");
 String Date1=China.getParameter(request,"Date1");
 String Date2=China.getParameter(request,"Date2");
 String px=China.getParameter(request,"px");
 String lffs=China.getParameter(request,"lffs");
 if (lffs.equals("")||lffs.equals("0"))lffs=" and  visitstate=0";
 else lffs=" and  visitstate=1";
 String choose	  =China.getParameter(request,"choose");
 if (!chooseseller.equals(""))
   chooseseller=" and customer.seller='"+chooseseller+"' ";
	String sql="";
	  sql="select  customer.section,customer.code,customer.Code,customer.serialno,customer.cus_name,customer.cus_sex, customer.Phone,customer.sj,customer.Address,customer.region,customer.Zip_Code ,customer.sj,customer.Address,customer.yixianmianji,customer.demand,customer.Knowledge_From,customer.Zip_Code ,customer.seller,convert(char(10),customer.visit_date,120) as   visit_date,bbj,sj from customer where customer.state="+choose+chooseseller+" and   customer.visit_date between '"+Date1+"' and '"+Date2+"' and  section='"+section+"' "+lffs+" and not serialno  in (select customer from order_contract where state<>3 and Section ='"+section+"' )    " ;
 
ResultSet rs=null;
    rs=ViewBean.executeQuery(sql +"order by visit_date desc");
 
 
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
 
%>
 

<body  >

<form name=form1 method="post" > 
<DIV align=center id="printdiv">
 <br><input type="button" name="Button" value="打印预览" onClick="window.printdiv.style.display='none';javascript:document.all.WebBrowser.ExecWB(7,1);window.printdiv.style.display='block'">
 <input type="button" name="Button" value="导 出" onClick="bringToExcel();">
  
 </div>
  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>
  <div align=left id=report1  >
<p align=center class=FontColor><font size=3><b>客户信息一览表</b></p>

<table width="95%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr   >
      <td height="25"  align="center">序号</td>
  <td  align="center">客户姓名</td>
 
  <td  align="center">联系电话</td>
  <td  align="center">联系地址</td>
 <td  align="center">来自区域</td>
  <td  align="center">意向户型</td>
    <td  align="center">意向面积</td>
	<td  align="center">了解途径</td>
  <td  align="center">来访日期</td>
  <td  align="center">销售员</td>

  </tr>
　
 <%	
  try{

int tr=0;

	
   while (rs.next()){
	 
     i=i+1;
   //按FIELDS顺序一GET　VALUE
   
     no=rs.getString("SerialNo").trim();
	 String code=rs.getString("code").trim();
     name=getbyte(rs.getString("Cus_Name"));
     sex=getbyte(rs.getString("Cus_Sex"));
     //age=rs.getString("cus_age");
     tel=getbyte(rs.getString("Phone"));
	 sj=getbyte(rs.getString("sj"));
     address=getbyte(rs.getString("address"));
	 post=getbyte(rs.getString("Zip_Code"));
    
	 sell=getbyte(rs.getString("seller"));
	 date=getbyte(rs.getString("visit_date"));
     
  %>
 
 <tr id=TR<%=i %>   trid=tr<%=tr %> align="center"    > 
 <td  align="center"><%=i %>　</td>
    <td  align="left"><%=name %>　&nbsp;</td>
     <td  align="left">
	<%String strt="";
	String strs="";
	if (tel.indexOf(" ")>0)strt=" ";
	if (tel.indexOf("/")>0)strt="/";
	if (sj.indexOf(" ")>0)strs=" ";
	if (sj.indexOf("/")>0)strs="/";
	 %>
	<%out.print(tel);  
	  %><%=Repalce(sj,strs)%>&nbsp;</td>
	 
 
<td  align="left" title="<%=address %>"> <%
	 
	//if (address.length()>14)address=address.substring(1,14)+"...";
	if (!post.trim().equals(""))address+="("+post+")" ;
	out.print(address);
	%>&nbsp;</td>
	  <td  align="center"><%=getbyte(rs.getString("region")) %>&nbsp;</td>
	  
	  <%   sql="select * from CustomerDcValue a, customer_xq b where b.customer="+code +" and b.xq_code=a.code and a.dccode   in (select code from CustomerDc where codeName like '%户型%' and  sectionno='"+section+"')" ;
 
	   ResultSet   rs1=ViewBean1.executeQuery(sql);
	   String yixianmianji="";
	   while (rs1.next()){
	   yixianmianji+=rs1.getString("codevalue");
	   }
	   rs1.close(); 
	   sql="select * from CustomerDcValue a, customer_xq b where b.customer="+code +" and b.xq_code=a.code and a.dccode   in (select code from CustomerDc where codeName like '%面积%' and  sectionno='"+section+"')" ;
 
	       rs1=ViewBean1.executeQuery(sql);
	   String demand="";
	   while (rs1.next()){
	   demand+=rs1.getString("codevalue");
	   }
	   rs1.close();
	    sql="select * from CustomerDcValue a, customer_xq b where b.customer="+code +" and b.xq_code=a.code and a.dccode   in (select code from CustomerDc where codeName like '%途径%' and  sectionno='"+section+"')" ;
 
	       rs1=ViewBean1.executeQuery(sql);
	   String Knowledge_From="";
	   while (rs1.next()){
	   Knowledge_From+=rs1.getString("codevalue");
	   }
	   rs1.close();
	   %>
	  
	  <td  align="center"><%=yixianmianji %>&nbsp;</td>
	    <td  align="center"><%=demand%>&nbsp;</td>
		  <td  align="center"><%=Knowledge_From %>&nbsp;</td>
    <td  align="center"><%=date %>&nbsp;</td>
	<td  align="center"><%=sell%>&nbsp;</td>
   </tr>

<%

  }
   
   
}catch(Exception s){out.println(s.getMessage());}
 
rs.close();
 
 

 %> 
 </table>
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
