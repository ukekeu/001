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

<title>������¥������</title>


</head>
<script language="javascript" src="../public_js/public.js">
</script>
<SCRIPT language=javascript>
     function Validate(aForm)
   {

		if (aForm.Name.value.length<1)
	    	{
	    	alert("���������ƣ�");
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
    else Title="�����붰��/����";
    if (SecNo==null)SecNo="";
	else Title="��������/����/����";
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
<input type="button" name="add1" value="�������" onclick="AddData1()" <%if (!Edit.equals("")){out.print("disabled");} %>>&nbsp;<input type="button" name="add" value="�������" <%if (!Edit.equals("")){out.print("disabled");} %> onclick="AddData()"><%}  if (Cortrol.indexOf("E")>=0){  %>&nbsp;<input type="button" name="modi" value="�޸�" onclick="EditDate();" ><%}  if (Cortrol.indexOf("D")>=0){  %>&nbsp;<input type="button" name="modi" value="ɾ��" onclick="DeleData();">
<%} %><%  if (!Submit.equals("")){ %>
<p align=center><font size=3><b><div id=title></div></b></font></p>
 <table class=parent id=KB3Parent border="0" width="100%"  align="center" height="70">
    <%if (!Edit.equals("")){ %>
	   
	   <%if (Para.equals("Build")){ %>
	   <tr><td>&nbsp;<div id=DIVNAME>ԭ���ƣ�</DIV></td><td>
	   <input type=text size=10 name=EditName readonly value="<%=Loft%>">
	    </td>
	   <%}else if (Para.equals("Room")){ %>
	   <tr><td>&nbsp;<div id=DIVNAME>ԭ���ƣ�</DIV></td><td>
	   <input type=text size=10 name=EditName readonly value="<%=Build%>">
	  </td></tr>
	   <%} %>
	  
	   
	<%} %>
	 <tr><td>&nbsp;<div id=DIVNAME>��&nbsp;&nbsp;�ƣ�</DIV></td><td><input type=text size=10 title="���¼��4�����ֳ���"  maxlength="10" name=Name OnChange="toUpper(document.cus.Name);"></td></tr>
     <tr><td colspan="2"> &nbsp;<div id=DIVNAME>˵����¥�����Ʋ�Ҫ����������ַ���<br>��:"-","#"�ȣ�һ�������ġ���ĸ������</td></tr>
    
	 <tr> 
        <td  align="center" height="2" colspan="2"> 
             <input type="submit" value="�ύ" name="submit1">&nbsp;
             <input type="reset" value="ȡ��" name="reset" onclick="parent.TreeList.window.location='Tree.jsp?SecNo=<%=SecNo %>';window.location='AddLoft.jsp'">

        </td>
    </table>     
     
</form>  
<%}else{ %>   
<input type="hidden" value="�ύ" name="submit1">
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
	  if (j>1){alert("ֻ��ѡ��һ���������");return false;}
	  else if (j==0){alert("��ѡ�����ӵĶ���");return false;}
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
	  if (j>1){alert("ֻ��ѡ��һ���������");return false;}
	  else if (j==0){alert("��ѡ�����ӵĶ���");return false;}
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
		
		 if (checkStr.substring(checkStr.indexOf("*")+1)!="Loft"){//����ɾ��¥����
	       if (confirm("��ȷ��Ҫɾ������ѡ��Ķ�����")){
	         document.cus.action="SaveLoft.jsp?oper=delete";
	         document.cus.submit();
		  }
		 }else{alert("����ɾ��¥����");} 
	  }else if (j==0){
	   alert("��ѡ��Ҫɾ����һ������");
	  }
   
   }
  function EditDate(){
     var Num=parent.TreeList.document.cus.SecNo.length;
	 var j=0;
	 var jj=0;
     for (var i=0;i<Num;i++){
	     if (parent.TreeList.document.cus.SecNo[i].checked){j++;jj=i;}
	  }
	 if  (j==0){alert("��ѡ��Ҫ�޸ĵ�һ������");}
	 else{
	   var checkStr=parent.TreeList.document.cus.SecNo[jj].value;
	 
	   if (checkStr.substring(checkStr.indexOf("*")+1)!="Loft"){//����ɾ��¥����
	      document.cus.action="AddLoft.jsp?Edit=edit";
	      document.cus.submit();
	   }else{alert("�����޸�¥������");} 
	  } 
  }
  
  </script>
</body>       
</html>       
