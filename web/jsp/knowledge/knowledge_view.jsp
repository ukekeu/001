<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>文件一览</title>
</head>
  <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 <jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
<%@ include file="../public_js/checktime.jsp"%>
<script language="javascript" src="../public_js/public.js">
</script>
<%@ include file="../public_js/getByteOut.jsp"%>
<%@ include file="../public_js/countpagenum.jsp"%>
<%
String FindCondition="";//传递参数变量
String orderby=China.getParameter(request,"orderby"); 
String id=request.getParameter("id");
if (id!=null) {ViewBean.executeUpdate("delete knowledge_data  where id="+id);}//delete data

 //排序方式
	if ( !orderby.equals("")||orderby.equals("0"))
	 orderby=" order by register_date desc";
	else if (orderby.equals("1")) orderby=" order by register_date asc";
	 String choosetype=China.getParameter(request,"stateValue");
	 if (!choosetype.equals("")) choosetype=" and type='"+choosetype+"'" ;
 	String PubPra=(String)session.getAttribute("Attribute");	
    String user=(String)session.getAttribute("loginname");	
    String sql="select Top "+pageSize+" *  from knowledge_data where  type in(select type from knowledge_type where user_id like '%"+(String )session.getAttribute( "loginid")+"%') "+choosetype+" and  id not in (Select top "+prenum +" id from knowledge_data where type in(select type from knowledge_type where user_id like '%"+(String )session.getAttribute( "loginid")+"%') "+choosetype+" ) "+orderby;
   sqlcount="SELECT count(id) from knowledge_data where type in(select type from knowledge_type where user_id like '%"+(String )session.getAttribute( "loginid")+"%')   "+choosetype;
ResultSet rs=null; 
out.print("<p align=center class=FontColor><font size=3><b>文档一览表</b></font></p>");
%>
<script>
function full(){
  setSelectMad(document.form1.stateValue,'<%=China.getParameter(request,"stateValue") %>');
 setSelectMad(document.form1.orderby,'<%=China.getParameter(request,"orderby") %>');
}

</script>
<body onload="full()">
<form name=form1 method="post">
<%@ include file="../public_js/qx_checke.jsp"%>
 <%
//权限审核
String Cortrol=checke_qx(ViewBean1,(String)session.getAttribute("loginid"),"oa05");
 %>
 <input type=hidden name="cusche">
 <input type=hidden name="Find">
<input type=hidden name="Findsection">
   <table width=100% border="0"><tr height="16" bgcolor="#EAEAEA"><td align="left"> 
	  <select name="stateValue"  onchange="FindCusState(this.value);">
  <option value="">选择类别</option>
	<%String StrSql="select type from knowledge_type where typestate=0 and user_id like '%"+(String )session.getAttribute( "loginid")+"%'";
 
	 ResultSet codeRS=ViewBean.executeQuery(StrSql);
     
     while (codeRS.next()){
	 String type=getbyte(codeRS.getString("type"));
       out.print("<option value='"+type+"'>"+type+"</option>");
	 
   }
   codeRS.close();
 %>
	 </select>
	 按日期排序:     
	 <select name="orderby" onchange="ordersubmit();">     
	 <option value=1>升序</option>
<option value=0>降序</option>
	 </select>	  
	 <%
	if (Cortrol==null)Cortrol="";
	%>
   <%if (Cortrol.indexOf("A")>=0){ %><input type=button name=add value="增 加"    onclick="addCus();"><%} if (Cortrol.indexOf("E")>=0){ %> <input type=button name=modi value="修 改"  onclick="Edit();">
   <%}  if (Cortrol.indexOf("D")>=0){ %><input type=button name=del value="删 除"   onclick="Dele();"><%} if (Cortrol.indexOf("F")>=0){ %><%String reportAddrs=(String)session.getAttribute("reportAddr"); %> 
   </td>  </tr></table>
   <%} %>
 
<table width=100%><tr height="3"><td></td></tr></table>
<center>

<table BORDER=0 width="100%"  CELLSPACING=1 CELLPADDING=1 ALIGN=center >
  <tr  class=listtitle>
  <td  align="center" width="10%"><font color=white>序号</font></td>
  <td  align="center" width="20%"><font color=white>登记日期</font></td>
   <td  align="center" width="10%"><font color=white>类别</font></td>
  <td    align="center" width="40%"><font color=white>主  题</font></td>
   <td     align="center" width="10%"><font color=white>访问次数</font></td>
   <td    align="center" width="10%"><font color=white>附件</font></td>
 </tr>
 <%	

	//保存输入值的变量
    String register_date="";
    String text="";
     String handler="";
	 String title="";
	 String adjunct="";
	 String see_num="";
	int no=0;
	int i=0;
	String type="";
 rs=ViewBean.executeQuery(sql);	
 try{
   while (rs.next()){
     i++;
	 no=rs.getInt("id");
	 type=getbyte(rs.getString("type"));
	 title=rs.getString("title");
     text=getbyte(rs.getString("text"));
	 adjunct=getbyte(rs.getString("adjunct"));
	 handler=getbyte(rs.getString("handler"));
	 register_date=rs.getDate("register_date").toString();
	 see_num=getbyte(rs.getString("see_num"));
	
	 
    %>

   <tr id=TR<%=i %>   align="center" class=listcontent  onmouseover="mout(this);"  onclick="savepara('<%=no%>');changeclass1(this,'clickbg','listcontent');" ondblclick="Edit();" > 
	<td  align="center"><%=i %>　&nbsp;</td>
    <td  align="left"><%=register_date %></td>
	   <td  align="center"><%=type %></td>
    <td  align="center" title="<%=text %>"><%=title.trim() %>&nbsp;</td>
    <td  align="center"  ><%=see_num %>&nbsp;</td>
	 <td  align="center"  ><%if (!adjunct.equals("")){%>
	    <a href="#" onclick="openwin('../../imail/downFile.jsp?fileurel=/jsp/knowledge/<%=adjunct %>',10,10,10,10);"><img src="../images/i_sign.gif" border=0></a>
		 <%} %>&nbsp;</td>
   </tr>

<%

}
}catch(Exception s){out.println(s.getMessage());}

rs.close();
 %> 
   <%@ include file="../public_js/changepage.jsp"%>
</table>
</form>
</center>

<script>
 
   var cusno="";
    function Edit(){
    	
   	         if (logid==""){alert("请选择修改的日志");}
		     else{ openwin("ShowKnowledge1.jsp?id="+logid,650,450,100,5);}
	
	}

	function Dele(){
	 if (confirm("真的要删除吗？")){
   	      if (logid==""){alert("请选择)");}
		   else{window.location="knowledge_view.jsp?id="+logid;}
	  }
	}
	
	function view(){
	  if (cusno==""){alert("请选择客户(只需单击列表中某行一次)");}
		   else{openwin("listcusdata.jsp?cusno="+cusno,500,520,100,5);}
	  }
    var logid="";
    function savepara(para){
			  logid=para;
			
			  }
  
  function addCus(){
    openwin("addknowledge.jsp",650,500,100,5)
   }
   function ordersubmit(){
	 document.form1.submit();	 
	}
   function changesub(para){
		document.form1.Findsection.value=para;
		document.form1.Find.value="o";
 		document.form1.submit();
	}
  function FindCusState(aa){
	document.form1.Find.value="o";
    document.form1.Findsection.value=aa;
   document.form1.submit();
  
  }
  </script>

</body>
</html>
