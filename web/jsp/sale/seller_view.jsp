<%@ page contentType="text/html;charset=GBK" %><!--页显示中文编码-->
<%@ include file="../public_js/checktime.jsp"%><!--系统使用时间check-->
<%@ page language="java" import="java.sql.*,java.util.*" %> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/>  
<jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
<jsp:useBean id="fa" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%> 
<%@ include file="../public_js/CheckSection.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>业绩统计表</title>
</head>
<script language="javascript" src="../public_js/public.js">
</script>
<script language=javascript src="js/mad.js"> </script>
<script language=javascript src="../public_js/basal.js"> </script>
 
<%String section=getbyte1(request.getParameter("section"));
 
 %>
<body topmargin="0"  onload="setSelectMad(document.f1.section,'<%=request.getParameter("section") %>');">



<form method="POST" name="f1" action="">

  <% String sel=(String)request.getParameter("sel");
   if(sel==null) sel="1";	 %>
 <table width="160" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr> 
   <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.f1.sel.value=1;findSub('salervalue_dept.jsp');"> <font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>部门业绩 
	</td>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.f1.sel.value=0;findSub('seller_view.jsp');"> <font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>个人业绩  
	</td>
	 </tr>
	 </table>
	<script>
function findSub(para){
   document.f1.action=para+"?Search=b&Find=b";
   document.f1.submit();


}
</script>

 <input type=hidden name=sel value="<%=sel%>">
</table>
 <p align="center"><b><font size="3" class=FontColor>销售员业绩完成情况</font></b>
  </p>
楼盘：<select name="section" onchange="document.f1.submit();"> 
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
	
     %> </select>&nbsp;年月:
	<%
	      String RentYear=getbyte1(request.getParameter("RentYear"));
		  String RentMonth=getbyte1(request.getParameter("RentMonth"));
		  int w=1;
		  java.util.Date curDate=new java.util.Date();
		  int CurYear=curDate.getYear()+1900;
	      int CurMonth=curDate.getMonth()+1;
	      int CurDay=curDate.getDate();
		  if(RentYear.equals(""))RentYear=CurYear+"";
		  if(RentMonth.equals(""))RentMonth=CurMonth+"";
		  %>
		  &nbsp;<select name="RentYear" onchange="document.f1.submit();">
		  <%
		for (w=2000;w < 2020;w++){ %>
		<option value="<%=w %>" ><%=w %></option>	
		<%} %>	
		</select>年
		  <select name="RentMonth" onchange="document.f1.submit();">
		  <option value="" ></option>	
		  <%
		for (w=1;w < 13;w++){ %>
		<option value="<%=w %>" ><%=w %></option>	
		<%} %>	
		</select>月&nbsp;&nbsp;&nbsp;<input type=button name="yj" value="佣金计算" onclick="openwin('../finance/autoselect4.jsp?url=14&section=<%=request.getParameter("section") %>',350,250,100,100);"></td>
		<script>
		setSelectMad(document.f1.RentYear,"<%=RentYear %>");
		setSelectMad(document.f1.RentMonth,"<%=RentMonth %>");
		setSelectMad(document.f1.section,"<%=request.getParameter("section") %>");
		</script>
		  <input type="button" onclick="bringToExcel()" value="导出到Excel"> 
 
		 <DIV align=center id="report1">

		
		<table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 bordercolor="#FFFFFF" ALIGN=center class="tablefill" >
    <tr class=listtitle align="center" > 
       <td ><font color=white>序号</font></td>
	   <td ><font color=white>销售员</font></td>
       <TD ><font color=white>今日<br>套数</font></td>
	   <TD ><font color=white>今日<br>面积</font></td>
	   <TD ><font color=white>今日<br>销售额</font></td>
	   <td ><font color=white>本月<br>套数</font></td>
	   <TD ><font color=white>本月<br>面积</font></td>
	   <TD ><font color=white>本月<br>销售额</font></td>
	   <TD ><font color=white>本月<br>完成比</font></td>
	   <td ><font color=white>累计<br>套数</font></td>
	   <TD ><font color=white>累计<br>面积</font></td>
	   <TD ><font color=white>累计<br>销售额</font></td>
	    <TD ><font color=white>累计<br>回笼款</font></td>
	   <td ><font color=white>今日接<br>待客户数</font></td>
	   <td ><font color=white>累计接<br>待客户数</font></td>
	   <td ><font color=white>今日<br>临订数</font></td>
	   <td ><font color=white>累计<br>临订数</font></td>
	   
    </tr>
    <%
String strWhere="";
if (!section.equals(""))strWhere=" and section='"+section+"'";
  ResultSet rs = ViewBean2.executeQuery(" select perarea,seller from SalerValue where RentYear ="+RentYear +" and RentMonth="+RentMonth+" and uptown='"+request.getParameter("section")+"'");

List list=new LinkedList();//存放销售员本月指标
List list1=new LinkedList();//存放销售员 
while (rs.next()){
   list.add(rs.getString("perarea"));
   list1.add(rs.getString("seller"));
}
rs.close();
ResultSet rs1=null;
String sql="SELECT s.seller FROM seller s where section_no='"+section+"'";
ResultSet rs3=ViewBean2.executeQuery(sql);

int ii=0;
while (rs3.next()){
   String codename=getbyte(rs3.getString("seller"));
   
   //销售员销售指标
   String target_value="0";
  if (list1.contains(codename)){
      int index=list1.indexOf(codename);
	  target_value=(String)list.get(index);
  
  }
   
   //today sale
   sql="select count(*) nn,sum(jzarea) jzarea,sum(rmbprice) price from order_contract where seller like '%"+codename+"%' " +strWhere+" and year(date)="+RentYear+" and month(date)="+RentMonth;

   ii++;
    rs1=ViewBean1.executeQuery(sql);
   String nn="";
   String todayjzarea="";
    String todayprice="";
   String monthjzarea="";
   String monthprice="";
   String sumjzarea="";
   String sumprice="";
   String nnn="";
   String nnnn="";
   String nnnnn="";
   String mljn="";
   String jj="";
   String jjj="";
   if (rs1.next()){
nn=getbyte(rs1.getString("nn"));
todayjzarea=fa.getFloat2(rs1.getDouble("jzarea"),3);
todayprice=fa.getFloat(rs1.getFloat("price"),2);
}
   rs1.close();
   //累计销售
   sql="select count(*) nn,sum(jzarea) jzarea,sum(rmbprice) price from order_contract where seller='"+codename+"'"+strWhere;
   rs1=ViewBean1.executeQuery(sql);
    if (rs1.next()){
	 nnn=getbyte(rs1.getString("nn"));
	 sumjzarea=fa.getFloat2(rs1.getDouble("jzarea"),3);
	 sumprice=fa.getFloat(rs1.getFloat("price"),2);
	}
   rs1.close();
   
     //累计回笼款
	 String hlprice="";
   sql="select sum(factmoney*CurrRate)  price from FactGatheringRecord where  checkstate=1 and contractno in (select code from order_contract where seller='"+codename+"'"+strWhere+")";
   rs1=ViewBean1.executeQuery(sql);
    if (rs1.next()){
	 
	 hlprice=fa.getFloat(rs1.getFloat("price"),2);
	}
   rs1.close();
   
    //本月累计销售
   sql="select count(*) nn,sum(jzarea) jzarea,sum(rmbprice) price from order_contract where   year(date)="+RentYear+" and month(date)="+RentMonth +" and seller='"+codename+"'"+strWhere;
   rs1=ViewBean1.executeQuery(sql);
    if (rs1.next()){
	mljn=getbyte(rs1.getString("nn"));
	 double aaa=rs1.getDouble("jzarea");
	
	target_value=fa.getFloat2(Double.parseDouble(target_value)/aaa*100,3);
    monthjzarea=fa.getFloat2(aaa,3);
	monthprice=fa.getFloat(rs1.getFloat("price"),2);
}
   rs1.close();
   
   //today customer
    sql="select count(*) nn from customer where seller='"+codename+"' and convert(char(24),visit_date,111)=convert(char(24),getdate(),111)" +strWhere;
   rs1=ViewBean1.executeQuery(sql);
    if (rs1.next())nnnn=getbyte(rs1.getString("nn"));
   rs1.close();
    //today customer
    sql="select count(*) nn from customer where seller='"+codename+"'"+strWhere;
   rs1=ViewBean1.executeQuery(sql);
    if (rs1.next())nnnnn=getbyte(rs1.getString("nn"));
   rs1.close();
   
   //today ld
    sql="select count(*) nn from SL_TemporarilyBuy where Receiver='"+codename+"' and convert(char(24),StartDate,111)=convert(char(24),getdate(),111) ";
if (!section.equals(""))
   sql+=" and roomcode in (select code from room where seccode='"+section+"')";
   rs1=ViewBean1.executeQuery(sql);
    if (rs1.next())jj=getbyte(rs1.getString("nn"));
   rs1.close();
    //today ld
    sql="select count(*) nn from SL_TemporarilyBuy where Receiver='"+codename+"'";
if (!section.equals(""))
   sql+=" and roomcode in (select code from room where seccode='"+section+"')";
   rs1=ViewBean1.executeQuery(sql);
    if (rs1.next())jjj=getbyte(rs1.getString("nn"));
   rs1.close();
   
 %> 
  <tr  align="center" class=listcontent  onmouseover="mout(this) ;"  ondblclick="openwin1('SaleV.jsp?seller=<%=codename %>&yea=<%=RentYear %>&mon=<%=RentMonth %>',700,300,30,30);"> 
  
	    <td  ><%=ii %></td>
	    <td  ><a href="#"  onclick="openwin1('SaleV.jsp?seller=<%=codename %>&yea=<%=RentYear %>&mon=<%=RentMonth %>',700,300,30,30);"><%=codename %></a></td>
		<td  > <%=nn %></td>
		<td  > <%=todayjzarea %></td>
		<td  > <%=todayprice %></td>
		<td  > <%=nn %></td>
		<td  > <%=monthjzarea %></td>
		<td  > <%=monthprice %></td>
		<td  > <%=monthprice %>%</td>
	    <td  > <%=nnn %></td>
		<td  > <%=sumjzarea %></td>
		<td><%=hlprice %></td>
		<td  > <%=sumprice %></td>
	    <td  > <%=nnnn %></td>
		<td  > <%=nnnnn %></td>
	    <td  > <%=jj %></td>
		<td  > <%=jjj %></td>
	</tr>
    <%

}rs3.close();
String choosePic="checked";
if (getbyte1(request.getParameter("choosePic")).equals("")){
choosePic="";
}
%> 
  </table>
  <table width="90%"><tr><td align="right"><input name="choosePic" value=1 type="checkbox" <%=choosePic %> onclick="document.forms[0].submit();">显示本月图形</td></tr></table>
    <IFRAME ID="eWebEditor1" src="../seller/viewsalecountreopt4.jsp?SecNo=<%=section %>&RentMonth=<%=RentMonth%>&choosePic=<%=getbyte1(request.getParameter("choosePic")) %>" frameborder="0" scrolling="auto" width="100%" height="99%" ></IFRAME>
	
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
</body>
</form>
</html>