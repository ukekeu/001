<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/news.css" rel=stylesheet>

<title>�������</title>
<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/checktime.jsp"%>
</head>
<SCRIPT language=javascript>
     function Validate(aForm)
   {

		if (aForm.Section.value.length<1)
	    	{
	    	alert("������¥�����ƣ�");
	        aForm.Section.focus();
	        return (false);
	    	}	
		if (aForm.Building.value.length<1)
		{
	        alert("�����붰�ţ�");
	        aForm.Building.focus();
	        return false;
		}
		return (true);
   }   
   function toUpper(aa){
    var a=aa.value;
    aa.value=a.toUpperCase();
  }
   function setfocus()
   {
   		cus.Section.focus();
   }

</SCRIPT>
<%
  String para=request.getParameter("para");
  String Mess="";
  String actionFrm="";
  if (para!=null){
   if (para.equals("dj")){
     Mess="��ѡ�㶨�۵�¥�̡����ż����ڵ�����";actionFrm="RoomDjShow.jsp";}
   else  if (para.equals("tj")){
     Mess="��ѡ����۵�¥�̡����ż����ڵ�����";actionFrm="RoomTjShow.jsp";
  }else if (para.equals("pricedz")){
   Mess="��ѡ��鿴��¥�̡����ż����ڵ�����";actionFrm="RoomPriceShow.jsp";
  }
}else{Mess="��ѡ��鿴��¥�̡����ż����ڵ�����";actionFrm="RoomCodeShow.jsp";}

 %>
<body onload="setfocus()" onLoad="chgCol()">
<form method="POST" name="cus" action="RoomCodeShow.jsp?find=find" onsubmit="return Validate(this);">
  <P>
   <p align="center"><b><font size="3" color="#000080"><%=Mess%></font></b><p>
	<p>
	<table class=parent id=KB3Parent border="0" width="50%" style="border-style: solid; border-width: 1" align="center" height="70">
      <tr style="border-style: solid; border-width: 1"> 
        <td width="16%" style="border-right-style: solid; border-right-width: 1; border-bottom-style: solid; border-bottom-width: 1" align="left" height="23">������:</td>
        <td width="57%" style="border-right-style: solid; border-right-width: 1; border-bottom-style: solid; border-bottom-width: 1" align="left" height="23"> 
          <select name="Region" style="border-style: solid; border-width: 1">
           <%
 String StrSql="select type,codename from CODE where Type='K' order by type";
   ResultSet codeRS=null;
   String CodeName[]=new String[200];
   String CodeType[]=new String[200];
    codeRS=ViewBean.executeQuery(StrSql);
   int i=0;
   while (codeRS.next()){
     CodeType[i]=codeRS.getString("type");
     CodeName[i]=getbyte(codeRS.getString("codename"));
	 i++;
   }
   codeRS.close();
 %>
<%
   for (int ii=0;ii<20;ii++){
		  if (CodeType[ii]!=null){
		   if (CodeType[ii].equals("K"))
	       out.print("<option>"+CodeName[ii]+"</option>");
		  }
       }
  %>
          </select>
        </td>
      </tr>
	  	  <%@ include file="../public_js/selectSRB1.jsp"%>
      <tr> 
        <td width="73%" style="border-right-style: solid; border-right-width: 1" align="left" height="2" colspan="2"> 
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
          <div align="center"> 
            <input type="submit" value="�ᡡ��" name="submit">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <input type="reset" value="ȡ  ��" name="reset">
          </div>
        </td>
    </table>     
     
</form>     
       
</body>       
</html>       
