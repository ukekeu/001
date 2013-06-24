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
<title>输出</title>



</head>
<script language="javascript" src="../public_js/public.js">
</script>
<SCRIPT language=javascript>
<!--
     function Validate(aForm){
		
		if (aForm.out4.value.length<1){
	    	alert("请先选择需要在报表中显示的数据项！");
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
   alert("请选择要删除的数据项");return false;}
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
 }else{alert("请选择要显示的数据项");return false;} 
 
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
  }else{alert("请选择值你定义的报表栏位名");}
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


     <p align="center"><b><font size="3" color="#000080">报表自定义输出</font></b>
<br>
<form name=aa method="post" action="" >
		请选择你要打印的定义报表数据表名:
		<select name=section onchange="document.aa.submit();">
		<option></option>
		<option value="RgsViewC">认购报表</option>
		<option value="SaleViewC">销售报表</option>
		
		</select>
		</form>




<form method="POST" name="rmis" action="PrintReport2.jsp?para=show&type=<%=type %>&tablename=<%=conStr %>" onsubmit="return Validate(this)" >
<input type=hidden name=type value="<%=type %>">
	    <table width="90%" align=center border="0" cellspacing="0"  cellpadding="0"  class="tablefill">
<tr>
    
		<td width="20%" align=center > 
        待选择数据项<br>
		  <select name="out"　 size="10" multiple style="width: 90;  height: 180" >

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
		<input type="radio" name="choose" value="px" checked>排序
		<br>
		<input type="radio" name="choose" value="fz">分组
		<br>
		<input type="radio" name="choose" value="out">输出
		<br>
		<input type="radio" name="choose" value="ifelse">条件
		<br>
  <input type=button name=aa1 value=">>" onclick="remove();" title="排序数据项">
  
  <br><br>
    <input type=button name=aa2 value="<<" onclick="remove1();">
 
		  </td>
		 <td width="25%">
		 排序数据项<br>
		 <input type=hidden name=out1 value="">
		 <input type=text name=pxtext ><br>
          <input type=radio name="px" value="ASC" checked>升序<input type=radio name="px" value="DESC" >降序
           <br>
		   分组数据项<br>
		    <input type=hidden name=out2 value="">
		    <input type=text name=fztext >
		   
		    <br>
			输出条件<br>
		   <select  name="out3" size="10" multiple style="width: 90;  height: 40" >

           </select>  

		 </td>
<td width="20%" align=center > 
        在输出顺序　<br>
		  <select name="out4"　 size="10" multiple style="width: 90;  height: 180" >
          </select>
		   
		  </td> 
      
		  <td width="15%" align=center > 
		<br><br>
		<input type=submit name=submit value="显示自定义报表">
		</td>
	
      
      </tr>
   </table>     
</form>     
       
       
       
</body>       
</html>       
