 
 <%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="pageBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<SCRIPT language="JavaScript1.2" type="text/javascript">
function checkData(form)
{ 
   var ans;	
   ans=IsBlank("flowname","请输入流程名称！");
   if(!ans) return false;
    
   
   
   return true;
}
</SCRIPT>
 
<title>流程一览</title>
</head>
<body topmargin="0" leftmargin="0">
 <%

 String StrSql=" ";
   ResultSet codeRS=null;
  String dele=getbyte(request.getParameter("dele"));
  if (!dele.equals("")){
     StrSql="delete  workflow  where   flowname='"+getbyte(request.getParameter("flowname"))+"' and  flow_code="+request.getParameter("code");

	 ViewBean.executeUpdate(StrSql);
   %>
    <script>
	opener.window.location="flow_list.jsp?para=flowtype&sel=2";
	window.close();
	</script>
   <%	 
  
  }
 %>
<form name="pm" method="post"  onSubmit="return checkData()">
 <P align="center"><font size=4>审批流程</font></P>
 
 <% 
   StrSql="select a.checker_no,a.wait_day,b.name from workflow a ,CortrolMan b where a.flow_checker=b.id and  a.flowname='"+getbyte1(request.getParameter("flowname"))+"' and  a.flow_code="+request.getParameter("code");
   codeRS=ViewBean.executeQuery(StrSql);
 
     
    %>
 
 
<center><table width="100%" border="0" cellpadding="1" cellspacing="1">
  <tr align="center"  class=listtitle> 
     <td  > 
      <font color=white>审批顺序</font>
    </td>
  
    <td  > 
   审批人</td>
	 <td  > 
    延迟天数</td>
	 
  </tr> 
  <%  while (codeRS.next()){ %>
  <tr align="center"  class=listcontent> 
 
  
  <td > <%=codeRS.getString("checker_no") %>   </td>
  <td > <%=codeRS.getString("name") %>   </td>    
  <td > <%=codeRS.getString("wait_day") %>   </td>
 
  </tr>
  
  <%
   }codeRS.close();
   
 
   %>
 
 
</table>
 <input type=button name="delefloow" value="删除"  onclick="delechec();">
 <script>
 function delechec(){
  if (confirm("确认删除吗？"))
    window.location="flow_view.jsp?flowname=<%=getbyte(request.getParameter("flowname")) %>&code=<%=getbyte(request.getParameter("code")) %>&dele=ok";
 
 
 }
 
 
 </script>
 
</center>
</form>
 
</body>
</html>