<%@ page contentType="text/html;charset=GBK" import="java.sql.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/> 
<jsp:useBean id="fBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="f2Bean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/getByteOut.jsp"%>
 <%@ include file="../public_js/checktime.jsp"%>
<%!
public String formatDateTime( java.sql.Timestamp dt , int flag ) throws Exception {
    java.text.SimpleDateFormat f = new java.text.SimpleDateFormat( "yyyy-MM-dd" ) ;
    return f.format( dt ) ;
}
public String formatDateTime( java.util.Date dt , int flag ) throws Exception {
    java.text.SimpleDateFormat f = new java.text.SimpleDateFormat( "yyyy-MM-dd" ) ;
    return f.format( dt ) ;
}
%>

<%
String ref_id = request.getParameter( "ref_id" ) ;
ref_id = "-1000" ;
String sq =  " select a.* , b.* "
		   + " from tb_chengyi a left join customer b"
		   + " on a.serialNo = b.serialNo "
           + " where a.serialNo = '" + ref_id + "' "
	       + " order by dengji_riqi desc" ;

String seri = "" ;
String in1 = "" ;
String in2 = "" ;
String in3 = "" ;
String in4 = "" ;
String in5 = "" ;
String in6 = "" ;
String in7 = "" ;
String in8 = "" ;
String in9 = "" ;
String in10 = "" ;
String in11 = "" ;
String in12 = "" ;
String in13 = "" ;
String in14 = "" ;
int in15 = 0 ;
String in16 = "" ;
String in17 = "" ;
String in18 = "" ;
String in19 = "" ;

ResultSet rs = fBean.executeQuery( sq ) ;
if( rs.next() ) {
    seri = rs.getString( 1 ) ;
    in1 = getbyte( rs.getString( "Cus_Name" ) ) ;
    in2 = getbyte( rs.getString( "Cus_Sex" ) ) ;
    in3 = getbyte( rs.getString( "cus_age" ) ) ;
    in4 = getbyte( rs.getString( "ID_Card" ) ) ;
    in5 = getbyte( rs.getString( "Phone" ) ) ;
    in6 = getbyte( rs.getString( "sj" ) ) ;
    in7 = getbyte( rs.getString( "address" ) ) ;
    in8 = getbyte( rs.getString( "Zip_Code" ) ) ;
    in9 = getbyte( rs.getString( "demand" ) ) ;
    in10 = getbyte( rs.getString( "yixianmianji" ) ) ;
    in11 = getbyte( rs.getString( "Knowledge_From" ) ) ;
    in12 = getbyte( rs.getString( "payment" ) ) ;
    in13 = formatDateTime( rs.getTimestamp( "dengji_riqi" ) , 0 ) ;
    in14 = formatDateTime( rs.getTimestamp( "shixiao_riqi" ) , 0 ) ;
    in15 = rs.getInt( "jinger" ) ;
    in16 = getbyte( rs.getString( "shaojuhaoma" ) ) ;
    in18 = getbyte( rs.getString( "dengjiren" ) ) ;
    in19 = getbyte( rs.getString( "beizhu" ) ) ;
}
rs.close() ;

String yixiang = "" ;
String sq2="";
ResultSet rsy =null;
String StrSql="select type,codename from CODE order by type";
ResultSet codeRS=null;
String CodeName[]=new String[200];
String CodeType[]=new String[200];
codeRS=ViewBean.executeQuery(StrSql);
int i=0;
while (codeRS.next()){
    CodeType[i]=getbyte(codeRS.getString("type"));
    CodeName[i]=getbyte(codeRS.getString("codename"));
    i++;
}
codeRS.close();
 %>

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
<input type=hidden name=ref_id value="<%= ref_id%>" >
<div id="xq" style="position:absolute; left:195px; top:170px; width:30px; height:30px; z-index:1; visibility: hidden"> 
<select  name="xq1" multiple size=10 onchange="sele(document.form1.in9,document.form1.xq1,'xq',sh3);choose1(document.form1.in9);" >
 <%
   for (int ii=0;ii<200;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("A"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 
</div>

<div id="tj2" style="position:absolute; left:195px; top:180px; width:30px; height:30px; z-index:1; visibility: hidden"> 
<select  name="tj1" multiple size=10 onchange="sele(document.form1.in11,document.form1.tj1,'tj2',sh3);">
 <%
   for (int ii=0;ii<200;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("E"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %>
 </select> 
</div>

<div id="jt2" style="position:absolute; left:380px; top:180px; width:30px; height:30px; z-index:1; visibility: hidden"> 
<select  name="jt1" multiple size=10 onchange="sele(document.form1.in12,document.form1.jt1,'jt2',sh3);">
  <option >按揭付款</option>
   <option >分期付款</option>
   <option >一次性付款</option>
 </select> 
</div>

<p align="center"><b><font class=FontColor size="3" ><b>诚意查询</font></b></p>

<center>
<table border="0" cellspacing="1" width="95%" cellpadding="0" class="tablefill">
     <tr>
      <td width="50%" align="left" class=roomleft>VIP卡号</td>
      <td width="50%" class=roomright><input type=text name=vipno size=16  ></td>
    </tr>
	<tr>
      <td width="50%" align="left" class=roomleft>客户姓名</td>
      <td width="50%" class=roomright><input type=text name=cusName size=16 value="<%= in1 %>" ></td>
    </tr>
    <tr>
      <td width="50%" align="left" class=roomleft>联系电话</td>
      <td width="50%" class=roomright ><input type=text name=cusPhone size=16 value="<%= in5 %>"></td>
    </tr>
    <tr>
      <td width="50%" align="left" class=roomleft >登记日期</td>
      <td width="50%" class=roomright >
从<input type=text name=dengyi1 size=11 value="<%= in13 %>" readonly><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(dengyi1);return false;" >
<br>到<input type=text name=dengyi2 size=11 value="<%= in13 %>" readonly><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(dengyi2);return false;" ></td>
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
