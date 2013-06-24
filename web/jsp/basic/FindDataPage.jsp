<%@ page contentType="text/html;charset=GBK" %>
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>房间资料查询</title>
<script language="javascript" src="../public_js/public.js">
</script>
</head>
<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
<body onload="document.cus.RoomCode.focus();">

<%@ include file="../public_js/CodeSele.jsp"%>
<form method="POST" name="cus" action="SectionPicInsert.jsp"  ENCTYPE="multipart/form-data">
  <p align="center"><b><font size="3" class=FontColor>选择查询条件</font></b></p>
  <input type=hidden name=sel>
  <%//String SectionS=(String)session.getAttribute("Section"); %>
<table BORDER=0 width="100%" CELLSPACING=1 CELLPADDING=1 ALIGN=center >
     
	  <tr> <td width="30%"  class=roomleft>
	 &nbsp;房&nbsp;间&nbsp;号</td><td  class=roomright>&nbsp;<input type=text name=RoomCode size="12" onkeydown="key(document.cus.Floor)">
	 </td></tr>
 	  <tr> <td width="30%"  class=roomleft >
    	&nbsp;楼&nbsp;&nbsp;&nbsp;&nbsp;层</td><td  class=roomright>&nbsp;<input type=text name=Floor size="12" onkeydown="key(document.cus.RoomType)">
		</td></tr>
	<tr> <td width="30%"  class=roomleft >
    	&nbsp;户&nbsp;&nbsp;&nbsp;&nbsp;型</td><td  class=roomright>&nbsp;<select name="RoomType">
		   <option></option>
		    <%
   for (int ii=0;ii<20;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("A"))
	       out.print("<option value="+CodeName[ii]+">"+CodeName[ii]+"</option>");
		  }
       }
  %></select>
		
		</td></tr>	
	<tr> <td width="30%"  class=roomleft >
    	&nbsp;建筑面积</td><td  class=roomright>&nbsp;<input type=text name=JZAREA size="12" onkeydown="key(document.cus.unitprice)">
		</td></tr>	
    <tr> <td width="30%"  class=roomleft >
    	&nbsp;建筑单价</td><td  class=roomright>&nbsp;<input type=text name=unitprice size="12" onkeydown="key(document.cus.CX)">
		</td></tr>	
	<tr> <td width="30%"  class=roomleft >
    	&nbsp;朝&nbsp;&nbsp;&nbsp;&nbsp;向</td><td  class=roomright>&nbsp;<select name="CX">
				   <option></option>
		  <%
   for (int ii=0;ii<20;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("D"))
	       out.print("<option value="+CodeName[ii]+">"+CodeName[ii]+"</option>");
		  }
       }
  %></select> 
	
		</td></tr>		
  </table>					
        <p align="center"> 
            &nbsp;&nbsp; 
			 <input type="BUTTON" value="提 交" name="submit" onclick="ChooseFind();">

           &nbsp;&nbsp;
		    <input type="BUTTON" value="退 出" name="submit" onclick="window.close()">
                </P>
    <script>
	 function ChooseFind(){
	 

	   if (document.cus.unitprice.value!="")
		opener.document.cus.unitprice.value=document.cus.unitprice.value;
	   if (document.cus.CX.value!="")
		opener.document.cus.CX.value=document.cus.CX.value;
	   if (document.cus.JZAREA.value!="")
		opener.document.cus.JZAREA.value=document.cus.JZAREA.value;
	   if (document.cus.RoomType.value!="")
		opener.document.cus.RoomType.value=document.cus.RoomType.value;
		
		if (document.cus.RoomCode.value!="")
		opener.document.cus.RoomCode.value=document.cus.RoomCode.value;
		if (document.cus.Floor.value!="")
		opener.document.cus.Floor.value=document.cus.Floor.value;
		opener.document.cus.submit();
		
		close();
	 }
	</script>
</form> 
</body>       
</html>       
