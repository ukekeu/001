<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>

 <%@ page language="java" import="java.sql.*,common.*" %>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/qx_checke.jsp"%>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<title>请输入楼栋资料</title>


</head>
<script language="javascript" src="../public_js/public.js">
</script>
<SCRIPT language=javascript>
     function Validate(aForm)
   {

		if (aForm.Name.value.length<1)
	    	{
	    	alert("请输入名称！");
	        aForm.Name.focus();
	        return (false);
	    	}	
		
		return (true);
   }   
   function toUpper(aa){
    var a=aa.value;
    aa.value=a.toUpperCase();
  }
   function setfocus()
   {
   		cus.Loft.focus();
   }
 
</SCRIPT>
<%
  String Para=China.getParameter(request,"Para");
  String Loft=China.getParameter(request,"Loft");
  String SecNo=China.getParameter(request,"SecNo");
  String Build=China.getParameter(request,"Build");
  String Submit=China.getParameter(request,"submit1");
  String Edit=China.getParameter(request,"Edit");
  String Title="";
  try{
    if (Loft==null)Loft="";
    else Title="请输入栋号/座号";
    if (SecNo==null)SecNo="";
	else Title="输入区号/阁名/期数";
  }catch(Exception s){}
  
String Cortrol= checke_qx(ViewBean,(String)session.getAttribute("loginid"),"B003");
 
 %>
<body class=listcontent oncontextmenu="return false"  >
<form method="POST" name="cus" action="SaveLoft.jsp" onsubmit="return Validate(this);" >
<input type=hidden name=SecNo value="<%=SecNo %>">
<input type=hidden name=Loft value="<%=Loft %>">
<input type=hidden name=Build value="<%=Build %>">
<input type=hidden name=Para value="<%=Para %>">
<input type=hidden name=Edit value="<%=Edit %>">
<p align=center>
<%if  (Cortrol.indexOf("A")>=0){ %>
<input type="button" name="add1" value="批量添加" onclick="AddData1()" <%if (!Edit.equals("")){out.print("disabled");} %>>&nbsp;<input type="button" name="add" value="单个添加" <%if (!Edit.equals("")){out.print("disabled");} %> onclick="AddData()"><%}  if (Cortrol.indexOf("E")>=0){  %>&nbsp;<input type="button" name="modi" value="修改" onclick="EditDate();" ><%}  if (Cortrol.indexOf("D")>=0){  %>&nbsp;<input type="button" name="modi" value="删除" onclick="DeleData();">
<%} %><%  if (!Submit.equals("")){ %>
<p align=center><font size=3><b><div id=title></div></b></font></p>
 <table class=parent id=KB3Parent border="0" width="100%"  align="center" height="70">
    <%if (!Edit.equals("")){ %>
	   
	   <%if (Para.equals("Build")){ %>
	   <tr><td>&nbsp;<div id=DIVNAME>原名称：</DIV></td><td>
	   <input type=text size=10 name=EditName readonly value="<%=Loft%>">
	    </td>
	   <%}else if (Para.equals("Room")){ %>
	   <tr><td>&nbsp;<div id=DIVNAME>原名称：</DIV></td><td>
	   <input type=text size=10 name=EditName readonly value="<%=Build%>">
	  </td></tr>
	   <%} %>
	  
	   
	<%} %>
	 <tr><td>&nbsp;<div id=DIVNAME>名&nbsp;&nbsp;称：</DIV></td><td><input type=text size=10 title="最多录入4个文字长度"  maxlength="10" name=Name OnChange="toUpper(document.cus.Name);"></td></tr>
     <tr><td colspan="2"> &nbsp;<div id=DIVNAME>说明：楼栋名称不要包括特殊的字符，<br>如:"-","#"等，一般用中文、字母或数字</td></tr>
    
	 <tr> 
        <td  align="center" height="2" colspan="2"> 
             <input type="submit" value="提交" name="submit1">&nbsp;
             <input type="reset" value="取消" name="reset" onclick="parent.TreeList.window.location='Tree.jsp?SecNo=<%=SecNo %>';window.location='AddLoft.jsp'">

        </td>
    </table>     
     
</form>  
<%}else{ %>   
<input type="hidden" value="提交" name="submit1">
<%} %>
  <script>     

    function AddData(){
	 var Num=parent.TreeList.document.cus.SecNo.length;
	 var j=0;
     var jj=0;
	 if (Num){
	  for (var i=0;i<Num;i++){
	 
	     if (parent.TreeList.document.cus.SecNo[i].checked){j++;jj++}
	  }
	  if (j>1){alert("只能选择一个对象操作");return false;}
	  else if (j==0){alert("请选择增加的对象");return false;}
	 }
	  
	    if (document.cus.Name){if (document.cus.Name.value!="")document.cus.Name.value=toUpper(document.cus.Name.value);}
		 document.cus.action="AddLoft.jsp";
	     document.cus.submit();
	  
   }
   function AddData1(){
	 var Num=parent.TreeList.document.cus.SecNo.length;
	 var j=0;
     var jj=0;
	 if (Num){
	  for (var i=0;i<Num;i++){
	 
	     if (parent.TreeList.document.cus.SecNo[i].checked){j++;jj++}
	  }
	  if (j>1){alert("只能选择一个对象操作");return false;}
	  else if (j==0){alert("请选择增加的对象");return false;}
	 }
	 
	 openwin1("AddLoft1.jsp?SecNo="+parent.Operation.document.cus.SecNo.value,450,100,100,100); 
	 }
   function DeleData(){
     var Num=parent.TreeList.document.cus.SecNo.length;
	 var j=0;
	 var jj=0;
	  for (var i=0;i<Num;i++){
	     if (parent.TreeList.document.cus.SecNo[i].checked){j++;jj=i;}
	  }
       if (j>0){
	     var checkStr=parent.TreeList.document.cus.SecNo[jj].value;
		
		 if (checkStr.substring(checkStr.indexOf("*")+1)!="Loft"){//不能删除楼盘名
	       if (confirm("请确认要删除所有选择的对象吗？")){
	         document.cus.action="SaveLoft.jsp?oper=delete";
	         document.cus.submit();
		  }
		 }else{alert("不能删除楼盘名");} 
	  }else if (j==0){
	   alert("请选择要删除的一个对象");
	  }
   
   }
  function EditDate(){
     var Num=parent.TreeList.document.cus.SecNo.length;
	 var j=0;
	 var jj=0;
     for (var i=0;i<Num;i++){
	     if (parent.TreeList.document.cus.SecNo[i].checked){j++;jj=i;}
	  }
	 if  (j==0){alert("请选择要修改的一个对象");}
	 else{
	   var checkStr=parent.TreeList.document.cus.SecNo[jj].value;
	 
	   if (checkStr.substring(checkStr.indexOf("*")+1)!="Loft"){//不能删除楼盘名
	      document.cus.action="AddLoft.jsp?Edit=edit";
	      document.cus.submit();
	   }else{alert("不能修改楼盘名称");} 
	  } 
  }
  
  </script>
</body>       
</html>       
