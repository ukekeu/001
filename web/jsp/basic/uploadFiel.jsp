<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>��������</title>
<%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
 

<body > 
<form method="POST" name="cus" action=""  ENCTYPE="multipart/form-data"> <!--//����������-->
<p align=center><font size=3 class=FontColor><B>��������</b></font></p>
<table width="100%" border="0" cellspacing="1"   cellpadding="1" >
      
    
        <td  width="30%" class=roomleft  align="left" height="31" bgcolor="#CFE6EB">&nbsp;ƽ&nbsp;��&nbsp;ͼ</td>
        <td  width="30%" class=roomright   align="left" height="31"> 
          &nbsp;<input type="file" name="Map" size="10" >
        </td>
	  </tr><input type="hidden"  name="YN"  value="T"  >
 
       
	  </table>
	   
    <p align="center"> 
           	 
  
			<input type="Button" name="saveRoom" value="�� ��" onclick="loca();">
		  
		
           &nbsp;&nbsp;
		   <input type="Button" name="saveRoom" value="�� ��" onclick="window.close();"> &nbsp;&nbsp;
		   <input type="Button" name="saveRoom" value="�� ӡ" onclick="window.print();">

          </P>
   <script>
		function loca(){
		  if (  document.cus.Date1.value==""){alert("��¥���ڲ���Ϊ��");return false;}
		  document.cus.ASumPrice.value=document.cus.SumPrice.value;//+Float.parseFloat(document.cus.lutai_unitprice.value)*Float.parseFloat(document.cus.lutai_area.value);
		  if (confirm("ȷ�ϵ�ǰ�����������")){
		  if (Validate(document.cus)){
		    document.cus.action="RoomInsert.jsp";
		    document.cus.submit();
          }		
		  }
		}
		</script>
</form>     
       
       
       
</body>       
</html>       
