<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="InsertBean1" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="FormtD" scope="page" class="FormatData.FormatData"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
	<title>楼层浮动系数</title>
</head>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="javascript" src="../public_js/public.js"></script>
<script language="JavaScript">
 function setFindValue()
 {
  opener.document.frm.basicfloor.value=pmregister.basicfloor.value;
  opener.document.frm.floor1.value=pmregister.floor1.value;
  opener.document.frm.floor2.value=pmregister.floor2.value;
  opener.document.frm.fixmodulus.value=pmregister.fixmodulus.value;
  opener.document.frm.floormodulus.value=pmregister.floatmodulus.value;
  opener.getmodulus();
  close();

}

</script>
</head>
<body>
<form name=pmregister>
<p align="center">楼层浮动系数</p>
<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
   
    <tr width="100%">
          <td width="125" align="right" bgcolor="#CFE6EB">基准楼层</td>
	      <td width="128" bgcolor="#e2e2e2"> 
           <input type="text" name="basicfloor" size=10 >
   
   </td>
   </tr>
   <tr width="100%">
          <td width="125" align="right" bgcolor="#CFE6EB">浮动区间</td>
	      <td width="128" bgcolor="#e2e2e2"> 
           <input type="text" name="floor1" size=3 >-<input type="text" name="floor2" size=3 >
   
   </td>
   </tr>
    <tr width="100%">
          <td width="125" align="right" bgcolor="#CFE6EB">固定系数</td>
	      <td width="128" bgcolor="#e2e2e2"> 
        <input type="text" name="fixmodulus" size=10 value="1">
  
	    
		 </td>
	</tr>
	<tr width="100%">
          <td width="125" align="right" bgcolor="#CFE6EB">浮动系数</td>
	      <td width="128" bgcolor="#e2e2e2"> 
            <input type="text" name="floatmodulus" size="18">
	     </td>
	</tr>	   
	
</table>
<br>
<table width="98%" border="0">
  <tr>
    <td align="center">
	<input  type="button" value="确定" onclick="setFindValue();">
	<input  type="button" onclick="javascript:window.close()" value="取消">
   </td>
  </tr>
 </table>
</form>
</body>
</html>
