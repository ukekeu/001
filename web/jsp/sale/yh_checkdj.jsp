<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
   <%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <%@ include file="../public_js/getByteOut.jsp"%>    
  <%@ include file="../public_js/logrecord.jsp" %>
<html>
<head>
<title>�Ż���˼�¼</title>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
</head>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<%
String codes=request.getParameter("codes");
String code=getbyte1(request.getParameter("code"));
if (!code.equals("")){
   String checkdate=getbyte1(request.getParameter("checkdate"));
   String checkperson=getbyte1(request.getParameter("checkperson"));
   String checknote=getbyte1(request.getParameter("checknote"));
     try{
		 aBean.executeUpdate("update  contract_disc set state=1,check_date='"+checkdate+"',checker='"+checkperson+"' where state=0 and    code in("+code+")");
	  
	  setlog( aBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "�Ż����" , 
                  "���(�Żݼ�¼ID��"+ codes+")"
                ) ;
	   }catch(Exception s){out.print(s);}
    %>
	   <script>alert("�Ѽ�¼����");opener.document.frm.submit();window.close();</script>
	   <%  

}

 %>
 <script>
  function checkdata(){
    if (document.frm.checkdate.value==""){alert("��ѡ������");return false;}
    if (document.frm.checkperson.value==""){alert("����д������");return false;}
  document.frm.submit();
  }
 function fulldate(){
	 var dateValue=new Date();
	 var year="";
	 var month="";
	 var day="";
	 if (dateValue.getMonth()+1>=10)month=dateValue.getMonth()+1;
	 else month="0"+(dateValue.getMonth()+1);
	 if (dateValue.getDate()+1>=10)day=dateValue.getDate();
	 else day="0"+(dateValue.getDate());
	 
	   document.frm.checkdate.value=dateValue.getYear()+"-"+month+"-"+day;
	}
 </script>
<body onload="fulldate();">
<form name=frm method="post">
<input type=hidden name=code value="<%=codes %>">
<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1  ALIGN=center  >
<tr  class=TXTColor> 
 
<td  align="center">��������</td>
<td  align="center">�����</td>
<td  align="center">������</td>
 </tr>
 <tr  class=listcontent > 
 
<td  align="center"><input type=text name=checkdate size=12><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(checkdate);return false;"></td>
<td  align="center"><input type=text name=checkperson size=12 value="<%=(String)session.getAttribute("loginname") %>"></td>
<td  align="center"><input type=text name=checknote ></td>
 </tr>
</table>
<p align="center"><input type=button name=tj value="�� ��" onclick="checkdata();">	&nbsp;<input type=button name=cl value="�� ��" onclick="window.close();">	
    </p>
	</form>
</body>
</html>
