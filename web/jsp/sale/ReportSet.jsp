<%@ page contentType="text/html;charset=GBK" %>
<%@ page language="java" import="java.sql.*" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>
<%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "自定报表" , 
                  "浏览"
                ) ;
%>

<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>报表自定义</title>



</head>
<script language="javascript" src="../public_js/public.js">
</script>
<SCRIPT language=javascript>
<!--
     function Validate(aForm){
 
 for (var j=0;j<24;j++){
   if (document.rmis.out1.options[j])
 document.rmis.out1.options[j].selected=true;
 }
		if (aForm.out1.value.length<1){
	    	alert("请先选择需要在报表中显示的数据项！");
	        aForm.out1.focus();
	        return (false);
	    }
		if (aForm.report.value.length<1){
	    	alert("请输入自定义文件名！");
	        aForm.report.focus();
	        return (false);
	    }
		
		return (true);

   }   
   
   
function remove1(){

// var result1=seelist(rmis.out1);
 if (document.rmis.out1.selectedIndex<0){
   alert("请选择要删除的数据项");return false;
  }
   var strvalue="";
   var strtext="";
   var ii=document.rmis.out1.length;
 for (var j=0;j<ii;j++){
   if (document.rmis.out1.selectedIndex<0)break;
    strvalue=document.rmis.out1.options[document.rmis.out1.selectedIndex].value;
    strtext=document.rmis.out1.options[document.rmis.out1.selectedIndex].text;
   document.rmis.out1.options[document.rmis.out1.selectedIndex]=null;
    document.rmis.out.options[document.rmis.out.length]=new Option(strtext,strvalue);
 }
 for (var jj=0;jj<document.rmis.out1.length;jj++){
	 document.rmis.out1.options[jj].selected=true;
	}
}

function getSelect(radio){
  for (var i=0;i<radio.length;i++){
      if (radio[i].checked){return i}
   }	  
 }
function adddata(){

// var result=seelist(rmis.out);
if (document.rmis.out.selectedIndex<0){
alert("请选择要显示的数据项");
}

 var strvalue="";
 var strtext="";
 var ii=document.rmis.out.length;
 for (var j=0;j<ii;j++){
    if (document.rmis.out.selectedIndex<0)break;
  strvalue=document.rmis.out.options[document.rmis.out.selectedIndex].value;
   strtext=document.rmis.out.options[document.rmis.out.selectedIndex].text; 
   document.rmis.out1.options[document.rmis.out1.length]=new Option(strtext,strvalue);
   document.rmis.out1.options[document.rmis.out1.length-1].selected=true;
   //document.rmis.out.options[document.rmis.out.selectedIndex].selected=false;
   document.rmis.out.options[document.rmis.out.selectedIndex]=null;
}
 // document.rmis.out1.options[document.rmis.out1.length]=new Option('认购日期','date'+'-'+'认购日期');
 //  document.rmis.out1.options[document.rmis.out1.length-1].selected=true;
}

function addorderby(){

// var result=seelist(rmis.out);
if (document.rmis.out1.selectedIndex<0){
alert("请选择要显示的数据项");
}

 var strvalue="";
 var strtext="";
 var ii=document.rmis.out1.length;
 for (var j=0;j<ii;j++){

   if (document.rmis.out1.selectedIndex<0)break;
   strvalue=document.rmis.out1.options[document.rmis.out1.selectedIndex].value;
   strtext=document.rmis.out1.options[document.rmis.out1.selectedIndex].text; 
   document.rmis.orderby.options[document.rmis.orderby.length]=new Option(strtext,strvalue);
   document.rmis.orderby.options[document.rmis.orderby.length-1].selected=true;
   document.rmis.out1.options[document.rmis.out1.selectedIndex].selected=false;
   //document.rmis.out.options[document.rmis.out.selectedIndex]=null;
}
 // document.rmis.out1.options[document.rmis.out1.length]=new Option('认购日期','date'+'-'+'认购日期');
 //document.rmis.out1.options[document.rmis.out1.length-1].selected=true;
}


function removeorderby(){

// var result1=seelist(rmis.out1);
 if (document.rmis.orderby.selectedIndex<0){
     alert("请选择要删除的数据项");return false;
  }
   var strvalue="";
   var strtext="";
   var ii=document.rmis.orderby.length;
 for (var j=0;j<ii;j++){
   if (document.rmis.orderby.selectedIndex<0)break;
    strvalue=document.rmis.orderby.options[document.rmis.orderby.selectedIndex].value;
    strtext=document.rmis.orderby.options[document.rmis.orderby.selectedIndex].text;
   document.rmis.orderby.options[document.rmis.orderby.selectedIndex]=null;
 }
 for (var jj=0;jj<document.rmis.orderby.length;jj++){
	 document.rmis.orderby.options[jj].selected=true;
	}
}


function seelist(form){
  var result="";
  
  for (var i=0;i<form.out.length;i++){
   
	 result+=form.out1.options[i].value+",";
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
<%String section=request.getParameter("section");
String conStr=section;
String condi="a";
 section="select * from  RgsViewC";//+section;

 if (section!=null){condi="disabled";}else{section="";} %>
 <script>
 function selectD(){
 	setSelectMad(document.aa.section,"<%=request.getParameter("section") %>");

}
 </script>
<body >


     <p align="center"><b><font size="3" color="#000080">报表自定义设置</font></b>
<br>
	<!--	
<form name=aa method="post" action="" >
请选择你要定义的报表数据表名:
		<select name=section onchange="document.aa.submit();">
		<option></option>
		<option value="RgsViewC">认购报表</option>
		<option value="SaleViewC">销售报表</option>
		</select>
		</form>

-->
<form method="POST" name="rmis" action="InertReportSet.jsp?Operation=Insert" onsubmit="return Validate(this);" >
<%
 String type="";
 if (conStr!=null)   type=conStr;
  
 %>
<input type=hidden name=type value="RgsViewC"><%//type %>
<table CELLSPACING=1 CELLPADDING=1 ALIGN=center >
<tr><td valign="top">
<table>
<tr class="TXTColor">
<td>已定义报表名称</td><td>输出</td><td>删除</td></tr>
<%
  String reSql="select reportname,type  from  ReportSet group by reportname,type";
  ResultSet reRs=ViewBean.executeQuery(reSql);
  while (reRs.next()){
    String reportName=getbyte(reRs.getString("reportname"));
	String reportType=reRs.getString("type");
    out.print("<tr class=listcontent ><td>"+reportName+"</td><td><a href='ReportShow.jsp?section="+reportType+"*"+reportName+"'>输出</a></td>");
    %>
  <td><a href='#' onclick="window.open('DeleteAucReportSet.jsp?reportname=<%=reportName%>')">删除</a></td></tr>
<%
  }
  reRs.close();
 %>
 </table>
</td><td>
<table class='listcontent' border="0" width="70%"  align="center" height="211">
<tr><td>
<table  border="0" width="50%"  align="center" height="211">
<tr>
    
		<td width="20%"  align="center"> 
        待选择数据项<br>
		  <select name="out"　 size="10" multiple style="width: 90;  height: 180" >
  
			<%

	    //  if (condi!=""){
		    ResultSetMetaData rsmd=null;
			ResultSet rs=null;
		
			try{
			 rs=ViewBean.executeQuery(section);
			
			rsmd=rs.getMetaData();
			int numCols=rsmd.getColumnCount();
			for (int i=0;i<numCols;i+=2){
			  String lableE=rsmd.getColumnLabel(i+1);
			  String lableC=rsmd.getColumnLabel(i+2);
			  out.print("<option value='"+lableE+"-"+lableC+"' >");
			  out.print(lableC+"</option>");
			}
			}catch(Exception e){out.print(section);}
		// }else{out.print("<option value=''>fdf</option>");}
		
			%>
		
          </select>
          </td>
        <td width="15%"  align="center"> 
  <input type=button name=aa1 value=">>" onclick="adddata();">
  <br><br>
    <input type=button name=aa2 value="<<" onclick="remove1();">
		  </td>
		 <td>
		 选择的数据项<br>
		  <select  name="out1" size="10" multiple style="width: 90;  height: 180" >

           </select>

		 </td>
		  <td width="15%" align="center"> 
	     <table >
		 <tr><td><br><br> <input type=button name=aa9 value=">>" onclick="addorderby();"> <br> 
    <input type=button name=aa8 value="<<" onclick="removeorderby();"></td><td>	  排序项  <select name="orderby"　 size="10" multiple style="width: 100;  height: 80" > </td></tr>
 <tr><td colspan="2">排序：<input type="radio" checked value="0" name="orderbytype">降序<input type="radio" value="1" name="orderbytype">升序
		</td></tr>
		 <tr><td colspan="2">
		自定义报表名称:<br><input type=text name=report >
		<input type=submit name=submit value="提交定义">
		</td></tr>
		</table>
		<br><br>
	<!--	<input type=button name=button value="显示自定义报表" onclick="javascript:window.open('InertReportSet.jsp?para=show&type=<%=type %>&tablename=<%=conStr %>','_blank')">-->
		</td>
	
      
      </tr>
   </table>     
   </td></tr></table>
   </td></tr></table>
</form>     
       
       
       
</body>       
</html>       
