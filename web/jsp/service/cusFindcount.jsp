<%@ page contentType="text/html;charset=GBK" %>
 


 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>

<html>
<head> 
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>�ͻ�����</title>

</head>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>


 <script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script>
function fxType(para){
document.cus.ty.value=para;
 
}
function fx(){
 var choose=document.cus.photo.value;
 
 if (choose=="3")
  document.cus.action="customerFX.jsp";
 else if (choose=="2")
    document.cus.action="customerFX.jsp";
 else if (choose=="1")	
    document.cus.action="cusFx.jsp";
	
 document.cus.submit();
}
</script>
<body>

<!--DemandAnalysepic.jsp-->
<form name=cus method="post" action="" target="_blank"> 
 
<p align=center><font size=4 class=FontColor><b>ѡ��ͻ���������</b></font><p>

<table BORDER=0 width="50%" class=parent id=KB3Parent CELLSPACING=1 CELLPADDING=3 ALIGN=center style="table-layout:fixed;word-break:break-all">
  
		<tr><td class=roomleft  width="25%">
     		&nbsp;����ָ�꣺
		</td><td  class=roomright>
 
		&nbsp;<select  multiple size=8  name="fxzb" style="width : 104" onchange="fxType(this.text)" >
		 
 
        <option value=wenhua>ѧ��  </option> 
    
        <option value=job>ְҵ </option>   
	    <option  value=Sex>�Ա�</option>           
        <option  value=age>����</option>           
         
		<option  value=hy>����״��</option>
		<option  value=sr>������</option>
        <option  value=ah>����</option>
	 

      </select></td>  

</tr>
<tr><td class=roomleft>ͼ������</td><td class=roomright>&nbsp;<select name="photo"><option value=3>��ͼ</option><option value=2>ֱ����״ͼ</option><option value=1>����ֱ��ͼ</option></select></td></tr>
<tr><td class=roomleft>����Դ</td><td class=roomright>&nbsp;<select name="cus_state"><option value=3>���пͻ�</option><option value=2>�ɽ��ͻ�</option><option value=1>δ�ɽ��ͻ�</option></select></td></tr>
  </table>
 <input type=hidden name=ty >
  <p align=center>	<input type=button name="Count" value="�� ��" onclick="fx();">
<input type=button name="Count" value="�� ��">

	</p>  
  </form>


</body>

</html>
