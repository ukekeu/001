 


 
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
<script language="javascript" src="../public_js/public.js"></script>
 
<title>增加流程类别</title>
</head>
<body topmargin="0" leftmargin="0">
 <%

 String StrSql="select * from CortrolMan where ACTIVE=1";
   ResultSet codeRS=null;
   String CodeName[]=new String[100];
   String CodeType[]=new String[100];
   codeRS=ViewBean.executeQuery(StrSql);
   int ii=0;
   while (codeRS.next()){
     CodeType[ii]=getbyte(codeRS.getString("id"));
     CodeName[ii]=getbyte(codeRS.getString("name"));
	 ii++;
   }
   codeRS.close();
 %>
<form name="pm" method="post" action="add_floow_action.jsp" onSubmit="return checkData()">
 <P align="center"><font size=4>定义审批流程</font></P>
 选择流程类别：<select name=floowtype>
 <% 
   StrSql="select code,flow_name from workflow_set";
   codeRS=ViewBean.executeQuery(StrSql);
  while (codeRS.next()){
      out.print("<option value="+getbyte(codeRS.getString("code"))+">"+getbyte(codeRS.getString("flow_name"))+"</option>");
	 ii++;
   }
   codeRS.close();
    %>
 
 </select>&nbsp;&nbsp;流程名称：<input type=text name=flowname>
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
  <% for (int i=1;i<8;i++){ %>
  <tr align="center"  class=listcontent> 
 
  
   <td > <select  name="N<%=i %>"     onkeydown="key(document.frm.P<%=i %>)">
  
   <%
   for (int iii=1;iii<8;iii++){
        if (iii==i)
	      out.print("<option  value="+iii+" selected >"+iii+"</option>");
		else
		    out.print("<option  value="+iii+"  >"+iii+"</option>"); 
       }
  %>
  </SELECT>
  
   </td>
       
  <td ><select  name="P<%=i %>"      onkeydown="key(document.frm.D<%=i %>)">
  <option value=""></option> 
 <%
   for (int iii=0;iii<100;iii++){
		  if (CodeType[iii]!=null){
		  
	       out.print("<option value="+CodeType[iii]+">"+CodeName[iii]+"</option>");
		  }
       }
  %>
 </select> </td>
  <td > <input type=text name="D<%=i %>"  size="10"  value=3    onkeydown="key(document.frm.N<%=i+1 %>)" ></td>
   
 
  </tr>
  
  <%
   }
   
 
   %>
 
 
</table>
	<p align=center>
 
        <input type="button" name="Button" value="提   交" onclick="document.pm.submit()">&nbsp;<input type="button" name="Button1" value="退 出" onclick="if (confirm('确认退出吗？'))window.close();">
    
</p>
 
</center>
</form>
 
</body>
</html>