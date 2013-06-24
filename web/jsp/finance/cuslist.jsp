<%@ page contentType="text/html;charset=GBK" %>
 <%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<title>客户列表</title>
</head>
  <%@ page import="java.sql.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
    <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
<body bgcolor="#EBaBEc">
<%String SecName=request.getParameter("SecNo"); 
  String sql="select ViewFinanceVoucher";
  if (SecName==null){SecName="";}
  else{SecName=" where SerialNo='"+SecName+"'";}
%>
<SCRIPT>
  		function changeSec() {
			cus.action = "cuslist.jsp";
			cus.submit();
		}
	function setValue(){
        var aa=eval("parent.document.cus.summary"+parent.buttonId);
        var aa1=eval("parent.document.cus.CusSummary"+parent.buttonId);
		
        aa.value=document.cus.CusList.options[document.cus.CusList.selectedIndex].text;
		aa1.value=document.cus.CusList.options[document.cus.CusList.selectedIndex].value;
		parent.list_Close('cuslist');
	   
  }
  </SCRIPT> 
<form name=cus method="post" action="">
<input type=button name=aa value="X" onclick="parent.list_Close('cuslist');" title="关闭客户列表">&nbsp;楼盘名称:
<select name="SecNo" OnChange="changeSec();">
<option>&nbsp;</option>
<%	out.println(commonListBean.getList(aBean,"serialno","name"," from section"));
 %>
</select>
<br>
<select name="CusList" multiple size=20 style=" border-width: 40" OnChange="setValue();">

<%	out.println(commonListBean.getList(aBean,"cusno","cus"," from ViewFinanceVoucher "+SecName));
 %>

</select>
</form>
</body>
</html>