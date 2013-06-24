 <%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
<HTML>
<HEAD>
<TITLE>发布资讯</TITLE> 
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<style>
body,td,input,textarea {font-size:9pt}
</style>
</HEAD>
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript">
function dosubmit()
{
if (confirm("确认吗?")){
if(form1.subject.value=="")
{
alert("发布资讯标题不能为空");
form1.subject.focus();
return false;
} 
document.form1.submit();
}
}
</script>
<BODY>
<%  String sContent1=getbyte1(request.getParameter("content1"));
 String subject=getbyte1(request.getParameter("subject"));
if (!subject.equals("")) {
	String SQL="INSERT INTO news(newstitle,newstxt,newsdate,enddate,checker,type,reads) values('" ;
    SQL+=getbyte1(request.getParameter("subject"))+"','"+sContent1+"',getdate(),'"+getbyte1(request.getParameter("enddate"));
	SQL+="','"+(String)session.getAttribute("loginname")+"','"+getbyte1(request.getParameter("type"))+"',1)";
 
		 try{   ViewBean.executeUpdate(SQL); 
	 
	}catch(Exception s){out.print(s);out.close();}				  
%><script language="JavaScript">
alert("添加成功");
 //opener.window.location="../manager/view_info.jsp?pagename=1";
  opener.window.full1('<%=getbyte1(request.getParameter("type")) %>');

window.close();
</script><%
	
out.close();
}
%>
<FORM method="POST" name="myform" action="">
<TABLE border="0" cellpadding="2" cellspacing="1">
  <tr>
  <td width="15%"  >  <div align="right">类别：</div></td>
  <td width="75%" class=roomright>
<select name=type>
<%String StrSql="select type from knowledge_type   where typestate=1 ";
ResultSet codeRS=ViewBean.executeQuery(StrSql);
   
   while (codeRS.next()){
String type=getbyte(codeRS.getString("type"));
     out.print("<option value='"+type+"'>"+type+"</option>");

 }
 codeRS.close();
%>
</select>
　</td>  </tr>  <tr>                             
                          <td> 
                            <div align="right">在</div>
                          </td>
                          <td><input  type=text name=enddate  size=12  ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(enddate);" title="请选择认购日期">
                            之前有效  </td>
                        </tr>
						<tr> 
                          <td> 
                            <div align="right">标题：</div>
                          </td>
                          <td colspan="3"> 
                            <input type="text" name="subject" size="65" maxlength="100">
                          </td>
                        </tr>
<TR>
	<TD>编辑<br>内容：</TD>
	<TD>
		<INPUT type="hidden" name="content1" value="">
		 <IFRAME ID="eWebEditor1" src="ewebeditor.jsp?id=content1&style=coolblue" frameborder="0" scrolling="no" width="550" height="350"></IFRAME>
	     </TD>
</TR>
<TR>
	<TD colspan=2 align=right>
	<INPUT type=submit name=b1 value="保 存">
	<INPUT type=button name=b2 value="退 出" onclick="window.close();">
	 	</TD>
</TR>
 
</TABLE>
</FORM>

</BODY>
</HTML>
