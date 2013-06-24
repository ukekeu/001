<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
 

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>选择付款方式</title>
</head>
<%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
  <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
<%@ include file="../public_js/CheckSection.jsp"%>
<%@ include file="../public_js/getByteOut.jsp"%>
<body >

<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script language="javascript" src="../public_js/public.js"></script>

<form name=cus method=POST ACTION="">
<p align=center><font class=FontColor><b>
选择付款方式:
    <%
	FindWhere=" where seccoe ='"+request.getParameter("SecNo")+"'";
	
	String sql="select * from PayMent  "+FindWhere+" order by PayName";

      ResultSet rs3=ViewBean.executeQuery(sql);
	  String pay="";
	  String dic="";
	  String dj="";
	  float dj1;
	  String num="";
	  String id="";
	  int i=0;
	  String type="";
	  String pay1="";
	  String prepay="";
 
  %>
  <table>
 <%while (rs3.next()){
        type="";
	    id=rs3.getString("ID");
		pay=getbyte(rs3.getString("PayName"));
		if (pay.indexOf("%")>=0)
		pay1=pay.substring(0,pay.indexOf("%"))+"成"+pay.substring(pay.indexOf("%")+1);
		else pay1=pay;
		num=rs3.getString("num");
	    dic=rs3.getString("Discont");
		prepay=rs3.getString("prepay");
		String dic1=String.valueOf(dic);
		type=rs3.getString("state");
		if(type.equals("1"))type="checked";
		if (i==0){
		  out.print("<tr>");
		 }
	     out.print("<td><input type='Checkbox' name=pay value='"+id+"' "+type+">"+pay+"*"+num+"*期</td>");
		 i++;
		 if (i==3)i=0;
		 if (i==0)out.print("</tr>");
	  }rs3.close();
     %></table>
	 <input type=hidden name=AjType value=0>
	 说明:选中的付款方式表示在选房计价中客户可以选择的付款方式
</b></font></p>
  <p align=center><input type=button name=submit1 value="提  交" onclick="SubCheck()">&nbsp;&nbsp;<input type=button name=close value="退  出"  onclick="window.close();">
</center>
</FORM>
<script>
function checkroom()
    {  var x=0;
       var seldocs = new Array();
       for(i=0;i<document.forms[0].elements.length;i++){
         if ((document.forms[0].elements[i].type=="checkbox")&&(document.forms[0].elements[i].checked))
		   {
       		seldocs [x]= ""+document.forms[0].elements[i].value+"";
			x++;
   		   }
        }
      return seldocs;	   
    }
 function SubCheck(){
      var FT="";
	  var paylist="";
      var paylist=checkroom();
    if (paylist=="")
    {alert("请选择付款方式");
	 return false;
	}
	//alert(paylist);
	document.forms[0].action="SavePayment.jsp?id="+paylist;
	document.forms[0].submit();
   }

</script>
</body>

</html>
