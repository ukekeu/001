<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>ѡ�񷿼�</title>
</head>

<body >
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>
<SCRIPT language=javascript >
function openwin(url,wh,hg,lf,tp) {
  var newwin=window.open(url,"newwin","toolbar=no,location=no,directories=yes,status=yes,menubar=yes,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
  newwin.focus();
  return false;
}
</SCRIPT>
 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <%@ include file="../public_js/getByteOut.jsp"%>
<%
  String sql="";
  int id=0;
  String Payname="";
  String name=getbyte2(request.getParameter("secname"));
  String rooms=getbyte2(request.getParameter("rooms"));
  String secno=getbyte2(request.getParameter("secno"));
  String build=getbyte2(request.getParameter("build"));
  String loft=getbyte2(request.getParameter("loft"));
%>

<form name=frm method="post" action="rgdj.jsp?para=aa" >
  <input type="hidden" name="rooms" value="<%=rooms%>">
  <input type="hidden" name="secname" value="<%=name%>">
  <input type="hidden" name="secno" value="<%=secno%>">
  <input type="hidden" name="build" value="<%=build%>">  
  <input type="hidden" name="loft" value="<%=loft%>">  
 
<div align="center">
<p><font color="#0000CC"><b><font size="3" class=FontColor>ѡ�񷿼�</font></b></font></p></div>

<table border="0" width="100%"CELLSPACING=0 CELLPADDING=0 ALIGN=center bordercolor="#fffff" class="tablefill" >
  <tr>
    <td width="50%" class=roomleft>&nbsp;������:</td>
    <td width="50%" class=roomright ><select name="person">
		  <%
           String StrSql="select type,codename from CODE  WHERE TYPE='P' order by type";
            ResultSet codeRS=null;
		   codeRS=ViewBean.executeQuery(StrSql);
		   String codename="";
		   while (codeRS.next()){
		     codename=getbyte(codeRS.getString("codename"));
			  out.print("<option value='"+codename+"'>"+codename+"</option>");
		   }
		   codeRS.close();
		   %>
		  </select>  </td>
  </tr>
  <tr>
    <td width="50%" class=roomleft>&nbsp;��׼��:</td>
    <td width="50%" class=roomright><select name="checker"><%
 StrSql="select type,codename from CODE  WHERE TYPE='P' order by type";
            codeRS=null;
		   codeRS=ViewBean.executeQuery(StrSql);
		   codename="";
		   while (codeRS.next()){
		     codename=getbyte(codeRS.getString("codename"));
			  out.print("<option value='"+codename+"'>"+codename+"</option>");
		   }
		   codeRS.close();
		   %>
		  </select>  
</td>  
  </tr>
   <tr>
    <td width="50%" class=roomleft>&nbsp;Ԥ��:</td>
	<td width="50%" class=roomright>
	 <select name="yl">
	  <option value="4">Ԥ��</option>
	  <option value="1">ȡ��Ԥ��</option>
	 </select>
	</td>
  </tr>  
  <tr>
    <td width="50%" class=roomleft>&nbsp;��Ч����:</td>
    <td width="50%" class=roomright >
     <input type=text name="youxiao"  size="20" readonly >
     <input type=button name=cale value=".." onclick="fPopUpCalendarDlg(youxiao);return false;">
    </td>	  
  </tr>
 
  </table>
  <p align="center"> 
            &nbsp;&nbsp; <input type=button name=ss value=" �� �� " onclick="SaveCancel();" >
           &nbsp;&nbsp;
           <input type=button name=ss value=" �� �� "  onclick="window.close();">
          </P>

</form>
<SCRIPT language=javascript>
   function Validate(aForm)
   {
       if (aForm.person.value.length<1)
	    	{
	    	alert("�����뾭���ˣ�");
	        aForm.person.focus();
	        return (false);
	    	}	
		 if (aForm.checker.value.length<1)
	    	{
	    	alert("��������׼��");
	        aForm.comm.focus();
	        return (false);
	    	}			
	  return (true);
	}
	function SaveCancel(){
      if (Validate(document.frm)){
	   document.frm.action="SaveRoomYL.jsp";
	   document.frm.submit();
     }
    }	
   </script>		
</body>

</html>
