<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*" %>

 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="pageBean" scope="page" class="ConnDatabase.SDatabase"/>
  <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet></head>


<script language="javascript" src="../public_jspublic.js"></script>
 <script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

	 
<script>
function check(aForm){
   if (aForm.title.value.length<1)
	  	{
	   	alert("请输入主题！");
	     aForm.title.focus();
	     return (false);
	   }	
  
 if (aForm.date.value.length<1)
	  	{
	   	alert("请选择日期！");
	     aForm.date.focus();
	     return (false);
	   }	 	     
 return (true);
}
</script>
<body> 
<%
 String  id=request.getParameter("id");
   String SQL="select  type,subject,body,date,tdate,deptid,filename from gonggao where id="+id;
   String my_id=""; 
    ResultSet rs=null;
	
     rs=ViewBean.executeQuery(SQL);   
	 
   if (rs.next()){
   String type=getbyte(rs.getString("type"));
 %>
<p align=center><font size=3 class=FontColor><b>发布公告</b></font></p>
<form method="POST" name="cus" action="modigongao_at.jsp" onsubmit="return check(this);"  ENCTYPE="multipart/form-data">
<input type=hidden name=gonggaoid value="<%=id %>">
<table width="100%" border="0" cellspacing="1"  cellpadding="1" >
  
  <tr>
    <td width="15%" class=roomleft >&nbsp;部门</td>
    <td width="75%" class=roomright>
	 <input type=text  size=50  name="dept" value="<%=getbyte(rs.getString("deptid")) %>"><input type=button name=set value="分配" onclick="openwin1('dept_list.jsp',300,400);">&nbsp;      
	 
	　</td>
  </tr>
 
  <tr>
    <td width="15%"class=roomleft>&nbsp;主    题</td>
    <td width="75%"class=roomright>
  
          <input type=text  size=50  name="title" value="<%=getbyte(rs.getString("subject")) %>">         
       </td>
	   </tr>
	   <tr>
          <td width="15%"class=roomleft >&nbsp; 正   文</td>
          <td width="75%"class=roomright>
			<INPUT type="hidden" name="content1" value="<%=getbyte(rs.getString("body")) %>">
		      <IFRAME ID="eWebEditor1" src="../edit/ewebeditor.jsp?id=content1&style=coolblue" frameborder="0" scrolling="no" width="550" height="350"></IFRAME>
	       
		  
		  </td>   
        </tr>
      <tr>
          <td width="15%"class=roomleft  colspan="2">&nbsp; 开始日期    
		   &nbsp; <input type=text size="12" name="date" value="<%=getbyte1(rs.getDate("date").toString()) %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(date,'../');return false">       
       &nbsp; 结束日期 
        
		  <input type=text size="12" name="date1" value="<%=getbyte(rs.getDate("tdate").toString()) %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(date1,'../');return false">       
       </td>    
       </tr>
	    <%
		int ii=0;
		String fj1="",fj2="",fj3="";
		String adjunct=getbyte1(rs.getString("filename"));
		if (!adjunct.equals("")){%>
	 <%StringTokenizer st22 = new StringTokenizer(adjunct,"&") ;
	  while (st22.hasMoreElements()) {
	   if (ii==0)
	    fj1=(String)st22.nextElement();
	   else 	if (ii==1)
	      fj2=(String)st22.nextElement();
	    else 	if (ii==2)
	      fj3=(String)st22.nextElement();	
		ii++;    
	  %>
	 
	 
	 
	 <%}} %>&nbsp;
		<tr>
          <td width="15%"class=roomleft >&nbsp; 附   件</td>
          <td width="75%"class=roomright>
		  <%if (!fj1.equals("")){ %>
		    <a href="#"  onclick="window.open('<%=fj1 %>');"><img src="../images/i_sign.gif" border=0></a>
	      <%} %>
		  <input type="file" name="Map1"  >
		  </td>   
        </tr>
		<tr>
          <td width="15%"class=roomleft >&nbsp; 附   件</td>
          <td width="75%"class=roomright>
		   <%if (!fj2.equals("")){ %>
		    <a href="#"  onclick="window.open('<%=fj2 %>');"><img src="../images/i_sign.gif" border=0></a>
	      <%} %><input type="file" name="Map2"  >
		  </td>   
        </tr>
		<tr>
          <td width="15%"class=roomleft >&nbsp; 附   件</td>
          <td width="75%"class=roomright>
		   <%if (!fj3.equals("")){ %>
		    <a href="#"  onclick="window.open('<%=fj3 %>');"><img src="../images/i_sign.gif" border=0></a>
	      <%} %><input type="file" name="Map3"  >
		  </td>   
        </tr>
</table>

<p>
<div align="center"> 
            <input type="submit" value="提　交" name="submit" >
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="button" value="退  出" name="cancel" onclick="window.close();">
          </div>
</p>
<%}rs.close(); %>
  </form>       
</body>

</html>
