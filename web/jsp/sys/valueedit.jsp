<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<jsp:useBean id="Format" scope="page" class="FormatData.FormatData"/>


<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<title>ҵ��ָ��</title>
</head>

<%@ page import="java.sql.*" %>
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="bBean" scope="page" class="ConnDatabase.SDatabase" />
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<body  oncontextmenu="return false">
<script language="JavaScript" src='../public_js/basal.js'></script>
<script language="JavaScript" src='../public_js/public.js'></script>
<script>
 function count1(){
   document.all.perarea.value=parseFloat(document.all.areavalue.value)/parseFloat(document.all.salercount.value);
 
 }
 //�������������
function inputformat(src,strCheck,e){
var whichcode=(window.Event)?e.which:e.keyCode;
if(whichcode==13)return true;
key=String.fromCharCode(whichcode);
if(strCheck.indexOf(key)==-1)return false;
}
function savevalue(){
		if (parseFloat(document.frm.perarea.value)+parseFloat(document.frm.plansumprice.value)+parseFloat(document.frm.planCount.value)<=0 ){
		 alert("���������ۼƻ�������ѡ��һ��");
		 
		 return false;
		}
		document.frm.action="valueaction.jsp?Operation=Modify";
		document.frm.submit();
}
</script>
<form name=frm method="post">

<%@ include file="../public_js/getByteOut.jsp"%>

<center>
<%
 
String loginID=(String)session.getAttribute("loginid");
if (loginID==null)loginID="";


String SQL="select * from CortrolMan WHERE SerialNo='"+loginID+"'";
 

String control="";
ResultSet qx=null;
try{
  qx = aBean.executeQuery ( SQL );
if (qx.next()){
  control=getbyte(qx.getString("job"));
}
qx.close();
}catch(Exception s){out.println(SQL+s.getMessage());out.close();}
 %>
<p align="center"><b><font class=FontColor size="3" ><b>�޸�ָ��</font></b></p>
<table BORDER=0 width="100%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#000000" class="tablefill">
<%String id=request.getParameter("id");
  String uptown="";
  %>
  <input type="hidden" name="ID" value="<%=id %>">
  
  <%
  SQL="select * from SalerValue where id="+id;
  qx = aBean.executeQuery ( SQL );
  if(qx.next()){
    String no=qx.getString("uptown");
   %>
  <tr>
    <td width="15%"  class=roomleft >&nbsp;¥�̣�</td>
    <td class=roomright >&nbsp;
	 <%String uptownstr="select name FROM crm_project where serialno='"+no+"'";
	   ResultSet temprs=bBean.executeQuery(uptownstr);
	   if(temprs.next())
	   {
	     uptown=getbyte(temprs.getString("name"));
	   } 
	   temprs.close(); 
	 out.print(uptown);%>
  </td>
 
    <td width="15%"  class=roomleft >&nbsp;�� �£�</td>  
    <td width="15%"   class=roomright>&nbsp;<%=qx.getInt("rentyear") %>��<%=qx.getInt("rentmonth") %>��</td>
    <td width="15%"  class=roomleft >&nbsp;����Ա��</td>
    <td width="15%"  class=roomright>&nbsp; <%=qx.getString("seller") %>
  </td></tr>
  <tr>
   

    <td width="15%"  class=roomleft >&nbsp;ָ�������</td>  
    <td width="15%"  class=roomright>&nbsp;<input type=text name=perarea onchange = "checkNaN(this);"  size=5 value="<%=qx.getFloat("perarea") %>" >M<sup>2</sup></td>
    <td width="15%"  class=roomleft >&nbsp;ָ���</td>  
    <td width="15%"  class=roomright>&nbsp;<input type=text name=plansumprice onchange = "checkNaN(this);"  size=5 value="<%=qx.getFloat("sale_money") %>" >��Ԫ</td>
 <td width="15%"  class=roomleft >&nbsp;ָ��������</td>  
    <td width="15%"  class=roomright>&nbsp;<input type=text name=planCount onchange = "checkNaN(this);"  size=5 value="<%=qx.getString("sale_num") %>" >��</td>

  </tr>
  
  </table>
 
  <p align=center>
    <input type="hidden" name="section" value="<%=no %>">
<input type=button name=save value="ȷ   ��" onclick="savevalue();">
<input type=reset name=del value="ȡ   ��" onclick="window.close();">
</p>
<%} %>
</center>
</form>
</body>

</html>
