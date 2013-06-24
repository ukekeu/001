<%@ page import = "java.sql.*" contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 
<jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase" />
 <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
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
	  销售员业绩指标设定
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
<% String sel=(String)request.getParameter("sel");
    if(sel==null) sel="0";
  %>
</head>
<body  oncontextmenu="return false"  topmargin="0">
<form name=f1 method=post>
  <input type=hidden name="sel" value="<%=sel %>">
   <table width="160" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr> 
   <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.f1.sel.value=1;findSub('salervalue_dept.jsp');"> <font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>部门业绩 
	</td>
    <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.f1.sel.value=0;findSub('salervalue.jsp');"> <font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>个人业绩  
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
    销售员业绩完成情况
   </b>
  </font>
 </p>
 
 

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
		  if(RentMonth.equals(""))RentMonth=CurMonth+"";
		  %>
		  &nbsp;<select name="RentYear" onchange="document.f1.submit();">
		  <%
		for (w=2000;w < 2020;w++){ %>
		<option value="<%=w %>" ><%=w %></option>	
		<%} %>	
		</select>年
		  <select name="RentMonth" onchange="document.f1.submit();">
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
	</td></tr>
	</table>
 <table border=0 width=100% align=center  cellspacing=1 cellpadding=1 >
   <tr class=listtitle>
    
	<td width=20% align=center>
	 <font color=white>
	  楼盘名
	 </font>
	</td>	
	<td width=20% align=center>
	 <font color=white>
	  年月
	 </font>
	</td>
	<td width=10% align=center>
	 <font color=white>
	  销售员
	 </font>
	</td>
	 
	
	<td width=10% align=center>
	 <font color=white>
	   指标面积(M<sup>2</sup>)
	 </font>
	</td>
	<td width=10% align=center>
	 <font color=white>
	   指标金额(万元)
	 </font>
	</td>
   </tr>
   
   <%  int id=0;
       String uptown="",sale_num="";
	  
	   float areavalue=0;
	   float perarea=0;
	   String seller="";
	   String section="";
	   if (request.getParameter("section")!=null)section=" and uptown ='"+request.getParameter("section")+"'";
	    else section=" and uptown   in("+SectionS+")";
   ResultSet rs = aBean.executeQuery(" select * from SalerValue where RentYear ="+RentYear +"  and type=0  and RentMonth="+RentMonth+section);
//out.print(" select * from SalerValue where RentYear ="+RentYear +" and RentMonth="+RentMonth+section);
   int u = 0;
   while(rs.next()){
      id= rs.getInt("id");
	  uptown=rs.getString("uptown");
	  String sqls="select name from Crm_Project where serialno='"+uptown+"'";
	  ResultSet rss=bBean.executeQuery(sqls);
	  if(rss.next()){
	   uptown=getbyte(rss.getString("name"));	  
	  }
	  RentYear=rs.getString("RentYear");
	  RentMonth=rs.getString("RentMonth");
	  areavalue=rs.getFloat("areavalue");
	  perarea=rs.getFloat("perarea");
	  seller=getbyte(rs.getString("seller"));
	  sale_num=getbyte(rs.getString("sale_money"));
   	%>   	
	<tr align="center" id=TR<%=id %>  onclick="savepara('<%=id %>');changeclass1(this,'clickbg','listcontent');">
	 <td><%= uptown%></td>	
	 <td><%= RentYear+"-"+RentMonth%></td>	
	   <td><%= seller%></td>  
	 <td><%= perarea%></td>
	
	 <td><%=sale_num %></td>	 	 
	</tr>	
	<%
	u++;
   }
   rs.close();
   %>    
   <!--tr class='listcontent'>
    <td colspan=5>
     <input type=checkbox name=ca onclick="selectAll()"> &nbsp; 全选/取消
	</td>	
   </tr-->	
 </table>
 
  <input type=hidden name=rows value=<%= u%> > 
</body>
</html>

