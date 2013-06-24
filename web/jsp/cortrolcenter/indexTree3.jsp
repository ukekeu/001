<%@ page contentType="text/html;charset=GBK" %>  
<%@ include file="../public_js/checktime.jsp"%>
<META content="MSHTML 6.00.2462.0" name=GENERATOR>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<STYLE>.navPoint {
	FONT-SIZE: 6pt; CURSOR: hand; COLOR: red; FONT-FAMILY: Webdings
}
P {
	FONT-SIZE: 6pt
}
</STYLE>
<script language="JavaScript" src='../public_js/menu.js'></script>
	<title>销控表</title>
</HEAD>
<BODY style="MARGIN: 0px" scroll=no>
<TABLE height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD id=frmTitle vAlign=center noWrap align=middle name="frmTitle"><IFRAME 
      id=BoardTitle 
      style="Z-INDEX: 2; VISIBILITY: inherit; WIDTH: 140px; HEIGHT: 100%" 
      name=BoardTitle src="roomtreestate.jsp" frameBorder=0></IFRAME>
    <TD style="WIDTH: 5pt" bgColor=#dbdbdb>
      <TABLE height="100%" cellSpacing=0 cellPadding=0 border=0>
        <TBODY>
        <TR>
          <TD style="HEIGHT: 100%" onclick=switchSysBar()><SPAN class=navPoint 
            id=switchPoint title=关闭/打开左栏>3</SPAN> </TD></TR></TBODY></TABLE></TD>
    <TD style="WIDTH: 100%">
	<IFRAME id=frmright 
      style="Z-INDEX: 1; VISIBILITY: inherit; WIDTH: 100%; HEIGHT: 100%" 
      name=frmright src="searcher.jsp" 
      frameBorder=0>
      </IFRAME></TD></TR></TBODY></TABLE></BODY></HTML>
