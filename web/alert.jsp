<%@ page contentType="text/html;charset=GBK" %>
   <%@ include file="jsp/public_js/checktime.jsp"%>
<html>
<head>
<LINK href="jsp/class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<base target="_self">
	<title>ϵͳ����</title>
</head>
<body  >
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 
 <table BORDER=0 width="90%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#000000" class="tablefill">
   <tr><td>U�����������:</td></tr>
	  <tr><td>��ϵͳ��װ������30��(���ð�ֻ��7��)֮�������û�еõ�����ṩ�̵�
Զ�̽������ȷ�ϣ�ϵͳ��ֹͣ����!</td></tr>
	 <tr><td> ������д��ȷ��ע�����ϣ������Ӱ��ϵͳ���������С�  </td></tr>
	 </table>

<%@ page import="java.sql.*,common.*,ConnDatabase.MailHandler" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="checkreg" scope="page" class="regcheck.regcheck"/> 
<%@ include file="jsp/public_js/logrecord.jsp" %>
 
<script language="JavaScript" src='jsp/public_js/public.js'></script>

<%@ include file="jsp/public_js/getByteOut.jsp"%>
<%String SQL="";
  String companyname="";
  String companytel="";
  String companyaddr="";
  String companyman="";
  String companypost="";
  String companyfax="";
  String usernum="";
  String project="";
  String person="";
  String phone="";
  String saleurl="";
  String saleperson="";
  String softver="";
  String id="";
  String eof="false";
  String code="";
  String save=China.getParameter(request,"save");
  if (!save.equals("")){
     companyname=China.getParameter(request,"companyname");
     companytel=China.getParameter(request,"companytel");
     companyaddr=China.getParameter(request,"companyaddr");
     companyman=China.getParameter(request,"companyman");
	 companypost=China.getParameter(request,"post");
	 project=China.getParameter(request,"project");
	 usernum=China.getParameter(request,"usernum");
	 person=China.getParameter(request,"person");
	 phone=China.getParameter(request,"phone");
	 softver=China.getParameter(request,"softver");
	 saleurl=China.getParameter(request,"saleurl");
	 saleperson=China.getParameter(request,"saleperson");
	 code=China.getParameter(request,"code");
	 String name=( String )session.getAttribute( "loginname" );
 
	 out.print(checkreg.GetRegInfo(companyname,companytel,companyaddr,companyman,companypost,companytel,name,project,usernum));
	 aBean.executeUpdate("update user_reg set code='"+code+"',softver='"+softver+"',servicephone='"+phone+"',serviceperson='"+person+"',saleperson='"+saleperson+"',saleurl='"+saleurl+"'");
	 
  } 
  out.print(checkreg.reginfo());

 %>
</form>
<script>
 
 function save1(){
 
  if (document.frm.companyname.value===""){alert("��¼�빫˾����");return false;}
   if (document.frm.companytel.value==""){alert("��¼�빫˾�绰����");return false;}
   if (document.frm.companyfax.value==""){alert("��¼�빫˾��������");return false;}
    if (document.frm.companyaddr.value==""){alert("��¼�빫˾��ַ����");return false;}
    if (document.frm.companyman.value==""){alert("��¼�빫˾���˴�������");return false;}
    if (document.frm.phone.value==""){alert("��¼�������ϵ�绰");return false;}
	 if (document.frm.person.value==""){alert("��¼�������ϵ��");return false;}
	 
	 if (document.frm.saleperson.value==""){alert("��¼������ṩ��");return false;}
	 
	 if (document.frm.saleurl.value==""){alert("��¼�뿪������վ");return false;}
   document.frm.submit();
 }
  function window_onunload()
  {  
    if (document.frm.companyname.value===""){alert("��¼�빫˾����");return false;}
   if (document.frm.companytel.value==""){alert("��¼�빫˾�绰����");return false;}
   if (document.frm.companyfax.value==""){alert("��¼�빫˾��������");return false;}
    if (document.frm.companyaddr.value==""){alert("��¼�빫˾��ַ����");return false;}
    if (document.frm.companyman.value==""){alert("��¼�빫˾���˴�������");return false;}
   if (document.frm.phone.value==""){alert("��¼�������ϵ�绰");return false;}
	 if (document.frm.person.value==""){alert("��¼�������ϵ��");return false;}
	 
	 if (document.frm.saleperson.value==""){alert("��¼������ṩ��");return false;}
	 
	 if (document.frm.saleurl.value==""){alert("��¼�뿪������վ");return false;}
  
  }
</script>

 
</body>
</html>
