<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="../public_js/checktime.jsp"%>
<%@ include file="../public_js/logrecord.jsp" %>

<HTML>
<HEAD>
<TITLE>�����������</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK"> 
</HEAD>
  <%@ page import="java.sql.*" %>
  <jsp:useBean id="aBean" scope="page" class="ConnDatabase.SDatabase" />
 <%@ include file="../public_js/getByteOut.jsp"%>
<%  
	

String SID=getbyte1(request.getParameter("id"));

    if (!(SID.equals(""))){
 
   String sql="select count(*) num from code where type in (select TYPE from code where id in ("+SID+"))";
 
   ResultSet rs=aBean.executeQuery(sql);
if (rs.next()){
  if (rs.getInt("num")<=1){
   out.print("<script>");
   out.print("alert('����ɾ������˴�����豣��һ������ֵ�����ɾ���������Ӻ���ɾ�����õĴ���');");
      out.print("window.location='codelist.jsp';");
   out.print("</script>");

   out.close();
  
  }else{
    try{
      aBean.executeUpdate("delete code where id in("+SID+")");
	}catch(Exception s){ out.println("delete code where id in("+SID+")");
	  out.close();}
  }
 
}

   %>
   <%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "��������" , 
                  "ɾ��"
                ) ;
%>
   <script>
     alert("ϵͳ��ɾ����Ĵ���");
     window.location="codelist.jsp";
      </script>
   <%
   
   return;
}
String Scodetype = getbyte1(request.getParameter("codetype1"));
String Scodetypename = getbyte1(request.getParameter("codetypename"));
String Scodeno = getbyte1(request.getParameter("codeno"));
String Scodename = getbyte1(request.getParameter("codename"));
String bak=getbyte1(request.getParameter("bak"));
String StrSql=""; 
String StrSql1=""; 
 
StrSql = "insert into code(TYPE,TYPENAME,CODENAME,bak)";
StrSql += " values('";
StrSql += Scodetype + "','" + Scodetypename+"','" + Scodename + "','"+bak+"')";
try {
aBean.executeUpdate(StrSql);
      %>
	  <%
setlog( setlogBean , 
                  ( String )session.getAttribute( "loginid" ) ,
                  "��������" , 
                  "����"
                ) ;
%>
     <script>
     if (confirm("ϵͳ�������Ĵ���,�Ƿ������"))
    ������window.history.back(1);
	else{
	 opener.window.location="codelist.jsp";
	 window.close();
	 }
   </script>
<%
}catch(Exception ee) {
out.print("�û����ʧ��,ԭ��:"+StrSql);
              out.print(ee.getMessage());   
} 

%>
 
<BODY BGCOLOR="#FFFFFF" TEXT="#000000">
</BODY>
</HTML>
