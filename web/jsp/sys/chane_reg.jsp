<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<HTML>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<HEAD>
 <LINK href="../class/news.css" rel=stylesheet>
<TITLE>修改登录用户</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK"> 

<script language=javascript src="js/mad.js"></script>
</HEAD>
<%@ page import = "java.sql.*" %>
<jsp:useBean id = "aBean" scope = "page" class = "ConnDatabase.SDatabase" />
<jsp:useBean id='md5' scope='request' class='crypt.MD5'/>
<%@ include file="../public_js/getByteOut.jsp"%>
<BODY oncontextmenu="return false" >
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
		if (document.aform.NewID.value==""){
		    alert("请输入新登录ID");
			return false;
			}
		if (document.aform.NewID1.value==""){
		   alert("请输入确认登录ID");
			return false;		
		}
		var npass = document.aform.NewID.value;
		var npass2 = document.aform.NewID1.value;
		if (!(npass == npass2)) {
			alert("两次新登录ID必须相同");
			document.aform.NewID.focus();
			return false;
		}	
		return true;
	}
</script>
<FORM NAME="aform" METHOD="post" ACTION="" onsubmit="return submitValidate()">
  
  <TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ALIGN="CENTER">
    <TR><TD COLSPAN="2"><DIV ALIGN="CENTER"><B><font size="3">修改登录用户</font></B><br>
        </DIV></TD></TR><TR>
<TD WIDTH="50%" class=roomleft>
<DIV ALIGN="RIGHT">用户名:</DIV>
</TD>
<TD WIDTH="50%" class=roomright>
<%= id %><input type=hidden name="userid" value="<%= user_id %>" >
</TD>
</TR>
<TR><TD WIDTH="50%" class=roomleft>
<DIV ALIGN="RIGHT">输入密码:</DIV>
</TD>
<TD WIDTH="50%" class=roomright><INPUT TYPE="PASSWORD" NAME="Password">
</TD>
</TR>
<TR>
<TD WIDTH="50%" class=roomleft><DIV ALIGN="RIGHT">输入新帐号:</DIV></TD>
<TD WIDTH="50%" class=roomright><INPUT TYPE="TEXT" NAME="NewID"></TD>
</TR>
<TR><TD WIDTH="50%" class=roomleft><DIV ALIGN="RIGHT">确认新帐号:</DIV></TD>
<TD WIDTH="50%" class=roomright><INPUT TYPE="TEXT" NAME="NewID1"></TD>
</TR>
<TR>
 
<TD WIDTH="80%" align=center colspan=3><INPUT TYPE="submit" NAME="Submit" VALUE=" 提 交 " >&nbsp;<INPUT TYPE="button" NAME="Submit1" VALUE=" 退 出" onclick="window.close();"></TD></TR></TABLE></FORM> 
<%
	String password = request.getParameter("Password");
	String newPass = request.getParameter("NewID");
	String newPass2 = request.getParameter("NewID1");
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
		passStr = "select count(*) count2 from CortrolMan where SerialNo='" + user_id + "' and password='" + md5.getMD5ofStr(password)   + "'";
	
		aRS = aBean.executeQuery(passStr);
		aRS.next();
		int count = aRS.getInt("count2");

		if (count != 1) {
			out.print("密码不正确"+password);
			out.close();
		}else{	
		insertStr = "update CortrolMan set in_no='"+md5.getMD5ofStr(newPass)  + "' where SerialNo='" + user_id + "'";

		try {
			aBean.executeUpdate(insertStr);
            setlog( setlogBean , 
                              ( String )session.getAttribute( "loginid" ) ,
                              "修改登录ID" , 
                              "修改"
                            ) ;
			out.print("<p align=center ><font color=red>登录ID修改成功</font>");
		}catch(Exception e) {
			out.print("登录ID修改不成功,请重新");
		}
		}
	}	
		
%>

</BODY>
</HTML>