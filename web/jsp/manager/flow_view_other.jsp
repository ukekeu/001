 
 <%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
 
 <jsp:useBean id='md5' scope='request' class='crypt.MD5'/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<SCRIPT language="JavaScript1.2" type="text/javascript">
function checkData()
{ 
    var ans;	
   ans=IsBlank("checkpassword","请输入你的密码！");
   if(!ans) return false;
   else document.pm.submit();
 
}
</SCRIPT>
 <script language="javascript" src="../public_js/public.js"></script>
<title>流程一览(非客户)</title>
</head>
<body topmargin="0" leftmargin="0">

<form name="pm" method="post" action=""  >
<input type=hidden name=code value"<%=request.getParameter("code") %>">
 
 <% 
 String checkpassword=getbyte(request.getParameter("checkpassword"));
 String flow_code=request.getParameter("code");
 String checkstate="";
 if (!checkpassword.equals("")){
  if (md5.getMD5ofStr(checkpassword).equals((String) session.getAttribute("pwd"))){
   String check_anwser=getbyte(request.getParameter("Remark1"));
   String checkok=getbyte(request.getParameter("checkok"));
   String SQL="UPDATE workflow_check_state SET check_date=getdate(),check_anwser='"+check_anwser+"'";
          SQL+=",check_state="+checkok+" where  checker="+(String) session.getAttribute("login_id")+" and flow_no="+request.getParameter("code");
          ViewBean.executeUpdate(SQL);
		  checkstate="dd";
		   out.print("<p align=center><font color=red>已审批</font></p>");
		   SQL="select  check_state from workflow_check_state where check_state=0 and  checker="+(String) session.getAttribute("login_id")+" and flow_no="+request.getParameter("code");
           ResultSet rs=null;
		 
		   rs=ViewBean.executeQuery(SQL);
	      if (!rs.next()){   
		     ViewBean.executeUpdate("update workflow_txt set state=1 where code="+request.getParameter("code"));
			int aa= ViewBean.executeUpdate("update PM_CUSTOMER set mess=2 where id="+request.getParameter("customer"));
			 
		  }
		  rs.close();
		  %>
		  <script>
		  opener.window.location="myplan.jsp";
		  </script>
		  <%
   }else{
    out.print("<p align=center><font color=red>密码不正确</font></p>");
    }
 }
 String StrSql=" select * from workflow_txt where code="+request.getParameter("code");
 
   ResultSet codeRS=null;
   String send_date="",customer="";
    codeRS=ViewBean.executeQuery(StrSql);
	if (codeRS.next()){
	send_date=codeRS.getString("send_date").substring(0,10);
	customer=codeRS.getString("customer");
	String files=codeRS.getString("files");
  
 %>

<table border="0" width="95%"  cellspacing="1" cellpadding="0" class="L2">
    <tr >
    <td align="right"  class=listtitle>发送人：</td>
	<td align="left" class=listcontent> <%=codeRS.getString("send_person") %></td>
  </tr>
    <tr>
    <td align="right"  class=listtitle>发送日间：</td>
	<td align="left" class=listcontent> <%=codeRS.getString("send_date") %></td>
  </tr>
   <tr>
    <td align="right"  class=listtitle>申请编号：</td>
	<td align="left" class=listcontent> <%=codeRS.getString("flowno") %></td>
  </tr>
  <tr>
    <td align="right"  class=listtitle>申请主题：</td>
	<td align="left" class=listcontent><%=codeRS.getString("flowtitle") %></td>
  </tr>
  <tr>
    <td align="right"  class=listtitle>正&nbsp;&nbsp;&nbsp;&nbsp;文：</td>
	<td align="left" class=listcontent> <%=codeRS.getString("check_txt") %></td>
  </tr>
  <tr>
    <td align="right"  class=listtitle>紧急程度：</td>
	<td align="left" class=listcontent> <input name="grad" type="radio" value=0 <%if (codeRS.getInt("filetype")==0){out.print("checked");} %>>普通&nbsp;&nbsp;<input name="grad" type="radio" value=1 <%if (codeRS.getInt("filetype")==1){out.print("checked");} %> >加急</td>
  </tr>
    <tr>
        <td width=114 align=right class=listtitle>附&nbsp;&nbsp;&nbsp;&nbsp;件：</td>
        <td colspan=3 class=listcontent><%if (!files.equals("")){ %><a href="../<%=files %>" target="_blank"><img src="../images/i_sign.gif" border="0"></a><%} %></td> 
      </tr>
</table> 

<%}codeRS.close(); %>
 <P align="center"><font size=4>审批流程</font></P>
 
 <% 
 
    ViewBean.executeUpdate("UPDATE workflow_check_state SET READ_DATE=GETDATE() WHERE READ_DATE is null and  checker="+(String) session.getAttribute("login_id")+" and flow_no="+request.getParameter("code"));
   StrSql="select a.checker_no,a.wait_day,b.name,a.check_state,a.check_anwser,a.check_date,a.back_state,datediff(dd,'"+send_date+"',getdate()) day,a.READ_DATE   from workflow_check_state a ,CortrolMan b where   a.checker=b.id  and a.flow_no="+request.getParameter("code");
   codeRS=ViewBean.executeQuery(StrSql);
        %>
 
 
<center><table width="100%" border="0" cellpadding="1" cellspacing="1"  bgcolor="#000000" >
  <tr align="center"  class=listtitle> 
     <td  >  审批顺序  </td>  
	   <td  >审批状态   </td> 
     <td  >    审批人</td>
	 <td  >    审批意见</td>
	  <td  >    查阅时间</td>
	   <td  >    审批时间</td>
  </tr> 
  <%  while (codeRS.next()){ %>
  <tr align="center"  class=listcontent>   
  <td > <%=codeRS.getString("checker_no") %>   </td>
  <td > <%if (codeRS.getInt("check_state")==1)out.print("<font color='red'>√</font>");else if (codeRS.getInt("check_state")==3) out.print("终止"); else if (codeRS.getInt("check_state")==2) out.print("退回");else out.print("待批");  %>   </td>
  <td > <%=codeRS.getString("name") %>   </td>    
  <td > <%=getbyte(codeRS.getString("check_anwser")) %>   </td>
   <td > <%=getbyte(codeRS.getString("READ_DATE"))  %>   </td>
    <td > <%=getbyte(codeRS.getString("check_date"))  %>   </td>
  </tr>
  
  <%
   }codeRS.close();
   
 
   %>
 
 
</table>
 
</center>
</form>
 
</body>
</html>