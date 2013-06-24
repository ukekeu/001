<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<HTML>
<HEAD>
<TITLE>快速设置</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; chamisRset=gb2312"> 
<link rel="stylesheet" href="../class/news.css" >
<script language="javascript" src="../public_js/public.js"></script>
<script language=javascript src="../js/mad.js"></script>
<script  src="../public_js/calendar.script"></script>
<script  src="../public_js/Popup.js"></script>     
</head>
<%@ page import="java.sql.*, common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
<jsp:useBean id="setpro" scope="session" class="setProperty.setProperty"/>   
<%@ include file="../public_js/getByteOut.jsp"%>
<body>
<script language="JavaScript">
function checkedvalue(th){
    var thisvalue=th.value;
	if (thisvalue!=""){
	 if (isNaN(thisvalue)){
	   alert("请输出数字型数值");
	   th.focus();
	   th.select();
	   return false;
	  }
	 }
	 if (thisvalue!=""&&thisvalue.indexOf("+")<0&&thisvalue.indexOf("-")<0){
	 th.value="+"+thisvalue;
	 }
  }
</script>
<form method="post" name="pmregister"> 
<%String spage=request.getParameter("page"); 
String itemname=getbyte2(request.getParameter("itemname"));
  String item=" where typename='"+itemname+"'";
  %>
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
  <TR> 
    <TD COLSPAN="2"  align="center" class=FontColor> 
        <font size=3><b>快速设置</b></font>
    </TD>
  </TR>
  <TR> 
    <TD COLSPAN="2" height=10></TD>
  </TR>
</TABLE>

<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
   
    <tr align="center" > 
      <TD WIDTH="50%" bgcolor="#CFE6EB"> <%=itemname %></TD>
      <TD WIDTH="50%" bgcolor="#e2e2e2"> 
        <div align="left"> 
         <input type="text" name="begin" value="" size="5">--<input type="text" name="end" value="" size="5">
        </div>
      </TD>    
    </TR>
	<tr align="center">
	   <TD WIDTH="50%" bgcolor="#CFE6EB">差价</TD>
      <TD WIDTH="50%" bgcolor="#e2e2e2"> 
        <div align="left"> 
          <input type="text" name="price"  onblur="checkedvalue(this);" title="数字" value="0" size="15" >
        </div>
      </TD>
	</tr>
     </TABLE>
  

  <table width="50%" border="0" align="center">
    <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
      <div align="center">
        
		<input type="button" name="Submit3" value="提 交" onclick="setFindValue()">
      </div>
    </td>
    <td>
      <div align="center">
        <input type="button" name="Submit2" value="返 回" onclick="window.close()">
      </div>
    </td>
  </tr>
</table>
<script language="JavaScript">
 function setFindValue()
 {
  opener.document.frm.begin.value=pmregister.begin.value;
  opener.document.frm.end.value=pmregister.end.value;
  opener.document.frm.price.value=pmregister.price.value;
  opener.getpage('<%=request.getParameter("Rinfo") %>');
  close();
  }
</script>
</form>
</BODY>
</HTML>
