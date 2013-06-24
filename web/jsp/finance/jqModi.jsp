<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,java.util.*,common.*"%>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="fa" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<%
  String yang_tai_zhao_sarea=getbyte1(request.getParameter("yang_tai_zhao_sarea"));
  String dt_area=getbyte1(request.getParameter("dt_area"));
 String SQL="";
   String roomno=request.getParameter("roomno");
   String section=request.getParameter("section");
   String id=getbyte1(request.getParameter("id"));
   if (!id.equals("")){
   String jqdate=getbyte1(request.getParameter("jqdate"));
   String contractno=getbyte1(request.getParameter("contractno"));
   String type=getbyte1(request.getParameter("type"));
if (!jqdate.equals("")&&type.equals("2"))
   SQL="update order_contract set ytz_jq_date=getdate() where code="+contractno;
if (!jqdate.equals("")&&type.equals("1"))
   SQL="update order_contract set yxz_jq_date=getdate() where code="+contractno;
  ViewBean.executeUpdate(SQL);
   %> <script>alert("已保存！");opener.window.location.reload();window.close();</script>
	<%
  }
 
	  
	%>
	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/news.css" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>阳台罩资料</title>

</head>

<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
 


<body   bgcolor="#EBEBEB">

<form method="POST" name="cus1" action="jqModi.jsp?roomno=<%=roomno %>&section=<%=section %>">
<input type=hidden name=id value=<%=roomno %>>
 
	<p align="center"><b><font size="3" color="#000080">结清</font></b></p>
	
   <table width="98%"  align="center" border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
      <tr style="border-style: solid; border-width: 1"> 
        <td width="25%"  align="left" height="23" bgcolor="#EBEBEB">&nbsp;结清日期</td>
        <td width="25%"  align="left" height="23"  > 
		  &nbsp;<INPUT TYPE=TEXT NAME=jqdate size=12 ><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(jqdate);" title="请选择认购日期">
		  </td>
      </tr>
      
     
	
	  
       
    </table> 
	<br>
	 <div align="center"> 
               <input type=hidden name=type value="<%=request.getParameter("type") %>">
             <input type=hidden name=contractno value=<%=request.getParameter("contractno") %>>
            <input type="button" value="提　交" name="Save" onclick="checkjq();" >
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="reset" value="退  出" name="button" onclick="window.close();">
          </div> 
</form>     
<script>
function checkjq(){
 if (document.cus1.jqdate.value==""){alert("请选择结清日期");return false;}
 document.cus1.submit();

}
</script>
 
   
       
       
</body>       
</html>       
