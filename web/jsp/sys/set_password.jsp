<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
	<title>更改用户密码</title>
</head>
<%@ page import = "java.sql.*" %>
  <jsp:useBean id = "aBean" scope = "page" class = "ConnDatabase.SDatabase" />
<%@ include file="../public_js/getByteOut.jsp"%>
 
<body onload="document.aform.NewPass.focus();"  oncontextmenu="return false">
<%String user=request.getParameter("user");
String userid=request.getParameter("userid"); 
String submit=request.getParameter("Submit");
String NewPass=request.getParameter("NewPass");

if (submit!=null){
  aBean.executeUpdate("UPDATE CortrolMan set  password='"+NewPass+"' where SerialNo='"+userid+"'");
 %>
 <script>
 alert("系统已更换密码");
 close();
 </script>
 <%} %>
 <script>

 function submitValidate() {
		
		
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
<DIV ALIGN="CENTER"><B>修 
改 密 码</B></DIV>
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ALIGN="CENTER">
<TR><TD ></TD></TR>
<TR><TD><DIV ALIGN="RIGHT">用户名:</DIV></TD>
<TD >&nbsp;</TD><TD ><%= user %><input type=hidden name="userid" value="<%= userid %>" ></TD></TR>
<TR><TD ><DIV ALIGN="RIGHT">新密码:</DIV></TD><TD>&nbsp;</TD>
<TD ><INPUT TYPE="PASSWORD" NAME="NewPass"></TD></TR>
<TR><TD><DIV ALIGN="RIGHT">确认密码:</DIV></TD>
<TD>&nbsp;</TD><TD >
<INPUT TYPE="PASSWORD" NAME="NewPass2"></TD></TR>
<TR><TD ><DIV ALIGN="CENTER"></DIV></TD>
<TD >&nbsp;</TD><TD ><INPUT TYPE="submit" NAME="Submit" VALUE="提交" ></TD>
</TR></TABLE>
</form>
</body>
</html>
