<%@ page contentType="text/html;charset=GBK" %>
   <%@ include file="jsp/public_js/checktime.jsp"%>
<html>
<head>
<LINK href="jsp/class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<base target="_self">
	<title>系统提醒</title>
</head>
<body  >
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 
 <table BORDER=0 width="90%" CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#000000" class="tablefill">
   <tr><td>U客软件提醒您:</td></tr>
	  <tr><td>本系统安装即日起30天(试用版只有7天)之内如果还没有得到软件提供商的
远程进行身份确认，系统将停止运行!</td></tr>
	 <tr><td> 必须填写正确的注册资料，否则会影响系统的数据运行。  </td></tr>
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
 
  if (document.frm.companyname.value===""){alert("请录入公司名称");return false;}
   if (document.frm.companytel.value==""){alert("请录入公司电话名称");return false;}
   if (document.frm.companyfax.value==""){alert("请录入公司传真名称");return false;}
    if (document.frm.companyaddr.value==""){alert("请录入公司地址名称");return false;}
    if (document.frm.companyman.value==""){alert("请录入公司法人代表名称");return false;}
    if (document.frm.phone.value==""){alert("请录入服务联系电话");return false;}
	 if (document.frm.person.value==""){alert("请录入服务联系人");return false;}
	 
	 if (document.frm.saleperson.value==""){alert("请录入软件提供商");return false;}
	 
	 if (document.frm.saleurl.value==""){alert("请录入开发商网站");return false;}
   document.frm.submit();
 }
  function window_onunload()
  {  
    if (document.frm.companyname.value===""){alert("请录入公司名称");return false;}
   if (document.frm.companytel.value==""){alert("请录入公司电话名称");return false;}
   if (document.frm.companyfax.value==""){alert("请录入公司传真名称");return false;}
    if (document.frm.companyaddr.value==""){alert("请录入公司地址名称");return false;}
    if (document.frm.companyman.value==""){alert("请录入公司法人代表名称");return false;}
   if (document.frm.phone.value==""){alert("请录入服务联系电话");return false;}
	 if (document.frm.person.value==""){alert("请录入服务联系人");return false;}
	 
	 if (document.frm.saleperson.value==""){alert("请录入软件提供商");return false;}
	 
	 if (document.frm.saleurl.value==""){alert("请录入开发商网站");return false;}
  
  }
</script>

 
</body>
</html>
