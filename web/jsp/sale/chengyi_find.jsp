<%@ page contentType="text/html;charset=GBK" import="java.sql.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="f2Bean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/getByteOut.jsp"%>
 
 <%@ include file="../public_js/checktime.jsp"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>诚意查询</title>
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script Language="JavaScript" src="../public_js/basal.js"></script>
</head>

<body>
<form name="form1" method="post">
 
 
<p align="center"><b><font class=FontColor size="3" ><b>诚意查询</font></b></p>

<center>
<table border="0" cellspacing="1" width="95%" cellpadding="0" class="tablefill">
     <tr>
      <td width="50%" align="left" class=roomleft>VIP卡号</td>
      <td width="50%" class=roomright><input type=text name=vipno size=16  ></td>
    </tr>
	<tr>
      <td width="50%" align="left" class=roomleft>客户姓名</td>
      <td width="50%" class=roomright><input type=text name=cusName size=16 value="" ></td>
    </tr>
    <tr>
      <td width="50%" align="left" class=roomleft>联系电话</td>
      <td width="50%" class=roomright ><input type=text name=cusPhone size=16 value=""></td>
    </tr>
    <tr>
      <td width="50%" align="left" class=roomleft >登记日期</td>
      <td width="50%" class=roomright >
从<input type=text name=dengyi1 size=11 value="" readonly><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(dengyi1);return false;" >
<br>到<input type=text name=dengyi2 size=11 value="" readonly><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(dengyi2);return false;" ></td>
    </tr>
	 
</table>
</center>

<p align="center">
 <input type=button name=b1 value=" 查询 " onclick="findcy()">
 <input type=button name=b2 value=" 关闭 " onclick="javascript:window.close()">    
</p>

<script lang=javascript>
function checkValue()
{
	if( document.forms[ 0 ].in15.value == "" || isNaN( document.forms[ 0 ].in15.value ) ) {
		alert( "请输入有效值 ! " ) ;
		document.forms[ 0 ].in15.focus() ;
		return false ;
	}
	if( document.forms[ 0 ].in17.value == "" ) {
		alert( "请选择意向单位 ! " ) ;
		document.forms[ 0 ].in17.focus() ;
		return false ;
	}
	return true ;
}

function findcy()
{
    var cusName = document.form1.cusName.value ;
    var cusPhone = document.form1.cusPhone.value ;
    var dengyi1 = document.form1.dengyi1.value ;
    var dengyi2 = document.form1.dengyi2.value ;
 var vipno = document.form1.vipno.value ;
 
 
    window.opener.document.form1.cusName.value = cusName ;
    opener.document.form1.cusPhone.value = cusPhone ;
    opener.document.form1.dengyi1.value = dengyi1 ;
    opener.document.form1.dengyi2.value = dengyi2 ;
    opener.document.form1.vipno.value = vipno ;

    opener.form1.action = "chengyi_index.jsp" ;
    opener.form1.submit() ;
    close() ;
}

function xuanzhe_dangwei()
{
    var spa = 60 ;
    var hei = window.screen.availHeight - spa ;
    var wid = window.screen.availWidth - spa ;
    var tp = spa / 2 ;
    var lef = spa / 2 ;
    var posi = "" ;
    var posi = posi + "top=" + tp ;
    var posi = posi + ",left=" + lef ;
    var posi = posi + ",height=" + hei ;
    var posi = posi + ",width=" + wid ;
    
    var newwin2 = window.open( "chengyi_danwei.jsp","NewsWin","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no," + posi );
    newwin2.focus();	
}

function qingkong_dangwei()
{
    document.forms[ 0 ].in17.value = "" ;
}

var atten="";
function choose(para){    
   atten=para.value;   
}

function choose1(para){
    if (atten!=""){
       if (confirm("已经选择了一个，是否要多选？"))para.value=para.value+","+atten;
    }
}
</script>
</form>
</body>
</html>
