<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>

<html>
<head>
	<title>��¼��־</title>
	<LINK href="../class/<%=session.getAttribute("FactColorC") %>" rel=stylesheet>
</head>
 <%@ page language="java" import="java.sql.*,java.util.*,common.*" %>
 
<jsp:useBean id="ViewBean" scope="page" class="ConnDatabase.SDatabase" />
<jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
<%@ include file="../public_js/getByteOut.jsp"%>
<body topmargin="0" oncontextmenu="return false" >
<%
 String date1=getbyte1(request.getParameter("time1"));
 String date2=getbyte1(request.getParameter("time2"));
String where="";
String where1="";
 if (!date1.equals("")&&!date1.equals(""))
 {
  where="where indatetime between '"+date1+"' and '"+date2+"'";
 where1=" and indatetime between '"+date1+"' and '"+date2+"'";
 }
 
 

 %>
<script language="javascript" src="../public_js/public.js">
</script>
<script Language="JavaScript" src="../public_js/calendar.script"></script>
<script Language="JavaScript" src="../public_js/Popup.js"></script>
<script>
function check(){
 if (confirm("ȷ��ɾ����?"))
 return true;
 else return false;
  
}
function deletelog(){
  check();
  chhoseData1();
  openwin("delete_inlog.jsp?logid="+logid,10,10,10,10);

}
function chhoseData(dd){
   for (var i=0;i<document.form1.choos.length;i++){
 	  document.form1.choos[i].checked=dd;
	 
    }

}

var logid="";
function chhoseData1(){
  logid="";
   for (var i=0;i<document.form1.choos.length;i++){
 	  if (document.form1.choos[i].checked){
	    var aa=document.form1.choos[i].value;
		  if (logid!="")
		   logid+=","+aa;
		  else
		   logid=aa;
	  }
   }
   }
</script>
<% String sel=(String)request.getParameter("sel");
   if(sel==null) sel="0";  %>
 <form name=form1  method="post" >
<input type=hidden name="sel" value="<%=sel %>">
   <table width="180" border="0" cellspacing="0" cellpadding="0" class="L2">
   <tr>  <td class="<%if(sel.equals("0")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	   <a href="#" onclick="document.form1.sel.value=0;findSub('log.jsp');"> <font color='<%if(sel.equals("0")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>������־</font> </a>
	</td>
	<td class="<%if(sel.equals("1")){out.print("menuselect3");}else{out.print("selemenu4");}%>" align="center" width=88 height=21>
	 <a href="#" onclick="document.form1.sel.value=1;findSub('inlog.jsp');"><font color='<%if(sel.equals("1")){out.print("#FFFFFF");}else{out.print("#000000");}%>'>��¼��־</font></a>
	</td>
	 
	</tr></table>
	<script>
function findSub(para){
   document.form1.action=para;
   document.form1.submit();
}
</script>
<p align="center"><font size=3>��¼��־</font></p>
     ʱ���: ��<input type=input name=time1 size=10 value="<%=date1 %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(time1);return false;">��<input type=input name=time2 size=10 readonly   value="<%=date2 %>"><input type=button name=cale value=".." onclick="fPopUpCalendarDlg(time2);return false;"><input type=submit name=ok value=" �� �� "> &nbsp;&nbsp; <input type=button name=dd value="ɾ����ǰ��־" onclick="deletelog();">
 <br><br>
 <%@ include file="../public_js/countpagenum.jsp"%>
 ϵͳÿ��ֻ��ʾ���100����־��¼
<table width="100%" border="0" CELLSPACING=0 CELLPADDING=0 bordercolor="#000000" class="tablefill"> 
<tr class=listtitle><td><input type=checkbox name=ch onclick="chhoseData(this.checked);">��¼�û�</td><td>��¼ʱ��</td><td>�˳�ʱ��</td><td>��¼IP</td></tr>
<%String sql="";
 sql="select Top "+pageSize+"  *    from WorkingJournalRecord where id not in (Select top "+prenum +" id from WorkingJournalRecord     "+where+" order by id desc)  "+ where1+" order by id desc";
sqlcount="SELECT count(id) code from WorkingJournalRecord "+where;

String control="";
ResultSet qx=null;

  qx = aBean.executeQuery ( sql );
while (qx.next()){
%>
 <tr>
 <td><input type=checkbox name=choos  value="<%=getbyte(qx.getString("id")) %>"><%=getbyte(qx.getString("username")) %></td>
 <td><%=qx.getString("indatetime") %></td>
 <td><%=getbyte(qx.getString("outdatetime")) %></td>
 <td><%=getbyte(qx.getString("ip")) %></td>
  
 </tr>

<%
   
}
qx.close();

 %>
</table>
  <%@ include file="../public_js/changepage.jsp"%>
</form>
</body>
</html>
