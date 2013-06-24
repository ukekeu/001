<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ page language="java" import="java.sql.*,common.*" %>
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
<jsp:useBean id="commonListBean" scope="page" class="ConnDatabase.SListBean" />
 <jsp:useBean id="txt" scope="page" class="ConnDatabase.WriteToTxtBean"/>
<jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/> 
<%@ include file="../public_js/getByteOut.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>

<title>查询销售情况</title>
<script language="JavaScript" src='../public_js/basal.js'></script>


</head>
<%
String PARA_SQL=request.getParameter("PARA_SQL");
String url=request.getParameter("url");
String reporttype=request.getParameter("reporttype");
String tablename=request.getParameter("tablename");

String out3=request.getParameter("out3");
String ifvalueC=getbyte1(request.getParameter("ifvalueC"));
String ifvalueE=getbyte1(request.getParameter("ifvalueE"));
 String SQLwhere="";
 
String SectionS = setpopedom.getSectionlist(); //有权使用楼盘编码  

java.util.Hashtable hs = setpopedom.getDic() ;
  
  

// String SectionS=(String)session.getAttribute("Section");	//有权使用楼盘编码  //where SerialNo in ("+SectionS+")"+"
String defaultNo="";
String SecNo="";
try{
    defaultNo=(String)session.getAttribute("defaultNo");
}catch(Exception s){
}
if ( defaultNo == null ) {
    defaultNo="";//如何用户未设置默认楼盘，则显示用户选中或所有楼盘的楼栋
}
if (!defaultNo.equals(""))
{
    SectionS=defaultNo;
    SecNo=defaultNo;
}
String FindWhere="";
if ( !SecNo.equals("") ) { 
    FindWhere=" where section='"+SecNo+"'";
}else{
    FindWhere=" where section in("+SectionS+")";
}
%>

<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<SCRIPT language=javascript>
<!--
    function full(){
	 <%
	  int iii=ifvalueE.length();
	  String ss1="";
	  String ss2="";
	  int num=0;
	  int nn=0;
	  if (!ifvalueE.equals("")){
	  %>

	  document.frm.ifvalueC.value="<%=ifvalueC %>";
  	  document.frm.ifvalueE.value="<%=ifvalueE %>";
	  document.rmis.url1.value="<%=url %>";
  	  document.rmis.reporttype1.value="<%=reporttype %>";
	  document.rmis.tablename1.value="<%=tablename %>";
	  document.frm.bjgx.disabled=false; 
	  setSelectMad(document.frm.bjgx,' and ');
    <%
	
	  for (int jjj=0;jjj<iii;jjj++){
		 if (ifvalueE.substring(jjj,jjj+1).equals("|"))num++;
	  }
	    
	  if (iii==0)iii++;
	 
	  for (int jj=0;jj<iii;jj++){
	     if (ifvalueE.indexOf("|")>=0){
		   ss1=ifvalueE.substring(0,ifvalueE.indexOf("|"));
		   ss2=ifvalueC.substring(0,ifvalueC.indexOf("|"));
		   ifvalueE=ifvalueE.substring(ifvalueE.indexOf("|")+1);
		   ifvalueC=ifvalueC.substring(ifvalueC.indexOf("|")+1);
		   SQLwhere+=ss1;
		   nn++;
		%>
		 document.rmis.ifvalue.options[document.rmis.ifvalue.length]=new Option("<%=ss2 %>","<%=ss1%>");
		 <%
		  } 
		  if (jj==num){%>
		  document.rmis.ifvalue.options[document.rmis.ifvalue.length]=new Option("<%=ifvalueC %>","<%=ifvalueE%>");
		  <%nn++;
		  SQLwhere+=ifvalueE;
		  }
	     }
	   }
	
	   if (nn==0&&!ifvalueE.equals("")){
	  %>
	  	document.rmis.ifvalue.options[document.rmis.ifvalue.length]=new Option("<%=ifvalueC %>","<%=ifvalueE%>");
       <%} %>			 
       for (var j=0;j<document.rmis.ifvalue.length;j++){
	     document.rmis.ifvalue.options[j].selected=true;
	   }
	
	 }
  function Validate(aForm){
	 var valueaa="";
     for (var j=0;j<document.rmis.ifvalue.length;j++){
	   if (valueaa=="")
	     { valueaa=document.rmis.ifvalue.options[j].value;
		   document.rmis.ifvalue.options[j].selected=true;
	   }else{
	      valueaa+="  "+document.rmis.ifvalue.options[j].value;
		  document.rmis.ifvalue.options[j].selected=true;
	    }
	  }
	 if (valueaa==""){
	   alert("请输入打印条件值");
	 	   return false;
	 }
	 		return (true);
     
   }   
   

function remove1(){
 var strvalue="";
 var strtext="";
 if (confirm("确认要取消该项数据吗？")){
 //var i=getSelect(document.frm.choose);
 var result1=seelist(frm.out4);
 if (!(result1!="")&&(document.frm.out4.selectedIndex>=0)){
   alert("请选择要删除的数据项");return false;}
 //if (document.frm.choose[i].value=="out"){
   var len=document.frm.out4.length;
    for (var j=0;j<len;j++){
      if (document.frm.out4.selectedIndex<0)break;
      document.frm.out4.options[document.frm.out4.selectedIndex]=null;
	}

 for (var j=0;j<document.frm.out4.length;j++){
	 document.frm.out4.options[j].selected=true;
	}
}
}
function selec(){
for (var j=0;j<document.frm.out4.length;j++){
	 document.frm.out4.options[j].selected=true;
	}
}	

function getSelect(radio){
  for (var i=0;i<radio.length;i++){
      if (radio[i].checked){return i}
   }	  
 }
function adddata(){
var i=getSelect(document.frm.choose);
 var strvalue="";
 var strtext="";
 var result=seelist(frm.out);
 if (result!=""&&document.frm.out.selectedIndex<0){
 alert("请选择要显示的数据项");return false;} 

  for (var j=0;j<document.frm.out.length;j++){
   if (document.frm.out.selectedIndex<0)break;
  strvalue=document.frm.out.options[document.frm.out.selectedIndex].value; 
  strtext=document.frm.out.options[document.frm.out.selectedIndex].text;
  document.frm.out.options[document.frm.out.selectedIndex].selected=false;
 
 if (document.frm.choose[i].value=="px"){
   
    var pxtext=document.frm.pxtext.value;
	var pxvalue=document.frm.out1.value;
	document.frm.px[0].checked=true;
    if (pxtext!=""){
	  document.frm.out1.value=pxvalue+","+strvalue;
 	  document.frm.pxtext.value=pxtext+","+strtext;
	}else{
	  document.frm.out1.value=strvalue;
 	  document.frm.pxtext.value=strtext;
	
	}
   }else if (document.frm.choose[i].value=="fz"){
     var fztext=document.frm.fztext.value;
	 var fzvalue=document.frm.out2.value;
	 document.frm.out4.options[document.frm.out4.length]=new Option(strtext,strvalue+"-"+strtext);
     document.frm.out4.options[document.frm.out4.length-1].selected=true;

    if (fztext!=""){
	  document.frm.out2.value=fzvalue+","+strvalue;
 	  document.frm.fztext.value=fztext+","+strtext;
    }else{

      document.frm.out2.value=strvalue;
 	  document.frm.fztext.value=strtext;
	}
  }else if (document.frm.choose[i].value=="out"){
    document.frm.out4.options[document.frm.out4.length]=new Option(strtext,strvalue+"-"+strtext);
    document.frm.out4.options[document.frm.out4.length-1].selected=true;
	document.frm.out3.options[document.frm.out3.length]=new Option(strtext,strvalue);

 }
 }
 var ifvalue2=document.frm.ifvalue.options[document.frm.ifvalue.selectedIndex].text;
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

function clea(){
  document.frm.ifv.select();
  }
function addif()
  {
   var valueaa="";
   var valueab="";
   var gx="";//是否and /or 
    if (document.rmis.ifvalue.length>0&&document.frm.bjgx.options[document.frm.bjgx.selectedIndex].text=="")
	{
	alert("请选择复合条件关系");
	document.frm.bjgx.focus();
	return false;
	}
	if (document.rmis.ifvalue.length==0&&document.frm.bjgx.options[document.frm.bjgx.selectedIndex].text!="")
	{
	alert("当前条件是简单条件，不能选择复合关系");
	//document.frm.bjgx.value="";
	return false;
	}
	strtext=document.frm.out3.options[document.frm.out3.selectedIndex].text;
	 
	 strvalue=document.frm.out3.options[document.frm.out3.selectedIndex].value;
	 
	 
    
   strif=document.frm.ifelse.options[document.frm.ifelse.selectedIndex].value;
   strt=document.frm.ifelse.options[document.frm.ifelse.selectedIndex].text;
   
   if (strt==""){alert("请输入条件值");document.frm.ifelse.focus();return false;}
if (document.frm.ifv.value==""&&document.frm.ifvA.value=="") {alert("请输入或选择条件值");document.frm.ifv.focus();return false;}
    gx=	document.frm.bjgx.value;
	if (document.frm.choosroomno.value=="") 
	 {
	 if (document.frm.ifv.value!="")
	 strtext=strtext+strif+document.frm.ifv.value;
	 else  if (document.frm.ifvA.value!="")
		 strtext=strtext+strif+document.frm.ifvA.value; 
	 }
	else
	  strtext=strtext+strif+document.frm.choosroomno.value;
	var ifvalue="";
	if (document.frm.choosroomno.value=="") 
	 {if (document.frm.ifv.value!="")
	  ifvalue=document.frm.ifv.value;
	 else  if (document.frm.ifvA.value!="")
	 ifvalue=document.frm.ifvA.value; 
	}
	else
	  ifvalue=document.frm.choosroomno.value;
	if (strtext.indexOf("序号")>=0){
	  if (!check(document.frm.ifv))return false;
	    }
	
   //if (strtext.indexOf("日期")>=0)strvalue=strvalue;
    if (!(strif.indexOf("in")>=0||strtext.indexOf("面积")>=0||strtext.indexOf("价")>=0||strtext.indexOf("序号")>=0||strtext.indexOf("楼层")>=0))ifvalue="'"+ifvalue+"'";


    if (strt=="like"){
     strvalue=gx+strvalue+"  "+strif+ifvalue+"%'";
    }else  if (strt=="包含"){
     strvalue=gx+strvalue+"   "+strif+" ("+ifvalue+")";
    }else{
	 strvalue=gx+strvalue+"  "+strif+ifvalue;
	}
	 
	
   if (document.rmis.ifvalue.length>0)	strtext=document.frm.bjgx.options[document.frm.bjgx.selectedIndex].text+" "+strtext;
   document.rmis.ifvalue.options[document.rmis.ifvalue.length]=new Option(strtext,strvalue);
   document.rmis.ifvalue.options[document.rmis.ifvalue.length-1].selected=true;
   for (var j=0;j<document.rmis.ifvalue.length;j++){
	 if (valueaa=="")
	{ valueaa=document.rmis.ifvalue.options[j].text;
	 valueab=document.rmis.ifvalue.options[j].value;
	  document.rmis.if_name.value=document.rmis.ifvalue.options[j].text
	  document.rmis.if_value.value=document.rmis.ifvalue.options[j].value
	 }else{
	   valueaa+=" | "+document.rmis.ifvalue.options[j].text;
	  document.rmis.if_name.value+=document.rmis.ifvalue.options[j].text
	  valueab+=" | "+document.rmis.ifvalue.options[j].value;
	  document.rmis.if_value.value+=document.rmis.ifvalue.options[j].value
	 }
	}
	document.frm.ifvalueC.value=valueaa;
	document.frm.ifvalueE.value=valueab;
	setSelectMad(document.frm.bjgx,' and ');
        document.frm.bjgx.disabled=false;
		
  }

function reif(){
    if (document.rmis.ifvalue.length==2){
	  if (document.rmis.ifvalue.selectedIndex==0){ alert("不能删除第一个条件");return false;}
	}
    if (document.rmis.ifvalue.selectedIndex>=0){
	document.rmis.ifvalue.options[document.rmis.ifvalue.selectedIndex]=null;
    document.frm.ifvalueC.value="";
	document.frm.ifvalueE.value="";
   }
   
    for (var j=0;j<document.rmis.ifvalue.length;j++){
	 document.rmis.ifvalue.options[j].selected=true;
	  if (document.frm.ifvalueC.value!=""){
	    document.frm.ifvalueC.value+=" | "+document.rmis.ifvalue.options[j].text;
  	    document.frm.ifvalueE.value+=" | "+document.rmis.ifvalue.options[j].value;
	  }else{
	    document.frm.ifvalueC.value=document.rmis.ifvalue.options[j].text;
  	    document.frm.ifvalueE.value=document.rmis.ifvalue.options[j].value;
	  }
	}
   if (document.rmis.ifvalue.length==0){
      setSelectMad(document.frm.bjgx,'');
      document.frm.bjgx.disabled=true;
  }
}

function locat(form){
  var result1=seelist(frm.out1);
 
   if ((result1!="")&&(result2!="")&&(result3!="")){
  result1=result1.substring(0,result1.lastIndexOf(","));
  }else{alert("请选择值你定义的报表栏位名");}
}

function choose(){
   var ifvalue1=document.frm.out3.options[document.frm.out3.selectedIndex].value;
   var ifvalue2=document.frm.out3.options[document.frm.out3.selectedIndex].text;
   if (document.frm.ifelse.options[document.frm.ifelse.selectedIndex].value=="in"){
   openwin1("roomcodelist.jsp?PARA_SQL=<%=PARA_SQL %>&groupname="+ifvalue1,380,480,300,100);
   
   return false;
   }

 if (ifvalue2.indexOf("日期")>=0){
     fPopUpCalendarDlg(document.frm.datevalue);
	var aa=document.frm.datevalue.value;
    var aa=document.frm.datevalue.value;
	var aaa="";
	for (var jj=0;jj<aa.length;jj++){
	   if (aa.substring(jj,jj+1)!="-")
	     aaa+=aa.substring(jj,jj+1);
       else aaa+="/";
	 }  
	 document.frm.ifv.options[document.frm.ifv.length]=new Option(aaa,aaa);
	setSelectMad(document.frm.ifv,aaa);
    }
}
function submitChoose(){
   document.frm.action="sale_select.jsp?PARA_SQL=<%=PARA_SQL %>";
   document.frm.submit();
}


//-->
</SCRIPT>

<body onload="setSelectMad(document.frm.out3,'<%=out3 %>');full()">
            

     <p align="center"><b><font size="3" color="#000080">请选择查询条件</font></b>
<br>
	   <form name=frm method="post">
<center>
  <table width="100%" align=center border="0" cellspacing="0"  cellpadding="0"  >
  <tr><td>输出条件</td><td>组合条件</td><td>条件</td>
<td>选择条件值</td><td>手工输入条件值</td></tr>
<tr>
    
			
	 <td >
		
			
		   <select  name="out3"   style="width: 90;"  onchange="submitChoose();">
		   <option></option>
             <%		
	    ResultSetMetaData rsmd=null;
   		ResultSet rs=null;
			
		try{
			 rs=ViewBean.executeQuery("select * from  "+PARA_SQL);
			
			rsmd=rs.getMetaData();
			int numCols=rsmd.getColumnCount();
			for (int i=0;i<numCols;i+=2){
			  String lableE=rsmd.getColumnLabel(i+1);
			  String lableC=rsmd.getColumnLabel(i+2);
			  out.print("<option value='"+lableE+"' >");
			  out.print(lableC+"</option>");
	
			}
			
			rs.close();
			}catch(Exception e){out.print(e.getMessage());}
		
      %>
           </select>
		   </td><td>
		    <select name=bjgx disabled>
			<option ></option>
			<option value=" and ">并且</option>
			<option value=" or ">或者</option>
			</select> 
	        <input type=hidden name="choosroomno"  >
            
			  </td><td>
			  <select name=ifelse onchange="choose();">
			<option ></option>
			<option value="=">等于</option>
			<option value=">">大于</option>
			<option value="<">小于</option>
			<option value=">=">大于等于</option>
			<option value="<=">小于等于</option>
			<option value="!=">不等于</option>
			<option value="in">包含</option>
			<option value="like '%">大概</option>
			</select> 
<%
//out.print("select "+out3+ " from  "+PARA_SQL +FindWhere+SQLwhere+" group by "+out3);
if (!SQLwhere.equals(""))SQLwhere=" and "+SQLwhere;
%>         </td><td>
			<select name=ifv>
			<option></option>
			<%String StrValue="";
			if (out3!=null){
			 try{
			 
			 rs=ViewBean.executeQuery("select "+out3+ " from  "+PARA_SQL +FindWhere+SQLwhere+" group by "+out3);
			 while (rs.next()){
			   StrValue=getbyte(rs.getString(out3)).trim();
			  out.print("<option value="+StrValue+">"+StrValue+"</option>");
			 
			 }
			rs.close();
			}catch(Exception s){}
			} %>
			</select>
			</td><td>
			<%if (!StrValue.equals("")){ %><input type=text name=ifvA size=12 title="手动输入条件值"><%} %>&nbsp;
</td><td>
</tr>
			<input type=hidden name=datevalue >
			<input type=hidden name=FindB1>
			<input type=hidden name=cusname>
			<input type=hidden name=cusname1>
			<input type=hidden name=tel>
			<input type=hidden name=sj>
			<input type=hidden name=carid>
			<input type=hidden name=Address>
			<input type=hidden name=post>
			<input type=hidden name=ifvalueC value="<%=ifvalueC %>">
			<input type=hidden name=ifvalueE value="<%=ifvalueE %>">
			<input type=hidden name=reporttype value="<%=reporttype %>">
　　　　　　<input type=hidden name=url value="<%=url %>">
             <input type=hidden name=tablename value="<%=tablename %>">  
</form>
 <form method="POST" name="rmis" action="sale_view.jsp?PARA_SQL=<%=PARA_SQL %>" onsubmit="return Validate(this)" target="_blank" >
			<tr><td colspan="6">
			<input type=button name=add value="添加条件" onclick="addif();" title="添加打印数据条件">   <input type=button name=rem value="取消条件" onclick="reif();" title="取消打印数据条件">
     </td></tr>
			<tr><td colspan="6">
			 <select name="ifvalue"　 size="10" multiple style="width: 600;  height: 80" ></select>
			 
			 <input type=hidden name="if_name" >
			 <input type=hidden name="if_value" >
		 </td>
     
      </tr>
	  <tr><td>是否保留查询条件：<input type="checkbox" name="reportState" value="1"></td><td align="left"></td></tr>

   </table>
 <input type=submit name=submit1 value="查   询" > <input type=button name=winclose value="关 闭" onclick="window.close();" >
 <input type=hidden name=reporttype1 value="<%=reporttype %>">
 <input type=hidden name=url1 value="<%=url %>">
 <input type=hidden name=tablename1 value="<%=tablename %>">
  <input type=hidden name=state value="<%=tablename %>">

 </center>
</form>     
       
       <%
  try{
   //读取文件主目录
	 String filepath=request.getRealPath(request.getServletPath());
	 String company=request.getParameter("company");
     String sep=System.getProperty("file.separator");
     String filesep="";
     if(sep.equals("\\"))
      filesep="\\"; //win平台
     else if(sep.equals("/"))
      filesep="/"; //unix平台
     int pos=filepath.lastIndexOf("\\");
     String savepath="";
     if(pos!=-1)
     savepath=filepath.substring(0,pos+1)+"condition"+url+".txt";
     String file=txt.ReadTXT(savepath); 
     //out.print(file);
    // txt.WriteToTXT(if_value,if_name);
	if (!file.equals("")&&ifvalueC.equals("")){
	%>
	<script>
	 	document.rmis.ifvalue.options[document.rmis.ifvalue.length]=new Option("<%=file.substring(file.indexOf("|")+1) %>","<%=file.substring(0,file.indexOf("|"))%>");
       	 
       for (var j=0;j<document.rmis.ifvalue.length;j++){
	     document.rmis.ifvalue.options[j].selected=true;
	   }
	
	</script>
  <%}
   }catch(Exception s){}
  
  %>
       
</body>       
</html>       
