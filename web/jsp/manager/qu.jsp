<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %> 

<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="aBean2" scope="page" class="ConnDatabase.SDatabase" />
 <%@ include file="../public_js/getByteOut.jsp"%>
<head>
<title>发言</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.unnamed1 {  font-size: 9pt}
-->
</style>
<link rel="stylesheet" href="../font.css">
<script language="JavaScript">
function dosubmit()
{
	if(form1.subject.value=="")
	{
		alert("标题不能为空");
		return false;
	}
} 
</script>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgproperties="fixed">
<form method="post" action="qu_action.jsp" name="form1"   onsubmit="return dosubmit();">
 <div align="right">
          <input type="hidden" name="id" value="<%="119"%>">
          <input type="hidden" name="pagename" value="qu">
          <input type="submit" border="0" name="Submit"  value="确 定" height="18">
        </div>
  <table width="96%" border="0" cellspacing="0" cellpadding="0" align="center" class="unnamed1">
    <tr> 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <h4>发言</h4>
      </td>
    </tr>
    <tr> 
      <td width="62"> 
        <div align="right">标题：</div>
      </td>
      <td colspan="2">
        <input type="text" name="subject" size="83" maxlength="80">
      </td>
    </tr>
			 
 
   
    <tr> 
      <td width="62" valign="top">&nbsp;</td>
      <td valign="top" colspan="2"> 
        <table width="525" border="0" cellpadding="0" cellspacing="0">
          <tr> 
            <td width="525"><br>
              <input type="radio" name="face" value="1" checked>
              <img src="../../bbs/images/face1.gif" ><%for (int i=2 ;i<= 40;i++){%> 
              <input type="radio" name="face" value="<%=i%>">
              <img src="../../bbs/images/face<%=i%>.gif"><%}%></td>
			<td> 
			
          </tr>
          <tr>
          <input type="radio" name="nmflag"  value="1">
			匿名
			<input type="radio" name="nmflag" checked value="2">
			不匿名
			</td>
          </tr>
          
        </table>
      </td>
    </tr>
	 <tr> 
      <td width="62" valign="top"> 
        <div align="right">内容：</div>
      </td>
      <td valign="top" colspan="2">
	  <textarea cols="95" rows="14" name="content1"></textarea>    </td>
   </tr> 
    <tr> 
      <td width="62" valign="top">&nbsp;</td>
      <td valign="top" colspan="2"> 
       
      </td>
    </tr>
  </table>
</form>
</body>
</html>
