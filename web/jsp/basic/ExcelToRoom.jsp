<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*,common.*,java.util.*" %> 
<jsp:useBean id="InsertBean" scope="page" class="ConnDatabase.SDatabase"/> 
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
 <%
String sql="select payment,convert(varchar(10),date,120) date,state,checkstate from  试算价目表 where paymenttype=0 and  sectionno='"+getbyte1(request.getParameter("SecNo"))+"' and loft='"+getbyte1(request.getParameter("Loft"))+"' group by convert(varchar(10),date,120),payment,state,checkstate order by date";
 
	ResultSet rs = InsertBean.executeQuery(sql) ;
	 out.print("<script>");
     out.print("var payment=new Array();");
     int pay_no=0;
     while (rs.next()) {
       out.print("payment["+String.valueOf(pay_no)+"]="+"\""+getbyte(rs.getString("payment"))+"\""+";");
	   pay_no++;
      }	 
     rs.close();
     out.print("</script>");
	 InsertBean.closeConn();
 %>
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
          &nbsp;重复导入时更新面积<input name="check" type="checkbox" value="1">
        </td>
	  </tr> 
	   <tr>
    
         <td  width="30%" colspan="2" class=roomright   align="left" height="31"> 
          &nbsp;保存原价格<input name="saleoldprice" type="checkbox" value="1">&nbsp;名称<input type=text size=17 name="oldprice" onblur="checkedPaymentNoExist();" >
        </td>
	  </tr> 
	    <tr>
    
         <td  width="30%" colspan="2"    align="left" height="31"> 
          &nbsp;注意导入格式(标题必须取消),<a href="room_price.exe" ><b>下载后查阅</b></a>
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
		
	function checkedPaymentNoExist(){
    if (document.cus.oldprice.value=="")return false;
    for (var i=0;i<payment.length;i++){
	    if (document.cus.oldprice.value==payment[i]){
		 alert("此方案名称已经使用");
		 document.cus.oldprice.focus();
		 return false;
		}
	}
 }
		</script>
</form>     
       
       
       
</body>       
</html>       
