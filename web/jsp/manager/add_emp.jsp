 
    <%@ page contentType="text/html;charset=GBK" %>
  <%@ include file="../public_js/checktime.jsp"%>
  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
    <%@ include file="../public_js/getByteOut.jsp"%>
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<SCRIPT language="JavaScript1.2" type="text/javascript">
function checkData()
{ 
   
    if (document.pm.flowtitle.value==""){alert("请输入申请主题！");return false;}
    
   document.pm.action="add_emp_action.jsp";
  document.pm.submit();
}
</SCRIPT>
 <script>
 function full(){
      
	  setSelectMad(document.pm.floowtype,"<%=getbyte(request.getParameter("floowtype"))%>");
	  if (document.pm.flowname)
	  setSelectMad(document.pm.flowname,"<%=getbyte1(request.getParameter("flowname"))%>");
	 
	}  
	</script>    
 <script language="javascript" src="../public_js/public.js"></script>
<title>添加申请</title>
</head>
<body topmargin="0" leftmargin="0" onload="full();">
<form name="pm" method="post" action="add_emp.jsp" <%if (!getbyte1(request.getParameter("flowname")).equals("")){ %> ENCTYPE="multipart/form-data"<%} %> ><!---->
 <input type=hidden name=customer value="0">
<center>
 选择流程类别：<select name=floowtype onchange="document.pm.submit()">
 <option value="">选择你的流程类别</option>
 <% 
   String StrSql="select code,flow_name from workflow_set";
    ResultSet codeRS=ViewBean.executeQuery(StrSql);
  while (codeRS.next()){
      out.print("<option value="+getbyte(codeRS.getString("code"))+">"+getbyte(codeRS.getString("flow_name"))+"</option>");
    
   }
   codeRS.close();
   out.print("</select>");
   String floowtype=getbyte(request.getParameter("floowtype"));
   if (!floowtype.equals("")){
   
    %>
	
	 选择流程：<select name=flowname onchange="document.pm.submit()">
 <option value="">选择需要审批流程</option>
 <% 
   StrSql="select  flowname from workflow where flow_code="+floowtype+" group by flowname";
   codeRS=ViewBean.executeQuery(StrSql);
  while (codeRS.next()){

      out.print("<option value='"+getbyte(codeRS.getString("flowname"))+"'>"+getbyte(codeRS.getString("flowname"))+"</option>");
	 
   }
     out.print("</select>");
   codeRS.close();
    String flowname=getbyte1(request.getParameter("flowname"));
   if (!floowtype.equals("")&&!flowname.equals("")){
   %>
 <P align="center"><font size=4>审批流程</font></P>
 
 <% 
   StrSql="select a.checker_no,a.wait_day,b.name from workflow a ,CortrolMan b where a.flowname='"+flowname+"' and a.flow_checker=b.id and  a.flow_code="+getbyte1(request.getParameter("floowtype"));
   codeRS=ViewBean.executeQuery(StrSql);
 
 
    %>
 
 
<center><table  border="0" cellpadding="0" cellspacing="0" bordercolor="#111111">
   
  <tr align="center"  class=listbody> 
 
   <td ><img src="../images/man.jpg" border="0"> <%=(String)session.getAttribute("loginname") %> (起草人)<img src="../images/jt.jpg" border="0" ></td>
 
  <% 
  int i=0;
   int checker_no=0;
   while (codeRS.next()){ 
   
   if (checker_no!=codeRS.getInt("checker_no")&&checker_no>0)
   out.print("</td><td>");
   else  if (checker_no!=codeRS.getInt("checker_no")&&checker_no==0)
   out.print("<td>");
   else   if (checker_no==codeRS.getInt("checker_no")&&checker_no>0)
    out.print("<br>");
	checker_no=codeRS.getInt("checker_no");
   %>
  
  
  <img src="../images/man.jpg" border="0"> (<%=codeRS.getString("name") %>)<img src="../images/jt.jpg" border="0" >
   
 
 

  
  <%i++;
   }codeRS.close();
  
   %>
  
  <td> <img src="../images/man.jpg" >审批结束(归档人归档)</td>
   </tr>
 
</table>
<% 

 
 //当前日期
 Calendar nowcal=new GregorianCalendar();
 int nowyear=nowcal.get(Calendar.YEAR);
 int nowmonth=(nowcal.get(Calendar.MONTH)+1);
 int nowday=nowcal.get(Calendar.DATE);
 String nowdate=""+nowyear+"-"+nowmonth+"-"+nowday;
 String strnowmonth=""+nowmonth;
 if(strnowmonth.length()==1) strnowmonth="0"+strnowmonth;
 String strnowday=""+nowday;
 if(strnowday.length()==1) strnowday="0"+strnowday;
 String strnowdate=""+nowyear+"-"+strnowmonth+"-"+strnowday;
String chooseyear=getbyte(request.getParameter("chooseyear"));
   String choosemonth=getbyte(request.getParameter("choosemonth"));
   if (!chooseyear.equals(""))nowyear=Integer.parseInt(chooseyear);
   if (!choosemonth.equals(""))nowmonth=Integer.parseInt(choosemonth);
   StrSql="select top 1 flowno from workflow_txt where flow_code="+request.getParameter("floowtype")+" order by code desc";
    codeRS=ViewBean.executeQuery(StrSql);
   String flow_no="";
    if (codeRS.next()){ 
	  flow_no=codeRS.getString("flowno") ;
	 }codeRS.close();
	 
	 ViewBean.closeConn(); 
	 if (flow_no.equals(""))flow_no="["+String.valueOf(nowyear)+"]"+String.valueOf(nowmonth)+"C001";
	 else {
	   String no=flow_no.substring(0,flow_no.indexOf("C"));
	   String no1=flow_no.substring(flow_no.indexOf("C")+1);
	   if (Integer.parseInt(no1)+1<10)
	     flow_no="["+String.valueOf(nowyear)+"]"+String.valueOf(nowmonth)+"C00"+String.valueOf(Integer.parseInt(no1)+1);
	   else  if (Integer.parseInt(no1)+1<100)
	     flow_no="["+String.valueOf(nowyear)+"]"+String.valueOf(nowmonth)+"C0"+String.valueOf(Integer.parseInt(no1)+1);
	  } %>
<hr>
<table border="0" width="95%"  cellspacing="1" cellpadding="0" class="L2">
   <tr>
    <td align="right"  class=firsttd>申请编号：</td>
	<td align="left" class=listbody><input type=text name="No" size=50 value="<%=flow_no %>"></td>
  </tr>
  <tr>
    <td align="right"  class=firsttd>申请主题：</td>
	<td align="left" class=listbody><input type=text name="flowtitle" size=50></td>
  </tr>
  <tr>
    <td align="right"  class=firsttd>正&nbsp;&nbsp;&nbsp;&nbsp;文：</td>
	<td align="left" class=listbody>
	<INPUT type="hidden" name="content1" value="">
		<IFRAME ID="eWebEditor1" src="../edit/ewebeditor.jsp?id=content1&style=coolblue" frameborder="0" scrolling="no" width="650" height="250"></IFRAME>
		 
  </tr>
  
  <tr>
    <td align="right"  class=firsttd>紧急程度：</td>
	<td align="left" class=listbody> <input name="grad" type="radio" value=0 checked>普通&nbsp;&nbsp;<input name="grad" type="radio" value=1 >加急</td>
  </tr> 
    <tr>
        <td width=114 align=right class=firsttd>附&nbsp;&nbsp;&nbsp;&nbsp;件：</td>
        <td colspan=3 class=listbody><input type="file" name="upfile" size="42" ></td> 
      </tr>
</table>

 <br>
  <table border="0" width="95%"  cellspacing="1" cellpadding="0" class="L2">
  <tr>
    <td align="right">
	 
	<input type=button name=ok value="保存" class="button" onclick="checkData()">
	 
	<input type="button" onclick="javascript:window.close()" value="关闭" class=button>
	</td>
  </tr>
</table>
<%} %>
 

<%
}%>
 
</center>
</form>
 
</body>
</html>