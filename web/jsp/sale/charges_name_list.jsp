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
<title>营销费用</title>
</head>
  <%@ page import="java.sql.*,common.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
   <jsp:useBean id="aBean1" scope="page" class="ConnDatabase.SDatabase" />
    <jsp:useBean id="setpopedom" scope="session" class="setProperty.setpopedom"/>
	<%@ include file="../public_js/CheckSection.jsp"%>
   <%@ include file="../public_js/getByteOut.jsp"%>
<body oncontextmenu="return false"  topmargin="0" onload="setSelectMad(document.frm.section,'<%=request.getParameter("section") %>');">
<script language="javascript" src="../public_js/public.js"></script>
<%
String chargesname=getbyte1(request.getParameter("chargesname"));
if (!chargesname.equals("")){
   String SQL="";
   SQL = "insert into   charges_set(chargesname,sectionno)   values('" +chargesname+"', '"+getbyte1(request.getParameter("section"))+"')";
   aBean.executeUpdate(SQL) ;
}
String chargescode=getbyte1(request.getParameter("chargescode"));
if (!chargescode.equals("")){
     String SQL="";
   SQL = "delete      charges_set where id="+chargescode;
   aBean.executeUpdate(SQL) ;

}
 String Stype="";
 String Scodeno="";
 String Scodename="";
 String StrSql="";
 
 ResultSet rs=null;
 int num=0;
 int sum=0; 
 String sel=(String)request.getParameter("sel");
 if(sel==null) sel="3";	
  %>
<%@ include file="../public_js/qx_checke.jsp"%>
 <%
//权限审核
String Cortrol=checke_qx(aBean1,(String)session.getAttribute("loginid"),"B002");
 %>
<form name=frm>

<input type=hidden name=sel value="<%=sel%>">
 <input type=hidden name=chargescode value="">
	  <table width="260" border="0" cellspacing="0" cellpadding="0" class="L2">
   
<tr>
    <td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.frm.sel.value=1;document.frm.action='chargeslist.jsp';document.frm.submit();"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>费用计划</font></a>
	</td>
	<td class="<%if(sel.equals("2")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=2;document.frm.action='charges_view.jsp';document.frm.submit();"><font color='<%if(sel.equals("2")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>实际支出</font></a>
	</td>
	<td class="<%if(sel.equals("3")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.frm.sel.value=3;document.frm.action='charges_name_list.jsp';document.frm.submit();"><font color='<%if(sel.equals("3")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>费用设置</font></a>
	</td>
	</tr>
	</table>
	
	 <table width=98% border="0"><tr height="16"  ><td align="left">楼盘：<select name="section" onchange="document.frm.submit();"> 
   <option>请选择楼盘名称</option>
<%  
    
	  
	 if (!defaultNo.equals(""))	SectionS="'"+defaultNo+"'";		
      String sql1 ="select SerialNo,Name from CRM_Project "+FindWhere;

 
	  ResultSet rs2=aBean.executeQuery(sql1);	
	  String sec="";
	  String no1="";
	  String cusno="";
      while (rs2.next()){
	   no1=rs2.getString("SerialNo");
	   sec=getbyte(rs2.getString("Name"));
     	out.print("<option value='"+no1+"'>"+sec+"</option>");
	  }
	  if (!no1.equals(""))defaultNo=no1;
	    rs2.close();
	
     %> </select>
	 </td> <td>费用名称：<input type=text name=chargesname>&nbsp;&nbsp;<input type=button value="提交" onclick="AddCode();"></td><td> <%if (Cortrol.indexOf("A")>=0){ %><%}
   if (Cortrol.indexOf("D")>=0){ %><%}%>
</td> </tr></table>


<table width="100%">  <tr><td align="right"  ><img src="../images/color.gif" height="1" width="100%"></td></tr>
</table>

  <p  align="center" class=FontColor><font size=3><b>营销费用一览</b></font> </p>
 <table border="0" width="100%" ALIGN=left>
 
 <%
int br=0;
  StrSql="select * from charges_set where sectionno='"+China.getParameter(request,"section")+"'";
  rs=aBean.executeQuery(StrSql);
   while (rs.next()){
	   
	  if (br==0)out.print("<tr align='left'><td>&nbsp;");
	  br++;
	  %>	
    <%=rs.getString("chargesname") %><input type=checkbox name=code title="取消选种将删除此数据项" value="<%=rs.getString("id")%>" checked onclick="cancelChoose(this.checked,this.value);"> 
 	<%
	if (br==4){out.print(" </td></tr>");br=0;}
	 }
	 rs.close();
   %>
    </tr>
</table>
 
</form>
</center>
<script>
var RSID="";
function AddCode() {
    if (document.frm.chargesname.value==""){
	  alert("请录入费用名称");
	  document.frm.chargesname.focus();
	  return false;
	}
	 document.frm.submit();
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
function cancelChoose(para,para1){
  if (!para&&confirm("确认删除此数据项吗？")){
      document.frm.chargescode.value=para1;
      document.frm.submit();
    }
}
</script>
</body>

</html>
