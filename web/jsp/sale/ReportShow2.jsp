<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<title>���</title>



</head>
<script language="javascript" src="../public_js/public.js">
</script>
<SCRIPT language=javascript>
<!--
     function Validate(aForm){
		
		if (aForm.out4.value.length<1){
	    	alert("����ѡ����Ҫ�ڱ�������ʾ�������");
	        aForm.out4.focus();
	        return (false);
	    }
		return (true);

   }   
   
   
function remove1(){
 var strvalue="";
 var strtext="";
 var i=getSelect(document.rmis.choose);
 var result1=seelist(rmis.out4);
 if (!(result1!="")&&(document.rmis.out4.selectedIndex>=0)){
   alert("��ѡ��Ҫɾ����������");return false;}
 if (document.rmis.choose[i].value=="out"){
   document.rmis.out4.options[document.rmis.out4.selectedIndex]=null;
 }
}

function getSelect(radio){
  for (var i=0;i<radio.length;i++){
      if (radio[i].checked){return i}
   }	  
 }
function remove(){
var i=getSelect(document.rmis.choose);
 var strvalue="";
 var strtext="";
 var result=seelist(rmis.out);
 if (result!=""&&document.rmis.out.selectedIndex>=0){
   strvalue=document.rmis.out.options[document.rmis.out.selectedIndex].value; 
   strtext=document.rmis.out.options[document.rmis.out.selectedIndex].text;
   document.rmis.out.options[document.rmis.out.selectedIndex].selected=false;
 }else{alert("��ѡ��Ҫ��ʾ��������");return false;} 
 
 if (document.rmis.choose[i].value=="px"){
    var pxtext=document.rmis.pxtext.value;
	var pxvalue=document.rmis.out1.value;
    if (pxtext!=""){
	  document.rmis.out1.value=pxvalue+","+strvalue;
 	  document.rmis.pxtext.value=pxtext+","+strtext;
	}else{
	  document.rmis.out1.value=strvalue;
 	  document.rmis.pxtext.value=strtext;
	
	}
   }else if (document.rmis.choose[i].value=="fz"){
     var fztext=document.rmis.fztext.value;
	 var fzvalue=document.rmis.out2.value;
	 document.rmis.out4.options[document.rmis.out4.length]=new Option(strtext,strvalue+"-"+strtext);
     document.rmis.out4.options[document.rmis.out4.length-1].selected=true;

    if (fztext!=""){
	  document.rmis.out2.value=fzvalue+","+strvalue;
 	  document.rmis.fztext.value=fztext+","+strtext;
    }else{
      document.rmis.out2.value=strvalue;
 	  document.rmis.fztext.value=strtext;
	}
  }else if (document.rmis.choose[i].value=="ifelse"){
    document.rmis.out3.options[document.rmis.out3.length]=new Option(strtext,strvalue);
  }else if (document.rmis.choose[i].value=="out"){
    document.rmis.out4.options[document.rmis.out4.length]=new Option(strtext,strvalue+"-"+strtext);
    document.rmis.out4.options[document.rmis.out4.length-1].selected=true;
	//document.rmis.out.options[document.rmis.out.selectedIndex].selected=false;

 }
}

function seelist(form){
  var result="";
  for (var i=0;i<form.length;i++){
    //if (form.out1.options[i].selected){
	 result+=form.options[i].value+",";
	 //}
	
   }
   return result;
}
function locat(form){
  var result1=seelist(rmis.out1);
 
   if ((result1!="")&&(result2!="")&&(result3!="")){
  result1=result1.substring(0,result1.lastIndexOf(","));
  }else{alert("��ѡ��ֵ�㶨��ı�����λ��");}
}
//-->
</SCRIPT>
<%
 String type="";
 

String section=request.getParameter("section");
String conStr=section;
String condi="";
if (conStr!=null){
 type=conStr
    section="select * from ReportSet where Type='"+type.substring(0,type.indexOf("*"))+"' and reportname='"+type.substring(type.indexOf("*")+1)+"'";
 }


 if (section!=null){condi="disabled";}else{section="";} %>
<body  onload="setSelectMad(document.aa.section,'<%=request.getParameter("section") %>') ;">


     <p align="center"><b><font size="3" color="#000080">�����Զ������</font></b>
<br>
<form name=aa method="post" action="" >
		��ѡ����Ҫ��ӡ�Ķ��屨�����ݱ���:
		<select name=section onchange="document.aa.submit();">
		<option></option>
		<option value="RgsViewC">�Ϲ�����</option>
		<option value="SaleViewC">���۱���</option>
		
		</select>
		</form>




<form method="POST" name="rmis" action="PrintReport2.jsp?para=show&type=<%=type %>&tablename=<%=conStr %>" onsubmit="return Validate(this)" >
<input type=hidden name=type value="<%=type %>">
	    <table width="90%" align=center border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
<tr>
    
		<td width="20%" align=center > 
        ��ѡ��������<br>
		  <select name="out"�� size="10" multiple style="width: 90;  height: 180" >

			<%

	      if (condi!=""){
		    ResultSetMetaData rsmd=null;
			ResultSet rs=null;
			out.print(section.length());
			try{
			 rs=ViewBean.executeQuery(section);
			
			}catch(Exception e){out.print(section);out.close();}
			//rsmd=rs.getMetaData();
			//int numCols=rsmd.getColumnCount();
			while (rs.next()){
			 String FieldName=rs.getString("E_name");
			 String FieldValue=rs.getString("C_name");
			 // String lableE=rsmd.getColumnLabel(i+1);
			 // String lableC=rsmd.getColumnLabel(i+2);
			  out.print("<option value='"+FieldName+"' >");
			  out.print(FieldValue+"</option>");
			}
		 }else{out.print("<option value=''></option>");}
		
			%>
		  
          </select>
          </td>
        <td width="22%" align=center  > 
		<input type="radio" name="choose" value="px" checked>����
		<br>
		<input type="radio" name="choose" value="fz">����
		<br>
		<input type="radio" name="choose" value="out">���
		<br>
		<input type="radio" name="choose" value="ifelse">����
		<br>
  <input type=button name=aa1 value=">>" onclick="remove();" title="����������">
  
  <br><br>
    <input type=button name=aa2 value="<<" onclick="remove1();">
 
		  </td>
		 <td width="25%">
		 ����������<br>
		 <input type=hidden name=out1 value="">
		 <input type=text name=pxtext ><br>
          <input type=radio name="px" value="ASC" checked>����<input type=radio name="px" value="DESC" >����
           <br>
		   ����������<br>
		    <input type=hidden name=out2 value="">
		    <input type=text name=fztext >
		   
		    <br>
			�������<br>
		   <select  name="out3" size="10" multiple style="width: 90;  height: 40" >

           </select>  

		 </td>
<td width="20%" align=center > 
        �����˳��<br>
		  <select name="out4"�� size="10" multiple style="width: 90;  height: 180" >
          </select>
		   
		  </td> 
      
		  <td width="15%" align=center > 
		<br><br>
		<input type=submit name=submit value="��ʾ�Զ��屨��">
		</td>
	
      
      </tr>
   </table>     
</form>     
       
       
       
</body>       
</html>       
