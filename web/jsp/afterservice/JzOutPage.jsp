<%@ page contentType="text/html;charset=GBK" %>

<HTML>
<%@ include file="../public_js/checktime.jsp"%>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>�����Ǽ�</title>
</head>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
  <%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
  <jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
<%@ include file="../public_js/getByteOut.jsp"%>
<%String ContrctNo=request.getParameter("contract"); %>
<%
String OUTDATE=China.getParameter(request,"OUTDATE");
String HANDLE=China.getParameter(request,"HANDLE");
if (!HANDLE.equals("")&&!OUTDATE.equals("")){
try {
      String SQL="update appraisal set outdate='"+OUTDATE+"',handle1='"+HANDLE+"',state='2' where contractno in ("+ContrctNo+")";
			aBean.startTransaction();
			aBean.executeUpdate(SQL);
			aBean.executeUpdate("update order_contract set jzdate='"+OUTDATE+"' where code in ("+ContrctNo+")");
			 
		    %>
			<script>
			alert("�����Ǽ��ѳɹ�");
			opener.window.location.reload();
			close();
			</script>
			<%
			aBean.commit();
			aBean.endTransaction();


}catch(Exception ee) {
			aBean.rollback();

			out.print("��֤���ʧ��,�����Ի���ϵ����Ա");
		}
		
}

 %>
<body >
 <form method="POST" name=frm action="">
 <input type=hidden name=contract value="<%=ContrctNo %>">
 <center>
 <p><font class=FontColor size=3><b>�����Ǽ�</b></font></p>
  <table width="100%" border="0" cellpadding="3" cellspacing="1">
  <tr>
    <td width="40%">��������</td>
    <td width="60%">
    <input type="text" name="OUTDATE" size="20"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(OUTDATE);return false;" title="��ѡ������">
    
    </td>
  </tr>
  <tr>
    <td width="40%">��&nbsp;��&nbsp;��</td>
    <td width="60%">   <input type="text"  name="HANDLE" value="<%=(String)session.getAttribute("loginname") %>"> </td>
  </tr>
  
</table>
<input type=hidden name=check value=1>
 <p align="center"> 
         <input type=button value="�� ��" name="submit1" onclick="loca();">
            &nbsp;<input type=button value=" �� ��" onclick="window.close()">
          </P>

 </center>
  </form>
  <script>
  function chec(){
   if (document.frm.R1[0].checked)
   document.frm.check.value="1";
   else
   document.frm.check.value="2";
 
  }
  function Validate(aForm)
{ 

      if (document.frm.OUTDATE.value==""){
           alert("�������������");
           document.frm.OUTDATE.focus();
           return (false);
        }
		
    if (document.frm.HANDLE.value==""){
           alert("�����뾭����");
           document.frm.HANDLE.focus();
		   return (false);
	}	   
	
	 return (true);
  }	 
  function loca(){
	  if (Validate(document.frm)){
	 	 document.frm.action="JzOutPage.jsp";
		 document.frm.submit();
      }		
}
</script>
</body>

</html>
