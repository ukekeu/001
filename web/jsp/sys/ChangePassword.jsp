<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<HTML>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<HEAD>
 <LINK href="../class/news.css" rel=stylesheet>
<TITLE>修改密码</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312"> 

<script language=javascript src="js/mad.js"></script>
</HEAD>
<%@ page import = "java.sql.*" %>
  <jsp:useBean id = "aBean" scope = "page" class = "ConnDatabase.SDatabase" />
<jsp:useBean id='md5' scope='request' class='crypt.MD5'/>
<%@ include file="../public_js/getByteOut.jsp"%>
<BODY bgcolor="#F9F9F9" oncontextmenu="return false"  >
<%
    String user_id =(String) session.getAttribute("loginuserid");
	String user =(String) session.getAttribute("loginname");
	String id = (String) session.getAttribute("loginid");
%>
<script>
	function submitValidate() {
		
		if (document.aform.Password.value==""){
		    alert("请输入密码");
			return false;
			}
		if (document.aform.NewPass.value==""){
		    alert("请输入新密码");
			return false;
			}
		if (document.aform.NewPass2.value==""){
		   alert("请输入新密码");
			return false;		
		}
		var npass = document.aform.NewPass.value;
		var npass2 = document.aform.NewPass2.value;
		if (!(npass == npass2)) {
			alert("新密码不一致");
			document.aform.NewPass.focus();
			return false;
		}	
		return true;
	}
</script>
<FORM NAME="aform" METHOD="post" ACTION="" onsubmit="return submitValidate()">
<p>&nbsp;</p>

 
  <TABLE WIDTH="90%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ALIGN="CENTER">
    <TR><TD COLSPAN="2"><DIV ALIGN="CENTER"><B><font size="3">修 改 密 码</font></B><br>
        </DIV></TD></TR><TR>
<TD WIDTH="50%" class=roomleft>
<DIV ALIGN="RIGHT">用户名:</DIV>
</TD>
<TD WIDTH="50%" class=roomright>
<%= user %><input type=hidden name="userid" value="<%= user_id %>" >
</TD>
</TR>
<TR><TD WIDTH="50%" class=roomleft>
<DIV ALIGN="RIGHT">输入旧密码:</DIV>
</TD>
<TD WIDTH="50%" class=roomright><INPUT TYPE="PASSWORD" NAME="Password">
</TD>
</TR>
<TR>
<TD WIDTH="50%" class=roomleft><DIV ALIGN="RIGHT">输入新密码:</DIV></TD>
<TD WIDTH="50%" class=roomright><INPUT TYPE="PASSWORD" NAME="NewPass"></TD>
</TR>
<TR><TD WIDTH="50%" class=roomleft><DIV ALIGN="RIGHT">确认新密码:</DIV></TD>
<TD WIDTH="50%" class=roomright><INPUT TYPE="PASSWORD" NAME="NewPass2"></TD>
</TR>
<TR>
 
<TD WIDTH="80%" align=center colspan=3><p>&nbsp;</p><INPUT TYPE="submit" NAME="Submit" VALUE=" 提 交 " >&nbsp;<INPUT TYPE="button" NAME="Submit1" VALUE=" 退 出" onclick="window.close();"></TD></TR></TABLE></FORM> 
<%
	String password = request.getParameter("Password");
	String newPass = request.getParameter("NewPass");
	String newPass2 = request.getParameter("NewPass2");
	String userid = id;
	if (password == null)
		password = "";
	if (newPass == null)
		newPass = "";
	if (newPass2 == null)
		newPass2 = "";
	if (userid == null)
		userid = "";
		
	String passStr = "";
	String insertStr = "";
	ResultSet aRS = null;	
	if (!(password.equals("") || newPass.equals("") || newPass2.equals("") || userid.equals(""))) {
		passStr = "select count(*) count2 from CortrolMan where SerialNo='" + user_id + "' and password='" +md5.getMD5ofStr(password)  + "'";
	
		aRS = aBean.executeQuery(passStr);
		aRS.next();
		int count = aRS.getInt("count2");

		if (count != 1) {
			out.print("密码不正确");
			out.close();
		}	
		insertStr = "update CortrolMan set password='" + md5.getMD5ofStr(newPass)+ "' where SerialNo='" + user_id + "'";
 
		try {
			aBean.executeUpdate(insertStr);
                 setlog( setlogBean , 
                              ( String )session.getAttribute( "loginid" ) ,
                              "修改密码" , 
                              "修改"
                            ) ;
			out.print("<p align=center ><font color=red>密码修改成功</font>");
			%>
			<script>alert("密码修改成功");window.close();</script>
			<%
		}catch(Exception e) {
			out.print("密码修改不成功,请重新");
		}
	}	
		
%>

</BODY>
</HTML>