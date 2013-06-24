 <%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
  <%@ page import = "java.sql.*,common.*" %>
  <jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <jsp:useBean id = "changeListBean" scope = "page" class = "ConnDatabase.SDatabase" />
   <jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
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
 
<bod   topmargin="1"   >
<form name="frm" method="post" action="ChangeList.jsp"> 
<input type="button" onclick="bringToExcel()" value="导出到Excel">
 <%
	
	int hasRecord = 0;
	int id;
	String  SecNo=China.getParameter(request,"SecNo");
    String  Date1=China.getParameter(request,"Date1");
	String  Loft=China.getParameter(request,"Loft");	
	String  Date2=China.getParameter(request,"Date2");
	String Build="";
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
	 
%>
<%String sel=(String)request.getParameter("sel");
    if(sel==null) sel="1";	   %> 
	<div align=left id=report1 style="background-color:#F7F7F7;height:500px;overflow:auto;width:100%;z-index:2"   >
<p align="center" class=FontColor><font size=3><b>  <%=Loft+Build %>换房明细</font></b></p>
 
 时间段：<%=Date1 %>到<%=Date2 %>
 <table width="100%"  border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<tr  align="center" >
  <td   align="center"   >序号 </td>
 <td>现房间代码</td>
  <td>现房间面积</td>
    <td>现房间总款</td>
  <td>原房间代码</td>
    <td>原房间面积</td>
	  <td>原房间总款</td>
  <td>客户姓名</td>
   <td>认购日期</td>
 <td>换房日期</td>
 <td>换房原因</td>
  <td>面积差</td>
    <td>总价差</td>
 
 <td>审批人</td></tr> 
<%
	String changeStr = "select  b.cus_name,a.*,sumprice-oldprice c_price,jzarea-oldarea c_area from ChangRoomR a,customer b  where a.customer=b.SerialNo and a.secno='"+SecNo+"'and a.build='"+Build + "' "
                      + " and convert(char(10),ChangeDate,120)>='"+Date1+"' and  convert(char(10),ChangeDate,120)<='"+Date2+"'"
                      + " order by ChangeDate desc";
					
    String secno="";
	String customer="";
	String cusname="";
	String order_code="";
	double s_c_a=0;
	double s_c_p=0;
	String newloft="",newbuild="";
   // out.print( changeStr + "<br>" ) ;
    ResultSet changeRS1 = null;
	try{
	changeRS1 = changeListBean.executeQuery(changeStr);	
	hasRecord = 0;
	int i=0;
	
	while (changeRS1.next()) {
		hasRecord = 1;
		 i++;
		 
		 secno=changeRS1.getString("secno");
		 customer=changeRS1.getString("customer");
		 
		 
		    cusname=getbyte(changeRS1.getString("cus_name"));
			 
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
		s_c_p+=changeRS1.getDouble("c_price");
		String c_area=getbyte(changeRS1.getString("c_area"));
		s_c_a+=changeRS1.getDouble("c_area");
		String oldname=getbyte(changeRS1.getString("oldname"));
		String olddate=getbyte(changeRS1.getString("olddate"));
		String oldarea=getbyte(changeRS1.getString("oldarea"));
		String area=getbyte(changeRS1.getString("jzarea"));
		String sumprice=getbyte(changeRS1.getString("sumprice"));
		String oldprice=getbyte(changeRS1.getString("oldprice"));

 %> <b>
  <tr id=TR<%=i %>  align="center"   title="换房原因：<%=Note %>" >
  <td    ><%=i %></td>
<td ><%= section+newloft+newbuild+NowRoom%></td>
<td ><%= area%></td>
<td ><%= sumprice%></td>
<td><%= oldname+ Loft+building+OldRoom %></td>
<td><%=oldarea %></td>
<td><%=oldprice %></td>
<td><%=cusname %></td>
<td><%= olddate.substring(0,olddate.indexOf(" ")) %></td>
<td><%= ChangeDate.substring(0,ChangeDate.indexOf(" ")) %></td>
<td><%= Note %></td>
<td><%= c_area %></td>
<td><%= c_price %></td>
 
<td><%= checker %></td>
</tr>
 
<%
  	}
	changeRS1.close();
	}catch(Exception e){out.print(e);}
  %>
  <tr align="center"><td>合计</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
  <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
  <td><%=FormtD.getFloat3(s_c_a,2) %></td>
    <td><%=FormtD.getFloat3(s_c_p,2) %></td>
	<td>&nbsp;</td>
	
  </tr>
</table>
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

</form> 

</body>
</html>
