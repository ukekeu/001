<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
   
<%@ include file="../public_js/qx_checke.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>�Ǽǿͻ����ټ�¼</title>
</head>


<script language="javascript" src="../public_js/public.js"></script>
 <script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>

<script>
function FindOption(){
var str="";
/*for (var i=0;i<document.feedback.CusNo.length;i++){
     str=document.feedback.CusNo.options[i].text;
	   if (str.indexOf(document.feedback.FindName.value)>=0){
           setSelectMad(document.feedback.CusNo,document.feedback.CusNo.options[i].value);
   	     break;
       }else{*/
	   openwin1("../sale/newcustomer.jsp?section="+document.cus.section.value+"&FindCus="+document.cus.FindName.value,350,380,300,100);
	//   }
	//}
}
</script>	
 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/getByteOut.jsp"%>

<%String StrCusNo=request.getParameter("cusno");//���Ϳͻ����
 if (StrCusNo==null)StrCusNo="";
 String SectionS=(String)session.getAttribute("Section");						
 String sql2="select SerialNo,Name FROM crm_project where SerialNo in("+SectionS+")";
      ResultSet rs2=ViewBean.executeQuery(sql2);
	  String sec="";
	  String no="";
%>
<script>
function check(aForm){
   if (aForm.fc.value.length<1)
	  	{
	   	alert("��������ټ�¼��");
	     aForm.fc.focus();
	     return (false);
	   }	
 /*if (aForm.fw.value.length<1)
	  	{
	   	alert("������ͻ��ڷ�����ķ�����Ϣ��");
	     aForm.fw.focus();
	     return (false);
	   }		 
 if (aForm.pay.value.length<1)
	  	{
	   	alert("������ͻ��ڸ����ķ�����Ϣ��");
	     aForm.pay.focus();
	     return (false);
	   }		
 if (aForm.year.value.length<1)
	  	{
	   	alert("����������ڣ�");
	     aForm.year.focus();
	     return (false);
	   }	*/	   	     
 return (true);
}
</script>
<body onload=" setSelectMad(document.cus.seller,'<%=(String)session.getAttribute("loginname")%>');"> 
<p align=center><font size=3 class=FontColor><b>�Ǽǿͻ����ټ�¼</b></font></p>
<form method="POST" name="cus" action="InsertCusTail.jsp?cusno=<%=StrCusNo %>" onsubmit="return check(this);">
<table width="100%" border="0" cellspacing="1"  cellpadding="1" >
 
  <tr>
    <td width="76" class=roomleft >&nbsp;���ټ�¼</td>
    <td width="490" class=roomright><textarea rows="5" name="fc" cols="54"></textarea>��</td>
  </tr>
  <!--
  <tr>
    <td width="76" class=roomleft >&nbsp;���׷���</td>
    <td width="490" class=roomright><textarea rows="3" name="pt" cols="54"></textarea>��</td>
  </tr>
  <tr>
    <td width="76" class=roomleft >&nbsp;������</td>
    <td width="490" class=roomright><textarea rows="3"  name="fw" cols="54"></textarea>��</td>
  </tr>
  <tr>
    <td width="76" class=roomleft >&nbsp;�����</td>
    <td width="490" class=roomright><textarea rows="3" name="pay" cols="54"></textarea>��</td>
  </tr>
  <tr>
    <td width="76"class=roomleft >&nbsp;��������</td>
    <td width="490"class=roomright><textarea rows="3" name="other" cols="54"></textarea>��</td>
  </tr>
  -->
  <tr>
    <td width="76"class=roomleft>&nbsp;ҵ&nbsp;��&nbsp;Ա</td>
    <td width="490"class=roomright>
      <table border="0" width="100%">
        <tr>
          <td width="10%"class=roomright> <select size="1" name="seller">          
      <%
	  String sql="select * from CortrolMan";
	  ResultSet rs=ViewBean.executeQuery(sql);
      String Seller="";
	  while(rs.next()){
	  Seller=getbyte(rs.getString("name"));        
	  %>        
        <option  value="<%=Seller%>"><%=Seller%></option>        
	  <%}        
	  rs.close(); %>               
      </select></td>
          <td width="10%"class=roomleft >&nbsp;��������</td>
          <td width="40%"class=roomright><input type=text size="12" name="year"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(year);return false">       
       </td>   
          
		  <input type=hidden name="yn">
		  
        </tr>
      </table>
    </td>
  </tr>
</table>
<p>
<div align="center"> 
 <%
 
String Cortrol=checke_qx(ViewBean,(String)session.getAttribute("loginid"),"C002");
   if (Cortrol==null)Cortrol="";
     %>
	  <%if (Cortrol.indexOf("A")>=0){ %>
            <input type="submit" value="�ᡡ��" name="submit" >
			<%} %>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="button" value="��  ��" name="cancel" onclick="window.close();">
          </div>
</p>
  </form>    
  <p align="center">���ټ�¼</p>
  <table height=16  width="100%" border=1 cellspacing='0'  cellpadding='0' bgcolor=ffffff bordercolordark=ffffff bordercolorlight=000000>
<tr><td height=16  width="10%">&nbsp;��������</td><td height=16  width="20%">��������</td><td height=16  width="10%">������</td></tr>

<%
String SQL="SELECT date,fc,seller FROM tail_after WHERE cusno='"+StrCusNo+"'";
 rs2=ViewBean.executeQuery(SQL);
while (rs2.next()){
%>
<tr><td height=16  width="20%">&nbsp;<%=rs2.getDate("date").toString() %></td><td height=16  width="20%"><%=getbyte(rs2.getString("fc")) %></td><td height=16  width="20%"><%=getbyte(rs2.getString("seller")) %></td></tr>

<%
}
rs2.close();

 %>     
</body>

</html>
