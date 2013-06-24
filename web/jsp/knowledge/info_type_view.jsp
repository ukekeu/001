<%@ page contentType="text/html;charset=GBK" %>



<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>知识库列表</title>
</head>

  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/checktime.jsp"%>
<script language="javascript" src="../public_js/public.js">
</script>
<%@ include file="../public_js/getByteOut.jsp"%>
 
<%

String FindCondition="";//传递参数变量
String orderby=China.getParameter(request,"orderby");
 
String id=request.getParameter("id");
if (id!=null) {ViewBean.executeUpdate("delete knowledge_type where id="+id);}//delete data

  
String sql="select  *  from knowledge_type  where typestate=1 ";
     
 

ResultSet rs=null;

   


%>
 

<body >

<form name=form1 method="post">

<% String sel=(String)request.getParameter("sel");
   if(sel==null) sel="0"; %>
   <body topmargin="1"  >
 
  <input type=hidden name="sel" value="<%=sel %>">
     <table width="180" border="0" cellspacing="0" cellpadding="0" class="L2">
   <tr>
    <td class="<%if(sel.equals("0")){out.print("paneselect3");}else{out.print("panemenu3");}%>" align="center" width=88 height=21>
	  <a href="#" onclick="document.form1.sel.value=0;findSub('knowledge_type_view.jsp');"><font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>文档类别</font> </a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("paneselect4");}else{out.print("panemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.form1.sel.value=1;findSub('info_type_view.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>资讯类别</font></a>
	</td>	 
	</tr></table>
	<script>
function findSub(para){
   document.form1.action=para+"?Loft=<%=getbyte2(request.getParameter("Loft"))%>&SecNo=<%=getbyte2(request.getParameter("SecNo"))%>";
   document.form1.submit();
}
</script>
<%@ include file="../public_js/qx_checke.jsp"%>

 <%
//权限审核
String Cortrol=checke_qx(ViewBean1,(String)session.getAttribute("loginid"),"S004");
out.print("<p align=center class=FontColor><font size=3><b>资讯类别一览表</b></font></p>");
 %>
 <input type=hidden name="cusche">
 <input type=hidden name="Find">
<input type=hidden name="Findsection">

   <table width=100% border="0"><tr height="16" bgcolor="#EAEAEA"><td align="left"> 
	 
	  
	 <%
	if (Cortrol==null)Cortrol="";
	%>
   <%if (Cortrol.indexOf("A")>=0){ %><input type=button name=add value="增 加"   onclick="addCus();"><%} 
    if (Cortrol.indexOf("D")>=0){ %><input type=button name=del value="删 除"   onclick="Dele();"><%} if (Cortrol.indexOf("F")>=0){ %><%String reportAddrs=(String)session.getAttribute("reportAddr"); %> 
   </td>  </tr></table>
   <%} %>
 
<table width=100%><tr height="3"><td></td></tr></table>
<center>

<table BORDER=0 width="100%"  CELLSPACING=1 CELLPADDING=1 ALIGN=center >
  <tr  class=listtitle>
  <td  align="center" width="10%"><font color=white>序号</font></td>
  <td  align="center" width="10%"><font color=white>类别名称</font></td>
  <td  "  align="center" width="60%"><font color=white>可查阅用户</font></td>
   <td  "  align="center" width="8%"><font color=white>分配</font></td>
 </tr>
 <%	

	//保存输入值的变量
    String type="";
    String user_id="";
   
	int no=0;
	int i=0;
	rs=ViewBean.executeQuery(sql);	
 try{
   while (rs.next()){
     i++;
	 no=rs.getInt("id");
     type=getbyte(rs.getString("type"));
	 user_id=getbyte(rs.getString("user_id"));
	 
    %>

   <tr id=TR<%=i %>   align="center" class=listcontent  onmouseover="mout(this);"  onclick="savepara('<%=no%>');changeclass1(this,'clickbg','listcontent');" ondblclick="Edit();" > 
	<td  align="center"><%=i %>　</td>
    <td  align="left"><%=type %>　&nbsp;</td>
    <td  align="left" ><%=user_id %>&nbsp;</td>
    <td  align="left"  ><input type=button name=set value="分配" onclick="openwin('user_list1.jsp?id=<%=no %>',300,400);">&nbsp;</td>
	 
   </tr>

<%

}
}catch(Exception s){out.println(s.getMessage());}

rs.close();
 %> 
</table>
</form>
</center>

<script>
 
   var cusno="";
  	function Dele(){
	 if (confirm("真的要删除吗？")){
   	      if (logid==""){alert("请选择)");}
		   else{window.location="knowledge_type_view.jsp?id="+logid;}
	  }
	}
	
	 var logid="";
    function savepara(para){
			  logid=para;
			
			  }
  
  function addCus(){
    openwin("knowlege_type.jsp?state=1&sel=1",500,300,100,5)
   }
   function ordersubmit(){
	 document.form1.submit();	 
	}
   function changesub(para){
		document.form1.Findsection.value=para;
		document.form1.Find.value="o";
 		document.form1.submit();
	}
  function FindCusState(){
	document.form1.Find.value="o";
    document.form1.Findsection.value=document.form1.section.value;
   document.form1.submit();
  
  }
  </script>

</body>
</html>
