<%@ page import = "java.sql.*" contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 
<jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase" />
 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
  <jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/qx_checke.jsp"%>
 <%@ include file="../public_js/CheckSection.jsp"%>
 <%
//权限审核
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),request.getParameter("param"));
%>
<html>
<head>	
	<LINK href="../class/news.css" rel=stylesheet>
	<title>
	  部门业绩指标设定
	</title>
<script language="javascript" src="../public_js/public.js"></script>
<script language="JavaScript">
var id="";
function new_win(url,w,h) {
        var newwin
        newwin = window.open(url,"NewWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width="+w+",height="+h);
        newwin.focus();
}
function addzhu_i()
{
	document.f1.action="zhuadd_i.jsp";
	document.f1.submit();
}
function savepara(para){
		 id=para;
	}
function Edit()
{
  if(id==""){
	   alert("请选择一条记录!!");
   }else{
   new_win("valueedit.jsp?id="+id,500,250);

   }
}
function Deletes()
{
  if(id==""){
	   alert("请选择一条记录!!");
   }else{
   if(confirm("确定删除该记录吗？"))
   new_win("valueaction.jsp?ID="+id+"&Operation=Delete",240,220);

   }
}
</script>

</head>
<body  oncontextmenu="return false" topmargin="0">
<% String sel=(String)request.getParameter("sel");
    if(sel==null) sel="1";
  %>
<form name=f1 method=post>
  <input type=hidden name="sel" value="<%=sel %>">
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
 <p align=center class=FontColor>
  <font size=3>
   <b>
     部门业绩完成情况
   </b>
  </font>
 </p>
 
 <DIV align=center id="printdiv">

 <table border=0 width=100% align=center  cellspacing=1 cellpadding=1 >
   <tr >
    
	<td width=20% align=left>&nbsp;  楼盘：<select name="section" onchange="document.f1.submit();"> 
   <option></option>
<%  

	 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql1="select SerialNo,Name from Crm_Project where SerialNo in("+SectionS+")";

	  ResultSet rs2=ViewBean.executeQuery(sql1);	
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
		//  if(RentMonth.equals(""))RentMonth=CurMonth+"";
		  %>
		  &nbsp;<select name="RentYear" onchange="document.f1.submit();">
		  <%
		for (w=2000;w < 2020;w++){ %>
		<option value="<%=w %>" ><%=w %></option>	
		<%} %>	
		</select>年
		  <select name="RentMonth" onchange="document.f1.submit();">
		 <option></option>
		  <%
		for (w=1;w < 13;w++){ %>
		<option value="<%=w %>" ><%=w %></option>	
		<%} %>	
		</select>月</td>
		<script>
		setSelectMad(document.f1.RentYear,"<%=RentYear %>");
		setSelectMad(document.f1.RentMonth,"<%=RentMonth %>");
		setSelectMad(document.f1.section,"<%=request.getParameter("section") %>");
		</script>
	</td><td width="20%" align="right">  <input type="button" onclick="bringToExcel()" value="导出到Excel"> 
</td></tr>
	</table>
	</div<
	  <object id="WebBrowser" width="0" height="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
  </object>

  
<div align=left id=report1 >
 <table border=0 width=100% align=center  cellspacing=1 cellpadding=1 >
   	<tr class="listtitle">
			<td align="middle" width="15%" rowspan="2">楼盘名称 
			</font></td>
			<td align="middle" width="10%" rowspan="2">年月 
			</font></td>
			<td align="middle" width="15%" colspan="2">套数</td>
			<td align="middle" width="20%" colspan="2">面积</td>
			<td align="middle" width="20%" colspan="2">金额(万元) </td>
			<td align="middle" width="24%" colspan="3">完成率</td>
		</tr>
		<tr class="listtitle">
			<td align="middle" width="10%">计划</td>
			<td align="middle" width="8%">实际</td>
			<td align="middle" width="8%">计划</td>
			<td align="middle" width="8%">实际</td>
			<td align="middle" width="8%">计划</td>
			<td align="middle" width="8%">实际</td>
			<td align="middle" width="8%">套数</td>
			<td align="middle" width="8%">面积</td>
			<td align="middle" width="8%">金额</td>
		</tr>
   
   <%  int id=0;
       String uptown="",sale_num="";
	  
	   double areavalue=0;
	   double perarea=0;
	   String seller="";
	   String section="";
	   String num="0";
	   String sectionno="";
	   if (request.getParameter("section")!=null)section=" and uptown ='"+request.getParameter("section")+"'";
	    else section=" and uptown   in("+SectionS+")";
	   String QQ=" select a.*,b.name from SalerValue a,Crm_Project b where a.uptown=b.serialno and a.RentYear ="+RentYear +" and a.type=1  ";
	   if (!RentMonth.equals(""))QQ+=" AND a.RentMonth="+RentMonth;
	   QQ+=section;
    ResultSet rs = aBean.executeQuery(QQ +" order by a.RentYear, a.RentMonth");
    int u = 0;
   while(rs.next()){
      id= rs.getInt("id");
	  sectionno=getbyte(rs.getString("uptown"));	
	  uptown=getbyte(rs.getString("name"));	
	  RentYear=rs.getString("RentYear");
	  RentMonth=rs.getString("RentMonth");
	  String a1="0",a2="0",a3="0";
	
	  areavalue=rs.getDouble("areavalue");
	  perarea=rs.getDouble("perarea");
	  seller=getbyte(rs.getString("seller"));
	  sale_num=getbyte(rs.getString("sale_money"));
	  num=getbyte(rs.getString("sale_num"));
	    String sqls="select sum(jzarea) jzarea,sum(rmbprice)/10000 rmprice,count(*) num  from order_contract where section='"+sectionno+"' and year(date)="+RentYear+" and month(date)="+RentMonth;
	  ResultSet rss=bBean.executeQuery(sqls);
	 
	  if(rss.next()){
	    a1= Format.getFloat3(rss.getDouble("jzarea"),2);	
		a2= Format.getFloat3(rss.getDouble("rmprice"),2);	
		a3= Format.getFloat3(rss.getDouble("num"),0);	
	  }
	  rss.close();
   	%>   	
	<tr align="center" id=TR<%=id %>   class='listcontent' onclick="savepara('<%=id %>');changeclass1(this,'clickbg','listcontent');">
	 <td><%= uptown%></td>	
	 <td><%= RentYear+"-"+RentMonth%></td>	
	<td><%=num %></td>  
	<td><%=a3 %></td>  
	<td><%=Format.getFloat2(Double.valueOf(perarea),2) %></td>
	<td><%= Format.getFloat2(Double.valueOf(a1),2)%></td>
	<td><%=Format.getFloat2(Double.valueOf(sale_num),2) %></td>	 	
	<td><%=Format.getFloat2(Double.valueOf(a2),2) %></td> 
	<td><%if (Integer.valueOf(num)>0){out.println(Format.getFloat3(Double.valueOf(a3)/Double.valueOf(num)*100,3));}else{out.print("0");} %>%</td> 	
	<td><%if (Double.valueOf(perarea)>0){out.println(Format.getFloat3(Double.valueOf(a1)/Double.valueOf(perarea)*100,3));}else{out.print("0");} %>% </td> 
	<td><%if (Double.valueOf(sale_num)>0){out.println(Format.getFloat3(Double.valueOf(a2)/Double.valueOf(sale_num)*100,3));}else{out.print("0");}%>% </td> 
	</tr>	
	<%
	u++;
   }
   rs.close();
   %>    
 
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
 </body>
</html>

