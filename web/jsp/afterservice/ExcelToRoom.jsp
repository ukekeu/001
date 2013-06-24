<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
  <%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<link rel=stylesheet href="../class/mad.css" >
<title>从EXCEL中导入</title>
 

<body>
 
<form method="POST" name="cus" action=""  ENCTYPE="multipart/form-data">
<p align=center><font size=3 class=FontColor><B>请选择导入的EXCEL文件</b></font></p>
<table width="100%" border="0" cellspacing="1"   cellpadding="1" >
        <tr>
    
        <td  width="30%" class=roomleft  align="left" height="31" bgcolor="#CFE6EB">&nbsp;选择文件</td>
        <td  width="60%" class=roomright   align="left" height="31"> 
          &nbsp;<input type="file" name="Map" size="15" >
        </td>
	  </tr> 
	    <tr>
    
         <td  width="30%" colspan="2" class=roomright   align="left" height="31"> 
          &nbsp;注意导入格式(标题必须取消),<br>&nbsp;&nbsp;<a href="roomarea.exe" ><b>请下载后查阅</b></a>
        </td>
	  </tr> 
		</table>
		
		   <p align="center"> <input type="Button" name="saveRoom" value="提 交" onclick="loca();">
&nbsp;&nbsp; <input type="Button" name="saveRoom1" value="退 出" onclick="window.close();"> &nbsp;&nbsp;
		   
          </P>
   <script>
		function loca(){
		  	  if (confirm("确认当前要导入的文件吗？")){
			        document.cus.saveRoom.disabled=true;
		  		    document.cus.action="toRoom.jsp?SecNo=<%=getbyte1(request.getParameter("SecNo")) %>&Loft=<%=getbyte1(request.getParameter("Loft")) %>";
		            document.cus.submit();
          
		  }
		}
		</script>
</form>     
       
       
       
</body>       
</html>       
