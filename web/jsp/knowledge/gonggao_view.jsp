<%@ page contentType="text/html;charset=GBK" %>


<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
<title>�����б�</title>
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
String FindCondition="";//���ݲ�������
String orderby=China.getParameter(request,"orderby");
 
String id=request.getParameter("id");
String deleteid=request.getParameter("deleteid");
String strstate=request.getParameter("state");
if (id!=null) {ViewBean.executeUpdate("update  gonggao set state="+strstate+"  where id="+id);}//delete data
if (deleteid!=null) {ViewBean.executeUpdate("delete  gonggao    where id="+deleteid);}//delete data

 //����ʽ
	if ( !orderby.equals("")||orderby.equals("0"))
	 orderby=" order by date desc";
	else if (orderby.equals("1")) orderby=" order by  date asc";
	String PubPra=(String)session.getAttribute("Attribute");	
    String user=(String)session.getAttribute("loginname");	

 
ResultSet rs=null;


out.print("<p align=center class=FontColor><font size=3><b>����һ����</b></font></p>");
%>
<script>
function full(){
   setSelectMad(document.form1.orderby,'<%=China.getParameter(request,"orderby") %>');
}

</script>

<body onload="full()">

<form name=form1 method="post">

<%@ include file="../public_js/qx_checke.jsp"%>

 <%
//Ȩ�����
  ResultSet codeRS=null;
String Cortrol=checke_qx(ViewBean1,(String)session.getAttribute("loginid"),"oa07");

 %>
 <input type=hidden name="cusche">
 <input type=hidden name="Find">
<input type=hidden name="Findsection">
   <table width=100% border="0"><tr height="16" bgcolor="#EAEAEA"><td align="left"> 
	   
	 ����������:     
	 <select name="orderby" onchange="ordersubmit();">
     
	 <option value=1>����</option>
<option value=0>����</option>
	 </select>
	  
	 <%
	if (Cortrol==null)Cortrol="";
	%>
   <%if (Cortrol.indexOf("A")>=0){ %><input type=button name=add value="�� ��"    onclick="addCus();"><%}%>
     </td>  </tr></table>
   
 
<table width=100%><tr height="3"><td></td></tr></table>
<center>

<table BORDER=0 width="100%"  CELLSPACING=1 CELLPADDING=1 ALIGN=center >
  <tr  class=listtitle>
  <td  align="center" width="10%"><font color=white>���</font></td>
 
  <td  align="center" width="10%"><font color=white>�Ǽ�����</font></td>
    <td  align="center" width="10%"><font color=white>ʧЧ����</font></td>
  
  <td  "  align="center" width="30%"><font color=white>��  ��</font></td>
 
   <td  "  align="center" width="20%"><font color=white>����</font></td>
    <td  "  align="center" width="15%"><font color=white>����</font></td>
 </tr>
 <%	

	//��������ֵ�ı���
    String  date="";
	String  date1="";
    String text="";
     String handler="";
	 String title="";
	 String adjunct="";
	 String see_num="";
	int no=0;
	int i=0;
	String type="",tdate="";
	String sql="select Top "+pageSize+" * from gonggao where    id not in (Select top "+prenum +" id from gonggao )  "+orderby;
     
   
sqlcount="SELECT count(id) from gonggao ";

	codeRS=ViewBean.executeQuery(sql);
	 
 try{
   while (codeRS.next()){
     i++;
	
	 no=codeRS.getInt("id");
	 type=getbyte(codeRS.getString("type"));
	 title=codeRS.getString("subject");
     text=getbyte(codeRS.getString("body"));
	 adjunct=getbyte(codeRS.getString("filename"));
	 date=getbyte(codeRS.getDate("date").toString());
	 tdate=getbyte(codeRS.getDate("tdate").toString());
	 boolean state=codeRS.getBoolean("state");
   %>

   <tr id=TR<%=i %>   align="center" class=listcontent  onmouseover="mout(this);"  onclick="savepara('<%=no%>');changeclass1(this,'clickbg','listcontent');" ondblclick="Edit();" > 
	<td  align="center"><%=i %>��&nbsp;</td>
	 
    <td  ><%=date %></td>
    <td  ><%=tdate %></td>
    <td  align="center" title="<%=text %>"><%=title.trim() %>&nbsp;</td>
   
	 <td  align="center"  ><%if (!adjunct.equals("")){%>
	 <%StringTokenizer st22 = new StringTokenizer(adjunct,"&") ;
	  while (st22.hasMoreElements()) {
	  adjunct=(String)st22.nextElement();
	  %>
	 
	 
	  <a href="#" onclick="openwin('../../imail/downFile.jsp?fileurel=/jsp/knowledge/<%=adjunct %>',10,10,10,10);"><img src="../images/i_sign.gif" border=0></a>
	 
	 <%}} %>&nbsp;</td>
	 <td  >
    <%if (!state){ %>
	    <a href="gonggao_view.jsp?state=1&id=<%=no %>">��ֹ</a> 
    <%}else{ %>
	<a href="gonggao_view.jsp?state=0&id=<%=no %>">����</a> 
	 <%} %>
	 <% if (Cortrol.indexOf("E")>=0){  %>&nbsp;<a href="#"  onclick="savepara('<%=no%>');Edit();">�޸�</a> &nbsp;<%} if (Cortrol.indexOf("D")>=0){  %><a href="#"  onclick="savepara('<%=no%>');Dele();">ɾ��</a><%} %>
    </td>
   </tr>

<%

}
}catch(Exception s){out.println(s.getMessage()+sql);}

codeRS.close();
 %> 
   <%@ include file="../public_js/changepage.jsp"%>
</table>
</form>
</center>

<script>
 
   var cusno="";
    function Edit(){
    	
   	         if (logid==""){alert("��ѡ���޸ĵ���־");}
		     else{ openwin("modi_gonggao.jsp?id="+logid,650,450,100,5);}
	
	}

	function Dele(){
	 if (confirm("���Ҫɾ����")){
   	      if (logid==""){alert("��ѡ��)");}
		   else{window.location="gonggao_view.jsp?deleteid="+logid;}
	  }
	}
	
	function view(){
	  if (cusno==""){alert("��ѡ��ͻ�(ֻ�赥���б���ĳ��һ��)");}
		   else{openwin("listcusdata.jsp?cusno="+cusno,500,520,100,5);}
	  }
    var logid="";
    function savepara(para){
			  logid=para;
			
			  }
  
  function addCus(){
    openwin("add_gonggao.jsp",650,500,100,5)
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
