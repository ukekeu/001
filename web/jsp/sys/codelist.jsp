<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link rel=stylesheet href="../class/mad.css" >
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>代码列表</title>
</head>
  <%@ page import="java.sql.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase" />
     <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
   <%@ include file="../public_js/getByteOut.jsp"%>
<body oncontextmenu="return false" >
 <SCRIPT language=JavaScript1.2>
function show(tmp) {
	var divs = document.all.tags("DIV") ;
	var temp=tmp.substring(0,4);
	for ( i = 0 ; i < divs.length ; i ++ ) {
		if (divs[i].id) {
	     	var tt = divs[i].id ;
			if (tt.indexOf(temp) > -1) {
				if (tt==tmp) 
		   		   document.all.tags("DIV")[i].style.display = (document.all.tags("div")[i].style.display == "block")?"none":"block" ;
				else 
				   document.all.tags("DIV")[i].style.display = "none" ;
				 }
			}			
		}
}
</SCRIPT>
 
<script language="javascript" src="../public_js/public.js"></script>
<%
 String Stype="";
 String Scodeno="";
 String Scodename="";
 String StrSql="";
 
 ResultSet rs=null;
 int num=0;
 int sum=0;
StrSql="select count(*) as num from CODE where child=1 ";
 try{
   rs=aBean.executeQuery(StrSql);
   while (rs.next()){
     
	 sum=rs.getInt("num");
   }
   num=sum;
   rs.close();
  }catch(Exception s) {}
 String StrType[]=new String[num];
 String StrName[]=new String[num];  
 StrSql="select count(*) as num from CODE where child=0 ";
 try{
   rs=aBean.executeQuery(StrSql);
   while (rs.next()){
     
	 sum=rs.getInt("num");
   }
  }catch(Exception s) {}
    rs.close();
 String StrType1[]=new String[sum];
 String StrCodeNo[]=new String[sum];
 String StrCodeName[]=new String[sum];  
 
 StrSql="select type,TYPENAME from CODE  WHERE CHILD=1 group by  type,TYPENAME order  by  type,TYPENAME";
 int i=0;
 int ii=0;

 try{
   rs=aBean.executeQuery(StrSql);
   
  while (rs.next()){
     StrType[i]=rs.getString("TYPE");
     StrName[i]=getbyte(rs.getString("TYPENAME"));
     i++;
   }
  
   rs.close();
 }catch(Exception s)  {}
   StrSql="select * from CODE  where child=0 order  by  type,TYPENAME,Codeno";
 i=0;
 try{

   rs=aBean.executeQuery(StrSql);

   while (rs.next()){
     StrType1[i]=rs.getString("TYPE");
     StrCodeNo[i]=getbyte(rs.getString("id"));
     StrCodeName[i]=getbyte(rs.getString("CODENAME"));
     i++;
   }
  
   rs.close();
 }catch(Exception s)  { }
 
  %>

<center>
<form name=cus>
<%@ include file="../public_js/qx_checke.jsp"%>
<%
//权限审核
String Cortrol=checke_qx(aBean1,(String)session.getAttribute("loginid"),"B002");
 %>
	<p  align="center" class=FontColor><font size=3><b>常用代码列表</b></font> </p>
 
 
    <table BORDER=0 width="95%" CELLSPACING=1 CELLPADDING=1 ALIGN=center>
      <!-- class="tablefill"-->
      <tr align="right"><td> <%if (Cortrol.indexOf("A")>=0){ %><input type=button value="增 加"   onclick="addCode();"><%}
   if (Cortrol.indexOf("D")>=0){ %><input type=button value="删 除" onclick="delCode();"><%}%>
</td></tr>
</table>
 
    <table BORDER=1 width="95%" CELLSPACING=0 CELLPADDING=0  align="center">
      <%
 try{
 for ( int jj=0;jj<num;jj++){ 
   if (jj>0&&(jj%2)==0)out.print(" </tr >");
   if ((jj%2)==0)out.print(" <tr >");
 
 %>
      <td ALIGN=left  valign="top" > 
 <table border="0" width="100%" ALIGN=left>
<tr bgcolor='#EAEAEA'><td colspan="7">
<b> <%if (Cortrol.indexOf("A")>=0){ %><input type="radio" value="<%=StrType[jj]%>" name=chos onclick="checkType('<%=StrType[jj]%>','<%=StrName[jj]%>');"><%} %><%=StrName[jj]%></b>
</td></tr>
 <%
int br=0;
for ( int jjj=0;jjj<sum;jjj++){ 
  	
	  if (StrType[jj].equals(StrType1[jjj])){
	  if (br==0)out.print("<tr align='left'><td>&nbsp;");
	  br++;
	  %>
	 
	
    <%=StrCodeName[jjj]%><input type=checkbox name=code value="<%=StrCodeNo[jjj] %>" onclick="checkClick(this)"> 
 
	<%
	if (br==4){out.print(" </td></tr>");br=0;}
	 }
	}
   %>
    </tr>
</table>
</td>
<%// if ((jj%2)==0)out.print("</tr>"); %>

  <%}  }catch(Exception s)  { }%>	  
 
</table>
</form>
</center>
<script>
var RSID="";
function delCode() {
    if (RSID!=""){
		if ( confirm("确实想删除该条记录?"))
			window.location = "savecode.jsp?id=" + RSID;
    }else{
	
	alert("请选择你要删除的代码");
	}
	}

function checkClick(para){
  var Num=document.cus.code.length;//当前checkbox的length
  var CodeStr="";
  for(var j=0;j<Num;j++)
     {
	 if (document.cus.code[j].checked){
	  if  (CodeStr=="")CodeStr=document.cus.code[j].value;
	  else CodeStr=CodeStr+","+document.cus.code[j].value; 
     }
   }
 RSID=CodeStr;
}	   
var CodeType="";
var CodeName="";
function checkType(para1,para2){
   CodeType=para1;
   CodeName=para2;
}	
function addCode(){
  if (CodeType==""){alert("选择增加的代码");return false;}
  openwin1("codeset.jsp?codetype="+CodeType+"&CodeName="+CodeName,300,200,150,100);

} 
</script>
</body>

</html>
