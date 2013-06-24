<%@ page contentType="text/html;charset=GBK" %>
<%@ page import = "java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id = "Bean" scope = "page" class = "ConnDatabase.SDatabase" />
 <jsp:useBean id = "ViewBean" scope = "page" class = "ConnDatabase.SDatabase" />
  <%@ include file="../jsp/public_js/getByteOut.jsp"%>
 <%@ include file="../jsp/public_js/checktime.jsp"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>阅读邮件</title>
<LINK href="green.css" rel=stylesheet type=text/css>
<script language="javascript">

function change(nn,imgobj) {
if (document.images){
eval('document.images.'+nn+'.src="'+imgobj+'"');

}
}
 function delemail(){
  var aaa="";
  for (var aa=0;aaa<document.form1.fff.length();aa++){
   if (document.form1.fff[aa].checked)alert(document.form1.fff[aa].value);
  }

}
</script>
</head>

<body><form name=form1 method="post" >
<%@ include file="../jsp/public_js/countpagenum.jsp"%>
<table width="100%" cellspacing cellpadding  >
 
  <tr>
    <td width="100%" height="27" style="background-image: url('images/yellowwg/maildi.gif'); background-repeat: repeat-x" align="right" valign="top">
      <table width="235" cellspacing cellpadding>
<tr>
<!-- ddddddddddddd-->
<!-- 全部回复ddddddddddd-->

 <td width="8"></td>
 <td width="8"></td>
<td width="70">
<p 
onmouseout="change('img5','images/yellowwg/mm05.gif')" 
onmouseover="change('img5','images/yellowwg/mm05k.gif')"><a href="#" onclick="if (confirm('确认删除吗'))document.form1.submit();"><img border="0" src="images/yellowwg/mm05.gif" name=img5></a></td>
<td width="8"></td>
 <td width="8"></td>
     <td width="8"></td>
          <td width="70">
            <p 
      onmouseout="change('img6','images/yellowwg/mm06.gif')" 
      onmouseover="change('img6','images/yellowwg/mm06k.gif')"><a href="#"  onClick="window.close()"><img border="0" src="images/yellowwg/mm06.gif" name=img6></a></td>
          <td width="10"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr > 
    <td width="100%"   valign="top" align="center"> 
      <%
	
 
  String  [] ffs=request.getParameterValues("choos");
  String codes="";
 if (ffs!=null){
   for (int a=0;a<ffs.length;a++){
       if (codes.equals(""))  codes=getbyte1(ffs[a]);
	   else codes+=","+getbyte1(ffs[a]);
   }
   }

if (!codes.equals("")){
Bean.executeUpdate("delete imail_message  where id in ("+codes+")");
Bean.executeUpdate("delete oa_mail_state  where main_id in ("+codes+")");
}
String sql="";
String mailchoose=getbyte1(request.getParameter("mailchoose"));
if (mailchoose.equals(""))mailchoose="1";
String user=" jsuser like '%"+(String)session.getAttribute("loginid")+"%' ";
if (mailchoose.equals("2")){user=" fuserid='"+(String)session.getAttribute("loginid")+"' ";
 
   sql="select Top "+pageSize+"   * from  imail_message where "+user+"  and  id  not in (Select top "+prenum +" id from  imail_message   where  "+user+" order by date desc )  order by date desc" ;
  sqlcount="SELECT count(id) code from imail_message  where  "+user;
 }else{
 sql="select Top "+pageSize+"  * from  imail_message where "+user+"  and  id  not in (Select top "+prenum +" id from  imail_message   where  "+user+" order by date desc )  order by date desc" ;
  sqlcount="SELECT count(id) code from imail_message  where  "+user;
 
 }
  
 
ResultSet rs=null;
 
rs=Bean.executeQuery(sql);
%>

     <select name=mailchoose onchange="document.form1.submit();"><option value=1 <% if (mailchoose.equals("1")){out.print("selected");}%>>显示收件箱信息</option><option value=2 <% if (mailchoose.equals("2")){out.print("selected");}%>>显示发件箱信息</option</select>
      <table width="100%" cellspacing="1" cellpadding=1 align="center" border="0">
        <tr class="bgcolor4"> 
          <td width="20%" align="center"><font color="#FFFFFF"><%if (mailchoose.equals("2")) {%>收件人<%}else{  %>发件人<%} %></font></td>
         <td width="60%" align="center"><font color="#FFFFFF">标题</font></td>
		 <td width="20%" align="center"><font color="#FFFFFF">时间</font></td>
        </tr>
        <%while (rs.next()) {%>
        <tr class="bgcolor2"  > 
          <td width=20%" align="center"><input type="checkbox" name="choos" value="<%=rs.getInt("id") %>"><font color="#FFFFFF"><%=rs.getString("fuserid") %></font></td>
          <td width="60%">&nbsp;<font color="#FFFFFF"><a href="#" onClick="window.open('../imail/rev.jsp?id=<%=rs.getInt("id")%>','1','menubar=no,scrollbars=yes,resizable=yes,width=690,height=542,left=200,top=100');" title="邮件主题:<%=rs.getString("subject")%>"><%=rs.getString("subject")%></a></font></td>
          <td width="20%">&nbsp;<font color="#FFFFFF"><%=rs.getString("date").substring(0,16)%></font></td>
        </tr>
         <%}rs.close();%>
     
      </table>
	 </td>
	 </tr>
	 </table>
	 
	      <%@ include file="../jsp/public_js/changepage.jsp"%>
		 