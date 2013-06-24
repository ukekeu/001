<%response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0);  %>
<%@ page contentType="text/html;charset=GBK" %>
 <%@ page language="java" import="java.sql.*" %>
 <jsp:useBean id="ViewBean1" scope="page" class="ConnDatabase.SDatabase"/>
 <jsp:useBean id="ViewBean2" scope="page" class="ConnDatabase.SDatabase"/>
   
  <%
  String acc_person=(String)session.getAttribute("loginname");
   String sql="SELECT * FROM  online_alter WHERE acc_person='"+acc_person+"' and state=0"; 
   ResultSet rs = null;  
  String useridl=(String) session.getAttribute("loginid");
   if (useridl==null||useridl.equals("")){
  %>    
<SCRIPT> 
    alert("出于安全原因，系统将你退出系统！")
	 window.parent.location='../outSys.jsp'
   </SCRIPT>
  <%
 }else{     
	  rs=ViewBean1.executeQuery(sql);
	  while (rs.next()){	
%>
<script>
function openwin1(url,wh,hg,lf,tp) {
  var newwin=window.open(url,"alertinfo<%=rs.getString("code") %>","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width="+wh+",height="+hg+",left="+lf+",top="+tp);
  newwin.focus();
  return false;
}
openwin1("../top/ShowOnlineAlert.jsp?send_person=<%=rs.getString("send_person") %>&send_date=<%=rs.getString("send_date")  %>&info=<%=rs.getString("info")  %>",500,200,100,100);
</script>

<%
ViewBean2.executeUpdate("update online_alter set state=1 where code="+rs.getString("code") );
}rs.close();
 sql="Select     a.subject,a.id,a.shmail,a.date,a.fuserid ,a.annex,a.filename,b.leave from imail_message as a,oa_mail_state as b where b.state<>0 and b.leave=0  and b.name='"+(String)session.getAttribute("loginid")+"' and a.id=b.main_id order by b.leave,a.date desc";
  rs=ViewBean2.executeQuery(sql);
 
  while (rs.next()){
  %>
<script>
 
window.open('../../imail/rev.jsp?id=<%=rs.getInt("id")%>','','menubar=no,scrollbars=yes,resizable=yes,width=690,height=542,left=200,top=100');
</script>

<% 
  }
  rs.close();
 } %>
