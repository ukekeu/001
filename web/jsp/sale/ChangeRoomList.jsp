 <%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
  <%@ page import = "java.sql.*,common.*" %>
  <jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id = "changeListBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<title>换房一览表</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
<script language="javascript" src="../public_js/public.js"></script>
<script language=javascript src="js/mad.js"> </script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script> 
 
 <body     topmargin="1"  >
<form name="frm" method="post" action="ChangeList.jsp"> 
 
	 <% 
 
 
 
  String stdate = China.getParameter(request,"Date1") ;
  String endate = China.getParameter(request,"Date2") ;
  String SecNo=China.getParameter(request,"SecNo") ; 
  String Loft = China.getParameter(request,"Loft") ; 
   String room=getbyte1(request.getParameter("room"));
  
 
 %>
 <div align=left id=report1  >
 <br><br><br>
<p align="center" class=FontColor><font size=3><b>  <%=Loft %>换房明细</b></p>
 

<table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
  <tr  bgcolor="efefef" align="center"  >
  <td     >序号</td>
 <td>现房间代码</td>
  <td>原房间代码</td>
  <td>客户姓名</td>
   <td>认购日期</td>
 <td>换房日期</td>
 <td>换房原因</td>
  <td>换房面积差</td>
    <td>换房总价差</td>
  <td>经办人</td>
 <td>审批人</td></tr> 

</form>
 
<%
	String changeStr = "select  *,sumprice-oldprice c_price,jzarea-oldarea c_area from ChangRoomR where secno='"+SecNo+"'  ";
	      if (!Loft.equals(""))
          changeStr +=" and loft='"+Loft+"'";
          changeStr +=" and ChangeDate>='"+stdate+"' and ChangeDate<='"+endate+"'";
          changeStr +=" order by ChangeDate desc";
		 
    String secno="";
	String section;
	String building;
	String OldRoom;
	String NowRoom;
	String ChangeDate;
    String Note="";
	String person="";
	String checker="";
	String seller="";
	String subscription="";
	String customer="";
	String cusname="";
	String order_code="";
	String newloft="",newbuild="";
   // out.print( changeStr + "<br>" ) ;
    ResultSet changeRS1 = null;
	try{
	changeRS1 = changeListBean.executeQuery(changeStr);	
	 
	int i=0;
	while (changeRS1.next()) {
	 
		 i++;
		 secno=changeRS1.getString("secno");
		 customer=changeRS1.getString("customer");
		 
		 if(customer!=null){
		 String  sql="select customer.cus_name,Order_Contract.code  from customer,Order_Contract where Order_Contract.customer=customer.SerialNo and Order_Contract.section='"+SecNo+"' and customer.SerialNo='"+customer+"'";
		
		 ResultSet rs = ViewBean.executeQuery(sql);	
		 if(rs.next()){
		    cusname=getbyte(rs.getString("cus_name"));
			order_code=getbyte(rs.getString("code"));
		 }rs.close();
		 }
		 
		 section = getbyte(changeRS1.getString("Section"));
		 Loft =getbyte(changeRS1.getString("Loft"));
		 building = getbyte(changeRS1.getString("Build"));
		 OldRoom = changeRS1.getString("OldRoom"); 
		 NowRoom = changeRS1.getString("NowRoom"); 
		 newloft= changeRS1.getString("newloft"); 
		 newbuild= changeRS1.getString("newbuild"); 
         ChangeDate = changeRS1.getString("ChangeDate");
		 checker=getbyte(changeRS1.getString("Checker"));
		 Note=getbyte(changeRS1.getString("Note"));
	    person=getbyte(changeRS1.getString("person"));
		String c_price=getbyte(changeRS1.getString("c_price"));
		String c_area=getbyte(changeRS1.getString("c_area"));
		String oldname=getbyte(changeRS1.getString("oldname"));
		String olddate=getbyte(changeRS1.getString("olddate"));

 %> <b>
  <tr id=TR<%=i %>  align="center"     >
  <td    ><%=i %></td>
<td ><%= section+newloft+newbuild+NowRoom%></td>
<td><%= oldname +Loft+building+OldRoom %></td>
<td><%=cusname %>&nbsp;</td>
<td><%= olddate.substring(0,olddate.indexOf(" ")) %></td>
<td><%= ChangeDate.substring(0,ChangeDate.indexOf(" ")) %></td>
<td><%= Note %>&nbsp;</td>
<td><%= c_area %></td>
<td><%= c_price %></td>

<td><%= person %>&nbsp;</td>
<td><%= checker %>&nbsp;</td>
</tr>
</b> 
<%
  	}
	changeRS1.close();
	}catch(Exception e){out.print(e);}
  %>
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
<input type="button" onclick="bringToExcel()" value="导出到Excel"> 
 
</body>
</html>
